Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C999F3AC6CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 11:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFRJJp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 05:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhFRJJo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 05:09:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19915613C2;
        Fri, 18 Jun 2021 09:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624007255;
        bh=r167WIyDtqUGkAc4r3jGYGFCA/c0iepusDavo3Z9pq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldEFx8N+sT/96BqwumHyamri1jZOPXlBiTuhHhUqRUcWq0RFpmtO55sHHYW0v+s5d
         6peS+yiGRPr52BwbAipV9h5SyfQzPjn+Pa1u7fEFxI1gn9TleP9LskF/ifaEFIyeKl
         MB4VnxQHuqPfQayekaAA1p+8X35S5orLpyeGc2smf0QU49BcKrqXrgksEKbhic7yC9
         7D5yA8vvBsCHdvdUApTDfX1pOZJgTwGHdDhL3+z5NaGvS+fk9E9ZeZiqXKGJsw0cti
         Xviz2Hb7YRDAMelpf3ap3vXmDScqflqDahnLxumWQj5Fvqi0oKnSIGxRZV5v4tHtrG
         PxtywsDPJ8mjA==
Date:   Fri, 18 Jun 2021 12:07:32 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] selftests/sgx: Refine the test enclave to have
 storage
Message-ID: <20210618090732.szt3bh5s7yfemewe@kernel.org>
References: <20210610083021.392269-1-jarkko@kernel.org>
 <20210610083021.392269-5-jarkko@kernel.org>
 <b1bf69f5-e203-d69e-d15d-3fb5e98b63dd@linuxfoundation.org>
 <20210615131359.zrfvi36sjdpxghzl@kernel.org>
 <20210615131553.5y3jssldqc3sv2ge@kernel.org>
 <adcc7797-db49-4dbc-ef87-5c12ad1d6a44@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adcc7797-db49-4dbc-ef87-5c12ad1d6a44@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 15, 2021 at 03:55:25PM -0600, Shuah Khan wrote:
> On 6/15/21 7:15 AM, Jarkko Sakkinen wrote:
> > On Tue, Jun 15, 2021 at 04:14:02PM +0300, Jarkko Sakkinen wrote:
> > > On Mon, Jun 14, 2021 at 02:16:15PM -0600, Shuah Khan wrote:
> > > > On 6/10/21 2:30 AM, Jarkko Sakkinen wrote:
> > > > > Extend the enclave to have two operations: ENCL_OP_PUT and ENCL_OP_GET.
> > > > > ENCL_OP_PUT stores value inside the enclave address space and
> > > > > ENCL_OP_GET reads it. The internal buffer can be later extended to be
> > > > > variable size, and allow reclaimer tests.
> > > > > 
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > ---
> > > > >    tools/testing/selftests/sgx/defines.h     | 10 ++++
> > > > >    tools/testing/selftests/sgx/main.c        | 57 ++++++++++++++++++-----
> > > > >    tools/testing/selftests/sgx/test_encl.c   | 19 +++++++-
> > > > >    tools/testing/selftests/sgx/test_encl.lds |  3 +-
> > > > >    4 files changed, 74 insertions(+), 15 deletions(-)
> > > > > 
> > > > 
> > > > Test output before applying the series:
> > > > 
> > > > TAP version 13
> > > > 1..1
> > > > # selftests: sgx: test_sgx
> > > > # Unable to open /dev/sgx_enclave: No such file or directory
> > > > # 1..0 # SKIP cannot load enclaves
> > > > ok 1 selftests: sgx: test_sgx # SKIP
> > > > 
> > > > Test output after applying second patch
> > > > 
> > > > selftests/sgx: Migrate to kselftest harness
> > > > 
> > > > Output changes to the following. It doesn't look like the second
> > > > patch adds any new tests. What is the point in running the tests
> > > > that fail if /dev/sgx_enclave is missing.
> > > > 
> > > > Unfortunately this series doesn't have a cover letter that explains
> > > > what this series is doing. I don't like the fact that the test
> > > > output and behavior changes when migrating the test to kselftest
> > > > harness. Shouldn't the output stay the same as in skip the tests
> > > > if /dev/sgx_enclave fails.
> > > 
> > > I get what you are saying but actually I do not know how with
> > > fixtures I can skip "the rest" when FIXTURE_SETUP() fails.
> > > 
> > > The reason for the output below is that with fixtures for all
> > > tests enclave is initialized for each test case. And it kind of
> > > makes sense because all tests start from the clean expected
> > > state.
> > > 
> > > I don't how to do that with zero change in the output.
> > > 
> 
> Yeah. I took a look at the FIXTURE. Doesn't look like it is possible.
> 
> > > The reason to do this change is to make it easy to add more tests,
> > > and return correct status codes to the framework.
> > 
> > To add: everything I did I based purely to the existing kernel
> > documentation, following the examples on how to use fixture.
> > 
> 
> I will pick these up and will add a note to the last commit that
> output changes, so test rings that run kselftest are aware of the
> change.
> 
> thanks,
> -- Shuah

OK, great, thank you!

/Jarkko
