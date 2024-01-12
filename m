Return-Path: <linux-kselftest+bounces-2894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F6782BB88
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 08:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C6A1F25BFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 07:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57EA5C8EA;
	Fri, 12 Jan 2024 07:15:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75395C8E6
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Jan 2024 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40C7F1rd043835;
	Fri, 12 Jan 2024 15:15:02 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id 886D122E1859;
	Fri, 12 Jan 2024 15:19:24 +0800 (CST)
Received: from localhost.localdomain (10.99.206.12) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Fri, 12 Jan 2024 15:15:02 +0800
From: Hu Yadi <hu.yadi@h3c.com>
To: <jmorris@namei.org>, <serge@hallyn.com>, <shuah@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mic@digikod.net>
CC: <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <514118380@qq.com>,
        "Hu.Yadi" <hu.yadi@h3c.com>
Subject: [PATCH v3] selftests/landlock:Fix two build issues
Date: Fri, 12 Jan 2024 15:12:45 +0800
Message-ID: <20240112071245.669-1-hu.yadi@h3c.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 40C7F1rd043835

From: "Hu.Yadi" <hu.yadi@h3c.com>

Two issues comes up while building selftest/landlock on my side
(gcc 7.3/glibc-2.28/kernel-4.19)

the first one is as to gettid

net_test.c: In function ‘set_service’:
net_test.c:91:45: warning: implicit declaration of function ‘gettid’; [-Wimplicit-function-declaration]
    "_selftests-landlock-net-tid%d-index%d", gettid(),
                                             ^~~~~~
                                             getgid
net_test.c:(.text+0x4e0): undefined reference to `gettid'

the second is compiler error
gcc -Wall -O2 -isystem   fs_test.c -lcap -o selftests/landlock/fs_test
fs_test.c:4575:9: error: initializer element is not constant
  .mnt = mnt_tmp,
         ^~~~~~~

this patch is to fix them

Signed-off-by: Hu.Yadi <hu.yadi@h3c.com>
Suggested-by: Jiao <jiaoxupo@h3c.com>
Reviewed-by: Berlin <berlin@h3c.com>
---
Changes v3 -> v2:
 - add helper of gettid instead of __NR_gettid
 - add gcc/glibc version info in comments
Changes v1 -> v2:
 - fix whitespace error
 - replace SYS_gettid with _NR_gettid

 tools/testing/selftests/landlock/fs_test.c  | 5 ++++-
 tools/testing/selftests/landlock/net_test.c | 9 +++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 18e1f86a6234..a992cf7c0ad1 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4572,7 +4572,10 @@ FIXTURE_VARIANT(layout3_fs)
 /* clang-format off */
 FIXTURE_VARIANT_ADD(layout3_fs, tmpfs) {
 	/* clang-format on */
-	.mnt = mnt_tmp,
+	.mnt = {
+		.type = "tmpfs",
+		.data = "size=4m,mode=700",
+	},
 	.file_path = file1_s1d1,
 };
 
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 929e21c4db05..12a6744568e2 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -21,6 +21,15 @@
 
 #include "common.h"
 
+#ifndef gettid
+static pid_t gettid(void)
+{
+        return syscall(__NR_gettid);
+}
+
+#endif
+
+
 const short sock_port_start = (1 << 10);
 
 static const char loopback_ipv4[] = "127.0.0.1";
-- 
2.23.0


