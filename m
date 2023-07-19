Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25696758E5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 09:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjGSHJS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 03:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGSHJR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 03:09:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49D3E47
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 00:09:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso60352065e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 00:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689750554; x=1692342554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AnRQdh3EEqJvpxETy5ODliVLYVhTAipKqSwZ1tgyM7s=;
        b=aTwmtP37x0bkdUYFbjUqUYnJC/Hnr+D9La8jEgyiierVL4utIhqhD1JTy+P+f+y/mq
         UXKokW7pEV5meRgolDZSxJ7N19/4DmWjiMeVcvYTPDLdjlidkQUIu6fATD7bXgYsUi5+
         QDsDb68YKoRkNiyCH5mzvEE+uIsQvdaHoFtI5FrxdLVyaP/VsEGlxadzIdv39txlqr8M
         ZmOPhQxhoDjonu4G4cLR6BjLvY5eh7gwcdHL91j5C314qlUhimptswBFolJ9CVmGacBk
         Ml8ckDptZTszCTHgyoEHGqJ2lzHA0ZRe9xh4tuA8rIrFHESi3UpHfTen3XB+x58nc/YG
         JJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689750554; x=1692342554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnRQdh3EEqJvpxETy5ODliVLYVhTAipKqSwZ1tgyM7s=;
        b=PH5AY3P8h8pqDTVNoUHun72IBv24gUte9Up820YRyrMjjyXbJxdhgM1CrTEqmir8Ux
         q/mtMt8OLkqiLWbWW8lbgKU4cSbmhyaTaOlSmfjeW4kdzPGPr4mBIDlhcKhaPEESA/du
         NElyl2Z/Sx8dCyeJHBDgRHuPLP576HCoepibWwDeZZVqZRAg239UKR8x9mggz1h5cprD
         9uIPOFxDcdDNmoi3LCiyV2BbOsglUoYPrerSADvyDTgWL1Jyc6zJqSBc2zKbVDW/FlYN
         SlIqsWFrkZ8NJPZsPrkDIUzvnJtkhKXc5T5B+UJ+pkYswKJGkA3DyTiixv0yfVP7n+/D
         CJYg==
X-Gm-Message-State: ABy/qLa/TAwnz00LQrzm8lgw1jFZXDWOelq6cULWRHEZUFIknTMZalSG
        /7JzwTm5+yunlGvQFFRDHml+Pg==
X-Google-Smtp-Source: APBJJlEHxNQB8OI0gK1JkgrcA6qpKfCt1495gUus2SsESAJnzz3dh8IXIELLzNbEHSWbTsk9l2XGjg==
X-Received: by 2002:adf:f48f:0:b0:315:adee:2e47 with SMTP id l15-20020adff48f000000b00315adee2e47mr14943637wro.30.1689750554376;
        Wed, 19 Jul 2023 00:09:14 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4204000000b00315a1c160casm4388505wrq.99.2023.07.19.00.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 00:09:13 -0700 (PDT)
Date:   Wed, 19 Jul 2023 07:10:23 +0000
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
Message-ID: <ZLeMX4cJnKeXJfqW@zh-lab-node-5>
References: <20230714141747.41560-1-aspsk@isovalent.com>
 <20230714142100.42265-1-aspsk@isovalent.com>
 <20230714142100.42265-2-aspsk@isovalent.com>
 <CAADnVQJztACtOx8UEyWJqTXd95DBDWsNEAG284Ci4N7Ma8Fqgw@mail.gmail.com>
 <ZLOhMDZIjikWdWf5@zh-lab-node-5>
 <CAADnVQLt=k6T0s3cRZRB26D+7TXcvR5CRk-q4SbKK6FQKuyjhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLt=k6T0s3cRZRB26D+7TXcvR5CRk-q4SbKK6FQKuyjhg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 18, 2023 at 05:54:27PM -0700, Alexei Starovoitov wrote:
