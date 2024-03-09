Return-Path: <linux-kselftest+bounces-6141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5329B8771EA
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 16:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6658B281AC0
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BAA4437C;
	Sat,  9 Mar 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUdTYmhj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A751E894;
	Sat,  9 Mar 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709998163; cv=none; b=KM+VpIKYWzw+qM6JTjxPIfq1k4l43uXYpuLYfNqk026r+5U6xoUM+YCIm8BDZgW+mSLySuMRiwzVm+B744ZItDTWfSr6FWMvgJODxmpvTYo+rVV6wFRPa3W1BzqKiVNwiukwkJf6Db5kbpGX667PQOTXrDVuoBXfVwCnZ94L4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709998163; c=relaxed/simple;
	bh=Bg80MTqXmXFKya5DEXpQUBqfaQKWyW8qK1fha3wwP9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qeb/G1RHASZ5vnizdagzMnzpOV/u/A33OYpf6xOXcVoB3ePQir3kBjvjnJLA0cWnQE9df/3TLe34NRvQxYh5tTnX9Y3BguOKrn7RxeoKh2t4pA8bAXUPoDOZfmz2FROj8SQtgQL1w8eAL6e2Sib4otmMWgt2Ii1+uPFv4i45DGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUdTYmhj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-413175397f0so11914015e9.1;
        Sat, 09 Mar 2024 07:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709998158; x=1710602958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPsdQIc+G1Px8xK2mWrNXT6TSPP8fbERJJ5PETv30YI=;
        b=MUdTYmhj7tpmYo0ljIzBFHm6muHp54vFXC2HSLm7Kq8sG6dxaXoApmNLqeXXNNWCBC
         CKhKvCit8jsn8PlkZwyxoSGuGR8SbOFq5g/lk0UkVnati7eQfdce44OdLbUgJXao9nht
         8rC80EX27+ij3Ew6OHD79TnnZXlQuAkYCLNfYvAb8D6am3IiBDywW2Lgz4+gT73XCjU4
         1jeQFJuJXNp9EhRaf0+zS7RPC1fumZMxG8VZDFNxp1rDPLjEL16Qp/5BkVRP284jmA53
         UnGafXFLBb3zk5ACUOH0dZ55p9oA6dZve2WzbFTNJL+65J5Uh7jLeCijegmJU2eawEcl
         zmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709998158; x=1710602958;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VPsdQIc+G1Px8xK2mWrNXT6TSPP8fbERJJ5PETv30YI=;
        b=MH4mi45QQ1fO3rHy+bcAfOB3tuxtF39/IPxXz64mzTE42BKIZmRpzj2spFpdfxU+B2
         r1qflDR2G2McYyE1RLW9xfpN462/a/dRR/oETj8Lrn5uDuzPXZnIy45nAlIobWMCh1ft
         yfIq8nn96X/ICgqGPb3Ce7B4XuL2h4I2vCbLMzvg34dyc08Cw5ao5uoLb1I3sA1X3jS3
         FD/c/bXgpGOLh0oGVxDcmJe2007QOwuntoa1Ob9tq7PBV1JTM1Nn3WImyjADn+OovCGv
         5ZgYgJpDXJ3sM35tySya4o36enNg7MEd6OCjmW6JPgB6O595VHFARMoQ+CQYIx35ksLE
         +qzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoYQP+43VCgzqy+P5vsNK9nPRzdqddyi8AWNWSMlH84yFU5kGZrJkOmDGrdG+f44dczRNe5JMKb4sqNTS7nZn/QS60NFY5jrbvJiYuxyzvEEfp7dTara1KNvK71aM7QgTNEXT8TNEv6kIDq+z6Ep755hqo0bF0Fu45Ou1cZp6YSnelsSbW
X-Gm-Message-State: AOJu0YzJTCxc7qpsc45URLVNfs8EA7CFhFOp+J3PQg/EjB0uRF/0I3tu
	hJzpVWNZxLMv7EAwBA17fDGqqthQEp+2+V/2OtNucQ7eCcFzvYI0
