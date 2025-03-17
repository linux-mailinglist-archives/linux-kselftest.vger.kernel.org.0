Return-Path: <linux-kselftest+bounces-29214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D38A64B7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 12:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5342174860
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAE423F409;
	Mon, 17 Mar 2025 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ZPWmokfb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FD323F39A
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209140; cv=none; b=pFNE3wn6uw6CvBQtIT+FsHmF3i3A0TweUkYJtTk4PGeO/D7gbr6sTvriCFQkPNX8BN+4oZeJDh29/BtvSk7dg1h1g3xEAWZqhOxA4nVZMiQT0uR0+RbzZCvUrvo83pU92MVT4HyP+HrXBsUfUSCPGylWb3tIhC/43ETKzaYmo/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209140; c=relaxed/simple;
	bh=lN6+uLr4YpWJFlGsF93rg99nxoQ2xyOlduljX4096YQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Slu9oqVVcDJ1u8OdEietUuFVMO8zaYHf8aMzKlfbXicJizY8zRW6S5rVlcHTR8cM0fuSVzmgF1ICZSyiRMCB9SXAP6qeOTl/norlQ0qxDJhAx7VZHs4OjRig/5zOKgtXTwm0+S1/955JVS7WlmiwAxOb4k8t7PHZ+8Ye98WO2yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ZPWmokfb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-226185948ffso11416455ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 03:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742209137; x=1742813937; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuCKs6/yWaq7hp5qKF+oZHxstBPYJ3gUDKOwyUJw0c0=;
        b=ZPWmokfbai8bt5YrCgaXsJ8H14yv82DCRc3UjNn8y6zUCKuv8wRX7s1hmAs1TQ0wib
         SsdqlGhZc30Rp600Y36ghA7mWRtvP2ccLl0xK6g/oOUq1wE3BJconooqaUIY/fsmDrSM
         XaaqZnmTsk303U+Oa63JaaCkg6/HGXWghsXtVSPJUPArs5acgKJv9h9NPlts6Q/N5oQT
         PAPnVwaOjTb+WNfrSTKuMqpeMYeEfqr2QgZlwl1QECLA90xsvkAXpo1BiRzSpEp3ZiuI
         a/Td1UIn1EC4pEC3auW6UChp5oZFEI32O7bpqT7Y+jPxmyGfyPuqD7+PBsicpVtOCazA
         DDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209137; x=1742813937;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuCKs6/yWaq7hp5qKF+oZHxstBPYJ3gUDKOwyUJw0c0=;
        b=U1YMccC7cPwSfZi4VfW5a7+bnFnyPOYfOYAG71uPEj9mV1iAU4vlNvJUDT4PJ1j5X/
         dr5yaf7N5+kjx86fdZ43QcacBbCaeLk7CMWKdPc94VxKIC3XOUW9ktpqxTC/wUuXxNYc
         FSWGwJ8sZLXly5kUf2MH0482QcJUgGSH2QroC4yKj4Zol4ieJjUMzuRO/2TDrX6V4QNq
         EcyEqZ6LR5WE1iqULsCNiX062UHk2BXB1qv5kKEQvi6NFktyP/9UZ6ir494kGBOhtYHM
         +AkR/Vy1a+ZIAoXWDeS23+YIM5SZu0qrqFXhUkte6gKGsObFDcVw8CrNIAKhEP1Mm6hk
         03MA==
X-Forwarded-Encrypted: i=1; AJvYcCXFAfkPhzi1X0bmWLjW9ECmUMx7qSQQit1wb338kU8/LACEVMz/r9VONBPfMuC7R91OQCHjTZS+uGafRO7ImMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiWYDykuVFT6+MSuKz23nGtWBXjJ/Qvq7AN1GBaNzEu/uhDZfc
	W72Ndc3uyW8j2PnbBjb6bth7BPPrOPwKitSvSrf5agnQOXgr1buG5XpPZnBZtZY=
