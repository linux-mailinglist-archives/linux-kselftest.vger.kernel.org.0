Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69986312F4F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 11:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBHKo3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 05:44:29 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55429 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232609AbhBHKl6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 05:41:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UOAHH.R_1612780871;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UOAHH.R_1612780871)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Feb 2021 18:41:12 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     shuah@kernel.org
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] selftests/powerpc: remove unneeded semicolon
Date:   Mon,  8 Feb 2021 18:41:10 +0800
Message-Id: <1612780870-95890-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Eliminate the following coccicheck warning:
./tools/testing/selftests/powerpc/nx-gzip/gzfht_test.c:327:4-5: Unneeded
semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/testing/selftests/powerpc/nx-gzip/gzfht_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/nx-gzip/gzfht_test.c b/tools/testing/selftests/powerpc/nx-gzip/gzfht_test.c
index 02dffb6..b099753 100644
--- a/tools/testing/selftests/powerpc/nx-gzip/gzfht_test.c
+++ b/tools/testing/selftests/powerpc/nx-gzip/gzfht_test.c
@@ -324,7 +324,7 @@ int compress_file(int argc, char **argv, void *handle)
 				fprintf(stderr, "error: cannot progress; ");
 				fprintf(stderr, "too many faults\n");
 				exit(-1);
-			};
+			}
 		}
 
 		fault_tries = NX_MAX_FAULTS; /* Reset for the next chunk */
-- 
1.8.3.1

