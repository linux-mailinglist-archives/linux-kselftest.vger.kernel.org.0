Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F89342DCC
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Mar 2021 16:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCTPe7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Mar 2021 11:34:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:56411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhCTPe4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Mar 2021 11:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616254451;
        bh=b+DAkGSEJEYQr1J+vYvC9mKnu1liKEHFHg8AxvtyYMM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FxOPsH+SEHI5chRlRQQBwAcaQ9m0NG7SjAG8JvR/+wxDB+seC4RbIeRGrCoTG9MMw
         +wus5/7yXUbmBwPZfaRi676rrQIOTAIful9ygZ4eTQQP4bMwDRuZNpGH7+4xONxhNl
         /2e63o/gyM3lQDIJgfgzL1LgbrEh6O5iAcroF0nA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6KUT-1lmLE21Iyn-016i8W; Sat, 20
 Mar 2021 16:34:11 +0100
Date:   Sat, 20 Mar 2021 16:34:06 +0100
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
Subject: Re: [PATCH v6 3/8] securtiy/brute: Detect a brute force attack
Message-ID: <20210320153406.GB3023@ubuntu>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-4-john.wood@gmx.com>
 <202103171902.E6F55172@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103171902.E6F55172@keescook>
X-Provags-ID: V03:K1:mmvqspBjLAdCfBOq0CTFBPQaDrsx5fEfCvn4pEjMSAqctnxsEKQ
 b9LgXFf4ywOhYtaf9Ql4bsc0B1bTCdwjztQhJbxVATashkWphzRbsuE8ERPy8OL8XhP+Zwo
 dnxoyRfRw6kqOltKAXnZF/z3q5YXFxnAAgC24vJxSFYlYuATaH3UQi5Mttcrwidhhw2xJEy
 vM34g/VMY8CBcZg85bCGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yG8hg28xvpM=:85blcd041/E2wZo8zxrMWZ
 Fw+uszJBN54N8cdUNYUBbMNetTpXSXQsYqyO8ipsC+fvGBs/FGd4j1igGSZMZ2kA7PpPgLrLh
 I8JLdbQNKQHRa0DrkRU9J0dPCQ8zVs/0QEpmJP5Hj6k6MVeU8ckA8vZxOCNY8jNPPj1WNxY3o
 t2AF27Fy2frrFTc0Y6Eayi6JBJHKDa4/qb5AcAkp7oFwMk+LyG8SIlXWiR3zRjQgNsvTjQdEh
 cFbbazFi4qkelPF6AaC3xb0uBWC7sLXU0J7Z8QuXiEHVTm2mSgAHvqgr5ovf1DW9N1z72JXqA
 e8Eqp3EoPOdM73pgSzTcV4cDrxNoMTi7vED05MnceA8ztSUgVEoKbZFXC+S3q4ClILXmeRckx
 LceaKrSdGe39Lo0LRyHLNRxaM+s170Uo8zVHmltiQoX2DhwJ2rfaX6J9VddSfeiJl63VVDo83
 tEkanxP3Mu0jK5vZfeXgA0o+MSm9+iGjH9+Q4uGJhq4n3AVTl4dzQOT2xFNlQ6JjVyjaGvWD9
 cesgRU2MsEC/MPIuQzxrnIju+oVq9hJFgudya7Cba0F7Ml0fBQmy1dqg7Kye2zw8RRuogIrR5
 MztucIVASszau8G0bTzOKgEkLgus/XBG/ISnfL7AU+AN1I7hX5XhdiKCoiKzFFHe7WaaxgZiY
 v9hlfDR4YpFdcMNMMMlDgNaTqlhKslyse/RnOlp14PUBIOU4nGsMj3DnHEU+16n3x1OIzg0C8
 1YvCp5yGPAi4VIqIe84gpH7jLkK0LzQPv2+X2gZr+82YAqRFLNjSY3PFs8aCTomkM0EMmPCJV
 Df0YNkKP/3iDGh8EohtPIb2Myh7S9oW0B1xodyhDwPA5EuTHrG8fnT1wR3kqOf5/o/TcNTHus
 40+GXFuWrFwaShpM4L06ZMmGvkfKpp4GMfdsXVH5urTt8l9tXyy1rYs9QEvyKKiCe9sDjpRsh
 U6IKzSAFUkteolhQ0cyYfN6gXRpNoj9/1k9XFG7Nz9UWmmV4PeDyhPF7Y0y2/zx6fJW4fqQKE
 oPYbWgQbWIVxPEjBOXW3knq8G+pxomv3Qva6tBxgR+xaP9k4OCD6l6WGoniVmka4qnEX/qg4m
 /TjaexSPCTSnwEVUXhEWBfSDmMgsfStG3PfffvKg3nMClUsNWW2YG5eixRAZEMNoLSxM1meNU
 pNGAQ9VrbFiLMt4cBo79sKmmYPilPTJrx/UopA0jTJLtZyLsndA4o1K7NSEy5Q1blEgL4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 17, 2021 at 07:57:10PM -0700, Kees Cook wrote:
