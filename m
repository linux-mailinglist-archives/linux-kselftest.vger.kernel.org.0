Return-Path: <linux-kselftest+bounces-1089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73594804097
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 21:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 123BAB20BEC
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 20:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1374E3A28B;
	Mon,  4 Dec 2023 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="YRNFHjWu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hA9LeaKx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574CF170E;
	Mon,  4 Dec 2023 12:57:08 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.nyi.internal (Postfix) with ESMTP id B4F42580A25;
	Mon,  4 Dec 2023 15:57:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 04 Dec 2023 15:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701723427; x=
	1701730627; bh=9Zj48xwH3RKj/ArgA1aCuMUGNgo6h0Y1fWoiEhljy1A=; b=Y
	RNFHjWuvz62cHaHBqNVtt23HjB9DJfbsIsMz5mtvQYCOAbgZ4Sq+ZJgIlxE2e8a9
	P4tflkyTht3suLl8DfCLTpLMgLvOeORxcs3n2KwUeHMUIlqvWUM3xnEnene+kmI1
	hEyo5H4ngR9VIg3JyirTN7v8L8PXa8+HHQNsLkbAU+k+haWrowYdlwua74ep4P1k
	0foMFFqDDlBrxxJlHWzGD1oUjLjgk4cSlg/7T6WTP56z6UWbqNjBKS+4kIPkEqoS
	8XZYNKxoOnzTIw961M3EiY5XSa5ke9qtgtG80HJQyClK0qiFq5B+m4O9sZIql62s
	xSla47eugTRO8cet5NT/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701723427; x=
	1701730627; bh=9Zj48xwH3RKj/ArgA1aCuMUGNgo6h0Y1fWoiEhljy1A=; b=h
	A9LeaKxKwqWVu3TTqKfQeBpC/Bcs75pl9s20RcGpHsDQ2Hq75t4QeT6RuAXfo9Yb
	SNo8Kwgs9YqY609+nbgoIqIvAfFrBkSGOoGGBiMs5xRe1QyC7b5ii0+hQJjjpE1K
	S1mosax2Y9pJtBt4ojIvd1s/4Vst87ikhBLQwLi282kQBxmP2oWKtlTwAhHiyE0J
	XIFp+zgbGPyf2Cvs6iVJysg3P0i83K09/jC0gCJZtz+8tt5awUL2Ol28vpy/QQlD
	Gx3As31z6/8MrA65EKx7ffcgAoFbWMWvIr6bI8EFjg8B/QQ7oKCr39YpfSHTiSl5
	d1gKbaLT6vcTQAQTA/sKg==
X-ME-Sender: <xms:Iz1uZSsxlgir7JwxNecurIdP9uao28xb5D3N7KtVWBj7lF3Jzc_pYA>
    <xme:Iz1uZXetuX0fg4XNTtFSCXYV-NK6QOspIG3pDzv_fhSEE_xCCZ1--bHWntX4EqRco
    LvIklzCwPMfYdx3pw>
X-ME-Received: <xmr:Iz1uZdwd_GzvNTPzQxrfS-5irLub7IMoZ-YH6yKVCkcdJdjXb9dMJyzCUWMSRuOa3gC8XFRQNLmzhaFt64hAAu8JeJGsfhtoBigV9wQwqDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Iz1uZdPK332aFU7j4wTFHikA9nHICsAm2WC6Ov5ePPRspUa2GVONFw>
    <xmx:Iz1uZS-yStlNBmwBkhoRLZPCmyjWfM7PtJw_UEfFrTvHyf846jDeAA>
    <xmx:Iz1uZVW0HidpyzTH4HiMr5qJ0eixPioCShbEDgImzkEbp-swsbVYkg>
    <xmx:Iz1uZVdsWyBHbMkwR22m39D7Ngma2OlpdjDGzR0fxWY3tVMcss3ENA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 15:57:05 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	shuah@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
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
Subject: [PATCH bpf-next v4 08/10] bpf: selftests: test_tunnel: Use vmlinux.h declarations
Date: Mon,  4 Dec 2023 13:56:28 -0700
Message-ID: <325a9b767f4e0c2acf2f66dafd3e16d560f760de.1701722991.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701722991.git.dxu@dxuuu.xyz>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
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


