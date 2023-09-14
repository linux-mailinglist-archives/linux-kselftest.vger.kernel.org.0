Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11547A0A25
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 18:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbjINQCO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 12:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241677AbjINQCB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 12:02:01 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390F32728;
        Thu, 14 Sep 2023 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694707293;
        bh=zl3Xj+oQp2Dr3MQfACk4EonlZTHBYeQ+nfTgGzZOwVE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Y4CgCkNksk2J13ulVehJe/Ytv0sKK+LNKe/GNZXCdeZIMaFoGW9OlGrjttaz0ylS7
         8g4puMZEVbV9XFppWL5QlcvofBOAiR5tgNLSdD9NuZ2Pm7iohQOcRlAjM7DXz6bvSU
         /5r2kwjn23Ssc99K6I0h63VzuV3TANTgNMTVA9vo=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 14 Sep 2023 18:01:20 +0200
Subject: [PATCH 4/4] tools/nolibc: automatically detect necessity to use
 pselect6
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230914-nolibc-syscall-nr-v1-4-e50df410da11@weissschuh.net>
References: <20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net>
In-Reply-To: <20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707292; l=3914;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zl3Xj+oQp2Dr3MQfACk4EonlZTHBYeQ+nfTgGzZOwVE=;
 b=F8EbEV7tGvVpu68Qr3EK6RIfDob0u0Yj2Wok7lOtDs9Z1s+WoEBEmIuIiU5hgIybWgIAnW2VT
 o284s51I2qYDdkhTq5ZYHZcd9Vboi/EkkwezL5N2eZpLKzuMwT1pykA
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We can automatically detect if pselect6 is needed or not from the kernel
headers. This removes the need to manually specify it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-aarch64.h   |  3 ---
 tools/include/nolibc/arch-loongarch.h |  4 +---
 tools/include/nolibc/arch-riscv.h     |  3 ---
 tools/include/nolibc/sys.h            | 10 +++++-----
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 6c33c46848e3..b23ac1f04035 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -20,10 +20,7 @@
  *   - the arguments are cast to long and assigned into the target registers
  *     which are then simply passed as registers to the asm code, so that we
  *     don't have to experience issues with register constraints.
- *
- * On aarch64, select() is not implemented so we have to use pselect6().
  */
-#define __ARCH_WANT_SYS_PSELECT6
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index bf98f6220195..3f8ef8f86c0f 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -19,10 +19,8 @@
  *   - the arguments are cast to long and assigned into the target
  *     registers which are then simply passed as registers to the asm code,
  *     so that we don't have to experience issues with register constraints.
- *
- * On LoongArch, select() is not implemented so we have to use pselect6().
  */
-#define __ARCH_WANT_SYS_PSELECT6
+
 #define _NOLIBC_SYSCALL_CLOBBERLIST \
 	"memory", "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$t8"
 
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 950cc2283fd7..1927c643c739 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -19,10 +19,7 @@
  *   - the arguments are cast to long and assigned into the target
  *     registers which are then simply passed as registers to the asm code,
  *     so that we don't have to experience issues with register constraints.
- *
- * On riscv, select() is not implemented so we have to use pselect6().
  */
-#define __ARCH_WANT_SYS_PSELECT6
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index d96f2aa7d987..dbf5cc92181b 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -946,7 +946,11 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 		struct timeval *t;
 	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
 	return my_syscall1(__NR_select, &arg);
-#elif defined(__ARCH_WANT_SYS_PSELECT6) && defined(__NR_pselect6)
+#elif defined(__NR__newselect)
+	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
+#elif defined(__NR_select)
+	return my_syscall5(__NR_select, nfds, rfds, wfds, efds, timeout);
+#elif defined(__NR_pselect6)
 	struct timespec t;
 
 	if (timeout) {
@@ -954,10 +958,6 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 		t.tv_nsec = timeout->tv_usec * 1000;
 	}
 	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
-#elif defined(__NR__newselect)
-	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
-#elif defined(__NR_select)
-	return my_syscall5(__NR_select, nfds, rfds, wfds, efds, timeout);
 #else
 	(void)nfds;
 	(void)rfds;

-- 
2.42.0

