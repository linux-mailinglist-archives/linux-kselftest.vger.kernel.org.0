Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A21874181E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 20:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjF1SkU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 14:40:20 -0400
Received: from smtp-fw-80006.amazon.com ([99.78.197.217]:54882 "EHLO
        smtp-fw-80006.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjF1SkT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 14:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687977620; x=1719513620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BL4ULAFej05+WRV13/0IUuXBJpcZCjd4OTT8VyAGeUo=;
  b=md69R2XKNtIInjnpodcnZ8ZCRoSl0TFUSxMBAnm0cudPbrsS7/PTXU4u
   K+PU8b/s2nIyom7cMzaFy+BQT1S6xCoHI+DbQs4ZToD9q9taXhaNuP9wG
   yfPU5h6TDJvVgBe3vELVjWFjI+iml6KDWvNL8Y0ntwCzpCVKCD3Eclx0t
   s=;
X-IronPort-AV: E=Sophos;i="6.01,166,1684800000"; 
   d="scan'208";a="223422365"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 18:40:16 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com (Postfix) with ESMTPS id 1B2B7805E6;
        Wed, 28 Jun 2023 18:40:08 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 18:40:04 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 28 Jun 2023 18:39:59 +0000
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
Subject: Re: [PATCH bpf-next v4 4/7] net: document inet[6]_lookup_reuseport sk_state requirements
Date:   Wed, 28 Jun 2023 11:39:50 -0700
Message-ID: <20230628183950.75449-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613-so-reuseport-v4-4-4ece76708bba@isovalent.com>
References: <20230613-so-reuseport-v4-4-4ece76708bba@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.50]
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 28 Jun 2023 10:48:19 +0100
> The current implementation was extracted from inet[6]_lhash2_lookup
> in commit 80b373f74f9e ("inet: Extract helper for selecting socket
> from reuseport group") and commit 5df6531292b5 ("inet6: Extract helper
> for selecting socket from reuseport group"). In the original context,
> sk is always in TCP_LISTEN state and so did not have a separate check.
> 
> Add documentation that specifies which sk_state are valid to pass to
> the function.
> 
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

2 nit below.


> ---
>  net/ipv4/inet_hashtables.c  | 14 ++++++++++++++
>  net/ipv6/inet6_hashtables.c | 14 ++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 352eb371c93b..ac927a635a6f 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -335,6 +335,20 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  
>  INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
>  
> +/**
> + * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket if necessary.
> + * @net: network namespace.
> + * @sk: AF_INET socket, must be in TCP_LISTEN state for TCP or TCP_CLOSE for UDP.
> + * @skb: context for a potential SK_REUSEPORT program.
> + * @doff: header offset.
> + * @saddr: source address.
> + * @sport: source port.
> + * @daddr: destination address.
> + * @hnum: destination port in host byte order.

It seems you forgot to copy-and-paste the ehashfn description.

---8<---
+ * @ehashfn: hash function used to generate the fallback hash.
---8<---
https://lore.kernel.org/all/20230613-so-reuseport-v3-4-907b4cbb7b99@isovalent.com/


> + *
> + * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
> + *         the selected sock or an error.
> + */
>  struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
>  				   struct sk_buff *skb, int doff,
>  				   __be32 saddr, __be16 sport,
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index 3616225c89ef..d37602fabc00 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -114,6 +114,20 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  
>  INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
>  
> +/**
> + * inet6_lookup_reuseport() - execute reuseport logic on AF_INET6 socket if necessary.
> + * @net: network namespace.
> + * @sk: AF_INET6 socket, must be in TCP_LISTEN state for TCP or TCP_CLOSE for UDP.
> + * @skb: context for a potential SK_REUSEPORT program.
> + * @doff: header offset.
> + * @saddr: source address.
> + * @sport: source port.
> + * @daddr: destination address.
> + * @hnum: destination port in host byte order.

Same here.


> + *
> + * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
> + *         the selected sock or an error.
> + */
>  struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
>  				    struct sk_buff *skb, int doff,
>  				    const struct in6_addr *saddr,
> 
> -- 
> 2.40.1
