Return-Path: <linux-kselftest+bounces-48265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4439CF6516
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 02:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18D88303E0F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 01:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2FD3164C2;
	Tue,  6 Jan 2026 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LO52RI6T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951502868B2
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663364; cv=none; b=fyKqByytF6daUNonIrR6ULx/EIhaY2mYXtphoFybHL7jcTRnNub+QVLd5Lq/Ho6pZRoCauxRm33wfI5nwbolxYD6ZsGleqK7EQ2Q9M0mL2BX8FMYJxrkQw1vygXQH+dCp7na5COrCgVc3ELY30+4k4re1lJiVaYi8owMBt57f9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663364; c=relaxed/simple;
	bh=1Q1RiDIAFkCQpUf2Av+niR0MOVEyfWEtRaYvKQV0ctY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtQ1uTHXpDunxuj0v963ZMpc5ShKiRjblgUlXIjrnQ8kyHMRX0gzYWldeKUApQtTSIkZ0cUisM0LaLM54ET/b0CpHMOQAqa2eBWUtuMw+w5nIiZJmLpmqAlUV8wUByA7HYrIm3GzV4sk5cS44XD/5UiRO4fxehZDkLnOr0NN5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LO52RI6T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767663361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVLA9fiklNQD9VQBuHy22IKHtUeJIXv5AwA+1ApaiNA=;
	b=LO52RI6Td3gLkpby2V/0IZE9dun01gXG9cjBX4LDpemdjl4eNA16tTaErJH9N6HhGCtd1t
	kcKd44jmMfn0s3ki4iWAlbjMqTXnU/11mwDp4CN72ZtZHIuuu7LVMcunfNRH3XoZXgqCik
	RuE2+I5B3AuS/JseEJoKqWDJROj3+90=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-S3W0UybXMLuXhJ4K6z1OrQ-1; Mon,
 05 Jan 2026 20:35:58 -0500
X-MC-Unique: S3W0UybXMLuXhJ4K6z1OrQ-1
X-Mimecast-MFC-AGG-ID: S3W0UybXMLuXhJ4K6z1OrQ_1767663357
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC554195DE48;
	Tue,  6 Jan 2026 01:35:56 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1555E180044F;
	Tue,  6 Jan 2026 01:35:52 +0000 (UTC)
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
Subject: [PATCH net-next v4 6/8] selftest: tun: Add test for sending gso packet into tun
Date: Tue,  6 Jan 2026 09:35:19 +0800
Message-ID: <cd042fefae2613b0d519cbc0fadf84e82b4ea93d.1767597114.git.xudu@redhat.com>
In-Reply-To: <cover.1767597114.git.xudu@redhat.com>
References: <cover.1767597114.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The test constructs a raw packet, prepends a virtio_net_hdr,
and writes the result to the TUN device. This mimics the behavior
of a vm forwarding a guest's packet to the host networking stack.

Signed-off-by: Xu Du <xudu@redhat.com>
---
v3 -> v4:
 - Expand the buffer to accommodate the maximum length of test packets.

v1 -> v2:
 - Correct spelling of 'recieve' to 'receive'.
 - Avoid busy waiting caused by recv() returning empty.

 tools/testing/selftests/net/tun.c | 151 ++++++++++++++++++++++++++++--
 1 file changed, 142 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index add5e91df6c9..ececc5ed4909 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -75,8 +75,35 @@ static struct in6_addr param_ipaddr6_inner_src = {
 #define UDP_TUNNEL_OUTER_IPV4 (UDP_TUNNEL_VXLAN_4IN4 | UDP_TUNNEL_VXLAN_6IN4)
 #define UDP_TUNNEL_INNER_IPV4 (UDP_TUNNEL_VXLAN_4IN4 | UDP_TUNNEL_VXLAN_4IN6)
 
+#define UDP_TUNNEL_VXLAN_4IN4_HDRLEN \
+	(ETH_HLEN + 2 * sizeof(struct iphdr) + 8 + 2 * sizeof(struct udphdr))
+#define UDP_TUNNEL_VXLAN_6IN6_HDRLEN \
+	(ETH_HLEN + 2 * sizeof(struct ipv6hdr) + 8 + 2 * sizeof(struct udphdr))
+#define UDP_TUNNEL_VXLAN_4IN6_HDRLEN                                    \
+	(ETH_HLEN + sizeof(struct iphdr) + sizeof(struct ipv6hdr) + 8 + \
+	 2 * sizeof(struct udphdr))
+#define UDP_TUNNEL_VXLAN_6IN4_HDRLEN                                    \
+	(ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct iphdr) + 8 + \
+	 2 * sizeof(struct udphdr))
+
+#define UDP_TUNNEL_HDRLEN(type)                                           \
+	((type) == UDP_TUNNEL_VXLAN_4IN4 ? UDP_TUNNEL_VXLAN_4IN4_HDRLEN : \
+	 (type) == UDP_TUNNEL_VXLAN_6IN4 ? UDP_TUNNEL_VXLAN_6IN4_HDRLEN : \
+	 (type) == UDP_TUNNEL_VXLAN_4IN6 ? UDP_TUNNEL_VXLAN_4IN6_HDRLEN : \
+	 (type) == UDP_TUNNEL_VXLAN_6IN6 ? UDP_TUNNEL_VXLAN_6IN6_HDRLEN : \
+					   0)
+
+#define UDP_TUNNEL_MSS(type) (ETH_DATA_LEN - UDP_TUNNEL_HDRLEN(type))
+
+#define UDP_TUNNEL_MAX(type, is_tap) \
+	(ETH_MAX_MTU - UDP_TUNNEL_HDRLEN(type) - ((is_tap) ? ETH_HLEN : 0))
+
 #define TUN_VNET_TNL_SIZE sizeof(struct virtio_net_hdr_v1_hash_tunnel)
 
