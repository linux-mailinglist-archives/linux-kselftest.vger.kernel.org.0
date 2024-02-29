Return-Path: <linux-kselftest+bounces-5666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D616386D403
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 21:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6431F23F6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 20:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A813F45F;
	Thu, 29 Feb 2024 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psBgccYi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E613C9FE
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237750; cv=none; b=Lp9E60xyf0tUyuX/jO61Teu6aBe6L+zksMVkDhBEVgBFQr49Q790On2dz8W5NSJLYSvt3B28yfCwgTJRAnXvElO9yewWfdk83YMr45J5vHKYOdVbsnNQtynYzKGkPm3BCvC3CMZ9j+yHjMdWBCRg+3QUIKdHcOoMBgAIiOiTgoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237750; c=relaxed/simple;
	bh=Cdag8DU5L2fMkFCCYdGz/QNM0tII8V07y7M10a+9buY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Icy7qajCVpB7YZCGkJyOrSyJRWmKnVZsg3RJptZ6jt/XMWUu5OEy/4PedxUrBo37dNGW/OoBKxG7Rl6z/iSoZ2+AOaLb80kJv1xuMdAujHT08ogLyNsxG8cBnVLvh1rw063Iy5F3VGZSrPTx3UiH1taKvToddbEcn4htGhWKBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psBgccYi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4129a5f7b54so15995e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 12:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709237744; x=1709842544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsOjg42DWljDVgAvUHlYEw5Hy7w1zKaDp83BCUrYnD0=;
        b=psBgccYiCgY9FGMTyZbdbrzYupXaikWVgPnaVp/XUQxA1GKraZQeCup5ns9c7mrtmo
         TDYWP3/Ab4juxBpdSVbqgEWnX5rKRX8PasVZsoPKDr+bj0bmDjhBDPRBr8KR1NuJU3CX
         3gTXoM+FZmJl3uxtFzPjDihwbFdrUL/RZQ0B2A2dD+pL6gOhvlOwaq0tR6om0g2D3H8J
         IkI4Du9q4WqcBtJ4EYGGwLmfWfEOAwVt/iG++n+lImvddYRe7ol1j593UtovqA6fNG8L
         7wjGEeoNyjmPcJ4pXISoS72ja2o9nHdpFw5xgEQfOrHOBYZCnya3JmLchXUFIg0Mxh/R
         scrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709237744; x=1709842544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsOjg42DWljDVgAvUHlYEw5Hy7w1zKaDp83BCUrYnD0=;
        b=xNaUBMiSudQuwTxW2zS7cMjLhwINtCCXg/YhuLphwQPm+6+33xH1mIvzyHMIG/RLYx
         MsE5pDDE3+sd+4cf3w75ksMHKRGlOxpCYf2+XyMAsIqClriOhRsz6AiUcDcFRnhmPcf/
         KMNgNMV8fXX5kPdoIfGHCQWCLxV2FuobNusKpQDaU8E9p6pGRLuazzg8uYHE311qUnM+
         YXXTTcz4bMuLjAEdywSvrcCzruhTnEYgTR3pru8vBv6jX8+Yho8vngO+CWUTF3+biWRX
         KQU+K5E/kJso7JdIrX1VCb6QzRzeeM5m2bJE9Ey/sNWH5/ajcBPNuco3rbugnrGGu3d7
         q6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVRD/Mpj4Uc53hXppAWU5tlQa8vXChaEfZ3bxi32yMFvTTr7pG+jCJRI7uAOmbcFeDCWxb+vGRz88NqoaP+mD/45nW+KwQtrJkpYmzUSEzx
X-Gm-Message-State: AOJu0YznsCWp1eZUrMHlYyUKAciO7qlV4ejCeRyChp2AdLaNlEQyIrgC
	6+Kb32jloCMp2GJmvWBSglCYHmFzcFHxXd309vi/3pfKfPazpee07xis+1UBa3WuZNLRMGX4bBN
	qnCcJUmkBhkNeoRACMDkZOsyZh2+cPymaxH5X
X-Google-Smtp-Source: AGHT+IHNWC2ivq7xCMFVnwrLmw4hWGdLfOq7XmXIwF/KRAVIULRlzrYQfVexpp9J/HPrL/YkKNg6lFGOkvkyoPhprRw=
X-Received: by 2002:a05:600c:1e29:b0:412:c3a5:200e with SMTP id
 ay41-20020a05600c1e2900b00412c3a5200emr12669wmb.6.1709237744211; Thu, 29 Feb
 2024 12:15:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e1d22505-c5f8-4c02-a997-64248480338b@gmail.com>
 <446695cb-50b8-4187-bf11-63aedb6e9aed@gmail.com> <CANn89iJxCT0Bcmqjdd1kp4VCf5i3Me7yATsZXO7SkYTPQ9BOAA@mail.gmail.com>
 <a10b6d19-232c-4b6d-bd71-eb3451675f64@gmail.com>
