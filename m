Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAEC312241
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Feb 2021 08:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBGHm5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Feb 2021 02:42:57 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:58608 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhBGHm4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Feb 2021 02:42:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UO34qWQ_1612683731;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UO34qWQ_1612683731)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 07 Feb 2021 15:42:11 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] selftests/x86/ldt_gdt: remove unneeded semicolon
Date:   Sun,  7 Feb 2021 15:42:10 +0800
Message-Id: <1612683730-104353-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Eliminate the following coccicheck warning:
./tools/testing/selftests/x86/ldt_gdt.c:610:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/testing/selftests/x86/ldt_gdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/ldt_gdt.c b/tools/testing/selftests/x86/ldt_gdt.c
index 1aef72d..3a29346 100644
--- a/tools/testing/selftests/x86/ldt_gdt.c
+++ b/tools/testing/selftests/x86/ldt_gdt.c
@@ -607,7 +607,7 @@ static void do_multicpu_tests(void)
 
 		failures++;
 		asm volatile ("mov %0, %%ss" : : "rm" (orig_ss));
-	};
+	}
 
 	ftx = 100;  /* Kill the thread. */
 	syscall(SYS_futex, &ftx, FUTEX_WAKE, 0, NULL, NULL, 0);
-- 
1.8.3.1

