Return-Path: <linux-kselftest+bounces-49325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DA4D39E00
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 06:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79CCE3065295
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 05:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42606331205;
	Mon, 19 Jan 2026 05:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Um9LG8hh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF12A330B2C
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768801277; cv=none; b=etHzlybY+fJ8zLNHiE4Zq+6md+mfBGXOcb9+GSbRKLz0shHll3/0aT4j1oOKh6LlaokyKdElkUD1MBInaCZAZylILl+cQtr3ekoUM2EWrUkmwC7UK3AYLgxi8CiyKjcWts+F9S4u70iyRxogPlASc6V7OhWFlYPEPeKxOfxQ7Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768801277; c=relaxed/simple;
	bh=g38DlUZkRdlJ0ZSnW67GBayP+2oMQoROgzlN1EpP/Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDO/I9LzrIWCYGVllspU2MUQ8c4RMisyosk/s/EyOkHnCaBiimGqOBXn34fmEzrxjk+bqYee+gRslsSIzIgSB+g/vx1nP+IifpqqoDCW7rEKHd3PzF5q4snbS3trrRKELL1QrJ0v0RS/ZL+azWd9+gci1eYe+oDDFzlw74ZZDDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Um9LG8hh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768801274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+LmLXkMXMaFHSZYvpj4ayHWC8ZNpzFMrhh3QdVkU7o=;
	b=Um9LG8hhB5qWCp7kKzGm8SVcxuD9+EcCedrBTjWHnKC/eio6vg4hSzsnq5K2uuHFfraqGc
	jfEuT1PFLhapcxbCdMoJ+hWgAO5uegd0QKXfVKDfK+HLsP6iYC1DDdtpFjSbeaKKGpYmCX
	FA2O5f81oqbi4ZVhODpffotBseeN7y0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-SWdWfrV5POCJzviLI3Aaww-1; Mon,
 19 Jan 2026 00:41:11 -0500
X-MC-Unique: SWdWfrV5POCJzviLI3Aaww-1
X-Mimecast-MFC-AGG-ID: SWdWfrV5POCJzviLI3Aaww_1768801269
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C800918003FD;
	Mon, 19 Jan 2026 05:41:09 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C55C61800994;
	Mon, 19 Jan 2026 05:41:02 +0000 (UTC)
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
Subject: [PATCH net-next v5 6/7] selftest: tun: Add test for receiving gso packet from tun
Date: Mon, 19 Jan 2026 13:40:03 +0800
Message-ID: <2e77843bfa9f6b89168436631309eac12ee70cca.1768800198.git.xudu@redhat.com>
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

The test validate that GSO information are correctly exposed
when reading packets from a TUN device.

Signed-off-by: Xu Du <xudu@redhat.com>
---
v1 -> v2:
 - Use previous helper to simplify tunnel packet sending.
 - Treat read timeout (EAGAIN) as assertion failure.
 - Correct spelling of 'recieve' to 'receive'.

 tools/testing/selftests/net/tun.c | 194 ++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index f0ddb5d37683..628ae2caf6f4 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -364,6 +364,116 @@ static int ip_route_check(const char *intf, int family, void *addr)
 	return 0;
 }
 
