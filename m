Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDED34340D
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Mar 2021 19:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhCUS2v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Mar 2021 14:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhCUS2U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Mar 2021 14:28:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC40C061574
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Mar 2021 11:28:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g15so9469206pfq.3
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Mar 2021 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=POo1SoTUwsWWnflL2igeiPiE/2YoV0u9IJHG+MIDORU=;
        b=iHdGKUlN+xmxipuJMHD4y0Ch02Wn5luO0tquZ0RRAUzvd34Kxby0+9caMgXiVWv+7e
         Lldf1Cv57E0FtCF1XI9B7OtrOzMMP4ObZi9EKUxdzNiOdwVWpZgNDuQXeTTKZuOlndqV
         puuaR/FZ8U55eV7F5f55fjV2Gd3PPqI8jv94o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=POo1SoTUwsWWnflL2igeiPiE/2YoV0u9IJHG+MIDORU=;
        b=NLLRwXrWhK8kg43w9ZEWvV179IvLM3FtLZ5bVTlwUdCytJtC/m5R12EqEfTVBZ8TfY
         LlyrsYL/09SsPy8J1FaKVAiLnZgsVo7HoOUMAh/bn6Iu+/erikRkkQWmCRi2AseDgLPH
         QJ/puJ/YB2m71YKlpKm/zSIJ3xki4lS0bezCJEAkWYYd13+Wy5TDmTZ689fbDRCejFnm
         Su2hmL7ltFweenRdSLV7dn32yZUlTWOPDjOQdaMyb/9TFb6udUduUERk6N6RwOMcWa0h
         JISGGCn4iBo12mbUZ4hN/nfop4S9k2jiVdjgYOqnU1Yj5TFssO8QstSWUIkcp2JX+Kaq
         cM4A==
X-Gm-Message-State: AOAM530qr4aJRe/8Paxk+3PbOSIQrhzkrJWlt+b464Azs7hD77C+Nsqz
        1HN8SrfuROYUEgcYQFhmI4m5tw==
X-Google-Smtp-Source: ABdhPJygMrBqqGxOk5LkBukeVmFjDrop1vSHRbvmmKWeMApUBRuSjDZSDcA5iuukfeTo5FepHI7JWQ==
X-Received: by 2002:a63:5464:: with SMTP id e36mr19721434pgm.223.1616351299040;
        Sun, 21 Mar 2021 11:28:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u1sm3104677pgg.11.2021.03.21.11.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 11:28:18 -0700 (PDT)
Date:   Sun, 21 Mar 2021 11:28:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Wood <john.wood@gmx.com>
Cc:     Jann Horn <jannh@google.com>, Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v6 3/8] securtiy/brute: Detect a brute force attack
Message-ID: <202103211108.628E6729F@keescook>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-4-john.wood@gmx.com>
 <202103171902.E6F55172@keescook>
 <20210320153406.GB3023@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320153406.GB3023@ubuntu>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 20, 2021 at 04:34:06PM +0100, John Wood wrote:
