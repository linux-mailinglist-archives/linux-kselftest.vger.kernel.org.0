Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48DC217CF81
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 18:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgCGRmz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Mar 2020 12:42:55 -0500
Received: from wind.enjellic.com ([76.10.64.91]:59474 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgCGRmz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Mar 2020 12:42:55 -0500
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 027HgO0B031288;
        Sat, 7 Mar 2020 11:42:24 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 027HgNKI031287;
        Sat, 7 Mar 2020 11:42:23 -0600
Date:   Sat, 7 Mar 2020 11:42:23 -0600
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
Message-ID: <20200307174223.GA30928@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com> <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com> <CAOASepN1JrD6OEzZycbqOr6_ZVACK=EctEOoQ8oSAEeigMr1Eg@mail.gmail.com> <04362c0cf66bf66e8f7c25a531830b9f294d2d09.camel@linux.intel.com> <20200306154222.GA20820@wind.enjellic.com> <20200306190753.GH7472@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306190753.GH7472@linux.intel.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sat, 07 Mar 2020 11:42:24 -0600 (CST)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 06, 2020 at 09:07:53PM +0200, Jarkko Sakkinen wrote:

Good morning, I hope the weekend is going well for everyone.

> Actually many people have applaused to have a small scoped, even if
> not perfect, test program to look at how SGX works. One that is only
> dependent on glibc. None of the selftests are meant to be production
> peaces of code. You are getting wrong the role of the selftest in
> the first place.

We certainly want to be counted in the camp of those who are
applausing you for making the selftests available, particularly the
new VDSO setup and entry code.

We arguably have similar motivations.  We architected and authored an
entire SGX runtime that has as its only dependencies the MUSL C
library, libelf and OpenSSL, primarily because we needed an easily
auditable and low footprint SGX implementation.

To the point at hand though, I'm certainly not a very smart guy so I
doubt that I am able to understand the role of the selftests.  We do
seem to agree though that they only provide a rudimentary exercise of
the driver.

We also seem to agree that the primary role of the driver is to
service the needs of those of us that are building production level
SGX runtime stacks.  In service of that premise, it would be helpful
to know if you are internally testing the driver/VDSO against enclaves
of production quality, with metadata, or just the two page selftest
enclave.

Since Intel signs and releases binary enclaves, (QE, LE, PCE), it
would seem that a load and initialization of these enclaves would
provide a good reference point for all of us to agree on with respect
to basic driver testing and validation.

> /Jarkko

Have a good remainder of the weekend.

Dr. Greg

As always,
Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           SGX secured infrastructure and
Fargo, ND  58102            autonomously self-defensive platforms.
PH: 701-281-1686            EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"... remember that innovation is saying 'no' to 1000 things."
                                -- Moxie Marlinspike
