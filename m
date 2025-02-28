Return-Path: <linux-kselftest+bounces-27831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6847A49126
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 06:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F8E3B719A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 05:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177521C4A20;
	Fri, 28 Feb 2025 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y7m3280f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652E1C2304
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721929; cv=none; b=dNsFd+YT2hiaZQaEkiBy+bKxHiBGJiyUV4QrUhWVQpWp7aT9fTfFkQH/ZKsnupULTxJ2VnVHshIWDZN9dCbHD6flzhhhz+kAfiMRfaFYD/DW2OVCJwK1UMHLfj9DogUI5njQMPoFthRpqnMPPn99SDk+OYa8MGy8HSQq1IQlJMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721929; c=relaxed/simple;
	bh=YGlwgS0iclU1RDdEcGSrlFCzWJuaWzjnvf9QGAvqufs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tow6PDkekrcY+p8FI6OoTKD1CjgK5eM147jY4iGvGPuOmRgglvcjg9hFthmGQMqWREPeuW0+1waC42M7mjwNmiP4uOXtZiGX2/QL8WcCCsGkTLcDU3koSj146pz4RHm+CHC2IhN9YLBKjip7zIqVP/jA2Fqu5fAfSgWSx8/fJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y7m3280f; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740721925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWGoD/LIkFY1aSDCo/cUvHFAtxAXhzMCTXmZy5rY90A=;
	b=Y7m3280fbmzlK5sg9jqyV8uHt5j+GOfL8RREEvLRMJvzsIPmEFxHlqb3GaBgP/RilZeQpZ
	ViOZRQwZ31HDvL/EriQcQPmI5hBYruD5NR4u430guZBWhonh7gb6fqVwmfVfcOmYC4Al0E
	rA0bS4Yy1ajuyHooeWEYz3buZQRq1sg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: xiyou.wangcong@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	martin.lau@linux.dev
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	mhal@rbox.co,
	jiayuan.chen@linux.dev,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mrpre@163.com,
	cong.wang@bytedance.com
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add edge case tests for sockmap
Date: Fri, 28 Feb 2025 13:51:06 +0800
Message-ID: <20250228055106.58071-4-jiayuan.chen@linux.dev>
In-Reply-To: <20250228055106.58071-1-jiayuan.chen@linux.dev>
References: <20250228055106.58071-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add edge case tests for sockmap.

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1e3e4392dcca..ad8bb085baf2 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1042,6 +1042,59 @@ static void test_sockmap_vsock_unconnected(void)
 	xclose(map);
 }
 
+void *close_thread(void *arg)
+{
+	int *fd = (int *)arg;
+
+	sleep(1);
+	close(*fd);
+	*fd = -1;
+	return NULL;
+}
+
+void test_sockmap_with_close_on_write(int family, int sotype)
+{
+	struct test_sockmap_pass_prog *skel;
+	int err, map, verdict;
+	pthread_t tid;
+	int zero = 0;
+	int c = -1, p = -1;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (!ASSERT_OK(err, "create_pair"))
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &p, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	err = pthread_create(&tid, 0, close_thread, &p);
+	if (!ASSERT_OK(err, "pthread_create"))
+		goto out;
+
+	while (p > 0)
+		send(c, "a", 1, MSG_NOSIGNAL);
+
+	pthread_join(tid, NULL);
+out:
+	if (c > 0)
+		close(c);
+	if (p > 0)
+		close(p);
+	test_sockmap_pass_prog__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -1108,4 +1161,10 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_vsock_poll();
 	if (test__start_subtest("sockmap vsock unconnected"))
 		test_sockmap_vsock_unconnected();
+	if (test__start_subtest("sockmap with write on close")) {
+		test_sockmap_with_close_on_write(AF_UNIX, SOCK_STREAM);
+		test_sockmap_with_close_on_write(AF_UNIX, SOCK_DGRAM);
+		test_sockmap_with_close_on_write(AF_INET, SOCK_STREAM);
+		test_sockmap_with_close_on_write(AF_INET, SOCK_DGRAM);
+	}
 }
-- 
2.47.1


