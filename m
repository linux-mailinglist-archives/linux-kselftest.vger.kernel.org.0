Return-Path: <linux-kselftest+bounces-1969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D410D813D8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 23:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE11282D52
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 22:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D4C6E2B4;
	Thu, 14 Dec 2023 22:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="q0WJccvE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PTU2xgSj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED8C6DCF2;
	Thu, 14 Dec 2023 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.west.internal (Postfix) with ESMTP id AF69E2B006D3;
	Thu, 14 Dec 2023 17:49:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 14 Dec 2023 17:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1702594170; x=
	1702601370; bh=9Zj48xwH3RKj/ArgA1aCuMUGNgo6h0Y1fWoiEhljy1A=; b=q
	0WJccvEiqp+OKyiyiLd7y0ALdi8/80Qrhymw3YCbPFiRKseZU/aIfla2jEpDcCOh
	moJtGViMQNrkh9ukizU+duDsY+pg7nbHi0hUEVxLvRhH7JjVuv2o6ZDKxKrJtZPa
	5W4h2d2GhN98wCojSSpGZ4VFwSr62giNjbZCN4mYuddsP2hPYStvTtsZiVFFz9mN
	2gLhuZJvNWgGksz5ZUfJObog3rDU4dRsSHM6h2PI3ZmoX2iZw3/JwE85ZMAEPyzk
	4hC5Gf4hVBlpNEMBqCpEUtTYjCmHz9RU/0RPmUMOsK8aHZ66qwS9DaVNnmE+ShPN
	bVfz+8OtDQOgUw8ExzrBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702594170; x=
	1702601370; bh=9Zj48xwH3RKj/ArgA1aCuMUGNgo6h0Y1fWoiEhljy1A=; b=P
	TU2xgSjJQH91/90vUbbQq8bfxUAMzs7975OKTnKTjS8r6v8qkBtjy7EWnrFSXTKc
	1SaCbkipcO6pXPNqvId0dC2IbiqHR0U3LPmApqiDKa+5eQrhNJz+fyp1gId2IT4A
	W7OTBOgkSyXxqKKqz+y1V44vJY5cn6lcXv3vYvbRU5KybVYPMNnuXhel9TBUirEW
	IzpHc2ViPX6v8lHjaODK4CwMFLI1WPjeSgVDxB7EAbrngD74Dl7XV1Fp1QMxxM3t
	wqBb7FoJKfpl4TPZfN1Gfth4g5sqFnC8EcTifixkCKiLVAjxc+1G6A0pwjvEVvMJ
	+65MwLEQwuHb4/cIaR4nw==
X-ME-Sender: <xms:eoZ7ZZquqmFQ_Mks5CPvAX_RrzsAAuqlkcDABkEe2i39yYe68foY6g>
    <xme:eoZ7ZbrPeLhpPaVnj4hpH7Vg-6LPsyw7QbBlGLvIyXkyMNBovdQEpijv3Cf1tVAUx
    lrSMd3sdt4qwkuBYg>
X-ME-Received: <xmr:eoZ7ZWPm6dgc1aYqa1gsbdTdV4GRBw8GgORJmYja3CS6gPn7h6i8HqcEWEI7pgLlNbv3IbzNnhUYnZVyzBTd24JR4JKI8lkWORgVLeBwxJ1uIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddttddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepvdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:eoZ7ZU52uwI8uaTBTOLp3Ig4iU2y43c2F0015qPNlQSwjd8AoQ3B9Q>
    <xmx:eoZ7ZY43R4aEpNz04FXoMHrLtjV32bAx1Dbk3XK__LKL4EzE8qOy4A>
    <xmx:eoZ7ZcjXCgQMOYokCZKA-I8ht1EntWwGY8QNdzoRk-fCGLyq-1gu_Q>
    <xmx:eoZ7ZdTZGwGzAw-_SUHG5NaSrJjD9yn0NStK1vG_LubZEPtkCP4EMTjwnw4>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 17:49:28 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	ast@kernel.org,
	shuah@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	eyal.birger@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v6 3/5] bpf: selftests: test_tunnel: Use vmlinux.h declarations
Date: Thu, 14 Dec 2023 15:49:04 -0700
Message-ID: <884bde1d9a351d126a3923886b945ea6b1b0776b.1702593901.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702593901.git.dxu@dxuuu.xyz>
References: <cover.1702593901.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmlinux.h declarations are more ergnomic, especially when working with
kfuncs. The uapi headers are often incomplete for kfunc definitions.

This commit also switches bitfield accesses to use CO-RE helpers.
Switching to vmlinux.h definitions makes the verifier very
unhappy with raw bitfield accesses. The error is:

    ; md.u.md2.dir = direction;
    33: (69) r1 = *(u16 *)(r2 +11)
    misaligned stack access off (0x0; 0x0)+-64+11 size 2

Fix by using CO-RE-aware bitfield reads and writes.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/progs/bpf_tracing_net.h     |  1 +
 .../selftests/bpf/progs/test_tunnel_kern.c    | 76 +++++--------------
 2 files changed, 22 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index 0b793a102791..1bdc680b0e0e 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -26,6 +26,7 @@
 #define IPV6_AUTOFLOWLABEL	70
 
 #define TC_ACT_UNSPEC		(-1)
