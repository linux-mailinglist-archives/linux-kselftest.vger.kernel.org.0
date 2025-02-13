Return-Path: <linux-kselftest+bounces-26540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA051A33EA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 13:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B433A954E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B518D23A988;
	Thu, 13 Feb 2025 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="SbwUG6i8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4DC221722;
	Thu, 13 Feb 2025 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447993; cv=none; b=gJ0KX5atN0NU2e0tKVMtjMShDIiTNGQKigfw7NHComU2P+BUR25b0Mnj8IQLdpTPtOHlsb+BAQuyu22qe/6mzp47691NC9kOwyf1sPIt7ANVAg+O31Gz22uTifsuf+tKk3vP6Cn28OCijGe149OYjmNpZirtLE+qNTXDXWlO5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447993; c=relaxed/simple;
	bh=fMoXLuF5d8eGMrBTitSutfWb/zAV/yVFvE4nKp2F/yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5ivUuj4kUsX5rG9bpZhnJNqbSIwvsHNfNce6h7UYWCQK7cd3SH0QkytiYeLnaIXeRp+RCVAbyVxoKdTRWoRqEigs4VovFmqz8WVlj2zJ8/0t5WMGxHWGSVSo7nFubiQqtTt8emVI3wsfcJ61rRQhU2VDiOKQ63tN59fyCuHyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=SbwUG6i8; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tiXsc-002RsM-JX; Thu, 13 Feb 2025 12:59:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=7HwOodpeouGmCMVjpYK3Qh6CQjYz2QlZ4WQNHLx8gUE=; b=SbwUG6i8CBxSgLg+kO/ewCegmG
	SOAcpo9fPBLs90OfMIRhPGThSJA8QOl5syRnt7VT+MFg1aWyumAKN53k5s42+M08JbqLRZQPsnALq
	HIcZY4tysagJznG8NZ/KDARoAMZyTX2umd8mpvdj3aN5nnk+bn4wOk0ZevGuI4JCSasW4Bh48oZxS
	kB3Z81XtLI0CD2qBdDCJYfJH8fHbalPvhH7wPzmz7Sc5qAG/JIpTw5i94PsVzBKTh3hw1lMw0PyiI
	aw+OWahR9lbZ3mmNck4+A2oDEJfo3yDAjyIHG/lMMNFa5NdQ2Fr6vrBqbazWio+Eqb0XL9su0DJ+z
	GHWaNorA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tiXsc-0004rG-4A; Thu, 13 Feb 2025 12:59:42 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tiXsE-008u87-1A; Thu, 13 Feb 2025 12:59:18 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 13 Feb 2025 12:58:52 +0100
Subject: [PATCH net 4/4] selftest/bpf: Add vsock test for sockmap rejecting
 unconnected
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-vsock-listen-sockmap-nullptr-v1-4-994b7cd2f16b@rbox.co>
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
In-Reply-To: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Verify that for a connectible AF_VSOCK socket, merely having a transport
assigned is insufficient; socket must be connected for the sockmap to
accept.

This does not test datagram vsocks. Even though it hardly matters. VMCI is
the only transport that features VSOCK_TRANSPORT_F_DGRAM, but it has an
unimplemented vsock_transport::readskb() callback, making it unsupported by
BPF/sockmap.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 21793d8c79e12b6e607f59ecebb26448c310044b..05eb37935c3e290ee52b8d8c7c3e3a8db026cba2 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1065,6 +1065,34 @@ static void test_sockmap_skb_verdict_vsock_poll(void)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
+static void test_sockmap_vsock_unconnected(void)
+{
+	struct sockaddr_storage addr;
+	int map, s, zero = 0;
+	socklen_t alen;
+
+	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
+			     sizeof(int), 1, NULL);
+	if (!ASSERT_OK_FD(map, "bpf_map_create"))
+		return;
+
+	s = xsocket(AF_VSOCK, SOCK_STREAM, 0);
+	if (s < 0)
+		goto close_map;
+
+	/* Fail connect(), but trigger transport assignment. */
+	init_addr_loopback(AF_VSOCK, &addr, &alen);
+	if (!ASSERT_ERR(connect(s, sockaddr(&addr), alen), "connect"))
+		goto close_sock;
+
+	ASSERT_ERR(bpf_map_update_elem(map, &zero, &s, BPF_ANY), "map_update");
+
+close_sock:
+	xclose(s);
+close_map:
+	xclose(map);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -1131,4 +1159,6 @@ void test_sockmap_basic(void)
 		test_skmsg_helpers_with_link(BPF_MAP_TYPE_SOCKHASH);
 	if (test__start_subtest("sockmap skb_verdict vsock poll"))
 		test_sockmap_skb_verdict_vsock_poll();
+	if (test__start_subtest("sockmap vsock unconnected"))
+		test_sockmap_vsock_unconnected();
 }

-- 
2.48.1


