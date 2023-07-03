Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57704745700
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 10:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjGCILT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 04:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjGCILQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 04:11:16 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87B6E56;
        Mon,  3 Jul 2023 01:11:13 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1688371871;
        bh=kJhOWrHT19lxlXbxpDms6ePeadAyakSraqg81a3AWM4=;
        h=From:Date:Subject:To:Cc:From;
        b=haqhEw2cv08hpnQ0MnDu82+CPHCatTfbpexHrd8fjyzYBsGbIR8lCZV2FMIA4bLDZ
         6DA+/oBKuuhyWd/yQCo0lzMwipNP3gREr9zXeWH1I2QVgfjTA5gpjszfaqAZbwOpPC
         UOmlFF8lpiWTDVjJXkDML9eRseRuY3n24br3bNsw=
Date:   Mon, 03 Jul 2023 10:11:08 +0200
Subject: [PATCH] selftests/nolibc: simplify call to ioperm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230703-nolibc-ioperm-v1-1-abf9ebe98a80@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJuComQC/x3MQQqAIBBA0avIrBNMKa2rRIvKqQZKRSEC8e5Jy
 7f4P0PCSJhgZBkiPpTIu4q2YbCdizuQk60GKaQSWiju/EXrxskHjDc3xhq9YG87HKA2IeJO7/+
 b5lI+8GhPCl8AAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688371870; l=1268;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kJhOWrHT19lxlXbxpDms6ePeadAyakSraqg81a3AWM4=;
 b=S+s/IO9qf076DYNW/+GGq2bcAJOviujQOot28YeutmosgS+tbApKaXBDWI9HiY9BruZ+Mv32f
 QFTEPNUXlUWCqHxl651aZoxNEnGa5HRMhWCCBJ/L+G8PXxAel5dgiWF
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

Since commit 53fcfafa8c5c ("tools/nolibc/unistd: add syscall()") nolibc
has support for syscall(2).
Use it to get rid of some ifdef-ery.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 486334981e60..c02d89953679 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1051,11 +1051,7 @@ int main(int argc, char **argv, char **envp)
 		 * exit with status code 2N+1 when N is written to 0x501. We
 		 * hard-code the syscall here as it's arch-dependent.
 		 */
-#if defined(_NOLIBC_SYS_H)
-		else if (my_syscall3(__NR_ioperm, 0x501, 1, 1) == 0)
-#else
-		else if (ioperm(0x501, 1, 1) == 0)
-#endif
+		else if (syscall(__NR_ioperm, 0x501, 1, 1) == 0)
 			__asm__ volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
 		/* if it does nothing, fall back to the regular panic */
 #endif

---
base-commit: a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451
change-id: 20230703-nolibc-ioperm-88d87ae6d5e9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

