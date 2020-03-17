Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8510187753
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Mar 2020 02:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbgCQBJ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Mar 2020 21:09:59 -0400
Received: from wind.enjellic.com ([76.10.64.91]:60356 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733017AbgCQBJ7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Mar 2020 21:09:59 -0400
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 02H17IhN002955;
        Mon, 16 Mar 2020 20:07:18 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 02H17Irm002954;
        Mon, 16 Mar 2020 20:07:18 -0500
Date:   Mon, 16 Mar 2020 20:07:18 -0500
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
Message-ID: <20200317010718.GA2546@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com> <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com> <20200306053210.GA16297@wind.enjellic.com> <op.0g923rgpwjvjmi@hhuan26-mobl1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.0g923rgpwjvjmi@hhuan26-mobl1.amr.corp.intel.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 16 Mar 2020 20:07:18 -0500 (CDT)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 10, 2020 at 02:29:41PM -0500, Haitao Huang wrote:

Good evening, I hope the week is going well for everyone.

> >Just as a clarification, are you testing the new driver against
> >signed production class enclaves in .so format that also include
> >metadata layout directives or is the driver just getting tested
> >against the two page toy enclave that copies a word of memory from
> >one memory location to another?

> We (Intel SGX SDK/PSW team) tested this driver for enclaves in .so
> format with metadata. Our 2.8 release supports v24 and 2.9 supports
> v25+. Both production signed and debug signed enclaves worked.
>
> *Note* we did make some code changes in our runtime for v24+, mainly
> dealing with src & EPC page alignment for EADD, open one fd per
> enclave, use -z noexecstack linker option, etc. You can see the
> changes on GitHub.

Lots of knobs getting turned at the same time but we sorted out all
the issues and our runtime is now passing its regression tests with
the new driver, with an exception that we note below.

I suspect that we might have the only complete and architecturally
independent runtime implementation so if the new driver is working
against yours and ours it would seem to be a reasonable test spectrum
for the driver.

> >We see the same behavior from both our unit test enclaves and the
> >Quoting Enclave from the Intel SGX runtime.

> We did not see any issue loading QE in our tests. Please directly
> email me on this test if you have specific questions.

As it turns out the major problem we were running into with respect to
the QE test was the fact that generic use of atexit() handlers was
disabled by changes that went into the 2.8 SDK.  Our runtime and SDK
assume that enclave atexit() handling works.

The enclave UNINIT ECALL is only allowed on runtimes that are
advertising EDMM support.  That seems excessively restrictive since
atexit() handling is generically useful for enclaves that are not
using EDMM.  Our runtime allows EDMM to be disabled and we have
enclaves that gate on that for security purposes.

On a quasi-related note, it appears that the 1.4 compatibility
metadata created by post 2.0 signing tools is leaking layout
descriptors that a version 1.4 runtime doesn't understand.

Do you want to exchange e-mail on this or should we direct
conversations about these issues with others on your SDK team.

Have a good remainder of the week.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D, Worker      SGX secured infrastructure and
Enjellic Systems Development, LLC     autonomously self-defensive
4206 N. 19th Ave.                     platforms.
Fargo, ND  58102
PH: 701-281-1686                      EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"All parts should go together without forcing.  You must remember that
 the parts you are reassembling were disassembled by you.  Therefore,
 if you can't get them together again, there must be a reason.  By all
 means, do not use a hammer."
                                -- IBM maintenance manual, 1925
