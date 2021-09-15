Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463F640CD87
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 21:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhIOT4C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 15:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhIOT4C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 15:56:02 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A8AC061575
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 12:54:42 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o4-20020ae9f504000000b003d39d97b227so7215992qkg.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 12:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=aeNnN9xag+ICPAe0ffKzWBBB/Z6CmxOcYPRHh7D2frs=;
        b=qIerQ+9u8w+7e+qc1Pt4BEtWWL4xi9o8Z0pshF/NwvFawnX2spGgfsa9wOdgOOK9XQ
         RsJjzY7WGt/x7Wfs3fZPhK7HV2XBvzYQhv2bGfwblwPJ+AxlvEq944N7y6+C/zP6st/K
         twrstG4QdSPG3LQcpZ+dcCdMORJbjS3Ap/fnWfckbmFtO9pZm6gHHt2z+NsiRWTxOh3N
         i1JHv9yIrsHipRryQvgavJikwchYg2qHfdG7ep7gkYP6fB7Fx4+dOei0JgekEhb01/g+
         AxBKKH+J4nWVjPfNEtTSPGqEoxCFWJegufYxQbs+ajtcOyaU0QEDGRnDFLlHFR9Muinr
         y2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=aeNnN9xag+ICPAe0ffKzWBBB/Z6CmxOcYPRHh7D2frs=;
        b=0RgGm4COvPPtVaJfU5A8jwAbZbHvbNl28O2pwz/jEZBE3CWx9jIvOOBil68dVtiWD9
         2pyzI2yO+QPBjVeZ6lzw1ZPIa1FeShpTCf6RnpQHlhMjRRsx/9E2H0OQr0SQT3h6uIHW
         TC/N78P0pWVn0d3sopO5dPtQZPOoQmGvr2XS9KfOCF1C/WodDhDVE6paJGU4Ioqf9qKT
         ykyiKVuPjkG58qxuN6Bk3utyFIjURvvGR/PeBMAhL7xe2vkROb6PpIsXoWQmTZix72gm
         isqimQdIowQTfxZe0Q2krhaKh+pTstJG/4MPOj5uRx49tN6ZT1+9ogEzNRcRQyZ2sioP
         BQSA==
X-Gm-Message-State: AOAM5336uWeS/PUZZNWLqDOnMU1fw2M7nCsprxV4vGbb1W3V4qjowAX/
        xOTpxkFXa5ZHKw6dux0kk1JVw0poujiE7wZ2uw==
X-Google-Smtp-Source: ABdhPJz+DW0EgPkGnJfyhBQPsr8CaKufz8imI6mY2o3UUZTSwYh/1vOOeISmx+9v9/HDzO4mxi5M1R98Grqs+py63A==
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:f58a:: with SMTP id
 k10mr1752710qvm.62.1631735681948; Wed, 15 Sep 2021 12:54:41 -0700 (PDT)
Date:   Wed, 15 Sep 2021 19:52:46 +0000
In-Reply-To: <20210915195306.612966-1-kaleshsingh@google.com>
Message-Id: <20210915195306.612966-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20210915195306.612966-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 2/5] tracing: Add division and multiplication support for hist triggers
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
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

	echo 'hist:keys=common_pid:x=5*$b' \
                   >> event/trigger

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 kernel/trace/trace_events_hist.c | 72 +++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 2802b211ccf3..dc28eb6fc73a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -99,6 +99,8 @@ enum field_op_id {
 	FIELD_OP_PLUS,
 	FIELD_OP_MINUS,
 	FIELD_OP_UNARY_MINUS,
+	FIELD_OP_DIV,
+	FIELD_OP_MULT,
 };
 
 /*
@@ -287,6 +289,40 @@ static u64 hist_field_minus(struct hist_field *hist_field,
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
+	return val1 / val2;
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
@@ -1595,6 +1631,12 @@ static char *expr_str(struct hist_field *field, unsigned int level)
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
@@ -1610,7 +1652,7 @@ static int contains_operator(char *str)
 	enum field_op_id field_op = FIELD_OP_NONE;
 	char *op;
 
-	op = strpbrk(str, "+-");
+	op = strpbrk(str, "+-/*");
 	if (!op)
 		return FIELD_OP_NONE;
 
@@ -1631,6 +1673,12 @@ static int contains_operator(char *str)
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
@@ -2370,10 +2418,26 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
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
@@ -2445,6 +2509,12 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
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
2.33.0.309.g3052b89438-goog

