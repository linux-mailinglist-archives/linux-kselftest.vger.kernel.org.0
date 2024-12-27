Return-Path: <linux-kselftest+bounces-23766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 048FF9FCFFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 05:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4AD188368B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 04:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E62C70819;
	Fri, 27 Dec 2024 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYoAEBwB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9CC524B4;
	Fri, 27 Dec 2024 04:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735272482; cv=none; b=WE01zbhQuP8wAzPu9KD+r4HmJ1INfB/CaYLm/Nt5jI/jKaUXPYHbEyuk+A0WJnwDSVLMa7JZyRm97dkJifvxZKc+gaZD9hLU7Qz3ZlQTcZYT+L6xcUMhfzKSXlTb6w0eJ1gbLAx8ix1w1+quOAj7yB+y2MBwmgAfb+HxkNRO0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735272482; c=relaxed/simple;
	bh=TchTdNcfedUw/CH++HJkkUKA69Xgwj9N7+N9n9Ihqtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSqqWIbmrfey6lZSly2jmA1+ws5WlF77Lpx/zukVOYHtUniK4qMYY7O/0iNyFOYNNvrPoxhKflVYhZf/Cj9RcF3AkNz/+m60GLbHo9OiOA9MYDWSnQl703dW0hTblQKF0OMf7219iJg8TUtjKJL1RqVYA/ivNsKjyVR/QwTuvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYoAEBwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB35C4CED0;
	Fri, 27 Dec 2024 04:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735272482;
	bh=TchTdNcfedUw/CH++HJkkUKA69Xgwj9N7+N9n9Ihqtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYoAEBwBsFc8nij8kIefT6ii85vYHWc27S3RYMDVIAmVuJGYi3vK2HLWqSP5yGobV
	 mfkY0xDm4GBP5PpDBHKefHnK9EJ+Dn8ki8TSfBNFnVeuzXlMU6TTIJ12ztNsKndcgd
	 mOu9BC/Zqz12Q6hKmJp9HfqXUeIMpT8C1mOD8jsSsTVoKvmiRQqXHbKpCIBpW50zSl
	 jvFUIF+sQqG2Fv4agtYfhyqYnIPmmL3jagxompeHP+0Foc7rE/vWgFD0G4dhvrDI4b
	 dMetRqNuMWPnRsPVATdACnyYWaMqWPA/RAhpy/JDXKx+2k/OmU1AurMs8EPiU5nU7S
	 48CdYEeiKqkzg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 1/3] tracing/hist: Add poll(POLLIN) support on hist file
Date: Fri, 27 Dec 2024 13:07:57 +0900
Message-ID: <173527247756.464571.14236296701625509931.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173527246726.464571.11533527581374142406.stgit@devnote2>
References: <173527246726.464571.11533527581374142406.stgit@devnote2>
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
But it is not a good idea to peek at the `trace` for an event that
randomly happens. And `trace_pipe` is not coming back until a page is
filled with events.

This allows a user to wait for a specific event on the `hist` file. User
can set a histogram trigger on the event which they want to monitor
and poll() on its `hist` file. Since this poll() returns POLLIN, the next
poll() will return soon unless a read() happens on that hist file.

NOTE: To read the hist file again, you must set the file offset to 0,
but just for monitoring the event, you may not need to read the
histogram.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
---
 Changes in v7:
   - Reword description according to Steve's comment.
   - Use guard() for mutex.
---
 include/linux/trace_events.h     |   14 ++++++++
 kernel/trace/trace_events.c      |   14 ++++++++
 kernel/trace/trace_events_hist.c |   69 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 2a5df5b62cfc..47caca4e7ff4 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -669,6 +669,20 @@ struct trace_event_file {
 	atomic_t		tm_ref;	/* trigger-mode reference counter */
 };
 
+#ifdef CONFIG_HIST_TRIGGERS
+extern struct irq_work hist_poll_work;
+extern wait_queue_head_t hist_poll_wq;
+
+static inline void hist_poll_wakeup(void)
+{
+	if (wq_has_sleeper(&hist_poll_wq))
+		irq_work_queue(&hist_poll_work);
+}
+
+#define hist_poll_wait(file, wait)	\
+	poll_wait(file, &hist_poll_wq, wait)
+#endif
+
 #define __TRACE_EVENT_FLAGS(name, value)				\
 	static int __init trace_init_flags_##name(void)			\
 	{								\
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 77e68efbd43e..e34b4a88d8ec 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2972,6 +2972,20 @@ static bool event_in_systems(struct trace_event_call *call,
 	return !*p || isspace(*p) || *p == ',';
 }
 
+#ifdef CONFIG_HIST_TRIGGERS
+/*
+ * Wake up waiter on the hist_poll_wq from irq_work because the hist trigger
+ * may happen in any context.
+ */
+static void hist_poll_event_irq_work(struct irq_work *work)
+{
+	wake_up_all(&hist_poll_wq);
+}
+
+DEFINE_IRQ_WORK(hist_poll_work, hist_poll_event_irq_work);
+DECLARE_WAIT_QUEUE_HEAD(hist_poll_wq);
+#endif
+
 static struct trace_event_file *
 trace_create_new_event(struct trace_event_call *call,
 		       struct trace_array *tr)
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9c058aa8baf3..e169f67c6088 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5311,6 +5311,8 @@ static void event_hist_trigger(struct event_trigger_data *data,
 
 	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
 		hist_trigger_actions(hist_data, elt, buffer, rec, rbe, key, var_ref_vals);
+
+	hist_poll_wakeup();
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -5590,15 +5592,36 @@ static void hist_trigger_show(struct seq_file *m,
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
@@ -5608,6 +5631,7 @@ static int hist_show(struct seq_file *m, void *v)
 		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
 			hist_trigger_show(m, data, n++);
 	}
+	hist_file->last_read = get_hist_hit_count(event_file);
 
  out_unlock:
 	mutex_unlock(&event_mutex);
@@ -5615,24 +5639,63 @@ static int hist_show(struct seq_file *m, void *v)
 	return ret;
 }
 
+static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct trace_event_file *event_file;
+	struct seq_file *m = file->private_data;
+	struct hist_file_data *hist_file = m->private;
+
+	guard(mutex)(&event_mutex);
+
+	event_file = event_file_data(file);
+	if (!event_file)
+		return EPOLLERR;
+
+	hist_poll_wait(file, wait);
+
+	if (hist_file->last_read != get_hist_hit_count(event_file))
+		return EPOLLIN | EPOLLRDNORM;
+
+	return 0;
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


