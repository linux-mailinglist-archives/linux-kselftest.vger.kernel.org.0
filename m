Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A2033FD7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 03:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhCRC5V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 22:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhCRC5N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 22:57:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACFFC06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 19:57:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so2363488pjb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 19:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NUKVVALo46DGDLY5Fpeo9BiER2fbqhihd3E1ZF34CxI=;
        b=lz5ruq2g10F+WV/R9w10Emn1b/d3L7wD5eqK3paO76kfssR8OfYeSvl8ps5bKV5/KW
         K3CL9xllkqMJV2aNREAgWyii3Vxw452N2edSPFJnkDdw0xznCiigvconRoWaj7aXN2ob
         hGb+OkumdLkoJFXazfD9n76MyYd5/ORyLhZYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NUKVVALo46DGDLY5Fpeo9BiER2fbqhihd3E1ZF34CxI=;
        b=QX/h3x7vKnubiFRp805W6e5WU/OIFaT2BkO+k0E0k5h1k8m4sUGeYG9pEzYIjl9mUh
         ik2fuKn1NW7gwFCRtIwHN4H+EQZfYdL3GfX75Ab6Ndsx4Fh0EqQ57I2Ora81TvOExx9+
         hlVxrJcXvj+DEVMWsiukmxVBzW/a7Nm/DI70R5YCsjy73iH2YVFokMQWzsya5QAtqChL
         vsaejFV0nlsFdHetttxmbXMbiyg5xOWEK0GLJGut9BTk1wUC2pFLH7nbrc4WCG1m2OqW
         wWPJ3EiJpwILfPgVLwBRQJcEKdWdCHYrOkvf6ltFEyPOuBIrfaxO56QwJW37hR0ZUGzB
         IBdA==
X-Gm-Message-State: AOAM533yAykRQEFqgVoLxRh8Ov153kvAog+afwf2b+j0g/0tKGPM3BZd
        ajFLgf3dA/v0zAtJvR7gRtY4Ug==
X-Google-Smtp-Source: ABdhPJz1ek8GfT0KeD8DnVJAAL3uk+iTkBFyKHB5qADwC+qlPXChftj9SX9SK/zR80mbxWsg6DrN7Q==
X-Received: by 2002:a17:90b:94c:: with SMTP id dw12mr1895089pjb.119.1616036232560;
        Wed, 17 Mar 2021 19:57:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id na8sm382199pjb.2.2021.03.17.19.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 19:57:11 -0700 (PDT)
Date:   Wed, 17 Mar 2021 19:57:10 -0700
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
Message-ID: <202103171902.E6F55172@keescook>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-4-john.wood@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307113031.11671-4-john.wood@gmx.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 07, 2021 at 12:30:26PM +0100, John Wood wrote:
> To detect a brute force attack it is necessary that the statistics
> shared by all the fork hierarchy processes be updated in every fatal
> crash and the most important data to update is the application crash
> period. To do so, use the new "task_fatal_signal" LSM hook added in a
> previous step.
> 
> The application crash period must be a value that is not prone to change
> due to spurious data and follows the real crash period. So, to compute
> it, the exponential moving average (EMA) is used.
> 
> There are two types of brute force attacks that need to be detected. The
> first one is an attack that happens through the fork system call and the
> second one is an attack that happens through the execve system call. The
> first type uses the statistics shared by all the fork hierarchy
> processes, but the second type cannot use this statistical data due to
> these statistics disappear when the involved tasks finished. In this
> last scenario the attack info should be tracked by the statistics of a
> higher fork hierarchy (the hierarchy that contains the process that
> forks before the execve system call).
> 
> Moreover, these two attack types have two variants. A slow brute force
> attack that is detected if the maximum number of faults per fork
> hierarchy is reached and a fast brute force attack that is detected if
> the application crash period falls below a certain threshold.
> 
> Also, this patch adds locking to protect the statistics pointer hold by
> every process.
> 
> Signed-off-by: John Wood <john.wood@gmx.com>
> ---
>  security/brute/brute.c | 498 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 479 insertions(+), 19 deletions(-)
> 
> diff --git a/security/brute/brute.c b/security/brute/brute.c
> index 99d099e45112..870db55332d4 100644
> --- a/security/brute/brute.c
> +++ b/security/brute/brute.c
> @@ -11,9 +11,14 @@
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/lsm_hooks.h>
> +#include <linux/math64.h>
>  #include <linux/printk.h>
>  #include <linux/refcount.h>
> +#include <linux/rwlock.h>
> +#include <linux/rwlock_types.h>
>  #include <linux/sched.h>
> +#include <linux/sched/signal.h>
> +#include <linux/sched/task.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> @@ -37,6 +42,11 @@ struct brute_stats {
>  	u64 period;
>  };
> 
> +/*
> + * brute_stats_ptr_lock - Lock to protect the brute_stats structure pointer.
> + */
> +static DEFINE_RWLOCK(brute_stats_ptr_lock);

