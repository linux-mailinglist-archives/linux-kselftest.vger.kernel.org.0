Return-Path: <linux-kselftest+bounces-14233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E50793C35F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620151C21C74
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7849E19D060;
	Thu, 25 Jul 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lKMWRAZy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260419B3F9;
	Thu, 25 Jul 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915557; cv=none; b=th2OynhxEu1rrlyLBGkiG88vnraLn8yZGjAk+SBw4aIucB8npe4TEi0w9KnMqtIntoCaymUxeAnmQ2U3+IxBF3S1m7ZHJiegbVIfdRRp36gn/y4/5A5pU4DsULu2BZQbckK9QC9TI9Acve/fPRin6b9D6wCd/pwgTiyBRCvmy8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915557; c=relaxed/simple;
	bh=zc9t+NuL8SwuCwQTvaIS4OGbnjxe++347upIB3oETfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EEL4y5bvB6codcLNTiEkAqviNQ9RbvQ8lrAmqOIT9K7P2oz2kWSHcXqO2ipJK1Duy8/rnq0+mSqdUB2r32+lGreLR2GYpWA5ChL5qNoZBN0YDjMPFyRWcppl7DARPDz2hptGzd+EtSuNEJHIxCGxfjoj1VOiaAjkByJJdX41RQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lKMWRAZy; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A343E20007;
	Thu, 25 Jul 2024 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721915552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQ83ztEGoqsWGcCUKuX+N4cmCcu3i0ntpa9PAB9DADs=;
	b=lKMWRAZyta/sR0DVSmVIWottkPRSMUKiaoly6IwIPFNNAVap+scIb1fRiKzMq+e81m4izl
	3GTUCUSqOAJohedC792yMHLvSH84f/+LIdSeQ82mLO4aLAPjETnR/PQmE/ktxDN8d8/Tg1
	nRjTfX+WTqAU1iv9z5rBCnLQnXeXQ0d1QaEYzO5v83LOmWhIE5cKyhr2LXs/iuMXjfjkcs
	oC4lUT0QQslndRSiQC7UVbM3gPGfULF2Mhs/3jC6ZqkkUagAQZ1BZImaFNmiErwmkFXCOe
	6tWwcGT/E6AxmmPUmVNEInbzNrKF9ZFIDvGfd2JU26pEqbVXreHYT0kYCX8wAw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 25 Jul 2024 15:51:10 +0200
Subject: [PATCH 2/3] selftests/bpf: convert test_dev_cgroup to test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240725-convert_dev_cgroup-v1-2-2c8cbd487c44@bootlin.com>
References: <20240725-convert_dev_cgroup-v1-0-2c8cbd487c44@bootlin.com>
In-Reply-To: <20240725-convert_dev_cgroup-v1-0-2c8cbd487c44@bootlin.com>
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

test_dev_cgroup is defined as a standalone test program, and so is not
executed in CI.

Convert it to test_progs framework so it is tested automatically in CI, and
remove the old test. In order to be able to run it in test_progs, /dev/null
must remain usable, so change the new test to test operations on devices
1:3 as valid, and operations on devices 1:5 (/dev/zero) as invalid.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   2 -
 .../testing/selftests/bpf/prog_tests/cgroup_dev.c  | 120 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_dev_cgroup.c      |  85 ---------------
 4 files changed, 120 insertions(+), 88 deletions(-)

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
index aeada478e37a..2a9ba2246f80 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -69,7 +69,6 @@ endif
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
-	test_dev_cgroup \
 	test_sock test_sockmap get_cgroup_id_user \
 	test_cgroup_storage \
 	test_tcpnotify_user test_sysctl \
@@ -295,7 +294,6 @@ JSON_WRITER		:= $(OUTPUT)/json_writer.o
 CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
 NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
 
-$(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
new file mode 100644
index 000000000000..5112b99213ad
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
@@ -0,0 +1,120 @@
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
+		       int dev_minor, int should_fail)
+{
+	int ret;
+
+	unlink(path);
+	ret = mknod(path, mode, makedev(dev_major, dev_minor));
+	if (should_fail)
+		ASSERT_ERR(ret, "mknod");
+	else
+		ASSERT_OK(ret, "mknod");
+	unlink(path);
+}
+
+static void test_read(const char *path, int should_fail)
+{
+	char buf[TEST_BUFFER_SIZE];
+	int ret, fd;
+
+	fd = open(path, O_RDONLY);
+
+	/* A bare open on unauthorized device should fail */
+	if (should_fail) {
+		ASSERT_ERR(fd, "open file for read");
+		if (fd)
+			close(fd);
+		return;
+	}
+
+	if (!ASSERT_OK_FD(fd, "open file for read"))
+		return;
+
+	ret = read(fd, buf, TEST_BUFFER_SIZE);
+	if (should_fail)
+		ASSERT_ERR(ret, "read");
+	else
+		ASSERT_EQ(ret, TEST_BUFFER_SIZE, "read");
+
+	close(fd);
+}
+
+static void test_write(const char *path, int should_fail)
+{
+	char buf[] = "some random test data";
+	int ret, fd;
+
+	fd = open(path, O_WRONLY);
+
+	/* A bare open on unauthorized device should fail */
+	if (should_fail) {
+		ASSERT_ERR(fd, "open file for write");
+		if (fd)
+			close(fd);
+		return;
+	}
+
+	if (!ASSERT_OK_FD(fd, "open file for write"))
+		return;
+
+	ret = write(fd, buf, sizeof(buf));
+	if (should_fail)
+		ASSERT_ERR(ret, "write");
+	else
+		ASSERT_EQ(ret, sizeof(buf), "write");
+
+	close(fd);
+}
+
+void test_cgroup_dev(void)
+{
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
+	if (!ASSERT_OK(bpf_prog_attach(bpf_program__fd(skel->progs.bpf_prog1),
+				       cgroup_fd, BPF_CGROUP_DEVICE, 0),
+		       "attach_program"))
+		goto cleanup_progs;
+
+	if (test__start_subtest("deny-mknod"))
+		test_mknod("/dev/test_dev_cgroup_zero", S_IFCHR, 1, 5, 1);
+
+	if (test__start_subtest("allow-mknod"))
+		test_mknod("/dev/test_dev_cgroup_null", S_IFCHR, 1, 3, 0);
+
+	if (test__start_subtest("allow-read"))
+		test_read("/dev/urandom", 0);
+
+	if (test__start_subtest("allow-write"))
+		test_write("/dev/null", 0);
+
+	if (test__start_subtest("deny-read"))
+		test_read("/dev/random", 1);
+
+	if (test__start_subtest("deny-write"))
+		test_write("/dev/zero", 1);
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


