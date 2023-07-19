Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610E8758A74
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 02:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjGSAzb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 20:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGSAza (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 20:55:30 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11071FC0;
        Tue, 18 Jul 2023 17:55:06 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so94163291fa.2;
        Tue, 18 Jul 2023 17:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689728079; x=1692320079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1lgrdv/MLekx6tS4/WHkEIbIxXWLWmPvwLqshtCQQU=;
        b=o2ufsUKkT9w5RrRpHixndQ55WkKfEtvgXPMOxiSRb1W8AApe0zLM0mnlYZvqk+DgzW
         TUeYcI/tN8/xTDmfbwoln714sZ0ErkiF5/rLtuJwLD2cP3a74Dylfdx1UAew9oOHb62p
         MvYvm3R/Hf0QPAuwqUltbBWaHlX9HSM2F4l4Uihtg/gljlCAJc+Wkt6WJcK3PJ5Kj2LV
         zbInNKg7ViUsXPR/TrArzxQT1p9HGccjeCZUhlYkn5w1jjIdTP/6lmRNUA1UZyqX8iQU
         yQgxZ1qQPFLSnvrT9QIO+enMP1TSwmbax51N+WkLB++hQrkD6HOVgEqtQEjwDCtiMQ0q
         +FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689728079; x=1692320079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1lgrdv/MLekx6tS4/WHkEIbIxXWLWmPvwLqshtCQQU=;
        b=e/jKbie2MjEMhX34LOD5BQXN5dlTewNyXWTeQqkLH8gr0zKjWzbuXfwrlKYd2tDyoF
         KxmhhQmK3/iQMfS55fQHMh4O2MYficaFT8mtLNWYslrfUUvv8t65MtKvXpObwvGHIVvT
         zr4/oe3VJgTu8yWDCrFx3tA+je8Qffagjag/HC8PRiz2XnUqYjBTOUvdJGkUuCafW1Ss
         Tli/66eMjQ/8IH2Ewvou5xU5eeAGYMOscXjyeFguirLcWQra3GllNT1YfSnYpAZ/TDBz
         yjyS3cZt6sD59cLHVtAddO1ikMMGf6GZK/ektOVGkdU5gRfnqJqkjW/iVg9i6edyQCT/
         JhKA==
X-Gm-Message-State: ABy/qLbvzgNjuYfZxpcE/pq2mKOQEYrk+JSBMnpN3UrZj+inWzb71xUn
        vEo9IbgkTADXBNqq6gstgVVjGCz0Ux5Lj/TSewI=
X-Google-Smtp-Source: APBJJlEor4PxN+Pt7ws7HRCcZfxHIDALiZXwrqL6AsyfBhCGVtArPpUuMJUZDnXtAFitPbhb4HuEY4/91Majm3G6r7Y=
X-Received: by 2002:a2e:94c7:0:b0:2b6:e2aa:8fc2 with SMTP id
 r7-20020a2e94c7000000b002b6e2aa8fc2mr10302597ljh.46.1689728079063; Tue, 18
 Jul 2023 17:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230714141747.41560-1-aspsk@isovalent.com> <20230714142100.42265-1-aspsk@isovalent.com>
 <20230714142100.42265-2-aspsk@isovalent.com> <CAADnVQJztACtOx8UEyWJqTXd95DBDWsNEAG284Ci4N7Ma8Fqgw@mail.gmail.com>
 <ZLOhMDZIjikWdWf5@zh-lab-node-5>
In-Reply-To: <ZLOhMDZIjikWdWf5@zh-lab-node-5>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 18 Jul 2023 17:54:27 -0700
Message-ID: <CAADnVQLt=k6T0s3cRZRB26D+7TXcvR5CRk-q4SbKK6FQKuyjhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: consider CONST_PTR_TO_MAP as trusted
 pointer to struct bpf_map
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Hou Tao <houtao1@huawei.com>, Joe Stringer <joe@isovalent.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
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

On Sun, Jul 16, 2023 at 12:49=E2=80=AFAM Anton Protopopov <aspsk@isovalent.=
com> wrote:
>
> On Fri, Jul 14, 2023 at 10:56:00AM -0700, Alexei Starovoitov wrote:
> > On Fri, Jul 14, 2023 at 7:20=E2=80=AFAM Anton Protopopov <aspsk@isovale=
nt.com> wrote:
> > >
> > > Patch verifier to regard values of type CONST_PTR_TO_MAP as trusted
> > > pointers to struct bpf_map. This allows kfuncs to work with `struct
> > > bpf_map *` arguments.
> > >
> > > Save some bytes by defining btf_bpf_map_id as BTF_ID_LIST_GLOBAL_SING=
LE
> > > (which is u32[1]), not as BTF_ID_LIST (which is u32[64]).
> > >
> > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > ---
> > >  include/linux/btf_ids.h | 1 +
> > >  kernel/bpf/map_iter.c   | 3 +--
> > >  kernel/bpf/verifier.c   | 5 ++++-
> > >  3 files changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > > index 00950cc03bff..a3462a9b8e18 100644
> > > --- a/include/linux/btf_ids.h
> > > +++ b/include/linux/btf_ids.h
> > > @@ -267,5 +267,6 @@ MAX_BTF_TRACING_TYPE,
> > >  extern u32 btf_tracing_ids[];
> > >  extern u32 bpf_cgroup_btf_id[];
> > >  extern u32 bpf_local_storage_map_btf_id[];
> > > +extern u32 btf_bpf_map_id[];
> > >
> > >  #endif
> > > diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> > > index d06d3b7150e5..b67996147895 100644
> > > --- a/kernel/bpf/map_iter.c
> > > +++ b/kernel/bpf/map_iter.c
> > > @@ -78,8 +78,7 @@ static const struct seq_operations bpf_map_seq_ops =
=3D {
> > >         .show   =3D bpf_map_seq_show,
> > >  };
> > >
> > > -BTF_ID_LIST(btf_bpf_map_id)
> > > -BTF_ID(struct, bpf_map)
> > > +BTF_ID_LIST_GLOBAL_SINGLE(btf_bpf_map_id, struct, bpf_map)
> > >
> > >  static const struct bpf_iter_seq_info bpf_map_seq_info =3D {
> > >         .seq_ops                =3D &bpf_map_seq_ops,
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 0b9da95331d7..5663f97ef292 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -5419,6 +5419,9 @@ static bool is_trusted_reg(const struct bpf_reg=
_state *reg)
> > >         if (reg->ref_obj_id)
> > >                 return true;
> > >
> > > +       if (reg->type =3D=3D CONST_PTR_TO_MAP)
> > > +               return true;
> > > +
> >
> > Overall it looks great.
> > Instead of above, how about the following instead:
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0b9da95331d7..cd08167dc347 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10775,7 +10775,7 @@ static int check_kfunc_args(struct
> > bpf_verifier_env *env, struct bpf_kfunc_call_
> >                         if (!is_kfunc_trusted_args(meta) && !is_kfunc_r=
cu(meta))
> >                                 break;
> >
> > -                       if (!is_trusted_reg(reg)) {
> > +                       if (!is_trusted_reg(reg) &&
> > !reg2btf_ids[base_type(reg->type)]) {
> >
> >
> > This way we won't need to list every convertible type in is_trusted_reg=
.
> >
> > I'm a bit hesitant to put reg2btf_ids[] check directly into is_trusted_=
reg().
> > Maybe it's ok, but it needs more analysis.
>
> I am not sure I see a difference in adding a check you proposed above and
> adding the reg2btf_ids[] check directly into the is_trusted_reg() functio=
n.
> Basically, we say "if type is in reg2btf_ids[], then consider it trusted"=
 in
> both cases. AFAIS, currently the reg2btf_ids[] contains only trusted type=
s,
> however, could it happen that we add a non-trusted type there?
>
> So, I would leave the patch as is (which also makes sense because the
> const-ptr-to-map is a special case), or add the "reg2btf_ids[] check"
> directly into the is_trusted_reg() function.

Fair enough. Let's add reg2btf_ids[] to is_trusted_reg() directly.
