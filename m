Return-Path: <linux-kselftest+bounces-458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB927F4F48
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 19:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0301C20B11
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4E5ABB5;
	Wed, 22 Nov 2023 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="BFalt9Z/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KRc5j5oI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DD8A4;
	Wed, 22 Nov 2023 10:21:08 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.nyi.internal (Postfix) with ESMTP id EAAFC58055A;
	Wed, 22 Nov 2023 13:21:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 22 Nov 2023 13:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1700677267; x=
	1700684467; bh=WA5yo16lMwft5CPh1GKorx1eBd7zIhQykMs+an4tdPA=; b=B
	Falt9Z/i6QDvEudBODypdblGWf4C34f3e4zwjOAQAJYvtG3NBAW/lttl0hmKGUeG
	sNezz1XKkZ/AIymaW2ZFOfEkh4f18HNcUlXP8z1IW3mu40BXMl5gIqMnFisWpei5
	wCQzNtoPT9vhlBlv2zb22siDC1cy6H5QHW/6pmizxoUcxHx/sJaFWoxH/A5+XY6L
	BM9dL0enMkHhEhq3vtgYM1/BL4KdboEhM+yhErOu/H5eSMiAWBlv5cf33JMpwLlc
	kOc3Pvm1NSFrywV7RPM7Ckd6tBDjlVwVlrRPpbCF/hcpJ8ysFSRZDpSL7yZheKg/
	cNbCN7/tvbAhYzsZfa/kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700677267; x=
	1700684467; bh=WA5yo16lMwft5CPh1GKorx1eBd7zIhQykMs+an4tdPA=; b=K
	Rc5j5oIkr3tswv0HQiFshjicajn2sHsLWPsKJGIMQAJDgz2B1m2TsFTyzCNiPxI1
	9QLbTpjgW2vFhfRa5COk6mDiGCwTMrMBT+qc2amMJkpk4cXIfdabLJ2X2rIL3UKG
	cz3VlgBpHATCeysbLosMdm8hnV4JJpdOzAp4/kqKY0GIYHqyeMz2CQaid3OQkTH8
	RaDYAYcgaTaECpH0/l09+rok7/sg5A4a7OiWjjR7kcplE+cTZNOGTDRTWOT9Xgvm
	TwJR12Qn7tqtMW4nWNHJbS8bCrwbC8ZZccg8lf0SSUnCxs9IJLgIg5j80zFSt+5/
	nAERvz0dCSY6Huo37VJpQ==
X-ME-Sender: <xms:k0ZeZQsn2xP9wXPxvDwEKXrTI_PLkZwziWX5ARqBzqvfb6nj53JSrg>
    <xme:k0ZeZdedfSlwZSLehNjyDtUqAR-Pbre8KoVF3qdNka6Jkgx5YKyuGTUW3nL2heMs0
    WvKgOqazrHrkjvlUA>
X-ME-Received: <xmr:k0ZeZby233F7jLsWHs9eNDQE9_KaNC4GisfmY4F3wy2w0l0Y5p9wVYUo0pn4EcNHMLL_YZgUlcct55ZHRBaNxwIsUb7II4gTIxzHPvIC-WHAWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:k0ZeZTMioTyb-cmY7SVevCTVFyD2TbMpaH9lH3nD_1go2ch2SQfKvA>
    <xmx:k0ZeZQ8mnZIFD1M-tkXT6ajzgrqWa0AAEGi1lCNdB0_FV1WSGwsDgg>
    <xmx:k0ZeZbVK1TUoIxqOV_RjLs22cIazstoJJUlixQRx9qTJ9NZWFqGRoA>
    <xmx:k0ZeZbhHRMPrs8-fQRwJKnGtSpLEQOfj526ntuMoEdzoVtmTQ0MnxQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 13:21:06 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ast@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: [PATCH ipsec-next v1 5/7] bpf: selftests: test_tunnel: Use vmlinux.h declarations
Date: Wed, 22 Nov 2023 11:20:26 -0700
Message-ID: <c5f6a6686e1472e17014f5d015c8dacade9f053e.1700676682.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700676682.git.dxu@dxuuu.xyz>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmlinux.h declarations are more ergnomic, especially when working with
kfuncs. The uapi headers are often incomplete for kfunc definitions.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/progs/bpf_tracing_net.h     |  1 +
 .../selftests/bpf/progs/test_tunnel_kern.c    | 48 ++++---------------
 2 files changed, 9 insertions(+), 40 deletions(-)

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
index f66af753bbbb..3065a716544d 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -6,62 +6,30 @@
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
 struct vxlanhdr {
 	__be32 vx_flags;
 	__be32 vx_vni;
 } __attribute__((packed));
 
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
-- 
2.42.1


