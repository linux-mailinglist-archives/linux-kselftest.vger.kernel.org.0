Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2A176BDED
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 21:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjHATja (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 15:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjHATj3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 15:39:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5348619A8;
        Tue,  1 Aug 2023 12:39:27 -0700 (PDT)
X-QQ-mid: bizesmtp82t1690918758tdq8mq9o
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 03:39:17 +0800 (CST)
X-QQ-SSF: 01200000002000E0X000B00A0000000
X-QQ-FEAT: D6RqbDSxuq47V5/O0pbAo//GjZY8tPkJDPm56ilbwVbuqUTvdeK45RzFqkM0Q
        KlzUVm0mvSANRZiFY/pk4AgC+392xKcWobxCOHq4xZhdAAEUHx/8H2B5+QowAaGRVrSdSJy
        T0IquIBWkJt2/dEwnf45XnkSFdVuNF1Wx2m9wreliQcI1wxdRr9N+1VbIyPtxPW3CyU3bCz
        /L/MA/eRdzdfS80LJhaaD/KNQTm+8CXjsL5V9SfQxMT5CHfSKOuBbCOVzSx4UG+Sidq/DIM
        q6gcP7jOJpKQIztrGBwt57kvX4S3PXduASWn2IK2zi5BVIO4xH9BIBVGyhi/9OAAr60hJEK
        qT4friMz9RjQbyxiovCRW/dstWz3sMr5XJNUnntWjuZwx96UBeVDEfplylR6CizeVU1KpE9
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6478331743894401545
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: [PATCH v4 03/12] selftests/nolibc: fix up O= option support
Date:   Wed,  2 Aug 2023 03:39:17 +0800
Message-Id: <3daf2650a61e4605d68d5982ebd32e1edb7e6782.1690916314.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690916314.git.falcon@tinylab.org>
References: <cover.1690916314.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To avoid pollute the source code tree and avoid mrproper for every
architecture switch, the O= argument must be supported.

Both IMAGE and .config are from the building directory, let's use
objtree instead of srctree for them.

If no O= option specified, means building kernel in source code tree,
objtree should be srctree in such case.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/ZK0AB1OXH1s2xYsh@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index f42adef87e12..f0bda0d28000 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -9,6 +9,9 @@ ifeq ($(srctree),)
 srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
 endif
 
+# add objtree for O= argument, required by IMAGE and .config
+objtree ?= $(srctree)
+
 ifeq ($(ARCH),)
 include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
@@ -167,12 +170,12 @@ kernel: initramfs
 
 # run the tests after building the kernel
 run: kernel
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 clean:
-- 
2.25.1

