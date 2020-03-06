Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C179817C209
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Mar 2020 16:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCFPmx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 10:42:53 -0500
Received: from wind.enjellic.com ([76.10.64.91]:59400 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgCFPmw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 10:42:52 -0500
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 026FgN7D021662;
        Fri, 6 Mar 2020 09:42:23 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 026FgMhA021661;
        Fri, 6 Mar 2020 09:42:22 -0600
Date:   Fri, 6 Mar 2020 09:42:22 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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
Message-ID: <20200306154222.GA20820@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com> <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com> <CAOASepN1JrD6OEzZycbqOr6_ZVACK=EctEOoQ8oSAEeigMr1Eg@mail.gmail.com> <04362c0cf66bf66e8f7c25a531830b9f294d2d09.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04362c0cf66bf66e8f7c25a531830b9f294d2d09.camel@linux.intel.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 06 Mar 2020 09:42:23 -0600 (CST)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 05, 2020 at 01:33:28PM +0200, Jarkko Sakkinen wrote:

Good morning, I hope the end of the week is going well for everyone.

> On Wed, 2020-03-04 at 14:27 -0500, Nathaniel McCallum wrote:
> >         # Header
> >         .fill   1, 8, 0                 # XSTATE_BV
> >         .fill   1, 8, 1 << 63           # XCOMP_BV (compaction mode)
> >         .fill   6, 8, 0
> > 
> > Also, since people are likely to copy this code for their own
> > enclaves, it would be helpful to document which flags are set in FCW
> > and MXCSR.

> It was meant as a test program but I'd guess what you say is true
> because it also might be the only alternative user space to Intel's
> :-) And a great starting point if you want to do things from
> scratch.
>
> Because I meant it as a smoke test program for SGX, not everything
> is too well documented but given the multipurpose use for that code
> I'll make the improvements that you are suggesting.

At the risk of what will certainly be a fair amount of criticism, I
will take on the moniker of being the pernicious voice of reality, if
not intellectual honesty, in all of this.  No market or security
relevant enclaves are going to get built by developers starting from
scratch or copying this code, useful and informative as it might be,
into their enclaves.

That isn't to say that it isn't good to have some example code but
Nate's point in a previous e-mail is well taken, it shouldn't have
known security vulnerabilities in it.  Given the current realities of
speculative execution attacks, there are a ton of subtle issues
surrounding entry and exit into enclaves, which by definition is the
primary attack surface for a trusted execution environment.

For the sake of those reading along at home, relevant enclave
development needs, at an absolute minimum, the following:

1.) A lot of trusted runtime initialization and scaffolding code.
2.) An embedded C/C++ library.
3.) A compiler intrinsics implementation.

That gets you, maybe, something that you can start thinking about,
'hello world', with, but nothing useful with respect to what anyone
would want to do with an enclave.

On top of that you need a lot of platform software to get the enclave
relevantly signed, loaded, executed and supported.  Not the least of
which is support for remote attestation, which means rolling up one's
sleeves to do either a DCAP implementation or an EPID provisioning
implementation.  The latter of which, believe me, is not for the faint
of heart given that you have to develop it in an unknown oracle model.

My point in all of this is that the only relevant consumers of this
driver are groups that are resourced well enough to understand,
deliver and support all of this infrastructure.  I will leave it to
others, and history, to judge whether or not the driver has been
developed with this frame of reference.

> /Jarkko

Best wishes for a pleasant weekend.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           SGX secured infrastructure and autonomously
Fargo, ND  58102            self-defensive platforms.
PH: 701-281-1686            EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"The couple is registered at Herbergers, Target and Fleet Farm."
                                -- Wedding invitation
                                   West Central Minnesota
