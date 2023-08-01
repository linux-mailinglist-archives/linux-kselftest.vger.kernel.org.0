Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AEB76B8D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 17:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjHAPkV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjHAPkU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 11:40:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADE0213D;
        Tue,  1 Aug 2023 08:40:04 -0700 (PDT)
X-QQ-mid: bizesmtp86t1690904397t1qsics3
Received: from dslab-main2-ubuntu.tail147f4.ts ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Aug 2023 23:39:56 +0800 (CST)
X-QQ-SSF: 01200000000000705000000A0000000
X-QQ-FEAT: D2GZf6M6C/i2/7WsKIkl9OkzBxEGFzGXMgnT/XtLNUHlu8FLNK6N6zWdnhOnZ
        Cyj6BQpBjNGWAQMvloYpeyl1qZ+/5/86HEX4bQZvgzMkKHTgVp1OzsJ+K4uJBapkNkz92nD
        PEVSAYyVc8VeZRTfzitgRKEojjcuSZJUuUCj+igoeIC+EozWMCZKq10fgS2Rw5KiNK9y871
        VAcPD616zUrh5yfeXg07s8/JqM044XCZpVUw1qav27wNIq9lcNdKpkMSqH7lSYANegVfade
        AJoae5ww/HpE0RQMvyih9j3nIcn2MymGsOkAkcPE2Uo+pCwZj3GYOFiUl+61GG9lMXpA/RF
        TtG8TyWJ2uQbFyTi7wbvakMb+WRjLxtuXxImFIc0owKMJP+dHCoBMMTQGmLSQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7644089916909828399
From:   Yuan Tan <tanyuan@tinylab.org>
To:     w@1wt.eu, thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH v3 1/2] tools/nolibc: add pipe() and pipe2() support
Date:   Tue,  1 Aug 2023 23:39:54 +0800
Message-Id: <ee9b82db75dbbc517a00a30b6be60ae1e0f4a252.1690903601.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690903601.git.tanyuan@tinylab.org>
References: <cover.1690903601.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
index 8bfe7db20b80..56f63eb48a1b 100644
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
+	return my_syscall2(__NR_pipe2, pipefd, flags);
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
+	return pipe2(pipefd, 0);
+}
+
+
 /*
  * int prctl(int option, unsigned long arg2, unsigned long arg3,
  *                       unsigned long arg4, unsigned long arg5);
-- 
2.34.1

