Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D95D70EE64
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 08:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbjEXGqr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 02:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239057AbjEXGpw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 02:45:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CB7E64;
        Tue, 23 May 2023 23:44:52 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684910689;
        bh=FYAqrmQ0bmlPcw1wkxP32NPCjnUQYdlgK0CFzZKmxlk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=DZJdKNn9Ap7NKATrnMB39AQGUg9zX6xro+uRCY8RdTJX+olz5nKfWAOAIHk6Yvqxm
         d8+u+xaNV56WUeZI2Ns7KZ0bRX6WE3lTf0N2QYCrfwegZ2nAOL0WwCYgVKraCTMPHn
         ITsP6s+8sxs2fwvIU1K629WJOs+m0sTKWPWuF3Gk=
Date:   Wed, 24 May 2023 08:44:42 +0200
Subject: [PATCH 1/3] Revert "EXP: tools/nolibc: partially revert
 stackprotector compiler flags"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230523-nolibc-stackprotector-gcc9-v1-1-3e4804235d50@weissschuh.net>
References: <20230523-nolibc-stackprotector-gcc9-v1-0-3e4804235d50@weissschuh.net>
In-Reply-To: <20230523-nolibc-stackprotector-gcc9-v1-0-3e4804235d50@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684910688; l=1431;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FYAqrmQ0bmlPcw1wkxP32NPCjnUQYdlgK0CFzZKmxlk=;
 b=VxjyolajHhh+l1qIIIRuw/r3vGErBeQ5q/uMj5L4M0mHrxf+5NdxV0wVJ/cLQ1SGtSV0M76Id
 G4gwjSfGK69A6sv4PcCPIem1QPvHv/uvxe53fin25F1/KGPhA3vHx3g
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This reverts commit 8213b0cdb51d1f66af713e00fd0dff3c2eb47636.

A nicer solution for the same problem is implemented later in this series.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index e479e9fec5f8..882ba6a33dbb 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -76,20 +76,11 @@ else
 Q=@
 endif
 
-CFLAGS_STACKPROTECTOR = $(call cc-option,-mstack-protector-guard=global) \
-			$(call cc-option,-fstack-protector-all)
-CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_arm64 = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_arm = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_mips = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_riscv = $(CFLAGS_STACKPROTECTOR)
-CFLAGS_STKP_loongarch = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_s390 = -m64
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(call cc-option,-fno-stack-protector) \
-		$(CFLAGS_STKP_$(ARCH)) $(CFLAGS_$(ARCH))
+		$(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all)) \
+		$(CFLAGS_$(ARCH))
 LDFLAGS := -s
 
 help:

-- 
2.40.1

