Return-Path: <linux-kselftest+bounces-47248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BA5CABE7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 04:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33B0B3006A60
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 03:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD03220487E;
	Mon,  8 Dec 2025 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="GiSdBMeE";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="IOW3PX+3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E5D18E1F;
	Mon,  8 Dec 2025 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765163046; cv=none; b=Lexz+/EWXYAw8vCIwArvr6I6lgN+NiCnreIASkpNoLe8zgqDwI+L7aeDn77Ny0IFNrxZUajDNlowHsRayq9IeM+tpoEIRY5VnexUMk8I1ybfWXBG76mftTZGCmgqT25M+XMWjw/DGdrnU3+oRz5t0B+LFU8yBvVDiNWk/pbqzt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765163046; c=relaxed/simple;
	bh=PruMky51aq1b74UjBSuijf8uUQW9/wmqSaebUUO5YRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwxPZ0e9wB3lmo2v6pNxBTsjVIdt0miejhGKSsRe0j7VrwdZM0IwvpGHTZyRW4yWlXDb+IVsefK7sUDYbMvXJZ3vIEEAWLRiavVuHLuQEgMWePcbT6EPX+clh8hpFLKRueQ9J4Ih0SY3tGO3MJnri0C5wtWkZ2RCGc+pMNu9nMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=GiSdBMeE; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=IOW3PX+3; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1765162878; bh=Vr3um8yPZTbStrtypCcGJMg
	YsEZF0UFd41eY7PNjUuo=; b=GiSdBMeEQxem7XLa0k5AAUdUaXSd4Y485HPO2YvGpCbvdKFh82
	lfs1DHykMYlBGaN9I+Bk2aEFBTV3kTF+WPNAbHB4oegT2D9L6dlxJGDDjrUJE1g9WF3xvuHZ1rE
	7E+Ybgrw/2flOtPUiBheY4mpaegNyYr3DNLnxBrwxNbZPjpbeJPiB9ec5eiRFVAccbS4Nie0v7U
	A42poedere/KUD9hhL2xNq63cCXZ3M8Oj4ahG1k4OGAFvh7SEcn6wZz8y0T1airKgBMevbe+Yep
	H20g1NvryS8R1izx1AroTSPK0TrUTWLNDPhhJftUU1t2DoEeu1gLo6zwGqx1ravSBaw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1765162878; bh=Vr3um8yPZTbStrtypCcGJMg
	YsEZF0UFd41eY7PNjUuo=; b=IOW3PX+3pmGwNB5HKDuLJEQgIstFTIavb63oGqKWkEB94rw2kg
	dLeWWhoj+7qNtqov3fT8ixlIwa6bEFMqgQDg==;
From: Daniel Hodges <git@danielhodges.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	vadim.fedorenko@linux.dev,
	song@kernel.org,
	yatsenko@meta.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	yonghong.song@linux.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v3 4/6] selftests/bpf: Add tests for bpf_crypto_hash kfunc
Date: Sun,  7 Dec 2025 22:01:15 -0500
Message-ID: <20251208030117.18892-5-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208030117.18892-1-git@danielhodges.dev>
References: <20251208030117.18892-1-git@danielhodges.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests to validate the bpf_crypto_hash works properly. The tests
verify both correct functionality and proper error handling.

Test Data:
All tests use the well-known NIST test vector input "abc" and validate
against the standardized expected outputs for each algorithm. This ensures
the BPF kfunc wrappers correctly delegate to the kernel crypto library.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/crypto_hash.c    | 147 ++++++++++++++++++
 .../testing/selftests/bpf/progs/crypto_hash.c | 142 +++++++++++++++++
 3 files changed, 291 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_hash.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_hash.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 558839e3c185..d168b3073cba 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -12,7 +12,9 @@ CONFIG_BPF_SYSCALL=y
 # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
 CONFIG_CGROUP_BPF=y
 CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_HASH2=y
 CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_USER_API=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_USER_API_SKCIPHER=y
diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_hash.c b/tools/testing/selftests/bpf/prog_tests/crypto_hash.c
new file mode 100644
index 000000000000..1d8acbd56e32
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/crypto_hash.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <errno.h>
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
+static struct crypto_hash *setup_skel(void)
+{
+	struct crypto_hash *skel;
+
+	skel = crypto_hash__open_and_load();
+	if (!skel) {
+		/* Skip if kfuncs not available (CONFIG_CRYPTO_HASH2 not set) */
+		if (errno == ENOENT || errno == EINVAL) {
+			test__skip();
+			return NULL;
+		}
+		ASSERT_OK_PTR(skel, "crypto_hash__open_and_load");
+		return NULL;
+	}
+
+	return skel;
+}
+
+static void test_sha256_basic(void)
+{
+	struct crypto_hash *skel;
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = setup_skel();
+	if (!skel)
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
+	skel = setup_skel();
+	if (!skel)
+		return;
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
+	skel = setup_skel();
+	if (!skel)
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
+	skel = setup_skel();
+	if (!skel)
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
index 000000000000..0f9174b3cbd5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crypto_hash.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
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
+/* Declare the crypto kfuncs */
+extern struct bpf_crypto_ctx *bpf_crypto_ctx_create(const struct bpf_crypto_params *params,
+						     u32 params__sz, int *err) __ksym;
+extern void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx) __ksym;
+extern int bpf_crypto_hash(struct bpf_crypto_ctx *ctx, const struct bpf_dynptr *data,
+			   const struct bpf_dynptr *out) __ksym;
+
+SEC("syscall")
+int test_sha256(void *ctx)
+{
+	struct bpf_dynptr input_ptr, output_ptr;
+	struct bpf_crypto_ctx *hash_ctx;
+	struct bpf_crypto_params params = {
+		.type = "hash",
+		.algo = "sha256",
+		.key_len = 0,
+	};
+	int err = 0;
+
+	hash_ctx = bpf_crypto_ctx_create(&params, sizeof(params), &err);
+	if (!hash_ctx) {
+		sha256_status = err;
+		return 0;
+	}
+
+	bpf_dynptr_from_mem(test_input, sizeof(test_input), 0, &input_ptr);
+	bpf_dynptr_from_mem(sha256_output, sizeof(sha256_output), 0, &output_ptr);
+
+	sha256_status = bpf_crypto_hash(hash_ctx, &input_ptr, &output_ptr);
+	bpf_crypto_ctx_release(hash_ctx);
+	return 0;
+}
+
+SEC("syscall")
+int test_sha384(void *ctx)
+{
+	struct bpf_dynptr input_ptr, output_ptr;
+	struct bpf_crypto_ctx *hash_ctx;
+	struct bpf_crypto_params params = {
+		.type = "hash",
+		.algo = "sha384",
+		.key_len = 0,
+	};
+	int err = 0;
+
+	hash_ctx = bpf_crypto_ctx_create(&params, sizeof(params), &err);
+	if (!hash_ctx) {
+		sha384_status = err;
+		return 0;
+	}
+
+	bpf_dynptr_from_mem(test_input, sizeof(test_input), 0, &input_ptr);
+	bpf_dynptr_from_mem(sha384_output, sizeof(sha384_output), 0, &output_ptr);
+
+	sha384_status = bpf_crypto_hash(hash_ctx, &input_ptr, &output_ptr);
+	bpf_crypto_ctx_release(hash_ctx);
+	return 0;
+}
+
+SEC("syscall")
+int test_sha512(void *ctx)
+{
+	struct bpf_dynptr input_ptr, output_ptr;
+	struct bpf_crypto_ctx *hash_ctx;
+	struct bpf_crypto_params params = {
+		.type = "hash",
+		.algo = "sha512",
+		.key_len = 0,
+	};
+	int err = 0;
+
+	hash_ctx = bpf_crypto_ctx_create(&params, sizeof(params), &err);
+	if (!hash_ctx) {
+		sha512_status = err;
+		return 0;
+	}
+
+	bpf_dynptr_from_mem(test_input, sizeof(test_input), 0, &input_ptr);
+	bpf_dynptr_from_mem(sha512_output, sizeof(sha512_output), 0, &output_ptr);
+
+	sha512_status = bpf_crypto_hash(hash_ctx, &input_ptr, &output_ptr);
+	bpf_crypto_ctx_release(hash_ctx);
+	return 0;
+}
+
+SEC("syscall")
+int test_sha256_zero_len(void *ctx)
+{
+	struct bpf_dynptr input_ptr, output_ptr;
+	struct bpf_crypto_ctx *hash_ctx;
+	struct bpf_crypto_params params = {
+		.type = "hash",
+		.algo = "sha256",
+		.key_len = 0,
+	};
+	int err = 0;
+	int ret;
+
+	hash_ctx = bpf_crypto_ctx_create(&params, sizeof(params), &err);
+	if (!hash_ctx) {
+		sha256_status = err;
+		return 0;
+	}
+
+	bpf_dynptr_from_mem(test_input, 0, 0, &input_ptr);
+	bpf_dynptr_from_mem(sha256_output, sizeof(sha256_output), 0, &output_ptr);
+
+	ret = bpf_crypto_hash(hash_ctx, &input_ptr, &output_ptr);
+	sha256_status = (ret == -22) ? 0 : ret;
+	bpf_crypto_ctx_release(hash_ctx);
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.51.0


