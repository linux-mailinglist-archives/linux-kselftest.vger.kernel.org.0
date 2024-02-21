Return-Path: <linux-kselftest+bounces-5138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA1B85D35C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 10:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D6FB21F62
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFFA3D0B3;
	Wed, 21 Feb 2024 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s5A7OW7G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1D3D0B4;
	Wed, 21 Feb 2024 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507364; cv=none; b=LiVsPksQNrwI2/IkmMrWrbuM4YHQNWBGDVcUf4rgePgTJTVslYZE8Prm1+2kE3j2eKdpn7H8RxdqmLSgqLQQZR1tVBnk37EVJwnZpmjqDLgI/3hQZnrHYm5vyQDiB0oRZrH3xRlyfnS+YDqp5sEFELXNlpGfdb0XFp0dUcMZti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507364; c=relaxed/simple;
	bh=xkgrSNcnpOKalVdXXYVqaTxPkhRZgbthmWR7h5oU1Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmvN2gF0T6IsYOrLdZN+fE1NTHLXlXw8sUouRmWBnw4rmP1A1ZSX8XrGrZP/LHUYPKK2nAFlBOGjMNYqLMRSUF2lAnH6w5J7E3YhDW8xlAgCAreLeC6t7tqKCzvGwkAt6KtPA6Qql38zH4TmGd5nxC1rVMCUrjtnBW9TZGnttTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s5A7OW7G; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708507360;
	bh=xkgrSNcnpOKalVdXXYVqaTxPkhRZgbthmWR7h5oU1Ms=;
	h=From:To:Cc:Subject:Date:From;
	b=s5A7OW7G3m/lA2YtUzukRq+hqDADy89s23mso7hIRC81kX5qUYAmQW0ZzuWgtGBEZ
	 mc48oWAQ7647K3943RD1pZBvFSOmuMTwhnTgQ1KEgtBT2T/cwPcYEIlDjevZ+KYP2F
	 VMXUudHG95CYRdbnR6rLYQR5c1hglgfe5IIxXLmkq0dIT9+W5TbpV9UGYOzAktf1Id
	 /nE+vkViUxsete467M1Yvu1JkFzIBjwAh4IjOS6AppenzaygDjh+cAXumlfebc3IHp
	 RNHg3+62WwrEKKngBRI/MlUb0l6LK/EFswYnxQUPNz8fCcC4cH3sY7iQHibIBvX1XZ
	 OlMNmAEbM2Jqg==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E4F93378148F;
	Wed, 21 Feb 2024 09:22:35 +0000 (UTC)
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
Subject: [PATCH bpf-next v2] selftests/bpf: Move test_dev_cgroup to prog_tests
Date: Wed, 21 Feb 2024 14:22:35 +0500
Message-ID: <20240221092248.1945364-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
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
index 0000000000000..980b015a116ff
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
+void test_dev_cgroup(void)
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
2.42.0


