Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1E255AE4E
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jun 2022 05:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiFZC47 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 22:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiFZC46 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 22:56:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D6813E97;
        Sat, 25 Jun 2022 19:56:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o18so5362604plg.2;
        Sat, 25 Jun 2022 19:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1xFp3YccCABYdb/qSiAbIbYGz64YunMLfgN9dTWOVPs=;
        b=neafXIA+Tvwh+05RT47jIllowolww82eol4Cw/D88GzfLp68GjYSjM/cS19gTeg1nu
         Z/JrL+upJTJcymS7Ip9dqWQo2maptHDkROsElvgU+etHzsBe1yrtiIPNMQ01aG2jgNhN
         0Q0EghMx5pbRa3GWDtOJi5jPKXiRmY8m5dEWaXcnvXOR+1KX9ipHJeBI3lBEtG+j6izz
         FXqS1ZyAGGlsGzG2e6hoH6l2G4IcypagQUV2Ez3vJvWSY1BlT1UtT8hvdOkRrjQbU/2y
         a6YiHDsDS3j+3x3Xyljy5l911JTatZbW7Mom/CQoY6XK2EGRHLnsfqGu7QLzVY7tG1mY
         /Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xFp3YccCABYdb/qSiAbIbYGz64YunMLfgN9dTWOVPs=;
        b=CARKqGJ+DBFpPVXBaNVSzeUYrMydkL1IQGgXjAGcDcKTnF1kWHcRqGig3mu1WBhY+t
         O8V9jaGWCJ2QqJ9nxc1Ul3zB0PFHAWkWG9/XHGHYPFWF3uJsqW6tDek8mYfFSwU0tlcM
         rlMkvCCHqxdBxllGmkhj/OvIa/+7a/aIgSpWjxU2L8RImRwSxXdEkLtqEaQGOdGMpEai
         PA/QIrmXYTWRj2XVeWIp4i/T0aptD5XpEDsOUIPcgXuNq2Y78aHFbHqQDNSrDFq5Ruv/
         X1iQjyjLxpK9bPzso1qq6Mz4XhmhORLLRPhlnEMODA9E8Lb6kH7DjyenQIc6D5pTPoyI
         6T9g==
X-Gm-Message-State: AJIora8/rF9ef5HrB71Z0I+cDtyZZiUb3NsOo8yTL7oglgzXS2x9QRUG
        ptgexUObzP2kcATsSMOxjwU=
X-Google-Smtp-Source: AGRyM1veHMAUopHOCNcbgBFPlKkz0J/G+JMTePUfQRomN94x4ePSTvBaWVrVVq0Fws6cpeUUvHETLA==
X-Received: by 2002:a17:90b:3911:b0:1ec:bd65:a307 with SMTP id ob17-20020a17090b391100b001ecbd65a307mr7792538pjb.4.1656212217116;
        Sat, 25 Jun 2022 19:56:57 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id d15-20020a056a0024cf00b005258df7615bsm1607061pfv.0.2022.06.25.19.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 19:56:56 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
        chensong_2000@189.cn, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v13 2/4] trace/objtrace: Get the value of the object
Date:   Sun, 26 Jun 2022 10:56:02 +0800
Message-Id: <20220626025604.277413-3-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220626025604.277413-1-xiehuan09@gmail.com>
References: <20220626025604.277413-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Using objtrace trigger to get the value of the object which from the kernel
function parameter.

Syntax:
	objtrace:add:obj[,offset][:type][:count][if <filter>]

Usage:
	# echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
	# gdb vmlinux
	(gdb) p &(((struct bio *)0)->bi_iter.bi_size)
	$1 = (unsigned int *) 0x28
	# echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
		 p_bio_add_page_0/trigger
	# cat /test.txt

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 kernel/trace/trace.c         |   2 +-
 kernel/trace/trace_entries.h |   5 +-
 kernel/trace/trace_object.c  | 187 ++++++++++++++++++++++++++++++++---
 kernel/trace/trace_output.c  |   6 +-
 4 files changed, 181 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7074ad8bc1a0..37f5cbfa5347 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5628,7 +5628,7 @@ static const char readme_msg[] =
 	"\t            disable_hist:<system>:<event>\n"
 #endif
 #ifdef CONFIG_TRACE_OBJECT
