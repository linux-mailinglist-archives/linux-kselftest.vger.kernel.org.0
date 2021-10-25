Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5701943A475
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 22:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbhJYUZz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 16:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhJYUZe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 16:25:34 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D67C04A418
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:10:24 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id z20-20020a17090abd9400b001a1b91abc81so464873pjr.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=iRuPYXoXcrU+gBqRAGhoDpe/K+LXE+9n+7UkO6cV9+w=;
        b=GAVlFRWpquxQgXr3aSxg1OFGvTrVNx4qVnVFZoG/+2lawxOOt1ZiH7BiEY0qicDK7h
         3N7Suc0Ka1S88TwBDlH27drOlWOt0ZSr7PhSvYnAJ96IF+RPkSB679FS7Wns56A/nmMW
         wu5oB8dU8N46CE18RJKJAjf5AXIcJ7j0DYqeGtINeMH2PgXZe1wgkqnl0hLzIxrwU1M9
         o24QoGCWhgRNsFDgzEoD5nmvS+bhe6IxLhnaEDEBUgUTmEGPT5KJpm56W1E8hmP0aZWp
         wNV91F3YJw9PeanrFsztHBVsBgJxy4b+wsETLfC7ZbszldRemjb1INNyUCmQNO7Ef1+k
         eViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=iRuPYXoXcrU+gBqRAGhoDpe/K+LXE+9n+7UkO6cV9+w=;
        b=UmbojOtZxjZ/oydSdL8WEENjWdXPl0F5okjibxVOh3BvdIkkYekj4SV3Ec+218sLsP
         t2U3pZtTZ0H84fmaYG+GehSXlJQiyeFLPLMOCPenNLbNrCAPVQZu+ZUynIoY6XLubDYi
         904LCB1tJrQZ1G/9b9bUZG7lTpCxig/a/C13hQEYUk2xr3ZKsS4JpIBTwuXfx/Vubccx
         CX+WBN6B301CtYh8dbzMGDsdWENcDn7VFfqLeseVK98KZ51vZQCsHdD7VtP2JIS5U/Ng
         heZ8cPuxvJwPkyRkDgyQsJsyiugWlBjz1U9tPEzEL4mNa8TktRM9GSFakhl3ELv6aBKj
         OAsw==
X-Gm-Message-State: AOAM531pXi7x7uVh9OYlKezGrNXAHLjBrYX6ncQvwL2mnOhwTNV6miVK
        k4z+scncBSQOnP1nJxQ8jFeNLl1WRFJS+ES6Jw==
X-Google-Smtp-Source: ABdhPJy3RMLEye7zYyYojyILl3vD84PxOkz34BxaVkTlBJfr2GFO3/7X6V+6P5CDojCfKvW7aoiEmIvL+Pm6POHnzw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b783:5702:523e:d435])
 (user=kaleshsingh job=sendgmr) by 2002:a17:902:bf02:b0:13f:cfdd:804e with
 SMTP id bi2-20020a170902bf0200b0013fcfdd804emr18447486plb.1.1635192623573;
 Mon, 25 Oct 2021 13:10:23 -0700 (PDT)
Date:   Mon, 25 Oct 2021 13:08:35 -0700
In-Reply-To: <20211025200852.3002369-1-kaleshsingh@google.com>
Message-Id: <20211025200852.3002369-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211025200852.3002369-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 3/8] tracing: Fix operator precedence for hist triggers expression
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

The current histogram expression evaluation logic evaluates the
expression from right to left. This can lead to incorrect results
if the operations are not associative (as is the case for subtraction
and, the now added, division operators).
	e.g. 16-8-4-2 should be 2 not 10 --> 16-8-4-2 = ((16-8)-4)-2
	     64/8/4/2 should be 1 not 16 --> 64/8/4/2 = ((64/8)/4)/2

Division and multiplication are currently limited to single operation
expression due to operator precedence support not yet implemented.

Rework the expression parsing to support the correct evaluation of
expressions containing operators of different precedences; and fix
the associativity error by evaluating expressions with operators of
the same precedence from left to right.

