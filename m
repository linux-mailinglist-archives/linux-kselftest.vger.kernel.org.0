Return-Path: <linux-kselftest+bounces-48263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 438B1CF6534
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 02:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63B3A30CD3A5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 01:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E127305976;
	Tue,  6 Jan 2026 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7MnCNk9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268C316184
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 01:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663354; cv=none; b=h0rpm1qcgohu0kxFmoqQXec1U+zTZBdgmyz1mvIMJmJBVIUkj+5+hwJg70PLzxhpRr7H0CMmuMuEWAkjc906p3yJCaa4mhWXTImoPWByK73PdnWDOtw9lni+tYy7WleL6bKzT20rvj12/NsHwuG2Fjf8p+r58BVM/cUitTHg7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663354; c=relaxed/simple;
	bh=Zq1Setti4rHsB3+ThqaDAQ01swL11cF1fNxgGM0PHeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzglDM4LnnMl4InJzsnSYGQCNyylKNobBtYHW3NOMaSATQ77neLg23cAQXDWgwSuf9lBmQPmVGduNObBS0ncnmeOSiw6tkxhT4JPVNx1XkOdegpp02cmRkGEhJ6BJPik6bbTabcrdFRIdrfS2OGuPoBPg5+fQIpMdipnS2lNsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7MnCNk9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767663351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRz+JUHDJPTQK9o/T4QW/5UA/qmHHVcBln6aFBJ9uxQ=;
	b=E7MnCNk9yxQBGrz1/EmL6fUMRUav5XlyljCWjOH3XL0shwxz1t/q36pGrx54zD+gmJhvqC
	EuHCb1ra36QNdr3V+PsUxLOeQ8kOEvfGynFj0jg1Z0vO4Cd3xZQM2wRl0NzB1K8sVHJ9SG
	fL67sGkpMLh7eFvSWr5CrvnZ5qqqFH0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-Frkikj4sMBun2xyuv6aUTg-1; Mon,
 05 Jan 2026 20:35:49 -0500
X-MC-Unique: Frkikj4sMBun2xyuv6aUTg-1
X-Mimecast-MFC-AGG-ID: Frkikj4sMBun2xyuv6aUTg_1767663348
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB8971800365;
	Tue,  6 Jan 2026 01:35:47 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D817018004D4;
	Tue,  6 Jan 2026 01:35:43 +0000 (UTC)
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
Subject: [PATCH net-next v4 4/8] selftest: tap: Refactor tap test to use tuntap_helpers
Date: Tue,  6 Jan 2026 09:35:17 +0800
Message-ID: <02a1295475c7218510e9a808ad8f97bb6005cdfc.1767597114.git.xudu@redhat.com>
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

Refactor existing TAP test cases to use the previously introduced
tuntap_helpers from tuntap_helpers.h for device setup, packet
construction, and cleanup.

This reduces code duplication, improves test maintainability, and
ensures consistent behavior across test scenarios.

Signed-off-by: Xu Du <xudu@redhat.com>
---
v1 -> v2:
  - Add mactap IFLA_ADDRESS attribute.
  - Fix incorrect argument order in build_eth and build_ipv4_header.

 tools/testing/selftests/net/tap.c | 281 +++++-------------------------
 1 file changed, 41 insertions(+), 240 deletions(-)

diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
index a0c9418132c8..6793e47d67a7 100644
--- a/tools/testing/selftests/net/tap.c
+++ b/tools/testing/selftests/net/tap.c
@@ -10,14 +10,13 @@
 #include <unistd.h>
 #include <net/if.h>
 #include <linux/if_tun.h>
-#include <linux/netlink.h>
-#include <linux/rtnetlink.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <linux/virtio_net.h>
 #include <netinet/ip.h>
 #include <netinet/udp.h>
 #include "kselftest_harness.h"
+#include "tuntap_helpers.h"
 
 static const char param_dev_tap_name[] = "xmacvtap0";
 static const char param_dev_dummy_name[] = "xdummy0";
@@ -26,161 +25,36 @@ static unsigned char param_hwaddr_dest[] = {
 	0x00, 0xfe, 0x98, 0x94, 0xd2, 0x43
 };
 
