Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462037BFB89
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjJJMeV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 08:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjJJMeR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 08:34:17 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6EF11C;
        Tue, 10 Oct 2023 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696941245;
        bh=hixffEo6Od5BKvLAa5YL7lg4UjAnDYgxCrpKJ2QsowA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lx3KNP+OrSMDesEOP/6O8tZLVwMGi+QevwDFDT3qHF8IG2SUsmA2KIGHH73jpOzLf
         npr7PcECkFSkT4sYG6x2UbQQny2sDepg6BCl/QEfgYdb06yRzINCiA7EU/VCjHj0S1
         kbLHyuDcldSRxw8ayz5FWXyGMzlY6DLizCvmnE+o=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 10 Oct 2023 14:33:58 +0200
Subject: [PATCH 3/5] selftests/nolibc: anchor paths in $(srcdir) if
 possible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231010-nolibc-out-of-tree-v1-3-b6a263859596@weissschuh.net>
References: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
In-Reply-To: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696941244; l=1347;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hixffEo6Od5BKvLAa5YL7lg4UjAnDYgxCrpKJ2QsowA=;
 b=Yeyu0n2VOJ82yYaeMfS6OUy6louhOtnaeMYZ7aWmOmVdzx6zfBp8W8AkTzKCUwHkpvTQRI4No
 78YKz0kxgnBBHULSkIKMMgOCz9Uy3ABmI7jRCvB1TI1l3xqRlPyv6Mn
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

It is easier to recognize paths from their well-known location in the
source tree than having to resolve the relative path in ones head.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 258293639572..598d53c5cb7b 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -167,7 +167,7 @@ sysroot: sysroot/$(ARCH)/include
 sysroot/$(ARCH)/include:
 	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
 	$(QUIET_MKDIR)mkdir -p sysroot
-	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
+	$(Q)$(MAKE) -C $(srctree)/tools/include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
 	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
 
 ifneq ($(NOLIBC_SYSROOT),0)
@@ -177,7 +177,7 @@ nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
 else
 nolibc-test: nolibc-test.c
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
-	  -nostdlib -static -include ../../../include/nolibc/nolibc.h $< -lgcc
+	  -nostdlib -static -include $(srctree)/tools/include/nolibc/nolibc.h $< -lgcc
 endif
 
 libc-test: nolibc-test.c

-- 
2.42.0

