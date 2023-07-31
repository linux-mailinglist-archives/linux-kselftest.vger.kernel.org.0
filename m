Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2018768B61
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 07:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjGaFvA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 01:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjGaFu5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 01:50:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DBBE76;
        Sun, 30 Jul 2023 22:50:55 -0700 (PDT)
X-QQ-mid: bizesmtp68t1690782649tezi1726
Received: from dslab-main2-ubuntu.tail147f4.ts ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 31 Jul 2023 13:50:47 +0800 (CST)
X-QQ-SSF: 01200000000000704000000A0000000
X-QQ-FEAT: lO87fmWkX3HIdlFAfcAaSU54ZhJkQnHcfd0NxI/L0CMTSCQD5GQMbaxv2ExB3
        Vb3xSIQr3LnxxXtg354jzyBPkZz5hvWUwn9K1zH0B6+YEa2BDvgENNLsOe5N0CwRrzbCueb
        ftemh3/tUhA17rKPM2v1yXcQQAoOXdqA5vkHJnOXmxc0n5rF6TFNIZ9BYf8LqzxirdkWC4d
        NZqxjjAo+Z0FYWV9emq73G7rj+oy8XONBUYJY7e2taLamipnq/eaMzFRw7YX5aAw3qt2a2O
        IcLPZ8tG2RoS9KcuIns1Ttz9TMt758U4m6vEE0C0DaYva/ca4GGMNZlwZLe5N5zzq+XKcOW
        l/eNWpqsCT7sohq73d+r9mjiHm0Qb5z+j+hBnoIjW8TfsvK5pc=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15683328812315869985
From:   Yuan Tan <tanyuan@tinylab.org>
To:     w@1wt.eu, thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH v2 1/2] tools/nolibc: add pipe() and pipe2() support
Date:   Mon, 31 Jul 2023 13:50:45 +0800
Message-Id: <23019c9ad3a63d7026a60df8bc41934c3e74e564.1690733545.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690733545.git.tanyuan@tinylab.org>
References: <cover.1690733545.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

According to manual page [1], posix spec [2] and source code like
arch/mips/kernel/syscall.c, for historic reasons, the sys_pipe() syscall
on some architectures has an unusual calling convention.  It returns
results in two registers which means there is no need for it to do
verify the validity of a userspace pointer argument.  Historically that
used to be expensive in Linux.  These days the performance advantage is
negligible.

Nolibc doesn't support the unusual calling convention above, luckily
Linux provides a generic sys_pipe2() with an additional flags argument
from 2.6.27. If flags is 0, then pipe2() is the same as pipe(). So here
we use sys_pipe2() to implement the pipe().

pipe2() is also provided to allow users to use flags argument on demand.

[1]: https://man7.org/linux/man-pages/man2/pipe.2.html
[2]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/pipe.html

Suggested-by: Zhangjin Wu <falcon@tinylab.org>
Link: https://lore.kernel.org/all/20230729100401.GA4577@1wt.eu/
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 tools/include/nolibc/sys.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 8bfe7db20b80..9fec09c22dbe 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -752,6 +752,30 @@ int open(const char *path, int flags, ...)
 }
 
 
+/*
+ * int pipe2(int pipefd[2], int flags);
+ * int pipe(int pipefd[2]);
+ */
+
+static __attribute__((unused))
+int sys_pipe2(int pipefd[2], int flags)
+{
+	return my_syscall2(__NR_pipe, pipefd, flags);
+}
+
+static __attribute__((unused))
+int pipe2(int pipefd[2], int flags)
+{
+	return __sysret(sys_pipe2(pipefd, flags));
+}
+
+static __attribute__((unused))
+int pipe(int pipefd[2])
+{
+	pipe2(pipefd, 0);
+}
+
+
 /*
  * int prctl(int option, unsigned long arg2, unsigned long arg3,
  *                       unsigned long arg4, unsigned long arg5);
-- 
2.34.1

