Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E916B73ECCD
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 23:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFZVX0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 17:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjFZVXZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 17:23:25 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C1C2;
        Mon, 26 Jun 2023 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687814604; x=1719350604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AT/KPQKjSjG7XfGIa1PPJzx4QqnG/LdnhEF+Jfk66C8=;
  b=TE+AdBplSVc8mUvH0Ok/sqnE5lgn7mWtybROSF7802hIxl42Gk/tKRsW
   OkXJjpJZdHZJoQwnBl2kaTEkBivJxalof9blCYPT4wMmQz/qK1twx8VNg
   oGnqi2OLFVCPFPhCKHVmPo2TbAwmnH+97yQxKZ/mYxtBKM6rJFLDsi786
   4=;
X-IronPort-AV: E=Sophos;i="6.01,160,1684800000"; 
   d="scan'208";a="336291050"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 21:23:19 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id 9FF0C8A669;
        Mon, 26 Jun 2023 21:23:17 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 21:23:17 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 26 Jun 2023 21:23:12 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <kuniyu@amazon.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>,
        <dsahern@kernel.org>, <edumazet@google.com>, <haoluo@google.com>,
        <hemanthmalla@gmail.com>, <joe@cilium.io>, <joe@wand.net.nz>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kpsingh@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <lmb@isovalent.com>, <martin.lau@linux.dev>, <mykolal@fb.com>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@google.com>,
        <shuah@kernel.org>, <song@kernel.org>,
        <willemdebruijn.kernel@gmail.com>, <yhs@fb.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign
Date:   Mon, 26 Jun 2023 14:23:03 -0700
Message-ID: <20230626212303.91671-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230626210846.84206-1-kuniyu@amazon.com>
References: <20230626210846.84206-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.15]
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Mon, 26 Jun 2023 14:08:46 -0700
> From: Lorenz Bauer <lmb@isovalent.com>
> Date: Mon, 26 Jun 2023 16:09:03 +0100
> > Currently the bpf_sk_assign helper in tc BPF context refuses SO_REUSEPORT
> > sockets. This means we can't use the helper to steer traffic to Envoy,
> > which configures SO_REUSEPORT on its sockets. In turn, we're blocked
> > from removing TPROXY from our setup.
> > 
> > The reason that bpf_sk_assign refuses such sockets is that the
> > bpf_sk_lookup helpers don't execute SK_REUSEPORT programs. Instead,
> > one of the reuseport sockets is selected by hash. This could cause
> > dispatch to the "wrong" socket:
> > 
> >     sk = bpf_sk_lookup_tcp(...) // select SO_REUSEPORT by hash
> >     bpf_sk_assign(skb, sk) // SK_REUSEPORT wasn't executed
> > 
> > Fixing this isn't as simple as invoking SK_REUSEPORT from the lookup
> > helpers unfortunately. In the tc context, L2 headers are at the start
> > of the skb, while SK_REUSEPORT expects L3 headers instead.
> > 
> > Instead, we execute the SK_REUSEPORT program when the assigned socket
> > is pulled out of the skb, further up the stack. This creates some
> > trickiness with regards to refcounting as bpf_sk_assign will put both
> > refcounted and RCU freed sockets in skb->sk. reuseport sockets are RCU
> > freed. We can infer that the sk_assigned socket is RCU freed if the
> > reuseport lookup succeeds, but convincing yourself of this fact isn't
> > straight forward. Therefore we defensively check refcounting on the
> > sk_assign sock even though it's probably not required in practice.
> > 
> > Fixes: 8e368dc72e86 ("bpf: Fix use of sk->sk_reuseport from sk_assign")
> > Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
> > Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> > Cc: Joe Stringer <joe@cilium.io>
> > Link: https://lore.kernel.org/bpf/CACAyw98+qycmpQzKupquhkxbvWK4OFyDuuLMBNROnfWMZxUWeA@mail.gmail.com/
> > ---
> >  include/net/inet6_hashtables.h | 59 ++++++++++++++++++++++++++++++++++++++----
> >  include/net/inet_hashtables.h  | 52 +++++++++++++++++++++++++++++++++++--
> >  include/net/sock.h             |  7 +++--
> >  include/uapi/linux/bpf.h       |  3 ---
> >  net/core/filter.c              |  2 --
> >  net/ipv4/udp.c                 |  8 ++++--
> >  net/ipv6/udp.c                 | 10 ++++---
> >  tools/include/uapi/linux/bpf.h |  3 ---
> >  8 files changed, 122 insertions(+), 22 deletions(-)
> > 
> > diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
> > index 4d2a1a3c0be7..4d300af6ccb6 100644
> > --- a/include/net/inet6_hashtables.h
> > +++ b/include/net/inet6_hashtables.h
> > @@ -103,6 +103,49 @@ static inline struct sock *__inet6_lookup(struct net *net,
> >  				     daddr, hnum, dif, sdif);
> >  }
> >  
> > +static inline
> > +struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
> > +			      const struct in6_addr *saddr, const __be16 sport,
> > +			      const struct in6_addr *daddr, const __be16 dport,
> > +			      bool *refcounted, inet6_ehashfn_t ehashfn)
> > +{
> > +	struct sock *sk, *reuse_sk;
> > +	bool prefetched;
> > +
> > +	sk = skb_steal_sock(skb, refcounted, &prefetched);
> > +	if (!sk)
> > +		return NULL;
> > +
> > +	if (!prefetched)
> > +		return sk;
> > +
> > +	if (sk->sk_protocol == IPPROTO_TCP) {
> > +		if (sk->sk_state != TCP_LISTEN)
> > +			return sk;
> > +	} else if (sk->sk_protocol == IPPROTO_UDP) {
> > +		if (sk->sk_state != TCP_CLOSE)
> > +			return sk;
> > +	} else {
> > +		return sk;
> > +	}
> > +
> > +	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
> > +					  saddr, sport, daddr, ntohs(dport),
> > +					  ehashfn);
> > +	if (!reuse_sk || reuse_sk == sk)
> > +		return sk;
> > +
> > +	/* We've chosen a new reuseport sock which is never refcounted.
> > +	 * sk might be refcounted however, drop the reference if necessary.
> > +	 */
> > +	if (*refcounted) {
> > +		sock_put(sk);
> > +		*refcounted = false;
> > +	}
> 
> As *refcounted should be false here (TCP_LISTEN and UDP sk have
> SOCK_RCU_FREE and other sk does not reach here), I prefer adding
> WARN_ON_ONCE() to catch a future bug:
> 
> 	WARN_ON_ONCE(*refcounted);
> 	sock_put(sk);

Sorry, sock_put(sk) is not needed here.
