Return-Path: <linux-kselftest+bounces-14468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 612A2941168
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 14:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F771F244FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48681A08CF;
	Tue, 30 Jul 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cU4lKVtN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95477199230;
	Tue, 30 Jul 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722340777; cv=none; b=OFSthdPuygQUArbB5LCqg34vIGk59iM2ZVX2ka0m0J2pVXm4iGuJnZqm8ynp5kztmq60pmaoH4odtcUIQWURPF/JMfPJ8wlWnVA8dxVH9oxfYam8Q+TJOiqv+Pz38KZEwqUMxZ5+txiKY6alOsnUYTuJscL2QoLtYwZdIbeNeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722340777; c=relaxed/simple;
	bh=isl0ezG6+3OepXJnDHfJaDlYd2FxnnA3hSWR0PPlE2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OPv+YJ7yUFOaOKNV8R7DFScDhd5R+5hYN1Ju8TXGrCb86sADgZrMv2+Bw1brBSyo98tK2MTysE+z+6BqvsnaMfprnJa41ZGrrwf7r9UBFPCBK6lj6p8jhIcKB7clZzDq86opCiNnRb0O/8jubWVUG3bCDo1fypbwJXa11a+N1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cU4lKVtN; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 443346000F;
	Tue, 30 Jul 2024 11:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722340767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6U0BaQ/FWgHOAEqug7cSJLGWPRKBnb5UpnKyeZ2uXM=;
	b=cU4lKVtNQFoALdc1PILUNy0PlYKH7Wkcx38Kb9dOthWxIFu+9Coty6NHOnU3s5eeGBiGTO
	IBEndgneeoKzOUVDM+kAbP1MUpkXqYQFTZitev8cDdzOprC46uRaUstpU485/JhVyFDIGw
	2togXZYfPFml1VAXRMUH0D7zGIZGI75kJ4feHUKuKz8qkTSMomoBZu60xH6Wcicpih61og
	j/sy73o4ZqynXYO24Fsa8CaxAXrghRUOGtw/5jyLaztKDVGPAHgT2D7HMGt2kCB0wvLi4m
	6e8hxE+p+S7WT52ob3DX9nvuE09qlqzHat8QVeEecyGihU7l8u4sRKG0pIPwTw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 30 Jul 2024 13:59:12 +0200
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: convert test_dev_cgroup to
 test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240730-convert_dev_cgroup-v3-2-93e573b74357@bootlin.com>
References: <20240730-convert_dev_cgroup-v3-0-93e573b74357@bootlin.com>
In-Reply-To: <20240730-convert_dev_cgroup-v3-0-93e573b74357@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: alexis.lothore@bootlin.com

test_dev_cgroup is defined as a standalone test program, and so is not
executed in CI.

Convert it to test_progs framework so it is tested automatically in CI, and
remove the old test. In order to be able to run it in test_progs, /dev/null
must remain usable, so change the new test to test operations on devices
1:3 as valid, and operations on devices 1:5 (/dev/zero) as invalid.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- delete mknod file only when is has been created
- use bpf_program__attach_cgroup instead of bpf_prog_attach
- reorder subtests
- collect review/ack tags

Changes in v2:
- pass expected return code to subtest function instead of boolean pass/not
  pass
- also pass buffer and buffer size for read/write subtests
- fix faulty fd check on read/write tests expected to fail
---
 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   2 -
 .../testing/selftests/bpf/prog_tests/cgroup_dev.c  | 115 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_dev_cgroup.c      |  85 ---------------
 4 files changed, 115 insertions(+), 88 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 4e4aae8aa7ec..8f14d8faeb0b 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -9,7 +9,6 @@ test_lpm_map
 test_tag
 FEATURE-DUMP.libbpf
 fixdep
-test_dev_cgroup
 /test_progs
 /test_progs-no_alu32
 /test_progs-bpf_gcc
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 564e1fdf80b6..bb02a3540d7a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -69,7 +69,6 @@ endif
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
-	test_dev_cgroup \
 	test_sock test_sockmap get_cgroup_id_user \
 	test_cgroup_storage \
 	test_tcpnotify_user test_sysctl \
@@ -294,7 +293,6 @@ JSON_WRITER		:= $(OUTPUT)/json_writer.o
 CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
 NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
 