> On Wed, Mar 17, 2021 at 07:57:10PM -0700, Kees Cook wrote:
> > On Sun, Mar 07, 2021 at 12:30:26PM +0100, John Wood wrote:
> > > @@ -74,7 +84,7 @@ static struct brute_stats *brute_new_stats(void)
> > >  {
> > >  	struct brute_stats *stats;
> > >
> > > -	stats = kmalloc(sizeof(struct brute_stats), GFP_KERNEL);
> > > +	stats = kmalloc(sizeof(struct brute_stats), GFP_ATOMIC);
> >
> > Why change this here? I'd just start with this in the patch that
> > introduces it.
> 
> To be coherent in the previous patch. In the previous patch the kmalloc
> could use GFP_KERNEL due to the call was made out of an atomic context.
> Now, with the new lock it needs GFP_ATOMIC. So the question:
> 
> If finally it need to use GFP_ATOMIC, the first patch need to use it even if
> it is not necessary?

It's probably not a big deal, but for me, I'd just do GFP_ATOMIC from
the start, maybe add a comment that says "some LSM hooks are from atomic
context" or something.

> > >  	if (!stats)
> > >  		return NULL;
> > >
> > > @@ -99,16 +109,17 @@ static struct brute_stats *brute_new_stats(void)
> > >   * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> > >   * since the task_free hook can be called from an IRQ context during the
> > >   * execution of the task_alloc hook.
> > > + *
> > > + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> > > + *          held.
> > >   */
> > >  static void brute_share_stats(struct brute_stats *src,
> > >  			      struct brute_stats **dst)
> > >  {
> > > -	unsigned long flags;
> > > -
> > > -	spin_lock_irqsave(&src->lock, flags);
> > > +	spin_lock(&src->lock);
> > >  	refcount_inc(&src->refc);
> > >  	*dst = src;
> > > -	spin_unlock_irqrestore(&src->lock, flags);
> > > +	spin_unlock(&src->lock);
> > >  }
> >
> > I still don't think any locking is needed here; the whole function can
> > go away, IMO.
> 
> In this case I think this is possible:
> 
> Scenario 1: cpu 1 writes the stats pointer and cpu 2 is navigating the
>             processes tree reading the same stats pointer.
> 
> Scenario 2: cpu 1 is navigating the processes tree reading the stats
>             pointer and in IRQ the same stats pointer is wrote.
> 
> So, we need locking. Am I wrong?

But only the refcount is being incremented, yes? That doesn't need a
lock because it's already an atomic.

> 
> > >  /**
> > > @@ -126,26 +137,36 @@ static void brute_share_stats(struct brute_stats *src,
> > >   * this task and the new one being allocated. Otherwise, share the statistics
> > >   * that the current task already has.
> > >   *
> > > + * It's mandatory to disable interrupts before acquiring brute_stats_ptr_lock
> > > + * and brute_stats::lock since the task_free hook can be called from an IRQ
> > > + * context during the execution of the task_alloc hook.
> > > + *
> > >   * Return: -ENOMEM if the allocation of the new statistics structure fails. Zero
> > >   *         otherwise.
> > >   */
> > >  static int brute_task_alloc(struct task_struct *task, unsigned long clone_flags)
> > >  {
> > >  	struct brute_stats **stats, **p_stats;
> > > +	unsigned long flags;
> > >
> > >  	stats = brute_stats_ptr(task);
> > >  	p_stats = brute_stats_ptr(current);
> > > +	write_lock_irqsave(&brute_stats_ptr_lock, flags);
> > >
> > >  	if (likely(*p_stats)) {
> > >  		brute_share_stats(*p_stats, stats);
> > > +		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > >  		return 0;
> > >  	}
> > >
> > >  	*stats = brute_new_stats();
> > > -	if (!*stats)
> > > +	if (!*stats) {
> > > +		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > >  		return -ENOMEM;
> > > +	}
> > >
> > >  	brute_share_stats(*stats, p_stats);
> > > +	write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > >  	return 0;
> > >  }
> >
> > I'd much prefer that whatever locking is needed be introduced in the
> > initial patch: this transformation just double the work to review. :)
> 
> So, IIUC I need to introduce all the locks in the initial patch even if
> they are not necessary. Am I right?

I would find it easier to follow. Perhaps other reviewers would have a
different opinion.

