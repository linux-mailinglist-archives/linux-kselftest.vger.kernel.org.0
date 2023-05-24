Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5299070FCD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 19:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjEXRlS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 13:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjEXRlQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 13:41:16 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA49E119;
        Wed, 24 May 2023 10:41:14 -0700 (PDT)
X-QQ-mid: bizesmtp85t1684950069tkbe1e2d
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 01:41:08 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: ymkv9EwBIzIqdJHXz1tqkq1Xg/DZPmkYs3TYAOpX5T7lHwTwTwis4rf2mwKFE
        ieDnbszxtjK2OAL7YE2gUPRLdWypPjkjaRhPGXRbx5dlmtZiULOtw7P7XD2aTb7WChN22gt
        +p+oJOz/ld1s36+Y5HLYRZ+6j9LYEwPb7u1+5HMIWWZtn5+fAK+Dxry+5TJZmF/TQ5AW9Xz
        CRyBs923a/CV3bsZPZtqThtsORSKPAtHO9jdjXmQVwKAIDSffJdR9hO5v6QRIlHdL/Clvs8
        1zHRswgNcSBP8wNh+2l4cYYjDr62+2dRdZBMuwaM5EmTdiDFcskXJ7PO74thD79yjH1VQbI
        +AcdX1ozF9N8Op3VjzWCAWk59keifaWIKuiJNGj/RqMBsPMFJpwSzkswbimyA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4465477485056657340
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: [PATCH 01/13] Revert "tools/nolibc: riscv: Support __NR_llseek for rv32"
Date:   Thu, 25 May 2023 01:41:06 +0800
Message-Id: <c8221575c0c2edebf15aea67e1dcd6ce09f01157.1684949267.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684949267.git.falcon@tinylab.org>
References: <cover.1684949267.git.falcon@tinylab.org>
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

This reverts commit d2c3acba6d66 to prepare for a whole new patch later.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/std.h |  1 -
 tools/include/nolibc/sys.h | 19 -------------------
 2 files changed, 20 deletions(-)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 83c0b0cb9564..933bc0be7e1c 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -32,6 +32,5 @@ typedef   signed long         off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
 typedef   signed long        time_t;
-typedef     long long        loff_t;
 
 #endif /* _NOLIBC_STD_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 7874062bea95..d5792a5de70b 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -671,26 +671,7 @@ int link(const char *old, const char *new)
 static __attribute__((unused))
 off_t sys_lseek(int fd, off_t offset, int whence)
 {
-#ifdef __NR_lseek
 	return my_syscall3(__NR_lseek, fd, offset, whence);
-#elif defined(__NR_llseek)
-	loff_t res;
-	off_t retval;
-
-	int rc = my_syscall5(__NR_llseek, fd, (long) (((uint64_t) (offset)) >> 32), (long) offset, &res, whence);
-
-	if (rc)
-		return rc;
-
-	retval = (off_t) res;
-	if (retval == res)
-		return retval;
-
-	SET_ERRNO(EOVERFLOW);
-	return (off_t) -1;
-#else
-#error Neither __NR_lseek nor __NR_llseek defined, cannot implement sys_lseek()
-#endif
 }
 
 static __attribute__((unused))
-- 
2.25.1

