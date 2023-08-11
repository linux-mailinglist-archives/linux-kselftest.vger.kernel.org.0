Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E057799EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 23:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbjHKVvF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 17:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237070AbjHKVvE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 17:51:04 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964DD2712;
        Fri, 11 Aug 2023 14:51:03 -0700 (PDT)
X-QQ-mid: bizesmtp63t1691790647tk467uon
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 12 Aug 2023 05:50:45 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: cknW069rtVdcYll5qSTwzsTfqXrvv75L0qlCqnV/4/VuNNA7AGW2lTfMec+rQ
        gEw8mbCx55sIMZILg5KY6QqKA+LhLlKg5bADNzSAvAlfol9VlvGPKaKhHJ/bXqcbpBQY9gV
        C0DVP4IGf98tFitIlQSyk5om2TtXNcx+SX7xsxiCPx7YbfwTS64JfQSNKLwptd5ADVtfSyf
        I5AdAfTL6bbgRExXfcQMn7T9lmasM9eDj+0hWlw5iNtV8lDfnf2oti4bBDVfPw6G52Dnyto
        jTDMKgGG4xzfJdBamFQYhuWsLwhYy4TPPJB72surXE19oa0ZzXscT77AHrYFWUEZLX8ySFy
        7taB/RHQeSTab8kW2cW9spWFSz7nxNBDKqV9hqMf48knKOe2WazBXHc7rPhhA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10867541119786147020
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, david.laight@aculab.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: [PATCH v6 1/2] tools/nolibc: let sys_brk, sys_mmap and sys_mmap2 return long
Date:   Sat, 12 Aug 2023 05:50:45 +0800
Message-Id: <82b584cbda5cee8d5318986644a2a64ba749a098.1691788036.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691788036.git.falcon@tinylab.org>
References: <cover.1691788036.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Firstly, since the sys_* functions are internally used by our library
routines, it is ok to let them preserve the 'long' return type of
my_syscall<N> macros, that means not necessary to return pointer like
their library routines do.

Secondly, in order to avoid the size inflating issues introduced by the
sign extension, it is better to let __sysret() only accept integer input
types, to do so, we must let all of the sys_* functions not return
pointers.

There are only three sys_* functions which return pointer, let's make
them return 'long' instead of pointer.

Link: https://lore.kernel.org/lkml/20230809221743.83107-1-falcon@tinylab.org/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-s390.h |  4 ++--
 tools/include/nolibc/sys.h       | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 5d60fd43f883..6396c2a6bc3a 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -160,7 +160,7 @@ struct s390_mmap_arg_struct {
 };
 
 static __attribute__((unused))
-void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
+long sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 	       off_t offset)
 {
 	struct s390_mmap_arg_struct args = {
@@ -172,7 +172,7 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 		.offset = (unsigned long)offset
 	};
 
-	return (void *)my_syscall1(__NR_mmap, &args);
+	return my_syscall1(__NR_mmap, &args);
 }
 #define sys_mmap sys_mmap
 
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 833d6c5e86dc..a28e7fbff448 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -74,9 +74,9 @@ long __sysret(unsigned long ret)
  */
 
 static __attribute__((unused))
-void *sys_brk(void *addr)
+long sys_brk(void *addr)
 {
-	return (void *)my_syscall1(__NR_brk, addr);
+	return my_syscall1(__NR_brk, addr);
 }
 
 static __attribute__((unused))
@@ -89,12 +89,12 @@ static __attribute__((unused))
 void *sbrk(intptr_t inc)
 {
 	/* first call to find current end */
-	void *ret = sys_brk(0);
+	void *ret = (void *)sys_brk(0);
 
-	if (ret && sys_brk(ret + inc) == ret + inc)
+	if (ret && (void *)sys_brk(ret + inc) == ret + inc)
 		return ret + inc;
 
-	return (void *)__sysret(-ENOMEM);
+	return (void *)__sysret((long)-ENOMEM);
 }
 
 
@@ -658,7 +658,7 @@ int mknod(const char *path, mode_t mode, dev_t dev)
 
 #ifndef sys_mmap
 static __attribute__((unused))
-void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
+long sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 	       off_t offset)
 {
 	int n;
@@ -670,7 +670,7 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 	n = __NR_mmap;
 #endif
 
-	return (void *)my_syscall6(n, addr, length, prot, flags, fd, offset);
+	return my_syscall6(n, addr, length, prot, flags, fd, offset);
 }
 #endif
 
@@ -682,7 +682,7 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 static __attribute__((unused))
 void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
 {
-	return (void *)__sysret((unsigned long)sys_mmap(addr, length, prot, flags, fd, offset));
+	return (void *)__sysret(sys_mmap(addr, length, prot, flags, fd, offset));
 }
 
 static __attribute__((unused))
-- 
2.25.1

