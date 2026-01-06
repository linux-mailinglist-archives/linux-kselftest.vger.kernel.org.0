Return-Path: <linux-kselftest+bounces-48264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3CFCF653A
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 02:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 568533053723
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 01:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4033164B6;
	Tue,  6 Jan 2026 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMw52VLI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF513161A3
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663360; cv=none; b=W8F5zEZOoDPDGbTHhyaig023xxnfqsYjnxaqOCUP2SG5DFcVXH2/zFhdqgm+DtXo0YAIzr7nIfQlxNKgo+pKK3W/j/ZnmsOTcLuHRsxiwL27FtX/hQDaDmsFHgjyXnV5zmfdHCw9XRD8wh4BQqi7B8WZWlb84w0S8rmPLyy9oio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663360; c=relaxed/simple;
	bh=tAUYHEl6685CSsQlCLViu12gGje42jR1WClHXv8Kdc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQzsA9QLPRfbAPCLHzvPmZU3//d6deIo5Nor12GJbqY//d5Ln6gmdM7PhU9MS+5JMkmSO5nOksR/e1m+0s4py+TJPjpRjIlXUhm5x5s6l4Bc36Sj7QaoZOYAAr5W3FCL+8XHL0d/DOyTkk84LTqGIqN1DogQmdeseX5D4TM3ls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMw52VLI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767663357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpfI5p9F4UpUW06qF6WwOuqLV8kuSpKWxe//r7BovXA=;
	b=HMw52VLIIQEgu/lld5514oO2t4UfMBm2iV9QpeYZS5Lkw6aSkiASoqq6gYrWOnRt8iZwhe
	nWvSK7MsXhHd38hgkPjYQxGWxjSTG3x/Ucq4PMZV+Ps93DJW7ek1/6XeHos5TJZ+fOGdoQ
	FjsnaLVQkAoteauhBOL1Bie6ARqLozI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-i598fBnkPpywaZXxDWHu8g-1; Mon,
 05 Jan 2026 20:35:53 -0500
X-MC-Unique: i598fBnkPpywaZXxDWHu8g-1
X-Mimecast-MFC-AGG-ID: i598fBnkPpywaZXxDWHu8g_1767663352
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62B451800657;
	Tue,  6 Jan 2026 01:35:52 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F01E180049F;
	Tue,  6 Jan 2026 01:35:48 +0000 (UTC)
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
Subject: [PATCH net-next v4 5/8] selftest: tun: Add helpers for GSO over UDP tunnel
Date: Tue,  6 Jan 2026 09:35:18 +0800
Message-ID: <5a95d6bfc481e69307ef805d33b7aa5ab2d99865.1767597114.git.xudu@redhat.com>
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

In preparation for testing GSO over UDP tunnels, enhance the test
infrastructure to support a more complex data path involving a TUN
device and a VXLAN tunnel.

This patch introduces a dedicated setup/teardown topology that creates
both a VXLAN tunnel interface and a TUN interface. The TUN device acts
as the VTEP (Virtual Tunnel Endpoint), allowing it to send and receive
virtio-net packets. Note that after adding a new address to the UDP
tunnel, we need to wait a bit until the associated route is available.
This setup effectively tests the kernel's data path for encapsulated
traffic.

Additionally, a new data structure is defined to manage test parameters.
This structure is designed to be extensible, allowing different test
data and configurations to be easily added in subsequent patches.

Signed-off-by: Xu Du <xudu@redhat.com>
---
v1 -> v2:
 - Explicitly wait for successful target route lookup before transmitting
   the packets.
 - Add UDP connect() to verify remote reachability.
 - Abstract address assignment logic into helpers.

 tools/testing/selftests/net/tun.c | 439 ++++++++++++++++++++++++++++++
 1 file changed, 439 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 08e760fa5d15..add5e91df6c9 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -15,6 +15,78 @@
 #include "kselftest_harness.h"
 #include "tuntap_helpers.h"
 
