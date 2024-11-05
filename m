Return-Path: <linux-kselftest+bounces-21444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDBF9BC56F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 07:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC311C217C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 06:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FA81DB54C;
	Tue,  5 Nov 2024 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NyUW0/Va"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9BD2A1A4;
	Tue,  5 Nov 2024 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730788232; cv=none; b=nM8pmiGtaPACXrL5VF1RtjGmYJSwXR1RLbfIX11fOvoE4+Ce4c1bD47aqcTWZlLCdhAqXvOnKKnquUXe/AuV49LS+OPVSvCEBeZYsbc2okymQflK91Sbn4RhEG0X3dxgP9YfNToB6TAzn7pLAHtLyQSTfCxAYYBhtJ3xU/7ILGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730788232; c=relaxed/simple;
	bh=kjbESFFWG4BDe9MOncRwl06BAfbr906Lw3teZlqXl3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qvV4sRZLTnInnTnAYn8CtcgzOM2M4ymzB4ZueQW/dB+4xniIR3o1tF1xuXVaKQiEd5MtxOJl8ip3pNsgecCA+NJRfRavwTkpNcIIBAZN6em/bvf6zhA5WZodJP5M4y5U563UUTh45KKAAB7c5F/aq2goNklc1uN3dbavCF9k4xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NyUW0/Va; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=D9tVf
	W7C3vZfeOWSUmemUKmWuGxkufuqBcJukZRo+L0=; b=NyUW0/VaMYhK45P6ucsOU
	Rhynz7Wo9h/vxa+F+/dwarL/AWxvBuRJtpm+M72fSVTjItdgo8n9syfyQBO4/kjE
	46wux9z56hP9DGfFTjOW5oIBLQoHRzW8B+jOJeWizoxp+Bfkc/sQOVtURPNhOM7l
	+YCKIxbAT/Tk8ifnNywpmQ=
Received: from localhost.localdomain (unknown [111.48.69.246])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDXNVpluylnIOXNCQ--.54265S2;
	Tue, 05 Nov 2024 14:29:57 +0800 (CST)
From: zhouyuhang <zhouyuhang1010@163.com>
To: brauner@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhouyuhang <zhouyuhang@kylinos.cn>
Subject: [PATCH v4] selftests: clone3: Use the capget and capset syscall directly
Date: Tue,  5 Nov 2024 14:29:48 +0800
Message-Id: <20241105062948.1037011-1-zhouyuhang1010@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDXNVpluylnIOXNCQ--.54265S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw4ftw1fur4DGFWUCF1fXrb_yoWxAry7pa
	1kZr45Krs0gw1xJFWFywnruF10yFyrZr17Jw1UAw1fCr1akrs7tr4Sk3Wjq3Wj9a9xZwn8
	XF1jkan7ZF9rAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07juFALUUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiLxaOJmcpsknGWwAAs5

From: zhouyuhang <zhouyuhang@kylinos.cn>

The libcap commit aca076443591 ("Make cap_t operations thread safe.")
added a __u8 mutex at the beginning of the struct _cap_struct, it changes
the offset of the members in the structure that breaks the assumption
made in the "struct libcap" definition in clone3_cap_checkpoint_restore.c.
This causes the call to cap_set_proc here to fail with error code EPERM,
and the output is as follows:

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
The output is as follows:

 #  RUN           global.clone3_cap_checkpoint_restore ...
 # clone3() syscall supported
 # clone3_cap_checkpoint_restore.c:160:clone3_cap_checkpoint_restore:Child has PID 23708
 # clone3_cap_checkpoint_restore.c:91:clone3_cap_checkpoint_restore:[23707] Trying clone3() with CLONE_SET_TID to 23708
 # clone3_cap_checkpoint_restore.c:58:clone3_cap_checkpoint_restore:Operation not permitted - Failed to create new process
 # clone3_cap_checkpoint_restore.c:93:clone3_cap_checkpoint_restore:[23707] clone3() with CLONE_SET_TID 23708 says:-1
 # clone3_cap_checkpoint_restore.c:91:clone3_cap_checkpoint_restore:[23707] Trying clone3() with CLONE_SET_TID to 23708
 # clone3_cap_checkpoint_restore.c:73:clone3_cap_checkpoint_restore:I am the parent (23707). My child's pid is 23708
 # clone3_cap_checkpoint_restore.c:66:clone3_cap_checkpoint_restore:I am the child, my PID is 23708 (expected 23708)
 # clone3_cap_checkpoint_restore.c:93:clone3_cap_checkpoint_restore:[23707] clone3() with CLONE_SET_TID 23708 says:0
 #            OK  global.clone3_cap_checkpoint_restore
 ok 1 global.clone3_cap_checkpoint_restore
 # PASSED: 1 / 1 tests passed.

Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
---
v4:
	* Add some comments and modify the output and return value when set_capability fails
