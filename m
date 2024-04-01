Return-Path: <linux-kselftest+bounces-6939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB784893ABA
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 13:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A35281B70
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 11:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A06219E0;
	Mon,  1 Apr 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aSZAhOg7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3921105;
	Mon,  1 Apr 2024 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711972299; cv=none; b=Hqj82nzjqbcSRnzYLaoitKD+zkPlfGsenMHfLKAVA+igP/70UrdOmVupimV/xGgyynQ8wy3/7mVNREjX9ai5+0FgzyMGxDiDXzKJRQSv/x8gG6DF0x3BCkmDGaESeMnbq4wMtoccPakWQdU7O4tRIHRaOSjs54X6I9YIr9gE3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711972299; c=relaxed/simple;
	bh=MiTn1QBDoXu4z3m/p6W/aD6j7Th+QhOgpsn4TJ96pM4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hHHkViYMC9bDuTxdaIqK3lO2CqqBfnlhec4TGZ9mXqBDAbek0+CvJJ8JW3XCmaiMBhKQ5JmTIHqWCa7S21wxIi2k3x2G8Eae8+FGqG6142zzHLyor/iBkVJzShxZgY4NVWdSEdphscFIaiAyxWwa1JsOWElOo7o4l5eHEg0I70A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aSZAhOg7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711972295;
	bh=MiTn1QBDoXu4z3m/p6W/aD6j7Th+QhOgpsn4TJ96pM4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=aSZAhOg7s9F54Xk9A+/KBlyVHJkYmKnrD3ue0k6/PKYyKxnxXL677aP/EwKzCpiip
	 BFEUDUPTHZ5zimVyg8xRLy15d3h7kSByWUauNJ6dmiWJlvfyGde65fSo4peW+Ujhrt
	 YRtGf5r9L1Kr7Flh4WC5FhftJ8Z1NYcN8FJDoGHsmaX2IO2yzfNVOGgwFpAI8h2FIc
	 ZNOEGVDfNI/bePkYRyVuNpe7zrdq6LmhtmrUEYRNMGjafxYD8dhIxN7uwGB9BJmj3C
	 uEo0o8pxSGSwTAunV+3F1O7IIrh/86DmcN3G9kdSTtXboGgWf03WqdEzJW0gS6aYte
	 N9uIhELEmiC8Q==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BBED937809D1;
	Mon,  1 Apr 2024 11:51:30 +0000 (UTC)
Message-ID: <737409df-d83e-49cf-bb1a-49436ed2d38a@collabora.com>
Date: Mon, 1 Apr 2024 16:52:02 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Move test_dev_cgroup to
 prog_tests
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>
References: <20240221092248.1945364-1-usama.anjum@collabora.com>
 <a0fb8d9a-ae4d-4fc0-a921-efaa180e1bd7@collabora.com>
 <765ac086-621e-40b9-bbdf-bc1fbbdebf06@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <765ac086-621e-40b9-bbdf-bc1fbbdebf06@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Trying the BPF CI job again by changing test_dev_cgroup to
serial_test_dev_cgroup. I'm not sure if it'll trigger the job or not. Is
there any other way to trigger a CI job for a test patch?

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../selftests/bpf/prog_tests/dev_cgroup.c     | 58 +++++++++++++
 tools/testing/selftests/bpf/test_dev_cgroup.c | 85 -------------------
 2 files changed, 58 insertions(+), 85 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dev_cgroup.c
 delete mode 100644 tools/testing/selftests/bpf/test_dev_cgroup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/dev_cgroup.c
b/tools/testing/selftests/bpf/prog_tests/dev_cgroup.c
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
+	if (!ASSERT_EQ(err, 0, "bpf_query") || (!ASSERT_EQ(prog_cnt, 1,
"bpf_query")))
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
diff --git a/tools/testing/selftests/bpf/test_dev_cgroup.c
b/tools/testing/selftests/bpf/test_dev_cgroup.c
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

