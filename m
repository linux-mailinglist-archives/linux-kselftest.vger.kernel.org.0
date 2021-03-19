Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F170342285
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhCSQyF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 12:54:05 -0400
Received: from foss.arm.com ([217.140.110.172]:56802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhCSQxo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 12:53:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49F52ED1;
        Fri, 19 Mar 2021 09:53:44 -0700 (PDT)
Received: from e104803-lin.cambridge.arm.com (e104803-lin.cambridge.arm.com [10.1.197.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B68E03F70D;
        Fri, 19 Mar 2021 09:53:42 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: [PATCH 01/11] kselftest/arm64: mte: Fix compilation with native compiler
Date:   Fri, 19 Mar 2021 16:53:24 +0000
Message-Id: <20210319165334.29213-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20210319165334.29213-1-andre.przywara@arm.com>
References: <20210319165334.29213-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The mte selftest Makefile contains a check for GCC, to add the memtag
-march flag to the compiler options. This check fails if the compiler
is not explicitly specified, so reverts to the standard "cc", in which
case --version doesn't mention the "gcc" string we match against:
$ cc --version | head -n 1
cc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0

This will not add the -march switch to the command line, so compilation
fails:
mte_helper.S: Assembler messages:
mte_helper.S:25: Error: selected processor does not support `irg x0,x0,xzr'
mte_helper.S:38: Error: selected processor does not support `gmi x1,x0,xzr'
...

Actually clang accepts the same -march option as well, so we can just
drop this check and add this unconditionally to the command line, to avoid
any future issues with this check altogether (gcc actually prints
basename(argv[0]) when called with --version).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/mte/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/Makefile b/tools/testing/selftests/arm64/mte/Makefile
index 0b3af552632a..df15d44aeb8d 100644
--- a/tools/testing/selftests/arm64/mte/Makefile
+++ b/tools/testing/selftests/arm64/mte/Makefile
@@ -6,9 +6,7 @@ SRCS := $(filter-out mte_common_util.c,$(wildcard *.c))
 PROGS := $(patsubst %.c,%,$(SRCS))
 
 #Add mte compiler option
-ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep gcc),)
 CFLAGS += -march=armv8.5-a+memtag
-endif
 
 #check if the compiler works well
 mte_cc_support := $(shell if ($(CC) $(CFLAGS) -E -x c /dev/null -o /dev/null 2>&1) then echo "1"; fi)
-- 
2.17.5

