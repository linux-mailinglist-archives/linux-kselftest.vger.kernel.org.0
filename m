Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1DE74F7E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 20:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjGKSRO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 14:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGKSRN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 14:17:13 -0400
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0779C;
        Tue, 11 Jul 2023 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689099433; x=1720635433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ejSRqyLc1keD4J84EQBZZKFA9D4wAPd5a7wHIeEh9lk=;
  b=lJagRR05LfgvbN+CSWEOnAGSk8pNI9WmVTrfDH2JBjGCU3DglCK+d10s
   oZZqn9quKgNEzo9FdcykHLTuiyGtoK/iar9JWY0GDhrgp6Npee9aL2PYe
   3ezezIEsJIZlCgE0zF8m9y2s42n3V9MMS9beRr3qaYedK3G6oQCzXMqcF
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,197,1684800000"; 
   d="scan'208";a="592379661"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 18:17:09 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id 5AE7C805D4;
        Tue, 11 Jul 2023 18:17:03 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 18:16:49 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Tue, 11 Jul 2023 18:16:44 +0000
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
Subject: Re: [PATCH bpf-next v5 6/7] bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign
Date:   Tue, 11 Jul 2023 11:16:34 -0700
Message-ID: <20230711181634.52860-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAN+4W8gs84r+PVWgMbic29Opj2EviNMh7AzcP=BR3CLvYHiQWg@mail.gmail.com>
References: <CAN+4W8gs84r+PVWgMbic29Opj2EviNMh7AzcP=BR3CLvYHiQWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.187.170.35]
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
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
Date: Tue, 11 Jul 2023 17:15:06 +0100
> On Tue, Jul 4, 2023 at 2:46 PM Lorenz Bauer <lmb@isovalent.com> wrote:
> >
> > +static inline
> > +struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
> > +                             const struct in6_addr *saddr, const __be16 sport,
> > +                             const struct in6_addr *daddr, const __be16 dport,
> > +                             bool *refcounted, inet6_ehashfn_t *ehashfn)
> > +{
> > +       struct sock *sk, *reuse_sk;
> > +       bool prefetched;
> > +
> > +       sk = skb_steal_sock(skb, refcounted, &prefetched);
> > +       if (!sk)
> > +               return NULL;
> > +
> > +       if (!prefetched)
> > +               return sk;
> > +
> > +       if (sk->sk_protocol == IPPROTO_TCP) {
> > +               if (sk->sk_state != TCP_LISTEN)
> > +                       return sk;
> > +       } else if (sk->sk_protocol == IPPROTO_UDP) {
> > +               if (sk->sk_state != TCP_CLOSE)
> > +                       return sk;
> > +       } else {
> > +               return sk;
> > +       }
> > +
> > +       reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
> > +                                         saddr, sport, daddr, ntohs(dport),
> > +                                         ehashfn);
> > +       if (!reuse_sk)
> > +               return sk;
> > +
> > +       /* We've chosen a new reuseport sock which is never refcounted. This
> > +        * implies that sk also isn't refcounted.
> > +        */
> > +       WARN_ON_ONCE(*refcounted);
> > +
> > +       return reuse_sk;
> > +}
> 
> Hi Kuniyuki,
> 
> Continuing the conversation from v5 of the patch set, you wrote:
> 
> In inet6?_steal_sock(), we call inet6?_lookup_reuseport() only for
> sk that was a TCP listener or UDP non-connected socket until just before
> the sk_state checks.  Then, we know *refcounted should be false for such
> sockets even before inet6?_lookup_reuseport().
> 
> This makes sense for me in the TCP listener case. I understand UDP
> less, so I'll have to rely on your input. I tried to convince myself
> that all UDP sockets in TCP_CLOSE have SOCK_RCU_FREE set. However, the
> only place I see sock_set_flag(sk, SOCK_RCU_FREE) in the UDP case is
> in udp_lib_get_port(). That in turn seems to be called during bind.
> So, what if BPF does bpf_sk_assign() of an unbound and unconnected
> socket?  Wouldn't that trigger the warning?

Ah sorry, I assumed it would not happen, but if we can put unbound
TCP/UDP socket into a map and select it, then yes, it hits the warning.

Let's say we can select a non-RCU sk in bpf_sk_assign() and then the
socket is converted to RCU by bind(udp_sk) or listen(tcp_sk).

The sk_is_refcounted() in bpf_sk_assign() returns true and sk_refcnt
is incremented.  Then, I think of two scenarios:

  1) RCU conversion is done before sk_is_refcounted() in skb_steal_sock().
     -> *refcounted is false

  2) RCU conversion is done after skb_steal_sock().
     -> *refcounted is true

In both cases, we need to decrement the refcnt that is bumped up
by bpf_sk_assign().  The sock_put() in the v1 series does not catch
the former case.

How should we track it ?


> 
> To maybe sidestep this question: do you think the location of the
> WARN_ON_ONCE has to prevent this patch set from going in? I've been
> noodling at it for quite a while already and it would be good to see
> it land.

If the issue above happened, I think it could be a blocker.

Thanks!