X-Gm-Gg: ASbGncuhERk4JHmrnPCnIqCxZx03p/rizAYnWIAO++9uZKnSp+7haMUkOA7V0HiYFmG
	+I0cbTj3lBUsV09HFzz64wK78KnbwphKbXAe8IpQDSLGfF9lLwPScx2rTkqQ41rdyZwn8oQhK7J
	m/bugeaHblMneVe1udLU1Oi13IwTaBPhUW92j6FFLtE97CWiLebUAv7ItgUPOZ6oNvrZNC6iINw
	tjxIPa3VSWadBgc1SB3So/pe8XPka6tNaieak8Tn2+issFncaBfVYBIVbTCrao7IErWVtnWcKii
	/dWpyHFlk6y/KybAFTTsh9b0styzrIjB93me+y2N7Bksbb3i
X-Google-Smtp-Source: AGHT+IGmh+wlYLU6Dm5L8FlVHO2yhosTkmig11zRjfv1fKJv5Tr5Do4rX2LYb8ms+AEuq8hbttkjaQ==
X-Received: by 2002:a05:6a20:e613:b0:1f5:5aac:f345 with SMTP id adf61e73a8af0-1f5c13287b1mr18198565637.36.1742209137372;
        Mon, 17 Mar 2025 03:58:57 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af56ea7bcc0sm6884416a12.56.2025.03.17.03.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:58:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 17 Mar 2025 19:57:58 +0900
Subject: [PATCH net-next v11 08/10] selftest: tun: Add tests for virtio-net
 hashing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rss-v11-8-4cacca92f31f@daynix.com>
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
In-Reply-To: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

The added tests confirm tun can perform RSS for all supported hash types
to select the receive queue and report hash values.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tun.c    | 455 ++++++++++++++++++++++++++++++++++-
 2 files changed, 447 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 73ee88d6b043..9772f691a9a0 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -123,6 +123,6 @@ $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
 $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
 $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
