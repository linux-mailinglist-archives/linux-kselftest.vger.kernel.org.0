Return-Path: <linux-kselftest+bounces-45800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E570C663ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 22:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A166F354066
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EEF30F924;
	Mon, 17 Nov 2025 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="ej3EtMHR";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="nrcMBH5T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5929AAFA;
	Mon, 17 Nov 2025 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414239; cv=none; b=qRNkWKzW/T8Rf85TEb/dlQg87cBvLWmPg5m6uvv0/E4WgEIKksywYiPN0KW+aXJPgZFkPtOXqFUqMsXwFIc3i3r0mx84xThcZm98SQU3UmQA5T5ASFfeP64pGRKuSIXwzVh3TnjX2IFLB2d25f6MrcT/ipbp3MQe2Ekoj+e6ysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414239; c=relaxed/simple;
	bh=Fq2tE7o+bvcR+DrpxG8T1R6IVl/ni71hrmTg6QBp460=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoeoZCev/HtRCXmardZ5G360CSN1XHX1R9zDNHid7zA2IHjMSKQ2rU/yFEvtBZYZ86OdbjTpi5W1cnUWLD9kW56tCultS3vzYNB6SPJt9w5gpSRYQnOfYwg+RxvmQwHfJc4xSJze2eoB4redKugHpTtdgu4AlMswAjQljPa6hHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=ej3EtMHR; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=nrcMBH5T; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1763414082; bh=cr4YY/Ybyh02RSV9+T1d9VF
	RIkHvVmX+jAaozJ62nO4=; b=ej3EtMHR1+796RtzxxalIEHiJCQFGaDJ0eF3yamLdWdJB1uuUx
	knP4DEB2U4MPHZmkcTEbxg9amhszkf1gy+6v8ms8iBsid2jVr1TLPT6WiYMSkofEqOHEWu097rs
	7QfPcU89gP4NBBvbCTppbnkuLKoivhsHD60LpPK/yuP++h+TjoatAgj5yQZs7p8BsrtAbJP4c/M
	AeTevFkj+FKG2tnGyb7Ac/13idJfW6Dr4HqX7W/BfW4YLg3fwCEyNQC9+1nh/giq8d2Y/MXGhjh
	GsoXZzsDVHc77BO9efDLAgjWY8M39ck0FylwKBsXkSxifazMFdIS2icsvmyqIkCiskg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1763414082; bh=cr4YY/Ybyh02RSV9+T1d9VF
	RIkHvVmX+jAaozJ62nO4=; b=nrcMBH5TGUZeGpZ3h4HRxmYx20DVRRDxIif528yC6Oh5AI+dgr
	VCIUdJSRogR4dXkk8N+YLgt+JMqPK6eSnDDw==;
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
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add tests for ECDSA signature verification kfuncs
Date: Mon, 17 Nov 2025 16:14:01 -0500
Message-ID: <20251117211413.1394-5-git@danielhodges.dev>
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

Add selftests to validate the ECDSA signature verification kfuncs
introduced in the BPF crypto subsystem. The tests verify both valid
signature acceptance and invalid signature rejection using the
context-based ECDSA API.

The tests use RFC 6979 test vectors for NIST P-256 (secp256r1) with
well-known valid signatures. The algorithm "p1363(ecdsa-nist-p256)"
is used to handle standard r||s signature format.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 .../selftests/bpf/prog_tests/ecdsa_verify.c   |  96 ++++++++
 .../selftests/bpf/progs/ecdsa_verify.c        | 228 ++++++++++++++++++
 2 files changed, 324 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ecdsa_verify.c
 create mode 100644 tools/testing/selftests/bpf/progs/ecdsa_verify.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ecdsa_verify.c b/tools/testing/selftests/bpf/prog_tests/ecdsa_verify.c
