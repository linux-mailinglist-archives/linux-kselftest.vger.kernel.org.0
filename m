Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B01B342DF1
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Mar 2021 16:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCTPsJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Mar 2021 11:48:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:40975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhCTPrk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Mar 2021 11:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616255215;
        bh=PRkjx4QnvAjhzrwqjXQp7oKX8aVfUdjdL/gFEKNG86s=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XOV8LU2SD3SLuTONokkoaN1yyM+vcJA2jqO5TQXn0PqshM0yjymagTpTNuSBZQbGM
         Rbb1s5YRa7Pr+KtPNxw//mtZ/toBhqdkpRWPyZpcDjdZR98sJ41nyPHMunTR3EilZG
         Fr+lpNvbXAhuk8TBzLCcgSLAnxx3dKolnh2KmHNg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNJq-1l9yo927gw-00VM8U; Sat, 20
 Mar 2021 16:46:55 +0100
Date:   Sat, 20 Mar 2021 16:46:48 +0100
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
Subject: Re: [PATCH v6 4/8] security/brute: Fine tuning the attack detection
Message-ID: <20210320154648.GC3023@ubuntu>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-5-john.wood@gmx.com>
 <202103171957.16C0560D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103171957.16C0560D@keescook>
X-Provags-ID: V03:K1:0rKWMfe0fpiE0SwoD4sT7kjU3f7RVSxYmoHpyesGPyv6A7AnC65
 mNFtDGGUWaZMgpsE8AzrOHdFqZqK6XmkUuAhJYIlaQh1UbDYGE0r5RDhMCW8sE8nDBhd5zk
 VDoERdb0uNubUNN+a4OQZXResIXJCpWdFO9tw9/KcceyAw2+SMBVgn2ZdHCmcDnzozQSkYM
 U05S0rdfNdJR23JuzAW0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+aCHYtmSVSU=:ZFy1WOJD3yf+VyE8hJxr10
 7ePrKScOYmGJRz9QY7drHnBLODQfc6X5x/RqHY2rlnOG+DiEw3S1dpO//8R/2OghJNgNaXIqF
 t7/+Nzij16zXQojGoomRvqKVvniH/eXiz8v04Rp6RdIRgDB2iv+nxzU5/jTCwWGvrbPDy+szG
 ebLZ6ndQaK27kgvWxKEmnXh0/o+e5eKEGSGMO6RcdRci4t/BQlFShZBisDICw1uohxczpwDKk
 V8VFVjO0zz9sT/PyzseKVUmr9JeWQ9Ov8BAuG7NX8pyc1p2Qhwj052IDyaq3prw9XD3yPMIlW
 kUlYzM9MqYiN/x/zizkKVuHwwkDBnzplPO+PYUxF6pfjWrdTwzu5KbmkkMyMYrr2Xl9xMy/5k
 erY/CxgfKOZNo3qhzkBmb9gs5eGMH2qT8CNtuZvoNAcPB6UhWIf8uQiMsoiKtcyERlJSxmvMK
 IRMs59Z4KXlQaOXlJ8jhPKFLN5NL/u/bmdljtthWtRgN5bXJumldsSxhAL9lopVEB4yzzAbYZ
 pAIRSFV2tUbQi6OGreB+sIoFrbjod+IBOagpJdMf/x6eelRUVbhkqRuLlyCEJ1vxGL0n4JEMG
 108b/2OhsDL5S5o+E1StBOdDrunU4AWSUeHPWblXePaOknAmDqaQPZrvBqc4OzakPVw0aDBYs
 PgJ9nLL2RTG/sEd6FDwnP/JL1FjSsWDOVHs76pdV8ZsTsh7jUkwWedOZXxzhy47lpV/q2d/sk
 tFCCnSyy/pLrVL7XzicN+fzLk/YaNEhyt05JFOSSD5eSFX85jyvPZSx9VkgTRJK+v9hltGqvI
 7lj8mJuAz2lVJghppdtW01U7Qy6kKOTgboXpKqeo4S3B+7iVcXlkvXxnYmaxjakdSHkw0Qq/0
 LjW0y8/7r5k+VeWnMzNvsIUpv1NdJOc8MTedwfOpknJkpXUI7v2rNkvE9gRtGQPAX/Bmz6hgs
 jhXkMlAttTqCp+ig7hiorlR0MgHEev4YHJ1FXWi8NSCTSLrcXGxhGxHNbRvOTZa5cX+NSCf0D
 4bVbacN/rTUFb/8odI1IC7JPPoBXImrVSWdf8KUImF5gLeL1sBK8exr8IC/u/xtsVQVtIZZET
 93nyviNH8ZyAh95d5zIjsmv//hVrCM8fmR771WDOVcarVZjvMspcJ2TsipL9R4dJY4rOf68ls
 e3qOH3zGwWUim4CceE9LFO0e6gdBhKTcwos+XTFAoAQXWs3TRLWOQXEkbl3+rkKAexNgE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 17, 2021 at 09:00:51PM -0700, Kees Cook wrote:
