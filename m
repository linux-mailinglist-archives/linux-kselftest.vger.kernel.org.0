Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592C3715028
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 22:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjE2UCS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 16:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjE2UCR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 16:02:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2BECF;
        Mon, 29 May 2023 13:02:15 -0700 (PDT)
X-QQ-mid: bizesmtp82t1685390525tz5qfwin
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 04:02:04 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: znfcQSa1hKbqS/wmQkhqLdwrSmiDHvyr6TKGy5erBP95lAX2a5SNTQj/PK8Ly
        8Q83734ok7p3uV3bvpoEUwgs/ETtKRKuQB1PRX5jqAcr3G2iCef+kteIP98SFtKkceBncv+
        MU25NzwaU1R+nbXctsMuEFHS4GBXB9qUQ0DCeQXoztp3RNnsWwxo8HnSRzot7jR2VfW2qdn
        29yKvC/LFYAoenIfSYWVRR4hZ8lMsHjfDJ9j4zsH/TH/t6nPtK+9vP1YoxnWxDgYLfCbZ4c
        mg5+yl3HmrTNLLQb+iT5TFdh2GXi5osb3dyKJfwwtXfTWtDSt5YeDV3rGF3HkCOdyhQFJ6J
        6+l86v9uzLe/q46AZmM1/ZbROiYVJMj7zfWr2h1gTU8UOyK/JX+o2QuEH055w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4662585006422710528
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 12/13] tools/nolibc: sys_wait4: add waitid syscall support
Date:   Tue, 30 May 2023 04:01:13 +0800
Message-Id: <ad9654c0d65a978b5757d8c5697edbc89d4937e3.1685387484.git.falcon@tinylab.org>
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

rv32 uses the generic include/uapi/asm-generic/unistd.h and it has no
__NR_wait4 after kernel commit d4c08b9776b3 ("riscv: Use latest system
call ABI"), use __NR_waitid instead.

This code is based on sysdeps/unix/sysv/linux/wait4.c of glibc.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 533233094733..a32b90b1fd3b 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -12,6 +12,7 @@
 
 /* system includes */
 #include <asm/unistd.h>
+#include <asm/siginfo.h> /* for siginfo_t */
 #include <asm/signal.h>  /* for SIGCHLD */
 #include <asm/ioctls.h>
 #include <asm/mman.h>
@@ -1373,7 +1374,56 @@ int unlink(const char *path)
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
+			*status = WCOREFLAG | infop.si_status;
+			break;
+		case CLD_KILLED:
+			*status = infop.si_status;
+			break;
+		case CLD_TRAPPED:
+		case CLD_STOPPED:
+			*status = W_STOPCODE(infop.si_status);
+			break;
+		case CLD_CONTINUED:
+			*status = W_CONTINUED;
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
-- 
2.25.1

