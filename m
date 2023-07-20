Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D35875B972
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 23:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGTVRI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 17:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGTVRI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 17:17:08 -0400
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E081C10F3;
        Thu, 20 Jul 2023 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689887827; x=1721423827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wDX3ZPeckpdvoDd+/BKwtAdHUyZVsWMkV40y0TdOiMo=;
  b=D+3Vjc2n/4ceybnaE6qfy9WNItLonYt0+TME0ShHxGOVwXqIYUDXmQD1
   FmhumbiLuXjvZkAFPLMPf/tLInPDvHRubiag9dLmbWS5QYH3AQHFHt82v
   eytlyr7HPRS5EP+EhSSKsrDbizgdJ5BFemkay1BJ8XlHsZ0Rns/uohRtF
   c=;
X-IronPort-AV: E=Sophos;i="6.01,219,1684800000"; 
   d="scan'208";a="573336688"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 21:17:04 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 70119442FB;
        Thu, 20 Jul 2023 21:17:03 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 21:17:02 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Thu, 20 Jul 2023 21:16:56 +0000
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
Subject: Re: [PATCH bpf-next v6 2/8] bpf: reject unhashed sockets in bpf_sk_assign
Date:   Thu, 20 Jul 2023 14:16:46 -0700
Message-ID: <20230720211646.34782-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230720-so-reuseport-v6-2-7021b683cdae@isovalent.com>
References: <20230720-so-reuseport-v6-2-7021b683cdae@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.12]
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
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
Date: Thu, 20 Jul 2023 17:30:06 +0200
> The semantics for bpf_sk_assign are as follows:
> 
>     sk = some_lookup_func()
>     bpf_sk_assign(skb, sk)
>     bpf_sk_release(sk)
> 
> That is, the sk is not consumed by bpf_sk_assign. The function
> therefore needs to make sure that sk lives long enough to be
> consumed from __inet_lookup_skb. The path through the stack for a
> TCPv4 packet is roughly:
> 
>   netif_receive_skb_core: takes RCU read lock
>     __netif_receive_skb_core:
>       sch_handle_ingress:
>         tcf_classify:
>           bpf_sk_assign()
>       deliver_ptype_list_skb:
>         deliver_skb:
>           ip_packet_type->func == ip_rcv:
>             ip_rcv_core:
>             ip_rcv_finish_core:
>               dst_input:
>                 ip_local_deliver:
>                   ip_local_deliver_finish:
>                     ip_protocol_deliver_rcu:
>                       tcp_v4_rcv:
>                         __inet_lookup_skb:
>                           skb_steal_sock
> 
> The existing helper takes advantage of the fact that everything
> happens in the same RCU critical section: for sockets with
> SOCK_RCU_FREE set bpf_sk_assign never takes a reference.
> skb_steal_sock then checks SOCK_RCU_FREE again and does sock_put
> if necessary.
> 
> This approach assumes that SOCK_RCU_FREE is never set on a sk
> between bpf_sk_assign and skb_steal_sock, but this invariant is
> violated by unhashed UDP sockets. A new UDP socket is created
> in TCP_CLOSE state but without SOCK_RCU_FREE set. That flag is only
> added in udp_lib_get_port() which happens when a socket is bound.
> 
> When bpf_sk_assign was added it wasn't possible to access unhashed
> UDP sockets from BPF, so this wasn't a problem. This changed
> in commit 0c48eefae712 ("sock_map: Lift socket state restriction
> for datagram sockets"), but the helper wasn't adjusted accordingly.
> The following sequence of events will therefore lead to a refcount
> leak:
> 
> 1. Add socket(AF_INET, SOCK_DGRAM) to a sockmap.
> 2. Pull socket out of sockmap and bpf_sk_assign it. Since
>    SOCK_RCU_FREE is not set we increment the refcount.
> 3. bind() or connect() the socket, setting SOCK_RCU_FREE.
> 4. skb_steal_sock will now set refcounted = false due to
>    SOCK_RCU_FREE.
> 5. tcp_v4_rcv() skips sock_put().
> 
> Fix the problem by rejecting unhashed sockets in bpf_sk_assign().
> This matches the behaviour of __inet_lookup_skb which is ultimately
> the goal of bpf_sk_assign().
> 
> Fixes: cf7fbe660f2d ("bpf: Add socket assign support")

Should this be 0c48eefae712 then ?


> Cc: Joe Stringer <joe@cilium.io>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>

The change itself looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> ---
>  net/core/filter.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 797e8f039696..b5b51ef48c5f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7353,6 +7353,8 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
>  		return -ENETUNREACH;
>  	if (unlikely(sk_fullsock(sk) && sk->sk_reuseport))
>  		return -ESOCKTNOSUPPORT;
> +	if (sk_unhashed(sk))
> +		return -EOPNOTSUPP;
>  	if (sk_is_refcounted(sk) &&
>  	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
>  		return -ENOENT;
> 
> -- 
> 2.41.0
