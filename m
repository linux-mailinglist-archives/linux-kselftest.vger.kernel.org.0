Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D53342D82
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Mar 2021 16:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhCTPDH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Mar 2021 11:03:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:35291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhCTPCz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Mar 2021 11:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616252530;
        bh=Qyy316MMRLCeGzcR94PAqHg48ZDAQa0fq9Q52i0Shv4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HHm76Nxr7kXuOksjq0yHaPoZzQUcews5agadFz9TNWK9FhZYGxzh9emiG7lpNBQXp
         esGuXlJjYQp/VJJCjo5X/EwQHTnqr3AiCxt4ifJEi5fUt4b9gtkbokMY8hpb9MquUX
         FfmJtiEcHSM+ah+nq4AOpmmLnyWRutgn6wg8bTPU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1HZo-1lPGkC2SmA-002nOF; Sat, 20
 Mar 2021 16:02:10 +0100
Date:   Sat, 20 Mar 2021 16:01:53 +0100
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     John Wood <john.wood@gmx.com>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
Message-ID: <20210320150153.GA3023@ubuntu>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-3-john.wood@gmx.com>
 <202103171823.E7F64A593@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103171823.E7F64A593@keescook>
X-Provags-ID: V03:K1:N3kDi3fcr7BY5jsLXEhpPT5eZCaHx6vuob6jMA+RdTaGjh8x9VS
 hV87Ez7R08B5a/LV4rUuS+sNRxEb0rRx9YG2RV+GiHLEyMffLwDJoqHDDtbHZme0X7p/ut0
 fALzuLGYUv3x79dHwdPPAU/s3LXWcFANyklULIR94sta/QDX8kUIAzk0Rg5JIBQHkNMSy1u
 ffOa76sdUHRXUIcjhEtVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:znyhYE+hPho=:4IpP/8ClXstsl4SruKeZN+
 QBRMjJyTtACcGbLZY1iLRJA7wipKvsAez6Wxl0QsHTOEp4CjrLaf9zCxkM3+5qO91f0tIvD3q
 uoFVuR/e0xie6uXyLlVX7U44aprQ8JtF7YdOhta42A4pVijYKqz5kVdaxZfFSg231iqeNUCeJ
 ohTdH2mYstSXwpDLKbGFq6kdRUvTn1mskkPOM70kaoqDLWYJH2/hHIfm/SbNi0KPkMBkVzjo8
 21zXP53PeLQa+1AYoK4Yi1h0f//PsJfaE53v0C67pX5GiAdbZlyj0xFcX+x6/N/BjKZyb46iA
 9ydBQMVIpj1KTANBZLSPR1v6Q8vkwTAxiutsSxhHIlp6t0or/dhBH6bfHxzgFsSNhfsK2hV7X
 AOd2kcb9jksY+/pDCNlYbNpZaV9za0/myw0ghISjpdXNyAIaiH4JLdVdPWix13Pba9GXAKlry
 MkkjcA/oTvoS6zz7Ae34+vzhksKRte4DKnwvCLJudMs0Tsr6ZLnAOJK+yGGUdJF/PmOEmAZuG
 vKtVFVjRjqHE08Q5yD7cmQtdXvZAQds5eF7QSNNRrFZD/h4egly+AzviUZWM2DI+HIoGeDsZW
 XgjxIpz8Gnyfeoj+uPVjhBxfkCRFK/BJHnIUED4JLCVIxfPprj6DUEwAXXU4DQ4dOBrbHmiJ2
 8L49dfglgJnAetJYIV3lvji50TjLsFtrfJ2NA682Nzr8c3wk4zyOJ6W/QqbBnytSJF/m6zJch
 BerqnhrhLJEZ1KOD1If6tf/zOq5S/X1afd50Ht7Dg7wAQoAgs4gFEEXSG8DK99qc+ok/pzh5U
 2FfjyJdmPIibEVNOSZZGQ1HQURy5CVzsmQL29jk5gBxDnTUU3rTjEe9VvUZA2yqmLxkMlU1Ro
 CZBBwWM/EB8E2VB/BtEQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,
