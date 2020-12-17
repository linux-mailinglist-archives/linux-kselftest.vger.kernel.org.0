Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C852DD1E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 14:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgLQNHo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 08:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgLQNHn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 08:07:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE25C061794;
        Thu, 17 Dec 2020 05:07:03 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608210421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CyOHKGrGF5FgJ/jrTCkQanXT7eBDkCqK5reXHcNL6hU=;
        b=eovS1hyj5PJ9FjFq7ljImsiygsavh4+hyAufANIEN4qOrIiRDJvnEz+nMcNLlzLjQ0nmpQ
        qpnwUz3EbXYBc8fFktrxzlnN4DQmYjZ5fJG/MnTix8uxeXRp5AG95AtjsfGKOw0krQrQxv
        1vu89vPNDAI5DTALWz8VCvROwjE0G5obplIWO86tQCTJsL8Ksrn/sX1nm9dy12fVzaf4Jy
        eLWmf4CzfHO5nriFc0GYwEHcejk6r4D1+RzHUBqtvKcEI2Cbx+JIjoJYs4kN/Xi6fu2LQC
        vavhLTIKjSMksx9LjtZAGZdRTRAJXK54Rhp3ahyHcTjHuE4EKFiMiOaYQs+8/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608210421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CyOHKGrGF5FgJ/jrTCkQanXT7eBDkCqK5reXHcNL6hU=;
        b=trlnJKPooUM3Q07R6gTR3/B9v5VRgpJBlPadulHLT7hRSrDAzhWFliWBHTApTwcTBZrwKG
        VIZ25dC5Vt0t6hDA==
To:     Andy Lutomirski <luto@kernel.org>, Weiny Ira <ira.weiny@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3.1] entry: Pass irqentry_state_t by reference
In-Reply-To: <CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com>
References: <20201106232908.364581-6-ira.weiny@intel.com> <20201124060956.1405768-1-ira.weiny@intel.com> <CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com>
Date:   Thu, 17 Dec 2020 14:07:01 +0100
Message-ID: <878s9wshsa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 11 2020 at 14:14, Andy Lutomirski wrote:
> On Mon, Nov 23, 2020 at 10:10 PM <ira.weiny@intel.com> wrote:
> After contemplating this for a bit, I think this isn't really the
> right approach.  It *works*, but we've mostly just created a bit of an
> unfortunate situation.  Our stack, on a (possibly nested) entry looks
> like:
>
> previous frame (or empty if we came from usermode)
> ---
> SS
> RSP
> FLAGS
> CS
> RIP
> rest of pt_regs
>
> C frame
>
> irqentry_state_t (maybe -- the compiler is within its rights to play
> almost arbitrary games here)
>
> more C stuff
>
> So what we've accomplished is having two distinct arch register
> regions, one called pt_regs and the other stuck in irqentry_state_t.
> This is annoying because it means that, if we want to access this
> thing without passing a pointer around or access it at all from outer
> frames, we need to do something terrible with the unwinder, and we
> don't want to go there.
>
> So I propose a somewhat different solution: lay out the stack like this.
>
> SS
> RSP
> FLAGS
> CS
> RIP
> rest of pt_regs
> PKS
> ^^^^^^^^ extended_pt_regs points here
>
> C frame
> more C stuff
> ...
>
> IOW we have:
>
> struct extended_pt_regs {
>   bool rcu_whatever;
>   other generic fields here;
>   struct arch_extended_pt_regs arch_regs;
>   struct pt_regs regs;
> };
>
> and arch_extended_pt_regs has unsigned long pks;
>
> and instead of passing a pointer to irqentry_state_t to the generic
> entry/exit code, we just pass a pt_regs pointer.

While I agree vs. PKS which is architecture specific state and needed in
other places e.g. #PF, I'm not convinced that sticking the existing
state into the same area buys us anything more than an indirect access.

Peter?

Thanks,

        tglx
