Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A3875B2AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 17:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjGTPbR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 11:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjGTPbJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 11:31:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031192D6D
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 08:30:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-992e22c09edso141511166b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 08:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689867051; x=1690471851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVN2luy3B+9Q6ge9iBx/c//0gONdtx9S4ycDFM8bWek=;
        b=Jwv02r0nd1E24BZFqhqukpzG6hwVfgtNgpmWgBd9gSRL/0ViLxokNfxgr9PnV2OdcC
         Bsi5N5snlsfiGZIU+MOUEtfYI1srW8wjEy8kU1qGMTp7wwJxaCFGnpO55IH9AQHTyoSL
         4CtDXy0hVdWH/UwCZKQWoThBsMH3z5ixv0FmmI1Z7YJ+RHPEiNkwLBjH5F3y73tHHqr5
         t+c9z/jrDCI0FOBvsq5Nl0Y5rhT8PmO2egnF0uGmvU7C80ywdF3d3phQrq/myrJp4LyN
         rhT5K04T0VlbyMiUI+LR8urFzY8kltoD7k+7NVonJkxrRD9zA9KWgawMGl8vAdZalghg
         ejrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867051; x=1690471851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVN2luy3B+9Q6ge9iBx/c//0gONdtx9S4ycDFM8bWek=;
        b=mGkjixpvVzkziTjXDdQw5Sux90rVojp9SSd2MFrVCeA+UlZX4EgPBK4Bs63VHn0Nce
         cUja6Dh+9YmGC7rswhsvATQrrXk7c9sZLA30sdJ7V3o6ja+6bqP5PzgebCUaNTCGXhti
         3qxq2g25dXQLu5TVR3lu8in5G4C8gjlr/BA5em3aRu5m4MfY8pc1SSZSrAQ1Xzyb8OEA
         iG6/VRWKM3gulvkM3a7JjhBXVhaZr2U4egFRiwtzijZdFnN3kMZ7Ar+hWvEwDxZYCDKi
         SygGEcWcIcazI/kH0QdyA1fU6O86NQxKqQqtDeu3ofVfo1G7v/MNBXJo73xGAwROxSm1
         Sklg==
X-Gm-Message-State: ABy/qLaIFMsor/37Nrc0WJR8KJV70gDqJW+N5xlIQ8fjvXWyaYVFnFNG
        5aIofKasGuPFakAcOftGHL6Eng==
X-Google-Smtp-Source: APBJJlEejAwBqp1O03SRTW8ZwhZFdcLdInzVNO96F6P0IXsFQWUuCKXZSUSICV0Ux2zeKmwJ8onuxA==
X-Received: by 2002:a17:907:3e9a:b0:993:f90b:e549 with SMTP id hs26-20020a1709073e9a00b00993f90be549mr6818234ejc.37.1689867051359;
        Thu, 20 Jul 2023 08:30:51 -0700 (PDT)
Received: from [192.168.188.151] (p200300c1c7176000b788d2ebe49c4b82.dip0.t-ipconnect.de. [2003:c1:c717:6000:b788:d2eb:e49c:4b82])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906804a00b009893b06e9e3sm851007ejw.225.2023.07.20.08.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:30:51 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 20 Jul 2023 17:30:10 +0200
Subject: [PATCH bpf-next v6 6/8] net: remove duplicate sk_lookup helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-so-reuseport-v6-6-7021b683cdae@isovalent.com>
References: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
In-Reply-To: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
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
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 64fc1bd3fb63..75b1ed1b89f2 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -403,25 +403,23 @@ static struct sock *inet_lhash2_lookup(struct net *net,
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
@@ -439,9 +437,11 @@ struct sock *__inet_lookup_listener(struct net *net,
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
index 55f683b31c93..045eca6ed177 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -465,30 +465,6 @@ static struct sock *udp4_lib_lookup2(struct net *net,
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
@@ -513,9 +489,11 @@ struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr,
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
index f76dbbb29332..7c9700c7c9c8 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -177,31 +177,30 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
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
@@ -215,9 +214,11 @@ struct sock *inet6_lookup_listener(struct net *net,
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
index a65f8d72543d..109f14b17a09 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -206,32 +206,6 @@ static struct sock *udp6_lib_lookup2(struct net *net,
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
@@ -256,9 +230,11 @@ struct sock *__udp6_lib_lookup(struct net *net,
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
2.41.0

