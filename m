Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04539A815A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2019 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfIDLr0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Sep 2019 07:47:26 -0400
Received: from foss.arm.com ([217.140.110.172]:52564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfIDLr0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Sep 2019 07:47:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EA7C337;
        Wed,  4 Sep 2019 04:47:25 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 964DB3F246;
        Wed,  4 Sep 2019 04:47:24 -0700 (PDT)
Date:   Wed, 4 Sep 2019 12:47:22 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
Subject: Re: [PATCH v5 00/11] Add arm64/signal initial kselftest support
Message-ID: <20190904114722.GQ27757@arm.com>
References: <20190902112932.36129-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902112932.36129-1-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 02, 2019 at 12:29:21pm +0100, Cristian Marussi wrote:
> Hi
> 
> this patchset aims to add the initial arch-specific arm64 support to
> kselftest starting with signals-related test-cases.
> A common internal test-case layout is proposed which then it is anyway
> wired-up to the toplevel kselftest Makefile, so that it should be possible
> at the end to run it on an arm64 target in the usual way with KSFT.

BTW, it's helpful to state the base branch / commit as clearly as
possible near the top of the cover letter, say,

--8<--

This series is based on arm64/for-next/core [1]
commit 9ce1263033cd ("selftests, arm64: add a selftest for passing tagged pointers to kernel")

[1] git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core

-->8--

This is particularly important if you expect the maintainer to pick up
the patches.

You don't need to reference a specific commit unless there's a
significant chance of conflicts if the wrong commit is used, but it can
help provide a clue as to why you're basing on this alternate branch.

> ~/linux# make TARGETS=arm64 kselftest
> 
> New KSFT arm64 testcases live inside tools/testing/selftests/arm64 grouped by
> family inside subdirectories: arm64/signal is the first family proposed with
> this series.
> This series converts also to this subdirectory scheme the pre-existing
> (already queued on arm64/for-next/core) KSFT arm64 tags tests, moving them
> into arm64/tags.
> 
> Thanks
> 
> Cristian
> 
> 
> Notes:
> -----
> - further details in the included READMEs
> 
> - more tests still to be written (current strategy is going through the related
>   Kernel signal-handling code and write a test for each possible and sensible code-path)
>   A few ideas for more TODO testcases:
> 	- fake_sigreturn_unmapped_sp: SP into unmapped addrs
> 	- fake_sigreturn_kernelspace_sp: SP into kernel addrs
> 	- fake_sigreturn_sve_bad_extra_context: SVE extra context badly formed
> 	- mangle_sve_invalid_extra_context: SVE extra_context invalid
> 
> - SVE signal testcases and special handling will be part of an additional patch
>   still to be released

What's your approach to checking that the test failure paths work?

We could either hack the kernel or the tests to provoke "fake" failures,
and I don't think it's necessary to test everything in this way,
providing we have confidence that the test strategy and framework works
in general.

[...]

Cheers
---Dave