First of all thanks for the review. More info and questions inline.

On Wed, Mar 17, 2021 at 07:00:56PM -0700, Kees Cook wrote:
> On Sun, Mar 07, 2021 at 12:30:25PM +0100, John Wood wrote:
> >
> >  config LSM
> >  	string "Ordered list of enabled LSMs"
> > -	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tom=
oyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> > -	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,=
smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> > -	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DE=
FAULT_SECURITY_TOMOYO
> > -	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_S=
ECURITY_DAC
> > -	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tom=
oyo,apparmor,bpf"
> > +	default "brute,lockdown,yama,loadpin,safesetid,integrity,smack,selin=
ux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> > +	default "brute,lockdown,yama,loadpin,safesetid,integrity,apparmor,se=
linux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> > +	default "brute,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf"=
 if DEFAULT_SECURITY_TOMOYO
> > +	default "brute,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEF=
AULT_SECURITY_DAC
> > +	default "brute,lockdown,yama,loadpin,safesetid,integrity,selinux,sma=
ck,tomoyo,apparmor,bpf"
>
> It probably doesn't matter much, but I think brute should be added
> between lockdown and yama.

What is the rationale for the stacking order (in relation with brute and
lockdown)?

> > diff --git a/security/Makefile b/security/Makefile
> > index 3baf435de541..1236864876da 100644
> > --- a/security/Makefile
> > +++ b/security/Makefile
> > @@ -36,3 +36,7 @@ obj-$(CONFIG_BPF_LSM)			+=3D bpf/
> >  # Object integrity file lists
> >  subdir-$(CONFIG_INTEGRITY)		+=3D integrity
> >  obj-$(CONFIG_INTEGRITY)			+=3D integrity/
> > +
> > +# Object brute file lists
> > +subdir-$(CONFIG_SECURITY_FORK_BRUTE)	+=3D brute
> > +obj-$(CONFIG_SECURITY_FORK_BRUTE)	+=3D brute/
>
> I don't think subdir is needed here? I think you can use obj-... like
> loadpin, etc.

loadpin also uses subdir just like selinux, smack, tomoyo, etc.. So, why
is it not necessary for brute?

> > +#include <asm/current.h>
>
> Why is this needed?

IIUC, the "current" macro is defined in this header. I try to include the
appropiate header for every macro and function used.

> > +/**
> > + * struct brute_stats - Fork brute force attack statistics.
> > + * @lock: Lock to protect the brute_stats structure.
> > + * @refc: Reference counter.
> > + * @faults: Number of crashes.
> > + * @jiffies: Last crash timestamp.
> > + * @period: Crash period's moving average.
> > + *
> > + * This structure holds the statistical data shared by all the fork h=
ierarchy
> > + * processes.
> > + */
> > +struct brute_stats {
> > +	spinlock_t lock;
> > +	refcount_t refc;
> > +	unsigned char faults;
> > +	u64 jiffies;
> > +	u64 period;
> > +};
>
> I assume the max-255 "faults" will be explained... why is this so small?

If a brute force attack is running slowly for a long time, the application
crash period's EMA is not suitable for the detection. This type of attack
must be detected using a maximum number of faults. In this case, the
BRUTE_MAX_FAULTS is defined as 200.

