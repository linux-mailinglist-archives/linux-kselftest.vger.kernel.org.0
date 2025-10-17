Return-Path: <linux-kselftest+bounces-43382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC02BE933A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC663B1F41
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 14:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBE632E145;
	Fri, 17 Oct 2025 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZLm6m6wz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E7632E135;
	Fri, 17 Oct 2025 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711376; cv=none; b=XFavXPM25KBrIsJACz8GJbr6Kwi/RY+1CyzKvdeZUwTxOiI4XXac5lu0+a0FeXiRwn5aNlmAw7xryXgKmf7OBtpeCIxCZ8UsMabKCuIWL7rji709P/oTWceFcOE+MdWqq88yeE6uoPDmKHNYfzoMDs/vyRAQ261vHSkJWbi9DsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711376; c=relaxed/simple;
	bh=KFFcsNcBFgb58ULj0aYU6tCoAsaGKKGBcZrihqppUUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3JmzQ7087PSH9Gb82RBChoThR6LuIpXQIO3pUCGQoNqadyPMMxhf5LMkwIp/gsHVYTWB66VrDBa+jEX/ltU3UeZPDii+r9XLd8hlvmHk4qMjGG+gSnGmzAFmrRhkXnwWUPUK1oeGWtycu/Xg67iexbqDMSYFajbgpdR3ebNtHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZLm6m6wz; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AADAC1A1485;
	Fri, 17 Oct 2025 14:29:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7B22D606DB;
	Fri, 17 Oct 2025 14:29:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B956D102F235A;
	Fri, 17 Oct 2025 16:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760711370; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=W+wRxRAlI6EyZThyqekU+pdIAIl20GfxBsr5PCtljcE=;
	b=ZLm6m6wzAESp3BSx2Zkv07YzyUOTY89RkqnXxAvCtxqYVSYE9XbtYgQw4EXq6SgIXlCj+f
	SsaUCWVDo3e3ECf62uknsKYzr1TnJ8Nc4nzJ1YR0rL/aD9g0rHulGW88wZMVcjLUIVJ2dz
	vImANJghaug2GUMtoXsGzWXlGetEx8O4hSFambsoe8UfrblUIj9LijUkg4bK+45X8e+jxH
	4k8+WdcYDCCRz/W/PxZK1xznRYZlMEz39/2XIwXs3/WgQ5ynpBV/2zk28UwvSoZre/0mpl
	sRIuPWn2KxOOGvO0dqbzCpBhOBrGJYszzZA345REZsz+9+JI6ohFHOxI5w+wYg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 17 Oct 2025 16:29:03 +0200
Subject: [PATCH bpf-next 3/5] selftests/bpf: make test_tc_tunnel.bpf.c
 compatible with big endian platforms
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251017-tc_tunnel-v1-3-2d86808d86b2@bootlin.com>
References: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
In-Reply-To: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

When trying to run bpf-based encapsulation in a s390x environment, some
parts of test_tc_tunnel.bpf.o do not encapsulate correctly the traffic,
leading to tests failures. Adding some logs shows for example that
packets about to be sent on an interface with the ip6vxlan_eth program
attached do not have the expected value 5 in the ip header ihl field,
and so are ignored by the program.

This phenomenon appears when trying to cross-compile the selftests,
rather than compiling it from a virtualized host: the selftests build
system may then wrongly pick some host headers. If <asm/byteorder.h>
ends up being picked on the host (and if the host has a endianness
different from the target one), it will then expose wrong endianness
defines (e.g __LITTLE_ENDIAN_BITFIELD instead of __BIT_ENDIAN_BITFIELD),
and it will for example mess up the iphdr structure layout used in the
ebpf program.

To prevent this, directly use the vmlinux.h header generated by the
selftests build system rather than including directly specific kernel
headers. As a consequence, add some missing definitions that are not
exposed by vmlinux.h, and adapt the bitfield manipulations to allow
building and using the program on both types of platforms.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 61 +++++++++-------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index 404124a9389278949e6952a6f1a50eea9a1bc473..c5a26f7e8ecfd0404960e75f07388fe609522bde 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -2,23 +2,10 @@
 
 /* In-place tunneling */
 
-#include <stdbool.h>
-#include <string.h>
-
-#include <linux/stddef.h>
-#include <linux/bpf.h>
-#include <linux/if_ether.h>
-#include <linux/in.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <linux/mpls.h>
-#include <linux/tcp.h>
-#include <linux/udp.h>
-#include <linux/pkt_cls.h>
-#include <linux/types.h>
+#include <vmlinux.h>
 
-#include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
 #include "bpf_compiler.h"
 
 #pragma GCC diagnostic ignored "-Waddress-of-packed-member"
@@ -27,6 +14,19 @@ static const int cfg_port = 8000;
 
 static const int cfg_udp_src = 20000;
 