+static const char param_dev_vxlan_name[] = "vxlan1";
+static unsigned char param_hwaddr_outer_dst[] = { 0x00, 0xfe, 0x98,
+						  0x14, 0x22, 0x42 };
+static unsigned char param_hwaddr_outer_src[] = { 0x00, 0xfe, 0x98,
+						  0x94, 0xd2, 0x43 };
+static unsigned char param_hwaddr_inner_dst[] = { 0x00, 0xfe, 0x98,
+						  0x94, 0x22, 0xcc };
+static unsigned char param_hwaddr_inner_src[] = { 0x00, 0xfe, 0x98,
+						  0x94, 0xd2, 0xdd };
+
+static struct in_addr param_ipaddr4_outer_dst = {
+	__constant_htonl(0xac100001),
+};
+
+static struct in_addr param_ipaddr4_outer_src = {
+	__constant_htonl(0xac100002),
+};
+
+static struct in_addr param_ipaddr4_inner_dst = {
+	__constant_htonl(0xac100101),
+};
+
+static struct in_addr param_ipaddr4_inner_src = {
+	__constant_htonl(0xac100102),
+};
+
+static struct in6_addr param_ipaddr6_outer_dst = {
+	{ { 0x20, 0x02, 0x0d, 0xb8, 0x01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 } },
+};
+
+static struct in6_addr param_ipaddr6_outer_src = {
+	{ { 0x20, 0x02, 0x0d, 0xb8, 0x01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 } },
+};
+
+static struct in6_addr param_ipaddr6_inner_dst = {
+	{ { 0x20, 0x02, 0x0d, 0xb8, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 } },
+};
+
+static struct in6_addr param_ipaddr6_inner_src = {
+	{ { 0x20, 0x02, 0x0d, 0xb8, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 } },
+};
+
+#define VN_ID 1
+#define VN_PORT 4789
+#define UDP_SRC_PORT 22
+#define UDP_DST_PORT 48878
+#define IPPREFIX_LEN 24
+#define IP6PREFIX_LEN 64
+#define TIMEOUT_SEC 10
+#define TIMEOUT_USEC 100000
+#define MAX_RETRIES 20
+
+#define UDP_TUNNEL_VXLAN_4IN4 0x01
+#define UDP_TUNNEL_VXLAN_6IN4 0x02
+#define UDP_TUNNEL_VXLAN_4IN6 0x04
+#define UDP_TUNNEL_VXLAN_6IN6 0x08
+
+#define UDP_TUNNEL_OUTER_IPV4 (UDP_TUNNEL_VXLAN_4IN4 | UDP_TUNNEL_VXLAN_6IN4)
+#define UDP_TUNNEL_INNER_IPV4 (UDP_TUNNEL_VXLAN_4IN4 | UDP_TUNNEL_VXLAN_4IN6)
+
+#define TUN_VNET_TNL_SIZE sizeof(struct virtio_net_hdr_v1_hash_tunnel)
+
+struct vxlan_setup_config {
+	struct sockaddr_storage local_ip;
+	struct sockaddr_storage remote_ip;
+	__be32 vni;
+	int remote_ifindex;
+	__be16 dst_port;
+	unsigned char hwaddr[6];
+	uint8_t csum;
+};
+
 static int tun_attach(int fd, char *dev)
 {
 	struct ifreq ifr;
@@ -67,6 +139,198 @@ static int tun_delete(char *dev)
 	return dev_delete(dev);
 }
 
