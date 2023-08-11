//
//  StorageController.swift
//  Banking
//
//  Created by Matteo Manferdini on 31/01/2017.
//  Copyright © 2017 Pure Creek. All rights reserved.
//

import Foundation

class StorageController {
	private let documentsDirectoryURL = FileManager.default
		.urls(for: .documentDirectory, in: .userDomainMask)
		.first!
	
	private var projectsFileURL: URL {
		return documentsDirectoryURL
			.appendingPathComponent("Projects")
			.appendingPathExtension("json")
	}
	
	func save(_ projects: [Project]) {
		let encoder = JSONEncoder()
		guard let data = try? encoder.encode(projects) else { return }
		try? data.write(to: projectsFileURL)
	}
	
	func fetchProject() -> [Project] {
		guard let data = try? Data(contentsOf: projectsFileURL) else { return [] }
		let decoder = JSONDecoder()
		let projects = try? decoder.decode([Project].self, from: data)
		return projects ?? []
	}
}
