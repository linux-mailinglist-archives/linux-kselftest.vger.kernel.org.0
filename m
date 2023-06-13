Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D172DEE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbjFMKPM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 06:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbjFMKPG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 06:15:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7535186
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 03:15:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3094910b150so5268100f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 03:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686651302; x=1689243302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niB6q6L/HCGZT/TBjgQN2/GjByVpsHkMvTo8zuSRSUc=;
        b=Qv+2PGaA9RwJMjvR+xwpdWTcgBPvWTxD7iG7XpXoOvBL2rJ+jF5QCv/z5cUxxSPrWP
         afJAwm8zvEyAE5NpYLDUuoONbMss4FzDTFzE3DjyrjiAYptxrPuFp1+p7T2/c9Jsuw2b
         c70yOoHqApYqd/J5UgtuoFMbIJWFGrjF6RDKtxYOgzVJWuUhGQZheT47h2SQ+1W517Z8
         p6dS2RLP5cx67KYWsOdA687ZOusc5i9INLPk833OGn0slAKQqMC/UzF62O+jVhKkJ2UC
         Jsdz8WHkCM08tGUOq6zbp+TudJJe5zxmvt+kj5xg1Wbcid1glwmZkONqD0Py5/KQjK0v
         J1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651302; x=1689243302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niB6q6L/HCGZT/TBjgQN2/GjByVpsHkMvTo8zuSRSUc=;
        b=C1GMtnso7n7WvwkJe1YT9ohSXV6ZZ26hCirW4yiLLD2AZnsABwpjLaDNtZIp6C8kr+
         ufeF6lN/+BOcFeRZJRuKNWRSGio5C61jfn0/OBg9vlLmEYJRDnmE7Ia+lNaga9Ljfc2C
         6gCx/81GbGJ68HgLI8hHDQz4dAF3CqdvpQw9u4Ou2gKwJ2D5EMmvTiPVtNxuEY6I8mwx
         7L77bi/9mklM4+W+poxrfvxAJ2+6JrMkD/fxb5LQ1DCb/t9rhmywTUNuz/mnqpNtpCXy
         RaAgMsQ/6QNaqxhG1SjkvD3NHRmK6pClKEZQ0TVWMGZ7sV93HxVDy6Gpfvxd2STl1yMy
         yf0Q==
X-Gm-Message-State: AC+VfDzr4p+VdAAE1No4HUpuXgCEC4580jIzlM3xSpSzGn7XgzHSoELz
        QXJQQ6yhkkTS2mRQQWvc4e8VKw==
X-Google-Smtp-Source: ACHHUZ6UewQXorpZ3YU+nko8DYBZ2I6KsnBKBUYuNUebb1pq+Wjw2WfX42AxoOnJXFF8PlTtGtt8ww==
X-Received: by 2002:a5d:4712:0:b0:30f:b912:e13c with SMTP id y18-20020a5d4712000000b0030fb912e13cmr6394918wrq.43.1686651302116;
        Tue, 13 Jun 2023 03:15:02 -0700 (PDT)
Received: from [192.168.133.193] ([5.148.46.226])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6e8f000000b0030e6096afb6sm15075020wrz.12.2023.06.13.03.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:15:01 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 13 Jun 2023 11:14:58 +0100
Subject: [PATCH bpf-next v2 3/6] net: remove duplicate reuseport_lookup
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v2-3-b7c69a342613@isovalent.com>
References: <20230613-so-reuseport-v2-0-b7c69a342613@isovalent.com>
In-Reply-To: <20230613-so-reuseport-v2-0-b7c69a342613@isovalent.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are currently four copies of reuseport_lookup: one each for
(TCP, UDP)x(IPv4, IPv6). This forces us to duplicate all callers of
those functions as well. This is already the case for sk_lookup
helpers (inet,inet6,udp4,udp6)_lookup_run_bpf.

The only difference between the reuseport_lookup helpers is calling
a different hash function. Cut down the number of reuseport_lookup
functions to one per IP version by using the INDIRECT_CALL
infrastructure.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 include/net/inet6_hashtables.h | 11 ++++++++++-
 include/net/inet_hashtables.h  | 15 +++++++++-----
 net/ipv4/inet_hashtables.c     | 22 ++++++++++++++-------
 net/ipv4/udp.c                 | 37 +++++++++++-----------------------
 net/ipv6/inet6_hashtables.c    | 16 +++++++++++----
 net/ipv6/udp.c                 | 45 +++++++++++++++---------------------------
 6 files changed, 75 insertions(+), 71 deletions(-)

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
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 91f9210d4e83..1ec895fd9905 100644
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
 
