class UsineError < StandardError
end

class UsineError::DefinitionNotFound < UsineError
end

class UsineError::SequenceNotFound < UsineError
end

class UsineError::SequenceInvalidInitialValue < UsineError
end