> On Sun, Mar 07, 2021 at 12:30:27PM +0100, John Wood wrote:
> >  #include <asm/current.h>
> > +#include <asm/rwonce.h>
> > +#include <asm/siginfo.h>
> > +#include <asm/signal.h>
> > +#include <linux/binfmts.h>
> >  #include <linux/bug.h>
> >  #include <linux/compiler.h>
> > +#include <linux/cred.h>
> > +#include <linux/dcache.h>
> >  #include <linux/errno.h>
> > +#include <linux/fs.h>
> >  #include <linux/gfp.h>
> > +#include <linux/if.h>
> >  #include <linux/init.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/kernel.h>
> >  #include <linux/lsm_hooks.h>
> >  #include <linux/math64.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/path.h>
> >  #include <linux/printk.h>
> >  #include <linux/refcount.h>
> >  #include <linux/rwlock.h>
> > @@ -19,9 +29,35 @@
> >  #include <linux/sched.h>
> >  #include <linux/sched/signal.h>
> >  #include <linux/sched/task.h>
> > +#include <linux/signal.h>
> > +#include <linux/skbuff.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/stat.h>
> >  #include <linux/types.h>
> > +#include <linux/uidgid.h>
>
> This is really a LOT of includes. Are you sure all of these are
> explicitly needed?

I try to add the needed header for every macro and function used. If
there is a better method to do it I will apply it. Thanks.

> >  /**
> >   * struct brute_stats - Fork brute force attack statistics.
> > @@ -30,6 +66,9 @@
> >   * @faults: Number of crashes.
> >   * @jiffies: Last crash timestamp.
> >   * @period: Crash period's moving average.
> > + * @saved_cred: Saved credentials.
> > + * @network: Network activity flag.
> > + * @bounds_crossed: Privilege bounds crossed flag.
> >   *
> >   * This structure holds the statistical data shared by all the fork h=
ierarchy
> >   * processes.
> > @@ -40,6 +79,9 @@ struct brute_stats {
> >  	unsigned char faults;
> >  	u64 jiffies;
> >  	u64 period;
> > +	struct brute_cred saved_cred;
> > +	unsigned char network : 1;
> > +	unsigned char bounds_crossed : 1;
>
> If you really want to keep faults a "char", I would move these bools
> after "faults" to avoid adding more padding.

Understood. Thanks.

> > +/**
> > + * brute_is_setid() - Test if the executable file has the setid flags=
 set.
> > + * @bprm: Points to the linux_binprm structure.
> > + *
> > + * Return: True if the executable file has the setid flags set. False=
 otherwise.
> > + */
> > +static bool brute_is_setid(const struct linux_binprm *bprm)
> > +{
> > +	struct file *file =3D bprm->file;
> > +	struct inode *inode;
> > +	umode_t mode;
> > +
> > +	if (!file)
> > +		return false;
> > +
> > +	inode =3D file->f_path.dentry->d_inode;
> > +	mode =3D inode->i_mode;
> > +
> > +	return !!(mode & (S_ISUID | S_ISGID));
> > +}
>
> Oh, er, no, this should not reinvent the wheel. You just want to know if
> creds got elevated, so you want bprm->secureexec; this gets correctly
> checked in cap_bprm_creds_from_file().

Ok, I will work on it for the next version.