> 
> > >
> > > @@ -167,9 +188,9 @@ static int brute_task_alloc(struct task_struct *task, unsigned long clone_flags)
> > >   * only one task (the task that calls the execve function) points to the data.
> > >   * In this case, the previous allocation is used but the statistics are reset.
> > >   *
> > > - * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> > > - * since the task_free hook can be called from an IRQ context during the
> > > - * execution of the bprm_committing_creds hook.
> > > + * It's mandatory to disable interrupts before acquiring brute_stats_ptr_lock
> > > + * and brute_stats::lock since the task_free hook can be called from an IRQ
> > > + * context during the execution of the bprm_committing_creds hook.
> > >   */
> > >  static void brute_task_execve(struct linux_binprm *bprm)
> > >  {
> > > @@ -177,24 +198,33 @@ static void brute_task_execve(struct linux_binprm *bprm)
> > >  	unsigned long flags;
> > >
> > >  	stats = brute_stats_ptr(current);
> > > -	if (WARN(!*stats, "No statistical data\n"))
> > > +	read_lock_irqsave(&brute_stats_ptr_lock, flags);
> > > +
> > > +	if (WARN(!*stats, "No statistical data\n")) {
> > > +		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > >  		return;
> > > +	}
> > >
> > > -	spin_lock_irqsave(&(*stats)->lock, flags);
> > > +	spin_lock(&(*stats)->lock);
> > >
> > >  	if (!refcount_dec_not_one(&(*stats)->refc)) {
> > >  		/* execve call after an execve call */
> > >  		(*stats)->faults = 0;
> > >  		(*stats)->jiffies = get_jiffies_64();
> > >  		(*stats)->period = 0;
> > > -		spin_unlock_irqrestore(&(*stats)->lock, flags);
> > > +		spin_unlock(&(*stats)->lock);
> > > +		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > >  		return;
> > >  	}
> > >
> > >  	/* execve call after a fork call */
> > > -	spin_unlock_irqrestore(&(*stats)->lock, flags);
> > > +	spin_unlock(&(*stats)->lock);
> > > +	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > > +
> > > +	write_lock_irqsave(&brute_stats_ptr_lock, flags);
> > >  	*stats = brute_new_stats();
> > >  	WARN(!*stats, "Cannot allocate statistical data\n");
> > > +	write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > >  }
> >
> > Again, I don't see a need for locking -- this is just managing the
> > lifetime which is entirely handled by the implicit locking of "current"
> > and the refcount_t.
> 
> Here I can see the same two scenarios noted before. So I think the locking
> is needed. Am I right?
> 
> > >  /**
> > > @@ -204,9 +234,9 @@ static void brute_task_execve(struct linux_binprm *bprm)
> > >   * The statistical data that is shared between all the fork hierarchy processes
> > >   * needs to be freed when this hierarchy disappears.
> > >   *
> > > - * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> > > - * since the task_free hook can be called from an IRQ context during the
> > > - * execution of the task_free hook.
> > > + * It's mandatory to disable interrupts before acquiring brute_stats_ptr_lock
> > > + * and brute_stats::lock since the task_free hook can be called from an IRQ
> > > + * context during the execution of the task_free hook.
> > >   */
> > >  static void brute_task_free(struct task_struct *task)
> > >  {
> > > @@ -215,17 +245,446 @@ static void brute_task_free(struct task_struct *task)
> > >  	bool refc_is_zero;
> > >
> > >  	stats = brute_stats_ptr(task);
> > > -	if (WARN(!*stats, "No statistical data\n"))
> > > +	read_lock_irqsave(&brute_stats_ptr_lock, flags);
> > > +
> > > +	if (WARN(!*stats, "No statistical data\n")) {
> > > +		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > >  		return;
> > > +	}
> > >
> > > -	spin_lock_irqsave(&(*stats)->lock, flags);
> > > +	spin_lock(&(*stats)->lock);
> > >  	refc_is_zero = refcount_dec_and_test(&(*stats)->refc);
> > > -	spin_unlock_irqrestore(&(*stats)->lock, flags);
> > > +	spin_unlock(&(*stats)->lock);
> > > +	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > >
> > >  	if (refc_is_zero) {
> > > +		write_lock_irqsave(&brute_stats_ptr_lock, flags);
> > >  		kfree(*stats);
> > >  		*stats = NULL;
> > > +		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > > +	}
> > > +}
> >
> > Same; I would expect this to be simply:
> 
> No comment. I think I am missing something. I need to clarify the previous
> cases before to work on the next ones. Sorry and thanks for the guidance.

Right -- so, there are a few concurrency cases you need to worry about,
AIUI:

1- stats lifetime (based on creation/death of tasks)
2- stats value being written vs read
3- stats values being written/read vs stats lifetime

