Return-Path: <linux-kselftest+bounces-17999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D1E979428
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 03:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186141F23775
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 01:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6821B85EC;
	Sun, 15 Sep 2024 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="0Z5Ups1W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71548BFF
	for <linux-kselftest@vger.kernel.org>; Sun, 15 Sep 2024 01:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363243; cv=none; b=ppqFxFDoSVA93iuBTXY6R9V1k7XEiHgrjF5X+HJEosw5qeZyr8wEmDwBQVPMajZOqW6GX0INNF2mdZVsUgoa/Sjw81twnEm6o/VzketEygEdeyFxaC8XivTXKufrRYAOElkWPkEckLEdRDDEZ8CmwdwTgUw8a4kjI0c08lObdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363243; c=relaxed/simple;
	bh=6zlbnOsMI8gPu4ehWmCldIrR8sC6Hx7q4xuJWXGsm0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=ZdN5B4DjYyxFPjBwLuZPKgLIi804unO9Q3ojiHJBnhSbb+dr8aX/BqnCMaVv0ADBWpTa9srdSLG7/srJxdcz7SX3hUSl/6Og+1owAxCj0uvyDt8LYeX29DrltRA6Nh6e2lXBxaXfkx6DM+a9iIYq3jQMBEWf7UvOdnFpwLq2XMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=0Z5Ups1W; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71798a15ce5so3016276b3a.0
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Sep 2024 18:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363241; x=1726968041; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLgeoM89s2vp4aLHGD208YibV+nTiX/UBaSjJzGFe5A=;
        b=0Z5Ups1WrYR+Z1h7rq+8GQu5cc5NEOletTgsBiDcK4on9czZizibKGRgD3U+BSG+Cq
         f+tR/q8kq/DR3gaeYfA3jU0VWaz7PsU1ZnzFh7QFeVOFtB/S8BBPVYPM7Aq1K9BeJLUc
         wzxauFwtZOWISJU0X8Oyuzs+KUowqQWKqJYS2wpXuiqNHQtG1Kms55NXrqp5C8i0YbwR
         xq3gPb8L7pnj3YrSbjfK68oSoCawTi1to0TW3O94lCRe/dc2V1Q1OBBSVpo54JHnfRZP
         1JJLDQ0GntsnjYfYVFhiR7zUQ0h6k+owzLbQ7sxQ0qJ7tJgUmYbkC4KRfHTxQuMk5pSv
         dRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363241; x=1726968041;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLgeoM89s2vp4aLHGD208YibV+nTiX/UBaSjJzGFe5A=;
        b=M+OiGQIDmfAfjcXZl+GHKIAT4gqsUsKCJ0Wg82zn1b87nUfaFeUX0vGHg5Raa6G63Y
         4oZqZH5Ld9hakkXi6QjM0DqAnXC3J1UfxFgNTbvDmvpfc33EgyMDvrnoExJUZISQ/y/K
         ZRObwGpRMH21AwkPDIE4zd8GzeOzld3lKdOAZfE79SUQ4Ld2V+uVSyVgnwHpPqDW8we4
         Hcbf2FkX/qh6Vb7gSbWRCVT5fi6mn4A1n7SU4XCwYWM8gwUGX96oj1wE6NuCxZwQLz79
         QuE3NP2/BBLRWWjAA33XhU+qaXDAa6H6oAjLid5slvBlVCz9mcXGAzIaFZ4BpwDttLOz
         k4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0JjgXV2YQ+alOFdGSnd4SNYxpGc8Xx1rqM7/c13Ri/CYCEthYYeD1oL906uxHW3aXH00mLCDeCr3u+QvO8vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOt3G5nsrTtSupAeEulZbFCKlBqtlnQJ3kYzLX654OEgXsTrfR
	hrGpO1noNNxyehlUNoEHYA8C+UrzIoRZdXbEene6kZWomebqHjmDaz3wjkRnRpQ=
X-Google-Smtp-Source: AGHT+IEuXd470KPosf/99tIHcbCkFqhBXY56o9UQ9zTUfV7dYcRP8GFxpdSADKV9eRB98r7H8uS0Kg==
X-Received: by 2002:a05:6a21:e85:b0:1ce:f6dc:2ba8 with SMTP id adf61e73a8af0-1cf759249demr16946549637.24.1726363240737;
        Sat, 14 Sep 2024 18:20:40 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71944a9ac0esm1568371b3a.14.2024.09.14.18.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:20:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:17:47 +0900
