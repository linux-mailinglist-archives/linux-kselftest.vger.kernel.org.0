Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800EE43A36D
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 21:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbhJYT7X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 15:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbhJYT4Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 15:56:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1198AC110F25
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 12:24:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u17-20020a25ab11000000b005c1620952bfso9166319ybi.14
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=+/27iLcVwsoRtZBbebC5PI/8sCrYV9o5nqqwoDvFwLQ=;
        b=iJyBPNByASMp+w6u1OkWWEXPmlY+xuxhMQCry00NkR6CZi5U11wQfoXyJgPVnrdsN5
         l1jlpID4yAeJ6DA9F5o77Qmt4Csbolwyo+aERKpL88HbbqOxBzalYfHIK6EUn34ingcM
         9ulqgmaEh9+s8F/utYRhLzwDCF4f7Vhbd/MkFGip8zQUYpVh+9+IKxarCXs1aecowlls
         uDja4f+k3tDJ3CTj/p4GefB9//lhLSLWJr/t8VwkLvNLZbOkqBmJ7pmvCWpSIVKkpcN0
         lC9d5sRZYXXm/r8DN7C9JO8C5G7Q3ApBIa4JlH9p/h1E9mbny8IvZVVQ2FqzyJBZ3lyr
         YX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=+/27iLcVwsoRtZBbebC5PI/8sCrYV9o5nqqwoDvFwLQ=;
        b=5kGUyMW3dVYLuxHEjhna9EP9FAeHfnN7Q8vVnuGkGHnVYA3t/+H/mbM8RJ7OaMlEHV
         nbkdZWO8VVcNuBbfB6WSrc3Je4KeQZU+gMZY3HHMRN1XNtqZN1BIbACq6Ee13S2bdFPx
         IeEd10/60bGV/Jai29QZGz5LTLUCJNALqF5WiI8I/z4dQQgoi9Mop+zEy57h8w94icJc
         XZmg2vn9LCzAX/TiIZcUQ/JZkzZwNtfNuT1Hvv0yFI9xH91IzzL8nIyQUX6JWGX24fxp
         LGNs1g0yTIhiDViav8uXcxlIO6VuiU5A4CL09YT5qZWmgdOHAhJsvoxOZWe+A7fgAY+L
         y/Ow==
X-Gm-Message-State: AOAM533F991Ke3Bn/H5N3UD3K/fZjQ80XCcoC5Y+K6GHn1OQJXQdwhmF
        VU0bihs9qFcqofE3WFqvSDwf7uzAz90V+ckjTQ==
X-Google-Smtp-Source: ABdhPJzGkE0zCUemaF+iHnCTNiduZE54B6+Q+I95bSiWKG4W1OfAzxxaOmrl4UL79SWQbI9iCBMUB9r9pO5DM4x0nw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b783:5702:523e:d435])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:501:: with SMTP id
 x1mr19798810ybs.217.1635189848312; Mon, 25 Oct 2021 12:24:08 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:23:13 -0700
In-Reply-To: <20211025192330.2992076-1-kaleshsingh@google.com>
Message-Id: <20211025192330.2992076-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211025192330.2992076-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 2/8] tracing: Add division and multiplication support for
 hist triggers
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds basic support for division and multiplication operations for
hist trigger variable expressions.

For simplicity this patch only supports, division and multiplication
for a single operation expression (e.g. x=$a/$b), as currently
expressions are always evaluated right to left. This can lead to some
incorrect results:

	e.g. echo 'hist:keys=common_pid:x=8-4-2' >> event/trigger

	     8-4-2 should evaluate to 2 i.e. (8-4)-2
	     but currently x evaluate to  6 i.e. 8-(4-2)

Multiplication and division in sub-expressions will work correctly, once
correct operator precedence support is added (See next patch in this
series).

For the undefined case of division by 0, the histogram expression
evaluates to (u64)(-1). Since this cannot be detected when the
expression is created, it is the responsibility of the user to be
aware and account for this possibility.

