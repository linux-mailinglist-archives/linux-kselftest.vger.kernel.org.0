Return-Path: <linux-kselftest+bounces-22332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFD39D34A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 08:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4B3B24551
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F33919F12D;
	Wed, 20 Nov 2024 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WQ/YzyVV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F615CD41;
	Wed, 20 Nov 2024 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088629; cv=none; b=ogc/Kuq+k46iVaqiC8ToQKFChG8JJx6o4SwOCraQh4rgFCRG4LcshRT37B6609xxPkgwNo7mzJ1JJCwtjQa/mdN3BkQRimDF4m+g9o3JbR7uyKTx+eqDVoz65z6DGXAUjMzsSHCXwBNb1JRzsEPENK/tTaTtI89p+Dda0QI6JEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088629; c=relaxed/simple;
	bh=d5JgCAHQX++TG+5t01KzdAYKUKsEDeX16L9ApMIfKZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ctypg0QItVOV0M88VA3KMDcpBBOzfXDb70C9Z5kQY3TYFSfc8bnMAj+IpmH1N8GPNAqTO4HiKEjrWpLSbe3KJxDbgbP19vYg4e3+VNd8UiP3/SKP3toQg7BpmSYNorGmRY4W4FcaU7voNNkhrCzdLNmsc7A+j//FvT3bUtivIgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WQ/YzyVV; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 784E924000B;
	Wed, 20 Nov 2024 07:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732088624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnS2bDn7T3R9sRDp3boZ+QRxTPhb6KczAtLf0qSev7Q=;
	b=WQ/YzyVVPirykXEv5V8uxQZ6xiNLQ940CM8cPkqjFBdcilcrxaW3k3L4xg0Vv4vRRpBzF5
	HJqkeSblV2lWK8GNNVwIETE3rcFCR5TwfCK+07zeRFNAliiifgYK9NB9XQt6BPoJdOZEnL
	PpLVwucYq+45RWC43NKzB/s6EbQE1qsf3KBs9xHibDMyJ5APNsdjCFGWWWpWePmamAj53g
	WKzCkhs+oCJi4r6P30bHKkOaMf7Yh9kHFjD8NprRYVv74g85jzdmN6IdYZq04xYYzdczc8
	LPZinCDkunZpf8wyBC0owWeYv0HibKYbyOUrg8qBct6m6tG37rBjePvcJWfn6Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 20 Nov 2024 08:43:24 +0100
Subject: [PATCH bpf-next v3 14/14] selftests/bpf: remove
 test_flow_dissector.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-flow_dissector-v3-14-45b46494f937@bootlin.com>
References: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
In-Reply-To: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

Now that test_flow_dissector.sh has been converted to test_progs, remove
the legacy test.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- none

Changes in v2:
- fetch Acked-by tag
---
 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   3 +-
 tools/testing/selftests/bpf/test_flow_dissector.c  | 780 ---------------------
 tools/testing/selftests/bpf/test_flow_dissector.sh | 178 -----
 4 files changed, 1 insertion(+), 961 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index d45c9a9b304d4710ee66f4ffdf4d7e1c785c99bc..0bbc9b8ba8527b2c02009ea75b9fc98d02f2eb2b 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -19,7 +19,6 @@ feature
 urandom_read
 test_sockmap
 test_lirc_mode2_user
-test_flow_dissector
 flow_dissector_load
 test_tcpnotify_user
 test_libbpf
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b1080284522d6615b753bd98f9d5135db55f922a..2439749dfc86651aa2afa79b572cb32570c6bdbd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -133,7 +133,6 @@ TEST_PROGS := test_kmod.sh \
 	test_tunnel.sh \
 	test_lwt_seg6local.sh \
 	test_lirc_mode2.sh \
-	test_flow_dissector.sh \
 	test_xdp_vlan_mode_generic.sh \
 	test_xdp_vlan_mode_native.sh \
 	test_lwt_ip_encap.sh \
@@ -154,7 +153,7 @@ TEST_PROGS_EXTENDED := with_addr.sh \
 
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = \
-	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
+	flow_dissector_load test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
 	xdp_features bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
