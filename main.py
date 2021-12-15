import clips
import clips.agenda as agenda
env = clips.Environment()
env.reset()

if __name__ == "__main__":

    rules = open("rules.txt", "r")
    for rule in rules:
        env.build(rule)

    while True:
        agenda.Agenda.run(env)
        ass = str(input())
        ass = "(a " + ass + ")"
        env.assert_string(ass)
        agenda.Agenda.run(env)