Examples:
	echo 'hist:keys=common_pid:a=8,b=4,x=$a/$b' \
                   >> event/trigger

	echo 'hist:keys=common_pid:y=5*$b' \
                   >> event/trigger

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Use div64 helper in hist_field_div() to avoid faults on
    x86 32-bit machines, per Steven Rostedt

 kernel/trace/trace_events_hist.c | 72 +++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 28f711224944..522355a06f58 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -97,6 +97,8 @@ enum field_op_id {
 	FIELD_OP_PLUS,
 	FIELD_OP_MINUS,
 	FIELD_OP_UNARY_MINUS,
+	FIELD_OP_DIV,
+	FIELD_OP_MULT,
 };
 
 /*
@@ -285,6 +287,40 @@ static u64 hist_field_minus(struct hist_field *hist_field,
 	return val1 - val2;
 }
 
+static u64 hist_field_div(struct hist_field *hist_field,
+			   struct tracing_map_elt *elt,
+			   struct trace_buffer *buffer,
+			   struct ring_buffer_event *rbe,
+			   void *event)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
+
+	/* Return -1 for the undefined case */
+	if (!val2)
+		return -1;
+
+	return div64_u64(val1, val2);
+}
+
+static u64 hist_field_mult(struct hist_field *hist_field,
+			   struct tracing_map_elt *elt,
+			   struct trace_buffer *buffer,
+			   struct ring_buffer_event *rbe,
+			   void *event)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
+
+	return val1 * val2;
+}
+
 static u64 hist_field_unary_minus(struct hist_field *hist_field,
 				  struct tracing_map_elt *elt,
 				  struct trace_buffer *buffer,
@@ -1592,6 +1628,12 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 	case FIELD_OP_PLUS:
 		strcat(expr, "+");
 		break;
+	case FIELD_OP_DIV:
+		strcat(expr, "/");
+		break;
+	case FIELD_OP_MULT:
+		strcat(expr, "*");
+		break;
 	default:
 		kfree(expr);
 		return NULL;
@@ -1607,7 +1649,7 @@ static int contains_operator(char *str)
 	enum field_op_id field_op = FIELD_OP_NONE;
 	char *op;
 
-	op = strpbrk(str, "+-");
+	op = strpbrk(str, "+-/*");
 	if (!op)
 		return FIELD_OP_NONE;
 
@@ -1628,6 +1670,12 @@ static int contains_operator(char *str)
 	case '+':
 		field_op = FIELD_OP_PLUS;
 		break;
+	case '/':
+		field_op = FIELD_OP_DIV;
+		break;
+	case '*':
+		field_op = FIELD_OP_MULT;
+		break;
 	default:
 		break;
 	}
@@ -2361,10 +2409,26 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	case FIELD_OP_PLUS:
 		sep = "+";
 		break;
+	case FIELD_OP_DIV:
+		sep = "/";
+		break;
+	case FIELD_OP_MULT:
+		sep = "*";
+		break;
 	default:
 		goto free;
 	}
 
+	/*
+	 * Multiplication and division are only supported in single operator
+	 * expressions, since the expression is always evaluated from right
+	 * to left.
+	 */
+	if ((field_op == FIELD_OP_DIV || field_op == FIELD_OP_MULT) && level > 0) {
+		hist_err(file->tr, HIST_ERR_TOO_MANY_SUBEXPR, errpos(str));
+		return ERR_PTR(-EINVAL);
+	}
+
 	operand1_str = strsep(&str, sep);
 	if (!operand1_str || !str)
 		goto free;
@@ -2436,6 +2500,12 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	case FIELD_OP_PLUS:
 		expr->fn = hist_field_plus;
 		break;
+	case FIELD_OP_DIV:
+		expr->fn = hist_field_div;
+		break;
+	case FIELD_OP_MULT:
+		expr->fn = hist_field_mult;
+		break;
 	default:
 		ret = -EINVAL;
 		goto free;
-- 
2.33.0.1079.g6e70778dc9-goog

