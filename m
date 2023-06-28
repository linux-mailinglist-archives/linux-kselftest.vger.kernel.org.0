Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC60741867
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 20:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjF1S4O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 14:56:14 -0400
Received: from smtp-fw-9105.amazon.com ([207.171.188.204]:55113 "EHLO
        smtp-fw-9105.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjF1SyN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 14:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687978454; x=1719514454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sj4D9/YhFa5gm+2Xbpetvt8RuR2FgzUgdFX5Vd7PyHk=;
  b=H+bRP7RkcTc9SPLVmZV4zgn12WQ4P9+hzkw5GJF2Yp2VzVfoHdgs7eFf
   5qWaxRGKJY9OpU5gzj8kdBpZQYNkXedh85MfdM8hgcJT5x8KTVT5B+Nxk
   3HPK3h4hKYLPgwyS0R57ygybpgfV6z5ZDgE8UtKr7Dlne/e1KxLVGpIYO
   8=;
X-IronPort-AV: E=Sophos;i="6.01,166,1684800000"; 
   d="scan'208";a="657569115"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 18:54:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 07C7DA0A9B;
        Wed, 28 Jun 2023 18:54:06 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 18:54:06 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Wed, 28 Jun 2023 18:54:00 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <lmb@isovalent.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>,
        <dsahern@kernel.org>, <edumazet@google.com>, <haoluo@google.com>,
        <hemanthmalla@gmail.com>, <joe@cilium.io>, <joe@wand.net.nz>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kpsingh@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <martin.lau@linux.dev>, <mykolal@fb.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <sdf@google.com>, <shuah@kernel.org>,
        <song@kernel.org>, <willemdebruijn.kernel@gmail.com>, <yhs@fb.com>
Subject: Re: [PATCH bpf-next v4 6/7] bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign
Date:   Wed, 28 Jun 2023 11:53:52 -0700
Message-ID: <20230628185352.76923-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613-so-reuseport-v4-6-4ece76708bba@isovalent.com>
References: <20230613-so-reuseport-v4-6-4ece76708bba@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.50]
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 28 Jun 2023 10:48:21 +0100
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
> index a6722d6ef80f..7d677b89f269 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -103,6 +103,46 @@ static inline struct sock *__inet6_lookup(struct net *net,
>  				     daddr, hnum, dif, sdif);
>  }
>  
> +static inline
> +struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
> +			      const struct in6_addr *saddr, const __be16 sport,
> +			      const struct in6_addr *daddr, const __be16 dport,
> +			      bool *refcounted, inet6_ehashfn_t *ehashfn)
> +{
> +	struct sock *sk, *reuse_sk;
> +	bool prefetched;
> +
> +	sk = skb_steal_sock(skb, refcounted, &prefetched);
> +	if (!sk)
> +		return NULL;
> +
> +	if (!prefetched)
> +		return sk;
> +
> +	if (sk->sk_protocol == IPPROTO_TCP) {
> +		if (sk->sk_state != TCP_LISTEN)
> +			return sk;
> +	} else if (sk->sk_protocol == IPPROTO_UDP) {
> +		if (sk->sk_state != TCP_CLOSE)
> +			return sk;
> +	} else {
> +		return sk;
> +	}
> +
> +	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
> +					  saddr, sport, daddr, ntohs(dport),
> +					  ehashfn);
> +	if (!reuse_sk || reuse_sk == sk)
> +		return sk;
> +
> +	/* We've chosen a new reuseport sock which is never refcounted. This
> +	 * implies that sk also isn't refcounted.
> +	 */
> +	WARN_ON_ONCE(*refcounted);

One more nit.

WARN_ON_ONCE() should be tested before inet6?_lookup_reuseport() not to
miss the !reuse_sk case.


> +
> +	return reuse_sk;
> +}
