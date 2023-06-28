Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ED6740E08
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 12:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjF1KFz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 06:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjF1JwY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 05:52:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E4C2733
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 02:48:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f9bdb01ec0so65283865e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687945721; x=1690537721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeZGdd4rUtgKqzwCJQVIgRg4hn1CZ7BnN059R+TDiIQ=;
        b=bM0q80Cc+Q8VGRiGWT7s8M9IVMbfczVrvr8FFm+rwTdTpoYNqKfe5ix0rHbmbcOO5Q
         gFj//15MTaeMQmboXsv9UOwlc/IsqP5cbRMK5MvpA7+KNTd648LFGTr/c/3LhWg+xH4L
         OK+uT7rB5XNhHmvckJ7tOb1zRvehrxIjT5HvPfTFXijBuANLzYXultB3OWPJAI/iqTnV
         gWUP2QNUI7LfbzKLPsGc/YD143cpbWxDMp/0Bx07KoI06JSSThsrC1DwXmWpWHvfWj+j
         L5LUll6jP4xJSvsIqMBlg5vPAtMvQhulXhCItS2GvNOIS7J2Am4TOht+N1OZ4AgD5APU
         Kwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687945721; x=1690537721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeZGdd4rUtgKqzwCJQVIgRg4hn1CZ7BnN059R+TDiIQ=;
        b=R/NWEY9JLWLw5iaMBo0Mh/Vsnx9ycywSERx9mWptltY7jnJ0LfL5U/8g5gGksGGTRW
         5gI0iFfoZnp0ybl/J7wbUATSgGII9KxpR+pGQSoZx3p0q6gxG4SeT3BISkF8LPY00QhL
         BexfJHsq2DbYnAd9so/J3TDmVgFuRGNstjS+OnfVoanf7iL40tAidyohUsH1ujc8lCVY
         z6fKQNMhhFuM0AvyxxrST/HlfJW4nGbhwaK/mQ3klGDa5/JpOEiT4xz4W4MgLdhvnfkB
         DiKDTRTNjQiiyA8mg32ne4NLze+CkIC0yVXDG9K4fYzJENmsUfEbLrKEcTJQyEefHnSx
         8bVA==
X-Gm-Message-State: AC+VfDx9pDsH1g30ctIVzEH7EiQgbVHnHDWYxW4wZMgw51FlITEHOEeA
        oQyuuMs4W2Xj59rzdnM4EHb+5g==
X-Google-Smtp-Source: ACHHUZ5W9QvJ/GW3sCUSvq8r9xYv8m4L2ZLedBlE8qP8Kh3UPlV5HCEiRQbnVzamob2NwsITzxPe+Q==
X-Received: by 2002:a05:600c:2212:b0:3fa:7b20:6193 with SMTP id z18-20020a05600c221200b003fa7b206193mr12747270wml.38.1687945721418;
        Wed, 28 Jun 2023 02:48:41 -0700 (PDT)
Received: from [192.168.1.193] (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc41a000000b003fbb1a9586esm1187613wmi.15.2023.06.28.02.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:48:41 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 28 Jun 2023 10:48:20 +0100
Subject: [PATCH bpf-next v4 5/7] net: remove duplicate sk_lookup helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v4-5-4ece76708bba@isovalent.com>
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

Now that inet[6]_lookup_reuseport are parameterised on the ehashfn
we can remove two sk_lookup helpers.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 include/net/inet6_hashtables.h |  9 +++++++++
 include/net/inet_hashtables.h  |  7 +++++++
 net/ipv4/inet_hashtables.c     | 26 +++++++++++++-------------
 net/ipv4/udp.c                 | 32 +++++---------------------------
 net/ipv6/inet6_hashtables.c    | 31 ++++++++++++++++---------------
 net/ipv6/udp.c                 | 34 +++++-----------------------------
 6 files changed, 55 insertions(+), 84 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index f89320b6fee3..a6722d6ef80f 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -73,6 +73,15 @@ struct sock *inet6_lookup_listener(struct net *net,
 				   const unsigned short hnum,
 				   const int dif, const int sdif);
 
+struct sock *inet6_lookup_run_sk_lookup(struct net *net,
+					int protocol,
+					struct sk_buff *skb, int doff,
+					const struct in6_addr *saddr,
+					const __be16 sport,
+					const struct in6_addr *daddr,
+					const u16 hnum, const int dif,
+					inet6_ehashfn_t *ehashfn);
+
 static inline struct sock *__inet6_lookup(struct net *net,
 					  struct inet_hashinfo *hashinfo,
 					  struct sk_buff *skb, int doff,
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index ddfa2e67fdb5..c0532cc7587f 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -393,6 +393,13 @@ struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
 				   __be32 daddr, unsigned short hnum,
 				   inet_ehashfn_t *ehashfn);
 
+struct sock *inet_lookup_run_sk_lookup(struct net *net,
+				       int protocol,
+				       struct sk_buff *skb, int doff,
+				       __be32 saddr, __be16 sport,
+				       __be32 daddr, u16 hnum, const int dif,
+				       inet_ehashfn_t *ehashfn);
+
 static inline struct sock *
 	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
 				const __be32 saddr, const __be16 sport,
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ac927a635a6f..a411ae560bdf 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -402,25 +402,23 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 	return result;
 }
 
