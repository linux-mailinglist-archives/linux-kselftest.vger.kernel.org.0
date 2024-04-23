Return-Path: <linux-kselftest+bounces-8686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B34C8AE255
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0001C217A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156F354BE7;
	Tue, 23 Apr 2024 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYg/z36t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB3208BC;
	Tue, 23 Apr 2024 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868555; cv=none; b=Mbpt0EW1UcdvcZAa1jIPBama2HQRVgnmIB/5Zz3NFxvt02VVWUuvX1bo+AyVofdnhio6OH1R5h6xyidiARceDYXuTzmMQe9az5zU1uSzlD+B7o52/5/kgFNQZc+2Z+kHAFyED1FKxZc6Z5/pTR1DuV7pKBpPGKKMQLQ8f8OsPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868555; c=relaxed/simple;
	bh=Kh24xx74BMiBf0zBPKwV+/aaiP33cTYPW17+8U10VwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AXJA99c2gUnfPc8nHSwYuGDDGODzgo+RTeK15e1fbGI2HqTNp2gSjMLkrICbuBdE/lstPO5MGMPfNnr9S/B3j16Uk+3/GSsDFRxlMEsl671tqkXtiHXVxWYhT81/HNykfvPAzvRbWGYWj3zpQuh7Bjleawoc7D4Rox28JQ2+EGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYg/z36t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCE5C116B1;
	Tue, 23 Apr 2024 10:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713868554;
	bh=Kh24xx74BMiBf0zBPKwV+/aaiP33cTYPW17+8U10VwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYg/z36tMjK71wUAZMloc3wB2oHOXeTjoXXmC9W1AA0YwW0mqkSEsL0lZPhq/9aut
	 A/WzdyW69M0aVbuyeu38fpeMss/sW6YfuF6ejxrBZWKT1g9znysBKEMkJA4cgI+mIk
	 08KLLedCYGu02kCp0fwM+4xJ0RgUncPqChz51GgzpnXZWEeU8UUATLkwS9dcxjk+dj
	 s70DuKbiAZ36gxnyAYGrnYQPVz/A2iy5fJ9FNTmNayYUe+UNjEI6/4vO7BkqT343eK
	 w/yDLIZmI5P/cLrlrABuhp6XluELBhZWSKrqmAknmvtw0r/8rw3LxLAYxNfIwIlaSp
	 hbqQgMEPqO3fQ==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next v2 2/5] selftests/bpf: Use log_err in open_netns/close_netns
Date: Tue, 23 Apr 2024 18:35:28 +0800
Message-Id: <d1dad22b2ff4909af3f8bfd0667d046e235303cb.1713868264.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713868264.git.tanggeliang@kylinos.cn>
References: <cover.1713868264.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

ASSERT helpers defined in test_progs.h shouldn't be used in public
functions like open_netns() and close_netns(). Since they depend on
test__fail() which defined in test_progs.c. Public functions may be
used not only in test_progs.c, but in other tests like test_sock_addr.c
in the next commit.

This patch uses log_err() to replace ASSERT helpers in open_netns()
and close_netns() in network_helpers.c to decouple dependencies, then
uses ASSERT_OK_PTR() to check the return values of all open_netns().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 19 ++++++++++++++-----
 .../selftests/bpf/prog_tests/empty_skb.c      |  2 ++
 .../bpf/prog_tests/ip_check_defrag.c          |  2 ++
 .../selftests/bpf/prog_tests/tc_redirect.c    |  2 +-
 .../selftests/bpf/prog_tests/test_tunnel.c    |  4 ++++
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 16 ++++++++++++++++
 6 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index b2f531a6a4c7..c134cd740638 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -459,22 +459,30 @@ struct nstoken *open_netns(const char *name)
 	struct nstoken *token;
 
 	token = calloc(1, sizeof(struct nstoken));
-	if (!ASSERT_OK_PTR(token, "malloc token"))
+	if (!token) {
+		log_err("Failed to malloc token");
 		return NULL;
+	}
 
 	token->orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
-	if (!ASSERT_GE(token->orig_netns_fd, 0, "open /proc/self/ns/net"))
+	if (token->orig_netns_fd == -1) {
+		log_err("Failed to open /proc/self/ns/net");
 		goto fail;
+	}
 
 	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
 	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
-	if (!ASSERT_GE(nsfd, 0, "open netns fd"))
+	if (nsfd == -1) {
+		log_err("Failed to open netns fd");
 		goto fail;
+	}
 
 	err = setns(nsfd, CLONE_NEWNET);
 	close(nsfd);
-	if (!ASSERT_OK(err, "setns"))
+	if (err) {
+		log_err("Failed to setns");
 		goto fail;
+	}
 
 	return token;
 fail:
@@ -488,7 +496,8 @@ void close_netns(struct nstoken *token)
 	if (!token)
 		return;
 
-	ASSERT_OK(setns(token->orig_netns_fd, CLONE_NEWNET), "setns");
+	if (setns(token->orig_netns_fd, CLONE_NEWNET))
+		log_err("Failed to setns");
 	close(token->orig_netns_fd);
 	free(token);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