In-Reply-To: <a10b6d19-232c-4b6d-bd71-eb3451675f64@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Feb 2024 21:15:30 +0100
Message-ID: <CANn89iK8rDOc14HMGMq=sw0zECcg88Mb=67044r_OA=mSh=xtQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: gro: set {inner_,}network_header in
 receive phase
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, shuah@kernel.org, liujian56@huawei.com, horms@kernel.org, 
	aleksander.lobakin@intel.com, linyunsheng@huawei.com, therbert@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:22=E2=80=AFPM Richard Gobert <richardbgobert@gmai=
l.com> wrote:
>
>
>
> Eric Dumazet wrote:
> >
> > My intuition is that this patch has a high cost for normal GRO processi=
ng.
> > SW-GRO is already a bottleneck on ARM cores in smart NICS.
> >
> > I would suggest instead using parameters to give both the nhoff and tho=
ff values
> > this would avoid many conditionals in the fast path.
> >
> > ->
> >
> > INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int
> > nhoff, int thoff)
> > {
> >  const struct ipv6hdr *ipv6h =3D (const struct ipv6hdr *)(skb->data + n=
hoff);
> >  struct udphdr *uh =3D (struct udphdr *)(skb->data + thoff);
> > ...
> > }
> >
> > INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int
> > nhoff, int thoff)
> > {
> >        const struct ipv6hdr *iph =3D  (const struct ipv6hdr *)(skb->dat=
a + nhoff);
> >        struct tcphdr *th =3D (struct tcphdr *)(skb->data + thoff);
> >
> > Why storing in skb fields things that really could be propagated more
> > efficiently as function parameters ?
>
> Hi Eric,
> Thanks for the review!
>
> I agree, the conditionals could be a problem and are actually not needed.
> The third commit in this patch series introduces an optimisation for
> ipv6/ipv4 using the correct {inner_}network_header. We can remove the
> conditionals; I thought about multiple ways to do so. First, remove the
> conditional in skb_gro_network_offset:
>
>     static inline int skb_gro_network_offset(const struct sk_buff *skb)
>     {
>         const u32 mask =3D NAPI_GRO_CB(skb)->encap_mark - 1;
>         return (skb_network_offset(skb) & mask) | (skb_inner_network_offs=
et(skb) & ~mask);
>     }

I was trying to say that we do not need all these helpers, storing
state in NAPI_GRO_CB(skb),
dirtying cache lines...

Ideally, the skb network/transport/... headers could be set at the
last stage, in gro_complete(big_gro_skb),
instead of doing this for each segment.

All the gro_receive() could be much faster by using additional
parameters (nhoff, thoff)

skb_gro_offset() could be replaced by the current offset (nhoff or
other name), passed as a parameter.

Here is a WIP for gro_complete() step, this looks large but this is
only adding a 2nd 'offset' parameter

Prior offset (typically network offset), called p_off
Old argument nhoff, (renamed thoff if that makes sense), pointing to
the current offset.



 drivers/net/geneve.c           |    6 +++---
 drivers/net/vxlan/vxlan_core.c |   11 +++++++----
 include/linux/etherdevice.h    |    2 +-
 include/linux/netdevice.h      |    2 +-
 include/linux/udp.h            |    2 +-
 include/net/gro.h              |   10 +++++-----
 include/net/inet_common.h      |    2 +-
 include/net/tcp.h              |    4 ++--
 include/net/udp.h              |    8 ++++----
 include/net/udp_tunnel.h       |    2 +-
 net/8021q/vlan_core.c          |    4 ++--
 net/core/gro.c                 |    2 +-
 net/ethernet/eth.c             |    4 ++--
 net/ipv4/af_inet.c             |    8 ++++----
 net/ipv4/fou_core.c            |    9 +++++----
 net/ipv4/gre_offload.c         |    4 ++--
 net/ipv4/tcp_offload.c         |    6 +++---
 net/ipv4/udp.c                 |    3 ++-
 net/ipv4/udp_offload.c         |   24 ++++++++++++------------
 net/ipv6/ip6_offload.c         |   22 ++++++++++++----------
 net/ipv6/tcpv6_offload.c       |    7 ++++---
 net/ipv6/udp.c                 |    3 ++-
 net/ipv6/udp_offload.c         |   12 ++++++------
 23 files changed, 83 insertions(+), 74 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 6f3f9b446b1d202f6c71a20ce48088691e9120bf..af8dfdd47ffdeb7bdea302c5957=
e81faf83b19db
100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -546,7 +546,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *=
sk,
 }

 static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