Examples:
        (1) echo 'hist:keys=common_pid:a=8,b=4,c=2,d=1,w=$a-$b-$c-$d' \
                  >> event/trigger
        (2) echo 'hist:keys=common_pid:x=$a/$b/3/2' >> event/trigger
        (3) echo 'hist:keys=common_pid:y=$a+10/$c*1024' >> event/trigger
        (4) echo 'hist:keys=common_pid:z=$a/$b+$c*$d' >> event/trigger

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
---

Changed in v2:
  - Add Namhyung's Reviewed-by

 kernel/trace/trace_events_hist.c | 210 ++++++++++++++++++++-----------
 1 file changed, 140 insertions(+), 70 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 522355a06f58..e10c7d9611e5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -67,7 +67,9 @@
 	C(TOO_MANY_SORT_FIELDS,	"Too many sort fields (Max = 2)"),	\
 	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),	\
 	C(INVALID_STR_OPERAND,	"String type can not be an operand in expression"), \
-	C(EXPECT_NUMBER,	"Expecting numeric literal"),
+	C(EXPECT_NUMBER,	"Expecting numeric literal"),		\
+	C(UNARY_MINUS_SUBEXPR,	"Unary minus not supported in sub-expressions"), \
+	C(SYM_OFFSET_SUBEXPR,	".sym-offset not supported in sub-expressions"),
 
 #undef C
 #define C(a, b)		HIST_ERR_##a
@@ -1644,40 +1646,96 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 	return expr;
 }
 