-$(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
new file mode 100644
index 000000000000..62a2ca9a0b94
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include "test_progs.h"
+#include "cgroup_helpers.h"
+#include "dev_cgroup.skel.h"
+
+#define TEST_CGROUP "/test-bpf-based-device-cgroup/"
+#define TEST_BUFFER_SIZE 64
+
+static void test_mknod(const char *path, mode_t mode, int dev_major,
+		       int dev_minor, int expected_ret)
+{
+	int ret;
+
+	unlink(path);
+	ret = mknod(path, mode, makedev(dev_major, dev_minor));
+	ASSERT_EQ(ret, expected_ret, "mknod");
+	if (!ret)
+		unlink(path);
+}
+
+static void test_read(const char *path, char *buf, int buf_size,
+		      int expected_ret)
+{
+	int ret, fd;
+
+	fd = open(path, O_RDONLY);
+
+	/* A bare open on unauthorized device should fail */
+	if (expected_ret < 0) {
+		ASSERT_EQ(fd, expected_ret, "open file for read");
+		if (fd >= 0)
+			close(fd);
+		return;
+	}
+
+	if (!ASSERT_OK_FD(fd, "open file for read"))
+		return;
+
+	ret = read(fd, buf, buf_size);
+	ASSERT_EQ(ret, expected_ret, "read");
+
+	close(fd);
+}
+
+static void test_write(const char *path, char *buf, int buf_size,
+		       int expected_ret)
+{
+	int ret, fd;
+
+	fd = open(path, O_WRONLY);
+
+	/* A bare open on unauthorized device should fail */
+	if (expected_ret < 0) {
+		ASSERT_EQ(fd, expected_ret, "open file for write");
+		if (fd >= 0)
+			close(fd);
+		return;
+	}
+
+	if (!ASSERT_OK_FD(fd, "open file for write"))
+		return;
+
+	ret = write(fd, buf, buf_size);
+	ASSERT_EQ(ret, expected_ret, "write");
+
+	close(fd);
+}
+
+void test_cgroup_dev(void)
+{
+	char buf[TEST_BUFFER_SIZE] = "some random test data";
+	struct dev_cgroup *skel;
+	int cgroup_fd;
+
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
+	if (!ASSERT_OK_FD(cgroup_fd, "cgroup switch"))
+		return;
+
+	skel = dev_cgroup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "load program"))
+		goto cleanup_cgroup;
+
+	skel->links.bpf_prog1 =
+		bpf_program__attach_cgroup(skel->progs.bpf_prog1, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.bpf_prog1, "attach_program"))
+		goto cleanup_progs;
+
+	if (test__start_subtest("allow-mknod"))
+		test_mknod("/dev/test_dev_cgroup_null", S_IFCHR, 1, 3, 0);
+
+	if (test__start_subtest("allow-read"))
+		test_read("/dev/urandom", buf, TEST_BUFFER_SIZE,
+			  TEST_BUFFER_SIZE);
+
+	if (test__start_subtest("allow-write"))
+		test_write("/dev/null", buf, TEST_BUFFER_SIZE,
+			   TEST_BUFFER_SIZE);
+
+	if (test__start_subtest("deny-mknod"))
+		test_mknod("/dev/test_dev_cgroup_zero", S_IFCHR, 1, 5, -EPERM);
+
+	if (test__start_subtest("deny-read"))
+		test_read("/dev/random", buf, TEST_BUFFER_SIZE, -EPERM);
+
+	if (test__start_subtest("deny-write"))
+		test_write("/dev/zero", buf, TEST_BUFFER_SIZE, -EPERM);
+
+cleanup_progs:
+	dev_cgroup__destroy(skel);
+cleanup_cgroup:
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/test_dev_cgroup.c b/tools/testing/selftests/bpf/test_dev_cgroup.c
deleted file mode 100644
index 33f544f0005a..000000000000
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
-	/* All operations with /dev/null and /dev/urandom are allowed,
-	 * everything else is forbidden.
-	 */
-	assert(system("rm -f /tmp/test_dev_cgroup_zero") == 0);
-	assert(system("mknod /tmp/test_dev_cgroup_zero c 1 5"));
-	assert(system("rm -f /tmp/test_dev_cgroup_zero") == 0);
-
-	/* /dev/null is whitelisted */
-	assert(system("rm -f /tmp/test_dev_cgroup_null") == 0);
-	assert(system("mknod /tmp/test_dev_cgroup_null c 1 3") == 0);
-	assert(system("rm -f /tmp/test_dev_cgroup_null") == 0);
-
-	assert(system("dd if=/dev/urandom of=/dev/null count=64") == 0);
-
-	/* src is allowed, target is forbidden */
-	assert(system("dd if=/dev/urandom of=/dev/full count=64"));
-
-	/* src is forbidden, target is allowed */
-	assert(system("dd if=/dev/random of=/dev/null count=64"));
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
2.45.2


