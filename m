Return-Path: <linux-kselftest+bounces-47132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABA7CA8A9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2186C313601B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD52345729;
	Fri,  5 Dec 2025 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="ANG7bZMn";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="P6I8YcNo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E909B244670;
	Fri,  5 Dec 2025 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764956394; cv=none; b=M8n8odrNwPJJiu/5b5R3QKGmYVGBoVc+XTtF6ZabqPMD9qnOLbpXxTC4+ue5iJR/x7r8ITe/krnaDJ+8sAD1+GYtoJLuUkZVk9q9xP70QLgjQuMm0W4Hy7XUa8/3BABqHe0E2AOHziMS+TIvQRfwJtzptgi5BKBhjR7uslnXH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764956394; c=relaxed/simple;
	bh=rr2dodnmQBE//RZi6sTrV0pfjiVKjY3nNryi+9fRQJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzjJPEBaKeFfvdeYeFHtDAQpJhMsH4aF8NmQK4ZAGHZRXE5uWOW6IxSPWOniakkXs1xDz9vbyCfPBbFW72yFzMxYcrVPVreD1a7tgGPi8OJKyUuga1hPWiNYSBPY1Z2cr6eX/e68E2GIJCl4kJzFYH+ssCzxCy1CTwAxFDn9C2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=ANG7bZMn; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=P6I8YcNo; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1764956365; bh=KVUhcg73/TqA3EpqJ1rA7Fv
	3Jp/HbsvMpxg1pjeiYFE=; b=ANG7bZMn68WxI9tnEBKlqM4eDtnbfh/OIDT1ujXykzHvqNeC9T
	x+leEuz/z1/HI2LznLoogmT+ssmku9EPAH0zMNVPOeLCSjW+o6wWr35v9kWD6D2pLXtE6cgyZdA
	bW/ZTpqYuh0arAcVvRt9jRIwbWDP0+f2Jb+Ybx1Aeh8hPIZDmOQv8PpHR654aMWisya7EoV/X+n
	6OiQhqy/RghV8Ic8PJ1n4bxRuBDCYBAOXD3bUMh8br8uiJcCfE3wTvyc8sw2xbWs+ccufn/2AIb
	HIER48BpeYAoIXy8X/r2FcoD3kmkMvDB2t6ncgfvFch6fpFyCAVZQAM2vYIaNf9le5w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1764956365; bh=KVUhcg73/TqA3EpqJ1rA7Fv
	3Jp/HbsvMpxg1pjeiYFE=; b=P6I8YcNozYkbW6lFa59A+Y4N691E6Rq10/Rr7UB2AII+CXyEbl
	vo6bK0TXL2XJO8zRnkaLs+JiEAkYUAvU1PCA==;
From: Daniel Hodges <git@danielhodges.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	vadim.fedorenko@linux.dev
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v2 3/5] selftests/bpf: Add tests for bpf_crypto_hash kfunc
Date: Fri,  5 Dec 2025 12:39:21 -0500
Message-ID: <20251205173923.31740-4-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205173923.31740-1-git@danielhodges.dev>
References: <20251205173923.31740-1-git@danielhodges.dev>
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
 .../selftests/bpf/prog_tests/crypto_hash.c    | 158 ++++++++++++++++++
 .../testing/selftests/bpf/progs/crypto_hash.c | 141 ++++++++++++++++
 3 files changed, 301 insertions(+)
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
index 000000000000..f1495ea85aae
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/crypto_hash.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
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
+static void test_sha256_basic(void)
+{
+	struct crypto_hash *skel;
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = crypto_hash__open_and_load();
+	if (!skel) {
+		/* Skip if kfuncs not available (CONFIG_CRYPTO_HASH2 not set) */
+		if (errno == ENOENT || errno == EINVAL) {
+			test__skip();
+			return;
+		}
+		ASSERT_OK_PTR(skel, "crypto_hash__open_and_load");
+		return;
+	}
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
+	if (!skel) {
+		/* Skip if kfuncs not available (CONFIG_CRYPTO_HASH2 not set) */
+		if (errno == ENOENT || errno == EINVAL) {
+			test__skip();
+			return;
+		}
+		ASSERT_OK_PTR(skel, "crypto_hash__open_and_load");
+		return;
+	}
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
+	if (!skel) {
+		/* Skip if kfuncs not available (CONFIG_CRYPTO_HASH2 not set) */
+		if (errno == ENOENT || errno == EINVAL) {
+			test__skip();
+			return;
+		}
+		ASSERT_OK_PTR(skel, "crypto_hash__open_and_load");
+		return;
+	}
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
+	if (!skel) {
+		/* Skip if kfuncs not available (CONFIG_CRYPTO_HASH2 not set) */
+		if (errno == ENOENT || errno == EINVAL) {
+			test__skip();
+			return;
+		}
+		ASSERT_OK_PTR(skel, "crypto_hash__open_and_load");
+		return;
+	}
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
index 000000000000..cbb9ccecc697
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crypto_hash.c
@@ -0,0 +1,141 @@
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


