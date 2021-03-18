Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895C833FDF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 05:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhCREA7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Mar 2021 00:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhCREAy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Mar 2021 00:00:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DCFC061760
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 21:00:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ha17so2220090pjb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 21:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+PDx2ETSsybyjv8lYQbaCw0/ZC3EaF/6hDbP8WAdDDU=;
        b=jmpF1oVKhThnjlKFRGjhQ0GZ7IYC+dhw+ayMCDgBw+Fia716dImqvugbnVflyMckx8
         p317YipYasW7GCD1fyQfrAyR6D2/HXMUi9HhWs6ma+VmyMRCIa7z4eSyv51/JQlIercb
         1FgbCtCoNobngirV5lpcYkqZ2lEisya26YXRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+PDx2ETSsybyjv8lYQbaCw0/ZC3EaF/6hDbP8WAdDDU=;
        b=aA2siFSi7SAXqpfrvq6MkA1kCra3AEHvVvV5/7K9dJr1fOcx9RbgFmu2VySvy6Ks9Q
         Zs6Oic3PPyPN/jOnd7n8Dw7KdZT29xB24fj4HJXZEkxqNuKXqdghTOWo6xv8CopfHNW/
         +ZBC4mWMP/nLDMz3JQbMEaCgDjO44V0shQSkWmNdkn2iMgX2gJcV4GQlSxwIcJzRHO1Y
         DAI+XquLlcgt7+2M1sAS7s9yqOvzSt+9YbIr4Nu3I+/CbSWTVYLOytzqhtjx07rqXhoo
         WR9DHpoY3U7ZHrcIiSsdlsas5BGUMQk2yekNeEKt4ScWPDGoXcn/Ml7V8SNUVNkiHx1J
         zntg==
X-Gm-Message-State: AOAM530gOdp/O6O7AFIw80gyPhEEbDU0NikF6cIWAwQhNPm3eHpfR29V
        pGj0Kops8LQ/SVmif4ZwNfsqXw==
X-Google-Smtp-Source: ABdhPJzW+YGhgIHxGj6CBZjbiZVHcmu4AVXFh3OPUFjbCMhGQJExLvQcQbeDC73TQ09/77sGT1pbqA==
X-Received: by 2002:a17:902:ecc3:b029:e5:d7cc:2a20 with SMTP id a3-20020a170902ecc3b02900e5d7cc2a20mr7553690plh.11.1616040053272;
        Wed, 17 Mar 2021 21:00:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x19sm536144pfc.152.2021.03.17.21.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 21:00:52 -0700 (PDT)
