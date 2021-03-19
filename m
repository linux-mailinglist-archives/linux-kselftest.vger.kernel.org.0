Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD14B342290
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhCSQyI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 12:54:08 -0400
Received: from foss.arm.com ([217.140.110.172]:56868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230105AbhCSQxy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 12:53:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 503D21063;
        Fri, 19 Mar 2021 09:53:54 -0700 (PDT)
Received: from e104803-lin.cambridge.arm.com (e104803-lin.cambridge.arm.com [10.1.197.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19B953F70D;
        Fri, 19 Mar 2021 09:53:52 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 08/11] kselftest/arm64: mte: Output warning about failing compiler
Date:   Fri, 19 Mar 2021 16:53:31 +0000
Message-Id: <20210319165334.29213-9-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20210319165334.29213-1-andre.przywara@arm.com>
References: <20210319165334.29213-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

At the moment we check the compiler's ability to compile MTE enabled
code, but guard all the Makefile rules by it. As a consequence a broken
or not capable compiler just doesn't do anything, and make happily
returns without any error message, but with no programs created.

Since the MTE feature is only supported by recent aarch64 compilers (not
all stable distro compilers support it), having an explicit message
seems like a good idea. To not break building multiple targets, we let
make proceed without errors.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/mte/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/arm64/mte/Makefile b/tools/testing/selftests/arm64/mte/Makefile
index fa282e5f2069..e0d43cea3cd1 100644
--- a/tools/testing/selftests/arm64/mte/Makefile
+++ b/tools/testing/selftests/arm64/mte/Makefile
@@ -23,6 +23,9 @@ TEST_GEN_PROGS := $(PROGS)
 
 # Get Kernel headers installed and use them.
 KSFT_KHDR_INSTALL := 1
+else
+    $(warning compiler "$(CC)" does not support the ARMv8.5 MTE extension.)
+    $(warning test program "mte" will not be created.)
 endif
 
 # Include KSFT lib.mk.
-- 
2.17.5

