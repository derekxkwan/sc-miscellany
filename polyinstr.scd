//courtesy of a post by james harkins (hjh/ddw) on the sc-users list, an event type capable of handling multiple instruments

Event.addEventType(\polyInstr, { |server|
    ~instrument.do { |instr|
        // the main event being played now is accessible through currentEnvironment
        currentEnvironment.copy
        .put(\instrument, instr)
        .put(\type, ~subtype ?? { \note })
        .play;
    };
});
