Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF3074B64B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjGGSaJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGGSaI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:30:08 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7322684;
        Fri,  7 Jul 2023 11:30:05 -0700 (PDT)
X-QQ-mid: bizesmtp90t1688754595ts3n5v37
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:29:54 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: XBN7tc9DADJx3xrBBNujCbgqiQFsrVO7Qw97Fa4yASrCH5l/MPK8XyD0c+v9H
        VuIGWjq4fXE8uh1ZrceDIUrqxS9IVjYcxdH09ev5PE+FesVf6Ga0X7q/j97L8j/JuBt0WvJ
        MEVKdynPhOv69sVotBquSeLNASL4Hasl9Nu3gZrFdmaLgJzlDaNesJ3fsoDD87gB9ivRjVU
        GxfpnYvmB9VZSnrgAfBP9Qekr3TmHkd1MOf+zwY8D3bddaRLx8UBO3IfKGM+Pk9nCrbIu0h
        lko7AVERcKQ2JgpPJRGsRxMGyFZytzYbrz+sicbowtZdEOCNIXJJWMYXF108CnhvRTliN/C
        46z1PlZbwgejlj5NLbTczrqrDVWQ9nC4g9ZhknhTKT8wvkjSVnVVgQdlKa3QdWai7N+XAU2
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5061810002461843469
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 06/18] tools/nolibc: types.h: add RB_ flags for reboot()
Date:   Sat,  8 Jul 2023 02:29:30 +0800
Message-Id: <d22d7d010ec0d6497d796b25c5b64242d2fe0a24.1688750763.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688750763.git.falcon@tinylab.org>
References: <cover.1688750763.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Both glibc and musl provide RB_ flags via <sys/reboot.h> for reboot(),
they don't need to include <linux/reboot.h>, let nolibc provide RB_
flags too.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h   |  1 -
 tools/include/nolibc/types.h | 12 +++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 61a3204b00d7..804bc0231ec7 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -21,7 +21,6 @@
 #include <linux/auxvec.h>
 #include <linux/fcntl.h> /* for O_* and AT_* */
 #include <linux/stat.h>  /* for statx() */
-#include <linux/reboot.h> /* for LINUX_REBOOT_* */
 #include <linux/prctl.h>
 
 #include "arch.h"
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 5e1bac8509ec..23963e48d8ee 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -9,8 +9,9 @@
 
 #include "std.h"
 #include <linux/mman.h>
-#include <linux/time.h>
+#include <linux/reboot.h> /* for LINUX_REBOOT_* */
 #include <linux/stat.h>
+#include <linux/time.h>
 
 
 /* Only the generic macros and types may be defined here. The arch-specific
@@ -92,6 +93,15 @@
 #define SEEK_CUR       1
 #define SEEK_END       2
 
+/* flags for reboot */
+#define RB_AUTOBOOT     LINUX_REBOOT_CMD_RESTART
+#define RB_HALT_SYSTEM  LINUX_REBOOT_CMD_HALT
+#define RB_ENABLE_CAD   LINUX_REBOOT_CMD_CAD_ON
+#define RB_DISABLE_CAD  LINUX_REBOOT_CMD_CAD_OFF
+#define RB_POWER_OFF    LINUX_REBOOT_CMD_POWER_OFF
+#define RB_SW_SUSPEND   LINUX_REBOOT_CMD_SW_SUSPEND
+#define RB_KEXEC        LINUX_REBOOT_CMD_KEXEC
+
 /* Macros used on waitpid()'s return status */
 #define WEXITSTATUS(status) (((status) & 0xff00) >> 8)
 #define WIFEXITED(status)   (((status) & 0x7f) == 0)
-- 
2.25.1

