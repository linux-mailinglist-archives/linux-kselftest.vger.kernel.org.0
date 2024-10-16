Return-Path: <linux-kselftest+bounces-19840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239FC9A07C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01AE289116
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9842071FE;
	Wed, 16 Oct 2024 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYvgApve"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8B20514B;
	Wed, 16 Oct 2024 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075768; cv=none; b=gxBQuJ+k3u8G333LyshfTiiBYr9bhGXsnSiLPdOOd4CRB6XlRjapLYIm7G+3CDI8H+Xama2yHLTW7qQ8hWTGAYrZ7vlr+qmVtkpWDa5LSXnNST+1tj34Xe8PxYi6JX0TWY7BgZKKAvnj2bhplZSPNDPsKlGjhjo4Pig5UaqWMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075768; c=relaxed/simple;
	bh=EFt2YqSmM2kHiH7ygo+ZURxSXzlTYOn0haPNawBOZTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hW9scvwpwdbG9aGX1vHWFsYdYXsjss0wmqkcnhgW4MNu1VXsOy3OtR9HQeSzdZ1KSH8ZgfMroBBYKmlnRcOTV9Ff7swPxp6wcxYP2NKRv6/AQkDj5s7EfNuFpfa1JixqN/V0dDiF92SRkvy7VUKU0bqu/eqCBlBv967GBMx/GG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYvgApve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F102C4CECD;
	Wed, 16 Oct 2024 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729075768;
	bh=EFt2YqSmM2kHiH7ygo+ZURxSXzlTYOn0haPNawBOZTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYvgApveNGA2j826YMumZFHPWPXbz+9rmLbpfgO1Fd/KvA/bd+gD7aOpoGX9mmQiN
	 O5CyuE49p3QxhTrhLMb/+Vi7yOH6bXrUoQ5E2iq+7bEfIB3+KCUkgtg4Hw6zuocqQq
	 9tNCuE8AOIui6N02Z3JNtA2I2dY4KKNIAvHsf6+degd323/YY1+zBIetRFGTDuvmZ1
	 YxCZ8VOwwk1PMuBasNG6trJJhgZyXwVORLYXG2ao6iYb71n0+C9HlZUZQMH3n8Urbb
	 Yt+DMPXLp+eG8maKFCFucYvd0L94oRkCXf9CB0j7CLRJwboCA8o5rU82dcuKgXyVEd
	 +F67qHOxToMAg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 1/3] tracing/hist: Add poll(POLLIN) support on hist file
Date: Wed, 16 Oct 2024 19:49:24 +0900
Message-ID:  <172907576461.470540.1954983717302445787.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To:  <172907575534.470540.12941248697563459082.stgit@mhiramat.roam.corp.google.com>
References:  <172907575534.470540.12941248697563459082.stgit@mhiramat.roam.corp.google.com>
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
 Changes in v6:
   - Use a global poll irq_work and wait_queue.
---
 include/linux/trace_events.h     |   14 +++++++
 kernel/trace/trace_events.c      |   14 +++++++
 kernel/trace/trace_events_hist.c |   75 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 42bedcddd511..46c771a61f2a 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -685,6 +685,20 @@ struct trace_event_file {
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
index 7266ec2a4eea..0a7cb30043ef 100644
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
index 5f9119eb7c67..107eaa0f40f1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5314,6 +5314,8 @@ static void event_hist_trigger(struct event_trigger_data *data,
 
 	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
 		hist_trigger_actions(hist_data, elt, buffer, rec, rbe, key, var_ref_vals);
+
+	hist_poll_wakeup();
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -5593,15 +5595,36 @@ static void hist_trigger_show(struct seq_file *m,
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
@@ -5611,6 +5634,7 @@ static int hist_show(struct seq_file *m, void *v)
 		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
 			hist_trigger_show(m, data, n++);
 	}
+	hist_file->last_read = get_hist_hit_count(event_file);
 
  out_unlock:
 	mutex_unlock(&event_mutex);
@@ -5618,24 +5642,69 @@ static int hist_show(struct seq_file *m, void *v)
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
+	hist_poll_wait(file, wait);
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