-#define MAX_RTNL_PAYLOAD (2048)
-#define PKT_DATA 0xCB
-#define TEST_PACKET_SZ (sizeof(struct virtio_net_hdr) + ETH_HLEN + ETH_MAX_MTU)
-
-static struct rtattr *rtattr_add(struct nlmsghdr *nh, unsigned short type,
-				 unsigned short len)
-{
-	struct rtattr *rta =
-		(struct rtattr *)((uint8_t *)nh + RTA_ALIGN(nh->nlmsg_len));
-	rta->rta_type = type;
-	rta->rta_len = RTA_LENGTH(len);
-	nh->nlmsg_len = RTA_ALIGN(nh->nlmsg_len) + RTA_ALIGN(rta->rta_len);
-	return rta;
-}
-
-static struct rtattr *rtattr_begin(struct nlmsghdr *nh, unsigned short type)
-{
-	return rtattr_add(nh, type, 0);
-}
-
-static void rtattr_end(struct nlmsghdr *nh, struct rtattr *attr)
-{
-	uint8_t *end = (uint8_t *)nh + nh->nlmsg_len;
-
-	attr->rta_len = end - (uint8_t *)attr;
-}
-
-static struct rtattr *rtattr_add_str(struct nlmsghdr *nh, unsigned short type,
-				     const char *s)
-{
-	unsigned int strsz = strlen(s) + 1;
-	struct rtattr *rta;
-
-	rta = rtattr_add(nh, type, strsz);
-
-	memcpy(RTA_DATA(rta), s, strsz);
-	return rta;
-}
-
-static struct rtattr *rtattr_add_any(struct nlmsghdr *nh, unsigned short type,
-				     const void *arr, size_t len)
-{
-	struct rtattr *rta = rtattr_add(nh, type, len);
-
-	memcpy(RTA_DATA(rta), arr, len);
-	return rta;
-}
-
-static int dev_create(const char *dev, const char *link_type,
-		      int (*fill_rtattr)(struct nlmsghdr *nh),
-		      int (*fill_info_data)(struct nlmsghdr *nh))
-{
-	struct {
-		struct nlmsghdr nh;
-		struct ifinfomsg info;
-		unsigned char data[MAX_RTNL_PAYLOAD];
-	} req;
-	struct rtattr *link_info, *info_data;
-	int ret, rtnl;
-
-	rtnl = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
-	if (rtnl < 0) {
-		fprintf(stderr, "%s: socket %s\n", __func__, strerror(errno));
-		return 1;
-	}
-
-	memset(&req, 0, sizeof(req));
-	req.nh.nlmsg_len = NLMSG_LENGTH(sizeof(req.info));
-	req.nh.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE;
-	req.nh.nlmsg_type = RTM_NEWLINK;
-
-	req.info.ifi_family = AF_UNSPEC;
-	req.info.ifi_type = 1;
-	req.info.ifi_index = 0;
-	req.info.ifi_flags = IFF_BROADCAST | IFF_UP;
-	req.info.ifi_change = 0xffffffff;
-
-	rtattr_add_str(&req.nh, IFLA_IFNAME, dev);
-
-	if (fill_rtattr) {
-		ret = fill_rtattr(&req.nh);
-		if (ret)
-			return ret;
-	}
-
-	link_info = rtattr_begin(&req.nh, IFLA_LINKINFO);
-
-	rtattr_add_str(&req.nh, IFLA_INFO_KIND, link_type);
-
-	if (fill_info_data) {
-		info_data = rtattr_begin(&req.nh, IFLA_INFO_DATA);
-		ret = fill_info_data(&req.nh);
-		if (ret)
-			return ret;
-		rtattr_end(&req.nh, info_data);
-	}
-
-	rtattr_end(&req.nh, link_info);
-
-	ret = send(rtnl, &req, req.nh.nlmsg_len, 0);
-	if (ret < 0)
-		fprintf(stderr, "%s: send %s\n", __func__, strerror(errno));
-	ret = (unsigned int)ret != req.nh.nlmsg_len;
-
-	close(rtnl);
-	return ret;
-}
-
-static int dev_delete(const char *dev)
-{
-	struct {
-		struct nlmsghdr nh;
-		struct ifinfomsg info;
-		unsigned char data[MAX_RTNL_PAYLOAD];
-	} req;
-	int ret, rtnl;
-
-	rtnl = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
-	if (rtnl < 0) {
-		fprintf(stderr, "%s: socket %s\n", __func__, strerror(errno));
-		return 1;
-	}
-
-	memset(&req, 0, sizeof(req));
-	req.nh.nlmsg_len = NLMSG_LENGTH(sizeof(req.info));
-	req.nh.nlmsg_flags = NLM_F_REQUEST;
-	req.nh.nlmsg_type = RTM_DELLINK;
-
-	req.info.ifi_family = AF_UNSPEC;
-
-	rtattr_add_str(&req.nh, IFLA_IFNAME, dev);
+static struct in_addr param_ipaddr_src = {
+	__constant_htonl(0xac110002),
+};
 
-	ret = send(rtnl, &req, req.nh.nlmsg_len, 0);
-	if (ret < 0)
-		fprintf(stderr, "%s: send %s\n", __func__, strerror(errno));
+static struct in_addr param_ipaddr_dst = {
+	__constant_htonl(0xac110001),
+};
 
-	ret = (unsigned int)ret != req.nh.nlmsg_len;
+#define UDP_SRC_PORT 22
+#define UDP_DST_PORT 58822
+#define TEST_PACKET_SZ (sizeof(struct virtio_net_hdr) + ETH_HLEN + ETH_MAX_MTU)
 
-	close(rtnl);
-	return ret;
-}
+struct mactap_setup_config {
+	char name[IFNAMSIZ];
+	unsigned char hwaddr[ETH_ALEN];
+};
 
