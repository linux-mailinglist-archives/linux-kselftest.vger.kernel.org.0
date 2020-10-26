Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08DC298CB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 13:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774766AbgJZMNH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 08:13:07 -0400
Received: from foss.arm.com ([217.140.110.172]:37110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1774764AbgJZMNG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 08:13:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F4651476;
        Mon, 26 Oct 2020 05:13:06 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A6003F719;
        Mon, 26 Oct 2020 05:13:04 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gabor Kertesz <gabor.kertesz@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH 0/6] kselftest/arm64: MTE fixes
Date:   Mon, 26 Oct 2020 12:12:42 +0000
Message-Id: <20201026121248.2340-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series contains a set of fixes for the arm64 MTE kselftests [1].

A version of the fixes rebased on 5.10-rc1 can be found at [2].

To verify the fixes it is possible to use the command below:

make -C tools/testing/selftests/ ARCH=arm64 TARGETS=arm64 ARM64_SUBTARGETS=mte \
        CC=<gcc compiler with MTE support>

[1] https://lore.kernel.org/lkml/20201002115630.24683-1-amit.kachhap@arm.com
[2] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v5.fixes

Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Gabor Kertesz <gabor.kertesz@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (6):
  kselftest/arm64: Fix check_buffer_fill test
  kselftest/arm64: Fix check_tags_inclusion test
  kselftest/arm64: Fix check_child_memory test
  kselftest/arm64: Fix check_mmap_options test
  kselftest/arm64: Fix check_ksm_options test
  kselftest/arm64: Fix check_user_mem test

 tools/testing/selftests/arm64/mte/check_buffer_fill.c    | 3 +++
 tools/testing/selftests/arm64/mte/check_child_memory.c   | 3 +++
 tools/testing/selftests/arm64/mte/check_ksm_options.c    | 4 ++++
 tools/testing/selftests/arm64/mte/check_mmap_options.c   | 4 ++++
 tools/testing/selftests/arm64/mte/check_tags_inclusion.c | 3 +++
 tools/testing/selftests/arm64/mte/check_user_mem.c       | 4 ++++
 6 files changed, 21 insertions(+)

-- 
2.28.0