Yeow, you've switched from an (unneeded in prior patch) per-stats lock
to a global lock? I think this isn't needed...

> +
>  /*
>   * brute_blob_sizes - LSM blob sizes.
>   *
> @@ -74,7 +84,7 @@ static struct brute_stats *brute_new_stats(void)
>  {
>  	struct brute_stats *stats;
> 
> -	stats = kmalloc(sizeof(struct brute_stats), GFP_KERNEL);
> +	stats = kmalloc(sizeof(struct brute_stats), GFP_ATOMIC);

Why change this here? I'd just start with this in the patch that
introduces it.

>  	if (!stats)
>  		return NULL;
> 
> @@ -99,16 +109,17 @@ static struct brute_stats *brute_new_stats(void)
>   * It's mandatory to disable interrupts before acquiring the brute_stats::lock
>   * since the task_free hook can be called from an IRQ context during the
>   * execution of the task_alloc hook.
> + *
> + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> + *          held.
>   */
>  static void brute_share_stats(struct brute_stats *src,
>  			      struct brute_stats **dst)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&src->lock, flags);
> +	spin_lock(&src->lock);
>  	refcount_inc(&src->refc);
>  	*dst = src;
> -	spin_unlock_irqrestore(&src->lock, flags);
> +	spin_unlock(&src->lock);
>  }

I still don't think any locking is needed here; the whole function can
go away, IMO.

> 
>  /**
> @@ -126,26 +137,36 @@ static void brute_share_stats(struct brute_stats *src,
>   * this task and the new one being allocated. Otherwise, share the statistics
>   * that the current task already has.
>   *
> + * It's mandatory to disable interrupts before acquiring brute_stats_ptr_lock
> + * and brute_stats::lock since the task_free hook can be called from an IRQ
> + * context during the execution of the task_alloc hook.
> + *
>   * Return: -ENOMEM if the allocation of the new statistics structure fails. Zero
>   *         otherwise.
>   */
>  static int brute_task_alloc(struct task_struct *task, unsigned long clone_flags)
>  {
>  	struct brute_stats **stats, **p_stats;
> +	unsigned long flags;
> 
>  	stats = brute_stats_ptr(task);
>  	p_stats = brute_stats_ptr(current);
> +	write_lock_irqsave(&brute_stats_ptr_lock, flags);
> 
>  	if (likely(*p_stats)) {
>  		brute_share_stats(*p_stats, stats);
> +		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
>  		return 0;
>  	}
> 
>  	*stats = brute_new_stats();
> -	if (!*stats)
> +	if (!*stats) {
> +		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
>  		return -ENOMEM;
> +	}
> 
>  	brute_share_stats(*stats, p_stats);
> +	write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
>  	return 0;
>  }

I'd much prefer that whatever locking is needed be introduced in the
initial patch: this transformation just double the work to review. :)

