Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B182723B08
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 10:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjFFIKI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 04:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjFFIKH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 04:10:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982B6B1;
        Tue,  6 Jun 2023 01:10:05 -0700 (PDT)
X-QQ-mid: bizesmtp74t1686038995tv89ingj
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2023 16:09:54 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: HH6/KuQOBEZ8A8pYx8XsBdrlyHL8GtyVq+ZUYV+ZZkz5xn0a8lAF48lB5ZtBN
        SEWV6uZWjpbmERUWWwjt4KHGN6OUhX3XImQ0L7p7kXrbRfdWAKcpM/mpRkjsNRth7sRK30F
        oLwh+CsaqTOX+bNQGyM0K20+LqxfeXTvq1RHm5O/G6QDI3z42kjmXotyPTq/8v9Ii9CqVa5
        WoUNXfWEfyW1TrJwG4a8+z0fI2ABZfq1QiLkCmY+J3QAlzybxry9PnCd7+qW5+2UC7Sp4ma
        FIf/x3mgWeYBACj50Qgz2pRM3ScdIBRZDKtwL910cw7SxyhfKwdvvN+K/3izjyLKz2AkkJM
        REp0CjT5nX4zPp5U+vBZkFTEMNAyE9w7qEI508/U7kiFmnEDTMTHEmP64/qJ1FRhs/y9Mus
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11179949754190029416
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 1/4] tools/nolibc: sys.h: add __syscall() and __sysret() helpers
Date:   Tue,  6 Jun 2023 16:09:51 +0800
Message-Id: <a42fb9e1bbe0daf7d8a48ea8f44135ef851030d7.1686036862.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686036862.git.falcon@tinylab.org>
References: <cover.1686036862.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

most of the library routines share the same code model, let's add two
helpers to simplify the coding and shrink the code lines too.

One added for syscall return, one added for syscall call.

Thomas suggested to use inline function instead of macro for __sysret(),
and he also helped to simplify the __syscall() a lot.

Willy suggested to make __sysret() be always inline.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/linux-riscv/ZH1+hkhiA2+ItSvX@1wt.eu/
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/linux-riscv/ea4e7442-7223-4211-ba29-70821e907888@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 5464f93e863e..c12c14db056e 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -28,6 +28,18 @@
 #include "errno.h"
 #include "types.h"
 
+/* Syscall return helper, set errno as -ret when ret < 0 */
+static inline __attribute__((always_inline)) long __sysret(long ret)
+{
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+/* Syscall call helper, use syscall name instead of syscall number */
+#define __syscall(name, ...) __sysret(sys_##name(__VA_ARGS__))
 
 /* Functions in this file only describe syscalls. They're declared static so
  * that the compiler usually decides to inline them while still being allowed
-- 
2.25.1

