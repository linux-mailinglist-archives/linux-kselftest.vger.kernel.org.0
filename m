Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BE77DA0F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 20:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346580AbjJ0SrZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 14:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346617AbjJ0Sq4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 14:46:56 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532B01B3;
        Fri, 27 Oct 2023 11:46:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E54B5C0206;
        Fri, 27 Oct 2023 14:46:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 14:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1698432408; x=
        1698518808; bh=cBgckGsvKO9J1GK/znjl6iHoBSLcZiVLBKbXHE7afz0=; b=Y
        jRCiU4V215Xa8DKjdZo2ika/BjTj4xklEkFzkgP93hYTijzwxkVXL9tF60nFe83W
        Qrn+W5Sj7xtT8E5/x/WUlHV+ddJPUFCcIdt4OTuq9j+F9CS5yahxs6UEwq8iqXik
        SGEHHURyAwnrJxYe3Kf9e+uwkaWTmlihnZ3jUBBUWlZ8usKt1CTf+BAHH3AV8nT6
        f63x4mEUAgW+mdf8h0VUtZsb+3L0j3BIhH+IVgS5QjVVmZqVv0YqbGuJ6M0HE3ZO
        igoWSJ1GSPW1+Ct1JIEexA11JqTPur9K9nAg3dfSXmDXbwfofgKWpbOgQ/ASMVDT
        ZvntYTRKuBU1tWSDbtT9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698432408; x=
        1698518808; bh=cBgckGsvKO9J1GK/znjl6iHoBSLcZiVLBKbXHE7afz0=; b=r
        9sLQcd/vGuZhTvGL4HgcjRmG5DXVLQMrZVMTs4gtWUaYMudPB408F2NQQVJt78L/
        KfQYuEXplYpv9ZlAqwNl7ofwcmC+rR1zW8tqknbb4o4qslFupVYwuNBTddQ1wYVi
        x9tL7GF05vyndB+xBkA67Ao0qj9iWpySLxFJC4p1kIExSawJUDuq0jWU2+TI4OJN
        3F0y2+l4ammfusvtHyWHrr0PgrD8yAAWzZgWOvxUlF5W6zZq/xDhNPgw7wMkMi1H
        50JTLd7LT/swuqxqlEWSUlT8qFfTmrL+TQITXviTZmCUiT2qi8GRxBQBkTTywueO
        fFpbRhZwNFbUAX8jY1c9Q==
X-ME-Sender: <xms:mAU8ZZ-Z1bOxDKBCWtbh8kAQCqs48tqQL5bMoMcRcjfR0OiEv5LUCg>
    <xme:mAU8ZdtegUI-vUq8LZd_aaZJ3B-t21qmRk_KXZ8yX9MIOfoS0SrXCO02V4Oy-QMBt
    lJunHOQO_hFEtkAJA>
X-ME-Received: <xmr:mAU8ZXB9kt-kJGQHmF3bXiNiwau133_kIwCQn1lXUqHIt_jcSyc4VWRUtZYN1-0HAgLe8tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:mAU8Zdd0NdYz3eZGZMM_rb8KfbtRvYsQLffrJD8U07uCfL7kFdfYTA>
    <xmx:mAU8ZeOtM6DoQNKQagm0CQ16MZPYGrb79UentwTMjAem5zoAW9ofTA>
    <xmx:mAU8ZfmXZUzxB-TYbJM9lG3j3zkWabIo86ycyiIHrUMwEUIOM1p3dw>
    <xmx:mAU8ZTzmHxfbvjmKtgTXHsfXSRFhWXCTIF5tGhCGjpH7jhHpweuHcw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 14:46:47 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     ast@kernel.org, andrii@kernel.org, shuah@kernel.org,
        daniel@iogearbox.net, steffen.klassert@secunet.com,
        antony.antony@secunet.com
Cc:     martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@linux-ipsec.org
Subject: [RFC bpf-next 4/6] bpf: selftests: test_tunnel: Use vmlinux.h declarations
Date:   Fri, 27 Oct 2023 12:46:20 -0600
Message-ID: <15604344a2cf67a756eda4e37145fe46ce551afd.1698431765.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698431765.git.dxu@dxuuu.xyz>
References: <cover.1698431765.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

vmlinux.h declarations are more ergnomic, especially when working with
kfuncs. The uapi headers are often incomplete for kfunc definitions.

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
2.42.0

