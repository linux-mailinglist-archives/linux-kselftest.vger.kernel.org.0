Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD6C43A320
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhJYT40 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 15:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239234AbhJYTyY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 15:54:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648D7C110F12
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 12:23:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s7-20020a25aa07000000b005bfb84d2315so19073715ybi.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=loxzsYhDjTebX67ME+FCIKC4vQSRTq2WjXhQBNyrLj8=;
        b=RJoFoecv8w3cy7UeAFaKPMZCZ47mxIugAnyZXHWGVlgWk5lDlGL5Oi/stF8Xv4HcIS
         7v21WcAkL9URcnMQ/zKB+cDssX6yLDBCNwxl2k0eH9vefctFha+C/jPnST2BmPEIqu22
         hC8+WyFfVBA+zWncFrrSoTCul45BPOwXn+ec1GiAGlTgsibhGCMNpjRbxgwVStV3odlW
         zNu4lb4Uj1y4aPs86mb30zzCvqGIzplH2UUco56oWJRO/CwgU/CPXHYBeCjcENNm/Z64
         qrZ5AjbyC42ByDdWnxWmeHIwnjd0ybw9j4efBSxC9++CS1yZNWwSUCpli8ooCOwmWilP
         o6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=loxzsYhDjTebX67ME+FCIKC4vQSRTq2WjXhQBNyrLj8=;
        b=niotkM8rgMKHa6cmOfKfVY7wZSDlGwM3fdkbb9zk8XbmGzIZSshhkalo+wE5yqLzfF
         WXBrPA4VIKkUEJz80/nN5UHjNFtGUcTaN4E9j/15p73DnhBmFxGV8OTqwNV3sf1lATQ7
         7AUtv0SLHJqSpEH0ZGh9En92hAyZxT5PJsZlw19GJBjoaU/EWWYsxgMHbjA9mMcohkui
         QKQ8afeA5KgeOszLqzaBJHE7DarQwXXGRetCChbcAweILrww0ZBFkG1t9edwv72TiMEn
         QKjN+jkdx+NYQ4+ARpXT6IlIqS7lPwgF42far6PYn2ynccruxZM/iZvkup014aI/X3Sw
         vetQ==
X-Gm-Message-State: AOAM533+sDlZWWIQraK9zl57SzkM8DsOKYyMiOd9sxFmZ4Fn2AIJuk/3
        pNdZOsAQq5A4KSK4scgk0q4M7geg2i3I/K1CMg==
X-Google-Smtp-Source: ABdhPJydJvl3PC03wLHBI/sDcDMdjPhmIoqIJeNbRR3IGq1cA8fGfxZtEiuFMiAWHLE1skqG2pTkYV1aYIAcDKhP0g==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b783:5702:523e:d435])
 (user=kaleshsingh job=sendgmr) by 2002:a25:f50b:: with SMTP id
 a11mr17568377ybe.241.1635189831607; Mon, 25 Oct 2021 12:23:51 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:23:12 -0700
In-Reply-To: <20211025192330.2992076-1-kaleshsingh@google.com>
Message-Id: <20211025192330.2992076-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211025192330.2992076-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 1/8] tracing: Add support for creating hist trigger
 variables from literal
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

Constants can be used with division/multiplication (added in the
next patch in this series) to implement granularity filters for frequent
trace events. For instance we can limit emitting the rss_stat
trace event to when there is a 512KB cross over in the rss size:

  # Create a synthetic event to monitor instead of the high frequency
  # rss_stat event
  echo 'rss_stat_throttled unsigned int mm_id; unsigned int curr;
	int member; long size' >> tracing/synthetic_events

  # Create a hist trigger that emits the synthetic rss_stat_throttled
  # event only when the rss size crosses a 512KB boundary.
  echo 'hist:keys=keys=mm_id,member:bucket=size/0x80000:onchange($bucket)
      .rss_stat_throttled(mm_id,curr,member,size)'
        >> events/kmem/rss_stat/trigger

