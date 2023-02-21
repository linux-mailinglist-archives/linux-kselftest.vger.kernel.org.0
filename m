Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE65B69E656
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 18:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjBURvA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 12:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjBURu7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 12:50:59 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6917C2F79F;
        Tue, 21 Feb 2023 09:50:51 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1677001849;
        bh=qYdc7DlpEpf8tCeieSL3/L60TRqR0O1xN25nKYNUnoU=;
        h=From:Date:Subject:To:Cc:From;
        b=FjlUiy7Izav64r1ZX6b3DBb6CsEBVCzdymQJPcC5SQzAfwalmmFGneNHF8VqsZ0Oh
         a9xIeaL4s/SM0GzBwmEZWehorIos5Pvd2V7K9Tp6IhtMDAMA9sXRIgNR1+eJa9eLK7
         Z1aAI5kouNbg/dM32Qq5+J8A1+ffrSNfQU00hnVI=
Date:   Tue, 21 Feb 2023 17:50:41 +0000
Subject: [PATCH] tools/nolibc: always disable stack protector for tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230221-nolibc-no-stack-protector-v1-1-4e6a42f969e2@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAHAE9WMC/x2NwQrCQAxEf6XkbKC7th78FfGwm0YbXLIlu4pQ+
 u8GT8MbeDM7NDbhBtdhB+OPNKnqEE4D0Jr0ySiLM8QxnscYA2otkskDW0/0ws1qZ+rVcM7ztMT
 ME10CuJ9TY8yWlFZf0HcpXm7GD/n+D2/34/gB+jEODYAAAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677001846; l=2095;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qYdc7DlpEpf8tCeieSL3/L60TRqR0O1xN25nKYNUnoU=;
 b=9M4HAx084LW48vqDyzoUw9mHD/nV2nkd9lwSpHPxjWEKpEPhW1szbdgG8wcZKb8cS9UUc4Fx3
 tcOJrqgoL2VA60v7Fip16dR0bPuMCy30H5qYM0bPKTHy9EANsU8nqH/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Stack protectors need support from libc.
This support is not provided by nolibc which leads to compiler errors
when stack protectors are enabled by default in a compiler:

      CC      nolibc-test
    /usr/bin/ld: /tmp/ccqbHEPk.o: in function `stat':
    nolibc-test.c:(.text+0x1d1): undefined reference to `__stack_chk_fail'
    /usr/bin/ld: /tmp/ccqbHEPk.o: in function `poll.constprop.0':
    nolibc-test.c:(.text+0x37b): undefined reference to `__stack_chk_fail'
    /usr/bin/ld: /tmp/ccqbHEPk.o: in function `vfprintf.constprop.0':
    nolibc-test.c:(.text+0x712): undefined reference to `__stack_chk_fail'
    /usr/bin/ld: /tmp/ccqbHEPk.o: in function `pad_spc.constprop.0':
    nolibc-test.c:(.text+0x80d): undefined reference to `__stack_chk_fail'
    /usr/bin/ld: /tmp/ccqbHEPk.o: in function `printf':
    nolibc-test.c:(.text+0x8c4): undefined reference to `__stack_chk_fail'
    /usr/bin/ld: /tmp/ccqbHEPk.o:nolibc-test.c:(.text+0x12d4): more undefined references to `__stack_chk_fail' follow
    collect2: error: ld returned 1 exit status

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 22f1e1d73fa8..ec724e445b5a 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for nolibc tests
 include ../../../scripts/Makefile.include
+# We need this for the "cc-option" macro.
+include ../../../build/Build.include
 
 # we're in ".../tools/testing/selftests/nolibc"
 ifeq ($(srctree),)
@@ -63,6 +65,7 @@ Q=@
 endif
 
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables
+CFLAGS  += $(call cc-option,-fno-stack-protector)
 LDFLAGS := -s
 
 help:

---
base-commit: 3f0b0903fde584a7398f82fc00bf4f8138610b87
change-id: 20230221-nolibc-no-stack-protector-5b54d2be4c61

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