> On Sun, Mar 07, 2021 at 12:30:26PM +0100, John Wood wrote:
> > @@ -74,7 +84,7 @@ static struct brute_stats *brute_new_stats(void)
> >  {
> >  	struct brute_stats *stats;
> >
> > -	stats =3D kmalloc(sizeof(struct brute_stats), GFP_KERNEL);
> > +	stats =3D kmalloc(sizeof(struct brute_stats), GFP_ATOMIC);
>
> Why change this here? I'd just start with this in the patch that
> introduces it.

To be coherent in the previous patch. In the previous patch the kmalloc
could use GFP_KERNEL due to the call was made out of an atomic context.
Now, with the new lock it needs GFP_ATOMIC. So the question:

If finally it need to use GFP_ATOMIC, the first patch need to use it even =
if
it is not necessary?

> >  	if (!stats)
> >  		return NULL;
> >
> > @@ -99,16 +109,17 @@ static struct brute_stats *brute_new_stats(void)
> >   * It's mandatory to disable interrupts before acquiring the brute_st=
ats::lock
> >   * since the task_free hook can be called from an IRQ context during =
the
> >   * execution of the task_alloc hook.
> > + *
> > + * Context: Must be called with interrupts disabled and brute_stats_p=
tr_lock
> > + *          held.
> >   */
> >  static void brute_share_stats(struct brute_stats *src,
> >  			      struct brute_stats **dst)
> >  {
> > -	unsigned long flags;
> > -
> > -	spin_lock_irqsave(&src->lock, flags);
> > +	spin_lock(&src->lock);
> >  	refcount_inc(&src->refc);
> >  	*dst =3D src;
> > -	spin_unlock_irqrestore(&src->lock, flags);
> > +	spin_unlock(&src->lock);
> >  }
>
> I still don't think any locking is needed here; the whole function can
> go away, IMO.

In this case I think this is possible:

Scenario 1: cpu 1 writes the stats pointer and cpu 2 is navigating the
            processes tree reading the same stats pointer.

Scenario 2: cpu 1 is navigating the processes tree reading the stats
            pointer and in IRQ the same stats pointer is wrote.

So, we need locking. Am I wrong?

> >  /**
> > @@ -126,26 +137,36 @@ static void brute_share_stats(struct brute_stats=
 *src,
> >   * this task and the new one being allocated. Otherwise, share the st=
atistics
> >   * that the current task already has.
> >   *
> > + * It's mandatory to disable interrupts before acquiring brute_stats_=
ptr_lock
> > + * and brute_stats::lock since the task_free hook can be called from =
an IRQ
> > + * context during the execution of the task_alloc hook.
> > + *
> >   * Return: -ENOMEM if the allocation of the new statistics structure =
fails. Zero
> >   *         otherwise.
> >   */
> >  static int brute_task_alloc(struct task_struct *task, unsigned long c=
lone_flags)
> >  {
> >  	struct brute_stats **stats, **p_stats;
> > +	unsigned long flags;
> >
> >  	stats =3D brute_stats_ptr(task);
> >  	p_stats =3D brute_stats_ptr(current);
> > +	write_lock_irqsave(&brute_stats_ptr_lock, flags);
> >
> >  	if (likely(*p_stats)) {
> >  		brute_share_stats(*p_stats, stats);
> > +		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> >  		return 0;
> >  	}
> >
> >  	*stats =3D brute_new_stats();
> > -	if (!*stats)
> > +	if (!*stats) {
> > +		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> >  		return -ENOMEM;
> > +	}
> >
> >  	brute_share_stats(*stats, p_stats);
> > +	write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> >  	return 0;
> >  }
>
> I'd much prefer that whatever locking is needed be introduced in the
> initial patch: this transformation just double the work to review. :)