+#define ETH_HLEN	14
+#define TC_ACT_OK	0
+#define TC_ACT_SHOT	2
+#define ETH_P_MPLS_UC	0x8847
+#define ETH_P_IP	0x0800
+#define ETH_P_IPV6	0x86DD
+#define ETH_P_TEB	0x6558
+
+#define MPLS_LS_S_MASK	0x00000100
+#define BPF_F_ADJ_ROOM_ENCAP_L2(len)			\
+	(((__u64)len & BPF_ADJ_ROOM_ENCAP_L2_MASK)	\
+	 << BPF_ADJ_ROOM_ENCAP_L2_SHIFT)
+
 #define	L2_PAD_SZ	(sizeof(struct vxlanhdr) + ETH_HLEN)
 
 #define	UDP_PORT		5555
@@ -36,10 +36,9 @@ static const int cfg_udp_src = 20000;
 
 #define	EXTPROTO_VXLAN	0x1
 
-#define	VXLAN_N_VID     (1u << 24)
-#define	VXLAN_VNI_MASK	bpf_htonl((VXLAN_N_VID - 1) << 8)
-#define	VXLAN_FLAGS     0x8
-#define	VXLAN_VNI       1
+#define	VXLAN_FLAGS     bpf_htonl(1<<27)
+#define	VNI_ID		1
+#define	VXLAN_VNI	bpf_htonl(VNI_ID << 8)
 
 #ifndef NEXTHDR_DEST
 #define NEXTHDR_DEST	60
@@ -48,12 +47,6 @@ static const int cfg_udp_src = 20000;
 /* MPLS label 1000 with S bit (last label) set and ttl of 255. */
 static const __u32 mpls_label = __bpf_constant_htonl(1000 << 12 |
 						     MPLS_LS_S_MASK | 0xff);
-
-struct vxlanhdr {
-	__be32 vx_flags;
-	__be32 vx_vni;
-} __attribute__((packed));
-
 struct gre_hdr {
 	__be16 flags;
 	__be16 protocol;
@@ -94,8 +87,8 @@ static __always_inline void set_ipv4_csum(struct iphdr *iph)
 static __always_inline int __encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
 					__u16 l2_proto, __u16 ext_proto)
 {
+	struct iphdr iph_inner = {0};
 	__u16 udp_dst = UDP_PORT;
-	struct iphdr iph_inner;
 	struct v4hdr h_outer;
 	struct tcphdr tcph;
 	int olen, l2_len;
@@ -122,7 +115,6 @@ static __always_inline int __encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
 			return TC_ACT_OK;
 
 		/* Derive the IPv4 header fields from the IPv6 header */
-		memset(&iph_inner, 0, sizeof(iph_inner));
 		iph_inner.version = 4;
 		iph_inner.ihl = 5;
 		iph_inner.tot_len = bpf_htons(sizeof(iph6_inner) +
@@ -210,7 +202,7 @@ static __always_inline int __encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
 			struct vxlanhdr *vxlan_hdr = (struct vxlanhdr *)l2_hdr;
 
 			vxlan_hdr->vx_flags = VXLAN_FLAGS;
-			vxlan_hdr->vx_vni = bpf_htonl((VXLAN_VNI & VXLAN_VNI_MASK) << 8);
+			vxlan_hdr->vx_vni = VXLAN_VNI;
 
 			l2_hdr += sizeof(struct vxlanhdr);
 		}
@@ -340,7 +332,7 @@ static __always_inline int __encap_ipv6(struct __sk_buff *skb, __u8 encap_proto,
 			struct vxlanhdr *vxlan_hdr = (struct vxlanhdr *)l2_hdr;
 
 			vxlan_hdr->vx_flags = VXLAN_FLAGS;
-			vxlan_hdr->vx_vni = bpf_htonl((VXLAN_VNI & VXLAN_VNI_MASK) << 8);
+			vxlan_hdr->vx_vni = VXLAN_VNI;
 
 			l2_hdr += sizeof(struct vxlanhdr);
 		}
@@ -372,8 +364,8 @@ static __always_inline int __encap_ipv6(struct __sk_buff *skb, __u8 encap_proto,
 
 static int encap_ipv6_ipip6(struct __sk_buff *skb)
 {
+	struct v6hdr h_outer = {0};
 	struct iphdr iph_inner;
-	struct v6hdr h_outer;
 	struct tcphdr tcph;
 	struct ethhdr eth;
 	__u64 flags;
@@ -400,13 +392,12 @@ static int encap_ipv6_ipip6(struct __sk_buff *skb)
 		return TC_ACT_SHOT;
 
 	/* prepare new outer network header */
-	memset(&h_outer.ip, 0, sizeof(h_outer.ip));
 	h_outer.ip.version = 6;
 	h_outer.ip.hop_limit = iph_inner.ttl;
-	h_outer.ip.saddr.s6_addr[1] = 0xfd;
-	h_outer.ip.saddr.s6_addr[15] = 1;
-	h_outer.ip.daddr.s6_addr[1] = 0xfd;
-	h_outer.ip.daddr.s6_addr[15] = 2;
+	h_outer.ip.saddr.in6_u.u6_addr8[1] = 0xfd;
+	h_outer.ip.saddr.in6_u.u6_addr8[15] = 1;
+	h_outer.ip.daddr.in6_u.u6_addr8[1] = 0xfd;
+	h_outer.ip.daddr.in6_u.u6_addr8[15] = 2;
 	h_outer.ip.payload_len = iph_inner.tot_len;
 	h_outer.ip.nexthdr = IPPROTO_IPIP;
 

-- 
2.51.0


