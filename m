Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7AD17C5E8
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Mar 2020 20:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCFTIA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 14:08:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:16862 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFTIA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 14:08:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 11:07:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="275647208"
Received: from wbakowsk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.27.142])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2020 11:07:54 -0800
Date:   Fri, 6 Mar 2020 21:07:53 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     Nathaniel McCallum <npmccallum@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, rientjes@google.com, cedric.xing@intel.com,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v28 14/22] selftests/x86: Add a selftest for SGX
Message-ID: <20200306190753.GH7472@linux.intel.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com>
 <CAOASepN1JrD6OEzZycbqOr6_ZVACK=EctEOoQ8oSAEeigMr1Eg@mail.gmail.com>
 <04362c0cf66bf66e8f7c25a531830b9f294d2d09.camel@linux.intel.com>
 <20200306154222.GA20820@wind.enjellic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306154222.GA20820@wind.enjellic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 06, 2020 at 09:42:22AM -0600, Dr. Greg wrote:
> On Thu, Mar 05, 2020 at 01:33:28PM +0200, Jarkko Sakkinen wrote:
> 
> Good morning, I hope the end of the week is going well for everyone.
> 
> > On Wed, 2020-03-04 at 14:27 -0500, Nathaniel McCallum wrote:
> > >         # Header
> > >         .fill   1, 8, 0                 # XSTATE_BV
> > >         .fill   1, 8, 1 << 63           # XCOMP_BV (compaction mode)
> > >         .fill   6, 8, 0
> > > 
> > > Also, since people are likely to copy this code for their own
> > > enclaves, it would be helpful to document which flags are set in FCW
> > > and MXCSR.
> 
> > It was meant as a test program but I'd guess what you say is true
> > because it also might be the only alternative user space to Intel's
> > :-) And a great starting point if you want to do things from
> > scratch.
> >
> > Because I meant it as a smoke test program for SGX, not everything
> > is too well documented but given the multipurpose use for that code
> > I'll make the improvements that you are suggesting.
> 
> At the risk of what will certainly be a fair amount of criticism, I
> will take on the moniker of being the pernicious voice of reality, if
> not intellectual honesty, in all of this.  No market or security
> relevant enclaves are going to get built by developers starting from
> scratch or copying this code, useful and informative as it might be,
> into their enclaves.
> 
> That isn't to say that it isn't good to have some example code but
> Nate's point in a previous e-mail is well taken, it shouldn't have
> known security vulnerabilities in it.  Given the current realities of
> speculative execution attacks, there are a ton of subtle issues
> surrounding entry and exit into enclaves, which by definition is the
> primary attack surface for a trusted execution environment.
> 
> For the sake of those reading along at home, relevant enclave
> development needs, at an absolute minimum, the following:
> 
> 1.) A lot of trusted runtime initialization and scaffolding code.
> 2.) An embedded C/C++ library.
> 3.) A compiler intrinsics implementation.
> 
> That gets you, maybe, something that you can start thinking about,
> 'hello world', with, but nothing useful with respect to what anyone
> would want to do with an enclave.

Actually many people have applaused to have a small scoped, even if not
perfect, test program to look at how SGX works. One that is only
dependent on glibc. None of the selftests are meant to be production
peaces of code. You are getting wrong the role of the selftest in the
first place.

/Jarkko