So, IIUC I need to introduce all the locks in the initial patch even if
they are not necessary. Am I right?

> >
> > @@ -167,9 +188,9 @@ static int brute_task_alloc(struct task_struct *ta=
sk, unsigned long clone_flags)
> >   * only one task (the task that calls the execve function) points to =
the data.
> >   * In this case, the previous allocation is used but the statistics a=
re reset.
> >   *
> > - * It's mandatory to disable interrupts before acquiring the brute_st=
ats::lock
> > - * since the task_free hook can be called from an IRQ context during =
the
> > - * execution of the bprm_committing_creds hook.
> > + * It's mandatory to disable interrupts before acquiring brute_stats_=
ptr_lock
> > + * and brute_stats::lock since the task_free hook can be called from =
an IRQ
> > + * context during the execution of the bprm_committing_creds hook.
> >   */
> >  static void brute_task_execve(struct linux_binprm *bprm)
> >  {
> > @@ -177,24 +198,33 @@ static void brute_task_execve(struct linux_binpr=
m *bprm)
> >  	unsigned long flags;
> >
> >  	stats =3D brute_stats_ptr(current);
> > -	if (WARN(!*stats, "No statistical data\n"))
> > +	read_lock_irqsave(&brute_stats_ptr_lock, flags);
> > +
> > +	if (WARN(!*stats, "No statistical data\n")) {
> > +		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> >  		return;
> > +	}
> >
> > -	spin_lock_irqsave(&(*stats)->lock, flags);
> > +	spin_lock(&(*stats)->lock);
> >
> >  	if (!refcount_dec_not_one(&(*stats)->refc)) {
> >  		/* execve call after an execve call */
> >  		(*stats)->faults =3D 0;
> >  		(*stats)->jiffies =3D get_jiffies_64();
> >  		(*stats)->period =3D 0;
> > -		spin_unlock_irqrestore(&(*stats)->lock, flags);
> > +		spin_unlock(&(*stats)->lock);
> > +		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> >  		return;
> >  	}
> >
> >  	/* execve call after a fork call */
> > -	spin_unlock_irqrestore(&(*stats)->lock, flags);
> > +	spin_unlock(&(*stats)->lock);
> > +	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > +
> > +	write_lock_irqsave(&brute_stats_ptr_lock, flags);
> >  	*stats =3D brute_new_stats();
> >  	WARN(!*stats, "Cannot allocate statistical data\n");
> > +	write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> >  }
>
> Again, I don't see a need for locking -- this is just managing the
> lifetime which is entirely handled by the implicit locking of "current"
> and the refcount_t.

Here I can see the same two scenarios noted before. So I think the locking
is needed. Am I right?

> >  /**
> > @@ -204,9 +234,9 @@ static void brute_task_execve(struct linux_binprm =
*bprm)
> >   * The statistical data that is shared between all the fork hierarchy=
 processes
> >   * needs to be freed when this hierarchy disappears.
> >   *
> > - * It's mandatory to disable interrupts before acquiring the brute_st=
ats::lock
> > - * since the task_free hook can be called from an IRQ context during =
the
> > - * execution of the task_free hook.
> > + * It's mandatory to disable interrupts before acquiring brute_stats_=
ptr_lock
> > + * and brute_stats::lock since the task_free hook can be called from =
an IRQ
> > + * context during the execution of the task_free hook.
> >   */
> >  static void brute_task_free(struct task_struct *task)
> >  {
> > @@ -215,17 +245,446 @@ static void brute_task_free(struct task_struct =
*task)
> >  	bool refc_is_zero;
> >
> >  	stats =3D brute_stats_ptr(task);
> > -	if (WARN(!*stats, "No statistical data\n"))
> > +	read_lock_irqsave(&brute_stats_ptr_lock, flags);
> > +
> > +	if (WARN(!*stats, "No statistical data\n")) {
> > +		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> >  		return;
> > +	}
> >
> > -	spin_lock_irqsave(&(*stats)->lock, flags);
> > +	spin_lock(&(*stats)->lock);
> >  	refc_is_zero =3D refcount_dec_and_test(&(*stats)->refc);
> > -	spin_unlock_irqrestore(&(*stats)->lock, flags);
> > +	spin_unlock(&(*stats)->lock);
> > +	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> >
> >  	if (refc_is_zero) {
> > +		write_lock_irqsave(&brute_stats_ptr_lock, flags);
> >  		kfree(*stats);
> >  		*stats =3D NULL;
> > +		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
> > +	}
> > +}
>
> Same; I would expect this to be simply:

