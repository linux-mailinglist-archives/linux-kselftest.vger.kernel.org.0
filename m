Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B613D344E99
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 19:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhCVSdT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 14:33:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:53159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231734AbhCVSc6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 14:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616437935;
        bh=a9Q8Zcnw/xf9sXWdpvtkD22X/toBDzx5VCNMGPqEsao=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=V+IEsbsg7pA8J46v3DI+dAtmCtV6lBWVzlRyw8QPDa9OwVA/xsKrEHq/ZG0KrPkHo
         sDyi4LRHH2WuE1Y2Cs4A+qs3QVtSFQ8S7LqSf9t/vtvSoPk1iqTy5TpnCVG0bGhcWp
         2W6e0vm15HHS1YDUsbcuaBwvhHpYVVrsZeZDPTmo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJVG-1lujlJ04dK-00fUtT; Mon, 22
 Mar 2021 19:32:15 +0100
Date:   Mon, 22 Mar 2021 19:32:01 +0100
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
Message-ID: <20210322183201.GA3401@ubuntu>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-4-john.wood@gmx.com>
 <202103171902.E6F55172@keescook>
 <20210321150118.GA3403@ubuntu>
 <202103211128.B59FEB91F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103211128.B59FEB91F@keescook>
X-Provags-ID: V03:K1:v1YYfDM4ZzWgD2iLohzBa4hvx/dVZggni7kZwkchp3kHU/01//I
 C2Oinu1rDKAQRRiEUgF2Twqs7C5KvD2CLs+AE4WG8sDVw+pbeuEceyAXjiafm4H3xvuAW6v
 H+I9Ko1qx6aJ2dKurmRWhGY9pM3sAkkiCr499DVfuESAbJfwK3tvBqsO+pWwkiPQvhgkIEq
 /B095FfHE6Enpr+2ol5yg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qUJ7roGywfk=:fBRjjkvxFOsWRm92sDEG5J
 fZol4nE3DxEHkCEFoKKpPv1BUPhVSQTV9rjS9X/WIKJ1CAke7JXqq+aRTMXlet4aJmmJ0wUwv
 2EZqyktEQFCYKhV4aZRJ/7qUtY/6EAO0XiRqaOQJT9PUkDMBpeh+gNGwgjGxto1sLd/dJJOjF
 HXI3gPzyAJStb+Z2shGg3618w6cPoFCXMQp0fzvV/iAH/6oxWVjtOA5MPrQ7Fgp9cCy3Y0Qye
 maOcQmLkB1GkFjH20Dzixc+iZYQAu38ZntB+FyXv3Oc6UvUoxfuR8SkUfym8FbAowtdW99UbK
 lmKPJpkftX/qN8uBj/FjA7dH9QMETEoFSssd2bVl+fhvZxOlfRMI/GYWAOUyPuxrrmeIVvRUq
 QII1NMqHh8yVFC+7ZR/Gij5q/jt0CdN+tQs65IeQGJNHuqmzzQGChx//PWqcuLEEHf7MJPGcT
 dvNwwpEgnzc8SnGA8Su9F/5DFkHghwP9NKQ3GCEsWCTJhRK5GIzC5xtl43AdBQZvskMLQBZq/
 5c5yo15l5INHhsRb3vz0qjLGbwPvKgyAJ+yzQ0Z8piLhnzpdCfcXHUmH2INAsIhqCvcpCkT+y
 5nLdiGwJeLg3Rlaqd/rubsD30ZoPE70sSKXFF5lgC/WOobuPPuMyFiE9TKvtVsk5YKvBGjr4J
 Q0OFra46huJKsYXjBWd1ZqwpqQmbx56FFXqmUfXZuHIzzs5JAsjn3PZfv+jeeO7NT1uSzZPU8
 gtCMj6nNFM5XlpoRct1c28iubp0Z/wpLGZz+Qy5uVKxUF4X5cCU6KgUcQzLaHF51LjAcNo6sV
 lv1WvrC6ZnS8rr6M30fJCT6TGccaeT9uznqDAXSNeVaJJ1LQsS7ZmAdD10nF9W9flE/Te1Ve6
 dxMbxvJPHRpC/J+lKN9g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Sun, Mar 21, 2021 at 11:45:59AM -0700, Kees Cook wrote:
