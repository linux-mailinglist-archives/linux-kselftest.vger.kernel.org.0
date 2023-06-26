Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2CC73E710
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 19:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjFZR5v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 13:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFZR5t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 13:57:49 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9112C130;
        Mon, 26 Jun 2023 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687802269; x=1719338269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CjHChph3jHdZoR8racjXNtVY5fiZpsb8Si0LuL7/rhg=;
  b=Wb0/SNLIl8Cbffi3+SrCCeDu8jeqiO6U3/ak9mEV/yBhnnr2Vecq3MTl
   g5EMYSor7c1cCL1x6Wz4aPY6D9nHeSE0tfqiXowgGneeM4hfsbQ0KUciJ
   TnmZS+D2lJ+Tfvkw3Hyowf/KpvN4g6AVDqcun0kivwtcEXJZxOvWzH/2z
   A=;
X-IronPort-AV: E=Sophos;i="6.01,160,1684800000"; 
   d="scan'208";a="341074945"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 17:57:46 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com (Postfix) with ESMTPS id 073FFC15FB;
        Mon, 26 Jun 2023 17:57:39 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 17:57:39 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Mon, 26 Jun 2023 17:57:34 +0000
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
Subject: Re: [PATCH bpf-next v3 3/7] net: document inet[6]_lookup_reuseport sk_state requirements
Date:   Mon, 26 Jun 2023 10:57:26 -0700
Message-ID: <20230626175726.61467-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613-so-reuseport-v3-3-907b4cbb7b99@isovalent.com>
References: <20230613-so-reuseport-v3-3-907b4cbb7b99@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.15]
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
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
Date: Mon, 26 Jun 2023 16:09:00 +0100
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
> ---
>  net/ipv4/inet_hashtables.c  | 14 ++++++++++++++
>  net/ipv6/inet6_hashtables.c | 14 ++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 920131e4a65d..91f9210d4e83 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -332,6 +332,20 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> +/**
> + * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket if necessary.
> + * @net: network namespace.
> + * @sk: AF_INET socket, must be in TCP_LISTEN state for TCP or TCP_CLOSE for UDP.

nit: " or TCP_CLOSE for UDP"

This part should be added in the next patch,
or this patch should be 4th patch.


> + * @skb: context for a potential SK_REUSEPORT program.
> + * @doff: header offset.
> + * @saddr: source address.
> + * @sport: source port.
> + * @daddr: destination address.
> + * @hnum: destination port in host byte order.
> + *
> + * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
> + *         the selected sock or an error.
> + */
>  struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
>  				   struct sk_buff *skb, int doff,
>  				   __be32 saddr, __be16 sport,
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index b7c56867314e..208998694ae3 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -111,6 +111,20 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
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
