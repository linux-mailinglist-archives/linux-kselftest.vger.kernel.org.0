Return-Path: <linux-kselftest+bounces-26793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6F7A38ABB
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 18:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB173ABC0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 17:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A5E22A4D0;
	Mon, 17 Feb 2025 17:39:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64922A7EC;
	Mon, 17 Feb 2025 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813976; cv=none; b=FflGjJgCR9F1iV93ydUlz310IuWk2Km5yPYTbf+tjo+rL7vAhYA5B1R/gfOsFupkvGnfFybD6pMS23rNa3gfHSHQ1FwUliXM1URsSWAXZDMwl6Y3fWfBeHat0MbVw9ebBSj6eeQfN0gmgxYzXag5VA4Oe6vJYm945LFss7fKr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813976; c=relaxed/simple;
	bh=3CAhi3EQrac5XAyZya0eABm6m4TO+XgBEKBgDLz3e1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQkpUptoJlGzBwT6iJoZP8avj0viRPyYMLDf5wZd2A8WOKDMfygRFAwFAH/DdpAvv4Yp+ZkOCjrlkgdxZJ7kgyH77MQo5c/0/fN4R6dKMw7fElTgN2MAwk8tXCqmsBpk9WRxnpgJ7xTiyeicdjlYI9yOnw2th57/oVoxP2F6Yq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tk4pt-0001wo-Vo; Mon, 17 Feb 2025 18:23:13 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tk4pt-000Opa-2N;
	Mon, 17 Feb 2025 18:23:13 +0100
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
	ast@kernel.org,
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
	mykolal@fb.com,
	shuah@kernel.org,
	hawk@kernel.org,
	marcus.wichelmann@hetzner-cloud.de
Subject: [PATCH bpf-next v2 4/6] selftests/bpf: refactor xdp_context_functional test and bpf program
Date: Mon, 17 Feb 2025 17:23:06 +0000
Message-ID: <20250217172308.3291739-5-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27552/Mon Feb 17 10:47:21 2025)

The existing XDP metadata test works by creating a veth pair and
attaching XDP & TC programs that drop the packet when the condition of
the test isn't fulfilled. The test then pings through the veth pair and
succeeds when the ping comes through.

While this test works great for a veth pair, it is hard to replicate for
tap devices to test the XDP metadata support of them. A similar test for
the tun driver would either involve logic to reply to the ping request,
or would have to capture the packet to check if it was dropped or not.

To make the testing of other drivers easier while still maximizing code
reuse, this commit refactors the existing xdp_context_functional test to
use a test_result map. Instead of conditionally passing or dropping the
packet, the TC program is changed to copy the received metadata into the
value of that single-entry array map. Tests can then verify that the map
value matches the expectation.

This testing logic is easy to adapt to other network drivers as the only
remaining requirement is that there is some way to send a custom
Ethernet packet through it that triggers the XDP & TC programs.

The payload of the Ethernet packet is used as the test data that is
expected to be passed as metadata from the XDP to the TC program and
written to the map. It has a fixed size of 32 bytes which is a
reasonalbe size that should be supported by both drivers. Additional
packet headers are not necessary for the test and were therefore skipped
to keep the testing code short.

Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
---
 .../bpf/prog_tests/xdp_context_test_run.c     | 93 +++++++++++++++----
 .../selftests/bpf/progs/test_xdp_meta.c       | 56 ++++++-----
 2 files changed, 106 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 937da9b7532a..0cd2a0d8ae60 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -4,13 +4,19 @@
 #include "test_xdp_context_test_run.skel.h"
 #include "test_xdp_meta.skel.h"
 
-#define TX_ADDR "10.0.0.1"
-#define RX_ADDR "10.0.0.2"
 #define RX_NAME "veth0"
 #define TX_NAME "veth1"
 #define TX_NETNS "xdp_context_tx"
 #define RX_NETNS "xdp_context_rx"
 