+#define MAX_VNET_TUNNEL_PACKET_SZ                                      \
+	(TUN_VNET_TNL_SIZE + ETH_HLEN + UDP_TUNNEL_VXLAN_6IN6_HDRLEN + \
+	 ETH_MAX_MTU)
+
 struct vxlan_setup_config {
 	struct sockaddr_storage local_ip;
 	struct sockaddr_storage remote_ip;
@@ -402,15 +429,23 @@ FIXTURE(tun_vnet_udptnl)
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
 
 TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_VXLAN_4IN4, 4in4);
@@ -558,14 +593,112 @@ FIXTURE_TEARDOWN(tun_vnet_udptnl)
 	EXPECT_EQ(ret, 0);
 }
 
-TEST_F(tun_vnet_udptnl, basic)
+static int build_gso_packet_into_tun(const FIXTURE_VARIANT(tun_vnet_udptnl) *
+					     variant,
+				     uint8_t *buf)
 {
-	int ret;
-	char cmd[256] = { 0 };
+	int tunnel_type = variant->tunnel_type;
+	int payload_len = variant->data_size;
+	int gso_size = variant->gso_size;
+	int inner_family, outer_family;
+	bool is_tap = variant->is_tap;
+	uint8_t *outer_udph = NULL;
+	uint8_t *cur = buf;
+	int len, proto;
+
+	len = (is_tap ? ETH_HLEN : 0) + UDP_TUNNEL_HDRLEN(tunnel_type);
+	inner_family = (tunnel_type & UDP_TUNNEL_INNER_IPV4) ? AF_INET :
+							       AF_INET6;
+	outer_family = (tunnel_type & UDP_TUNNEL_OUTER_IPV4) ? AF_INET :
+							       AF_INET6;
+
+	cur += build_virtio_net_hdr_v1_hash_tunnel(cur, is_tap, len, gso_size,
+						   outer_family, inner_family);
+
+	if (is_tap) {
+		proto = outer_family == AF_INET ? ETH_P_IP : ETH_P_IPV6;
+		cur += build_eth(cur, proto, param_hwaddr_outer_dst,
+				 param_hwaddr_outer_src);
+		len -= ETH_HLEN;
+	}
 
-	sprintf(cmd, "ip addr show %s > /dev/null 2>&1", param_dev_vxlan_name);
-	ret = system(cmd);
-	ASSERT_EQ(ret, 0);
+	if (outer_family == AF_INET) {
+		len = len - sizeof(struct iphdr) + payload_len;
+		cur += build_ipv4_header(cur, IPPROTO_UDP, len,
+					 &param_ipaddr4_outer_dst,
+					 &param_ipaddr4_outer_src);
+	} else {
+		len = len - sizeof(struct ipv6hdr) + payload_len;
+		cur += build_ipv6_header(cur, IPPROTO_UDP, 0, len,
+					 &param_ipaddr6_outer_dst,
+					 &param_ipaddr6_outer_src);
+	}
+
+	outer_udph = cur;
+	len -= sizeof(struct udphdr);
+	proto = inner_family == AF_INET ? ETH_P_IP : ETH_P_IPV6;
+	cur += build_udp_header(cur, UDP_SRC_PORT, VN_PORT, len);
+	cur += build_vxlan_header(cur, VN_ID);
+	cur += build_eth(cur, proto, param_hwaddr_inner_dst,
+			 param_hwaddr_inner_src);
+
+	len = sizeof(struct udphdr) + payload_len;
+	if (inner_family == AF_INET) {
+		cur += build_ipv4_header(cur, IPPROTO_UDP, len,
+					 &param_ipaddr4_inner_dst,
+					 &param_ipaddr4_inner_src);
+	} else {
+		cur += build_ipv6_header(cur, IPPROTO_UDP, 0, len,
+					 &param_ipaddr6_inner_dst,
+					 &param_ipaddr6_inner_src);
+	}
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


