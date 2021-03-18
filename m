Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67C533FCFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 03:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhCRCBX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 22:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhCRCA6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 22:00:58 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B4AC061760
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 19:00:58 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y27so414646pga.9
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 19:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bVErJGRzRSjUr14yCp657n5P09FwYeAA+Os+oEu+/68=;
        b=XlFoVsBEe3Isz7ISKO3OwMqARE4O4Y1sTI/dCSCily/8KVVXjwo+u9/vEeMnNetcDV
         /h1bfAb6b51lG6JSPfPgBUPM6WaLkd/5p9LbBfjh8uvJvW9SwSFzwJaaLzPSYxzbclGF
         VcGLVOPJGS76R9sjWp2gKCVbojXAJWarl9tuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bVErJGRzRSjUr14yCp657n5P09FwYeAA+Os+oEu+/68=;
        b=Z6vOnZkiyYVG7NddpdbdCHMKfTRyplLrwGLY/1eThhm/IlfbnIajsfUQUlJk5dLWYT
         BZAlkBNGJ2MmOvae/yDhl8wF30DVBQqhhD2uVfX0Khru5djxGCVbzx2W5e7m+blJWpNH
         TXKfc81P2T545r7DENF7wPXzK79pVmaV8WVvOaL3NBXfSpqe/H4HGj41u57Z1m4wf0wh
         Z1HxM5jHV1v5H1oT8+kf1wpcS9kCOq8a3IZ312/FTjX5Gwlj5YrjyH98IimnOur+RSTJ
         uOBlYAQJFDIHru562HnnSUGLW22LaFXfTMUSxvbxEH5C9qhmvQYvJKVFmZnsCr9MffCF
         3FpQ==
X-Gm-Message-State: AOAM532mcPQNmVYpBAFmq85W1iXsehP/FI6N+q8zalIkRk5XnGXmEu/c
        7o+Jo91Cn9PAFRFv8WlFIim3Zg==
X-Google-Smtp-Source: ABdhPJww/Vz9CVjYY9uEK0S0uZlHGIgREFKsnH7Z3u9YBvqRXRF2hG5uhC4OAs+OPUrX312Heh7KDg==
X-Received: by 2002:aa7:8f04:0:b029:1f7:d71b:6a51 with SMTP id x4-20020aa78f040000b02901f7d71b6a51mr1783844pfr.4.1616032857662;
        Wed, 17 Mar 2021 19:00:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n16sm324545pff.119.2021.03.17.19.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 19:00:56 -0700 (PDT)
Date:   Wed, 17 Mar 2021 19:00:56 -0700
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
Subject: Re: [PATCH v6 2/8] security/brute: Define a LSM and manage
 statistical data
Message-ID: <202103171823.E7F64A593@keescook>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-3-john.wood@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307113031.11671-3-john.wood@gmx.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 07, 2021 at 12:30:25PM +0100, John Wood wrote:
> Add a new Kconfig file to define a menu entry under "Security options"
> to enable the "Fork brute force attack detection and mitigation"
> feature.
> 
> For a correct management of a fork brute force attack it is necessary
> that all the tasks hold statistical data. The same statistical data
> needs to be shared between all the tasks that hold the same memory
> contents or in other words, between all the tasks that have been forked
> without any execve call. So, define a statistical data structure to hold
> all the necessary information shared by all the fork hierarchy
> processes. This info is basically the number of crashes, the last crash
> timestamp and the crash period's moving average.
> 
> When a forked task calls the execve system call, the memory contents are
> set with new values. So, in this scenario the parent's statistical data
> no need to be shared. Instead, a new statistical data structure must be
> allocated to start a new hierarchy.
> 
> The statistical data that is shared between all the fork hierarchy
> processes needs to be freed when this hierarchy disappears.
> 
> So, based in all the previous information define a LSM with three hooks
> to manage all the commented cases. These hooks are "task_alloc" to do
> the fork management, "bprm_committing_creds" to do the execve management
> and "task_free" to release the resources.
> 
> Also, add to the task_struct's security blob the pointer to the
> statistical data. This way, all the tasks will have access to this
> information.
> 
> Signed-off-by: John Wood <john.wood@gmx.com>
> ---
>  security/Kconfig        |  11 +-
>  security/Makefile       |   4 +
>  security/brute/Kconfig  |  12 ++
>  security/brute/Makefile |   2 +
>  security/brute/brute.c  | 257 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 281 insertions(+), 5 deletions(-)
>  create mode 100644 security/brute/Kconfig
>  create mode 100644 security/brute/Makefile
>  create mode 100644 security/brute/brute.c
> 
> diff --git a/security/Kconfig b/security/Kconfig
> index 7561f6f99f1d..204bb311b1f1 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -240,6 +240,7 @@ source "security/safesetid/Kconfig"
>  source "security/lockdown/Kconfig"
> 
>  source "security/integrity/Kconfig"
> +source "security/brute/Kconfig"
> 
>  choice
>  	prompt "First legacy 'major LSM' to be initialized"
> @@ -277,11 +278,11 @@ endchoice
> 
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> -	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> -	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> -	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> -	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
> +	default "brute,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> +	default "brute,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> +	default "brute,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> +	default "brute,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> +	default "brute,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