> > [...]
> > +static struct brute_stats *brute_new_stats(void)
> > +{
> > +	struct brute_stats *stats;
> > +
> > +	stats =3D kmalloc(sizeof(struct brute_stats), GFP_KERNEL);
> > +	if (!stats)
> > +		return NULL;
>
> Since this is tied to process creation, I think it might make sense to
> have a dedicated kmem cache for this (instead of using the "generic"
> kmalloc). See kmem_cache_{create,*alloc,free}

Thanks, I will work on it for the next version.
>
> > +
> > +	spin_lock_init(&stats->lock);
> > +	refcount_set(&stats->refc, 1);
> > +	stats->faults =3D 0;
> > +	stats->jiffies =3D get_jiffies_64();
> > +	stats->period =3D 0;
>
> And either way, I'd recommend using the "z" variant of the allocator
> (kmem_cache_zalloc, kzalloc) to pre-zero everything (and then you can
> drop the "=3D 0" lines here).

Understood.

>
> > +
> > +	return stats;
> > +}
> > +
> > +/**
> > + * brute_share_stats() - Share the statistical data between processes=
.
> > + * @src: Source of statistics to be shared.
> > + * @dst: Destination of statistics to be shared.
> > + *
> > + * Copy the src's pointer to the statistical data structure to the ds=
t's pointer
> > + * to the same structure. Since there is a new process that shares th=
e same
> > + * data, increase the reference counter. The src's pointer cannot be =
NULL.
> > + *
> > + * It's mandatory to disable interrupts before acquiring the brute_st=
ats::lock
> > + * since the task_free hook can be called from an IRQ context during =
the
> > + * execution of the task_alloc hook.
> > + */
> > +static void brute_share_stats(struct brute_stats *src,
> > +			      struct brute_stats **dst)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&src->lock, flags);
> > +	refcount_inc(&src->refc);
> > +	*dst =3D src;
> > +	spin_unlock_irqrestore(&src->lock, flags);
> > +}
> > +
> > +/**
> > + * brute_task_alloc() - Target for the task_alloc hook.
> > + * @task: Task being allocated.
> > + * @clone_flags: Contains the flags indicating what should be shared.
> > + *
> > + * For a correct management of a fork brute force attack it is necess=
ary that
> > + * all the tasks hold statistical data. The same statistical data nee=
ds to be
> > + * shared between all the tasks that hold the same memory contents or=
 in other
> > + * words, between all the tasks that have been forked without any exe=
cve call.
> > + *
> > + * To ensure this, if the current task doesn't have statistical data =
when forks,
> > + * it is mandatory to allocate a new statistics structure and share i=
t between
> > + * this task and the new one being allocated. Otherwise, share the st=
atistics
> > + * that the current task already has.
> > + *
> > + * Return: -ENOMEM if the allocation of the new statistics structure =
fails. Zero
> > + *         otherwise.
> > + */
> > +static int brute_task_alloc(struct task_struct *task, unsigned long c=
lone_flags)
> > +{
> > +	struct brute_stats **stats, **p_stats;
> > +
> > +	stats =3D brute_stats_ptr(task);
> > +	p_stats =3D brute_stats_ptr(current);
> > +
> > +	if (likely(*p_stats)) {
> > +		brute_share_stats(*p_stats, stats);
> > +		return 0;
> > +	}
> > +
> > +	*stats =3D brute_new_stats();
> > +	if (!*stats)
> > +		return -ENOMEM;
> > +
> > +	brute_share_stats(*stats, p_stats);
> > +	return 0;
> > +}
>
> During the task_alloc hook, aren't both "current" and "task" already
> immutable (in the sense that no lock needs to be held for
> brute_share_stats())?

I will work on it.

> And what is the case where brute_stats_ptr(current) returns NULL?

Sorry, but I don't understand what you are trying to explain me.
brute_stats_ptr(current) returns a pointer to a pointer. So, I think
your question is: What's the purpose of the "if (likely(*p_stats))"
check? If it is the case, this check is to guarantee that all the tasks
have statistical data. If some task has been allocated prior the brute
LSM initialization, this task doesn't have stats. So, with this check
all the tasks that fork have stats.