-	"\t            objtrace:add:obj[:count][if <filter>]\n"
+	"\t            objtrace:add:obj[,offset][:type][:count][if <filter>]\n"
 #endif
 #ifdef CONFIG_STACKTRACE
 	"\t\t    stacktrace\n"
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index bb120d9498a9..2407c45a568c 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -413,8 +413,9 @@ FTRACE_ENTRY(object, trace_object_entry,
 		__field(	unsigned long,		ip		)
 		__field(	unsigned long,		parent_ip	)
 		__field(	unsigned long,		object		)
+		__field(	unsigned long,		value		)
 	),
 
-	F_printk(" %ps <-- %ps object:%lx\n",
-		 (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
+	F_printk(" %ps <-- %ps object:%lx value:%lx\n", (void *)__entry->ip,
+	       (void *)__entry->parent_ip, __entry->object, __entry->value)
 );
diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
index 19ec4b1c0186..611341abeb7c 100644
--- a/kernel/trace/trace_object.c
+++ b/kernel/trace/trace_object.c
@@ -16,8 +16,14 @@ static const int max_args_num = 6;
 static void exit_trace_object(struct trace_array *tr);
 static int init_trace_object(struct trace_array *tr);
 
+/*
+ * get the offset from the special object and
+ * the type size of the value
+ */
 struct object_instance {
 	void *obj;
+	int obj_offset;
+	int obj_value_type_size;
 	struct trace_array *tr;
 };
 
@@ -25,9 +31,23 @@ struct object_instance {
 struct objtrace_trigger_data {
 	struct ftrace_event_field *field;
 	char objtrace_cmd[OBJTRACE_CMD_LEN];
+	int obj_offset;
+	int obj_value_type_size;
 	struct trace_array *tr;
 };
 
+/* get the type size for the special object */
+struct objtrace_fetch_type {
+	char *name;
+	int type_size;
+};
+
+enum objattr {
+	OBJ_OFFSET,
+	OBJ_VAL_TYPE_SIZE,
+	MAX_OBJ_ATTR
+};
+
 /* objtrace data with fops and objtrace_instances */
 struct objtrace_data {
 	struct list_head head;
@@ -67,6 +87,35 @@ static bool object_exist(void *obj, struct trace_array *tr)
 	return false;
 }
 
+static int get_object_attr(void *obj, int objattr,
+		struct trace_array *tr, int *result)
+{
+	int i, max;
+	struct objtrace_data *obj_data;
+
+	obj_data = get_obj_data(tr);
+	if (!obj_data)
+		return -EINVAL;
+
+	max = READ_ONCE(obj_data->num_traced_obj);
+	smp_rmb();
+	for (i = 0; i < max; i++) {
+		if (obj_data->traced_obj[i].obj == obj) {
+			switch (objattr) {
+			case OBJ_OFFSET:
+				*result = obj_data->traced_obj[i].obj_offset;
+				return 0;
+			case OBJ_VAL_TYPE_SIZE:
+				*result = obj_data->traced_obj[i].obj_value_type_size;
+				return 0;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+	return -EINVAL;
+}
+
 static bool object_empty(struct trace_array *tr)
 {
 	struct objtrace_data *obj_data;
@@ -78,7 +127,8 @@ static bool object_empty(struct trace_array *tr)
 	return !READ_ONCE(obj_data->num_traced_obj);
 }
 
-static void set_trace_object(void *obj, struct trace_array *tr)
+static void set_trace_object(void *obj, int obj_offset,
+			int obj_value_type_size, struct trace_array *tr)
 {
 	unsigned long flags;
 	struct object_instance *obj_ins;
@@ -103,6 +153,8 @@ static void set_trace_object(void *obj, struct trace_array *tr)
 	}
 	obj_ins = &obj_data->traced_obj[READ_ONCE(obj_data->num_traced_obj)];
 	obj_ins->obj = obj;
+	obj_ins->obj_value_type_size = obj_value_type_size;
+	obj_ins->obj_offset = obj_offset;
 	obj_ins->tr = tr;
 	/* make sure the num_traced_obj update always appears after traced_obj update */
 	smp_wmb();
@@ -112,7 +164,7 @@ static void set_trace_object(void *obj, struct trace_array *tr)
 }
 
 static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
-				 unsigned long object, struct trace_array *tr)
+		unsigned long object, unsigned long value, struct trace_array *tr)
 {
 
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
@@ -129,10 +181,43 @@ static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
 	entry->ip                       = ip;
 	entry->parent_ip                = parent_ip;
 	entry->object			= object;
+	entry->value			= value;
 
 	trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
 }
 
+static inline long get_object_value(unsigned long *val, void *obj, int type_size)
+{
+	char tmp[sizeof(u64)];
+	long ret = 0;
+
+	ret = copy_from_kernel_nofault(tmp, obj, sizeof(tmp));
+	if (ret)
+		return ret;
+	switch (type_size) {
+	case 1: {
+		*val = (unsigned long)*(u8 *)tmp;
+		break;
+	}
+	case 2: {
+		*val = (unsigned long)*(u16 *)tmp;
+		break;
+	}
+	case 4: {
+		*val = (unsigned long)*(u32 *)tmp;
+		break;
+	}
+	case 8: {
+		*val = (unsigned long)*(u64 *)tmp;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void
 trace_object_events_call(unsigned long ip, unsigned long parent_ip,
 		struct ftrace_ops *op, struct ftrace_regs *fregs)
@@ -140,7 +225,8 @@ trace_object_events_call(unsigned long ip, unsigned long parent_ip,
 	struct pt_regs *pt_regs = ftrace_get_regs(fregs);
 	struct trace_array *tr = op->private;
 	struct trace_array_cpu *data;
-	unsigned long obj;
+	int ret, val_type_size, obj_offset;
+	unsigned long obj, val;
 	long disabled;
 	int cpu, n;
 
@@ -154,8 +240,21 @@ trace_object_events_call(unsigned long ip, unsigned long parent_ip,
 			goto out;
 		for (n = 0; n < max_args_num; n++) {
 			obj = regs_get_kernel_argument(pt_regs, n);
-			if (object_exist((void *)obj, tr))
-				submit_trace_object(ip, parent_ip, obj, tr);
+			if (object_exist((void *)obj, tr)) {
+				ret = get_object_attr((void *)obj, OBJ_OFFSET,
+						tr, &obj_offset);
+				if (unlikely(ret) < 0)
+					goto out;
+				ret = get_object_attr((void *)obj, OBJ_VAL_TYPE_SIZE,
+						tr, &val_type_size);
+				if (unlikely(ret) < 0)
+					goto out;
+				if (get_object_value(&val, (void *)(obj + obj_offset),
+							val_type_size))
+					continue;
+
+				submit_trace_object(ip, parent_ip, obj, val, tr);
+			}
 		/* The parameters of a function may match multiple objects */
 		}
 	}
@@ -176,9 +275,23 @@ trace_object_trigger(struct event_trigger_data *data,
 
 	field = obj_data->field;
 	memcpy(&obj, rec + field->offset, sizeof(obj));
-	set_trace_object(obj, tr);
+	/* set the offset from the special object and the type size of the value*/
+	set_trace_object(obj, obj_data->obj_offset,
+			obj_data->obj_value_type_size, tr);
 }
 
+static const struct objtrace_fetch_type objtrace_fetch_types[] = {
+	{"u8", 1},
+	{"x8", 1},
+	{"u16", 2},
+	{"x16", 2},
+	{"u32", 4},
+	{"x32", 4},
+	{"u64", 8},
+	{"x64", 8},
+	{NULL, 0},
+};
+
 static void
 trace_object_trigger_free(struct event_trigger_data *data)
 {
@@ -213,14 +326,25 @@ static int
 event_trigger_print(const char *name, struct seq_file *m,
 		void *data, char *filter_str, void *objtrace_data)
 {
+	int i;
 	long count = (long)data;
 	struct objtrace_trigger_data *obj_data = objtrace_data;
+	const char *value_type_name;
 
 	seq_puts(m, name);
 
 	seq_printf(m, ":%s", obj_data->objtrace_cmd);
 	seq_printf(m, ":%s", obj_data->field->name);
+	if (obj_data->obj_offset)
+		seq_printf(m, ",0x%x", obj_data->obj_offset);
 
+	for (i = 0; objtrace_fetch_types[i].name; i++) {
+		if (objtrace_fetch_types[i].type_size == obj_data->obj_value_type_size) {
+			value_type_name = objtrace_fetch_types[i].name;
+			break;
+		}
+	}
+	seq_printf(m, ":%s", value_type_name);
 	if (count == -1)
 		seq_puts(m, ":unlimited");
 	else
@@ -303,16 +427,18 @@ event_object_trigger_parse(struct event_command *cmd_ops,
 	struct event_trigger_data *trigger_data;
 	struct objtrace_trigger_data *obj_data;
 	struct ftrace_event_field *field;
-	char *objtrace_cmd, *arg;
-	char *param, *filter;
-	int ret;
+	char *objtrace_cmd, *obj;
+	char *param, *filter, *str, *type;
+	int ret, i, def_type_size, obj_value_type_size = 0;
+	char *tmp_saved_param;
+	long offset = 0;
 	bool remove;
 
 	remove = event_trigger_check_remove(glob);
 
 	/*
 	 * separate the param and the filter:
-	 * objtrace:add:OBJ[:COUNT] [if filter]
+	 * objtrace:add:OBJ[,OFFS][:TYPE][:COUNT] [if filter]
 	 */
 	ret = event_trigger_separate_filter(param_and_filter, &param, &filter, true);
 	if (ret)
@@ -324,11 +450,44 @@ event_object_trigger_parse(struct event_command *cmd_ops,
 		return -EINVAL;
 	}
 
-	arg = strsep(&param, ":");
-	if (!arg)
+	obj = strsep(&param, ":");
+	if (!obj)
 		return -EINVAL;
 
-	field = trace_find_event_field(file->event_call, arg);
+	str = strchr(obj, ',');
+	if (!str)
+		offset = 0;
+	else {
+		*str++ = '\0';
+		ret = kstrtol(str, 0, &offset);
+		if (ret)
+			return -EINVAL;
+	}
+	def_type_size = sizeof(void *);
+	if (!param) {
+		obj_value_type_size = def_type_size;
+		goto skip_get_type;
+	}
+	tmp_saved_param = param;
+	type = strsep(&param, ":");
+	if (!type)
+		obj_value_type_size = def_type_size;
+	/* if this is the trigger count */
+	else if (isdigit(type[0])) {
+		obj_value_type_size = def_type_size;
+		param = tmp_saved_param;
+	} else {
+		for (i = 0; objtrace_fetch_types[i].name; i++) {
+			if (strcmp(objtrace_fetch_types[i].name, type) == 0) {
+				obj_value_type_size = objtrace_fetch_types[i].type_size;
+				break;
+			}
+		}
+	}
+	if (!obj_value_type_size)
+		return -EINVAL;
+skip_get_type:
+	field = trace_find_event_field(file->event_call, obj);
 	if (!field)
 		return -EINVAL;
 
@@ -345,6 +504,8 @@ event_object_trigger_parse(struct event_command *cmd_ops,
 		return -ENOMEM;
 
 	obj_data->field = field;
+	obj_data->obj_offset = offset;
+	obj_data->obj_value_type_size = obj_value_type_size;
 	obj_data->tr = file->tr;
 	snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN, objtrace_cmd);
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 34ff7b4dc521..a45871b52dcc 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1561,6 +1561,7 @@ static enum print_line_t trace_object_print(struct trace_iterator *iter, int fla
 	trace_assign_type(field, iter->ent);
 	print_fn_trace(s, field->ip, field->parent_ip, flags);
 	trace_seq_printf(s, " object:0x%lx", field->object);
+	trace_seq_printf(s, " value:0x%lx", field->value);
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
@@ -1573,9 +1574,8 @@ static enum print_line_t trace_object_raw(struct trace_iterator *iter, int flags
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(&iter->seq, "%lx %lx\n",
-			 field->ip,
-			 field->parent_ip);
+	trace_seq_printf(&iter->seq, "%lx %lx %lx %lx\n", field->ip,
+			field->parent_ip, field->object, field->value);
 
 	return trace_handle_return(&iter->seq);
 }
-- 
2.25.1