-static inline struct sock *inet_lookup_run_bpf(struct net *net,
-					       struct inet_hashinfo *hashinfo,
-					       struct sk_buff *skb, int doff,
-					       __be32 saddr, __be16 sport,
-					       __be32 daddr, u16 hnum, const int dif)
+struct sock *inet_lookup_run_sk_lookup(struct net *net,
+				       int protocol,
+				       struct sk_buff *skb, int doff,
+				       __be32 saddr, __be16 sport,
+				       __be32 daddr, u16 hnum, const int dif,
+				       inet_ehashfn_t *ehashfn)
 {
 	struct sock *sk, *reuse_sk;
 	bool no_reuseport;
 
-	if (hashinfo != net->ipv4.tcp_death_row.hashinfo)
-		return NULL; /* only TCP is supported */
-
-	no_reuseport = bpf_sk_lookup_run_v4(net, IPPROTO_TCP, saddr, sport,
+	no_reuseport = bpf_sk_lookup_run_v4(net, protocol, saddr, sport,
 					    daddr, hnum, dif, &sk);
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
 	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum,
-					 inet_ehashfn);
+					 ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
@@ -438,9 +436,11 @@ struct sock *__inet_lookup_listener(struct net *net,
 	unsigned int hash2;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
-		result = inet_lookup_run_bpf(net, hashinfo, skb, doff,
-					     saddr, sport, daddr, hnum, dif);
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
+	    hashinfo == net->ipv4.tcp_death_row.hashinfo) {
+		result = inet_lookup_run_sk_lookup(net, IPPROTO_TCP, skb, doff,
+						   saddr, sport, daddr, hnum, dif,
+						   inet_ehashfn);
 		if (result)
 			goto done;
 	}
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 7258edece691..eb79268f216d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -464,30 +464,6 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 	return result;
 }
 
-static struct sock *udp4_lookup_run_bpf(struct net *net,
-					struct udp_table *udptable,
-					struct sk_buff *skb,
-					__be32 saddr, __be16 sport,
-					__be32 daddr, u16 hnum, const int dif)
-{
-	struct sock *sk, *reuse_sk;
-	bool no_reuseport;
-
-	if (udptable != net->ipv4.udp_table)
-		return NULL; /* only UDP is supported */
-
-	no_reuseport = bpf_sk_lookup_run_v4(net, IPPROTO_UDP, saddr, sport,
-					    daddr, hnum, dif, &sk);
-	if (no_reuseport || IS_ERR_OR_NULL(sk))
-		return sk;
-
-	reuse_sk = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
-					 saddr, sport, daddr, hnum, udp_ehashfn);
-	if (reuse_sk)
-		sk = reuse_sk;
-	return sk;
-}
-
 /* UDP is nearly always wildcards out the wazoo, it makes no sense to try
  * harder than this. -DaveM
  */
@@ -512,9 +488,11 @@ struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr,
 		goto done;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
