Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0127F74180D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 20:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjF1SdW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 14:33:22 -0400
Received: from smtp-fw-9106.amazon.com ([207.171.188.206]:48096 "EHLO
        smtp-fw-9106.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjF1SdV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 14:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687977202; x=1719513202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dbBTEYDPjFE8oKNWOHth2ymdjwkx8nOAMSa/Kr6zII8=;
  b=Im+TeCEJmQpRzbM3/R74S54LjZsu1nlHOMYfZ24BdbsfykC1h1hVaYFn
   o8L1oHLMoF7JGPSR8xHpo8dMlmkPqoY5zbFRyIQZQg6/hNf7PcMi6aGVL
   U2jJyUX2VNu4pUm0UCb2Y27EsAIb88uuB0xZXubzJp0rSoRzg7/sNbcmm
   s=;
X-IronPort-AV: E=Sophos;i="6.01,166,1684800000"; 
   d="scan'208";a="656859080"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 18:33:16 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com (Postfix) with ESMTPS id 2070640D41;
        Wed, 28 Jun 2023 18:33:14 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 18:33:13 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 28 Jun 2023 18:33:08 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <lmb@isovalent.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>,
        <dsahern@kernel.org>, <edumazet@google.com>, <haoluo@google.com>,
        <hemanthmalla@gmail.com>, <joe@wand.net.nz>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kpsingh@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <martin.lau@linux.dev>, <mykolal@fb.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <sdf@google.com>, <shuah@kernel.org>,
        <song@kernel.org>, <willemdebruijn.kernel@gmail.com>, <yhs@fb.com>
Subject: Re: [PATCH bpf-next v4 3/7] net: remove duplicate reuseport_lookup functions
Date:   Wed, 28 Jun 2023 11:32:58 -0700
Message-ID: <20230628183258.74704-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613-so-reuseport-v4-3-4ece76708bba@isovalent.com>
References: <20230613-so-reuseport-v4-3-4ece76708bba@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.50]
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 28 Jun 2023 10:48:18 +0100
> There are currently four copies of reuseport_lookup: one each for
> (TCP, UDP)x(IPv4, IPv6). This forces us to duplicate all callers of
> those functions as well. This is already the case for sk_lookup
> helpers (inet,inet6,udp4,udp6)_lookup_run_bpf.
> 
> There are two differences between the reuseport_lookup helpers:
> 
> 1. They call different hash functions depending on protocol
> 2. UDP reuseport_lookup checks that sk_state != TCP_ESTABLISHED
> 
> Move the check for sk_state into the caller and use the INDIRECT_CALL
> infrastructure to cut down the helpers to one per IP version.
> 
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

2 nits below.


> ---
>  include/net/inet6_hashtables.h | 11 ++++++++++-
>  include/net/inet_hashtables.h  | 15 ++++++++++-----
>  net/ipv4/inet_hashtables.c     | 20 +++++++++++++-------
>  net/ipv4/udp.c                 | 34 +++++++++++++---------------------
>  net/ipv6/inet6_hashtables.c    | 14 ++++++++++----
>  net/ipv6/udp.c                 | 41 ++++++++++++++++-------------------------
>  6 files changed, 72 insertions(+), 63 deletions(-)
> 
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
> index 032ddab48f8f..f89320b6fee3 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -48,12 +48,21 @@ struct sock *__inet6_lookup_established(struct net *net,
>  					const u16 hnum, const int dif,
>  					const int sdif);
>  
> +typedef u32 (inet6_ehashfn_t)(const struct net *net,
> +			       const struct in6_addr *laddr, const u16 lport,
> +			       const struct in6_addr *faddr, const __be16 fport);
> +
> +inet6_ehashfn_t inet6_ehashfn;
> +
> +INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);

We need not define udp6_ehashfn() here as inet6_hashtables.c has
the definition.

Only inet6_ehashfn() is needed because sk_ehashfn() uses it.


