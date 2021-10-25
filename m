Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA04043A47A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 22:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbhJYU0A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 16:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbhJYUZj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 16:25:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF73C04A41F
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:10:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k22-20020a25b296000000b005c14f7662b6so11953367ybj.2
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=PgMb11rYRqtDORRAJvUgAM6VEyAICR6ozOy7CkCp1d8=;
        b=cfydvUIBwsMpyTEUsBxiqkD7qJIrnXKN6gU7AxG27BYqI3ZJofd5NxQFjGgY5xrGFy
         fcoCa26C+izcDXPsPleAE2l1hagJm28QTAu0XQcEESHs2CC+YDvA0V7v7PDuIe5HwURV
         RmJLzEljWR390h0OKCfzR+weKjWXcavpR6yxo34J+7+c0ygTXWUVVC0vhqjj9cnT/HKU
         LsKs1kGBsE2eTvb/5925j6Jh0KnbchLtXVMiBdQg/D+mxz+21YGUJdgRgzufzVNz3Xk/
         +JwiKhor7J+fyBux/QWHXzOVAThMgJq7TVtplP58qOFGma+ZibcBir4YEbeAVB33m4RY
         wIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=PgMb11rYRqtDORRAJvUgAM6VEyAICR6ozOy7CkCp1d8=;
        b=GdHVZuAG3UfCcgZzc0XRUX/vspo/g0u7b/1e33QBX1uS6FTjRBpWvM8siQ+qSNecYY
         Px9kpOn3HI/cus9WQHY27dA3u9tIxtfuMxQRy627pF1v6CRb1VJd8ScxfyTtTP19j/MT
         wKsgp80Ic6ZMFnoUE+wHRApY/EUHTK0PDXKyH3Mxkj+EVjvC0MDNu0CX++kSwxIJkQuw
         mtN14kfFwV4OUUpaJONeSTbhwMAaWcYwU5BIfQciNa5p4p7jUIblPtfws2daLxWXd0QC
         mFA9oDnmwm0PrzxOClArZ1/YN3J9rqQCEzX7jKeKU2DEoDfd64EXmCVLtn0v5LxonCQA
         SsAg==
X-Gm-Message-State: AOAM533av3c0OuqWYLkJQawupRYiKWD4lBhuJq9+a4S/vyDm+Knv4tlx
        dZFhgUA2+3m8vgGJ6yXmFWkGZAl1UNdLaTy5MQ==
X-Google-Smtp-Source: ABdhPJxheJji8hzdIygV2zHaLxRA6k79qhZpe1oSCFcqhVGHfxUqNGcUFaPjJ4TpK+af3/bXNJ1x8ZRHFmP82zNXAQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b783:5702:523e:d435])
 (user=kaleshsingh job=sendgmr) by 2002:a25:ea0a:: with SMTP id
 p10mr16539542ybd.520.1635192642476; Mon, 25 Oct 2021 13:10:42 -0700 (PDT)
Date:   Mon, 25 Oct 2021 13:08:36 -0700
In-Reply-To: <20211025200852.3002369-1-kaleshsingh@google.com>
Message-Id: <20211025200852.3002369-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211025200852.3002369-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 4/8] tracing/histogram: Simplify handling of .sym-offset in expressions
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The '-' in .sym-offset can confuse the hist trigger arithmetic
expression parsing. Simplify the handling of this by replacing the
'sym-offset' with 'symXoffset'. This allows us to correctly evaluate
expressions where the user may have inadvertently added a .sym-offset
modifier to one of the operands in an expression, instead of bailing
out. In this case the .sym-offset has no effect on the evaluation of the
expression. The only valid use of the .sym-offset is as a hist key
modifier.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 43 +++++++++++++-------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e10c7d9611e5..34aba07d23f8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -68,8 +68,7 @@
 	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),	\
 	C(INVALID_STR_OPERAND,	"String type can not be an operand in expression"), \
 	C(EXPECT_NUMBER,	"Expecting numeric literal"),		\
-	C(UNARY_MINUS_SUBEXPR,	"Unary minus not supported in sub-expressions"), \
-	C(SYM_OFFSET_SUBEXPR,	".sym-offset not supported in sub-expressions"),
+	C(UNARY_MINUS_SUBEXPR,	"Unary minus not supported in sub-expressions"),
 
 #undef C
 #define C(a, b)		HIST_ERR_##a
@@ -1672,10 +1671,6 @@ static int contains_operator(char *str, char **sep)
 	 */
 	minus_op = strrchr(str, '-');
 	if (minus_op) {
-		/* Unfortunately, the modifier ".sym-offset" can confuse things. */
-		if (minus_op - str >= 4 && !strncmp(minus_op - 4, ".sym-offset", 11))
-			goto out;
-
 		/*
 		 * Unary minus is not supported in sub-expressions. If
 		 * present, it is always the next root operator.
@@ -2138,7 +2133,11 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			*flags |= HIST_FIELD_FL_HEX;
 		else if (strcmp(modifier, "sym") == 0)
 			*flags |= HIST_FIELD_FL_SYM;
-		else if (strcmp(modifier, "sym-offset") == 0)
+		/*
+		 * 'sym-offset' occurrences in the trigger string are modified
+		 * to 'symXoffset' to simplify arithmetic expression parsing.
+		 */
+		else if (strcmp(modifier, "symXoffset") == 0)
 			*flags |= HIST_FIELD_FL_SYM_OFFSET;
 		else if ((strcmp(modifier, "execname") == 0) &&
 			 (strcmp(field_name, "common_pid") == 0))
@@ -2463,24 +2462,6 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		return ERR_PTR(-EINVAL);
 	}
 
-	/*
-	 * ".sym-offset" in expressions has no effect on their evaluation,
-	 * but can confuse operator parsing.
-	 */
-	if (*n_subexprs == 0) {
-		sep = strstr(str, ".sym-offset");
-		if (sep) {
-			*sep = '\0';
-			if (strpbrk(str, "+-/*") || strpbrk(sep + 11, "+-/*")) {
-				*sep = '.';
-				hist_err(file->tr, HIST_ERR_SYM_OFFSET_SUBEXPR,
-					 errpos(sep));
-				return ERR_PTR(-EINVAL);
-			}
-			*sep = '.';
-		}
-	}
-
 	field_op = contains_operator(str, &sep);
 
 	if (field_op == FIELD_OP_NONE)
@@ -6004,7 +5985,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	struct synth_event *se;
 	const char *se_name;
 	bool remove = false;
-	char *trigger, *p;
+	char *trigger, *p, *start;
 	int ret = 0;
 
 	lockdep_assert_held(&event_mutex);
@@ -6052,6 +6033,16 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		trigger = strstrip(trigger);
 	}
 
+	/*
+	 * To simplify arithmetic expression parsing, replace occurrences of
+	 * '.sym-offset' modifier with '.symXoffset'
+	 */
+	start = strstr(trigger, ".sym-offset");
+	while (start) {
+		*(start + 4) = 'X';
+		start = strstr(start + 11, ".sym-offset");
+	};
+
 	attrs = parse_hist_trigger_attrs(file->tr, trigger);
 	if (IS_ERR(attrs))
 		return PTR_ERR(attrs);
-- 
2.33.0.1079.g6e70778dc9-goog

