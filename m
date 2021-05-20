Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A0238B446
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 18:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhETQdt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 May 2021 12:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231655AbhETQdt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 May 2021 12:33:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13CF861019;
        Thu, 20 May 2021 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621528347;
        bh=xap1mXh1aur7meGreudrJanpOTnkh3G8eXqK30buDU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iAPrl2gKGSuO1pkSKW3UyYVcIWate1zEbOx6uQS2z95I8eDwM5jqfMk29DubPfRIB
         XwsyHZwvACHYvGD0QV4Fo7/GdQU0WsQmoZcWNWGjE32mb0V5JPXWEsGlzFHi9dKv5w
         cnlHYrN7T2AnP/D4CPLBxjmzzIXyAsnYSGFVHVQ+GpeJs37Rba47rJrVR6bJvwcJuO
         nk9Cq7fFLi8ozynliJ5dZNB352FPHSA0xx95jh/TRbrrwyBOyQVynS2JO7IpG87WTI
         LfcNN0673MChDgM+7lS1mEjMyCwbBBV2K0Hztme9ch8fTT22DOEneBXRwjXMY8o4kb
         8aXKLMX9iJkCg==
Date:   Thu, 20 May 2021 19:32:23 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] selftests/sgx: Migrate to kselftest harness
Message-ID: <YKaPFzzEQuA9j1ul@kernel.org>
References: <20210512215323.420639-1-jarkko@kernel.org>
 <20210512215323.420639-2-jarkko@kernel.org>
 <3b920525-694c-a8e4-93f5-7b1a3f9ad009@intel.com>
 <YKP+CavM21klDHH8@kernel.org>
 <YKQcH2/5ENIp2Bps@kernel.org>
 <16d7588e-a44c-90c1-44be-3a9cca1dc913@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d7588e-a44c-90c1-44be-3a9cca1dc913@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 18, 2021 at 01:07:16PM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 5/18/2021 12:57 PM, Jarkko Sakkinen wrote:
> > On Tue, May 18, 2021 at 08:49:00PM +0300, Jarkko Sakkinen wrote:
> > > On Mon, May 17, 2021 at 10:03:42AM -0700, Reinette Chatre wrote:
> > > > Hi Jarkko,
> > > > 
> > > > On 5/12/2021 2:53 PM, Jarkko Sakkinen wrote:
> > > > > Migrate to kselftest harness. Use a fixture test with enclave initialized
> > > > > and de-initialized for each of the existing three tests, in other words:
> > > > > 
> > > > > 1. One FIXTURE() for managing the enclave life-cycle.
> > > > > 2. Three TEST_F()'s, one for each test case.
> > > > > 
> > > > > This gives a leaps better reporting than before. Here's an example
> > > > > transcript:
> > > > > 
> > > > > TAP version 13
> > > > > 1..3
> > > > > 
> > > > > ok 1 enclave.unclobbered_vdso
> > > > > 
> > > > > ok 2 enclave.clobbered_vdso
> > > > > 
> > > > > ok 3 enclave.clobbered_vdso_and_user_function
> > > > > 
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > ---
> > > > > 
> > > > > v5:
> > > > > * Use TH_LOG() for printing enclave address ranges instead of printf(),
> > > > >     based on Reinette's remark.
> > > > 
> > > > Thank you for considering my feedback. The motivation for my comment was to
> > > > consider how this test output will be parsed. If these tests will have their
> > > > output parsed by automated systems then it needs to conform to the TAP13
> > > > format as supported by kselftest.
> > > > 
> > > > In your latest version the output printed during a successful test has been
> > > > changed, using TH_LOG() as you noted. From what I can tell this is the only
> > > > output addressed - failing tests continue to print error messages (perror,
> > > > fprintf) without consideration of how they will be parsed. My apologies, I
> > > > am not a kselftest expert to know what the best way for this integration is.
> > > > 
> > > > Reinette
> > > 
> > > It's a valid question, yes.
> > > 
> > > The problem is that only main.c can use kselftest macros because
> > > kselftest_harness.h pulls
> > > 
> > > static int test_harness_run(int __attribute__((unused)) argc,
> > > 			    char __attribute__((unused)) **argv)
> > > 
> > > which will not end up having a call site (because there's no
> > > "TEST_HARNESS_MAIN").
> > > 
> > > The whole logging thing in kselftest harness is a bit ambiguous.
> > > Namely:
> > > 
> > > 1. There's a macro TH_LOG() defined in kselftest_harness.h, which
> > >     "internally" uses fprintf().
> > > 2. There's an inline function ksft_print_msg() in kselftest.h
> > >     using vsprintf().
> > > 
> > > To add to that, kselftest_harness.h internally prints by using
> > > ksft_print_msg(), and provides TH_LOG(), which does not use
> > > ksft_print_msg().
> > > 
> > > I don't really get the logic in all this.
> > 
> > I tried to split TH_LOG() as separate entity but it's not possible, as the
> > macros access a static variable called '_metadata'.
> > 
> > I'm not exactly sure how to proceed from this, if we want to make logging
> > consistent.
> > 
> > I would personally suggest to leave the error messages intact in load.c,
> > because there is no way to make them consistent, except by removing them.
> 
> 
> It is not clear to me why ksft_print_msg() cannot be used but an alternative
> to it may be to just prefix all existing diagnostic messages with "# ".
> 
> Reinette

How is using ksft_print_msg() better than using fprintf()? It's as
incompatible with the logging used by fixtures, as is a raw fprintf().

What is the gain of doing that?

/Jarkko
