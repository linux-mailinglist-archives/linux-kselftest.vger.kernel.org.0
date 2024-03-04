Return-Path: <linux-kselftest+bounces-5811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A575486F904
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 04:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05ABF281392
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 03:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A7613A;
	Mon,  4 Mar 2024 03:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cppd5zti"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05349522D;
	Mon,  4 Mar 2024 03:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523660; cv=none; b=IOGgSwsZMe4hSwvA6BWVzBrSVqhg2/Ii43nyfUzCO3MyYugpzQ5VZJDyfMjbsiwUFviI+1EZjjsOJEo+QDK2bdaLn/sFrVZZonW6B7ko8vZkQV0KQV0W59d+e1ONPF0W6vH6wbb7O1qAHdu6Cb/7DYGBFZAnfhVhwP7DbmjGCBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523660; c=relaxed/simple;
	bh=xm8eNDqvHmVGlbVU4cCHv8Nn3II5JsS0sODOnfHfYpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emOHcIBj1rB1SeQJQdhTp4NezDJXj+IihaFExgnI8SUeDmKpWBHmRweDDPYmBBMdmRxIapyuz2jDCNa+NXaz1dvQabSCEBd8M9M9KsAi/2CZ+zdlrrhuXvi7LoxSvhTgqcAKPEYUe+yHrNf3Y8Vqzf9WsgWHxw+sKrlLK3FlNHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cppd5zti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9CEC433F1;
	Mon,  4 Mar 2024 03:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709523659;
	bh=xm8eNDqvHmVGlbVU4cCHv8Nn3II5JsS0sODOnfHfYpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cppd5ztiuMjeJEsLZp1EVk1ExWf95XSjzA6J0WwQ3hr4KP2WgqzKmEU9fZQj1qV0x
	 1MbZ/OeGdTYE47OXEZamxO2oyCjLxq1pIdvSNLrMdK7WTtgjLR+u70EpzEFCQ13YvK
	 8nwQYPAWgbw7K/d1or/Il9C+PhZyFBqmJRCExmNZdlrGDt3InthVEBAE/i2GlVO881
	 ftykt1nRXIXihLlJY+rI0O293mi0djEbJZZo2iSHP8MTEv59PmlCYvArRvhKa9POK7
	 5zCzjpQ+ZPtxn4CxtToXen5HWqrcqnd8/o3gGAfnSoPNNPh6GuI2l0yGEIwPndaly9
	 WrYtyVD/R0AFw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 6/8] tracing/probes: Support $argN in return probe (kprobe and fprobe)
Date: Mon,  4 Mar 2024 12:40:55 +0900
Message-Id: <170952365552.229804.224112990211602895.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170952359657.229804.14867636035660590574.stgit@devnote2>
References: <170952359657.229804.14867636035660590574.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Support accessing $argN in the return probe events. This will help users to
record entry data in function return (exit) event for simplfing the function
entry/exit information in one event, and record the result values (e.g.
allocated object/initialized object) at function exit.

For example, if we have a function `int init_foo(struct foo *obj, int param)`
sometimes we want to check how `obj` is initialized. In such case, we can
define a new return event like below;

 # echo 'r init_foo retval=$retval param=$arg2 field1=+0($arg1)' >> kprobe_events

Thus it records the function parameter `param` and its result `obj->field1`
(the dereference will be done in the function exit timing) value at once.

This also support fprobe, BTF args and'$arg*'. So if CONFIG_DEBUG_INFO_BTF
is enabled, we can trace both function parameters and the return value
by following command.

 # echo 'f target_function%return $arg* $retval' >> dynamic_events

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
   - Fix syntax error check selftests because now some syntax error
     will not happen.
 Changes in v2:
   - Update README message