Date:   Wed, 17 Mar 2021 21:00:51 -0700
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
Subject: Re: [PATCH v6 4/8] security/brute: Fine tuning the attack detection
Message-ID: <202103171957.16C0560D@keescook>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-5-john.wood@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307113031.11671-5-john.wood@gmx.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 07, 2021 at 12:30:27PM +0100, John Wood wrote:
> To avoid false positives during the attack detection it is necessary to
> narrow the possible cases. Only the following scenarios are taken into
> account:
> 
> 1.- Launching (fork()/exec()) a setuid/setgid process repeatedly until a
>     desirable memory layout is got (e.g. Stack Clash).
> 2.- Connecting to an exec()ing network daemon (e.g. xinetd) repeatedly
>     until a desirable memory layout is got (e.g. what CTFs do for simple
>     network service).
> 3.- Launching processes without exec() (e.g. Android Zygote) and exposing
>     state to attack a sibling.
> 4.- Connecting to a fork()ing network daemon (e.g. apache) repeatedly until
>     the previously shared memory layout of all the other children is
>     exposed (e.g. kind of related to HeartBleed).
> 
> In each case, a privilege boundary has been crossed:
> 
> Case 1: setuid/setgid process
> Case 2: network to local
> Case 3: privilege changes
> Case 4: network to local
> 
> So, this patch checks if any of these privilege boundaries have been
> crossed before to compute the application crash period.
> 
> Also, in every fatal crash only the signals delivered by the kernel are
> taken into account with the exception of the SIGABRT signal since the
> latter is used by glibc for stack canary, malloc, etc failures, which may
> indicate that a mitigation has been triggered.
> 
> Signed-off-by: John Wood <john.wood@gmx.com>
> ---
>  security/brute/brute.c | 293 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 280 insertions(+), 13 deletions(-)
> 
> diff --git a/security/brute/brute.c b/security/brute/brute.c
> index 870db55332d4..38e5e050964a 100644
> --- a/security/brute/brute.c
> +++ b/security/brute/brute.c
> @@ -3,15 +3,25 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
>  #include <asm/current.h>
> +#include <asm/rwonce.h>
> +#include <asm/siginfo.h>
> +#include <asm/signal.h>
> +#include <linux/binfmts.h>
>  #include <linux/bug.h>
>  #include <linux/compiler.h>
> +#include <linux/cred.h>
> +#include <linux/dcache.h>
>  #include <linux/errno.h>
> +#include <linux/fs.h>
>  #include <linux/gfp.h>
> +#include <linux/if.h>
>  #include <linux/init.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/math64.h>
> +#include <linux/netdevice.h>
> +#include <linux/path.h>
>  #include <linux/printk.h>
>  #include <linux/refcount.h>
>  #include <linux/rwlock.h>
> @@ -19,9 +29,35 @@
>  #include <linux/sched.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/task.h>
> +#include <linux/signal.h>
> +#include <linux/skbuff.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/stat.h>
>  #include <linux/types.h>
> +#include <linux/uidgid.h>

This is really a LOT of includes. Are you sure all of these are
explicitly needed?

