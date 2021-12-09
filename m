Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9797546F35F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Dec 2021 19:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhLISyx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Dec 2021 13:54:53 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38300 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhLISyx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Dec 2021 13:54:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2087CCE27D7
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 18:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCB2C004DD;
        Thu,  9 Dec 2021 18:51:12 +0000 (UTC)
Date:   Thu, 9 Dec 2021 18:51:07 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 00/37] arm64/sme: Initial support for the Scalable
 Matrix Extension
Message-ID: <YbJQG/V7wHohpX2x@arm.com>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 15, 2021 at 03:27:58PM +0000, Mark Brown wrote:
> Mark Brown (37):
>   arm64/sve: Make sysctl interface for SVE reusable by SME
>   arm64/sve: Generalise vector length configuration prctl() for SME
>   arm64/sve: Minor clarification of ABI documentation
>   kselftest/arm64: Parameterise ptrace vector length information
>   kselftest/arm64: Allow signal tests to trigger from a function
>   kselftest/arm64: Add a test program to exercise the syscall ABI
>   tools/nolibc: Implement gettid()
>   arm64: cpufeature: Add has_feature_flag() match function
>   arm64/sme: Provide ABI documentation for SME
>   arm64/sme: System register and exception syndrome definitions
>   arm64/sme: Define macros for manually encoding SME instructions
>   arm64/sme: Early CPU setup for SME
>   arm64/sme: Basic enumeration support
>   arm64/sme: Identify supported SME vector lengths at boot
>   arm64/sme: Implement sysctl to set the default vector length
>   arm64/sme: Implement vector length configuration prctl()s
>   arm64/sme: Implement support for TPIDR2
>   arm64/sme: Implement SVCR context switching
>   arm64/sme: Implement streaming SVE context switching
>   arm64/sme: Implement ZA context switching
>   arm64/sme: Implement traps and syscall handling for SME
>   arm64/sme: Implement streaming SVE signal handling
>   arm64/sme: Implement ZA signal handling
>   arm64/sme: Implement ptrace support for streaming mode SVE registers
>   arm64/sme: Add ptrace support for ZA
>   arm64/sme: Disable streaming mode and ZA when flushing CPU state
>   arm64/sme: Save and restore streaming mode over EFI runtime calls
>   arm64/sme: Provide Kconfig for SME
>   kselftest/arm64: sme: Add streaming SME support to vlset
>   kselftest/arm64: Add tests for TPIDR2
>   kselftest/arm64: Extend vector configuration API tests to cover SME
>   kselftest/arm64: sme: Provide streaming mode SVE stress test
>   kselftest/arm64: Add stress test for SME ZA context switching
>   kselftest/arm64: signal: Add SME signal handling tests
>   kselftest/arm64: Add streaming SVE to SVE ptrace tests
>   kselftest/arm64: Add coverage for the ZA ptrace interface
>   kselftest/arm64: Add SME support to syscall ABI test

I had a quick look through this series and made some minor comments but
I need to dig deeper into the SME ABI. Ideally someone (Szabolcs?) from
the toolchain/libc side should confirm that they are happy with it. In
the meantime I can queue the first 6 patches once updated.

Thanks.

-- 
Catalin