v3:
	* Remove locally declared system calls and retained the - lcap in the Makefile.
v2:
	* Move locally declared system calls to header file.
v1:
	* Directly using capget and capset and declare them locally.
---
 .../clone3/clone3_cap_checkpoint_restore.c    | 77 +++++++++++--------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 3c196fa86c99..076f9d4cce60 100644
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
@@ -87,47 +94,49 @@ static int test_clone3_set_tid(struct __test_metadata *_metadata,
 	return ret;
 }
 
-struct libcap {
-	struct __user_cap_header_struct hdr;
+static int set_capability(struct __test_metadata *_metadata)
+{
 	struct __user_cap_data_struct data[2];
-};
 
-static int set_capability(void)
-{
-	cap_value_t cap_values[] = { CAP_SETUID, CAP_SETGID };
-	struct libcap *cap;
-	int ret = -1;
-	cap_t caps;
-
-	caps = cap_get_proc();
-	if (!caps) {
-		perror("cap_get_proc");
-		return -1;
-	}
+	/*
+	 * Only _LINUX_CAPABILITY_VERSION_3 can be used here.
+	 * _LINUX_CAPABILITY_VERSION_1 represents use 32-bit capabilities,
+	 * using it will cause CAP_CHECKPOINT_RESTORE to not be set.
+	 * _LINUX_CAPABILITY_VERSION_2 has already been deprecated.
+	 */
+	struct __user_cap_header_struct hdr = {
+		.version = _LINUX_CAPABILITY_VERSION_3,
+	};
 
-	/* Drop all capabilities */
-	if (cap_clear(caps)) {
-		perror("cap_clear");
-		goto out;
+	/*
+	 * CAP_CHECKPOINT_RESTORE is greater than 31, so we need two u32.
+	 * cap0 is the lower 32bit and cap1 is the higher 32bit, they will
+	 * be combined into a u64 in mk_kernel_cap.
+	 */
+	__u32 cap0 = 1 << CAP_SETUID | 1 << CAP_SETGID;
+	__u32 cap1 = 1 << (CAP_CHECKPOINT_RESTORE - 32);
+	int ret;
+
+	ret = capget(&hdr, data);
+	if (ret) {
+		TH_LOG("%s - Failed to get capability", strerror(errno));
+		return -errno;
 	}
 
-	cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_values, CAP_SET);
-	cap_set_flag(caps, CAP_PERMITTED, 2, cap_values, CAP_SET);
+	/* Drop all capabilities */
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
+		TH_LOG("%s - Failed to set capability", strerror(errno));
+		return -errno;
 	}
-	ret = 0;
-out:
-	if (cap_free(caps))
-		perror("cap_free");
 	return ret;
 }
 
@@ -157,7 +166,7 @@ TEST(clone3_cap_checkpoint_restore)
 	/* After the child has finished, its PID should be free. */
 	set_tid[0] = pid;
 
-	ASSERT_EQ(set_capability(), 0)
+	ASSERT_EQ(set_capability(_metadata), 0)
 		TH_LOG("Could not set CAP_CHECKPOINT_RESTORE");
 
 	ASSERT_EQ(prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0), 0);
@@ -169,7 +178,7 @@ TEST(clone3_cap_checkpoint_restore)
 	set_tid[0] = pid;
 	/* This would fail without CAP_CHECKPOINT_RESTORE */
 	ASSERT_EQ(test_clone3_set_tid(_metadata, set_tid, 1), -EPERM);
-	ASSERT_EQ(set_capability(), 0)
+	ASSERT_EQ(set_capability(_metadata), 0)
 		TH_LOG("Could not set CAP_CHECKPOINT_RESTORE");
 	/* This should work as we have CAP_CHECKPOINT_RESTORE as non-root */
 	ASSERT_EQ(test_clone3_set_tid(_metadata, set_tid, 1), 0);
-- 
2.27.0


