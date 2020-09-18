Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF4B2701EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 18:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIRQRa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 12:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgIRQR1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 12:17:27 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6DFA2389E;
        Fri, 18 Sep 2020 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600445846;
        bh=OzFEfJHJT/f2B9gvZhTIsSFHcRRNGzULTO9hNKDvsA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0wGyqIvXsITcaer07SaQaxDXGG+cQ6PGz06heCRqcGgXoEPBOoiWP5cKcFdNv9jz
         XzXJnuV/CkO8M77oaLz8aPWyoak8UkHL1qsLdfNjvGeUpODKFRaOXnyvrKYkxgxHv2
         PEmf7zfGlUArEI7a/g0ZeXyTjdvNlhVNY9WGRkQU=
From:   Will Deacon <will@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/6] selftests: arm64: Add floating point selftests
Date:   Fri, 18 Sep 2020 17:17:13 +0100
Message-Id: <160043518911.3785481.10986128470527304767.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200819114837.51466-1-broonie@kernel.org>
References: <20200819114837.51466-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 19 Aug 2020 12:48:31 +0100, Mark Brown wrote:
> This series imports a series of tests for FPSIMD and SVE originally
> written by Dave Martin to the tree. Since these extensions have some
> overlap in terms of register usage and must sometimes be tested together
> they're dropped into a single directory. I've adapted some of the tests
> to run within the kselftest framework but there are also some stress
> tests here that are intended to be run as soak tests so aren't suitable
> for running by default and are mostly just integrated with the build
> system. There doesn't seem to be a more suitable home for those stress
> tests and they are very useful for work on these areas of the code so it
> seems useful to have them somewhere in tree.
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/6] selftests: arm64: Test case for enumeration of SVE vector lengths
      https://git.kernel.org/arm64/c/ca765153eb90
[2/6] selftests: arm64: Add test for the SVE ptrace interface
      https://git.kernel.org/arm64/c/0dca276ac4d2
[3/6] selftests: arm64: Add stress tests for FPSMID and SVE context switching
      https://git.kernel.org/arm64/c/5e992c638ea5
[4/6] selftests: arm64: Add utility to set SVE vector lengths
      https://git.kernel.org/arm64/c/fc7e611f9f38
[5/6] selftests: arm64: Add wrapper scripts for stress tests
      https://git.kernel.org/arm64/c/25f47e3eb66e
[6/6] selftests: arm64: Add build and documentation for FP tests
      https://git.kernel.org/arm64/c/e093256d14fb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
