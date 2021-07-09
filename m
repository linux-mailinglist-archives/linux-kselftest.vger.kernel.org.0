Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4803E3C2776
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 18:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhGIQZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jul 2021 12:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhGIQZd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jul 2021 12:25:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CDA261153;
        Fri,  9 Jul 2021 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625847769;
        bh=kxyDYP6A8O10FtJkUZON8yJOupFKIyAhOIelmPtwv5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZeKzIiYXEGbK0b9C6iTSp+7gymmyaIyPpTJr+lJkFub5wqx75idU9eUzfu+AEgr8
         +9onnivkg8BXgiatHW9u5VvmG7gIikAMaENxrGV5Qm+KgeG3PvNy5Za6UdoVX90h//
         9W+qlDq/Kf+nnYgJwbyxZ7NmXZUZctfErCrsPkLkbo4NwFyFkzisCfZ/v3vwFLR+AD
         KrsQCi1sJf8fIk+kRe/zgTVlVHeftuzfGB14jEQNEdrgBfT7dEFLDT/IzIa831iykg
         hvPVEX+slJhPXeXdQqHgxAFr8dgVoZe8kB1YCid7b8DkE6Qi+ZOWDputyWTvcQC9uu
         bkoqM+CaGnN8Q==
Date:   Fri, 9 Jul 2021 19:22:47 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests/sgx: Trigger the reclaimer and #PF handler
Message-ID: <20210709162247.d5ggqgpqpu2drp6o@kernel.org>
References: <20210705143652.116125-1-jarkko@kernel.org>
 <20210705143652.116125-5-jarkko@kernel.org>
 <715ed555-5044-6fee-1d09-1c4cfa827af3@intel.com>
 <20210706235016.uucukyrr3ckk57pi@kernel.org>
 <16505466-e001-c4b0-ec41-5384ddcf194b@intel.com>
 <20210707091736.6wzemgmtzuegk3uf@kernel.org>
 <10664754-7e53-d9d1-f00c-f9dbd4a2d877@intel.com>
 <20210707205019.6jy64s4uqcw65q4h@kernel.org>
 <64b1cac8-75b9-8549-8499-60b4d72cf9ef@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64b1cac8-75b9-8549-8499-60b4d72cf9ef@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 07, 2021 at 02:20:04PM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 7/7/2021 1:50 PM, Jarkko Sakkinen wrote:
> > On Wed, Jul 07, 2021 at 08:02:42AM -0700, Reinette Chatre wrote:
> > > Hi Jarkko,
> > > 
> > > On 7/7/2021 2:17 AM, Jarkko Sakkinen wrote:
> > > > On Tue, Jul 06, 2021 at 05:10:38PM -0700, Reinette Chatre wrote:
> > > > > Hi Jarkko,
> > > > > 
> > > > > On 7/6/2021 4:50 PM, Jarkko Sakkinen wrote:
> > > > > > On Tue, Jul 06, 2021 at 11:34:54AM -0700, Reinette Chatre wrote:
> > > > > > > Hi Jarkko,
> > > > > > > 
> > > > > > > On 7/5/2021 7:36 AM, Jarkko Sakkinen wrote:
> > > > > > > > Create a heap for the test enclave, which has the same size as all
> > > > > > > > available Enclave Page Cache (EPC) pages in the system. This will guarantee
> > > > > > > > that all test_encl.elf pages *and* SGX Enclave Control Structure (SECS)
> > > > > > > > have been swapped out by the page reclaimer during the load time. Actually,
> > > > > > > > this adds a bit more stress than that since part of the EPC gets reserved
> > > > > > > > for the Version Array (VA) pages.
> > > > > > > > 
> > > > > > > > For each test, the page fault handler gets triggered in two occasions:
> > > > > > > > 
> > > > > > > > - When SGX_IOC_ENCLAVE_INIT is performed, SECS gets swapped in by the
> > > > > > > >       page fault handler.
> > > > > > > > - During the execution, each page that is referenced gets swapped in
> > > > > > > >       by the page fault handler.
> > > > > > > > 
> > > > > > > 
> > > > > > > If I understand this correctly, all EPC pages are now being consumed during
> > > > > > > fixture setup and thus every SGX test, no matter how big or small, now
> > > > > > > becomes a stress test of the reclaimer instead of there being a unique
> > > > > > > reclaimer test. Since an enclave is set up and torn down for every test this
> > > > > > > seems like a significant addition. It also seems like this would impact
> > > > > > > future tests of dynamic page addition where not all scenarios could be
> > > > > > > tested with all EPC pages already consumed.
> > > > > > > 
> > > > > > > Reinette
> > > > > > 
> > > > > > Re-initializing the test enclave is mandatory thing to do for all tests
> > > > > > because it has an internals state.
> > > > > > 
> > > > > 
> > > > > Right, but not all tests require the same enclave. In kselftest terminology
> > > > > I think you are attempting to force all tests to depend on the same test
> > > > > fixture. Is it not possible to have a separate "reclaimer" test fixture that
> > > > > would build an enclave with a large heap and then have reclaimer tests that
> > > > > exercise it by being tests that are specific to this "reclaimer fixture"?
> > > > > 
> > > > > Reinette
> > > > 
> > > > Why add that complexity?
> > > > 
> > > 
> > > With this change every test is turned into a pseudo reclaimer test without
> > > there being any explicit testing (with pass/fail criteria) of reclaimer
> > > behavior. This is an expensive addition and reduces the scenarios that the
> > > tests can exercise.
> > > 
> > > Reinette
> > 
> > There is consistent known behaviour how reclaimer and also the page fault
> > are exercised for each test. I think that is what matters most right now
> > that the basic behaviour of both the page reclaimer and page fault handler
> > gets exercised.
> 
> I believe the basic behavior of page fault handler is currently exercised in
> each test, this is required.

This not true. The current test does not exercise ELDU code path.

> 
> > 
> > I don't understand the real-world gain of doing something factors more
> > complex than necessary at a particular point of time,  when you don't
> > really need to hang yourself into it forever.
> 
> Your argument about "hang yourself into it forever" can go both ways - why
> should all tests now unnecessarily consume the entire EPC forever?
> 
> If I understand correctly adding a separate reclaimer test is not complex
> but would require refactoring code.

What does it matter anyway if code nees to be refactored?

> > This patch does increase the coverage in a deterministic manner to the code
> > paths that were not previously exercised, i.e. we know the code paths, and
> > could even calculate the exact number of times that they are triggered. And
> > without doing anything obscure. That's what matters to me.
> 
> On the contrary this is indeed obfuscating the SGX tests: if an issue shows
> up in the reclaimer then all tests would fail. If there is a unique
> reclaimer test then that would help point to where the issue may be.

I tend to disagree this. I'll add a separate reclaimer test if I need
to test something that this does not scale. It's an iterative process.

/Jarkko
