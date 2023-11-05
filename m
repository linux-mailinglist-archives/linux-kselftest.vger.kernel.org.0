Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C7B7E1321
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 12:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjKELfK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 06:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKELfJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 06:35:09 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEC2F2;
        Sun,  5 Nov 2023 03:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699184103;
        bh=nyrjPvpNj7WNK2ijhv221XrS7R5GMOB+fysjKb+NE6o=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=msFqDpcXSSjuZeof1fOOu4F3KvdFjPlRQWnmsbkx5IncwISbVjpvwj1+4HSuM14NX
         mpPaEfVWolk/aS1Vg1HWeHSomdt/kCxJL9Oe/EC8g0GVQ+cSdnRImwt7jO4a+NJHT0
         QsaOO4ZajOXcaaF3oKamxoRIjWA3iE2L8ukPUUPk=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 05 Nov 2023 12:35:02 +0100
Subject: [PATCH v2 5/6] selftests/nolibc: extraconfig support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231105-nolibc-mips-be-v2-5-4ec993cb5407@weissschuh.net>
References: <20231105-nolibc-mips-be-v2-0-4ec993cb5407@weissschuh.net>
In-Reply-To: <20231105-nolibc-mips-be-v2-0-4ec993cb5407@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699184102; l=1285;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=nyrjPvpNj7WNK2ijhv221XrS7R5GMOB+fysjKb+NE6o=;
 b=pMFDcAOHYf4oHIZkEkSHQT55uQDBq91NgSrk1f7kzN2JjkQ9CLhIP4kxLS0KgKkI32bVdqLIH
 2KcXs4Yuyf3DEiRrfyVY62+QU7RUH9pQxmmtF8Ce1pAS4EZ0OTMGa1l
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allow some postprocessing of defconfig files.

Suggested-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 6a5e67f65daa..6a1f7f9edf91 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -81,6 +81,8 @@ DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
+EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
+
 # optional tests to run (default = all)
 TEST =
 
@@ -227,6 +229,10 @@ initramfs: nolibc-test
 
 defconfig:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
+	$(Q)if [ -n "$(EXTRACONFIG)" ]; then \
+		$(srctree)/scripts/config --file $(objtree)/.config $(EXTRACONFIG); \
+		$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) olddefconfig < /dev/null; \
+	fi
 
 kernel:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME)

-- 
2.42.1

