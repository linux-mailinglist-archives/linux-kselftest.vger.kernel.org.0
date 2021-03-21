Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE0343318
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Mar 2021 16:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhCUPC7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Mar 2021 11:02:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:56355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhCUPCg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Mar 2021 11:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616338895;
        bh=iZJ0fOWpOJ6yY0YV5G44L2lg06KSmwtvnOJXaEkExtE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=TNevtl3AfhJUXcEqpWTW7NUxLvQgd20u+CY0RdjZf3BujlDhlIXg7X1pLwFuxZXhj
         +YTaIqJ2gjjdMsNcalHURPf3NkI8uqHAu5Wgmk4uEt7R/BHTIy++v3ecmsSGpXyC8X
         mmrsTxIKn/U+Jhv3dU7SwYGNs1saYQhvHW5yadII=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2wGi-1lP4yZ05KW-003QLQ; Sun, 21
 Mar 2021 16:01:35 +0100
Date:   Sun, 21 Mar 2021 16:01:18 +0100
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
Message-ID: <20210321150118.GA3403@ubuntu>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-4-john.wood@gmx.com>
 <202103171902.E6F55172@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103171902.E6F55172@keescook>
X-Provags-ID: V03:K1:5iRc4TE2gbTpb1q7wZQyWklMZ218cDZeiH3XZxqi5sSaQxM3sNN
 seyl4NGaBffNBmBaIVTCRRhcemFFknJCGG8DQxU3rAocenFA7bAbupDbVanP8H3YoLBMOtQ
 35N+lxieCSch3to5WtQHN5/RcoUdtyzSD/Xk6BKCqj/tY/EUDpeqwHz3rGEry2dh8W6NAeS
 jcPWupq9LS2Vd1A9jIM0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3NbpJK5y4jQ=:aWD+YeneMTTP1w7cCN7+0z
 cVvuc+lpMtMDvU5ZF6QBO/z6KbyT7iqW1Be8hzoGjRklSCcBH5HU/RZ5HWoziUwNyo+BCYJjG
 PyndvJwlRu8O8kiPtey9mUMJacigX9OB4GN7a71Tk+bfyyGRmjXK4g9v4m4lar3viWTqnpvgP
 Nm9pmzaTxAVfA64WnD5Py0f1XiFP+mRHYn4IR9iM/8N6J30g79E2oMg/c6ld3KF+lXfXgvc3O
 +hN5b8zHP+RLNkHRs1T56G7+mGHcapU0WJCfKHFOQi7dg8u5IuBkDCPp5eurv8xDwHlDyip+t
 +jAku8To2bkM1NuAvPGk0H3WvE0DLUSzzJHZwe4jZUaeZ56stCRSau6Q5Z4zQzcyv3GTzBpfp
 6ljpBfE5GmGeJr7K5dVg95RtnA4XSiB9xC4dlSOrQhmvUT2TiDiJfL37HnXQhRUvzW8glBELx
 2XxeDX06zUShlRcQc3gb0YP2TKtIXf+M92S3iHj/A43lpWEkJTU3tWLZ5ScpXGWvZcngPs1jd
 vlNdBXCSGrqlDQ1RZS/ETph2iJLi3htdbB2kIuGBr4dONIIaXtc5/EHr1LgG1HQSzaMBIdsAQ
 JnkrGDELCsMOT3jeBG1JxAMF9UahobGYIVZZHzvGSGO5Bb+ZoazS3jII0lLu9b0KtOiZ69qIR
 bB5ptTCMRWlj8uhmo/6xLkFVW6AXdbivIDil7KtuwQ/OeTELIt09CL8nSg7metZEwvg1fULeo
 2ohv9SfeEkjEAdEbQeYqvQe0FYrjsuWwpIon7UZtiTT2sF6C6Ng0nY57aqgRBBKSAx2eT1cCF
 Trx+Rnj/h2rYdNbighM1cDX+Sc6hlTI0DQIrnGxcNI/pqNG3y4AIIlN+VnXg2yfIMWqKGcHn+
 Me9X3NmpEyW2ipHkzm0g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 17, 2021 at 07:57:10PM -0700, Kees Cook wrote:
> On Sun, Mar 07, 2021 at 12:30:26PM +0100, John Wood wrote:
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

Sorry, but I try to understand how to use locking properly without luck.

I have read (and tried to understand):
   tools/memory-model/Documentation/simple.txt
   tools/memory-model/Documentation/ordering.txt
   tools/memory-model/Documentation/recipes.txt
   Documentation/memory-barriers.txt

And I don't find the responses that I need. I'm not saying they aren't
there but I don't see them. So my questions:

If in the above function makes sense to use locking, and it is called from
the brute_task_fatal_signal hook, then, all the functions that are called
from this hook need locking (more than one process can access stats at the
same time).

So, as you point, how it is possible and safe to read jiffies and faults
(and I think period even though you not mention it) using READ_ONCE() but
without holding brute_stats::lock? I'm very confused.

IIUC (during the reading of the documentation) READ_ONCE and WRITE_ONCE on=
ly
guarantees that a variable loaded with WRITE_ONCE can be read safely with
READ_ONCE avoiding tearing, etc. So, I see these functions like a form of
guarantee atomicity in variables.

Another question. Is it also safe to use WRITE_ONCE without holding the lo=
ck?
Or this is only appliable to read operations?

Any light on this will help me to do the best job in the next patches. If
somebody can point me to the right direction it would be greatly appreciat=
ed.

Is there any documentation for newbies regarding this theme? I'm stuck.
I have also read the documentation about spinlocks, semaphores, mutex, etc=
..
but nothing clears me the concept expose.

Apologies if this question has been answered in the past. But the search i=
n
the mailing list has not been lucky.

Thanks for your time and patience.
John Wood
