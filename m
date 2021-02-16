Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D5F31C831
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Feb 2021 10:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhBPJh7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Feb 2021 04:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBPJhv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Feb 2021 04:37:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B1DC061574;
        Tue, 16 Feb 2021 01:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=6p6aP26uvaDys5m2iqcqs2Sq1c/nYDnkVqNjuyxRkDU=; b=Nk4MUsvviR9MIo25CvF38GBU6P
        HueibuWzMXbLsx5spRiXK/Folbl0pODU9941RNDDvdGqgpXmzjy+XIssHin4gBD797gR8i+2CiWsS
        9rNh3U6F/8P9YMQY6P8erJIv5tuxOhuvYGDhouTECta/1hzgomSFVtfYUVB8PFrMQrWPJun1bxPxK
        F5UliehaGMyP6rxujPhSnZT1x9VYjuxdQ5M2cyYF/evDQemtzv8Z0dsy2On6A4eZsIleh4omSGPQF
        W5ijuSs/k6kq8DUN5Ye3nZYeP/C8DtVAKAcz0jQ+2sxAbBn89IkIUL9Noq6BYQT4PoZiUGODuLnVZ
        RDBbf8JQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lBwl5-00GheO-QE; Tue, 16 Feb 2021 09:35:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46AE63059DD;
        Tue, 16 Feb 2021 10:35:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2CE432058CB0E; Tue, 16 Feb 2021 10:35:02 +0100 (CET)
Date:   Tue, 16 Feb 2021 10:35:02 +0100
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
Message-ID: <YCuRxl4uRhua+Y5b@hirez.programming.kicks-ass.net>
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

> +static int futex_dequeue_multiple(struct futexv_head *futexv, unsigned int nr)
> +{
> +	int i, ret = -1;
> +
> +	for (i = 0; i < nr; i++) {
> +		spin_lock(&futexv->objects[i].bucket->lock);
> +		if (!list_empty_careful(&futexv->objects[i].list)) {
> +			list_del_init_careful(&futexv->objects[i].list);
> +			bucket_dec_waiters(futexv->objects[i].bucket);

What's with the careful? AFAICT all sites have that bucket->lock.

> +		} else {
> +			ret = i;
> +		}
> +		spin_unlock(&futexv->objects[i].bucket->lock);
> +	}
> +
> +	return ret;
> +}

> +static int futex_enqueue(struct futexv_head *futexv, unsigned int nr_futexes,
> +			 int *awakened)
> +{
> +	int i, ret;
> +	u32 uval, *uaddr, val;
> +	struct futex_bucket *bucket;
> +
> +retry:
> +	set_current_state(TASK_INTERRUPTIBLE);
> +
> +	for (i = 0; i < nr_futexes; i++) {
> +		uaddr = (u32 * __user)futexv->objects[i].uaddr;
> +		val = (u32)futexv->objects[i].val;
> +
> +		bucket = futexv->objects[i].bucket;
> +
> +		bucket_inc_waiters(bucket);
> +		spin_lock(&bucket->lock);
> +
> +		ret = futex_get_user(&uval, uaddr);
> +
> +		if (unlikely(ret)) {
> +			spin_unlock(&bucket->lock);
> +
> +			bucket_dec_waiters(bucket);
> +			__set_current_state(TASK_RUNNING);
> +			*awakened = futex_dequeue_multiple(futexv, i);
> +
> +			if (__get_user(uval, uaddr))
> +				return -EFAULT;
> +
> +			if (*awakened >= 0)
> +				return 1;
> +
> +			goto retry;
> +		}
> +
> +		if (uval != val) {
> +			spin_unlock(&bucket->lock);
> +
> +			bucket_dec_waiters(bucket);
> +			__set_current_state(TASK_RUNNING);
> +			*awakened = futex_dequeue_multiple(futexv, i);
> +
> +			if (*awakened >= 0)
> +				return 1;
> +
> +			return -EAGAIN;
> +		}
> +
> +		list_add_tail(&futexv->objects[i].list, &bucket->list);

and here

> +		spin_unlock(&bucket->lock);
> +	}
> +
> +	return 0;
> +}
> +

> +static void futex_mark_wake(struct futex_waiter *waiter,
> +			    struct futex_bucket *bucket,
> +			    struct wake_q_head *wake_q)
> +{
> +	struct task_struct *task;
> +	struct futexv_head *parent = futex_get_parent((uintptr_t)waiter,
> +						      waiter->index);
> +

	lockdep_assert_held(&bucket->lock);

> +	parent->hint = true;
> +	task = parent->task;
> +	get_task_struct(task);
> +	list_del_init_careful(&waiter->list);

and here

> +	wake_q_add_safe(wake_q, task);
> +	bucket_dec_waiters(bucket);
> +}