It probably doesn't matter much, but I think brute should be added
between lockdown and yama.

>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list will be ignored. This can be
> diff --git a/security/Makefile b/security/Makefile
> index 3baf435de541..1236864876da 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -36,3 +36,7 @@ obj-$(CONFIG_BPF_LSM)			+= bpf/
>  # Object integrity file lists
>  subdir-$(CONFIG_INTEGRITY)		+= integrity
>  obj-$(CONFIG_INTEGRITY)			+= integrity/
> +
> +# Object brute file lists
> +subdir-$(CONFIG_SECURITY_FORK_BRUTE)	+= brute
> +obj-$(CONFIG_SECURITY_FORK_BRUTE)	+= brute/

I don't think subdir is needed here? I think you can use obj-... like
loadpin, etc.

> diff --git a/security/brute/Kconfig b/security/brute/Kconfig
> new file mode 100644
> index 000000000000..1bd2df1e2dec
> --- /dev/null
> +++ b/security/brute/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config SECURITY_FORK_BRUTE
> +	bool "Fork brute force attack detection and mitigation"
> +	depends on SECURITY
> +	help
> +	  This is an LSM that stops any fork brute force attack against
> +	  vulnerable userspace processes. The detection method is based on
> +	  the application crash period and as a mitigation procedure all the
> +	  offending tasks are killed. Like capabilities, this security module
> +	  stacks with other LSMs.

I'm not sure the stacking needs mentioning, but okay. :)

> +
> +	  If you are unsure how to answer this question, answer N.
> diff --git a/security/brute/Makefile b/security/brute/Makefile
> new file mode 100644
> index 000000000000..d3f233a132a9
> --- /dev/null
> +++ b/security/brute/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_SECURITY_FORK_BRUTE) += brute.o
> diff --git a/security/brute/brute.c b/security/brute/brute.c
> new file mode 100644
> index 000000000000..99d099e45112
> --- /dev/null
> +++ b/security/brute/brute.c
> @@ -0,0 +1,257 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <asm/current.h>

Why is this needed?

> +#include <linux/bug.h>
> +#include <linux/compiler.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/init.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/lsm_hooks.h>
> +#include <linux/printk.h>
> +#include <linux/refcount.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +/**
> + * struct brute_stats - Fork brute force attack statistics.
> + * @lock: Lock to protect the brute_stats structure.
> + * @refc: Reference counter.
> + * @faults: Number of crashes.
> + * @jiffies: Last crash timestamp.
> + * @period: Crash period's moving average.
> + *
> + * This structure holds the statistical data shared by all the fork hierarchy
> + * processes.
> + */
> +struct brute_stats {
> +	spinlock_t lock;
> +	refcount_t refc;
> +	unsigned char faults;
> +	u64 jiffies;
> +	u64 period;
> +};

I assume the max-255 "faults" will be explained... why is this so small?

