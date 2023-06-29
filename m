Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE40974313C
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 01:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjF2Xrl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 19:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjF2Xri (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 19:47:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947382D50;
        Thu, 29 Jun 2023 16:47:36 -0700 (PDT)
X-QQ-mid: bizesmtp69t1688082446tioisu3e
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 07:47:25 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: GUznYiACrGRXU/PHOEhZV4uIpp/gsrUe2qnOFpSTSF4MU1t9SCpp/PEXkGLnU
        X5sOQhdKVk9smFzAGQFaDLeDEwaVOpwCjMZ/QvMIpG5KF3300XxhHvoQpm6rFYpTpMhdbWa
        gielDawdT0Lm8wppHPUNs30pHHLYDJozuaT+A5bC2vX6H5DIQHD2GRfibL9k1GlUy1sL7iw
        U2L0h/dLPqID9hcbsmNDXA/PNc+YmKx8l6rpH7i7qkRkeUeLDZtU5S8PXbXWE5Vuf2jW2WT
        IQtTG3PqUOW8AttwjOR41SezOEo15azPYbN7wfChYvXhPFoUf362D8B7WwnbHY3pS1qAFbX
        T2mZ380MafeGj9Wbhzx8/WUCYI8pfecB1ICzTqF3SXKkLsgfhQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1361039155256738211
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 08/15] tools/nolibc: add rmdir() support
Date:   Fri, 30 Jun 2023 07:45:00 +0800
Message-Id: <7a2cde610506ca288742b4e52833572c4341ac20.1688078605.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688078604.git.falcon@tinylab.org>
References: <cover.1688078604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

a reverse operation of mkdir() is meaningful, add rmdir() here.

required by nolibc-test to remove /proc while CONFIG_PROC_FS is not
enabled.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index b6c33c40c037..7b052958e2ae 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -610,6 +610,28 @@ int mkdir(const char *path, mode_t mode)
 	return __sysret(sys_mkdir(path, mode));
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
+	return __sysret(sys_rmdir(path));
+}
+
 
 /*
  * int mknod(const char *path, mode_t mode, dev_t dev);
-- 
2.25.1

