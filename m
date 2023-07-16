Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C541754DB8
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jul 2023 09:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjGPHtE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Jul 2023 03:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPHtD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Jul 2023 03:49:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E451BF
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Jul 2023 00:49:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so30141965e9.3
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Jul 2023 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689493741; x=1692085741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bxPvz8cMswTTAWRzifMWMC21fRi3cQcESIrQBlKCw1E=;
        b=abLxdzFHoEflYGrY949ZeA1zKxAU5gyMFSG5PNf+O78DPaTYBMsuPv61KaJd2XwxEP
         NK++3V4bs6+MaGINrv7wG8cV/btv+ihU6vA9/ex8xdkGS1NH6CXWS73IvVAPXRt6s0Eh
         2JrVcicR7qRhVPMCnrmGyyQdPF0lbHlRVA8xrcxiPLe29WvDuKx59OgogIlb9HfsLYfM
         fiIYkO1LThA/kYYQFl5yk9daBv05bQAxSDnRuOmugvIc4SgMN/0c9P7z8klOWyuUfWDP
         iOVF7fcC0gWtfkbMNxAZlYYcVEROxr7wVFuPlxv0ESqnsnw5KI70b1S6nW+BNAUydu0z
         G2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689493741; x=1692085741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxPvz8cMswTTAWRzifMWMC21fRi3cQcESIrQBlKCw1E=;
        b=GJQeNG2jIgjB5VZ2+1V559McZT32McRjgSBKK+BSQJlJU+wJhM0TraGsxpJiGmSRSJ
         v/3N1de1ZQkk1nxMFLGEJCnkU/8QaTStalkhVHEXnWxEOGmoz8p8BCrTPUnCgDdeHaDO
         5tZ7ILSQAwm46iQ7yoLjPuO1SZf4SJL/Ijv5lSrMeiBuRTGa3ZiqPkr6KNSYqqpfSBMH
         Kx/umpr3oR5lPaTSE1rb4qGdhM5E97aDzIKVUZw3kWZQLsawj2G9AUqXH2CSDFndj3B7
         YcXpWmV98CqrxwFLWJrTrp8JpodSXnCAKXxJWGfCNSe1+X6SXUn1gXidzPt3tsDGz1xC
         J9TQ==
X-Gm-Message-State: ABy/qLYiXyeYEQaiu4tGys/2qsfztFXjpfbPxFba0TNsWJXs263yvXlm
        VZiyHVD0DK39eUJ0B9C+3nQVyw==
X-Google-Smtp-Source: APBJJlFLUp12727mVwnd5MY2IOu6lNOcUA55USqhYdE6mHTm3sENZgCDk8CTh51otCxV6LINvVk4wA==
X-Received: by 2002:a1c:ed1a:0:b0:3fc:5a3:367c with SMTP id l26-20020a1ced1a000000b003fc05a3367cmr7388693wmh.32.1689493740389;
        Sun, 16 Jul 2023 00:49:00 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c214700b003fbc681c8d1sm5142870wml.36.2023.07.16.00.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 00:48:59 -0700 (PDT)
Date:   Sun, 16 Jul 2023 07:50:08 +0000
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Subject: Re: [PATCH bpf-next 1/3] bpf: consider CONST_PTR_TO_MAP as trusted
 pointer to struct bpf_map
Message-ID: <ZLOhMDZIjikWdWf5@zh-lab-node-5>
References: <20230714141747.41560-1-aspsk@isovalent.com>
 <20230714142100.42265-1-aspsk@isovalent.com>
 <20230714142100.42265-2-aspsk@isovalent.com>
 <CAADnVQJztACtOx8UEyWJqTXd95DBDWsNEAG284Ci4N7Ma8Fqgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJztACtOx8UEyWJqTXd95DBDWsNEAG284Ci4N7Ma8Fqgw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 14, 2023 at 10:56:00AM -0700, Alexei Starovoitov wrote:
> On Fri, Jul 14, 2023 at 7:20 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > Patch verifier to regard values of type CONST_PTR_TO_MAP as trusted
> > pointers to struct bpf_map. This allows kfuncs to work with `struct
> > bpf_map *` arguments.
> >
> > Save some bytes by defining btf_bpf_map_id as BTF_ID_LIST_GLOBAL_SINGLE
> > (which is u32[1]), not as BTF_ID_LIST (which is u32[64]).
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  include/linux/btf_ids.h | 1 +
> >  kernel/bpf/map_iter.c   | 3 +--
> >  kernel/bpf/verifier.c   | 5 ++++-
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > index 00950cc03bff..a3462a9b8e18 100644
> > --- a/include/linux/btf_ids.h
> > +++ b/include/linux/btf_ids.h
> > @@ -267,5 +267,6 @@ MAX_BTF_TRACING_TYPE,
> >  extern u32 btf_tracing_ids[];
> >  extern u32 bpf_cgroup_btf_id[];
> >  extern u32 bpf_local_storage_map_btf_id[];
> > +extern u32 btf_bpf_map_id[];
> >
> >  #endif
> > diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> > index d06d3b7150e5..b67996147895 100644
> > --- a/kernel/bpf/map_iter.c
> > +++ b/kernel/bpf/map_iter.c
> > @@ -78,8 +78,7 @@ static const struct seq_operations bpf_map_seq_ops = {
> >         .show   = bpf_map_seq_show,
> >  };
> >
> > -BTF_ID_LIST(btf_bpf_map_id)
> > -BTF_ID(struct, bpf_map)
> > +BTF_ID_LIST_GLOBAL_SINGLE(btf_bpf_map_id, struct, bpf_map)
> >
> >  static const struct bpf_iter_seq_info bpf_map_seq_info = {
> >         .seq_ops                = &bpf_map_seq_ops,
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0b9da95331d7..5663f97ef292 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5419,6 +5419,9 @@ static bool is_trusted_reg(const struct bpf_reg_state *reg)
> >         if (reg->ref_obj_id)
> >                 return true;
> >
> > +       if (reg->type == CONST_PTR_TO_MAP)
> > +               return true;
> > +
> 
> Overall it looks great.
> Instead of above, how about the following instead:
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0b9da95331d7..cd08167dc347 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10775,7 +10775,7 @@ static int check_kfunc_args(struct
> bpf_verifier_env *env, struct bpf_kfunc_call_
>                         if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
>                                 break;
> 
> -                       if (!is_trusted_reg(reg)) {
> +                       if (!is_trusted_reg(reg) &&
> !reg2btf_ids[base_type(reg->type)]) {
> 
> 
> This way we won't need to list every convertible type in is_trusted_reg.
> 
> I'm a bit hesitant to put reg2btf_ids[] check directly into is_trusted_reg().
> Maybe it's ok, but it needs more analysis.

I am not sure I see a difference in adding a check you proposed above and
adding the reg2btf_ids[] check directly into the is_trusted_reg() function.
Basically, we say "if type is in reg2btf_ids[], then consider it trusted" in
both cases. AFAIS, currently the reg2btf_ids[] contains only trusted types,
however, could it happen that we add a non-trusted type there?

So, I would leave the patch as is (which also makes sense because the
const-ptr-to-map is a special case), or add the "reg2btf_ids[] check" 
directly into the is_trusted_reg() function.
