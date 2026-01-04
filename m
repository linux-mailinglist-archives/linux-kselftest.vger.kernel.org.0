Return-Path: <linux-kselftest+bounces-48133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56520CF1220
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 17:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98F55300BECB
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19012836AF;
	Sun,  4 Jan 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vuVRnV8K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0911527FD56
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543911; cv=none; b=pB9LIRkA8Xx7OS8QS6rDhBzVYHY5UF5YeqcDSsy/g6iC/ci1jIh7v1caky/TO6mh0V3RKJy9Wlu9oJO4MJTiL1fBXwdj6/dAcbiX0jRcHorWcCerzVEN41iRCqqH5YYrZrzaV5tEnyAhxAlgx7+o0A3aWmCDdHFDMU8DR8hNlGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543911; c=relaxed/simple;
	bh=LSTTQ1Bw6k7njO8lwuxwQO6h9yNeUWCg0KXwR2Yikd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUcoo27Q+R4WGRl71E1dDUxqXvENq+Db6Xt6J7su4OUoqLiLMEU8Rvuhwnnv4bgoxzAnWg19BsHI1TY7AC869aaEPzKpTz8xyLZj+mYQQjy/MCmObc29atL+vKOu8vkhp4nmfUPvfQ4UllM/01JVcNw0LClTFz/qekbVYO9QtsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vuVRnV8K; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767543906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqbsIbMnN1SRJEl+iPFxJCqCnnA13u+xQvRbspdzZhg=;
	b=vuVRnV8KsWEl32XjLibUJqTVNuyAgu2Rfq8RAwC0U+f3yHLB0jE+t/S/hmO3+uRW8TzkY1
	Igqj2rbXzsy0k2snLJkZd8fi0/Z4YVnnVT9yrGEce7ypmn/GIYwbswno5s2vtQk8OlNSXx
	qghU0C9WepW1socVTmvBocKOfMzllHM=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	shuah@kernel.org,
	aleksander.lobakin@intel.com,
	toke@redhat.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for xdp_md context with LIVE_FRAMES in BPF_PROG_TEST_RUN
Date: Mon,  5 Jan 2026 00:23:50 +0800
Message-ID: <20260104162350.347403-3-kafai.wan@linux.dev>
In-Reply-To: <20260104162350.347403-1-kafai.wan@linux.dev>
References: <fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn>
 <20260104162350.347403-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a test case uses xdp_md as context parameter for BPF_PROG_TEST_RUN
with LIVE_FRAMES flag. The test ensures that potential user-memory-access
vulnerabilities are properly prevented.

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../bpf/prog_tests/xdp_context_test_run.c     | 19 +++++++++++++++++++
 .../bpf/progs/test_xdp_context_test_run.c     |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index ee94c281888a..0276daaae45c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -45,6 +45,7 @@ void test_xdp_context_error(int prog_fd, struct bpf_test_run_opts opts,
 void test_xdp_context_test_run(void)
 {
 	struct test_xdp_context_test_run *skel = NULL;
+	char data_xdp[sizeof(pkt_v4) + XDP_PACKET_HEADROOM];
 	char data[sizeof(pkt_v4) + sizeof(__u32)];
 	char bad_ctx[sizeof(struct xdp_md) + 1];
 	struct xdp_md ctx_in, ctx_out;
@@ -55,6 +56,12 @@ void test_xdp_context_test_run(void)
 			    .ctx_size_out = sizeof(ctx_out),
 			    .repeat = 1,
 		);
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts_xdp,
+			    .data_in = &data_xdp,
+			    .data_size_in = sizeof(data_xdp),
+			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
+			    .repeat = 1,
+		);
 	int err, prog_fd;
 
 	skel = test_xdp_context_test_run__open_and_load();
@@ -70,6 +77,18 @@ void test_xdp_context_test_run(void)
 	ASSERT_EQ(errno, E2BIG, "extradata-errno");
 	ASSERT_ERR(err, "bpf_prog_test_run(extradata)");
 
+	memset(&ctx_in, 0, sizeof(ctx_in));
+	ctx_in.data_meta = 0;
+	ctx_in.data = 0xf4;
+	ctx_in.data_end = sizeof(data_xdp);
+	opts_xdp.ctx_in = &ctx_in;
+	opts_xdp.ctx_size_in = sizeof(ctx_in);
+	*(__u32 *)(data_xdp + 0) = 0x28d6a0b5;
+	*(__u32 *)(data_xdp + 4) = 0xf273eea3;
+	*(struct ipv4_packet *)(data_xdp + ctx_in.data) = pkt_v4;
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.xdp_pass), &opts_xdp);
+	ASSERT_OK(err, "bpf_prog_test_run(valid meta)");
+
 	*(__u32 *)data = XDP_PASS;
 	*(struct ipv4_packet *)(data + sizeof(__u32)) = pkt_v4;
 	opts.ctx_in = &ctx_in;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
index d7b88cd05afd..2166928d4680 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
@@ -17,4 +17,10 @@ int xdp_context(struct xdp_md *xdp)
 	return ret;
 }
 
+SEC("xdp")
+int xdp_pass(struct xdp_md *xdp)
+{
+	return XDP_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