index 261228eb68e8..438583e1f2d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/empty_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
@@ -94,6 +94,8 @@ void test_empty_skb(void)
 
 	SYS(out, "ip netns add empty_skb");
 	tok = open_netns("empty_skb");
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
 	SYS(out, "ip link add veth0 type veth peer veth1");
 	SYS(out, "ip link set dev veth0 up");
 	SYS(out, "ip link set dev veth1 up");
diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
index 8dd2af9081f4..284764e7179f 100644
--- a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
@@ -88,6 +88,8 @@ static int attach(struct ip_check_defrag *skel, bool ipv6)
 	int err = -1;
 
 	nstoken = open_netns(NS1);
+	if (!ASSERT_OK_PTR(nstoken, "setns"))
+		goto out;
 
 	skel->links.defrag = bpf_program__attach_netfilter(skel->progs.defrag, &opts);
 	if (!ASSERT_OK_PTR(skel->links.defrag, "program attach"))
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index dbe06aeaa2b2..b1073d36d77a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -530,7 +530,7 @@ static int wait_netstamp_needed_key(void)
 	__u64 tstamp = 0;
 
 	nstoken = open_netns(NS_DST);
-	if (!nstoken)
+	if (!ASSERT_OK_PTR(nstoken, "setns dst"))
 		return -1;
 
 	srv_fd = start_server(AF_INET6, SOCK_DGRAM, "::1", 0, 0);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 5f1fb0a2ea56..cec746e77cd3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -612,6 +612,8 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 
 	/* ping from at_ns0 namespace test */
 	nstoken = open_netns("at_ns0");
+	if (!ASSERT_OK_PTR(nstoken, "setns"))
+		goto done;
 	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
 	if (!ASSERT_OK(err, "test_ping"))
 		goto done;
@@ -666,6 +668,8 @@ static void test_xfrm_tunnel(void)
 
 	/* ping from at_ns0 namespace test */
 	nstoken = open_netns("at_ns0");
+	if (!ASSERT_OK_PTR(nstoken, "setns"))
+		goto done;
 	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
 	close_netns(nstoken);
 	if (!ASSERT_OK(err, "test_ping"))
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 05edcf32f528..f76b5d67a3ee 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -384,6 +384,8 @@ void test_xdp_metadata(void)
 	SYS(out, "ip netns add " RX_NETNS_NAME);
 
 	tok = open_netns(TX_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
 	SYS(out, "ip link add numtxqueues 1 numrxqueues 1 " TX_NAME
 	    " type veth peer " RX_NAME " numtxqueues 1 numrxqueues 1");
 	SYS(out, "ip link set " RX_NAME " netns " RX_NETNS_NAME);
@@ -400,6 +402,8 @@ void test_xdp_metadata(void)
 	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME_VLAN);
 
 	switch_ns_to_rx(&tok);
+	if (!ASSERT_OK_PTR(tok, "setns rx"))
+		goto out;
 
 	SYS(out, "ip link set dev " RX_NAME " address " RX_MAC);
 	SYS(out, "ip link set dev " RX_NAME " up");
@@ -449,6 +453,8 @@ void test_xdp_metadata(void)
 		goto out;
 
 	switch_ns_to_tx(&tok);
+	if (!ASSERT_OK_PTR(tok, "setns tx"))
+		goto out;
 
 	/* Setup separate AF_XDP for TX interface nad send packet to the RX socket. */
 	tx_ifindex = if_nametoindex(TX_NAME);
@@ -461,6 +467,8 @@ void test_xdp_metadata(void)
 		goto out;
 
 	switch_ns_to_rx(&tok);
+	if (!ASSERT_OK_PTR(tok, "setns rx"))
+		goto out;
 
 	/* Verify packet sent from AF_XDP has proper metadata. */
 	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk, true), 0,
@@ -468,6 +476,8 @@ void test_xdp_metadata(void)
 		goto out;
 
 	switch_ns_to_tx(&tok);
+	if (!ASSERT_OK_PTR(tok, "setns tx"))
+		goto out;
 	complete_tx(&tx_xsk);
 
 	/* Now check metadata of packet, generated with network stack */
@@ -475,6 +485,8 @@ void test_xdp_metadata(void)
 		goto out;
 
 	switch_ns_to_rx(&tok);
+	if (!ASSERT_OK_PTR(tok, "setns rx"))
+		goto out;
 
 	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk, false), 0,
 		       "verify_xsk_metadata"))
@@ -498,6 +510,8 @@ void test_xdp_metadata(void)
 		goto out;
 
 	switch_ns_to_tx(&tok);
+	if (!ASSERT_OK_PTR(tok, "setns tx"))
+		goto out;
 
 	/* Send packet to trigger . */
 	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
@@ -505,6 +519,8 @@ void test_xdp_metadata(void)
 		goto out;
 
 	switch_ns_to_rx(&tok);
+	if (!ASSERT_OK_PTR(tok, "setns rx"))
+		goto out;
 
 	while (!retries--) {
 		if (bpf_obj2->bss->called)
-- 
2.40.1