> 
> @@ -167,9 +188,9 @@ static int brute_task_alloc(struct task_struct *task, unsigned long clone_flags)
>   * only one task (the task that calls the execve function) points to the data.
>   * In this case, the previous allocation is used but the statistics are reset.
>   *
> - * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> - * since the task_free hook can be called from an IRQ context during the
> - * execution of the bprm_committing_creds hook.
> + * It's mandatory to disable interrupts before acquiring brute_stats_ptr_lock
> + * and brute_stats::lock since the task_free hook can be called from an IRQ
> + * context during the execution of the bprm_committing_creds hook.
>   */
>  static void brute_task_execve(struct linux_binprm *bprm)
>  {
> @@ -177,24 +198,33 @@ static void brute_task_execve(struct linux_binprm *bprm)
>  	unsigned long flags;
> 
>  	stats = brute_stats_ptr(current);
> -	if (WARN(!*stats, "No statistical data\n"))
> +	read_lock_irqsave(&brute_stats_ptr_lock, flags);
> +
> +	if (WARN(!*stats, "No statistical data\n")) {
> +		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
>  		return;
> +	}
> 
> -	spin_lock_irqsave(&(*stats)->lock, flags);
> +	spin_lock(&(*stats)->lock);
> 
>  	if (!refcount_dec_not_one(&(*stats)->refc)) {
>  		/* execve call after an execve call */
>  		(*stats)->faults = 0;
>  		(*stats)->jiffies = get_jiffies_64();
>  		(*stats)->period = 0;
> -		spin_unlock_irqrestore(&(*stats)->lock, flags);
> +		spin_unlock(&(*stats)->lock);
> +		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
>  		return;
>  	}
> 
>  	/* execve call after a fork call */
> -	spin_unlock_irqrestore(&(*stats)->lock, flags);
> +	spin_unlock(&(*stats)->lock);
> +	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> +
> +	write_lock_irqsave(&brute_stats_ptr_lock, flags);
>  	*stats = brute_new_stats();
>  	WARN(!*stats, "Cannot allocate statistical data\n");
> +	write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
>  }

Again, I don't see a need for locking -- this is just managing the
lifetime which is entirely handled by the implicit locking of "current"
and the refcount_t.

> 
>  /**
> @@ -204,9 +234,9 @@ static void brute_task_execve(struct linux_binprm *bprm)
>   * The statistical data that is shared between all the fork hierarchy processes
>   * needs to be freed when this hierarchy disappears.
>   *
> - * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> - * since the task_free hook can be called from an IRQ context during the
> - * execution of the task_free hook.
> + * It's mandatory to disable interrupts before acquiring brute_stats_ptr_lock
> + * and brute_stats::lock since the task_free hook can be called from an IRQ
> + * context during the execution of the task_free hook.
>   */
>  static void brute_task_free(struct task_struct *task)
>  {
> @@ -215,17 +245,446 @@ static void brute_task_free(struct task_struct *task)
>  	bool refc_is_zero;
> 
>  	stats = brute_stats_ptr(task);
> -	if (WARN(!*stats, "No statistical data\n"))
> +	read_lock_irqsave(&brute_stats_ptr_lock, flags);
> +
> +	if (WARN(!*stats, "No statistical data\n")) {
> +		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
>  		return;
> +	}
> 
> -	spin_lock_irqsave(&(*stats)->lock, flags);
> +	spin_lock(&(*stats)->lock);
>  	refc_is_zero = refcount_dec_and_test(&(*stats)->refc);
> -	spin_unlock_irqrestore(&(*stats)->lock, flags);
> +	spin_unlock(&(*stats)->lock);
> +	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> 
>  	if (refc_is_zero) {
> +		write_lock_irqsave(&brute_stats_ptr_lock, flags);
>  		kfree(*stats);
>  		*stats = NULL;
> +		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> +	}
> +}

Same; I would expect this to be simply:

	stats = brute_stats_ptr(task);
	if (WARN_ON_ONCE(!*stats))
		return;
	if (refcount_dec_and_test(&(*stats)->refc)) {
		kfree(*stats);
		*stats = NULL;
	}

> +
> +/*
> + * BRUTE_EMA_WEIGHT_NUMERATOR - Weight's numerator of EMA.
> + */
> +static const u64 BRUTE_EMA_WEIGHT_NUMERATOR = 7;
> +
> +/*
> + * BRUTE_EMA_WEIGHT_DENOMINATOR - Weight's denominator of EMA.
> + */
> +static const u64 BRUTE_EMA_WEIGHT_DENOMINATOR = 10;

Should these be externally configurable (via sysfs)?

> +
> +/**
> + * brute_mul_by_ema_weight() - Multiply by EMA weight.
> + * @value: Value to multiply by EMA weight.
> + *
> + * Return: The result of the multiplication operation.
> + */
> +static inline u64 brute_mul_by_ema_weight(u64 value)
> +{
> +	return mul_u64_u64_div_u64(value, BRUTE_EMA_WEIGHT_NUMERATOR,
> +				   BRUTE_EMA_WEIGHT_DENOMINATOR);
> +}
> +
> +/*
> + * BRUTE_MAX_FAULTS - Maximum number of faults.
> + *
> + * If a brute force attack is running slowly for a long time, the application
> + * crash period's EMA is not suitable for the detection. This type of attack
> + * must be detected using a maximum number of faults.
> + */
> +static const unsigned char BRUTE_MAX_FAULTS = 200;

