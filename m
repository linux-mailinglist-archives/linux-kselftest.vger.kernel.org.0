Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F878740E06
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 12:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjF1KFv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 06:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjF1JwY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 05:52:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2372D2D69
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 02:48:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa8cd4a113so34847705e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687945722; x=1690537722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACu9x9znTzzrG5OOVX/Mf35kw5S9FPJgqrcruayEvUA=;
        b=b5HkArT3+z8GOWUG+9nyuz5QF4kb+DHqy6lgEmHJDfpdV0RJ0FFnJ2gQDonbVWHz5F
         SjPXWCDQ8sbGkRr/jZwrohskYiqkEfkkPCA1PliTY+y21BESwRBSPkHPskZt9Y54gWlq
         TTgi48gtMj2JzXSluJmVfIrueHm8HIZfLv80UBFGjsXv7Q8ssM4PGthyeFCyw51e+NLH
         pY4G8FjuojzuH2RALY0YO2eCL9xscPOkULZLV3jZHQWKHWw4ALbn3h2xTeZzqE1iiRx3
         7zjfYolauoEuWndfK+cK2yX+iUGg66Pn0Q93mZ4RRRNSFzXuT/QXytZlsq8h5tbrepYm
         vmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687945722; x=1690537722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACu9x9znTzzrG5OOVX/Mf35kw5S9FPJgqrcruayEvUA=;
        b=jF6STmTD2U7/sM91KoXIyH9YZgl62HIsU+1R9y/4kV6i2Vu6VwUgxstDK8KeSLGFso
         VdOrJ/NHgzffy8C+jMsDFV60mLMM+vgeis249sb25jm7PftNTAnDnXkWm5p6LpEyfYat
         SuRPFs/5PcVNyQeMh8D0RLTxi/DvlesGPeyiTcn13eGfOBl/Gw5eOx1CDl4G450P0lzb
         ihhD1oDr5J0Dc5uAZLoNkTbwH6cB/YhX0gPtbDxg2tIUqUgbhBxUjyUwYD37OmwCFzWh
         HIqetep6vQKIrMEcZ1XGWqCT7WuF1ltLw8LHAKqb9nNY/+9EU6YCVQ/9ZlAbW6pm6WeM
         gVdw==
X-Gm-Message-State: AC+VfDyvMTf07H9Om4zyZ1XrmHimVHWWY57wxmU8e3iwYz5TsHFm3x4M
        lLN7uhPXchHe0naxoTz3XBA0dg==
X-Google-Smtp-Source: ACHHUZ45a0QJUGsm91jVXed9BAr4NffD2osdU9jn0fZa1wpkiy+BilWG1MqBEVXSDXOmzH1bJlZVxA==
X-Received: by 2002:a05:600c:3786:b0:3f9:c0a9:3e22 with SMTP id o6-20020a05600c378600b003f9c0a93e22mr14927552wmr.12.1687945722587;
        Wed, 28 Jun 2023 02:48:42 -0700 (PDT)
Received: from [192.168.1.193] (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc41a000000b003fbb1a9586esm1187613wmi.15.2023.06.28.02.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:48:42 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 28 Jun 2023 10:48:21 +0100
Subject: [PATCH bpf-next v4 6/7] bpf, net: Support SO_REUSEPORT sockets
 with bpf_sk_assign
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v4-6-4ece76708bba@isovalent.com>
References: <20230613-so-reuseport-v4-0-4ece76708bba@isovalent.com>
In-Reply-To: <20230613-so-reuseport-v4-0-4ece76708bba@isovalent.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>,
        Joe Stringer <joe@cilium.io>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the bpf_sk_assign helper in tc BPF context refuses SO_REUSEPORT
sockets. This means we can't use the helper to steer traffic to Envoy,
which configures SO_REUSEPORT on its sockets. In turn, we're blocked
from removing TPROXY from our setup.

The reason that bpf_sk_assign refuses such sockets is that the
bpf_sk_lookup helpers don't execute SK_REUSEPORT programs. Instead,
one of the reuseport sockets is selected by hash. This could cause
dispatch to the "wrong" socket:

    sk = bpf_sk_lookup_tcp(...) // select SO_REUSEPORT by hash
    bpf_sk_assign(skb, sk) // SK_REUSEPORT wasn't executed

Fixing this isn't as simple as invoking SK_REUSEPORT from the lookup
helpers unfortunately. In the tc context, L2 headers are at the start
of the skb, while SK_REUSEPORT expects L3 headers instead.

Instead, we execute the SK_REUSEPORT program when the assigned socket
is pulled out of the skb, further up the stack. This creates some
trickiness with regards to refcounting as bpf_sk_assign will put both
refcounted and RCU freed sockets in skb->sk. reuseport sockets are RCU
freed. We can infer that the sk_assigned socket is RCU freed if the
reuseport lookup succeeds, but convincing yourself of this fact isn't
straight forward. Therefore we defensively check refcounting on the
sk_assign sock even though it's probably not required in practice.

Fixes: 8e368dc72e86 ("bpf: Fix use of sk->sk_reuseport from sk_assign")
Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
Cc: Joe Stringer <joe@cilium.io>
Link: https://lore.kernel.org/bpf/CACAyw98+qycmpQzKupquhkxbvWK4OFyDuuLMBNROnfWMZxUWeA@mail.gmail.com/
---
 include/net/inet6_hashtables.h | 56 ++++++++++++++++++++++++++++++++++++++----
 include/net/inet_hashtables.h  | 49 ++++++++++++++++++++++++++++++++++--
 include/net/sock.h             |  7 ++++--
 include/uapi/linux/bpf.h       |  3 ---
 net/core/filter.c              |  2 --
 net/ipv4/udp.c                 |  8 ++++--
 net/ipv6/udp.c                 | 10 +++++---
 tools/include/uapi/linux/bpf.h |  3 ---
 8 files changed, 116 insertions(+), 22 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index a6722d6ef80f..7d677b89f269 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -103,6 +103,46 @@ static inline struct sock *__inet6_lookup(struct net *net,
 				     daddr, hnum, dif, sdif);
 }
 
