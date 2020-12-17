Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D422DCA0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 01:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgLQAjS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Dec 2020 19:39:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:41740 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgLQAjS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Dec 2020 19:39:18 -0500
IronPort-SDR: XGMrxkwFhYQpZI6EHZkhVsJOQMmV0Sw2gq+cPR67QzZ8iYbJ3cdR5tRVSZ3N6yepNaMrVuAKMv
 KYkv8gBXHyFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="175266136"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="175266136"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 16:38:36 -0800
IronPort-SDR: NimDuO3JSSCaVpcE48OB6QWQniCI0fiXPNzekJI5l7NmE3AKdZihNJaKV633ov9z2pi3EL+dvK
 tZn+LkRliH4A==
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="369434314"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 16:38:36 -0800
Date:   Wed, 16 Dec 2020 16:38:36 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH V3.1] entry: Pass irqentry_state_t by reference
Message-ID: <20201217003835.GZ1563847@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-6-ira.weiny@intel.com>
 <20201124060956.1405768-1-ira.weiny@intel.com>
 <CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com>
 <20201216013202.GY1563847@iweiny-DESK2.sc.intel.com>
 <CALCETrWoh5BYnU16adT7i6tsQ77PGaLN_qyZnCy-WfO3UJoykw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWoh5BYnU16adT7i6tsQ77PGaLN_qyZnCy-WfO3UJoykw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 15, 2020 at 06:09:02PM -0800, Andy Lutomirski wrote:
> On Tue, Dec 15, 2020 at 5:32 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Fri, Dec 11, 2020 at 02:14:28PM -0800, Andy Lutomirski wrote:
> > > On Mon, Nov 23, 2020 at 10:10 PM <ira.weiny@intel.com> wrote:
> 
> > > IOW we have:
> > >
> > > struct extended_pt_regs {
> > >   bool rcu_whatever;
> > >   other generic fields here;
> > >   struct arch_extended_pt_regs arch_regs;
> > >   struct pt_regs regs;
> > > };
> > >
> > > and arch_extended_pt_regs has unsigned long pks;
> > >
> > > and instead of passing a pointer to irqentry_state_t to the generic
> > > entry/exit code, we just pass a pt_regs pointer.  And we have a little
> > > accessor like:
> > >
> > > struct extended_pt_regs *extended_regs(struct pt_regs *) { return
> > > container_of(...); }
> > >
> > > And we tell eBPF that extended_pt_regs is NOT ABI, and we will change
> > > it whenever we feel like just to keep you on your toes, thank you very
> > > much.
> > >
> > > Does this seem reasonable?
> >
> > Conceptually yes.  But I'm failing to see how this implementation can be made
> > generic for the generic fields.  The pks fields, assuming they stay x86
> > specific, would be reasonable to add in PUSH_AND_CLEAR_REGS.  But the
> > rcu/lockdep field is generic.  Wouldn't we have to modify every architecture to
> > add space for the rcu/lockdep bool?
> >
> > If not, where is a generic place that could be done?  Basically I'm missing how
> > the effective stack structure can look like this:
> >
> > > struct extended_pt_regs {
> > >   bool rcu_whatever;
> > >   other generic fields here;
> > >   struct arch_extended_pt_regs arch_regs;
> > >   struct pt_regs regs;
> > > };
> >
> > It seems more reasonable to make it look like:
> >
> > #ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > struct extended_pt_regs {
> >         unsigned long pkrs;
> >         struct pt_regs regs;
> > };
> > #endif
> >
> > And leave the rcu/lockdep bool passed by value as before (still in C).
> 
> We could certainly do this,

I'm going to start with this basic support.  Because I have 0 experience in
most of these architectures.

> but we could also allocate some generic
> space.  PUSH_AND_CLEAR_REGS would get an extra instruction like:
> 
> subq %rsp, $GENERIC_PTREGS_SIZE
> 
> or however this should be written.  That field would be defined in
> asm-offsets.c.  And yes, all the generic-entry architectures would
> need to get onboard.

What do you mean by 'generic-entry' architectures?  I thought they all used the
generic entry code?

Regardless I would need to start another thread on this topic with any of those
architecture maintainers to see what the work load would be for this.  I don't
think I can do it on my own.

FWIW I think it is a bit unfair to hold up the PKS support in x86 for making
these generic fields part of the stack frame.  So perhaps that could be made a
follow on to the PKS series?

> 
> If we wanted to be fancy, we could split the generic area into
> initialize-to-zero and uninitialized for debugging purposes, but that
> might be more complication than is worthwhile.

Ok, agreed, but this is step 3 or 4 at the earliest.

Ira