+#define TEST_PAYLOAD_LEN 32
+static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
+	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+};
+
 void test_xdp_context_error(int prog_fd, struct bpf_test_run_opts opts,
 			    __u32 data_meta, __u32 data, __u32 data_end,
 			    __u32 ingress_ifindex, __u32 rx_queue_index,
@@ -112,15 +118,66 @@ void test_xdp_context_test_run(void)
 	test_xdp_context_test_run__destroy(skel);
 }
 
-void test_xdp_context_functional(void)
+int send_test_packet(int ifindex)
+{
+	int n, sock = -1;
+	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
+
+	/* The ethernet header is not relevant for this test and doesn't need to
+	 * be meaningful.
+	 */
+	struct ethhdr eth = { 0 };
+
+	memcpy(packet, &eth, sizeof(eth));
+	memcpy(packet + sizeof(eth), test_payload, TEST_PAYLOAD_LEN);
+
+	sock = socket(AF_PACKET, SOCK_RAW, IPPROTO_RAW);
+	if (!ASSERT_GE(sock, 0, "socket"))
+		goto err;
+
+	struct sockaddr_ll saddr = {
+		.sll_family = PF_PACKET,
+		.sll_ifindex = ifindex,
+		.sll_halen = ETH_ALEN
+	};
+	n = sendto(sock, packet, sizeof(packet), 0, (struct sockaddr *)&saddr,
+		   sizeof(saddr));
+	if (!ASSERT_EQ(n, sizeof(packet), "sendto"))
+		goto err;
+
+	close(sock);
+	return 0;
+
+err:
+	if (sock >= 0)
+		close(sock);
+	return -1;
+}
+
+void assert_test_result(struct test_xdp_meta *skel)
+{
+	int err;
+	__u32 map_key = 0;
+	__u8 map_value[TEST_PAYLOAD_LEN];
+
+	err = bpf_map__lookup_elem(skel->maps.test_result, &map_key,
+				   sizeof(map_key), &map_value,
+				   TEST_PAYLOAD_LEN, BPF_ANY);
+	if (!ASSERT_OK(err, "lookup test_result"))
+		return;
+
+	ASSERT_MEMEQ(&map_value, &test_payload, TEST_PAYLOAD_LEN,
+		     "test_result map contains test payload");
+}
+
+void test_xdp_context_veth(void)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
 	struct netns_obj *rx_ns = NULL, *tx_ns = NULL;
-	struct bpf_program *tc_prog, *xdp_prog;
 	struct test_xdp_meta *skel = NULL;
 	struct nstoken *nstoken = NULL;
-	int rx_ifindex;
+	int rx_ifindex, tx_ifindex;
 	int ret;
 
 	tx_ns = netns_new(TX_NETNS, false);
@@ -138,7 +195,6 @@ void test_xdp_context_functional(void)
 	if (!ASSERT_OK_PTR(nstoken, "setns rx_ns"))
 		goto close;
 
-	SYS(close, "ip addr add " RX_ADDR "/24 dev " RX_NAME);
 	SYS(close, "ip link set dev " RX_NAME " up");
 
 	skel = test_xdp_meta__open_and_load();
@@ -154,21 +210,12 @@ void test_xdp_context_functional(void)
 	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
 		goto close;
 
-	tc_prog = bpf_object__find_program_by_name(skel->obj, "ing_cls");
-	if (!ASSERT_OK_PTR(tc_prog, "open ing_cls prog"))
-		goto close;
-
-	tc_opts.prog_fd = bpf_program__fd(tc_prog);
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.ing_cls);
 	ret = bpf_tc_attach(&tc_hook, &tc_opts);
 	if (!ASSERT_OK(ret, "bpf_tc_attach"))
 		goto close;
 
