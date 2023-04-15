Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE166E33D7
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Apr 2023 23:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDOV2x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Apr 2023 17:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDOV2w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Apr 2023 17:28:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F2326BB;
        Sat, 15 Apr 2023 14:28:50 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681594128;
        bh=CZhCYpNg6uTpr8ZWTgKMWLkEe3rYuevwpfUwwonzaWk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PcywB2y0z0iNDHNCs9VywljvSdQG2Nf16KN2ym/OCk8ABkmfoXUrSyYL1Z20J2x0W
         UuHvT+4bIO6HElmv37TvJLz7TOXcsI3smT6QL7WBhOGvn8SdFhOgSU6B7sJZyA6SVH
         mPRDfe4sL8wngoEIoUcMgaOgHZukj82JcUwELmeE=
Date:   Sat, 15 Apr 2023 23:28:47 +0200
Subject: [PATCH 1/2] tools/nolibc: s390: provide custom implementation for
 sys_fork
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230415-nolibc-fork-v1-1-9747c73651c5@weissschuh.net>
References: <20230415-nolibc-fork-v1-0-9747c73651c5@weissschuh.net>
In-Reply-To: <20230415-nolibc-fork-v1-0-9747c73651c5@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681594127; l=1606;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CZhCYpNg6uTpr8ZWTgKMWLkEe3rYuevwpfUwwonzaWk=;
 b=hD1G6hgf9pqOmGf4Ntf0OGWFeXHPFB9vAqPAyQNtEqtgOf52tpnC/4SnTJ8toLNxHPC4OitDO
 xW6fgOK8tnlA2shaegJnpmX4hiVvWwcnQKooqvRjqsZJ/DCFR+RsLnw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On s390 the first two arguments to the clone() syscall are swapped,
as documented in clone(2).

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-s390.h | 8 ++++++++
 tools/include/nolibc/sys.h       | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 6b0e54ed543d..db4ea51a4dbb 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -5,6 +5,7 @@
 
 #ifndef _NOLIBC_ARCH_S390_H
 #define _NOLIBC_ARCH_S390_H
+#include <asm/signal.h>
 #include <asm/unistd.h>
 
 /* The struct returned by the stat() syscall, equivalent to stat64(). The
@@ -223,4 +224,11 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 	return (void *)my_syscall1(__NR_mmap, &args);
 }
 #define sys_mmap sys_mmap
+
+static __attribute__((unused))
+pid_t sys_fork(void)
+{
+	return my_syscall5(__NR_clone, 0, SIGCHLD, 0, 0, 0);
+}
+#define sys_fork sys_fork
 #endif // _NOLIBC_ARCH_S390_H
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index bea9760dbd16..f5a450153a63 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -336,6 +336,7 @@ void exit(int status)
  * pid_t fork(void);
  */
 
+#ifndef sys_fork
 static __attribute__((unused))
 pid_t sys_fork(void)
 {
@@ -351,6 +352,7 @@ pid_t sys_fork(void)
 #error Neither __NR_clone nor __NR_fork defined, cannot implement sys_fork()
 #endif
 }
+#endif
 
 static __attribute__((unused))
 pid_t fork(void)

-- 
2.40.0