> > +
> > +/**
> > + * brute_reset_stats() - Reset the statistical data.
> > + * @stats: Statistics to be reset.
> > + * @is_setid: The executable file has the setid flags set.
> > + *
> > + * Reset the faults and period and set the last crash timestamp to no=
w. This
> > + * way, it is possible to compute the application crash period at the=
 next
> > + * fault. Also, save the credentials of the current task and update t=
he
> > + * bounds_crossed flag based on a previous network activity and the i=
s_setid
> > + * parameter.
> > + *
> > + * The statistics to be reset cannot be NULL.
> > + *
> > + * Context: Must be called with interrupts disabled and brute_stats_p=
tr_lock
> > + *          and brute_stats::lock held.
> > + */
> > +static void brute_reset_stats(struct brute_stats *stats, bool is_seti=
d)
> > +{
> > +	const struct cred *cred =3D current_cred();
> > +
> > +	stats->faults =3D 0;
> > +	stats->jiffies =3D get_jiffies_64();
> > +	stats->period =3D 0;
> > +	stats->saved_cred.uid =3D cred->uid;
> > +	stats->saved_cred.gid =3D cred->gid;
> > +	stats->saved_cred.suid =3D cred->suid;
> > +	stats->saved_cred.sgid =3D cred->sgid;
> > +	stats->saved_cred.euid =3D cred->euid;
> > +	stats->saved_cred.egid =3D cred->egid;
> > +	stats->saved_cred.fsuid =3D cred->fsuid;
> > +	stats->saved_cred.fsgid =3D cred->fsgid;
> > +	stats->bounds_crossed =3D stats->network || is_setid;
> > +}
>
> I would include brute_reset_stats() in the first patch (and add to it as
> needed). To that end, it can start with a memset(stats, 0, sizeof(*stats=
));

So, need all the struct fields to be introduced in the initial patch?
Even if they are not needed in the initial patch? I'm confused.

> > +/**
> > + * brute_priv_have_changed() - Test if the privileges have changed.
> > + * @stats: Statistics that hold the saved credentials.
> > + *
> > + * The privileges have changed if the credentials of the current task=
 are
> > + * different from the credentials saved in the statistics structure.
> > + *
> > + * The statistics that hold the saved credentials cannot be NULL.
> > + *
> > + * Context: Must be called with interrupts disabled and brute_stats_p=
tr_lock
> > + *          and brute_stats::lock held.
> > + * Return: True if the privileges have changed. False otherwise.
> > + */
> > +static bool brute_priv_have_changed(struct brute_stats *stats)
> > +{
> > +	const struct cred *cred =3D current_cred();
> > +	bool priv_have_changed;
> > +
> > +	priv_have_changed =3D !uid_eq(stats->saved_cred.uid, cred->uid) ||
> > +		!gid_eq(stats->saved_cred.gid, cred->gid) ||
> > +		!uid_eq(stats->saved_cred.suid, cred->suid) ||
> > +		!gid_eq(stats->saved_cred.sgid, cred->sgid) ||
> > +		!uid_eq(stats->saved_cred.euid, cred->euid) ||
> > +		!gid_eq(stats->saved_cred.egid, cred->egid) ||
> > +		!uid_eq(stats->saved_cred.fsuid, cred->fsuid) ||
> > +		!gid_eq(stats->saved_cred.fsgid, cred->fsgid);
> > +
> > +	return priv_have_changed;
> > +}
>
> This should just be checked from bprm->secureexec, which is valid by the
> time you get to the bprm_committing_creds hook. You can just save the
> value to your stats struct instead of re-interrogating current_cred,
> etc.

Ok. Thanks.

