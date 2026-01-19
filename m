Return-Path: <linux-kselftest+bounces-49324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85026D39DFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 06:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BE42305BC1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 05:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3EA330D35;
	Mon, 19 Jan 2026 05:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIzC7aUw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F650330B2E
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768801269; cv=none; b=sRSVYLFzx2s5p3mNtD2RIAQI1vxUlQzM/IGH/J2KLg/p3WNaEUWyUdYrpFUpjQ1wf3yFJtMtmwJEW1JvUg1zo8WZ+eojva6nn+HfXbpRUaM54UB9jiZQq7Sm8pr0HhRJjVNa6t9MQ7f2z5geW99i4l4tZ4noYFRkQfEybFJFBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768801269; c=relaxed/simple;
	bh=r1GIHPsQXqh4NzWIRRAFxrdy8aRnIFNORBQkE2f8a20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arrOJv4ShW8Su1YBcixu/jY3hP5ltdtAjEVizfjW1DtSqFFJidqkWXeZOmk3cm2D9NtgP/3evIoe5twJYaRiYRBEPOGbWu4OqV7xYflJ3EPvBagr6zE0XnNdgNnD9Kl3Ji9q3AU8xWqkpKAWzIltynnKPhBieJzHHjHh4tzHJ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIzC7aUw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768801267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jVfxCv38JtbRl/2k2l0lZedi5OEIHN4mUj3DSEDDH4=;
	b=JIzC7aUwKUFcwxfFdf7n5cN8ufgz53ZrqrR7Qw1nUNmBoy2Wwp0WAplazJzinIt4c+lO8O
	+RbFpcqvjMWYHdMzc75I68lYrZfh9zhsKspGAyYWGm2H5xf4yEKijQKJNpXJYGus7u6SbZ
	f/J48+Tke5Yr3nJZNokOmwLyRY0VErk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-kirIsUZmMg-63DiUr7Jqew-1; Mon,
 19 Jan 2026 00:41:03 -0500
X-MC-Unique: kirIsUZmMg-63DiUr7Jqew-1
X-Mimecast-MFC-AGG-ID: kirIsUZmMg-63DiUr7Jqew_1768801261
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C264F1954B0B;
	Mon, 19 Jan 2026 05:41:01 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BA2E18004D8;
	Mon, 19 Jan 2026 05:40:52 +0000 (UTC)
From: Xu Du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 5/7] selftest: tun: Add test for sending gso packet into tun
Date: Mon, 19 Jan 2026 13:40:02 +0800
Message-ID: <fb91f56131fa49592a2f80790ea1a56a4d2c2fb6.1768800198.git.xudu@redhat.com>
In-Reply-To: <cover.1768800198.git.xudu@redhat.com>
References: <cover.1768800198.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The test constructs a raw packet, prepends a virtio_net_hdr,
and writes the result to the TUN device. This mimics the behavior
of a vm forwarding a guest's packet to the host networking stack.

Signed-off-by: Xu Du <xudu@redhat.com>
---
v4 -> v5:
 - Use Geneve instead of VXLAN due to missing YNL support.

v3 -> v4:
 - Expand the buffer to accommodate the maximum length of test packets.

