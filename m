Return-Path: <linux-kselftest+bounces-2970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F182D752
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 11:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608AF1F21F38
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A51F4E7;
	Mon, 15 Jan 2024 10:27:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA66101D0
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40FAQblH006444;
	Mon, 15 Jan 2024 18:26:37 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id 053852004BC6;
	Mon, 15 Jan 2024 18:31:05 +0800 (CST)
Received: from localhost.localdomain (10.99.206.12) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Mon, 15 Jan 2024 18:26:36 +0800
From: Hu Yadi <hu.yadi@h3c.com>
To: <jmorris@namei.org>, <serge@hallyn.com>, <shuah@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mic@digikod.net>,
        <amir73il@gmail.com>, <brauner@kernel.org>, <avagin@google.com>
CC: <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <514118380@qq.com>,
        <konstantin.meskhidze@huawei.com>, "Hu.Yadi"
	<hu.yadi@h3c.com>
Subject: [PATCH v4] selftests/landlock:Fix two build issues
Date: Mon, 15 Jan 2024 18:24:09 +0800
Message-ID: <20240115102409.19799-1-hu.yadi@h3c.com>
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
X-MAIL:h3cspam02-ex.h3c.com 40FAQblH006444

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

Fixes: 04f9070e99a4 ("selftests/landlock: Add tests for pseudo filesystems")
Fixes: a549d055a22e ("selftests/landlock: Add network tests")

this patch is to fix them

Signed-off-by: Hu.Yadi <hu.yadi@h3c.com>
Suggested-by: Jiao <jiaoxupo@h3c.com>
Reviewed-by: Berlin <berlin@h3c.com>
---
Changes v4 -> v3:
  fix gettid error from kernel test robot
  https://lore.kernel.org/oe-kbuild-all/202401151147.T1s11iHJ-lkp@intel.com/
Changes v3 -> v2:
 - add helper of gettid instead of __NR_gettid
 - add gcc/glibc version info in comments
Changes v1 -> v2:
 - fix whitespace error
 - replace SYS_gettid with _NR_gettid

 tools/testing/selftests/landlock/fs_test.c  | 5 ++++-
 tools/testing/selftests/landlock/net_test.c | 7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

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
index 929e21c4db05..d50f2920ed82 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -21,6 +21,11 @@

 #include "common.h"

+static pid_t landlock_gettid(void)
+{
+        return syscall(__NR_gettid);
+}
+
 const short sock_port_start = (1 << 10);

 static const char loopback_ipv4[] = "127.0.0.1";
@@ -88,7 +93,7 @@ static int set_service(struct service_fixture *const srv,
 	case AF_UNIX:
 		srv->unix_addr.sun_family = prot.domain;
 		sprintf(srv->unix_addr.sun_path,
-			"_selftests-landlock-net-tid%d-index%d", gettid(),
+			"_selftests-landlock-net-tid%d-index%d", landlock_gettid(),
 			index);
 		srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
 		srv->unix_addr.sun_path[0] = '\0';
--
2.23.0


