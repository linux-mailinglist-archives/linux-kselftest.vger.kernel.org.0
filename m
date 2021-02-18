Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFAF31ECC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Feb 2021 18:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBRRCC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Feb 2021 12:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhBRNbu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Feb 2021 08:31:50 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B85BC06178C;
        Thu, 18 Feb 2021 05:30:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 2EC3D1F45BCB
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Subject: Re: [RFC PATCH 01/13] futex2: Implement wait and wake functions
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, pgriffais@valvesoftware.com,
        z.figura12@gmail.com, joel@joelfernandes.org,
        malteskarupke@fastmail.fm, linux-api@vger.kernel.org,
        fweimer@redhat.com, libc-alpha@sourceware.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, acme@kernel.org,
        corbet@lwn.net
References: <20210215152404.250281-1-andrealmeid@collabora.com>
 <20210215152404.250281-2-andrealmeid@collabora.com>
 <87k0r9w19l.fsf@collabora.com>
Message-ID: <74e321d5-2cf5-f3a6-6a7a-49e1ed2fda07@collabora.com>
Date:   Thu, 18 Feb 2021 10:29:46 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87k0r9w19l.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Gabriel,

Às 16:59 de 15/02/21, Gabriel Krisman Bertazi escreveu:
> André Almeida <andrealmeid@collabora.com> writes:
> 
>> +/**
>> + * struct futexv_head - List of futexes to be waited
>> + * @task:    Task to be awaken
>> + * @hint:    Was someone on this list awakened?
>> + * @objects: List of futexes
>> + */
>> +struct futexv_head {
>> +	struct task_struct *task;
>> +	bool hint;
>> +	struct futex_waiter objects[0];
>> +};
> 
> this structure is also used for a single futex.  maybe struct futex_waiter_head?

One could argue that a single futex is a futexv of one element, but I 
can see that futex_waiter_head makes more sense. Fixed.

>> +/**
>> + * struct futex_single_waiter - Wrapper for a futexv_head of one element
>> + * @futexv: Single futexv element
>> + * @waiter: Single waiter element
>> + */
>> +struct futex_single_waiter {
>> +	struct futexv_head futexv;
>> +	struct futex_waiter waiter;
>> +} __packed;
> 
> Is this struct necessary?  can't you just allocate the necessary space,
> i.e. a struct futexv_head with 1 futexv_head->object?

I don't feel that makes sense to use dynamic allocation for a fixed 
sized memory. Given that, using this struct was the way I found to have 
a futexv_head of a single element in a static allocation fashion.

>> +
>> +	key->offset = address % PAGE_SIZE;
>> +	address -= key->offset;
>> +	key->pointer = (u64)address;
>> +	key->index = (unsigned long)current->mm;
> 
> Why split the key in offset and pointer and waste 1/3 more space to
> store each key?
> 

We need three fields for storing the shared key in the current design, 
and given that the futex key currently lives inside struct futex_waiter, 
private and shared keys need to use the same amount of space. Even if I 
don't use offset for now, the next patch would expand the memory anyway. 
I see that the way I organized the patches made this confusing.

To avoid that we could allocate the key space in futex_wait and make 
futex key point there.

>> +
>> +	/* Generate hash key for this futex using uaddr and current->mm */
>> +	hash_key = jhash2((u32 *)key, sizeof(*key) / sizeof(u32), 0);
>> +
>> +	/* Since HASH_SIZE is 2^n, subtracting 1 makes a perfect bit mask */
>> +	return &futex_table[hash_key & (futex2_hashsize - 1)];
> 
> If someone inadvertely changes futex2_hashsize to something not 2^n this
> will silently break.  futex2_hashsize should be constant and you need
> a BUILD_BUG_ON().

Given that futex2_hashsize is calcutated at boot time, not sure what we 
could to about this, maybe BUG_ON()?

> 
>> +static int futex_enqueue(struct futexv_head *futexv, unsigned int nr_futexes,
>> +			 int *awakened)
>> +{
>> +	int i, ret;
>> +	u32 uval, *uaddr, val;
>> +	struct futex_bucket *bucket;
>> +
>> +retry:
>> +	set_current_state(TASK_INTERRUPTIBLE);
>> +
>> +	for (i = 0; i < nr_futexes; i++) {
>> +		uaddr = (u32 * __user)futexv->objects[i].uaddr;
>> +		val = (u32)futexv->objects[i].val;
>> +
>> +		bucket = futexv->objects[i].bucket;
>> +
>> +		bucket_inc_waiters(bucket);
>> +		spin_lock(&bucket->lock);
>> +
>> +		ret = futex_get_user(&uval, uaddr);
>> +
>> +		if (unlikely(ret)) {
>> +			spin_unlock(&bucket->lock);
>> +
>> +			bucket_dec_waiters(bucket);
>> +			__set_current_state(TASK_RUNNING);
>> +			*awakened = futex_dequeue_multiple(futexv, i);
>> +
>> +			if (__get_user(uval, uaddr))
>> +				return -EFAULT;
>> +
>> +			if (*awakened >= 0)
>> +				return 1;
> 
> If you are awakened, you don't need to waste time with trying to get the
> next key.
> 

Yes, and this is what this return is supposed to do. What I'm missing?

> 
>> +/**
>> + * futex_wait - Setup the timer (if there's one) and wait on a list of futexes
>> + * @futexv:     List of futexes
>> + * @nr_futexes: Length of futexv
>> + * @timo:	Timeout
>> + * @flags:	Timeout flags
>> + *
>> + * Return:
>> + * * 0 >= - Hint of which futex woke us
>> + * * 0 <  - Error code
>> + */
>> +static int futex_set_timer_and_wait(struct futexv_head *futexv,
>> +				    unsigned int nr_futexes,
>> +				    struct __kernel_timespec __user *timo,
>> +				    unsigned int flags)
>> +{
>> +	struct hrtimer_sleeper timeout;
>> +	int ret;
>> +
>> +	if (timo) {
>> +		ret = futex_setup_time(timo, &timeout, flags);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	ret = __futex_wait(futexv, nr_futexes, timo ? &timeout : NULL);
>> +
>> +	if (timo)
>> +		hrtimer_cancel(&timeout.timer);
>> +
>> +	return ret;
>> +}
> 
> I'm having a hard time understanding why this function exists.  part of
> the futex is set up outside of it, part inside.  Not sure if this isn't
> just part of sys_futex_wait.
> 

I wrote this function since setting the timer, waiting and canceling the 
timer is common for both wait and waitv, so this would avoid some code 
duplication. But I probably can just do the timer stuff inside __futex_wait.

> Thanks,
> 