-$(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
+$(OUTPUT)/io_uring_zerocopy_tx $(OUTPUT)/tun: CFLAGS += -I../../../include/
 
 include bpf.mk
diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index ad168c15c02d..dfb84da50d91 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -2,21 +2,38 @@
 
 #define _GNU_SOURCE
 
+#include <endian.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <sched.h>
+#include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <linux/if.h>
+#include <net/if.h>
+#include <netinet/ip.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <linux/compiler.h>
+#include <linux/icmp.h>
+#include <linux/if_arp.h>
 #include <linux/if_tun.h>
+#include <linux/ipv6.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
-#include <sys/ioctl.h>
-#include <sys/socket.h>
+#include <linux/sockios.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <linux/virtio_net.h>
 
 #include "../kselftest_harness.h"
 
+#define TUN_HWADDR_SOURCE { 0x02, 0x00, 0x00, 0x00, 0x00, 0x00 }
+#define TUN_HWADDR_DEST { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 }
+#define TUN_IPADDR_SOURCE htonl((172 << 24) | (17 << 16) | 0)
+#define TUN_IPADDR_DEST htonl((172 << 24) | (17 << 16) | 1)
+
 static int tun_attach(int fd, char *dev)
 {
 	struct ifreq ifr;
@@ -39,7 +56,7 @@ static int tun_detach(int fd, char *dev)
 	return ioctl(fd, TUNSETQUEUE, (void *) &ifr);
 }
 
-static int tun_alloc(char *dev)
+static int tun_alloc(char *dev, short flags)
 {
 	struct ifreq ifr;
 	int fd, err;
@@ -52,7 +69,8 @@ static int tun_alloc(char *dev)
 
 	memset(&ifr, 0, sizeof(ifr));
 	strcpy(ifr.ifr_name, dev);
-	ifr.ifr_flags = IFF_TAP | IFF_NAPI | IFF_MULTI_QUEUE;
+	ifr.ifr_flags = flags | IFF_TAP | IFF_NAPI | IFF_NO_PI |
+			IFF_MULTI_QUEUE;
 
 	err = ioctl(fd, TUNSETIFF, (void *) &ifr);
 	if (err < 0) {
@@ -64,6 +82,20 @@ static int tun_alloc(char *dev)
 	return fd;
 }
 
+static bool tun_set_flags(int local_fd, const char *name, short flags)
+{
+	struct ifreq ifreq = { .ifr_flags = flags };
+
+	strcpy(ifreq.ifr_name, name);
+
+	if (ioctl(local_fd, SIOCSIFFLAGS, &ifreq)) {
+		perror("SIOCSIFFLAGS");
+		return false;
+	}
+
+	return true;
+}
+
 static int tun_delete(char *dev)
 {
 	struct {
@@ -102,6 +134,107 @@ static int tun_delete(char *dev)
 	return ret;
 }
 
+static uint32_t tun_sum(const void *buf, size_t len)
+{
+	const uint16_t *sbuf = buf;
+	uint32_t sum = 0;
+
+	while (len > 1) {
+		sum += *sbuf++;
+		len -= 2;
+	}
+
+	if (len)
+		sum += *(uint8_t *)sbuf;
+
+	return sum;
+}
+
+static uint16_t tun_build_ip_check(uint32_t sum)
+{
+	return ~((sum & 0xffff) + (sum >> 16));
+}
+
+static uint32_t tun_build_ip_pseudo_sum(const void *iphdr)
+{
+	uint16_t tot_len = ntohs(((struct iphdr *)iphdr)->tot_len);
+
+	return tun_sum((char *)iphdr + offsetof(struct iphdr, saddr), 8) +
+	       htons(((struct iphdr *)iphdr)->protocol) +
+	       htons(tot_len - sizeof(struct iphdr));
+}
+
+static uint32_t tun_build_ipv6_pseudo_sum(const void *ipv6hdr)
+{
+	return tun_sum((char *)ipv6hdr + offsetof(struct ipv6hdr, saddr), 32) +
+	       ((struct ipv6hdr *)ipv6hdr)->payload_len +
+	       htons(((struct ipv6hdr *)ipv6hdr)->nexthdr);
+}
+
+static void tun_build_iphdr(void *dest, uint16_t len, uint8_t protocol)
+{
+	struct iphdr iphdr = {
+		.ihl = sizeof(iphdr) / 4,
+		.version = 4,
+		.tot_len = htons(sizeof(iphdr) + len),
+		.ttl = 255,
+		.protocol = protocol,
+		.saddr = TUN_IPADDR_SOURCE,
+		.daddr = TUN_IPADDR_DEST
+	};
+
+	iphdr.check = tun_build_ip_check(tun_sum(&iphdr, sizeof(iphdr)));
+	memcpy(dest, &iphdr, sizeof(iphdr));
+}
+
+static void tun_build_ipv6hdr(void *dest, uint16_t len, uint8_t protocol)
+{
+	struct ipv6hdr ipv6hdr = {
+		.version = 6,
+		.payload_len = htons(len),
+		.nexthdr = protocol,
+		.saddr = {
+			.s6_addr32 = {
+				htonl(0xffff0000), 0, 0, TUN_IPADDR_SOURCE
+			}
+		},
+		.daddr = {
+			.s6_addr32 = {
+				htonl(0xffff0000), 0, 0, TUN_IPADDR_DEST
+			}
+		},
+	};
+
+	memcpy(dest, &ipv6hdr, sizeof(ipv6hdr));
+}
+
+static void tun_build_tcphdr(void *dest, uint32_t sum)
+{
+	struct tcphdr tcphdr = {
+		.source = htons(9),
+		.dest = htons(9),
+		.fin = 1,
+		.doff = sizeof(tcphdr) / 4,
+	};
+	uint32_t tcp_sum = tun_sum(&tcphdr, sizeof(tcphdr));
+
+	tcphdr.check = tun_build_ip_check(sum + tcp_sum);
+	memcpy(dest, &tcphdr, sizeof(tcphdr));
+}
+
+static void tun_build_udphdr(void *dest, uint32_t sum)
+{
+	struct udphdr udphdr = {
+		.source = htons(9),
+		.dest = htons(9),
+		.len = htons(sizeof(udphdr)),
+	};
+	uint32_t udp_sum = tun_sum(&udphdr, sizeof(udphdr));
+
+	udphdr.check = tun_build_ip_check(sum + udp_sum);
+	memcpy(dest, &udphdr, sizeof(udphdr));
+}
+
 FIXTURE(tun)
 {
 	char ifname[IFNAMSIZ];
@@ -112,10 +245,10 @@ FIXTURE_SETUP(tun)
 {
 	memset(self->ifname, 0, sizeof(self->ifname));
 
-	self->fd = tun_alloc(self->ifname);
+	self->fd = tun_alloc(self->ifname, 0);
 	ASSERT_GE(self->fd, 0);
 
-	self->fd2 = tun_alloc(self->ifname);
+	self->fd2 = tun_alloc(self->ifname, 0);
 	ASSERT_GE(self->fd2, 0);
 }
 
@@ -168,7 +301,7 @@ FIXTURE(tun_deleted)
 FIXTURE_SETUP(tun_deleted)
 {
 	self->ifname[0] = 0;
-	self->fd = tun_alloc(self->ifname);
+	self->fd = tun_alloc(self->ifname, 0);
 	ASSERT_LE(0, self->fd);
 
 	ASSERT_EQ(0, tun_delete(self->ifname))
@@ -197,4 +330,308 @@ TEST_F(tun_deleted, getvnethashcap)
 	EXPECT_EQ(0, i);
 }
 
-TEST_HARNESS_MAIN
+FIXTURE(tun_vnet_hash)
+{
+	int dest_fds[3];
+	unsigned int dest_ifindex;
+	int source_fd;
+	char buffer[sizeof(struct ipv6hdr) + sizeof(struct tcphdr)];
+	uint16_t len;
+};
+
+FIXTURE_VARIANT(tun_vnet_hash)
+{
+	uint16_t eth_p;
+	uint8_t ipproto;
+	uint8_t flags;
+	uint16_t hash_report;
+	uint32_t hash_value;
+};
+
+FIXTURE_VARIANT_ADD(tun_vnet_hash, unclassified)
+{
+	.eth_p = ETH_P_LOOPBACK
+};
+
+FIXTURE_VARIANT_ADD(tun_vnet_hash, ipv4)
+{
+	.eth_p = ETH_P_IP,
+	.ipproto = 253,
+	.hash_report = VIRTIO_NET_HASH_REPORT_IPv4,
+	.hash_value = 0x6e45d952
+};
+
+FIXTURE_VARIANT_ADD(tun_vnet_hash, tcpv4)
+{
+	.eth_p = ETH_P_IP,
+	.ipproto = IPPROTO_TCP,
+	.hash_report = VIRTIO_NET_HASH_REPORT_TCPv4,
+	.hash_value = 0xfb63539a
+};
+
+FIXTURE_VARIANT_ADD(tun_vnet_hash, udpv4)
+{
+	.eth_p = ETH_P_IP,
+	.ipproto = IPPROTO_UDP,
+	.hash_report = VIRTIO_NET_HASH_REPORT_UDPv4,
+	.hash_value = 0xfb63539a
+};
+
+FIXTURE_VARIANT_ADD(tun_vnet_hash, ipv6)
+{
+	.eth_p = ETH_P_IPV6,
+	.ipproto = 253,
+	.hash_report = VIRTIO_NET_HASH_REPORT_IPv6,
+	.hash_value = 0xd6eb560f
+};
+
+FIXTURE_VARIANT_ADD(tun_vnet_hash, tcpv6)
+{
+	.eth_p = ETH_P_IPV6,
+	.ipproto = IPPROTO_TCP,
+	.hash_report = VIRTIO_NET_HASH_REPORT_TCPv6,
+	.hash_value = 0xc2b9f251
+};
+
+FIXTURE_VARIANT_ADD(tun_vnet_hash, udpv6)
+{
+	.eth_p = ETH_P_IPV6,
+	.ipproto = IPPROTO_UDP,
+	.hash_report = VIRTIO_NET_HASH_REPORT_UDPv6,
+	.hash_value = 0xc2b9f251
+};
+
+FIXTURE_SETUP(tun_vnet_hash)
+{
+	static const struct {
+		struct tun_vnet_hash hdr;
+		struct tun_vnet_hash_rss rss;
+		uint16_t rss_indirection_table[2];
+		uint8_t rss_key[40];
+	} vnet_hash = {
+		.hdr = {
+			.flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
+			.types = VIRTIO_NET_RSS_HASH_TYPE_IPv4 |
+				VIRTIO_NET_RSS_HASH_TYPE_TCPv4 |
+				VIRTIO_NET_RSS_HASH_TYPE_UDPv4 |
+				VIRTIO_NET_RSS_HASH_TYPE_IPv6 |
+				VIRTIO_NET_RSS_HASH_TYPE_TCPv6 |
+				VIRTIO_NET_RSS_HASH_TYPE_UDPv6
+		},
+		.rss = { .indirection_table_mask = 1, .unclassified_queue = 5 },
+		.rss_indirection_table = { 3, 4 },
+		.rss_key = {
+			0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,
+			0x41, 0x67, 0x25, 0x3d, 0x43, 0xa3, 0x8f, 0xb0,
+			0xd0, 0xca, 0x2b, 0xcb, 0xae, 0x7b, 0x30, 0xb4,
+			0x77, 0xcb, 0x2d, 0xa3, 0x80, 0x30, 0xf2, 0x0c,
+			0x6a, 0x42, 0xb7, 0x3b, 0xbe, 0xac, 0x01, 0xfa
+		}
+	};
+
+	struct {
+		struct virtio_net_hdr_v1_hash vnet_hdr;
+		struct ethhdr ethhdr;
+		struct arphdr arphdr;
+		unsigned char sender_hwaddr[6];
+		uint32_t sender_ipaddr;
+		unsigned char target_hwaddr[6];
+		uint32_t target_ipaddr;
+	} __packed packet = {
+		.ethhdr = {
+			.h_source = TUN_HWADDR_SOURCE,
+			.h_dest = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
+			.h_proto = htons(ETH_P_ARP)
+		},
+		.arphdr = {
+			.ar_hrd = htons(ARPHRD_ETHER),
+			.ar_pro = htons(ETH_P_IP),
+			.ar_hln = ETH_ALEN,
+			.ar_pln = 4,
+			.ar_op = htons(ARPOP_REQUEST)
+		},
+		.sender_hwaddr = TUN_HWADDR_DEST,
+		.sender_ipaddr = TUN_IPADDR_DEST,
+		.target_ipaddr = TUN_IPADDR_DEST
+	};
+
+	struct tun_vnet_hash cap;
+	char dest_ifname[IFNAMSIZ] = "";
+	int i, local_fd;
+	uint16_t ip_payload_len;
+	uint32_t ip_sum;
+
+	self->dest_fds[0] = tun_alloc(dest_ifname, IFF_VNET_HDR);
+	ASSERT_LE(0, self->dest_fds[0]) {
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+	}
+
+	i = ioctl(self->dest_fds[0], TUNGETVNETHASHCAP, &cap);
+	if (i == -1 && errno == EINVAL) {
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+		SKIP(return, "TUNGETVNETHASHCAP not supported");
+	}
+
+	ASSERT_EQ(0, i)
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+
+	if ((cap.flags & vnet_hash.hdr.flags) != vnet_hash.hdr.flags) {
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+		SKIP(return, "Lacks some hash flag support");
+	}
+
+	if ((cap.types & vnet_hash.hdr.types) != vnet_hash.hdr.types) {
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+		SKIP(return, "Lacks some hash type support");
+	}
+
+	self->dest_ifindex = if_nametoindex(dest_ifname);
+	ASSERT_TRUE(self->dest_ifindex)
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+
+	i = sizeof(struct virtio_net_hdr_v1_hash);
+	ASSERT_EQ(0, ioctl(self->dest_fds[0], TUNSETVNETHDRSZ, &i))
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+
+	i = 1;
+	ASSERT_EQ(0, ioctl(self->dest_fds[0], TUNSETVNETLE, &i))
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+
+	local_fd = socket(AF_LOCAL, SOCK_STREAM, 0);
+	ASSERT_LE(0, local_fd)
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+
+	i = tun_set_flags(local_fd, dest_ifname, IFF_UP);
+	EXPECT_EQ(0, close(local_fd));
+	ASSERT_TRUE(i)
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+
+	ASSERT_EQ(sizeof(packet),
+		  write(self->dest_fds[0], &packet, sizeof(packet)))
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+
+	ASSERT_EQ(0, ioctl(self->dest_fds[0], TUNSETVNETHASH, &vnet_hash))
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+
+	self->source_fd = socket(AF_PACKET, SOCK_DGRAM, 0);
+	ASSERT_LE(0, self->source_fd)
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+
+	for (i = 1; i < ARRAY_SIZE(self->dest_fds); i++) {
+		self->dest_fds[i] = tun_alloc(dest_ifname, IFF_VNET_HDR);
+		ASSERT_LE(0, self->dest_fds[i]) {
+			while (i) {
+				i--;
+				EXPECT_EQ(0, close(self->dest_fds[i]));
+			}
+		}
+	}
+
+	if (variant->eth_p == ETH_P_IP || variant->eth_p == ETH_P_IPV6) {
+		switch (variant->ipproto) {
+		case IPPROTO_TCP:
+			ip_payload_len = sizeof(struct tcphdr);
+			break;
+
+		case IPPROTO_UDP:
+			ip_payload_len = sizeof(struct udphdr);
+			break;
+
+		default:
+			ip_payload_len = 0;
+		}
+
+		switch (variant->eth_p) {
+		case ETH_P_IP:
+			tun_build_iphdr(self->buffer, ip_payload_len, variant->ipproto);
+			self->len = sizeof(struct iphdr);
+			ip_sum = tun_build_ip_pseudo_sum(self->buffer);
+			break;
+
+		case ETH_P_IPV6:
+			tun_build_ipv6hdr(self->buffer, ip_payload_len, variant->ipproto);
+			self->len = sizeof(struct ipv6hdr);
+			ip_sum = tun_build_ipv6_pseudo_sum(self->buffer);
+			break;
+		}
+
+		switch (variant->ipproto) {
+		case IPPROTO_TCP:
+			tun_build_tcphdr(self->buffer + self->len, ip_sum);
+			break;
+
+		case IPPROTO_UDP:
+			tun_build_udphdr(self->buffer + self->len, ip_sum);
+			break;
+		}
+
+		self->len += ip_payload_len;
+	}
+}
+
+FIXTURE_TEARDOWN(tun_vnet_hash)
+{
+	EXPECT_EQ(0, close(self->source_fd));
+
+	for (size_t i = 0; i < ARRAY_SIZE(self->dest_fds); i++)
+		EXPECT_EQ(0, close(self->dest_fds[i]));
+}
+
+TEST_F(tun_vnet_hash, rx)
+{
+	size_t len = sizeof(struct virtio_net_hdr_v1_hash) + ETH_HLEN + self->len;
+	struct {
+		struct virtio_net_hdr_v1_hash vnet_hdr;
+		struct ethhdr ethhdr;
+		char payload[sizeof(self->buffer)];
+	} buffer;
+	struct virtio_net_hdr_v1_hash hdr = {
+		.hdr = { .flags = variant->flags },
+		.hash_value = htole32(variant->hash_value),
+		.hash_report = htole16(variant->hash_report)
+	};
+	int txq = variant->hash_report ? variant->hash_value & 1 : 2;
+	struct sockaddr_ll ll = {
+		.sll_family = AF_PACKET,
+		.sll_addr = TUN_HWADDR_DEST,
+		.sll_halen = ETH_ALEN,
+		.sll_ifindex = self->dest_ifindex,
+		.sll_protocol = htons(variant->eth_p),
+	};
+
+	EXPECT_EQ(self->len,
+		  sendto(self->source_fd, self->buffer, self->len, 0,
+			 (struct sockaddr *)&ll, sizeof(ll)));
+	EXPECT_EQ(len, read(self->dest_fds[txq], &buffer, len));
+	ASSERT_FALSE(memcmp(&buffer, &hdr, sizeof(hdr)));
+	ASSERT_FALSE(memcmp(buffer.payload, self->buffer, self->len));
+}
+
+int main(int argc, char **argv)
+{
+	FILE *file;
+
+	if (unshare(CLONE_NEWNET)) {
+		perror("unshare");
+		return KSFT_FAIL;
+	}
+
+	/* Disable IPv6 to eliminate IPv6 Neighbor Discovery messages. */
+	file = fopen("/proc/sys/net/ipv6/conf/default/disable_ipv6", "w");
+	if (file) {
+		if (fputc('1', file) != '1') {
+			perror("fputc");
+			return KSFT_FAIL;
+		}
+
+		if (fclose(file)) {
+			perror("fclose");
+			return KSFT_FAIL;
+		}
+	} else if (errno != ENOENT) {
+		perror("fopen");
+		return KSFT_FAIL;
+	}
+
+	return test_harness_run(argc, argv);
+}

-- 
2.48.1