-static int macvtap_fill_rtattr(struct nlmsghdr *nh)
+static int macvtap_fill_rtattr(struct nlmsghdr *nh, void *data)
 {
+	struct mactap_setup_config *mactap = data;
 	int ifindex;
 
-	ifindex = if_nametoindex(param_dev_dummy_name);
+	ifindex = if_nametoindex(mactap->name);
 	if (ifindex == 0) {
 		fprintf(stderr, "%s: ifindex  %s\n", __func__, strerror(errno));
 		return -errno;
 	}
 
 	rtattr_add_any(nh, IFLA_LINK, &ifindex, sizeof(ifindex));
-	rtattr_add_any(nh, IFLA_ADDRESS, param_hwaddr_src, ETH_ALEN);
-
+	rtattr_add_any(nh, IFLA_ADDRESS, mactap->hwaddr, ETH_ALEN);
 	return 0;
 }
 
@@ -212,91 +86,6 @@ static int opentap(const char *devname)
 	return fd;
 }
 
-size_t build_eth(uint8_t *buf, uint16_t proto)
-{
-	struct ethhdr *eth = (struct ethhdr *)buf;
-
-	eth->h_proto = htons(proto);
-	memcpy(eth->h_source, param_hwaddr_src, ETH_ALEN);
-	memcpy(eth->h_dest, param_hwaddr_dest, ETH_ALEN);
-
-	return ETH_HLEN;
-}
-
-static uint32_t add_csum(const uint8_t *buf, int len)
-{
-	uint32_t sum = 0;
-	uint16_t *sbuf = (uint16_t *)buf;
-
-	while (len > 1) {
-		sum += *sbuf++;
-		len -= 2;
-	}
-
-	if (len)
-		sum += *(uint8_t *)sbuf;
-
-	return sum;
-}
-
-static uint16_t finish_ip_csum(uint32_t sum)
-{
-	uint16_t lo = sum & 0xffff;
-	uint16_t hi = sum >> 16;
-
-	return ~(lo + hi);
-
-}
-
-static uint16_t build_ip_csum(const uint8_t *buf, int len,
-			      uint32_t sum)
-{
-	sum += add_csum(buf, len);
-	return finish_ip_csum(sum);
-}
-
-static int build_ipv4_header(uint8_t *buf, int payload_len)
-{
-	struct iphdr *iph = (struct iphdr *)buf;
-
-	iph->ihl = 5;
-	iph->version = 4;
-	iph->ttl = 8;
-	iph->tot_len =
-		htons(sizeof(*iph) + sizeof(struct udphdr) + payload_len);
-	iph->id = htons(1337);
-	iph->protocol = IPPROTO_UDP;
-	iph->saddr = htonl((172 << 24) | (17 << 16) | 2);
-	iph->daddr = htonl((172 << 24) | (17 << 16) | 1);
-	iph->check = build_ip_csum(buf, iph->ihl << 2, 0);
-
-	return iph->ihl << 2;
-}
-
-static int build_udp_packet(uint8_t *buf, int payload_len, bool csum_off)
-{
-	const int ip4alen = sizeof(uint32_t);
-	struct udphdr *udph = (struct udphdr *)buf;
-	int len = sizeof(*udph) + payload_len;
-	uint32_t sum = 0;
-
-	udph->source = htons(22);
-	udph->dest = htons(58822);
-	udph->len = htons(len);
-
-	memset(buf + sizeof(struct udphdr), PKT_DATA, payload_len);
-
-	sum = add_csum(buf - 2 * ip4alen, 2 * ip4alen);
-	sum += htons(IPPROTO_UDP) + udph->len;
-
-	if (!csum_off)
-		sum += add_csum(buf, len);
-
-	udph->check = finish_ip_csum(sum);
-
-	return sizeof(*udph) + payload_len;
-}
-
 size_t build_test_packet_valid_udp_gso(uint8_t *buf, size_t payload_len)
 {
 	uint8_t *cur = buf;
@@ -310,9 +99,12 @@ size_t build_test_packet_valid_udp_gso(uint8_t *buf, size_t payload_len)
 	vh->gso_size = ETH_DATA_LEN - sizeof(struct iphdr);
 	cur += sizeof(*vh);
 
-	cur += build_eth(cur, ETH_P_IP);
-	cur += build_ipv4_header(cur, payload_len);
-	cur += build_udp_packet(cur, payload_len, true);
+	cur += build_eth(cur, ETH_P_IP, param_hwaddr_src, param_hwaddr_dest);
+	cur += build_ipv4_header(cur, IPPROTO_UDP,
+				 payload_len + sizeof(struct udphdr),
+				 &param_ipaddr_src, &param_ipaddr_dst);
+	cur += build_udp_packet(cur, UDP_SRC_PORT, UDP_DST_PORT, payload_len,
+				AF_INET, true);
 
 	return cur - buf;
 }