-                              int nhoff)
+                              int p_off, int nhoff)
 {
        struct genevehdr *gh;
        struct packet_offload *ptype;
@@ -560,11 +560,11 @@ static int geneve_gro_complete(struct sock *sk,
struct sk_buff *skb,

        /* since skb->encapsulation is set, eth_gro_complete() sets
the inner mac header */
        if (likely(type =3D=3D htons(ETH_P_TEB)))
-               return eth_gro_complete(skb, nhoff + gh_len);
+               return eth_gro_complete(skb, p_off, nhoff + gh_len);

        ptype =3D gro_find_complete_by_type(type);
        if (ptype)
-               err =3D ptype->callbacks.gro_complete(skb, nhoff + gh_len);
+               err =3D ptype->callbacks.gro_complete(skb, p_off, nhoff + g=
h_len);

        skb_set_inner_mac_header(skb, nhoff + gh_len);

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.=
c
index 386cbe4d33272791e80470bd1378731d0c3b4d3b..84c123405b70f986a40b9f531e8=
26807bcfc880b
100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -767,15 +767,17 @@ static struct sk_buff
*vxlan_gpe_gro_receive(struct sock *sk,
        return pp;
 }

-static int vxlan_gro_complete(struct sock *sk, struct sk_buff *skb, int nh=
off)
+static int vxlan_gro_complete(struct sock *sk, struct sk_buff *skb,
+                             int p_off, int nhoff)
 {
        /* Sets 'skb->inner_mac_header' since we are always called with
         * 'skb->encapsulation' set.
         */
-       return eth_gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
+       return eth_gro_complete(skb, p_off, nhoff + sizeof(struct vxlanhdr)=
);
 }

-static int vxlan_gpe_gro_complete(struct sock *sk, struct sk_buff
*skb, int nhoff)
+static int vxlan_gpe_gro_complete(struct sock *sk, struct sk_buff *skb,
+                                 int p_off, int nhoff)
 {
        struct vxlanhdr *vh =3D (struct vxlanhdr *)(skb->data + nhoff);
        const struct packet_offload *ptype;
@@ -786,7 +788,8 @@ static int vxlan_gpe_gro_complete(struct sock *sk,
struct sk_buff *skb, int nhof
                return err;
        ptype =3D gro_find_complete_by_type(protocol);
        if (ptype)
-               err =3D ptype->callbacks.gro_complete(skb, nhoff +
sizeof(struct vxlanhdr));
+               err =3D ptype->callbacks.gro_complete(skb, p_off, nhoff +
+                                                   sizeof(struct vxlanhdr)=
);
        return err;
 }

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 224645f17c333b2311573197a28b41701eb35f92..b081b43d9686a1f3b0ddc9d84e6=
6566e297a2d67
100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -64,7 +64,7 @@ struct net_device *devm_alloc_etherdev_mqs(struct
device *dev, int sizeof_priv,
 #define devm_alloc_etherdev(dev, sizeof_priv)
devm_alloc_etherdev_mqs(dev, sizeof_priv, 1, 1)

 struct sk_buff *eth_gro_receive(struct list_head *head, struct sk_buff *sk=
b);
-int eth_gro_complete(struct sk_buff *skb, int nhoff);
+int eth_gro_complete(struct sk_buff *skb, int p_off, int nhoff);

 /* Reserved Ethernet Addresses per IEEE 802.1Q */
 static const u8 eth_reserved_addr_base[ETH_ALEN] __aligned(2) =3D
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 09023e44db4e2c3a2133afc52ba5a335d6030646..b21745f6233a2b56a64adda9f30=
3d4db22019a37
100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2788,7 +2788,7 @@ struct offload_callbacks {
                                                netdev_features_t features)=
;
        struct sk_buff          *(*gro_receive)(struct list_head *head,
                                                struct sk_buff *skb);
-       int                     (*gro_complete)(struct sk_buff *skb, int nh=
off);
+       int                     (*gro_complete)(struct sk_buff *skb,
int nhoff, int thoff);
 };

 struct packet_offload {
diff --git a/include/linux/udp.h b/include/linux/udp.h
index 3748e82b627b7044508db66adbf77c54a8e3d612..a04d94a3b42f8f5fb3d85622d2f=
3e56a94c4ea86
100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -82,7 +82,7 @@ struct udp_sock {
                                               struct sk_buff *skb);
        int                     (*gro_complete)(struct sock *sk,
                                                struct sk_buff *skb,
-                                               int nhoff);
+                                               int nhoff, int thoff);

        /* udp_recvmsg try to use this before splicing sk_receive_queue */
        struct sk_buff_head     reader_queue ____cacheline_aligned_in_smp;
diff --git a/include/net/gro.h b/include/net/gro.h
index b435f0ddbf64f7bf740b7e479a1b28bcdef122c6..2856b00b84dfbf122871ef9beda=
b2097a7c823eb
100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -385,18 +385,18 @@ static inline void
skb_gro_flush_final_remcsum(struct sk_buff *skb,

 INDIRECT_CALLABLE_DECLARE(struct sk_buff *ipv6_gro_receive(struct list_hea=
d *,
                                                           struct sk_buff *=
));
-INDIRECT_CALLABLE_DECLARE(int ipv6_gro_complete(struct sk_buff *, int));
+INDIRECT_CALLABLE_DECLARE(int ipv6_gro_complete(struct sk_buff *, int, int=
));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *inet_gro_receive(struct list_hea=
d *,
                                                           struct sk_buff *=
));
-INDIRECT_CALLABLE_DECLARE(int inet_gro_complete(struct sk_buff *, int));
+INDIRECT_CALLABLE_DECLARE(int inet_gro_complete(struct sk_buff *, int, int=
));

 INDIRECT_CALLABLE_DECLARE(struct sk_buff *udp4_gro_receive(struct list_hea=
d *,
                                                           struct sk_buff *=
));
-INDIRECT_CALLABLE_DECLARE(int udp4_gro_complete(struct sk_buff *, int));
+INDIRECT_CALLABLE_DECLARE(int udp4_gro_complete(struct sk_buff *, int, int=
));

 INDIRECT_CALLABLE_DECLARE(struct sk_buff *udp6_gro_receive(struct list_hea=
d *,
                                                           struct sk_buff *=
));
-INDIRECT_CALLABLE_DECLARE(int udp6_gro_complete(struct sk_buff *, int));
+INDIRECT_CALLABLE_DECLARE(int udp6_gro_complete(struct sk_buff *, int, int=
));

 #define indirect_call_gro_receive_inet(cb, f2, f1, head, skb)  \
 ({                                                             \
@@ -407,7 +407,7 @@ INDIRECT_CALLABLE_DECLARE(int
udp6_gro_complete(struct sk_buff *, int));

 struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *sk=
b,
                                struct udphdr *uh, struct sock *sk);
-int udp_gro_complete(struct sk_buff *skb, int nhoff, udp_lookup_t lookup);
+int udp_gro_complete(struct sk_buff *skb, int nhoff, int thoff,
udp_lookup_t lookup);

 static inline struct udphdr *udp_gro_udphdr(struct sk_buff *skb)
 {
diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index f50a644d87a9871fbed2dfd49d4bde9d3df0fd92..605f917c830c9b1794dfc3bda1b=
dc9ac24a0def3
100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -64,7 +64,7 @@ int inet_recv_error(struct sock *sk, struct msghdr
*msg, int len,
                    int *addr_len);

 struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *s=
kb);
-int inet_gro_complete(struct sk_buff *skb, int nhoff);
+int inet_gro_complete(struct sk_buff *skb, int nhoff, int thoff);
 struct sk_buff *inet_gso_segment(struct sk_buff *skb,
                                 netdev_features_t features);

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6ae35199d3b3c159ba029ff74b109c56a7c7d2fc..ad8e6efc8bd867ada990820b5ba=
dce96ee49c3da
100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2196,9 +2196,9 @@ void tcp_v4_destroy_sock(struct sock *sk);
 struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
                                netdev_features_t features);
 struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *sk=
b);
-INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb,
int thoff));
+INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb,
int nhoff, int thoff));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp4_gro_receive(struct
list_head *head, struct sk_buff *skb));
-INDIRECT_CALLABLE_DECLARE(int tcp6_gro_complete(struct sk_buff *skb,
int thoff));
+INDIRECT_CALLABLE_DECLARE(int tcp6_gro_complete(struct sk_buff *skb,
int nhoff, int thoff));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp6_gro_receive(struct
list_head *head, struct sk_buff *skb));
 #ifdef CONFIG_INET
 void tcp_gro_complete(struct sk_buff *skb);
