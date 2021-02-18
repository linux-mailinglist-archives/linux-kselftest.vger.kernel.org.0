Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5534331F0D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Feb 2021 21:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhBRULz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Feb 2021 15:11:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43052 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhBRUJx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Feb 2021 15:09:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 482F51F45D91
Subject: Re: [RFC PATCH 01/13] futex2: Implement wait and wake functions
To:     Peter Zijlstra <peterz@infradead.org>
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
References: <20210215152404.250281-1-andrealmeid@collabora.com>
 <20210215152404.250281-2-andrealmeid@collabora.com>
 <YCuKJEvcoXjgaNsb@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <d1b34b2e-8fb2-1ad4-6aa9-8240520bf89d@collabora.com>
Date:   Thu, 18 Feb 2021 17:09:02 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YCuKJEvcoXjgaNsb@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

Às 06:02 de 16/02/21, Peter Zijlstra escreveu:
> On Mon, Feb 15, 2021 at 12:23:52PM -0300, André Almeida wrote:
>> +static int __futex_wait(struct futexv_head *futexv, unsigned int nr_futexes,
>> +			struct hrtimer_sleeper *timeout)
>> +{
>> +	int ret;
>> +
>> +	while (1) {
>> +		int awakened = -1;
>> +
> 
> Might be easier to understand if the set_current_state() is here,
> instead of squirreled away in futex_enqueue().
> 

I placed set_current_state() inside futex_enqueue() because we need to 
set RUNNING and then INTERRUPTIBLE again for the retry path.

>> +		ret = futex_enqueue(futexv, nr_futexes, &awakened);
>> +
>> +		if (ret) {
>> +			if (awakened >= 0)
>> +				return awakened;
>> +			return ret;
>> +		}
>> +
>> +		/* Before sleeping, check if someone was woken */
>> +		if (!futexv->hint && (!timeout || timeout->task))
>> +			freezable_schedule();
>> +
>> +		__set_current_state(TASK_RUNNING);
> 
> This is typically after the loop.
> 

Sorry, which loop?

>> +
>> +		/*
>> +		 * One of those things triggered this wake:
>> +		 *
>> +		 * * We have been removed from the bucket. futex_wake() woke
>> +		 *   us. We just need to dequeue and return 0 to userspace.
>> +		 *
>> +		 * However, if no futex was dequeued by a futex_wake():
>> +		 *
>> +		 * * If the there's a timeout and it has expired,
>> +		 *   return -ETIMEDOUT.
>> +		 *
>> +		 * * If there is a signal pending, something wants to kill our
>> +		 *   thread, return -ERESTARTSYS.
>> +		 *
>> +		 * * If there's no signal pending, it was a spurious wake
>> +		 *   (scheduler gave us a change to do some work, even if we
> 
> chance?

Indeed, fixed.

> 
>> +		 *   don't want to). We need to remove ourselves from the
>> +		 *   bucket and add again, to prevent losing wakeups in the
>> +		 *   meantime.
>> +		 */
> 
> Anyway, doing a dequeue and enqueue for spurious wakes is a bit of an
> anti-pattern that can lead to starvation. I've not actually looked at
> much detail yet as this is my first read-through, but did figure I'd
> mention it.
> 

So we could just leave everything enqueued for spurious wake? I was 
expecting that we would need to do all the work again (including 
rechecking *uaddr == val) to see if we didn't miss a futex_wake() 
between the kernel thread waking (spuriously) and going to sleep again.

>> +
>> +		ret = futex_dequeue_multiple(futexv, nr_futexes);
>> +
>> +		/* Normal wake */
>> +		if (ret >= 0)
>> +			return ret;
>> +
>> +		if (timeout && !timeout->task)
>> +			return -ETIMEDOUT;
>> +
>> +		if (signal_pending(current))
>> +			return -ERESTARTSYS;
>> +
>> +		/* Spurious wake, do everything again */
>> +	}
>> +}

Thanks,
	André
