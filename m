Return-Path: <linux-kselftest+bounces-45801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D2C663F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 22:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 15F172902D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CFE322520;
	Mon, 17 Nov 2025 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="mfUBYzLx";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="WNiZKKpl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A47322745;
	Mon, 17 Nov 2025 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414245; cv=none; b=VlECg/2NFVDNDtWf2ajXwJGIAF1DPaVlmDAY4GHeKsLE4ozTZxxVZvf6FxNOubraxt2BddJyyoTsvVsCiqnC7ZUNiO7zFUq5Ar2DgVkiUwSG+IhQ4J9QmP3CZTBGHnw5ZONobN51YhNQ63j25q1aTgObpYCRIKk8nIIHrq3ScDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414245; c=relaxed/simple;
	bh=B38kdrMHbTECguHQL4nEXSKcuExXA6lTdJpnOHgV6Tg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwDg6+6XEEMbPMU/7aeYqeLxa2vJY39MND0lfp4Q8n8wNZ1+phyohrlcXEDKr40iBzSfF8o9A6MrOZ/ytryairTA7wbYKI7IAn7xgglhKQp1266KQ5U5y3fJEKZie1kZjfm1xWMnXk1adM8YyijD8lglF0KPbf9gh4FQcmSc2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=mfUBYzLx; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=WNiZKKpl; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1763414075; bh=6Lz6wJtKB4EA20sscEVO5V5
	GoWLkAYRca3TH8HoBaew=; b=mfUBYzLxKW4LJgTGQRgejkFcTg1u9wp6r3yx3YGv5vhlJCPs7h
	HFYsNDGO+pDqQwLFOzxyUHVopIZrmaG82C/V3R47B7T1bJEeS93S6BQcFp9WZU4lCnQCJr5D5Eg
	UnX3sdEpbC+bb9wP6laBxyaWlfr0KhKmtMJH/AwSEYq+JVcjdmXLQTZucyacuQJoQeY0uwmS5vh
	gQm9UteSQRdA0VVB5zwyD3puklagj2GwuiGC1k8p/x1vy/QpRfDuZw//eqIGHt+pgN89YqB/7en
	0YmqKOCIcwl0fGex+MlEX/zW+kiRKNUMVvxTYMOydOgL7BD31W0QCjc/5SbpN6o3DHQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1763414075; bh=6Lz6wJtKB4EA20sscEVO5V5
	GoWLkAYRca3TH8HoBaew=; b=WNiZKKpl0CB1osFGTYgPaBDoBhbj4GD5eZXlvR/NN1NxySGr9e
	PBBp8djUQpWF7nCwnPsgjSiwPEQFXaPxBNDw==;
From: Daniel Hodges <git@danielhodges.dev>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Daniel Hodges <git@danielhodges.dev>,
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [SELFTESTS] (Test Runners & Infrastructure)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next 2/4] selftests/bpf: Add tests for SHA hash kfuncs
Date: Mon, 17 Nov 2025 16:13:59 -0500
Message-ID: <20251117211413.1394-3-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117211413.1394-1-git@danielhodges.dev>
References: <20251117211413.1394-1-git@danielhodges.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests to validate the SHA-256, SHA-384, and SHA-512 hash kfuncs
introduced in the BPF crypto subsystem. The tests verify both correct
functionality and proper error handling.

Test Data:
All tests use the well-known NIST test vector input "abc" and validate
against the standardized expected outputs for each algorithm. This ensures
the BPF kfunc wrappers correctly delegate to the kernel crypto library.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 .../selftests/bpf/prog_tests/crypto_hash.c    | 129 ++++++++++++++++++
 .../testing/selftests/bpf/progs/crypto_hash.c |  83 +++++++++++
 2 files changed, 212 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_hash.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_hash.c

diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_hash.c b/tools/testing/selftests/bpf/prog_tests/crypto_hash.c
new file mode 100644
index 000000000000..4600dad693d4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/crypto_hash.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "crypto_hash.skel.h"
+
+/* NIST test vectors for SHA-256("abc") */
+static const unsigned char expected_sha256[32] = {
+	0xba, 0x78, 0x16, 0xbf, 0x8f, 0x01, 0xcf, 0xea,
+	0x41, 0x41, 0x40, 0xde, 0x5d, 0xae, 0x22, 0x23,
+	0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17, 0x7a, 0x9c,
+	0xb4, 0x10, 0xff, 0x61, 0xf2, 0x00, 0x15, 0xad
+};
+
+/* NIST test vectors for SHA-384("abc") */
+static const unsigned char expected_sha384[48] = {
+	0xcb, 0x00, 0x75, 0x3f, 0x45, 0xa3, 0x5e, 0x8b,
+	0xb5, 0xa0, 0x3d, 0x69, 0x9a, 0xc6, 0x50, 0x07,
+	0x27, 0x2c, 0x32, 0xab, 0x0e, 0xde, 0xd1, 0x63,
+	0x1a, 0x8b, 0x60, 0x5a, 0x43, 0xff, 0x5b, 0xed,
+	0x80, 0x86, 0x07, 0x2b, 0xa1, 0xe7, 0xcc, 0x23,
+	0x58, 0xba, 0xec, 0xa1, 0x34, 0xc8, 0x25, 0xa7
+};
+
+/* NIST test vectors for SHA-512("abc") */
+static const unsigned char expected_sha512[64] = {
+	0xdd, 0xaf, 0x35, 0xa1, 0x93, 0x61, 0x7a, 0xba,
+	0xcc, 0x41, 0x73, 0x49, 0xae, 0x20, 0x41, 0x31,
+	0x12, 0xe6, 0xfa, 0x4e, 0x89, 0xa9, 0x7e, 0xa2,
+	0x0a, 0x9e, 0xee, 0xe6, 0x4b, 0x55, 0xd3, 0x9a,
+	0x21, 0x92, 0x99, 0x2a, 0x27, 0x4f, 0xc1, 0xa8,
+	0x36, 0xba, 0x3c, 0x23, 0xa3, 0xfe, 0xeb, 0xbd,
+	0x45, 0x4d, 0x44, 0x23, 0x64, 0x3c, 0xe8, 0x0e,
+	0x2a, 0x9a, 0xc9, 0x4f, 0xa5, 0x4c, 0xa4, 0x9f
+};
+
+static void test_sha256_basic(void)
+{
+	struct crypto_hash *skel;
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = crypto_hash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "crypto_hash__open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.test_sha256);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_sha256");
+	ASSERT_EQ(skel->data->sha256_status, 0, "sha256_status");
+	ASSERT_EQ(memcmp(skel->bss->sha256_output, expected_sha256, 32), 0,
+		  "sha256_output_match");
+
+	crypto_hash__destroy(skel);
+}
+
+static void test_sha384_basic(void)
+{
+	struct crypto_hash *skel;
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = crypto_hash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "crypto_hash__open_and_load"))
+		return;
+
+	/* Run SHA-384 test */
+	prog_fd = bpf_program__fd(skel->progs.test_sha384);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_sha384");
+	ASSERT_EQ(skel->data->sha384_status, 0, "sha384_status");
+	ASSERT_EQ(memcmp(skel->bss->sha384_output, expected_sha384, 48), 0,
+		  "sha384_output_match");
+
+	crypto_hash__destroy(skel);
+}
+
+static void test_sha512_basic(void)
+{
+	struct crypto_hash *skel;
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = crypto_hash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "crypto_hash__open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.test_sha512);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_sha512");
+	ASSERT_EQ(skel->data->sha512_status, 0, "sha512_status");
+	ASSERT_EQ(memcmp(skel->bss->sha512_output, expected_sha512, 64), 0,
+		  "sha512_output_match");
+
+	crypto_hash__destroy(skel);
+}
+
+static void test_sha256_invalid_params(void)
+{
+	struct crypto_hash *skel;
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = crypto_hash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "crypto_hash__open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.test_sha256_zero_len);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_zero_len");
+	ASSERT_EQ(skel->data->sha256_status, 0, "zero_len_rejected");
+
+	crypto_hash__destroy(skel);
+}
+
+void test_crypto_hash(void)
+{
+	if (test__start_subtest("sha256_basic"))
+		test_sha256_basic();
+	if (test__start_subtest("sha384_basic"))
+		test_sha384_basic();
+	if (test__start_subtest("sha512_basic"))
+		test_sha512_basic();
+	if (test__start_subtest("sha256_invalid_params"))
+		test_sha256_invalid_params();
+}
diff --git a/tools/testing/selftests/bpf/progs/crypto_hash.c b/tools/testing/selftests/bpf/progs/crypto_hash.c
new file mode 100644
index 000000000000..d01f23557411
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crypto_hash.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+
+unsigned char test_input[3] = "abc";
+
+/* Expected SHA-256 hash of "abc" */
+/* ba7816bf 8f01cfea 414140de 5dae2223 b00361a3 96177a9c b410ff61 f20015ad */
+unsigned char expected_sha256[32] = {
+	0xba, 0x78, 0x16, 0xbf, 0x8f, 0x01, 0xcf, 0xea,
+	0x41, 0x41, 0x40, 0xde, 0x5d, 0xae, 0x22, 0x23,
+	0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17, 0x7a, 0x9c,
+	0xb4, 0x10, 0xff, 0x61, 0xf2, 0x00, 0x15, 0xad
+};
+
+/* Output buffers for test results */
+unsigned char sha256_output[32] = {};
+unsigned char sha384_output[48] = {};
+unsigned char sha512_output[64] = {};
+
+int sha256_status = -1;
+int sha384_status = -1;
+int sha512_status = -1;
+
+/* Declare the SHA hash kfuncs */
+extern int bpf_sha256_hash(const struct bpf_dynptr *data, const struct bpf_dynptr *out) __ksym;
+extern int bpf_sha384_hash(const struct bpf_dynptr *data, const struct bpf_dynptr *out) __ksym;
+extern int bpf_sha512_hash(const struct bpf_dynptr *data, const struct bpf_dynptr *out) __ksym;
+
+SEC("syscall")
+int test_sha256(void *ctx)
+{
+	struct bpf_dynptr input_ptr, output_ptr;
+
+	bpf_dynptr_from_mem(test_input, sizeof(test_input), 0, &input_ptr);
+	bpf_dynptr_from_mem(sha256_output, sizeof(sha256_output), 0, &output_ptr);
+
+	sha256_status = bpf_sha256_hash(&input_ptr, &output_ptr);
+	return 0;
+}
+
+SEC("syscall")
+int test_sha384(void *ctx)
+{
+	struct bpf_dynptr input_ptr, output_ptr;
+
+	bpf_dynptr_from_mem(test_input, sizeof(test_input), 0, &input_ptr);
+	bpf_dynptr_from_mem(sha384_output, sizeof(sha384_output), 0, &output_ptr);
+
+	sha384_status = bpf_sha384_hash(&input_ptr, &output_ptr);
+	return 0;
+}
+
+SEC("syscall")
+int test_sha512(void *ctx)
+{
+	struct bpf_dynptr input_ptr, output_ptr;
+
+	bpf_dynptr_from_mem(test_input, sizeof(test_input), 0, &input_ptr);
+	bpf_dynptr_from_mem(sha512_output, sizeof(sha512_output), 0, &output_ptr);
+
+	sha512_status = bpf_sha512_hash(&input_ptr, &output_ptr);
+	return 0;
+}
+
+SEC("syscall")
+int test_sha256_zero_len(void *ctx)
+{
+	struct bpf_dynptr input_ptr, output_ptr;
+	int ret;
+
+	bpf_dynptr_from_mem(test_input, 0, 0, &input_ptr);
+	bpf_dynptr_from_mem(sha256_output, sizeof(sha256_output), 0, &output_ptr);
+
+	ret = bpf_sha256_hash(&input_ptr, &output_ptr);
+	sha256_status = (ret == -22) ? 0 : ret;
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.51.0


