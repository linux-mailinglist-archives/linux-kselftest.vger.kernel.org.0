Return-Path: <linux-kselftest+bounces-47760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA47CD2E33
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 12:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29F15300FA12
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C5230B53C;
	Sat, 20 Dec 2025 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQnNlTob"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BDB28850D
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Dec 2025 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766230562; cv=none; b=sioKJDJMUzU8k4TntNiqhYerrOwyF6+qzOd6bGBNbClpFZHIRfkrfawI+Xx3RbRCfMjjo4ORcBEn93BPAjhuRdndSPq4QLxvka8VSt9+/tFLLSQInwY915rAOZ2Yn3UbVt+hCpjkSYgQNCYb0IGWP8JxYmsFwJ7LpQrhWVSxARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766230562; c=relaxed/simple;
	bh=jIDhSYVp9j8QWzc+Ung+SecNY2NPdp5wG0Cu5OE+NrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L2FfmPufXk5Y69oJUcFdz8kDTq03eVX/oO3PQ2VtxXQa2CsSxE9RkDpI1WWYiCt0VfT7pBDnF3PYkfduFY4AaiVfIY2+XptxR2Xr75ZSVTdiuYBDU2Q/GQNWvprKROCWPFLCDONfgw9MtBFESwZ4qEO6/cvrgkzoFvuRKjTO/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQnNlTob; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c21417781so2550440a91.3
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Dec 2025 03:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766230559; x=1766835359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIP/p9vK+z99OUz21qCwPYKTeE+7MGP1Av2Ob1HiCgE=;
        b=CQnNlToboKp35sjY9vHd+4cIG9QXrSvWvDrr/vYrDmK5xYISc8BeFOXgExrzfiMhLb
         J7g/bmOmmgKAjItZQZrpuRytJy+aQ7eNzhCJ65b8VuVkuNtCcBlXdcaBAlu1HBRdqWmw
         F2dBz5ZmLtjfdxSh0fzmtTqe10UhTc/OeWtpH+pIAWMigmGQkAZNbOny5W5ixTTpwf/7
         Hp3yBRYvWi29Uyrj0E5giKBU9W1+lKbFO/M4I3SEztCPLIh2tl2RzhKP94xhLYlHg9pT
         BxcimyA8JbJVDBrJ5EZkiLF71T/cq97BCeFFedoKAbngeEmA5xywLhvm1Xl9NKfu8zvK
         S44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766230559; x=1766835359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FIP/p9vK+z99OUz21qCwPYKTeE+7MGP1Av2Ob1HiCgE=;
        b=i0pPPV+70wuUFxeRyaNup2BdETS6P4kU89OKDNcFfeUqzURTWDU+EKQHIM8iFK7ElC
         qjxY+TpixugnytBQMlw6LREPrYffw7S3epek4UR5vKPR5BwTtncXqwNRKc5unf7eyMyo
         y7GvMZP4TBZMQYArW4wwlfI/qL/yWKhN908bl+Lqg6lCZgtnW4a7VIoWfzuE1wjHDbQH
         0T6qFHiT3GVqUbCJ4y8/FQpuBmybq0PKMI/ZhS0dx1spxe409qtXb/9Dk0nsUvoEk2Dz
         DsMOtXiEfszYT8Mgt4i98R7UwpJAqIENvvmoVOnSpOp+wBI+g2nU+fKr8drFfepk8MBP
         iSTw==
X-Forwarded-Encrypted: i=1; AJvYcCXGAG7By5EIuswRn1fHJ640eKPX7qMmta5s6YFTCbpGCfZ06CGwWxZoJnS4eQqvR5zpOJjvtvL7V18TRaHfK+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBZw1cYOKPwf6yW87QEbPd6V2W0G0Md6/AfZYymCN10oiaWhsz
	3wxpfZ+hhBM4Mv37yh89uZZqGhg6V7sKC6ZpDcTUnt99KeQUlIYEy2pt