@@ -326,9 +118,12 @@ size_t build_test_packet_valid_udp_csum(uint8_t *buf, size_t payload_len)
 	vh->gso_type = VIRTIO_NET_HDR_GSO_NONE;
 	cur += sizeof(*vh);
 
-	cur += build_eth(cur, ETH_P_IP);
-	cur += build_ipv4_header(cur, payload_len);
-	cur += build_udp_packet(cur, payload_len, false);
+	cur += build_eth(cur, ETH_P_IP, param_hwaddr_src, param_hwaddr_dest);
+	cur += build_ipv4_header(cur, IPPROTO_UDP,
+				 payload_len + sizeof(struct udphdr),
+				 &param_ipaddr_src, &param_ipaddr_dst);
+	cur += build_udp_packet(cur, UDP_SRC_PORT, UDP_DST_PORT, payload_len,
+				AF_INET, false);
 
 	return cur - buf;
 }
@@ -345,10 +140,13 @@ size_t build_test_packet_crash_tap_invalid_eth_proto(uint8_t *buf,
 	vh->gso_size = ETH_DATA_LEN - sizeof(struct iphdr);
 	cur += sizeof(*vh);
 
-	cur += build_eth(cur, 0);
+	cur += build_eth(cur, ETH_P_IP, param_hwaddr_src, param_hwaddr_dest);
 	cur += sizeof(struct iphdr) + sizeof(struct udphdr);
-	cur += build_ipv4_header(cur, payload_len);
-	cur += build_udp_packet(cur, payload_len, true);
+	cur += build_ipv4_header(cur, IPPROTO_UDP,
+				 payload_len + sizeof(struct udphdr),
+				 &param_ipaddr_src, &param_ipaddr_dst);
+	cur += build_udp_packet(cur, UDP_SRC_PORT, UDP_DST_PORT, payload_len,
+				AF_INET, true);
 	cur += payload_len;
 
 	return cur - buf;
@@ -362,12 +160,15 @@ FIXTURE(tap)
 FIXTURE_SETUP(tap)
 {
 	int ret;
+	struct mactap_setup_config mactap_config;
 
-	ret = dev_create(param_dev_dummy_name, "dummy", NULL, NULL);
+	ret = dev_create(param_dev_dummy_name, "dummy", NULL, NULL, NULL);
 	EXPECT_EQ(ret, 0);
 
+	strcpy(mactap_config.name, param_dev_dummy_name);
+	memcpy(mactap_config.hwaddr, param_hwaddr_src, ETH_ALEN);
 	ret = dev_create(param_dev_tap_name, "macvtap", macvtap_fill_rtattr,
-			 NULL);
+			 NULL, &mactap_config);
 	EXPECT_EQ(ret, 0);
 
 	self->fd = opentap(param_dev_tap_name);
-- 
2.49.0


