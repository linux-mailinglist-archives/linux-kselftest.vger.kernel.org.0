Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903971C7296
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 May 2020 16:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgEFOSD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 May 2020 10:18:03 -0400
Received: from foss.arm.com ([217.140.110.172]:37484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbgEFOSD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 May 2020 10:18:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1715101E;
        Wed,  6 May 2020 07:18:02 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D27843F68F;
        Wed,  6 May 2020 07:18:01 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/5] kselftest: Enable vDSO test on non x86 platforms
Date:   Wed,  6 May 2020 15:17:27 +0100
Message-Id: <20200506141731.14660-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506141731.14660-1-vincenzo.frascino@arm.com>
References: <20200506141731.14660-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the vDSO tests are built only on x86 platforms and cannot be
cross compiled.

Enable vDSO TARGET for all the platforms.

Future patches will extend the tests.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 tools/testing/selftests/Makefile      | 1 +
 tools/testing/selftests/vDSO/Makefile | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2ff68702fd41..e135b03c3d66 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -61,6 +61,7 @@ endif
 TARGETS += tmpfs
 TARGETS += tpm2
 TARGETS += user
+TARGETS += vDSO
 TARGETS += vm
 TARGETS += x86
 TARGETS += zram
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 9e03d61f52fd..2989e4d5a730 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -9,7 +9,6 @@ ifeq ($(ARCH),x86)
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
 
-ifndef CROSS_COMPILE
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
 ifeq ($(CONFIG_X86_32),y)
@@ -23,4 +22,3 @@ $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 		vdso_standalone_test_x86.c parse_vdso.c \
 		-o $@
 
-endif
-- 
2.26.2

