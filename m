Return-Path: <linux-kselftest+bounces-2823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AAE82A691
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 04:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C332815DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 03:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69DAEC8;
	Thu, 11 Jan 2024 03:42:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D6EC0
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40B3fTYr005490;
	Thu, 11 Jan 2024 11:41:29 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id E10B12004BB0;
	Thu, 11 Jan 2024 11:45:49 +0800 (CST)
Received: from localhost.localdomain (10.99.206.12) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Thu, 11 Jan 2024 11:41:29 +0800
From: Hu Yadi <hu.yadi@h3c.com>
To: <jmorris@namei.org>, <serge@hallyn.com>, <shuah@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mic@digikod.net>
CC: <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <514118380@qq.com>,
        <jiaoxupo@h3c.com>, "Hu.Yadi" <hu.yadi@h3c.com>
Subject: [PATCH v3] selftests/move_mount_set_group:Fix  build issue with old libc
Date: Thu, 11 Jan 2024 11:39:07 +0800
Message-ID: <20240111033907.26853-1-hu.yadi@h3c.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 40B3fTYr005490

From: "Hu.Yadi" <hu.yadi@h3c.com>

Replace SYS_move_mount with __NR_move_mount  to fix build error
with old libc.

Signed-off-by: Hu.Yadi <hu.yadi@h3c.com>
Suggested-by: Jiao <jiaoxupo@h3c.com>
Reviewed-by: Berlin <berlin@h3c.com>
---
Changes v2 -> v3:
 - Adjust comments 
Changes v1 -> v2:
 - Fix mail of Suggested-by and Reviewed-by

 .../move_mount_set_group/move_mount_set_group_test.c          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
index 50ed5d475dd1..bcf51d785a37 100644
--- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
+++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
@@ -218,7 +218,7 @@ static bool move_mount_set_group_supported(void)
 	if (mount(NULL, SET_GROUP_FROM, NULL, MS_SHARED, 0))
 		return -1;
 
-	ret = syscall(SYS_move_mount, AT_FDCWD, SET_GROUP_FROM,
+	ret = syscall(__NR_move_mount, AT_FDCWD, SET_GROUP_FROM,
 		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
 	umount2("/tmp", MNT_DETACH);
 
@@ -363,7 +363,7 @@ TEST_F(move_mount_set_group, complex_sharing_copying)
 		       CLONE_VM | CLONE_FILES); ASSERT_GT(pid, 0);
 	ASSERT_EQ(wait_for_pid(pid), 0);
 
-	ASSERT_EQ(syscall(SYS_move_mount, ca_from.mntfd, "",
+	ASSERT_EQ(syscall(__NR_move_mount, ca_from.mntfd, "",
 			  ca_to.mntfd, "", MOVE_MOUNT_SET_GROUP
 			  | MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH),
 		  0);
-- 
2.23.0