v1 -> v2:
 - Correct spelling of 'recieve' to 'receive'.
 - Avoid busy waiting caused by recv() returning empty.

 tools/testing/selftests/net/tun.c | 144 ++++++++++++++++++++++++++++--
 1 file changed, 135 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index ec089355312b..f0ddb5d37683 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -75,7 +75,34 @@ static struct in6_addr param_ipaddr6_inner_src = {
 #define UDP_TUNNEL_OUTER_IPV4 (UDP_TUNNEL_GENEVE_4IN4 | UDP_TUNNEL_GENEVE_6IN4)
 #define UDP_TUNNEL_INNER_IPV4 (UDP_TUNNEL_GENEVE_4IN4 | UDP_TUNNEL_GENEVE_4IN6)
 
+#define UDP_TUNNEL_GENEVE_4IN4_HDRLEN                        \
+	(ETH_HLEN + 2 * sizeof(struct iphdr) + GENEVE_HLEN + \
+	 2 * sizeof(struct udphdr))
+#define UDP_TUNNEL_GENEVE_6IN6_HDRLEN                          \
+	(ETH_HLEN + 2 * sizeof(struct ipv6hdr) + GENEVE_HLEN + \
+	 2 * sizeof(struct udphdr))
+#define UDP_TUNNEL_GENEVE_4IN6_HDRLEN                               \
+	(ETH_HLEN + sizeof(struct iphdr) + sizeof(struct ipv6hdr) + \
+	 GENEVE_HLEN + 2 * sizeof(struct udphdr))
+#define UDP_TUNNEL_GENEVE_6IN4_HDRLEN                               \
+	(ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct iphdr) + \
+	 GENEVE_HLEN + 2 * sizeof(struct udphdr))
+
+#define UDP_TUNNEL_HDRLEN(type)                                             \
+	((type) == UDP_TUNNEL_GENEVE_4IN4 ? UDP_TUNNEL_GENEVE_4IN4_HDRLEN : \
+	 (type) == UDP_TUNNEL_GENEVE_6IN6 ? UDP_TUNNEL_GENEVE_6IN6_HDRLEN : \
+	 (type) == UDP_TUNNEL_GENEVE_4IN6 ? UDP_TUNNEL_GENEVE_4IN6_HDRLEN : \
+	 (type) == UDP_TUNNEL_GENEVE_6IN4 ? UDP_TUNNEL_GENEVE_6IN4_HDRLEN : \
+					    0)
+
+#define UDP_TUNNEL_MSS(type) (ETH_DATA_LEN - UDP_TUNNEL_HDRLEN(type))
+#define UDP_TUNNEL_MAX(type, is_tap) \
+	(ETH_MAX_MTU - UDP_TUNNEL_HDRLEN(type) - ((is_tap) ? ETH_HLEN : 0))
+
 #define TUN_VNET_TNL_SIZE sizeof(struct virtio_net_hdr_v1_hash_tunnel)
+#define MAX_VNET_TUNNEL_PACKET_SZ                                       \
+	(TUN_VNET_TNL_SIZE + ETH_HLEN + UDP_TUNNEL_GENEVE_6IN6_HDRLEN + \
+	 ETH_MAX_MTU)
 
 struct geneve_setup_config {
 	int family;
@@ -408,15 +435,23 @@ FIXTURE(tun_vnet_udptnl)
 FIXTURE_VARIANT(tun_vnet_udptnl)
 {
 	int tunnel_type;
-	bool is_tap;
+	int gso_size;
+	int data_size;
+	int r_num_mss;
+	bool is_tap, no_gso;
 };
 
 /* clang-format off */
 #define TUN_VNET_UDPTNL_VARIANT_ADD(type, desc)                              \
-	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##udptnl) {                 \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##_1mss) {                  \
+		/* send a single MSS: fall back to no GSO */                 \
 		.tunnel_type = type,                                         \
+		.gso_size = UDP_TUNNEL_MSS(type),                            \
+		.data_size = UDP_TUNNEL_MSS(type),                           \
+		.r_num_mss = 1,                                              \
 		.is_tap = true,                                              \
-	}
+		.no_gso = true,                                              \
+	};
 /* clang-format on */
 
 TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_GENEVE_4IN4, 4in4);
@@ -544,14 +579,105 @@ FIXTURE_TEARDOWN(tun_vnet_udptnl)
 	EXPECT_EQ(ret, 0);
 }
 
