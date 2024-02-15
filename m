Return-Path: <linux-kselftest+bounces-4752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5B785626A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 13:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325751F2164E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 12:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E058C12B175;
	Thu, 15 Feb 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zK2Kc5Jf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05357219E0;
	Thu, 15 Feb 2024 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998547; cv=none; b=owHb0aM9GUXRSNIi4W9+4iZz6Yec9a21WL1BO7gVJcbKNJ9BytR14XN0EVTptb97eBVL6hYNVQgwx2rXnZHAHky5Cs61OdfLtrIe1aTw/+suNYDaoKIOsrXgNOYCxIjjiXVLNLxiWlrv+CQrU2eoZCc4I9WtoZkbTGMRdxVrO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998547; c=relaxed/simple;
	bh=C1yoGhOuFqXhiUyUou0BMV7c6tIj5s7JmMbgvjVR7jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BX1hy0mXXkdzCNECMCE7xaN/nUU35IxsKHmkvae4v46RI5TIVM36ek+FVqSDBUbDh3Us1fsrPff7j7s+J3IfTFBaN7nf8IewlQR2Qc37JSNsEEQm45k7oePIUYh4cUZmX0R1s+VG+9flOGJvu3tflHEG6UD1NYmxsUCXDfhM70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zK2Kc5Jf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707998542;
	bh=C1yoGhOuFqXhiUyUou0BMV7c6tIj5s7JmMbgvjVR7jQ=;
	h=From:To:Cc:Subject:Date:From;
	b=zK2Kc5JfLBU+NLuGLInn85iRJ4Ru0l5lREe+4N2i/GPdiJmUIdodM9oVsBm7t/AmF
	 ZpId8bOcH4FCXP/7vn3HFpe9OPJ3PbQ4OuNgZku9BKJbvXHIPfDiScAHKZeFk7yk4n
	 p56QilzqUWmF4+BphMXSJ/GO/v/k7dHQN2j6B19MW7v5hZD4MjG2RHJxt6iM3kn2cE
	 9VQBZ5w1Y56kF7B8OHqK3rkOlMdGAiRf8XkZdG4F2+jV3YzZlzSiWZSfclJtFjOZ7h
	 itVb8G0YnCERrCEwg5Pk+qJQ527wGYJz6DC4oEMHecOSLaBKiuPhwRyzIDcYGZ74dT
	 5hRYFho/iLj8A==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 59BE537820AD;
	Thu, 15 Feb 2024 12:02:16 +0000 (UTC)
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
Subject: [PATCH] selftests/bpf: Move test_dev_cgroup to prog_tests
Date: Thu, 15 Feb 2024 17:01:42 +0500
Message-ID: <20240215120233.308986-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move test_dev_cgroup to prog_tests to be able to run it with test_progs.
Replace dev_cgroup.bpf.o with skel header file, dev_cgroup.skel.h and
load program from it accourdingly.

  ./test_progs -t test_dev_cgroup
  mknod: /tmp/test_dev_cgroup_null: Operation not permitted
  64+0 records in
  64+0 records out
  32768 bytes (33 kB, 32 KiB) copied, 0.000856684 s, 38.2 MB/s
  dd: failed to open '/dev/full': Operation not permitted
  dd: failed to open '/dev/random': Operation not permitted
  #365     test_dev_cgroup:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
While converting from skeleton APIs, I didn't found direct alternative
of bpf_prog_attach(fd, cgroup_fd, BPF_CGROUP_DEVICE). So I've kept
using the bpf_prog_attach() in this patch.
---
 .../bpf/prog_tests/test_dev_cgroup.c          | 67 +++++++++++++++
 tools/testing/selftests/bpf/test_dev_cgroup.c | 85 -------------------
 2 files changed, 67 insertions(+), 85 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_dev_cgroup.c
 delete mode 100644 tools/testing/selftests/bpf/test_dev_cgroup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_dev_cgroup.c b/tools/testing/selftests/bpf/prog_tests/test_dev_cgroup.c
new file mode 100644
index 0000000000000..ee37ce52dec9f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_dev_cgroup.c
@@ -0,0 +1,67 @@
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
+void test_test_dev_cgroup(void)
+{
+	int cgroup_fd, err, duration = 0;
+	struct dev_cgroup *skel;
+	__u32 prog_cnt;
+
+	skel = dev_cgroup__open_and_load();
+	if (CHECK(!skel, "skel_open_and_load", "failed\n"))
+		goto cleanup;
+
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
+	if (CHECK(cgroup_fd < 0, "cgroup_setup_and_join", "failed: %d\n", cgroup_fd))
+		goto cleanup;
+
+	err = bpf_prog_attach(bpf_program__fd(skel->progs.bpf_prog1), cgroup_fd,
+			      BPF_CGROUP_DEVICE, 0);
+	if (CHECK(err, "bpf_attach", "failed: %d\n", err))
+		goto cleanup;
+
+	err = bpf_prog_query(cgroup_fd, BPF_CGROUP_DEVICE, 0, NULL, NULL, &prog_cnt);
+	if (CHECK(err || prog_cnt != 1, "bpf_query", "failed: %d %d\n", err, prog_cnt))
+		goto cleanup;
+
+	/* All operations with /dev/zero and /dev/urandom are allowed,
+	 * everything else is forbidden.
+	 */
+	CHECK(system("rm -f /tmp/test_dev_cgroup_null"), "rm",
+	      "unexpected rm on _null\n");
+	CHECK(!system("mknod /tmp/test_dev_cgroup_null c 1 3"),
+	      "mknod", "unexpected mknod on _null\n");
+	CHECK(system("rm -f /tmp/test_dev_cgroup_null"), "rm",
+	      "unexpected rm on _null\n");
+
+	/* /dev/zero is whitelisted */
+	CHECK(system("rm -f /tmp/test_dev_cgroup_zero"), "rm",
+	      "unexpected rm on _zero\n");
+	CHECK(system("mknod /tmp/test_dev_cgroup_zero c 1 5"),
+	      "mknod", "unexpected mknod on _zero\n");
+	CHECK(system("rm -f /tmp/test_dev_cgroup_zero"), "rm",
+	      "unexpected rm on _zero\n");
+
+	CHECK(system("dd if=/dev/urandom of=/dev/zero count=64"), "dd",
+	      "unexpected dd on /dev/zero\n");
+
+	/* src is allowed, target is forbidden */
+	CHECK(!system("dd if=/dev/urandom of=/dev/full count=64"), "dd",
+	      "unexpected dd on /dev/full\n");
+
+	/* src is forbidden, target is allowed */
+	CHECK(!system("dd if=/dev/random of=/dev/zero count=64"), "dd",
+	      "unexpected dd on /dev/zero\n");
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
2.42.0


