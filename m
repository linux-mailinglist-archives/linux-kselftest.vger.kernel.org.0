Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039237BFB8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjJJMeX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 08:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjJJMeU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 08:34:20 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3727310C;
        Tue, 10 Oct 2023 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696941246;
        bh=itCOy/n/isHYcQulK5emf3FoLnD4SemWjOxOW/MPxRU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cFd0HdMoqAGecyLpraySfzYGr81X8M9XAdG8/b2/LiqZQyHu/7QsZQ8ET5a3nVkgZ
         6QgRnssxfnhVUh0zzE6GweAt8SXRQO1vtH9Hw9LtGsL1XKlkRSRPFNQcOSxbqi99jZ
         YTpdmdeQK5MQksUv/baRtd2BraVENnyBcd84/mH0=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 10 Oct 2023 14:34:00 +0200
Subject: [PATCH 5/5] selftests/nolibc: generate config automatically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231010-nolibc-out-of-tree-v1-5-b6a263859596@weissschuh.net>
References: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
In-Reply-To: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696941244; l=1742;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=itCOy/n/isHYcQulK5emf3FoLnD4SemWjOxOW/MPxRU=;
 b=FZZ9E3TluP14IhqlqbPbtRKKsEauXukQv98Yt6wYhopJ6+aRz22BRfiyu+SEtUioUGvNvBZen
 sJzKTnj2q8jCBaMkfPEKO/yzZN3Yn+fUb3FskXxux3tYKjmUAjq9frV
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This new target generates a .config if none exists yet.

Also drop the defconfig target with its hidden call to 'mrproper' which
is fairly invasive.
If users want to overwrite their kernel existing kernel configuration
they can do so easily from the toplevel directory.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 21e3f7da2ecf..5a3623680f1a 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -173,7 +173,7 @@ all: run
 
 sysroot: sysroot/$(ARCH)/include
 
-sysroot/$(ARCH)/include:
+sysroot/$(ARCH)/include: $(objtree)/.config
 	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
 	$(QUIET_MKDIR)mkdir -p sysroot
 	$(Q)$(MAKE) -C $(srctree) outputmakefile
@@ -216,13 +216,13 @@ initramfs: nolibc-test
 	$(call QUIET_INSTALL, initramfs/init)
 	$(Q)cp nolibc-test initramfs/init
 
-defconfig:
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
+$(objtree)/.config:
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(DEFCONFIG)
 
-kernel:
+kernel: $(objtree)/.config
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME)
 
-kernel-standalone: initramfs
+kernel-standalone: $(objtree)/.config initramfs
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
 # run the tests after building the kernel

-- 
2.42.0

