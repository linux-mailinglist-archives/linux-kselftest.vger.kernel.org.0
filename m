Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5507E3231
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 01:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjKGAYL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 19:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjKGAYK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 19:24:10 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582BC184
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Nov 2023 16:24:04 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-45da9f949aaso1264085137.2
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Nov 2023 16:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699316643; x=1699921443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpkgociZWtNmHNqup8fc4OP6m9kvy0WIbsUu3JqjrFo=;
        b=GaVApw0hOud1Xw6db4glBTFJo8iBe1OqNQoGimb+Dtp+ClwWvIbxnPmHJakYWqO+nk
         3LOPE8evloiG3m1Pd5se8xet9e5/WYduh1HWtdb2sFo8NMQdTVmqqsXWVeY0MwtqsQZi
         gB3NNIn71w9awI2qYBu2Myc1kvU4uf1TI5DGSk7x6aASQCpqONOGkSpWiqpW/NFSs2IQ
         usMwoNyRZMjfyhLcoW8a9IWrmKwglyEw+wwAMfQ6HTTvr6mIoZ3CEMf3JiUqWgFP7Sse
         yZXJQLVIB87K6smWXXP7X5aKZQsVpqTJ0C413h8hgLX7qnkz2MGnj6u9e1+qzgH1phWZ
         4Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699316643; x=1699921443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpkgociZWtNmHNqup8fc4OP6m9kvy0WIbsUu3JqjrFo=;
        b=GnbEqrGsoyCXrL4T50cEV+taj65KC4s5caFGaWRmv3+6LL+xDHYRliEa/3Qhgiv2Mb
         uz4DaD/sSjx1COePs3PtORDah325huPaOLSW63UYdQkaMiR1be+PxJzUtuzyqNIQt+8E
         zv8ozjWvzpPPbCvd+7fm7oDcBd05UfsuNRW25XzkrhoGChNIcRptIvR+Orsk5bO5Nn5X
         V+Qu5yu54IHLAIxmDmutRSCp+aMn+4vhX4KKVT22jdgrxqRyUqBKA7fVx3xBhEk73wY0
         Jh9lM3EgZQStxxYV0MvtyyGyYIIlmm0DH/oobj+nrDtQBDRJxGBlaYTq0rojZzUV3z/w
         6wUw==
X-Gm-Message-State: AOJu0YwM4ZnTwhzq+oAkVDJHMyUi11JldFCOKhPCzIfwT9NiAb3151S7
        mbYZZsJZajHKqNhjSUCiMduvB+l6cY6W+ntx12AiGg==
X-Google-Smtp-Source: AGHT+IETMKyQIhhyycP7VfpcyOAP+36Ndh1eORahNjRPB1IML5/P0pzLe4lyVRhYqpQBeNyazLdIIUZ8jHzBSAAkKuo=
X-Received: by 2002:a05:6102:2049:b0:45f:642e:41c with SMTP id
 q9-20020a056102204900b0045f642e041cmr2136927vsr.13.1699316643304; Mon, 06 Nov
 2023 16:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-10-almasrymina@google.com> <fa44c3d1-92b9-4686-ab3b-4fcda257aafd@kernel.org>
In-Reply-To: <fa44c3d1-92b9-4686-ab3b-4fcda257aafd@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 6 Nov 2023 16:23:52 -0800
Message-ID: <CAHS8izPW++mf1rq2XdezvXJpxhc6Ey1-_2nbpEymm5KThV18yw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
To:     David Ahern <dsahern@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 6, 2023 at 4:16=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 11/5/23 7:44 PM, Mina Almasry wrote:
> > diff --git a/net/core/datagram.c b/net/core/datagram.c
> > index 176eb5834746..cdd4fb129968 100644
> > --- a/net/core/datagram.c
> > +++ b/net/core/datagram.c
> > @@ -425,6 +425,9 @@ static int __skb_datagram_iter(const struct sk_buff=
 *skb, int offset,
> >                       return 0;
> >       }
> >
> > +     if (skb_frags_not_readable(skb))
> > +             goto short_copy;
> > +
> >       /* Copy paged appendix. Hmm... why does this look so complicated?=
 */
> >       for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
> >               int end;
> > @@ -616,6 +619,9 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, str=
uct sock *sk,
> >  {
> >       int frag;
> >
> > +     if (skb_frags_not_readable(skb))
> > +             return -EFAULT;
>
> This check ....
> > +
> >       if (msg && msg->msg_ubuf && msg->sg_from_iter)
> >               return msg->sg_from_iter(sk, skb, from, length);
>
>
> ... should go here. That allows custome sg_from_iter to have access to
> the skb. What matters is not expecting struct page (e.g., refcounting);
> if the custom iter does not do that then all is well. io_uring's iter
> does not look at the pages, so all good.
>
> >
> > diff --git a/net/core/gro.c b/net/core/gro.c
> > index 42d7f6755f32..56046d65386a 100644
> > --- a/net/core/gro.c
> > +++ b/net/core/gro.c
> > @@ -390,6 +390,9 @@ static void gro_pull_from_frag0(struct sk_buff *skb=
, int grow)
> >  {
> >       struct skb_shared_info *pinfo =3D skb_shinfo(skb);
> >
> > +     if (WARN_ON_ONCE(skb_frags_not_readable(skb)))
> > +             return;
> > +
> >       BUG_ON(skb->end - skb->tail < grow);
> >
> >       memcpy(skb_tail_pointer(skb), NAPI_GRO_CB(skb)->frag0, grow);
> > @@ -411,7 +414,7 @@ static void gro_try_pull_from_frag0(struct sk_buff =
*skb)
> >  {
> >       int grow =3D skb_gro_offset(skb) - skb_headlen(skb);
> >
> > -     if (grow > 0)
> > +     if (grow > 0 && !skb_frags_not_readable(skb))
> >               gro_pull_from_frag0(skb, grow);
> >  }
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 13eca4fd25e1..f01673ed2eff 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -1230,6 +1230,14 @@ void skb_dump(const char *level, const struct sk=
_buff *skb, bool full_pkt)
> >               struct page *p;
> >               u8 *vaddr;
> >
> > +             if (skb_frag_is_page_pool_iov(frag)) {
>
> Why skb_frag_is_page_pool_iov here vs skb_frags_not_readable?

Seems like a silly choice on my end. I should probably check
skb_frags_not_readable() and not kmap any frags in that case. Will do.

--=20
Thanks,
Mina
