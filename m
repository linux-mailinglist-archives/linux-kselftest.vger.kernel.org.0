Return-Path: <linux-kselftest+bounces-23606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9980E9F7F9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 17:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441817A0652
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF039227BA3;
	Thu, 19 Dec 2024 16:23:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA6622759D;
	Thu, 19 Dec 2024 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625393; cv=none; b=Bl1bviThsH9in3a35yxmgNnrDXpN5TuoTPOumQerPatbB306aKYEa0Td9ThF2E3qVkVtobkNqaBc4NyLQP5nae44mkCdxcXW5LyDq9VTrZtfAxx5iIqHITIl7eLgd+WE50Pleke70bMen3UKIdlnOuG8KvO66n3DYCz+rQgo97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625393; c=relaxed/simple;
	bh=v/uQ42kP3ivcBKC/yGNZjNihyA2MLrCveiZNmwRz2l0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFU7OcpInvKrocEeTHoaOtKtJTlVvmwTEMh7iip4JZy89x7saeUguN0smTAWdbBViO0H6r8/ivB39y7iGFNZNbEIQa/S+2Qa+uoCbG9vkFD6LlKWwl2bL46ldJYF5tZuDx+Eb3SQ9LbcZcog6hlhxlUkAEGqsGVTKF8MGOYwi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADB9C4CED6;
	Thu, 19 Dec 2024 16:23:12 +0000 (UTC)
Date: Thu, 19 Dec 2024 11:23:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Tom Zanussi <zanussi@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/3] tracing/hist: Add poll(POLLIN) support on hist
 file
Message-ID: <20241219112352.5750dc80@gandalf.local.home>
In-Reply-To: <172907576461.470540.1954983717302445787.stgit@mhiramat.roam.corp.google.com>
References: <172907575534.470540.12941248697563459082.stgit@mhiramat.roam.corp.google.com>
	<172907576461.470540.1954983717302445787.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 19:49:24 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add poll syscall support on the `hist` file. The Waiter will be waken
> up when the histogram is updated with POLLIN.
> 
> Currently, there is no way to wait for a specific event in userspace.
> So user needs to peek the `trace` periodicaly, or wait on `trace_pipe`.


> But that is not good idea to peek the `trace` for the event randomely
> happens. And `trace_pipe` is not coming back until a page is filled
> with events.

I would reword the above to:

    But it is not a good idea to peek at the `trace` for an event that
    randomly happens. And `trace_pipe` is not coming back until a page is
    filled with events.

> 
> This allows user to wait for a specific events on `hist` file. User
> can set a histogram trigger on the event which they want to monitor.
> And poll() on its `hist` file. Since this poll() returns POLLIN,
> the next poll() will return soon unless you do read() on hist file.

And that to:

    This allows a user to wait for a specific event on the `hist` file. User
    can set a histogram trigger on the event which they want to monitor
    and poll() on its `hist` file. Since this poll() returns POLLIN, the next
    poll() will return soon unless a read() happens on that hist file.

