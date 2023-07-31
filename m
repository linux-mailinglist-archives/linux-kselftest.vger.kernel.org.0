Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B6476A2F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 23:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjGaVf6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 17:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjGaVfs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 17:35:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C79210C
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 14:35:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5221cf2bb8cso7304233a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 14:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690839313; x=1691444113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoQ6AMqbH7T3p3Yr5Pye74Q6WCQZL+lK6DdYCEXr40o=;
        b=YDtNwl2gvEdzUtsqGkrJjlUralI+dGLNS813sAQedgc5FSaOYZgvtEZA5Z6tcC5UzI
         mAbX/ZGY5EoRq2jjO8qgvt2qAHUGcfWv5FM3ponM9TkB2ywUB90eka8w3BAjewqY0rnv
         qprjOTgYL1vA4ZCIVQBHw0ksn9cr7Ls/qYsFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690839313; x=1691444113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoQ6AMqbH7T3p3Yr5Pye74Q6WCQZL+lK6DdYCEXr40o=;
        b=GV3PILLvzBrIQC7v+fwW7O9poUD/oTTIGO7UkalztiTuLxhstdmGnjcqiKqnglSmWt
         JvX6oBiS28Tw55Vj5eBItXgFj0QlND04dO8iktFulSNFWLeasRzjcRysDdafLjNXa1je
         h920Lz9f0AhRzNiZ3wsZY6fYQAsYzxXIjKW+0GQiqw4kYqIn7xptjlfcIqqySXpV7ifJ
         MaAcBRcO/sxoPhu4DR+nkeG5wGk9U4cIHo77/+y6PizhI+tgb6uqJp4QNGaWqPvnqP+w
         Ote6s1yGNiJtHzF6A5Sc+S2NYAQx++ZY++fc7xizg7X2bUujERGyyZMkKnw7BWsvAc3M
         qcFA==
X-Gm-Message-State: ABy/qLZ8PQSMovFoWb8aHcxedmfW9zijYorNID68IVgkRX2DzvqaqqCZ
        1FqLtL0HSC8reBHf1tbBjTJx2qhU3146W7nDEIkLKg==
X-Google-Smtp-Source: APBJJlFBfBMR6ifd3iBPqOfNdGmVDUsQS4R69cJOXFItn8JIAmskEdBDTXCgE3bDvE3zYTLX2ZEuz5+VLMSkWvgFjmg=
X-Received: by 2002:aa7:d311:0:b0:522:4dd0:de6e with SMTP id
 p17-20020aa7d311000000b005224dd0de6emr825060edq.8.1690839312703; Mon, 31 Jul
 2023 14:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690332693.git.yan@cloudflare.com> <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
 <266ab56e-ae83-7ddc-618e-3af228df81bd@linux.dev>
In-Reply-To: <266ab56e-ae83-7ddc-618e-3af228df81bd@linux.dev>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Mon, 31 Jul 2023 16:35:01 -0500
Message-ID: <CAO3-Pbon7tCdChnK9kZ4992C-AFPvE5gTDWre6dQT9npEMxS2Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
        Jordan Griege <jgriege@cloudflare.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 5:02=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 7/25/23 6:08 PM, Yan Zhai wrote:
> > skb_do_redirect returns various of values: error code (negative),
> > 0 (success), and some positive status code, e.g. NET_XMIT_CN,
> > NET_RX_DROP. Commit 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel
> > infrastructure") didn't check the return code correctly, so positive
> > values are propagated back along call chain:
> >
> >    ip_finish_output2
> >      -> bpf_xmit
> >        -> run_lwt_bpf
> >          -> skb_do_redirect
>
>  From looking at skb_do_redirect, the skb_do_redirect should have consume=
d the
> skb except for the -EAGAIN return value. afaik, -EAGAIN could only happen=
 by
> using the bpf_redirect_peer helper. lwt does not have the bpf_redirect_pe=
er
> helper available, so there is no -EAGAIN case in lwt. iow, skb_do_redirec=
t
> should have always consumed the skb in lwt. or did I miss something?
>
> If that is the case, it feels like the fix should be in run_lwt_bpf() and=
 the
> "if (ret =3D=3D 0)" test in run_lwt_bpf() is unnecessary?
>
>                         ret =3D skb_do_redirect(skb);
>                         if (ret =3D=3D 0)
>                                 ret =3D BPF_REDIRECT;
>
>
Just fixing skb redirect return code won't be sufficient. I realized
there are other return paths that need to be treated, e.g. bpf reroute
path also directly returns dev_queue_xmit status. I plan to check for
LWTUNNEL_XMIT_CONTINUE (and change it to a value that does not
conflict with NET_RX_DROP and NET_XMIT_DROP) in the next revision. On
the other hand, the return value of NETDEV_TX_BUSY is another hassle.
As Dan suggested, packets might not have been freed when this is
returned from drivers. The caller of dev_queue_xmit might need to free
skb when this happens.

Yan
