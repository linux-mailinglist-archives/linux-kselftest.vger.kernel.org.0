Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9C3283DFE
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Oct 2020 20:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgJESJF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Oct 2020 14:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgJESJE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Oct 2020 14:09:04 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7969E2100A;
        Mon,  5 Oct 2020 18:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601921344;
        bh=JQrEJw5wL+Whaph7CBgSEPJ12ogkEyC+vf6sNyfuM5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkXE3kGUmTDZXbcKJl87bPVlRStDAZk38su9z0U54VxB0tSMESlqZrb9fkvDwoIPA
         4/nYQnmOOaPB1Olz9iQs9FR3UW2mPIFgVr1fn7Zg3FrWm4Rep0Ksq90ofbqzW/8hbw
         jD63EbUZKTakwpw5soBCn1mO1Ohrjsi+4QvSzbGY=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Gabor Kertesz <gabor.kertesz@arm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Subject: Re: [PATCH v2 0/6] kselftest: arm64/mte: Tests for user-space MTE
Date:   Mon,  5 Oct 2020 19:08:57 +0100
Message-Id: <160192033783.52795.7154690742315956684.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002115630.24683-1-amit.kachhap@arm.com>
References: <20201002115630.24683-1-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2 Oct 2020 17:26:24 +0530, Amit Daniel Kachhap wrote:
> These patch series adds below kselftests to test the user-space support for the
> ARMv8.5 Memory Tagging Extension present in arm64 tree [1]. This patch
> series is based on Linux v5.9-rc3.
> 
> 1) This test-case verifies that the memory allocated by kernel mmap interface
> can support tagged memory access. It first checks the presence of tags at
> address[56:59] and then proceeds with read and write. The pass criteria for
> this test is that tag fault exception should not happen.
> 
> [...]

Applied to arm64 (for-next/late-arrivals), thanks!

[1/6] kselftest/arm64: Add utilities and a test to validate mte memory
      https://git.kernel.org/arm64/c/e9b60476bea0
[2/6] kselftest/arm64: Verify mte tag inclusion via prctl
      https://git.kernel.org/arm64/c/f3b2a26ca78d
[3/6] kselftest/arm64: Check forked child mte memory accessibility
      https://git.kernel.org/arm64/c/dfe537cf4718
[4/6] kselftest/arm64: Verify all different mmap MTE options
      https://git.kernel.org/arm64/c/53ec81d23213
[5/6] kselftest/arm64: Verify KSM page merge for MTE pages
      https://git.kernel.org/arm64/c/f981d8fa2646
[6/6] kselftest/arm64: Check mte tagged user address in kernel
      https://git.kernel.org/arm64/c/4dafc08d0ba4

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