+static int send_gso_udp_msg(int socket, struct sockaddr_storage *addr,
+			    uint8_t *send_buf, int send_len, int gso_size)
+{
+	char control[CMSG_SPACE(sizeof(uint16_t))] = { 0 };
+	int alen = sockaddr_len(addr->ss_family);
+	struct msghdr msg = { 0 };
+	struct iovec iov = { 0 };
+	int ret;
+
+	iov.iov_base = send_buf;
+	iov.iov_len = send_len;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_name = addr;
+	msg.msg_namelen = alen;
+
+	if (gso_size > 0) {
+		struct cmsghdr *cmsg;
+
+		msg.msg_control = control;
+		msg.msg_controllen = sizeof(control);
+
+		cmsg = CMSG_FIRSTHDR(&msg);
+		cmsg->cmsg_level = SOL_UDP;
+		cmsg->cmsg_type = UDP_SEGMENT;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(uint16_t));
+		*(uint16_t *)CMSG_DATA(cmsg) = gso_size;
+	}
+
+	ret = sendmsg(socket, &msg, 0);
+	if (ret < 0)
+		perror("sendmsg");
+
+	return ret;
+}
+
+static int validate_hdrlen(uint8_t **cur, int *len, int x)
+{
+	if (*len < x)
+		return -1;
+	*cur += x;
+	*len -= x;
+	return 0;
+}
+
+static int parse_udp_tunnel_vnet_packet(uint8_t *buf, int len, int tunnel_type,
+					bool is_tap)
+{
+	struct ipv6hdr *iph6;
+	struct udphdr *udph;
+	struct iphdr *iph4;
+	uint8_t *cur = buf;
+
+	if (validate_hdrlen(&cur, &len, TUN_VNET_TNL_SIZE))
+		return -1;
+
+	if (is_tap) {
+		if (validate_hdrlen(&cur, &len, ETH_HLEN))
+			return -1;
+	}
+
+	if (tunnel_type & UDP_TUNNEL_OUTER_IPV4) {
+		iph4 = (struct iphdr *)cur;
+		if (validate_hdrlen(&cur, &len, sizeof(struct iphdr)))
+			return -1;
+		if (iph4->version != 4 || iph4->protocol != IPPROTO_UDP)
+			return -1;
+	} else {
+		iph6 = (struct ipv6hdr *)cur;
+		if (validate_hdrlen(&cur, &len, sizeof(struct ipv6hdr)))
+			return -1;
+		if (iph6->version != 6 || iph6->nexthdr != IPPROTO_UDP)
+			return -1;
+	}
+
+	udph = (struct udphdr *)cur;
+	if (validate_hdrlen(&cur, &len, sizeof(struct udphdr)))
+		return -1;
+	if (ntohs(udph->dest) != VN_PORT)
+		return -1;
+
+	if (validate_hdrlen(&cur, &len, GENEVE_HLEN))
+		return -1;
+	if (validate_hdrlen(&cur, &len, ETH_HLEN))
+		return -1;
+
+	if (tunnel_type & UDP_TUNNEL_INNER_IPV4) {
+		iph4 = (struct iphdr *)cur;
+		if (validate_hdrlen(&cur, &len, sizeof(struct iphdr)))
+			return -1;
+		if (iph4->version != 4 || iph4->protocol != IPPROTO_UDP)
+			return -1;
+	} else {
+		iph6 = (struct ipv6hdr *)cur;
+		if (validate_hdrlen(&cur, &len, sizeof(struct ipv6hdr)))
+			return -1;
+		if (iph6->version != 6 || iph6->nexthdr != IPPROTO_UDP)
+			return -1;
+	}
+
+	udph = (struct udphdr *)cur;
+	if (validate_hdrlen(&cur, &len, sizeof(struct udphdr)))
+		return -1;
+	if (ntohs(udph->dest) != UDP_DST_PORT)
+		return -1;
+
+	return len;
+}
+
 FIXTURE(tun)
 {
 	char ifname[IFNAMSIZ];
@@ -664,6 +774,68 @@ receive_gso_packet_from_tunnel(FIXTURE_DATA(tun_vnet_udptnl) * self,
 	return total_len;
 }
 
+static int send_gso_packet_into_tunnel(FIXTURE_DATA(tun_vnet_udptnl) * self,
+				       const FIXTURE_VARIANT(tun_vnet_udptnl) *
+					       variant)
+{
+	int family = (variant->tunnel_type & UDP_TUNNEL_INNER_IPV4) ? AF_INET :
+								      AF_INET6;
+	uint8_t buf[MAX_VNET_TUNNEL_PACKET_SZ] = { 0 };
+	int payload_len = variant->data_size;
+	int gso_size = variant->gso_size;
+	struct sockaddr_storage ssa, dsa;
+
+	assign_sockaddr_vars(family, 0, &ssa, &dsa);
+	return send_gso_udp_msg(self->sock, &dsa, buf, payload_len, gso_size);
+}
+
+static int
+receive_gso_packet_from_tun(FIXTURE_DATA(tun_vnet_udptnl) * self,
+			    const FIXTURE_VARIANT(tun_vnet_udptnl) * variant,
+			    struct virtio_net_hdr_v1_hash_tunnel *vnet_hdr)
+{
+	struct timeval timeout = { .tv_sec = TIMEOUT_SEC };
+	uint8_t buf[MAX_VNET_TUNNEL_PACKET_SZ];
+	int tunnel_type = variant->tunnel_type;
+	int payload_len = variant->data_size;
+	bool is_tap = variant->is_tap;
+	int ret, len, total_len = 0;
+	int tun_fd = self->fd;
+	fd_set fdset;
+
+	while (total_len < payload_len) {
+		FD_ZERO(&fdset);
+		FD_SET(tun_fd, &fdset);
+
+		ret = select(tun_fd + 1, &fdset, NULL, NULL, &timeout);
+		if (ret <= 0) {
+			perror("select");
+			break;
+		}
+		if (!FD_ISSET(tun_fd, &fdset))
+			continue;
+
+		len = read(tun_fd, buf, sizeof(buf));
+		if (len <= 0) {
+			if (len < 0 && errno != EAGAIN && errno != EWOULDBLOCK)
+				perror("read");
+			break;
+		}
+
+		len = parse_udp_tunnel_vnet_packet(buf, len, tunnel_type,
+						   is_tap);
+		if (len < 0)
+			continue;
+
+		if (total_len == 0)
+			memcpy(vnet_hdr, buf, TUN_VNET_TNL_SIZE);
+
+		total_len += len;
+	}
+
+	return total_len;
+}
+
 TEST_F(tun_vnet_udptnl, send_gso_packet)
 {
 	uint8_t pkt[MAX_VNET_TUNNEL_PACKET_SZ];
@@ -680,4 +852,26 @@ TEST_F(tun_vnet_udptnl, send_gso_packet)
 	ASSERT_EQ(r_num_mss, variant->r_num_mss);
 }
 
+TEST_F(tun_vnet_udptnl, recv_gso_packet)
+{
+	struct virtio_net_hdr_v1_hash_tunnel vnet_hdr = { 0 };
+	struct virtio_net_hdr_v1 *vh = &vnet_hdr.hash_hdr.hdr;
+	int ret, gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
+
+	ret = send_gso_packet_into_tunnel(self, variant);
+	ASSERT_EQ(ret, variant->data_size);
+
+	memset(&vnet_hdr, 0, sizeof(vnet_hdr));
+	ret = receive_gso_packet_from_tun(self, variant, &vnet_hdr);
+	ASSERT_EQ(ret, variant->data_size);
+
+	if (!variant->no_gso) {
+		ASSERT_EQ(vh->gso_size, variant->gso_size);
+		gso_type |= (variant->tunnel_type & UDP_TUNNEL_OUTER_IPV4) ?
+				    (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4) :
+				    (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6);
+		ASSERT_EQ(vh->gso_type, gso_type);
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.49.0


