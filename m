Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1883BF107
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jul 2021 22:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhGGUxD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jul 2021 16:53:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhGGUxD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jul 2021 16:53:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D259B61CB0;
        Wed,  7 Jul 2021 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625691022;
        bh=9zDDWkBWSm0T5z6aXmZqdehpL2Wuu1uLQ4ONnfG8f/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3mCVC2zi7QCTtx99z0UQWcvt4aCEkN1puxnjBGJdQs0UMM0755abE3ReSXyDIQcl
         Yg2z0C8BrDrelfrId+E2cCfC13p5KUtC8tgbVpEDUYxbpQDki5kqS7ICgcajQumIhY
         vjRGWXC1KvskFm2sfwduOuoDx0gQVT4vicEhCVTbGXB6CuNH+WwVsL9VApc7s+qZ4E
         b+1gjmtlVFtxizvI5Z8vwq3NjsfAPTHXGnSpMRjeZx6G33qsebGNy9hf7iMlUYG0yb
         LxA4WbeZX+eE+4MAowwBvyTz9k+CbmYLqcfd1r5dd+KPB6Sob3HeJWVDoRvmLsFysl
         rlfdUeYIArguQ==
Date:   Wed, 7 Jul 2021 23:50:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests/sgx: Trigger the reclaimer and #PF handler
Message-ID: <20210707205019.6jy64s4uqcw65q4h@kernel.org>
References: <20210705143652.116125-1-jarkko@kernel.org>
 <20210705143652.116125-5-jarkko@kernel.org>
 <715ed555-5044-6fee-1d09-1c4cfa827af3@intel.com>
 <20210706235016.uucukyrr3ckk57pi@kernel.org>
 <16505466-e001-c4b0-ec41-5384ddcf194b@intel.com>
 <20210707091736.6wzemgmtzuegk3uf@kernel.org>
 <10664754-7e53-d9d1-f00c-f9dbd4a2d877@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10664754-7e53-d9d1-f00c-f9dbd4a2d877@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 07, 2021 at 08:02:42AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 7/7/2021 2:17 AM, Jarkko Sakkinen wrote:
> > On Tue, Jul 06, 2021 at 05:10:38PM -0700, Reinette Chatre wrote:
> > > Hi Jarkko,
> > > 
> > > On 7/6/2021 4:50 PM, Jarkko Sakkinen wrote:
> > > > On Tue, Jul 06, 2021 at 11:34:54AM -0700, Reinette Chatre wrote:
> > > > > Hi Jarkko,
> > > > > 
> > > > > On 7/5/2021 7:36 AM, Jarkko Sakkinen wrote:
> > > > > > Create a heap for the test enclave, which has the same size as all
> > > > > > available Enclave Page Cache (EPC) pages in the system. This will guarantee
> > > > > > that all test_encl.elf pages *and* SGX Enclave Control Structure (SECS)
> > > > > > have been swapped out by the page reclaimer during the load time. Actually,
> > > > > > this adds a bit more stress than that since part of the EPC gets reserved
> > > > > > for the Version Array (VA) pages.
> > > > > > 
> > > > > > For each test, the page fault handler gets triggered in two occasions:
> > > > > > 
> > > > > > - When SGX_IOC_ENCLAVE_INIT is performed, SECS gets swapped in by the
> > > > > >      page fault handler.
> > > > > > - During the execution, each page that is referenced gets swapped in
> > > > > >      by the page fault handler.
> > > > > > 
> > > > > 
> > > > > If I understand this correctly, all EPC pages are now being consumed during
> > > > > fixture setup and thus every SGX test, no matter how big or small, now
> > > > > becomes a stress test of the reclaimer instead of there being a unique
> > > > > reclaimer test. Since an enclave is set up and torn down for every test this
> > > > > seems like a significant addition. It also seems like this would impact
> > > > > future tests of dynamic page addition where not all scenarios could be
> > > > > tested with all EPC pages already consumed.
> > > > > 
> > > > > Reinette
> > > > 
> > > > Re-initializing the test enclave is mandatory thing to do for all tests
> > > > because it has an internals state.
> > > > 
> > > 
> > > Right, but not all tests require the same enclave. In kselftest terminology
> > > I think you are attempting to force all tests to depend on the same test
> > > fixture. Is it not possible to have a separate "reclaimer" test fixture that
> > > would build an enclave with a large heap and then have reclaimer tests that
> > > exercise it by being tests that are specific to this "reclaimer fixture"?
> > > 
> > > Reinette
> > 
> > Why add that complexity?
> > 
> 
> With this change every test is turned into a pseudo reclaimer test without
> there being any explicit testing (with pass/fail criteria) of reclaimer
> behavior. This is an expensive addition and reduces the scenarios that the
> tests can exercise.
> 
> Reinette

There is consistent known behaviour how reclaimer and also the page fault
are exercised for each test. I think that is what matters most right now
that the basic behaviour of both the page reclaimer and page fault handler
gets exercised.

I don't understand the real-world gain of doing something factors more
complex than necessary at a particular point of time,  when you don't
really need to hang yourself into it forever.

This patch does increase the coverage in a deterministic manner to the code
paths that were not previously exercised, i.e. we know the code paths, and
could even calculate the exact number of times that they are triggered. And
without doing anything obscure. That's what matters to me.

/Jarkko

/Jarkko
