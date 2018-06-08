//
//  NetworkError.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/8/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case Unknown,NotConnectedToInternet,InternationalRoamingOff,NotReachedServer,ConnectionLost,IncorrectDataReturned
    
    internal init(error: Error) {
        if error._domain == NSURLErrorDomain {
            switch error._code {
            case NSURLErrorUnknown:
                self = .Unknown
            case NSURLErrorCancelled:
                self = .Unknown // Cancellation is not used in this project.
            case NSURLErrorBadURL:
                self = .IncorrectDataReturned // Because it is caused by a bad URL returned in a JSON response from the server.
            case NSURLErrorTimedOut:
                self = .NotReachedServer
            case NSURLErrorUnsupportedURL:
                self = .IncorrectDataReturned
            case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
                self = .NotReachedServer
            case NSURLErrorDataLengthExceedsMaximum:
                self = .IncorrectDataReturned
            case NSURLErrorNetworkConnectionLost:
                self = .ConnectionLost
            case NSURLErrorDNSLookupFailed:
                self = .NotReachedServer
            case NSURLErrorHTTPTooManyRedirects:
                self = .Unknown
            case NSURLErrorResourceUnavailable:
                self = .IncorrectDataReturned
            case NSURLErrorNotConnectedToInternet:
                self = .NotConnectedToInternet
            case NSURLErrorRedirectToNonExistentLocation, NSURLErrorBadServerResponse:
                self = .IncorrectDataReturned
            case NSURLErrorUserCancelledAuthentication, NSURLErrorUserAuthenticationRequired:
                self = .Unknown
            case NSURLErrorZeroByteResource, NSURLErrorCannotDecodeRawData, NSURLErrorCannotDecodeContentData:
                self = .IncorrectDataReturned
            case NSURLErrorCannotParseResponse:
                self = .IncorrectDataReturned
            case NSURLErrorInternationalRoamingOff:
                self = .InternationalRoamingOff
            case NSURLErrorCallIsActive, NSURLErrorDataNotAllowed, NSURLErrorRequestBodyStreamExhausted:
                self = .Unknown
            case NSURLErrorFileDoesNotExist, NSURLErrorFileIsDirectory:
                self = .IncorrectDataReturned
            case
            NSURLErrorNoPermissionsToReadFile,
            NSURLErrorSecureConnectionFailed,
            NSURLErrorServerCertificateHasBadDate,
            NSURLErrorServerCertificateUntrusted,
            NSURLErrorServerCertificateHasUnknownRoot,
            NSURLErrorServerCertificateNotYetValid,
            NSURLErrorClientCertificateRejected,
            NSURLErrorClientCertificateRequired,
            NSURLErrorCannotLoadFromNetwork,
            NSURLErrorCannotCreateFile,
            NSURLErrorCannotOpenFile,
            NSURLErrorCannotCloseFile,
            NSURLErrorCannotWriteToFile,
            NSURLErrorCannotRemoveFile,
            NSURLErrorCannotMoveFile,
            NSURLErrorDownloadDecodingFailedMidStream,
            NSURLErrorDownloadDecodingFailedToComplete:
                self = .Unknown
            default:
                self = .Unknown
            }
        }
        else {
            self = .Unknown
        }
    }
}


