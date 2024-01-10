Return-Path: <linux-kselftest+bounces-2794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D34829408
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 08:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED54E287BD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 07:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898B137168;
	Wed, 10 Jan 2024 07:12:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881237157
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jan 2024 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40A7BA94013595;
	Wed, 10 Jan 2024 15:11:10 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id DD8812004BA6;
	Wed, 10 Jan 2024 15:15:29 +0800 (CST)
Received: from localhost.localdomain (10.99.206.12) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Wed, 10 Jan 2024 15:11:11 +0800
From: Hu Yadi <hu.yadi@h3c.com>
To: <jmorris@namei.org>, <serge@hallyn.com>, <shuah@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mic@digikod.net>
CC: <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <514118380@qq.com>,
        <berlin@h3c.com>, "Hu.Yadi" <hu.yadi@h3c.com>
Subject: [PATCH] selftests/landlock:Fix two build issues
Date: Wed, 10 Jan 2024 15:08:54 +0800
Message-ID: <20240110070854.7077-1-hu.yadi@h3c.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 40A7BA94013595

From: "Hu.Yadi" <hu.yadi@h3c.com>

Two issues comes up  while building selftest/landlock:

the first one is as to gettid

net_test.c: In function ‘set_service’:
net_test.c:91:45: warning: implicit declaration of function ‘gettid’; did you mean ‘getgid’? [-Wimplicit-function-declaration]
    "_selftests-landlock-net-tid%d-index%d", gettid(),
                                             ^~~~~~
                                             getgid
net_test.c:(.text+0x4e0): undefined reference to `gettid'

the second is compiler error
gcc -Wall -O2 -isystem   fs_test.c -lcap -o /home/linux/tools/testing/selftests/landlock/fs_test
fs_test.c:4575:9: error: initializer element is not constant
  .mnt = mnt_tmp,
         ^~~~~~~

this patch is to fix them

Signed-off-by: Hu.Yadi <hu.yadi@h3c.com>
Suggested-by: Jiao <jiaoxupo@h3c.com>
Reviewed-by:Berlin <berlin@h3c.com>
---
 tools/testing/selftests/landlock/fs_test.c  | 5 ++++-
 tools/testing/selftests/landlock/net_test.c | 3 +--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 18e1f86a6234..93eb40a09073 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4572,7 +4572,10 @@ FIXTURE_VARIANT(layout3_fs)
 /* clang-format off */
 FIXTURE_VARIANT_ADD(layout3_fs, tmpfs) {
 	/* clang-format on */
-	.mnt = mnt_tmp,
+	.mnt = {
+		.type = "tmpfs",
+        	.data = "size=4m,mode=700",
+	},
 	.file_path = file1_s1d1,
 };
 
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 929e21c4db05..8fb357de8c55 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -18,7 +18,6 @@
 #include <sys/prctl.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-
 #include "common.h"
 
 const short sock_port_start = (1 << 10);
@@ -88,7 +87,7 @@ static int set_service(struct service_fixture *const srv,
 	case AF_UNIX:
 		srv->unix_addr.sun_family = prot.domain;
 		sprintf(srv->unix_addr.sun_path,
-			"_selftests-landlock-net-tid%d-index%d", gettid(),
+			"_selftests-landlock-net-tid%ld-index%d", syscall(SYS_gettid),
 			index);
 		srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
 		srv->unix_addr.sun_path[0] = '\0';
-- 
2.23.0