---
 kernel/trace/trace.c                               |    1 
 kernel/trace/trace_eprobe.c                        |    6 -
 kernel/trace/trace_fprobe.c                        |   55 ++++--
 kernel/trace/trace_kprobe.c                        |   56 +++++-
 kernel/trace/trace_probe.c                         |  177 ++++++++++++++++++--
 kernel/trace/trace_probe.h                         |   28 +++
 kernel/trace/trace_probe_tmpl.h                    |   10 +
 kernel/trace/trace_uprobe.c                        |   12 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    2 
 10 files changed, 289 insertions(+), 62 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 516c585f5879..71a96decc276 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5755,6 +5755,7 @@ static const char readme_msg[] =
 	"\t           $stack<index>, $stack, $retval, $comm,\n"
 #endif
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
+	"\t     kernel return probes support: $retval, $arg<N>, $comm\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
 	"\t           symstr, <type>\\[<array-size>\\]\n"
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index eb72def7410f..b0e0ec85912e 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -390,8 +390,8 @@ static int get_eprobe_size(struct trace_probe *tp, void *rec)
 
 /* Note that we don't verify it, since the code does not come from user space */
 static int
-process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
-		   void *base)
+process_fetch_insn(struct fetch_insn *code, void *rec, void *edata,
+		   void *dest, void *base)
 {
 	unsigned long val;
 	int ret;
@@ -438,7 +438,7 @@ __eprobe_trace_func(struct eprobe_data *edata, void *rec)
 		return;
 
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
-	store_trace_args(&entry[1], &edata->ep->tp, rec, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &edata->ep->tp, rec, NULL, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
 }
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 5109650b0d82..4f4280815522 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2022 Google LLC.
  */
 #define pr_fmt(fmt)	"trace_fprobe: " fmt
+#include <asm/ptrace.h>
 
 #include <linux/fprobe.h>
 #include <linux/module.h>
@@ -129,8 +130,8 @@ static bool trace_fprobe_is_registered(struct trace_fprobe *tf)
  * from user space.
  */
 static int
-process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
-		   void *base)
+process_fetch_insn(struct fetch_insn *code, void *rec, void *edata,
+		   void *dest, void *base)
 {
 	struct pt_regs *regs = rec;
 	unsigned long val;
@@ -152,6 +153,9 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 	case FETCH_OP_ARG:
 		val = regs_get_kernel_argument(regs, code->param);
 		break;
+	case FETCH_OP_EDATA:
+		val = *(unsigned long *)((unsigned long)edata + code->offset);
+		break;
 #endif
 	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
 		code++;
@@ -184,7 +188,7 @@ __fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	dsize = __get_data_size(&tf->tp, regs);
+	dsize = __get_data_size(&tf->tp, regs, NULL);
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
 					   sizeof(*entry) + tf->tp.size + dsize);
@@ -194,7 +198,7 @@ __fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 	fbuffer.regs = regs;
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->ip = entry_ip;
-	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, regs, NULL, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
 }
@@ -211,10 +215,23 @@ fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 NOKPROBE_SYMBOL(fentry_trace_func);
 
 /* function exit handler */
+static int trace_fprobe_entry_handler(struct fprobe *fp, unsigned long entry_ip,
+				unsigned long ret_ip, struct pt_regs *regs,
+				void *entry_data)
+{
+	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
+
+	if (tf->tp.entry_arg)
+		store_trace_entry_data(entry_data, &tf->tp, regs);
+
+	return 0;
+}
+NOKPROBE_SYMBOL(trace_fprobe_entry_handler)
+
 static nokprobe_inline void
 __fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 		   unsigned long ret_ip, struct pt_regs *regs,
-		   struct trace_event_file *trace_file)
+		   void *entry_data, struct trace_event_file *trace_file)
 {
 	struct fexit_trace_entry_head *entry;
 	struct trace_event_buffer fbuffer;
@@ -227,7 +244,7 @@ __fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	dsize = __get_data_size(&tf->tp, regs);
+	dsize = __get_data_size(&tf->tp, regs, entry_data);
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
 					   sizeof(*entry) + tf->tp.size + dsize);
@@ -238,19 +255,19 @@ __fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->func = entry_ip;
 	entry->ret_ip = ret_ip;
-	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, regs, entry_data, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
 }
 
 static void
 fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
-		 unsigned long ret_ip, struct pt_regs *regs)
+		 unsigned long ret_ip, struct pt_regs *regs, void *entry_data)
 {
 	struct event_file_link *link;
 
 	trace_probe_for_each_link_rcu(link, &tf->tp)
-		__fexit_trace_func(tf, entry_ip, ret_ip, regs, link->file);
+		__fexit_trace_func(tf, entry_ip, ret_ip, regs, entry_data, link->file);
 }
 NOKPROBE_SYMBOL(fexit_trace_func);
 