+#define TC_ACT_OK		0
 #define TC_ACT_SHOT		2
 
 #define SOL_TCP			6
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index f66af753bbbb..b320fb7bb080 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -6,62 +6,26 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
-#include <stddef.h>
-#include <string.h>
-#include <arpa/inet.h>
-#include <linux/bpf.h>
-#include <linux/if_ether.h>
-#include <linux/if_packet.h>
-#include <linux/if_tunnel.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <linux/icmp.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/pkt_cls.h>
-#include <linux/erspan.h>
-#include <linux/udp.h>
+#include "vmlinux.h"
+#include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include "bpf_kfuncs.h"
+#include "bpf_tracing_net.h"
 
 #define log_err(__ret) bpf_printk("ERROR line:%d ret:%d\n", __LINE__, __ret)
 
-#define VXLAN_UDP_PORT 4789
+#define VXLAN_UDP_PORT		4789
+#define ETH_P_IP		0x0800
+#define PACKET_HOST		0
+#define TUNNEL_CSUM		bpf_htons(0x01)
+#define TUNNEL_KEY		bpf_htons(0x04)
 
 /* Only IPv4 address assigned to veth1.
  * 172.16.1.200
  */
 #define ASSIGNED_ADDR_VETH1 0xac1001c8
 
-struct geneve_opt {
-	__be16	opt_class;
-	__u8	type;
-	__u8	length:5;
-	__u8	r3:1;
-	__u8	r2:1;
-	__u8	r1:1;
-	__u8	opt_data[8]; /* hard-coded to 8 byte */
-};
-
-struct vxlanhdr {
-	__be32 vx_flags;
-	__be32 vx_vni;
-} __attribute__((packed));
-
-struct vxlan_metadata {
-	__u32     gbp;
-};
-
-struct bpf_fou_encap {
-	__be16 sport;
-	__be16 dport;
-};
-
-enum bpf_fou_encap_type {
-	FOU_BPF_ENCAP_FOU,
-	FOU_BPF_ENCAP_GUE,
-};
-
 int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
 			  struct bpf_fou_encap *encap, int type) __ksym;
 int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
@@ -205,9 +169,9 @@ int erspan_set_tunnel(struct __sk_buff *skb)
 	__u8 hwid = 7;
 
 	md.version = 2;
-	md.u.md2.dir = direction;
-	md.u.md2.hwid = hwid & 0xf;
-	md.u.md2.hwid_upper = (hwid >> 4) & 0x3;
+	BPF_CORE_WRITE_BITFIELD(&md.u.md2, dir, direction);
+	BPF_CORE_WRITE_BITFIELD(&md.u.md2, hwid, (hwid & 0xf));
+	BPF_CORE_WRITE_BITFIELD(&md.u.md2, hwid_upper, (hwid >> 4) & 0x3);
 #endif
 
 	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
@@ -246,8 +210,9 @@ int erspan_get_tunnel(struct __sk_buff *skb)
 	bpf_printk("\tindex %x\n", index);
 #else
 	bpf_printk("\tdirection %d hwid %x timestamp %u\n",
-		   md.u.md2.dir,
-		   (md.u.md2.hwid_upper << 4) + md.u.md2.hwid,
+		   BPF_CORE_READ_BITFIELD(&md.u.md2, dir),
+		   (BPF_CORE_READ_BITFIELD(&md.u.md2, hwid_upper) << 4) +
+		   BPF_CORE_READ_BITFIELD(&md.u.md2, hwid),
 		   bpf_ntohl(md.u.md2.timestamp));
 #endif
 
@@ -284,9 +249,9 @@ int ip4ip6erspan_set_tunnel(struct __sk_buff *skb)
 	__u8 hwid = 17;
 
 	md.version = 2;
-	md.u.md2.dir = direction;
-	md.u.md2.hwid = hwid & 0xf;
-	md.u.md2.hwid_upper = (hwid >> 4) & 0x3;
+	BPF_CORE_WRITE_BITFIELD(&md.u.md2, dir, direction);
+	BPF_CORE_WRITE_BITFIELD(&md.u.md2, hwid, (hwid & 0xf));
+	BPF_CORE_WRITE_BITFIELD(&md.u.md2, hwid_upper, (hwid >> 4) & 0x3);
 #endif
 
 	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
@@ -326,8 +291,9 @@ int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
 	bpf_printk("\tindex %x\n", index);
 #else
 	bpf_printk("\tdirection %d hwid %x timestamp %u\n",
-		   md.u.md2.dir,
-		   (md.u.md2.hwid_upper << 4) + md.u.md2.hwid,
+		   BPF_CORE_READ_BITFIELD(&md.u.md2, dir),
+		   (BPF_CORE_READ_BITFIELD(&md.u.md2, hwid_upper) << 4) +
+		   BPF_CORE_READ_BITFIELD(&md.u.md2, hwid),
 		   bpf_ntohl(md.u.md2.timestamp));
 #endif
 
-- 
2.42.1


