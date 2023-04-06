Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5F6DA293
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 22:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbjDFUXL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbjDFUW5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 16:22:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2F77EFA;
        Thu,  6 Apr 2023 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hPBwWzsuf10OLaAVTCaYjPLONJGSSpf1kqp034sRoAQ=; b=QMxAnedNp7IDVbovhyH++LCRJa
        4AkAwNcWM32tR82dPxgmMEEsUQ3ZaRv5ym5AZNngOMn0457baygSoYcvSZWm71mPbfm7t9TMz0kJw
        3+sG7uwRZvBMD1QRs4f6wJzviS4fh99DPkCng9rycKGGGaKVFwIarCVwf+KnAc/p7H7YW32ESdVJA
        JuXeGeQwD8TC9Cws53icodLy4XpKoNl1MSB0FTJ8cjmQJY+jMFFSBDTY9io9eILKatzSNBfvw4P6B
        mpHxtqMfNvFWPiZxqQXTLSTNBRJ8C1lZDTdxKvfIAC/HStAVN66oIEARkzzswIBpl8514ER4pdSBr
        iVERAXsg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkW7o-0008k6-W2; Thu, 06 Apr 2023 20:22:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D2DB3300202;
        Thu,  6 Apr 2023 22:22:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B702A212E36AE; Thu,  6 Apr 2023 22:22:27 +0200 (CEST)
Date:   Thu, 6 Apr 2023 22:22:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
Message-ID: <20230406202227.GD405948@hirez.programming.kicks-ass.net>
References: <20230316123028.2890338-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316123028.2890338-1-elver@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 16, 2023 at 01:30:27PM +0100, Marco Elver wrote:
> From: Dmitry Vyukov <dvyukov@google.com>
> 
> POSIX timers using the CLOCK_PROCESS_CPUTIME_ID clock prefer the main
> thread of a thread group for signal delivery.     However, this has a
> significant downside: it requires waking up a potentially idle thread.
> 
> Instead, prefer to deliver signals to the current thread (in the same
> thread group) if SIGEV_THREAD_ID is not set by the user. This does not
> change guaranteed semantics, since POSIX process CPU time timers have
> never guaranteed that signal delivery is to a specific thread (without
> SIGEV_THREAD_ID set).
> 
> The effect is that we no longer wake up potentially idle threads, and
> the kernel is no longer biased towards delivering the timer signal to
> any particular thread (which better distributes the timer signals esp.
> when multiple timers fire concurrently).
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/signal.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8cb28f1df294..605445fa27d4 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1003,8 +1003,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>  	/*
>  	 * Now find a thread we can wake up to take the signal off the queue.
>  	 *
> -	 * If the main thread wants the signal, it gets first crack.
> -	 * Probably the least surprising to the average bear.
> +	 * Try the suggested task first (may or may not be the main thread).
>  	 */
>  	if (wants_signal(sig, p))
>  		t = p;
> @@ -1970,8 +1969,23 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  
>  	ret = -1;
>  	rcu_read_lock();
> +	/*
> +	 * This function is used by POSIX timers to deliver a timer signal.
> +	 * Where type is PIDTYPE_PID (such as for timers with SIGEV_THREAD_ID
> +	 * set), the signal must be delivered to the specific thread (queues
> +	 * into t->pending).
> +	 *
> +	 * Where type is not PIDTYPE_PID, signals must just be delivered to the
> +	 * current process. In this case, prefer to deliver to current if it is
> +	 * in the same thread group as the target, as it avoids unnecessarily
> +	 * waking up a potentially idle task.
> +	 */
>  	t = pid_task(pid, type);
> -	if (!t || !likely(lock_task_sighand(t, &flags)))
> +	if (!t)
> +		goto ret;
> +	if (type != PIDTYPE_PID && same_thread_group(t, current))
> +		t = current;
> +	if (!likely(lock_task_sighand(t, &flags)))
>  		goto ret;
>  
>  	ret = 1; /* the signal is ignored */
> @@ -1993,6 +2007,11 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  	q->info.si_overrun = 0;
>  
>  	signalfd_notify(t, sig);
> +	/*
> +	 * If the type is not PIDTYPE_PID, we just use shared_pending, which
> +	 * won't guarantee that the specified task will receive the signal, but
> +	 * is sufficient if t==current in the common case.
> +	 */
>  	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
>  	list_add_tail(&q->list, &pending->list);
>  	sigaddset(&pending->signal, sig);
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 