Using refcount_t in the standard pattern (as you're doing) should
entirely cover "1".

Since the values read from stats are mostly independent, it should be
possible to use READ_ONCE() in the readers and WRITE_ONCE() under a lock
in the writers (this is case "2").

For "3", I think the implicit locking of "current" keeps you safe (as
in, the stats can't go away because "current" will always have a
reference on it).

I see two places where stats are written. One appears to be the
brute_task_execve() case where only 1 thread exists, so there's no
lock needed, and the other case is brute_update_crash_period(), which
makes sense to me to lock: two tasks might be sharing a stats as they
crash.

Of course, I could easily be missing something here, but it looks like
much less locking is needed.

> 
> > 	stats = brute_stats_ptr(task);
> > 	if (WARN_ON_ONCE(!*stats))
> > 		return;
> > 	if (refcount_dec_and_test(&(*stats)->refc)) {
> > 		kfree(*stats);
> > 		*stats = NULL;
> > 	}
> >
> > > +
> > > +/*
> > > + * BRUTE_EMA_WEIGHT_NUMERATOR - Weight's numerator of EMA.
> > > + */
> > > +static const u64 BRUTE_EMA_WEIGHT_NUMERATOR = 7;
> > > +
> > > +/*
> > > + * BRUTE_EMA_WEIGHT_DENOMINATOR - Weight's denominator of EMA.
> > > + */
> > > +static const u64 BRUTE_EMA_WEIGHT_DENOMINATOR = 10;
> >
> > Should these be externally configurable (via sysfs)?
> 
> No problem. I think this is easier than locking :)

Heh, for the most part, yes. ;) Though I have my own nightmares[1] about
sysfs.

