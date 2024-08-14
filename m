Return-Path: <linux-kselftest+bounces-15285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0339510E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 02:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1973A284584
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 00:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A235197;
	Wed, 14 Aug 2024 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPqaJ7QS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC222901;
	Wed, 14 Aug 2024 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723594288; cv=none; b=V/cu9Io0XakTZ+RBlBrrxXWj0fW/vbC3VQVgUXio7xUu3EH3/3EzLMY4q9mC8D9BPQguJndkiZZ60177GHzzVv/7R5KkbR8egdVeyA1ciPQpwRokfvEM/nT1ke/AFC4GkHOvWGDNV/3anSbFlrHEXfBuMdkwixyZdmMMig5wlQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723594288; c=relaxed/simple;
	bh=PduHRgfMp3qDtlIlUMaJZfdj3y/ud8IXpCM0H4jkdiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OX5EvUWesOToXE4Acc4B89JM3I0gTsM9wv15gQMPaFN0DpTpvB0AfMSAiumeZxrenbon/6VSJd4zoG5rXNuLsMrOYyNogY1kR7JnLNYQz5hOXPW0fe8E+tkFooiAlc1YeQ6Qck06BKYyWkwEy6Qe7X2EaJiOFx8HfP5vMBB093k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPqaJ7QS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96402C32782;
	Wed, 14 Aug 2024 00:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723594288;
	bh=PduHRgfMp3qDtlIlUMaJZfdj3y/ud8IXpCM0H4jkdiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPqaJ7QS3VOFcIlhjBGTAlFHglF/8UnBzdBS4p4m4a6LbNQlGVn3SCMnCMkJglj4t
	 hiMvjojhXt2yrmF6GEQDxyBO9s8/nGA7yZWoL1pcJiCKjZgWGf06y827RQqOxSuuzl
	 fbracmVx6cGaHdNSf6Ju26pttOQFP/DUM16ZGPgSZgjRc/jBgV5GGAZ+HC4LfTceYE
	 +CWV8KoMefcjI4v0QN0TOONGZ4ytaUg9I+FrBj7LxNG+cpyB3RueudwbdaCWmGtcXN
	 hNgv+RjRfUhPp2E93Bll/Yt00nzx1aWMHhWJIv06PW65zM13thjWtsJI9sAioAFLQ9
	 KAh7TlU5NlEkQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/3] tracing/hist: Add poll(POLLIN) support on hist file
Date: Wed, 14 Aug 2024 09:11:24 +0900
Message-Id: <172359428405.323666.13595084292942408031.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172359427367.323666.6446548762874507863.stgit@devnote2>
References: <172359427367.323666.6446548762874507863.stgit@devnote2>
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

Add poll syscall support on the `hist` file. The Waiter will be waken
up when the histogram is updated with POLLIN.

Currently, there is no way to wait for a specific event in userspace.
So user needs to peek the `trace` periodicaly, or wait on `trace_pipe`.
But that is not good idea to peek the `trace` for the event randomely
happens. And `trace_pipe` is not coming back until a page is filled
with events.

This allows user to wait for a specific events on `hist` file. User
can set a histogram trigger on the event which they want to monitor.
And poll() on its `hist` file. Since this poll() returns POLLIN,
the next poll() will return soon unless you do read() on hist file.

