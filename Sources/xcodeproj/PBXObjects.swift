import Foundation

public class PBXObjects: Equatable {

    // MARK: - Properties

    public var buildFiles: ReferenceableCollection<PBXBuildFile> = [:]
    public var legacyTargets: ReferenceableCollection<PBXLegacyTarget> = [:]
    public var aggregateTargets: ReferenceableCollection<PBXAggregateTarget> = [:]
    public var containerItemProxies: ReferenceableCollection<PBXContainerItemProxy> = [:]
    public var groups: ReferenceableCollection<PBXGroup> = [:]
    public var configurationLists: ReferenceableCollection<XCConfigurationList> = [:]
    public var versionGroups: ReferenceableCollection<XCVersionGroup> = [:]
    public var buildConfigurations: ReferenceableCollection<XCBuildConfiguration> = [:]
    public var variantGroups: ReferenceableCollection<PBXVariantGroup> = [:]
    public var targetDependencies: ReferenceableCollection<PBXTargetDependency> = [:]
    public var nativeTargets: ReferenceableCollection<PBXNativeTarget> = [:]
    public var fileReferences: ReferenceableCollection<PBXFileReference> = [:]
    public var projects: ReferenceableCollection<PBXProject> = [:]
    public var referenceProxies: ReferenceableCollection<PBXReferenceProxy> = [:]
    public var buildRules: ReferenceableCollection<PBXBuildRule> = [:]

    // Build Phases
    public var copyFilesBuildPhases: ReferenceableCollection<PBXCopyFilesBuildPhase> = [:]
    public var shellScriptBuildPhases: ReferenceableCollection<PBXShellScriptBuildPhase> = [:]
    public var resourcesBuildPhases: ReferenceableCollection<PBXResourcesBuildPhase> = [:]
    public var frameworksBuildPhases: ReferenceableCollection<PBXFrameworksBuildPhase> = [:]
    public var headersBuildPhases: ReferenceableCollection<PBXHeadersBuildPhase> = [:]
    public var sourcesBuildPhases: ReferenceableCollection<PBXSourcesBuildPhase> = [:]
    public var carbonResourcesBuildPhases: ReferenceableCollection<PBXRezBuildPhase> = [:]

    // MARK: - Computed Properties

    public var buildPhases: ReferenceableCollection<PBXBuildPhase> {
        var phases: [PBXObjectReference: PBXBuildPhase] = [:]
        phases.merge(copyFilesBuildPhases as ReferenceableCollection<PBXBuildPhase>, uniquingKeysWith: { first, _ in return first })
        phases.merge(sourcesBuildPhases as ReferenceableCollection<PBXBuildPhase>, uniquingKeysWith: { first, _ in return first })
        phases.merge(shellScriptBuildPhases as ReferenceableCollection<PBXBuildPhase>, uniquingKeysWith: { first, _ in return first })
        phases.merge(resourcesBuildPhases as ReferenceableCollection<PBXBuildPhase>, uniquingKeysWith: { first, _ in return first })
        phases.merge(headersBuildPhases as ReferenceableCollection<PBXBuildPhase>, uniquingKeysWith: { first, _ in return first })
        phases.merge(carbonResourcesBuildPhases as ReferenceableCollection<PBXBuildPhase>, uniquingKeysWith: { first, _ in return first })
        phases.merge(frameworksBuildPhases as ReferenceableCollection<PBXBuildPhase>, uniquingKeysWith: { first, _ in return first })
        return phases
    }

    /// Initializes the project objects container
    ///
    /// - Parameters:
    ///   - objects: project objects
    public init(objects: [String: PBXObject]) {
        objects.forEach { _ = self.addObject($0.value, reference: $0.key) }
    }

    // MARK: - Equatable

    public static func == (lhs: PBXObjects, rhs: PBXObjects) -> Bool {
        return lhs.buildFiles == rhs.buildFiles &&
            lhs.legacyTargets == rhs.legacyTargets &&
            lhs.aggregateTargets == rhs.aggregateTargets &&
            lhs.containerItemProxies == rhs.containerItemProxies &&
            lhs.copyFilesBuildPhases == rhs.copyFilesBuildPhases &&
            lhs.groups == rhs.groups &&
            lhs.configurationLists == rhs.configurationLists &&
            lhs.buildConfigurations == rhs.buildConfigurations &&
            lhs.variantGroups == rhs.variantGroups &&
            lhs.targetDependencies == rhs.targetDependencies &&
            lhs.sourcesBuildPhases == rhs.sourcesBuildPhases &&
            lhs.shellScriptBuildPhases == rhs.shellScriptBuildPhases &&
            lhs.resourcesBuildPhases == rhs.resourcesBuildPhases &&
            lhs.frameworksBuildPhases == rhs.frameworksBuildPhases &&
            lhs.headersBuildPhases == rhs.headersBuildPhases &&
            lhs.nativeTargets == rhs.nativeTargets &&
            lhs.fileReferences == rhs.fileReferences &&
            lhs.projects == rhs.projects &&
            lhs.versionGroups == rhs.versionGroups &&
            lhs.referenceProxies == rhs.referenceProxies &&
            lhs.carbonResourcesBuildPhases == rhs.carbonResourcesBuildPhases &&
            lhs.buildRules == rhs.buildRules
    }

