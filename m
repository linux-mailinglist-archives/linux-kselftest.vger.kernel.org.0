Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF8B40CD83
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 21:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhIOTzE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 15:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhIOTzD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 15:55:03 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CB4C061764
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 12:53:44 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id v1-20020a0cc1c1000000b0037c671dbf1cso7895988qvh.12
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 12:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=sVrJdEErDsLvRaIvb4CeOJb0g1GXWTlBERxtwXGY8HE=;
        b=EF/Zdx1yS38c5HY21otyrQ+dN9YognFFRBeWIi6ndcOEAxCRrbPgOWTYlC9UvR5ZKI
         uTxWvIc06UJtndo6LfQx0+zkShzvsz0COyD28WDmP9SMRbqS6ALTuKOhIH2763U5IWpo
         L+l1st2odVLiVjJ/365RyRkHcqbq9awUqgaDOdASI3uDhFvOFjX/Q8/FL3ntZ2V6q0Cf
         W/rXCCABLtyPabSFpHhNlxJMPtYHR5UuspGeXCa/wyEzwnduwXizgnaIPABNpbIuy0+N
         C0B066hxKq9pQIL7cfH1EnOpzWTbwyAPZ7FWMqcsrIVyCw86xpklBSc/t/V+HKSCJdht
         vO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=sVrJdEErDsLvRaIvb4CeOJb0g1GXWTlBERxtwXGY8HE=;
        b=k8kqAUIk2UJPmW/SNijelCynJppTBheVjq45gfRkVxgXK4KMso105QKs0DT7/Mo2Sp
         SjaaKQuyg7Lxq+1OrIvBFGJvA/dJLi9SaeqJQHqoT1JkUi+tzG4CtoyE9ohFfVLka3JQ
         fvVqFnkOqGCLGPdiYGys5W2wsXnOqMlZg03Uet6+aOsOcLy/Ga0cPRC6kci+3n7lDezP
         kvGLOz8oGf6lTnHyOL3OrYrd5IDovIvfjCQTZHvhvf45OpJ7fSEGgHOEh56W2isKykxa
         lsWakptxrxoHm2/suqUU6SwkRHzxROmgtn05aXvzVwki3ojH7YPqIlDDzsyw5VhmJaWz
         X6Og==
X-Gm-Message-State: AOAM533A0H5OlhAt/E+iGYG2FzYLeuaR38t2e2XeJFPQ+WOrSndEybcw
        12ugEsvKiW/4pXyb8wvg6xQo1S3Cd7yhHQRtAw==
X-Google-Smtp-Source: ABdhPJzFgzXL254C6TJScd4rbVqalNmOtOpQrcr3F0qHUJHI4lsGkBvLdvyBlcXeL4qfNFhEkbRsblZgj+cg57lgyg==
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:8c81:: with SMTP id
 p1mr1771257qvb.7.1631735623651; Wed, 15 Sep 2021 12:53:43 -0700 (PDT)
Date:   Wed, 15 Sep 2021 19:52:45 +0000
In-Reply-To: <20210915195306.612966-1-kaleshsingh@google.com>
Message-Id: <20210915195306.612966-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20210915195306.612966-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 1/5] tracing: Add support for creating hist trigger variables
 from literal
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

Currently hist trigger expressions don't support the use of numeric
literals:
	e.g. echo 'hist:keys=common_pid:x=$y-1234'
		--> is not valid expression syntax

Having the ability to use numeric constants in hist triggers supports
a wider range of expressions for creating variables.

Add support for creating trace event histogram variables from numeric
literals.

	e.g. echo 'hist:keys=common_pid:x=1234,y=size-1024' >> event/trigger

A negative numeric constant is created, using unary minus operator
(parentheses are required).

	e.g. echo 'hist:keys=common_pid:z=-(2)' >> event/trigger

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 kernel/trace/trace_events_hist.c | 80 +++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a6061a69aa84..2802b211ccf3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -66,7 +66,9 @@
 	C(EMPTY_SORT_FIELD,	"Empty sort field"),			\
 	C(TOO_MANY_SORT_FIELDS,	"Too many sort fields (Max = 2)"),	\
 	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),	\
-	C(INVALID_STR_OPERAND,	"String type can not be an operand in expression"),
+	C(INVALID_STR_OPERAND,	"String type can not be an operand in expression"), \
+	C(TOO_MANY_CONSTS,	"Too many constants defined"),		\
+	C(EXPECT_NUMBER,	"Expecting numeric literal"),
 
 #undef C
 #define C(a, b)		HIST_ERR_##a
@@ -89,6 +91,8 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field,
 #define HIST_FIELD_OPERANDS_MAX	2
 #define HIST_FIELDS_MAX		(TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
 #define HIST_ACTIONS_MAX	8