+static inline
+struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
+			      const struct in6_addr *saddr, const __be16 sport,
+			      const struct in6_addr *daddr, const __be16 dport,
+			      bool *refcounted, inet6_ehashfn_t *ehashfn)
+{
+	struct sock *sk, *reuse_sk;
+	bool prefetched;
+
+	sk = skb_steal_sock(skb, refcounted, &prefetched);
+	if (!sk)
+		return NULL;
+
+	if (!prefetched)
+		return sk;
+
+	if (sk->sk_protocol == IPPROTO_TCP) {
+		if (sk->sk_state != TCP_LISTEN)
+			return sk;
+	} else if (sk->sk_protocol == IPPROTO_UDP) {
+		if (sk->sk_state != TCP_CLOSE)
+			return sk;
+	} else {
+		return sk;
+	}
+
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
+					  saddr, sport, daddr, ntohs(dport),
+					  ehashfn);
+	if (!reuse_sk || reuse_sk == sk)
+		return sk;
+
+	/* We've chosen a new reuseport sock which is never refcounted. This
+	 * implies that sk also isn't refcounted.
+	 */
+	WARN_ON_ONCE(*refcounted);
+
+	return reuse_sk;
+}
+
 static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 					      struct sk_buff *skb, int doff,
 					      const __be16 sport,
@@ -110,14 +150,20 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 					      int iif, int sdif,
 					      bool *refcounted)
 {
-	struct sock *sk = skb_steal_sock(skb, refcounted);
-
+	struct net *net = dev_net(skb_dst(skb)->dev);
+	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
+	struct sock *sk;
+
+	sk = inet6_steal_sock(net, skb, doff, &ip6h->saddr, sport, &ip6h->daddr, dport,
+			      refcounted, inet6_ehashfn);
+	if (IS_ERR(sk))
+		return NULL;
 	if (sk)
 		return sk;
 
-	return __inet6_lookup(dev_net(skb_dst(skb)->dev), hashinfo, skb,
-			      doff, &ipv6_hdr(skb)->saddr, sport,
-			      &ipv6_hdr(skb)->daddr, ntohs(dport),
+	return __inet6_lookup(net, hashinfo, skb,
+			      doff, &ip6h->saddr, sport,
+			      &ip6h->daddr, ntohs(dport),
 			      iif, sdif, refcounted);
 }
 
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index c0532cc7587f..c6ae0af12ce0 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -449,6 +449,46 @@ static inline struct sock *inet_lookup(struct net *net,
 	return sk;
 }
 
+static inline
+struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
+			     const __be32 saddr, const __be16 sport,
+			     const __be32 daddr, const __be16 dport,
+			     bool *refcounted, inet_ehashfn_t *ehashfn)
+{
+	struct sock *sk, *reuse_sk;
+	bool prefetched;
+
+	sk = skb_steal_sock(skb, refcounted, &prefetched);
+	if (!sk)
+		return NULL;
+
+	if (!prefetched)
+		return sk;
+
+	if (sk->sk_protocol == IPPROTO_TCP) {
+		if (sk->sk_state != TCP_LISTEN)
+			return sk;
+	} else if (sk->sk_protocol == IPPROTO_UDP) {
+		if (sk->sk_state != TCP_CLOSE)
+			return sk;
+	} else {
+		return sk;
+	}
+
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff,
+					 saddr, sport, daddr, ntohs(dport),
+					 ehashfn);
+	if (!reuse_sk || reuse_sk == sk)
+		return sk;
+
+	/* We've chosen a new reuseport sock which is never refcounted. This
+	 * implies that sk also isn't refcounted.
+	 */
+	WARN_ON_ONCE(*refcounted);
+
+	return reuse_sk;
+}
+
 static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 					     struct sk_buff *skb,
 					     int doff,
