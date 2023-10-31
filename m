Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4407DD721
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 21:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjJaUhI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 16:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjJaUhG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 16:37:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B5CFE;
        Tue, 31 Oct 2023 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1698784621;
        bh=EnUH+FVtH/2LFDhbHmODszdfsWGWE/DcG346HqhXK2g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ILFzcJGCaPzR71nWlxIIPD1cs/We2OEt3ALO3BSVTtTWr1NTNNNy+kbFajQCMI0rl
         UF15W+0CBkN7+cnM5kKPHx5P2LpT9+waoCNmMjIiPA1ObsZCIp5EZVAISb71fAJuTp
         xD6mT5FVK/xv+w5le+r09255Ut6k1Vq+S1WHeUhk=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 31 Oct 2023 21:36:59 +0100
Subject: [PATCH 2/3] selftests/nolibc: anchor paths in $(srcdir) if
 possible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231031-nolibc-out-of-tree-v1-2-47c92f73590a@weissschuh.net>
References: <20231031-nolibc-out-of-tree-v1-0-47c92f73590a@weissschuh.net>
In-Reply-To: <20231031-nolibc-out-of-tree-v1-0-47c92f73590a@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698784620; l=1515;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EnUH+FVtH/2LFDhbHmODszdfsWGWE/DcG346HqhXK2g=;
 b=RyW5XWFgW1+NuFvftheWO5iwivD2gAnupVLHTHp8ifnMh4hICk7oPe+PXPm7mzSOXQmGA6qel
 RDDWr1IzXaRB4e+KhoiljXuY/mGYwi8aa8cQa/37gAFhDwayUvEqas3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It is easier to recognize paths from their well-known location in the
source tree than having to resolve the relative path in ones head.

Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index eb258ae1d948..b1129be98376 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -174,7 +174,7 @@ sysroot: sysroot/$(ARCH)/include
 sysroot/$(ARCH)/include:
 	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
 	$(QUIET_MKDIR)mkdir -p sysroot
-	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
+	$(Q)$(MAKE) -C $(srctree)/tools/include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
 	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
 
 ifneq ($(NOLIBC_SYSROOT),0)
@@ -184,7 +184,7 @@ nolibc-test: nolibc-test.c nolibc-test-linkage.c sysroot/$(ARCH)/include
 else
 nolibc-test: nolibc-test.c nolibc-test-linkage.c
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
-	  -nostdlib -static -include ../../../include/nolibc/nolibc.h nolibc-test.c nolibc-test-linkage.c -lgcc
+	  -nostdlib -static -include $(srctree)/tools/include/nolibc/nolibc.h nolibc-test.c nolibc-test-linkage.c -lgcc
 endif
 
 libc-test: nolibc-test.c nolibc-test-linkage.c

-- 
2.42.0

