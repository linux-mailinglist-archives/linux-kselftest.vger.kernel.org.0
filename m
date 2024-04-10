Return-Path: <linux-kselftest+bounces-7570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EA289FBB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43881C2229C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 15:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DECF16F0E0;
	Wed, 10 Apr 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW+YCPJp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CD16F0D8;
	Wed, 10 Apr 2024 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763329; cv=none; b=qheiA23TBmrz93fVCEc6dUrB8i0IwrvL/Q36+ZJXH/qYDBIiQH9f9kufrVaQo3v1xU5HdumkfnYkQk72/FjRUEFvLQ0G6zxltjY5zAKXlOlZk8nf/j9jxfTHC/UhNVPCa0zlTn7oumqQWQyt6991007pa5Qh/q4aAEzD4KuRCs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763329; c=relaxed/simple;
	bh=bjUcEut3WQ26NBLs6jb1FUz99Rz8McKWANPmfgo4mJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNXaaPhipi/fRjww9lU1P/wqKBLeRjadILO3OrYMjAToFBQlaepS3ChVNCSmQXzF0562JOUXcZzfhbZMSYVOG3qY+d//B9LSxvkDEp7ivcfG/WRZ/DHTB/5VwdM4XEg0Ac8TBemEMcp7q/Lq0ldyhrDijkL5gPU4Kl1h3ysgei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW+YCPJp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343eb6cc46bso3548011f8f.2;
        Wed, 10 Apr 2024 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712763325; x=1713368125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/7TjPxwoxAQbRrLaAjmIUiQ1mftYc30wuJsOkEmeZ8=;
        b=aW+YCPJpOODg7+g4/jb9VVfZQa+t2/meYITd/tt2DwFARHrCqPzBgFSpoV0e4WoxXC
         7bjkiEWP2fngU7jpBhRYE2hqLboj9ktbtZIaltdE5sc/mNB4JFUIZLz8VBbp39Bhlv73
         tw0rTO3HK6OhqXgXQSKekPMq3NT5lwtDoiXrYXzvZK1WRdc8TTx6Rt7iq+KAA8AP9rrW
         tWp+AB9oXdsDC7Tuq5G7KVo98e6b9yCbIl2QxnCHIJ0dFEMHGympt42WbQZ79jJfY+V3
         mPJ/B72tb2GkB/FeHzG+qgFbqrcjvC/gxvY+Ba3SrzXPhCtl1HxAs473ElQV1mz5Llva
         hZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763325; x=1713368125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/7TjPxwoxAQbRrLaAjmIUiQ1mftYc30wuJsOkEmeZ8=;
        b=KU9tIdqnwHkdEefobC9epbWYH8U2PIEN8mU9rzMT5FSjtAzcK/8rgiw32k5DvG+vYj
         xox9Yw7MdvNTnkB7nAyJfJBosMKD/OerwIjc3nFtB7ushCeTRJuZjm08ln2p+8VaeA3k
         42+JJWzTiSO+cF6hKGFjUDMuJ1ioS9o8FlDBK/v3t/vuP8HDgQYIZVmoBbs+SL0q/6gT
         fJCWq6SKmuty/xka0cIBMyltnWhUrG9RpEB19vSupqmk1O693nHnen/tzkjCuDm6efAC
         snudGYX15jtv5dR2ereOZ3xWbCkie+dMU/bxPOs03B0bIHoHyVlh0m3TWh5mrhryAN+H
         Gazw==
X-Forwarded-Encrypted: i=1; AJvYcCVwxz3WQze3+cJvFk8jDfKBJqU9vDw3o5D3ca0rezp5LKDAzK9k8UCrrZTLOCbe32uiA2Jk4DG6hepjBdzvBmJg8CAjy1aG4iJdhuxxlMtBRk+uGMi3UU6ei2o6wMt0N+mX5R0I6iSbDkdYl0ClHKMNWJKBI6doADt5l0rOEaKDIma4l6Ui
X-Gm-Message-State: AOJu0YzCunB9bCJWrFJSMQ627xNRKZPLpjnc+jmWJBQpOa2t5K0KgWvB
	6BeAu1LNH0j7o0Uop06zjHWTsGh2kJWSYfHdBjAM9I4IUHuJBbDa
X-Google-Smtp-Source: AGHT+IEmQcf/3ilqiJLz0QokNnzPAAoFBvkWZj3KUtAGJiBu4Ozp5gxrnbSoHJC30ab7mbd1CgCmug==
X-Received: by 2002:a5d:5185:0:b0:343:7cdc:458b with SMTP id k5-20020a5d5185000000b003437cdc458bmr2139759wrv.7.1712763324590;
        Wed, 10 Apr 2024 08:35:24 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d540c000000b00343f662327bsm12848738wrv.77.2024.04.10.08.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:35:24 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	dsahern@kernel.org,
	aduyck@mirantis.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v6 2/6] net: gro: add p_off param in *_gro_complete