Subject: [PATCH RFC v3 8/9] selftest: tun: Add tests for virtio-net hashing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-rss-v3-8-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
In-Reply-To: <20240915-rss-v3-0-c630015db082@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

The added tests confirm tun can perform RSS and hash reporting, and
reject invalid configurations for them.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tun.c    | 666 ++++++++++++++++++++++++++++++++++-
 2 files changed, 660 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8eaffd7a641c..5629e68bf69d 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -109,6 +109,6 @@ $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
 $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
 $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
-$(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
+$(OUTPUT)/io_uring_zerocopy_tx $(OUTPUT)/tun: CFLAGS += -I../../../include/
 
 include bpf.mk
diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1..f46affa39d5c 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -2,21 +2,37 @@
 
 #define _GNU_SOURCE
 
+#include <endian.h>
 #include <errno.h>
 #include <fcntl.h>
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
@@ -39,7 +55,7 @@ static int tun_detach(int fd, char *dev)
 	return ioctl(fd, TUNSETQUEUE, (void *) &ifr);
 }
 
-static int tun_alloc(char *dev)
+static int tun_alloc(char *dev, short flags)
 {
 	struct ifreq ifr;
 	int fd, err;
@@ -52,7 +68,8 @@ static int tun_alloc(char *dev)
 
 	memset(&ifr, 0, sizeof(ifr));
 	strcpy(ifr.ifr_name, dev);
-	ifr.ifr_flags = IFF_TAP | IFF_NAPI | IFF_MULTI_QUEUE;
+	ifr.ifr_flags = flags | IFF_TAP | IFF_NAPI | IFF_NO_PI |
+			IFF_MULTI_QUEUE;
 
 	err = ioctl(fd, TUNSETIFF, (void *) &ifr);
 	if (err < 0) {
@@ -64,6 +81,40 @@ static int tun_alloc(char *dev)
 	return fd;
 }
 
+static bool tun_add_to_bridge(int local_fd, const char *name)
+{
+	struct ifreq ifreq = {
+		.ifr_name = "xbridge",
+		.ifr_ifindex = if_nametoindex(name)
+	};
+
+	if (!ifreq.ifr_ifindex) {
+		perror("if_nametoindex");
+		return false;
+	}
+
+	if (ioctl(local_fd, SIOCBRADDIF, &ifreq)) {
+		perror("SIOCBRADDIF");
+		return false;
+	}
+
+	return true;
+}
+
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
@@ -102,6 +153,159 @@ static int tun_delete(char *dev)
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
+static void tun_build_ethhdr(struct ethhdr *ethhdr, uint16_t proto)
+{
+	*ethhdr = (struct ethhdr) {
+		.h_dest = TUN_HWADDR_DEST,
+		.h_source = TUN_HWADDR_SOURCE,
+		.h_proto = htons(proto)
+	};
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
+static bool tun_vnet_hash_check(int source_fd, const int *dest_fds,
+				const void *buffer, size_t len,
+				uint8_t flags,
+				uint16_t hash_report, uint32_t hash_value)
+{
+	size_t read_len = sizeof(struct virtio_net_hdr_v1_hash) + len;
+	struct virtio_net_hdr_v1_hash *read_buffer;
+	struct virtio_net_hdr_v1_hash hdr = {
+		.hdr = {
+			.flags = flags,
+			.num_buffers = hash_report ? htole16(1) : 0
+		},
+		.hash_value = htole32(hash_value),
+		.hash_report = htole16(hash_report)
+	};
+	int ret;
+	int txq = hash_report ? hash_value & 1 : 2;
+
+	if (write(source_fd, buffer, len) != len) {
+		perror("write");
+		return false;
+	}
+
+	read_buffer = malloc(read_len);
+	if (!read_buffer) {
+		perror("malloc");
+		return false;
+	}
+
+	ret = read(dest_fds[txq], read_buffer, read_len);
+	if (ret != read_len) {
+		perror("read");
+		free(read_buffer);
+		return false;
+	}
+
+	ret = !memcmp(read_buffer, &hdr, sizeof(*read_buffer)) &&
+	      !memcmp(read_buffer + 1, buffer, len);
+
+	free(read_buffer);
+	return ret;
+}
+
 FIXTURE(tun)
 {
 	char ifname[IFNAMSIZ];
@@ -112,10 +316,10 @@ FIXTURE_SETUP(tun)
 {
 	memset(self->ifname, 0, sizeof(self->ifname));
 
-	self->fd = tun_alloc(self->ifname);
+	self->fd = tun_alloc(self->ifname, 0);
 	ASSERT_GE(self->fd, 0);
 
-	self->fd2 = tun_alloc(self->ifname);
+	self->fd2 = tun_alloc(self->ifname, 0);
 	ASSERT_GE(self->fd2, 0);
 }
 
@@ -159,4 +363,452 @@ TEST_F(tun, reattach_close_delete) {
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
+FIXTURE(tun_vnet_hash)
+{
+	int local_fd;
+	int source_fd;
+	int dest_fds[3];
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
+	char source_ifname[IFNAMSIZ] = "";
+	char dest_ifname[IFNAMSIZ] = "";
+	int i;
+
+	self->local_fd = socket(AF_LOCAL, SOCK_STREAM, 0);
+	ASSERT_LE(0, self->local_fd);
+
+	self->source_fd = tun_alloc(source_ifname, 0);
+	ASSERT_LE(0, self->source_fd) {
+		EXPECT_EQ(0, close(self->local_fd));
+	}
+
+	ASSERT_TRUE(tun_set_flags(self->local_fd, source_ifname, IFF_UP)) {
+		EXPECT_EQ(0, close(self->local_fd));
+	}
+
+	self->dest_fds[0] = tun_alloc(dest_ifname, IFF_VNET_HDR);
+	ASSERT_LE(0, self->dest_fds[0]) {
+		EXPECT_EQ(0, close(self->source_fd));
+		EXPECT_EQ(0, close(self->local_fd));
+	}
+
+	i = sizeof(struct virtio_net_hdr_v1_hash);
+	ASSERT_EQ(ioctl(self->dest_fds[0], TUNSETVNETHDRSZ, &i), 0) {
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+		EXPECT_EQ(0, close(self->source_fd));
+		EXPECT_EQ(0, close(self->local_fd));
+	}
+
+	i = 1;
+	ASSERT_EQ(ioctl(self->dest_fds[0], TUNSETVNETLE, &i), 0) {
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+		EXPECT_EQ(0, close(self->source_fd));
+		EXPECT_EQ(0, close(self->local_fd));
+	}
+
+	ASSERT_TRUE(tun_set_flags(self->local_fd, dest_ifname, IFF_UP)) {
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+		EXPECT_EQ(0, close(self->source_fd));
+		EXPECT_EQ(0, close(self->local_fd));
+	}
+
+	ASSERT_EQ(write(self->dest_fds[0], &packet, sizeof(packet)),
+		  sizeof(packet)) {
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+		EXPECT_EQ(0, close(self->source_fd));
+		EXPECT_EQ(0, close(self->local_fd));
+	}
+
+	ASSERT_EQ(ioctl(self->dest_fds[0], TUNSETVNETHASH, &vnet_hash), 0) {
+		EXPECT_EQ(0, close(self->dest_fds[0]));
+		EXPECT_EQ(0, close(self->source_fd));
+		EXPECT_EQ(0, close(self->local_fd));
+	}
+
+	for (i = 1; i < ARRAY_SIZE(self->dest_fds); i++) {
+		self->dest_fds[i] = tun_alloc(dest_ifname, IFF_VNET_HDR);
+		ASSERT_LE(0, self->dest_fds[i]) {
+			while (i) {
+				i--;
+				EXPECT_EQ(0, close(self->local_fd));
+			}
+
+			EXPECT_EQ(0, close(self->source_fd));
+			EXPECT_EQ(0, close(self->local_fd));
+		}
+	}
+
+	ASSERT_EQ(ioctl(self->local_fd, SIOCBRADDBR, "xbridge"), 0) {
+		EXPECT_EQ(0, ioctl(self->local_fd, SIOCBRDELBR, "xbridge"));
+
+		for (i = 0; i < ARRAY_SIZE(self->dest_fds); i++)
+			EXPECT_EQ(0, close(self->dest_fds[i]));
+
+		EXPECT_EQ(0, close(self->source_fd));
+		EXPECT_EQ(0, close(self->local_fd));
+	}
+
+	ASSERT_TRUE(tun_add_to_bridge(self->local_fd, source_ifname)) {
+		EXPECT_EQ(0, ioctl(self->local_fd, SIOCBRDELBR, "xbridge"));
+
+		for (i = 0; i < ARRAY_SIZE(self->dest_fds); i++)
+			EXPECT_EQ(0, close(self->dest_fds[i]));
+
+		EXPECT_EQ(0, close(self->source_fd));
+		EXPECT_EQ(0, close(self->local_fd));
+	}
+
+	ASSERT_TRUE(tun_add_to_bridge(self->local_fd, dest_ifname)) {
+		EXPECT_EQ(0, ioctl(self->local_fd, SIOCBRDELBR, "xbridge"));
+
+		for (i = 0; i < ARRAY_SIZE(self->dest_fds); i++)
+			EXPECT_EQ(0, close(self->dest_fds[i]));
+
+		EXPECT_EQ(0, close(self->source_fd));
+		EXPECT_EQ(0, close(self->local_fd));
+	}
+
+	ASSERT_TRUE(tun_set_flags(self->local_fd, "xbridge", IFF_UP)) {
+		EXPECT_EQ(0, ioctl(self->local_fd, SIOCBRDELBR, "xbridge"));
+
+		for (i = 0; i < ARRAY_SIZE(self->dest_fds); i++)
+			EXPECT_EQ(0, close(self->dest_fds[i]));
+
+		EXPECT_EQ(0, close(self->source_fd));
+		EXPECT_EQ(0, close(self->local_fd));
+	}
+}
+
+FIXTURE_TEARDOWN(tun_vnet_hash)
+{
+	ASSERT_TRUE(tun_set_flags(self->local_fd, "xbridge", 0)) {
+		for (size_t i = 0; i < ARRAY_SIZE(self->dest_fds); i++)
+			EXPECT_EQ(0, close(self->dest_fds[i]));
+
+		EXPECT_EQ(0, close(self->source_fd));
+		EXPECT_EQ(0, close(self->local_fd));
+	}
+
+	EXPECT_EQ(0, ioctl(self->local_fd, SIOCBRDELBR, "xbridge"));
+
+	for (size_t i = 0; i < ARRAY_SIZE(self->dest_fds); i++)
+		EXPECT_EQ(0, close(self->dest_fds[i]));
+
+	EXPECT_EQ(0, close(self->source_fd));
+	EXPECT_EQ(0, close(self->local_fd));
+}
+
+TEST_F(tun_vnet_hash, unclassified)
+{
+	struct {
+		struct ethhdr ethhdr;
+		struct iphdr iphdr;
+	} __packed packet;
+
+	tun_build_ethhdr(&packet.ethhdr, ETH_P_LOOPBACK);
+
+	EXPECT_TRUE(tun_vnet_hash_check(self->source_fd, self->dest_fds,
+					&packet, sizeof(packet), 0,
+					VIRTIO_NET_HASH_REPORT_NONE, 0));
+}
+
+TEST_F(tun_vnet_hash, ipv4)
+{
+	struct {
+		struct ethhdr ethhdr;
+		struct iphdr iphdr;
+	} __packed packet;
+
+	tun_build_ethhdr(&packet.ethhdr, ETH_P_IP);
+	tun_build_iphdr(&packet.iphdr, 0, 253);
+
+	EXPECT_TRUE(tun_vnet_hash_check(self->source_fd, self->dest_fds,
+					&packet, sizeof(packet), 0,
+					VIRTIO_NET_HASH_REPORT_IPv4,
+					0x6e45d952));
+}
+
+TEST_F(tun_vnet_hash, tcpv4)
+{
+	struct {
+		struct ethhdr ethhdr;
+		struct iphdr iphdr;
+		struct tcphdr tcphdr;
+	} __packed packet;
+
+	tun_build_ethhdr(&packet.ethhdr, ETH_P_IP);
+	tun_build_iphdr(&packet.iphdr, sizeof(struct tcphdr), IPPROTO_TCP);
+
+	tun_build_tcphdr(&packet.tcphdr,
+			 tun_build_ip_pseudo_sum(&packet.iphdr));
+
+	EXPECT_TRUE(tun_vnet_hash_check(self->source_fd, self->dest_fds,
+					&packet, sizeof(packet),
+					VIRTIO_NET_HDR_F_DATA_VALID,
+					VIRTIO_NET_HASH_REPORT_TCPv4,
+					0xfb63539a));
+}
+
+TEST_F(tun_vnet_hash, udpv4)
+{
+	struct {
+		struct ethhdr ethhdr;
+		struct iphdr iphdr;
+		struct udphdr udphdr;
+	} __packed packet;
+
+	tun_build_ethhdr(&packet.ethhdr, ETH_P_IP);
+	tun_build_iphdr(&packet.iphdr, sizeof(struct udphdr), IPPROTO_UDP);
+
+	tun_build_udphdr(&packet.udphdr,
+			 tun_build_ip_pseudo_sum(&packet.iphdr));
+
+	EXPECT_TRUE(tun_vnet_hash_check(self->source_fd, self->dest_fds,
+					&packet, sizeof(packet),
+					VIRTIO_NET_HDR_F_DATA_VALID,
+					VIRTIO_NET_HASH_REPORT_UDPv4,
+					0xfb63539a));
+}
+
+TEST_F(tun_vnet_hash, ipv6)
+{
+	struct {
+		struct ethhdr ethhdr;
+		struct ipv6hdr ipv6hdr;
+	} __packed packet;
+
+	tun_build_ethhdr(&packet.ethhdr, ETH_P_IPV6);
+	tun_build_ipv6hdr(&packet.ipv6hdr, 0, 253);
+
+	EXPECT_TRUE(tun_vnet_hash_check(self->source_fd, self->dest_fds,
+					&packet, sizeof(packet), 0,
+					VIRTIO_NET_HASH_REPORT_IPv6,
+					0xd6eb560f));
+}
+
+TEST_F(tun_vnet_hash, tcpv6)
+{
+	struct {
+		struct ethhdr ethhdr;
+		struct ipv6hdr ipv6hdr;
+		struct tcphdr tcphdr;
+	} __packed packet;
+
+	tun_build_ethhdr(&packet.ethhdr, ETH_P_IPV6);
+	tun_build_ipv6hdr(&packet.ipv6hdr, sizeof(struct tcphdr), IPPROTO_TCP);
+
+	tun_build_tcphdr(&packet.tcphdr,
+			 tun_build_ipv6_pseudo_sum(&packet.ipv6hdr));
+
+	EXPECT_TRUE(tun_vnet_hash_check(self->source_fd, self->dest_fds,
+					&packet, sizeof(packet),
+					VIRTIO_NET_HDR_F_DATA_VALID,
+					VIRTIO_NET_HASH_REPORT_TCPv6,
+					0xc2b9f251));
+}
+
+TEST_F(tun_vnet_hash, udpv6)
+{
+	struct {
+		struct ethhdr ethhdr;
+		struct ipv6hdr ipv6hdr;
+		struct udphdr udphdr;
+	} __packed packet;
+
+	tun_build_ethhdr(&packet.ethhdr, ETH_P_IPV6);
+	tun_build_ipv6hdr(&packet.ipv6hdr, sizeof(struct udphdr), IPPROTO_UDP);
+
+	tun_build_udphdr(&packet.udphdr,
+			 tun_build_ipv6_pseudo_sum(&packet.ipv6hdr));
+
+	EXPECT_TRUE(tun_vnet_hash_check(self->source_fd, self->dest_fds,
+					&packet, sizeof(packet),
+					VIRTIO_NET_HDR_F_DATA_VALID,
+					VIRTIO_NET_HASH_REPORT_UDPv6,
+					0xc2b9f251));
+}
+
+FIXTURE(tun_vnet_hash_config)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(tun_vnet_hash_config)
+{
+	char ifname[IFNAMSIZ];
+
+	ifname[0] = 0;
+	self->fd = tun_alloc(ifname, 0);
+	ASSERT_LE(0, self->fd);
+}
+
+FIXTURE_TEARDOWN(tun_vnet_hash_config)
+{
+	EXPECT_EQ(close(self->fd), 0);
+}
+
+TEST_F(tun_vnet_hash_config, cap)
+{
+	struct tun_vnet_hash cap;
+
+	ASSERT_EQ(0, ioctl(self->fd, TUNGETVNETHASHCAP, &cap));
+	EXPECT_EQ(cap.types,
+		  VIRTIO_NET_RSS_HASH_TYPE_IPv4 |
+		  VIRTIO_NET_RSS_HASH_TYPE_TCPv4 |
+		  VIRTIO_NET_RSS_HASH_TYPE_UDPv4 |
+		  VIRTIO_NET_RSS_HASH_TYPE_IPv6 |
+		  VIRTIO_NET_RSS_HASH_TYPE_TCPv6 |
+		  VIRTIO_NET_RSS_HASH_TYPE_UDPv6);
+}
+
+TEST_F(tun_vnet_hash_config, insufficient_hdr_sz)
+{
+	static const struct tun_vnet_hash vnet_hash = {
+		.flags = TUN_VNET_HASH_REPORT
+	};
+	int i;
+
+	i = 1;
+	ASSERT_EQ(0, ioctl(self->fd, TUNSETVNETLE, &i));
+
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETHASH, &vnet_hash));
+	EXPECT_EQ(errno, EBUSY);
+}
+
+TEST_F(tun_vnet_hash_config, shrink_hdr_sz)
+{
+	static const struct tun_vnet_hash vnet_hash = {
+		.flags = TUN_VNET_HASH_REPORT
+	};
+	int i;
+
+	i = sizeof(struct virtio_net_hdr_v1_hash);
+	ASSERT_EQ(0, ioctl(self->fd, TUNSETVNETHDRSZ, &i));
+
+	i = 1;
+	ASSERT_EQ(0, ioctl(self->fd, TUNSETVNETLE, &i));
+
+	ASSERT_EQ(0, ioctl(self->fd, TUNSETVNETHASH, &vnet_hash));
+
+	i = sizeof(struct virtio_net_hdr);
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETHDRSZ, &i));
+	EXPECT_EQ(errno, EBUSY);
+}
+
+TEST_F(tun_vnet_hash_config, set_be_early)
+{
+	static const struct tun_vnet_hash vnet_hash = {
+		.flags = TUN_VNET_HASH_REPORT
+	};
+	int i;
+
+	i = 1;
+	if (ioctl(self->fd, TUNSETVNETBE, &i))
+		return;
+
+	i = sizeof(struct virtio_net_hdr_v1_hash);
+	ASSERT_EQ(0, ioctl(self->fd, TUNSETVNETHDRSZ, &i));
+
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETHASH, &vnet_hash));
+	EXPECT_EQ(errno, EBUSY);
+}
+
+TEST_F(tun_vnet_hash_config, set_be_later)
+{
+	static const struct tun_vnet_hash vnet_hash = {
+		.flags = TUN_VNET_HASH_REPORT
+	};
+	int i;
+
+	i = sizeof(struct virtio_net_hdr_v1_hash);
+	ASSERT_EQ(0, ioctl(self->fd, TUNSETVNETHDRSZ, &i));
+
+	if (ioctl(self->fd, TUNSETVNETHASH, &vnet_hash))
+		return;
+
+	i = 1;
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETBE, &i));
+	EXPECT_TRUE(errno == EBUSY || errno == EINVAL);
+}
+
+TEST_F(tun_vnet_hash_config, unset_le_later)
+{
+	static const struct tun_vnet_hash vnet_hash = {
+		.flags = TUN_VNET_HASH_REPORT
+	};
+	int i;
+
+	i = sizeof(struct virtio_net_hdr_v1_hash);
+	ASSERT_EQ(0, ioctl(self->fd, TUNSETVNETHDRSZ, &i));
+
+	i = 1;
+	ioctl(self->fd, TUNSETVNETBE, &i);
+
+	if (!ioctl(self->fd, TUNSETVNETHASH, &vnet_hash))
+		return;
+
+	i = 1;
+	ASSERT_EQ(0, ioctl(self->fd, TUNSETVNETLE, &i));
+
+	ASSERT_EQ(0, ioctl(self->fd, TUNSETVNETHASH, &vnet_hash));
+
+	i = 0;
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETLE, &i));
+	EXPECT_EQ(errno, EBUSY);
+}
+
 TEST_HARNESS_MAIN

-- 
2.46.0


