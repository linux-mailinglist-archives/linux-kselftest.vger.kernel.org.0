Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF31720E9B
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 10:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjFCIDP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 04:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFCIDO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 04:03:14 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAE3E40;
        Sat,  3 Jun 2023 01:03:12 -0700 (PDT)
X-QQ-mid: bizesmtp88t1685779382tnnl2ip3
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 16:03:01 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: /+iK7ZpVlLQCQXqPSdOBhJJtHOaA/uGGRHPayXIRaGu+YhAFWsPazE+ULSLgS
        s96RiiK7GwzPd6n89GHKQ6SFyVzhAqWyrFlaMYaOWdhjhbHb+VixYEAYRUPKZ/rQtyNckdi
        Zi25NQ0xylNsTwAaSxVLoioPCOMe8dtaR7JxTZ1xYpMFZ283x4epDN6y5QixLz8+iZP0EfJ
        HvS+E4mwJnyo4BzYB8Dnvkv08tDSmnmlt5WxwR5X2dw2THx/n7ZPVm+0e8Wgc04QLzraW17
        ZNGSqreCAtS/IQdHnr/1E2GfnX2rLYl70mHTMeCkWhU9d+Udx4qEAgNftIJGCjPiNotnHYR
        f3WDBW5fL5oG0fLP3oLir4hW+hIQGRTVyTaQu9rpMwP+WLysZ3z9Hgl46OfyXFXNEC80Cml
        2uhx01xuDXA=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15194475891504528648
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 02/12] tools/nolibc: add missing nanoseconds support for __NR_statx
Date:   Sat,  3 Jun 2023 16:02:04 +0800
Message-Id: <bcb69a382bbb68826f974ef4f521c8f1c60e47bc.1685777982.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685777982.git.falcon@tinylab.org>
References: <cover.1685777982.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit a89c937d781a ("tools/nolibc: support nanoseconds in stat()")
added nanoseconds for stat() but missed the statx case, this adds it.

The stx_atime, stx_mtime, stx_ctime are in type of 'struct
statx_timestamp', which is incompatible with 'struct timespec', should
convert explicitly.

    /* include/uapi/linux/stat.h */

    struct statx_timestamp {
    	__s64	tv_sec;
    	__u32	tv_nsec;
    	__s32	__reserved;
    };

    /* include/uapi/linux/time.h */
    struct timespec {
    	__kernel_old_time_t	tv_sec;		/* seconds */
    	long			tv_nsec;	/* nanoseconds */
    };

Without this patch, the stat_timestamps test case would fail when
__NR_statx defined.

Fixes: a89c937d781a ("tools/nolibc: support nanoseconds in stat()")
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/linux-riscv/3a3edd48-1ace-4c89-89e8-9c594dd1b3c9@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 1d6f33f58629..0160605444e7 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1161,23 +1161,26 @@ int sys_stat(const char *path, struct stat *buf)
 	long ret;
 
 	ret = sys_statx(AT_FDCWD, path, AT_NO_AUTOMOUNT, STATX_BASIC_STATS, &statx);
-	buf->st_dev     = ((statx.stx_dev_minor & 0xff)
-			  | (statx.stx_dev_major << 8)
-			  | ((statx.stx_dev_minor & ~0xff) << 12));
-	buf->st_ino     = statx.stx_ino;
-	buf->st_mode    = statx.stx_mode;
-	buf->st_nlink   = statx.stx_nlink;
-	buf->st_uid     = statx.stx_uid;
-	buf->st_gid     = statx.stx_gid;
-	buf->st_rdev    = ((statx.stx_rdev_minor & 0xff)
-			  | (statx.stx_rdev_major << 8)
-			  | ((statx.stx_rdev_minor & ~0xff) << 12));
-	buf->st_size    = statx.stx_size;
-	buf->st_blksize = statx.stx_blksize;
-	buf->st_blocks  = statx.stx_blocks;
-	buf->st_atime   = statx.stx_atime.tv_sec;
-	buf->st_mtime   = statx.stx_mtime.tv_sec;
-	buf->st_ctime   = statx.stx_ctime.tv_sec;
+	buf->st_dev          = ((statx.stx_dev_minor & 0xff)
+			       | (statx.stx_dev_major << 8)
+			       | ((statx.stx_dev_minor & ~0xff) << 12));
+	buf->st_ino          = statx.stx_ino;
+	buf->st_mode         = statx.stx_mode;
+	buf->st_nlink        = statx.stx_nlink;
+	buf->st_uid          = statx.stx_uid;
+	buf->st_gid          = statx.stx_gid;
+	buf->st_rdev         = ((statx.stx_rdev_minor & 0xff)
+			       | (statx.stx_rdev_major << 8)
+			       | ((statx.stx_rdev_minor & ~0xff) << 12));
+	buf->st_size         = statx.stx_size;
+	buf->st_blksize      = statx.stx_blksize;
+	buf->st_blocks       = statx.stx_blocks;
+	buf->st_atim.tv_sec  = statx.stx_atime.tv_sec;
+	buf->st_atim.tv_nsec = statx.stx_atime.tv_nsec;
+	buf->st_mtim.tv_sec  = statx.stx_mtime.tv_sec;
+	buf->st_mtim.tv_nsec = statx.stx_mtime.tv_nsec;
+	buf->st_ctim.tv_sec  = statx.stx_ctime.tv_sec;
+	buf->st_ctim.tv_nsec = statx.stx_ctime.tv_nsec;
 	return ret;
 }
 #else
-- 
2.25.1


