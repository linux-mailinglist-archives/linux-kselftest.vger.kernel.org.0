Return-Path: <linux-kselftest+bounces-1612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3018680DB7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 21:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C421FB21592
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 20:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998CC54F80;
	Mon, 11 Dec 2023 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="SKyip/e4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bSwbgW8d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E72DF1;
	Mon, 11 Dec 2023 12:20:45 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.nyi.internal (Postfix) with ESMTP id 0C4CB58095D;
	Mon, 11 Dec 2023 15:20:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 11 Dec 2023 15:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1702326045; x=
	1702333245; bh=9Zj48xwH3RKj/ArgA1aCuMUGNgo6h0Y1fWoiEhljy1A=; b=S
	Kyip/e4Cp0oZnleaL+k3YnUYEeGktOr5IxxUgX1luEZ5CxOZstwiFl5xsbmtcbpD
	xKfFXUxjhfS8iF9dWzvLCV+DJZUx8WswvW5oh/DSjZ+v15pSRdjqLpKskxS3dlRA
	F27oXmmdE7BgTSVykUHB5s1yZUAxmQaGmeK4Wdhm3AXQaPjSsWVwJv/I/rL9tDCP
	kj+bi+kfxsw5FUwji2JH/o1t1s/eCx+L0WssbZbsypoE0CVeMwzyclJFo4vnVvSL
	EFw/PySoG5wcbbKOpBNgJ/G6CUy4UC1Hi0lQp6kh9Zq6ov4rls4+S/X8swS9SWQL
	KaWAAS2vGPTdCm/2O4Glw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702326045; x=
	1702333245; bh=9Zj48xwH3RKj/ArgA1aCuMUGNgo6h0Y1fWoiEhljy1A=; b=b
	SwbgW8djABuVjpGYSkQKSGdcbuiIk/WTDGtKr2shHBk29Y5mMMMf5JhyN6vpW4sU
	PFFveOQ9o0/NsP8tc70sarx4fEWcme0VnJHscRMV1PDwJtdgSPk4V4qi+evxJFZd
	beJqCEFWMykqZikBsbM2BTVSupfj1G6Jj/whA42Z+e7+VvkA5ALBu9TQQNTb4JRB
	exW05keY21gs5JebKwouyzWwQoqVsELzdTKuOej8QWaeWE0JTFw/GOo2YGm9y35V
	QWyqChgEYG2AP74HWj8gxTpppucj16qsLAnR+3pYV83vODA4LTJus1hPtgYxTW0T
	r8ZauZ164XqdvkuN51ntg==
X-ME-Sender: <xms:HG93ZblmfMdZS9S9vxMMJedheX6BZb50eY26EwrLPbYffIBXYtRlDw>
    <xme:HG93Ze0OxBzFjW8NCMXOscarwqoQAE1kTx7p-JoaRyrikPCtLadOgE4SOmkt-1vRk
    yjAr-EGVxoFO07idw>
X-ME-Received: <xmr:HG93ZRqhv6QGawNvfkmoZz4YxBNZhUYWAL_oAtxlSk019qfN7D0iTSQFMA_yDTa-8P70MKstA_eD3q7PVLxxqVcPJV2crXZIsu6q-iIYjl8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:HG93ZTlgMKUogD0flIaGFwhfL8SV3ryVwTK2jYsCBq12dTGsPy5lyQ>
    <xmx:HG93ZZ3y2ypg96PGixWzrPcwPxb9gldETik8ontjJr0k04cXb3ocjA>
    <xmx:HG93ZSv3QSvE-5bMD-ByMV08TdRL9zrYG9-374FOo13J2eOqWh7EIA>
    <xmx:HW93ZY8ECWbzVhK1j2iPYFUmSc-dELVVvb3VfsowsEPCC4Pw23CbDA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:20:43 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	andrii@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v5 7/9] bpf: selftests: test_tunnel: Use vmlinux.h declarations
Date: Mon, 11 Dec 2023 13:20:11 -0700
Message-ID: <212243113688736de2633030807fbfbf700c75eb.1702325874.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702325874.git.dxu@dxuuu.xyz>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
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