> On Sun, Mar 21, 2021 at 04:01:18PM +0100, John Wood wrote:
> > On Wed, Mar 17, 2021 at 07:57:10PM -0700, Kees Cook wrote:
> > > On Sun, Mar 07, 2021 at 12:30:26PM +0100, John Wood wrote:
> > Sorry, but I try to understand how to use locking properly without luc=
k.
> >
> > I have read (and tried to understand):
> >    tools/memory-model/Documentation/simple.txt
> >    tools/memory-model/Documentation/ordering.txt
> >    tools/memory-model/Documentation/recipes.txt
> >    Documentation/memory-barriers.txt
> >
> > And I don't find the responses that I need. I'm not saying they aren't
> > there but I don't see them. So my questions:
> >
> > If in the above function makes sense to use locking, and it is called =
from
> > the brute_task_fatal_signal hook, then, all the functions that are cal=
led
> > from this hook need locking (more than one process can access stats at=
 the
> > same time).
> >
> > So, as you point, how it is possible and safe to read jiffies and faul=
ts
> > (and I think period even though you not mention it) using READ_ONCE() =
but
> > without holding brute_stats::lock? I'm very confused.
>
> There are, I think, 3 considerations:
>
> - is "stats", itself, a valid allocation in kernel memory? This is the
>   "lifetime" management of the structure: it will only stay allocated as
>   long as there is a task still alive that is attached to it. The use of
>   refcount_t on task creation/death should entirely solve this issue, so
>   that all the other places where you access "stats", the memory will be
>   valid. AFAICT, this one is fine: you're doing all the correct lifetime
>   management.
>
> - changing a task's stats pointer: this is related to lifetime
>   management, but it, I think, entirely solved by the existing
>   refcounting. (And isn't helped by holding stats->lock since this is
>   about stats itself being a valid pointer.) Again, I think this is all
>   correct already in your existing code (due to the implicit locking of
>   "current"). Perhaps I've missed something here, but I guess we'll see!

My only concern now is the following case:

One process crashes with a fatal signal. Then, its stats are updated. Then
we get the exec stats (the stats of the task that calls exec). At the same
time another CPU frees this same stats. Now, if the first process writes
to the exec stats we get a "use after free" bug.

If this scenario is possible, we would need to protect all the section
inside the task_fatal_signal hook that deals with the exec stats. I think
that here a global lock is necessary and also, protect the write of the
pointer to stats struct in the task_free hook.

Moreover, I can see another scenario:

The first CPU gets the exec stats when a task fails with a fatal signal.
The second CPU exec()ve after exec()ve over the same task from we get the
exec stats with the first CPU. This second CPU resets the stats at the sam=
e
time that the first CPU updates the same stats. I think we also need lock
here.

Am I right? Are these paths possible?

>
> - are the values in stats getting written by multiple writers, or read
>   during a write, etc?
>
> This last one is the core of what I think could be improved here:
>
> To keep the writes serialized, you (correctly) perform locking in the
> writers. This is fine.
>
> There is also locking in the readers, which I think is not needed.
> AFAICT, READ_ONCE() (with WRITE_ONCE() in the writers) is sufficient for
> the readers here.
>
> > IIUC (during the reading of the documentation) READ_ONCE and WRITE_ONC=
E only
> > guarantees that a variable loaded with WRITE_ONCE can be read safely w=
ith
> > READ_ONCE avoiding tearing, etc. So, I see these functions like a form=
 of
> > guarantee atomicity in variables.
>
> Right -- from what I can see about how you're reading the statistics, I
> don't see a way to have the values get confused (assuming locked writes
> and READ/WRITE_ONCE()).
>
> > Another question. Is it also safe to use WRITE_ONCE without holding th=
e lock?
> > Or this is only appliable to read operations?
>
> No -- you'll still want the writer locked since you update multiple fiel=
ds
> in stats during a write, so you could miss increments, or interleave
> count vs jiffies writes, etc. But the WRITE_ONCE() makes sure that the
> READ_ONCE() readers will see a stable value (as I understand it), and
> in the order they were written.
>
> > Any light on this will help me to do the best job in the next patches.=
 If
> > somebody can point me to the right direction it would be greatly appre=
ciated.
> >
> > Is there any documentation for newbies regarding this theme? I'm stuck=
.
> > I have also read the documentation about spinlocks, semaphores, mutex,=
 etc..
> > but nothing clears me the concept expose.
> >
> > Apologies if this question has been answered in the past. But the sear=
ch in
> > the mailing list has not been lucky.
>
> It's a complex subject! Here are some other docs that might help:
>
> tools/memory-model/Documentation/explanation.txt
> Documentation/core-api/refcount-vs-atomic.rst
>
> or they may melt your brain further! :) I know mine is always mushy
> after reading them.
>
> > Thanks for your time and patience.
>
> You're welcome; and thank you for your work on this! I've wanted a robus=
t
> brute force mitigation in the kernel for a long time. :)
>

Thank you very much for this great explanation and mentorship. Now this
subject is more clear to me. It's a pleasure to me to work on this.

Again, thanks for your help.
John Wood
