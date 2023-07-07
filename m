Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EBA74B663
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjGGSer (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjGGSeq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:34:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E782685;
        Fri,  7 Jul 2023 11:34:43 -0700 (PDT)
X-QQ-mid: bizesmtp67t1688754875tv67uwp3
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:34:34 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: lO87fmWkX3HpsLfCTb5+tVIiOoTKdAOMqPvXKyQaIVThl5VL9goMsQIls+Xbj
        kl3u0in0xHM7RNVC00ryMWbvQRHgGvwn3XpXtpN4DpADWw2EIUnWs5VZdhMrNM2Ad2hQdWK
        onn7iIrumRQb33g1ICrYHJOJqYlQwUuULrBTP6A5za9MXEVNQfQ2F9dkFvvYVSMAp0rcXTX
        ILIWuBznvTEtO6aJ3MWIyQPf+L+eODvh5sHZHL38mjvHFXIl44cFcNA2Mi3SS95AjK6p/lv
        PvDRYv46O7Ht0Ig5ygo5CxVKVcRVEd3wkQm0PMJKY3xI6yARcFZ5ti5OeMY1K+9hwtp5i2W
        ThpacGhwgfI8uHEkZhLK36wYrMogXXYqJspOsc3Ghdhg2KjCOY=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7451315100261662590
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 10/18] tools/nolibc: add rmdir() support
Date:   Sat,  8 Jul 2023 02:34:21 +0800
Message-Id: <3d6088e256c5b3961b433b52431f43e52f3e0634.1688750763.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688750763.git.falcon@tinylab.org>
References: <cover.1688750763.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 804bc0231ec7..dee56894a811 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -611,6 +611,28 @@ int mkdir(const char *path, mode_t mode)
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

