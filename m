Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C352473E2D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjFZPJ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 11:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjFZPJX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 11:09:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D67A10CF
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 08:09:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fa99742af9so8810335e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687792157; x=1690384157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ct7YsjVQJp9T465ku7hA1Ygl3bo6vDeEBz5TLiSCNk=;
        b=S9FNU0oCsDht1rIhRtbxX7erLiuoXEOahKKyuE6+Li1hdObRhBSN2KOAQR14YqBxbY
         Pa8prYbMSU53c3E0ZQ4qXRcr0u+NZzACTNJKEoJvehHsxvXN5SFQDsvkSFSriymdMCwR
         /Z3XDvcAg8pQyPUE9W3OD6jrLXVjtOpa53Z3cmTrZDlbO2Vb3GiQ1gwDQFnYrwp2rdLQ
         DRSbZSzW6vbSe15HGr+spDFP0KK6+dAV5INLhkmcm+bi6aNyfVTghG9hN+Wf7U8METez
         iDzSoZgKSLzhHxkPgX/XijwB4p/pKG7/lEH1CYdh6nc9dQk37xGBw/0rbiCS+Rpz2kQw
         fKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687792157; x=1690384157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ct7YsjVQJp9T465ku7hA1Ygl3bo6vDeEBz5TLiSCNk=;
        b=KFvJIecuC+yws8cqE0TIBAPhmwGyTb1mDecKrnCUST94HQLF8xKqX4nvDtj0bUZX0D
         Ueyl0ZcppKqqaqdSrMOPVKwVwrXjp8uW8URBEVuWiS9+2Bbm2v6gNXEjOZ8bA7nTqWLs
         969doMxgeytgPyqSYJwYIW+WftaTlcXUg1Pw54DLprEJSqC82ZbTYooVh7KPPGSW9SRw
         Dzr8vby7EgEFfoheKHDz5iO1+hfTHNBevKbfTl49ofOJGs8b+fikdliB8hZuAE32qYvu
         V8Prz9KH90hUiS2ebDS2jnZxKcTuBEqIUXwch9CeGZTDHOwse662TDeG4E/L8D2OjV0u
         7sog==
X-Gm-Message-State: AC+VfDyYTG/GQINQqjQMmCJHGJiFySQHi8jgcFRsVy9dFSWDJ9FCtxyF
        pfAse219OJ2I96CgZWduCqjTLA==
X-Google-Smtp-Source: ACHHUZ4Lg+llBzTicJWcDyowo9/Gu6e2WdUCvY9zMY5t+fAOExDSAp9gpVrqrFVNxy8Wk9x6ZjI5bA==
X-Received: by 2002:a7b:cbd3:0:b0:3f9:b3ec:35d0 with SMTP id n19-20020a7bcbd3000000b003f9b3ec35d0mr13854968wmi.10.1687792156492;
        Mon, 26 Jun 2023 08:09:16 -0700 (PDT)