@@ -457,13 +497,18 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 					     const int sdif,
 					     bool *refcounted)
 {
-	struct sock *sk = skb_steal_sock(skb, refcounted);
+	struct net *net = dev_net(skb_dst(skb)->dev);
 	const struct iphdr *iph = ip_hdr(skb);
+	struct sock *sk;
 
+	sk = inet_steal_sock(net, skb, doff, iph->saddr, sport, iph->daddr, dport,
+			     refcounted, inet_ehashfn);
+	if (IS_ERR(sk))
+		return NULL;
 	if (sk)
 		return sk;
 
-	return __inet_lookup(dev_net(skb_dst(skb)->dev), hashinfo, skb,
+	return __inet_lookup(net, hashinfo, skb,
 			     doff, iph->saddr, sport,
 			     iph->daddr, dport, inet_iif(skb), sdif,
 			     refcounted);
diff --git a/include/net/sock.h b/include/net/sock.h
index 656ea89f60ff..5645570c2a64 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2806,20 +2806,23 @@ sk_is_refcounted(struct sock *sk)
  * skb_steal_sock - steal a socket from an sk_buff
  * @skb: sk_buff to steal the socket from
  * @refcounted: is set to true if the socket is reference-counted
+ * @prefetched: is set to true if the socket was assigned from bpf
  */
 static inline struct sock *
-skb_steal_sock(struct sk_buff *skb, bool *refcounted)
+skb_steal_sock(struct sk_buff *skb, bool *refcounted, bool *prefetched)
 {
 	if (skb->sk) {
 		struct sock *sk = skb->sk;
 
 		*refcounted = true;
-		if (skb_sk_is_prefetched(skb))
+		*prefetched = skb_sk_is_prefetched(skb);
+		if (*prefetched)
 			*refcounted = sk_is_refcounted(sk);
 		skb->destructor = NULL;
 		skb->sk = NULL;
 		return sk;
 	}
+	*prefetched = false;
 	*refcounted = false;
 	return NULL;
 }
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a7b5e91dd768..d6fb6f43b0f3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4158,9 +4158,6 @@ union bpf_attr {
  *		**-EOPNOTSUPP** if the operation is not supported, for example
  *		a call from outside of TC ingress.
  *
- *		**-ESOCKTNOSUPPORT** if the socket type is not supported
- *		(reuseport).
- *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
  *		Helper is overloaded depending on BPF program type. This
diff --git a/net/core/filter.c b/net/core/filter.c
index 428df050d021..d4be0a1d754c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7278,8 +7278,6 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 		return -EOPNOTSUPP;
 	if (unlikely(dev_net(skb->dev) != sock_net(sk)))
 		return -ENETUNREACH;
-	if (unlikely(sk_fullsock(sk) && sk->sk_reuseport))
-		return -ESOCKTNOSUPPORT;
 	if (sk_is_refcounted(sk) &&
 	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 		return -ENOENT;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index eb79268f216d..b256f1f73b4d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2388,7 +2388,11 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	if (udp4_csum_init(skb, uh, proto))
 		goto csum_error;
 
-	sk = skb_steal_sock(skb, &refcounted);
+	sk = inet_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
+			     &refcounted, udp_ehashfn);
+	if (IS_ERR(sk))
+		goto no_sk;
+
 	if (sk) {
 		struct dst_entry *dst = skb_dst(skb);
 		int ret;
@@ -2409,7 +2413,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	sk = __udp4_lib_lookup_skb(skb, uh->source, uh->dest, udptable);
 	if (sk)
 		return udp_unicast_rcv_skb(sk, skb, uh);
-
+no_sk:
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto drop;
 	nf_reset_ct(skb);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8a6d94cabee0..2d4c05bc322a 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -923,9 +923,9 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct in6_addr *saddr, *daddr;
 	struct net *net = dev_net(skb->dev);
+	bool refcounted;
 	struct udphdr *uh;
 	struct sock *sk;
-	bool refcounted;
 	u32 ulen = 0;
 
 	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
@@ -962,7 +962,11 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		goto csum_error;
 
 	/* Check if the socket is already available, e.g. due to early demux */
-	sk = skb_steal_sock(skb, &refcounted);
+	sk = inet6_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
+			      &refcounted, udp6_ehashfn);
+	if (IS_ERR(sk))
+		goto no_sk;
+
 	if (sk) {
 		struct dst_entry *dst = skb_dst(skb);
 		int ret;
@@ -996,7 +1000,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 			goto report_csum_error;
 		return udp6_unicast_rcv_skb(sk, skb, uh);
 	}
-
+no_sk:
 	reason = SKB_DROP_REASON_NO_SOCKET;
 
 	if (!uh->check)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a7b5e91dd768..d6fb6f43b0f3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4158,9 +4158,6 @@ union bpf_attr {
  *		**-EOPNOTSUPP** if the operation is not supported, for example
  *		a call from outside of TC ingress.
  *
- *		**-ESOCKTNOSUPPORT** if the socket type is not supported
- *		(reuseport).
- *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
  *		Helper is overloaded depending on BPF program type. This

-- 
2.40.1

