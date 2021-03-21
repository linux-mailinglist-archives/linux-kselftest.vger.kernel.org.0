Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256E23433C7
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Mar 2021 18:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhCURhj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Mar 2021 13:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCURhV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Mar 2021 13:37:21 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93932C061764
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Mar 2021 10:37:20 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e33so7124264pgm.13
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Mar 2021 10:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h1o7IzHwWbxdPHi+8uUp3/Koaw8yljOar4ODRP9JcNU=;
        b=QCSrTB65+gO/mWpneMOKqnkMx0IckhHxEMVpw/wknbb2Lz3sRC9GExh18/RQNLu3dI
         ENXytI4LIW1QVxzKHwNKRfEbSC8CsR+oBz9O3UrcGodRRnUlgcNagLnp4f7Ul6ErFRgC
         RI5jXj4Np1phupV3DzS7y1TeSymkUHwSe60eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h1o7IzHwWbxdPHi+8uUp3/Koaw8yljOar4ODRP9JcNU=;
        b=DXBrGia+ZqINcKqF4dPo+D+PwEnmeXST5hHSDcaixk5Bxu0hKruRmkHfPW7rmHxzT6
         UCpNDkitzRXSHz9GhZV1fcbyaM7emzk/fJaFpP8OfM7+wzPnrpSwcOB3H/yxkBv9VqWd
         jhoZsKNAZ/DHUcU06+LUm4IL3m6nyTEcqT1SAU5A5IC63LWdfWOTBbsacFSM4Pqb628V
         zrhL4Dd9u0pGn1KlWi3h6fdmBzvcpo76wQl+MbWUmZKxHJ4CAI4KuBf78QET7pyCpsrv
         OQ7IsppWtbmsNktIA3CwpG9RXrbx909myvtRty27RtvI/n1DGheBKBG+WExrD/EfVBPj
         foVA==
X-Gm-Message-State: AOAM531mx7xtkXEr0OJ5HmwuAWl7zQ+iIBsN92seyadIaOlUKWbjAR+o
        Pnv5vzbSN7Tsk9X8YPZk7uJzqg==
X-Google-Smtp-Source: ABdhPJx7f+7KrqqQ2UNcYrMTPWR7geuxADOud2Pt1BKnWAECIduFCs6HMz/l+Z7c6l0ZWemH+Lr/xw==
X-Received: by 2002:a62:68c1:0:b029:1ee:5dfa:860b with SMTP id d184-20020a6268c10000b02901ee5dfa860bmr17681481pfc.35.1616348239667;
        Sun, 21 Mar 2021 10:37:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v2sm11087872pjg.34.2021.03.21.10.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 10:37:18 -0700 (PDT)
Date:   Sun, 21 Mar 2021 10:37:17 -0700
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
Message-ID: <202103211013.4680330D7@keescook>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-3-john.wood@gmx.com>
 <202103171823.E7F64A593@keescook>
 <20210320150153.GA3023@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320150153.GA3023@ubuntu>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 20, 2021 at 04:01:53PM +0100, John Wood wrote:
> Hi,
> First of all thanks for the review. More info and questions inline.
> 
> On Wed, Mar 17, 2021 at 07:00:56PM -0700, Kees Cook wrote:
> > On Sun, Mar 07, 2021 at 12:30:25PM +0100, John Wood wrote:
> > >
> > >  config LSM
> > >  	string "Ordered list of enabled LSMs"
> > > -	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> > > -	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> > > -	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> > > -	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> > > -	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
> > > +	default "brute,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> > > +	default "brute,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> > > +	default "brute,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> > > +	default "brute,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> > > +	default "brute,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
> >
> > It probably doesn't matter much, but I think brute should be added
> > between lockdown and yama.
> 
> What is the rationale for the stacking order (in relation with brute and
> lockdown)?

lockdown has some very early hooks, so leaving it at the front seems
organizationally correct to me. It doesn't really matter, though, so
perhaps we should just alphabetize them, but that's for another day.

