Return-Path: <linux-kselftest+bounces-27361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F993A4265B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 16:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04506170743
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 15:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E0225A635;
	Mon, 24 Feb 2025 15:29:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC12561D1;
	Mon, 24 Feb 2025 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410987; cv=none; b=RmHdSAKWLmqA1lRroHfq5ij2N6pevWUzH9UnG76neeOWX6EM1a++YfbDwMQthWCPgx9nFkCX/QTeCqV/o50upvaX00J1pK7Czgg2aiQRSAKyI6YnlnX5R9eut38uwvwL9qekJ8tuvBF51h0eyoY+cs6QXo8wvW/zanGsmaQ97JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410987; c=relaxed/simple;
	bh=Bz9QAvk0n62OqPIRtmIU+QS9wEusbclae33SDw6IB54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcdxB7kg1Xzo4rYpnwIjWkLV2jCqdVzOaFzx+B1syffxHj4sZhBPjcsc7J+oASV02FEP35oHWyMYqDl8Ga6bTpBrQ7tiE2GvP9VTXZqZs+IpDhdskUKU25512gHc55zKA7NvCccGNg+XKLWBpeH0V4F963JNywISekHbpG+EwkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tmaOR-000A2H-3P; Mon, 24 Feb 2025 16:29:15 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tmaOQ-0005Hj-2m;
	Mon, 24 Feb 2025 16:29:14 +0100
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	marcus.wichelmann@hetzner-cloud.de
Subject: [PATCH bpf-next v3 5/6] selftests/bpf: add test for XDP metadata support in tun driver
Date: Mon, 24 Feb 2025 15:29:08 +0000
Message-ID: <20250224152909.3911544-6-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27559/Mon Feb 24 10:44:14 2025)

Add a selftest that creates a tap device, attaches XDP and TC programs,
writes a packet with a test payload into the tap device and checks the
test result. This test ensures that the XDP metadata support in the tun
driver is enabled and that the metadata size is correctly passed to the
skb.

See the previous commit ("selftests/bpf: refactor xdp_context_functional
test and bpf program") for details about the test design.

Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
---
 .../bpf/prog_tests/xdp_context_test_run.c     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 4043f220d7c0..60aad6bd8882 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -8,6 +8,7 @@
 #define TX_NAME "veth1"
 #define TX_NETNS "xdp_context_tx"
 #define RX_NETNS "xdp_context_rx"
+#define TAP_NAME "tap0"
 
 #define TEST_PAYLOAD_LEN 32
 static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
@@ -251,3 +252,66 @@ void test_xdp_context_veth(void)
 	netns_free(tx_ns);
 }
 
+void test_xdp_context_tuntap(void)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct test_xdp_meta *skel = NULL;
+	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
+	int tap_fd = -1;
+	int tap_ifindex;
+	int ret;
+
+	tap_fd = open_tuntap(TAP_NAME, true);
+	if (!ASSERT_GE(tap_fd, 0, "open_tuntap"))
+		goto close;
+
+	/* By default, Linux sends IPv6 multicast listener reports which
+	 * interfere with this test. Set the IFF_NOARP flag to ensure
+	 * silence on the interface.
+	 */
+	SYS(close, "ip link set dev " TAP_NAME " arp off");
+	SYS(close, "ip link set dev " TAP_NAME " up");
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		goto close;
+
+	tap_ifindex = if_nametoindex(TAP_NAME);
+	if (!ASSERT_GE(tap_ifindex, 0, "if_nametoindex"))
+		goto close;
+
+	tc_hook.ifindex = tap_ifindex;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto close;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.ing_cls);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto close;
+
+	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(skel->progs.ing_xdp),
+			     0, NULL);
+	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
+		goto close;
+
+	/* The ethernet header is not relevant for this test and doesn't need to
+	 * be meaningful.
+	 */
+	struct ethhdr eth = { 0 };
+
+	memcpy(packet, &eth, sizeof(eth));
+	memcpy(packet + sizeof(eth), test_payload, TEST_PAYLOAD_LEN);
+
+	ret = write(tap_fd, packet, sizeof(packet));
+	if (!ASSERT_EQ(ret, sizeof(packet), "write packet"))
+		goto close;
+
+	assert_test_result(skel);
+
+close:
+	if (tap_fd >= 0)
+		close(tap_fd);
+	test_xdp_meta__destroy(skel);
+}
-- 
2.43.0