-		sk = udp4_lookup_run_bpf(net, udptable, skb,
-					 saddr, sport, daddr, hnum, dif);
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
+	    udptable == net->ipv4.udp_table) {
+		sk = inet_lookup_run_sk_lookup(net, IPPROTO_UDP, skb, sizeof(struct udphdr),
+					       saddr, sport, daddr, hnum, dif,
+					       udp_ehashfn);
 		if (sk) {
 			result = sk;
 			goto done;
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index d37602fabc00..f9653675f577 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -176,31 +176,30 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 	return result;
 }
 
-static inline struct sock *inet6_lookup_run_bpf(struct net *net,
-						struct inet_hashinfo *hashinfo,
-						struct sk_buff *skb, int doff,
-						const struct in6_addr *saddr,
-						const __be16 sport,
-						const struct in6_addr *daddr,
-						const u16 hnum, const int dif)
+struct sock *inet6_lookup_run_sk_lookup(struct net *net,
+					int protocol,
+					struct sk_buff *skb, int doff,
+					const struct in6_addr *saddr,
+					const __be16 sport,
+					const struct in6_addr *daddr,
+					const u16 hnum, const int dif,
+					inet6_ehashfn_t *ehashfn)
 {
 	struct sock *sk, *reuse_sk;
 	bool no_reuseport;
 
-	if (hashinfo != net->ipv4.tcp_death_row.hashinfo)
-		return NULL; /* only TCP is supported */
-
-	no_reuseport = bpf_sk_lookup_run_v6(net, IPPROTO_TCP, saddr, sport,
+	no_reuseport = bpf_sk_lookup_run_v6(net, protocol, saddr, sport,
 					    daddr, hnum, dif, &sk);
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
 	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
-					  saddr, sport, daddr, hnum, inet6_ehashfn);
+					  saddr, sport, daddr, hnum, ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
 }
+EXPORT_SYMBOL_GPL(inet6_lookup_run_sk_lookup);
 
 struct sock *inet6_lookup_listener(struct net *net,
 		struct inet_hashinfo *hashinfo,
@@ -214,9 +213,11 @@ struct sock *inet6_lookup_listener(struct net *net,
 	unsigned int hash2;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
-		result = inet6_lookup_run_bpf(net, hashinfo, skb, doff,
-					      saddr, sport, daddr, hnum, dif);
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
+	    hashinfo == net->ipv4.tcp_death_row.hashinfo) {
+		result = inet6_lookup_run_sk_lookup(net, IPPROTO_TCP, skb, doff,
+						    saddr, sport, daddr, hnum, dif,
+						    inet6_ehashfn);
 		if (result)
 			goto done;
 	}
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index ebac9200b15c..8a6d94cabee0 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -205,32 +205,6 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 	return result;
 }
 
-static inline struct sock *udp6_lookup_run_bpf(struct net *net,
-					       struct udp_table *udptable,
-					       struct sk_buff *skb,
-					       const struct in6_addr *saddr,
-					       __be16 sport,
-					       const struct in6_addr *daddr,
-					       u16 hnum, const int dif)
-{
-	struct sock *sk, *reuse_sk;
-	bool no_reuseport;
-
-	if (udptable != net->ipv4.udp_table)
-		return NULL; /* only UDP is supported */
-
-	no_reuseport = bpf_sk_lookup_run_v6(net, IPPROTO_UDP, saddr, sport,
-					    daddr, hnum, dif, &sk);
-	if (no_reuseport || IS_ERR_OR_NULL(sk))
-		return sk;
-
-	reuse_sk = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
-					  saddr, sport, daddr, hnum, udp6_ehashfn);
-	if (reuse_sk)
-		sk = reuse_sk;
-	return sk;
-}
-
 /* rcu_read_lock() must be held */
 struct sock *__udp6_lib_lookup(struct net *net,
 			       const struct in6_addr *saddr, __be16 sport,
@@ -255,9 +229,11 @@ struct sock *__udp6_lib_lookup(struct net *net,
 		goto done;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
-		sk = udp6_lookup_run_bpf(net, udptable, skb,
-					 saddr, sport, daddr, hnum, dif);
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
+	    udptable == net->ipv4.udp_table) {
+		sk = inet6_lookup_run_sk_lookup(net, IPPROTO_UDP, skb, sizeof(struct udphdr),
+						saddr, sport, daddr, hnum, dif,
+						udp6_ehashfn);
 		if (sk) {
 			result = sk;
 			goto done;

-- 
2.40.1

