Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53173EB73
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 22:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjFZUEA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 16:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjFZUDn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 16:03:43 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBEC2940;
        Mon, 26 Jun 2023 13:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687809801; x=1719345801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nqaoi3Cyia2kgM9EB/SIf9EIHf/ApdjE+FZSiJFCs90=;
  b=BaV5Y8mrsOR9T8Ep6S5GtvoAWe8vZMDncYGY+Y4T+5atwKlcA2cLav3t
   Z6qvhitj+BLoUOs7XAk0O5X/mC7VTPZ2NKqU+pRrmRpLjQsqI2F2UZHLh
   qAG8EjI5sAQIqoAlvtTNT/Iw22R6avu7nNKzHtBQJhHsTxgv8Sn80I8Dd
   0=;
X-IronPort-AV: E=Sophos;i="6.01,160,1684800000"; 
   d="scan'208";a="12592082"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 20:03:16 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com (Postfix) with ESMTPS id 530004654A;
        Mon, 26 Jun 2023 20:03:10 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 20:02:52 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 26 Jun 2023 20:02:48 +0000
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
Subject: Re: [PATCH bpf-next v3 5/7] net: remove duplicate sk_lookup helpers
Date:   Mon, 26 Jun 2023 13:02:38 -0700
Message-ID: <20230626200238.75316-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613-so-reuseport-v3-5-907b4cbb7b99@isovalent.com>
References: <20230613-so-reuseport-v3-5-907b4cbb7b99@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.15]
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 26 Jun 2023 16:09:02 +0100
> Now that inet[6]_lookup_reuseport are parameterised on the ehashfn
> we can remove two sk_lookup helpers.
> 
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  include/net/inet6_hashtables.h |  9 +++++++++
>  include/net/inet_hashtables.h  |  7 +++++++
>  net/ipv4/inet_hashtables.c     | 26 +++++++++++++-------------
>  net/ipv4/udp.c                 | 32 +++++---------------------------
>  net/ipv6/inet6_hashtables.c    | 31 ++++++++++++++++---------------
>  net/ipv6/udp.c                 | 34 +++++-----------------------------
>  6 files changed, 55 insertions(+), 84 deletions(-)
> 
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
> index 49d586454287..4d2a1a3c0be7 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -73,6 +73,15 @@ struct sock *inet6_lookup_listener(struct net *net,
>  				   const unsigned short hnum,
>  				   const int dif, const int sdif);
>  
> +struct sock *inet6_lookup_run_sk_lookup(struct net *net,
> +					int protocol,
> +					struct sk_buff *skb, int doff,
> +					const struct in6_addr *saddr,
> +					const __be16 sport,
> +					const struct in6_addr *daddr,
> +					const u16 hnum, const int dif,
> +					inet6_ehashfn_t ehashfn);
> +
>  static inline struct sock *__inet6_lookup(struct net *net,
>  					  struct inet_hashinfo *hashinfo,
>  					  struct sk_buff *skb, int doff,
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> index 51ab6a1a3601..aa02f1db1f86 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -393,6 +393,13 @@ struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
>  				   __be32 daddr, unsigned short hnum,
>  				   inet_ehashfn_t ehashfn);
>  
> +struct sock *inet_lookup_run_sk_lookup(struct net *net,
> +				       int protocol,
> +				       struct sk_buff *skb, int doff,
> +				       __be32 saddr, __be16 sport,
> +				       __be32 daddr, u16 hnum, const int dif,
> +				       inet_ehashfn_t ehashfn);
> +
>  static inline struct sock *
>  	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
>  				const __be32 saddr, const __be16 sport,
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 0dd768ab22d9..34e44a096795 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -405,25 +405,23 @@ static struct sock *inet_lhash2_lookup(struct net *net,
>  	return result;
>  }
>  
> -static inline struct sock *inet_lookup_run_bpf(struct net *net,
> -					       struct inet_hashinfo *hashinfo,
> -					       struct sk_buff *skb, int doff,
> -					       __be32 saddr, __be16 sport,
> -					       __be32 daddr, u16 hnum, const int dif)
> +struct sock *inet_lookup_run_sk_lookup(struct net *net,
> +				       int protocol,
> +				       struct sk_buff *skb, int doff,
> +				       __be32 saddr, __be16 sport,
> +				       __be32 daddr, u16 hnum, const int dif,
> +				       inet_ehashfn_t ehashfn)
>  {
>  	struct sock *sk, *reuse_sk;
>  	bool no_reuseport;
>  
> -	if (hashinfo != net->ipv4.tcp_death_row.hashinfo)
> -		return NULL; /* only TCP is supported */
> -
> -	no_reuseport = bpf_sk_lookup_run_v4(net, IPPROTO_TCP, saddr, sport,
> +	no_reuseport = bpf_sk_lookup_run_v4(net, protocol, saddr, sport,
>  					    daddr, hnum, dif, &sk);
>  	if (no_reuseport || IS_ERR_OR_NULL(sk))
>  		return sk;
>  
>  	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum,
> -					 inet_ehashfn);
> +					 ehashfn);
>  	if (reuse_sk)
>  		sk = reuse_sk;
>  	return sk;
> @@ -441,9 +439,11 @@ struct sock *__inet_lookup_listener(struct net *net,
>  	unsigned int hash2;
>  
>  	/* Lookup redirect from BPF */
> -	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
> -		result = inet_lookup_run_bpf(net, hashinfo, skb, doff,
> -					     saddr, sport, daddr, hnum, dif);
> +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> +	    hashinfo == net->ipv4.tcp_death_row.hashinfo) {
> +		result = inet_lookup_run_sk_lookup(net, IPPROTO_TCP, skb, doff,
> +						   saddr, sport, daddr, hnum, dif,
> +						   inet_ehashfn);
>  		if (result)
>  			goto done;
>  	}
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 7258edece691..eb79268f216d 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -464,30 +464,6 @@ static struct sock *udp4_lib_lookup2(struct net *net,
>  	return result;
>  }
>  
> -static struct sock *udp4_lookup_run_bpf(struct net *net,
> -					struct udp_table *udptable,
> -					struct sk_buff *skb,
> -					__be32 saddr, __be16 sport,
> -					__be32 daddr, u16 hnum, const int dif)
> -{
> -	struct sock *sk, *reuse_sk;
> -	bool no_reuseport;
> -
> -	if (udptable != net->ipv4.udp_table)
> -		return NULL; /* only UDP is supported */
> -
> -	no_reuseport = bpf_sk_lookup_run_v4(net, IPPROTO_UDP, saddr, sport,
> -					    daddr, hnum, dif, &sk);
> -	if (no_reuseport || IS_ERR_OR_NULL(sk))
> -		return sk;
> -
> -	reuse_sk = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
> -					 saddr, sport, daddr, hnum, udp_ehashfn);
> -	if (reuse_sk)
> -		sk = reuse_sk;
> -	return sk;
> -}
> -
>  /* UDP is nearly always wildcards out the wazoo, it makes no sense to try
>   * harder than this. -DaveM
>   */
> @@ -512,9 +488,11 @@ struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr,
>  		goto done;
>  
>  	/* Lookup redirect from BPF */
> -	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
> -		sk = udp4_lookup_run_bpf(net, udptable, skb,
> -					 saddr, sport, daddr, hnum, dif);
> +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> +	    udptable == net->ipv4.udp_table) {
> +		sk = inet_lookup_run_sk_lookup(net, IPPROTO_UDP, skb, sizeof(struct udphdr),
> +					       saddr, sport, daddr, hnum, dif,
> +					       udp_ehashfn);
>  		if (sk) {
>  			result = sk;
>  			goto done;
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index b5de1642bc51..e908aa3cb7ea 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -179,31 +179,30 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
>  	return result;
>  }
>  
> -static inline struct sock *inet6_lookup_run_bpf(struct net *net,
> -						struct inet_hashinfo *hashinfo,
> -						struct sk_buff *skb, int doff,
> -						const struct in6_addr *saddr,
> -						const __be16 sport,
> -						const struct in6_addr *daddr,
> -						const u16 hnum, const int dif)
> +struct sock *inet6_lookup_run_sk_lookup(struct net *net,
> +					int protocol,
> +					struct sk_buff *skb, int doff,
> +					const struct in6_addr *saddr,
> +					const __be16 sport,
> +					const struct in6_addr *daddr,
> +					const u16 hnum, const int dif,
> +					inet6_ehashfn_t ehashfn)
>  {
>  	struct sock *sk, *reuse_sk;
>  	bool no_reuseport;
>  
> -	if (hashinfo != net->ipv4.tcp_death_row.hashinfo)
> -		return NULL; /* only TCP is supported */
> -
> -	no_reuseport = bpf_sk_lookup_run_v6(net, IPPROTO_TCP, saddr, sport,
> +	no_reuseport = bpf_sk_lookup_run_v6(net, protocol, saddr, sport,
>  					    daddr, hnum, dif, &sk);
>  	if (no_reuseport || IS_ERR_OR_NULL(sk))
>  		return sk;
>  
>  	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
> -					  saddr, sport, daddr, hnum, inet6_ehashfn);
> +					  saddr, sport, daddr, hnum, ehashfn);
>  	if (reuse_sk)
>  		sk = reuse_sk;
>  	return sk;
>  }
> +EXPORT_SYMBOL_GPL(inet6_lookup_run_sk_lookup);
>  
>  struct sock *inet6_lookup_listener(struct net *net,
>  		struct inet_hashinfo *hashinfo,
> @@ -217,9 +216,11 @@ struct sock *inet6_lookup_listener(struct net *net,
>  	unsigned int hash2;
>  
>  	/* Lookup redirect from BPF */
> -	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
> -		result = inet6_lookup_run_bpf(net, hashinfo, skb, doff,
> -					      saddr, sport, daddr, hnum, dif);
> +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> +	    hashinfo == net->ipv4.tcp_death_row.hashinfo) {
> +		result = inet6_lookup_run_sk_lookup(net, IPPROTO_TCP, skb, doff,
> +						    saddr, sport, daddr, hnum, dif,
> +						    inet6_ehashfn);
>  		if (result)
>  			goto done;
>  	}
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index ebac9200b15c..8a6d94cabee0 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -205,32 +205,6 @@ static struct sock *udp6_lib_lookup2(struct net *net,
>  	return result;
>  }
>  
> -static inline struct sock *udp6_lookup_run_bpf(struct net *net,
> -					       struct udp_table *udptable,
> -					       struct sk_buff *skb,
> -					       const struct in6_addr *saddr,
> -					       __be16 sport,
> -					       const struct in6_addr *daddr,
> -					       u16 hnum, const int dif)
> -{
> -	struct sock *sk, *reuse_sk;
> -	bool no_reuseport;
> -
> -	if (udptable != net->ipv4.udp_table)
> -		return NULL; /* only UDP is supported */
> -
> -	no_reuseport = bpf_sk_lookup_run_v6(net, IPPROTO_UDP, saddr, sport,
> -					    daddr, hnum, dif, &sk);
> -	if (no_reuseport || IS_ERR_OR_NULL(sk))
> -		return sk;
> -
> -	reuse_sk = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
> -					  saddr, sport, daddr, hnum, udp6_ehashfn);
> -	if (reuse_sk)
> -		sk = reuse_sk;
> -	return sk;
> -}
> -
>  /* rcu_read_lock() must be held */
>  struct sock *__udp6_lib_lookup(struct net *net,
>  			       const struct in6_addr *saddr, __be16 sport,
> @@ -255,9 +229,11 @@ struct sock *__udp6_lib_lookup(struct net *net,
>  		goto done;
>  
>  	/* Lookup redirect from BPF */
> -	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
> -		sk = udp6_lookup_run_bpf(net, udptable, skb,
> -					 saddr, sport, daddr, hnum, dif);
> +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> +	    udptable == net->ipv4.udp_table) {
> +		sk = inet6_lookup_run_sk_lookup(net, IPPROTO_UDP, skb, sizeof(struct udphdr),
> +						saddr, sport, daddr, hnum, dif,
> +						udp6_ehashfn);
>  		if (sk) {
>  			result = sk;
>  			goto done;
> 
> -- 
> 2.40.1
