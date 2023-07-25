Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088077620D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 20:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjGYSBe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 14:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjGYSBd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 14:01:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E431FF2;
        Tue, 25 Jul 2023 11:01:29 -0700 (PDT)
X-QQ-mid: bizesmtp70t1690308084t5vcw89e
Received: from localhost.localdomain ( [42.242.128.198])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 02:01:23 +0800 (CST)
X-QQ-SSF: 01200000000000403000B00A0000000
X-QQ-FEAT: ybg6K0M/reNhatuJAQj2pVlNYo7QSouh4qfAKOOGrsqpOAFklqw056+Ntmyga
        qaW+pewqcXh9WzeCoCMnFwpA5DYy9Z0WlEhvJmb7cIC8k7t9wsQ5yzxNpkuv9QJVbUflA/e
        qmM6U0pcIdjN3KNy/aecc5d7F3FJ1gXG0T+FskvW9g6BoH2kh9Tj5nR9To1heHtp60kbpGJ
        tKmfZeCL/sLwJV+N6GdH6zc4+C6AxKjgJx9j+RsW1/lcVafqDCflR76efmhm9Uz0mA3LB0L
        7V1kxcINVYOZdQZ5V7Ls5Jhc61lZCfnxDzg67lQtU9pvGmjc9/AdvSnCEqoREdVZy/vn7lj
        wOh053nzx4vqPfIhG2qc8sLrgSGu9e2jDpfWYrnNBW0E2DLQXM=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15258818057665170873
From:   Yuan Tan <tanyuan@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH 1/2] tools/nolibc: add pipe() support
Date:   Tue, 25 Jul 2023 14:01:21 -0400
Message-Id: <d01fc60c6a85cc4af87f6f88eb5017b83c181f4d.1690307717.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690307717.git.tanyuan@tinylab.org>
References: <cover.1690307717.git.tanyuan@tinylab.org>
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

pipe is crucial for shell.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 tools/include/nolibc/sys.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 8bfe7db20b80..09841fc266fe 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -752,6 +752,23 @@ int open(const char *path, int flags, ...)
 }
 
 
+/*
+ * int pipe(int pipefd[2]);
+ */
+
+static __attribute__((unused))
+int sys_pipe(int pipefd[2])
+{
+	return my_syscall1(__NR_pipe, pipefd);
+}
+
+static __attribute__((unused))
+int pipe(int pipefd[2])
+{
+	return __sysret(sys_pipe(pipefd));
+}
+
+
 /*
  * int prctl(int option, unsigned long arg2, unsigned long arg3,
  *                       unsigned long arg4, unsigned long arg5);
-- 
2.39.2

