Return-Path: <linux-kselftest+bounces-2904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F382BBFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 08:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3717DB24EC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 07:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2902D5D742;
	Fri, 12 Jan 2024 07:45:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B685D729
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Jan 2024 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40C7hs78061086;
	Fri, 12 Jan 2024 15:43:54 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id 63C8322CFF00;
	Fri, 12 Jan 2024 15:48:17 +0800 (CST)
Received: from localhost.localdomain (10.99.206.12) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Fri, 12 Jan 2024 15:43:55 +0800
From: Hu Yadi <hu.yadi@h3c.com>
To: <jmorris@namei.org>, <serge@hallyn.com>, <shuah@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mic@digikod.net>,
        <amir73il@gmail.com>, <brauner@kernel.org>, <avagin@google.com>
CC: <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <514118380@qq.com>,
        Hu Yadi <hu.yadi@h3c.com>
Subject: [PATCH] selftests/filesystems:fix build error in overlayfs
Date: Fri, 12 Jan 2024 15:40:59 +0800
Message-ID: <20240112074059.29673-1-hu.yadi@h3c.com>
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
X-MAIL:h3cspam02-ex.h3c.com 40C7hs78061086

One build issue comes up due to both mount.h included dev_in_maps.c

In file included from dev_in_maps.c:10:
/usr/include/sys/mount.h:35:3: error: expected identifier before numeric constant
   35 |   MS_RDONLY = 1,  /* Mount read-only.  */
      |   ^~~~~~~~~
In file included from dev_in_maps.c:13:

Remove one of them to solve conflict, another error comes up:

dev_in_maps.c:170:6: error: implicit declaration of function ‘mount’ [-Werror=implicit-function-declaration]
  170 |  if (mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) == -1) {
      |      ^~~~~
cc1: all warnings being treated as errors

and then , add sys_mount definition to solve it
After both above, dev_in_maps.c can be built correctly on my mache(gcc 10.2,glibc-2.32,kernel-5.10)

Signed-off-by: Hu Yadi <hu.yadi@h3c.com>
---
 .../selftests/filesystems/overlayfs/dev_in_maps.c      | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index e19ab0e85709..759f86e7d263 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -10,7 +10,6 @@
 #include <linux/mount.h>
 #include <sys/syscall.h>
 #include <sys/stat.h>
-#include <sys/mount.h>
 #include <sys/mman.h>
 #include <sched.h>
 #include <fcntl.h>
@@ -32,7 +31,11 @@ static int sys_fsmount(int fd, unsigned int flags, unsigned int attr_flags)
 {
 	return syscall(__NR_fsmount, fd, flags, attr_flags);
 }
-
+static int sys_mount(const char *src, const char *tgt, const char *fst,
+		unsigned long flags, const void *data)
+{
+	return syscall(__NR_mount, src, tgt, fst, flags, data);
+}
 static int sys_move_mount(int from_dfd, const char *from_pathname,
 			  int to_dfd, const char *to_pathname,
 			  unsigned int flags)
@@ -166,8 +169,7 @@ int main(int argc, char **argv)
 		ksft_test_result_skip("unable to create a new mount namespace\n");
 		return 1;
 	}
-
-	if (mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) == -1) {
+	if (sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) == -1) {
 		pr_perror("mount");
 		return 1;
 	}
-- 
2.39.3


