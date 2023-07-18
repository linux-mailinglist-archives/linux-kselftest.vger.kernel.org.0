Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7598E7588FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 01:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjGRXRl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 19:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGRXRl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 19:17:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F008DE0;
        Tue, 18 Jul 2023 16:17:37 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b701dee4bfso99026221fa.0;
        Tue, 18 Jul 2023 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689722256; x=1692314256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzQPWMhde2JM67Z9YJrSaWfoJkaH/VUF8uE77z0Cvjs=;
        b=rG9L+BKfL/ZAsrVSJFjjM0DSy6iUlGpCJj7xKQLmo38tapnIoC3I0vh908W1HRwDiz
         ZdboHB0TxJz6lM7sRMCZl1UDqZLhIF4QngAF+N+KCUycBygVpXvRswmcyJcO+IKdl9UN
         1WzC+iZXqkkOgrpiVEyKxYPOLtB2bqY2Xy+c8TcBVNNzFTpsCP5b2+7b0FHzxdzrzdLA
         3AusKdeNBQviiiQiD9bknJ+fEBnudpUkMdqY1FPx1y3HGmA1m6RN8Z/UJuOxCWTScjFx
         47fCOABvJFLVvkFbJEtAsSdW11fiUW416yHS77jaF/M6VUuHnQ3aiFabutqqyq4gmMQn
         uGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689722256; x=1692314256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzQPWMhde2JM67Z9YJrSaWfoJkaH/VUF8uE77z0Cvjs=;
        b=QPiqTgv+SGBwuA/Af24hGaTgoZ8pZzH7KZNkgZ88Cw6QOpnjo4mfoSACrZH0bJreL1
         MVwhfGB/k0ZjXCk2vBLpZgKynFZMXfAFfeQEDuvHnF0hPibtehflPvTb9In/ckuqFk6m
         klI+zUUG50hERqG+TITAqgwWh+gzk19VEcVYi/829mINMF6ndKsbfzegwN8LD2CWDdEL
         uvorsmsifNmVf6q78DEY2v4w+R8pY/LSd+2PrPlWIpz23qVeRjRqGEhSy70dLS+7uCw0
         C0LLv67lXHukcv1xF92f+s0D6jAJDiUV6Te8gLaRfVc75JrQ4DEzAsSpyVbMUc1wYKwa
         yuUQ==
X-Gm-Message-State: ABy/qLa32NsYCyKxIpaAxPF2iUUtdFJSEOBqNRZKj8MSYDqXVH63N2AW
        ngcIrRWMVirvb5/JpWQ3/1j8iBRvK5gfFwStNOY=
X-Google-Smtp-Source: APBJJlGkLoDh1ODwOzmp3eyc+xlIMgI+sCLOu5u7rDsta6T/G2AcYkpW2zxgbdZ/Z7FLVj7VkQ93dhSxUU4lB6ga2oI=
X-Received: by 2002:a2e:9d45:0:b0:2b9:40c7:f5ed with SMTP id
 y5-20020a2e9d45000000b002b940c7f5edmr4594165ljj.17.1689722256001; Tue, 18 Jul
 2023 16:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230502005218.3627530-1-drosen@google.com> <20230718082615.08448806@kernel.org>
 <CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
 <20230718090632.4590bae3@kernel.org> <CAADnVQ+4aehGYPJ2qT_HWWXmOSo4WXf69N=N9-dpzERKfzuSzQ@mail.gmail.com>
 <20230718101841.146efae0@kernel.org> <CAADnVQ+jAo4V-Pa9_LhJEwG0QquL-Ld5S99v3LNUtgkiiYwfzw@mail.gmail.com>
 <20230718111101.57b1d411@kernel.org> <CAADnVQLJBiB7pWDTDNgQW_an+YoB61xkNEsa5g8p6zTy-mAG7Q@mail.gmail.com>
 <20230718160612.71f09752@kernel.org>
In-Reply-To: <20230718160612.71f09752@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 18 Jul 2023 16:17:24 -0700
Message-ID: <CAADnVQ+3Bmm0DgGBgh_zkA1JeK7uApo_nnJ+=Sgf4ojGX2KrHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
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

On Tue, Jul 18, 2023 at 4:06=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 18 Jul 2023 13:34:06 -0700 Alexei Starovoitov wrote:
> > > Direct packet access via skb->data is there for those who want high
> > > speed =F0=9F=A4=B7=EF=B8=8F
> >
> > skb->data/data_end approach unfortunately doesn't work that well.
> > Too much verifier fighting. That's why dynptr was introduced.
>
> I wish Daniel told us more about the use case.
>
> > > My worry is that people will think that whether the buffer is needed =
or
> > > not depends on _their program_, rather than on the underlying platfor=
m.
> > > So if it works in testing without the buffer - the buffer must not be
> > > required for their use case.
> >
> > Are you concerned about bpf progs breaking this way?
>
> Both, BPF progs breaking and netdev code doing things which don't make
> sense. But I won't argue too hard about the former, i.e. the BPF API.
>
> > I thought you're worried about the driver misusing
> > skb_header_pointer() with buffer=3D=3DNULL.
> >
> > We can remove !buffer check as in the attached patch,
> > but I don't quite see how it would improve driver quality.
>
> The drivers may not be pretty but they aren't buggy AFAICT.
>
> > [0001-bpf-net-Introduce-skb_pointer_if_linear.patch  application/octet-=
stream (2873 bytes)]
>
> Or we can simply pretend we don't have the skb:
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 91ed66952580..217447f01d56 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4023,7 +4023,7 @@ __skb_header_pointer(const struct sk_buff *skb, int=
 offset, int len,
>         if (likely(hlen - offset >=3D len))
>                 return (void *)data + offset;
>
> -       if (!skb || !buffer || unlikely(skb_copy_bits(skb, offset, buffer=
, len) < 0))
> +       if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0)=
)
>                 return NULL;
>
>         return buffer;
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9e80efa59a5d..8bc4622cc1df 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2239,7 +2239,13 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bp=
f_dynptr_kern *ptr, u32 offset
>         case BPF_DYNPTR_TYPE_RINGBUF:
>                 return ptr->data + ptr->offset + offset;
>         case BPF_DYNPTR_TYPE_SKB:
> -               return skb_header_pointer(ptr->data, ptr->offset + offset=
, len, buffer__opt);
> +       {
> +               const struct sk_buff *skb =3D ptr->data;
> +
> +               return __skb_header_pointer(NULL, ptr->offset + offset, l=
en,
> +                                           skb->data, skb_headlen(skb),
> +                                           buffer__opt);
> +       }

Which would encourage bnxt-like hacks.
I don't like it tbh.
At least skb_pointer_if_linear() has a clear meaning.
It's more run-time overhead, since buffer__opt is checked early,
but that's ok.
