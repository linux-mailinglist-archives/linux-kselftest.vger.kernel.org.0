Return-Path: <linux-kselftest+bounces-49323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B15D39DFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 06:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A93230519F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 05:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18390330D35;
	Mon, 19 Jan 2026 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRIMyXMj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A258F258EFF
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768801262; cv=none; b=G5myRmjoSue1OZ+5+sdSZF6nhyJ/xF/Wnz30mCyOTrHBqOGEnWF7/W722b9EG2c5DSeV2P9v5xQ/wA2pmGYUjRngIglMJxQdUu7tcl1r56P20EfshMieCKBixcNlVqU2s5TsydpKuZ32oPswfwaEX6xmw5AI9l7Kd9djDpq3QaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768801262; c=relaxed/simple;
	bh=j88S8UVMF4UN7ODSbM06V5kHCjacP62bjwVGVI7CEOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBJuonwktzZ1zMKzZKAg2biQdeKj1CpUxvZXI/Z3FL0niXXXvm/czkIt2KrUTOay5G8EG2OQmb16DtHfzslIeho1s1tE8ojLQ6spw28rqly4XeayMJhI9vR5/b9L8xC+lBF/CY3pLGl1VTGEQE/mqatEtfb/oledgr4OFm/KA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRIMyXMj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768801258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvZgwvJeGyGBpLubrY0OttguapRc1gPc0WNHWvn2/cU=;
	b=iRIMyXMj1qTj9xNDw5izIsU0YATRLADfB1NiHituAEhj42HanoLb5fTv8bP7RS3GWWmJqR
	MBCMbQdyGeUcpAAA4kZelbENLDL2Q0gAF0pF+7omaQg68eKeQBnB1/udp4VFA69UKTBE/m
	4rNGrgsmfYMDQxP6eANU+U3GdPR9zS4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-RubMhR79MlerTRDX_QIAEg-1; Mon,
 19 Jan 2026 00:40:53 -0500
X-MC-Unique: RubMhR79MlerTRDX_QIAEg-1
X-Mimecast-MFC-AGG-ID: RubMhR79MlerTRDX_QIAEg_1768801252
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F36131956080;
	Mon, 19 Jan 2026 05:40:51 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD5A718004D8;
	Mon, 19 Jan 2026 05:40:45 +0000 (UTC)
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
Subject: [PATCH net-next v5 4/7] selftest: tun: Add helpers for GSO over UDP tunnel
Date: Mon, 19 Jan 2026 13:40:01 +0800
Message-ID: <b03cb02ef1ae6b01ee67ca58fc754059490e172f.1768800198.git.xudu@redhat.com>
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

In preparation for testing GSO over UDP tunnels, enhance the test
infrastructure to support a more complex data path involving a TUN
device and a GENEVE udp tunnel.

This patch introduces a dedicated setup/teardown topology that creates
both a GENEVE tunnel interface and a TUN interface. The TUN device acts
as the VTEP (Virtual Tunnel Endpoint), allowing it to send and receive
virtio-net packets. This setup effectively tests the kernel's data path
for encapsulated traffic.

Note that after adding a new address to the UDP tunnel, we need to wait
a bit until the associated route is available.

Additionally, a new data structure is defined to manage test parameters.
This structure is designed to be extensible, allowing different test
data and configurations to be easily added in subsequent patches.

Signed-off-by: Xu Du <xudu@redhat.com>
---
v4 -> v5:
 - Use Geneve instead of VXLAN due to missing YNL support.

v1 -> v2:
 - Explicitly wait for successful target route lookup before transmitting
   the packets.
 - Add UDP connect() to verify remote reachability.
 - Abstract address assignment logic into helpers.

 tools/testing/selftests/net/tun.c | 425 ++++++++++++++++++++++++++++++
 1 file changed, 425 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index d9030bdd2e06..ec089355312b 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -15,6 +15,80 @@
 #include "kselftest_harness.h"
 #include "tuntap_helpers.h"
 
