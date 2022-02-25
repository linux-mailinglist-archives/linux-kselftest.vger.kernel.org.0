Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915B54C45B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 14:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiBYNQX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 08:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiBYNQW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 08:16:22 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A30D181E57;
        Fri, 25 Feb 2022 05:15:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 890461F45EAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645794948;
        bh=iANknHWAfv72XgX0hMtZ0uWhgfV7gO/pAWFzD/WhLYU=;
        h=From:To:Cc:Subject:Date:From;
        b=GsuTzxt3Rh3nRwaeDhRoTiUXBrE2X/C21+/Ig6m3l95ExxJ1r2LtLMaw+NBw/S0Vz
         qFcRQH9PtPo53Xi0OfZsJSlSLllgKpu1s4bMEK10MJr0NG/MFvp555CgFgdjyZZoXt
         djHBTh1aKRmco39uOL2eTOpY79T7X7x3S9qBw97rUuNnl4M33FzYJ1vZv1qvw8fNVw
         DbbjJVcH8iGjYn8QldDoATvRMdiiXxuzc2dm5sFW9nzU0qN3LMkEGie+xQAkslxhmK
         DCD/3GHdIhlwCNPPJbO88Q5FJWI4RvfTkVyMJvjDx3BBd54czneO147vWq4S5wbjUH
         GBuAUgqsR53OQ==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests, x86: fix how check_cc.sh is being invoked
Date:   Fri, 25 Feb 2022 13:15:43 +0000
Message-Id: <9320d88a3a65350d9bfdc5e258742cd0b162f017.1645794882.git.guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add quotes around $(CC) when calling check_cc.sh from a Makefile to
pass the value as a single argument to the script even if it has
several words such as "ccache gcc".  Conversely, remove quotes in
check_cc.sh when calling $CC to make it a command with potentially
several arguments again.

Fixes: e9886ace222e ("selftests, x86: Rework x86 target architecture detection")
Tested-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 tools/testing/selftests/vm/Makefile     | 6 +++---
 tools/testing/selftests/x86/Makefile    | 6 +++---
 tools/testing/selftests/x86/check_cc.sh | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 1607322a112c..d934f026ebb5 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -49,9 +49,9 @@ TEST_GEN_FILES += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
 
 ifeq ($(MACHINE),x86_64)
-CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_program.c -m32)
-CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_64bit_program.c)
-CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_program.c -no-pie)
+CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
+CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_program.c)
+CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_program.c -no-pie)
 
 TARGETS := protection_keys
 BINARIES_32 := $(TARGETS:%=%_32)
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 8a1f62ab3c8e..53df7d3893d3 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -6,9 +6,9 @@ include ../lib.mk
 .PHONY: all all_32 all_64 warn_32bit_failure clean
 
 UNAME_M := $(shell uname -m)
-CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
-CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
-CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
+CAN_BUILD_I386 := $(shell ./check_cc.sh "$(CC)" trivial_32bit_program.c -m32)
+CAN_BUILD_X86_64 := $(shell ./check_cc.sh "$(CC)" trivial_64bit_program.c)
+CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
diff --git a/tools/testing/selftests/x86/check_cc.sh b/tools/testing/selftests/x86/check_cc.sh
index 3e2089c8cf54..aff2c15018b5 100755
--- a/tools/testing/selftests/x86/check_cc.sh
+++ b/tools/testing/selftests/x86/check_cc.sh
@@ -7,7 +7,7 @@ CC="$1"
 TESTPROG="$2"
 shift 2
 
-if "$CC" -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
+if $CC -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
     echo 1
 else
     echo 0
-- 
2.30.2

