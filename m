Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AAA43A480
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 22:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhJYU0M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbhJYUZz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 16:25:55 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F93C06118B
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:10:59 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 2-20020aa79102000000b0044c216dd8ecso7059115pfh.18
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=ycQjNiSMtT2r+Nmugkr+45lU69ayqIpN5p1Bdj1Qt2c=;
        b=aHqeuuil44JjI5IyPl326WS7uYjIPv/RTESFRvJ8eJPKCTZ9lxhYUaAYiJ+Fy/WHxn
         lyoQs83YyCWL7l7MPfW4D1VwVyjWBkTs1SkonBbq11kLheT3tU6trVfUwc6ddfF/LZiM
         mhRWys2x+SIuPykGQVgvbfbvgGt0BWRTaiMymAcBpOXbk43cxrlwxGpezYliMyRESHQm
         NHstJvCXsI7RvQ3gBeJh8qg8iBfNjl7/P94LDup9KQuSlkwFsuI+lmkv2HFzxKZCrtgB
         PL3k0hySc8NmomxDEnAjyq0UZ2OHLh1smdkVnlY/kRNx4XkLd8siIXSYeJ9YSnl74ZRp
         JMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=ycQjNiSMtT2r+Nmugkr+45lU69ayqIpN5p1Bdj1Qt2c=;
        b=X2J2Vp1LoPCUte7wmJa1MQK6umKk7Abbru1czbpWTu+4Upb7r6HT2WOvvUs5chdg0c
         c/s/PET2hP5cjYSwFOJBzz3z+X46l0eYiHwmQWUzaHrKQ5KGiAH2pGdmRX3DhZvYwd12
         W5zw4I4tHrDEpvcA9VjarMPQIspiw/42EACn+zudugkRmox/7dFFcIIyKOVyw0WLoPU4
         d3vgS1y81iriGPLfJ2JB0Skjifmz7f7QyZFg0fp30CFch2I4Lj1h8ofQababBuKVOMdE
         BusHN9QaV21NRZ3Z6Fni15hcr11ABKTJ7zYlGAJylWOePZS1X4gfBQ58qpJXAiuKsa/f
         ZriQ==
X-Gm-Message-State: AOAM530GTFMs9mB3drls8Md8L7lJTsj/wF8V5zkh/9JeRkVm+dIZNIty
        equEzJY8eiHegYSt6iOfbNP+uo8OqmxVBCOTcg==
X-Google-Smtp-Source: ABdhPJxrZpROS+ehAu+ccYX47HZdg5A2ZMiPmh4iidFRHYZJ7YkRT0sQewp765Bvawvqjjdw9LBt0G2lEg7uPi0J0A==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b783:5702:523e:d435])
 (user=kaleshsingh job=sendgmr) by 2002:a17:90b:60d:: with SMTP id
 gb13mr154155pjb.0.1635192657999; Mon, 25 Oct 2021 13:10:57 -0700 (PDT)
Date:   Mon, 25 Oct 2021 13:08:37 -0700
In-Reply-To: <20211025200852.3002369-1-kaleshsingh@google.com>
Message-Id: <20211025200852.3002369-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211025200852.3002369-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 5/8] tracing/histogram: Covert expr to const if both
 operands are constants
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

If both operands of a hist trigger expression are constants, convert the
expression to a constant. This optimization avoids having to perform the
same calculation multiple times and also saves on memory since the
merged constants are represented by a single struct hist_field instead
or multiple.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 104 ++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 34aba07d23f8..db28bcf976f4 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2411,9 +2411,15 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	return ERR_PTR(ret);
 }
 