-TEST_F(tun_vnet_udptnl, basic)
+static int build_gso_packet_into_tun(const FIXTURE_VARIANT(tun_vnet_udptnl) *
+					     variant,
+				     uint8_t *buf)
 {
-	int ret;
-	char cmd[256] = { 0 };
+	int pktlen, hlen, proto, inner_family, outer_family;
+	int tunnel_type = variant->tunnel_type;
+	int payload_len = variant->data_size;
+	int gso_size = variant->gso_size;
+	uint8_t *outer_udph, *cur = buf;
+	void *sip, *dip, *smac, *dmac;
+	bool is_tap = variant->is_tap;
 
-	sprintf(cmd, "ip addr show %s > /dev/null 2>&1", param_dev_geneve_name);
-	ret = system(cmd);
-	ASSERT_EQ(ret, 0);
+	hlen = (is_tap ? ETH_HLEN : 0) + UDP_TUNNEL_HDRLEN(tunnel_type);
+	inner_family = (tunnel_type & UDP_TUNNEL_INNER_IPV4) ? AF_INET :
+							       AF_INET6;
+	outer_family = (tunnel_type & UDP_TUNNEL_OUTER_IPV4) ? AF_INET :
+							       AF_INET6;
+
+	cur += build_virtio_net_hdr_v1_hash_tunnel(cur, is_tap, hlen, gso_size,
+						   outer_family, inner_family);
+
+	pktlen = hlen + payload_len;
+	assign_ifaddr_vars(outer_family, 1, &sip, &dip, &smac, &dmac);
+
+	if (is_tap) {
+		proto = outer_family == AF_INET ? ETH_P_IP : ETH_P_IPV6;
+		pktlen -= ETH_HLEN;
+		cur += build_eth(cur, proto, dmac, smac);
+	}
+
+	if (outer_family == AF_INET) {
+		pktlen = pktlen - sizeof(struct iphdr);
+		cur += build_ipv4_header(cur, IPPROTO_UDP, pktlen, dip, sip);
+	} else {
+		pktlen = pktlen - sizeof(struct ipv6hdr);
+		cur += build_ipv6_header(cur, IPPROTO_UDP, 0, pktlen, dip, sip);
+	}
+
+	outer_udph = cur;
+	assign_ifaddr_vars(inner_family, 0, &sip, &dip, &smac, &dmac);
+
+	pktlen -= sizeof(struct udphdr);
+	proto = inner_family == AF_INET ? ETH_P_IP : ETH_P_IPV6;
+	cur += build_udp_header(cur, UDP_SRC_PORT, VN_PORT, pktlen);
+	cur += build_geneve_header(cur, VN_ID);
+	cur += build_eth(cur, proto, dmac, smac);
+
+	pktlen = sizeof(struct udphdr) + payload_len;
+	if (inner_family == AF_INET)
+		cur += build_ipv4_header(cur, IPPROTO_UDP, pktlen, dip, sip);
+	else
+		cur += build_ipv6_header(cur, IPPROTO_UDP, 0, pktlen, dip, sip);
+
+	cur += build_udp_packet(cur, UDP_DST_PORT, UDP_SRC_PORT, payload_len,
+				inner_family, false);
+
+	build_udp_packet_csum(outer_udph, outer_family, false);
+
+	return cur - buf;
+}
+
+static int
+receive_gso_packet_from_tunnel(FIXTURE_DATA(tun_vnet_udptnl) * self,
+			       const FIXTURE_VARIANT(tun_vnet_udptnl) * variant,
+			       int *r_num_mss)
+{
+	uint8_t packet_buf[MAX_VNET_TUNNEL_PACKET_SZ];
+	int len, total_len = 0, socket = self->sock;
+	int payload_len = variant->data_size;
+
+	while (total_len < payload_len) {
+		len = recv(socket, packet_buf, sizeof(packet_buf), 0);
+		if (len <= 0) {
+			if (len < 0 && errno != EAGAIN && errno != EWOULDBLOCK)
+				perror("recv");
+			break;
+		}
+
+		(*r_num_mss)++;
+		total_len += len;
+	}
+
+	return total_len;
+}
+
+TEST_F(tun_vnet_udptnl, send_gso_packet)
+{
+	uint8_t pkt[MAX_VNET_TUNNEL_PACKET_SZ];
+	int r_num_mss = 0;
+	int ret, off;
+
+	memset(pkt, 0, sizeof(pkt));
+	off = build_gso_packet_into_tun(variant, pkt);
+	ret = write(self->fd, pkt, off);
+	ASSERT_EQ(ret, off);
+
+	ret = receive_gso_packet_from_tunnel(self, variant, &r_num_mss);
+	ASSERT_EQ(ret, variant->data_size);
+	ASSERT_EQ(r_num_mss, variant->r_num_mss);
 }
 
 TEST_HARNESS_MAIN
-- 
2.49.0