NOTE: To read the hist file again, you must set the file offset to 0,
but just for monitoring the event, you may not need to read the
histogram.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/trace_events.h     |    5 +++
 kernel/trace/trace_events.c      |   18 +++++++++
 kernel/trace/trace_events_hist.c |   76 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 42bedcddd511..f3ec67d34097 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -663,6 +663,11 @@ struct trace_event_file {
 	struct trace_subsystem_dir	*system;
 	struct list_head		triggers;
 
+#ifdef CONFIG_HIST_TRIGGERS
+	struct irq_work			hist_work;
+	wait_queue_head_t		hist_wq;
+#endif
+
 	/*
 	 * 32 bit flags:
 	 *   bit 0:		enabled
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7266ec2a4eea..0f077b32eea4 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2972,6 +2972,20 @@ static bool event_in_systems(struct trace_event_call *call,
 	return !*p || isspace(*p) || *p == ',';
 }
 
+#ifdef CONFIG_HIST_TRIGGERS
+/*
+ * Wake up waiter on the hist_wq from irq_work because the hist trigger
+ * may happen in any context.
+ */
+static void hist_event_irq_work(struct irq_work *work)
+{
+	struct trace_event_file *event_file;
+
+	event_file = container_of(work, struct trace_event_file, hist_work);
+	wake_up_all(&event_file->hist_wq);
+}
+#endif
+
 static struct trace_event_file *
 trace_create_new_event(struct trace_event_call *call,
 		       struct trace_array *tr)
@@ -3004,6 +3018,10 @@ trace_create_new_event(struct trace_event_call *call,
 	INIT_LIST_HEAD(&file->triggers);
 	list_add(&file->list, &tr->events);
 	refcount_set(&file->ref, 1);
+#ifdef CONFIG_HIST_TRIGGERS
+	init_irq_work(&file->hist_work, hist_event_irq_work);
+	init_waitqueue_head(&file->hist_wq);
+#endif
 
 	return file;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5f9119eb7c67..d27b60f54f68 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5314,6 +5314,9 @@ static void event_hist_trigger(struct event_trigger_data *data,
 
 	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
 		hist_trigger_actions(hist_data, elt, buffer, rec, rbe, key, var_ref_vals);
+
+	if (hist_data->event_file && wq_has_sleeper(&hist_data->event_file->hist_wq))
+		irq_work_queue(&hist_data->event_file->hist_work);
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -5593,15 +5596,36 @@ static void hist_trigger_show(struct seq_file *m,
 		   n_entries, (u64)atomic64_read(&hist_data->map->drops));
 }
 
+struct hist_file_data {
+	struct file *file;
+	u64 last_read;
+};
+
+static u64 get_hist_hit_count(struct trace_event_file *event_file)
+{
+	struct hist_trigger_data *hist_data;
+	struct event_trigger_data *data;
+	u64 ret = 0;
+
+	list_for_each_entry(data, &event_file->triggers, list) {
+		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			hist_data = data->private_data;
+			ret += atomic64_read(&hist_data->map->hits);
+		}
+	}
+	return ret;
+}
+
 static int hist_show(struct seq_file *m, void *v)
 {
+	struct hist_file_data *hist_file = m->private;
 	struct event_trigger_data *data;
 	struct trace_event_file *event_file;
 	int n = 0, ret = 0;
 
 	mutex_lock(&event_mutex);
 
-	event_file = event_file_file(m->private);
+	event_file = event_file_file(hist_file->file);
 	if (unlikely(!event_file)) {
 		ret = -ENODEV;
 		goto out_unlock;
@@ -5611,6 +5635,7 @@ static int hist_show(struct seq_file *m, void *v)
 		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
 			hist_trigger_show(m, data, n++);
 	}
+	hist_file->last_read = get_hist_hit_count(event_file);
 
  out_unlock:
 	mutex_unlock(&event_mutex);
@@ -5618,24 +5643,69 @@ static int hist_show(struct seq_file *m, void *v)
 	return ret;
 }
 
+static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct trace_event_file *event_file;
+	struct seq_file *m = file->private_data;
+	struct hist_file_data *hist_file = m->private;
+	__poll_t ret = 0;
+
+	mutex_lock(&event_mutex);
+
+	event_file = event_file_data(file);
+	if (!event_file) {
+		ret = EPOLLERR;
+		goto out_unlock;
+	}
+
+	poll_wait(file, &event_file->hist_wq, wait);
+
+	if (hist_file->last_read != get_hist_hit_count(event_file))
+		ret = EPOLLIN | EPOLLRDNORM;
+
+out_unlock:
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+static int event_hist_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct hist_file_data *hist_file = m->private;
+
+	kfree(hist_file);
+	return tracing_single_release_file_tr(inode, file);
+}
+
 static int event_hist_open(struct inode *inode, struct file *file)
 {
+	struct hist_file_data *hist_file;
 	int ret;
 
 	ret = tracing_open_file_tr(inode, file);
 	if (ret)
 		return ret;
 
+	hist_file = kzalloc(sizeof(*hist_file), GFP_KERNEL);
+	if (!hist_file)
+		return -ENOMEM;
+	hist_file->file = file;
+
 	/* Clear private_data to avoid warning in single_open() */
 	file->private_data = NULL;
-	return single_open(file, hist_show, file);
+	ret = single_open(file, hist_show, hist_file);
+	if (ret)
+		kfree(hist_file);
+	return ret;
 }
 
 const struct file_operations event_hist_fops = {
 	.open = event_hist_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = tracing_single_release_file_tr,
+	.release = event_hist_release,
+	.poll = event_hist_poll,
 };
 
 #ifdef CONFIG_HIST_TRIGGERS_DEBUG


