Return-Path: <linux-kselftest+bounces-6941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B79D893AFD
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 14:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8021F215B1
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B90E3BB29;
	Mon,  1 Apr 2024 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f475f+rY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2C3A262;
	Mon,  1 Apr 2024 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711974885; cv=none; b=Ilvfs+p2/NqCaDoPo74B979Hahio3qlkJQMgg3YCTp8NrrXxCiYhJSu05vgInze0DQN0282h4Tx8A9oXBom7NXucTQGCdTAoAj3HGQpc7yz1CctA9hjDrIKmv4y4bOxc4TUMuTwhygz6+4X73TaY3V5AKZ/Bao5xJki3oJunp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711974885; c=relaxed/simple;
	bh=U4HB7FzetW57SkZCwImf3w3sHh/l9bhoKvxCMenzM9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YdcPXf7W2F5/zp8hSRdxRLyc5WzlGSLUAB0JLrZmMPRmK8Pqcd4G2u2VofaJ03mkx6yc6bNCtvIPCrEuY3HnPzYSEsZ1jdwIUzkrRMNgJa6ZvJHj7QyH+CA0D3KP+mTuF+PEpUwIuv0lRFcWO2LvzqUvY+IF53vY64hmRA0Ifeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f475f+rY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711974881;
	bh=U4HB7FzetW57SkZCwImf3w3sHh/l9bhoKvxCMenzM9E=;
	h=From:To:Cc:Subject:Date:From;
	b=f475f+rYVd4mwwx3N5umsoi5aQZqDOS4vW0+QEaTltJtvZ952oat6bUjI0ZKzTqdY
	 KuZuXHXcZ6ZPlYNh0yDAAUxAHaKpFkpqeX8weikPv92piQTELYFrSMzO4dWmFk7HVV
	 +750p/WbETf2Jxci7vdRzbjcCSXv6piNg8WFfW3VF4L74JaDuXiAhXpKffEn9nu13s
	 VR+Zthmw78omuXPlk1klovRmrccvsM0eYgyTnJFmOhEDn0/6MRsvjCQZdpkFBLyc4i
	 A6bPik1Hr41REee1/Ci+2HSpLwqF0/ZNjd/jFAcdFbmEdOd4gY0WTu+0Mxkcoe7hCf
	 gjPaSVqEVDeQg==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EBA7437813B6;
	Mon,  1 Apr 2024 12:34:34 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3] selftests/bpf: Move test_dev_cgroup to prog_tests
Date: Mon,  1 Apr 2024 17:34:45 +0500
Message-Id: <20240401123455.1377896-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move test_dev_cgroup.c to prog_tests/dev_cgroup.c to be able to run it
with test_progs. Replace dev_cgroup.bpf.o with skel header file,
dev_cgroup.skel.h and load program from it accourdingly.

  ./test_progs -t dev_cgroup
  mknod: /tmp/test_dev_cgroup_null: Operation not permitted
  64+0 records in
  64+0 records out
  32768 bytes (33 kB, 32 KiB) copied, 0.000856684 s, 38.2 MB/s
  dd: failed to open '/dev/full': Operation not permitted
  dd: failed to open '/dev/random': Operation not permitted
  #72     test_dev_cgroup:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v2:
- Replace test_dev_cgroup with serial_test_dev_cgroup as there is
  probability that the test is racing against another cgroup test
- Minor changes to the commit message above

I've tested the patch with vmtest.sh on bpf-next/for-next and linux
next. It is passing on both. Not sure why it was failed on BPFCI.
Test run with vmtest.h:
sudo LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh ./test_progs -t dev_cgroup
./test_progs -t dev_cgroup
mknod: /tmp/test_dev_cgroup_null: Operation not permitted
64+0 records in
64+0 records out
32768 bytes (33 kB, 32 KiB) copied, 0.000403432 s, 81.2 MB/s
dd: failed to open '/dev/full': Operation not permitted
dd: failed to open '/dev/random': Operation not permitted
 #69      dev_cgroup:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Changes since v1:
- Rename file from test_dev_cgroup.c to dev_cgroup.c
- Use ASSERT_* in-place of CHECK
---
 .../selftests/bpf/prog_tests/dev_cgroup.c     | 58 +++++++++++++
 tools/testing/selftests/bpf/test_dev_cgroup.c | 85 -------------------
 2 files changed, 58 insertions(+), 85 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dev_cgroup.c
 delete mode 100644 tools/testing/selftests/bpf/test_dev_cgroup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/dev_cgroup.c b/tools/testing/selftests/bpf/prog_tests/dev_cgroup.c