+static size_t sockaddr_len(int family)
+{
+	return (family == AF_INET) ? sizeof(struct sockaddr_in) :
+				     sizeof(struct sockaddr_in6);
+}
+
+static int tun_open(char *dev, const int flags, const int hdrlen,
+		    const int features, const unsigned char *mac_addr)
+{
+	struct ifreq ifr = { 0 };
+	int fd, sk = -1;
+
+	fd = open("/dev/net/tun", O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		return -1;
+	}
+
+	ifr.ifr_flags = flags;
+	if (ioctl(fd, TUNSETIFF, (void *)&ifr) < 0) {
+		perror("ioctl(TUNSETIFF)");
+		goto err;
+	}
+	strcpy(dev, ifr.ifr_name);
+
+	if (hdrlen > 0) {
+		if (ioctl(fd, TUNSETVNETHDRSZ, &hdrlen) < 0) {
+			perror("ioctl(TUNSETVNETHDRSZ)");
+			goto err;
+		}
+	}
+
+	if (features) {
+		if (ioctl(fd, TUNSETOFFLOAD, features) < 0) {
+			perror("ioctl(TUNSETOFFLOAD)");
+			goto err;
+		}
+	}
+
+	sk = socket(PF_INET, SOCK_DGRAM, 0);
+	if (sk < 0) {
+		perror("socket");
+		goto err;
+	}
+
+	if (ioctl(sk, SIOCGIFFLAGS, &ifr) < 0) {
+		perror("ioctl(SIOCGIFFLAGS)");
+		goto err;
+	}
+
+	ifr.ifr_flags |= (IFF_UP | IFF_RUNNING);
+	if (ioctl(sk, SIOCSIFFLAGS, &ifr) < 0) {
+		perror("ioctl(SIOCSIFFLAGS)");
+		goto err;
+	}
+
+	if (mac_addr && flags & IFF_TAP) {
+		ifr.ifr_hwaddr.sa_family = ARPHRD_ETHER;
+		memcpy(ifr.ifr_hwaddr.sa_data, mac_addr, ETH_ALEN);
+
+		if (ioctl(sk, SIOCSIFHWADDR, &ifr) < 0) {
+			perror("ioctl(SIOCSIFHWADDR)");
+			goto err;
+		}
+	}
+
+out:
+	if (sk >= 0)
+		close(sk);
+	return fd;
+
+err:
+	close(fd);
+	fd = -1;
+	goto out;
+}
+
+static int vxlan_fill_rtattr(struct nlmsghdr *nh, void *data)
+{
+	struct vxlan_setup_config *vxlan = data;
+
+	rtattr_add_any(nh, IFLA_ADDRESS, vxlan->hwaddr, ETH_ALEN);
+	return 0;
+}
+
+static int vxlan_fill_info_data(struct nlmsghdr *nh, void *data)
+{
+	struct vxlan_setup_config *vxlan = data;
+
+	rtattr_add_any(nh, IFLA_VXLAN_LINK, &vxlan->remote_ifindex,
+		       sizeof(vxlan->remote_ifindex));
+	rtattr_add_any(nh, IFLA_VXLAN_ID, &vxlan->vni, sizeof(vxlan->vni));
+	rtattr_add_any(nh, IFLA_VXLAN_PORT, &vxlan->dst_port,
+		       sizeof(vxlan->dst_port));
+	rtattr_add_any(nh, IFLA_VXLAN_UDP_CSUM, &vxlan->csum,
+		       sizeof(vxlan->csum));
+
+	if (vxlan->remote_ip.ss_family == AF_INET) {
+		struct sockaddr_in *r = (struct sockaddr_in *)&vxlan->remote_ip;
+		struct sockaddr_in *l = (struct sockaddr_in *)&vxlan->local_ip;
+
+		rtattr_add_any(nh, IFLA_VXLAN_GROUP, &r->sin_addr,
+			       sizeof(struct in_addr));
+		rtattr_add_any(nh, IFLA_VXLAN_LOCAL, &l->sin_addr,
+			       sizeof(struct in_addr));
+	} else {
+		struct sockaddr_in6 *r6 =
+			(struct sockaddr_in6 *)&vxlan->remote_ip;
+		struct sockaddr_in6 *l6 =
+			(struct sockaddr_in6 *)&vxlan->local_ip;
+
+		rtattr_add_any(nh, IFLA_VXLAN_GROUP6, &r6->sin6_addr,
+			       sizeof(struct in6_addr));
+		rtattr_add_any(nh, IFLA_VXLAN_LOCAL6, &l6->sin6_addr,
+			       sizeof(struct in6_addr));
+	}
+
+	return 0;
+}
+
+static int set_pmtu_discover(int fd, bool is_ipv4)
+{
+	int level, name, val;
+
+	if (is_ipv4) {
+		level = SOL_IP;
+		name = IP_MTU_DISCOVER;
+		val = IP_PMTUDISC_DO;
+	} else {
+		level = SOL_IPV6;
+		name = IPV6_MTU_DISCOVER;
+		val = IPV6_PMTUDISC_DO;
+	}
+
+	return setsockopt(fd, level, name, &val, sizeof(val));
+}
+
+static int udp_socket_open(struct sockaddr_storage *ssa, bool do_frag,
+			   bool do_connect, struct sockaddr_storage *dsa)
+{
+	struct timeval to = { .tv_sec = TIMEOUT_SEC };
+	int fd, family = ssa->ss_family;
+	int salen = sockaddr_len(family);
+
+	fd = socket(family, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return -1;
+
+	if (bind(fd, (struct sockaddr *)ssa, salen) < 0) {
+		perror("bind");
+		goto err;
+	}
+
+	if (do_connect && connect(fd, (struct sockaddr *)dsa, salen) < 0) {
+		perror("connect");
+		goto err;
+	}
+
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &to, sizeof(to)) < 0) {
+		perror("setsockopt(SO_RCVTIMEO)");
+		goto err;
+	}
+
+	if (!do_frag && set_pmtu_discover(fd, family == AF_INET) < 0) {
+		perror("set_pmtu_discover");
+		goto err;
+	}
+	return fd;
+
+err:
+	close(fd);
+	return -1;
+}
+
+static int ip_route_check(const char *intf, int family, void *addr)
+{
+	int len = ip_addr_len(family) * 8;
+	int retries = MAX_RETRIES;
+
+	while (retries-- > 0) {
+		if (ip_route_get(intf, family, addr, len, RTN_LOCAL,
+				 RT_TABLE_LOCAL) > 0)
+			break;
+		usleep(TIMEOUT_USEC);
+	}
+
+	if (retries < 0)
+		return -1;
+
+	return 0;
+}
+
 FIXTURE(tun)
 {
 	char ifname[IFNAMSIZ];
@@ -129,4 +393,179 @@ TEST_F(tun, reattach_close_delete)
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
+FIXTURE(tun_vnet_udptnl)
+{
+	char ifname[IFNAMSIZ];
+	int fd, sock;
+};
+
+FIXTURE_VARIANT(tun_vnet_udptnl)
+{
+	int tunnel_type;
+	bool is_tap;
+};
+
+/* clang-format off */
+#define TUN_VNET_UDPTNL_VARIANT_ADD(type, desc)                              \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##udptnl) {                 \
+		.tunnel_type = type,                                         \
+		.is_tap = true,                                              \
+	}
+/* clang-format on */
+
+TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_VXLAN_4IN4, 4in4);
+TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_VXLAN_6IN4, 6in4);
+TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_VXLAN_4IN6, 4in6);
+TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_VXLAN_6IN6, 6in6);
+
+static void assign_ifaddr_vars(int family, int is_outer, void **srcip,
+			       void **dstip, void **lladdr, int *prefix)
+{
+	if (is_outer) {
+		if (family == AF_INET) {
+			*srcip = (void *)&param_ipaddr4_outer_src;
+			*dstip = (void *)&param_ipaddr4_outer_dst;
+		} else {
+			*srcip = (void *)&param_ipaddr6_outer_src;
+			*dstip = (void *)&param_ipaddr6_outer_dst;
+		}
+		*lladdr = param_hwaddr_outer_dst;
+	} else {
+		if (family == AF_INET) {
+			*srcip = (void *)&param_ipaddr4_inner_src;
+			*dstip = (void *)&param_ipaddr4_inner_dst;
+		} else {
+			*srcip = (void *)&param_ipaddr6_inner_src;
+			*dstip = (void *)&param_ipaddr6_inner_dst;
+		}
+		*lladdr = param_hwaddr_inner_dst;
+	}
+	*prefix = (family == AF_INET) ? IPPREFIX_LEN : IP6PREFIX_LEN;
+}
+
+static void assign_sockaddr_vars(int family, int is_outer,
+				 struct sockaddr_storage *src,
+				 struct sockaddr_storage *dst)
+{
+	struct sockaddr_in6 *s6, *d6;
+	struct sockaddr_in *s4, *d4;
+
+	if (is_outer) {
+		if (family == AF_INET) {
+			s4 = (struct sockaddr_in *)src;
+			d4 = (struct sockaddr_in *)dst;
+			s4->sin_family = AF_INET;
+			d4->sin_family = AF_INET;
+			s4->sin_addr = param_ipaddr4_outer_src;
+			d4->sin_addr = param_ipaddr4_outer_dst;
+		} else {
+			s6 = (struct sockaddr_in6 *)src;
+			d6 = (struct sockaddr_in6 *)dst;
+			s6->sin6_family = AF_INET6;
+			d6->sin6_family = AF_INET6;
+			s6->sin6_addr = param_ipaddr6_outer_src;
+			d6->sin6_addr = param_ipaddr6_outer_dst;
+		}
+	} else {
+		if (family == AF_INET) {
+			s4 = (struct sockaddr_in *)src;
+			d4 = (struct sockaddr_in *)dst;
+			s4->sin_family = AF_INET;
+			d4->sin_family = AF_INET;
+			s4->sin_addr = param_ipaddr4_inner_src;
+			d4->sin_addr = param_ipaddr4_inner_dst;
+			s4->sin_port = htons(UDP_SRC_PORT);
+			d4->sin_port = htons(UDP_DST_PORT);
+		} else {
+			s6 = (struct sockaddr_in6 *)src;
+			d6 = (struct sockaddr_in6 *)dst;
+			s6->sin6_family = AF_INET6;
+			d6->sin6_family = AF_INET6;
+			s6->sin6_addr = param_ipaddr6_inner_src;
+			d6->sin6_addr = param_ipaddr6_inner_dst;
+			s6->sin6_port = htons(UDP_SRC_PORT);
+			d6->sin6_port = htons(UDP_DST_PORT);
+		}
+	}
+}
+
+FIXTURE_SETUP(tun_vnet_udptnl)
+{
+	int ret, family, prefix, flags, features;
+	int tunnel_type = variant->tunnel_type;
+	struct sockaddr_storage ssa, dsa;
+	struct vxlan_setup_config vxlan;
+	void *srcip, *dstip, *lladdr;
+
+	flags = (variant->is_tap ? IFF_TAP : IFF_TUN) | IFF_VNET_HDR |
+		IFF_MULTI_QUEUE | IFF_NO_PI;
+	features = TUN_F_CSUM | TUN_F_UDP_TUNNEL_GSO |
+		   TUN_F_UDP_TUNNEL_GSO_CSUM | TUN_F_USO4 | TUN_F_USO6;
+	self->fd = tun_open(self->ifname, flags, TUN_VNET_TNL_SIZE, features,
+			    param_hwaddr_outer_src);
+	ASSERT_GE(self->fd, 0);
+
+	family = (tunnel_type & UDP_TUNNEL_OUTER_IPV4) ? AF_INET : AF_INET6;
+	assign_ifaddr_vars(family, 1, &srcip, &dstip, &lladdr, &prefix);
+
+	ret = ip_addr_add(self->ifname, family, srcip, prefix);
+	ASSERT_EQ(ret, 0);
+	ret = ip_neigh_add(self->ifname, family, dstip, lladdr);
+	ASSERT_EQ(ret, 0);
+	ret = ip_route_check(self->ifname, family, srcip);
+	ASSERT_EQ(ret, 0);
+
+	assign_sockaddr_vars(family, 1, &ssa, &dsa);
+	memset(&vxlan, 0, sizeof(vxlan));
+	vxlan.vni = VN_ID;
+	vxlan.dst_port = htons(VN_PORT);
+	vxlan.csum = 1;
+	vxlan.remote_ifindex = if_nametoindex(self->ifname);
+	vxlan.local_ip = ssa;
+	vxlan.remote_ip = dsa;
+	memcpy(vxlan.hwaddr, param_hwaddr_inner_src, ETH_ALEN);
+
+	ret = dev_create(param_dev_vxlan_name, "vxlan", vxlan_fill_rtattr,
+			 vxlan_fill_info_data, (void *)&vxlan);
+	ASSERT_EQ(ret, 0);
+
+	family = (tunnel_type & UDP_TUNNEL_INNER_IPV4) ? AF_INET : AF_INET6;
+	assign_ifaddr_vars(family, 0, &srcip, &dstip, &lladdr, &prefix);
+
+	ret = ip_addr_add(param_dev_vxlan_name, family, srcip, prefix);
+	ASSERT_EQ(ret, 0);
+	ret = ip_neigh_add(param_dev_vxlan_name, family, dstip, lladdr);
+	ASSERT_EQ(ret, 0);
+	ret = ip_route_check(param_dev_vxlan_name, family, srcip);
+	ASSERT_EQ(ret, 0);
+
+	assign_sockaddr_vars(family, 0, &ssa, &dsa);
+	self->sock = udp_socket_open(&ssa, false, true, &dsa);
+	ASSERT_GE(self->sock, 0);
+}
+
+FIXTURE_TEARDOWN(tun_vnet_udptnl)
+{
+	int ret;
+
+	if (self->sock != -1)
+		close(self->sock);
+
+	ret = dev_delete(param_dev_vxlan_name);
+	EXPECT_EQ(ret, 0);
+
+	ret = tun_delete(self->ifname);
+	EXPECT_EQ(ret, 0);
+}
+
+TEST_F(tun_vnet_udptnl, basic)
+{
+	int ret;
+	char cmd[256] = { 0 };
+
+	sprintf(cmd, "ip addr show %s > /dev/null 2>&1", param_dev_vxlan_name);
+	ret = system(cmd);
+	ASSERT_EQ(ret, 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.49.0