A use case for using constants with addition/subtraction is not yet
known, but for completeness the use of constants are supported for all
operators.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Change-Id: I142121d28dc3475dfbc3a882e7b2368d833474eb
---

Changes in v3:
  - Remove the limit on the number of constants that can be created,
    per Steven Rostedt

Changes in v2:
  - Add description of use case for constants in arithmetic
    operations in commit message, per Steven Rostedt
  - Add Namhyung's Reviewed-by

 kernel/trace/trace_events_hist.c | 71 +++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f01e442716e2..28f711224944 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -66,7 +66,8 @@
 	C(EMPTY_SORT_FIELD,	"Empty sort field"),			\
 	C(TOO_MANY_SORT_FIELDS,	"Too many sort fields (Max = 2)"),	\
 	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),	\
-	C(INVALID_STR_OPERAND,	"String type can not be an operand in expression"),
+	C(INVALID_STR_OPERAND,	"String type can not be an operand in expression"), \
+	C(EXPECT_NUMBER,	"Expecting numeric literal"),
 
 #undef C
 #define C(a, b)		HIST_ERR_##a
@@ -89,6 +90,7 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field,
 #define HIST_FIELD_OPERANDS_MAX	2
 #define HIST_FIELDS_MAX		(TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
 #define HIST_ACTIONS_MAX	8
+#define HIST_CONST_DIGITS_MAX	21
 
 enum field_op_id {
 	FIELD_OP_NONE,
@@ -152,6 +154,9 @@ struct hist_field {
 	bool                            read_once;
 
 	unsigned int			var_str_idx;
+
+	/* Numeric literals are represented as u64 */
+	u64				constant;
 };
 
 static u64 hist_field_none(struct hist_field *field,
@@ -163,6 +168,15 @@ static u64 hist_field_none(struct hist_field *field,
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
@@ -341,6 +355,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_CPU		= 1 << 15,
 	HIST_FIELD_FL_ALIAS		= 1 << 16,
 	HIST_FIELD_FL_BUCKET		= 1 << 17,
+	HIST_FIELD_FL_CONST		= 1 << 18,
 };
 
 struct var_defs {
@@ -1516,6 +1531,12 @@ static void expr_field_str(struct hist_field *field, char *expr)
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
 
@@ -1689,6 +1710,15 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
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
@@ -2090,6 +2120,29 @@ static struct hist_field *create_alias(struct hist_trigger_data *hist_data,
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
+
+	return field;
+}
+
 static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 				     struct trace_event_file *file, char *str,
 				     unsigned long *flags, char *var_name)
@@ -2100,6 +2153,15 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
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
@@ -4950,6 +5012,8 @@ static void hist_field_debug_show_flags(struct seq_file *m,
 
 	if (flags & HIST_FIELD_FL_ALIAS)
 		seq_puts(m, "        HIST_FIELD_FL_ALIAS\n");
+	else if (flags & HIST_FIELD_FL_CONST)
+		seq_puts(m, "        HIST_FIELD_FL_CONST\n");
 }
 
 static int hist_field_debug_show(struct seq_file *m,
@@ -4971,6 +5035,9 @@ static int hist_field_debug_show(struct seq_file *m,
 			   field->var.idx);
 	}
 
+	if (field->flags & HIST_FIELD_FL_CONST)
+		seq_printf(m, "      constant: %llu\n", field->constant);
+
 	if (field->flags & HIST_FIELD_FL_ALIAS)
 		seq_printf(m, "      var_ref_idx (into hist_data->var_refs[]): %u\n",
 			   field->var_ref_idx);
@@ -5213,6 +5280,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 
 	if (hist_field->flags & HIST_FIELD_FL_CPU)
 		seq_puts(m, "common_cpu");
+	else if (hist_field->flags & HIST_FIELD_FL_CONST)
+		seq_printf(m, "%llu", hist_field->constant);
 	else if (field_name) {
 		if (hist_field->flags & HIST_FIELD_FL_VAR_REF ||
 		    hist_field->flags & HIST_FIELD_FL_ALIAS)
-- 
2.33.0.1079.g6e70778dc9-goog