> > +
> > +/**
> > + * brute_task_execve() - Target for the bprm_committing_creds hook.
> > + * @bprm: Points to the linux_binprm structure.
> > + *
> > + * When a forked task calls the execve system call, the memory conten=
ts are set
> > + * with new values. So, in this scenario the parent's statistical dat=
a no need
> > + * to be shared. Instead, a new statistical data structure must be al=
located to
> > + * start a new hierarchy. This condition is detected when the statist=
ics
> > + * reference counter holds a value greater than or equal to two (a fo=
rk always
> > + * sets the statistics reference counter to a minimum of two since th=
e parent
> > + * and the child task are sharing the same data).
> > + *
> > + * However, if the execve function is called immediately after anothe=
r execve
> > + * call, althought the memory contents are reset, there is no need to=
 allocate
> > + * a new statistical data structure. This is possible because at this=
 moment
> > + * only one task (the task that calls the execve function) points to =
the data.
> > + * In this case, the previous allocation is used but the statistics a=
re reset.
> > + *
> > + * It's mandatory to disable interrupts before acquiring the brute_st=
ats::lock
> > + * since the task_free hook can be called from an IRQ context during =
the
> > + * execution of the bprm_committing_creds hook.
> > + */
> > +static void brute_task_execve(struct linux_binprm *bprm)
> > +{
> > +	struct brute_stats **stats;
> > +	unsigned long flags;
> > +
> > +	stats =3D brute_stats_ptr(current);
> > +	if (WARN(!*stats, "No statistical data\n"))
> > +		return;
> > +
> > +	spin_lock_irqsave(&(*stats)->lock, flags);
> > +
> > +	if (!refcount_dec_not_one(&(*stats)->refc)) {
> > +		/* execve call after an execve call */
> > +		(*stats)->faults =3D 0;
> > +		(*stats)->jiffies =3D get_jiffies_64();
> > +		(*stats)->period =3D 0;
> > +		spin_unlock_irqrestore(&(*stats)->lock, flags);
> > +		return;
> > +	}
> > +
> > +	/* execve call after a fork call */
> > +	spin_unlock_irqrestore(&(*stats)->lock, flags);
> > +	*stats =3D brute_new_stats();
> > +	WARN(!*stats, "Cannot allocate statistical data\n");
> > +}
>
> I don't think any of this locking is needed -- you're always operating
> on "current", so its brute_stats will always be valid.

But another process (that share the same stats) could be modifying this
concurrently.

Scenario 1: cpu 1 writes stats and cpu 2 writes stats.
Scenario 2: cpu 1 writes stats, then IRQ on the same cpu writes stats.

I think it is possible. So AFAIK we need locking. Sorry if I am wrong.

> > +
> > +/**
> > + * brute_task_free() - Target for the task_free hook.
> > + * @task: Task about to be freed.
> > + *
> > + * The statistical data that is shared between all the fork hierarchy=
 processes
> > + * needs to be freed when this hierarchy disappears.
> > + *
> > + * It's mandatory to disable interrupts before acquiring the brute_st=
ats::lock
> > + * since the task_free hook can be called from an IRQ context during =
the
> > + * execution of the task_free hook.
> > + */
> > +static void brute_task_free(struct task_struct *task)
> > +{
> > +	struct brute_stats **stats;
> > +	unsigned long flags;
> > +	bool refc_is_zero;
> > +
> > +	stats =3D brute_stats_ptr(task);
> > +	if (WARN(!*stats, "No statistical data\n"))
> > +		return;
> > +
> > +	spin_lock_irqsave(&(*stats)->lock, flags);
> > +	refc_is_zero =3D refcount_dec_and_test(&(*stats)->refc);
> > +	spin_unlock_irqrestore(&(*stats)->lock, flags);
> > +
> > +	if (refc_is_zero) {
> > +		kfree(*stats);
> > +		*stats =3D NULL;
> > +	}
> > +}
>
> Same thing -- this is what dec_and_test is for: it's atomic, so no
> locking needed.

Ok, in this case I can see that the locking is not necessary due to the
stats::refc is atomic. But in the previous case, faults, jiffies and
period are not atomic. So I think the lock is necessary. If not, what am
I missing?

Thanks,
John Wood