X-Google-Smtp-Source: AGHT+IETG6LGqtLQV2VULazhmjK5O7yxcR5bjQUQEaflXWXITCLjRcOpWgnndfNWCqanWmk6rzBQZA==
X-Received: by 2002:a05:600c:4fcf:b0:412:f098:dd64 with SMTP id o15-20020a05600c4fcf00b00412f098dd64mr1616250wmq.28.1709998158323;
        Sat, 09 Mar 2024 07:29:18 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id bw4-20020a0560001f8400b0033e2777f313sm2075195wrb.72.2024.03.09.07.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 07:29:17 -0800 (PST)
Message-ID: <b939cc50-fffa-40fe-847a-e2bbe0dadb60@gmail.com>
Date: Sat, 9 Mar 2024 16:29:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v3 1/4] net: gro: add p_off param in *_gro_complete
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 xeb@mail.ru, shuah@kernel.org, idosch@nvidia.com, razor@blackwall.org,
 amcohen@nvidia.com, petrm@nvidia.com, jbenc@redhat.com, bpoirier@nvidia.com,
 b.galvani@gmail.com, gavinl@nvidia.com, liujian56@huawei.com,
 horms@kernel.org, linyunsheng@huawei.com, therbert@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("udp:
additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in the
complete phase of gro. The functions always return skb->network_header,
which in the case of encapsulated packets at the gro complete phase, is
always set to the innermost L3 of the packet. That means that calling
{ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
gro_list and *_gro_complete) when parsing an encapsulated packet's _outer_
L3/L4 may return an unexpected value.

This incorrect usage leads to a bug in GRO's UDP socket lookup.
udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
*_hdr functions return network_header which will point to the innermost L3,
resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
encapsulated packets.

To fix this issue p_off param is used in *_gro_complete to pass off the
offset of the previous layer.

Reproduction example:

Endpoint configuration example (fou + local address bind)

    # ip fou add port 6666 ipproto 4
    # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap fou encap-dport 5555 encap-sport 6666 mode ipip
    # ip link set tun1 up
    # ip a add 1.1.1.2/24 dev tun1

Netperf TCP_STREAM result on net-next before patch is applied:

net-next main, GRO enabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.28        2.37

net-next main, GRO disabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.01     2745.06

patch applied, GRO enabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.01     2877.38

Fixes: 57c67ff4bd92 ("udp: additional GRO support")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 drivers/net/geneve.c           |  7 ++++---
 drivers/net/vxlan/vxlan_core.c | 11 +++++++----
 include/linux/etherdevice.h    |  2 +-
 include/linux/netdevice.h      |  3 ++-
 include/linux/udp.h            |  2 +-
 include/net/gro.h              | 11 ++++++-----
 include/net/inet_common.h      |  2 +-
 include/net/tcp.h              |  6 ++++--
 include/net/udp.h              |  8 ++++----
 include/net/udp_tunnel.h       |  2 +-
 net/8021q/vlan_core.c          |  4 ++--
 net/core/gro.c                 |  2 +-
 net/ethernet/eth.c             |  4 ++--
 net/ipv4/af_inet.c             |  8 ++++----
 net/ipv4/fou_core.c            |  9 +++++----
 net/ipv4/gre_offload.c         |  5 +++--
 net/ipv4/tcp_offload.c         |  7 ++++---
 net/ipv4/udp.c                 |  3 ++-
 net/ipv4/udp_offload.c         | 26 ++++++++++++++------------
 net/ipv6/ip6_offload.c         | 22 ++++++++++++----------
 net/ipv6/tcpv6_offload.c       |  7 ++++---
 net/ipv6/udp.c                 |  3 ++-
 net/ipv6/udp_offload.c         | 13 +++++++------
 23 files changed, 93 insertions(+), 74 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index e25e0a31126c..75837b3fb2d3 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -546,7 +546,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 }
 
 static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