-	xdp_prog = bpf_object__find_program_by_name(skel->obj, "ing_xdp");
-	if (!ASSERT_OK_PTR(xdp_prog, "open ing_xdp prog"))
-		goto close;
-
-	ret = bpf_xdp_attach(rx_ifindex,
-			     bpf_program__fd(xdp_prog),
+	ret = bpf_xdp_attach(rx_ifindex, bpf_program__fd(skel->progs.ing_xdp),
 			     0, NULL);
 	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
 		goto close;
@@ -179,9 +226,17 @@ void test_xdp_context_functional(void)
 	if (!ASSERT_OK_PTR(nstoken, "setns tx_ns"))
 		goto close;
 
-	SYS(close, "ip addr add " TX_ADDR "/24 dev " TX_NAME);
 	SYS(close, "ip link set dev " TX_NAME " up");
-	ASSERT_OK(SYS_NOFAIL("ping -c 1 " RX_ADDR), "ping");
+
+	tx_ifindex = if_nametoindex(TX_NAME);
+	if (!ASSERT_GE(tx_ifindex, 0, "if_nametoindex tx"))
+		goto close;
+
+	ret = send_test_packet(tx_ifindex);
+	if (!ASSERT_OK(ret, "send_test_packet"))
+		goto close;
+
+	assert_test_result(skel);
 
 close:
 	close_netns(nstoken);
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index fe2d71ae0e71..56a83307b483 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -4,49 +4,57 @@
 
 #include <bpf/bpf_helpers.h>
 
-#define __round_mask(x, y) ((__typeof__(x))((y) - 1))
-#define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
-#define ctx_ptr(ctx, mem) (void *)(unsigned long)ctx->mem
+#define META_SIZE 32
+
+/* Demonstrates how metadata can be passed from an XDP program to a TC program
+ * using bpf_xdp_adjust_meta.
+ * For the sake of testing the metadata support in drivers, the XDP program uses
+ * a fixed-size payload after the Ethernet header as metadata. The TC program
+ * copies the metadata it receives into a map so it can be checked from
+ * userspace.
+ */
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__uint(value_size, META_SIZE);
+} test_result SEC(".maps");
 
 SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
-	__u8 *data, *data_meta, *data_end;
-	__u32 diff = 0;
+	void *data_meta = (void *)(unsigned long)ctx->data_meta;
+	void *data = (void *)(unsigned long)ctx->data;
 
-	data_meta = ctx_ptr(ctx, data_meta);
-	data_end  = ctx_ptr(ctx, data_end);
-	data      = ctx_ptr(ctx, data);
-
-	if (data + ETH_ALEN > data_end ||
-	    data_meta + round_up(ETH_ALEN, 4) > data)
+	if (data_meta + META_SIZE > data)
 		return TC_ACT_SHOT;
 
-	diff |= ((__u32 *)data_meta)[0] ^ ((__u32 *)data)[0];
-	diff |= ((__u16 *)data_meta)[2] ^ ((__u16 *)data)[2];
+	int key = 0;
+
+	bpf_map_update_elem(&test_result, &key, data_meta, BPF_ANY);
 
-	return diff ? TC_ACT_SHOT : TC_ACT_OK;
+	return TC_ACT_SHOT;
 }
 
 SEC("xdp")
 int ing_xdp(struct xdp_md *ctx)
 {
-	__u8 *data, *data_meta, *data_end;
-	int ret;
-
-	ret = bpf_xdp_adjust_meta(ctx, -round_up(ETH_ALEN, 4));
+	int ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
 	if (ret < 0)
 		return XDP_DROP;
 
-	data_meta = ctx_ptr(ctx, data_meta);
-	data_end  = ctx_ptr(ctx, data_end);
-	data      = ctx_ptr(ctx, data);
+	void *data_meta = (void *)(unsigned long)ctx->data_meta;
+	void *data = (void *)(unsigned long)ctx->data;
+	void *data_end = (void *)(unsigned long)ctx->data_end;
 
-	if (data + ETH_ALEN > data_end ||
-	    data_meta + round_up(ETH_ALEN, 4) > data)
+	void *payload = data + sizeof(struct ethhdr);
+
+	if (data_meta + META_SIZE > data || payload + META_SIZE > data_end)
 		return XDP_DROP;
 
-	__builtin_memcpy(data_meta, data, ETH_ALEN);
+	__builtin_memcpy(data_meta, payload, META_SIZE);
+
 	return XDP_PASS;
 }
 
-- 
2.43.0


