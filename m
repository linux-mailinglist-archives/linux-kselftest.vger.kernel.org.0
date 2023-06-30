Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE599743DF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 16:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjF3Oyx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 10:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjF3Oyn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 10:54:43 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD8B199C;
        Fri, 30 Jun 2023 07:54:41 -0700 (PDT)
X-QQ-mid: bizesmtp62t1688136872tw3c6ubu
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 22:54:31 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: znfcQSa1hKbueF+mXAgBy3rJOgj1RLfbDdVxw5G9LZsIKSHSDWEo0cPthZn5y
        2507pXERHbMQlfcGVi/fPoErK4Q+RhkejsHI7PKAIoYK61wlHUruw2XEBjLind0HIk+RQsP
        ESu4yDckaqB4Zu8BTqm1n04LvedF4U3iF/SkLxvf8Z3oiOG4m5c6Tny1Igo5PX+/R3qpMRg
        yZlvGKhBNasKGPiAwMJAAnNO6oxAVrdVDl5DurO9CQzy7f5YuLC2zPOtWfLEI4giP7v/88H
        pEkPmmeDcjaBK1YbDkRmiJtiPyNN1F+M0m0458Hq55J5tjaRE3Nh39h0bIF/4HvmGeHBytE
        ZZFY9FD/68V5g2Iz7zu+8a1Dpt9Yl3c8ZwVxpOYETRHTjKCFTyKaT8dwFeFzg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 657531427943538185
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 09/14] tools/nolibc: add rmdir() support
Date:   Fri, 30 Jun 2023 22:54:24 +0800
Message-Id: <630ad07b61503e1970f93c6f24b3c6e2fc3a1650.1688134400.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688134399.git.falcon@tinylab.org>
References: <cover.1688134399.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
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

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
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

