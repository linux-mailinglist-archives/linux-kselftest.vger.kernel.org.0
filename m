Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DAE714FFF
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 21:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjE2TwG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 15:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjE2TwF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 15:52:05 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FC5E3;
        Mon, 29 May 2023 12:52:02 -0700 (PDT)
X-QQ-mid: bizesmtp87t1685389912tusgo9mr
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 03:51:51 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: LE7C6P2vL8R5XJtM7F/ylhDdnSf4EUI8w+v082wCayEwS8rdu+e8MzUqlG3Sb
        QuE4mqAnTVj6AADlLJu/mYN813+YPw+wXBoUtUM/fgbT6eqZhO8mdM4qSyoVp4k8dOh/beL
        /l7yxz9x8w9r+TSZWZLLMsMD9u3qECqZpmPkRw0+tQOYBeXpiaRhRFDEEoxVspoDs9zmbAg
        977LlI4WFKBMXCoTk3CBGjDpFdvDeGrbH0Fsj2GfLw+U4NeVeHbXa3Ycefev6zt9mzP01Qo
        LJnk0Twv4xlHA/20ARRy2Qt8n9dEKicVztokHy1O+8hrgKAQQHYbo5SNcKjO3ajFS8Vnkwl
        KO6HYcWeOwM/XfiLougrpGNauB5hUSmFxblr/kzjnLpPEhiZhWuZnbWOyY86IFQeBWRJY38
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14959843268558275111
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 05/13] tools/nolibc: add more wait status related types
Date:   Tue, 30 May 2023 03:51:48 +0800
Message-Id: <e578baa7116bb09f406a2beaea8298f7bbb22d6c.1685387484.git.falcon@tinylab.org>
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

More wait status related types are added for the coming waitid syscall
based wait4() support.

Resue the ones from <linux/wait.h>, add the missing ones from sys/wait.h
and bits/waitstatus.h of glibc.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/types.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index f96e28bff4ba..698d859fc6e2 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -10,6 +10,7 @@
 #include "std.h"
 #include <linux/time.h>
 #include <linux/stat.h>
+#include <linux/wait.h>
 
 
 /* Only the generic macros and types may be defined here. The arch-specific
@@ -91,9 +92,13 @@
 #define WIFEXITED(status)   (((status) & 0x7f) == 0)
 #define WTERMSIG(status)    ((status) & 0x7f)
 #define WIFSIGNALED(status) ((status) - 1 < 0xff)
+#define WIFSTOPPED(status)  (((status) & 0xff) == 0x7f)
 
-/* waitpid() flags */
-#define WNOHANG      1
+/* Macros for constructing status values.  */
+#define W_EXITCODE(ret, sig) ((ret) << 8 | (sig))
+#define W_STOPCODE(sig)      ((sig) << 8 | 0x7f)
+#define W_CONTINUED          0xffff
+#define WCOREFLAG            0x80
 
 /* standard exit() codes */
 #define EXIT_SUCCESS 0
-- 
2.25.1