-			       int nhoff)
+			       int p_off, int nhoff)
 {
 	struct genevehdr *gh;
 	struct packet_offload *ptype;
@@ -560,11 +560,12 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 
 	/* since skb->encapsulation is set, eth_gro_complete() sets the inner mac header */
 	if (likely(type == htons(ETH_P_TEB)))
-		return eth_gro_complete(skb, nhoff + gh_len);
+		return eth_gro_complete(skb, p_off, nhoff + gh_len);
 
 	ptype = gro_find_complete_by_type(type);
 	if (ptype)
-		err = ptype->callbacks.gro_complete(skb, nhoff + gh_len);
+		err = ptype->callbacks.gro_complete(skb, p_off,
+			nhoff + gh_len);
 
 	skb_set_inner_mac_header(skb, nhoff + gh_len);
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 386cbe4d3327..84c123405b70 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -767,15 +767,17 @@ static struct sk_buff *vxlan_gpe_gro_receive(struct sock *sk,
 	return pp;
 }
 
-static int vxlan_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
+static int vxlan_gro_complete(struct sock *sk, struct sk_buff *skb,
+			      int p_off, int nhoff)
 {
 	/* Sets 'skb->inner_mac_header' since we are always called with
 	 * 'skb->encapsulation' set.
 	 */
-	return eth_gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
+	return eth_gro_complete(skb, p_off, nhoff + sizeof(struct vxlanhdr));
 }
 
-static int vxlan_gpe_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
+static int vxlan_gpe_gro_complete(struct sock *sk, struct sk_buff *skb,
+				  int p_off, int nhoff)
 {
 	struct vxlanhdr *vh = (struct vxlanhdr *)(skb->data + nhoff);
 	const struct packet_offload *ptype;
@@ -786,7 +788,8 @@ static int vxlan_gpe_gro_complete(struct sock *sk, struct sk_buff *skb, int nhof
 		return err;
 	ptype = gro_find_complete_by_type(protocol);
 	if (ptype)
-		err = ptype->callbacks.gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
+		err = ptype->callbacks.gro_complete(skb, p_off, nhoff +
+						    sizeof(struct vxlanhdr));
 	return err;
 }
 
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 224645f17c33..b081b43d9686 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -64,7 +64,7 @@ struct net_device *devm_alloc_etherdev_mqs(struct device *dev, int sizeof_priv,
 #define devm_alloc_etherdev(dev, sizeof_priv) devm_alloc_etherdev_mqs(dev, sizeof_priv, 1, 1)
 
 struct sk_buff *eth_gro_receive(struct list_head *head, struct sk_buff *skb);
-int eth_gro_complete(struct sk_buff *skb, int nhoff);
+int eth_gro_complete(struct sk_buff *skb, int p_off, int nhoff);
 
 /* Reserved Ethernet Addresses per IEEE 802.1Q */
 static const u8 eth_reserved_addr_base[ETH_ALEN] __aligned(2) =
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c41019f34179..5a7049f83e41 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2788,7 +2788,8 @@ struct offload_callbacks {
 						netdev_features_t features);
 	struct sk_buff		*(*gro_receive)(struct list_head *head,
 						struct sk_buff *skb);
-	int			(*gro_complete)(struct sk_buff *skb, int nhoff);
+	int			(*gro_complete)(struct sk_buff *skb, int nhoff,
+						int thoff);
 };
 
 struct packet_offload {
diff --git a/include/linux/udp.h b/include/linux/udp.h
index 3748e82b627b..a04d94a3b42f 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -82,7 +82,7 @@ struct udp_sock {
 					       struct sk_buff *skb);
 	int			(*gro_complete)(struct sock *sk,
 						struct sk_buff *skb,
-						int nhoff);
+						int nhoff, int thoff);
 
 	/* udp_recvmsg try to use this before splicing sk_receive_queue */
 	struct sk_buff_head	reader_queue ____cacheline_aligned_in_smp;
diff --git a/include/net/gro.h b/include/net/gro.h
index 2b58671a6549..cb7282bf3d63 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -382,18 +382,18 @@ static inline void skb_gro_flush_final_remcsum(struct sk_buff *skb,
 
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *ipv6_gro_receive(struct list_head *,
 							   struct sk_buff *));
-INDIRECT_CALLABLE_DECLARE(int ipv6_gro_complete(struct sk_buff *, int));
+INDIRECT_CALLABLE_DECLARE(int ipv6_gro_complete(struct sk_buff *, int, int));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *inet_gro_receive(struct list_head *,
 							   struct sk_buff *));
-INDIRECT_CALLABLE_DECLARE(int inet_gro_complete(struct sk_buff *, int));
+INDIRECT_CALLABLE_DECLARE(int inet_gro_complete(struct sk_buff *, int, int));
 
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *udp4_gro_receive(struct list_head *,
 							   struct sk_buff *));
