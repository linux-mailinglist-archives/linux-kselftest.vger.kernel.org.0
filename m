Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E69C74A111
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjGFPd4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 11:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjGFPdz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 11:33:55 -0400
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F346BFF;
        Thu,  6 Jul 2023 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1688657635; x=1720193635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=trA35bhtZS7sC65wm9GfBeAVYdZXIA5psrybUjewGIQ=;
  b=A0UumUCQtccE+sL4EQW3IA6Wg1hcfLSmRSmI/JZD/sedyT5VYzAKy+fS
   qjJCBdlLKda+gxGC1/nglq1eFqaJmASSIL1vTr72VH8gF+r8AifyGvAa4
   QqOoXm+zYDyY8Tu1M2r39/T7cT4zFNhrTsSoccqGOyygiR2iLn3AaIYYA
   8=;
X-IronPort-AV: E=Sophos;i="6.01,185,1684800000"; 
   d="scan'208";a="658357472"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 15:33:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id 7CCA88103C;
        Thu,  6 Jul 2023 15:33:42 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 15:33:40 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 15:33:35 +0000
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
Date:   Thu, 6 Jul 2023 08:33:27 -0700
Message-ID: <20230706153327.99298-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAN+4W8iRH6kpDmmY8i5r1nKbckaYghmOCqRXe+4bDHE7vzVMMA@mail.gmail.com>
References: <CAN+4W8iRH6kpDmmY8i5r1nKbckaYghmOCqRXe+4bDHE7vzVMMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.187.171.32]
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
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
Date: Thu, 6 Jul 2023 09:11:15 +0100
> On Thu, Jul 6, 2023 at 1:41 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > Sorry for late reply.
> >
> > What we know about sk before inet6?_lookup_reuseport() are
> >
> >   (1) sk was full socket in bpf_sk_assign()
> >   (2) sk had SOCK_RCU_FREE in bpf_sk_assign()
> >   (3) sk was TCP_LISTEN here if TCP
> 
> Are we looking at the same bpf_sk_assign? Confusingly there are two
> very similarly named functions. The one we care about is:
> 
> BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
> {
>     if (!sk || flags != 0)
>         return -EINVAL;
>     if (!skb_at_tc_ingress(skb))
>         return -EOPNOTSUPP;
>     if (unlikely(dev_net(skb->dev) != sock_net(sk)))
>         return -ENETUNREACH;
>     if (sk_is_refcounted(sk) &&
>         unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
>         return -ENOENT;
> 
>     skb_orphan(skb);
>     skb->sk = sk;
>     skb->destructor = sock_pfree;
> 
>     return 0;
> }
> 
> From this we can't tell what state the socket is in or whether it is
> RCU freed or not.

But we can in inet6?_steal_sock() by calling sk_is_refcounted() again
via skb_steal_sock().

In inet6?_steal_sock(), we call inet6?_lookup_reuseport() only for
sk that was a TCP listener or UDP non-connected socket until just before
the sk_state checks.  Then, we know *refcounted should be false for such
sockets even before inet6?_lookup_reuseport().

After the checks, sk might be poped out of the reuseport group before
inet6?_lookup_reuseport() and reuse_sk might be NULL, but it's not
related because *refcounted is a value for sk, not for reuse_sk.