X-Gm-Gg: AY/fxX63Lx3ipdj0BBYArXbao9878HLMw9q4CVqGw8FzpKY0SUtuQKGytqA3Tabqv0h
	KSzZhIuKZb8cBQJ4Mc5XYu4eO6r5tV1oyZrLLXlJYRzY53gYQE+bPj7yk03K5gY7ahOTeQKpKyv
	5qUiZYaFUAcaWrnVFAzJE4vZ6HSIYJ2Xl3lyS12x1XjmkT1efOPxXgngEXPn4zv/LQ1uX4Qi02E
	9ytqsKvcqIjGgfYehVAvOe2IdnljMs3N3n0FKWJ2oH8QlYj0RQTsVd2WB6teSkfmkAJZsFIkVKG
	NxHL/Rj6tbbmdLsjWHSHQ613wQbv5l23N70p5uIPChbjtvl2G9EYWrg2YUAUIwpqolS0iFN0jpr
	3YE+r4VHDGkkwBvDixjWGD1gyisqYyJarlFCKCz3ADu3TeVvWYaAaQv/jnEylHF8/ZjDekIb9sh
	146dKsUpKTlgc=
X-Google-Smtp-Source: AGHT+IFdI/LDc0piR9RWMjmgLQ3q3D7MDPC24mANcTglaDLcS2snWjW0R/06TaK3G00xl98gaRtVzA==
X-Received: by 2002:a17:90a:dfc6:b0:340:d1a1:af8e with SMTP id 98e67ed59e1d1-34e921e60d9mr4930318a91.37.1766230558471;
        Sat, 20 Dec 2025 03:35:58 -0800 (PST)
