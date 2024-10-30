Return-Path: <linux-kselftest+bounces-21069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CFD9B5A1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 03:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD871C20DBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 02:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F30191F8A;
	Wed, 30 Oct 2024 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JfbT+1xi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4D64437;
	Wed, 30 Oct 2024 02:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256667; cv=none; b=UDnk2oeCu8igh7lkxy5GWHMDmAf+bficDMOifZW3ZGyis4tTdBobJfXrpweOKZ2yjdlmDru0WcmEopsdgDzSE6bqMBJ5QM1z3aAvVkxnHOGtW0mFpZwQn/+6zejwnItgolOLexo06M9VwGC0PJR7mn4jMggddICcRUIn+sMnxxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256667; c=relaxed/simple;
	bh=9hPKqNQjyusRoKaJAkDgVlScXaFG/rUGQKYmVM9MmLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aED5bSRYEHMAJeGmL2CjtTZNwKKnPDmijHlCLxePFXguh/QsSCQujm+MW4GvvISdkK1+vAn1EC8lEBJenioD7iamswKw3adHFhxFg+MPEG3YHAxIpooYe/VU8bo3tAVAcB9HlqxaJNPoCTKblMYg3LCkuvRH9Vg4MMeDU2t3Uxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JfbT+1xi; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0CaPG
	GT5Nb49Lgi2Fhlg+7izeIcy26jCF0+UBWrjnmk=; b=JfbT+1xijGs6miiyCn0nz
	6pXVX+GiU72HFboIOkjktudVBO1jrqWGf+3vJ7kP4eP91xszXGpbQXEMr8JCFq4V
	9Htq+/+7foc1iiyK63tN09Xp8oSgatRjKy7onYWXGlLiEZKhqV7ESiVCqG/g3LAk
	ZLf8lM9ns9zFFqyh/FA3L8=
Received: from localhost.localdomain (unknown [111.48.69.246])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3_wIMnyFnWR+xEA--.876S2;
	Wed, 30 Oct 2024 10:50:53 +0800 (CST)
From: zhouyuhang <zhouyuhang1010@163.com>
To: brauner@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhouyuhang <zhouyuhang@kylinos.cn>
Subject: [PATCH v3] selftests: clone3: Use the capget and capset syscall directly
Date: Wed, 30 Oct 2024 10:50:45 +0800
Message-Id: <20241030025045.1156941-1-zhouyuhang1010@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_wIMnyFnWR+xEA--.876S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4kWr4kJrWkJryxuF48JFb_yoW5KF18pa
	ykJrsxKrs5Wr1xGFWFywsruFnYkF95Xw47Jr1UAw1jkr1akr4xtF4FkFyqq3Wj9ayDu3yY
	qa18KayxZFyDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07juFALUUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiYAKIJmchlfLjjgAAsA

From: zhouyuhang <zhouyuhang@kylinos.cn>

The libcap commit aca076443591 ("Make cap_t operations thread safe.")
added a __u8 mutex at the beginning of the struct _cap_struct, it changes
the offset of the members in the structure that breaks the assumption
made in the "struct libcap" definition in clone3_cap_checkpoint_restore.c.
This will cause the test case to fail with the following output:

 #  RUN           global.clone3_cap_checkpoint_restore ...
 # clone3() syscall supported
 # clone3_cap_checkpoint_restore.c:151:clone3_cap_checkpoint_restore:Child has PID 130508
 cap_set_proc: Operation not permitted
 # clone3_cap_checkpoint_restore.c:160:clone3_cap_checkpoint_restore:Expected set_capability() (-1) == 0 (0)
 # clone3_cap_checkpoint_restore.c:161:clone3_cap_checkpoint_restore:Could not set CAP_CHECKPOINT_RESTORE
 # clone3_cap_checkpoint_restore: Test terminated by assertion
 #          FAIL  global.clone3_cap_checkpoint_restore

Changing to using capget and capset syscall directly here can fix this error,
just like what the commit 663af70aabb7 ("bpf: selftests: Add helpers to directly
use the capget and capset syscall") does.

Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
---
 .../clone3/clone3_cap_checkpoint_restore.c    | 58 +++++++++----------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 3c196fa86c99..8b61702bf721 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -27,6 +27,13 @@
 #include "../kselftest_harness.h"
 #include "clone3_selftests.h"
 
+/*
+ * Prevent not being defined in the header file
+ */
+#ifndef CAP_CHECKPOINT_RESTORE
+#define CAP_CHECKPOINT_RESTORE 40
+#endif
+
 static void child_exit(int ret)
 {
 	fflush(stdout);
@@ -87,47 +94,36 @@ static int test_clone3_set_tid(struct __test_metadata *_metadata,
 	return ret;
 }
 
-struct libcap {
-	struct __user_cap_header_struct hdr;
-	struct __user_cap_data_struct data[2];
-};
-
 static int set_capability(void)
 {
-	cap_value_t cap_values[] = { CAP_SETUID, CAP_SETGID };
-	struct libcap *cap;
-	int ret = -1;
-	cap_t caps;
-
-	caps = cap_get_proc();
-	if (!caps) {
-		perror("cap_get_proc");
+	struct __user_cap_data_struct data[2];
+	struct __user_cap_header_struct hdr = {
+		.version = _LINUX_CAPABILITY_VERSION_3,
+	};
+	__u32 cap0 = 1 << CAP_SETUID | 1 << CAP_SETGID;
+	__u32 cap1 = 1 << (CAP_CHECKPOINT_RESTORE - 32);
+	int ret;
+
+	ret = capget(&hdr, data);
+	if (ret) {
+		perror("capget");
 		return -1;
 	}
 
 	/* Drop all capabilities */
-	if (cap_clear(caps)) {
-		perror("cap_clear");
-		goto out;
-	}
-
-	cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_values, CAP_SET);
-	cap_set_flag(caps, CAP_PERMITTED, 2, cap_values, CAP_SET);
+	memset(&data, 0, sizeof(data));
 
-	cap = (struct libcap *) caps;
+	data[0].effective |= cap0;
+	data[0].permitted |= cap0;
 
-	/* 40 -> CAP_CHECKPOINT_RESTORE */
-	cap->data[1].effective |= 1 << (40 - 32);
-	cap->data[1].permitted |= 1 << (40 - 32);
+	data[1].effective |= cap1;
+	data[1].permitted |= cap1;
 
-	if (cap_set_proc(caps)) {
-		perror("cap_set_proc");
-		goto out;
+	ret = capset(&hdr, data);
+	if (ret) {
+		perror("capset");
+		return -1;
 	}
-	ret = 0;
-out:
-	if (cap_free(caps))
-		perror("cap_free");
 	return ret;
 }
 
-- 
2.27.0


