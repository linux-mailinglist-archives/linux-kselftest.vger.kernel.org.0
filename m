Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8778E7411FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjF1NK5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:10:57 -0400
Received: from bg4.exmail.qq.com ([43.155.65.254]:26558 "EHLO
        bg4.exmail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjF1NKz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:10:55 -0400
X-QQ-mid: bizesmtp81t1687957840tk05w25f
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:10:38 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3izmkUOsSxg9uIUu5hu7sXFhGMVn/F21TZKgQ+LTXI715mV+znqg
        V0FT8m4j5DU0uhm6jSBfO1u4rd7ypCrgSxJ91A3DlKLEueKsMfbTPPs+P9mJAzgNVumAW9U
        QkEQK3DazjlmxzOw8p068gfMxLkBWHbXFdbP/MVamr2vOlwQG9sNOE1r6D9eod+n8miz9Mk
        qH26SCAVQRROGIpcJ5YabBf38Pf4XN/b8ImH1ko0hkIy/ANWUjXjd3rcxdpp8bzl3nTjxt4
        /eu8Nz4NkPabuRpc5kBjSj7f6YL1B8AiP7pvmV6zn0pBlRyQemBwh60oA6IjG2HfjjdnX3N
        n38Lno9VJXoOQHtJmlyr9DM9Zvh9zrl+PAfzsaANOHi+Dmo3wsu6GmpGjn/c6JhUUagGQGB
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17494817763370749656
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 01/14] tools/nolibc: sys.h: add a syscall return helper
Date:   Wed, 28 Jun 2023 21:08:32 +0800
Message-Id: <c23a5b2ad7c756c05d8a19af6033462ddbd948a6.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
References: <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Most of the library routines share the same syscall return logic:

  In general, a 0 return value indicates success.  A -1 return value
  indicates an error, and an error number is stored in errno. [1]

Let's add a __sysret() helper for the above logic to simplify the coding
and shrink the code lines too.

Thomas suggested to use inline function instead of macro for __sysret().

Willy suggested to make __sysret() be always inline.

[1]: https://man7.org/linux/man-pages/man2/syscall.2.html

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/linux-riscv/ZH1+hkhiA2+ItSvX@1wt.eu/
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/linux-riscv/ea4e7442-7223-4211-ba29-70821e907888@t-8ch.de/
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 5464f93e863e..097eef88cf7e 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -28,6 +28,16 @@
 #include "errno.h"
 #include "types.h"
 
+/* Syscall return helper, set errno as -ret when ret < 0 */
+static __inline__ __attribute__((unused, always_inline))
+long __sysret(long ret)
+{
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
 
 /* Functions in this file only describe syscalls. They're declared static so
  * that the compiler usually decides to inline them while still being allowed
-- 
2.25.1

