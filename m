Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E131C5F4F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 May 2020 19:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgEERvW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 May 2020 13:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbgEERvV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 May 2020 13:51:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9051A206FA;
        Tue,  5 May 2020 17:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588701081;
        bh=4iCCz19po9xgnLGsbZnbbWXeps6ukThnpnJYA9jeKPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJ/VcOUCIJfX+BUwHbijJnLiCujUrbfBc5r8+0MDLCfUSj+at6zWwbzG1GLGo7hkf
         TIcUXuz6Fesz6iq5A2Hvcc6G92+yqeRGTIWprUX2J2gMrOa1wEi/h98lNskF0h+PHd
         /+e+bD2uy2/hw26OJTeeKVDTvY3g2SykpMfKCAYE=
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] selftests: vdso: Rename vdso_test to vdso_test_gettimeofday
Date:   Tue,  5 May 2020 18:47:26 +0100
Message-Id: <20200505174728.46594-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200505174728.46594-1-broonie@kernel.org>
References: <20200505174728.46594-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the vDSO kselftests have a test called vdso_test which tests
the vDSO implementation of gettimeofday(). In preparation for adding
tests for other vDSO functionality rename this test to reflect what's
going on.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/vDSO/.gitignore                      | 1 +
 tools/testing/selftests/vDSO/Makefile                        | 4 ++--
 .../selftests/vDSO/{vdso_test.c => vdso_test_gettimeofday.c} | 5 +++--
 3 files changed, 6 insertions(+), 4 deletions(-)
 rename tools/testing/selftests/vDSO/{vdso_test.c => vdso_test_gettimeofday.c} (89%)

diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftests/vDSO/.gitignore
index 382cfb39a1a3..74f49bd5f6dd 100644
--- a/tools/testing/selftests/vDSO/.gitignore
+++ b/tools/testing/selftests/vDSO/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 vdso_test
+vdso_test_gettimeofday
 vdso_standalone_test_x86
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 9e03d61f52fd..ae15d700b62e 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -4,7 +4,7 @@ include ../lib.mk
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-TEST_GEN_PROGS := $(OUTPUT)/vdso_test
+TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday
 ifeq ($(ARCH),x86)
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
@@ -17,7 +17,7 @@ LDLIBS += -lgcc_s
 endif
 
 all: $(TEST_GEN_PROGS)
-$(OUTPUT)/vdso_test: parse_vdso.c vdso_test.c
+$(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
diff --git a/tools/testing/selftests/vDSO/vdso_test.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
similarity index 89%
rename from tools/testing/selftests/vDSO/vdso_test.c
rename to tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index 719d5a6bd664..511c0dc5e47e 100644
--- a/tools/testing/selftests/vDSO/vdso_test.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * vdso_test.c: Sample code to test parse_vdso.c
+ * vdso_test_gettimeofday.c: Sample code to test parse_vdso.c and
+ *                           vDSO gettimeofday()
  * Copyright (c) 2014 Andy Lutomirski
  *
  * Compile with:
- * gcc -std=gnu99 vdso_test.c parse_vdso.c
+ * gcc -std=gnu99 vdso_test_gettimeofday.c parse_vdso_gettimeofday.c
  *
  * Tested on x86, 32-bit and 64-bit.  It may work on other architectures, too.
  */
-- 
2.20.1