-static int contains_operator(char *str)
+/*
+ * If field_op != FIELD_OP_NONE, *sep points to the root operator
+ * of the expression tree to be evaluated.
+ */
+static int contains_operator(char *str, char **sep)
 {
 	enum field_op_id field_op = FIELD_OP_NONE;
-	char *op;
+	char *minus_op, *plus_op, *div_op, *mult_op;
+
+
+	/*
+	 * Report the last occurrence of the operators first, so that the
+	 * expression is evaluated left to right. This is important since
+	 * subtraction and division are not associative.
+	 *
+	 *	e.g
+	 *		64/8/4/2 is 1, i.e 64/8/4/2 = ((64/8)/4)/2
+	 *		14-7-5-2 is 0, i.e 14-7-5-2 = ((14-7)-5)-2
+	 */
 
-	op = strpbrk(str, "+-/*");
-	if (!op)
-		return FIELD_OP_NONE;
+	/*
+	 * First, find lower precedence addition and subtraction
+	 * since the expression will be evaluated recursively.
+	 */
+	minus_op = strrchr(str, '-');
+	if (minus_op) {
+		/* Unfortunately, the modifier ".sym-offset" can confuse things. */
+		if (minus_op - str >= 4 && !strncmp(minus_op - 4, ".sym-offset", 11))
+			goto out;
 
-	switch (*op) {
-	case '-':
 		/*
-		 * Unfortunately, the modifier ".sym-offset"
-		 * can confuse things.
+		 * Unary minus is not supported in sub-expressions. If
+		 * present, it is always the next root operator.
 		 */
-		if (op - str >= 4 && !strncmp(op - 4, ".sym-offset", 11))
-			return FIELD_OP_NONE;
-
-		if (*str == '-')
+		if (minus_op == str) {
 			field_op = FIELD_OP_UNARY_MINUS;
-		else
-			field_op = FIELD_OP_MINUS;
-		break;
-	case '+':
-		field_op = FIELD_OP_PLUS;
-		break;
-	case '/':
+			goto out;
+		}
+
+		field_op = FIELD_OP_MINUS;
+	}
+
+	plus_op = strrchr(str, '+');
+	if (plus_op || minus_op) {
+		/*
+		 * For operators of the same precedence use to rightmost as the
+		 * root, so that the expression is evaluated left to right.
+		 */
+		if (plus_op > minus_op)
+			field_op = FIELD_OP_PLUS;
+		goto out;
+	}
+
+	/*
+	 * Multiplication and division have higher precedence than addition and
+	 * subtraction.
+	 */
+	div_op = strrchr(str, '/');
+	if (div_op)
 		field_op = FIELD_OP_DIV;
-		break;
-	case '*':
+
+	mult_op = strrchr(str, '*');
+	/*
+	 * For operators of the same precedence use to rightmost as the
+	 * root, so that the expression is evaluated left to right.
+	 */
+	if (mult_op > div_op)
 		field_op = FIELD_OP_MULT;
-		break;
-	default:
-		break;
+
+out:
+	if (sep) {
+		switch (field_op) {
+		case FIELD_OP_UNARY_MINUS:
+		case FIELD_OP_MINUS:
+			*sep = minus_op;
+			break;
+		case FIELD_OP_PLUS:
+			*sep = plus_op;
+			break;
+		case FIELD_OP_DIV:
+			*sep = div_op;
+			break;
+		case FIELD_OP_MULT:
+			*sep = mult_op;
+			break;
+		case FIELD_OP_NONE:
+		default:
+			*sep = NULL;
+			break;
+		}
 	}
 
 	return field_op;
@@ -2003,7 +2061,7 @@ static char *field_name_from_var(struct hist_trigger_data *hist_data,
 
 		if (strcmp(var_name, name) == 0) {
 			field = hist_data->attrs->var_defs.expr[i];
-			if (contains_operator(field) || is_var_ref(field))
+			if (contains_operator(field, NULL) || is_var_ref(field))
 				continue;
 			return field;
 		}
@@ -2266,21 +2324,24 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 				     struct trace_event_file *file,
 				     char *str, unsigned long flags,
-				     char *var_name, unsigned int level);
+				     char *var_name, unsigned int *n_subexprs);
 
 static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 				      struct trace_event_file *file,
 				      char *str, unsigned long flags,
-				      char *var_name, unsigned int level)
+				      char *var_name, unsigned int *n_subexprs)
 {
 	struct hist_field *operand1, *expr = NULL;
 	unsigned long operand_flags;
 	int ret = 0;
 	char *s;
 
+	/* Unary minus operator, increment n_subexprs */
+	++*n_subexprs;
+
 	/* we support only -(xxx) i.e. explicit parens required */
 
-	if (level > 3) {
+	if (*n_subexprs > 3) {
 		hist_err(file->tr, HIST_ERR_TOO_MANY_SUBEXPR, errpos(str));
 		ret = -EINVAL;
 		goto free;
@@ -2297,8 +2358,16 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	}
 
 	s = strrchr(str, ')');
-	if (s)
+	if (s) {
+		 /* unary minus not supported in sub-expressions */
+		if (*(s+1) != '\0') {
+			hist_err(file->tr, HIST_ERR_UNARY_MINUS_SUBEXPR,
+				 errpos(str));
+			ret = -EINVAL;
+			goto free;
+		}
 		*s = '\0';
+	}
 	else {
 		ret = -EINVAL; /* no closing ')' */
 		goto free;
@@ -2312,7 +2381,7 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	}
 
 	operand_flags = 0;
-	operand1 = parse_expr(hist_data, file, str, operand_flags, NULL, ++level);
+	operand1 = parse_expr(hist_data, file, str, operand_flags, NULL, n_subexprs);
 	if (IS_ERR(operand1)) {
 		ret = PTR_ERR(operand1);
 		goto free;
@@ -2382,60 +2451,61 @@ static int check_expr_operands(struct trace_array *tr,
 static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 				     struct trace_event_file *file,
 				     char *str, unsigned long flags,
-				     char *var_name, unsigned int level)
+				     char *var_name, unsigned int *n_subexprs)
 {
 	struct hist_field *operand1 = NULL, *operand2 = NULL, *expr = NULL;
 	unsigned long operand_flags;
 	int field_op, ret = -EINVAL;
 	char *sep, *operand1_str;
 
-	if (level > 3) {
+	if (*n_subexprs > 3) {
 		hist_err(file->tr, HIST_ERR_TOO_MANY_SUBEXPR, errpos(str));
 		return ERR_PTR(-EINVAL);
 	}
 
-	field_op = contains_operator(str);
+	/*
+	 * ".sym-offset" in expressions has no effect on their evaluation,
+	 * but can confuse operator parsing.
+	 */
+	if (*n_subexprs == 0) {
+		sep = strstr(str, ".sym-offset");
+		if (sep) {
+			*sep = '\0';
+			if (strpbrk(str, "+-/*") || strpbrk(sep + 11, "+-/*")) {
+				*sep = '.';
+				hist_err(file->tr, HIST_ERR_SYM_OFFSET_SUBEXPR,
+					 errpos(sep));
+				return ERR_PTR(-EINVAL);
+			}
+			*sep = '.';
+		}
+	}
+
+	field_op = contains_operator(str, &sep);
 
 	if (field_op == FIELD_OP_NONE)
 		return parse_atom(hist_data, file, str, &flags, var_name);
 
 	if (field_op == FIELD_OP_UNARY_MINUS)
-		return parse_unary(hist_data, file, str, flags, var_name, ++level);
+		return parse_unary(hist_data, file, str, flags, var_name, n_subexprs);
 
-	switch (field_op) {
-	case FIELD_OP_MINUS:
-		sep = "-";
-		break;
-	case FIELD_OP_PLUS:
-		sep = "+";
-		break;
-	case FIELD_OP_DIV:
-		sep = "/";
-		break;
-	case FIELD_OP_MULT:
-		sep = "*";
-		break;
-	default:
-		goto free;
-	}
+	/* Binary operator found, increment n_subexprs */
+	++*n_subexprs;
 
-	/*
-	 * Multiplication and division are only supported in single operator
-	 * expressions, since the expression is always evaluated from right
-	 * to left.
-	 */
-	if ((field_op == FIELD_OP_DIV || field_op == FIELD_OP_MULT) && level > 0) {
-		hist_err(file->tr, HIST_ERR_TOO_MANY_SUBEXPR, errpos(str));
-		return ERR_PTR(-EINVAL);
-	}
+	/* Split the expression string at the root operator */
+	if (!sep)
+		goto free;
+	*sep = '\0';
+	operand1_str = str;
+	str = sep+1;
 
-	operand1_str = strsep(&str, sep);
 	if (!operand1_str || !str)
 		goto free;
 
 	operand_flags = 0;
-	operand1 = parse_atom(hist_data, file, operand1_str,
-			      &operand_flags, NULL);
+
+	/* LHS of string is an expression e.g. a+b in a+b+c */
+	operand1 = parse_expr(hist_data, file, operand1_str, operand_flags, NULL, n_subexprs);
 	if (IS_ERR(operand1)) {
 		ret = PTR_ERR(operand1);
 		operand1 = NULL;
@@ -2447,9 +2517,9 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		goto free;
 	}
 
-	/* rest of string could be another expression e.g. b+c in a+b+c */
+	/* RHS of string is another expression e.g. c in a+b+c */
 	operand_flags = 0;
-	operand2 = parse_expr(hist_data, file, str, operand_flags, NULL, ++level);
+	operand2 = parse_expr(hist_data, file, str, operand_flags, NULL, n_subexprs);
 	if (IS_ERR(operand2)) {
 		ret = PTR_ERR(operand2);
 		operand2 = NULL;
@@ -3883,9 +3953,9 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
 			      unsigned long flags)
 {
 	struct hist_field *hist_field;
-	int ret = 0;
+	int ret = 0, n_subexprs = 0;
 
-	hist_field = parse_expr(hist_data, file, field_str, flags, var_name, 0);
+	hist_field = parse_expr(hist_data, file, field_str, flags, var_name, &n_subexprs);
 	if (IS_ERR(hist_field)) {
 		ret = PTR_ERR(hist_field);
 		goto out;
@@ -4026,7 +4096,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 	struct hist_field *hist_field = NULL;
 	unsigned long flags = 0;
 	unsigned int key_size;
-	int ret = 0;
+	int ret = 0, n_subexprs = 0;
 
 	if (WARN_ON(key_idx >= HIST_FIELDS_MAX))
 		return -EINVAL;
@@ -4039,7 +4109,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 		hist_field = create_hist_field(hist_data, NULL, flags, NULL);
 	} else {
 		hist_field = parse_expr(hist_data, file, field_str, flags,
-					NULL, 0);
+					NULL, &n_subexprs);
 		if (IS_ERR(hist_field)) {
 			ret = PTR_ERR(hist_field);
 			goto out;
-- 
2.33.0.1079.g6e70778dc9-goog

