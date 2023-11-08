Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF527E5CFD
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 19:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjKHSO7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 13:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjKHSO7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 13:14:59 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C5B1FEE;
        Wed,  8 Nov 2023 10:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699467295;
        bh=BwZjAK9qEtDtquMpNAzCqMoIeUdxSwsVoif00t8/fG0=;
        h=From:Date:Subject:To:Cc:From;
        b=stTvblAtssYrgSehAYvzjjGwocbrT13FfDCn2Z6Ycic6PkW++ZXYbikwU67CxzJ9C
         NFHm2gE0dUOIR+3a9O+hKImJBKcbPvfWW63uAvNpaDGDzBzAdlmcrFkOx4vHy7VtXT
         Jy6uyMZ1CP0c2y3QAFRROs3rDCjP8hAtNEvq7cQM=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 08 Nov 2023 19:14:43 +0100
Subject: [PATCH v2] tools/nolibc: mips: add support for PIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231108-nolibc-pic-v2-1-4fb0d6284757@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABLQS2UC/03Myw6CMBCF4Vchs7ZmelGEle9hWEAZ7CSmkA6ih
 vDuVlYu/5OcbwWhxCRQFyskWlh4jDnMoQAf2ngnxX1uMFiWWGmn4vjgzquJvbKIzg5Dhw4t5MO
 UaOD3jt2a3IFlHtNntxf9WzNjrNZ4+WcWrbSqurJ1pupP7bm/vohFxIdnOEaaodm27QvZSD9Jq
 QAAAA==
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699467293; l=2546;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BwZjAK9qEtDtquMpNAzCqMoIeUdxSwsVoif00t8/fG0=;
 b=/2x+alqOzCUKEQdtzFYWNM/8F+3apyB7ma/lHuuYrz7usvWzgNEaTpwBX0e9Y2HEyWJnRfgO5
 qxmOJz5CbrJCWz9TTeHE0EjVYklXN9KaqfMUFLQkGoYnl9BBNxSHBfW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

MIPS requires some extra instructions to set up the $gp register for the
with a pointer to the global data area.

This isn't needed for non-PIC builds, but this patch enables the code
unconditionally to prevent bitrot.

Also enable PIC in one of the test configurations for ongoing
validation.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Preserver 8-byte alignment of stack pointer
- Link to v1: https://lore.kernel.org/r/20231108-nolibc-pic-v1-1-9b7a429d5a6d@weissschuh.net
---
 tools/include/nolibc/arch-mips.h        | 7 ++++++-
 tools/testing/selftests/nolibc/Makefile | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 3a2c76716b83..62cc50ef3288 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -184,8 +184,13 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 	__asm__ volatile (
 		".set push\n"
 		".set noreorder\n"
-		".option pic0\n"
+		"bal 1f\n"               /* prime $ra for .cpload                            */
+		"nop\n"
+		"1:\n"
+		".cpload $ra\n"
 		"move  $a0, $sp\n"       /* save stack pointer to $a0, as arg1 of _start_c */
+		"addiu $sp, $sp, -4\n"   /* space for .cprestore to store $gp              */
+		".cprestore 0\n"
 		"li    $t0, -8\n"
 		"and   $sp, $sp, $t0\n"  /* $sp must be 8-byte aligned                     */
 		"addiu $sp, $sp, -16\n"  /* the callee expects to save a0..a3 there        */
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 508435b8ac2a..484bb02d8e6c 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -144,7 +144,7 @@ CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
 CFLAGS_s390 = -m64
-CFLAGS_mips32le = -EL -mabi=32
+CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \

---
base-commit: ba335752620565c25c3028fff9496bb8ef373602
change-id: 20770914-nolibc-pic-30043ffb0403

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

