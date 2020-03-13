Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 756DA184F40
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 20:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgCMTYY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 15:24:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:30843 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgCMTYY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 15:24:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 12:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="278338828"
Received: from delmakie-mobl1.ger.corp.intel.com (HELO localhost) ([10.255.192.235])
  by fmsmga002.fm.intel.com with ESMTP; 13 Mar 2020 12:24:11 -0700
Date:   Fri, 13 Mar 2020 21:24:09 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Nathaniel McCallum <npmccallum@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, rientjes@google.com, cedric.xing@intel.com,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v28 14/22] selftests/x86: Add a selftest for SGX
Message-ID: <20200313192409.GA180706@linux.intel.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com>
 <CAOASepN1JrD6OEzZycbqOr6_ZVACK=EctEOoQ8oSAEeigMr1Eg@mail.gmail.com>
 <04362c0cf66bf66e8f7c25a531830b9f294d2d09.camel@linux.intel.com>
 <20200311132832.GA75185@linux.intel.com>
 <20200311164047.GG21852@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311164047.GG21852@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 11, 2020 at 09:40:47AM -0700, Sean Christopherson wrote:
> On Wed, Mar 11, 2020 at 03:28:32PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Mar 05, 2020 at 01:33:28PM +0200, Jarkko Sakkinen wrote:
> > > On Wed, 2020-03-04 at 14:27 -0500, Nathaniel McCallum wrote:
> > > > > > +xsave_area:
> > > > > +       .fill   1, 4, 0x037F            # FCW
> > > > > +       .fill   5, 4, 0
> > > > > +       .fill   1, 4, 0x1F80            # MXCSR
> > > > > +       .fill   1, 4, 0xFFFF            # MXCSR_MASK
> > > > > +       .fill   123, 4, 0
> > > > > +       .fill   1, 4, 0x80000000        # XCOMP_BV[63] = 1, compaction mode
> > > > > +       .fill   12, 4, 0
> > > > 
> > > > I find this much more readable:
> > > 
> > > And I always aim to get things more readable. Thank you.
> > > 
> > > > xsave_area:
> > > >         # Legacy
> > > >         .fill   1, 4, 0x037F            # FCW
> > > >         .fill   5, 4, 0
> > > >         .fill   1, 4, 0x1F80            # MXCSR
> > > >         .fill   1, 4, 0xFFFF            # MXCSR_MASK
> > > >         .fill   60, 8, 0
> > > > 
> > > >         # Header
> > > >         .fill   1, 8, 0                 # XSTATE_BV
> > > >         .fill   1, 8, 1 << 63           # XCOMP_BV (compaction mode)
> > > >         .fill   6, 8, 0
> > > > 
> > > > Also, since people are likely to copy this code for their own
> > > > enclaves, it would be helpful to document which flags are set in FCW
> > > > and MXCSR.
> > > 
> > > It was meant as a test program but I'd guess what you say is true
> > > because it also might be the only alternative user space to Intel's
> > > :-) And a great starting point if you want to do things from scratch.
> > > 
> > > Because I meant it as a smoke test program for SGX, not everything is
> > > too well documented but given the multipurpose use for that code I'll
> > > make the improvements that you are suggesting.
> > 
> > For FPU Control World (FCW), I think 0x037F is not the right value even
> > if section 18.5 in the x86 SDM says that it is the initial value for it.
> > 
> > I took that value from that section.
> > 
> > The reason I think that there is an error in the SDM is that if you look
> > at the section 8.1.5, you'll see that bit 6 is a reserved bit. Thus,
> > does not make to set it on.
> > 
> > I think the legit value ought to be 0x33F i.e. unset bit 6.
> 
> Bit 6 is reserved, but it's forced to '1' by the CPU.
> 
> Regardless, IMO it'd be better to drop this code entirely, it's all kinds
> of wonky.  The label says "xsave_area" and implies XSAVE state is being
> loaded, but the code uses FXRSTOR, which will only load x86/MMX/XMM state,
> i.e. the first 512 bytes of the so called xsave_area.
> 
> The test enclave doesn't touch state managed by XSAVE, let alone put
> secrets into said state.  I see no reason to bother purging anything.

Makes sense.

/Jarkko