-INDIRECT_CALLABLE_DECLARE(int udp4_gro_complete(struct sk_buff *, int));
+INDIRECT_CALLABLE_DECLARE(int udp4_gro_complete(struct sk_buff *, int, int));
 
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *udp6_gro_receive(struct list_head *,
 							   struct sk_buff *));
-INDIRECT_CALLABLE_DECLARE(int udp6_gro_complete(struct sk_buff *, int));
+INDIRECT_CALLABLE_DECLARE(int udp6_gro_complete(struct sk_buff *, int, int));
 
 #define indirect_call_gro_receive_inet(cb, f2, f1, head, skb)	\
 ({								\
@@ -404,7 +404,8 @@ INDIRECT_CALLABLE_DECLARE(int udp6_gro_complete(struct sk_buff *, int));
 
 struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 				struct udphdr *uh, struct sock *sk);
-int udp_gro_complete(struct sk_buff *skb, int nhoff, udp_lookup_t lookup);
+int udp_gro_complete(struct sk_buff *skb, int nhoff, int thoff,
+		     udp_lookup_t lookup);
 
 static inline struct udphdr *udp_gro_udphdr(struct sk_buff *skb)
 {
diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index f50a644d87a9..605f917c830c 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -64,7 +64,7 @@ int inet_recv_error(struct sock *sk, struct msghdr *msg, int len,
 		    int *addr_len);
 
 struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb);
-int inet_gro_complete(struct sk_buff *skb, int nhoff);
+int inet_gro_complete(struct sk_buff *skb, int nhoff, int thoff);
 struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 				 netdev_features_t features);
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6ae35199d3b3..f36f15b6fb49 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2196,9 +2196,11 @@ void tcp_v4_destroy_sock(struct sock *sk);
 struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 				netdev_features_t features);
 struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb);
-INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb, int thoff));
+INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb, int nhoff,
+						int thoff));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb));
-INDIRECT_CALLABLE_DECLARE(int tcp6_gro_complete(struct sk_buff *skb, int thoff));
+INDIRECT_CALLABLE_DECLARE(int tcp6_gro_complete(struct sk_buff *skb, int nhoff,
+						int thoff));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb));
 #ifdef CONFIG_INET
 void tcp_gro_complete(struct sk_buff *skb);
diff --git a/include/net/udp.h b/include/net/udp.h
index 488a6d2babcc..601d1c3b677a 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -166,8 +166,8 @@ static inline void udp_csum_pull_header(struct sk_buff *skb)
 	UDP_SKB_CB(skb)->cscov -= sizeof(struct udphdr);
 }
 