+/*
+ * If the operands are var refs, return pointers the
+ * variable(s) referenced in var1 and var2, else NULL.
+ */
 static int check_expr_operands(struct trace_array *tr,
 			       struct hist_field *operand1,
-			       struct hist_field *operand2)
+			       struct hist_field *operand2,
+			       struct hist_field **var1,
+			       struct hist_field **var2)
 {
 	unsigned long operand1_flags = operand1->flags;
 	unsigned long operand2_flags = operand2->flags;
@@ -2426,6 +2432,7 @@ static int check_expr_operands(struct trace_array *tr,
 		if (!var)
 			return -EINVAL;
 		operand1_flags = var->flags;
+		*var1 = var;
 	}
 
 	if ((operand2_flags & HIST_FIELD_FL_VAR_REF) ||
@@ -2436,6 +2443,7 @@ static int check_expr_operands(struct trace_array *tr,
 		if (!var)
 			return -EINVAL;
 		operand2_flags = var->flags;
+		*var2 = var;
 	}
 
 	if ((operand1_flags & HIST_FIELD_FL_TIMESTAMP_USECS) !=
@@ -2453,9 +2461,12 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 				     char *var_name, unsigned int *n_subexprs)
 {
 	struct hist_field *operand1 = NULL, *operand2 = NULL, *expr = NULL;
-	unsigned long operand_flags;
+	struct hist_field *var1 = NULL, *var2 = NULL;
+	unsigned long operand_flags, operand2_flags;
 	int field_op, ret = -EINVAL;
 	char *sep, *operand1_str;
+	hist_field_fn_t op_fn;
+	bool combine_consts;
 
 	if (*n_subexprs > 3) {
 		hist_err(file->tr, HIST_ERR_TOO_MANY_SUBEXPR, errpos(str));
@@ -2512,11 +2523,38 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		goto free;
 	}
 
-	ret = check_expr_operands(file->tr, operand1, operand2);
+	switch (field_op) {
+	case FIELD_OP_MINUS:
+		op_fn = hist_field_minus;
+		break;
+	case FIELD_OP_PLUS:
+		op_fn = hist_field_plus;
+		break;
+	case FIELD_OP_DIV:
+		op_fn = hist_field_div;
+		break;
+	case FIELD_OP_MULT:
+		op_fn = hist_field_mult;
+		break;
+	default:
+		ret = -EINVAL;
+		goto free;
+	}
+
+	ret = check_expr_operands(file->tr, operand1, operand2, &var1, &var2);
 	if (ret)
 		goto free;
 
-	flags |= HIST_FIELD_FL_EXPR;
+	operand_flags = var1 ? var1->flags : operand1->flags;
+	operand2_flags = var2 ? var2->flags : operand2->flags;
+
+	/*
+	 * If both operands are constant, the expression can be
+	 * collapsed to a single constant.
+	 */
+	combine_consts = operand_flags & operand2_flags & HIST_FIELD_FL_CONST;
+
+	flags |= combine_consts ? HIST_FIELD_FL_CONST : HIST_FIELD_FL_EXPR;
 
 	flags |= operand1->flags &
 		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
@@ -2533,37 +2571,43 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	expr->operands[0] = operand1;
 	expr->operands[1] = operand2;
 
-	/* The operand sizes should be the same, so just pick one */
-	expr->size = operand1->size;
+	if (combine_consts) {
+		if (var1)
+			expr->operands[0] = var1;
+		if (var2)
+			expr->operands[1] = var2;
 
-	expr->operator = field_op;
-	expr->name = expr_str(expr, 0);
-	expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
-	if (!expr->type) {
-		ret = -ENOMEM;
-		goto free;
-	}
+		expr->constant = op_fn(expr, NULL, NULL, NULL, NULL);
 
-	switch (field_op) {
-	case FIELD_OP_MINUS:
-		expr->fn = hist_field_minus;
-		break;
-	case FIELD_OP_PLUS:
-		expr->fn = hist_field_plus;
-		break;
-	case FIELD_OP_DIV:
-		expr->fn = hist_field_div;
-		break;
-	case FIELD_OP_MULT:
-		expr->fn = hist_field_mult;
-		break;
-	default:
-		ret = -EINVAL;
-		goto free;
+		expr->operands[0] = NULL;
+		expr->operands[1] = NULL;
+
+		/*
+		 * var refs won't be destroyed immediately
+		 * See: destroy_hist_field()
+		 */
+		destroy_hist_field(operand2, 0);
+		destroy_hist_field(operand1, 0);
+
+		expr->name = expr_str(expr, 0);
+	} else {
+		expr->fn = op_fn;
+
+		/* The operand sizes should be the same, so just pick one */
+		expr->size = operand1->size;
+
+		expr->operator = field_op;
+		expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
+		if (!expr->type) {
+			ret = -ENOMEM;
+			goto free;
+		}
+
+		expr->name = expr_str(expr, 0);
 	}
 
 	return expr;
- free:
+free:
 	destroy_hist_field(operand1, 0);
 	destroy_hist_field(operand2, 0);
 	destroy_hist_field(expr, 0);
-- 
2.33.0.1079.g6e70778dc9-goog