diff --git a/include/net/udp.h b/include/net/udp.h
index 488a6d2babccf26edfbaecc525f25e03d86b7d62..601d1c3b677a9acd6b6615e64de=
3f034f940287d
100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -166,8 +166,8 @@ static inline void udp_csum_pull_header(struct sk_buff =
*skb)
        UDP_SKB_CB(skb)->cscov -=3D sizeof(struct udphdr);
 }

-typedef struct sock *(*udp_lookup_t)(const struct sk_buff *skb, __be16 spo=
rt,
-                                    __be16 dport);
+typedef struct sock *(*udp_lookup_t)(const struct sk_buff *skb, int nhoff,
+                                    __be16 sport, __be16 dport);

 void udp_v6_early_demux(struct sk_buff *skb);
 INDIRECT_CALLABLE_DECLARE(int udpv6_rcv(struct sk_buff *));
@@ -301,7 +301,7 @@ struct sock *udp4_lib_lookup(struct net *net,
__be32 saddr, __be16 sport,
 struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport=
,
                               __be32 daddr, __be16 dport, int dif, int sdi=
f,
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
index d716214fe03df0a56266c22c7e8b42ba650e728b..a641392e70b0aa3d01826430640=
f3db6557d604b
100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -75,7 +75,7 @@ typedef struct sk_buff
*(*udp_tunnel_gro_receive_t)(struct sock *sk,
                                                    struct list_head *head,
                                                    struct sk_buff *skb);
 typedef int (*udp_tunnel_gro_complete_t)(struct sock *sk, struct sk_buff *=
skb,
-                                        int nhoff);
+                                        int nhoff, int thoff);

 struct udp_tunnel_sock_cfg {
        void *sk_user_data;     /* user data used by encap_rcv call back */
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index f001582345052f8c26e008058ae5f721f8bc224d..247704cf70aff1279c62507a940=
581e5049175b9
100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -510,7 +510,7 @@ static struct sk_buff *vlan_gro_receive(struct
list_head *head,
        return pp;
 }

-static int vlan_gro_complete(struct sk_buff *skb, int nhoff)
+static int vlan_gro_complete(struct sk_buff *skb, int p_off, int nhoff)
 {
        struct vlan_hdr *vhdr =3D (struct vlan_hdr *)(skb->data + nhoff);
        __be16 type =3D vhdr->h_vlan_encapsulated_proto;
@@ -521,7 +521,7 @@ static int vlan_gro_complete(struct sk_buff *skb, int n=
hoff)
        if (ptype)
                err =3D INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
                                         ipv6_gro_complete, inet_gro_comple=
te,
-                                        skb, nhoff + sizeof(*vhdr));
+                                        skb, p_off, nhoff + sizeof(*vhdr))=
;

        return err;
 }
