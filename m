Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED2F1913A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgCXOvi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Mar 2020 10:51:38 -0400
Received: from foss.arm.com ([217.140.110.172]:36574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgCXOvi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Mar 2020 10:51:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74E12FEC;
        Tue, 24 Mar 2020 07:51:37 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FB703F52E;
        Tue, 24 Mar 2020 07:51:36 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/3] kselftest: Enable vDSO test on non x86 platforms
Date:   Tue, 24 Mar 2020 14:51:18 +0000
Message-Id: <20200324145120.42194-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324145120.42194-1-vincenzo.frascino@arm.com>
References: <20200324145120.42194-1-vincenzo.frascino@arm.com>
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
index 6ec503912bea..20aa4c68b88c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -60,6 +60,7 @@ endif
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
2.25.2

