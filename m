Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AEA17FACF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Mar 2020 14:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgCJNI1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Mar 2020 09:08:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:19572 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731107AbgCJNIZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Mar 2020 09:08:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 06:08:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="388926224"
Received: from akharche-mobl2.ccr.corp.intel.com (HELO localhost) ([10.251.86.23])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2020 06:08:19 -0700
Date:   Tue, 10 Mar 2020 15:08:18 +0200
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
Message-ID: <20200310130818.GA32334@linux.intel.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com>
 <CAOASepN1JrD6OEzZycbqOr6_ZVACK=EctEOoQ8oSAEeigMr1Eg@mail.gmail.com>
 <04362c0cf66bf66e8f7c25a531830b9f294d2d09.camel@linux.intel.com>
 <20200306154222.GA20820@wind.enjellic.com>
 <20200306190753.GH7472@linux.intel.com>
 <20200307174223.GA30928@wind.enjellic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307174223.GA30928@wind.enjellic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 07, 2020 at 11:42:23AM -0600, Dr. Greg wrote:
> On Fri, Mar 06, 2020 at 09:07:53PM +0200, Jarkko Sakkinen wrote:
> 
> Good morning, I hope the weekend is going well for everyone.
> 
> > Actually many people have applaused to have a small scoped, even if
> > not perfect, test program to look at how SGX works. One that is only
> > dependent on glibc. None of the selftests are meant to be production
> > peaces of code. You are getting wrong the role of the selftest in
> > the first place.
> 
> We certainly want to be counted in the camp of those who are
> applausing you for making the selftests available, particularly the
> new VDSO setup and entry code.
> 
> We arguably have similar motivations.  We architected and authored an
> entire SGX runtime that has as its only dependencies the MUSL C
> library, libelf and OpenSSL, primarily because we needed an easily
> auditable and low footprint SGX implementation.

Good to hear!

> To the point at hand though, I'm certainly not a very smart guy so I
> doubt that I am able to understand the role of the selftests.  We do
> seem to agree though that they only provide a rudimentary exercise of
> the driver.

The role of kselftests is not to be production code. They are somewhat
adhoc pieces of code that just check that "things turn on" e.g. in a
new kernel release or a new hardware platform.

> We also seem to agree that the primary role of the driver is to
> service the needs of those of us that are building production level
> SGX runtime stacks.  In service of that premise, it would be helpful
> to know if you are internally testing the driver/VDSO against enclaves
> of production quality, with metadata, or just the two page selftest
> enclave.

I do agree that a more complete test suite would be an essential thing
to have. In that I'd just use the SDK and implement it outside the
kernel tree.

Unfortunately I do not have time to implement such.

/Jarkko
