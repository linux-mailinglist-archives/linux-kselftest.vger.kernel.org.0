Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6387E5C89
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 18:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjKHRkJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 12:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKHRkI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 12:40:08 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B50F199;
        Wed,  8 Nov 2023 09:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699465203;
        bh=tiJ2JW2vQSAVtrjfe1rVfr6WSRjf+WLHWHD+0FEQ1ao=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uYdGP+eXcfxfrE2KHIdruvOGEPrt1GzfgH5IpaVk6yTd4v4tdvKQ2ayjtQdrzUd4g
         g2hmIqhF0HkijSiFZLvOHYcCCRp5dYsVo+AfnmG5xSIwF5C2HhNjLd8lWfj9xlFdOL
         xllWEA6wgfKn9hH86avlVAvwZ4AQPeyzaEb1FwXI=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 15 Sep 2077 02:13:52 +0200
Subject: [PATCH 1/2] selftests/nolibc: introduce QEMU_ARCH_USER
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20770915-nolibc-run-user-v1-1-3caec61726dc@weissschuh.net>
References: <20770915-nolibc-run-user-v1-0-3caec61726dc@weissschuh.net>
In-Reply-To: <20770915-nolibc-run-user-v1-0-3caec61726dc@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=3398890432; l=1348;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tiJ2JW2vQSAVtrjfe1rVfr6WSRjf+WLHWHD+0FEQ1ao=;
 b=tFbY13AASe4iUbNe8F6FfUWoaOi3NOeLIFYlxn7lHFwI9In7TA6azw6dVXrTT7DhGesHOAOdT
 3kSnoLAx+HiA3B+FmiAzOic7aCJnBUWrEh/5muayr0yh7R3OLR9g7VH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While ppc64le shares the same executable with regular ppc64 the user
variant needs has a dedicated executable.
Introduce a new QEMU_ARCH_USER Makefile variable to accommodate that.

Fixes: 17362f3d0bd3 ("selftests/nolibc: use qemu-system-ppc64 for ppc64le")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 508435b8ac2a..501bd41e0830 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -106,6 +106,9 @@ QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
+QEMU_ARCH_USER_ppc64le = ppc64le
+QEMU_ARCH_USER         = $(or $(QEMU_ARCH_USER_$(XARCH)),$(QEMU_ARCH_$(XARCH)))
+
 QEMU_BIOS_DIR = /usr/share/edk2/
 QEMU_BIOS_loongarch = $(QEMU_BIOS_DIR)/loongarch64/OVMF_CODE.fd
 
@@ -223,7 +226,7 @@ run-nolibc-test: nolibc-test
 
 # qemu user-land test
 run-user: nolibc-test
-	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
+	$(Q)qemu-$(QEMU_ARCH_USER) ./nolibc-test > "$(CURDIR)/run.out" || :
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 initramfs.cpio: kernel nolibc-test

-- 
2.42.1

