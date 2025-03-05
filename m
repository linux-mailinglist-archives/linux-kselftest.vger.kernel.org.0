Return-Path: <linux-kselftest+bounces-28343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBCBA50D9F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 22:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EF7189163A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE2A259498;
	Wed,  5 Mar 2025 21:35:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2258C2010F2;
	Wed,  5 Mar 2025 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210519; cv=none; b=qPT690jW6uIbH3LDSTBEejpXjL9/17eYT4ihA7y98y1UYPBjpmIfC27JhEWFgdIHvjZLWRZpPXnnQZ8WzzGHK2hfdt2V9KQ763poWqTST9O2sZRK9JXgdiSX3vYp2hZJJA+1kYokK0p3BXJuZ3ohAK1eNWApR5t9fI7+21C4jKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210519; c=relaxed/simple;
	bh=Wm7j1HgWk83EfFZ1iocToVAvL6arPbxN5Wq3/m91XlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bInzQBjaISJDnHUmRJ0g+qxEcy4N2EuijmQ4Ox9/XbmW9R1mFHCE25wVdR7CaVO920swCSMGSVF5Y2MZBOwG5afqVq4pfZc2YUHvye69kTUcMIFzEdiDUx3kHW+nFDNaFzUQMxl7CI903W4pMlOc1gfPAFaqodnV5YskNIA1nsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO3-000K1O-Ah; Wed, 05 Mar 2025 22:34:43 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO2-000MHO-1P;
	Wed, 05 Mar 2025 22:34:43 +0100
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
Subject: [PATCH bpf-next v5 5/6] selftests/bpf: add test for XDP metadata support in tun driver
Date: Wed,  5 Mar 2025 21:34:37 +0000
Message-ID: <20250305213438.3863922-6-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305213438.3863922-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250305213438.3863922-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27568/Wed Mar  5 10:48:48 2025)

Add a selftest that creates a tap device, attaches XDP and TC programs,
writes a packet with a test payload into the tap device and checks the
test result. This test ensures that the XDP metadata support in the tun
driver is enabled and that the metadata size is correctly passed to the
skb.

See the previous commit ("selftests/bpf: refactor xdp_context_functional
test and bpf program") for details about the test design.

The test runs in its own network namespace. This provides some extra
safety against conflicting interface names.

Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
---
 .../bpf/prog_tests/xdp_context_test_run.c     | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 78ca01edb050..b9d9f0a502ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -8,6 +8,8 @@
 #define TX_NAME "veth1"
 #define TX_NETNS "xdp_context_tx"
 #define RX_NETNS "xdp_context_rx"
+#define TAP_NAME "tap0"
+#define TAP_NETNS "xdp_context_tuntap"
 
 #define TEST_PAYLOAD_LEN 32
 static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
@@ -255,3 +257,67 @@ void test_xdp_context_veth(void)
 	netns_free(tx_ns);
 }
 
+void test_xdp_context_tuntap(void)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct netns_obj *ns = NULL;
+	struct test_xdp_meta *skel = NULL;
+	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
+	int tap_fd = -1;
+	int tap_ifindex;
+	int ret;
+
+	ns = netns_new(TAP_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
+	tap_fd = open_tuntap(TAP_NAME, true);
+	if (!ASSERT_GE(tap_fd, 0, "open_tuntap"))
+		goto close;
+
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
+	netns_free(ns);
+}
-- 
2.43.0


