Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8A84342F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 03:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhJTBgj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 21:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhJTBgj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 21:36:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC277C061749
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 18:34:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u84-20020a254757000000b005bbc2bc51fcso21300297yba.3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=E6LsuPT3sCsEi4Zp/VZ8W05eFESmOHRwQobyJf9PDAU=;
        b=e8PT+xyX2VIPOarEAwk7dRqrwAq1/cpTrEVbKAgKNBLqiVxbO9a3i6g6pokseFQtYO
         8Nlq0ZHaAtxMKWNI0R/MuBvh4M0SZH+YWcsXWzanOB4i9iRlawcmK8wV50Y4cvOiNQDw
         3hqLHxTk6tpMYduyNjcvYbo51t/Duog9ISfn9dFZTg4V9ZyL6hfXvep+2l4TqN6SJhbG
         CdF34x8C+AUw+pJKdSYvXOX1EmPtVRKtX1WHuj884NjmD5CY/buHhBtJ3efDQBlL6U6p
         8AR/LyQZxd9DpmPFr/GcwPPuFRUQge8mmcWyo68DB55kSEthEB6HHHgsKMD4e/0i0ip6
         3PCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=E6LsuPT3sCsEi4Zp/VZ8W05eFESmOHRwQobyJf9PDAU=;
        b=G+/t33WrlKSqSw1HU3gEFpCiS8j9R/00cz9HbpamdbevBexai3sk2ptVCwudRD1FAP
         ugTO9f2uX7p0Nif0fnncMevyQdVazeHfjQMPdB9MWHa97KyHWd20ZoRBCFREOZjM33ZN
         yN2kUgPjCcPEfqRWJlm5gxVilqn8T5/A2MNHucDYQpmocuezHBcGEplA/tSJeUzezq56
         IjF/bWoM7HNvHmT1wRpGyhJBzo34tCH1NL7h2bF9eij5eQvdfAOnOdWI0ed4EIQwXfBf
         Mnd4sANY2Z96RW/5OkLlrOXakarQhgIXgPfeWvt84TC/9llexgfZwlguT7t+r2eetfDx
         UX0w==
X-Gm-Message-State: AOAM530l40lIQAlH6GCq1KJbpwYX5I7bJPwsuSv0Dnff52cVMMjDHhjg
        kubTfTFqB7lDS9A+0lSsOOg7GDJnVRbEVWtByQ==
X-Google-Smtp-Source: ABdhPJxQ0lEpI+LfcyC7prj9h7MYOPG0MyNVoH7NnHyKZHmfq7e0TvJ9uggtBs+3S6gsqEsNHdci+QFJ4rE9xquZig==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:1953:b886:7a6c:bf0])
 (user=kaleshsingh job=sendgmr) by 2002:a25:8287:: with SMTP id
 r7mr41211463ybk.365.1634693664882; Tue, 19 Oct 2021 18:34:24 -0700 (PDT)
Date:   Tue, 19 Oct 2021 18:31:40 -0700
In-Reply-To: <20211020013153.4106001-1-kaleshsingh@google.com>
Message-Id: <20211020013153.4106001-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211020013153.4106001-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 3/5] tracing: Fix operator precedence for hist triggers expression
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
index 9415ee65acc0..9205cfe120e8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -68,7 +68,9 @@
 	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),	\
 	C(INVALID_STR_OPERAND,	"String type can not be an operand in expression"), \
 	C(TOO_MANY_CONSTS,	"Too many constants defined"),		\
-	C(EXPECT_NUMBER,	"Expecting numeric literal"),
+	C(EXPECT_NUMBER,	"Expecting numeric literal"),		\
+	C(UNARY_MINUS_SUBEXPR,	"Unary minus not supported in sub-expressions"), \
+	C(SYM_OFFSET_SUBEXPR,	".sym-offset not supported in sub-expressions"),
 
 #undef C
 #define C(a, b)		HIST_ERR_##a
@@ -1647,40 +1649,96 @@ static char *expr_str(struct hist_field *field, unsigned int level)
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
@@ -2006,7 +2064,7 @@ static char *field_name_from_var(struct hist_trigger_data *hist_data,
 
 		if (strcmp(var_name, name) == 0) {
 			field = hist_data->attrs->var_defs.expr[i];
-			if (contains_operator(field) || is_var_ref(field))
+			if (contains_operator(field, NULL) || is_var_ref(field))
 				continue;
 			return field;
 		}
@@ -2275,21 +2333,24 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
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
@@ -2306,8 +2367,16 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
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
@@ -2321,7 +2390,7 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	}
 
 	operand_flags = 0;
-	operand1 = parse_expr(hist_data, file, str, operand_flags, NULL, ++level);
+	operand1 = parse_expr(hist_data, file, str, operand_flags, NULL, n_subexprs);
 	if (IS_ERR(operand1)) {
 		ret = PTR_ERR(operand1);
 		goto free;
@@ -2391,60 +2460,61 @@ static int check_expr_operands(struct trace_array *tr,
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
@@ -2456,9 +2526,9 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
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
@@ -3892,9 +3962,9 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
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
@@ -4035,7 +4105,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 	struct hist_field *hist_field = NULL;
 	unsigned long flags = 0;
 	unsigned int key_size;
-	int ret = 0;
+	int ret = 0, n_subexprs = 0;
 
 	if (WARN_ON(key_idx >= HIST_FIELDS_MAX))
 		return -EINVAL;
@@ -4048,7 +4118,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
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

