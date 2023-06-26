Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4E073E2D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjFZPJZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 11:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjFZPJW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 11:09:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F0E10C2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 08:09:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-313e1c27476so1811854f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687792157; x=1690384157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5hvZWbrd4Kzqcl+2Bmi5kP9FC3uv1kKB+RjaEZXL14=;
        b=aQfj69jbsyUHrywXTqq37w0hjak+YvblQhu8IG5xe+bedOWlweciFVBqgx+tpg9PiM
         XP/56gzcKSrMIrdyfSRWxHMYZ/ZcDgMxMY+lfv+7D91teDqnABbqloMA2aHdByYEAikf
         prINqqXV+QRF1f9aZWBEW9IYb4myj1XnzdSDXVv1QC4DjumGrzEQ22MfBm/4xl0O4uLJ
         So0E2It6ySURI0QrhTOQJibDkynLl0ySfs1/Wx3UKfH96Cp6PScpj66x/ufb0v2oFO8H
         XAyIrfpeo86waez8vWLfgTfT1myXRIWvV2q5efkwxUHzBeEqx6IZ48nxOqzn6wy7SV4X
         rHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687792157; x=1690384157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5hvZWbrd4Kzqcl+2Bmi5kP9FC3uv1kKB+RjaEZXL14=;
        b=W3uPOjAi0pbxsMzXh6jBX9wqKptYBgueECWh38Tc0y58aFBdKC9la4h02feEoBqJUS
         Kua/FEbKV0y3RzuVjyzHJA7yf/YKEvjQbQHsaRSHR6081wvcQh0RIEyP5hVI/MgdRjUM
         3XxOpH77jZtub6KqCPGQHToVNtQkSU+SzZpl3cDd5uT4xV69+hJudMHm8rWZkO9+sZYn
         iwnXJkS83SGFCO24BOzWBFAf2UPPWQtYj39sNzW/CpQ6CmxXT4W1srZKouEW+XPSwAe8
         koMp46Ytb3zT+Aj5hWxhLkoed01XEuuhnanGRj1efNvc4mZx2HU7R0HuMXiz8mQYUXEU
         pExw==
X-Gm-Message-State: AC+VfDwBVbcbjkbKKD6N7Fyaprl9Eq2Yvdd6anHL+movAsqxVxGyfH98
        PvbGe3IgO+K1wDT4EiLOJ6T2Dg==
X-Google-Smtp-Source: ACHHUZ4ffZqPDmSHPF4zFCELjwWOxBcCOS8KxRDBBqlnTonCFtQ8Pi+XzTFWY17UcD+q73SSEWU2Yg==
X-Received: by 2002:adf:f443:0:b0:313:f0a7:133a with SMTP id f3-20020adff443000000b00313f0a7133amr3416428wrp.13.1687792157677;
        Mon, 26 Jun 2023 08:09:17 -0700 (PDT)
Received: from [192.168.1.193] (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id v1-20020adfe281000000b00311299df211sm7668710wri.77.2023.06.26.08.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:09:17 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Mon, 26 Jun 2023 16:09:02 +0100
Subject: [PATCH bpf-next v3 5/7] net: remove duplicate sk_lookup helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v3-5-907b4cbb7b99@isovalent.com>
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

Now that inet[6]_lookup_reuseport are parameterised on the ehashfn
we can remove two sk_lookup helpers.

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
index 0dd768ab22d9..34e44a096795 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -405,25 +405,23 @@ static struct sock *inet_lhash2_lookup(struct net *net,
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
@@ -441,9 +439,11 @@ struct sock *__inet_lookup_listener(struct net *net,
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
index b5de1642bc51..e908aa3cb7ea 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -179,31 +179,30 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
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
 }
+EXPORT_SYMBOL_GPL(inet6_lookup_run_sk_lookup);
 
 struct sock *inet6_lookup_listener(struct net *net,
 		struct inet_hashinfo *hashinfo,
@@ -217,9 +216,11 @@ struct sock *inet6_lookup_listener(struct net *net,
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

