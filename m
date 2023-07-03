Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CD47458B1
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 11:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGCJqQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 05:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjGCJqO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 05:46:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD0DE5B
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Jul 2023 02:46:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-992b66e5affso485175766b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jul 2023 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688377570; x=1690969570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAVcfp0GiSAt76fo4gLjijfKkWn98YypFzYe/HtvOKU=;
        b=HD95sOKgKpvDJjMobg5G+wIZgo1K7nnWBpuhskATho6HC5AoGzaZi8rRmPIxXemMq2
         o900X+GzpDo2XZJD199KKY9MrfZHJFr1QtuwRd07VlpmXVZUTLfY0LLTq3xJYVCf/a4/
         /0Le0hGJ5S4GMofEHiKUfaE6g50i0psznpRYu0R6MrOjBoTFVXnIkMsSkcUuBrWx8DBw
         oBHpe79OG2ppm+LVFsp/ULOh1mU+SX9eS6o2rIB95lTdmDBUNaDrUUfwMUNKiKzd7Zv3
         Tk8Lbpw0bJDK7E0+tJ9vUBc6XdoMDUaVABlzzlWA1H71sDEgy4C5RdTlA38Ni0SAY8p1
         A+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688377570; x=1690969570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAVcfp0GiSAt76fo4gLjijfKkWn98YypFzYe/HtvOKU=;
        b=Yrc0147b5FX175Zke5SpI6Vm2NRwAE4NAf2xA4Lwey3v7pzpGwqgjcwGWEGAvD5duw
         JbZRpJUUo4NHcrNwpiBwGeo9VC6g+S6YCDQD7NaaKywWMF5uDqsctOjT1n2UWYbJMAM5
         ABiytoyqT6gZi6ppZ+wKUjKf+jiPZVgvDVfqmNakx5Qwi5GWPX2pwtl3RpLtOqqyMNwV
         Hgt4ncigd59cI4OqapMtIsNaRk5U4D8UX5+s5H/o5/2tbSBkIKSGlVDkBf9tqJAbl2Y7
         U7goFeuiuC8/YQRPnem8tR20Qs3uX952KwedhHaUUtqo4CaAEDgR/8IzU52w5QvYkdGx
         9YtA==
X-Gm-Message-State: ABy/qLblbh3NBlsALzODhdtaMOsu75xZ14n65exdjN6+Bl35Wu4uA0Tw
        2wr1/T83DHjNJegKO3aHw0FWAIjvKxjXFZIMF/7v6Q==
X-Google-Smtp-Source: APBJJlH9SIlxp9gcpjrHbH85ZHsZVFnc5U9Yd+D/8BddOA5vnCK0mJ3tEWyu6sryEtQD1gdVrrGDxUNjQ+uJXH990sw=
X-Received: by 2002:a17:906:37cc:b0:94f:449e:75db with SMTP id
 o12-20020a17090637cc00b0094f449e75dbmr7501039ejc.52.1688377570306; Mon, 03
 Jul 2023 02:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230613-so-reuseport-v4-3-4ece76708bba@isovalent.com> <20230628183258.74704-1-kuniyu@amazon.com>
In-Reply-To: <20230628183258.74704-1-kuniyu@amazon.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Mon, 3 Jul 2023 10:45:59 +0100
Message-ID: <CAN+4W8ihqdQnZW5oWxhgmNaEDisdG9UDQYozVw_HpR41HkWL_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/7] net: remove duplicate reuseport_lookup functions
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com,
        joe@wand.net.nz, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, netdev@vger.kernel.org, pabeni@redhat.com,
        sdf@google.com, shuah@kernel.org, song@kernel.org,
        willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 28, 2023 at 7:33=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:

> > +
> > +inet6_ehashfn_t inet6_ehashfn;
> > +
> > +INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
>
> We need not define udp6_ehashfn() here as inet6_hashtables.c has
> the definition.
>
> Only inet6_ehashfn() is needed because sk_ehashfn() uses it.

Without udp6_ehashfn we get the following error, as reported by Simon
against v1:

net/ipv4/udp.c:410:5: error: no previous prototype for =E2=80=98udp_ehashfn=
=E2=80=99
[-Werror=3Dmissing-prototypes]
  410 | u32 udp_ehashfn(const struct net *net, const __be32 laddr,
const __u16 lport,
      |     ^~~~~~~~~~~

> > +inet_ehashfn_t inet_ehashfn;
> > +
> > +INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
> > +
>
> We don't need inet_ehashfn() and udp_ehashfn() declarations here.

Without inet_ehashfn I get:

./include/net/inet_hashtables.h: In function =E2=80=98__inet_lookup_skb=E2=
=80=99:
./include/net/inet_hashtables.h:501:42: error: =E2=80=98inet_ehashfn=E2=80=
=99
undeclared (first use in this function); did you mean =E2=80=98inet_bhashfn=
=E2=80=99?
  501 |                              refcounted, inet_ehashfn);

Same problem with the warning as above.

I think this needs to stay the way it is.
