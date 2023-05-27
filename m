Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA187134D6
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 May 2023 14:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjE0M4w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 May 2023 08:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjE0M4u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 May 2023 08:56:50 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45310EC;
        Sat, 27 May 2023 05:56:48 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685192205;
        bh=/cOHkF1z6kJm7Qrk+U5UtijhFyzbqdb92nwDXeYrX4Q=;
        h=From:Date:Subject:To:Cc:From;
        b=MhVn1r8UMG8I3x2MU1QsYHUC/32ynwqv4V8P66tMD2vetPKUSYjzb70QsCsI2MwQV
         XMacNKNXSSIenEoxfLEYa4laE7EgQVFEQBDS9mjbBMpdDS7uTQGaMZBRuDQnCPLpXj
         ArdFWac/qsZOZ7/LXBNmWoioo5RnmHebPL5d/mdc=
Date:   Sat, 27 May 2023 14:56:42 +0200
Subject: [PATCH] tools/nolibc: support nanoseconds in stat()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230527-nolibc-stat-nanoseconds-v1-1-3f7825caae68@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAn+cWQC/x2N0QrCMAwAf2Xk2UDXbg78FfEhbaMLlFSaTYSxf
 7f4eAfHHWDchA1uwwGNP2JStcN4GSCtpC9GyZ3BOx/c7BfUWiQmtI02VNJqnKpmwzBnHqfrQlN
 w0OtIxhgbaVp7r3spXb4bP+X7390f5/kD6e4YNn4AAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685192204; l=4809;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/cOHkF1z6kJm7Qrk+U5UtijhFyzbqdb92nwDXeYrX4Q=;
 b=0XVCyD6rNUL0DpnaiEPU/gzx2e9D4W5QnpfV/aUbIUjQZho97buJ58YMPtxASvrDRa0wpV2+W
 8J420vmmXZuBr6tU5+eJzwu1KsSaquliLuC+J/b/8IruMI3CNvToBIG
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Keep backwards compatibility through unions.

The compatibility macros like

 #define st_atime st_atim.tv_sec

as documented in stat(3type) don't work for nolibc because it would
break with other stat-like structures that contain the field st_atime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h                   | 29 +++++++++++++++-------------
 tools/include/nolibc/types.h                 |  6 +++---
 tools/testing/selftests/nolibc/nolibc-test.c | 23 ++++++++++++++++++++++
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 7874062bea95..11b354e26861 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1187,19 +1187,22 @@ int sys_stat(const char *path, struct stat *buf)
 #else
 #error Neither __NR_newfstatat nor __NR_stat defined, cannot implement sys_stat()
 #endif
-	buf->st_dev     = stat.st_dev;
-	buf->st_ino     = stat.st_ino;
-	buf->st_mode    = stat.st_mode;
-	buf->st_nlink   = stat.st_nlink;
-	buf->st_uid     = stat.st_uid;
-	buf->st_gid     = stat.st_gid;
-	buf->st_rdev    = stat.st_rdev;
-	buf->st_size    = stat.st_size;
-	buf->st_blksize = stat.st_blksize;
-	buf->st_blocks  = stat.st_blocks;
-	buf->st_atime   = stat.st_atime;
-	buf->st_mtime   = stat.st_mtime;
-	buf->st_ctime   = stat.st_ctime;
+	buf->st_dev          = stat.st_dev;
+	buf->st_ino          = stat.st_ino;
+	buf->st_mode         = stat.st_mode;
+	buf->st_nlink        = stat.st_nlink;
+	buf->st_uid          = stat.st_uid;
+	buf->st_gid          = stat.st_gid;
+	buf->st_rdev         = stat.st_rdev;
+	buf->st_size         = stat.st_size;
+	buf->st_blksize      = stat.st_blksize;
+	buf->st_blocks       = stat.st_blocks;
+	buf->st_atim.tv_sec  = stat.st_atime;
+	buf->st_atim.tv_nsec = stat.st_atime_nsec;
+	buf->st_mtim.tv_sec  = stat.st_mtime;
+	buf->st_mtim.tv_nsec = stat.st_mtime_nsec;
+	buf->st_ctim.tv_sec  = stat.st_ctime;
+	buf->st_ctim.tv_nsec = stat.st_ctime_nsec;
 	return ret;
 }
 #endif
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 15b0baffd336..f96e28bff4ba 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -198,9 +198,9 @@ struct stat {
 	off_t     st_size;    /* total size, in bytes */
 	blksize_t st_blksize; /* blocksize for file system I/O */
 	blkcnt_t  st_blocks;  /* number of 512B blocks allocated */
-	time_t    st_atime;   /* time of last access */
-	time_t    st_mtime;   /* time of last modification */
-	time_t    st_ctime;   /* time of last status change */
+	union { time_t st_atime; struct timespec st_atim; }; /* time of last access */
+	union { time_t st_mtime; struct timespec st_mtim; }; /* time of last modification */
+	union { time_t st_ctime; struct timespec st_ctim; }; /* time of last status change */
 };
 
 /* WARNING, it only deals with the 4096 first majors and 256 first minors */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6e0a4dbe321e..8de72c87b7b7 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -500,6 +500,28 @@ static int test_fork(void)
 	}
 }
 
+static int test_stat_timestamps(void)
+{
+	struct stat st;
+
+	if (sizeof(st.st_atim.tv_sec) != sizeof(st.st_atime))
+		return 1;
+
+	if (stat("/proc/self/", &st))
+		return 1;
+
+	if (st.st_atim.tv_sec != st.st_atime || st.st_atim.tv_nsec > 1000000000)
+		return 1;
+
+	if (st.st_mtim.tv_sec != st.st_mtime || st.st_mtim.tv_nsec > 1000000000)
+		return 1;
+
+	if (st.st_ctim.tv_sec != st.st_ctime || st.st_ctim.tv_nsec > 1000000000)
+		return 1;
+
+	return 0;
+}
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -587,6 +609,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
 		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
 		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
+		CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
 		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;
 		CASE_TEST(unlink_blah);       EXPECT_SYSER(1, unlink("/proc/self/blah"), -1, ENOENT); break;

---
base-commit: 1974a2b5fd434812b32952b09df7b79fdee8104d
change-id: 20230527-nolibc-stat-nanoseconds-35de1467a430

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