@@ -332,6 +332,10 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
+INDIRECT_CALLABLE_DECLARE(u32 udp_ehashfn(const struct net *,
+					  const __be32, const __u16,
+					  const __be32, const __be16));
+
 /**
  * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket if necessary.
  * @net: network namespace.
@@ -342,6 +346,7 @@ static inline int compute_score(struct sock *sk, struct net *net,
  * @sport: source port.
  * @daddr: destination address.
  * @hnum: destination port in host byte order.
+ * @ehashfn: hash function used to generate the fallback hash.
  *
  * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
  *         the selected sock or an error.
@@ -349,13 +354,15 @@ static inline int compute_score(struct sock *sk, struct net *net,
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
+		phash = INDIRECT_CALL_2(ehashfn, inet_ehashfn, udp_ehashfn,
+					net, daddr, hnum, saddr, sport);
 		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
 	}
 	return reuse_sk;
@@ -385,7 +392,7 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
 			result = inet_lookup_reuseport(net, sk, skb, doff,
-						       saddr, sport, daddr, hnum);
+						       saddr, sport, daddr, hnum, inet_ehashfn);
 			if (result)
 				return result;
 
@@ -414,7 +421,8 @@ static inline struct sock *inet_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum,
+					 inet_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index fd3dae081f3a..10468fe144d0 100644
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
@@ -450,11 +434,13 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
-			result = lookup_reuseport(net, sk, skb,
-						  saddr, sport, daddr, hnum);
-			/* Fall back to scoring if group has connections */
-			if (result && !reuseport_has_conns(sk))
-				return result;
+			if (sk->sk_state != TCP_ESTABLISHED) {
+				result = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+							       saddr, sport, daddr, hnum, udp_ehashfn);
+				/* Fall back to scoring if group has connections */
+				if (result && !reuseport_has_conns(sk))
+					return result;
+			}
 
 			result = result ? : sk;
 			badness = score;
@@ -480,7 +466,8 @@ static struct sock *udp4_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+					 saddr, sport, daddr, hnum, udp_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 208998694ae3..a350ee40141c 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -111,6 +111,10 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
+INDIRECT_CALLABLE_DECLARE(u32 udp6_ehashfn(const struct net *,
+					   const struct in6_addr *, const u16,
+					   const struct in6_addr *, const __be16));
+
 /**
  * inet6_lookup_reuseport() - execute reuseport logic on AF_INET6 socket if necessary.
  * @net: network namespace.
@@ -121,6 +125,7 @@ static inline int compute_score(struct sock *sk, struct net *net,
  * @sport: source port.
  * @daddr: destination address.
  * @hnum: destination port in host byte order.
+ * @ehashfn: hash function used to generate the fallback hash.
  *
  * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
  *         the selected sock or an error.
@@ -130,13 +135,15 @@ struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
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
+		phash = INDIRECT_CALL_2(ehashfn, inet6_ehashfn, udp6_ehashfn,
+					net, daddr, hnum, saddr, sport);
 		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
 	}
 	return reuse_sk;
@@ -159,7 +166,7 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
 			result = inet6_lookup_reuseport(net, sk, skb, doff,
-							saddr, sport, daddr, hnum);
+							saddr, sport, daddr, hnum, inet6_ehashfn);
 			if (result)
 				return result;
 
@@ -190,7 +197,8 @@ static inline struct sock *inet6_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
+					  saddr, sport, daddr, hnum, inet6_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index e5a337e6b970..2af3a595f38a 100644
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
@@ -193,11 +176,14 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
-			result = lookup_reuseport(net, sk, skb,
-						  saddr, sport, daddr, hnum);
-			/* Fall back to scoring if group has connections */
-			if (result && !reuseport_has_conns(sk))
-				return result;
+			if (sk->sk_state != TCP_ESTABLISHED) {
+				result = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+								saddr, sport, daddr, hnum,
+								udp6_ehashfn);
+				/* Fall back to scoring if group has connections */
+				if (result && !reuseport_has_conns(sk))
+					return result;
+			}
 
 			result = result ? : sk;
 			badness = score;
@@ -225,7 +211,8 @@ static inline struct sock *udp6_lookup_run_bpf(struct net *net,
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

