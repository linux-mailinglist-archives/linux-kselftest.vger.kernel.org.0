Return-Path: <linux-kselftest+bounces-48227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32679CF50DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 18:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BD9B304711F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BC5327206;
	Mon,  5 Jan 2026 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="gnJiEZQZ";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="laZQfacq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB10274B48;
	Mon,  5 Jan 2026 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635060; cv=none; b=Nzq5oc5bOLCB3hgOjkPWndvki/AXwAfdJ+qm7U+6LxgXn5wCi+/QjLh/35d76tSKdqjGTguDrd0SgAWJR50wUlSTmiUzXL0dM37kaAUy/KFkR4g5L22GJabygKWUWZ2Oa9lV/7iO+5cIUBC89McvHh8EEOcU6LG5PcpmDil8P/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635060; c=relaxed/simple;
	bh=cQoG6zPuMPulqqFHwVib7hRRrrQaZYLXQn1yk/MldhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVTjvMpWaNv74YXUHGTBo8qKEUo+kIQIBOXhYDawBE0Z30D2h6PBtL3a7ngmLCgfWzQPk4xUQjEJsaPsduSPmRh2qD5kF7rb3qjAVw10LvSgIqA3rNHecZv4a/WQrfm/rGvc9KJ4OKVnwJPmjUM44OGdWQkAh1kpIHsWvjPeJt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=gnJiEZQZ; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=laZQfacq; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767634677; bh=psRspwxSwofsdvOuCeeS15b
	ALpOWHSbPQu+l/vx/unk=; b=gnJiEZQZRKw/vbwfTlY+X+CW0zFOiI1VK999lFuYhJ1PTgh9pq
	q0KwgR+p5kYYKAO1sswdJooDgzGaVwd6vQHYFx8cmEeOVm9ZdoFMB67gwTHPnnY/xwL3GXlD6bK
	MA7RtMNMCqaDGS3SJn64P210oeW3eEb6ySjx2G8qgVwSPtTxK9Egoi0hfwD6qdCCnUxrgH/S7u8
	Ed7H1ZFaDtbaqbBQPSpf0IMm+0pLLWaYePdbAX/LQ3FeaYXGz+kUSY4LcsBHhXYqz7aTvu2Gcgq
	1R5ih28s6TUoqfnixyKdygPSysV637MW6xw1s8aaYiumnFV8LL4xm611poVcWZaIY7w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767634677; bh=psRspwxSwofsdvOuCeeS15b
	ALpOWHSbPQu+l/vx/unk=; b=laZQfacqBtBpc8crIrs9RB0AHLXhPZCsGLgJ4JyBQs0IupSlZn
	kt7AUjray0oqtrHDg1cW7I4+Nf1Ub7kQkzCA==;
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
Subject: [PATCH bpf-next v4 4/6] selftests/bpf: Add tests for bpf_crypto_hash kfunc
Date: Mon,  5 Jan 2026 12:37:53 -0500
Message-ID: <20260105173755.22515-5-git@danielhodges.dev>
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

Add selftests to validate the bpf_crypto_hash works properly. The tests
verify both correct functionality and proper error handling.

Test Data:
All tests use the well-known NIST test vector input "abc" and validate
against the standardized expected outputs for each algorithm. This ensures
the BPF kfunc wrappers correctly delegate to the kernel crypto library.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 MAINTAINERS                                   |   2 +
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/crypto_hash.c    | 147 ++++++++++++++++++
 .../selftests/bpf/progs/crypto_common.h       |   7 +
 .../testing/selftests/bpf/progs/crypto_hash.c | 136 ++++++++++++++++
 5 files changed, 294 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_hash.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_hash.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fdf451bad869..a413cb1b973c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4717,6 +4717,8 @@ F:	crypto/bpf_crypto_sig.c
 F:	crypto/bpf_crypto_skcipher.c
 F:	include/linux/bpf_crypto.h
 F:	kernel/bpf/crypto.c
+F:	tools/testing/selftests/bpf/prog_tests/crypto_hash.c
+F:	tools/testing/selftests/bpf/progs/crypto_hash.c
 
 BPF [DOCUMENTATION] (Related to Standardization)
 R:	David Vernet <void@manifault.com>
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
diff --git a/tools/testing/selftests/bpf/progs/crypto_common.h b/tools/testing/selftests/bpf/progs/crypto_common.h
index 57dd7a68a8c3..c357850b17a6 100644
--- a/tools/testing/selftests/bpf/progs/crypto_common.h
+++ b/tools/testing/selftests/bpf/progs/crypto_common.h
@@ -15,6 +15,13 @@ int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx, const struct bpf_dynptr *src,
 		       const struct bpf_dynptr *dst, const struct bpf_dynptr *iv) __ksym;
 int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx, const struct bpf_dynptr *src,
 		       const struct bpf_dynptr *dst, const struct bpf_dynptr *iv) __ksym;
+int bpf_crypto_hash(struct bpf_crypto_ctx *ctx, const struct bpf_dynptr *data,
+		    const struct bpf_dynptr *out) __ksym;
+int bpf_ecdsa_verify(struct bpf_crypto_ctx *ctx, const struct bpf_dynptr *message,
+		     const struct bpf_dynptr *signature) __ksym;
+int bpf_ecdsa_keysize(struct bpf_crypto_ctx *ctx) __ksym;
+int bpf_ecdsa_digestsize(struct bpf_crypto_ctx *ctx) __ksym;
+int bpf_ecdsa_maxsize(struct bpf_crypto_ctx *ctx) __ksym;
 
 struct __crypto_ctx_value {
 	struct bpf_crypto_ctx __kptr * ctx;
diff --git a/tools/testing/selftests/bpf/progs/crypto_hash.c b/tools/testing/selftests/bpf/progs/crypto_hash.c
new file mode 100644
index 000000000000..7eafbdd394af
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crypto_hash.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+#include "crypto_common.h"
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


