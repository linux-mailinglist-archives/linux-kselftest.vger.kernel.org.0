Return-Path: <linux-kselftest+bounces-48224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E80CF506A
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 18:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E90730268DF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC5F33ADA1;
	Mon,  5 Jan 2026 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="tUpjItM9";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="9urMZkA7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56831B13B;
	Mon,  5 Jan 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634836; cv=none; b=IPLC6/KeOfe2OvXw7iztlatg/EXK32k7wnqIGCqCOs5kkXDe6vw6r5gOOUh9PtPvjmJC5XStbhMiHFJ4CpQWSoWA5ela2BXG+dIEaodNSuOjZjD+tQvPlAHx0KyqGppsOHQ+aNlXrKt4SdmqT08eDQ+lI0gkhnQ2VmkFGhOmp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634836; c=relaxed/simple;
	bh=lIPnO+kw2886Ju9Xk8DvPqC+wPtM4g3aStXtUa2+qgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bs55IAInBCgcKF0ZNce2+hyF63Y3X6A2zQ3zWJwzDqgHvSNvJ9bdRLoXyyKMOp5CYSERDb7JpfXa3UMMWIGIfTqeii/Z4DQdG8YNKonH0zc2MykMDUajBcRPND6QqI0b7I8JqpBmzn5pA46IcXQbX4c++FmT0S8UAXSX2qamNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=tUpjItM9; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=9urMZkA7; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767634677; bh=U9uDF5+qPxHr49V2MHK2v7G
	XWlBfmcMJXNTrT92Jg+o=; b=tUpjItM9Qal68jCxDxOK+lUlmfciMUflX6ZdKhyaxb7LjtePKJ
	zrxLTrBHxDCfb3792m1eVMhMuQPe4ruLBxFgR2seBRG70Up4eeOXKAoeVtROP2AoNU2LclR/+uc
	atpK9zOqCu0L+ASpZjrbsl3CoZM6YdkSlUnOGZxeMxHLnMoixH26vwdWpOFTe6aYYiAmVHMW9qN
	dbVx8Y7Mvhf3YvtfLSoz321+5zpuNL7N4T+Byu55Rfn/H7KrSvDEpzy2YTTG0a7garODcwHeMzR
	wrYJlUIvgP6GJ41TfpOZfpURRLlcK2Id6RANhT9mLBtr9pHA8JlW2EL7Jk7PLkTN5cg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767634677; bh=U9uDF5+qPxHr49V2MHK2v7G
	XWlBfmcMJXNTrT92Jg+o=; b=9urMZkA7OpbTreqmL/Sbee2zCHFsV9wtyqpxa7V73p5QNS0rbR
	yZInYJitvVf+aj5HU0KNfsSbhhRN+/PeyiCg==;
From: Daniel Hodges <git@danielhodges.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Song Liu <song@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: Add tests for ECDSA signature verification kfuncs
Date: Mon,  5 Jan 2026 12:37:55 -0500
Message-ID: <20260105173755.22515-7-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105173755.22515-1-git@danielhodges.dev>
References: <20260105173755.22515-1-git@danielhodges.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests to validate the ECDSA signature verification kfuncs
introduced in the BPF crypto subsystem. The tests verify both valid
signature acceptance and invalid signature rejection using the
context-based ECDSA API.

The tests use RFC 6979 test vectors for NIST P-256 (secp256r1) with
well-known valid signatures. The algorithm "p1363(ecdsa-nist-p256)"
is used to handle standard r||s signature format.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 MAINTAINERS                                   |   2 +
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/ecdsa_verify.c   |  75 +++++++++
 .../selftests/bpf/progs/ecdsa_verify.c        | 157 ++++++++++++++++++
 4 files changed, 235 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ecdsa_verify.c
 create mode 100644 tools/testing/selftests/bpf/progs/ecdsa_verify.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a413cb1b973c..7d65deb4dd03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4718,7 +4718,9 @@ F:	crypto/bpf_crypto_skcipher.c
 F:	include/linux/bpf_crypto.h
 F:	kernel/bpf/crypto.c
 F:	tools/testing/selftests/bpf/prog_tests/crypto_hash.c
+F:	tools/testing/selftests/bpf/prog_tests/ecdsa_verify.c
 F:	tools/testing/selftests/bpf/progs/crypto_hash.c
+F:	tools/testing/selftests/bpf/progs/ecdsa_verify.c
 
 BPF [DOCUMENTATION] (Related to Standardization)
 R:	David Vernet <void@manifault.com>
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index d168b3073cba..c99811d3f61f 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -15,6 +15,7 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_HASH2=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_ECDSA=y
 CONFIG_CRYPTO_USER_API=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_USER_API_SKCIPHER=y