diff --git a/net/core/gro.c b/net/core/gro.c
index 0759277dc14ee65d0a5376d48694cc1cccaee959..07768055ecf25d426e7cd01551f=
32978a70e8379
100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -254,7 +254,7 @@ static void napi_gro_complete(struct napi_struct
*napi, struct sk_buff *skb)

                err =3D INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
                                         ipv6_gro_complete, inet_gro_comple=
te,
-                                        skb, 0);
+                                        skb, 0, 0);
                break;
        }
        rcu_read_unlock();
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 2edc8b796a4e7326aa44128a0618e15b9aa817de..7515e6bcbb7d1e62fa0af2fd477=
bdea0284bfe40
100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -453,7 +453,7 @@ struct sk_buff *eth_gro_receive(struct list_head
*head, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(eth_gro_receive);

-int eth_gro_complete(struct sk_buff *skb, int nhoff)
+int eth_gro_complete(struct sk_buff *skb, int p_off, int nhoff)
 {
        struct ethhdr *eh =3D (struct ethhdr *)(skb->data + nhoff);
        __be16 type =3D eh->h_proto;
@@ -467,7 +467,7 @@ int eth_gro_complete(struct sk_buff *skb, int nhoff)
        if (ptype !=3D NULL)
                err =3D INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
                                         ipv6_gro_complete, inet_gro_comple=
te,
-                                        skb, nhoff + sizeof(*eh));
+                                        skb, p_off, nhoff + sizeof(*eh));

        return err;
 }
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 5daebdcbca326aa1fc042e1e1ff1e82a18bd283d..bef9b222f3c90487c7d44015efb=
23c08168cf164
100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1640,7 +1640,7 @@ int inet_recv_error(struct sock *sk, struct
msghdr *msg, int len, int *addr_len)
 }
 EXPORT_SYMBOL(inet_recv_error);

-int inet_gro_complete(struct sk_buff *skb, int nhoff)
+int inet_gro_complete(struct sk_buff *skb, int prior_off, int nhoff)
 {
        struct iphdr *iph =3D (struct iphdr *)(skb->data + nhoff);
        const struct net_offload *ops;
@@ -1666,17 +1666,17 @@ int inet_gro_complete(struct sk_buff *skb, int nhof=
f)
         */
        err =3D INDIRECT_CALL_2(ops->callbacks.gro_complete,
                              tcp4_gro_complete, udp4_gro_complete,
-                             skb, nhoff + sizeof(*iph));
+                             skb, nhoff, nhoff + sizeof(*iph));

 out:
        return err;
 }