Received: from [192.168.1.193] (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id v1-20020adfe281000000b00311299df211sm7668710wri.77.2023.06.26.08.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:09:16 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Mon, 26 Jun 2023 16:09:01 +0100
Subject: [PATCH bpf-next v3 4/7] net: remove duplicate reuseport_lookup
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v3-4-907b4cbb7b99@isovalent.com>
References: <20230613-so-reuseport-v3-0-907b4cbb7b99@isovalent.com>
In-Reply-To: <20230613-so-reuseport-v3-0-907b4cbb7b99@isovalent.com>
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
        linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are currently four copies of reuseport_lookup: one each for
(TCP, UDP)x(IPv4, IPv6). This forces us to duplicate all callers of
those functions as well. This is already the case for sk_lookup
helpers (inet,inet6,udp4,udp6)_lookup_run_bpf.

There are two differences between the reuseport_lookup helpers:

1. They call different hash functions depending on protocol
2. UDP reuseport_lookup checks that sk_state != TCP_ESTABLISHED

Move the check for sk_state into the caller and use the INDIRECT_CALL
infrastructure to cut down the helpers to one per IP version.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 include/net/inet6_hashtables.h | 11 ++++++++++-
 include/net/inet_hashtables.h  | 15 ++++++++++-----
 include/net/udp.h              |  8 ++++++++
 net/ipv4/inet_hashtables.c     | 23 ++++++++++++++++-------
 net/ipv4/udp.c                 | 34 +++++++++++++---------------------
 net/ipv6/inet6_hashtables.c    | 17 +++++++++++++----
 net/ipv6/udp.c                 | 41 ++++++++++++++++-------------------------
 7 files changed, 86 insertions(+), 63 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 032ddab48f8f..49d586454287 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -48,12 +48,21 @@ struct sock *__inet6_lookup_established(struct net *net,
 					const u16 hnum, const int dif,
 					const int sdif);
 
+typedef u32 (*inet6_ehashfn_t)(const struct net *net,
+			       const struct in6_addr *laddr, const u16 lport,
+			       const struct in6_addr *faddr, const __be16 fport);
+
+u32 inet6_ehashfn(const struct net *net,
+		  const struct in6_addr *laddr, const u16 lport,
+		  const struct in6_addr *faddr, const __be16 fport);
+
 struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
 				    struct sk_buff *skb, int doff,
 				    const struct in6_addr *saddr,
 				    __be16 sport,
 				    const struct in6_addr *daddr,
-				    unsigned short hnum);
+				    unsigned short hnum,
+				    inet6_ehashfn_t ehashfn);
 
 struct sock *inet6_lookup_listener(struct net *net,
 				   struct inet_hashinfo *hashinfo,
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 8734f3488f5d..51ab6a1a3601 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -379,10 +379,19 @@ struct sock *__inet_lookup_established(struct net *net,
 				       const __be32 daddr, const u16 hnum,
 				       const int dif, const int sdif);
 
+typedef u32 (*inet_ehashfn_t)(const struct net *net,
+			      const __be32 laddr, const __u16 lport,
+			      const __be32 faddr, const __be16 fport);
+
+u32 inet_ehashfn(const struct net *net,
+		 const __be32 laddr, const __u16 lport,
+		 const __be32 faddr, const __be16 fport);
+
 struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
 				   struct sk_buff *skb, int doff,
 				   __be32 saddr, __be16 sport,
-				   __be32 daddr, unsigned short hnum);
+				   __be32 daddr, unsigned short hnum,
+				   inet_ehashfn_t ehashfn);
 
 static inline struct sock *
 	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
@@ -453,10 +462,6 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 			     refcounted);
 }
 
-u32 inet6_ehashfn(const struct net *net,
-		  const struct in6_addr *laddr, const u16 lport,
-		  const struct in6_addr *faddr, const __be16 fport);
-
 static inline void sk_daddr_set(struct sock *sk, __be32 addr)
 {
 	sk->sk_daddr = addr; /* alias of inet_daddr */
diff --git a/include/net/udp.h b/include/net/udp.h
index 5cad44318d71..3b404b429f88 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -317,6 +317,14 @@ struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport);
 int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 
+INDIRECT_CALLABLE_DECLARE(u32 udp_ehashfn(const struct net *,
+					  const __be32, const __u16,
+					  const __be32, const __be16));
+
+INDIRECT_CALLABLE_DECLARE(u32 udp6_ehashfn(const struct net *,
+					   const struct in6_addr *, const u16,
+					   const struct in6_addr *, const __be16));
+
 /* UDP uses skb->dev_scratch to cache as much information as possible and avoid
  * possibly multiple cache miss on dequeue()
  */
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 91f9210d4e83..0dd768ab22d9 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -28,9 +28,9 @@
 #include <net/tcp.h>
 #include <net/sock_reuseport.h>
 
