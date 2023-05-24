Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E1070FD66
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 20:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbjEXSCd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 14:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjEXSCc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 14:02:32 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E189130;
        Wed, 24 May 2023 11:02:29 -0700 (PDT)
X-QQ-mid: bizesmtp77t1684951344tml8b7ly
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 02:02:21 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: Xz3VOcA7Mr0KaqdkQOpzZ+GPBYPXJApKLC+NLroSL35n8g1DvXnk4MI0nnhSq
        eCA8abIJEj5/MMX0E0nOiq1r3tRW1Dzuj8kKIhMISCxuR2R+vSH+y9iUTtbM2YLkEZQFbl4
        Gwj6XvvvAj46eYzyPG97x4/H3sFl0piFoY4Qhzz2TCtETlBg073vgdEKgIponO7WU5ihXTG
        7USD/hZHC2KRfmWeEOarJtk8QF/O+zSJAue55HVToyJnWjy0g89EeUu6x7BvEne9Q56B8z+
        H1qfJhUBHAXsIGNQEAnBLXLdMPINADkwqTscOIIy4rgBZdHW6p9iKZ9pgDu/AIDCanwCLue
        Hp87XNtP5SGMjLlCeXCoFJZ6Z7QZPlB5zQMCyidc1VKdP9xYKKKx3ND7Gh9AA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6618908142304380197
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: [PATCH 12/13] tools/nolibc: sys_wait4: riscv: use __NR_waitid for rv32
Date:   Thu, 25 May 2023 02:02:17 +0800
Message-Id: <7a55e771c3cacf2e5b1a4750efac747289dbc54b.1684949268.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684949267.git.falcon@tinylab.org>
References: <cover.1684949267.git.falcon@tinylab.org>
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

rv32 uses the generic include/uapi/asm-generic/unistd.h and it has no
__NR_wait4 after kernel commit d4c08b9776b3 ("riscv: Use latest system
call ABI"), use __NR_waitid instead.

This code is based on sysdeps/unix/sysv/linux/wait4.c of glibc.

Notes: The kernel wait4 syscall has the 'pid == INT_MIN' path and
returns -ESRCH, but the kernel waitid syscall has no such path, to let
this __NR_waitid based sys_wait4 has the same return value and pass the
'waitpid_min' test, we emulate such path in our new nolibc __NR_waitid
branch.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h   | 54 ++++++++++++++++++++++++++++++++++++
 tools/include/nolibc/types.h | 15 +++++++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 00c7197dcd50..2642b380c6aa 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -12,6 +12,7 @@
 
 /* system includes */
 #include <asm/unistd.h>
+#include <asm/siginfo.h> /* for siginfo_t */
 #include <asm/signal.h>  /* for SIGCHLD */
 #include <asm/ioctls.h>
 #include <asm/mman.h>
@@ -1333,7 +1334,60 @@ int unlink(const char *path)
 static __attribute__((unused))
 pid_t sys_wait4(pid_t pid, int *status, int options, struct rusage *rusage)
 {
+#ifdef __NR_wait4
 	return my_syscall4(__NR_wait4, pid, status, options, rusage);
+#elif defined(__NR_waitid)
+	siginfo_t infop;
+	int idtype = P_PID;
+	int ret;
+
+	/* emulate the 'pid == INT_MIN' path of wait4 */
+	if (pid == INT_MIN)
+		return -ESRCH;
+
+	if (pid < -1) {
+		idtype = P_PGID;
+		pid *= -1;
+	} else if (pid == -1) {
+		idtype = P_ALL;
+	} else if (pid == 0) {
+		idtype = P_PGID;
+	}
+
+	options |= WEXITED;
+
+	ret = my_syscall5(__NR_waitid, idtype, pid, &infop, options, rusage);
+	if (ret < 0)
+		return ret;
+
+	if (status) {
+		switch (infop.si_code) {
+		case CLD_EXITED:
+			*status = W_EXITCODE(infop.si_status, 0);
+			break;
+		case CLD_DUMPED:
+			*status = __WCOREFLAG | infop.si_status;
+			break;
+		case CLD_KILLED:
+			*status = infop.si_status;
+			break;
+		case CLD_TRAPPED:
+		case CLD_STOPPED:
+			*status = W_STOPCODE(infop.si_status);
+			break;
+		case CLD_CONTINUED:
+			*status = __W_CONTINUED;
+			break;
+		default:
+			*status = 0;
+			break;
+		}
+	}
+
+	return infop.si_pid;
+#else
+#error Neither __NR_wait4 nor __NR_waitid defined, cannot implement sys_wait4()
+#endif
 }
 
 static __attribute__((unused))
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index ee914391439c..c4f95c267607 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -92,8 +92,21 @@
 #define WTERMSIG(status)    ((status) & 0x7f)
 #define WIFSIGNALED(status) ((status) - 1 < 0xff)
 
-/* waitpid() flags */
+/* waitpid() and waitid() flags */
 #define WNOHANG      1
+#define WEXITED      0x00000004
+
+/* first argument for waitid() */
+#define P_ALL        0
+#define P_PID        1
+#define P_PGID       2
+#define P_PIDFD      3
+
+/* Macros used on waitid's status setting */
+#define W_EXITCODE(ret, sig) ((ret) << 8 | (sig))
+#define W_STOPCODE(sig)      ((sig) << 8 | 0x7f)
+#define __W_CONTINUED        0xffff
+#define __WCOREFLAG          0x80
 
 /* standard exit() codes */
 #define EXIT_SUCCESS 0
-- 
2.25.1

