Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978AD74E2A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 02:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjGKAlZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 20:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKAlX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 20:41:23 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47F71AC;
        Mon, 10 Jul 2023 17:41:22 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6ff1ada5dso80498691fa.2;
        Mon, 10 Jul 2023 17:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689036081; x=1691628081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efOAgxEmmwfXTjqPB7I0Z2dgqV2TvYCNGg5OCjQJVI4=;
        b=B+3OS09MuotFOVY1dDveToEz2WoT5xkcB3LzHb6Z+2tOWZQ84ha0XpAoqRFu8tNIgl
         7Uj90GnG4Yml9Bj40WCMsC01xMMal/sHbREfSoKFrIXtt7X241sCWPXGb+M9WdE/BGz/
         4Joe6k93ob75Inpyix+DVPJ/OHbqPjLg3kLRTbZt3d4dxR0m+C1tUqMfl3kQ+Ouoitgi
         5sC0r3tQL8mS4qQqOBlSPt1QNPL/6Whceai7ALHec3LXf0+HW5N/01JZ0Kr5PfFoTVcR
         wqT5pvQ+Adwa0szw82oz1/mBXkHeDak7VxrAHoWqQ6Cvppb7ibPCzHuYpNKUSvxvTZ5c
         fjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689036081; x=1691628081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efOAgxEmmwfXTjqPB7I0Z2dgqV2TvYCNGg5OCjQJVI4=;
        b=frVijC4tNI+4JD7u6aV1/HByf163CJw2gBrECSg16/BScF/106EEYTNKplr1yU0Mq1
         cr9Mrx/OmgoM70+mPszAcB9s0wXjb3zW9UlhnBuzsnCwZHwII3M2WkNPDw2aqvYfIMti
         bLai9OLzbphEVkKRjCdPWDRmEnOqQu9K1s9Pmj+MRZbr6G3o3TXaElVRJixaaiwE19F/
         Ne/dD8oQi35sS3R4C1YexQLuchuNbVoGxwFHfhyqfe+UUaDi/RwcpCLiGQbzJ+SE3yCR
         H8gPPTf7YTNsDzkdfYhQrf/3atODAABub/HfrTldpuiFCBIRKwrGuEsbvbu88ChiuxqS
         8a3Q==
X-Gm-Message-State: ABy/qLbI159XA/s3wXOC2FlOLBpopGwdUWnNnPomFcF8sq8Kl+JKJv4y
        9+Vt4kcmNw1760akZH8PJFAycfAXSg9cVzyfGpM=
X-Google-Smtp-Source: APBJJlE0xkzS08RMt8yd7eqeNOa+sfpj/or0uIsa7m/WeT7ybK4WWGVR/nd2iSYTODdqjMCKQeeVPXXhFVq9VpATKiI=
X-Received: by 2002:a2e:8883:0:b0:2b6:e2c2:d234 with SMTP id
 k3-20020a2e8883000000b002b6e2c2d234mr11356614lji.33.1689036080823; Mon, 10
 Jul 2023 17:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAN+4W8iRH6kpDmmY8i5r1nKbckaYghmOCqRXe+4bDHE7vzVMMA@mail.gmail.com>
 <20230706153327.99298-1-kuniyu@amazon.com>
In-Reply-To: <20230706153327.99298-1-kuniyu@amazon.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 10 Jul 2023 17:41:09 -0700
Message-ID: <CAADnVQK5gorOuM+GTANJjrwTNSfVcEO-cL_ESqXOjUBdpJLvGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/7] bpf, net: Support SO_REUSEPORT sockets
 with bpf_sk_assign
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     Lorenz Bauer <lmb@isovalent.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Hao Luo <haoluo@google.com>,
        Hemanth Malla <hemanthmalla@gmail.com>,
        Joe Stringer <joe@cilium.io>, Joe Stringer <joe@wand.net.nz>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>,
        Network Development <netdev@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 6, 2023 at 8:33=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Lorenz Bauer <lmb@isovalent.com>
> Date: Thu, 6 Jul 2023 09:11:15 +0100
> > On Thu, Jul 6, 2023 at 1:41=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > >
> > > Sorry for late reply.
> > >
> > > What we know about sk before inet6?_lookup_reuseport() are
> > >
> > >   (1) sk was full socket in bpf_sk_assign()
> > >   (2) sk had SOCK_RCU_FREE in bpf_sk_assign()
> > >   (3) sk was TCP_LISTEN here if TCP
> >
> > Are we looking at the same bpf_sk_assign? Confusingly there are two
> > very similarly named functions. The one we care about is:
> >
> > BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64=
, flags)
> > {
> >     if (!sk || flags !=3D 0)
> >         return -EINVAL;
> >     if (!skb_at_tc_ingress(skb))
> >         return -EOPNOTSUPP;
> >     if (unlikely(dev_net(skb->dev) !=3D sock_net(sk)))
> >         return -ENETUNREACH;
> >     if (sk_is_refcounted(sk) &&
> >         unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> >         return -ENOENT;
> >
> >     skb_orphan(skb);
> >     skb->sk =3D sk;
> >     skb->destructor =3D sock_pfree;
> >
> >     return 0;
> > }
> >
> > From this we can't tell what state the socket is in or whether it is
> > RCU freed or not.
>
> But we can in inet6?_steal_sock() by calling sk_is_refcounted() again
> via skb_steal_sock().
>
> In inet6?_steal_sock(), we call inet6?_lookup_reuseport() only for
> sk that was a TCP listener or UDP non-connected socket until just before
> the sk_state checks.  Then, we know *refcounted should be false for such
> sockets even before inet6?_lookup_reuseport().
>
> After the checks, sk might be poped out of the reuseport group before
> inet6?_lookup_reuseport() and reuse_sk might be NULL, but it's not
> related because *refcounted is a value for sk, not for reuse_sk.

I was about to apply v5 before I noticed this discussion on v4.
Sounds like v6 will be needed.
Next time please continue discussion in the latest version.