> +
> +/*
> + * brute_blob_sizes - LSM blob sizes.
> + *
> + * To share statistical data among all the fork hierarchy processes, define a
> + * pointer to the brute_stats structure as a part of the task_struct's security
> + * blob.
> + */
> +static struct lsm_blob_sizes brute_blob_sizes __lsm_ro_after_init = {
> +	.lbs_task = sizeof(struct brute_stats *),
> +};
> +
> +/**
> + * brute_stats_ptr() - Get the pointer to the brute_stats structure.
> + * @task: Task that holds the statistical data.
> + *
> + * Return: A pointer to a pointer to the brute_stats structure.
> + */
> +static inline struct brute_stats **brute_stats_ptr(struct task_struct *task)
> +{
> +	return task->security + brute_blob_sizes.lbs_task;
> +}
> +
> +/**
> + * brute_new_stats() - Allocate a new statistics structure.
> + *
> + * If the allocation is successful the reference counter is set to one to
> + * indicate that there will be one task that points to this structure. Also, the
> + * last crash timestamp is set to now. This way, it is possible to compute the
> + * application crash period at the first fault.
> + *
> + * Return: NULL if the allocation fails. A pointer to the new allocated
> + *         statistics structure if it success.
> + */
> +static struct brute_stats *brute_new_stats(void)
> +{
> +	struct brute_stats *stats;
> +
> +	stats = kmalloc(sizeof(struct brute_stats), GFP_KERNEL);
> +	if (!stats)
> +		return NULL;

Since this is tied to process creation, I think it might make sense to
have a dedicated kmem cache for this (instead of using the "generic"
kmalloc). See kmem_cache_{create,*alloc,free}

> +
> +	spin_lock_init(&stats->lock);
> +	refcount_set(&stats->refc, 1);
> +	stats->faults = 0;
> +	stats->jiffies = get_jiffies_64();
> +	stats->period = 0;

And either way, I'd recommend using the "z" variant of the allocator
(kmem_cache_zalloc, kzalloc) to pre-zero everything (and then you can
drop the "= 0" lines here).

> +
> +	return stats;
> +}
> +
> +/**
> + * brute_share_stats() - Share the statistical data between processes.
> + * @src: Source of statistics to be shared.
> + * @dst: Destination of statistics to be shared.
> + *
> + * Copy the src's pointer to the statistical data structure to the dst's pointer
> + * to the same structure. Since there is a new process that shares the same
> + * data, increase the reference counter. The src's pointer cannot be NULL.
> + *
> + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> + * since the task_free hook can be called from an IRQ context during the
> + * execution of the task_alloc hook.
> + */
> +static void brute_share_stats(struct brute_stats *src,
> +			      struct brute_stats **dst)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&src->lock, flags);
> +	refcount_inc(&src->refc);
> +	*dst = src;
> +	spin_unlock_irqrestore(&src->lock, flags);
> +}
> +
> +/**
> + * brute_task_alloc() - Target for the task_alloc hook.
> + * @task: Task being allocated.
> + * @clone_flags: Contains the flags indicating what should be shared.
> + *
> + * For a correct management of a fork brute force attack it is necessary that
> + * all the tasks hold statistical data. The same statistical data needs to be
> + * shared between all the tasks that hold the same memory contents or in other
> + * words, between all the tasks that have been forked without any execve call.
> + *
> + * To ensure this, if the current task doesn't have statistical data when forks,
> + * it is mandatory to allocate a new statistics structure and share it between
> + * this task and the new one being allocated. Otherwise, share the statistics
> + * that the current task already has.
> + *
> + * Return: -ENOMEM if the allocation of the new statistics structure fails. Zero
> + *         otherwise.
> + */
> +static int brute_task_alloc(struct task_struct *task, unsigned long clone_flags)
> +{
> +	struct brute_stats **stats, **p_stats;
> +
> +	stats = brute_stats_ptr(task);
> +	p_stats = brute_stats_ptr(current);
> +
> +	if (likely(*p_stats)) {
> +		brute_share_stats(*p_stats, stats);
> +		return 0;
> +	}
> +
> +	*stats = brute_new_stats();
> +	if (!*stats)
> +		return -ENOMEM;
> +
> +	brute_share_stats(*stats, p_stats);
> +	return 0;
> +}

During the task_alloc hook, aren't both "current" and "task" already
immutable (in the sense that no lock needs to be held for
brute_share_stats())?

And what is the case where brute_stats_ptr(current) returns NULL?