> > > +/**
> > > + * brute_update_crash_period() - Update the application crash period.
> > > + * @stats: Statistics that hold the application crash period to update.
> > > + * @now: The current timestamp in jiffies.
> > > + *
> > > + * The application crash period must be a value that is not prone to change due
> > > + * to spurious data and follows the real crash period. So, to compute it, the
> > > + * exponential moving average (EMA) is used.
> > > + *
> > > + * This kind of average defines a weight (between 0 and 1) for the new value to
> > > + * add and applies the remainder of the weight to the current average value.
> > > + * This way, some spurious data will not excessively modify the average and only
> > > + * if the new values are persistent, the moving average will tend towards them.
> > > + *
> > > + * Mathematically the application crash period's EMA can be expressed as
> > > + * follows:
> > > + *
> > > + * period_ema = period * weight + period_ema * (1 - weight)
> > > + *
> > > + * If the operations are applied:
> > > + *
> > > + * period_ema = period * weight + period_ema - period_ema * weight
> > > + *
> > > + * If the operands are ordered:
> > > + *
> > > + * period_ema = period_ema - period_ema * weight + period * weight
> > > + *
> > > + * Finally, this formula can be written as follows:
> > > + *
> > > + * period_ema -= period_ema * weight;
> > > + * period_ema += period * weight;
> > > + *
> > > + * The statistics that hold the application crash period to update cannot be
> > > + * NULL.
> > > + *
> > > + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> > > + * since the task_free hook can be called from an IRQ context during the
> > > + * execution of the task_fatal_signal hook.
> > > + *
> > > + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> > > + *          held.
> > > + * Return: The last crash timestamp before updating it.
> > > + */
> > > +static u64 brute_update_crash_period(struct brute_stats *stats, u64 now)
> > > +{
> > > +	u64 current_period;
> > > +	u64 last_crash_timestamp;
> > > +
> > > +	spin_lock(&stats->lock);
> > > +	current_period = now - stats->jiffies;
> > > +	last_crash_timestamp = stats->jiffies;
> > > +	stats->jiffies = now;
> > > +
> > > +	stats->period -= brute_mul_by_ema_weight(stats->period);
> > > +	stats->period += brute_mul_by_ema_weight(current_period);
> > > +
> > > +	if (stats->faults < BRUTE_MAX_FAULTS)
> > > +		stats->faults += 1;
> > > +
> > > +	spin_unlock(&stats->lock);
> > > +	return last_crash_timestamp;
> > > +}
> >
> > Now *here* locking makes sense, and it only needs to be per-stat, not
> > global, since multiple processes may be operating on the same stat
> > struct. To make this more no-reader-locking-friendly, I'd also update
> > everything at the end, and use WRITE_ONCE():
> >
> > 	u64 current_period, period;
> > 	u64 last_crash_timestamp;
> > 	u64 faults;
> >
> > 	spin_lock(&stats->lock);
> > 	current_period = now - stats->jiffies;
> > 	last_crash_timestamp = stats->jiffies;
> >
> > 	WRITE_ONCE(stats->period,
> > 		   stats->period - brute_mul_by_ema_weight(stats->period) +
> > 		   brute_mul_by_ema_weight(current_period));
> >
> > 	if (stats->faults < BRUTE_MAX_FAULTS)
> > 		WRITE_ONCE(stats->faults, stats->faults + 1);
> >
> > 	WRITE_ONCE(stats->jiffies, now);
> >
> > 	spin_unlock(&stats->lock);
> > 	return last_crash_timestamp;
> >
> > That way readers can (IIUC) safely use READ_ONCE() on jiffies and faults
> > without needing to hold the &stats->lock (unless they need perfectly matching
> > jiffies, period, and faults).
> 
> Thanks for the refactory. I will work on it (if I can understand locking). :(

It may be worth reading Documentation/memory-barriers.txt which has some
more details.

> > > +/**
> > > + * brute_manage_fork_attack() - Manage a fork brute force attack.
> > > + * @stats: Statistical data shared by all the fork hierarchy processes.
> > > + * @now: The current timestamp in jiffies.
> > > + *
> > > + * For a correct management of a fork brute force attack it is only necessary to
> > > + * update the statistics and test if an attack is happening based on these data.
> > > + *
> > > + * The statistical data shared by all the fork hierarchy processes cannot be
> > > + * NULL.
> > > + *
> > > + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> > > + * since the task_free hook can be called from an IRQ context during the
> > > + * execution of the task_fatal_signal hook.
> > > + *
> > > + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> > > + *          held.
> > > + * Return: The last crash timestamp before updating it.
> > > + */
> > > +static u64 brute_manage_fork_attack(struct brute_stats *stats, u64 now)
> > > +{
> > > +	u64 last_fork_crash;
> > > +
> > > +	last_fork_crash = brute_update_crash_period(stats, now);
> > > +	if (brute_attack_running(stats))
> > > +		print_fork_attack_running();
> > > +
> > > +	return last_fork_crash;
> > > +}
> > > +
> > > +/**
> > > + * brute_get_exec_stats() - Get the exec statistics.
> > > + * @stats: When this function is called, this parameter must point to the
> > > + *         current process' statistical data. When this function returns, this
> > > + *         parameter points to the parent process' statistics of the fork
> > > + *         hierarchy that hold the current process' statistics.
> > > + *
> > > + * To manage a brute force attack that happens through the execve system call it
> > > + * is not possible to use the statistical data hold by this process due to these
> > > + * statistics disappear when this task is finished. In this scenario this data
> > > + * should be tracked by the statistics of a higher fork hierarchy (the hierarchy
> > > + * that contains the process that forks before the execve system call).
> > > + *
> > > + * To find these statistics the current fork hierarchy must be traversed up
> > > + * until new statistics are found.
> > > + *
> > > + * Context: Must be called with tasklist_lock and brute_stats_ptr_lock held.
> > > + */
> > > +static void brute_get_exec_stats(struct brute_stats **stats)
> > > +{
> > > +	const struct task_struct *task = current;
> > > +	struct brute_stats **p_stats;
> > > +
> > > +	do {
> > > +		if (!task->real_parent) {
> > > +			*stats = NULL;
> > > +			return;
> > > +		}
> > > +
> > > +		p_stats = brute_stats_ptr(task->real_parent);
> > > +		task = task->real_parent;
> > > +	} while (*stats == *p_stats);
> > > +
> > > +	*stats = *p_stats;
> > > +}
> >
> > See Yama's task_is_descendant() for how to walk up the process tree
> > (and I think the process group stuff will save some steps too); you
> > don't need tasklist_lock held, just rcu_read_lock held, AIUI:
> > Documentation/RCU/listRCU.rst
> >
> > And since you're passing this stats struct back up, and it would be outside of rcu read lock, you'd want to do a "get" on it first:
> >
> > 	rcu_read_lock();
> > 	loop {
> > 		...
> > 	}
> > 	refcount_inc_not_zero(&(*p_stats)->refc);
> > 	rcu_read_unlock();
> >
> > 	*stats = *p_stats
> 
> Thanks for the suggestions. I will work on it for the next version.
> Anyway, in the first version Kees Cook and Jann Horn noted that some tasks
> could escape the rcu read lock and that alternate locking were needed.
> 
> Extract from the RFC:
> 
> [Kees Cook]
> Can't newly created processes escape this RCU read lock? I think this
> need alternate locking, or something in the task_alloc hook that will
> block any new process from being created within the stats group.
> 
> [Jann Horn]
> Good point; the proper way to deal with this would probably be to take
> the tasklist_lock in read mode around this loop (with
> read_lock(&tasklist_lock) / read_unlock(&tasklist_lock)), which pairs
> with the write_lock_irq(&tasklist_lock) in copy_process(). Thanks to
> the fatal_signal_pending() check while holding the lock in
> copy_process(), that would be race-free - any fork() that has not yet
> inserted the new task into the global task list would wait for us to
> drop the tasklist_lock, then bail out at the fatal_signal_pending()
> check.
> 
> I think that this scenario is still possible. So the tasklist_lock is
> necessary. Am I right?

Oops, yeah, best to listen to Jann and past-me. :) Were these comments
about finding the parent or killing offenders?

