Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40B170FD53
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 19:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbjEXR5k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 13:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjEXR5j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 13:57:39 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BA398;
        Wed, 24 May 2023 10:57:36 -0700 (PDT)
X-QQ-mid: bizesmtp69t1684951051toedm1f2
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 01:57:30 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 1U/NVTUyJNR0Bdf3bNTIg9tVMMQ36KW+m0gOe7QYfuSjie+syXUksgUIyPwT9
        XfFw8T5ZcY0Gquio8enXfYroGAwnsHycofnfTqboltbdqCDUUnRUVfDdQvLU4WvGApwZDmN
        bAN6znioI8PEsk337ISXWj6upRE/YjYx52ag3fsAJyiq4tZ26fjpekhGMHr/nYoxUoDKTYU
        6S9Cj0J1aASneoJI34cnjcZTI00YRCWzxAihgavquQbYb9F5spPI4fNfgj/l9yZIVq6KWXo
        a6u2uupdH0bFQEDqTZhEIceDjXFL2DwMqyhdHjNld9/7nfjCGEzUsIU/oflxOuhOMH7GnTA
        mW8SbP+DccbvKioNg2HMYwFQW6yUW75OfYEsj38yT1ZpwZ2SpCTFlWISeGvAQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7132561189251988013
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: [PATCH 09/13] tools/nolibc: sys_poll: riscv: use __NR_ppoll_time64 for rv32
Date:   Thu, 25 May 2023 01:57:24 +0800
Message-Id: <ec5af2ae25264eddce4b50380bfd24f9490eca75.1684949268.git.falcon@tinylab.org>
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
__NR_ppoll after kernel commit d4c08b9776b3 ("riscv: Use latest system
call ABI"), use __NR_ppoll_time64 instead.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/std.h   | 1 +
 tools/include/nolibc/sys.h   | 7 ++++++-
 tools/include/nolibc/types.h | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 83c0b0cb9564..221385c0e823 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -32,6 +32,7 @@ typedef   signed long         off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
 typedef   signed long        time_t;
+typedef     long long       time64_t;
 typedef     long long        loff_t;
 
 #endif /* _NOLIBC_STD_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 0ff77c0a06d7..08d38175bd7b 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -923,8 +923,13 @@ int pivot_root(const char *new, const char *old)
 static __attribute__((unused))
 int sys_poll(struct pollfd *fds, int nfds, int timeout)
 {
-#if defined(__NR_ppoll)
+#if defined(__NR_ppoll) || defined(__NR_ppoll_time64)
+#ifdef __NR_ppoll
 	struct timespec t;
+#else
+	struct timespec64 t;
+#define __NR_ppoll __NR_ppoll_time64
+#endif
 
 	if (timeout >= 0) {
 		t.tv_sec  = timeout / 1000;
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 15b0baffd336..ee914391439c 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -203,6 +203,12 @@ struct stat {
 	time_t    st_ctime;   /* time of last status change */
 };
 
+/* needed by time64 syscalls */
+struct timespec64 {
+	time64_t	tv_sec;		/* seconds */
+	long		tv_nsec;	/* nanoseconds */
+};
+
 /* WARNING, it only deals with the 4096 first majors and 256 first minors */
 #define makedev(major, minor) ((dev_t)((((major) & 0xfff) << 8) | ((minor) & 0xff)))
 #define major(dev) ((unsigned int)(((dev) >> 8) & 0xfff))
-- 
2.25.1