-static int ipip_gro_complete(struct sk_buff *skb, int nhoff)
+static int ipip_gro_complete(struct sk_buff *skb, int prior_off, int nhoff=
)
 {
        skb->encapsulation =3D 1;
        skb_shinfo(skb)->gso_type |=3D SKB_GSO_IPXIP4;
-       return inet_gro_complete(skb, nhoff);
+       return inet_gro_complete(skb, prior_off, nhoff);
 }

 int inet_ctl_sock_create(struct sock **sk, unsigned short family,
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 0c41076e31edadd16f8e55ebc50f84db262a2f0d..ac4a6595d5cdf7e1e4b0eef4171=
73d8d2d4ad76d
100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -260,7 +260,7 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 }

 static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
-                           int nhoff)
+                           int p_off, int nhoff)
 {
        const struct net_offload __rcu **offloads;
        u8 proto =3D fou_from_sock(sk)->protocol;
@@ -272,7 +272,7 @@ static int fou_gro_complete(struct sock *sk,
struct sk_buff *skb,
        if (WARN_ON(!ops || !ops->callbacks.gro_complete))
                goto out;

-       err =3D ops->callbacks.gro_complete(skb, nhoff);
+       err =3D ops->callbacks.gro_complete(skb, p_off, nhoff);

        skb_set_inner_mac_header(skb, nhoff);

@@ -445,7 +445,8 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
        return pp;
 }

-static int gue_gro_complete(struct sock *sk, struct sk_buff *skb, int nhof=
f)
+static int gue_gro_complete(struct sock *sk, struct sk_buff *skb,
+                           int p_off, int nhoff)
 {
        struct guehdr *guehdr =3D (struct guehdr *)(skb->data + nhoff);
        const struct net_offload __rcu **offloads;
@@ -480,7 +481,7 @@ static int gue_gro_complete(struct sock *sk,
struct sk_buff *skb, int nhoff)
        if (WARN_ON(!ops || !ops->callbacks.gro_complete))
                goto out;

-       err =3D ops->callbacks.gro_complete(skb, nhoff + guehlen);
+       err =3D ops->callbacks.gro_complete(skb, p_off, nhoff + guehlen);

        skb_set_inner_mac_header(skb, nhoff + guehlen);

diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
index 311e70bfce407a2cadaa33fbef9a3976375711f4..803a8498f3030ec80a0ed41313e=
314021416a207
100644
--- a/net/ipv4/gre_offload.c
+++ b/net/ipv4/gre_offload.c
@@ -233,7 +233,7 @@ static struct sk_buff *gre_gro_receive(struct
list_head *head,
        return pp;
 }

-static int gre_gro_complete(struct sk_buff *skb, int nhoff)
+static int gre_gro_complete(struct sk_buff *skb, int p_off, int nhoff)
 {
        struct gre_base_hdr *greh =3D (struct gre_base_hdr *)(skb->data + n=
hoff);
        struct packet_offload *ptype;
@@ -253,7 +253,7 @@ static int gre_gro_complete(struct sk_buff *skb, int nh=
off)

        ptype =3D gro_find_complete_by_type(type);
        if (ptype)
-               err =3D ptype->callbacks.gro_complete(skb, nhoff + grehlen)=
;
+               err =3D ptype->callbacks.gro_complete(skb, p_off, nhoff
+ grehlen);

        skb_set_inner_mac_header(skb, nhoff + grehlen);

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 8311c38267b55ba97e59924c3c1c5b59f133fdcd..6f126f7d806d60e4d884c4f95b5=
3b8e4bd9fbb8a
100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -328,10 +328,10 @@ struct sk_buff *tcp4_gro_receive(struct
list_head *head, struct sk_buff *skb)
        return tcp_gro_receive(head, skb);
 }

-INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int tho=
ff)
+INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb,
int nhoff, int thoff)
 {
-       const struct iphdr *iph =3D ip_hdr(skb);
-       struct tcphdr *th =3D tcp_hdr(skb);
+       const struct iphdr *iph =3D (const struct iphdr *)(skb->data + nhof=
f);
+       struct tcphdr *th =3D (struct tcphdr *)(skb->data + thoff);

        th->check =3D ~tcp_v4_check(skb->len - thoff, iph->saddr,
                                  iph->daddr, 0);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a8acea17b4e5344d022ae8f8eb674d1a36f8035a..70a6d174855f76fb5dd289e3ef2=
22a5158890e4f
100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -532,9 +532,10 @@ static inline struct sock
*__udp4_lib_lookup_skb(struct sk_buff *skb,
 }

 struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
+                                int nhoff,
                                 __be16 sport, __be16 dport)
 {
-       const struct iphdr *iph =3D ip_hdr(skb);
+       const struct iphdr *iph =3D (const struct iphdr *)(skb->data + nhof=
f);
        struct net *net =3D dev_net(skb->dev);
        int iif, sdif;

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 6c95d28d0c4a7e56d587a986113b3711f8de964c..fa82a5a08688086415bae1d425d=
034f12311b0ab
100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -669,18 +669,18 @@ static int udp_gro_complete_segment(struct sk_buff *s=
kb)
        return 0;
 }

