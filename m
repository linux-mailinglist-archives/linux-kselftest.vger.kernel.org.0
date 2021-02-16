Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1985B31C7CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Feb 2021 10:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhBPJGi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Feb 2021 04:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBPJGJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Feb 2021 04:06:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3356C061574;
        Tue, 16 Feb 2021 01:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ueDYc2cZ6bpbKw5Gc+nyHkg0hLkWmeN2VNHfX5Xo3ag=; b=K+/WiHc6o5yV4kz+dOxC4G4yUC
        8uNKBREjJ4Jzye1NK4C+S1Uz/YP2nm/DFL77Q5Cmq3OB62po9MPSnmyUS+479Ndr/zQaVVG0f3SBN
        iKCQs+2BB74237hcpDgRoKRVaj4ZCWpOJfKjOVpxWqThLN/7Zez8qh1JvWOeKTRQnR2zl05mVGLk5
        ZeIIeyGsPN7KwNUc2aFIYFACzoxRewV8R+Y0Wglm5Kwl/CdPyhVvRZ0/wL3tHKxEEOPdh/bFC2TU1
        xCjT9j6TWdMWi8gYJIzbxqIlqHlFfLJIoKi1Vpz4wCKLS4WNqXrxs0O6UCSZhLeDQcjSegVQmb+g5
        mm8Q5Kng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lBwFc-00GfhV-8w; Tue, 16 Feb 2021 09:03:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C67243003E5;
        Tue, 16 Feb 2021 10:02:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2950D205A431C; Tue, 16 Feb 2021 10:02:28 +0100 (CET)
Date:   Tue, 16 Feb 2021 10:02:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net
Subject: Re: [RFC PATCH 01/13] futex2: Implement wait and wake functions
Message-ID: <YCuKJEvcoXjgaNsb@hirez.programming.kicks-ass.net>
References: <20210215152404.250281-1-andrealmeid@collabora.com>
 <20210215152404.250281-2-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210215152404.250281-2-andrealmeid@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 15, 2021 at 12:23:52PM -0300, André Almeida wrote:
> +static int __futex_wait(struct futexv_head *futexv, unsigned int nr_futexes,
> +			struct hrtimer_sleeper *timeout)
> +{
> +	int ret;
> +
> +	while (1) {
> +		int awakened = -1;
> +

Might be easier to understand if the set_current_state() is here,
instead of squirreled away in futex_enqueue().

> +		ret = futex_enqueue(futexv, nr_futexes, &awakened);
> +
> +		if (ret) {
> +			if (awakened >= 0)
> +				return awakened;
> +			return ret;
> +		}
> +
> +		/* Before sleeping, check if someone was woken */
> +		if (!futexv->hint && (!timeout || timeout->task))
> +			freezable_schedule();
> +
> +		__set_current_state(TASK_RUNNING);

This is typically after the loop.

> +
> +		/*
> +		 * One of those things triggered this wake:
> +		 *
> +		 * * We have been removed from the bucket. futex_wake() woke
> +		 *   us. We just need to dequeue and return 0 to userspace.
> +		 *
> +		 * However, if no futex was dequeued by a futex_wake():
> +		 *
> +		 * * If the there's a timeout and it has expired,
> +		 *   return -ETIMEDOUT.
> +		 *
> +		 * * If there is a signal pending, something wants to kill our
> +		 *   thread, return -ERESTARTSYS.
> +		 *
> +		 * * If there's no signal pending, it was a spurious wake
> +		 *   (scheduler gave us a change to do some work, even if we

chance?

> +		 *   don't want to). We need to remove ourselves from the
> +		 *   bucket and add again, to prevent losing wakeups in the
> +		 *   meantime.
> +		 */

Anyway, doing a dequeue and enqueue for spurious wakes is a bit of an
anti-pattern that can lead to starvation. I've not actually looked at
much detail yet as this is my first read-through, but did figure I'd
mention it.

> +
> +		ret = futex_dequeue_multiple(futexv, nr_futexes);
> +
> +		/* Normal wake */
> +		if (ret >= 0)
> +			return ret;
> +
> +		if (timeout && !timeout->task)
> +			return -ETIMEDOUT;
> +
> +		if (signal_pending(current))
> +			return -ERESTARTSYS;
> +
> +		/* Spurious wake, do everything again */
> +	}
> +}