> 
> NOTE: To read the hist file again, you must set the file offset to 0,
> but just for monitoring the event, you may not need to read the
> histogram.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Reviewed-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  Changes in v6:
>    - Use a global poll irq_work and wait_queue.
> ---
>  include/linux/trace_events.h     |   14 +++++++
>  kernel/trace/trace_events.c      |   14 +++++++
>  kernel/trace/trace_events_hist.c |   75 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 100 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 42bedcddd511..46c771a61f2a 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -685,6 +685,20 @@ struct trace_event_file {
>  	atomic_t		tm_ref;	/* trigger-mode reference counter */
>  };
>  
> +#ifdef CONFIG_HIST_TRIGGERS
> +extern struct irq_work hist_poll_work;
> +extern wait_queue_head_t hist_poll_wq;
> +
> +static inline void hist_poll_wakeup(void)
> +{
> +	if (wq_has_sleeper(&hist_poll_wq))
> +		irq_work_queue(&hist_poll_work);
> +}
> +
> +#define hist_poll_wait(file, wait)	\
> +	poll_wait(file, &hist_poll_wq, wait)
> +#endif
> +
>  #define __TRACE_EVENT_FLAGS(name, value)				\
>  	static int __init trace_init_flags_##name(void)			\
>  	{								\
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 7266ec2a4eea..0a7cb30043ef 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2972,6 +2972,20 @@ static bool event_in_systems(struct trace_event_call *call,
>  	return !*p || isspace(*p) || *p == ',';
>  }
>  
> +#ifdef CONFIG_HIST_TRIGGERS
> +/*
> + * Wake up waiter on the hist_poll_wq from irq_work because the hist trigger
> + * may happen in any context.
> + */
> +static void hist_poll_event_irq_work(struct irq_work *work)
> +{
> +	wake_up_all(&hist_poll_wq);
> +}
> +
> +DEFINE_IRQ_WORK(hist_poll_work, hist_poll_event_irq_work);
> +DECLARE_WAIT_QUEUE_HEAD(hist_poll_wq);
> +#endif
> +
>  static struct trace_event_file *
>  trace_create_new_event(struct trace_event_call *call,
>  		       struct trace_array *tr)
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 5f9119eb7c67..107eaa0f40f1 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5314,6 +5314,8 @@ static void event_hist_trigger(struct event_trigger_data *data,
>  
>  	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
>  		hist_trigger_actions(hist_data, elt, buffer, rec, rbe, key, var_ref_vals);
> +
> +	hist_poll_wakeup();
>  }
>  
>  static void hist_trigger_stacktrace_print(struct seq_file *m,
> @@ -5593,15 +5595,36 @@ static void hist_trigger_show(struct seq_file *m,
>  		   n_entries, (u64)atomic64_read(&hist_data->map->drops));
>  }
>  
> +struct hist_file_data {
> +	struct file *file;
> +	u64 last_read;
> +};
> +
> +static u64 get_hist_hit_count(struct trace_event_file *event_file)
> +{
> +	struct hist_trigger_data *hist_data;
> +	struct event_trigger_data *data;
> +	u64 ret = 0;
> +
> +	list_for_each_entry(data, &event_file->triggers, list) {
> +		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST) {
> +			hist_data = data->private_data;
> +			ret += atomic64_read(&hist_data->map->hits);
> +		}
> +	}
> +	return ret;
> +}
> +
>  static int hist_show(struct seq_file *m, void *v)
>  {
> +	struct hist_file_data *hist_file = m->private;
>  	struct event_trigger_data *data;
>  	struct trace_event_file *event_file;
>  	int n = 0, ret = 0;
>  
>  	mutex_lock(&event_mutex);
>  
> -	event_file = event_file_file(m->private);
> +	event_file = event_file_file(hist_file->file);
>  	if (unlikely(!event_file)) {
>  		ret = -ENODEV;
>  		goto out_unlock;
> @@ -5611,6 +5634,7 @@ static int hist_show(struct seq_file *m, void *v)
>  		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
>  			hist_trigger_show(m, data, n++);
>  	}
> +	hist_file->last_read = get_hist_hit_count(event_file);
>  
>   out_unlock:
>  	mutex_unlock(&event_mutex);
> @@ -5618,24 +5642,69 @@ static int hist_show(struct seq_file *m, void *v)
>  	return ret;
>  }
>  
> +static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wait)
> +{
> +	struct trace_event_file *event_file;
> +	struct seq_file *m = file->private_data;
> +	struct hist_file_data *hist_file = m->private;
> +	__poll_t ret = 0;
> +
> +	mutex_lock(&event_mutex);

Let's start using guard(mutex)(&event_mutex);

I'm working on changing the other locations in this file with a separate
patch. I don't want to add new ones.

-- Steve

> +
> +	event_file = event_file_data(file);
> +	if (!event_file) {
> +		ret = EPOLLERR;
> +		goto out_unlock;
> +	}
> +
> +	hist_poll_wait(file, wait);
> +
> +	if (hist_file->last_read != get_hist_hit_count(event_file))
> +		ret = EPOLLIN | EPOLLRDNORM;
> +
> +out_unlock:
> +	mutex_unlock(&event_mutex);
> +
> +	return ret;
> +}
> +
> +static int event_hist_release(struct inode *inode, struct file *file)
> +{
> +	struct seq_file *m = file->private_data;
> +	struct hist_file_data *hist_file = m->private;
> +
> +	kfree(hist_file);
> +	return tracing_single_release_file_tr(inode, file);
> +}
> +
>  static int event_hist_open(struct inode *inode, struct file *file)
>  {
> +	struct hist_file_data *hist_file;
>  	int ret;
>  
>  	ret = tracing_open_file_tr(inode, file);
>  	if (ret)
>  		return ret;
>  
> +	hist_file = kzalloc(sizeof(*hist_file), GFP_KERNEL);
> +	if (!hist_file)
> +		return -ENOMEM;
> +	hist_file->file = file;
> +
>  	/* Clear private_data to avoid warning in single_open() */
>  	file->private_data = NULL;
> -	return single_open(file, hist_show, file);
> +	ret = single_open(file, hist_show, hist_file);
> +	if (ret)
> +		kfree(hist_file);
> +	return ret;
>  }
>  
>  const struct file_operations event_hist_fops = {
>  	.open = event_hist_open,
>  	.read = seq_read,
>  	.llseek = seq_lseek,
> -	.release = tracing_single_release_file_tr,
> +	.release = event_hist_release,
> +	.poll = event_hist_poll,
>  };
>  
>  #ifdef CONFIG_HIST_TRIGGERS_DEBUG