-typedef struct sock *(*udp_lookup_t)(const struct sk_buff *skb, __be16 sport,
-				     __be16 dport);
+typedef struct sock *(*udp_lookup_t)(const struct sk_buff *skb, int nhoff,
+				     __be16 sport, __be16 dport);
 
 void udp_v6_early_demux(struct sk_buff *skb);
 INDIRECT_CALLABLE_DECLARE(int udpv6_rcv(struct sk_buff *));
@@ -301,7 +301,7 @@ struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
 struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
 			       __be32 daddr, __be16 dport, int dif, int sdif,
 			       struct udp_table *tbl, struct sk_buff *skb);
-struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
+struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb, int nhoff,
 				 __be16 sport, __be16 dport);
 struct sock *udp6_lib_lookup(struct net *net,
 			     const struct in6_addr *saddr, __be16 sport,
@@ -312,7 +312,7 @@ struct sock *__udp6_lib_lookup(struct net *net,
 			       const struct in6_addr *daddr, __be16 dport,
 			       int dif, int sdif, struct udp_table *tbl,
 			       struct sk_buff *skb);
-struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
+struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb, int nhoff,
 				 __be16 sport, __be16 dport);
 int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index d716214fe03d..a641392e70b0 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -75,7 +75,7 @@ typedef struct sk_buff *(*udp_tunnel_gro_receive_t)(struct sock *sk,
 						    struct list_head *head,
 						    struct sk_buff *skb);
 typedef int (*udp_tunnel_gro_complete_t)(struct sock *sk, struct sk_buff *skb,
-					 int nhoff);
+					 int nhoff, int thoff);
 
 struct udp_tunnel_sock_cfg {
 	void *sk_user_data;     /* user data used by encap_rcv call back */
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index f00158234505..247704cf70af 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -510,7 +510,7 @@ static struct sk_buff *vlan_gro_receive(struct list_head *head,
 	return pp;
 }
 
-static int vlan_gro_complete(struct sk_buff *skb, int nhoff)
+static int vlan_gro_complete(struct sk_buff *skb, int p_off, int nhoff)
 {
 	struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data + nhoff);
 	__be16 type = vhdr->h_vlan_encapsulated_proto;
@@ -521,7 +521,7 @@ static int vlan_gro_complete(struct sk_buff *skb, int nhoff)
 	if (ptype)
 		err = INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
 					 ipv6_gro_complete, inet_gro_complete,
-					 skb, nhoff + sizeof(*vhdr));
+					 skb, p_off, nhoff + sizeof(*vhdr));
 
 	return err;
 }
diff --git a/net/core/gro.c b/net/core/gro.c
index 6a0edbd826a1..7da3df2c634f 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -254,7 +254,7 @@ static void napi_gro_complete(struct napi_struct *napi, struct sk_buff *skb)
 
 		err = INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
 					 ipv6_gro_complete, inet_gro_complete,
-					 skb, 0);
+					 skb, 0, 0);
 		break;
 	}
 	rcu_read_unlock();
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 2edc8b796a4e..7515e6bcbb7d 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -453,7 +453,7 @@ struct sk_buff *eth_gro_receive(struct list_head *head, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(eth_gro_receive);
 
-int eth_gro_complete(struct sk_buff *skb, int nhoff)
+int eth_gro_complete(struct sk_buff *skb, int p_off, int nhoff)
 {
 	struct ethhdr *eh = (struct ethhdr *)(skb->data + nhoff);
 	__be16 type = eh->h_proto;
@@ -467,7 +467,7 @@ int eth_gro_complete(struct sk_buff *skb, int nhoff)
 	if (ptype != NULL)
 		err = INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
 					 ipv6_gro_complete, inet_gro_complete,
-					 skb, nhoff + sizeof(*eh));
+					 skb, p_off, nhoff + sizeof(*eh));
 
 	return err;
 }
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 5daebdcbca32..9334b563a88b 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1640,7 +1640,7 @@ int inet_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 }
 EXPORT_SYMBOL(inet_recv_error);
 
