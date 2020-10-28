Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC44629DE94
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 01:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbgJ2AzN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 20:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731652AbgJ1WRk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:40 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09DD3247C1;
        Wed, 28 Oct 2020 15:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603897975;
        bh=HZmLg7SlaBNEBZr6yuif6M5CcMd4/KqwKEaK+Y+Ve60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxi08IAw2J/t9u9TcUgPVUOWxwfHzYekp3jddaAxsa/f/o0Gk/JAdg8xMgODOCs5L
         xE6ELEDB2wxonO+xpRJlR4iC9QUQEELPiOYPrQDFIsTMlvBw5ehoqZTilf/YjuLHnB
         ftRYAkGGU6eaS7YX/Ayl42bJyMbVa3MuTLNoiX2E=
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Gabor Kertesz <gabor.kertesz@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: Re: [PATCH 0/6] kselftest/arm64: MTE fixes
Date:   Wed, 28 Oct 2020 15:12:37 +0000
Message-Id: <160389254446.1108215.12233305220868499790.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201026121248.2340-1-vincenzo.frascino@arm.com>
References: <20201026121248.2340-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 26 Oct 2020 12:12:42 +0000, Vincenzo Frascino wrote:
> This series contains a set of fixes for the arm64 MTE kselftests [1].
> 
> A version of the fixes rebased on 5.10-rc1 can be found at [2].
> 
> To verify the fixes it is possible to use the command below:
> 
> make -C tools/testing/selftests/ ARCH=arm64 TARGETS=arm64 ARM64_SUBTARGETS=mte \
>         CC=<gcc compiler with MTE support>
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/6] kselftest/arm64: Fix check_buffer_fill test
      https://git.kernel.org/arm64/c/5bc7c1156f3f
[2/6] kselftest/arm64: Fix check_tags_inclusion test
      https://git.kernel.org/arm64/c/041fa41f5422
[3/6] kselftest/arm64: Fix check_child_memory test
      https://git.kernel.org/arm64/c/386cf789fa6d
[4/6] kselftest/arm64: Fix check_mmap_options test
      https://git.kernel.org/arm64/c/7419390a466e
[5/6] kselftest/arm64: Fix check_ksm_options test
      https://git.kernel.org/arm64/c/cbb268af05de
[6/6] kselftest/arm64: Fix check_user_mem test
      https://git.kernel.org/arm64/c/493b35db0548

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
