Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BBC725D20
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 13:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbjFGLar (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 07:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbjFGLaq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 07:30:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B2519A4;
        Wed,  7 Jun 2023 04:30:41 -0700 (PDT)
X-QQ-mid: bizesmtp88t1686137431txjb0ruo
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 19:30:30 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: PS/N6jJLnDYwJEGZC7QAtJWPa/AlKwXo0vmdJ7kjq/mWA0tEQux5qfVTlr0zq
        V0mQ4yl64VpUmbvnsqbSN7zmeSevRUHmbKOZoV2RqIOt8edl233rqbjgHL+q7xdbYk7qw0T
        oDbzE70YdzBu94Fz3kB0Vxyk73oAMss5RRcIEMdMbDAKZGDHbrmqZ3shDB9YNI4GPLQbbyC
        YpefZjfBLWxIf0z9U6lv0MnP+rAzGLTBXjOtyEUJdteCy8j1LYn7FPmZtLhHlVEj+dAmryn
        bRmbdeOXlRWDFL3U2JhqQGtudiei24trgW3jAVgqAa8iUyA/xMvOA7v8ihmxArblu03CWvf
        A7TJ2iCs1KR4AhETgTAsng5OTvPUqWD1dzD8jIRVnYXh9ApTgLCxOG2o/o+ts6irrjY3CNF
        F0Q8oxfdQOU=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11378213777674272868
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 1/3] tools/nolibc: sys.h: add a syscall return helper
Date:   Wed,  7 Jun 2023 19:30:09 +0800
Message-Id: <7cad207c4c4deb41151bd12fa658fb3fc64a5bf1.1686135913.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686135913.git.falcon@tinylab.org>
References: <cover.1686135913.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