> 
> > > diff --git a/security/Makefile b/security/Makefile
> > > index 3baf435de541..1236864876da 100644
> > > --- a/security/Makefile
> > > +++ b/security/Makefile
> > > @@ -36,3 +36,7 @@ obj-$(CONFIG_BPF_LSM)			+= bpf/
> > >  # Object integrity file lists
> > >  subdir-$(CONFIG_INTEGRITY)		+= integrity
> > >  obj-$(CONFIG_INTEGRITY)			+= integrity/
> > > +
> > > +# Object brute file lists
> > > +subdir-$(CONFIG_SECURITY_FORK_BRUTE)	+= brute
> > > +obj-$(CONFIG_SECURITY_FORK_BRUTE)	+= brute/
> >
> > I don't think subdir is needed here? I think you can use obj-... like
> > loadpin, etc.
> 
> loadpin also uses subdir just like selinux, smack, tomoyo, etc.. So, why
> is it not necessary for brute?

Oops, yes, my mistake. I didn't look at the Makefile as a whole. I will
adjust my suggestion as: please split subdir and obj as done by the
other LSMs (integrity should be fixed to do the same, but that doesn't
need to be part of this series).

> 
> > > +#include <asm/current.h>
> >
> > Why is this needed?
> 
> IIUC, the "current" macro is defined in this header. I try to include the
> appropiate header for every macro and function used.

The common approach is actually to minimize the number of explicit
headers so that if header files includes need to be changed, they only
need to be changed internally instead of everywhere in the kernel.
Please find an appropriately minimal set of headers to include.

> 
> > > +/**
> > > + * struct brute_stats - Fork brute force attack statistics.
> > > + * @lock: Lock to protect the brute_stats structure.
> > > + * @refc: Reference counter.
> > > + * @faults: Number of crashes.
> > > + * @jiffies: Last crash timestamp.
> > > + * @period: Crash period's moving average.
> > > + *
> > > + * This structure holds the statistical data shared by all the fork hierarchy
> > > + * processes.
> > > + */
> > > +struct brute_stats {
> > > +	spinlock_t lock;
> > > +	refcount_t refc;
> > > +	unsigned char faults;
> > > +	u64 jiffies;
> > > +	u64 period;
> > > +};
> >
> > I assume the max-255 "faults" will be explained... why is this so small?
> 
> If a brute force attack is running slowly for a long time, the application
> crash period's EMA is not suitable for the detection. This type of attack
> must be detected using a maximum number of faults. In this case, the
> BRUTE_MAX_FAULTS is defined as 200.

Okay, so given the choise of BRUTE_MAX_FAULTS, you limited the storage
size? I guess I worry about this somehow wrapping around easily. Given
the struct has padding due to the u8 storage, it seems like just using
int would be fine too.

> > > +static int brute_task_alloc(struct task_struct *task, unsigned long clone_flags)
> > > +{
> > > +	struct brute_stats **stats, **p_stats;
> > > +
> > > +	stats = brute_stats_ptr(task);
> > > +	p_stats = brute_stats_ptr(current);
> > > +
> > > +	if (likely(*p_stats)) {
> > > +		brute_share_stats(*p_stats, stats);
> > > +		return 0;
> > > +	}
> > > +
> > > +	*stats = brute_new_stats();
> > > +	if (!*stats)
> > > +		return -ENOMEM;
> > > +
> > > +	brute_share_stats(*stats, p_stats);
> > > +	return 0;
> > > +}
> >
> > During the task_alloc hook, aren't both "current" and "task" already
> > immutable (in the sense that no lock needs to be held for
> > brute_share_stats())?
> 
> I will work on it.
> 
> > And what is the case where brute_stats_ptr(current) returns NULL?
> 
> Sorry, but I don't understand what you are trying to explain me.
> brute_stats_ptr(current) returns a pointer to a pointer. So, I think
> your question is: What's the purpose of the "if (likely(*p_stats))"
> check? If it is the case, this check is to guarantee that all the tasks
> have statistical data. If some task has been allocated prior the brute
> LSM initialization, this task doesn't have stats. So, with this check
> all the tasks that fork have stats.

Thank you for figuring out my poorly-worded question. :) Yes, I was
curious about the "if (likely(*p_stats))". It seems like it shouldn't be
possible for a process to lack a stats allocation: the LSMs get
initialized before processes. If you wanted to be defensive, I would
have expected:

if (WARN_ON_ONCE(!*p_stats))
	return -ENOMEM;

