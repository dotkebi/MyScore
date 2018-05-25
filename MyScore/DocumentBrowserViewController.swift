//
//  DocumentBrowserViewController.swift
//  MyScore
//
//  Created by dotkebi on 2018. 4. 26..
//  Copyright © 2018년 dotkebi. All rights reserved.
//

import UIKit
import PDFReader

class DocumentBrowserViewController: UIDocumentBrowserViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        allowsDocumentCreation = false
        allowsPickingMultipleItems = false

        // Update the style of the UIDocumentBrowserViewController
        // browserUserInterfaceStyle = .dark
        // view.tintColor = .white

        // Specify the allowed content types of your application via the Info.plist.

        // Do any additional setup after loading the view, typically from a nib.
    }

}

extension DocumentBrowserViewController: UIDocumentBrowserViewControllerDelegate {

    // MARK: UIDocumentBrowserViewControllerDelegate

    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        let newDocumentURL: URL? = nil

        // Set the URL for the new document here. Optionally, you can present a template chooser before calling the importHandler.
        // Make sure the importHandler is always called, even if the user cancels the creation request.
        if newDocumentURL != nil {
            importHandler(newDocumentURL, .move)
        } else {
            importHandler(nil, .none)
        }
    }

    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentURLs documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else {
            return
        }

        // Present the Document View Controller for the first document that was picked.
        // If you support picking multiple items, make sure you handle them all.
        presentDocument(at: sourceURL)
    }

    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }

    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
    }

}

extension DocumentBrowserViewController {

    // MARK: Document Presentation

    func presentDocument(at documentURL: URL) {

        guard documentURL.pathExtension == "pdf" else {
            alert(message: "PDF만 지원합니다")
            return
        }

        if documentURL.startAccessingSecurityScopedResource() {
            if let document = PDFDocument(url: documentURL) {
                let readerController = PDFViewController.createNew(with: document)
                present(readerController, animated: true)

            } else {
                alert(message: "wrong")
            }
            documentURL.stopAccessingSecurityScopedResource()

        }
    }

    func alert(message: String) {
        let alertController = UIAlertController(title: ALERT_TITLE, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인".lo, style: .default))
        present(alertController, animated: true)
    }
}
