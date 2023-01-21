Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49A967654A
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 09:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjAUIyO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Jan 2023 03:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjAUIyI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Jan 2023 03:54:08 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCD616E0E2;
        Sat, 21 Jan 2023 00:54:06 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30L8rhCt011766;
        Sat, 21 Jan 2023 09:53:43 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2/2] selftests/nolibc: add a "run-user" target to test the program in user land
Date:   Sat, 21 Jan 2023 09:53:20 +0100
Message-Id: <20230121085320.11712-3-w@1wt.eu>
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

I found that when developing tests I'm not that often building kernels,
and instead I'm often using the much quicker QEMU Linux emulator instead
of the system emulator. It is sufficient to test startup code, stdlib
code and syscall calling convention. As such it is expected that other
users will value this, so let's add a "run-user" target that immediately
executes the prebuilt executable with the user's privilege (thus some
tests may fail due to insufficient permissions or missing features in
the local kernel).

Now running a userland test is as simple as issuing:

  make ARCH=xxx CROSS_COMPILE=xxx run-user

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 423598045ff1..8fe61d3e3cce 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -80,6 +80,7 @@ help:
 	@echo "  help         this help"
 	@echo "  sysroot      create the nolibc sysroot here (uses \$$ARCH)"
 	@echo "  nolibc-test  build the executable (uses \$$CC and \$$CROSS_COMPILE)"
+	@echo "  run-user     runs the executable under QEMU (uses \$$ARCH, \$$TEST)"
 	@echo "  initramfs    prepare the initramfs with nolibc-test"
 	@echo "  defconfig    create a fresh new default config (uses \$$ARCH)"
 	@echo "  kernel       (re)build the kernel with the initramfs (uses \$$ARCH)"
@@ -113,6 +114,11 @@ nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
 	  -nostdlib -static -Isysroot/$(ARCH)/include $< -lgcc
 
+# qemu user-land test
+run-user: nolibc-test
+	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
+	$(Q)grep -w FAIL "$(CURDIR)/run.out" && echo "See all results in $(CURDIR)/run.out" || echo "$$(grep -c ^[0-9].*OK $(CURDIR)/run.out) test(s) passed."
+
 initramfs: nolibc-test
 	$(QUIET_MKDIR)mkdir -p initramfs
 	$(call QUIET_INSTALL, initramfs/init)
-- 
2.17.5

