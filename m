Return-Path: <linux-kselftest+bounces-28340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52677A50D92
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 22:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B43189043F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D3A2505AE;
	Wed,  5 Mar 2025 21:35:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D72E336F;
	Wed,  5 Mar 2025 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210515; cv=none; b=ja89VGfKW7SY9OtWtHOcEHD+2EeT3QbtjbUYTT2dRviwENGXpJHjwgpZEMAmRjkD056cVztI3QSXnG7CkTAoydhRfggqYIqF0zZAEnv2m8mu0IJbipMAdA5/imns/QLyLRUKx9uB2999tEGeBzGQktEKYyBQy8dKNozfLyS8iiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210515; c=relaxed/simple;
	bh=xvBXAhdwthiiXYueUAodS61M5UdB1KJ7yDJg0ZB7hEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mN9IfKmkmsD0WgUacJAfQ25/bGxFRdiWeRdWlgIgZI+i2hVtw6I5i6PiT5RBBv/hG7JHAUiIz7LYgwrAeKbIee/vLbIJ6y6aTvJsMYRK8XBoTgEZlgrexmCO0m7PXuStfUcadMZWQ0DC+njU8BDGVbKQb58bLbAuD+wDmXaVA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO3-000K1L-7z; Wed, 05 Mar 2025 22:34:43 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO2-000MHO-12;
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
	marcus.wichelmann@hetzner-cloud.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf-next v5 4/6] selftests/bpf: refactor xdp_context_functional test and bpf program
Date: Wed,  5 Mar 2025 21:34:36 +0000
Message-ID: <20250305213438.3863922-5-marcus.wichelmann@hetzner-cloud.de>
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

The Ethernet header of that custom packet is all-zero, because it is not
required to be valid for the test to work. The zero ethertype also helps
to filter out packets that are not related to the test and would
otherwise interfere with it.

The payload of the Ethernet packet is used as the test data that is
expected to be passed as metadata from the XDP to the TC program and
written to the map. It has a fixed size of 32 bytes which is a
reasonable size that should be supported by both drivers. Additional
packet headers are not necessary for the test and were therefore skipped
to keep the testing code short.

This new testing methodology no longer requires the veth interfaces to
have IP addresses assigned, therefore these were removed.

Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c     | 79 +++++++++++++++++--
 .../selftests/bpf/progs/test_xdp_meta.c       | 53 +++++++++----
 2 files changed, 110 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 937da9b7532a..78ca01edb050 100644
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
@@ -112,7 +118,59 @@ void test_xdp_context_test_run(void)
 	test_xdp_context_test_run__destroy(skel);
 }
 
-void test_xdp_context_functional(void)
+static int send_test_packet(int ifindex)
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
+static void assert_test_result(struct test_xdp_meta *skel)
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
@@ -120,7 +178,7 @@ void test_xdp_context_functional(void)
 	struct bpf_program *tc_prog, *xdp_prog;
 	struct test_xdp_meta *skel = NULL;
 	struct nstoken *nstoken = NULL;
-	int rx_ifindex;
+	int rx_ifindex, tx_ifindex;
 	int ret;
 
 	tx_ns = netns_new(TX_NETNS, false);
@@ -138,7 +196,6 @@ void test_xdp_context_functional(void)
 	if (!ASSERT_OK_PTR(nstoken, "setns rx_ns"))
 		goto close;
 
-	SYS(close, "ip addr add " RX_ADDR "/24 dev " RX_NAME);
 	SYS(close, "ip link set dev " RX_NAME " up");
 
 	skel = test_xdp_meta__open_and_load();
@@ -179,9 +236,17 @@ void test_xdp_context_functional(void)
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
index fe2d71ae0e71..fcf6ca14f2ea 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -4,37 +4,50 @@
 
 #include <bpf/bpf_helpers.h>
 
-#define __round_mask(x, y) ((__typeof__(x))((y) - 1))
-#define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
+#define META_SIZE 32
+
 #define ctx_ptr(ctx, mem) (void *)(unsigned long)ctx->mem
 
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
+
 SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
-	__u8 *data, *data_meta, *data_end;
-	__u32 diff = 0;
+	__u8 *data, *data_meta;
+	__u32 key = 0;
 
 	data_meta = ctx_ptr(ctx, data_meta);
-	data_end  = ctx_ptr(ctx, data_end);
 	data      = ctx_ptr(ctx, data);
 
-	if (data + ETH_ALEN > data_end ||
-	    data_meta + round_up(ETH_ALEN, 4) > data)
+	if (data_meta + META_SIZE > data)
 		return TC_ACT_SHOT;
 
-	diff |= ((__u32 *)data_meta)[0] ^ ((__u32 *)data)[0];
-	diff |= ((__u16 *)data_meta)[2] ^ ((__u16 *)data)[2];
+	bpf_map_update_elem(&test_result, &key, data_meta, BPF_ANY);
 
-	return diff ? TC_ACT_SHOT : TC_ACT_OK;
+	return TC_ACT_SHOT;
 }
 
 SEC("xdp")
 int ing_xdp(struct xdp_md *ctx)
 {
-	__u8 *data, *data_meta, *data_end;
+	__u8 *data, *data_meta, *data_end, *payload;
+	struct ethhdr *eth;
 	int ret;
 
-	ret = bpf_xdp_adjust_meta(ctx, -round_up(ETH_ALEN, 4));
+	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
 	if (ret < 0)
 		return XDP_DROP;
 
@@ -42,11 +55,21 @@ int ing_xdp(struct xdp_md *ctx)
 	data_end  = ctx_ptr(ctx, data_end);
 	data      = ctx_ptr(ctx, data);
 
-	if (data + ETH_ALEN > data_end ||
-	    data_meta + round_up(ETH_ALEN, 4) > data)
+	eth = (struct ethhdr *)data;
+	payload = data + sizeof(struct ethhdr);
+
+	if (payload + META_SIZE > data_end ||
+	    data_meta + META_SIZE > data)
+		return XDP_DROP;
+
+	/* The Linux networking stack may send other packets on the test
+	 * interface that interfere with the test. Just drop them.
+	 * The test packets can be recognized by their ethertype of zero.
+	 */
+	if (eth->h_proto != 0)
 		return XDP_DROP;
 
-	__builtin_memcpy(data_meta, data, ETH_ALEN);
+	__builtin_memcpy(data_meta, payload, META_SIZE);
 	return XDP_PASS;
 }
 
-- 
2.43.0