-static u32 inet_ehashfn(const struct net *net, const __be32 laddr,
-			const __u16 lport, const __be32 faddr,
-			const __be16 fport)
+u32 inet_ehashfn(const struct net *net, const __be32 laddr,
+		 const __u16 lport, const __be32 faddr,
+		 const __be16 fport)
 {
 	static u32 inet_ehash_secret __read_mostly;
 
@@ -39,6 +39,7 @@ static u32 inet_ehashfn(const struct net *net, const __be32 laddr,
 	return __inet_ehashfn(laddr, lport, faddr, fport,
 			      inet_ehash_secret + net_hash_mix(net));
 }
+EXPORT_SYMBOL_GPL(inet_ehashfn);
 
 /* This function handles inet_sock, but also timewait and request sockets
  * for IPv4/IPv6.
@@ -332,6 +333,10 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
+INDIRECT_CALLABLE_DECLARE(u32 udp_ehashfn(const struct net *,
+					  const __be32, const __u16,
+					  const __be32, const __be16));
+
 /**
  * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket if necessary.
  * @net: network namespace.
@@ -342,6 +347,7 @@ static inline int compute_score(struct sock *sk, struct net *net,
  * @sport: source port.
  * @daddr: destination address.
  * @hnum: destination port in host byte order.
+ * @ehashfn: hash function used to generate the fallback hash.
  *
  * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
  *         the selected sock or an error.
@@ -349,13 +355,15 @@ static inline int compute_score(struct sock *sk, struct net *net,
 struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
 				   struct sk_buff *skb, int doff,
 				   __be32 saddr, __be16 sport,
-				   __be32 daddr, unsigned short hnum)
+				   __be32 daddr, unsigned short hnum,
+				   inet_ehashfn_t ehashfn)
 {
 	struct sock *reuse_sk = NULL;
 	u32 phash;
 
 	if (sk->sk_reuseport) {
-		phash = inet_ehashfn(net, daddr, hnum, saddr, sport);
+		phash = INDIRECT_CALL_2(ehashfn, udp_ehashfn, inet_ehashfn,
+					net, daddr, hnum, saddr, sport);
 		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
 	}
 	return reuse_sk;
@@ -385,7 +393,7 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
 			result = inet_lookup_reuseport(net, sk, skb, doff,
-						       saddr, sport, daddr, hnum);
+						       saddr, sport, daddr, hnum, inet_ehashfn);
 			if (result)
 				return result;
 
@@ -414,7 +422,8 @@ static inline struct sock *inet_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum,
+					 inet_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 5ef478d2c408..7258edece691 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -405,9 +405,9 @@ static int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static u32 udp_ehashfn(const struct net *net, const __be32 laddr,
-		       const __u16 lport, const __be32 faddr,
-		       const __be16 fport)
+INDIRECT_CALLABLE_SCOPE
+u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
+		const __be32 faddr, const __be16 fport)
 {
 	static u32 udp_ehash_secret __read_mostly;
 
@@ -417,22 +417,6 @@ static u32 udp_ehashfn(const struct net *net, const __be32 laddr,
 			      udp_ehash_secret + net_hash_mix(net));
 }
 
-static struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-				     struct sk_buff *skb,
-				     __be32 saddr, __be16 sport,
-				     __be32 daddr, unsigned short hnum)
-{
-	struct sock *reuse_sk = NULL;
-	u32 hash;
-
-	if (sk->sk_reuseport && sk->sk_state != TCP_ESTABLISHED) {
-		hash = udp_ehashfn(net, daddr, hnum, saddr, sport);
-		reuse_sk = reuseport_select_sock(sk, hash, skb,
-						 sizeof(struct udphdr));
-	}
-	return reuse_sk;
-}
-
 /* called with rcu_read_lock() */
 static struct sock *udp4_lib_lookup2(struct net *net,
 				     __be32 saddr, __be16 sport,
@@ -451,7 +435,14 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
 			badness = score;
-			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+
+			if (sk->sk_state == TCP_ESTABLISHED) {
+				result = sk;
+				continue;
+			}
+
+			result = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+						       saddr, sport, daddr, hnum, udp_ehashfn);
 			if (!result) {
 				result = sk;
 				continue;
@@ -490,7 +481,8 @@ static struct sock *udp4_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+					 saddr, sport, daddr, hnum, udp_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 208998694ae3..b5de1642bc51 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -39,6 +39,7 @@ u32 inet6_ehashfn(const struct net *net,
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
 			       inet6_ehash_secret + net_hash_mix(net));
 }
+EXPORT_SYMBOL_GPL(inet6_ehashfn);
 
 /*
  * Sockets in TCP_CLOSE state are _always_ taken out of the hash, so
@@ -111,6 +112,10 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
+INDIRECT_CALLABLE_DECLARE(u32 udp6_ehashfn(const struct net *,
+					   const struct in6_addr *, const u16,
+					   const struct in6_addr *, const __be16));
+
 /**
  * inet6_lookup_reuseport() - execute reuseport logic on AF_INET6 socket if necessary.
  * @net: network namespace.
@@ -121,6 +126,7 @@ static inline int compute_score(struct sock *sk, struct net *net,
  * @sport: source port.
  * @daddr: destination address.
  * @hnum: destination port in host byte order.
+ * @ehashfn: hash function used to generate the fallback hash.
  *
  * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
  *         the selected sock or an error.
@@ -130,13 +136,15 @@ struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
 				    const struct in6_addr *saddr,
 				    __be16 sport,
 				    const struct in6_addr *daddr,
-				    unsigned short hnum)
+				    unsigned short hnum,
+				    inet6_ehashfn_t ehashfn)
 {
 	struct sock *reuse_sk = NULL;
 	u32 phash;
 
 	if (sk->sk_reuseport) {
-		phash = inet6_ehashfn(net, daddr, hnum, saddr, sport);
+		phash = INDIRECT_CALL_INET(ehashfn, udp6_ehashfn, inet6_ehashfn,
+					   net, daddr, hnum, saddr, sport);
 		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
 	}
 	return reuse_sk;
@@ -159,7 +167,7 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
 			result = inet6_lookup_reuseport(net, sk, skb, doff,
-							saddr, sport, daddr, hnum);
+							saddr, sport, daddr, hnum, inet6_ehashfn);
 			if (result)
 				return result;
 
@@ -190,7 +198,8 @@ static inline struct sock *inet6_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
+					  saddr, sport, daddr, hnum, inet6_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8b3cb1d7da7c..ebac9200b15c 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -70,11 +70,12 @@ int udpv6_init_sock(struct sock *sk)
 	return 0;
 }
 
-static u32 udp6_ehashfn(const struct net *net,
-			const struct in6_addr *laddr,
-			const u16 lport,
-			const struct in6_addr *faddr,
-			const __be16 fport)
+INDIRECT_CALLABLE_SCOPE
+u32 udp6_ehashfn(const struct net *net,
+		 const struct in6_addr *laddr,
+		 const u16 lport,
+		 const struct in6_addr *faddr,
+		 const __be16 fport)
 {
 	static u32 udp6_ehash_secret __read_mostly;
 	static u32 udp_ipv6_hash_secret __read_mostly;
@@ -159,24 +160,6 @@ static int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-				     struct sk_buff *skb,
-				     const struct in6_addr *saddr,
-				     __be16 sport,
-				     const struct in6_addr *daddr,
-				     unsigned int hnum)
-{
-	struct sock *reuse_sk = NULL;
-	u32 hash;
-
-	if (sk->sk_reuseport && sk->sk_state != TCP_ESTABLISHED) {
-		hash = udp6_ehashfn(net, daddr, hnum, saddr, sport);
-		reuse_sk = reuseport_select_sock(sk, hash, skb,
-						 sizeof(struct udphdr));
-	}
-	return reuse_sk;
-}
-
 /* called with rcu_read_lock() */
 static struct sock *udp6_lib_lookup2(struct net *net,
 		const struct in6_addr *saddr, __be16 sport,
@@ -194,7 +177,14 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
 			badness = score;
-			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+
+			if (sk->sk_state == TCP_ESTABLISHED) {
+				result = sk;
+				continue;
+			}
+
+			result = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+							saddr, sport, daddr, hnum, udp6_ehashfn);
 			if (!result) {
 				result = sk;
 				continue;
@@ -234,7 +224,8 @@ static inline struct sock *udp6_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+					  saddr, sport, daddr, hnum, udp6_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;

-- 
2.40.1

