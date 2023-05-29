Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF09715010
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 21:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjE2TzI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 15:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjE2TzH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 15:55:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615CCF4;
        Mon, 29 May 2023 12:55:03 -0700 (PDT)
X-QQ-mid: bizesmtp74t1685390094tpc5r986
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 03:54:53 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: uGhnJwy6xZISo/AEbiO2R7D9Bkp1qAC1x25dTn245rn0AypFebeWwalodNjhE
        EL0Hxl2tTtRKwyjA9hWn6rJEMWZwJ13M7sTzYmfFM1VAENq33hSqeuCTSPxUjmRP8In5z0j
        jE3PPH0La2QBf3gtfL4qavbfPRbU9RB/PQuJibgW2/x+jjWS9xtIWSHbLtt65NMZEKdLaN8
        dkZK4Ia/D7JyiFc+a1Kz4je5B5SnuVU37OtBIhZa6tgmgd8wfgtSuev0V/BKN+5P6bH/hRU
        5o3Ae2l3mwfoTcHHys8UBybwBk03+OCAL3pFbxALn8Bt+8SyD8qmmeKLiKKhfao3WsglZUh
        Asti4FqiHE3VbrkVNKSBjtA3A/Az2xVvvEmvGiv9bla+QGTOev9aF8pmMHpuQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5796279202276383086
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 07/13] tools/nolibc: sys_lseek: add pure 64bit lseek
Date:   Tue, 30 May 2023 03:54:23 +0800
Message-Id: <2f5c3338898da65210ad3f62d7b7773a96f6d251.1685387484.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685387484.git.falcon@tinylab.org>
References: <cover.1685387484.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

use sys_llseek instead of sys_lseek to add 64bit seek even in 32bit
platforms.

This code is based on sysdeps/unix/sysv/linux/lseek.c of glibc and
src/unistd/lseek.c of musl.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 98cfa2f6d021..d0720af84b6d 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -672,7 +672,17 @@ int link(const char *old, const char *new)
 static __attribute__((unused))
 off_t sys_lseek(int fd, off_t offset, int whence)
 {
+#if defined(__NR_llseek) || defined(__NR__llseek)
+#ifndef __NR__llseek
+#define __NR__llseek __NR_llseek
+#endif
+	off_t result;
+	return my_syscall5(__NR__llseek, fd, offset >> 32, offset, &result, whence) ?: result;
+#elif defined(__NR_lseek)
 	return my_syscall3(__NR_lseek, fd, offset, whence);
+#else
+#error None of __NR_lseek, __NR_llseek nor __NR__llseek defined, cannot implement sys_lseek()
+#endif
 }
 
 static __attribute__((unused))
-- 
2.25.1

