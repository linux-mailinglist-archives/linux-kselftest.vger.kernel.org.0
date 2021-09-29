Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8923C41CB3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345392AbhI2RuU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 13:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345383AbhI2RuT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 13:50:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB2A5614C8;
        Wed, 29 Sep 2021 17:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632937718;
        bh=ToREgYmQQLiG5hjvle53IDBtanc/GdnJjSI49OZuBjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIQzwFy3VGNNcCdf/aiswn3wm09gEk6GH9X6Wp/+LSDmYdkXuYGUWjK1XCd13U0Ql
         puODOxPPy8yZDYIPq6rj0muKcC3cf8ehp4lFM0hoe1P2KZdL/RaYDHCVJ2JSDmn8IO
         jK9rgaTQxq3kPBsfWkUG2OaKI+YtuF771H7WQTxzXoRRPgPIFOIEElIh0wFQhjQ3n1
         67+3GLjeBisws0zlc2VsuAhTUU6SWl4nc1N96ZoXv66BcG0gbKhKIVF6xxFl/eLbPO
         el849ysdT5eBrmKA8srzVc2yMgpfeuOXQGHoOFLgqprZD71Ek7gW7DdGF6fcDW58/C
         +H060Q9dV/a6Q==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/8] selftests: arm64: SVE ptrace test rework
Date:   Wed, 29 Sep 2021 18:48:24 +0100
Message-Id: <163292283281.787570.15772098830500807545.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913125505.52619-1-broonie@kernel.org>
References: <20210913125505.52619-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 13 Sep 2021 13:54:57 +0100, Mark Brown wrote:
> This series overhauls the selftests we have for the SVE ptrace interface
> to make them much more comprehensive than they are currently, making the
> coverage of the data read and written more complete.  The new coverage
> for setting data on all vector lengths showed the issue with using the
> wrong buffer size with ptrace reported and fixed by:
> 
>   https://lore.kernel.org/linux-arm-kernel/20210909165356.10675-1-broonie@kernel.org/
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/8] selftests: arm64: Use a define for the number of SVE ptrace tests to be run
      https://git.kernel.org/arm64/c/78d2d816c45a
[2/8] selftests: arm64: Don't log child creation as a test in SVE ptrace test
      https://git.kernel.org/arm64/c/09121ad7186e
[3/8] selftests: arm64: Remove extraneous register setting code
      https://git.kernel.org/arm64/c/eab281e3afa6
[4/8] selftests: arm64: Document what the SVE ptrace test is doing
      https://git.kernel.org/arm64/c/736e6d5a5451
[5/8] selftests: arm64: Clarify output when verifying SVE register set
      https://git.kernel.org/arm64/c/8c9eece0bfbf
[6/8] selftests: arm64: Verify interoperation of SVE and FPSIMD register sets
      https://git.kernel.org/arm64/c/9f7d03a2c5a1
[7/8] selftests: arm64: More comprehensively test the SVE ptrace interface
      https://git.kernel.org/arm64/c/a1d7111257cd
[8/8] selftests: arm64: Move FPSIMD in SVE ptrace test into a function
      https://git.kernel.org/arm64/c/34785030dc06

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
