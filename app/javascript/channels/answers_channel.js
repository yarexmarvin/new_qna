
import consumer from "./consumer";

consumer.subscriptions.create(
    { channel: "AnswersChannel", question_id: gon.question_id },
    {
        received(data) {
            if (data["current_user"] != gon["current_user"]) {
                $(".answers").append(data["partial"]);
            }
        },
    }
);