diff --git a/tools/testing/selftests/bpf/prog_tests/ecdsa_verify.c b/tools/testing/selftests/bpf/prog_tests/ecdsa_verify.c
new file mode 100644
index 000000000000..4e88b3eeb3eb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ecdsa_verify.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "ecdsa_verify.skel.h"
+
+static void test_ecdsa_verify_valid_signature(void)
+{
+	struct ecdsa_verify *skel;
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = ecdsa_verify__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "ecdsa_verify__open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.test_ecdsa_verify_valid);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_ecdsa_verify_valid");
+	ASSERT_EQ(skel->data->ctx_create_status, 0, "ctx_create_status");
+	ASSERT_EQ(skel->data->verify_result, 0, "verify_valid_signature");
+
+	ecdsa_verify__destroy(skel);
+}
+
+static void test_ecdsa_verify_invalid_signature(void)
+{
+	struct ecdsa_verify *skel;
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = ecdsa_verify__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "ecdsa_verify__open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.test_ecdsa_verify_invalid);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_ecdsa_verify_invalid");
+	ASSERT_NEQ(skel->data->verify_invalid_result, 0, "verify_invalid_signature_rejected");
+
+	ecdsa_verify__destroy(skel);
+}
+
+static void test_ecdsa_size_queries(void)
+{
+	struct ecdsa_verify *skel;
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = ecdsa_verify__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "ecdsa_verify__open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.test_ecdsa_size_queries);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_ecdsa_size_queries");
+	ASSERT_EQ(skel->data->keysize_result, 256, "keysize_p256");
+	ASSERT_EQ(skel->data->digestsize_result, 64, "digestsize_p256");
+	ASSERT_EQ(skel->data->maxsize_result, 64, "maxsize_p256");
+
+	ecdsa_verify__destroy(skel);
+}
+
+void test_ecdsa_verify(void)
+{
+	if (test__start_subtest("verify_valid_signature"))
+		test_ecdsa_verify_valid_signature();
+	if (test__start_subtest("verify_invalid_signature"))
+		test_ecdsa_verify_invalid_signature();
+	if (test__start_subtest("size_queries"))
+		test_ecdsa_size_queries();
+}
diff --git a/tools/testing/selftests/bpf/progs/ecdsa_verify.c b/tools/testing/selftests/bpf/progs/ecdsa_verify.c
new file mode 100644
index 000000000000..2dd74995bd3a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ecdsa_verify.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "crypto_common.h"
+
+/* NIST P-256 test vector
+ * This is a known valid ECDSA signature for testing purposes
+ */
+
+/* Public key in uncompressed format: 0x04 || x || y (65 bytes) */
+unsigned char pubkey_p256[65] = {
+	0x04, /* Uncompressed point indicator */
+	/* X coordinate (32 bytes) */
+	0x60, 0xfe, 0xd4, 0xba, 0x25, 0x5a, 0x9d, 0x31,
+	0xc9, 0x61, 0xeb, 0x74, 0xc6, 0x35, 0x6d, 0x68,
+	0xc0, 0x49, 0xb8, 0x92, 0x3b, 0x61, 0xfa, 0x6c,
+	0xe6, 0x69, 0x62, 0x2e, 0x60, 0xf2, 0x9f, 0xb6,
+	/* Y coordinate (32 bytes) */
+	0x79, 0x03, 0xfe, 0x10, 0x08, 0xb8, 0xbc, 0x99,
+	0xa4, 0x1a, 0xe9, 0xe9, 0x56, 0x28, 0xbc, 0x64,
+	0xf2, 0xf1, 0xb2, 0x0c, 0x2d, 0x7e, 0x9f, 0x51,
+	0x77, 0xa3, 0xc2, 0x94, 0xd4, 0x46, 0x22, 0x99
+};
+
+/* Message hash (32 bytes) - SHA-256 of "sample" */
+unsigned char message_hash[32] = {
+	0xaf, 0x2b, 0xdb, 0xe1, 0xaa, 0x9b, 0x6e, 0xc1,
+	0xe2, 0xad, 0xe1, 0xd6, 0x94, 0xf4, 0x1f, 0xc7,
+	0x1a, 0x83, 0x1d, 0x02, 0x68, 0xe9, 0x89, 0x15,
+	0x62, 0x11, 0x3d, 0x8a, 0x62, 0xad, 0xd1, 0xbf
+};
+
+/* Valid signature r || s (64 bytes) */
+unsigned char valid_signature[64] = {
+	/* r component (32 bytes) */
+	0xef, 0xd4, 0x8b, 0x2a, 0xac, 0xb6, 0xa8, 0xfd,
+	0x11, 0x40, 0xdd, 0x9c, 0xd4, 0x5e, 0x81, 0xd6,
+	0x9d, 0x2c, 0x87, 0x7b, 0x56, 0xaa, 0xf9, 0x91,
+	0xc3, 0x4d, 0x0e, 0xa8, 0x4e, 0xaf, 0x37, 0x16,
+	/* s component (32 bytes) */
+	0xf7, 0xcb, 0x1c, 0x94, 0x2d, 0x65, 0x7c, 0x41,
+	0xd4, 0x36, 0xc7, 0xa1, 0xb6, 0xe2, 0x9f, 0x65,
+	0xf3, 0xe9, 0x00, 0xdb, 0xb9, 0xaf, 0xf4, 0x06,
+	0x4d, 0xc4, 0xab, 0x2f, 0x84, 0x3a, 0xcd, 0xa8
+};
+
+/* Invalid signature (modified r component) for negative test */
+unsigned char invalid_signature[64] = {
+	/* r component (32 bytes) - first byte modified */
+	0xff, 0xd4, 0x8b, 0x2a, 0xac, 0xb6, 0xa8, 0xfd,
+	0x11, 0x40, 0xdd, 0x9c, 0xd4, 0x5e, 0x81, 0xd6,
+	0x9d, 0x2c, 0x87, 0x7b, 0x56, 0xaa, 0xf9, 0x91,
+	0xc3, 0x4d, 0x0e, 0xa8, 0x4e, 0xaf, 0x37, 0x16,
+	/* s component (32 bytes) */
+	0xf7, 0xcb, 0x1c, 0x94, 0x2d, 0x65, 0x7c, 0x41,
+	0xd4, 0x36, 0xc7, 0xa1, 0xb6, 0xe2, 0x9f, 0x65,
+	0xf3, 0xe9, 0x00, 0xdb, 0xb9, 0xaf, 0xf4, 0x06,
+	0x4d, 0xc4, 0xab, 0x2f, 0x84, 0x3a, 0xcd, 0xa8
+};
+
+/* Test results */
+int verify_result = -1;
+int verify_invalid_result = -1;
+int ctx_create_status = -1;
+int keysize_result = -1;
+int digestsize_result = -1;
+int maxsize_result = -1;
+
+SEC("syscall")
+int test_ecdsa_verify_valid(void *ctx)
+{
+	struct bpf_crypto_ctx *ecdsa_ctx;
+	struct bpf_crypto_params params = {
+		.type = "sig",
+		.algo = "p1363(ecdsa-nist-p256)",
+		.key_len = sizeof(pubkey_p256),
+	};
+	struct bpf_dynptr msg_ptr, sig_ptr;
+	int err = 0;
+
+	__builtin_memcpy(params.key, pubkey_p256, sizeof(pubkey_p256));
+
+	ecdsa_ctx = bpf_crypto_ctx_create(&params, sizeof(params), &err);
+	if (!ecdsa_ctx) {
+		ctx_create_status = err;
+		return 0;
+	}
+	ctx_create_status = 0;
+
+	bpf_dynptr_from_mem(message_hash, sizeof(message_hash), 0, &msg_ptr);
+	bpf_dynptr_from_mem(valid_signature, sizeof(valid_signature), 0, &sig_ptr);
+
+	verify_result = bpf_ecdsa_verify(ecdsa_ctx, &msg_ptr, &sig_ptr);
+
+	bpf_crypto_ctx_release(ecdsa_ctx);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_ecdsa_verify_invalid(void *ctx)
+{
+	struct bpf_crypto_ctx *ecdsa_ctx;
+	struct bpf_crypto_params params = {
+		.type = "sig",
+		.algo = "p1363(ecdsa-nist-p256)",
+		.key_len = sizeof(pubkey_p256),
+	};
+	struct bpf_dynptr msg_ptr, sig_ptr;
+	int err = 0;
+
+	__builtin_memcpy(params.key, pubkey_p256, sizeof(pubkey_p256));
+
+	ecdsa_ctx = bpf_crypto_ctx_create(&params, sizeof(params), &err);
+	if (!ecdsa_ctx)
+		return 0;
+
+	bpf_dynptr_from_mem(message_hash, sizeof(message_hash), 0, &msg_ptr);
+	bpf_dynptr_from_mem(invalid_signature, sizeof(invalid_signature), 0, &sig_ptr);
+
+	verify_invalid_result = bpf_ecdsa_verify(ecdsa_ctx, &msg_ptr, &sig_ptr);
+
+	bpf_crypto_ctx_release(ecdsa_ctx);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_ecdsa_size_queries(void *ctx)
+{
+	struct bpf_crypto_ctx *ecdsa_ctx;
+	struct bpf_crypto_params params = {
+		.type = "sig",
+		.algo = "p1363(ecdsa-nist-p256)",
+		.key_len = sizeof(pubkey_p256),
+	};
+	int err = 0;
+
+	__builtin_memcpy(params.key, pubkey_p256, sizeof(pubkey_p256));
+
+	ecdsa_ctx = bpf_crypto_ctx_create(&params, sizeof(params), &err);
+	if (!ecdsa_ctx)
+		return 0;
+
+	keysize_result = bpf_ecdsa_keysize(ecdsa_ctx);
+	digestsize_result = bpf_ecdsa_digestsize(ecdsa_ctx);
+	maxsize_result = bpf_ecdsa_maxsize(ecdsa_ctx);
+
+	bpf_crypto_ctx_release(ecdsa_ctx);
+
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.51.0


