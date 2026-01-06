Return-Path: <linux-kselftest+bounces-48332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52053CF9D40
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 18:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2943A30C26A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D21A350D5E;
	Tue,  6 Jan 2026 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BHB/Ap6K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3EE350D50
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720138; cv=none; b=P/fwFzBKNcJCApis6gBON1YGA3BR4v9fUl31CyJrcWXiuutevkTamv4SimpAgTPKQUATCKP5lWAtf7XCjBxdbWHYuD9ek/SirYJF9H0SveurhO3Cm7ycL6oZDY5DfZn/OG4SSmLHhbBNuHCyN35cpFwE5qouyL53xDd9mCr8nGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720138; c=relaxed/simple;
	bh=MAXHjOZ2vDeALsrSrzEPhCR/6gju9wZ2EZGKEhw6FRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPstI79xblJAFzleX3RlVOspD3MNCjk+4LoZXxLtmu7fj/qlwwQMle75cOp0erkxVRM6FYulMT6YpYVS5CQJg7eQ/7y8B97lDm2i2bJCSd0t2ZzjQTOkd2ABOKV6mw9dVPFMAUxbn65g4qCx/Wod3UrSD+/p/1ORQaUbKgBTe/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BHB/Ap6K; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767720133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nQ8vlpZLZ5VvbTZ6i9ChLmZ/pLF0l+ICk23bpsc6Vs=;
	b=BHB/Ap6KtyI5TVmKGrT6iNUzOQCaSXYwhBOh8hg6YVDSGmKLlB/4aNEHyGe7mWw8XC38NV
	o1F+TCZ/vT8E4SL42MJybXrnsK/i8t6s0UDyBZ3tJa+FlsMA2XR/LO63A3vZVZ2Zg3RYQQ
	pvqeN4JLCzQqqpgodutY/nBOCZCGWQk=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Seth Forshee <sforshee@kernel.org>,
	Yuichiro Tsuji <yuichtsu@amazon.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [RESEND PATCH bpf-next v4 9/9] selftests/bpf: Add tests to verify map create failure log
Date: Wed,  7 Jan 2026 01:20:18 +0800
Message-ID: <20260106172018.57757-10-leon.hwang@linux.dev>
In-Reply-To: <20260106172018.57757-1-leon.hwang@linux.dev>
References: <20260106172018.57757-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As kernel is able to report log when fail to create map, add tests to
verify those logs.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/map_init.c       | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_init.c b/tools/testing/selftests/bpf/prog_tests/map_init.c
index 14a31109dd0e..52bd4b1966c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_init.c
@@ -212,3 +212,146 @@ void test_map_init(void)
 	if (test__start_subtest("pcpu_lru_map_init"))
 		test_pcpu_lru_map_init();
 }
+
+#define BPF_LOG_FIXED	8
+
+static void test_map_create(enum bpf_map_type map_type, const char *map_name,
+			    struct bpf_map_create_opts *opts, const char *exp_msg)
+{
+	const int key_size = 4, value_size = 4, max_entries = 1;
+	char log_buf[128];
+	int fd;
+	LIBBPF_OPTS(bpf_syscall_common_attr_opts, copts);
+
+	log_buf[0] = '\0';
+	copts.log_buf = log_buf;
+	copts.log_size = sizeof(log_buf);
+	copts.log_level = BPF_LOG_FIXED;
+	opts->cattr_opts = &copts;
+	fd = bpf_map_create(map_type, map_name, key_size, value_size, max_entries, opts);
+	if (!ASSERT_LT(fd, 0, "bpf_map_create")) {
+		close(fd);
+		return;
+	}
+
+	ASSERT_STREQ(log_buf, exp_msg, "log_buf");
+	ASSERT_EQ(copts.log_true_size, strlen(exp_msg) + 1, "log_true_size");
+}
+
+static void test_map_create_array(struct bpf_map_create_opts *opts, const char *exp_msg)
+{
+	test_map_create(BPF_MAP_TYPE_ARRAY, "test_map_create", opts, exp_msg);
+}
+
+static void test_invalid_vmlinux_value_type_id_struct_ops(void)
+{
+	const char *msg = "btf_vmlinux_value_type_id can only be used with struct_ops maps.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .btf_vmlinux_value_type_id = 1,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+static void test_invalid_vmlinux_value_type_id_kv_type_id(void)
+{
+	const char *msg = "btf_vmlinux_value_type_id is mutually exclusive with btf_key_type_id and btf_value_type_id.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .btf_vmlinux_value_type_id = 1,
+		    .btf_key_type_id = 1,
+	);
+
+	test_map_create(BPF_MAP_TYPE_STRUCT_OPS, "test_map_create", &opts, msg);
+}
+
+static void test_invalid_value_type_id(void)
+{
+	const char *msg = "Invalid btf_value_type_id.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .btf_key_type_id = 1,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+static void test_invalid_map_extra(void)
+{
+	const char *msg = "Invalid map_extra.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_extra = 1,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+static void test_invalid_numa_node(void)
+{
+	const char *msg = "Invalid numa_node.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_flags = BPF_F_NUMA_NODE,
+		    .numa_node = 0xFF,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+static void test_invalid_map_type(void)
+{
+	const char *msg = "Invalid map_type.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+
+	test_map_create(__MAX_BPF_MAP_TYPE, "test_map_create", &opts, msg);
+}
+
+static void test_invalid_token_fd(void)
+{
+	const char *msg = "Invalid map_token_fd.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_flags = BPF_F_TOKEN_FD,
+		    .token_fd = 0xFF,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+static void test_invalid_map_name(void)
+{
+	const char *msg = "Invalid map_name.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+
+	test_map_create(BPF_MAP_TYPE_ARRAY, "test-!@#", &opts, msg);
+}
+
+static void test_invalid_btf_fd(void)
+{
+	const char *msg = "Invalid btf_fd.\n";
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .btf_fd = -1,
+		    .btf_key_type_id = 1,
+		    .btf_value_type_id = 1,
+	);
+
+	test_map_create_array(&opts, msg);
+}
+
+void test_map_create_failure(void)
+{
+	if (test__start_subtest("invalid_vmlinux_value_type_id_struct_ops"))
+		test_invalid_vmlinux_value_type_id_struct_ops();
+	if (test__start_subtest("invalid_vmlinux_value_type_id_kv_type_id"))
+		test_invalid_vmlinux_value_type_id_kv_type_id();
+	if (test__start_subtest("invalid_value_type_id"))
+		test_invalid_value_type_id();
+	if (test__start_subtest("invalid_map_extra"))
+		test_invalid_map_extra();
+	if (test__start_subtest("invalid_numa_node"))
+		test_invalid_numa_node();
+	if (test__start_subtest("invalid_map_type"))
+		test_invalid_map_type();
+	if (test__start_subtest("invalid_token_fd"))
+		test_invalid_token_fd();
+	if (test__start_subtest("invalid_map_name"))
+		test_invalid_map_name();
+	if (test__start_subtest("invalid_btf_fd"))
+		test_invalid_btf_fd();
+}
-- 
2.52.0


