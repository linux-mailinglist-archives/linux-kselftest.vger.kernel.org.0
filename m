Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E68A73E744
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 20:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjFZSNR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjFZSMv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 14:12:51 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156392942;
        Mon, 26 Jun 2023 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687803136; x=1719339136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eSK17/Nu3oaFQ2VpG4P41G6xg6u1+jOi/ite1ltKpmI=;
  b=oxZgnOUmBSzcsiRRfrledeQclCoQnt2h0f5sycQikg3q334OjFbrI7wa
   KJ/me9HrJYSFsI+Axa3RIAhnXEBdjzclc1U3k5xdemj3xMyJ90WH0dI+j
   LYQpvVtCkGMJL/VcViY+4wl/4O0oy2QCCFzRrRUVqaQ5puq1uzHWz461v
   U=;
X-IronPort-AV: E=Sophos;i="6.01,160,1684800000"; 
   d="scan'208";a="347902966"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:12:10 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id 3F03D805EB;
        Mon, 26 Jun 2023 18:12:09 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 18:12:08 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Mon, 26 Jun 2023 18:12:04 +0000
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
Subject: Re: [PATCH bpf-next v3 4/7] net: remove duplicate reuseport_lookup functions
Date:   Mon, 26 Jun 2023 11:11:56 -0700
Message-ID: <20230626181156.62006-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613-so-reuseport-v3-4-907b4cbb7b99@isovalent.com>
References: <20230613-so-reuseport-v3-4-907b4cbb7b99@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.15]
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 26 Jun 2023 16:09:01 +0100
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
> ---
>  include/net/inet6_hashtables.h | 11 ++++++++++-
>  include/net/inet_hashtables.h  | 15 ++++++++++-----
>  include/net/udp.h              |  8 ++++++++
>  net/ipv4/inet_hashtables.c     | 23 ++++++++++++++++-------
>  net/ipv4/udp.c                 | 34 +++++++++++++---------------------
>  net/ipv6/inet6_hashtables.c    | 17 +++++++++++++----
>  net/ipv6/udp.c                 | 41 ++++++++++++++++-------------------------
>  7 files changed, 86 insertions(+), 63 deletions(-)
> 
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
> index 032ddab48f8f..49d586454287 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -48,12 +48,21 @@ struct sock *__inet6_lookup_established(struct net *net,
>  					const u16 hnum, const int dif,
>  					const int sdif);
>  
> +typedef u32 (*inet6_ehashfn_t)(const struct net *net,
> +			       const struct in6_addr *laddr, const u16 lport,
> +			       const struct in6_addr *faddr, const __be16 fport);
> +
> +u32 inet6_ehashfn(const struct net *net,
> +		  const struct in6_addr *laddr, const u16 lport,
> +		  const struct in6_addr *faddr, const __be16 fport);

Can we use inet6_ehashfn_t here ?

Same for .c file, IPv4, and UDP.


