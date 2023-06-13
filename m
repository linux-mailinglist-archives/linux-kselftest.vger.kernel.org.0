Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002AF72DEE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241683AbjFMKPO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 06:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241166AbjFMKPG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 06:15:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F0E18C
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 03:15:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30aeee7c8a0so3943129f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 03:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686651303; x=1689243303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUrpSFAbYZ/Kx7Q/Mv3h3i//CU/VSXI4LMvr8LpxmhI=;
        b=MZm+lUMh442N5nZ/uhW387Ax9a5HGiMbjKOfiGW7++VHHZ9fNpglFMWdrCpp2v6riw
         sobyQ75f3IBXtZNDOFy77OEvAUYu/OnletVtP75IFDwk8eQFzDq4oroAjdeQe99VSA1k
         MzRjWQ/74t8rr1G3Y+bl7J3zkJBhByUmO59klQSLimOpfXSd/e2Kk9Y+SmKz/hVE39N1
         O/os2vqai8U19jKcdBmyNP1N8KOplKS92StTHQ6HVg6EYdxvyql/ovQ1lN2nsK3p6cOn
         Xk0rJXhY6rbdPZtGHyXDBh4Vdcnp4e1EFtjyqu5SAQRkMUOAOENW4Buy2y5xxMTwWwFg
         6d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651303; x=1689243303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUrpSFAbYZ/Kx7Q/Mv3h3i//CU/VSXI4LMvr8LpxmhI=;
        b=LnRTk+5sHDbgI8hA405dB7DSsldf0/88/EjbW8lH9CHtZy+joMmDtf1HPsmhBLX/7r
         5rHNk4k/34nfLsvWIt5+hfsJ9j036gTPc0rXB4yU70vyHyAzjRFae7brTNjcFda0Kr+N
         3ACghHmWWm/vUQyr5vNblOwvK90lMuoswMYIs38qBcyijGek2JHWW3R1RmTcgwcsf5nA
         fXLGBgdskA6Hd2IS60Kd1s6IbacksAuZyW9Q/uj/K0W7e0XpXEKKdN/lOxvMkG0L6nyk
         g5N6nF/r+0RswrymBrHK1+rWbODdk6HXCtoF5ntcA2sz+v7Pt04iY/34B5Zgu0sLkifb
         iYfw==
X-Gm-Message-State: AC+VfDxqiV5DKSGmVw/+2+tPA4KeaXRcMORM1/QoIiivYRxZoNe6lL7T
        w/ihEFxgo6fh56lb4UMCFPwaPQ==
X-Google-Smtp-Source: ACHHUZ4msN9rPR8QjB8GX6d9AlgjceBhSGH+v0okKIS7YpeZbBLOGz8dcV1oT2JvqxkLyuOhfZ4ZHg==
X-Received: by 2002:a05:6000:10c2:b0:30f:bdad:19db with SMTP id b2-20020a05600010c200b0030fbdad19dbmr5016183wrx.10.1686651303389;
        Tue, 13 Jun 2023 03:15:03 -0700 (PDT)
Received: from [192.168.133.193] ([5.148.46.226])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6e8f000000b0030e6096afb6sm15075020wrz.12.2023.06.13.03.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:15:03 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 13 Jun 2023 11:14:59 +0100
Subject: [PATCH bpf-next v2 4/6] net: remove duplicate sk_lookup helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v2-4-b7c69a342613@isovalent.com>
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

Now that inet[6]_lookup_reuseport are parameterised on the ehashfn
we can remove two sk_lookup helpers.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 include/net/inet6_hashtables.h |  9 +++++++++
 include/net/inet_hashtables.h  |  7 +++++++
 net/ipv4/inet_hashtables.c     | 26 +++++++++++++-------------
 net/ipv4/udp.c                 | 32 +++++---------------------------
 net/ipv6/inet6_hashtables.c    | 30 +++++++++++++++---------------
 net/ipv6/udp.c                 | 34 +++++-----------------------------
 6 files changed, 54 insertions(+), 84 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 49d586454287..4d2a1a3c0be7 100644
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
+					inet6_ehashfn_t ehashfn);
+
 static inline struct sock *__inet6_lookup(struct net *net,
 					  struct inet_hashinfo *hashinfo,
 					  struct sk_buff *skb, int doff,
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 51ab6a1a3601..aa02f1db1f86 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -393,6 +393,13 @@ struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
 				   __be32 daddr, unsigned short hnum,
 				   inet_ehashfn_t ehashfn);
 
+struct sock *inet_lookup_run_sk_lookup(struct net *net,
+				       int protocol,
+				       struct sk_buff *skb, int doff,
+				       __be32 saddr, __be16 sport,
+				       __be32 daddr, u16 hnum, const int dif,
+				       inet_ehashfn_t ehashfn);
+
 static inline struct sock *
 	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
 				const __be32 saddr, const __be16 sport,
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 1ec895fd9905..47f57b060e9e 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -404,25 +404,23 @@ static struct sock *inet_lhash2_lookup(struct net *net,
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
+				       inet_ehashfn_t ehashfn)
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
@@ -440,9 +438,11 @@ struct sock *__inet_lookup_listener(struct net *net,
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
index 10468fe144d0..2500e92050a0 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -449,30 +449,6 @@ static struct sock *udp4_lib_lookup2(struct net *net,
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
@@ -497,9 +473,11 @@ struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr,
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
index a350ee40141c..80bf97669fc9 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -178,27 +178,25 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
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
+					inet6_ehashfn_t ehashfn)
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
@@ -216,9 +214,11 @@ struct sock *inet6_lookup_listener(struct net *net,
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
index 2af3a595f38a..961b7e61f02c 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -192,32 +192,6 @@ static struct sock *udp6_lib_lookup2(struct net *net,
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
@@ -242,9 +216,11 @@ struct sock *__udp6_lib_lookup(struct net *net,
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