-int inet_gro_complete(struct sk_buff *skb, int nhoff)
+int inet_gro_complete(struct sk_buff *skb, int prior_off, int nhoff)
 {
 	struct iphdr *iph = (struct iphdr *)(skb->data + nhoff);
 	const struct net_offload *ops;
@@ -1666,17 +1666,17 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
 	 */
 	err = INDIRECT_CALL_2(ops->callbacks.gro_complete,
 			      tcp4_gro_complete, udp4_gro_complete,
-			      skb, nhoff + sizeof(*iph));
+				  skb, nhoff, nhoff + sizeof(*iph));
 
 out:
 	return err;
 }
 
-static int ipip_gro_complete(struct sk_buff *skb, int nhoff)
+static int ipip_gro_complete(struct sk_buff *skb, int prior_off, int nhoff)
 {
 	skb->encapsulation = 1;
 	skb_shinfo(skb)->gso_type |= SKB_GSO_IPXIP4;
-	return inet_gro_complete(skb, nhoff);
+	return inet_gro_complete(skb, prior_off, nhoff);
 }
 
 int inet_ctl_sock_create(struct sock **sk, unsigned short family,
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index a8494f796dca..7cf214d0b96d 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -260,7 +260,7 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 }
 
 static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
-			    int nhoff)
+			    int p_off, int nhoff)
 {
 	const struct net_offload __rcu **offloads;
 	u8 proto = fou_from_sock(sk)->protocol;
@@ -272,7 +272,7 @@ static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
 		goto out;
 
-	err = ops->callbacks.gro_complete(skb, nhoff);
+	err = ops->callbacks.gro_complete(skb, p_off, nhoff);
 
 	skb_set_inner_mac_header(skb, nhoff);
 
@@ -445,7 +445,8 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 	return pp;
 }
 
-static int gue_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
+static int gue_gro_complete(struct sock *sk, struct sk_buff *skb,
+			    int p_off, int nhoff)
 {
 	struct guehdr *guehdr = (struct guehdr *)(skb->data + nhoff);
 	const struct net_offload __rcu **offloads;
@@ -480,7 +481,7 @@ static int gue_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
 		goto out;
 
-	err = ops->callbacks.gro_complete(skb, nhoff + guehlen);
+	err = ops->callbacks.gro_complete(skb, p_off, nhoff + guehlen);
 
 	skb_set_inner_mac_header(skb, nhoff + guehlen);
 
diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
index 5028c72d494a..d4520c3f7c09 100644
--- a/net/ipv4/gre_offload.c
+++ b/net/ipv4/gre_offload.c
@@ -233,7 +233,7 @@ static struct sk_buff *gre_gro_receive(struct list_head *head,
 	return pp;
 }
 
-static int gre_gro_complete(struct sk_buff *skb, int nhoff)
+static int gre_gro_complete(struct sk_buff *skb, int p_off, int nhoff)
 {
 	struct gre_base_hdr *greh = (struct gre_base_hdr *)(skb->data + nhoff);
 	struct packet_offload *ptype;
@@ -253,7 +253,8 @@ static int gre_gro_complete(struct sk_buff *skb, int nhoff)
 
 	ptype = gro_find_complete_by_type(type);
 	if (ptype)
-		err = ptype->callbacks.gro_complete(skb, nhoff + grehlen);
+		err = ptype->callbacks.gro_complete(skb, p_off,
+			nhoff + grehlen);
 
 	skb_set_inner_mac_header(skb, nhoff + grehlen);
 
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index b955ab3b236d..fde800179b2e 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -330,10 +330,11 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 	return tcp_gro_receive(head, skb);
 }
 
-INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
+INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int nhoff,
+					      int thoff)
 {
-	const struct iphdr *iph = ip_hdr(skb);
-	struct tcphdr *th = tcp_hdr(skb);
+	const struct iphdr *iph = (const struct iphdr *)(skb->data + nhoff);
+	struct tcphdr *th = (struct tcphdr *)(skb->data + thoff);
 
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a8acea17b4e5..70a6d174855f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -532,9 +532,10 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
 }
 
 struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
