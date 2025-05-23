Return-Path: <linux-kselftest+bounces-33649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9162BAC23B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 15:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32574A3BCB
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CD2292910;
	Fri, 23 May 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mNJCnvPW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF14292098
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748006412; cv=none; b=JUUEJN3fI6GD2anDUZa8w9iZlh70SdzGAeATe+LFEuzLlc6GHGua/HTBKYnpCNIb8P/ZHbyoAbjelfRBA/Ri6QZIPFqgALGP0E3F04X//42nCqLKnGcEkuevDMwQKHCILaO3vw8Nqlhuh0dSZh1HQxnoGzuaTrWX+S0Q2G7uHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748006412; c=relaxed/simple;
	bh=iG0pvVHCIniSa6/K288JCYz9/zRHjQOB+W412xcg368=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQEY7Q+IcJBq275ug/Q9XpBfoIsitufcUx7BQQKIv7loIBH47T4pNVyfkKmHYQSnQ9bI5AJtxnPagirYW9kVGCOd3BXwlpxKbiMBjUjD9KUet6hM3O5CasmnSIpCgOX6/rONWKbyek9JltnfFEapP0HqvER0yZItgdVNh1vp5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mNJCnvPW; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748006408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtCaT6fa/kicq1jIlhQVO8eyqlgwQfuRi8HxKyRVUBs=;
	b=mNJCnvPW0SRYYq9/bPn+7gDbbXwuFmw/XqeoRrlNnuNwxkXrR33Fq+TYBFRRmNNsXbOAMb
	NMs44y07xpu7A9dMFwAnKRQ4iizu+YN4XjF2lhiOe4vA5b1PXDjlEkowEe4/tGtE5vwvGa
	kOss1VjTg9bRmXYsUswSwgR1DPKCweE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <isolodrai@meta.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add test to cover ktls with bpf_msg_pop_data
Date: Fri, 23 May 2025 21:18:59 +0800
Message-ID: <20250523131915.19349-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250523131915.19349-1-jiayuan.chen@linux.dev>
References: <20250523131915.19349-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The selftest can reproduce an issue where using bpf_msg_pop_data() in
ktls causes errors on the receiving end.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 91 +++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  4 +
 2 files changed, 95 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index b6c471da5c28..b87e7f39e15a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -314,6 +314,95 @@ static void test_sockmap_ktls_tx_no_buf(int family, int sotype, bool push)
 	test_sockmap_ktls__destroy(skel);
 }
 
+static void test_sockmap_ktls_tx_pop(int family, int sotype)
+{
+	char msg[37] = "0123456789abcdefghijklmnopqrstuvwxyz\0";
+	int c = 0, p = 0, one = 1, sent, recvd;
+	struct test_sockmap_ktls *skel;
+	int prog_fd, map_fd;
+	char rcv[50] = {0};
+	int err;
+	int i, m, r;
+
+	skel = test_sockmap_ktls__open_and_load();
+	if (!ASSERT_TRUE(skel, "open ktls skel"))
+		return;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (!ASSERT_OK(err, "create_pair()"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.prog_sk_policy);
+	map_fd = bpf_map__fd(skel->maps.sock_map);
+
+	err = bpf_prog_attach(prog_fd, map_fd, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach sk msg"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, &one, &c, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
+		goto out;
+
+	err = init_ktls_pairs(c, p);
+	if (!ASSERT_OK(err, "init_ktls_pairs(c, p)"))
+		goto out;
+
+	struct {
+		int	pop_start;
+		int	pop_len;
+	} pop_policy[] = {
+		/* trim the start */
+		{0, 2},
+		{0, 10},
+		{1, 2},
+		{1, 10},
+		/* trim the end */
+		{35, 2},
+		/* New entries should be added before this line */
+		{-1, -1},
+	};
+
+	i = 0;
+	while (pop_policy[i].pop_start >= 0) {
+		skel->bss->pop_start = pop_policy[i].pop_start;
+		skel->bss->pop_end =  pop_policy[i].pop_len;
+
+		sent = send(c, msg, sizeof(msg), 0);
+		if (!ASSERT_EQ(sent, sizeof(msg), "send(msg)"))
+			goto out;
+
+		recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
+		if (!ASSERT_EQ(recvd, sizeof(msg) - pop_policy[i].pop_len, "pop len mismatch"))
+			goto out;
+
+		/* verify the data
+		 * msg: 0123456789a bcdefghij klmnopqrstuvwxyz
+		 *                  |       |
+		 *                  popped data
+		 */
+		for (m = 0, r = 0; m < sizeof(msg);) {
+			/* skip checking the data that has been popped */
+			if (m >= pop_policy[i].pop_start &&
+			    m <= pop_policy[i].pop_start + pop_policy[i].pop_len - 1) {
+				m++;
+				continue;
+			}
+
+			if (!ASSERT_EQ(msg[m], rcv[r], "data mismatch"))
+				goto out;
+			m++;
+			r++;
+		}
+		i++;
+	}
+out:
+	if (c)
+		close(c);
+	if (p)
+		close(p);
+	test_sockmap_ktls__destroy(skel);
+}
+
 static void run_tests(int family, enum bpf_map_type map_type)
 {
 	int map;
@@ -338,6 +427,8 @@ static void run_ktls_test(int family, int sotype)
 		test_sockmap_ktls_tx_cork(family, sotype, true);
 	if (test__start_subtest("tls tx egress with no buf"))
 		test_sockmap_ktls_tx_no_buf(family, sotype, true);
+	if (test__start_subtest("tls tx with pop"))
+		test_sockmap_ktls_tx_pop(family, sotype);
 }
 
 void test_sockmap_ktls(void)
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
index 8bdb9987c0c7..83df4919c224 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
@@ -7,6 +7,8 @@ int cork_byte;
 int push_start;
 int push_end;
 int apply_bytes;
+int pop_start;
+int pop_end;
 
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
@@ -22,6 +24,8 @@ int prog_sk_policy(struct sk_msg_md *msg)
 		bpf_msg_cork_bytes(msg, cork_byte);
 	if (push_start > 0 && push_end > 0)
 		bpf_msg_push_data(msg, push_start, push_end, 0);
+	if (pop_start >= 0 && pop_end > 0)
+		bpf_msg_pop_data(msg, pop_start, pop_end, 0);
 
 	return SK_PASS;
 }
-- 
2.47.1