@@ -269,7 +286,7 @@ static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
 	if (hlist_empty(head))
 		return 0;
 
-	dsize = __get_data_size(&tf->tp, regs);
+	dsize = __get_data_size(&tf->tp, regs, NULL);
 	__size = sizeof(*entry) + tf->tp.size + dsize;
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
@@ -280,7 +297,7 @@ static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
 
 	entry->ip = entry_ip;
 	memset(&entry[1], 0, dsize);
-	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, regs, NULL, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 	return 0;
@@ -289,7 +306,8 @@ NOKPROBE_SYMBOL(fentry_perf_func);
 
 static void
 fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
-		unsigned long ret_ip, struct pt_regs *regs)
+		unsigned long ret_ip, struct pt_regs *regs,
+		void *entry_data)
 {
 	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
 	struct fexit_trace_entry_head *entry;
@@ -301,7 +319,7 @@ fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
 	if (hlist_empty(head))
 		return;
 
-	dsize = __get_data_size(&tf->tp, regs);
+	dsize = __get_data_size(&tf->tp, regs, entry_data);
 	__size = sizeof(*entry) + tf->tp.size + dsize;
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
@@ -312,7 +330,7 @@ fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
 
 	entry->func = entry_ip;
 	entry->ret_ip = ret_ip;
-	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, regs, entry_data, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 }
@@ -343,10 +361,10 @@ static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
 
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
-		fexit_trace_func(tf, entry_ip, ret_ip, regs);
+		fexit_trace_func(tf, entry_ip, ret_ip, regs, entry_data);
 #ifdef CONFIG_PERF_EVENTS
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
-		fexit_perf_func(tf, entry_ip, ret_ip, regs);
+		fexit_perf_func(tf, entry_ip, ret_ip, regs, entry_data);
 #endif
 }
 NOKPROBE_SYMBOL(fexit_dispatcher);
@@ -1109,6 +1127,11 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 			goto error;	/* This can be -ENOMEM */
 	}
 
+	if (is_return && tf->tp.entry_arg) {
+		tf->fp.entry_handler = trace_fprobe_entry_handler;
+		tf->fp.entry_data_size = traceprobe_get_entry_data_size(&tf->tp);
+	}
+
 	ret = traceprobe_set_print_fmt(&tf->tp,
 			is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL);
 	if (ret < 0)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 843f13f839df..14099cc17fc9 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -740,6 +740,9 @@ static unsigned int number_of_same_symbols(char *func_name)
 	return ctx.count;
 }
 
+static int trace_kprobe_entry_handler(struct kretprobe_instance *ri,
+				      struct pt_regs *regs);
+
 static int __trace_kprobe_create(int argc, const char *argv[])
 {
 	/*
@@ -948,6 +951,11 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		if (ret)
 			goto error;	/* This can be -ENOMEM */
 	}
+	/* entry handler for kretprobe */
+	if (is_return && tk->tp.entry_arg) {
+		tk->rp.entry_handler = trace_kprobe_entry_handler;
+		tk->rp.data_size = traceprobe_get_entry_data_size(&tk->tp);
+	}
 
 	ptype = is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL;
 	ret = traceprobe_set_print_fmt(&tk->tp, ptype);
@@ -1303,8 +1311,8 @@ static const struct file_operations kprobe_profile_ops = {
 
 /* Note that we don't verify it, since the code does not come from user space */
 static int
-process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
-		   void *base)
+process_fetch_insn(struct fetch_insn *code, void *rec, void *edata,
+		   void *dest, void *base)
 {
 	struct pt_regs *regs = rec;
 	unsigned long val;
@@ -1329,6 +1337,9 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 	case FETCH_OP_ARG:
 		val = regs_get_kernel_argument(regs, code->param);
 		break;
+	case FETCH_OP_EDATA:
+		val = *(unsigned long *)((unsigned long)edata + code->offset);
+		break;
 #endif
 	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
 		code++;
@@ -1359,7 +1370,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	dsize = __get_data_size(&tk->tp, regs);
+	dsize = __get_data_size(&tk->tp, regs, NULL);
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
 					   sizeof(*entry) + tk->tp.size + dsize);