Received: from [127.0.0.1] ([188.253.121.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d65653sm7799389a91.5.2025.12.20.03.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 03:35:58 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Sat, 20 Dec 2025 19:35:05 +0800
Subject: [RFC PATCH bpf 2/2] selftests/bpf: add regression tests for
 snprintf and get_stack helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-helper_proto-v1-2-2206e0d9422d@gmail.com>
References: <20251220-helper_proto-v1-0-2206e0d9422d@gmail.com>
In-Reply-To: <20251220-helper_proto-v1-0-2206e0d9422d@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Zesen Liu <ftyghome@gmail.com>, 
 Shuran Liu <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, 
 Haoran Ni <haoran.ni.cs@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8326; i=ftyghome@gmail.com;
 h=from:subject:message-id; bh=jIDhSYVp9j8QWzc+Ung+SecNY2NPdp5wG0Cu5OE+NrM=;
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ6ZbF2tb9avMwFYrbdsTx/xaRSZ9NZ6QKZRypff5IfeWL
 SzSTkwdpSwMYlwMsmKKLL0/DO+uzDQ33maz4CDMHFYmkCEMXJwCMJGUkwz/lOepX93K7nbaUf3v
 nQ2qTvM2KHNuyzmd1TxZPLltx519eQx/eBeYs5xiusURpPFXICUhf012/du5V3pazPQ7P8xObKr
 mBgA=
X-Developer-Key: i=ftyghome@gmail.com; a=openpgp;
 fpr=8DF831DDA9693733B63CA0C18C1F774DEC4D3287

Add regression tests for bpf_snprintf(), bpf_snprintf_btf(), and
bpf_get_stack() to cover incorrect verifier assumptions caused by
incorrect function prototypes.

These tests reproduce the scenario where the verifier previously
incorrectly assumed that the destination buffer remained unwritten
across the helper call. The tests call these helpers and verify that
subsequent reads see the updated data, ensuring that the verifier
correctly marks the memory as clobbered and does not optimize away
the reads based on stale assumptions.

Co-developed-by: Shuran Liu <electronlsr@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Zesen Liu <ftyghome@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c | 15 +++++++++++++--
 tools/testing/selftests/bpf/prog_tests/snprintf.c         |  6 ++++++
 tools/testing/selftests/bpf/prog_tests/snprintf_btf.c     |  3 +++
 tools/testing/selftests/bpf/progs/netif_receive_skb.c     | 13 ++++++++++++-
 tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c  | 11 ++++++++++-
 tools/testing/selftests/bpf/progs/test_snprintf.c         | 12 ++++++++++++
 6 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
index 858e0575f502..7c2774b49138 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
@@ -87,13 +87,13 @@ void test_get_stack_raw_tp(void)
 	const char *file = "./test_get_stack_rawtp.bpf.o";
 	const char *file_err = "./test_get_stack_rawtp_err.bpf.o";
 	const char *prog_name = "bpf_prog1";
-	int i, err, prog_fd, exp_cnt = MAX_CNT_RAWTP;
+	int i, err, prog_fd, exp_cnt = MAX_CNT_RAWTP, key = 0, valid_top_stack = 0;
 	struct perf_buffer *pb = NULL;
 	struct bpf_link *link = NULL;
 	struct timespec tv = {0, 10};
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	struct bpf_map *map;
+	struct bpf_map *map, *bss_map;
 	cpu_set_t cpu_set;
 
 	err = bpf_prog_test_load(file_err, BPF_PROG_TYPE_RAW_TRACEPOINT, &obj, &prog_fd);
@@ -135,6 +135,17 @@ void test_get_stack_raw_tp(void)
 	for (i = 0; i < MAX_CNT_RAWTP; i++)
 		nanosleep(&tv, NULL);
 
+	bss_map = bpf_object__find_map_by_name(obj, ".bss");
+	if (CHECK(!bss_map, "find .bss map", "not found\n"))
+		goto close_prog;
+
+	err = bpf_map_lookup_elem(bpf_map__fd(bss_map), &key, &valid_top_stack);
+	if (CHECK(err, "lookup .bss", "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	if (!ASSERT_EQ(valid_top_stack, 1, "valid_top_stack"))
+		goto close_prog;
+
 	while (exp_cnt > 0) {
 		err = perf_buffer__poll(pb, 100);
 		if (err < 0 && CHECK(err < 0, "pb__poll", "err %d\n", err))
diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
index 594441acb707..80d6f2655b5f 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -33,6 +33,9 @@
 
 #define EXP_NO_BUF_RET 29
 
+#define EXP_STACK_OUT  "stack_out"
+#define EXP_STACK_RET  sizeof(EXP_STACK_OUT)
+
 static void test_snprintf_positive(void)
 {
 	char exp_addr_out[] = EXP_ADDR_OUT;
@@ -79,6 +82,9 @@ static void test_snprintf_positive(void)
 
 	ASSERT_EQ(skel->bss->nobuf_ret, EXP_NO_BUF_RET, "no_buf_ret");
 
+	ASSERT_EQ(skel->bss->stack_ret, EXP_STACK_RET, "stack_ret");
+	ASSERT_STREQ(skel->bss->stack_out, EXP_STACK_OUT, "stack_out");
+
 cleanup:
 	test_snprintf__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c b/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c
index dd41b826be30..a2e400a4880d 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c
@@ -55,6 +55,9 @@ void serial_test_snprintf_btf(void)
 		  bss->ran_subtests))
 		goto cleanup;
 
+	if (!ASSERT_EQ(bss->stack_out_test_passed, 1, "stack output test failed"))
+		goto cleanup;
+
 cleanup:
 	netif_receive_skb__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
index 9e067dcbf607..f78d5f56f6c9 100644
--- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
+++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
@@ -12,9 +12,11 @@
 long ret = 0;
 int num_subtests = 0;
 int ran_subtests = 0;
+int stack_out_test_passed = 0;
 bool skip = false;
 
-#define STRSIZE			2048
+#define STRSIZE 2048
+#define STACK_STRSIZE 64
 #define EXPECTED_STRSIZE	256
 
 #if defined(bpf_target_s390)
@@ -98,6 +100,7 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
 	__u32 key = 0;
 	int i, __ret;
 	char *str;
+	char stack_out[STACK_STRSIZE] = { };
 
 #if __has_builtin(__builtin_btf_type_id)
 	str = bpf_map_lookup_elem(&strdata, &key);
@@ -124,6 +127,13 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
 		ret = -ERANGE;
 	}
 
+	/* Check when writing to a buffer on the stack */
+	p.type_id = bpf_core_type_id_kernel(struct sk_buff);
+	p.ptr = skb;
+	ret = bpf_snprintf_btf(stack_out, STACK_STRSIZE, &p, sizeof(p), 0);
+	if (ret >= 0 && stack_out[0] != '\0')
+		stack_out_test_passed = 1;
+
 	/* Verify type display for various types. */
 
 	/* simple int */
@@ -242,6 +252,7 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
 	TEST_BTF(str, struct bpf_insn, BTF_F_NONAME, "{1,0x2,0x3,4,5,}",
 		 {.code = 1, .dst_reg = 0x2, .src_reg = 0x3, .off = 4,
 		  .imm = 5,});
+
 #else
 	skip = true;
 #endif
diff --git a/tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c b/tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c
index b6a6eb279e54..57723dc823a0 100644
--- a/tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c
+++ b/tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c
@@ -54,14 +54,17 @@ struct {
 	__type(value, __u64[2 * MAX_STACK_RAWTP]);
 } rawdata_map SEC(".maps");
 
+int valid_top_stack = 0;
+
 SEC("raw_tracepoint/sys_enter")
 int bpf_prog1(void *ctx)
 {
 	int max_len, max_buildid_len, total_size;
 	struct stack_trace_t *data;
-	long usize, ksize;
+	long usize, ksize, top_usize;
 	void *raw_data;
 	__u32 key = 0;
+	__u64 top_user_stack = 0;
 
 	data = bpf_map_lookup_elem(&stackdata_map, &key);
 	if (!data)
@@ -88,6 +91,12 @@ int bpf_prog1(void *ctx)
 	if (usize < 0)
 		return 0;
 
+	/* checks if the verifier correctly marks the stack variable as written. */
+	top_usize = bpf_get_stack(ctx, &top_user_stack, sizeof(__u64),
+				   BPF_F_USER_STACK);
+	if (top_usize > 0 && top_user_stack != 0)
+		valid_top_stack = 1;
+
 	ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
 	if (ksize < 0)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
index 8fda07544023..ce78fd7add03 100644
--- a/tools/testing/selftests/bpf/progs/test_snprintf.c
+++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
@@ -32,6 +32,9 @@ long noarg_ret = 0;
 
 long nobuf_ret = 0;
 
+char stack_out[64] = {};
+long stack_ret = 0;
+
 extern const void schedule __ksym;
 
 SEC("raw_tp/sys_enter")
@@ -42,6 +45,7 @@ int handler(const void *ctx)
 	const __u8 ex_ipv6[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1};
 	static const char str1[] = "str1";
 	static const char longstr[] = "longstr";
+	char buf[64] = {};
 
 	if ((int)bpf_get_current_pid_tgid() != pid)
 		return 0;
@@ -71,6 +75,14 @@ int handler(const void *ctx)
 	/* No buffer */
 	nobuf_ret = BPF_SNPRINTF(NULL, 0, "only interested in length %d", 60);
 
+	/* Write to a buffer on the stack */
+	stack_ret = BPF_SNPRINTF(buf, sizeof(buf), "stack_out");
+    /* The condition is necessary to check if the verifier
+     * correctly marks the stack memory as written.
+     */
+	if (buf[0] != '\0')
+		__builtin_memcpy(stack_out, buf, 64);
+
 	return 0;
 }
 

-- 
2.43.0


