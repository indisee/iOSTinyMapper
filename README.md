iOSTinyMapper
=============

Simple lightweight mapper class for ios. 

*Check out example project to figure out how that stuff works :)*

###Example/Explanation
For example we will parse <http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=10/json>

Will map 'feed' json object to instance of class FeedModel. Create FeedModel subclass of TinyMappingModel and declary few properties to map in:


	@interface FeedModel : TinyMappingModel
	@property (nonatomic, strong) TitleModel *title;
	@property (nonatomic, strong) NSArray *entry;
	@end
	
Each FeedModel will have array of 'entries' and 'title' property. In case we want to map json to custom classes, so we have to specify relation between class and json property name:

	#import "FeedModel.h"
	#import "TitleModel.h"
	#import "EntryModel.h"

	@implementation FeedModel

	- (NSDictionary *)keyToClassMappingRules {
    	return @{@"title":[TitleModel class],@"entry":[EntryModel class]};
	}

	@end
	
This code will tell mapper to map json property "title" to class TitleModel and 'entry' to EntryModel class. No matter what will store in json (simple object or json class/object) — the only thing to do for now is specify relation between  jsonKey and Objective-c class. Usin KVC and some magic, mapper will fill everything properly.

As you can guess, properties have to be declared with correct class, there some simple rules: 

* JSON class should be related to custom TinyMappingModel subclass (which one also have corresponding bindings) or to NSDictionary;
* JSON array should be mapped to NSArray
* strings mapped to NSString
* any kind of numbers to NSNumber


**Note:** If You do now want to map json classes in custom obj-c class (for example, You want to use regular NSDictionaries) — just skip previous step and leave -(void)keyToClassMappingRules empty or just do not implement it.
***

To show another cool feature, I will show how to setup EntryModel:

	@class TitleModel;
	@interface EntryModel : BaseModel
	@property (nonatomic, strong) NSDictionary *name;
	@property (nonatomic, strong) NSArray *images;
	@end

In this case we want 'im:name' json property map to 'name' property, but Objective-c do not allow us create property named 'im:name' (same for 'im:image'), so we have create rule for property to json parallel:

	#import "EntryModel.h"
	#import "ImageModel.h"
	
	@implementation EntryModel
	
	- (NSDictionary *)keyToClassMappingRules {
	    return @{@"im:image":[ImageModel class]};
	}
	
	- (NSDictionary *)keyToPropertyNameReplacementRules {
	    return @{@"im:name":@"name",@"im:image":@"images"};
	}
	
	@end
	
As in previous example we implement **-(void)keyToClassMappingRules;** method to say that 'im:image' will map to ImageModel class. At the same time in this situation we want 'name' json map to regular NSDictionary (we are too lazy for creation separate class) — so we skip this property declaration in **keyToClassMappingRules**, KVC will handle it for us.
Also we implement **-(void)keyToPropertyNameReplacementRules;** to set rules for json name -> propery name relation. 
	
	@{@"im:name":@"name",@"im:image":@"images"}
will tell mapper map json named 'im:name' to propery named 'name', and json 'im:image' map to 'images' propery.

That's all. Anythig else mapper will do by itself. In the simplest case, if all your json properties have valid names and there're only primitive structures (NSString, NSNumber etc, that KVC can handle) - the only thing You have to do - create subclass of TinyMappingModel and declare needed properties.

### Mapping itself

When you get your json, You have to pass dictionary representation of it to method **+(void)mapObjectFromDictionary:(NSDictionary *)dictionary** of root mapping class:

	//get data from netwrork
	AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
	[client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [client getPath:kGetAppsPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    	//start parsing
        self.model = [FeedModel mapObjectFromDictionary:[responseObject valueForKey:@"feed"]];
        //do whatever you want — see example
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

we are interested in:

	self.model = [FeedModel mapObjectFromDictionary:[responseObject valueForKey:@"feed"]];
	
After that simple step You will have fully initiated and filled FeedModel instance.
*****
There are two method You can use for mapping:

	+ (instancetype)mapObjectFromDictionary:(NSDictionary *)data;
	+ (NSArray *)mapArrayOfObjects:(NSArray *)data;
 
 **+ (instancetype)mapObjectFromDictionary:(NSDictionary *)data** — maps dictionary to instance of class You send message, as in previous example.
 
 **+ (NSArray *)mapArrayOfObjects:(NSArray \*)data;** — maps json array to array of instances of class you send this message.
 
 Hope this will help someone