or something (brute should be able to count on the kernel internals
behaving here: you're not expecting any path where this could happen).

> 
> > > +
> > > +/**
> > > + * brute_task_execve() - Target for the bprm_committing_creds hook.
> > > + * @bprm: Points to the linux_binprm structure.
> > > + *
> > > + * When a forked task calls the execve system call, the memory contents are set
> > > + * with new values. So, in this scenario the parent's statistical data no need
> > > + * to be shared. Instead, a new statistical data structure must be allocated to
> > > + * start a new hierarchy. This condition is detected when the statistics
> > > + * reference counter holds a value greater than or equal to two (a fork always
> > > + * sets the statistics reference counter to a minimum of two since the parent
> > > + * and the child task are sharing the same data).
> > > + *
> > > + * However, if the execve function is called immediately after another execve
> > > + * call, althought the memory contents are reset, there is no need to allocate
> > > + * a new statistical data structure. This is possible because at this moment
> > > + * only one task (the task that calls the execve function) points to the data.
> > > + * In this case, the previous allocation is used but the statistics are reset.
> > > + *
> > > + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> > > + * since the task_free hook can be called from an IRQ context during the
> > > + * execution of the bprm_committing_creds hook.
> > > + */
> > > +static void brute_task_execve(struct linux_binprm *bprm)
> > > +{
> > > +	struct brute_stats **stats;
> > > +	unsigned long flags;
> > > +
> > > +	stats = brute_stats_ptr(current);
> > > +	if (WARN(!*stats, "No statistical data\n"))
> > > +		return;
> > > +
> > > +	spin_lock_irqsave(&(*stats)->lock, flags);
> > > +
> > > +	if (!refcount_dec_not_one(&(*stats)->refc)) {
> > > +		/* execve call after an execve call */
> > > +		(*stats)->faults = 0;
> > > +		(*stats)->jiffies = get_jiffies_64();
> > > +		(*stats)->period = 0;
> > > +		spin_unlock_irqrestore(&(*stats)->lock, flags);
> > > +		return;
> > > +	}
> > > +
> > > +	/* execve call after a fork call */
> > > +	spin_unlock_irqrestore(&(*stats)->lock, flags);
> > > +	*stats = brute_new_stats();
> > > +	WARN(!*stats, "Cannot allocate statistical data\n");
> > > +}
> >
> > I don't think any of this locking is needed -- you're always operating
> > on "current", so its brute_stats will always be valid.
> 
> But another process (that share the same stats) could be modifying this
> concurrently.
> 
> Scenario 1: cpu 1 writes stats and cpu 2 writes stats.
> Scenario 2: cpu 1 writes stats, then IRQ on the same cpu writes stats.
> 
> I think it is possible. So AFAIK we need locking. Sorry if I am wrong.

Maybe I'm misunderstanding, but even your comments on the function say
that the zeroing path is there to avoid a new allocation, since only 1
thread has access to that "stats". (i.e. no locking needed), and in the
other path, a new stats is allocated (no locking needed). What are the
kernel execution paths you see where you'd need locking here?

> > > +/**
> > > + * brute_task_free() - Target for the task_free hook.
> > > + * @task: Task about to be freed.
> > > + *
> > > + * The statistical data that is shared between all the fork hierarchy processes
> > > + * needs to be freed when this hierarchy disappears.
> > > + *
> > > + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> > > + * since the task_free hook can be called from an IRQ context during the
> > > + * execution of the task_free hook.
> > > + */
> > > +static void brute_task_free(struct task_struct *task)
> > > +{
> > > +	struct brute_stats **stats;
> > > +	unsigned long flags;
> > > +	bool refc_is_zero;
> > > +
> > > +	stats = brute_stats_ptr(task);
> > > +	if (WARN(!*stats, "No statistical data\n"))
> > > +		return;
> > > +
> > > +	spin_lock_irqsave(&(*stats)->lock, flags);
> > > +	refc_is_zero = refcount_dec_and_test(&(*stats)->refc);
> > > +	spin_unlock_irqrestore(&(*stats)->lock, flags);
> > > +
> > > +	if (refc_is_zero) {
> > > +		kfree(*stats);
> > > +		*stats = NULL;
> > > +	}
> > > +}
> >
> > Same thing -- this is what dec_and_test is for: it's atomic, so no
> > locking needed.
> 
> Ok, in this case I can see that the locking is not necessary due to the
> stats::refc is atomic. But in the previous case, faults, jiffies and
> period are not atomic. So I think the lock is necessary. If not, what am
> I missing?

I thought the code had established that there could only be a single
stats holder for that code, so no locking. Maybe I misunderstood?

-- 
Kees Cook
