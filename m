Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76497735B44
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 17:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjFSPlj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjFSPli (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 11:41:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCC8113;
        Mon, 19 Jun 2023 08:41:36 -0700 (PDT)
X-QQ-mid: bizesmtp75t1687189283tf03uy18
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 23:41:21 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3jbjpkri1hCtt3wapIdtdZ3mKAKL3x4ywEH+9AAkaH2L1w9F6TnS
        Tx+YKnNgtl1OQjDw+EgPeDa3FaWoF9IQmEUTi2AyVScB6EvSGVTGHXGnIS67XikEy6+naJo
        fSmO3ZxxH1j3v3ekw8Pf+fz/3Vw5y0iNtBdxY5vVPRSdvVba2yz0+IlpPxN96v8lDQ9vEY2
        zEO3bvznX+ArQ0IfNCgqqXbXZ6lLhLV+/FvfQ6IuoCN3z9HLoccn/YpEDOzgZ15ObHr8ldM
        6JtYrJ077RhHpSdzMd4doDetReqFvlVxWZ5HY+fXN+9H53o+TN+P/bL9iFJv+xQQb9gYLW6
        Nt2EHqyX1g14gbJiAKteWKJ+DTc5ksX0Nx4cmNTluBs3O+E5h5KOoLZ47NeDSnyQVQuzXij
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11055691782021961800
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     david.laight@aculab.com, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 01/10] tools/nolibc: sys.h: add a syscall return helper
Date:   Mon, 19 Jun 2023 23:41:18 +0800
Message-Id: <c6e6077660db1d07fdf92d89dac3641ce8195851.1687187451.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687187451.git.falcon@tinylab.org>
References: <cover.1687187451.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 856249a11890..150777207468 100644
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

