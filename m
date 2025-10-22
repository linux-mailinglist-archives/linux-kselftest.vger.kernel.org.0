Return-Path: <linux-kselftest+bounces-43741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D15BFAA24
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 09:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BA93AA54B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 07:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503552FC871;
	Wed, 22 Oct 2025 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QD4Uf6K3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4432FBE12
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118827; cv=none; b=MlhLbgImtuJnVCqPO9ba90ItWAsVccZWIFL1qaTVCKp6hx61d/dojp3eExBJlloQJbXjN+iZG8lpGBeyOT9AA7mbvjwW+Z39/wPNeL2phPnABmJAK4fY4ZMafgKo2RMFRbjSWY4n4wApYVsjHIlvWAWbzDXGlahXXgEhnDTEWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118827; c=relaxed/simple;
	bh=iu0P+vaJ5O5gG5TpEvT8FAfiBsTiYmaG1u8QZ7crA7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JSTli04F9I/x0rCSmtkA+ahApyj/fSbgUXnkQutCLgH41PRoojDyrGLMFvt4xfpxzJohmfKrHhyrLCZ+AZj7tcr3gmqZBw11vuM40Jubs5hMcsio/JjwA+PZXIQazzn7sZ6WwscdJFzao2Dmv9aftEApE19U9lmm8eo09wRhBZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QD4Uf6K3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8365A4E41269;
	Wed, 22 Oct 2025 07:40:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5828A606DC;
	Wed, 22 Oct 2025 07:40:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3131F102F2426;
	Wed, 22 Oct 2025 09:40:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761118822; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xWiMo9ST793ACRe8WuzUy6BUXSEaZtsfUnqCbu+HGBM=;
	b=QD4Uf6K3wIQsXunCovsDhx+Gt5z1DSC3d3g/V0GYMaABddB6yrxJaqVkuRJOw/lu7+lh/G
	PZjxIXHAUUI+cxULZrYyRS2r2ae2FkOWuic4tkdbeVwJ4/RPtYZeCMRUrzYthIoEfZfLlc
	8BpBJLD62UE40E5IRorebzy8r1j1cSu3L5TrsTsQ7FSeIDh+vtb8lmKZ5eGZ1uHLlikX6m
	NtYNIJgXY5di40pLZ3L9/kvdm7Ersz7GOL1rzTj6tRN7erETMFTkIyuK145SQ7P/rIoleH
	tJySk4qqfTZAm/P3771JNi/I1m9+Usg5UqIVjVHUWu7NPTloGu/x2iGG40XnQg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 22 Oct 2025 09:39:51 +0200
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: make test_tc_tunnel.bpf.c
 compatible with big endian platforms
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251022-tc_tunnel-v2-2-a44a0bd52902@bootlin.com>
References: <20251022-tc_tunnel-v2-0-a44a0bd52902@bootlin.com>
In-Reply-To: <20251022-tc_tunnel-v2-0-a44a0bd52902@bootlin.com>
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
X-Mailer: b4 0.14.3
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
Changes in v2:
- use bpf_tracing_net.h to get some existing definitions
---
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 57 +++++++++-------------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index 404124a93892..b509e4c99648 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -2,23 +2,11 @@
 
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
+#include "bpf_tracing_net.h"
 #include "bpf_compiler.h"
 
 #pragma GCC diagnostic ignored "-Waddress-of-packed-member"
@@ -27,6 +15,14 @@ static const int cfg_port = 8000;
 
 static const int cfg_udp_src = 20000;
 
+#define ETH_P_MPLS_UC	0x8847
+#define ETH_P_TEB	0x6558
+
+#define MPLS_LS_S_MASK	0x00000100
+#define BPF_F_ADJ_ROOM_ENCAP_L2(len)			\
+	(((__u64)len & BPF_ADJ_ROOM_ENCAP_L2_MASK)	\
+	 << BPF_ADJ_ROOM_ENCAP_L2_SHIFT)
+
 #define	L2_PAD_SZ	(sizeof(struct vxlanhdr) + ETH_HLEN)
 
 #define	UDP_PORT		5555
@@ -36,10 +32,9 @@ static const int cfg_udp_src = 20000;
 
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
@@ -48,12 +43,6 @@ static const int cfg_udp_src = 20000;
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
@@ -94,8 +83,8 @@ static __always_inline void set_ipv4_csum(struct iphdr *iph)
 static __always_inline int __encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
 					__u16 l2_proto, __u16 ext_proto)
 {
+	struct iphdr iph_inner = {0};
 	__u16 udp_dst = UDP_PORT;
-	struct iphdr iph_inner;
 	struct v4hdr h_outer;
 	struct tcphdr tcph;
 	int olen, l2_len;
@@ -122,7 +111,6 @@ static __always_inline int __encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
 			return TC_ACT_OK;
 
 		/* Derive the IPv4 header fields from the IPv6 header */
-		memset(&iph_inner, 0, sizeof(iph_inner));
 		iph_inner.version = 4;
 		iph_inner.ihl = 5;
 		iph_inner.tot_len = bpf_htons(sizeof(iph6_inner) +
@@ -210,7 +198,7 @@ static __always_inline int __encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
 			struct vxlanhdr *vxlan_hdr = (struct vxlanhdr *)l2_hdr;
 
 			vxlan_hdr->vx_flags = VXLAN_FLAGS;
-			vxlan_hdr->vx_vni = bpf_htonl((VXLAN_VNI & VXLAN_VNI_MASK) << 8);
+			vxlan_hdr->vx_vni = VXLAN_VNI;
 
 			l2_hdr += sizeof(struct vxlanhdr);
 		}
@@ -340,7 +328,7 @@ static __always_inline int __encap_ipv6(struct __sk_buff *skb, __u8 encap_proto,
 			struct vxlanhdr *vxlan_hdr = (struct vxlanhdr *)l2_hdr;
 
 			vxlan_hdr->vx_flags = VXLAN_FLAGS;
-			vxlan_hdr->vx_vni = bpf_htonl((VXLAN_VNI & VXLAN_VNI_MASK) << 8);
+			vxlan_hdr->vx_vni = VXLAN_VNI;
 
 			l2_hdr += sizeof(struct vxlanhdr);
 		}
@@ -372,8 +360,8 @@ static __always_inline int __encap_ipv6(struct __sk_buff *skb, __u8 encap_proto,
 
 static int encap_ipv6_ipip6(struct __sk_buff *skb)
 {
+	struct v6hdr h_outer = {0};
 	struct iphdr iph_inner;
-	struct v6hdr h_outer;
 	struct tcphdr tcph;
 	struct ethhdr eth;
 	__u64 flags;
@@ -400,13 +388,12 @@ static int encap_ipv6_ipip6(struct __sk_buff *skb)
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
2.51.1.dirty