Date: Wed, 10 Apr 2024 17:34:19 +0200
Message-Id: <20240410153423.107381-3-richardbgobert@gmail.com>
In-Reply-To: <20240410153423.107381-1-richardbgobert@gmail.com>
References: <20240410153423.107381-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 163f94a5a58f..9c18a39b0d0c 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -555,7 +555,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 }
 
 static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
-			       int nhoff)
+			       int p_off, int nhoff)
 {
 	struct genevehdr *gh;
 	struct packet_offload *ptype;
@@ -569,11 +569,12 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 
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
index 72ecf6cf809c..6fb182d9d6e7 100644
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
index d45f330d083d..daff430d4d26 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2710,7 +2710,8 @@ struct offload_callbacks {
 						netdev_features_t features);
 	struct sk_buff		*(*gro_receive)(struct list_head *head,
 						struct sk_buff *skb);
-	int			(*gro_complete)(struct sk_buff *skb, int nhoff);
+	int			(*gro_complete)(struct sk_buff *skb, int nhoff,
+						int thoff);
 };
 
 struct packet_offload {
diff --git a/include/linux/udp.h b/include/linux/udp.h
index 17539d089666..ffb6af9f9404 100644
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
index 50f1e403dbbb..ebead1d642b4 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -383,18 +383,18 @@ static inline void skb_gro_flush_final_remcsum(struct sk_buff *skb,
 
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
@@ -405,7 +405,8 @@ INDIRECT_CALLABLE_DECLARE(int udp6_gro_complete(struct sk_buff *, int));
 
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
index 9ab5b37e9d53..2dd45c1dfa7d 100644
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
index a93dc51f6323..ffedf2121532 100644
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
index 83f35d99a682..b129cd201937 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -252,7 +252,7 @@ static void napi_gro_complete(struct napi_struct *napi, struct sk_buff *skb)
 
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
index 55bd72997b31..5a747d91cd0a 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1641,7 +1641,7 @@ int inet_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 }
 EXPORT_SYMBOL(inet_recv_error);
 
-int inet_gro_complete(struct sk_buff *skb, int nhoff)
+int inet_gro_complete(struct sk_buff *skb, int prior_off, int nhoff)
 {
 	struct iphdr *iph = (struct iphdr *)(skb->data + nhoff);
 	const struct net_offload *ops;
@@ -1667,17 +1667,17 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
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
index fab0973f995b..7f045b881dd4 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -328,10 +328,11 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
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
index 7613daa339b0..2c7cea1cbd7e 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -530,9 +530,10 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
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
index 1f4e08f43c4b..ad4c88fe7d15 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -689,18 +689,19 @@ static int udp_gro_complete_segment(struct sk_buff *skb)
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
@@ -714,8 +715,8 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
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
@@ -727,14 +728,15 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
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
@@ -745,10 +747,10 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 	}
 
 	if (uh->check)
-		uh->check = ~udp_v4_check(skb->len - nhoff, iph->saddr,
+		uh->check = ~udp_v4_check(skb->len - thoff, iph->saddr,
 					  iph->daddr, 0);
 
-	return udp_gro_complete(skb, nhoff, udp4_lib_lookup_skb);
+	return udp_gro_complete(skb, nhoff, thoff, udp4_lib_lookup_skb);
 }
 
 int __init udpv4_offload_init(void)
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index b41e35af69ea..10ddbbc0e46d 100644
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
 
 
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 4b07d1e6c952..91a55372dcd4 100644
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
index a9466f881f1b..fac6b6cd36e9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -271,9 +271,10 @@ static struct sock *__udp6_lib_lookup_skb(struct sk_buff *skb,
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
index bbd347de00b4..078055665397 100644
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
@@ -180,10 +181,10 @@ INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 	}
 
 	if (uh->check)
-		uh->check = ~udp_v6_check(skb->len - nhoff, &ipv6h->saddr,
+		uh->check = ~udp_v6_check(skb->len - thoff, &ipv6h->saddr,
 					  &ipv6h->daddr, 0);
 
-	return udp_gro_complete(skb, nhoff, udp6_lib_lookup_skb);
+	return udp_gro_complete(skb, nhoff, thoff, udp6_lib_lookup_skb);
 }
 
 int __init udpv6_offload_init(void)
-- 
2.36.1