> +
>  struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
>  				    struct sk_buff *skb, int doff,
>  				    const struct in6_addr *saddr,
>  				    __be16 sport,
>  				    const struct in6_addr *daddr,
> -				    unsigned short hnum);
> +				    unsigned short hnum,
> +				    inet6_ehashfn_t *ehashfn);
>  
>  struct sock *inet6_lookup_listener(struct net *net,
>  				   struct inet_hashinfo *hashinfo,
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> index 8734f3488f5d..ddfa2e67fdb5 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -379,10 +379,19 @@ struct sock *__inet_lookup_established(struct net *net,
>  				       const __be32 daddr, const u16 hnum,
>  				       const int dif, const int sdif);
>  
> +typedef u32 (inet_ehashfn_t)(const struct net *net,
> +			      const __be32 laddr, const __u16 lport,
> +			      const __be32 faddr, const __be16 fport);
> +
> +inet_ehashfn_t inet_ehashfn;
> +
> +INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
> +

We don't need inet_ehashfn() and udp_ehashfn() declarations here.


>  struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
>  				   struct sk_buff *skb, int doff,
>  				   __be32 saddr, __be16 sport,
> -				   __be32 daddr, unsigned short hnum);
> +				   __be32 daddr, unsigned short hnum,
> +				   inet_ehashfn_t *ehashfn);
>  
>  static inline struct sock *
>  	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
> @@ -453,10 +462,6 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
>  			     refcounted);
>  }
>  
> -u32 inet6_ehashfn(const struct net *net,
> -		  const struct in6_addr *laddr, const u16 lport,
> -		  const struct in6_addr *faddr, const __be16 fport);
> -
>  static inline void sk_daddr_set(struct sock *sk, __be32 addr)
>  {
>  	sk->sk_daddr = addr; /* alias of inet_daddr */
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 920131e4a65d..352eb371c93b 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -28,9 +28,9 @@
>  #include <net/tcp.h>
>  #include <net/sock_reuseport.h>
>  
> -static u32 inet_ehashfn(const struct net *net, const __be32 laddr,
> -			const __u16 lport, const __be32 faddr,
> -			const __be16 fport)
> +u32 inet_ehashfn(const struct net *net, const __be32 laddr,
> +		 const __u16 lport, const __be32 faddr,
> +		 const __be16 fport)
>  {
>  	static u32 inet_ehash_secret __read_mostly;
>  
> @@ -39,6 +39,7 @@ static u32 inet_ehashfn(const struct net *net, const __be32 laddr,
>  	return __inet_ehashfn(laddr, lport, faddr, fport,
>  			      inet_ehash_secret + net_hash_mix(net));
>  }
> +EXPORT_SYMBOL_GPL(inet_ehashfn);
>  
>  /* This function handles inet_sock, but also timewait and request sockets
>   * for IPv4/IPv6.
> @@ -332,16 +333,20 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> +INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
> +
>  struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
>  				   struct sk_buff *skb, int doff,
>  				   __be32 saddr, __be16 sport,
> -				   __be32 daddr, unsigned short hnum)
> +				   __be32 daddr, unsigned short hnum,
> +				   inet_ehashfn_t *ehashfn)
>  {
>  	struct sock *reuse_sk = NULL;
>  	u32 phash;
>  
>  	if (sk->sk_reuseport) {
> -		phash = inet_ehashfn(net, daddr, hnum, saddr, sport);
> +		phash = INDIRECT_CALL_2(ehashfn, udp_ehashfn, inet_ehashfn,
> +					net, daddr, hnum, saddr, sport);
>  		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
>  	}
>  	return reuse_sk;
> @@ -371,7 +376,7 @@ static struct sock *inet_lhash2_lookup(struct net *net,
>  		score = compute_score(sk, net, hnum, daddr, dif, sdif);
>  		if (score > hiscore) {
>  			result = inet_lookup_reuseport(net, sk, skb, doff,
> -						       saddr, sport, daddr, hnum);
> +						       saddr, sport, daddr, hnum, inet_ehashfn);
>  			if (result)
>  				return result;
>  
> @@ -400,7 +405,8 @@ static inline struct sock *inet_lookup_run_bpf(struct net *net,
>  	if (no_reuseport || IS_ERR_OR_NULL(sk))
>  		return sk;
>  
> -	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
> +	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum,
> +					 inet_ehashfn);
>  	if (reuse_sk)
>  		sk = reuse_sk;
>  	return sk;
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 5ef478d2c408..7258edece691 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -405,9 +405,9 @@ static int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> -static u32 udp_ehashfn(const struct net *net, const __be32 laddr,
> -		       const __u16 lport, const __be32 faddr,
> -		       const __be16 fport)
> +INDIRECT_CALLABLE_SCOPE
> +u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
> +		const __be32 faddr, const __be16 fport)
>  {
>  	static u32 udp_ehash_secret __read_mostly;
>  
> @@ -417,22 +417,6 @@ static u32 udp_ehashfn(const struct net *net, const __be32 laddr,
>  			      udp_ehash_secret + net_hash_mix(net));
>  }
>  
> -static struct sock *lookup_reuseport(struct net *net, struct sock *sk,
> -				     struct sk_buff *skb,
> -				     __be32 saddr, __be16 sport,
> -				     __be32 daddr, unsigned short hnum)
> -{
> -	struct sock *reuse_sk = NULL;
> -	u32 hash;
> -
> -	if (sk->sk_reuseport && sk->sk_state != TCP_ESTABLISHED) {
> -		hash = udp_ehashfn(net, daddr, hnum, saddr, sport);
> -		reuse_sk = reuseport_select_sock(sk, hash, skb,
> -						 sizeof(struct udphdr));
> -	}
> -	return reuse_sk;
> -}
> -
>  /* called with rcu_read_lock() */
>  static struct sock *udp4_lib_lookup2(struct net *net,
>  				     __be32 saddr, __be16 sport,
> @@ -451,7 +435,14 @@ static struct sock *udp4_lib_lookup2(struct net *net,
>  				      daddr, hnum, dif, sdif);
>  		if (score > badness) {
>  			badness = score;
> -			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
> +
> +			if (sk->sk_state == TCP_ESTABLISHED) {
> +				result = sk;
> +				continue;
> +			}
> +
> +			result = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
> +						       saddr, sport, daddr, hnum, udp_ehashfn);
>  			if (!result) {
>  				result = sk;
>  				continue;
> @@ -490,7 +481,8 @@ static struct sock *udp4_lookup_run_bpf(struct net *net,
>  	if (no_reuseport || IS_ERR_OR_NULL(sk))
>  		return sk;
>  
> -	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
> +	reuse_sk = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
> +					 saddr, sport, daddr, hnum, udp_ehashfn);
>  	if (reuse_sk)
>  		sk = reuse_sk;
>  	return sk;
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index b7c56867314e..3616225c89ef 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -39,6 +39,7 @@ u32 inet6_ehashfn(const struct net *net,
>  	return __inet6_ehashfn(lhash, lport, fhash, fport,
>  			       inet6_ehash_secret + net_hash_mix(net));
>  }
> +EXPORT_SYMBOL_GPL(inet6_ehashfn);
>  
>  /*
>   * Sockets in TCP_CLOSE state are _always_ taken out of the hash, so
> @@ -111,18 +112,22 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> +INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
> +
>  struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
>  				    struct sk_buff *skb, int doff,
>  				    const struct in6_addr *saddr,
>  				    __be16 sport,
>  				    const struct in6_addr *daddr,
> -				    unsigned short hnum)
> +				    unsigned short hnum,
> +				    inet6_ehashfn_t *ehashfn)
>  {
>  	struct sock *reuse_sk = NULL;
>  	u32 phash;
>  
>  	if (sk->sk_reuseport) {
> -		phash = inet6_ehashfn(net, daddr, hnum, saddr, sport);
> +		phash = INDIRECT_CALL_INET(ehashfn, udp6_ehashfn, inet6_ehashfn,
> +					   net, daddr, hnum, saddr, sport);
>  		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
>  	}
>  	return reuse_sk;
> @@ -145,7 +150,7 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
>  		score = compute_score(sk, net, hnum, daddr, dif, sdif);
>  		if (score > hiscore) {
>  			result = inet6_lookup_reuseport(net, sk, skb, doff,
> -							saddr, sport, daddr, hnum);
> +							saddr, sport, daddr, hnum, inet6_ehashfn);
>  			if (result)
>  				return result;
>  
> @@ -176,7 +181,8 @@ static inline struct sock *inet6_lookup_run_bpf(struct net *net,
>  	if (no_reuseport || IS_ERR_OR_NULL(sk))
>  		return sk;
>  
> -	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
> +	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
> +					  saddr, sport, daddr, hnum, inet6_ehashfn);
>  	if (reuse_sk)
>  		sk = reuse_sk;
>  	return sk;
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 8b3cb1d7da7c..ebac9200b15c 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -70,11 +70,12 @@ int udpv6_init_sock(struct sock *sk)
>  	return 0;
>  }
>  
> -static u32 udp6_ehashfn(const struct net *net,
> -			const struct in6_addr *laddr,
> -			const u16 lport,
> -			const struct in6_addr *faddr,
> -			const __be16 fport)
> +INDIRECT_CALLABLE_SCOPE
> +u32 udp6_ehashfn(const struct net *net,
> +		 const struct in6_addr *laddr,
> +		 const u16 lport,
> +		 const struct in6_addr *faddr,
> +		 const __be16 fport)
>  {
>  	static u32 udp6_ehash_secret __read_mostly;
>  	static u32 udp_ipv6_hash_secret __read_mostly;
> @@ -159,24 +160,6 @@ static int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> -static struct sock *lookup_reuseport(struct net *net, struct sock *sk,
> -				     struct sk_buff *skb,
> -				     const struct in6_addr *saddr,
> -				     __be16 sport,
> -				     const struct in6_addr *daddr,
> -				     unsigned int hnum)
> -{
> -	struct sock *reuse_sk = NULL;
> -	u32 hash;
> -
> -	if (sk->sk_reuseport && sk->sk_state != TCP_ESTABLISHED) {
> -		hash = udp6_ehashfn(net, daddr, hnum, saddr, sport);
> -		reuse_sk = reuseport_select_sock(sk, hash, skb,
> -						 sizeof(struct udphdr));
> -	}
> -	return reuse_sk;
> -}
> -
>  /* called with rcu_read_lock() */
>  static struct sock *udp6_lib_lookup2(struct net *net,
>  		const struct in6_addr *saddr, __be16 sport,
> @@ -194,7 +177,14 @@ static struct sock *udp6_lib_lookup2(struct net *net,
>  				      daddr, hnum, dif, sdif);
>  		if (score > badness) {
>  			badness = score;
> -			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
> +
> +			if (sk->sk_state == TCP_ESTABLISHED) {
> +				result = sk;
> +				continue;
> +			}
> +
> +			result = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
> +							saddr, sport, daddr, hnum, udp6_ehashfn);
>  			if (!result) {
>  				result = sk;
>  				continue;
> @@ -234,7 +224,8 @@ static inline struct sock *udp6_lookup_run_bpf(struct net *net,
>  	if (no_reuseport || IS_ERR_OR_NULL(sk))
>  		return sk;
>  
> -	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
> +	reuse_sk = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
> +					  saddr, sport, daddr, hnum, udp6_ehashfn);
>  	if (reuse_sk)
>  		sk = reuse_sk;
>  	return sk;
> 
> -- 
> 2.40.1
