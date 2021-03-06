 //
//  FLGResponse.m
//  ComicSearch
//
//  Created by Javi Alzueta on 16/5/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

#import "FLGResponse.h"

@interface FLGResponse ()

// Redefinimos la property "results" como read-write de forma privada.
// De puertas para fuera será "readonly" por la declaracion del .h
@property (strong, nonatomic) id results;

@end

@implementation FLGResponse

+ (instancetype) responseWithJSONDictionary: (NSDictionary *) JSONDictionary
                                resultClass: (Class) resultClass{
    
    FLGResponse *response = [MTLJSONAdapter modelOfClass:self
                                      fromJSONDictionary:JSONDictionary
                                                   error:NULL];
    
    id results = JSONDictionary[@"results"];
    
    // Comprobamos si le hemos pasado una "resultClass"
    if (resultClass != Nil) {
        if ([results isKindOfClass:[NSArray class]]) {
            // Nos llega un array en "results"
            response.results = [MTLJSONAdapter modelsOfClass:resultClass
                                               fromJSONArray:results
                                                       error:NULL];
        }else {
            // Nos llega un diccinario en "results"
            response.results = [MTLJSONAdapter modelOfClass:resultClass
                                         fromJSONDictionary:results
                                                      error:NULL];
        }
    } else{
        // Queremos que se mantenga el JSON
        response.results = results;
    }
    return response;
}

// Metodo para la gestion de errores en la respuesta del servidor. Hace falta porque la API devuelve un "200" aunque hay algun error
- (NSError *) error{
    if (self.statusCode.integerValue == 1) {
        return nil;
    } else{
        return [NSError errorWithDomain:@"ComicVineErrorDomain"
                                   code:self.statusCode.integerValue
                               userInfo:@{
                                          NSLocalizedDescriptionKey : self.errorMessage
                                          }];
    }
}

#pragma mark - MTLJSONSerializing

// Este metodo especifica como se mapea entre el JSON y el objeto de nuestro modelo
// Mirar la documentacion del metodo para ver como se mapea algo mas complicado (por ejemplo cuando hay aque crear algun objeto de Cocoa)
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"statusCode" : @"status_code",
             @"errorMessage" : @"error",
             @"numberOfTotalResults" : @"number_of_total_results",
             @"offset" : @"offset"
             };
}

@end
