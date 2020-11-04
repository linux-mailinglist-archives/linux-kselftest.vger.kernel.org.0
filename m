Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608D22A6C1F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 18:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgKDRqv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 12:46:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:16659 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbgKDRqv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 12:46:51 -0500
IronPort-SDR: uy+PlSWFo2zvFzWa5TjSeUTD8XVCezG1JQ40JUuexWym8X027IaCDenSNSYqBa6/apYGqr200u
 pV0+DP0YjeZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="168476165"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="168476165"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 09:46:46 -0800
IronPort-SDR: Q9Bmv6A8hLY7c8TvyszzEw9vj0W25YTLM3HEfYG4mwCufaGsYgJuK+k0r2131jolfBeCTxgYes
 GJ1Yb9QiFgjQ==
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="471304692"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 09:46:44 -0800
Date:   Wed, 4 Nov 2020 09:46:44 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V2 00/10] PKS: Add Protection Keys Supervisor (PKS)
 support
Message-ID: <20201104174643.GC1531489@iweiny-DESK2.sc.intel.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com>
 <871rhb8h73.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rhb8h73.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 03, 2020 at 12:36:16AM +0100, Thomas Gleixner wrote:
> On Mon, Nov 02 2020 at 12:53, ira weiny wrote:
> > Fenghua Yu (2):
> >   x86/pks: Enable Protection Keys Supervisor (PKS)
> >   x86/pks: Add PKS kernel API
> >
> > Ira Weiny (7):
> >   x86/pkeys: Create pkeys_common.h
> >   x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
> >   x86/pks: Preserve the PKRS MSR on context switch
> >   x86/entry: Pass irqentry_state_t by reference
> >   x86/entry: Preserve PKRS MSR across exceptions
> >   x86/fault: Report the PKRS state on fault
> >   x86/pks: Add PKS test code
> >
> > Thomas Gleixner (1):
> >   x86/entry: Move nmi entry/exit into common code
> 
> So the actual patch ordering is:
> 
>    x86/pkeys: Create pkeys_common.h
>    x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
>    x86/pks: Enable Protection Keys Supervisor (PKS)
>    x86/pks: Preserve the PKRS MSR on context switch
>    x86/pks: Add PKS kernel API
> 
>    x86/entry: Move nmi entry/exit into common code
>    x86/entry: Pass irqentry_state_t by reference
> 
>    x86/entry: Preserve PKRS MSR across exceptions
>    x86/fault: Report the PKRS state on fault
>    x86/pks: Add PKS test code
> 
> This is the wrong ordering, really.
> 
>      x86/entry: Move nmi entry/exit into common code
> 
> is a general cleanup and has absolutely nothing to do with PKRS.So this
> wants to go first.
> 

Sorry, yes this should be a pre-patch.

> Also:
> 
>     x86/entry: Move nmi entry/exit into common code
> [from other email]
>    >      x86/entry: Pass irqentry_state_t by reference
>    >      > 
>    >      >
> 
> is a prerequisite for the rest. So why is it in the middle of the
> series?

It is in the middle because passing by reference is not needed until additional
information is added to irqentry_state_t which is done immediately after this
patch by:

    x86/entry: Preserve PKRS MSR across exceptions

I debated squashing the 2 but it made review harder IMO.  But I thought keeping
them in order together made a lot of sense.

> 
> And then you enable all that muck _before_ it is usable:
> 

Strictly speaking you are correct, sorry.  I will reorder the series.

> 
> Bisectability is overrrated, right?

Agreed, bisectability is important.  I thought I had it covered but I was
wrong.

> 
> Once again: Read an understand Documentation/process/*
> 
> Aside of that using a spell checker is not optional.

Agreed.

In looking closer at the entry code I've found a couple of other instances I'll
add another precursor patch.

I've also found other errors with the series which I should have caught.  My
apologies I made some last minute changes which I should have checked more
thoroughly.

Thanks,
Ira
