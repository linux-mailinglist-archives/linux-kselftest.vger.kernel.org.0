Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD72DE7C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 18:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgLRRAJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 12:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgLRRAI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 12:00:08 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A57C06138C
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 08:59:28 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y24so2373170edt.10
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 08:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2IQ6TE/rhYWCk2P0BT6shtYVSJjLwqOvjZqkUrg3hg=;
        b=x0bdaXnT2B4JXcqIt4PJy6h+bXPGtd8toCsOgNdWIJa1nPBCH5WTS5rerVO30HHHv+
         0mEXFdRjcKh4IwU/rzCLurT6prPOAZRgSMIqzb+6RHbn47F53bE4mnZw4nfnwKqzLt9O
         y2s6lpJCJeivzJE/dzH1mAeUqmd6PsLFZpksfWbC5s5r/QUjZboSHmr84aZIE5P0LJzo
         X7gN+dmAo5f5vnJ+NP5gpsL6toXTlaOai1neElJ2mwb0KuuQoEZyD/SwUgY9jIhveiWf
         ANrkYt1dOrFDv6aPQb04TGSt5QVD0JKHk4L6JLZ7vVZPZsgr5RluZpOmVL9LdFpgPmDm
         3uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2IQ6TE/rhYWCk2P0BT6shtYVSJjLwqOvjZqkUrg3hg=;
        b=dNqTkL71tmXTQoB/I1fOEFvZE9iUfOqvyuWYW/mL+Ym8dB+oLy74cYJpRrzEhovx8O
         Yvqc31ZvgjaH6rvVsedorQp6tsPjh0Nkm0vjnMLnJCJzz7uReKDTDR4LrJzzYrzNoyQB
         uO6osASOAn1NntV5Mgb+uG0ZwIzsRlVyVgShDYYH3C3JGoNwhoIb3EshEoGgEFgfDEvL
         R13/DpPxtbG/yDFnb1ztYAlySFz8zk1o/SrHU0XZv6Bahw6w/Wqvjf9MdLJxEiYJlmb4
         +mQv5WmK2wW3tQGAgPYxRQoGU7fbigSy44m99qz8QETyZvsx0AbTn7Shb9b4VOrcyaWN
         bs+g==
X-Gm-Message-State: AOAM5314La7lhbE7v0+Qh0z35KbIay01UQThrg7UbY14ZhCnLIqgipM6
        4x43h6cy0pfuV3/nkw1ne0twuE4r/jJIMQ+6ZSwG6w==
X-Google-Smtp-Source: ABdhPJzi8p93x3vt5BPfkyWakXSFrE3q9YiaTjtJjD9XWTCVmH/VzLNltbu680O+caKH/UqiktjQd9bnfrMv9AkR1X4=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr5242794edr.97.1608310766755;
 Fri, 18 Dec 2020 08:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-11-ira.weiny@intel.com>
 <570ead2a-ff41-e730-d61d-0f59c67b1903@intel.com> <20201218040509.GD1563847@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20201218040509.GD1563847@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Dec 2020 08:59:16 -0800
Message-ID: <CAPcyv4hixbKqkkh4DsRgAF7fARH2n2zzHnqQa1cNrXDrH9PekA@mail.gmail.com>
Subject: Re: [PATCH V3 10/10] x86/pks: Add PKS test code
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 17, 2020 at 8:05 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Thu, Dec 17, 2020 at 12:55:39PM -0800, Dave Hansen wrote:
> > On 11/6/20 3:29 PM, ira.weiny@intel.com wrote:
> > > +           /* Arm for context switch test */
> > > +           write(fd, "1", 1);
> > > +
> > > +           /* Context switch out... */
> > > +           sleep(4);
> > > +
> > > +           /* Check msr restored */
> > > +           write(fd, "2", 1);
> >
> > These are always tricky.  What you ideally want here is:
> >
> > 1. Switch away from this task to a non-PKS task, or
> > 2. Switch from this task to a PKS-using task, but one which has a
> >    different PKS value
>
> Or both...
>
> >
> > then, switch back to this task and make sure PKS maintained its value.
> >
> > *But*, there's no absolute guarantee that another task will run.  It
> > would not be totally unreasonable to have the kernel just sit in a loop
> > without context switching here if no other tasks can run.
> >
> > The only way you *know* there is a context switch is by having two tasks
> > bound to the same logical CPU and make sure they run one after another.
>
> Ah...  We do that.
>
> ...
> +       CPU_ZERO(&cpuset);
> +       CPU_SET(0, &cpuset);
> +       /* Two processes run on CPU 0 so that they go through context switch.  */
> +       sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpuset);
> ...
>
> I think this should be ensuring that both the parent and the child are
> running on CPU 0.  At least according to the man page they should be.
>
> <man>
>         A child created via fork(2) inherits its parent's CPU affinity mask.
> </man>
>
> Perhaps a better method would be to synchronize the 2 threads more to ensure
> that we are really running at the 'same time' and forcing the context switch.
>
> >  This just gets itself into a state where it *CAN* context switch and
> > prays that one will happen.
>
> Not sure what you mean by 'This'?  Do you mean that running on the same CPU
> will sometimes not force a context switch?  Or do you mean that the sleeps
> could be badly timed and the 2 threads could run 1 after the other on the same
> CPU?  The latter is AFAICT the most likely case.
>

One way to guarantee that both threads run is to just pass a message
between them over a pipe and wait for the submitter to receive an ack
from the other end.
