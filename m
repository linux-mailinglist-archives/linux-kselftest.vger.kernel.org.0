Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D131418144E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 10:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgCKJNl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 05:13:41 -0400
Received: from wind.enjellic.com ([76.10.64.91]:59852 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgCKJNk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 05:13:40 -0400
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 02B9DEfJ008298;
        Wed, 11 Mar 2020 04:13:14 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 02B9DDv2008297;
        Wed, 11 Mar 2020 04:13:13 -0500
Date:   Wed, 11 Mar 2020 04:13:13 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v28 14/22] selftests/x86: Add a selftest for SGX
Message-ID: <20200311091313.GA8094@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com> <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com> <20200306053210.GA16297@wind.enjellic.com> <op.0g923rgpwjvjmi@hhuan26-mobl1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.0g923rgpwjvjmi@hhuan26-mobl1.amr.corp.intel.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 11 Mar 2020 04:13:14 -0500 (CDT)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 10, 2020 at 02:29:41PM -0500, Haitao Huang wrote:

Good morning, I hope this note finds the week going well for everyone.

> On Thu, 05 Mar 2020 23:32:10 -0600, Dr. Greg <greg@enjellic.com> wrote:
> 
> >On Wed, Mar 04, 2020 at 01:36:01AM +0200, Jarkko Sakkinen wrote:
> >
> >Good evening, I hope the end of the week is going well for everyone.
> >
> >>Add a selftest for SGX. It is a trivial test where a simple enclave
> >>copies one 64-bit word of memory between two memory locations given
> >>to the enclave as arguments. Use ENCLS[EENTER] to invoke the
> >>enclave.
> >
> >Just as a clarification, are you testing the new driver against signed
> >production class enclaves in .so format that also include metadata
> >layout directives or is the driver just getting tested against the two
> >page toy enclave that copies a word of memory from one memory location
> >to another?

> We (Intel SGX SDK/PSW team) tested this driver for enclaves in .so
> format with metadata. Our 2.8 release supports v24 and 2.9 supports
> v25+. Both production signed and debug signed enclaves worked.

Very good, this was the feedback we were hoping to get.

> *Note* we did make some code changes in our runtime for v24+, mainly
> dealing with src & EPC page alignment for EADD, open one fd per
> enclave, use -z noexecstack linker option, etc. You can see the
> changes on GitHub.

Yes, we made all of those changes as well, in a similar fashion.

This was the third time that we have changed the enclave creation
mmap() and alignment constraints, only to take us back to what we had
started with... :-)(

> >Our PSW/runtime is currently failing to initialize production class
> >enclaves secondary to a return value of -4 from the ENCLU[EINIT]
> >instruction, which means the measurement of the loaded enclave has
> >failed to match the value in the signature structure.
> >
> >The same enclave loads fine with the out of kernel driver.  Our
> >diagnostics tell us we are feeding identical page streams and
> >permissions to the page add ioctl's of both drivers.  The identity
> >modulus signature of the signing key for the enclave is being written
> >to the launch control registers.
> >
> >We see the same behavior from both our unit test enclaves and the
> >Quoting Enclave from the Intel SGX runtime.

> We did not see any issue loading QE in our tests. Please directly
> email me on this test if you have specific questions.

It isn't anything specific to the QE, we just used that as an example,
since it has no special attribute requirements and would seem to be a
good reference test for everyone working on runtimes.

We are missing some nuance with the latest version of the driver, our
runtime was working fine with the new driver a year ago.

It almost has to be a problem with metadata, we are suspicious of
guard page processing.

We are following the same strategy that we had used previously and
leaving a 'hole' in the enclave for each guard page at its RVA offset.
The comment in the add page ioctl indicating that the page range has
to be contiguous caught our eye and has us questioning if this
continues to be the correct approach.

Do you remember, off the top of your head, having to address guard
pages differently?

Have a good remainder of the week.

Dr. Greg

> Using Opera's mail client: http://www.opera.com/mail/

As always,
Dr. Greg Wettstein, Ph.D, Worker
IDfusion, LLC               SGX secured infrastructure and
4206 N. 19th Ave.           autonomously self-defensive platforms.
Fargo, ND  58102
PH: 701-281-1686            EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"Work makes life enjoyable."
                                -- North Dakota Germans