@@ -1368,7 +1379,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 
 	fbuffer.regs = regs;
 	entry->ip = (unsigned long)tk->rp.kp.addr;
-	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, NULL, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
 }
@@ -1384,6 +1395,31 @@ kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs)
 NOKPROBE_SYMBOL(kprobe_trace_func);
 
 /* Kretprobe handler */
+
+static int trace_kprobe_entry_handler(struct kretprobe_instance *ri,
+				      struct pt_regs *regs)
+{
+	struct kretprobe *rp = get_kretprobe(ri);
+	struct trace_kprobe *tk;
+
+	/*
+	 * There is a small chance that get_kretprobe(ri) returns NULL when
+	 * the kretprobe is unregister on another CPU between kretprobe's
+	 * trampoline_handler and this function.
+	 */
+	if (unlikely(!rp))
+		return -ENOENT;
+
+	tk = container_of(rp, struct trace_kprobe, rp);
+
+	/* store argument values into ri->data as entry data */
+	if (tk->tp.entry_arg)
+		store_trace_entry_data(ri->data, &tk->tp, regs);
+
+	return 0;
+}
+
+
 static nokprobe_inline void
 __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 		       struct pt_regs *regs,
@@ -1399,7 +1435,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	dsize = __get_data_size(&tk->tp, regs);
+	dsize = __get_data_size(&tk->tp, regs, ri->data);
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
 					   sizeof(*entry) + tk->tp.size + dsize);
@@ -1409,7 +1445,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	fbuffer.regs = regs;
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = get_kretprobe_retaddr(ri);
-	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, ri->data, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
 }
@@ -1557,7 +1593,7 @@ kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 	if (hlist_empty(head))
 		return 0;
 
-	dsize = __get_data_size(&tk->tp, regs);
+	dsize = __get_data_size(&tk->tp, regs, NULL);
 	__size = sizeof(*entry) + tk->tp.size + dsize;
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
@@ -1568,7 +1604,7 @@ kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 
 	entry->ip = (unsigned long)tk->rp.kp.addr;
 	memset(&entry[1], 0, dsize);
-	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, NULL, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 	return 0;
@@ -1593,7 +1629,7 @@ kretprobe_perf_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	if (hlist_empty(head))
 		return;
 
-	dsize = __get_data_size(&tk->tp, regs);
+	dsize = __get_data_size(&tk->tp, regs, ri->data);
 	__size = sizeof(*entry) + tk->tp.size + dsize;
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
@@ -1604,7 +1640,7 @@ kretprobe_perf_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = get_kretprobe_retaddr(ri);
-	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, ri->data, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 }
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 93f36f8a108e..217169de0920 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -594,6 +594,8 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 	return 0;
 }
 
+static int __store_entry_arg(struct trace_probe *tp, int argnum);
+
 static int parse_btf_arg(char *varname,
 			 struct fetch_insn **pcode, struct fetch_insn *end,
 			 struct traceprobe_parse_context *ctx)
@@ -618,11 +620,7 @@ static int parse_btf_arg(char *varname,
 		return -EOPNOTSUPP;
 	}
 
