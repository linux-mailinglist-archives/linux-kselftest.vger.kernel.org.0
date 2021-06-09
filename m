Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F9B3A10E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jun 2021 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbhFIKNk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Jun 2021 06:13:40 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:11738 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236314AbhFIKNk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Jun 2021 06:13:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ubr1ADd_1623232511;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Ubr1ADd_1623232511)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Jun 2021 17:55:14 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] selftests/x86/syscall: use ARRAY_SIZE for msbs
Date:   Wed,  9 Jun 2021 17:55:06 +0800
Message-Id: <1623232506-91641-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use ARRAY_SIZE instead of dividing sizeof array with sizeof an
element.

Clean up the following coccicheck warning:

./tools/testing/selftests/x86/syscall_numbering.c:316:35-36: WARNING:
Use ARRAY_SIZE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/x86/syscall_numbering.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
index 9915917..7d5e246 100644
--- a/tools/testing/selftests/x86/syscall_numbering.c
+++ b/tools/testing/selftests/x86/syscall_numbering.c
@@ -313,7 +313,7 @@ static void test_syscall_numbering(void)
 	 * The MSB is supposed to be ignored, so we loop over a few
 	 * to test that out.
 	 */
-	for (size_t i = 0; i < sizeof(msbs)/sizeof(msbs[0]); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(msbs); i++) {
 		int msb = msbs[i];
 		run("Checking system calls with msb = %d (0x%x)\n",
 		    msb, msb);
-- 
1.8.3.1

