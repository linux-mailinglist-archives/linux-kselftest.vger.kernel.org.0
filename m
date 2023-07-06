Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF2F7492AD
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 02:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGFAlG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 20:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGFAlF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 20:41:05 -0400
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE92219A9;
        Wed,  5 Jul 2023 17:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1688604065; x=1720140065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v+tsYcKm5P9WlsDhSBE+NcvZuf+VkDCTV0XouTKcUlk=;
  b=S2l9TwrnnFEUAbIaUDOkTvSDkcp+K2B7GoftUG3YRHsUqQxVrggjjWLg
   ZzAGz1iz7W6JmlcezonMbT77Jcx/nsqyusjGQn0zDulM7MqaOJVwi7kS0
   ekx5K20hGZcWijspOt+qBEx8FEO8X6FWCXegDj9yIBXRKCFC3952XqpN3
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,184,1684800000"; 
   d="scan'208";a="591314401"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 00:41:01 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com (Postfix) with ESMTPS id 0977F40D9F;
        Thu,  6 Jul 2023 00:40:58 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 00:40:58 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.47) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 00:40:53 +0000
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
Date:   Wed, 5 Jul 2023 17:40:44 -0700
Message-ID: <20230706004044.79850-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAN+4W8hLXYZuNFG+=J-FWLXWhbwT5TrHjMg5VzjQhv2NBo5VaA@mail.gmail.com>
References: <CAN+4W8hLXYZuNFG+=J-FWLXWhbwT5TrHjMg5VzjQhv2NBo5VaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.187.170.47]
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 3 Jul 2023 10:57:23 +0100
> On Wed, Jun 28, 2023 at 7:54 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> 
> > > +     reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
> > > +                                       saddr, sport, daddr, ntohs(dport),
> > > +                                       ehashfn);
> > > +     if (!reuse_sk || reuse_sk == sk)
> > > +             return sk;
> > > +
> > > +     /* We've chosen a new reuseport sock which is never refcounted. This
> > > +      * implies that sk also isn't refcounted.
> > > +      */
> > > +     WARN_ON_ONCE(*refcounted);
> >
> > One more nit.
> >
> > WARN_ON_ONCE() should be tested before inet6?_lookup_reuseport() not to
> > miss the !reuse_sk case.
> 
> I was just pondering that as well, but I came to the opposite
> conclusion. In the !reuse_sk case we don't really know anything about
> sk, except that it isn't part of a reuseport group. How can we be sure
> that it's not refcounted?

Sorry for late reply.

What we know about sk before inet6?_lookup_reuseport() are

  (1) sk was full socket in bpf_sk_assign()
  (2) sk had SOCK_RCU_FREE in bpf_sk_assign()
  (3) sk was TCP_LISTEN here if TCP

After bpf_sk_assign(), reqsk is never converted to fullsock, and UDP
never clears SOCK_RCU_FREE.  If sk is TCP, now we are in the RCU grace
period and confirmed sk->sk_state was TCP_LISTEN.  Then, TCP_LISTEN sk
cannot be reused and SOCK_RCU_FREE is never cleared.

So, before/after inet6?_lookup_reuseport(), the fact that sk is not
refcounted here should not change in spite of that reuse_sk is NULL.

What do you think ?