Same.

> +
> +/**
> + * brute_update_crash_period() - Update the application crash period.
> + * @stats: Statistics that hold the application crash period to update.
> + * @now: The current timestamp in jiffies.
> + *
> + * The application crash period must be a value that is not prone to change due
> + * to spurious data and follows the real crash period. So, to compute it, the
> + * exponential moving average (EMA) is used.
> + *
> + * This kind of average defines a weight (between 0 and 1) for the new value to
> + * add and applies the remainder of the weight to the current average value.
> + * This way, some spurious data will not excessively modify the average and only
> + * if the new values are persistent, the moving average will tend towards them.
> + *
> + * Mathematically the application crash period's EMA can be expressed as
> + * follows:
> + *
> + * period_ema = period * weight + period_ema * (1 - weight)
> + *
> + * If the operations are applied:
> + *
> + * period_ema = period * weight + period_ema - period_ema * weight
> + *
> + * If the operands are ordered:
> + *
> + * period_ema = period_ema - period_ema * weight + period * weight
> + *
> + * Finally, this formula can be written as follows:
> + *
> + * period_ema -= period_ema * weight;
> + * period_ema += period * weight;
> + *
> + * The statistics that hold the application crash period to update cannot be
> + * NULL.
> + *
> + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> + * since the task_free hook can be called from an IRQ context during the
> + * execution of the task_fatal_signal hook.
> + *
> + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> + *          held.
> + * Return: The last crash timestamp before updating it.
> + */
> +static u64 brute_update_crash_period(struct brute_stats *stats, u64 now)
> +{
> +	u64 current_period;
> +	u64 last_crash_timestamp;
> +
> +	spin_lock(&stats->lock);
> +	current_period = now - stats->jiffies;
> +	last_crash_timestamp = stats->jiffies;
> +	stats->jiffies = now;
> +
> +	stats->period -= brute_mul_by_ema_weight(stats->period);
> +	stats->period += brute_mul_by_ema_weight(current_period);
> +
> +	if (stats->faults < BRUTE_MAX_FAULTS)
> +		stats->faults += 1;
> +
> +	spin_unlock(&stats->lock);
> +	return last_crash_timestamp;
> +}

Now *here* locking makes sense, and it only needs to be per-stat, not
global, since multiple processes may be operating on the same stat
struct. To make this more no-reader-locking-friendly, I'd also update
everything at the end, and use WRITE_ONCE():

	u64 current_period, period;
	u64 last_crash_timestamp;
	u64 faults;

	spin_lock(&stats->lock);
	current_period = now - stats->jiffies;
	last_crash_timestamp = stats->jiffies;

	WRITE_ONCE(stats->period,
		   stats->period - brute_mul_by_ema_weight(stats->period) +
		   brute_mul_by_ema_weight(current_period));

	if (stats->faults < BRUTE_MAX_FAULTS)
		WRITE_ONCE(stats->faults, stats->faults + 1);

	WRITE_ONCE(stats->jiffies, now);

	spin_unlock(&stats->lock);
	return last_crash_timestamp;

That way readers can (IIUC) safely use READ_ONCE() on jiffies and faults
without needing to hold the &stats->lock (unless they need perfectly matching
jiffies, period, and faults).

> +
> +/*
> + * BRUTE_MIN_FAULTS - Minimum number of faults.
> + *
> + * The application crash period's EMA cannot be used until a minimum number of
> + * data has been applied to it. This constraint allows getting a trend when this
> + * moving average is used. Moreover, it avoids the scenario where an application
> + * fails quickly from execve system call due to reasons unrelated to a real
> + * attack.
> + */
> +static const unsigned char BRUTE_MIN_FAULTS = 5;
> +
> +/*
> + * BRUTE_CRASH_PERIOD_THRESHOLD - Application crash period threshold.
> + *
> + * The units are expressed in milliseconds.
> + *
> + * A fast brute force attack is detected when the application crash period falls
> + * below this threshold.
> + */
> +static const u64 BRUTE_CRASH_PERIOD_THRESHOLD = 30000;