> +
>  struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
>  				    struct sk_buff *skb, int doff,
>  				    const struct in6_addr *saddr,
>  				    __be16 sport,
>  				    const struct in6_addr *daddr,
> -				    unsigned short hnum);
> +				    unsigned short hnum,
> +				    inet6_ehashfn_t ehashfn);
>  
>  struct sock *inet6_lookup_listener(struct net *net,
>  				   struct inet_hashinfo *hashinfo,
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> index 8734f3488f5d..51ab6a1a3601 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -379,10 +379,19 @@ struct sock *__inet_lookup_established(struct net *net,
>  				       const __be32 daddr, const u16 hnum,
>  				       const int dif, const int sdif);
>  
> +typedef u32 (*inet_ehashfn_t)(const struct net *net,
> +			      const __be32 laddr, const __u16 lport,
> +			      const __be32 faddr, const __be16 fport);
> +
> +u32 inet_ehashfn(const struct net *net,
> +		 const __be32 laddr, const __u16 lport,
> +		 const __be32 faddr, const __be16 fport);
> +
>  struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
>  				   struct sk_buff *skb, int doff,
>  				   __be32 saddr, __be16 sport,
> -				   __be32 daddr, unsigned short hnum);
> +				   __be32 daddr, unsigned short hnum,
> +				   inet_ehashfn_t ehashfn);
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
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 5cad44318d71..3b404b429f88 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -317,6 +317,14 @@ struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
>  				 __be16 sport, __be16 dport);
>  int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
>  
> +INDIRECT_CALLABLE_DECLARE(u32 udp_ehashfn(const struct net *,
> +					  const __be32, const __u16,
> +					  const __be32, const __be16));
> +
> +INDIRECT_CALLABLE_DECLARE(u32 udp6_ehashfn(const struct net *,
> +					   const struct in6_addr *, const u16,
> +					   const struct in6_addr *, const __be16));
> +
>  /* UDP uses skb->dev_scratch to cache as much information as possible and avoid
>   * possibly multiple cache miss on dequeue()
>   */
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 91f9210d4e83..0dd768ab22d9 100644
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
> @@ -332,6 +333,10 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> +INDIRECT_CALLABLE_DECLARE(u32 udp_ehashfn(const struct net *,
> +					  const __be32, const __u16,
> +					  const __be32, const __be16));
> +
>  /**
>   * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket if necessary.
>   * @net: network namespace.
> @@ -342,6 +347,7 @@ static inline int compute_score(struct sock *sk, struct net *net,
>   * @sport: source port.
>   * @daddr: destination address.
>   * @hnum: destination port in host byte order.
> + * @ehashfn: hash function used to generate the fallback hash.
>   *
>   * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
>   *         the selected sock or an error.
> @@ -349,13 +355,15 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
>  				   struct sk_buff *skb, int doff,
>  				   __be32 saddr, __be16 sport,
> -				   __be32 daddr, unsigned short hnum)
> +				   __be32 daddr, unsigned short hnum,
> +				   inet_ehashfn_t ehashfn)
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
> @@ -385,7 +393,7 @@ static struct sock *inet_lhash2_lookup(struct net *net,
>  		score = compute_score(sk, net, hnum, daddr, dif, sdif);
>  		if (score > hiscore) {
>  			result = inet_lookup_reuseport(net, sk, skb, doff,
> -						       saddr, sport, daddr, hnum);
> +						       saddr, sport, daddr, hnum, inet_ehashfn);
>  			if (result)
>  				return result;
>  
> @@ -414,7 +422,8 @@ static inline struct sock *inet_lookup_run_bpf(struct net *net,
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
> index 208998694ae3..b5de1642bc51 100644
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
> @@ -111,6 +112,10 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> +INDIRECT_CALLABLE_DECLARE(u32 udp6_ehashfn(const struct net *,
> +					   const struct in6_addr *, const u16,
> +					   const struct in6_addr *, const __be16));
> +
>  /**
>   * inet6_lookup_reuseport() - execute reuseport logic on AF_INET6 socket if necessary.
>   * @net: network namespace.
> @@ -121,6 +126,7 @@ static inline int compute_score(struct sock *sk, struct net *net,
>   * @sport: source port.
>   * @daddr: destination address.
>   * @hnum: destination port in host byte order.
> + * @ehashfn: hash function used to generate the fallback hash.
>   *
>   * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
>   *         the selected sock or an error.
> @@ -130,13 +136,15 @@ struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
>  				    const struct in6_addr *saddr,
>  				    __be16 sport,
>  				    const struct in6_addr *daddr,
> -				    unsigned short hnum)
> +				    unsigned short hnum,
> +				    inet6_ehashfn_t ehashfn)
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
> @@ -159,7 +167,7 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
>  		score = compute_score(sk, net, hnum, daddr, dif, sdif);
>  		if (score > hiscore) {
>  			result = inet6_lookup_reuseport(net, sk, skb, doff,
> -							saddr, sport, daddr, hnum);
> +							saddr, sport, daddr, hnum, inet6_ehashfn);
>  			if (result)
>  				return result;
>  
> @@ -190,7 +198,8 @@ static inline struct sock *inet6_lookup_run_bpf(struct net *net,
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