diff --git a/tools/testing/selftests/bpf/test_flow_dissector.c b/tools/testing/selftests/bpf/test_flow_dissector.c
deleted file mode 100644
index 571cc076dd7db7f2254c4593e979ac5a8d89f273..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_flow_dissector.c
+++ /dev/null
@@ -1,780 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Inject packets with all sorts of encapsulation into the kernel.
- *
- * IPv4/IPv6	outer layer 3
- * GRE/GUE/BARE outer layer 4, where bare is IPIP/SIT/IPv4-in-IPv6/..
- * IPv4/IPv6    inner layer 3
- */
-
-#define _GNU_SOURCE
-
-#include <stddef.h>
-#include <arpa/inet.h>
-#include <asm/byteorder.h>
-#include <error.h>
-#include <errno.h>
-#include <linux/if_packet.h>
-#include <linux/if_ether.h>
-#include <linux/ipv6.h>
-#include <netinet/ip.h>
-#include <netinet/in.h>
-#include <netinet/udp.h>
-#include <poll.h>
-#include <stdbool.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <sys/ioctl.h>
-#include <sys/socket.h>
-#include <sys/stat.h>
-#include <sys/time.h>
-#include <sys/types.h>
-#include <unistd.h>
-
-#define CFG_PORT_INNER	8000
-
-/* Add some protocol definitions that do not exist in userspace */
-
-struct grehdr {
-	uint16_t unused;
-	uint16_t protocol;
-} __attribute__((packed));
-
-struct guehdr {
-	union {
-		struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-			__u8	hlen:5,
-				control:1,
-				version:2;
-#elif defined (__BIG_ENDIAN_BITFIELD)
-			__u8	version:2,
-				control:1,
-				hlen:5;
-#else
-#error  "Please fix <asm/byteorder.h>"
-#endif
-			__u8	proto_ctype;
-			__be16	flags;
-		};
-		__be32	word;
-	};
-};
-
-static uint8_t	cfg_dsfield_inner;
-static uint8_t	cfg_dsfield_outer;
-static uint8_t	cfg_encap_proto;
-static bool	cfg_expect_failure = false;
-static int	cfg_l3_extra = AF_UNSPEC;	/* optional SIT prefix */
-static int	cfg_l3_inner = AF_UNSPEC;
-static int	cfg_l3_outer = AF_UNSPEC;
-static int	cfg_num_pkt = 10;
-static int	cfg_num_secs = 0;
-static char	cfg_payload_char = 'a';
-static int	cfg_payload_len = 100;
-static int	cfg_port_gue = 6080;
-static bool	cfg_only_rx;
-static bool	cfg_only_tx;
-static int	cfg_src_port = 9;
-
-static char	buf[ETH_DATA_LEN];
-
-#define INIT_ADDR4(name, addr4, port)				\
-	static struct sockaddr_in name = {			\
-		.sin_family = AF_INET,				\
-		.sin_port = __constant_htons(port),		\
-		.sin_addr.s_addr = __constant_htonl(addr4),	\
-	};
-
-#define INIT_ADDR6(name, addr6, port)				\
-	static struct sockaddr_in6 name = {			\
-		.sin6_family = AF_INET6,			\
-		.sin6_port = __constant_htons(port),		\
-		.sin6_addr = addr6,				\
-	};
-
-INIT_ADDR4(in_daddr4, INADDR_LOOPBACK, CFG_PORT_INNER)
-INIT_ADDR4(in_saddr4, INADDR_LOOPBACK + 2, 0)
-INIT_ADDR4(out_daddr4, INADDR_LOOPBACK, 0)
-INIT_ADDR4(out_saddr4, INADDR_LOOPBACK + 1, 0)
-INIT_ADDR4(extra_daddr4, INADDR_LOOPBACK, 0)
-INIT_ADDR4(extra_saddr4, INADDR_LOOPBACK + 1, 0)
-
-INIT_ADDR6(in_daddr6, IN6ADDR_LOOPBACK_INIT, CFG_PORT_INNER)
-INIT_ADDR6(in_saddr6, IN6ADDR_LOOPBACK_INIT, 0)
-INIT_ADDR6(out_daddr6, IN6ADDR_LOOPBACK_INIT, 0)
-INIT_ADDR6(out_saddr6, IN6ADDR_LOOPBACK_INIT, 0)
-INIT_ADDR6(extra_daddr6, IN6ADDR_LOOPBACK_INIT, 0)
-INIT_ADDR6(extra_saddr6, IN6ADDR_LOOPBACK_INIT, 0)
-
-static unsigned long util_gettime(void)
-{
-	struct timeval tv;
-
-	gettimeofday(&tv, NULL);
-	return (tv.tv_sec * 1000) + (tv.tv_usec / 1000);
-}
-
-static void util_printaddr(const char *msg, struct sockaddr *addr)
-{
-	unsigned long off = 0;
-	char nbuf[INET6_ADDRSTRLEN];
-
-	switch (addr->sa_family) {
-	case PF_INET:
-		off = __builtin_offsetof(struct sockaddr_in, sin_addr);
-		break;
-	case PF_INET6:
-		off = __builtin_offsetof(struct sockaddr_in6, sin6_addr);
-		break;
-	default:
-		error(1, 0, "printaddr: unsupported family %u\n",
-		      addr->sa_family);
-	}
-
-	if (!inet_ntop(addr->sa_family, ((void *) addr) + off, nbuf,
-		       sizeof(nbuf)))
-		error(1, errno, "inet_ntop");
-
-	fprintf(stderr, "%s: %s\n", msg, nbuf);
-}
-
-static unsigned long add_csum_hword(const uint16_t *start, int num_u16)
-{
-	unsigned long sum = 0;
-	int i;
-
-	for (i = 0; i < num_u16; i++)
-		sum += start[i];
-
-	return sum;
-}
-
-static uint16_t build_ip_csum(const uint16_t *start, int num_u16,
-			      unsigned long sum)
-{
-	sum += add_csum_hword(start, num_u16);
-
-	while (sum >> 16)
-		sum = (sum & 0xffff) + (sum >> 16);
-
-	return ~sum;
-}
-
-static void build_ipv4_header(void *header, uint8_t proto,
-			      uint32_t src, uint32_t dst,
-			      int payload_len, uint8_t tos)
-{
-	struct iphdr *iph = header;
-
-	iph->ihl = 5;
-	iph->version = 4;
-	iph->tos = tos;
-	iph->ttl = 8;
-	iph->tot_len = htons(sizeof(*iph) + payload_len);
-	iph->id = htons(1337);
-	iph->protocol = proto;
-	iph->saddr = src;
-	iph->daddr = dst;
-	iph->check = build_ip_csum((void *) iph, iph->ihl << 1, 0);
-}
-
-static void ipv6_set_dsfield(struct ipv6hdr *ip6h, uint8_t dsfield)
-{
-	uint16_t val, *ptr = (uint16_t *)ip6h;
-
-	val = ntohs(*ptr);
-	val &= 0xF00F;
-	val |= ((uint16_t) dsfield) << 4;
-	*ptr = htons(val);
-}
-
-static void build_ipv6_header(void *header, uint8_t proto,
-			      struct sockaddr_in6 *src,
-			      struct sockaddr_in6 *dst,
-			      int payload_len, uint8_t dsfield)
-{
-	struct ipv6hdr *ip6h = header;
-
-	ip6h->version = 6;
-	ip6h->payload_len = htons(payload_len);
-	ip6h->nexthdr = proto;
-	ip6h->hop_limit = 8;
-	ipv6_set_dsfield(ip6h, dsfield);
-
-	memcpy(&ip6h->saddr, &src->sin6_addr, sizeof(ip6h->saddr));
-	memcpy(&ip6h->daddr, &dst->sin6_addr, sizeof(ip6h->daddr));
-}
-
-static uint16_t build_udp_v4_csum(const struct iphdr *iph,
-				  const struct udphdr *udph,
-				  int num_words)
-{
-	unsigned long pseudo_sum;
-	int num_u16 = sizeof(iph->saddr);	/* halfwords: twice byte len */
-
-	pseudo_sum = add_csum_hword((void *) &iph->saddr, num_u16);
-	pseudo_sum += htons(IPPROTO_UDP);
-	pseudo_sum += udph->len;
-	return build_ip_csum((void *) udph, num_words, pseudo_sum);
-}
-
-static uint16_t build_udp_v6_csum(const struct ipv6hdr *ip6h,
-				  const struct udphdr *udph,
-				  int num_words)
-{
-	unsigned long pseudo_sum;
-	int num_u16 = sizeof(ip6h->saddr);	/* halfwords: twice byte len */
-
-	pseudo_sum = add_csum_hword((void *) &ip6h->saddr, num_u16);
-	pseudo_sum += htons(ip6h->nexthdr);
-	pseudo_sum += ip6h->payload_len;
-	return build_ip_csum((void *) udph, num_words, pseudo_sum);
-}
-
-static void build_udp_header(void *header, int payload_len,
-			     uint16_t dport, int family)
-{
-	struct udphdr *udph = header;
-	int len = sizeof(*udph) + payload_len;
-
-	udph->source = htons(cfg_src_port);
-	udph->dest = htons(dport);
-	udph->len = htons(len);
-	udph->check = 0;
-	if (family == AF_INET)
-		udph->check = build_udp_v4_csum(header - sizeof(struct iphdr),
-						udph, len >> 1);
-	else
-		udph->check = build_udp_v6_csum(header - sizeof(struct ipv6hdr),
-						udph, len >> 1);
-}
-
-static void build_gue_header(void *header, uint8_t proto)
-{
-	struct guehdr *gueh = header;
-
-	gueh->proto_ctype = proto;
-}
-
-static void build_gre_header(void *header, uint16_t proto)
-{
-	struct grehdr *greh = header;
-
-	greh->protocol = htons(proto);
-}
-
-static int l3_length(int family)
-{
-	if (family == AF_INET)
-		return sizeof(struct iphdr);
-	else
-		return sizeof(struct ipv6hdr);
-}
-
-static int build_packet(void)
-{
-	int ol3_len = 0, ol4_len = 0, il3_len = 0, il4_len = 0;
-	int el3_len = 0;
-
-	if (cfg_l3_extra)
-		el3_len = l3_length(cfg_l3_extra);
-
-	/* calculate header offsets */
-	if (cfg_encap_proto) {
-		ol3_len = l3_length(cfg_l3_outer);
-
-		if (cfg_encap_proto == IPPROTO_GRE)
-			ol4_len = sizeof(struct grehdr);
-		else if (cfg_encap_proto == IPPROTO_UDP)
-			ol4_len = sizeof(struct udphdr) + sizeof(struct guehdr);
-	}
-
-	il3_len = l3_length(cfg_l3_inner);
-	il4_len = sizeof(struct udphdr);
-
-	if (el3_len + ol3_len + ol4_len + il3_len + il4_len + cfg_payload_len >=
-	    sizeof(buf))
-		error(1, 0, "packet too large\n");
-
-	/*
-	 * Fill packet from inside out, to calculate correct checksums.
-	 * But create ip before udp headers, as udp uses ip for pseudo-sum.
-	 */
-	memset(buf + el3_len + ol3_len + ol4_len + il3_len + il4_len,
-	       cfg_payload_char, cfg_payload_len);
-
-	/* add zero byte for udp csum padding */
-	buf[el3_len + ol3_len + ol4_len + il3_len + il4_len + cfg_payload_len] = 0;
-
-	switch (cfg_l3_inner) {
-	case PF_INET:
-		build_ipv4_header(buf + el3_len + ol3_len + ol4_len,
-				  IPPROTO_UDP,
-				  in_saddr4.sin_addr.s_addr,
-				  in_daddr4.sin_addr.s_addr,
-				  il4_len + cfg_payload_len,
-				  cfg_dsfield_inner);
-		break;
-	case PF_INET6:
-		build_ipv6_header(buf + el3_len + ol3_len + ol4_len,
-				  IPPROTO_UDP,
-				  &in_saddr6, &in_daddr6,
-				  il4_len + cfg_payload_len,
-				  cfg_dsfield_inner);
-		break;
-	}
-
-	build_udp_header(buf + el3_len + ol3_len + ol4_len + il3_len,
-			 cfg_payload_len, CFG_PORT_INNER, cfg_l3_inner);
-
-	if (!cfg_encap_proto)
-		return il3_len + il4_len + cfg_payload_len;
-
-	switch (cfg_l3_outer) {
-	case PF_INET:
-		build_ipv4_header(buf + el3_len, cfg_encap_proto,
-				  out_saddr4.sin_addr.s_addr,
-				  out_daddr4.sin_addr.s_addr,
-				  ol4_len + il3_len + il4_len + cfg_payload_len,
-				  cfg_dsfield_outer);
-		break;
-	case PF_INET6:
-		build_ipv6_header(buf + el3_len, cfg_encap_proto,
-				  &out_saddr6, &out_daddr6,
-				  ol4_len + il3_len + il4_len + cfg_payload_len,
-				  cfg_dsfield_outer);
-		break;
-	}
-
-	switch (cfg_encap_proto) {
-	case IPPROTO_UDP:
-		build_gue_header(buf + el3_len + ol3_len + ol4_len -
-				 sizeof(struct guehdr),
-				 cfg_l3_inner == PF_INET ? IPPROTO_IPIP
-							 : IPPROTO_IPV6);
-		build_udp_header(buf + el3_len + ol3_len,
-				 sizeof(struct guehdr) + il3_len + il4_len +
-				 cfg_payload_len,
-				 cfg_port_gue, cfg_l3_outer);
-		break;
-	case IPPROTO_GRE:
-		build_gre_header(buf + el3_len + ol3_len,
-				 cfg_l3_inner == PF_INET ? ETH_P_IP
-							 : ETH_P_IPV6);
-		break;
-	}
-
-	switch (cfg_l3_extra) {
-	case PF_INET:
-		build_ipv4_header(buf,
-				  cfg_l3_outer == PF_INET ? IPPROTO_IPIP
-							  : IPPROTO_IPV6,
-				  extra_saddr4.sin_addr.s_addr,
-				  extra_daddr4.sin_addr.s_addr,
-				  ol3_len + ol4_len + il3_len + il4_len +
-				  cfg_payload_len, 0);
-		break;
-	case PF_INET6:
-		build_ipv6_header(buf,
-				  cfg_l3_outer == PF_INET ? IPPROTO_IPIP
-							  : IPPROTO_IPV6,
-				  &extra_saddr6, &extra_daddr6,
-				  ol3_len + ol4_len + il3_len + il4_len +
-				  cfg_payload_len, 0);
-		break;
-	}
-
-	return el3_len + ol3_len + ol4_len + il3_len + il4_len +
-	       cfg_payload_len;
-}
-
-/* sender transmits encapsulated over RAW or unencap'd over UDP */
-static int setup_tx(void)
-{
-	int family, fd, ret;
-
-	if (cfg_l3_extra)
-		family = cfg_l3_extra;
-	else if (cfg_l3_outer)
-		family = cfg_l3_outer;
-	else
-		family = cfg_l3_inner;
-
-	fd = socket(family, SOCK_RAW, IPPROTO_RAW);
-	if (fd == -1)
-		error(1, errno, "socket tx");
-
-	if (cfg_l3_extra) {
-		if (cfg_l3_extra == PF_INET)
-			ret = connect(fd, (void *) &extra_daddr4,
-				      sizeof(extra_daddr4));
-		else
-			ret = connect(fd, (void *) &extra_daddr6,
-				      sizeof(extra_daddr6));
-		if (ret)
-			error(1, errno, "connect tx");
-	} else if (cfg_l3_outer) {
-		/* connect to destination if not encapsulated */
-		if (cfg_l3_outer == PF_INET)
-			ret = connect(fd, (void *) &out_daddr4,
-				      sizeof(out_daddr4));
-		else
-			ret = connect(fd, (void *) &out_daddr6,
-				      sizeof(out_daddr6));
-		if (ret)
-			error(1, errno, "connect tx");
-	} else {
-		/* otherwise using loopback */
-		if (cfg_l3_inner == PF_INET)
-			ret = connect(fd, (void *) &in_daddr4,
-				      sizeof(in_daddr4));
-		else
-			ret = connect(fd, (void *) &in_daddr6,
-				      sizeof(in_daddr6));
-		if (ret)
-			error(1, errno, "connect tx");
-	}
-
-	return fd;
-}
-
-/* receiver reads unencapsulated UDP */
-static int setup_rx(void)
-{
-	int fd, ret;
-
-	fd = socket(cfg_l3_inner, SOCK_DGRAM, 0);
-	if (fd == -1)
-		error(1, errno, "socket rx");
-
-	if (cfg_l3_inner == PF_INET)
-		ret = bind(fd, (void *) &in_daddr4, sizeof(in_daddr4));
-	else
-		ret = bind(fd, (void *) &in_daddr6, sizeof(in_daddr6));
-	if (ret)
-		error(1, errno, "bind rx");
-
-	return fd;
-}
-
-static int do_tx(int fd, const char *pkt, int len)
-{
-	int ret;
-
-	ret = write(fd, pkt, len);
-	if (ret == -1)
-		error(1, errno, "send");
-	if (ret != len)
-		error(1, errno, "send: len (%d < %d)\n", ret, len);
-
-	return 1;
-}
-
-static int do_poll(int fd, short events, int timeout)
-{
-	struct pollfd pfd;
-	int ret;
-
-	pfd.fd = fd;
-	pfd.events = events;
-
-	ret = poll(&pfd, 1, timeout);
-	if (ret == -1)
-		error(1, errno, "poll");
-	if (ret && !(pfd.revents & POLLIN))
-		error(1, errno, "poll: unexpected event 0x%x\n", pfd.revents);
-
-	return ret;
-}
-
-static int do_rx(int fd)
-{
-	char rbuf;
-	int ret, num = 0;
-
-	while (1) {
-		ret = recv(fd, &rbuf, 1, MSG_DONTWAIT);
-		if (ret == -1 && errno == EAGAIN)
-			break;
-		if (ret == -1)
-			error(1, errno, "recv");
-		if (rbuf != cfg_payload_char)
-			error(1, 0, "recv: payload mismatch");
-		num++;
-	}
-
-	return num;
-}
-
-static int do_main(void)
-{
-	unsigned long tstop, treport, tcur;
-	int fdt = -1, fdr = -1, len, tx = 0, rx = 0;
-
-	if (!cfg_only_tx)
-		fdr = setup_rx();
-	if (!cfg_only_rx)
-		fdt = setup_tx();
-
-	len = build_packet();
-
-	tcur = util_gettime();
-	treport = tcur + 1000;
-	tstop = tcur + (cfg_num_secs * 1000);
-
-	while (1) {
-		if (!cfg_only_rx)
-			tx += do_tx(fdt, buf, len);
-
-		if (!cfg_only_tx)
-			rx += do_rx(fdr);
-
-		if (cfg_num_secs) {
-			tcur = util_gettime();
-			if (tcur >= tstop)
-				break;
-			if (tcur >= treport) {
-				fprintf(stderr, "pkts: tx=%u rx=%u\n", tx, rx);
-				tx = 0;
-				rx = 0;
-				treport = tcur + 1000;
-			}
-		} else {
-			if (tx == cfg_num_pkt)
-				break;
-		}
-	}
-
-	/* read straggler packets, if any */
-	if (rx < tx) {
-		tstop = util_gettime() + 100;
-		while (rx < tx) {
-			tcur = util_gettime();
-			if (tcur >= tstop)
-				break;
-
-			do_poll(fdr, POLLIN, tstop - tcur);
-			rx += do_rx(fdr);
-		}
-	}
-
-	fprintf(stderr, "pkts: tx=%u rx=%u\n", tx, rx);
-
-	if (fdr != -1 && close(fdr))
-		error(1, errno, "close rx");
-	if (fdt != -1 && close(fdt))
-		error(1, errno, "close tx");
-
-	/*
-	 * success (== 0) only if received all packets
-	 * unless failure is expected, in which case none must arrive.
-	 */
-	if (cfg_expect_failure)
-		return rx != 0;
-	else
-		return rx != tx;
-}
-
-
-static void __attribute__((noreturn)) usage(const char *filepath)
-{
-	fprintf(stderr, "Usage: %s [-e gre|gue|bare|none] [-i 4|6] [-l len] "
-			"[-O 4|6] [-o 4|6] [-n num] [-t secs] [-R] [-T] "
-			"[-s <osrc> [-d <odst>] [-S <isrc>] [-D <idst>] "
-			"[-x <otos>] [-X <itos>] [-f <isport>] [-F]\n",
-		filepath);
-	exit(1);
-}
-
-static void parse_addr(int family, void *addr, const char *optarg)
-{
-	int ret;
-
-	ret = inet_pton(family, optarg, addr);
-	if (ret == -1)
-		error(1, errno, "inet_pton");
-	if (ret == 0)
-		error(1, 0, "inet_pton: bad string");
-}
-
-static void parse_addr4(struct sockaddr_in *addr, const char *optarg)
-{
-	parse_addr(AF_INET, &addr->sin_addr, optarg);
-}
-
-static void parse_addr6(struct sockaddr_in6 *addr, const char *optarg)
-{
-	parse_addr(AF_INET6, &addr->sin6_addr, optarg);
-}
-
-static int parse_protocol_family(const char *filepath, const char *optarg)
-{
-	if (!strcmp(optarg, "4"))
-		return PF_INET;
-	if (!strcmp(optarg, "6"))
-		return PF_INET6;
-
-	usage(filepath);
-}
-
-static void parse_opts(int argc, char **argv)
-{
-	int c;
-
-	while ((c = getopt(argc, argv, "d:D:e:f:Fhi:l:n:o:O:Rs:S:t:Tx:X:")) != -1) {
-		switch (c) {
-		case 'd':
-			if (cfg_l3_outer == AF_UNSPEC)
-				error(1, 0, "-d must be preceded by -o");
-			if (cfg_l3_outer == AF_INET)
-				parse_addr4(&out_daddr4, optarg);
-			else
-				parse_addr6(&out_daddr6, optarg);
-			break;
-		case 'D':
-			if (cfg_l3_inner == AF_UNSPEC)
-				error(1, 0, "-D must be preceded by -i");
-			if (cfg_l3_inner == AF_INET)
-				parse_addr4(&in_daddr4, optarg);
-			else
-				parse_addr6(&in_daddr6, optarg);
-			break;
-		case 'e':
-			if (!strcmp(optarg, "gre"))
-				cfg_encap_proto = IPPROTO_GRE;
-			else if (!strcmp(optarg, "gue"))
-				cfg_encap_proto = IPPROTO_UDP;
-			else if (!strcmp(optarg, "bare"))
-				cfg_encap_proto = IPPROTO_IPIP;
-			else if (!strcmp(optarg, "none"))
-				cfg_encap_proto = IPPROTO_IP;	/* == 0 */
-			else
-				usage(argv[0]);
-			break;
-		case 'f':
-			cfg_src_port = strtol(optarg, NULL, 0);
-			break;
-		case 'F':
-			cfg_expect_failure = true;
-			break;
-		case 'h':
-			usage(argv[0]);
-			break;
-		case 'i':
-			if (!strcmp(optarg, "4"))
-				cfg_l3_inner = PF_INET;
-			else if (!strcmp(optarg, "6"))
-				cfg_l3_inner = PF_INET6;
-			else
-				usage(argv[0]);
-			break;
-		case 'l':
-			cfg_payload_len = strtol(optarg, NULL, 0);
-			break;
-		case 'n':
-			cfg_num_pkt = strtol(optarg, NULL, 0);
-			break;
-		case 'o':
-			cfg_l3_outer = parse_protocol_family(argv[0], optarg);
-			break;
-		case 'O':
-			cfg_l3_extra = parse_protocol_family(argv[0], optarg);
-			break;
-		case 'R':
-			cfg_only_rx = true;
-			break;
-		case 's':
-			if (cfg_l3_outer == AF_INET)
-				parse_addr4(&out_saddr4, optarg);
-			else
-				parse_addr6(&out_saddr6, optarg);
-			break;
-		case 'S':
-			if (cfg_l3_inner == AF_INET)
-				parse_addr4(&in_saddr4, optarg);
-			else
-				parse_addr6(&in_saddr6, optarg);
-			break;
-		case 't':
-			cfg_num_secs = strtol(optarg, NULL, 0);
-			break;
-		case 'T':
-			cfg_only_tx = true;
-			break;
-		case 'x':
-			cfg_dsfield_outer = strtol(optarg, NULL, 0);
-			break;
-		case 'X':
-			cfg_dsfield_inner = strtol(optarg, NULL, 0);
-			break;
-		}
-	}
-
-	if (cfg_only_rx && cfg_only_tx)
-		error(1, 0, "options: cannot combine rx-only and tx-only");
-
-	if (cfg_encap_proto && cfg_l3_outer == AF_UNSPEC)
-		error(1, 0, "options: must specify outer with encap");
-	else if ((!cfg_encap_proto) && cfg_l3_outer != AF_UNSPEC)
-		error(1, 0, "options: cannot combine no-encap and outer");
-	else if ((!cfg_encap_proto) && cfg_l3_extra != AF_UNSPEC)
-		error(1, 0, "options: cannot combine no-encap and extra");
-
-	if (cfg_l3_inner == AF_UNSPEC)
-		cfg_l3_inner = AF_INET6;
-	if (cfg_l3_inner == AF_INET6 && cfg_encap_proto == IPPROTO_IPIP)
-		cfg_encap_proto = IPPROTO_IPV6;
-
-	/* RFC 6040 4.2:
-	 *   on decap, if outer encountered congestion (CE == 0x3),
-	 *   but inner cannot encode ECN (NoECT == 0x0), then drop packet.
-	 */
-	if (((cfg_dsfield_outer & 0x3) == 0x3) &&
-	    ((cfg_dsfield_inner & 0x3) == 0x0))
-		cfg_expect_failure = true;
-}
-
-static void print_opts(void)
-{
-	if (cfg_l3_inner == PF_INET6) {
-		util_printaddr("inner.dest6", (void *) &in_daddr6);
-		util_printaddr("inner.source6", (void *) &in_saddr6);
-	} else {
-		util_printaddr("inner.dest4", (void *) &in_daddr4);
-		util_printaddr("inner.source4", (void *) &in_saddr4);
-	}
-
-	if (!cfg_l3_outer)
-		return;
-
-	fprintf(stderr, "encap proto:   %u\n", cfg_encap_proto);
-
-	if (cfg_l3_outer == PF_INET6) {
-		util_printaddr("outer.dest6", (void *) &out_daddr6);
-		util_printaddr("outer.source6", (void *) &out_saddr6);
-	} else {
-		util_printaddr("outer.dest4", (void *) &out_daddr4);
-		util_printaddr("outer.source4", (void *) &out_saddr4);
-	}
-
-	if (!cfg_l3_extra)
-		return;
-
-	if (cfg_l3_outer == PF_INET6) {
-		util_printaddr("extra.dest6", (void *) &extra_daddr6);
-		util_printaddr("extra.source6", (void *) &extra_saddr6);
-	} else {
-		util_printaddr("extra.dest4", (void *) &extra_daddr4);
-		util_printaddr("extra.source4", (void *) &extra_saddr4);
-	}
-
-}
-
-int main(int argc, char **argv)
-{
-	parse_opts(argc, argv);
-	print_opts();
-	return do_main();
-}
diff --git a/tools/testing/selftests/bpf/test_flow_dissector.sh b/tools/testing/selftests/bpf/test_flow_dissector.sh
deleted file mode 100755
index 4b298863797a28a1762d1f06d6c89c481498b505..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_flow_dissector.sh
+++ /dev/null
@@ -1,178 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# Load BPF flow dissector and verify it correctly dissects traffic
-
-BPF_FILE="bpf_flow.bpf.o"
-export TESTNAME=test_flow_dissector
-unmount=0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-msg="skip all tests:"
-if [ $UID != 0 ]; then
-	echo $msg please run this as root >&2
-	exit $ksft_skip
-fi
-
-# This test needs to be run in a network namespace with in_netns.sh. Check if
-# this is the case and run it with in_netns.sh if it is being run in the root
-# namespace.
-if [[ -z $(ip netns identify $$) ]]; then
-	err=0
-	if bpftool="$(which bpftool)"; then
-		echo "Testing global flow dissector..."
-
-		$bpftool prog loadall $BPF_FILE /sys/fs/bpf/flow \
-			type flow_dissector
-
-		if ! unshare --net $bpftool prog attach pinned \
-			/sys/fs/bpf/flow/_dissect flow_dissector; then
-			echo "Unexpected unsuccessful attach in namespace" >&2
-			err=1
-		fi
-
-		$bpftool prog attach pinned /sys/fs/bpf/flow/_dissect \
-			flow_dissector
-
-		if unshare --net $bpftool prog attach pinned \
-			/sys/fs/bpf/flow/_dissect flow_dissector; then
-			echo "Unexpected successful attach in namespace" >&2
-			err=1
-		fi
-
-		if ! $bpftool prog detach pinned \
-			/sys/fs/bpf/flow/_dissect flow_dissector; then
-			echo "Failed to detach flow dissector" >&2
-			err=1
-		fi
-
-		rm -rf /sys/fs/bpf/flow
-	else
-		echo "Skipping root flow dissector test, bpftool not found" >&2
-	fi
-
-	# Run the rest of the tests in a net namespace.
-	../net/in_netns.sh "$0" "$@"
-	err=$(( $err + $? ))
-
-	if (( $err == 0 )); then
-		echo "selftests: $TESTNAME [PASS]";
-	else
-		echo "selftests: $TESTNAME [FAILED]";
-	fi
-
-	exit $err
-fi
-
-# Determine selftest success via shell exit code
-exit_handler()
-{
-	set +e
-
-	# Cleanup
-	tc filter del dev lo ingress pref 1337 2> /dev/null
-	tc qdisc del dev lo ingress 2> /dev/null
-	./flow_dissector_load -d 2> /dev/null
-	if [ $unmount -ne 0 ]; then
-		umount bpffs 2> /dev/null
-	fi
-}
-
-# Exit script immediately (well catched by trap handler) if any
-# program/thing exits with a non-zero status.
-set -e
-
-# (Use 'trap -l' to list meaning of numbers)
-trap exit_handler 0 2 3 6 9
-
-# Mount BPF file system
-if /bin/mount | grep /sys/fs/bpf > /dev/null; then
-	echo "bpffs already mounted"
-else
-	echo "bpffs not mounted. Mounting..."
-	unmount=1
-	/bin/mount bpffs /sys/fs/bpf -t bpf
-fi
-
-# Attach BPF program
-./flow_dissector_load -p $BPF_FILE -s _dissect
-
-# Setup
-tc qdisc add dev lo ingress
-echo 0 > /proc/sys/net/ipv4/conf/default/rp_filter
-echo 0 > /proc/sys/net/ipv4/conf/all/rp_filter
-echo 0 > /proc/sys/net/ipv4/conf/lo/rp_filter
-
-echo "Testing IPv4..."
-# Drops all IP/UDP packets coming from port 9
-tc filter add dev lo parent ffff: protocol ip pref 1337 flower ip_proto \
-	udp src_port 9 action drop
-
-# Send 10 IPv4/UDP packets from port 8. Filter should not drop any.
-./test_flow_dissector -i 4 -f 8
-# Send 10 IPv4/UDP packets from port 9. Filter should drop all.
-./test_flow_dissector -i 4 -f 9 -F
-# Send 10 IPv4/UDP packets from port 10. Filter should not drop any.
-./test_flow_dissector -i 4 -f 10
-
-echo "Testing IPv4 from 127.0.0.127 (fallback to generic dissector)..."
-# Send 10 IPv4/UDP packets from port 8. Filter should not drop any.
-./test_flow_dissector -i 4 -S 127.0.0.127 -f 8
-# Send 10 IPv4/UDP packets from port 9. Filter should drop all.
-./test_flow_dissector -i 4 -S 127.0.0.127 -f 9 -F
-# Send 10 IPv4/UDP packets from port 10. Filter should not drop any.
-./test_flow_dissector -i 4 -S 127.0.0.127 -f 10
-
-echo "Testing IPIP..."
-# Send 10 IPv4/IPv4/UDP packets from port 8. Filter should not drop any.
-./with_addr.sh ./with_tunnels.sh ./test_flow_dissector -o 4 -e bare -i 4 \
-	-D 192.168.0.1 -S 1.1.1.1 -f 8
-# Send 10 IPv4/IPv4/UDP packets from port 9. Filter should drop all.
-./with_addr.sh ./with_tunnels.sh ./test_flow_dissector -o 4 -e bare -i 4 \
-	-D 192.168.0.1 -S 1.1.1.1 -f 9 -F
-# Send 10 IPv4/IPv4/UDP packets from port 10. Filter should not drop any.
-./with_addr.sh ./with_tunnels.sh ./test_flow_dissector -o 4 -e bare -i 4 \
-	-D 192.168.0.1 -S 1.1.1.1 -f 10
-
-echo "Testing IPv4 + GRE..."
-# Send 10 IPv4/GRE/IPv4/UDP packets from port 8. Filter should not drop any.
-./with_addr.sh ./with_tunnels.sh ./test_flow_dissector -o 4 -e gre -i 4 \
-	-D 192.168.0.1 -S 1.1.1.1 -f 8
-# Send 10 IPv4/GRE/IPv4/UDP packets from port 9. Filter should drop all.
-./with_addr.sh ./with_tunnels.sh ./test_flow_dissector -o 4 -e gre -i 4 \
-	-D 192.168.0.1 -S 1.1.1.1 -f 9 -F
-# Send 10 IPv4/GRE/IPv4/UDP packets from port 10. Filter should not drop any.
-./with_addr.sh ./with_tunnels.sh ./test_flow_dissector -o 4 -e gre -i 4 \
-	-D 192.168.0.1 -S 1.1.1.1 -f 10
-
-tc filter del dev lo ingress pref 1337
-
-echo "Testing port range..."
-# Drops all IP/UDP packets coming from port 8-10
-tc filter add dev lo parent ffff: protocol ip pref 1337 flower ip_proto \
-	udp src_port 8-10 action drop
-
-# Send 10 IPv4/UDP packets from port 7. Filter should not drop any.
-./test_flow_dissector -i 4 -f 7
-# Send 10 IPv4/UDP packets from port 9. Filter should drop all.
-./test_flow_dissector -i 4 -f 9 -F
-# Send 10 IPv4/UDP packets from port 11. Filter should not drop any.
-./test_flow_dissector -i 4 -f 11
-
-tc filter del dev lo ingress pref 1337
-
-echo "Testing IPv6..."
-# Drops all IPv6/UDP packets coming from port 9
-tc filter add dev lo parent ffff: protocol ipv6 pref 1337 flower ip_proto \
-	udp src_port 9 action drop
-
-# Send 10 IPv6/UDP packets from port 8. Filter should not drop any.
-./test_flow_dissector -i 6 -f 8
-# Send 10 IPv6/UDP packets from port 9. Filter should drop all.
-./test_flow_dissector -i 6 -f 9 -F
-# Send 10 IPv6/UDP packets from port 10. Filter should not drop any.
-./test_flow_dissector -i 6 -f 10
-
-exit 0

-- 
2.47.0