No comment. I think I am missing something. I need to clarify the previous
cases before to work on the next ones. Sorry and thanks for the guidance.

> 	stats =3D brute_stats_ptr(task);
> 	if (WARN_ON_ONCE(!*stats))
> 		return;
> 	if (refcount_dec_and_test(&(*stats)->refc)) {
> 		kfree(*stats);
> 		*stats =3D NULL;
> 	}
>
> > +
> > +/*
> > + * BRUTE_EMA_WEIGHT_NUMERATOR - Weight's numerator of EMA.
> > + */
> > +static const u64 BRUTE_EMA_WEIGHT_NUMERATOR =3D 7;
> > +
> > +/*
> > + * BRUTE_EMA_WEIGHT_DENOMINATOR - Weight's denominator of EMA.
> > + */
> > +static const u64 BRUTE_EMA_WEIGHT_DENOMINATOR =3D 10;
>
> Should these be externally configurable (via sysfs)?

No problem. I think this is easier than locking :)

>
> > +
> > +/**
> > + * brute_mul_by_ema_weight() - Multiply by EMA weight.
> > + * @value: Value to multiply by EMA weight.
> > + *
> > + * Return: The result of the multiplication operation.
> > + */
> > +static inline u64 brute_mul_by_ema_weight(u64 value)
> > +{
> > +	return mul_u64_u64_div_u64(value, BRUTE_EMA_WEIGHT_NUMERATOR,
> > +				   BRUTE_EMA_WEIGHT_DENOMINATOR);
> > +}
> > +
> > +/*
> > + * BRUTE_MAX_FAULTS - Maximum number of faults.
> > + *
> > + * If a brute force attack is running slowly for a long time, the app=
lication
> > + * crash period's EMA is not suitable for the detection. This type of=
 attack
> > + * must be detected using a maximum number of faults.
> > + */
> > +static const unsigned char BRUTE_MAX_FAULTS =3D 200;
>
> Same.
Ok, understood.
>
> > +
> > +/**
> > + * brute_update_crash_period() - Update the application crash period.
> > + * @stats: Statistics that hold the application crash period to updat=
e.
> > + * @now: The current timestamp in jiffies.
> > + *
> > + * The application crash period must be a value that is not prone to =
change due
> > + * to spurious data and follows the real crash period. So, to compute=
 it, the
> > + * exponential moving average (EMA) is used.
> > + *
> > + * This kind of average defines a weight (between 0 and 1) for the ne=
w value to
> > + * add and applies the remainder of the weight to the current average=
 value.
> > + * This way, some spurious data will not excessively modify the avera=
ge and only
> > + * if the new values are persistent, the moving average will tend tow=
ards them.
> > + *
> > + * Mathematically the application crash period's EMA can be expressed=
 as
> > + * follows:
> > + *
> > + * period_ema =3D period * weight + period_ema * (1 - weight)
> > + *
> > + * If the operations are applied:
> > + *
> > + * period_ema =3D period * weight + period_ema - period_ema * weight
> > + *
> > + * If the operands are ordered:
> > + *
> > + * period_ema =3D period_ema - period_ema * weight + period * weight
> > + *
> > + * Finally, this formula can be written as follows:
> > + *
> > + * period_ema -=3D period_ema * weight;
> > + * period_ema +=3D period * weight;
> > + *
> > + * The statistics that hold the application crash period to update ca=
nnot be
> > + * NULL.
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
> > + * Return: The last crash timestamp before updating it.
> > + */
> > +static u64 brute_update_crash_period(struct brute_stats *stats, u64 n=
ow)
> > +{
> > +	u64 current_period;
> > +	u64 last_crash_timestamp;
> > +
> > +	spin_lock(&stats->lock);
> > +	current_period =3D now - stats->jiffies;
> > +	last_crash_timestamp =3D stats->jiffies;
> > +	stats->jiffies =3D now;
> > +
> > +	stats->period -=3D brute_mul_by_ema_weight(stats->period);
> > +	stats->period +=3D brute_mul_by_ema_weight(current_period);
> > +
> > +	if (stats->faults < BRUTE_MAX_FAULTS)
> > +		stats->faults +=3D 1;
> > +
> > +	spin_unlock(&stats->lock);
> > +	return last_crash_timestamp;
> > +}
>
> Now *here* locking makes sense, and it only needs to be per-stat, not
> global, since multiple processes may be operating on the same stat
> struct. To make this more no-reader-locking-friendly, I'd also update
> everything at the end, and use WRITE_ONCE():
>
> 	u64 current_period, period;
> 	u64 last_crash_timestamp;
> 	u64 faults;
>
> 	spin_lock(&stats->lock);
> 	current_period =3D now - stats->jiffies;
> 	last_crash_timestamp =3D stats->jiffies;
>
> 	WRITE_ONCE(stats->period,
> 		   stats->period - brute_mul_by_ema_weight(stats->period) +
> 		   brute_mul_by_ema_weight(current_period));
>
> 	if (stats->faults < BRUTE_MAX_FAULTS)
> 		WRITE_ONCE(stats->faults, stats->faults + 1);
>
> 	WRITE_ONCE(stats->jiffies, now);
>
> 	spin_unlock(&stats->lock);
> 	return last_crash_timestamp;
>
> That way readers can (IIUC) safely use READ_ONCE() on jiffies and faults
> without needing to hold the &stats->lock (unless they need perfectly mat=
ching
> jiffies, period, and faults).

