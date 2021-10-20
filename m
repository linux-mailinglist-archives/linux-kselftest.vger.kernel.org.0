Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A334342F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 03:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJTBgY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 21:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhJTBgX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 21:36:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2BAC061749
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 18:34:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y18-20020a25a092000000b005bddb39f160so26394275ybh.10
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 18:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=QoyL/j4Wj5xtQouIJDIdg2CMTweye3z9i1beCqJqXYs=;
        b=Zw3jTItRnv/CJli7JslBJen12pbdK99RkpUXc0nkc0zUSAySAtJbYkRKEI8joNJr59
         cBZqPCZX3zMuHXTJADhzSz/ru2z+OsZoqvnKok1CLc27jw0jAWWi8zDpMz3O5b/wDU5f
         UwFb1/Iqj0Foq0RC2L4ntvG+WBje7P2yca6VG/6tl4FHPyxxpeuYKGSr0/+x8dDagRPP
         nKl2dh/WItLL0Brnetrw3YCGNd6lueLntINApGPWW+iUK+sfkbXgNfeZKhNjBFtQwSfx
         r3gCve22ppGU0Z99Eh+UYIqYCAWgXOiL1K3dsSOi3Pxsk77v2jBb/U9jQrLwTuAsYaMw
         x7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=QoyL/j4Wj5xtQouIJDIdg2CMTweye3z9i1beCqJqXYs=;
        b=NBm+aCPo1lxJyKTqprm22Bc0kreHYH9OOIgsQF6AaX1nSehD4ssJdgaaQgXY+Qdsk8
         nDLh6hP9xHd11TqZDXyePTgA55OsMm7DJlX87XdauQ4s7sSPhbnqCvKYIfnbs74aDKGX
         nycb8X9ThxM2pxF1Jm/s0kyXOzWCES7oFWg1JCxf58/m1EuehAlyIdm3MLSJiJEynCh2
         cmWXjekgUQ1VtMwcfBiCxbOaBj0DPAHeAzPKaRAoivmjWdSRsuKW2b7zMURc1mzGqqYc
         XaOLokitLuNUGlkun8aoh4siVIN6sWSF/iwL1GxAs7RQztiYoQNDk26GkznP+f8v64AT
         8Rbg==
X-Gm-Message-State: AOAM5302gJbQFmha0wsGTZCo00W8BYvEOSFtYa1PDa5enAqBrp0rgVz8
        Zvbb2DYzGcYtUVpREiKBZ+fCm6Uss31sAL5dog==
X-Google-Smtp-Source: ABdhPJyDLS9Bp3kyfvBbh/WllX3HyAO9JB+5Aw4IPjnhXh1jJvgcTD9BGo3pTTYMLjQzjXA1Fssg+oNmS6BG+vmtWg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:1953:b886:7a6c:bf0])
 (user=kaleshsingh job=sendgmr) by 2002:a25:c696:: with SMTP id
 k144mr37146969ybf.296.1634693649086; Tue, 19 Oct 2021 18:34:09 -0700 (PDT)
Date:   Tue, 19 Oct 2021 18:31:39 -0700
In-Reply-To: <20211020013153.4106001-1-kaleshsingh@google.com>
Message-Id: <20211020013153.4106001-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211020013153.4106001-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 2/5] tracing: Add division and multiplication support for
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
index 8563a2d51f65..9415ee65acc0 100644
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
2.33.0.1079.g6e70778dc9-goog

