Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE073880DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 21:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245553AbhERT6l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 15:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239073AbhERT6k (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 15:58:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AD5F61285;
        Tue, 18 May 2021 19:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621367841;
        bh=W7vLOdSKLFgEV5k0jhtQlIFKhbJ5L0R4LHTEFOdxSEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QB4owFZkV2aDv2Fu2AUqXpp1mPGhL+DBAl+X9CUe2kA9z7gV73+vpOSALb+GFc/uY
         yYqrltR7+tl/2QJpbWuQ0i/fmZJr/KumoCq+MbADkLC03y8qCvMgYcManl5tMO+qlG
         Z6eICpd3qq24t7KPwZa/FDikKy/5Ni3gryIdCHKeRFHH7izT3K5Mue1sd/4BDVa1uK
         VgyyOWf/i0TUZA2dAnsMaK4QH5hIfDn2/Yh0DHQ3jkMVkpXUv5Q6wIbvHPRNqhTBoy
         noUU97EU5lAfRE30LqZW7OPkkXq2R4rEYXUpCvO+XNyfVzbsHJicWS/xRgvOcPdk2n
         lNIOvIJLs1Zsg==
Date:   Tue, 18 May 2021 22:57:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] selftests/sgx: Migrate to kselftest harness
Message-ID: <YKQcH2/5ENIp2Bps@kernel.org>
References: <20210512215323.420639-1-jarkko@kernel.org>
 <20210512215323.420639-2-jarkko@kernel.org>
 <3b920525-694c-a8e4-93f5-7b1a3f9ad009@intel.com>
 <YKP+CavM21klDHH8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKP+CavM21klDHH8@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 18, 2021 at 08:49:00PM +0300, Jarkko Sakkinen wrote:
> On Mon, May 17, 2021 at 10:03:42AM -0700, Reinette Chatre wrote:
> > Hi Jarkko,
> > 
> > On 5/12/2021 2:53 PM, Jarkko Sakkinen wrote:
> > > Migrate to kselftest harness. Use a fixture test with enclave initialized
> > > and de-initialized for each of the existing three tests, in other words:
> > > 
> > > 1. One FIXTURE() for managing the enclave life-cycle.
> > > 2. Three TEST_F()'s, one for each test case.
> > > 
> > > This gives a leaps better reporting than before. Here's an example
> > > transcript:
> > > 
> > > TAP version 13
> > > 1..3
> > > 
> > > ok 1 enclave.unclobbered_vdso
> > > 
> > > ok 2 enclave.clobbered_vdso
> > > 
> > > ok 3 enclave.clobbered_vdso_and_user_function
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > > 
> > > v5:
> > > * Use TH_LOG() for printing enclave address ranges instead of printf(),
> > >    based on Reinette's remark.
> > 
> > Thank you for considering my feedback. The motivation for my comment was to
> > consider how this test output will be parsed. If these tests will have their
> > output parsed by automated systems then it needs to conform to the TAP13
> > format as supported by kselftest.
> > 
> > In your latest version the output printed during a successful test has been
> > changed, using TH_LOG() as you noted. From what I can tell this is the only
> > output addressed - failing tests continue to print error messages (perror,
> > fprintf) without consideration of how they will be parsed. My apologies, I
> > am not a kselftest expert to know what the best way for this integration is.
> > 
> > Reinette
> 
> It's a valid question, yes.
> 
> The problem is that only main.c can use kselftest macros because
> kselftest_harness.h pulls 
> 
> static int test_harness_run(int __attribute__((unused)) argc,
> 			    char __attribute__((unused)) **argv)
> 
> which will not end up having a call site (because there's no
> "TEST_HARNESS_MAIN").
> 
> The whole logging thing in kselftest harness is a bit ambiguous.
> Namely:
> 
> 1. There's a macro TH_LOG() defined in kselftest_harness.h, which
>    "internally" uses fprintf().
> 2. There's an inline function ksft_print_msg() in kselftest.h
>    using vsprintf().
> 
> To add to that, kselftest_harness.h internally prints by using
> ksft_print_msg(), and provides TH_LOG(), which does not use
> ksft_print_msg().
> 
> I don't really get the logic in all this.

I tried to split TH_LOG() as separate entity but it's not possible, as the
macros access a static variable called '_metadata'.

I'm not exactly sure how to proceed from this, if we want to make logging
consistent.

I would personally suggest to leave the error messages intact in load.c,
because there is no way to make them consistent, except by removing them.

/Jarkko
