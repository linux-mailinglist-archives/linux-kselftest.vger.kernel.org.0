Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146EB7E12F6
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 11:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjKEKKY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 05:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjKEKKO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 05:10:14 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42FEE1;
        Sun,  5 Nov 2023 02:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699179007;
        bh=RD5TMEI3DvwFGeIbn1MxJkvOuIwUyEIM6E3CWF7zhCs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VtgoQbRnbg7D8L2jVsJ2VecXPhIGoIIKbYqEBqrMu291UT2sypuZRsKBJ0S5TcIEQ
         0tKHPwnvYncCFiBdEZTT4zkbS6W6ML6EsfgkQ3Ab3Z7E2vFpi0j6TLI/FzAV5VFMDU
         Xz0faz8nAmtwBW7s4R9dkSoaSe7eJ6YIbILtC1kQ=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 05 Nov 2023 11:09:59 +0100
Subject: [PATCH 5/6] selftests/nolibc: extraconfig support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231105-nolibc-mips-be-v1-5-6c2ad3e50a1f@weissschuh.net>
References: <20231105-nolibc-mips-be-v1-0-6c2ad3e50a1f@weissschuh.net>
In-Reply-To: <20231105-nolibc-mips-be-v1-0-6c2ad3e50a1f@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699179006; l=1246;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=RD5TMEI3DvwFGeIbn1MxJkvOuIwUyEIM6E3CWF7zhCs=;
 b=0Y1uz+HV+6jCTVNSi04qksfUleoSSIvQ4s7H43s39ob3QPfiK8IgTixMIgyc1j/WUqJz2uUpN
 FEclfzFdc/vCgoHSMJtfS1viqNFRmA3VaBf4Gc9/z8y631aS6EomftV
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
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index f8fea9fa0263..02c074e73a28 100644
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
+		$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) oldconfig < /dev/null; \
+	fi
 
 kernel:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME)

-- 
2.42.1