-int udp_gro_complete(struct sk_buff *skb, int nhoff,
+int udp_gro_complete(struct sk_buff *skb, int nhoff, int thoff,
                     udp_lookup_t lookup)
 {
-       __be16 newlen =3D htons(skb->len - nhoff);
-       struct udphdr *uh =3D (struct udphdr *)(skb->data + nhoff);
+       struct udphdr *uh =3D (struct udphdr *)(skb->data + thoff);
+       __be16 newlen =3D htons(skb->len - thoff);
        struct sock *sk;
        int err;

        uh->len =3D newlen;

        sk =3D INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
-                               udp4_lib_lookup_skb, skb, uh->source, uh->d=
est);
+                               udp4_lib_lookup_skb, skb, nhoff,
uh->source, uh->dest);
        if (sk && udp_sk(sk)->gro_complete) {
                skb_shinfo(skb)->gso_type =3D uh->check ? SKB_GSO_UDP_TUNNE=
L_CSUM
                                        : SKB_GSO_UDP_TUNNEL;
@@ -694,8 +694,8 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
                 * functions to make them set up the inner offsets.
                 */
                skb->encapsulation =3D 1;
-               err =3D udp_sk(sk)->gro_complete(sk, skb,
-                               nhoff + sizeof(struct udphdr));
+               err =3D udp_sk(sk)->gro_complete(sk, skb, nhoff,
+                               thoff + sizeof(struct udphdr));
        } else {
                err =3D udp_gro_complete_segment(skb);
        }
@@ -707,14 +707,14 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 }
 EXPORT_SYMBOL(udp_gro_complete);

-INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nho=
ff)
+INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb,
int nhoff, int thoff)
 {
-       const struct iphdr *iph =3D ip_hdr(skb);
-       struct udphdr *uh =3D (struct udphdr *)(skb->data + nhoff);
+       const struct iphdr *iph =3D (const struct iphdr *)(skb->data + nhof=
f);
+       struct udphdr *uh =3D (struct udphdr *)(skb->data + thoff);

        /* do fraglist only if there is no outer UDP encap (or we
already processed it) */
        if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-               uh->len =3D htons(skb->len - nhoff);
+               uh->len =3D htons(skb->len - thoff);

                skb_shinfo(skb)->gso_type |=3D (SKB_GSO_FRAGLIST|SKB_GSO_UD=
P_L4);
                skb_shinfo(skb)->gso_segs =3D NAPI_GRO_CB(skb)->count;
@@ -731,10 +731,10 @@ INDIRECT_CALLABLE_SCOPE int
udp4_gro_complete(struct sk_buff *skb, int nhoff)
        }

        if (uh->check)
-               uh->check =3D ~udp_v4_check(skb->len - nhoff, iph->saddr,
+               uh->check =3D ~udp_v4_check(skb->len - thoff, iph->saddr,
                                          iph->daddr, 0);

-       return udp_gro_complete(skb, nhoff, udp4_lib_lookup_skb);
+       return udp_gro_complete(skb, nhoff, thoff, udp4_lib_lookup_skb);
 }

 static const struct net_offload udpv4_offload =3D {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index cca64c7809bee9a0360cbfab6a645d3f8d2ffea3..e3a05b84c76ab9d55afafa94a53=
130b3b0d6c7f7
100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -346,12 +346,14 @@ static struct sk_buff *ip4ip6_gro_receive(struct
list_head *head,
        return inet_gro_receive(head, skb);
 }

-INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nho=
ff)
+INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb,
+                                             int p_off, int nhoff)
 {
        const struct net_offload *ops;
        struct ipv6hdr *iph;
        int err =3D -ENOSYS;
        u32 payload_len;
+       int nhlen;

        if (skb->encapsulation) {
                skb_set_inner_protocol(skb, cpu_to_be16(ETH_P_IPV6));
@@ -387,36 +389,36 @@ INDIRECT_CALLABLE_SCOPE int
ipv6_gro_complete(struct sk_buff *skb, int nhoff)
                iph->payload_len =3D htons(payload_len);
        }

-       nhoff +=3D sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
-       if (WARN_ON(!ops || !ops->callbacks.gro_complete))
+       nhlen =3D sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
+       if (WARN_ON_ONCE(!ops || !ops->callbacks.gro_complete))
                goto out;

        err =3D INDIRECT_CALL_L4(ops->callbacks.gro_complete, tcp6_gro_comp=
lete,
-                              udp6_gro_complete, skb, nhoff);
+                              udp6_gro_complete, skb, nhoff, nhoff + nhlen=
);

 out:
        return err;
 }

