Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C48676546
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 09:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjAUIyB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Jan 2023 03:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUIyA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Jan 2023 03:54:00 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FF1B65F17;
        Sat, 21 Jan 2023 00:53:59 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30L8rhrs011765;
        Sat, 21 Jan 2023 09:53:43 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/2] selftests/nolibc: support "x86_64" for arch name
Date:   Sat, 21 Jan 2023 09:53:19 +0100
Message-Id: <20230121085320.11712-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230121085320.11712-1-w@1wt.eu>
References: <20230121085320.11712-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Building the kernel with ARCH=x86_64 is perfectly supported, but the
nolibc-test only supports "x86", which causes errors when reusing
existing build environment. Let's permit it to be used as well.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 2bf613ee363d..423598045ff1 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -14,6 +14,7 @@ endif
 
 # kernel image names by architecture
 IMAGE_i386    = arch/x86/boot/bzImage
+IMAGE_x86_64  = arch/x86/boot/bzImage
 IMAGE_x86     = arch/x86/boot/bzImage
 IMAGE_arm64   = arch/arm64/boot/Image
 IMAGE_arm     = arch/arm/boot/zImage
@@ -25,6 +26,7 @@ IMAGE_NAME    = $(notdir $(IMAGE))
 
 # default kernel configurations that appear to be usable
 DEFCONFIG_i386    = defconfig
+DEFCONFIG_x86_64  = defconfig
 DEFCONFIG_x86     = defconfig
 DEFCONFIG_arm64   = defconfig
 DEFCONFIG_arm     = multi_v7_defconfig
@@ -38,6 +40,7 @@ TEST =
 
 # QEMU_ARCH: arch names used by qemu
 QEMU_ARCH_i386    = i386
+QEMU_ARCH_x86_64  = x86_64
 QEMU_ARCH_x86     = x86_64
 QEMU_ARCH_arm64   = aarch64
 QEMU_ARCH_arm     = arm
@@ -48,6 +51,7 @@ QEMU_ARCH         = $(QEMU_ARCH_$(ARCH))
 
 # QEMU_ARGS : some arch-specific args to pass to qemu
 QEMU_ARGS_i386    = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_x86_64  = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_x86     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm64   = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm     = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-- 
2.17.5