new file mode 100644
index 0000000000000..da0bc209d6a21
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/dev_cgroup.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2017 Facebook
+ */
+
+#include <test_progs.h>
+#include <time.h>
+#include "cgroup_helpers.h"
+#include "dev_cgroup.skel.h"
+
+#define TEST_CGROUP "/test-bpf-based-device-cgroup/"
+
+void serial_test_dev_cgroup(void)
+{
+	struct dev_cgroup *skel;
+	int cgroup_fd, err;
+	__u32 prog_cnt;
+
+	skel = dev_cgroup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto cleanup;
+
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
+	if (!ASSERT_GT(cgroup_fd, 0, "cgroup_setup_and_join"))
+		goto cleanup;
+
+	err = bpf_prog_attach(bpf_program__fd(skel->progs.bpf_prog1), cgroup_fd,
+			      BPF_CGROUP_DEVICE, 0);
+	if (!ASSERT_EQ(err, 0, "bpf_attach"))
+		goto cleanup;
+
+	err = bpf_prog_query(cgroup_fd, BPF_CGROUP_DEVICE, 0, NULL, NULL, &prog_cnt);
+	if (!ASSERT_EQ(err, 0, "bpf_query") || (!ASSERT_EQ(prog_cnt, 1, "bpf_query")))
+		goto cleanup;
+
+	/* All operations with /dev/zero and /dev/urandom are allowed,
+	 * everything else is forbidden.
+	 */
+	ASSERT_EQ(system("rm -f /tmp/test_dev_cgroup_null"), 0, "rm");
+	ASSERT_NEQ(system("mknod /tmp/test_dev_cgroup_null c 1 3"), 0, "mknod");
+	ASSERT_EQ(system("rm -f /tmp/test_dev_cgroup_null"), 0, "rm");
+
+	/* /dev/zero is whitelisted */
+	ASSERT_EQ(system("rm -f /tmp/test_dev_cgroup_zero"), 0, "rm");
+	ASSERT_EQ(system("mknod /tmp/test_dev_cgroup_zero c 1 5"), 0, "mknod");
+	ASSERT_EQ(system("rm -f /tmp/test_dev_cgroup_zero"), 0, "rm");
+
+	ASSERT_EQ(system("dd if=/dev/urandom of=/dev/zero count=64"), 0, "dd");
+
+	/* src is allowed, target is forbidden */
+	ASSERT_NEQ(system("dd if=/dev/urandom of=/dev/full count=64"), 0, "dd");
+
+	/* src is forbidden, target is allowed */
+	ASSERT_NEQ(system("dd if=/dev/random of=/dev/zero count=64"), 0, "dd");
+
+cleanup:
+	cleanup_cgroup_environment();
+	dev_cgroup__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/test_dev_cgroup.c b/tools/testing/selftests/bpf/test_dev_cgroup.c
deleted file mode 100644
index adeaf63cb6fa3..0000000000000
--- a/tools/testing/selftests/bpf/test_dev_cgroup.c
+++ /dev/null
@@ -1,85 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2017 Facebook
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-#include <assert.h>
-#include <sys/time.h>
-
-#include <linux/bpf.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "cgroup_helpers.h"
-#include "testing_helpers.h"
-
-#define DEV_CGROUP_PROG "./dev_cgroup.bpf.o"
-
-#define TEST_CGROUP "/test-bpf-based-device-cgroup/"
-
-int main(int argc, char **argv)
-{
-	struct bpf_object *obj;
-	int error = EXIT_FAILURE;
-	int prog_fd, cgroup_fd;
-	__u32 prog_cnt;
-
-	/* Use libbpf 1.0 API mode */
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-
-	if (bpf_prog_test_load(DEV_CGROUP_PROG, BPF_PROG_TYPE_CGROUP_DEVICE,
-			  &obj, &prog_fd)) {
-		printf("Failed to load DEV_CGROUP program\n");
-		goto out;
-	}
-
-	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
-	if (cgroup_fd < 0) {
-		printf("Failed to create test cgroup\n");
-		goto out;
-	}
-
-	/* Attach bpf program */
-	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_DEVICE, 0)) {
-		printf("Failed to attach DEV_CGROUP program");
-		goto err;
-	}
-
-	if (bpf_prog_query(cgroup_fd, BPF_CGROUP_DEVICE, 0, NULL, NULL,
-			   &prog_cnt)) {
-		printf("Failed to query attached programs");
-		goto err;
-	}
-
-	/* All operations with /dev/zero and and /dev/urandom are allowed,
-	 * everything else is forbidden.
-	 */
-	assert(system("rm -f /tmp/test_dev_cgroup_null") == 0);
-	assert(system("mknod /tmp/test_dev_cgroup_null c 1 3"));
-	assert(system("rm -f /tmp/test_dev_cgroup_null") == 0);
-
-	/* /dev/zero is whitelisted */
-	assert(system("rm -f /tmp/test_dev_cgroup_zero") == 0);
-	assert(system("mknod /tmp/test_dev_cgroup_zero c 1 5") == 0);
-	assert(system("rm -f /tmp/test_dev_cgroup_zero") == 0);
-
-	assert(system("dd if=/dev/urandom of=/dev/zero count=64") == 0);
-
-	/* src is allowed, target is forbidden */
-	assert(system("dd if=/dev/urandom of=/dev/full count=64"));
-
-	/* src is forbidden, target is allowed */
-	assert(system("dd if=/dev/random of=/dev/zero count=64"));
-
-	error = 0;
-	printf("test_dev_cgroup:PASS\n");
-
-err:
-	cleanup_cgroup_environment();
-
-out:
-	return error;
-}
-- 
2.39.2