-static int sit_gro_complete(struct sk_buff *skb, int nhoff)
+static int sit_gro_complete(struct sk_buff *skb, int p_off, int nhoff)
 {
        skb->encapsulation =3D 1;
        skb_shinfo(skb)->gso_type |=3D SKB_GSO_IPXIP4;
-       return ipv6_gro_complete(skb, nhoff);
+       return ipv6_gro_complete(skb, p_off, nhoff);
 }

-static int ip6ip6_gro_complete(struct sk_buff *skb, int nhoff)
+static int ip6ip6_gro_complete(struct sk_buff *skb, int p_off, int nhoff)
 {
        skb->encapsulation =3D 1;
        skb_shinfo(skb)->gso_type |=3D SKB_GSO_IPXIP6;
-       return ipv6_gro_complete(skb, nhoff);
+       return ipv6_gro_complete(skb, p_off, nhoff);
 }

-static int ip4ip6_gro_complete(struct sk_buff *skb, int nhoff)
+static int ip4ip6_gro_complete(struct sk_buff *skb, int p_off, int nhoff)
 {
        skb->encapsulation =3D 1;
        skb_shinfo(skb)->gso_type |=3D SKB_GSO_IPXIP6;
-       return inet_gro_complete(skb, nhoff);
+       return inet_gro_complete(skb, p_off, nhoff);
 }

 static struct packet_offload ipv6_packet_offload __read_mostly =3D {
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index bf0c957e4b5eaaabc0ac3a7e55c7de6608cec156..5043d2ff34eb8a7f9aeb7db6b43=
47a0f976b8502
100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -27,10 +27,11 @@ struct sk_buff *tcp6_gro_receive(struct list_head
*head, struct sk_buff *skb)
        return tcp_gro_receive(head, skb);
 }

-INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int tho=
ff)
+INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb,
+                                             int nhoff, int thoff)
 {
-       const struct ipv6hdr *iph =3D ipv6_hdr(skb);
-       struct tcphdr *th =3D tcp_hdr(skb);
+       const struct ipv6hdr *iph =3D (const struct ipv6hdr *)(skb->data + =
nhoff);
+       struct tcphdr *th =3D (struct tcphdr *)(skb->data + thoff);

        th->check =3D ~tcp_v6_check(skb->len - thoff, &iph->saddr,
                                  &iph->daddr, 0);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3f2249b4cd5f6a594dd9768e29f20f0d9a57faed..400243c89d8234ff98b3991c049=
e83237fa6686f
100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -273,9 +273,10 @@ static struct sock *__udp6_lib_lookup_skb(struct
sk_buff *skb,
 }

 struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
+                                int nhoff,
                                 __be16 sport, __be16 dport)
 {
-       const struct ipv6hdr *iph =3D ipv6_hdr(skb);
+       const struct ipv6hdr *iph =3D (const struct ipv6hdr *)(skb->data + =
nhoff);
        struct net *net =3D dev_net(skb->dev);
        int iif, sdif;

diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 6b95ba241ebe2af7e5f2760d8a9c1d78f08579c5..7bf0fb609451586ab9fb1de955d=
1ae2ea2dbee64
100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -162,14 +162,14 @@ struct sk_buff *udp6_gro_receive(struct
list_head *head, struct sk_buff *skb)
        return NULL;
 }

-INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nho=
ff)
+INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb,
int nhoff, int thoff)
 {
-       const struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
-       struct udphdr *uh =3D (struct udphdr *)(skb->data + nhoff);
+       const struct ipv6hdr *ipv6h =3D (const struct ipv6hdr
*)(skb->data + nhoff);
+       struct udphdr *uh =3D (struct udphdr *)(skb->data + thoff);

        /* do fraglist only if there is no outer UDP encap (or we
already processed it) */
        if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-               uh->len =3D htons(skb->len - nhoff);
+               uh->len =3D htons(skb->len - thoff);

                skb_shinfo(skb)->gso_type |=3D (SKB_GSO_FRAGLIST|SKB_GSO_UD=
P_L4);
                skb_shinfo(skb)->gso_segs =3D NAPI_GRO_CB(skb)->count;
@@ -186,10 +186,10 @@ INDIRECT_CALLABLE_SCOPE int
udp6_gro_complete(struct sk_buff *skb, int nhoff)
        }

        if (uh->check)
-               uh->check =3D ~udp_v6_check(skb->len - nhoff, &ipv6h->saddr=
,
+               uh->check =3D ~udp_v6_check(skb->len - thoff, &ipv6h->saddr=
,
                                          &ipv6h->daddr, 0);

-       return udp_gro_complete(skb, nhoff, udp6_lib_lookup_skb);
+       return udp_gro_complete(skb, nhoff, thoff, udp6_lib_lookup_skb);
 }

 static const struct net_offload udpv6_offload =3D {

