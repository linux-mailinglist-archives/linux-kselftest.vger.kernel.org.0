Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C185A342DF9
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Mar 2021 16:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhCTPtt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Mar 2021 11:49:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:39845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhCTPtf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Mar 2021 11:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616255332;
        bh=3039Ka36kQzxCE7OByeZhquPAelPder0B3E3vpB55Ck=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aE49Md6Iux30mr0x8tGfhY5GmawKL3nCQ0etw2AtfFVoeW7iiEVCbUCillVO2nYWU
         POpPQmh/yGNCmZjsJZYVP+EFHUcEb0NcNVXFF9rETurvO2v/w1TY8zn8K0EmeclH/K
         /aCK527xObKL1tw/F+l+wBzRww1IfOgo3w+qmRug=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhlKs-1lsYol2fvk-00dnBe; Sat, 20
 Mar 2021 16:48:51 +0100
Date:   Sat, 20 Mar 2021 16:48:47 +0100
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
Subject: Re: [PATCH v6 5/8] security/brute: Mitigate a brute force attack
Message-ID: <20210320154847.GD3023@ubuntu>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-6-john.wood@gmx.com>
 <202103172102.03F172613@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103172102.03F172613@keescook>
X-Provags-ID: V03:K1:zhMg8DWoJRCi7o6If91Omz30/GycNUkeI5EMSTZ9GuVgCAvTA8e
 W5UKMpAGryRY1a8a/x/t8wdyTnOWrI14uVCUokBmniOHh9vyyiVGjuEtGWzC2uIxgBk5G3q
 eJBWZwFLTf3n+Zy1srft/RSB9UIl658P6vA3HoGBkPshri44I6fdHySCmcRwqWfrQFN/WLz
 bTwOja+xyGuSYAd9Lih6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vPku32uMuX4=:ub4o/PyXc68JUwoltAckTD
 K3lhEw2/Q73IRCe0BjqqXe1cTOFKjd0DRuFS6IrUNIWqwwMwRGTYxuOF+c5syN2mX6QuLFwx1
 q4aLR72VbPIt9HrhJtMgB4MDvquukuLdtLxIdf2qBz6v4yI7y4jAmhtVlHnVxCJF/YgFt/Lsz
 sZf81iqp5uZfJM8oLChQd+1jCUV9r0Xc8u3V/NtxN6grltnobBfIgcWl9xyB70oCYFgGYl953
 eii1BMEuFbTR8p0RCWIUmb95WvxT3nKmoZTTLghqtCf6Bbe2uTbWrW90+DPNpTMbh/IPfcTAs
 1tQM5PF+2/QWADSN6BCTh2nzN+lmXVHJKqE2fIkTjnV5WKpR1bB+I4VphMJqv5i8N964khT8B
 xJTsekVj6EMmGeVHgtd8wdv1gEBZOJzwpC4gVwzrLeSW9Bi2hNe/LgV5hxvB7a+8uoWvQR2q3
 ULZYy/GsAXQOwSyqJ7x24GRU0cKoojPDTbgk1ExiAqrzKutZfWmtMYUcdNtvPb66vIURPrzCT
 liVfQHNGgNWsOuqJVMfnEPgVEm3YRTYQahu8VkCaqqWOtoKGFTrQmVPqwEI4/Lcknk6fDjklN
 4oBbMmljLpkLN4UP4CVVOTiHHmpsEZvYzh7qnOri5jJrGyHHlii1a0rfkTe9sH6w8lafHeHNJ
 mbS99b0QqO3pCaRv4qLxA3v4vrKQpM7RNNV+h1NKLUD0//lrxOuYO7GU9qmRrr05WHjDtH3/t
 bJ+W8P7dRXZiOs0VAtUng5YDZolz8c7PMPF0L30UXDc3tt7oJ//PaW/jTq5VEO/LJhGfmtAfA
 p93jWdgLVxI10RXEK3UISOSJZD8qEHF6oITnqf7MI3gMDZLYm62C85CdQc55aP2hLQV2UV8kF
 SOmvv2rOy1J4nCw17AdkpBIOvruxvWQ1Zu3US38RgoSAt8PBsEwdd8dvS9+t19PwYRENZRniZ
 9moM19IUamxTKdhk4uyej5x4aXrGrfbOZBIRT7M3vizW181/S5sb5G1QciejSLWAA3MJF4Zjk
 fDZkuxwgVSyL95B0qKs6xvJzRzK1FeHwht4Rzctxl1O3OOzBcEZ2CM6RsR4LPeICg44Vvc14P
 wxUxt34VdScdUoXM4GbuZeSym4u5fVYlVc/tULN2ExBRiVq8q4vHo/tHbaKxI2DN5mtwxZwpT
 JaLDsxMV5ng5B5mRNblR8DLH+Kusmw+xiiaJRElGeZWGhjt+5FgmGharj8PbTXrwPw00w=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 17, 2021 at 09:04:15PM -0700, Kees Cook wrote:
