Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E806312EF7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 11:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhBHK0u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 05:26:50 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:38489 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232218AbhBHKYr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 05:24:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UOAeU-o_1612779845;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UOAeU-o_1612779845)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Feb 2021 18:24:05 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     shuah@kernel.org
Cc:     tyhicks@linux.microsoft.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] selftests/ipc: remove unneeded semicolon
Date:   Mon,  8 Feb 2021 18:24:00 +0800
Message-Id: <1612779840-77555-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Eliminate the following coccicheck warning:
./tools/testing/selftests/ipc/msgque.c:72:3-4: Unneeded semicolon
./tools/testing/selftests/ipc/msgque.c:183:2-3: Unneeded semicolon
./tools/testing/selftests/ipc/msgque.c:191:2-3: Unneeded semicolon

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/testing/selftests/ipc/msgque.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index 5ec4d9e..656c43c 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -69,7 +69,7 @@ int restore_queue(struct msgque_data *msgque)
 			printf("msgsnd failed (%m)\n");
 			ret = -errno;
 			goto destroy;
-		};
+		}
 	}
 	return 0;
 
@@ -180,7 +180,7 @@ int fill_msgque(struct msgque_data *msgque)
 				IPC_NOWAIT) != 0) {
 		printf("First message send failed (%m)\n");
 		return -errno;
-	};
+	}
 
 	msgbuf.mtype = ANOTHER_MSG_TYPE;
 	memcpy(msgbuf.mtext, ANOTHER_TEST_STRING, sizeof(ANOTHER_TEST_STRING));
@@ -188,7 +188,7 @@ int fill_msgque(struct msgque_data *msgque)
 				IPC_NOWAIT) != 0) {
 		printf("Second message send failed (%m)\n");
 		return -errno;
-	};
+	}
 	return 0;
 }
 
-- 
1.8.3.1