    // MARK: - Public Methods

    /// Add a new object.
    ///
    /// - Parameters:
    ///   - object: object.
    ///   - reference: object reference.
    @discardableResult
    public func addObject(_ object: PBXObject, reference: String) -> PBXObjectReference {
        object.objects = self
        switch object {
        // subclasses of PBXGroup; must be tested before PBXGroup
        case let object as PBXVariantGroup: return variantGroups.append(object, reference: reference)
        case let object as XCVersionGroup: return versionGroups.append(object, reference: reference)

        // everything else
        case let object as PBXBuildFile: return buildFiles.append(object, reference: reference)
        case let object as PBXAggregateTarget: return aggregateTargets.append(object, reference: reference)
        case let object as PBXLegacyTarget: return legacyTargets.append(object, reference: reference)
        case let object as PBXContainerItemProxy: return containerItemProxies.append(object, reference: reference)
        case let object as PBXCopyFilesBuildPhase: return copyFilesBuildPhases.append(object, reference: reference)
        case let object as PBXGroup: return groups.append(object, reference: reference)
        case let object as XCConfigurationList: return configurationLists.append(object, reference: reference)
        case let object as XCBuildConfiguration: return buildConfigurations.append(object, reference: reference)
        case let object as PBXTargetDependency: return targetDependencies.append(object, reference: reference)
        case let object as PBXSourcesBuildPhase: return sourcesBuildPhases.append(object, reference: reference)
        case let object as PBXShellScriptBuildPhase: return shellScriptBuildPhases.append(object, reference: reference)
        case let object as PBXResourcesBuildPhase: return resourcesBuildPhases.append(object, reference: reference)
        case let object as PBXFrameworksBuildPhase: return frameworksBuildPhases.append(object, reference: reference)
        case let object as PBXHeadersBuildPhase: return headersBuildPhases.append(object, reference: reference)
        case let object as PBXNativeTarget: return nativeTargets.append(object, reference: reference)
        case let object as PBXFileReference: return fileReferences.append(object, reference: reference)
        case let object as PBXProject: return projects.append(object, reference: reference)
        case let object as PBXReferenceProxy: return referenceProxies.append(object, reference: reference)
        case let object as PBXRezBuildPhase: return carbonResourcesBuildPhases.append(object, reference: reference)
        case let object as PBXBuildRule: return buildRules.append(object, reference: reference)
        default: fatalError("Unhandled PBXObject type for \(object), this is likely a bug / todo")
        }
    }

    /// It returns the object with the given reference.
    ///
    /// - Parameter reference: file reference.
    /// - Returns: object.
    // swiftlint:disable function_body_length
    public func getReference(_ reference: String) -> PBXObject? {
        // This if-let expression is used because the equivalent chain of `??` separated lookups causes,
        // with Swift 4, this compiler error:
        //     Expression was too complex to be solved in reasonable time;
        //     consider breaking up the expression into distinct sub-expressions
        if let object = buildFiles.getReference(reference) {
            return object
        } else if let object = aggregateTargets.getReference(reference) {
            return object
        } else if let object = legacyTargets.getReference(reference) {
            return object
        } else if let object = containerItemProxies.getReference(reference) {
            return object
        } else if let object = groups.getReference(reference) {
            return object
        } else if let object = configurationLists.getReference(reference) {
            return object
        } else if let object = buildConfigurations.getReference(reference) {
            return object
        } else if let object = variantGroups.getReference(reference) {
            return object
        } else if let object = targetDependencies.getReference(reference) {
            return object
        } else if let object = nativeTargets.getReference(reference) {
            return object
        } else if let object = fileReferences.getReference(reference) {
            return object
        } else if let object = projects.getReference(reference) {
            return object
        } else if let object = versionGroups.getReference(reference) {
            return object
        } else if let object = referenceProxies.getReference(reference) {
            return object
        } else if let object = copyFilesBuildPhases.getReference(reference) {
            return object
        } else if let object = shellScriptBuildPhases.getReference(reference) {
            return object
        } else if let object = resourcesBuildPhases.getReference(reference) {
            return object
        } else if let object = frameworksBuildPhases.getReference(reference) {
            return object
        } else if let object = headersBuildPhases.getReference(reference) {
            return object
        } else if let object = sourcesBuildPhases.getReference(reference) {
            return object
        } else if let object = carbonResourcesBuildPhases.getReference(reference) {
            return object
        } else if let object = buildRules.getReference(reference) {
            return object
        } else {
            return nil
        }
    }

    /// Returns true if objects contains any object with the given reference.
    ///
    /// - Parameter reference: reference.
    /// - Returns: true if it contains the reference.
    public func contains(reference: String) -> Bool {
        return getReference(reference) != nil
    }
}
