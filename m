Return-Path: <linux-kselftest+bounces-23607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EB99F7F9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 17:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5932A7A2850
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7E226881;
	Thu, 19 Dec 2024 16:25:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D86226182;
	Thu, 19 Dec 2024 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625510; cv=none; b=d3JUmzhE/c7bBR90UidACkw/59qr+YiJcUwwvjrQO2jiyYynBJkCbrjUVbkORdbqOb8jotw1QiJpCtn1KmJbkO6Qj1wCu+Ome3y5Msz9y8MWkyofr6BqbPauyELZS1giXCp09MXqasFkGZue0nZmUJJfBpQYFE6DLlWC6tKE30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625510; c=relaxed/simple;
	bh=C10guj747IMjasBGZPFtSpI5ZWmYbozpm2FiPIruGl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEpchVdvQLE6ETckmqM34FwlAjEa7VDbtkaeDbIqfe721S+3JnQSDTKXw/tQkQaBmYdZlStRwKQ5iEJFPEXbhAfYBduN82+4yWKBYJk3LIM6iof2ZppnAN0YhHiFOXy5G69sQGbysO0zYKgaBLgoJbD5n/5gqtpt5euCwj+iUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FEAC4CECE;
	Thu, 19 Dec 2024 16:25:08 +0000 (UTC)
Date: Thu, 19 Dec 2024 11:25:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Tom Zanussi <zanussi@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 2/3] tracing/hist: Support POLLPRI event for poll on
 histogram
Message-ID: <20241219112549.48307109@gandalf.local.home>
In-Reply-To: <172907577331.470540.11394819971376123947.stgit@mhiramat.roam.corp.google.com>
References: <172907575534.470540.12941248697563459082.stgit@mhiramat.roam.corp.google.com>
	<172907577331.470540.11394819971376123947.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 19:49:33 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since POLLIN will not be flashed until read the hist file, user needs
> to repeat read() and poll() on hist for monitoring the event
> continuously. But the read() is somewhat redundant only for monitoring
> events.
> 
> This add POLLPRI poll event on hist, this event returns when a histogram
> is updated after open(), poll() or read(). Thus it is possible to wait
> next event without read().

I would reword the above to:

    Since POLLIN will not be flushed until the hist file is read, the user
    needs to repeatedly read() and poll() on the hist file for monitoring the
    event continuously. But the read() is somewhat redundant when the user is
    only monitoring for event updates.
    
    Add POLLPRI poll event on the hist file so the event returns when a
    histogram is updated after open(), poll() or read(). Thus it is possible
    to wait for the next event without having to issue a read().

> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Reviewed-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace_events_hist.c |   29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 107eaa0f40f1..8819a8cc4d53 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5598,6 +5598,7 @@ static void hist_trigger_show(struct seq_file *m,
>  struct hist_file_data {
>  	struct file *file;
>  	u64 last_read;
> +	u64 last_act;
>  };
>  
>  static u64 get_hist_hit_count(struct trace_event_file *event_file)
> @@ -5635,6 +5636,11 @@ static int hist_show(struct seq_file *m, void *v)
>  			hist_trigger_show(m, data, n++);
>  	}
>  	hist_file->last_read = get_hist_hit_count(event_file);
> +	/*
> +	 * Update last_act too so that poll()/POLLPRI can wait for the next
> +	 * event after any syscall on hist file.
> +	 */
> +	hist_file->last_act = hist_file->last_read;
>  
>   out_unlock:
>  	mutex_unlock(&event_mutex);
> @@ -5648,6 +5654,7 @@ static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wai
>  	struct seq_file *m = file->private_data;
>  	struct hist_file_data *hist_file = m->private;
>  	__poll_t ret = 0;
> +	u64 cnt;
>  
>  	mutex_lock(&event_mutex);
>  
> @@ -5659,8 +5666,13 @@ static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wai
>  
>  	hist_poll_wait(file, wait);
>  
> -	if (hist_file->last_read != get_hist_hit_count(event_file))
> -		ret = EPOLLIN | EPOLLRDNORM;
> +	cnt = get_hist_hit_count(event_file);
> +	if (hist_file->last_read != cnt)
> +		ret |= EPOLLIN | EPOLLRDNORM;
> +	if (hist_file->last_act != cnt) {
> +		hist_file->last_act = cnt;
> +		ret |= EPOLLPRI;
> +	}
>  
>  out_unlock:
>  	mutex_unlock(&event_mutex);
> @@ -5679,6 +5691,7 @@ static int event_hist_release(struct inode *inode, struct file *file)
>  
>  static int event_hist_open(struct inode *inode, struct file *file)
>  {
> +	struct trace_event_file *event_file;
>  	struct hist_file_data *hist_file;
>  	int ret;
>  
> @@ -5689,13 +5702,25 @@ static int event_hist_open(struct inode *inode, struct file *file)
>  	hist_file = kzalloc(sizeof(*hist_file), GFP_KERNEL);
>  	if (!hist_file)
>  		return -ENOMEM;
> +
> +	mutex_lock(&event_mutex);

And switch this over to guard() as well.

Thanks,

-- Steve

> +	event_file = event_file_data(file);
> +	if (!event_file) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
>  	hist_file->file = file;
> +	hist_file->last_act = get_hist_hit_count(event_file);
>  
>  	/* Clear private_data to avoid warning in single_open() */
>  	file->private_data = NULL;
>  	ret = single_open(file, hist_show, hist_file);
> +
> +out_unlock:
>  	if (ret)
>  		kfree(hist_file);
> +	mutex_unlock(&event_mutex);
>  	return ret;
>  }
>  