> > +
> > +/**
> > + * brute_threat_model_supported() - Test if the threat model is suppo=
rted.
> > + * @siginfo: Contains the signal information.
> > + * @stats: Statistical data shared by all the fork hierarchy processe=
s.
> > + *
> > + * To avoid false positives during the attack detection it is necessa=
ry to
> > + * narrow the possible cases. Only the following scenarios are taken =
into
> > + * account:
> > + *
> > + * 1.- Launching (fork()/exec()) a setuid/setgid process repeatedly u=
ntil a
> > + *     desirable memory layout is got (e.g. Stack Clash).
> > + * 2.- Connecting to an exec()ing network daemon (e.g. xinetd) repeat=
edly until
> > + *     a desirable memory layout is got (e.g. what CTFs do for simple=
 network
> > + *     service).
> > + * 3.- Launching processes without exec() (e.g. Android Zygote) and e=
xposing
> > + *     state to attack a sibling.
> > + * 4.- Connecting to a fork()ing network daemon (e.g. apache) repeate=
dly until
> > + *     the previously shared memory layout of all the other children =
is exposed
> > + *     (e.g. kind of related to HeartBleed).
> > + *
> > + * In each case, a privilege boundary has been crossed:
> > + *
> > + * Case 1: setuid/setgid process
> > + * Case 2: network to local
> > + * Case 3: privilege changes
> > + * Case 4: network to local
> > + *
> > + * Also, only the signals delivered by the kernel are taken into acco=
unt with
> > + * the exception of the SIGABRT signal since the latter is used by gl=
ibc for
> > + * stack canary, malloc, etc failures, which may indicate that a miti=
gation has
> > + * been triggered.
> > + *
> > + * The signal information and the statistical data shared by all the =
fork
> > + * hierarchy processes cannot be NULL.
> > + *
> > + * It's mandatory to disable interrupts before acquiring the brute_st=
ats::lock
> > + * since the task_free hook can be called from an IRQ context during =
the
> > + * execution of the task_fatal_signal hook.
> > + *
> > + * Context: Must be called with interrupts disabled and brute_stats_p=
tr_lock
> > + *          held.
> > + * Return: True if the threat model is supported. False otherwise.
> > + */
> > +static bool brute_threat_model_supported(const kernel_siginfo_t *sigi=
nfo,
> > +					 struct brute_stats *stats)
> > +{
> > +	bool bounds_crossed;
> > +
> > +	if (siginfo->si_signo =3D=3D SIGKILL && siginfo->si_code !=3D SIGABR=
T)
> > +		return false;
> > +
> > +	spin_lock(&stats->lock);
> > +	bounds_crossed =3D stats->bounds_crossed;
> > +	bounds_crossed =3D bounds_crossed || brute_priv_have_changed(stats);
> > +	stats->bounds_crossed =3D bounds_crossed;
> > +	spin_unlock(&stats->lock);
> > +
> > +	return bounds_crossed;
> > +}
>
> I think this logic can be done with READ_ONCE()s and moved directly into
> brute_task_fatal_signal().

Thanks. I will work on locking.

> >
> > +/**
> > + * brute_network() - Target for the socket_sock_rcv_skb hook.
> > + * @sk: Contains the sock (not socket) associated with the incoming s=
k_buff.
> > + * @skb: Contains the incoming network data.
> > + *
> > + * A previous step to detect that a network to local boundary has bee=
n crossed
> > + * is to detect if there is network activity. To do this, it is only =
necessary
> > + * to check if there are data packets received from a network device =
other than
> > + * loopback.
> > + *
> > + * It's mandatory to disable interrupts before acquiring brute_stats_=
ptr_lock
> > + * and brute_stats::lock since the task_free hook can be called from =
an IRQ
> > + * context during the execution of the socket_sock_rcv_skb hook.
> > + *
> > + * Return: -EFAULT if the current task doesn't have statistical data.=
 Zero
> > + *         otherwise.
> > + */
> > +static int brute_network(struct sock *sk, struct sk_buff *skb)
> > +{
> > +	struct brute_stats **stats;
> > +	unsigned long flags;
> > +
> > +	if (!skb->dev || (skb->dev->flags & IFF_LOOPBACK))
> > +		return 0;
> > +
> > +	stats =3D brute_stats_ptr(current);
>
> Uhh, is "current" valid here? I actually don't know this hook very well.

I think so, but I will try to study it. Thanks for noted this.

> > +	read_lock_irqsave(&brute_stats_ptr_lock, flags);
> > +
> > +	if (!*stats) {
> > +		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > +		return -EFAULT;
> > +	}
> > +
> > +	spin_lock(&(*stats)->lock);
> > +	(*stats)->network =3D true;
> > +	spin_unlock(&(*stats)->lock);
> > +	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > +	return 0;
> > +}

Thanks,
John Wood
