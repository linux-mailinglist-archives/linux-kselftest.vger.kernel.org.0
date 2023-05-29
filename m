Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CF6714FFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 21:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjE2Tux (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 15:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2Tuw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 15:50:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B9F92;
        Mon, 29 May 2023 12:50:50 -0700 (PDT)
X-QQ-mid: bizesmtp83t1685389840t1ldvvpj
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 03:50:39 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: dKvkn8qoLrFfEd304t1Xl83vvHzcvnC5EbPGl6s3cJET+n5LM1YDkRuZaPpId
        hp3bJ7KbDOlPLie0wL+QhZCmS6Ym5I3VeBvkxj/bRb7MTlDa33drXsOjI66pujE8j+7fncI
        L6Fnw0neLjbdK/6pgleFNIAbeK+rx1MA282jNwz6q+2YZuvTDOoBUf7/B8xqBW6Dp09Wb7f
        ism+NRTnMMJSNVs2lNPqesZMBxOJtK74ASsYMXd7AcpK5Hk3+rPgSmwIA3ip8LF7iOG9w92
        OlkSZ79gWfXHiVBWBtuYYBw+EqMK32qFP8x0dcMKGHEqR5eYUDKrGKxOzVNRmgHxiASOB30
        XPiK6fv7mSwkQeCgPpPSdu8qQiUeTDy2D5zRv+KIP5aJ4AFOm3hh77HWm7UxQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18400951668219620669
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 04/13] tools/nolibc: add missing nanoseconds support for __NR_statx
Date:   Tue, 30 May 2023 03:50:34 +0800
Message-Id: <4cd637be248b5bfad6f2a01b82a9fb6f3fe4c6fa.1685387484.git.falcon@tinylab.org>
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

    /* include/uapi/linux/time_types.h */
    struct __kernel_timespec {
    	__kernel_time64_t       tv_sec;                 /* seconds */
    	long long               tv_nsec;                /* nanoseconds */
    };

    /* tools/include/nolibc/types.h */
    #define timespec __kernel_timespec

Without this patch, the stat_timestamps test case would fail on rv32.

Fixes: a89c937d781a ("tools/nolibc: support nanoseconds in stat()")
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 154194056962..98cfa2f6d021 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1175,9 +1175,9 @@ int sys_stat(const char *path, struct stat *buf)
 	buf->st_size    = statx.stx_size;
 	buf->st_blksize = statx.stx_blksize;
 	buf->st_blocks  = statx.stx_blocks;
-	buf->st_atime   = statx.stx_atime.tv_sec;
-	buf->st_mtime   = statx.stx_mtime.tv_sec;
-	buf->st_ctime   = statx.stx_ctime.tv_sec;
+	buf->st_atim    = (struct timespec){ .tv_sec = statx.stx_atime.tv_sec, .tv_nsec = statx.stx_atime.tv_nsec };
+	buf->st_mtim    = (struct timespec){ .tv_sec = statx.stx_mtime.tv_sec, .tv_nsec = statx.stx_mtime.tv_nsec };
+	buf->st_ctim    = (struct timespec){ .tv_sec = statx.stx_ctime.tv_sec, .tv_nsec = statx.stx_ctime.tv_nsec };
 	return ret;
 }
 #else
-- 
2.25.1

