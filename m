Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B337E1322
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 12:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjKELfL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 06:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKELfJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 06:35:09 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC6DFA;
        Sun,  5 Nov 2023 03:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699184102;
        bh=a+9ND8eF9nLxQ/1grgp4DdoijTDtNpAFxfKUQan+h7M=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ve2zD0Vq063PtHS4Lxh8WD9DDxhauFe4gHtNgrPbeBRPljXDqfv9QoEwCmNhDHS5G
         lK+C2gEE8yzKYMICNcftDE47lMiW6NgIo7LWWV3anX8+XsFPaz8Sp1XhSo9XZsdW1H
         ii5nZg6Avq/KlnIbXcQNrDtFPCCNW2vdI4iLK6GI=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 05 Nov 2023 12:34:59 +0100
Subject: [PATCH v2 2/6] tools/nolibc: move MIPS ABI validation into
 arch-mips.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231105-nolibc-mips-be-v2-2-4ec993cb5407@weissschuh.net>
References: <20231105-nolibc-mips-be-v2-0-4ec993cb5407@weissschuh.net>
In-Reply-To: <20231105-nolibc-mips-be-v2-0-4ec993cb5407@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699184102; l=1437;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=a+9ND8eF9nLxQ/1grgp4DdoijTDtNpAFxfKUQan+h7M=;
 b=eJbW210gN9ZiHm9562zmKqj43K5z7WF41/80UWLA634WixdMeLP8a2IsPlrCKGle0tYPZ1JqO
 GdIZVn6/JIlCIdaJL0d032Me/fqn7ESrBaPMTAywCsnqJU/ue/4XLzz
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

When installing nolibc to a sysroot arch.h is not used so its ABI check
is bypassed. This makes is possible to compile nolibc with a non O32 ABI
which may build but can not run.

Move the check into arch-mips.h so it will always be evaluated.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-mips.h | 4 ++++
 tools/include/nolibc/arch.h      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 4ab6fa54beee..3a2c76716b83 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -10,6 +10,10 @@
 #include "compiler.h"
 #include "crt.h"
 
+#if !defined(_ABIO32)
+#error Unsupported MIPS ABI
+#endif
+
 /* Syscalls for MIPS ABI O32 :
  *   - WARNING! there's always a delayed slot!
  *   - WARNING again, the syntax is different, registers take a '$' and numbers
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 2f72ccac0378..c8f4e5d3add9 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -23,7 +23,7 @@
 #include "arch-arm.h"
 #elif defined(__aarch64__)
 #include "arch-aarch64.h"
-#elif defined(__mips__) && defined(_ABIO32)
+#elif defined(__mips__)
 #include "arch-mips.h"
 #elif defined(__powerpc__)
 #include "arch-powerpc.h"

-- 
2.42.1