Thanks for the refactory. I will work on it (if I can understand locking).=
 :(

> > +
> > +/*
> > + * BRUTE_MIN_FAULTS - Minimum number of faults.
> > + *
> > + * The application crash period's EMA cannot be used until a minimum =
number of
> > + * data has been applied to it. This constraint allows getting a tren=
d when this
> > + * moving average is used. Moreover, it avoids the scenario where an =
application
> > + * fails quickly from execve system call due to reasons unrelated to =
a real
> > + * attack.
> > + */
> > +static const unsigned char BRUTE_MIN_FAULTS =3D 5;
> > +
> > +/*
> > + * BRUTE_CRASH_PERIOD_THRESHOLD - Application crash period threshold.
> > + *
> > + * The units are expressed in milliseconds.
> > + *
> > + * A fast brute force attack is detected when the application crash p=
eriod falls
> > + * below this threshold.
> > + */
> > +static const u64 BRUTE_CRASH_PERIOD_THRESHOLD =3D 30000;
>
> These could all be sysctls (see yama's use of sysctl).

Ok

> > +
> > +/**
> > + * brute_attack_running() - Test if a brute force attack is happening=
.
> > + * @stats: Statistical data shared by all the fork hierarchy processe=
s.
> > + *
> > + * The decision if a brute force attack is running is based on the st=
atistical
> > + * data shared by all the fork hierarchy processes. This statistics c=
annot be
> > + * NULL.
> > + *
> > + * There are two types of brute force attacks that can be detected us=
ing the
> > + * statistical data. The first one is a slow brute force attack that =
is detected
> > + * if the maximum number of faults per fork hierarchy is reached. The=
 second
> > + * type is a fast brute force attack that is detected if the applicat=
ion crash
> > + * period falls below a certain threshold.
> > + *
> > + * Moreover, it is important to note that no attacks will be detected=
 until a
> > + * minimum number of faults have occurred. This allows to have a tren=
d in the
> > + * crash period when the EMA is used and also avoids the scenario whe=
re an
> > + * application fails quickly from execve system call due to reasons u=
nrelated to
> > + * a real attack.
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
> > + * Return: True if a brute force attack is happening. False otherwise=
.
> > + */
> > +static bool brute_attack_running(struct brute_stats *stats)
> > +{
> > +	u64 crash_period;
> > +
> > +	spin_lock(&stats->lock);
> > +	if (stats->faults < BRUTE_MIN_FAULTS) {
> > +		spin_unlock(&stats->lock);
> > +		return false;
> > +	}
>
> If I'm reading this correctly, you're performing two tests, so there
> isn't a strict relationship between faults and period for this test,
> and I think it could be done without locking with READ_ONCE():
>
> 	u64 faults;
> 	u64 crash_period;
>
> 	faults =3D READ_ONCE(stats->faults);
> 	if (faults < BRUTE_MIN_FAULTS)
> 		return false;
> 	if (faults >=3D BRUTE_MAX_FAULTS)
> 		return true;
>
> 	crash_period =3D jiffies64_to_msecs(READ_ONCE(stats->period));
> 	return crash_period < BRUTE_CRASH_PERIOD_THRESHOLD;

Thanks, I will work on it for the next version.

> > +
> > +	if (stats->faults >=3D BRUTE_MAX_FAULTS) {
> > +		spin_unlock(&stats->lock);
> > +		return true;
> > +	}
> > +
> > +	crash_period =3D jiffies64_to_msecs(stats->period);
> > +	spin_unlock(&stats->lock);
> > +
> > +	return crash_period < BRUTE_CRASH_PERIOD_THRESHOLD;
> > +}
> > +
> > +/**
> > + * print_fork_attack_running() - Warn about a fork brute force attack=
.
> > + */
> > +static inline void print_fork_attack_running(void)
> > +{
> > +	pr_warn("Fork brute force attack detected [%s]\n", current->comm);
> > +}
>
> I think pid should be part of this...

No problem.

> > +
> > +/**
> > + * brute_manage_fork_attack() - Manage a fork brute force attack.
> > + * @stats: Statistical data shared by all the fork hierarchy processe=
s.
> > + * @now: The current timestamp in jiffies.
> > + *
> > + * For a correct management of a fork brute force attack it is only n=
ecessary to
> > + * update the statistics and test if an attack is happening based on =
these data.
> > + *
> > + * The statistical data shared by all the fork hierarchy processes ca=
nnot be
> > + * NULL.
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
> > + * Return: The last crash timestamp before updating it.
> > + */
> > +static u64 brute_manage_fork_attack(struct brute_stats *stats, u64 no=
w)
> > +{
> > +	u64 last_fork_crash;
> > +
> > +	last_fork_crash =3D brute_update_crash_period(stats, now);
> > +	if (brute_attack_running(stats))
> > +		print_fork_attack_running();
> > +
> > +	return last_fork_crash;
> > +}
> > +
> > +/**
> > + * brute_get_exec_stats() - Get the exec statistics.
> > + * @stats: When this function is called, this parameter must point to=
 the
> > + *         current process' statistical data. When this function retu=
rns, this
> > + *         parameter points to the parent process' statistics of the =
fork
> > + *         hierarchy that hold the current process' statistics.
> > + *
> > + * To manage a brute force attack that happens through the execve sys=
tem call it
> > + * is not possible to use the statistical data hold by this process d=
ue to these
> > + * statistics disappear when this task is finished. In this scenario =
this data
> > + * should be tracked by the statistics of a higher fork hierarchy (th=
e hierarchy
> > + * that contains the process that forks before the execve system call=
).
> > + *
> > + * To find these statistics the current fork hierarchy must be traver=
sed up
> > + * until new statistics are found.
> > + *
> > + * Context: Must be called with tasklist_lock and brute_stats_ptr_loc=
k held.
> > + */
> > +static void brute_get_exec_stats(struct brute_stats **stats)
> > +{
> > +	const struct task_struct *task =3D current;
> > +	struct brute_stats **p_stats;
> > +
> > +	do {
> > +		if (!task->real_parent) {
> > +			*stats =3D NULL;
> > +			return;
> > +		}
> > +
> > +		p_stats =3D brute_stats_ptr(task->real_parent);
> > +		task =3D task->real_parent;
> > +	} while (*stats =3D=3D *p_stats);
> > +
> > +	*stats =3D *p_stats;
> > +}
>
> See Yama's task_is_descendant() for how to walk up the process tree
> (and I think the process group stuff will save some steps too); you
> don't need tasklist_lock held, just rcu_read_lock held, AIUI:
> Documentation/RCU/listRCU.rst
>
> And since you're passing this stats struct back up, and it would be outs=
ide of rcu read lock, you'd want to do a "get" on it first:
>
> 	rcu_read_lock();
> 	loop {
> 		...
> 	}
> 	refcount_inc_not_zero(&(*p_stats)->refc);
> 	rcu_read_unlock();
>
> 	*stats =3D *p_stats

Thanks for the suggestions. I will work on it for the next version.
Anyway, in the first version Kees Cook and Jann Horn noted that some tasks
could escape the rcu read lock and that alternate locking were needed.

Extract from the RFC:

[Kees Cook]
Can't newly created processes escape this RCU read lock? I think this
need alternate locking, or something in the task_alloc hook that will
block any new process from being created within the stats group.

[Jann Horn]
Good point; the proper way to deal with this would probably be to take
the tasklist_lock in read mode around this loop (with
read_lock(&tasklist_lock) / read_unlock(&tasklist_lock)), which pairs
with the write_lock_irq(&tasklist_lock) in copy_process(). Thanks to
the fatal_signal_pending() check while holding the lock in
copy_process(), that would be race-free - any fork() that has not yet
inserted the new task into the global task list would wait for us to
drop the tasklist_lock, then bail out at the fatal_signal_pending()
check.

I think that this scenario is still possible. So the tasklist_lock is
necessary. Am I right?

> > +
> > +/**
> > + * brute_update_exec_crash_period() - Update the exec crash period.
> > + * @stats: When this function is called, this parameter must point to=
 the
> > + *         current process' statistical data. When this function retu=
rns, this
> > + *         parameter points to the updated statistics (statistics tha=
t track the
> > + *         info to manage a brute force attack that happens through t=
he execve
> > + *         system call).
> > + * @now: The current timestamp in jiffies.
> > + * @last_fork_crash: The last fork crash timestamp before updating it=
.
> > + *
> > + * If this is the first update of the statistics used to manage a bru=
te force
> > + * attack that happens through the execve system call, its last crash=
 timestamp
> > + * (the timestamp that shows when the execve was called) cannot be us=
ed to
> > + * compute the crash period's EMA. Instead, the last fork crash times=
tamp should
> > + * be used (the last crash timestamp of the child fork hierarchy befo=
re updating
> > + * the crash period). This allows that in a brute force attack that h=
appens
> > + * through the fork system call, the exec and fork statistics are the=
 same. In
> > + * this situation, the mitigation method will act only in the process=
es that are
> > + * sharing the fork statistics. This way, the process that forked bef=
ore the
> > + * execve system call will not be involved in the mitigation method. =
In this
> > + * scenario, the parent is not responsible of the child's behaviour.
> > + *
> > + * It's mandatory to disable interrupts before acquiring the brute_st=
ats::lock
> > + * since the task_free hook can be called from an IRQ context during =
the
> > + * execution of the task_fatal_signal hook.
> > + *
> > + * Context: Must be called with interrupts disabled and tasklist_lock=
 and
> > + *          brute_stats_ptr_lock held.
> > + * Return: -EFAULT if there are no exec statistics. Zero otherwise.
> > + */
> > +static int brute_update_exec_crash_period(struct brute_stats **stats,
> > +					  u64 now, u64 last_fork_crash)
> > +{
> > +	brute_get_exec_stats(stats);
> > +	if (!*stats)
> > +		return -EFAULT;
>
> This isn't EFAULT (userspace memory fault), but rather more EINVAL or
> ESRCH.

Ok.

> > +
> > +	spin_lock(&(*stats)->lock);
> > +	if (!(*stats)->faults)
> > +		(*stats)->jiffies =3D last_fork_crash;
> > +	spin_unlock(&(*stats)->lock);
> > +
> > +	brute_update_crash_period(*stats, now);
>
> and then you can add:
>
> 	if (refcount_dec_and_test(&(*stats)->refc))
> 		kfree(*stats);
>
> (or better yet, make that a helper) named something like
> "put_brute_stats".

Sorry, but I don't understand why we need to free the stats here.
What is the rationale behind this change?

> > +	return 0;
> > +}
>
> I find the re-writing of **stats confusing here -- I think you should
> leave that unmodified, and instead return a pointer (instead of "int"),
> and for errors, use ERR_PTR(-ESRCH)

Ok, thanks.

> > +
> > +/**
> > + * brute_get_crash_period() - Get the application crash period.
> > + * @stats: Statistical data shared by all the fork hierarchy processe=
s.
> > + *
> > + * The statistical data shared by all the fork hierarchy processes ca=
nnot be
> > + * NULL.
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
> > + * Return: The application crash period.
> > + */
> > +static u64 brute_get_crash_period(struct brute_stats *stats)
> > +{
> > +	u64 crash_period;
> > +
> > +	spin_lock(&stats->lock);
> > +	crash_period =3D stats->period;
> > +	spin_unlock(&stats->lock);
> > +
> > +	return crash_period;
> > +}
>
> return READ_ONCE(stats->period);

Ok, thanks.

> > +
> > +/**
> > + * print_exec_attack_running() - Warn about an exec brute force attac=
k.
> > + * @stats: Statistical data shared by all the fork hierarchy processe=
s.
> > + *
> > + * The statistical data shared by all the fork hierarchy processes ca=
nnot be
> > + * NULL.
> > + *
> > + * Before showing the process name it is mandatory to find a process =
that holds
> > + * a pointer to the exec statistics.
> > + *
> > + * Context: Must be called with tasklist_lock and brute_stats_ptr_loc=
k held.
> > + */
> > +static void print_exec_attack_running(const struct brute_stats *stats=
)
> > +{
> > +	struct task_struct *p;
> > +	struct brute_stats **p_stats;
> > +	bool found =3D false;
> > +
> > +	for_each_process(p) {
> > +		p_stats =3D brute_stats_ptr(p);
> > +		if (*p_stats =3D=3D stats) {
> > +			found =3D true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (WARN(!found, "No exec process\n"))
> > +		return;
> > +
> > +	pr_warn("Exec brute force attack detected [%s]\n", p->comm);
> > +}
>
> Same logic to change here as above for talking the process list. (IIUC, =
since
> you're only reading, you don't need tasklist_lock, just rcu_read_lock.)
> But, if I'm reading this right, you only ever call this with "current".
> It seems like it would be way more efficient to just use "current"
> instead?

Ok, I will work on it. Thanks.

> > +
> > +/**
> > + * brute_manage_exec_attack() - Manage an exec brute force attack.
> > + * @stats: Statistical data shared by all the fork hierarchy processe=
s.
> > + * @now: The current timestamp in jiffies.
> > + * @last_fork_crash: The last fork crash timestamp before updating it=
.
> > + *
> > + * For a correct management of an exec brute force attack it is only =
necessary
> > + * to update the exec statistics and test if an attack is happening b=
ased on
> > + * these data.
> > + *
> > + * It is important to note that if the fork and exec crash periods ar=
e the same,
> > + * the attack test is avoided. This allows that in a brute force atta=
ck that
> > + * happens through the fork system call, the mitigation method does n=
ot act on
> > + * the parent process of the fork hierarchy.
> > + *
> > + * The statistical data shared by all the fork hierarchy processes ca=
nnot be
> > + * NULL.
> > + *
> > + * It's mandatory to disable interrupts before acquiring the brute_st=
ats::lock
> > + * since the task_free hook can be called from an IRQ context during =
the
> > + * execution of the task_fatal_signal hook.
> > + *
> > + * Context: Must be called with interrupts disabled and tasklist_lock=
 and
> > + *          brute_stats_ptr_lock held.
> > + */
> > +static void brute_manage_exec_attack(struct brute_stats *stats, u64 n=
ow,
> > +				     u64 last_fork_crash)
> > +{
> > +	int ret;
> > +	struct brute_stats *exec_stats =3D stats;
> > +	u64 fork_period;
> > +	u64 exec_period;
> > +
> > +	ret =3D brute_update_exec_crash_period(&exec_stats, now, last_fork_c=
rash);
> > +	if (WARN(ret, "No exec statistical data\n"))
> > +		return;
>
> I think this should fail closed: if there's a static processing error,
> treat it as an attack.

Do you mean to trigger the mitigation of a brute force attack over this ta=
sk?
So, IIUC you suggest that instead of generate warnings if there isn't
statistical data, we need to trigger the mitigation? This can be applied t=
o
the case where the allocation of a brute_stats structure fails?

> > +
> > +	fork_period =3D brute_get_crash_period(stats);
> > +	exec_period =3D brute_get_crash_period(exec_stats);
> > +	if (fork_period =3D=3D exec_period)
> > +		return;
> > +
> > +	if (brute_attack_running(exec_stats))
> > +		print_exec_attack_running(exec_stats);
> > +}
> > +
>
> I think this is very close!

Thank you very much for the comments and guidance.
John Wood
