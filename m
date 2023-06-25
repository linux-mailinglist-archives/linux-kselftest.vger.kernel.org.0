Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008D773D1F8
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjFYQMX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFYQMW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:12:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2791D18D;
        Sun, 25 Jun 2023 09:12:20 -0700 (PDT)
X-QQ-mid: bizesmtp85t1687709530tsvfo8pm
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:12:09 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: XBN7tc9DADJ/OcMdENJaOzWBkZLGnIpxol5HU5eHhMJPihloFMK4nV8tycOqP
        HcFbWitRT8ddnSgIxB4OEtcz18ioeAnXfZ/MrBw4IpHZfmtCgWRpTgqxkPqh0g72G187XBG
        FBxsQ2+M1egZBKQKwY+g8lqoc/5WHoHP2t7aZUQuOLiB643WygQ27rWCZ6T/8cgN29l5DaG
        EcF9AjMPzwmnUmCEc0CulnMK1nfUeR+Bp7UMx8LCV5GJcYxQ/P5TzVexQWbEERiTWMbyDm5
        P9yDZVUU3EoY3HD1BSRnFTFnBLHyPyunUd3s1RkxhHMPz/U5jCHY27tlTa9cA5pNbdN4z9U
        +iX6V2Hsgg+we5SNg2ilRyctvtMS61cx8HrbAIJ+kGfYUsx4cg=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15070065792118708961
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 01/22] selftests/nolibc: add test for -include /path/to/nolibc.h
Date:   Mon, 26 Jun 2023 00:12:00 +0800
Message-Id: <149d51ee77cdd4936de4a02ee8b2cff239fd8253.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As the head comment of nolibc-test.c shows, it can be built in 3 ways:

  The program may be built in 3 ways:
    $(CC) -nostdlib -include /path/to/nolibc.h => NOLIBC already defined
    $(CC) -nostdlib -I/path/to/nolibc/sysroot  => _NOLIBC_* guards are present
    $(CC) with default libc                    => NOLIBC* never defined

Only last two of them are tested currently, let's allow test the first one too.

This may help to find issues about using nolibc.h to build programs. it
derives from this change:

    commit 3a8039e289a3 ("tools/nolibc: Fix build of stdio.h due to header ordering")

Usage:

    // test with sysroot
    $ make run-user SYSROOT=1

    // test without sysroot, using nolibc.h directly
    $ make run-user SYSROOT=0

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 848884204a84..0b66b7a79cea 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -102,6 +102,9 @@ REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++;print} /\[SKIPPED\][\
 		END{ printf("%d test(s) passed, %d skipped, %d failed.\n", p, s, f); \
 		printf("See all results in %s\n", ARGV[1]); }'
 
+# allow switch nolibc headers include method: 1 for sysroot, 0 for nolibc.h
+SYSROOT ?= 1
+
 help:
 	@echo "Supported targets under selftests/nolibc:"
 	@echo "  all          call the \"run\" target below"
@@ -139,9 +142,15 @@ sysroot/$(ARCH)/include:
 	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
 	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
 
+ifeq ($(SYSROOT), 1)
 nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
 	  -nostdlib -static -Isysroot/$(ARCH)/include $< -lgcc
+else
+nolibc-test: nolibc-test.c
+	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
+	  -nostdlib -static -include ../../../include/nolibc/nolibc.h $< -lgcc
+endif
 
 libc-test: nolibc-test.c
 	$(QUIET_CC)$(CC) -o $@ $<
-- 
2.25.1

