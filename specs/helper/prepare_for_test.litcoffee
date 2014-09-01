    require 'must'
    module.exports = (preparable) ->
      simplifyEvent = (domainEventName, domainEventPayload) ->
        simplified = {}
        simplified[domainEventName] = domainEventPayload
        simplified

      emittedEvents = []

      preparable.$emitDomainEvent = (domainEventName, domainEventPayload) ->
        emittedEvents.push simplifyEvent domainEventName, domainEventPayload

      expectedEvents: (events...) ->
        emittedEvents.must.eql events