These could all be sysctls (see yama's use of sysctl).

> +
> +/**
> + * brute_attack_running() - Test if a brute force attack is happening.
> + * @stats: Statistical data shared by all the fork hierarchy processes.
> + *
> + * The decision if a brute force attack is running is based on the statistical
> + * data shared by all the fork hierarchy processes. This statistics cannot be
> + * NULL.
> + *
> + * There are two types of brute force attacks that can be detected using the
> + * statistical data. The first one is a slow brute force attack that is detected
> + * if the maximum number of faults per fork hierarchy is reached. The second
> + * type is a fast brute force attack that is detected if the application crash
> + * period falls below a certain threshold.
> + *
> + * Moreover, it is important to note that no attacks will be detected until a
> + * minimum number of faults have occurred. This allows to have a trend in the
> + * crash period when the EMA is used and also avoids the scenario where an
> + * application fails quickly from execve system call due to reasons unrelated to
> + * a real attack.
> + *
> + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> + * since the task_free hook can be called from an IRQ context during the
> + * execution of the task_fatal_signal hook.
> + *
> + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> + *          held.
> + * Return: True if a brute force attack is happening. False otherwise.
> + */
> +static bool brute_attack_running(struct brute_stats *stats)
> +{
> +	u64 crash_period;
> +
> +	spin_lock(&stats->lock);
> +	if (stats->faults < BRUTE_MIN_FAULTS) {
> +		spin_unlock(&stats->lock);
> +		return false;
> +	}

If I'm reading this correctly, you're performing two tests, so there
isn't a strict relationship between faults and period for this test,
and I think it could be done without locking with READ_ONCE():

	u64 faults;
	u64 crash_period;

	faults = READ_ONCE(stats->faults);
	if (faults < BRUTE_MIN_FAULTS)
		return false;
	if (faults >= BRUTE_MAX_FAULTS)
		return true;

	crash_period = jiffies64_to_msecs(READ_ONCE(stats->period));
	return crash_period < BRUTE_CRASH_PERIOD_THRESHOLD;


> +
> +	if (stats->faults >= BRUTE_MAX_FAULTS) {
> +		spin_unlock(&stats->lock);
> +		return true;
> +	}
> +
> +	crash_period = jiffies64_to_msecs(stats->period);
> +	spin_unlock(&stats->lock);
> +
> +	return crash_period < BRUTE_CRASH_PERIOD_THRESHOLD;
> +}
> +
> +/**
> + * print_fork_attack_running() - Warn about a fork brute force attack.
> + */
> +static inline void print_fork_attack_running(void)
> +{
> +	pr_warn("Fork brute force attack detected [%s]\n", current->comm);
> +}

I think pid should be part of this...

> +
> +/**
> + * brute_manage_fork_attack() - Manage a fork brute force attack.
> + * @stats: Statistical data shared by all the fork hierarchy processes.
> + * @now: The current timestamp in jiffies.
> + *
> + * For a correct management of a fork brute force attack it is only necessary to
> + * update the statistics and test if an attack is happening based on these data.
> + *
> + * The statistical data shared by all the fork hierarchy processes cannot be
> + * NULL.
> + *
> + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> + * since the task_free hook can be called from an IRQ context during the
> + * execution of the task_fatal_signal hook.
> + *
> + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> + *          held.
> + * Return: The last crash timestamp before updating it.
> + */
> +static u64 brute_manage_fork_attack(struct brute_stats *stats, u64 now)
> +{
> +	u64 last_fork_crash;
> +
> +	last_fork_crash = brute_update_crash_period(stats, now);
> +	if (brute_attack_running(stats))
> +		print_fork_attack_running();
> +
> +	return last_fork_crash;
> +}
> +
> +/**
> + * brute_get_exec_stats() - Get the exec statistics.
> + * @stats: When this function is called, this parameter must point to the
> + *         current process' statistical data. When this function returns, this
> + *         parameter points to the parent process' statistics of the fork
> + *         hierarchy that hold the current process' statistics.
> + *
> + * To manage a brute force attack that happens through the execve system call it
> + * is not possible to use the statistical data hold by this process due to these
> + * statistics disappear when this task is finished. In this scenario this data
> + * should be tracked by the statistics of a higher fork hierarchy (the hierarchy
> + * that contains the process that forks before the execve system call).
> + *
> + * To find these statistics the current fork hierarchy must be traversed up
> + * until new statistics are found.
> + *
> + * Context: Must be called with tasklist_lock and brute_stats_ptr_lock held.
> + */
> +static void brute_get_exec_stats(struct brute_stats **stats)
> +{
> +	const struct task_struct *task = current;
> +	struct brute_stats **p_stats;
> +
> +	do {
> +		if (!task->real_parent) {
> +			*stats = NULL;
> +			return;
> +		}
> +
> +		p_stats = brute_stats_ptr(task->real_parent);
> +		task = task->real_parent;
> +	} while (*stats == *p_stats);
> +
> +	*stats = *p_stats;
> +}

See Yama's task_is_descendant() for how to walk up the process tree
(and I think the process group stuff will save some steps too); you
don't need tasklist_lock held, just rcu_read_lock held, AIUI:
Documentation/RCU/listRCU.rst

And since you're passing this stats struct back up, and it would be outside of rcu read lock, you'd want to do a "get" on it first:

	rcu_read_lock();
	loop {
		...
	}
	refcount_inc_not_zero(&(*p_stats)->refc);
	rcu_read_unlock();

	*stats = *p_stats



> +
> +/**
> + * brute_update_exec_crash_period() - Update the exec crash period.
> + * @stats: When this function is called, this parameter must point to the
> + *         current process' statistical data. When this function returns, this
> + *         parameter points to the updated statistics (statistics that track the
> + *         info to manage a brute force attack that happens through the execve
> + *         system call).
> + * @now: The current timestamp in jiffies.
> + * @last_fork_crash: The last fork crash timestamp before updating it.
> + *
> + * If this is the first update of the statistics used to manage a brute force
> + * attack that happens through the execve system call, its last crash timestamp
> + * (the timestamp that shows when the execve was called) cannot be used to
> + * compute the crash period's EMA. Instead, the last fork crash timestamp should
> + * be used (the last crash timestamp of the child fork hierarchy before updating
> + * the crash period). This allows that in a brute force attack that happens
> + * through the fork system call, the exec and fork statistics are the same. In
> + * this situation, the mitigation method will act only in the processes that are
> + * sharing the fork statistics. This way, the process that forked before the
> + * execve system call will not be involved in the mitigation method. In this
> + * scenario, the parent is not responsible of the child's behaviour.
> + *
> + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> + * since the task_free hook can be called from an IRQ context during the
> + * execution of the task_fatal_signal hook.
> + *
> + * Context: Must be called with interrupts disabled and tasklist_lock and
> + *          brute_stats_ptr_lock held.
> + * Return: -EFAULT if there are no exec statistics. Zero otherwise.
> + */
> +static int brute_update_exec_crash_period(struct brute_stats **stats,
> +					  u64 now, u64 last_fork_crash)
> +{
> +	brute_get_exec_stats(stats);
> +	if (!*stats)
> +		return -EFAULT;

This isn't EFAULT (userspace memory fault), but rather more EINVAL or
ESRCH.

> +
> +	spin_lock(&(*stats)->lock);
> +	if (!(*stats)->faults)
> +		(*stats)->jiffies = last_fork_crash;
> +	spin_unlock(&(*stats)->lock);
> +
> +	brute_update_crash_period(*stats, now);

and then you can add:

	if (refcount_dec_and_test(&(*stats)->refc))
		kfree(*stats);

(or better yet, make that a helper) named something like
"put_brute_stats".

> +	return 0;
> +}

I find the re-writing of **stats confusing here -- I think you should
leave that unmodified, and instead return a pointer (instead of "int"),
and for errors, use ERR_PTR(-ESRCH)

> +
> +/**
> + * brute_get_crash_period() - Get the application crash period.
> + * @stats: Statistical data shared by all the fork hierarchy processes.
> + *
> + * The statistical data shared by all the fork hierarchy processes cannot be
> + * NULL.
> + *
> + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> + * since the task_free hook can be called from an IRQ context during the
> + * execution of the task_fatal_signal hook.
> + *
> + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> + *          held.
> + * Return: The application crash period.
> + */
> +static u64 brute_get_crash_period(struct brute_stats *stats)
> +{
> +	u64 crash_period;
> +
> +	spin_lock(&stats->lock);
> +	crash_period = stats->period;
> +	spin_unlock(&stats->lock);
> +
> +	return crash_period;
> +}

return READ_ONCE(stats->period);

> +
> +/**
> + * print_exec_attack_running() - Warn about an exec brute force attack.
> + * @stats: Statistical data shared by all the fork hierarchy processes.
> + *
> + * The statistical data shared by all the fork hierarchy processes cannot be
> + * NULL.
> + *
> + * Before showing the process name it is mandatory to find a process that holds
> + * a pointer to the exec statistics.
> + *
> + * Context: Must be called with tasklist_lock and brute_stats_ptr_lock held.
> + */
> +static void print_exec_attack_running(const struct brute_stats *stats)
> +{
> +	struct task_struct *p;
> +	struct brute_stats **p_stats;
> +	bool found = false;
> +
> +	for_each_process(p) {
> +		p_stats = brute_stats_ptr(p);
> +		if (*p_stats == stats) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (WARN(!found, "No exec process\n"))
> +		return;
> +
> +	pr_warn("Exec brute force attack detected [%s]\n", p->comm);
> +}

Same logic to change here as above for talking the process list. (IIUC, since
you're only reading, you don't need tasklist_lock, just rcu_read_lock.)
But, if I'm reading this right, you only ever call this with "current".
It seems like it would be way more efficient to just use "current"
instead?

> +
> +/**
> + * brute_manage_exec_attack() - Manage an exec brute force attack.
> + * @stats: Statistical data shared by all the fork hierarchy processes.
> + * @now: The current timestamp in jiffies.
> + * @last_fork_crash: The last fork crash timestamp before updating it.
> + *
> + * For a correct management of an exec brute force attack it is only necessary
> + * to update the exec statistics and test if an attack is happening based on
> + * these data.
> + *
> + * It is important to note that if the fork and exec crash periods are the same,
> + * the attack test is avoided. This allows that in a brute force attack that
> + * happens through the fork system call, the mitigation method does not act on
> + * the parent process of the fork hierarchy.
> + *
> + * The statistical data shared by all the fork hierarchy processes cannot be
> + * NULL.
> + *
> + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> + * since the task_free hook can be called from an IRQ context during the
> + * execution of the task_fatal_signal hook.
> + *
> + * Context: Must be called with interrupts disabled and tasklist_lock and
> + *          brute_stats_ptr_lock held.
> + */
> +static void brute_manage_exec_attack(struct brute_stats *stats, u64 now,
> +				     u64 last_fork_crash)
> +{
> +	int ret;
> +	struct brute_stats *exec_stats = stats;
> +	u64 fork_period;
> +	u64 exec_period;
> +
> +	ret = brute_update_exec_crash_period(&exec_stats, now, last_fork_crash);
> +	if (WARN(ret, "No exec statistical data\n"))
> +		return;

I think this should fail closed: if there's a static processing error,
treat it as an attack.

> +
> +	fork_period = brute_get_crash_period(stats);
> +	exec_period = brute_get_crash_period(exec_stats);
> +	if (fork_period == exec_period)
> +		return;
> +
> +	if (brute_attack_running(exec_stats))
> +		print_exec_attack_running(exec_stats);
> +}
> +
> +/**
> + * brute_task_fatal_signal() - Target for the task_fatal_signal hook.
> + * @siginfo: Contains the signal information.
> + *
> + * To detect a brute force attack is necessary to update the fork and exec
> + * statistics in every fatal crash and act based on these data.
> + *
> + * It's mandatory to disable interrupts before acquiring brute_stats_ptr_lock
> + * and brute_stats::lock since the task_free hook can be called from an IRQ
> + * context during the execution of the task_fatal_signal hook.
> + */
> +static void brute_task_fatal_signal(const kernel_siginfo_t *siginfo)
> +{
> +	struct brute_stats **stats;
> +	unsigned long flags;
> +	u64 last_fork_crash;
> +	u64 now = get_jiffies_64();
> +
> +	stats = brute_stats_ptr(current);
> +	read_lock(&tasklist_lock);
> +	read_lock_irqsave(&brute_stats_ptr_lock, flags);
> +
> +	if (WARN(!*stats, "No statistical data\n")) {
> +		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> +		read_unlock(&tasklist_lock);
> +		return;
>  	}
> +
> +	last_fork_crash = brute_manage_fork_attack(*stats, now);
> +	brute_manage_exec_attack(*stats, now, last_fork_crash);
> +	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> +	read_unlock(&tasklist_lock);
>  }
> 
>  /*
> @@ -235,6 +694,7 @@ static struct security_hook_list brute_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(task_alloc, brute_task_alloc),
>  	LSM_HOOK_INIT(bprm_committing_creds, brute_task_execve),
>  	LSM_HOOK_INIT(task_free, brute_task_free),
> +	LSM_HOOK_INIT(task_fatal_signal, brute_task_fatal_signal),
>  };
> 
>  /**
> --
> 2.25.1
> 

I think this is very close!

-- 
Kees Cook