-	if (ctx->flags & TPARG_FL_RETURN) {
-		if (strcmp(varname, "$retval") != 0) {
-			trace_probe_log_err(ctx->offset, NO_BTFARG);
-			return -ENOENT;
-		}
+	if (ctx->flags & TPARG_FL_RETURN && !strcmp(varname, "$retval")) {
 		code->op = FETCH_OP_RETVAL;
 		/* Check whether the function return type is not void */
 		if (query_btf_context(ctx) == 0) {
@@ -654,11 +652,21 @@ static int parse_btf_arg(char *varname,
 		const char *name = btf_name_by_offset(ctx->btf, params[i].name_off);
 
 		if (name && !strcmp(name, varname)) {
-			code->op = FETCH_OP_ARG;
-			if (ctx->flags & TPARG_FL_TPOINT)
-				code->param = i + 1;
-			else
-				code->param = i;
+			if (tparg_is_function_entry(ctx->flags)) {
+				code->op = FETCH_OP_ARG;
+				if (ctx->flags & TPARG_FL_TPOINT)
+					code->param = i + 1;
+				else
+					code->param = i;
+			} else if (tparg_is_function_return(ctx->flags)) {
+				code->op = FETCH_OP_EDATA;
+				ret = __store_entry_arg(ctx->tp, i);
+				if (ret < 0) {
+					/* internal error */
+					return ret;
+				}
+				code->offset = ret;
+			}
 			tid = params[i].type;
 			goto found;
 		}
@@ -755,6 +763,110 @@ static int check_prepare_btf_string_fetch(char *typename,
 
 #endif
 
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+
+static int __store_entry_arg(struct trace_probe *tp, int argnum)
+{
+	struct probe_entry_arg *earg = tp->entry_arg;
+	bool match = false;
+	int i, offset;
+
+	if (!earg) {
+		earg = kzalloc(sizeof(*tp->entry_arg), GFP_KERNEL);
+		if (!earg)
+			return -ENOMEM;
+		earg->size = 2 * tp->nr_args + 1;
+		earg->code = kcalloc(earg->size, sizeof(struct fetch_insn),
+				     GFP_KERNEL);
+		if (!earg->code) {
+			kfree(earg);
+			return -ENOMEM;
+		}
+		/* Fill the code buffer with 'end' to simplify it */
+		for (i = 0; i < earg->size; i++)
+			earg->code[i].op = FETCH_OP_END;
+		tp->entry_arg = earg;
+	}
+
+	offset = 0;
+	for (i = 0; i < earg->size - 1; i++) {
+		switch (earg->code[i].op) {
+		case FETCH_OP_END:
+			earg->code[i].op = FETCH_OP_ARG;
+			earg->code[i].param = argnum;
+			earg->code[i + 1].op = FETCH_OP_ST_EDATA;
+			earg->code[i + 1].offset = offset;
+			return offset;
+		case FETCH_OP_ARG:
+			match = (earg->code[i].param == argnum);
+			break;
+		case FETCH_OP_ST_EDATA:
+			offset = earg->code[i].offset;
+			if (match)
+				return offset;
+			offset += sizeof(unsigned long);
+			break;
+		default:
+			break;
+		}
+	}
+	return -ENOSPC;
+}
+
+int traceprobe_get_entry_data_size(struct trace_probe *tp)
+{
+	struct probe_entry_arg *earg = tp->entry_arg;
+	int i, size = 0;
+
+	if (!earg)
+		return 0;
+
+	for (i = 0; i < earg->size; i++) {
+		switch (earg->code[i].op) {
+		case FETCH_OP_END:
+			goto out;
+		case FETCH_OP_ST_EDATA:
+			size = earg->code[i].offset + sizeof(unsigned long);
+			break;
+		default:
+			break;
+		}
+	}
+out:
+	return size;
+}
+
+void store_trace_entry_data(void *edata, struct trace_probe *tp, struct pt_regs *regs)
+{
+	struct probe_entry_arg *earg = tp->entry_arg;
+	unsigned long val;
+	int i;
+
+	if (!earg)
+		return;
+
+	for (i = 0; i < earg->size; i++) {
+		struct fetch_insn *code = &earg->code[i];
+
+		switch (code->op) {
+		case FETCH_OP_ARG:
+			val = regs_get_kernel_argument(regs, code->param);
+			break;
+		case FETCH_OP_ST_EDATA:
+			*(unsigned long *)((unsigned long)edata + code->offset) = val;
+			break;
+		case FETCH_OP_END:
+			goto end;
+		default:
+			break;
+		}
+	}
+end:
+	return;
+}
+NOKPROBE_SYMBOL(store_trace_entry_data)
+#endif
+
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
 
 /* Parse $vars. @orig_arg points '$', which syncs to @ctx->offset */
@@ -830,7 +942,7 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
 
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	len = str_has_prefix(arg, "arg");
-	if (len && tparg_is_function_entry(ctx->flags)) {
+	if (len) {
 		ret = kstrtoul(arg + len, 10, &param);
 		if (ret)
 			goto inval;
@@ -839,15 +951,29 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
 			err = TP_ERR_BAD_ARG_NUM;
 			goto inval;
 		}
+		param--; /* argN starts from 1, but internal arg[N] starts from 0 */
 
-		code->op = FETCH_OP_ARG;
-		code->param = (unsigned int)param - 1;
-		/*
-		 * The tracepoint probe will probe a stub function, and the
-		 * first parameter of the stub is a dummy and should be ignored.
-		 */
-		if (ctx->flags & TPARG_FL_TPOINT)
-			code->param++;
+		if (tparg_is_function_entry(ctx->flags)) {
+			code->op = FETCH_OP_ARG;
+			code->param = (unsigned int)param;
+			/*
+			 * The tracepoint probe will probe a stub function, and the
+			 * first parameter of the stub is a dummy and should be ignored.
+			 */
+			if (ctx->flags & TPARG_FL_TPOINT)
+				code->param++;
+		} else if (tparg_is_function_return(ctx->flags)) {
+			/* function entry argument access from return probe */
+			ret = __store_entry_arg(ctx->tp, param);
+			if (ret < 0)	/* This error should be an internal error */
+				return ret;
+
+			code->op = FETCH_OP_EDATA;
+			code->offset = ret;
+		} else {
+			err = TP_ERR_NOFENTRY_ARGS;
+			goto inval;
+		}
 		return 0;
 	}
 #endif
@@ -1037,7 +1163,8 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		break;
 	default:
 		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
-			if (!tparg_is_function_entry(ctx->flags)) {
+			if (!tparg_is_function_entry(ctx->flags) &&
+			    !tparg_is_function_return(ctx->flags)) {
 				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
 				return -EINVAL;
 			}
@@ -1423,6 +1550,7 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, const char *arg,
 	struct probe_arg *parg = &tp->args[i];
 	const char *body;
 
+	ctx->tp = tp;
 	body = strchr(arg, '=');
 	if (body) {
 		if (body - arg > MAX_ARG_NAME_LEN) {
@@ -1479,7 +1607,8 @@ static int argv_has_var_arg(int argc, const char *argv[], int *args_idx,
 		if (str_has_prefix(argv[i], "$arg")) {
 			trace_probe_log_set_index(i + 2);
 
-			if (!tparg_is_function_entry(ctx->flags)) {
+			if (!tparg_is_function_entry(ctx->flags) &&
+			    !tparg_is_function_return(ctx->flags)) {
 				trace_probe_log_err(0, NOFENTRY_ARGS);
 				return -EINVAL;
 			}
@@ -1802,6 +1931,12 @@ void trace_probe_cleanup(struct trace_probe *tp)
 	for (i = 0; i < tp->nr_args; i++)
 		traceprobe_free_probe_arg(&tp->args[i]);
 
+	if (tp->entry_arg) {
+		kfree(tp->entry_arg->code);
+		kfree(tp->entry_arg);
+		tp->entry_arg = NULL;
+	}
+
 	if (tp->event)
 		trace_probe_unlink(tp);
 }
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index ed8d1052f8a7..cef3a50628a3 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -92,6 +92,7 @@ enum fetch_op {
 	FETCH_OP_ARG,		/* Function argument : .param */
 	FETCH_OP_FOFFS,		/* File offset: .immediate */
 	FETCH_OP_DATA,		/* Allocated data: .data */
+	FETCH_OP_EDATA,		/* Entry data: .offset */
 	// Stage 2 (dereference) op
 	FETCH_OP_DEREF,		/* Dereference: .offset */
 	FETCH_OP_UDEREF,	/* User-space Dereference: .offset */
@@ -102,6 +103,7 @@ enum fetch_op {
 	FETCH_OP_ST_STRING,	/* String: .offset, .size */
 	FETCH_OP_ST_USTRING,	/* User String: .offset, .size */
 	FETCH_OP_ST_SYMSTR,	/* Kernel Symbol String: .offset, .size */
+	FETCH_OP_ST_EDATA,	/* Store Entry Data: .offset */
 	// Stage 4 (modify) op
 	FETCH_OP_MOD_BF,	/* Bitfield: .basesize, .lshift, .rshift */
 	// Stage 5 (loop) op
@@ -232,6 +234,11 @@ struct probe_arg {
 	const struct fetch_type	*type;	/* Type of this argument */
 };
 
+struct probe_entry_arg {
+	struct fetch_insn	*code;
+	unsigned int		size;	/* The entry data size */
+};
+
 struct trace_uprobe_filter {
 	rwlock_t		rwlock;
 	int			nr_systemwide;
@@ -253,6 +260,7 @@ struct trace_probe {
 	struct trace_probe_event	*event;
 	ssize_t				size;	/* trace entry size */
 	unsigned int			nr_args;
+	struct probe_entry_arg		*entry_arg;	/* This is only for return probe */
 	struct probe_arg		args[];
 };
 
@@ -355,6 +363,18 @@ int trace_probe_create(const char *raw_command, int (*createfn)(int, const char
 int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
 		 u8 *data, void *field);
 
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+int traceprobe_get_entry_data_size(struct trace_probe *tp);
+/* This is a runtime function to store entry data */
+void store_trace_entry_data(void *edata, struct trace_probe *tp, struct pt_regs *regs);
+#else /* !CONFIG_HAVE_FUNCTION_ARG_ACCESS_API */
+static inline int traceprobe_get_entry_data_size(struct trace_probe *tp)
+{
+	return 0;
+}
+#define store_trace_entry_data(edata, tp, regs) do { } while (0)
+#endif
+
 #define trace_probe_for_each_link(pos, tp)	\
 	list_for_each_entry(pos, &(tp)->event->files, list)
 #define trace_probe_for_each_link_rcu(pos, tp)	\
@@ -381,6 +401,11 @@ static inline bool tparg_is_function_entry(unsigned int flags)
 	return (flags & TPARG_FL_LOC_MASK) == (TPARG_FL_KERNEL | TPARG_FL_FENTRY);
 }
 
+static inline bool tparg_is_function_return(unsigned int flags)
+{
+	return (flags & TPARG_FL_LOC_MASK) == (TPARG_FL_KERNEL | TPARG_FL_RETURN);
+}
+
 struct traceprobe_parse_context {
 	struct trace_event_call *event;
 	/* BTF related parameters */
@@ -392,6 +417,7 @@ struct traceprobe_parse_context {
 	const struct btf_type *last_type;	/* Saved type */
 	u32 last_bitoffs;		/* Saved bitoffs */
 	u32 last_bitsize;		/* Saved bitsize */
+	struct trace_probe *tp;
 	unsigned int flags;
 	int offset;
 };
@@ -506,7 +532,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NO_BTFARG,		"This variable is not found at this probe point"),\
 	C(NO_BTF_ENTRY,		"No BTF entry for this probe point"),	\
 	C(BAD_VAR_ARGS,		"$arg* must be an independent parameter without name etc."),\
-	C(NOFENTRY_ARGS,	"$arg* can be used only on function entry"),	\
+	C(NOFENTRY_ARGS,	"$arg* can be used only on function entry or exit"),	\
 	C(DOUBLE_ARGS,		"$arg* can be used only once in the parameters"),	\
 	C(ARGS_2LONG,		"$arg* failed because the argument list is too long"),	\
 	C(ARGIDX_2BIG,		"$argN index is too big"),		\
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 3935b347f874..2caf0d2afb32 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -54,7 +54,7 @@ fetch_apply_bitfield(struct fetch_insn *code, void *buf)
  * If dest is NULL, don't store result and return required dynamic data size.
  */
 static int
-process_fetch_insn(struct fetch_insn *code, void *rec,
+process_fetch_insn(struct fetch_insn *code, void *rec, void *edata,
 		   void *dest, void *base);
 static nokprobe_inline int fetch_store_strlen(unsigned long addr);
 static nokprobe_inline int
@@ -232,7 +232,7 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 
 /* Sum up total data length for dynamic arrays (strings) */
 static nokprobe_inline int
-__get_data_size(struct trace_probe *tp, struct pt_regs *regs)
+__get_data_size(struct trace_probe *tp, struct pt_regs *regs, void *edata)
 {
 	struct probe_arg *arg;
 	int i, len, ret = 0;
@@ -240,7 +240,7 @@ __get_data_size(struct trace_probe *tp, struct pt_regs *regs)
 	for (i = 0; i < tp->nr_args; i++) {
 		arg = tp->args + i;
 		if (unlikely(arg->dynamic)) {
-			len = process_fetch_insn(arg->code, regs, NULL, NULL);
+			len = process_fetch_insn(arg->code, regs, edata, NULL, NULL);
 			if (len > 0)
 				ret += len;
 		}
@@ -251,7 +251,7 @@ __get_data_size(struct trace_probe *tp, struct pt_regs *regs)
 
 /* Store the value of each argument */
 static nokprobe_inline void
-store_trace_args(void *data, struct trace_probe *tp, void *rec,
+store_trace_args(void *data, struct trace_probe *tp, void *rec, void *edata,
 		 int header_size, int maxlen)
 {
 	struct probe_arg *arg;
@@ -266,7 +266,7 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
 		/* Point the dynamic data area if needed */
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
-		ret = process_fetch_insn(arg->code, rec, dl, base);
+		ret = process_fetch_insn(arg->code, rec, edata, dl, base);
 		if (arg->dynamic && likely(ret > 0)) {
 			dyndata += ret;
 			maxlen -= ret;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 796ebcae9b38..9e461362450a 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -211,8 +211,8 @@ static unsigned long translate_user_vaddr(unsigned long file_offset)
 
 /* Note that we don't verify it, since the code does not come from user space */
 static int
-process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
-		   void *base)
+process_fetch_insn(struct fetch_insn *code, void *rec, void *edata,
+		   void *dest, void *base)
 {
 	struct pt_regs *regs = rec;
 	unsigned long val;
@@ -1490,11 +1490,11 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	dsize = __get_data_size(&tu->tp, regs);
+	dsize = __get_data_size(&tu->tp, regs, NULL);
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
 	ucb = uprobe_buffer_get();
-	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
+	store_trace_args(ucb->buf, &tu->tp, regs, NULL, esize, dsize);
 
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
 		ret |= uprobe_trace_func(tu, regs, ucb, dsize);
@@ -1525,11 +1525,11 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	dsize = __get_data_size(&tu->tp, regs);
+	dsize = __get_data_size(&tu->tp, regs, NULL);
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
 	ucb = uprobe_buffer_get();
-	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
+	store_trace_args(ucb->buf, &tu->tp, regs, NULL, esize, dsize);
 
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
 		uretprobe_trace_func(tu, func, regs, ucb, dsize);
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 20e42c030095..61877d166451 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -34,7 +34,9 @@ check_error 'f vfs_read ^$stack10000'	# BAD_STACK_NUM
 
 check_error 'f vfs_read ^$arg10000'	# BAD_ARG_NUM
 
+if !grep -q 'kernel return probes support:' README; then
 check_error 'f vfs_read $retval ^$arg1' # BAD_VAR
+fi
 check_error 'f vfs_read ^$none_var'	# BAD_VAR
 check_error 'f vfs_read ^'$REG		# BAD_VAR
 
@@ -99,7 +101,9 @@ if grep -q "<argname>" README; then
 check_error 'f vfs_read args=^$arg*'		# BAD_VAR_ARGS
 check_error 'f vfs_read +0(^$arg*)'		# BAD_VAR_ARGS
 check_error 'f vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
+if !grep -q 'kernel return probes support:' README; then
 check_error 'f vfs_read%return ^$arg*'		# NOFENTRY_ARGS
+fi
 check_error 'f vfs_read ^hoge'			# NO_BTFARG
 check_error 'f kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
 check_error 'f kfree%return ^$retval'		# NO_RETVAL
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 65fbb26fd58c..a16c6a6f6055 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -108,7 +108,9 @@ if grep -q "<argname>" README; then
 check_error 'p vfs_read args=^$arg*'		# BAD_VAR_ARGS
 check_error 'p vfs_read +0(^$arg*)'		# BAD_VAR_ARGS
 check_error 'p vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
+if !grep -q 'kernel return probes support:' README; then
 check_error 'r vfs_read ^$arg*'			# NOFENTRY_ARGS
+fi
 check_error 'p vfs_read+8 ^$arg*'		# NOFENTRY_ARGS
 check_error 'p vfs_read ^hoge'			# NO_BTFARG
 check_error 'p kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)