> +
> +/**
> + * brute_task_execve() - Target for the bprm_committing_creds hook.
> + * @bprm: Points to the linux_binprm structure.
> + *
> + * When a forked task calls the execve system call, the memory contents are set
> + * with new values. So, in this scenario the parent's statistical data no need
> + * to be shared. Instead, a new statistical data structure must be allocated to
> + * start a new hierarchy. This condition is detected when the statistics
> + * reference counter holds a value greater than or equal to two (a fork always
> + * sets the statistics reference counter to a minimum of two since the parent
> + * and the child task are sharing the same data).
> + *
> + * However, if the execve function is called immediately after another execve
> + * call, althought the memory contents are reset, there is no need to allocate
> + * a new statistical data structure. This is possible because at this moment
> + * only one task (the task that calls the execve function) points to the data.
> + * In this case, the previous allocation is used but the statistics are reset.
> + *
> + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> + * since the task_free hook can be called from an IRQ context during the
> + * execution of the bprm_committing_creds hook.
> + */
> +static void brute_task_execve(struct linux_binprm *bprm)
> +{
> +	struct brute_stats **stats;
> +	unsigned long flags;
> +
> +	stats = brute_stats_ptr(current);
> +	if (WARN(!*stats, "No statistical data\n"))
> +		return;
> +
> +	spin_lock_irqsave(&(*stats)->lock, flags);
> +
> +	if (!refcount_dec_not_one(&(*stats)->refc)) {
> +		/* execve call after an execve call */
> +		(*stats)->faults = 0;
> +		(*stats)->jiffies = get_jiffies_64();
> +		(*stats)->period = 0;
> +		spin_unlock_irqrestore(&(*stats)->lock, flags);
> +		return;
> +	}
> +
> +	/* execve call after a fork call */
> +	spin_unlock_irqrestore(&(*stats)->lock, flags);
> +	*stats = brute_new_stats();
> +	WARN(!*stats, "Cannot allocate statistical data\n");
> +}

I don't think any of this locking is needed -- you're always operating
on "current", so its brute_stats will always be valid.

> +
> +/**
> + * brute_task_free() - Target for the task_free hook.
> + * @task: Task about to be freed.
> + *
> + * The statistical data that is shared between all the fork hierarchy processes
> + * needs to be freed when this hierarchy disappears.
> + *
> + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> + * since the task_free hook can be called from an IRQ context during the
> + * execution of the task_free hook.
> + */
> +static void brute_task_free(struct task_struct *task)
> +{
> +	struct brute_stats **stats;
> +	unsigned long flags;
> +	bool refc_is_zero;
> +
> +	stats = brute_stats_ptr(task);
> +	if (WARN(!*stats, "No statistical data\n"))
> +		return;
> +
> +	spin_lock_irqsave(&(*stats)->lock, flags);
> +	refc_is_zero = refcount_dec_and_test(&(*stats)->refc);
> +	spin_unlock_irqrestore(&(*stats)->lock, flags);
> +
> +	if (refc_is_zero) {
> +		kfree(*stats);
> +		*stats = NULL;
> +	}
> +}

Same thing -- this is what dec_and_test is for: it's atomic, so no
locking needed.

> +
> +/*
> + * brute_hooks - Targets for the LSM's hooks.
> + */
> +static struct security_hook_list brute_hooks[] __lsm_ro_after_init = {
> +	LSM_HOOK_INIT(task_alloc, brute_task_alloc),
> +	LSM_HOOK_INIT(bprm_committing_creds, brute_task_execve),
> +	LSM_HOOK_INIT(task_free, brute_task_free),
> +};
> +
> +/**
> + * brute_init() - Initialize the brute LSM.
> + *
> + * Return: Always returns zero.
> + */
> +static int __init brute_init(void)
> +{
> +	pr_info("Brute initialized\n");
> +	security_add_hooks(brute_hooks, ARRAY_SIZE(brute_hooks),
> +			   KBUILD_MODNAME);
> +	return 0;
> +}
> +
> +DEFINE_LSM(brute) = {
> +	.name = KBUILD_MODNAME,
> +	.init = brute_init,
> +	.blobs = &brute_blob_sizes,
> +};
> --
> 2.25.1
> 

-- 
Kees Cook