> +
> +/**
> + * struct brute_cred - Saved credentials.
> + * @uid: Real UID of the task.
> + * @gid: Real GID of the task.
> + * @suid: Saved UID of the task.
> + * @sgid: Saved GID of the task.
> + * @euid: Effective UID of the task.
> + * @egid: Effective GID of the task.
> + * @fsuid: UID for VFS ops.
> + * @fsgid: GID for VFS ops.
> + */
> +struct brute_cred {
> +	kuid_t uid;
> +	kgid_t gid;
> +	kuid_t suid;
> +	kgid_t sgid;
> +	kuid_t euid;
> +	kgid_t egid;
> +	kuid_t fsuid;
> +	kgid_t fsgid;
> +};
> 
>  /**
>   * struct brute_stats - Fork brute force attack statistics.
> @@ -30,6 +66,9 @@
>   * @faults: Number of crashes.
>   * @jiffies: Last crash timestamp.
>   * @period: Crash period's moving average.
> + * @saved_cred: Saved credentials.
> + * @network: Network activity flag.
> + * @bounds_crossed: Privilege bounds crossed flag.
>   *
>   * This structure holds the statistical data shared by all the fork hierarchy
>   * processes.
> @@ -40,6 +79,9 @@ struct brute_stats {
>  	unsigned char faults;
>  	u64 jiffies;
>  	u64 period;
> +	struct brute_cred saved_cred;
> +	unsigned char network : 1;
> +	unsigned char bounds_crossed : 1;

If you really want to keep faults a "char", I would move these bools
after "faults" to avoid adding more padding.

>  };
> 
>  /*
> @@ -71,18 +113,25 @@ static inline struct brute_stats **brute_stats_ptr(struct task_struct *task)
> 
>  /**
>   * brute_new_stats() - Allocate a new statistics structure.
> + * @network_to_local: Network activity followed by a fork or execve system call.
> + * @is_setid: The executable file has the setid flags set.
>   *
>   * If the allocation is successful the reference counter is set to one to
>   * indicate that there will be one task that points to this structure. Also, the
>   * last crash timestamp is set to now. This way, it is possible to compute the
>   * application crash period at the first fault.
>   *
> + * Moreover, the credentials of the current task are saved. Also, the network
> + * and bounds_crossed flags are set based on the network_to_local and is_setid
> + * parameters.
> + *
>   * Return: NULL if the allocation fails. A pointer to the new allocated
>   *         statistics structure if it success.
>   */
> -static struct brute_stats *brute_new_stats(void)
> +static struct brute_stats *brute_new_stats(bool network_to_local, bool is_setid)
>  {
>  	struct brute_stats *stats;
> +	const struct cred *cred = current_cred();
> 
>  	stats = kmalloc(sizeof(struct brute_stats), GFP_ATOMIC);
>  	if (!stats)
> @@ -93,6 +142,16 @@ static struct brute_stats *brute_new_stats(void)
>  	stats->faults = 0;
>  	stats->jiffies = get_jiffies_64();
>  	stats->period = 0;
> +	stats->saved_cred.uid = cred->uid;
> +	stats->saved_cred.gid = cred->gid;
> +	stats->saved_cred.suid = cred->suid;
> +	stats->saved_cred.sgid = cred->sgid;
> +	stats->saved_cred.euid = cred->euid;
> +	stats->saved_cred.egid = cred->egid;
> +	stats->saved_cred.fsuid = cred->fsuid;
> +	stats->saved_cred.fsgid = cred->fsgid;

Hm, there's more than just uids to check for perms, but I'll go read
more...

> +	stats->network = network_to_local;
> +	stats->bounds_crossed = network_to_local || is_setid;
> 
>  	return stats;
>  }
> @@ -137,6 +196,10 @@ static void brute_share_stats(struct brute_stats *src,
>   * this task and the new one being allocated. Otherwise, share the statistics
>   * that the current task already has.
>   *
> + * Also, if the shared statistics indicate a previous network activity, the
> + * bounds_crossed flag must be set to show that a network-to-local privilege
> + * boundary has been crossed.
> + *
>   * It's mandatory to disable interrupts before acquiring brute_stats_ptr_lock
>   * and brute_stats::lock since the task_free hook can be called from an IRQ
>   * context during the execution of the task_alloc hook.
> @@ -155,11 +218,14 @@ static int brute_task_alloc(struct task_struct *task, unsigned long clone_flags)
> 
>  	if (likely(*p_stats)) {
>  		brute_share_stats(*p_stats, stats);
> +		spin_lock(&(*stats)->lock);
> +		(*stats)->bounds_crossed |= (*stats)->network;
> +		spin_unlock(&(*stats)->lock);
>  		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
>  		return 0;
>  	}
> 
> -	*stats = brute_new_stats();
> +	*stats = brute_new_stats(false, false);
>  	if (!*stats) {
>  		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
>  		return -ENOMEM;
> @@ -170,6 +236,61 @@ static int brute_task_alloc(struct task_struct *task, unsigned long clone_flags)
>  	return 0;
>  }
> 
> +/**
> + * brute_is_setid() - Test if the executable file has the setid flags set.
> + * @bprm: Points to the linux_binprm structure.
> + *
> + * Return: True if the executable file has the setid flags set. False otherwise.
> + */
> +static bool brute_is_setid(const struct linux_binprm *bprm)
> +{
> +	struct file *file = bprm->file;
> +	struct inode *inode;
> +	umode_t mode;
> +
> +	if (!file)
> +		return false;
> +
> +	inode = file->f_path.dentry->d_inode;
> +	mode = inode->i_mode;
> +
> +	return !!(mode & (S_ISUID | S_ISGID));
> +}

Oh, er, no, this should not reinvent the wheel. You just want to know if
creds got elevated, so you want bprm->secureexec; this gets correctly
checked in cap_bprm_creds_from_file().

> +
> +/**
> + * brute_reset_stats() - Reset the statistical data.
> + * @stats: Statistics to be reset.
> + * @is_setid: The executable file has the setid flags set.
> + *
> + * Reset the faults and period and set the last crash timestamp to now. This
> + * way, it is possible to compute the application crash period at the next
> + * fault. Also, save the credentials of the current task and update the
> + * bounds_crossed flag based on a previous network activity and the is_setid
> + * parameter.
> + *
> + * The statistics to be reset cannot be NULL.
> + *
> + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> + *          and brute_stats::lock held.
> + */
> +static void brute_reset_stats(struct brute_stats *stats, bool is_setid)
> +{
> +	const struct cred *cred = current_cred();
> +
> +	stats->faults = 0;
> +	stats->jiffies = get_jiffies_64();
> +	stats->period = 0;
> +	stats->saved_cred.uid = cred->uid;
> +	stats->saved_cred.gid = cred->gid;
> +	stats->saved_cred.suid = cred->suid;
> +	stats->saved_cred.sgid = cred->sgid;
> +	stats->saved_cred.euid = cred->euid;
> +	stats->saved_cred.egid = cred->egid;
> +	stats->saved_cred.fsuid = cred->fsuid;
> +	stats->saved_cred.fsgid = cred->fsgid;
> +	stats->bounds_crossed = stats->network || is_setid;
> +}

I would include brute_reset_stats() in the first patch (and add to it as
needed). To that end, it can start with a memset(stats, 0, sizeof(*stats));

> +
>  /**
>   * brute_task_execve() - Target for the bprm_committing_creds hook.
>   * @bprm: Points to the linux_binprm structure.
> @@ -188,6 +309,11 @@ static int brute_task_alloc(struct task_struct *task, unsigned long clone_flags)
>   * only one task (the task that calls the execve function) points to the data.
>   * In this case, the previous allocation is used but the statistics are reset.
>   *
> + * Also, if the statistics of the process that calls the execve system call
> + * indicate a previous network activity or the executable file has the setid
> + * flags set, the bounds_crossed flag must be set to show that a network to
> + * local privilege boundary or setid boundary has been crossed respectively.
> + *
>   * It's mandatory to disable interrupts before acquiring brute_stats_ptr_lock
>   * and brute_stats::lock since the task_free hook can be called from an IRQ
>   * context during the execution of the bprm_committing_creds hook.
> @@ -196,6 +322,8 @@ static void brute_task_execve(struct linux_binprm *bprm)
>  {
>  	struct brute_stats **stats;
>  	unsigned long flags;
> +	bool network_to_local;
> +	bool is_setid = false;
> 
>  	stats = brute_stats_ptr(current);
>  	read_lock_irqsave(&brute_stats_ptr_lock, flags);
> @@ -206,12 +334,18 @@ static void brute_task_execve(struct linux_binprm *bprm)
>  	}
> 
>  	spin_lock(&(*stats)->lock);
> +	network_to_local = (*stats)->network;
> +
> +	/*
> +	 * A network_to_local flag equal to true will set the bounds_crossed
> +	 * flag. So, in this scenario the "is setid" test can be avoided.
> +	 */
> +	if (!network_to_local)
> +		is_setid = brute_is_setid(bprm);
> 
>  	if (!refcount_dec_not_one(&(*stats)->refc)) {
>  		/* execve call after an execve call */
> -		(*stats)->faults = 0;
> -		(*stats)->jiffies = get_jiffies_64();
> -		(*stats)->period = 0;
> +		brute_reset_stats(*stats, is_setid);
>  		spin_unlock(&(*stats)->lock);
>  		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
>  		return;
> @@ -222,7 +356,7 @@ static void brute_task_execve(struct linux_binprm *bprm)
>  	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> 
>  	write_lock_irqsave(&brute_stats_ptr_lock, flags);
> -	*stats = brute_new_stats();
> +	*stats = brute_new_stats(network_to_local, is_setid);
>  	WARN(!*stats, "Cannot allocate statistical data\n");
>  	write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
>  }
> @@ -653,12 +787,103 @@ static void brute_manage_exec_attack(struct brute_stats *stats, u64 now,
>  		print_exec_attack_running(exec_stats);
>  }
> 
> +/**
> + * brute_priv_have_changed() - Test if the privileges have changed.
> + * @stats: Statistics that hold the saved credentials.
> + *
> + * The privileges have changed if the credentials of the current task are
> + * different from the credentials saved in the statistics structure.
> + *
> + * The statistics that hold the saved credentials cannot be NULL.
> + *
> + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> + *          and brute_stats::lock held.
> + * Return: True if the privileges have changed. False otherwise.
> + */
> +static bool brute_priv_have_changed(struct brute_stats *stats)
> +{
> +	const struct cred *cred = current_cred();
> +	bool priv_have_changed;
> +
> +	priv_have_changed = !uid_eq(stats->saved_cred.uid, cred->uid) ||
> +		!gid_eq(stats->saved_cred.gid, cred->gid) ||
> +		!uid_eq(stats->saved_cred.suid, cred->suid) ||
> +		!gid_eq(stats->saved_cred.sgid, cred->sgid) ||
> +		!uid_eq(stats->saved_cred.euid, cred->euid) ||
> +		!gid_eq(stats->saved_cred.egid, cred->egid) ||
> +		!uid_eq(stats->saved_cred.fsuid, cred->fsuid) ||
> +		!gid_eq(stats->saved_cred.fsgid, cred->fsgid);
> +
> +	return priv_have_changed;
> +}

This should just be checked from bprm->secureexec, which is valid by the
time you get to the bprm_committing_creds hook. You can just save the
value to your stats struct instead of re-interrogating current_cred,
etc.

> +
> +/**
> + * brute_threat_model_supported() - Test if the threat model is supported.
> + * @siginfo: Contains the signal information.
> + * @stats: Statistical data shared by all the fork hierarchy processes.
> + *
> + * To avoid false positives during the attack detection it is necessary to
> + * narrow the possible cases. Only the following scenarios are taken into
> + * account:
> + *
> + * 1.- Launching (fork()/exec()) a setuid/setgid process repeatedly until a
> + *     desirable memory layout is got (e.g. Stack Clash).
> + * 2.- Connecting to an exec()ing network daemon (e.g. xinetd) repeatedly until
> + *     a desirable memory layout is got (e.g. what CTFs do for simple network
> + *     service).
> + * 3.- Launching processes without exec() (e.g. Android Zygote) and exposing
> + *     state to attack a sibling.
> + * 4.- Connecting to a fork()ing network daemon (e.g. apache) repeatedly until
> + *     the previously shared memory layout of all the other children is exposed
> + *     (e.g. kind of related to HeartBleed).
> + *
> + * In each case, a privilege boundary has been crossed:
> + *
> + * Case 1: setuid/setgid process
> + * Case 2: network to local
> + * Case 3: privilege changes
> + * Case 4: network to local
> + *
> + * Also, only the signals delivered by the kernel are taken into account with
> + * the exception of the SIGABRT signal since the latter is used by glibc for
> + * stack canary, malloc, etc failures, which may indicate that a mitigation has
> + * been triggered.
> + *
> + * The signal information and the statistical data shared by all the fork
> + * hierarchy processes cannot be NULL.
> + *
> + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> + * since the task_free hook can be called from an IRQ context during the
> + * execution of the task_fatal_signal hook.
> + *
> + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> + *          held.
> + * Return: True if the threat model is supported. False otherwise.
> + */
> +static bool brute_threat_model_supported(const kernel_siginfo_t *siginfo,
> +					 struct brute_stats *stats)
> +{
> +	bool bounds_crossed;
> +
> +	if (siginfo->si_signo == SIGKILL && siginfo->si_code != SIGABRT)
> +		return false;
> +
> +	spin_lock(&stats->lock);
> +	bounds_crossed = stats->bounds_crossed;
> +	bounds_crossed = bounds_crossed || brute_priv_have_changed(stats);
> +	stats->bounds_crossed = bounds_crossed;
> +	spin_unlock(&stats->lock);
> +
> +	return bounds_crossed;
> +}

I think this logic can be done with READ_ONCE()s and moved directly into
brute_task_fatal_signal().

> +
>  /**
>   * brute_task_fatal_signal() - Target for the task_fatal_signal hook.
>   * @siginfo: Contains the signal information.
>   *
> - * To detect a brute force attack is necessary to update the fork and exec
> - * statistics in every fatal crash and act based on these data.
> + * To detect a brute force attack it is necessary, as a first step, to test in
> + * every fatal crash if the threat model is supported. If so, update the fork
> + * and exec statistics and act based on these data.
>   *
>   * It's mandatory to disable interrupts before acquiring brute_stats_ptr_lock
>   * and brute_stats::lock since the task_free hook can be called from an IRQ
> @@ -675,18 +900,59 @@ static void brute_task_fatal_signal(const kernel_siginfo_t *siginfo)
>  	read_lock(&tasklist_lock);
>  	read_lock_irqsave(&brute_stats_ptr_lock, flags);
> 
> -	if (WARN(!*stats, "No statistical data\n")) {
> -		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> -		read_unlock(&tasklist_lock);
> -		return;
> -	}
> +	if (WARN(!*stats, "No statistical data\n"))
> +		goto unlock;
> +
> +	if (!brute_threat_model_supported(siginfo, *stats))
> +		goto unlock;
> 
>  	last_fork_crash = brute_manage_fork_attack(*stats, now);
>  	brute_manage_exec_attack(*stats, now, last_fork_crash);
> +unlock:
>  	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
>  	read_unlock(&tasklist_lock);
>  }
> 
> +/**
> + * brute_network() - Target for the socket_sock_rcv_skb hook.
> + * @sk: Contains the sock (not socket) associated with the incoming sk_buff.
> + * @skb: Contains the incoming network data.
> + *
> + * A previous step to detect that a network to local boundary has been crossed
> + * is to detect if there is network activity. To do this, it is only necessary
> + * to check if there are data packets received from a network device other than
> + * loopback.
> + *
> + * It's mandatory to disable interrupts before acquiring brute_stats_ptr_lock
> + * and brute_stats::lock since the task_free hook can be called from an IRQ
> + * context during the execution of the socket_sock_rcv_skb hook.
> + *
> + * Return: -EFAULT if the current task doesn't have statistical data. Zero
> + *         otherwise.
> + */
> +static int brute_network(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct brute_stats **stats;
> +	unsigned long flags;
> +
> +	if (!skb->dev || (skb->dev->flags & IFF_LOOPBACK))
> +		return 0;
> +
> +	stats = brute_stats_ptr(current);

Uhh, is "current" valid here? I actually don't know this hook very well.

> +	read_lock_irqsave(&brute_stats_ptr_lock, flags);
> +
> +	if (!*stats) {
> +		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> +		return -EFAULT;
> +	}
> +
> +	spin_lock(&(*stats)->lock);
> +	(*stats)->network = true;
> +	spin_unlock(&(*stats)->lock);
> +	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> +	return 0;
> +}
> +
>  /*
>   * brute_hooks - Targets for the LSM's hooks.
>   */
> @@ -695,6 +961,7 @@ static struct security_hook_list brute_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(bprm_committing_creds, brute_task_execve),
>  	LSM_HOOK_INIT(task_free, brute_task_free),
>  	LSM_HOOK_INIT(task_fatal_signal, brute_task_fatal_signal),
> +	LSM_HOOK_INIT(socket_sock_rcv_skb, brute_network),
>  };
> 
>  /**
> --
> 2.25.1
> 

-- 
Kees Cook