+static const char param_dev_geneve_name[] = "geneve1";
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
+#define UDP_TUNNEL_GENEVE_4IN4 0x01
+#define UDP_TUNNEL_GENEVE_6IN4 0x02
+#define UDP_TUNNEL_GENEVE_4IN6 0x04
+#define UDP_TUNNEL_GENEVE_6IN6 0x08
+
+#define UDP_TUNNEL_OUTER_IPV4 (UDP_TUNNEL_GENEVE_4IN4 | UDP_TUNNEL_GENEVE_6IN4)
+#define UDP_TUNNEL_INNER_IPV4 (UDP_TUNNEL_GENEVE_4IN4 | UDP_TUNNEL_GENEVE_4IN6)
+
+#define TUN_VNET_TNL_SIZE sizeof(struct virtio_net_hdr_v1_hash_tunnel)
+
+struct geneve_setup_config {
+	int family;
+	union {
+		struct in_addr r4;
+		struct in6_addr r6;
+	} remote;
+	__be32 vnid;
+	__be16 vnport;
+	unsigned char hwaddr[6];
+	uint8_t csum;
+};
+
 static int tun_attach(int fd, char *dev)
 {
 	struct ifreq ifr;
@@ -67,6 +141,202 @@ static int tun_delete(char *dev)
 	return ip_link_del(dev);
 }
 
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
+static size_t sockaddr_len(int family)
+{
+	return (family == AF_INET) ? sizeof(struct sockaddr_in) :
+				     sizeof(struct sockaddr_in6);
+}
+
+static int geneve_fill_newlink(struct rt_link_newlink_req *req, void *data)
+{
+	struct geneve_setup_config *cfg = data;
+
+#define SET_GENEVE_REMOTE rt_link_newlink_req_set_linkinfo_data_geneve_remote
+#define SET_GENEVE_REMOTE6 rt_link_newlink_req_set_linkinfo_data_geneve_remote6
+
+	rt_link_newlink_req_set_address(req, cfg->hwaddr, ETH_ALEN);
+	rt_link_newlink_req_set_linkinfo_data_geneve_id(req, cfg->vnid);
+	rt_link_newlink_req_set_linkinfo_data_geneve_port(req, cfg->vnport);
+	rt_link_newlink_req_set_linkinfo_data_geneve_udp_csum(req, cfg->csum);
+
+	if (cfg->family == AF_INET)
+		SET_GENEVE_REMOTE(req, cfg->remote.r4.s_addr);
+	else
+		SET_GENEVE_REMOTE6(req, &cfg->remote.r6,
+				   sizeof(cfg->remote.r6));
+
+	return 0;
+}
+
+static int geneve_create(const char *dev, int family, void *remote,
+			 void *hwaddr)
+{
+	struct geneve_setup_config geneve;
+
+	memset(&geneve, 0, sizeof(geneve));
+	geneve.vnid = VN_ID;
+	geneve.vnport = htons(VN_PORT);
+	geneve.csum = 1;
+	geneve.family = family;
+	if (family == AF_INET)
+		memcpy(&geneve.remote.r4, remote, sizeof(struct in_addr));
+	else
+		memcpy(&geneve.remote.r6, remote, sizeof(struct in6_addr));
+	memcpy(geneve.hwaddr, hwaddr, ETH_ALEN);
+
+	return ip_link_add(dev, "geneve", geneve_fill_newlink, (void *)&geneve);
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
+static void parse_route_rsp(struct rt_route_getroute_rsp *rsp, void *rtm_type)
+{
+	*(uint8_t *)rtm_type = rsp->_hdr.rtm_type;
+}
+
+static int ip_route_check(const char *intf, int family, void *addr)
+{
+	uint8_t rtm_type, table = RT_TABLE_LOCAL;
+	int retries = MAX_RETRIES;
+
+	while (retries-- > 0) {
+		if (ip_route_get(intf, family, table, addr, parse_route_rsp,
+				 &rtm_type) == 0 &&
+		    rtm_type == RTN_LOCAL)
+			break;
+
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
@@ -129,4 +399,159 @@ TEST_F(tun, reattach_close_delete)
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
+TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_GENEVE_4IN4, 4in4);
+TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_GENEVE_6IN4, 6in4);
+TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_GENEVE_4IN6, 4in6);
+TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_GENEVE_6IN6, 6in6);
+
+static void assign_ifaddr_vars(int family, int is_outer, void **srcip,
+			       void **dstip, void **srcmac, void **dstmac)
+{
+	if (is_outer) {
+		if (family == AF_INET) {
+			*srcip = (void *)&param_ipaddr4_outer_src;
+			*dstip = (void *)&param_ipaddr4_outer_dst;
+		} else {
+			*srcip = (void *)&param_ipaddr6_outer_src;
+			*dstip = (void *)&param_ipaddr6_outer_dst;
+		}
+		*srcmac = param_hwaddr_outer_src;
+		*dstmac = param_hwaddr_outer_dst;
+	} else {
+		if (family == AF_INET) {
+			*srcip = (void *)&param_ipaddr4_inner_src;
+			*dstip = (void *)&param_ipaddr4_inner_dst;
+		} else {
+			*srcip = (void *)&param_ipaddr6_inner_src;
+			*dstip = (void *)&param_ipaddr6_inner_dst;
+		}
+		*srcmac = param_hwaddr_inner_src;
+		*dstmac = param_hwaddr_inner_dst;
+	}
+}
+
+static void assign_sockaddr_vars(int family, int is_outer,
+				 struct sockaddr_storage *src,
+				 struct sockaddr_storage *dst)
+{
+	src->ss_family = family;
+	dst->ss_family = family;
+
+	if (family == AF_INET) {
+		struct sockaddr_in *s4 = (struct sockaddr_in *)src;
+		struct sockaddr_in *d4 = (struct sockaddr_in *)dst;
+
+		s4->sin_addr = is_outer ? param_ipaddr4_outer_src :
+					  param_ipaddr4_inner_src;
+		d4->sin_addr = is_outer ? param_ipaddr4_outer_dst :
+					  param_ipaddr4_inner_dst;
+		if (!is_outer) {
+			s4->sin_port = htons(UDP_SRC_PORT);
+			d4->sin_port = htons(UDP_DST_PORT);
+		}
+	} else {
+		struct sockaddr_in6 *s6 = (struct sockaddr_in6 *)src;
+		struct sockaddr_in6 *d6 = (struct sockaddr_in6 *)dst;
+
+		s6->sin6_addr = is_outer ? param_ipaddr6_outer_src :
+					   param_ipaddr6_inner_src;
+		d6->sin6_addr = is_outer ? param_ipaddr6_outer_dst :
+					   param_ipaddr6_inner_dst;
+		if (!is_outer) {
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
+	void *sip, *dip, *smac, *dmac;
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
+	prefix = (family == AF_INET) ? IPPREFIX_LEN : IP6PREFIX_LEN;
+	assign_ifaddr_vars(family, 1, &sip, &dip, &smac, &dmac);
+
+	ret = ip_addr_add(self->ifname, family, sip, prefix);
+	ASSERT_EQ(ret, 0);
+	ret = ip_neigh_add(self->ifname, family, dip, dmac);
+	ASSERT_EQ(ret, 0);
+	ret = ip_route_check(self->ifname, family, sip);
+	ASSERT_EQ(ret, 0);
+
+	ret = geneve_create(param_dev_geneve_name, family, dip,
+			    param_hwaddr_inner_src);
+	ASSERT_EQ(ret, 0);
+
+	family = (tunnel_type & UDP_TUNNEL_INNER_IPV4) ? AF_INET : AF_INET6;
+	prefix = (family == AF_INET) ? IPPREFIX_LEN : IP6PREFIX_LEN;
+	assign_ifaddr_vars(family, 0, &sip, &dip, &smac, &dmac);
+
+	ret = ip_addr_add(param_dev_geneve_name, family, sip, prefix);
+	ASSERT_EQ(ret, 0);
+	ret = ip_neigh_add(param_dev_geneve_name, family, dip, dmac);
+	ASSERT_EQ(ret, 0);
+	ret = ip_route_check(param_dev_geneve_name, family, sip);
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
+	ret = ip_link_del(param_dev_geneve_name);
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
+	sprintf(cmd, "ip addr show %s > /dev/null 2>&1", param_dev_geneve_name);
+	ret = system(cmd);
+	ASSERT_EQ(ret, 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.49.0


