Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CB5715005
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 21:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjE2Tx3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 15:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjE2Tx0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 15:53:26 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B153992;
        Mon, 29 May 2023 12:53:24 -0700 (PDT)
X-QQ-mid: bizesmtp87t1685389995t9lfs5qi
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 03:53:14 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: CR3LFp2JE4kuE2cO00Q/1KOi7QfVnxapLBkeSoUSu+aL7k4cNLL5T6EAjWCRL
        qWr+iK9XeavjZJL6SHlw1xJ39WYbVKpn5xi/kAYVRjWTUL0jc2GvhKngTUvjVkB3ZP96t8a
        f6bQH5yJmO7ydx9hHga2PhgYSPsewy6BXmnd6JDH+Ie/uv5PlwLeMbh5hPN9bnBjuf1wI3/
        GX2HxLY2DDBNVjPV+v9pZ+RHjGYrURspNgApsk8t2R447yUh1MyCWXTv37OH8MqQk7xofTe
        afhTgbVNBvAS13Ewbqx3MqxnOl2Za5ZPSVDk9HvB/MNtCFJIf1+Y3Kh+P7RY2QdIZKD4kmW
        uCPOfJoEI2bVSbOW6d9M/0ygbJnGPeXTqMdOiA1LxQIbZHwVtv3xTZEg6CNn28wnViEtzW+
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2371937537439054605
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 06/13] tools/nolibc: add pure 64bit off_t, time_t and blkcnt_t
Date:   Tue, 30 May 2023 03:53:00 +0800
Message-Id: <b41f3cb75a71fc7ecb855cc82e85a3a0fbb39318.1685387484.git.falcon@tinylab.org>
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

clean up std.h with include/uapi/linux/posix_types.h

convert time_t to 64bit even in 32bit platforms, for y2038 issue.

align off_t and blkcnt_t with 'struct statx' in include/uapi/linux/stat.h

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/83ab9f47-e1ed-463c-a717-26aad6bf2b71@app.fastmail.com/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/std.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 933bc0be7e1c..0f458c1c24de 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -20,17 +20,21 @@
 
 #include "stdint.h"
 
-/* those are commonly provided by sys/types.h */
-typedef unsigned int          dev_t;
-typedef unsigned long         ino_t;
-typedef unsigned int         mode_t;
-typedef   signed int          pid_t;
-typedef unsigned int          uid_t;
-typedef unsigned int          gid_t;
-typedef unsigned long       nlink_t;
-typedef   signed long         off_t;
-typedef   signed long     blksize_t;
-typedef   signed long      blkcnt_t;
-typedef   signed long        time_t;
+#include <linux/posix_types.h>
+
+/* based on linux/types.h */
+typedef uint32_t __kernel_dev_t;
+
+typedef __kernel_dev_t          dev_t;
+typedef __kernel_ulong_t        ino_t;
+typedef __kernel_mode_t         mode_t;
+typedef __kernel_pid_t          pid_t;
+typedef __kernel_uid32_t        uid_t;
+typedef __kernel_gid32_t        gid_t;
+typedef __kernel_loff_t         off_t;
+typedef __kernel_time64_t       time_t;
+typedef uint32_t                nlink_t;
+typedef uint32_t                blksize_t;
+typedef uint64_t                blkcnt_t;
 
 #endif /* _NOLIBC_STD_H */
-- 
2.25.1