+#define HIST_CONST_MAX		4
+#define HIST_CONST_DIGITS_MAX	21
 
 enum field_op_id {
 	FIELD_OP_NONE,
@@ -152,6 +156,9 @@ struct hist_field {
 	bool                            read_once;
 
 	unsigned int			var_str_idx;
+
+	/* Numeric literals are represented as u64 */
+	u64				constant;
 };
 
 static u64 hist_field_none(struct hist_field *field,
@@ -163,6 +170,15 @@ static u64 hist_field_none(struct hist_field *field,
 	return 0;
 }
 
+static u64 hist_field_const(struct hist_field *field,
+			   struct tracing_map_elt *elt,
+			   struct trace_buffer *buffer,
+			   struct ring_buffer_event *rbe,
+			   void *event)
+{
+	return field->constant;
+}
+
 static u64 hist_field_counter(struct hist_field *field,
 			      struct tracing_map_elt *elt,
 			      struct trace_buffer *buffer,
@@ -341,6 +357,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_CPU		= 1 << 15,
 	HIST_FIELD_FL_ALIAS		= 1 << 16,
 	HIST_FIELD_FL_BUCKET		= 1 << 17,
+	HIST_FIELD_FL_CONST		= 1 << 18,
 };
 
 struct var_defs {
@@ -410,6 +427,7 @@ struct hist_trigger_data {
 	struct field_var		*save_vars[SYNTH_FIELDS_MAX];
 	unsigned int			n_save_vars;
 	unsigned int			n_save_var_str;
+	unsigned int			n_constants;
 };
 
 struct action_data;
@@ -1516,6 +1534,12 @@ static void expr_field_str(struct hist_field *field, char *expr)
 {
 	if (field->flags & HIST_FIELD_FL_VAR_REF)
 		strcat(expr, "$");
+	else if (field->flags & HIST_FIELD_FL_CONST) {
+		char str[HIST_CONST_DIGITS_MAX];
+
+		snprintf(str, HIST_CONST_DIGITS_MAX, "%llu", field->constant);
+		strcat(expr, str);
+	}
 
 	strcat(expr, hist_field_name(field, 0));
 
@@ -1689,6 +1713,15 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
+	if (flags & HIST_FIELD_FL_CONST) {
+		hist_field->fn = hist_field_const;
+		hist_field->size = sizeof(u64);
+		hist_field->type = kstrdup("u64", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+		goto out;
+	}
+
 	if (flags & HIST_FIELD_FL_STACKTRACE) {
 		hist_field->fn = hist_field_none;
 		goto out;
@@ -2090,6 +2123,35 @@ static struct hist_field *create_alias(struct hist_trigger_data *hist_data,
 	return alias;
 }
 
+static struct hist_field *parse_const(struct hist_trigger_data *hist_data,
+				      char *str, char *var_name,
+				      unsigned long *flags)
+{
+	struct trace_array *tr = hist_data->event_file->tr;
+	struct hist_field *field = NULL;
+	u64 constant;
+
+	if (hist_data->n_constants >= HIST_CONST_MAX) {
+		hist_err(tr, HIST_ERR_TOO_MANY_CONSTS, errpos(str));
+		return NULL;
+	}
+
+	if (kstrtoull(str, 0, &constant)) {
+		hist_err(tr, HIST_ERR_EXPECT_NUMBER, errpos(str));
+		return NULL;
+	}
+
+	*flags |= HIST_FIELD_FL_CONST;
+	field = create_hist_field(hist_data, NULL, *flags, var_name);
+	if (!field)
+		return NULL;
+
+	field->constant = constant;
+	hist_data->n_constants++;
+
+	return field;
+}
+
 static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 				     struct trace_event_file *file, char *str,
 				     unsigned long *flags, char *var_name)
@@ -2100,6 +2162,15 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 	unsigned long buckets = 0;
 	int ret = 0;
 
+	if (isdigit(str[0])) {
+		hist_field = parse_const(hist_data, str, var_name, flags);
+		if (!hist_field) {
+			ret = -EINVAL;
+			goto out;
+		}
+		return hist_field;
+	}
+
 	s = strchr(str, '.');
 	if (s) {
 		s = strchr(++s, '.');
@@ -4950,6 +5021,8 @@ static void hist_field_debug_show_flags(struct seq_file *m,
 
 	if (flags & HIST_FIELD_FL_ALIAS)
 		seq_puts(m, "        HIST_FIELD_FL_ALIAS\n");
+	else if (flags & HIST_FIELD_FL_CONST)
+		seq_puts(m, "        HIST_FIELD_FL_CONST\n");
 }
 
 static int hist_field_debug_show(struct seq_file *m,
@@ -4971,6 +5044,9 @@ static int hist_field_debug_show(struct seq_file *m,
 			   field->var.idx);
 	}
 
+	if (field->flags & HIST_FIELD_FL_CONST)
+		seq_printf(m, "      constant: %llu\n", field->constant);
+
 	if (field->flags & HIST_FIELD_FL_ALIAS)
 		seq_printf(m, "      var_ref_idx (into hist_data->var_refs[]): %u\n",
 			   field->var_ref_idx);
@@ -5213,6 +5289,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 
 	if (hist_field->flags & HIST_FIELD_FL_CPU)
 		seq_puts(m, "common_cpu");
+	else if (hist_field->flags & HIST_FIELD_FL_CONST)
+		seq_printf(m, "%llu", hist_field->constant);
 	else if (field_name) {
 		if (hist_field->flags & HIST_FIELD_FL_VAR_REF ||
 		    hist_field->flags & HIST_FIELD_FL_ALIAS)
-- 
2.33.0.309.g3052b89438-goog

