Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7AD41CB3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 19:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345369AbhI2RuV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 13:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345383AbhI2RuV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 13:50:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA9D461501;
        Wed, 29 Sep 2021 17:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632937720;
        bh=uqfSVBibfIyT6p7ujOHdH7qr/R4RUhU7XwLngMqoxMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EiwMkHtlgSDisMcx+jUTA7Jgj6xWj44iae7As/OPjPGLfmIEdrxvPNP3hyneT94Oc
         /n7PBgltSaW9w0+ApVOyMqtccxzzlcLTLLt6pLHrku6zXDMs6GCuI/RINZ73R1GTJv
         kIcUqVZqcRDZmSeLsuaTVmwK3QoURBic+A+5YeZg2Otn7fip12jf5hFmRw9uxJRfVN
         qqIj9aZbHnfAYNfc3qNakoCrXS4mYB7YC4vKdrlL/agaDYdLN2G5Bmqvy0NXHbtK76
         7ye07HLyg3BB3nc/ReR9Q7vHw8Bh+03aD+zDbPuZDI9Pd3oKIIzc/I5O9QPXphM01b
         Miq7McGh8Ph0g==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com
Subject: Re: [PATCH v3 0/4] selftests: arm64: vec-syscfg updates
Date:   Wed, 29 Sep 2021 18:48:25 +0100
Message-Id: <163292958496.925586.3098093192791038550.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929151925.9601-1-broonie@kernel.org>
References: <20210929151925.9601-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 29 Sep 2021 16:19:21 +0100, Mark Brown wrote:
> This series fixes up a few issues introduced into vec-syscfg during
> refactoring in the review process, then adds a new test which ensures
> that the behaviour when we attempt to set a vector length which is not
> supported by the current system matches what is documented in the SVE
> ABI documentation.
> 
> v3:
>  - Rebased onto v5.14-rc3.
>  - Check to see if we discovered the system vector lengths before trying
>    to set all possible vector lengths since we need that information to
>    validate the results.
> v2:
>  - Fix handling of missing VLs when checking that vector length setting
>    works as expected.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/4] selftests: arm64: Fix printf() format mismatch in vec-syscfg
      https://git.kernel.org/arm64/c/ff944c44b782
[2/4] selftests: arm64: Remove bogus error check on writing to files
      https://git.kernel.org/arm64/c/4caf339c037c
[3/4] selftests: arm64: Fix and enable test for setting current VL in vec-syscfg
      https://git.kernel.org/arm64/c/e42391150eab
[4/4] selftests: arm64: Verify that all possible vector lengths are handled
      https://git.kernel.org/arm64/c/8694e5e63886

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
