Return-Path: <linux-kselftest+bounces-48161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2E3CF1C22
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 04:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CF45307444E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 03:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F87A322A1C;
	Mon,  5 Jan 2026 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELkm7DPU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F32BE7A7
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 03:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767584728; cv=none; b=bEaDCLQPPYiNNqf929swhL4HznPp+FLlwy4lci0LLPAT/B1Dz1HelTv+C0if+ht8a9CDl4s1rHV5lgnXVJF3pxTLJSqh58cr/Zx39nwUibwhfUN1cnkiAJQ58RbAsbjYxVhKmpXKzb29kM190RqvDsoYf333xRFzWb0K7WOHSkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767584728; c=relaxed/simple;
	bh=rYIGwxdyyDFJzbHkSQ4Qpnaw9f0IJXAK7EI/W8QH/1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA7JPhDDeaCK3Jvf84qgyc/wfvZ/4Yy4cbGPcJIegqN986dxH9bgPp79aN3ZKv03HhVdSaikYFzPn7zcGaiZf15bOY17aNLf0TRO2AEhN7gNS2aeIiXGuihiixDNoV06RiftHqNx3NIfS4vOt864QyVZ0fSVbZ3vTRtXCDZuMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELkm7DPU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767584724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+aXhTY78WTxjb513TYN05IMY/BXabHyFAPbfjjGPHtI=;
	b=ELkm7DPU5NdyDecOPWVFy/2HoBm0dNEPsJHESHvbMaRR6Q61tzuCAq2tq7omET91Fm4OWo
	1Ok4sM1/F/S2gE2YmIbQFcYiRe9t9G2z+Ot1BlEFSd8klx0Ytz6Z5A01awcZiIpHhA5+rM
	QMS24Epo9qbUOqh0rB+FX5igZUT3wu0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-sMoj3zVtMs647K5rw_YIhQ-1; Sun,
 04 Jan 2026 22:45:21 -0500
X-MC-Unique: sMoj3zVtMs647K5rw_YIhQ-1
X-Mimecast-MFC-AGG-ID: sMoj3zVtMs647K5rw_YIhQ_1767584719
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFDAB1956088;
	Mon,  5 Jan 2026 03:45:19 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBCEB1800367;
	Mon,  5 Jan 2026 03:45:15 +0000 (UTC)
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
Subject: [PATCH net-next v3 6/8] selftest: tun: Add test for sending gso packet into tun
Date: Mon,  5 Jan 2026 11:44:41 +0800
Message-ID: <0231daf13d95c02a7c13f38ffe9860b07091e3db.1767580224.git.xudu@redhat.com>
In-Reply-To: <cover.1767580224.git.xudu@redhat.com>
References: <cover.1767580224.git.xudu@redhat.com>
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
v1 -> v2:
 - Correct spelling of 'recieve' to 'receive'.
 - Avoid busy waiting caused by recv() returning empty.

 tools/testing/selftests/net/tun.c | 149 ++++++++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index add5e91df6c9..dc114237adda 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -77,6 +77,31 @@ static struct in6_addr param_ipaddr6_inner_src = {
 
 #define TUN_VNET_TNL_SIZE sizeof(struct virtio_net_hdr_v1_hash_tunnel)
 
+#define MAX_VNET_TUNNEL_PACKET_SZ (TUN_VNET_TNL_SIZE + ETH_HLEN + ETH_MAX_MTU)
+
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
 struct vxlan_setup_config {
 	struct sockaddr_storage local_ip;
 	struct sockaddr_storage remote_ip;
@@ -402,15 +427,23 @@ FIXTURE(tun_vnet_udptnl)
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
@@ -558,14 +591,112 @@ FIXTURE_TEARDOWN(tun_vnet_udptnl)
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