> > > +
> > > +	spin_lock(&(*stats)->lock);
> > > +	if (!(*stats)->faults)
> > > +		(*stats)->jiffies = last_fork_crash;
> > > +	spin_unlock(&(*stats)->lock);
> > > +
> > > +	brute_update_crash_period(*stats, now);
> >
> > and then you can add:
> >
> > 	if (refcount_dec_and_test(&(*stats)->refc))
> > 		kfree(*stats);
> >
> > (or better yet, make that a helper) named something like
> > "put_brute_stats".
> 
> Sorry, but I don't understand why we need to free the stats here.
> What is the rationale behind this change?

Err, I think I may have quoted the wrong chunk of your patch! Sorry; I
was talking about the place where you did a free, I think? Disregard
this for now. :)

> > > +/**
> > > + * brute_manage_exec_attack() - Manage an exec brute force attack.
> > > + * @stats: Statistical data shared by all the fork hierarchy processes.
> > > + * @now: The current timestamp in jiffies.
> > > + * @last_fork_crash: The last fork crash timestamp before updating it.
> > > + *
> > > + * For a correct management of an exec brute force attack it is only necessary
> > > + * to update the exec statistics and test if an attack is happening based on
> > > + * these data.
> > > + *
> > > + * It is important to note that if the fork and exec crash periods are the same,
> > > + * the attack test is avoided. This allows that in a brute force attack that
> > > + * happens through the fork system call, the mitigation method does not act on
> > > + * the parent process of the fork hierarchy.
> > > + *
> > > + * The statistical data shared by all the fork hierarchy processes cannot be
> > > + * NULL.
> > > + *
> > > + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> > > + * since the task_free hook can be called from an IRQ context during the
> > > + * execution of the task_fatal_signal hook.
> > > + *
> > > + * Context: Must be called with interrupts disabled and tasklist_lock and
> > > + *          brute_stats_ptr_lock held.
> > > + */
> > > +static void brute_manage_exec_attack(struct brute_stats *stats, u64 now,
> > > +				     u64 last_fork_crash)
> > > +{
> > > +	int ret;
> > > +	struct brute_stats *exec_stats = stats;
> > > +	u64 fork_period;
> > > +	u64 exec_period;
> > > +
> > > +	ret = brute_update_exec_crash_period(&exec_stats, now, last_fork_crash);
> > > +	if (WARN(ret, "No exec statistical data\n"))
> > > +		return;
> >
> > I think this should fail closed: if there's a static processing error,
> > treat it as an attack.
> 
> Do you mean to trigger the mitigation of a brute force attack over this task?
> So, IIUC you suggest that instead of generate warnings if there isn't
> statistical data, we need to trigger the mitigation? This can be applied to
> the case where the allocation of a brute_stats structure fails?

Right -- it should be an impossible scenario that the stats are
_missing_. There is not an expected execution path in the kernel where
that could happen, so if you're testing for it (and correctly generating
a WARN), it should _also_ fail closed: an impossible case has been
found, so assume userspace is under attack. (Otherwise it could serve as
a bypass for an attacker who has found a way to navigate a process into
this state.)

-Kees

-- 
Kees Cook
