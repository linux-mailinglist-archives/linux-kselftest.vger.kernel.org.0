Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6257DE7D3
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Nov 2023 22:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345653AbjKAV7H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Nov 2023 17:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345806AbjKAV7E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Nov 2023 17:59:04 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5861A12D;
        Wed,  1 Nov 2023 14:58:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2F7323200A03;
        Wed,  1 Nov 2023 17:58:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 01 Nov 2023 17:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1698875933; x=
        1698962333; bh=4K3+7JUL823xP8yUd0IsPnXRHUkyr4JkEUzAeBc61hI=; b=F
        599aGqxz5n1C3mdf4uxnJbPlrYY5aAqCyJRrQWKd5GWYHX2wNAQuYpr+7cirXkN2
        7nk7NLS9vAwUdAlzq7sCRpabbP/bCxM+5QRygryOwAlie3s1J4haLpVpoB387XAG
        NuvKN5s2wffsWRrWVgdQmvbi4BirjeyeztR1Xtx43wFZFbeHdSocVYXyDHol2JeK
        K4UbldVqNyhN4H4mv2XOfOwKHttUlusOsFsCk6D8K6RfXatCMukQPPr9ri84AMwQ
        +DyPL/iYMNnnXt8V+h1P2IxU7WMyRsC2JMxIOXK2dttd8Q3iWtNIdjrPs0p1YouK
        LFZJOdvRQVXw5F4tLq/xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698875933; x=
        1698962333; bh=4K3+7JUL823xP8yUd0IsPnXRHUkyr4JkEUzAeBc61hI=; b=F
        XgVsGpLPwRVgSFCZC+WPzUUlGsuI5m1+H0o8OaxdGj5rC9WlVi73Zmn13dIdZ0Le
        95nYDfN9Ekmgfm0lmup5+8kO22fTP8LYkM7wMlG7+31nCOvUlfKG69BNkaHvx0A3
        YPZPJegFnq/SQfknQXNAabLn8eR3pTQ9kjtp2ro1t5Ra+hqaiw/30LnC6xf9Zka4
        FcFeNUNWkAvl5S5mDgye4JtVu/YTnlXWC8Rb9K8pvBKrICvATvHe7mQRWR/lZhQ5
        cSsS0fz6we8bOPDmAXO0NF2/SD06ICpDOfXE5hZiOHS3J2Y77DzQ/uXfpN2E2c1N
        CcoNJKsG+8ADQf6JhbSgA==
X-ME-Sender: <xms:HcpCZZk4wY5VHOZodayU7nbj6YctlqRBM0tIXJMzuLi9F5Zn-4JLfw>
    <xme:HcpCZU2rIIRiKSnKZKoDDebV-wsrMaPOkMDuVYxBa2lR92K5rVdLSZmcpP7BoRQHC
    Up0YRnIOUKihmHaig>
X-ME-Received: <xmr:HcpCZfp1LESaEAruWXaiQsvzamK5YrJ4RjfCU9U7xNj8giQV9Hc4FWjeSSIgmhes6VpKiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:HcpCZZlDSMxBK8pgVZhFZmGGlCakOD09v03beBxC-0WRzy5eRMgL-Q>
    <xmx:HcpCZX0C0CLNPBAJdfFFXSx3S7MgpV8NIS-AQmbUDB-tAFypjYWoMw>
    <xmx:HcpCZYv57-b5whKOwBGMJSgRZ9JjGwSMCPjV8nRLIEjuTQgigOGoug>
    <xmx:HcpCZb5PfN1SHWyaC1XVpjkriGIfjMGslW5c-dk53aOtX5XzMZc6Bg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 17:58:50 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     daniel@iogearbox.net, shuah@kernel.org, ast@kernel.org,
        andrii@kernel.org, steffen.klassert@secunet.com,
        antony.antony@secunet.com
Cc:     martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@linux-ipsec.org
Subject: [RFCv2 bpf-next 5/7] bpf: selftests: test_tunnel: Use vmlinux.h declarations
Date:   Wed,  1 Nov 2023 14:57:49 -0700
Message-ID: <6c85ae9dab941364fa593168c0811f3ee4682de8.1698875025.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698875025.git.dxu@dxuuu.xyz>
References: <cover.1698875025.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
2.42.0

