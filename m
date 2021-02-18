Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A805831E8AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Feb 2021 11:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhBRKTA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Feb 2021 05:19:00 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49261 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231582AbhBRJNG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Feb 2021 04:13:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UOtQegI_1613639531;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UOtQegI_1613639531)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Feb 2021 17:12:16 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] firmware_loader: Remove unnecessary conversion to bool
Date:   Thu, 18 Feb 2021 17:12:09 +0800
Message-Id: <1613639529-41139-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following coccicheck warnings:

./tools/testing/selftests/firmware/fw_namespace.c:98:54-59: WARNING:
conversion to bool not needed here.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/firmware/fw_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 5ebc1ae..0e393cb 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -95,7 +95,7 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
 		}
 		if (block_fw_in_parent_ns)
 			umount("/lib/firmware");
-		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
+		return WEXITSTATUS(status) == EXIT_SUCCESS;
 	}
 
 	if (unshare(CLONE_NEWNS) != 0) {
-- 
1.8.3.1