+				 int nhoff,
 				 __be16 sport, __be16 dport)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const struct iphdr *iph = (const struct iphdr *)(skb->data + nhoff);
 	struct net *net = dev_net(skb->dev);
 	int iif, sdif;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 6c95d28d0c4a..cba615d52300 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -669,18 +669,19 @@ static int udp_gro_complete_segment(struct sk_buff *skb)
 	return 0;
 }
 
-int udp_gro_complete(struct sk_buff *skb, int nhoff,
+int udp_gro_complete(struct sk_buff *skb, int nhoff, int thoff,
 		     udp_lookup_t lookup)
 {
-	__be16 newlen = htons(skb->len - nhoff);
-	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
+	struct udphdr *uh = (struct udphdr *)(skb->data + thoff);
+	__be16 newlen = htons(skb->len - thoff);
 	struct sock *sk;
 	int err;
 
 	uh->len = newlen;
 
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
-				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
+				udp4_lib_lookup_skb, skb, nhoff, uh->source,
+				uh->dest);
 	if (sk && udp_sk(sk)->gro_complete) {
 		skb_shinfo(skb)->gso_type = uh->check ? SKB_GSO_UDP_TUNNEL_CSUM
 					: SKB_GSO_UDP_TUNNEL;
@@ -694,8 +695,8 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 		 * functions to make them set up the inner offsets.
 		 */
 		skb->encapsulation = 1;
-		err = udp_sk(sk)->gro_complete(sk, skb,
-				nhoff + sizeof(struct udphdr));
+		err = udp_sk(sk)->gro_complete(sk, skb, nhoff,
+					       thoff + sizeof(struct udphdr));
 	} else {
 		err = udp_gro_complete_segment(skb);
 	}
@@ -707,14 +708,15 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 }
 EXPORT_SYMBOL(udp_gro_complete);
 
-INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
+INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff,
+					      int thoff)
 {
-	const struct iphdr *iph = ip_hdr(skb);
-	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
+	const struct iphdr *iph = (const struct iphdr *)(skb->data + nhoff);
+	struct udphdr *uh = (struct udphdr *)(skb->data + thoff);
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		uh->len = htons(skb->len - nhoff);
+		uh->len = htons(skb->len - thoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
@@ -731,10 +733,10 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 	}
 
 	if (uh->check)
-		uh->check = ~udp_v4_check(skb->len - nhoff, iph->saddr,
+		uh->check = ~udp_v4_check(skb->len - thoff, iph->saddr,
 					  iph->daddr, 0);
 
-	return udp_gro_complete(skb, nhoff, udp4_lib_lookup_skb);
+	return udp_gro_complete(skb, nhoff, thoff, udp4_lib_lookup_skb);
 }
 
 static const struct net_offload udpv4_offload = {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index cca64c7809be..e3a05b84c76a 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -346,12 +346,14 @@ static struct sk_buff *ip4ip6_gro_receive(struct list_head *head,
 	return inet_gro_receive(head, skb);
 }
 
-INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
+INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb,
+					      int p_off, int nhoff)
 {
 	const struct net_offload *ops;
 	struct ipv6hdr *iph;
 	int err = -ENOSYS;
 	u32 payload_len;
+	int nhlen;
 
 	if (skb->encapsulation) {
 		skb_set_inner_protocol(skb, cpu_to_be16(ETH_P_IPV6));
@@ -387,36 +389,36 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 		iph->payload_len = htons(payload_len);
 	}
 
-	nhoff += sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
-	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
+	nhlen = sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
+	if (WARN_ON_ONCE(!ops || !ops->callbacks.gro_complete))
 		goto out;
 
 	err = INDIRECT_CALL_L4(ops->callbacks.gro_complete, tcp6_gro_complete,
-			       udp6_gro_complete, skb, nhoff);
+			       udp6_gro_complete, skb, nhoff, nhoff + nhlen);
 
 out:
 	return err;
 }
 
