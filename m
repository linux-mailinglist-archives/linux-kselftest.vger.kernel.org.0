Return-Path: <linux-kselftest+bounces-19594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED31A99B29F
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 11:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14E6B20D47
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F12914BF8F;
	Sat, 12 Oct 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V13BGWhE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71949610D;
	Sat, 12 Oct 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726239; cv=none; b=GUcGdP/sKBqgmtJsY4bDtZjsg1T69m5zcJLMX5LjanL7hMkJyODPCHtPRFzJn+W9q4wtJh+vPQYU0mNDX4A1drI+eOayZoMtMcgcQnMD2b9mD7hYn5J0ugRlJixUhELgVWQnSv7qo4ClZmwDvCpaKKTcdZael2mAkJ3r5/z1fHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726239; c=relaxed/simple;
	bh=u6SCTW34m77+SZUJ4QfQ2fTZnVyo3HQiIoWzpjlrB3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrDob5pmGO9GnlCEJIWou8Rk4q7FA1ND7Q6qsIhju4v1MJPOX5pmcEFJaptQVFLuVtoVKFlIA4mis4sTWvyw+qYdh9NqxPEUscrGmSyECmnT9pXAOlHMVOXZi+yD932rUOkqvxSB97hjF/cs1FNpZg13C/ZpNID+/Y6M7DM+L1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V13BGWhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A385CC4CEC6;
	Sat, 12 Oct 2024 09:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728726239;
	bh=u6SCTW34m77+SZUJ4QfQ2fTZnVyo3HQiIoWzpjlrB3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V13BGWhEhtf//dQLaHxYjMqELcEd+sP9fFD9Qjv5kGJ5eDpgGJxOXU+wW4YPl4J7O
	 1UcnmHBR0EssqKzOGNdS6f7j13OWS8Sf2vQ3uwn7cmuIA6O1OjzFHosuZtzk0dK8kG
	 Cwr5BZxDsirUbDGBaajWVQBxrBaLEhHm82lOtDo/gvLN54yEIL2MDP0VcWu+AVl5kd
	 LTiasKXeeXz/k8U0lHTA5nOxliCS1TY/4J6UjLDyukJ+hrIhSksM5fItmg1TVFqbht
	 inh0T92ZzG7rya0por/4dIG+H8gmPBWaQnLZaEC0e7lLpGEw0h4gKBBPqkeQqJv1PP
	 iNSkM6V9l2pyA==
Date: Sat, 12 Oct 2024 10:43:52 +0100
From: Simon Horman <horms@kernel.org>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, Liam.Howlett@oracle.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, akpm@linux-foundation.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, peili.io@oracle.com
Subject: Re: [PATCH net-next 1/3] connector/cn_proc: Add hash table for
 threads
Message-ID: <20241012094352.GA77519@kernel.org>
References: <20241012004532.2071738-1-anjali.k.kulkarni@oracle.com>
 <20241012004532.2071738-2-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012004532.2071738-2-anjali.k.kulkarni@oracle.com>

On Fri, Oct 11, 2024 at 05:45:30PM -0700, Anjali Kulkarni wrote:
> Add a new type PROC_CN_MCAST_NOTIFY to proc connector API, which allows a
> thread to notify the kernel that it has exited abnormally. Thread can also
> send the exit status code it wants returned in the notification with it.
> Exiting thread can call this either when it wants to call pthread_exit()
> with non-zero value or from signal handler.
> 
> Add a new file cn_hash.c which implements a hash table storing the exit
> codes of abnormally exiting threads, received by the system call above.
> The key used for the hash table is the pid of the thread, so when the
> thread actually exits, we lookup it's pid in the hash table and retrieve
> the exit code sent by user. If the exit code in struct task is 0, we
> then replace it with the user supplied non-zero exit code.
> 
> cn_hash.c implements the hash table add, delete, lookup operations.
> mutex_lock() and mutex_unlock() operations are used to safeguard the
> integrity of the hash table while adding or deleting elements.
> connector.c has the API calls, called from cn_proc.c, as well as calls
> to allocate, initialize and free the hash table.
> 
> Add a new flag in PF_* flags of task_struct - EXIT_NOTIFY. This flag is
> set when user sends the exit code via PROC_CN_MCAST_NOTIFY. While
> exiting, this flag is checked and the hash table add or delete calls
> are only made if this flag is set.
> 
> A refcount field hrefcnt is added in struct cn_hash_dev, to keep track
> of number of threads which have added an entry in hash table. Before
> freeing the struct cn_hash_dev, this value must be 0.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>

...

> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 44b19e696176..8c6e002069d9 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c

...

> @@ -326,9 +328,16 @@ void proc_exit_connector(struct task_struct *task)
>  	struct proc_event *ev;
>  	struct task_struct *parent;
>  	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
> +	__u32 uexit_code;
> +	int err;
>  
> -	if (atomic_read(&proc_event_num_listeners) < 1)
> +	if (atomic_read(&proc_event_num_listeners) < 1) {
> +		if (likely(!(task->flags & PF_EXIT_NOTIFY)))
> +			return;
> +
> +		err = cn_del_elem(task->pid);

Hi Anjali,

err is set but otherwise unused in this function; probably it can be removed.

>  		return;
> +	}
>  
>  	msg = buffer_to_cn_msg(buffer);
>  	ev = (struct proc_event *)msg->data;

...