> On Sun, Mar 07, 2021 at 12:30:28PM +0100, John Wood wrote:
> > +/**
> > + * brute_kill_offending_tasks() - Kill the offending tasks.
> > + * @attack_type: Brute force attack type.
> > + * @stats: Statistical data shared by all the fork hierarchy processe=
s.
> > + *
> > + * When a brute force attack is detected all the offending tasks invo=
lved in the
> > + * attack must be killed. In other words, it is necessary to kill all=
 the tasks
> > + * that share the same statistical data. Moreover, if the attack happ=
ens through
> > + * the fork system call, the processes that have the same group_leade=
r that the
> > + * current task must be avoided since they are in the path to be kill=
ed.
> > + *
> > + * When the SIGKILL signal is sent to the offending tasks, this funct=
ion will be
> > + * called again from the task_fatal_signal hook due to a small crash =
period. So,
> > + * to avoid kill again the same tasks due to a recursive call of this=
 function,
> > + * it is necessary to disable the attack detection for this fork hier=
archy.
>
> Hah. Interesting. I wonder if there is a better way to handle this. Hmm.

If your comment is related to disable the detection:

I think it's no problematic to disable the attack detection for this fork
hierarchy since all theirs tasks will be removed. Also, I think that the d=
isable
mark can help in the path to use the wait*() functions to notify userspace=
 that
a task has been killed by the brute mitigation. Is a work in progress now.

If your comment is related to kill all the tasks:

In the previous version I have a useful discussion with Andi Kleen where a
proposal to block the fork system call during a time was made. He explains=
 me
the cons of this method and proposes that if the mitigation works as now w=
e can
use the wait*() functions to notify userspace that the tasks has been kill=
ed
by the brute mitigation. This way other problems related with the supervis=
ors
and respawned processes could be handled.

Anyway, new points of view are also welcome.

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
> > +static void brute_kill_offending_tasks(enum brute_attack_type attack_=
type,
> > +				       struct brute_stats *stats)
> > +{
> > +	struct task_struct *p;
> > +	struct brute_stats **p_stats;
> > +
> > +	spin_lock(&stats->lock);
> > +
> > +	if (attack_type =3D=3D BRUTE_ATTACK_TYPE_FORK &&
> > +	    refcount_read(&stats->refc) =3D=3D 1) {
> > +		spin_unlock(&stats->lock);
> > +		return;
> > +	}
>
> refcount_read() isn't a safe way to check that there is only 1
> reference. What's this trying to do?

If a fork brute force attack has been detected is due to a new fatal crash=
.
Under this scenario, if there is only one reference of these stats, it is
not necessary to kill any other tasks since the stats are not shared with
another process. Moreover, if this task has failed in a fatal way, is in
the path to be killed. So, no action is required.

How can I make this check in a safe way?

> > +
> > +	brute_disable(stats);
> > +	spin_unlock(&stats->lock);
> > +
> > +	for_each_process(p) {
> > +		if (attack_type =3D=3D BRUTE_ATTACK_TYPE_FORK &&
> > +		    p->group_leader =3D=3D current->group_leader)
> > +			continue;
> > +
> > +		p_stats =3D brute_stats_ptr(p);
> > +		if (*p_stats !=3D stats)
> > +			continue;
> > +
> > +		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_PID);
> > +		pr_warn_ratelimited("Offending process %d [%s] killed\n",
> > +				    p->pid, p->comm);
> > +	}
> > +}

Thanks,
John Wood
