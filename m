Return-Path: <linux-kselftest+bounces-20126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD4F9A3A73
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 11:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAE94B210E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B32200CAD;
	Fri, 18 Oct 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beOPpKVW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8D200B89;
	Fri, 18 Oct 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244989; cv=none; b=V844bkw8QZXt8Ush1X5nNG1RGHoy4yWvaP9ww9WX6kkM413E+yWRqVaWWnrodHMko+1LT4Io1bUH9aOifynlw76KyNE4/8Xmly+oJm7TYZdnr6XiKHrUTwhB8VbLn7Y8o/uHBavzUt4COnQnjjyYIjMmn6cwoBORNxx6+7kATW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244989; c=relaxed/simple;
	bh=lomrO0oUsxKUobrQmwshQwtfyAVPsEmKZo94r7bd44c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNaYX4yGy2BRLRtdUg2LMpBHcPX5eDaM1p5JzqEGu1/HezsjuPapzMxeTQsk2xlqy5RXhWgF5YdEaC93usLtNHfYn8Q8f5B1mfMmEil5Lz6i0w7bEAsmHLcHzD/4zwX50VVVwl3qzwU9SdJUt9/HFh6w7vwolkG3KdIrhIGAyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beOPpKVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E416C4CEC3;
	Fri, 18 Oct 2024 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729244988;
	bh=lomrO0oUsxKUobrQmwshQwtfyAVPsEmKZo94r7bd44c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=beOPpKVW4p4v+LhqXnYFMneUGQLnFtJpmqZKfGux5Ye8vU9+tKHi/pnydoPGVwqL9
	 CeHKvWJrYsesD1qoOggUgLcF6tb46bBezN2yFTzVj64ASOAb+qNNN+PxtEhtCr1bEA
	 zjkkwJ8pSd4KCCg4dsWJo2nw5e14hCVPBHFGvwvzwH3JqYQkT4qYo9FmLkN/ujLFSB
	 Koicb7uBwijVx9TQJQNThWwf1MY0kGvmXEzV8+xtQ3qja5F11TlIhVe8Gl0VG7FZYK
	 oe+9jSWYHvVo+mgS8qFLEhniKG2CRj9/xwT+XvE9alEJ22ieULhj3Q69WHnFXcDDHv
	 jVeXSlxPCkP5Q==
Date: Fri, 18 Oct 2024 10:49:42 +0100
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
Subject: Re: [PATCH net-next v5 0/3] Threads support in proc connector
Message-ID: <20241018094942.GE1697@kernel.org>
References: <20241017181436.2047508-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017181436.2047508-1-anjali.k.kulkarni@oracle.com>

On Thu, Oct 17, 2024 at 11:14:33AM -0700, Anjali Kulkarni wrote:
> Recently we committed a fix to allow processes to receive notifications for
> non-zero exits via the process connector module. Commit is a4c9a56e6a2c.
> 
> However, for threads, when it does a pthread_exit(&exit_status) call, the
> kernel is not aware of the exit status with which pthread_exit is called.
> It is sent by child thread to the parent process, if it is waiting in
> pthread_join(). Hence, for a thread exiting abnormally, kernel cannot
> send notifications to any listening processes.
> 
> The exception to this is if the thread is sent a signal which it has not
> handled, and dies along with it's process as a result; for eg. SIGSEGV or
> SIGKILL. In this case, kernel is aware of the non-zero exit and sends a
> notification for it.
> 
> For our use case, we cannot have parent wait in pthread_join, one of the
> main reasons for this being that we do not want to track normal
> pthread_exit(), which could be a very large number. We only want to be
> notified of any abnormal exits. Hence, threads are created with
> pthread_attr_t set to PTHREAD_CREATE_DETACHED.
> 
> To fix this problem, we add a new type PROC_CN_MCAST_NOTIFY to proc connector
> API, which allows a thread to send it's exit status to kernel either when
> it needs to call pthread_exit() with non-zero value to indicate some
> error or from signal handler before pthread_exit().
> 
> We also need to filter packets with non-zero exit notifications futher
> based on instances, which can be identified by task names. Hence, added a
> comm field to the packet's struct proc_event, in which task->comm is
> stored.

As it seems that there will be another revision anyway,
please run this patch-set through checkpatch with the following arguments.

	./scripts/checkpatch.pl --strict --max-line-length=80

And please fix warnings about alignment and line length.
But please do so in such a way that doesn't reduce readability,
e.g. don't split strings over multiple lines.

