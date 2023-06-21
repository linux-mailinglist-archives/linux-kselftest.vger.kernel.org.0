Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F5073843C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjFUNAx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFUNAw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:00:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD8D1AC;
        Wed, 21 Jun 2023 06:00:50 -0700 (PDT)
X-QQ-mid: bizesmtp65t1687352442tow0k82a
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 21:00:41 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: ILHsT53NKPiClSNJokhMYDBCmPxungrT3Z+CWJDyQNX3zu4qzLWhjv7TO/3Hn
        /N8B9E8eDY8EdrjCc7Jz6dJyueSDRep5azdaqdVyMFQYVxpSnf2LAKXuXjHzvidF8+mX6EB
        e5Ue0qtvGuZjh5LBUoEPh7E2IgsmHEEuFmESuk8i9WjkzTOkHBqjqPI+YYdG1iXXX9J40L+
        7DwACtW3ZjrR9UZ+Lf+GstYy7tDM9GvhRTboSxBRXLJ5mcOxhJbzSHpBT55cL9u+uGY82KR
        S82+3tyMLY2Hso2Z7zujZN91pH8jGSe3J1BPNU2GhGS3LLvtIB4/8s7CgHaHN5y8JADXQ5X
        EbMUU5cUoLYGmVPgqQEo6uoNF3USYfnsNQc05e0VbrrQQP2djYU8t5+QvZsOg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18188769316264056375
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 06/17] tools/nolibc: add rmdir() support
Date:   Wed, 21 Jun 2023 21:00:33 +0800
Message-Id: <12a992919bea416bbc073d869c90d03c5ad1c7ac.1687344643.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687344643.git.falcon@tinylab.org>
References: <cover.1687344643.git.falcon@tinylab.org>
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

A reverse operation of mkdir is meaningful, add rmdir() here.

This is required by nolibc-test to remove /proc if CONFIG_PROC_FS not
enabled.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 856249a11890..8ddfd9185da6 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -716,6 +716,34 @@ int mkdir(const char *path, mode_t mode)
 	return ret;
 }
 
+/*
+ * int rmdir(const char *path);
+ */
+
+static __attribute__((unused))
+int sys_rmdir(const char *path)
+{
+#ifdef __NR_rmdir
+	return my_syscall1(__NR_rmdir, path);
+#elif defined(__NR_unlinkat)
+	return my_syscall3(__NR_unlinkat, AT_FDCWD, path, AT_REMOVEDIR);
+#else
+	return -ENOSYS;
+#endif
+}
+
+static __attribute__((unused))
+int rmdir(const char *path)
+{
+	int ret = sys_rmdir(path);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
 
 /*
  * int mknod(const char *path, mode_t mode, dev_t dev);
-- 
2.25.1

