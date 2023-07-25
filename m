Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83FF761FC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 19:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjGYRHn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 13:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjGYRHm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 13:07:42 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD84C1988
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 10:07:39 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55c79a5565aso2640716a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690304859; x=1690909659;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/ZEADyM1ncmAQFJhw94R2+f8llXdPd8DQBrvQQGiqM=;
        b=YYBgqqNMeO+qTKuQPbqUC7IDLnv4u0Q6/fZRrhVzRrD1vQJLdYUBl9fwaXsv2osqhb
         mUL26l3vMZXHCIiWM5kdv45k+KqE2mtH+HToDMZ/s9V1G6hRsLM1vZ/2z8h/J0aStSJZ
         AYbrJqXwvQr21fQWicMEugqbDDiQFNg/ErYyvJvdVca4ig7YnXp+IMFCtssrcA1TXfa3
         Hb6ImsLjF0aw8W3BUIm19fhfKWZpKyw2OoUI2AX4jWXMIjhYF0NQvfGbWrGkuBkd2qWs
         JWoLs5i5tIz2eq33yKup8BRZY/HiSg/1fpQzARS/pO2cQVqwVWtUBJG7oV3kD44W2Ufl
         F21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690304859; x=1690909659;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d/ZEADyM1ncmAQFJhw94R2+f8llXdPd8DQBrvQQGiqM=;
        b=A4VX3laK/6kAlfaTajLcncM7ijy/48lmNPxqqoYsqQkcGSwqEHKj2+Mc44MEFNtKZN
         NeOluxhIGKpwr5KsB2sFDK9JotsCaN+HydBhLWBTHu2OWhJR9yc/5bXAT+yVWMrY95PX
         yNG/rbVm07eRHxUlq3HAleO7HsvJCIkOfv1GRHmaF+GeX4nPbVZ1Lz5TKy/ts09ihrU9
         eEwFUc97QQCHL2Su1YfbIJNAtN4aB/sqU2JHOOQP8diVz6a3BSmOFJUc0bgJdU56nyCO
         qBbwHEDhoU95we9Kd7qZqfyMQj7dVZ/SgYIQ/WhOgby92eKf50SPemWYuOVVEouwPX5v
         c+HQ==
X-Gm-Message-State: ABy/qLaKwrfx+NwDnjH/1BrXHFhsdGReYr8mL4HeBVlcWKaEcyVElV8m
        qTp9fxaSK8U0JBfH0HdsmUcHPjo=
X-Google-Smtp-Source: APBJJlF8ZssWRYSd7JTzlSp3mXs+ZIaAfSkYXZUzHMiFu7ahRQCi+Z+0gx3cYs8KCZ5sHVO59ZX5gy8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a65:67d8:0:b0:55a:f882:137 with SMTP id
 b24-20020a6567d8000000b0055af8820137mr53902pgs.5.1690304859273; Tue, 25 Jul
 2023 10:07:39 -0700 (PDT)
Date:   Tue, 25 Jul 2023 10:07:37 -0700
In-Reply-To: <CAO3-Pbp=VsQVZxvX3MZGhjLsG93r7CPyhe8jBJ-Bt1bJOEtqTQ@mail.gmail.com>
Mime-Version: 1.0
References: <cover.1690255889.git.yan@cloudflare.com> <cdbbc9df16044b568448ed9cd828d406f0851bfb.1690255889.git.yan@cloudflare.com>
 <87v8e8xsih.fsf@cloudflare.com> <CAO3-Pbp=VsQVZxvX3MZGhjLsG93r7CPyhe8jBJ-Bt1bJOEtqTQ@mail.gmail.com>
Message-ID: <ZMABWdaR5/JbBld3@google.com>
Subject: Re: [PATCH v3 bpf 1/2] bpf: fix skb_do_redirect return values
From:   Stanislav Fomichev <sdf@google.com>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jordan Griege <jgriege@cloudflare.com>,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07/25, Yan Zhai wrote:
> On Tue, Jul 25, 2023 at 4:14=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
> >
> > On Mon, Jul 24, 2023 at 09:13 PM -07, Yan Zhai wrote:
> > > skb_do_redirect returns various of values: error code (negative), 0
> > > (success), and some positive status code, e.g. NET_XMIT_CN, NET_RX_DR=
OP.
> > > Such code are not handled at lwt xmit hook in function ip_finish_outp=
ut2
> > > and ip6_finish_output, which can cause unexpected problems. This chan=
ge
> > > converts the positive status code to proper error code.
> > >
> > > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > > Reported-by: Jordan Griege <jgriege@cloudflare.com>
> > > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > >
> > > ---
> > > v3: converts also RX side return value in addition to TX values
> > > v2: code style change suggested by Stanislav Fomichev
> > > ---
> > >  net/core/filter.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 06ba0e56e369..3e232ce11ca0 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -2095,7 +2095,12 @@ static const struct bpf_func_proto bpf_csum_le=
vel_proto =3D {
> > >
> > >  static inline int __bpf_rx_skb(struct net_device *dev, struct sk_buf=
f *skb)
> > >  {
> > > -     return dev_forward_skb_nomtu(dev, skb);
> > > +     int ret =3D dev_forward_skb_nomtu(dev, skb);
> > > +
> > > +     if (unlikely(ret > 0))
> > > +             return -ENETDOWN;
> > > +
> > > +     return 0;
> > >  }
> > >
> > >  static inline int __bpf_rx_skb_no_mac(struct net_device *dev,
> > > @@ -2106,6 +2111,8 @@ static inline int __bpf_rx_skb_no_mac(struct ne=
t_device *dev,
> > >       if (likely(!ret)) {
> > >               skb->dev =3D dev;
> > >               ret =3D netif_rx(skb);
> > > +     } else if (ret > 0) {
> > > +             return -ENETDOWN;
> > >       }
> > >
> > >       return ret;
> > > @@ -2129,6 +2136,9 @@ static inline int __bpf_tx_skb(struct net_devic=
e *dev, struct sk_buff *skb)
> > >       ret =3D dev_queue_xmit(skb);
> > >       dev_xmit_recursion_dec();
> > >
> > > +     if (unlikely(ret > 0))
> > > +             ret =3D net_xmit_errno(ret);
> > > +
> > >       return ret;
> > >  }
> >
> > net_xmit_errno maps NET_XMIT_DROP to -ENOBUFS. It would make sense to m=
e
> > to map NET_RX_DROP to -ENOBUFS as well, instead of -ENETDOWN, to be
> > consistent.
> >
> In fact I looked at all those errno, but found none actually covers
> this situation completely. For the redirect ingress case, there are
> three reasons to fail: backlog full, dev down, and MTU issue. This
> won't be a problem for typical RX paths, since the error code is
> usually discarded by call sites of deliver_skb. But redirect ingress
> opens a call chain that would propagate this error to local sendmsg,
> which may be very confusing to troubleshoot in a complex environment
> (especially when backlog fills).
>=20
> That said I agree ENOBUF covers the most likely reason to fail
> (backlog). Let me change to that one in the next version if there are
> no new suggestions.

nit: also maybe wrap these rx paths into some new net_rx_errno ?
To mirror the tx side.
=20
> > It looks like the Fixes tag for this should point to the change that
> > introduced BPF for LWT:
> >
> > Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
> >
> Thanks for finding the tag. I was debating if it should be LWT commit
> or bpf_redirect commit: the error is not handled at LWT, but it seems
> actually innocent. The actual fix is the return value from the bpf
> redirect code. Let me incorporate both in the next one to justify
> better.
>=20
> --
> Yan
