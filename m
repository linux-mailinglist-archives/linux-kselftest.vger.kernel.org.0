Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A945D2D81C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 23:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406760AbgLKWPq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Dec 2020 17:15:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406751AbgLKWPZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Dec 2020 17:15:25 -0500
X-Gm-Message-State: AOAM532kwCN0bsxtFPe9yA7i+abDVnyzwlN7XcCSmx8mb0DJlPL5L0WW
        Ao6ygEfUxLKwAcwRxwgXXi5bBJtxaptxF67XJA4iNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607724882;
        bh=70LTUMehFh83IHad/vkXff9wd8DJwarU76xfxtWTpbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jPAdTjcAVpZyDFTaPihJOsnveXonsw5iOC6B7KbDZDjzqZNwbm7CsmLDH3yR0AMID
         SNfPGfnjQ3iWvMryER3GLaa8smv8iVvQy2GhAyVriM92szYovmcCUtjEsGsqB+wLEu
         7R/8evzBvMtqXX/2o39B34SfiJoMfQ9d2yPn0icWzRf3+6zFxZ2pNb/c6qokJB+How
         9HXBSycFcdAQzwnvNh3IDX4+qV7Qgi8aIYQK+QaOB/Jj0HXGnIYfXkI3qp+mFM3IOV
         v2A5PmGBQtslguW0eYDMFhwLH/Gqey8aJRD7LMfwaHCIDkWMKrpYuCoQlC3FRomXfL
         wiJq08Nve+OvA==
X-Google-Smtp-Source: ABdhPJwyiUgo4QSzbgQvODMi2EdGDgMycwa95HkgOC2v3m4y50nPJcH7R/4+bPCwIYyM+uNouuOpofy5wtqF2/93N+Q=
X-Received: by 2002:a5d:4905:: with SMTP id x5mr825454wrq.75.1607724880704;
 Fri, 11 Dec 2020 14:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20201106232908.364581-6-ira.weiny@intel.com> <20201124060956.1405768-1-ira.weiny@intel.com>
In-Reply-To: <20201124060956.1405768-1-ira.weiny@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 11 Dec 2020 14:14:28 -0800
X-Gmail-Original-Message-ID: <CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com>
Message-ID: <CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com>
Subject: Re: [PATCH V3.1] entry: Pass irqentry_state_t by reference
To:     Weiny Ira <ira.weiny@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 23, 2020 at 10:10 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Currently struct irqentry_state_t only contains a single bool value
> which makes passing it by value is reasonable.  However, future patches
> add information to this struct.  This includes the PKRS thread state,
> included in this series, as well as information to store kmap reference
> tracking and PKS global state outside this series.  In total, we
> anticipate 2 new 32 bit fields and an integer field to be added to the
> struct beyond the existing bool value.
>
> Adding information to irqentry_state_t makes passing by value less
> efficient.  Therefore, change the entry/exit calls to pass irq_state by
> reference in preparation for the changes which follow.
>
> While at it, make the code easier to follow by changing all the usage
> sites to consistently use the variable name 'irq_state'.

After contemplating this for a bit, I think this isn't really the
right approach.  It *works*, but we've mostly just created a bit of an
unfortunate situation.  Our stack, on a (possibly nested) entry looks
like:

previous frame (or empty if we came from usermode)
---
SS
RSP
FLAGS
CS
RIP
rest of pt_regs

C frame

irqentry_state_t (maybe -- the compiler is within its rights to play
almost arbitrary games here)

more C stuff


So what we've accomplished is having two distinct arch register
regions, one called pt_regs and the other stuck in irqentry_state_t.
This is annoying because it means that, if we want to access this
thing without passing a pointer around or access it at all from outer
frames, we need to do something terrible with the unwinder, and we
don't want to go there.

So I propose a somewhat different solution: lay out the stack like this.

SS
RSP
FLAGS
CS
RIP
rest of pt_regs
PKS
^^^^^^^^ extended_pt_regs points here

C frame
more C stuff
...

IOW we have:

struct extended_pt_regs {
  bool rcu_whatever;
  other generic fields here;
  struct arch_extended_pt_regs arch_regs;
  struct pt_regs regs;
};

and arch_extended_pt_regs has unsigned long pks;

and instead of passing a pointer to irqentry_state_t to the generic
entry/exit code, we just pass a pt_regs pointer.  And we have a little
accessor like:

struct extended_pt_regs *extended_regs(struct pt_regs *) { return
container_of(...); }

And we tell eBPF that extended_pt_regs is NOT ABI, and we will change
it whenever we feel like just to keep you on your toes, thank you very
much.

Does this seem reasonable?  You get to drop patch 7 and instead modify
the show_regs() stuff to just display one extra register.
