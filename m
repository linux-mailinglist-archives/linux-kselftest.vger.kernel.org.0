Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3E934228F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCSQyI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 12:54:08 -0400
Received: from foss.arm.com ([217.140.110.172]:56878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230107AbhCSQx4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 12:53:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14F84ED1;
        Fri, 19 Mar 2021 09:53:56 -0700 (PDT)
Received: from e104803-lin.cambridge.arm.com (e104803-lin.cambridge.arm.com [10.1.197.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81C113F70D;
        Fri, 19 Mar 2021 09:53:54 -0700 (PDT)
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
Subject: [PATCH 09/11] kselftest/arm64: mte: Makefile: Fix clang compilation
Date:   Fri, 19 Mar 2021 16:53:32 +0000
Message-Id: <20210319165334.29213-10-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20210319165334.29213-1-andre.przywara@arm.com>
References: <20210319165334.29213-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When clang finds a header file on the command line, it wants to
precompile that, which would end up in a separate output file.
Specifying -o on that same command line collides with that effort, so
the compiler complains:

clang: error: cannot specify -o when generating multiple output files

Since we are not really after a precompiled header, just drop the header
file from the command line, by removing it from the list of source
files in the Makefile.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/mte/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/mte/Makefile b/tools/testing/selftests/arm64/mte/Makefile
index e0d43cea3cd1..409e3e53d00a 100644
--- a/tools/testing/selftests/arm64/mte/Makefile
+++ b/tools/testing/selftests/arm64/mte/Makefile
@@ -32,5 +32,5 @@ endif
 include ../../lib.mk
 
 ifeq ($(mte_cc_support),1)
-$(TEST_GEN_PROGS): mte_common_util.c mte_common_util.h mte_helper.S
+$(TEST_GEN_PROGS): mte_common_util.c mte_helper.S
 endif
-- 
2.17.5