> On Sun, Jul 16, 2023 at 12:49 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On Fri, Jul 14, 2023 at 10:56:00AM -0700, Alexei Starovoitov wrote:
> > > On Fri, Jul 14, 2023 at 7:20 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > >
> > > > Patch verifier to regard values of type CONST_PTR_TO_MAP as trusted
> > > > pointers to struct bpf_map. This allows kfuncs to work with `struct
> > > > bpf_map *` arguments.
> > > >
> > > > Save some bytes by defining btf_bpf_map_id as BTF_ID_LIST_GLOBAL_SINGLE
> > > > (which is u32[1]), not as BTF_ID_LIST (which is u32[64]).
> > > >
> > > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > > ---
> > > >  include/linux/btf_ids.h | 1 +
> > > >  kernel/bpf/map_iter.c   | 3 +--
> > > >  kernel/bpf/verifier.c   | 5 ++++-
> > > >  3 files changed, 6 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > > > index 00950cc03bff..a3462a9b8e18 100644
> > > > --- a/include/linux/btf_ids.h
> > > > +++ b/include/linux/btf_ids.h
> > > > @@ -267,5 +267,6 @@ MAX_BTF_TRACING_TYPE,
> > > >  extern u32 btf_tracing_ids[];
> > > >  extern u32 bpf_cgroup_btf_id[];
> > > >  extern u32 bpf_local_storage_map_btf_id[];
> > > > +extern u32 btf_bpf_map_id[];
> > > >
> > > >  #endif
> > > > diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> > > > index d06d3b7150e5..b67996147895 100644
> > > > --- a/kernel/bpf/map_iter.c
> > > > +++ b/kernel/bpf/map_iter.c
> > > > @@ -78,8 +78,7 @@ static const struct seq_operations bpf_map_seq_ops = {
> > > >         .show   = bpf_map_seq_show,
> > > >  };
> > > >
> > > > -BTF_ID_LIST(btf_bpf_map_id)
> > > > -BTF_ID(struct, bpf_map)
> > > > +BTF_ID_LIST_GLOBAL_SINGLE(btf_bpf_map_id, struct, bpf_map)
> > > >
> > > >  static const struct bpf_iter_seq_info bpf_map_seq_info = {
> > > >         .seq_ops                = &bpf_map_seq_ops,
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 0b9da95331d7..5663f97ef292 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -5419,6 +5419,9 @@ static bool is_trusted_reg(const struct bpf_reg_state *reg)
> > > >         if (reg->ref_obj_id)
> > > >                 return true;
> > > >
> > > > +       if (reg->type == CONST_PTR_TO_MAP)
> > > > +               return true;
> > > > +
> > >
> > > Overall it looks great.
> > > Instead of above, how about the following instead:
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 0b9da95331d7..cd08167dc347 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -10775,7 +10775,7 @@ static int check_kfunc_args(struct
> > > bpf_verifier_env *env, struct bpf_kfunc_call_
> > >                         if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
> > >                                 break;
> > >
> > > -                       if (!is_trusted_reg(reg)) {
> > > +                       if (!is_trusted_reg(reg) &&
> > > !reg2btf_ids[base_type(reg->type)]) {
> > >
> > >
> > > This way we won't need to list every convertible type in is_trusted_reg.
> > >
> > > I'm a bit hesitant to put reg2btf_ids[] check directly into is_trusted_reg().
> > > Maybe it's ok, but it needs more analysis.
> >
> > I am not sure I see a difference in adding a check you proposed above and
> > adding the reg2btf_ids[] check directly into the is_trusted_reg() function.
> > Basically, we say "if type is in reg2btf_ids[], then consider it trusted" in
> > both cases. AFAIS, currently the reg2btf_ids[] contains only trusted types,
> > however, could it happen that we add a non-trusted type there?
> >
> > So, I would leave the patch as is (which also makes sense because the
> > const-ptr-to-map is a special case), or add the "reg2btf_ids[] check"
> > directly into the is_trusted_reg() function.
> 
> Fair enough. Let's add reg2btf_ids[] to is_trusted_reg() directly.

Thanks, I will send v2.
