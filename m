Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDFB2C5FE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Nov 2020 06:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392503AbgK0FuH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Nov 2020 00:50:07 -0500
Received: from mail.loongson.cn ([114.242.206.163]:45814 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389456AbgK0FuH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Nov 2020 00:50:07 -0500
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax6tCDk8BfNVkXAA--.44638S2;
        Fri, 27 Nov 2020 13:49:56 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools: selftests: Add missing munmap() in check_error_paths()
Date:   Fri, 27 Nov 2020 13:49:55 +0800
Message-Id: <1606456195-23965-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Ax6tCDk8BfNVkXAA--.44638S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWrJFy8ur1fJFyxKr17ZFb_yoW8XrW7p3
        yIg34v9F4IgF12qF47tr4DWF4Y9ry7Jay7Gw1fKw1jyF1UAr9xXrWftFy0qr4fGrZ5X393
        CFsrJayfAryUArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4rMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU45l8UUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the missing munmap(addr_ro, PAGE_SIZE) before return.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 tools/testing/selftests/ptrace/peeksiginfo.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c b/tools/testing/selftests/ptrace/peeksiginfo.c
index 5490065..3d64be4 100644
--- a/tools/testing/selftests/ptrace/peeksiginfo.c
+++ b/tools/testing/selftests/ptrace/peeksiginfo.c
@@ -62,7 +62,7 @@ static int check_error_paths(pid_t child)
 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
 	if (addr_ro == MAP_FAILED) {
 		err("mmap() failed: %m\n");
-		goto out;
+		goto out_rw;
 	}
 
 	arg.nr = SIGNR;
@@ -75,7 +75,7 @@ static int check_error_paths(pid_t child)
 		err("sys_ptrace() returns %d (expected -1),"
 				" errno %d (expected %d): %m\n",
 				ret, errno, EINVAL);
-		goto out;
+		goto out_ro;
 	}
 	arg.flags = 0;
 
@@ -84,7 +84,7 @@ static int check_error_paths(pid_t child)
 					addr_ro - sizeof(siginfo_t) * 2);
 	if (ret != 2) {
 		err("sys_ptrace() returns %d (expected 2): %m\n", ret);
-		goto out;
+		goto out_ro;
 	}
 
 	/* Read-only buffer */
@@ -93,11 +93,13 @@ static int check_error_paths(pid_t child)
 		err("sys_ptrace() returns %d (expected -1),"
 				" errno %d (expected %d): %m\n",
 				ret, errno, EFAULT);
-		goto out;
+		goto out_ro;
 	}
 
 	exit_code = 0;
-out:
+out_ro:
+	munmap(addr_ro, PAGE_SIZE);
+out_rw:
 	munmap(addr_rw, 2 * PAGE_SIZE);
 	return exit_code;
 }
-- 
2.1.0