-static int sit_gro_complete(struct sk_buff *skb, int nhoff)
+static int sit_gro_complete(struct sk_buff *skb, int p_off, int nhoff)
 {
 	skb->encapsulation = 1;
 	skb_shinfo(skb)->gso_type |= SKB_GSO_IPXIP4;
-	return ipv6_gro_complete(skb, nhoff);
+	return ipv6_gro_complete(skb, p_off, nhoff);
 }
 
-static int ip6ip6_gro_complete(struct sk_buff *skb, int nhoff)
+static int ip6ip6_gro_complete(struct sk_buff *skb, int p_off, int nhoff)
 {
 	skb->encapsulation = 1;
 	skb_shinfo(skb)->gso_type |= SKB_GSO_IPXIP6;
-	return ipv6_gro_complete(skb, nhoff);
+	return ipv6_gro_complete(skb, p_off, nhoff);
 }
 
-static int ip4ip6_gro_complete(struct sk_buff *skb, int nhoff)
+static int ip4ip6_gro_complete(struct sk_buff *skb, int p_off, int nhoff)
 {
 	skb->encapsulation = 1;
 	skb_shinfo(skb)->gso_type |= SKB_GSO_IPXIP6;
-	return inet_gro_complete(skb, nhoff);
+	return inet_gro_complete(skb, p_off, nhoff);
 }
 
 static struct packet_offload ipv6_packet_offload __read_mostly = {
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index bf0c957e4b5e..5043d2ff34eb 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -27,10 +27,11 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 	return tcp_gro_receive(head, skb);
 }
 
-INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
+INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb,
+					      int nhoff, int thoff)
 {
-	const struct ipv6hdr *iph = ipv6_hdr(skb);
-	struct tcphdr *th = tcp_hdr(skb);
+	const struct ipv6hdr *iph = (const struct ipv6hdr *)(skb->data + nhoff);
+	struct tcphdr *th = (struct tcphdr *)(skb->data + thoff);
 
 	th->check = ~tcp_v6_check(skb->len - thoff, &iph->saddr,
 				  &iph->daddr, 0);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3f2249b4cd5f..400243c89d82 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -273,9 +273,10 @@ static struct sock *__udp6_lib_lookup_skb(struct sk_buff *skb,
 }
 
 struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
+				 int nhoff,
 				 __be16 sport, __be16 dport)
 {
-	const struct ipv6hdr *iph = ipv6_hdr(skb);
+	const struct ipv6hdr *iph = (const struct ipv6hdr *)(skb->data + nhoff);
 	struct net *net = dev_net(skb->dev);
 	int iif, sdif;
 
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 6b95ba241ebe..f930efd27180 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -162,14 +162,15 @@ struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 	return NULL;
 }
 
-INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
+INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff,
+					      int thoff)
 {
-	const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
-	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
+	const struct ipv6hdr *ipv6h = (const struct ipv6hdr *)(skb->data + nhoff);
+	struct udphdr *uh = (struct udphdr *)(skb->data + thoff);
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		uh->len = htons(skb->len - nhoff);
+		uh->len = htons(skb->len - thoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
@@ -186,10 +187,10 @@ INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 	}
 
 	if (uh->check)
-		uh->check = ~udp_v6_check(skb->len - nhoff, &ipv6h->saddr,
+		uh->check = ~udp_v6_check(skb->len - thoff, &ipv6h->saddr,
 					  &ipv6h->daddr, 0);
 
-	return udp_gro_complete(skb, nhoff, udp6_lib_lookup_skb);
+	return udp_gro_complete(skb, nhoff, thoff, udp6_lib_lookup_skb);
 }
 
 static const struct net_offload udpv6_offload = {
-- 
2.36.1

