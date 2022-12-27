import consumer from "./consumer";

consumer.subscriptions.create(
    { channel: "CommentsChannel", question_id: gon.question_id },
    {
        received(data) {
            console.log(data);

            if (data.comment.answer_id === null ) {
                $(`.question-comment[data-comment-question=${data.comment.question_id}]`).append(
                    data["partial"]
                );
            } else {
                $(`.answer-comment[data-comment-answer=${data.comment.answer_id}]`).append(data["partial"]);
            }
            $(".new-comment #comment_body").val("");
        },
    }
);