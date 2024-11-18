Return-Path: <linux-kselftest+bounces-22208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7FF9D1A17
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 22:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251442822B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 21:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B3B1E908E;
	Mon, 18 Nov 2024 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="YWsSij6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E21E882B;
	Mon, 18 Nov 2024 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963937; cv=none; b=cBPtS+5S9N5FzCkijLjznW+ISh+5n6XCM9PsyanKao77O9vow/XiujPoguTtXeybLcepuDIqbHbFdJB5RBYrzXlvFdGoDJJLDInPJ40p3F949sKEeUK/TqAdhuYjmkyEQf/PAtTApkjza4S5vXF0Aucpncj8gvCo5tk/ygh0rKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963937; c=relaxed/simple;
	bh=AODplrguRoUyocjLNeUBfKkcS8/o/AnGAqHJ2z43hRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ogLGp7WKycltNAsaD9SlxZi0fsK3ROGFD6n2Ni0iS9DtN/mz+Qwz1If0i1wObqFZ6uRhSp5742fOYg2ExyUNAOfYAoCPWQ1vPnl1crYW/lC91IEplfsLPT1oeCQ0myyKtaQ6ZPmRrqEYuRVa5ga6T0TKmNMxzL67vrutfx2ODtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=YWsSij6p; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tD8vu-00HaWN-Ef; Mon, 18 Nov 2024 22:05:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=XaGj7bjiHFIFr0AkWU6B2NFpeWMUiB4pxn4b3JeRD3w=; b=YWsSij6pZgTNu+dEf6dtGDEvvO
	WB/SBOosxjuVtv5FB5cr52TNyP6Qo0xw/Wg9q4ZSYRDmdZwG/1M2ksAr8NQUtu82rSz006oaiFkbv
	DGoe4kk006y4ag1e4m4biPr5oTQioeMFrZ9t60mbvOKwnkQ/eRcTdHXVYToyk/B5m8uMpMcx2whcN
	TDbmvmI+5naCueHpredki5VqSwaswTrUh0s/wWRGEnbIHeh1amhn8Y9049BUU4RRCFngin+SoytSY
	B0Doo5sFIJvHMo9JQLPmgQiBv++0VJKV7ZXuJKrlpomIRhf6JaKSJDhEe4+pDaX/DSJsDsz3cRmw3
	ifguEV7g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tD8vt-0004o7-TD; Mon, 18 Nov 2024 22:05:18 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tD8vg-00DME4-3w; Mon, 18 Nov 2024 22:05:04 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 18 Nov 2024 22:03:42 +0100
Subject: [PATCH bpf 2/4] selftest/bpf: Add test for af_vsock poll()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-vsock-bpf-poll-close-v1-2-f1b9669cacdc@rbox.co>
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Verify that vsock's poll() notices when sk_psock::ingress_msg isn't empty.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 82bfb266741cfaceafa2a407cd2ccc937708c613..21d1e2e2308433e7475952dcab034e92f2f6101a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -885,6 +885,50 @@ static void test_sockmap_same_sock(void)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
+static void test_sockmap_skb_verdict_vsock_poll(void)
+{
+	struct test_sockmap_pass_prog *skel;
+	int err, map, conn, peer;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	char buf = 'x';
+	int zero = 0;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (create_pair(AF_VSOCK, SOCK_STREAM, &conn, &peer))
+		goto destroy;
+
+	prog = skel->progs.prog_skb_verdict;
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+	link = bpf_program__attach_sockmap(prog, map);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
+		goto close;
+
+	err = bpf_map_update_elem(map, &zero, &conn, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto detach;
+
+	if (xsend(peer, &buf, 1, 0) != 1)
+		goto detach;
+
+	err = poll_read(conn, IO_TIMEOUT_SEC);
+	if (!ASSERT_OK(err, "poll"))
+		goto detach;
+
+	if (xrecv_nonblock(conn, &buf, 1, 0) != 1)
+		FAIL("xrecv_nonblock");
+detach:
+	bpf_link__detach(link);
+close:
+	xclose(conn);
+	xclose(peer);
+destroy:
+	test_sockmap_pass_prog__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -943,4 +987,6 @@ void test_sockmap_basic(void)
 		test_skmsg_helpers_with_link(BPF_MAP_TYPE_SOCKMAP);
 	if (test__start_subtest("sockhash sk_msg attach sockhash helpers with link"))
 		test_skmsg_helpers_with_link(BPF_MAP_TYPE_SOCKHASH);
+	if (test__start_subtest("sockmap skb_verdict vsock poll"))
+		test_sockmap_skb_verdict_vsock_poll();
 }

-- 
2.46.2