new file mode 100644
index 000000000000..d1f83ce08ad6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ecdsa_verify.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
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
+static void test_ecdsa_sign_and_verify(void)
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
+	prog_fd = bpf_program__fd(skel->progs.test_ecdsa_sign_verify);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_ecdsa_sign_verify");
+	ASSERT_GT(skel->data->sign_result, 0, "sign_returns_signature_size");
+	ASSERT_EQ(skel->data->sign_verify_result, 0, "verify_generated_signature");
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
+	if (test__start_subtest("sign_and_verify"))
+		test_ecdsa_sign_and_verify();
+	if (test__start_subtest("size_queries"))
+		test_ecdsa_size_queries();
+}
diff --git a/tools/testing/selftests/bpf/progs/ecdsa_verify.c b/tools/testing/selftests/bpf/progs/ecdsa_verify.c
new file mode 100644
index 000000000000..fb24baf6c437
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ecdsa_verify.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct bpf_ecdsa_ctx;
+extern struct bpf_ecdsa_ctx *
+bpf_ecdsa_ctx_create(const struct bpf_dynptr *algo_name,
+		     const struct bpf_dynptr *public_key, int *err) __ksym;
+extern struct bpf_ecdsa_ctx *
+bpf_ecdsa_ctx_create_with_privkey(const struct bpf_dynptr *algo_name,
+				   const struct bpf_dynptr *private_key, int *err) __ksym;
+extern int bpf_ecdsa_verify(struct bpf_ecdsa_ctx *ctx,
+			    const struct bpf_dynptr *message,
+			    const struct bpf_dynptr *signature) __ksym;
+extern int bpf_ecdsa_sign(struct bpf_ecdsa_ctx *ctx,
+			  const struct bpf_dynptr *message,
+			  const struct bpf_dynptr *signature) __ksym;
+extern int bpf_ecdsa_keysize(struct bpf_ecdsa_ctx *ctx) __ksym;
+extern int bpf_ecdsa_digestsize(struct bpf_ecdsa_ctx *ctx) __ksym;
+extern int bpf_ecdsa_maxsize(struct bpf_ecdsa_ctx *ctx) __ksym;
+extern void bpf_ecdsa_ctx_release(struct bpf_ecdsa_ctx *ctx) __ksym;
+
+/* NIST P-256 test vector
+ * This is a known valid ECDSA signature for testing purposes
+ */
+
+/* Algorithm name for P-256 with p1363 format (standard r||s signature) */
+char algo_p256[] = "p1363(ecdsa-nist-p256)";
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
+/* Private key for signing (32 bytes) - matches the public key above */
+unsigned char privkey_p256[32] = {
+	0xc9, 0xaf, 0xa9, 0xd8, 0x45, 0xba, 0x75, 0x16,
+	0x6b, 0x5c, 0x21, 0x57, 0x67, 0xb1, 0xd6, 0x93,
+	0x4e, 0x50, 0xc3, 0xdb, 0x36, 0xe8, 0x9b, 0x12,
+	0x7b, 0x8a, 0x62, 0x2b, 0x12, 0x0f, 0x67, 0x21
+};
+
+/* Test results */
+int verify_result = -1;
+int verify_invalid_result = -1;
+int ctx_create_status = -1;
+int sign_result = -1;
+int sign_verify_result = -1;
+int keysize_result = -1;
+int digestsize_result = -1;
+int maxsize_result = -1;
+unsigned char generated_signature[64] = {0};
+
+SEC("syscall")
+int test_ecdsa_verify_valid(void *ctx)
+{
+	struct bpf_ecdsa_ctx *ecdsa_ctx;
+	struct bpf_dynptr algo_ptr, key_ptr, msg_ptr, sig_ptr;
+	int err = 0;
+
+	bpf_dynptr_from_mem(algo_p256, sizeof(algo_p256) - 1, 0, &algo_ptr);
+	bpf_dynptr_from_mem(pubkey_p256, sizeof(pubkey_p256), 0, &key_ptr);
+
+	ecdsa_ctx = bpf_ecdsa_ctx_create(&algo_ptr, &key_ptr, &err);
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
+	bpf_ecdsa_ctx_release(ecdsa_ctx);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_ecdsa_verify_invalid(void *ctx)
+{
+	struct bpf_ecdsa_ctx *ecdsa_ctx;
+	struct bpf_dynptr algo_ptr, key_ptr, msg_ptr, sig_ptr;
+	int err = 0;
+
+	bpf_dynptr_from_mem(algo_p256, sizeof(algo_p256) - 1, 0, &algo_ptr);
+	bpf_dynptr_from_mem(pubkey_p256, sizeof(pubkey_p256), 0, &key_ptr);
+
+	ecdsa_ctx = bpf_ecdsa_ctx_create(&algo_ptr, &key_ptr, &err);
+	if (!ecdsa_ctx)
+		return 0;
+
+	bpf_dynptr_from_mem(message_hash, sizeof(message_hash), 0, &msg_ptr);
+	bpf_dynptr_from_mem(invalid_signature, sizeof(invalid_signature), 0, &sig_ptr);
+
+	verify_invalid_result = bpf_ecdsa_verify(ecdsa_ctx, &msg_ptr, &sig_ptr);
+
+	bpf_ecdsa_ctx_release(ecdsa_ctx);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_ecdsa_sign_verify(void *ctx)
+{
+	struct bpf_ecdsa_ctx *sign_ctx, *verify_ctx;
+	struct bpf_dynptr algo_ptr, privkey_ptr, pubkey_ptr, msg_ptr, sig_ptr;
+	int err = 0;
+
+	/* Create signing context with private key */
+	bpf_dynptr_from_mem(algo_p256, sizeof(algo_p256) - 1, 0, &algo_ptr);
+	bpf_dynptr_from_mem(privkey_p256, sizeof(privkey_p256), 0, &privkey_ptr);
+
+	sign_ctx = bpf_ecdsa_ctx_create_with_privkey(&algo_ptr, &privkey_ptr, &err);
+	if (!sign_ctx) {
+		sign_result = err;
+		return 0;
+	}
+
+	/* Sign the message */
+	bpf_dynptr_from_mem(message_hash, sizeof(message_hash), 0, &msg_ptr);
+	bpf_dynptr_from_mem(generated_signature, sizeof(generated_signature), 0, &sig_ptr);
+
+	sign_result = bpf_ecdsa_sign(sign_ctx, &msg_ptr, &sig_ptr);
+
+	bpf_ecdsa_ctx_release(sign_ctx);
+
+	/* If signing succeeded, verify the generated signature */
+	if (sign_result > 0 && sign_result <= (int)sizeof(generated_signature)) {
+		unsigned int sig_size;
+
+		/* Explicitly bound the value for the verifier */
+		sig_size = sign_result & 0x3F; /* Max 64 bytes */
+
+		bpf_dynptr_from_mem(algo_p256, sizeof(algo_p256) - 1, 0, &algo_ptr);
+		bpf_dynptr_from_mem(pubkey_p256, sizeof(pubkey_p256), 0, &pubkey_ptr);
+
+		verify_ctx = bpf_ecdsa_ctx_create(&algo_ptr, &pubkey_ptr, &err);
+		if (!verify_ctx) {
+			sign_verify_result = err;
+			return 0;
+		}
+
+		bpf_dynptr_from_mem(message_hash, sizeof(message_hash), 0, &msg_ptr);
+		bpf_dynptr_from_mem(generated_signature, sig_size, 0, &sig_ptr);
+
+		sign_verify_result = bpf_ecdsa_verify(verify_ctx, &msg_ptr, &sig_ptr);
+
+		bpf_ecdsa_ctx_release(verify_ctx);
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+int test_ecdsa_size_queries(void *ctx)
+{
+	struct bpf_ecdsa_ctx *ecdsa_ctx;
+	struct bpf_dynptr algo_ptr, key_ptr;
+	int err = 0;
+
+	bpf_dynptr_from_mem(algo_p256, sizeof(algo_p256) - 1, 0, &algo_ptr);
+	bpf_dynptr_from_mem(pubkey_p256, sizeof(pubkey_p256), 0, &key_ptr);
+
+	ecdsa_ctx = bpf_ecdsa_ctx_create(&algo_ptr, &key_ptr, &err);
+	if (!ecdsa_ctx)
+		return 0;
+
+	keysize_result = bpf_ecdsa_keysize(ecdsa_ctx);
+	digestsize_result = bpf_ecdsa_digestsize(ecdsa_ctx);
+	maxsize_result = bpf_ecdsa_maxsize(ecdsa_ctx);
+
+	bpf_ecdsa_ctx_release(ecdsa_ctx);
+
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.51.0


