Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26BD62E9E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 00:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiKQX5U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 18:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKQX5T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 18:57:19 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0601B7ED;
        Thu, 17 Nov 2022 15:57:18 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z18so4898562edb.9;
        Thu, 17 Nov 2022 15:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yjUoFiBiFtf4ovqXKv3ngDDZlV/4c29oSzioK1ixLWE=;
        b=UIakpxJhpqIS/PFa5VipGn52ESjp37zIfUkxnby8IV3286QADCd7GA3BQSfX+oVses
         QGbu/veNeoIXk0Qi/fYNbjghpwOEBsH42NTwSDTz2OSQmOuo2Yrkohq9pknUf34/25dR
         zoeEv9FZLK7V/aXetruGh1xH7letjBCByyH5o7XNGAzSu12NihN0LLJC6cy7cqo91Pog
         6Orj7y0IZaHqzw+9jXge15XI0xDSXbJjddRbcIoJleKDtaZRT1/2objshU+nblanyaIL
         Bx3H1He3wwyOTL+O9myBxmWOrJeoSO5iHQnCDx3XviLkMD9x9QTd4yWRpQY/951cHjf0
         WguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjUoFiBiFtf4ovqXKv3ngDDZlV/4c29oSzioK1ixLWE=;
        b=Yzc2IKo80vsDbk4rZ36xNUKk/HC69EHl5zdSY4XayLND/C9lj2zmXGKcs51FWUVuv4
         cEXKRLnVqUstBxSZA5Bp8b/7CdpA/9baM6UQ5XdxnE0p4X7eo+Crg2l6VbL+JJrJJO6r
         HLvmygVMiWVHBvDC+GHh6s8C6f1UiBiw9J012VFv+mqXY+yrDj4siBOmjrl3M6RaKgQL
         BzQ0DnfnWfdMaBv7asH/zIlQdG/wXMYDIoQEuqbhGVIvHnLAse6HVgnJXNLnLeQJgABs
         zG1oZG68wyS1rs3pGADAtqomANZJbOancqar6DShEKK0N6omcfCSBvBzm+QwKx4rJESc
         rYrQ==
X-Gm-Message-State: ANoB5pk/n9bK/mzYj7v1MsWT/QgXnNHeqRdj7UXmM4zkr1e4H7HJCR1b
        FUnOojWQyuZq2HAUdn2AdUJhaxgZzv5mEOf/JJ4=
X-Google-Smtp-Source: AA0mqf5Yer3RXa/ls1/THY+ZW8wLWvZ0dNgAuBjrBaHCJG/4z0B3yuE913ejWYDULg2nnVULICpzw7HPiDeZwGBChgk=
X-Received: by 2002:a05:6402:4008:b0:458:dd63:e339 with SMTP id
 d8-20020a056402400800b00458dd63e339mr4014232eda.81.1668729437145; Thu, 17 Nov
 2022 15:57:17 -0800 (PST)
MIME-Version: 1.0
References: <tencent_E1424259BD97672AD1AF00A3468858065E08@qq.com> <CAKH8qBsAC4qHSQ7TYnkXEMM68rqOz8gxuZJBxVdSkzhpQ8MR-Q@mail.gmail.com>
In-Reply-To: <CAKH8qBsAC4qHSQ7TYnkXEMM68rqOz8gxuZJBxVdSkzhpQ8MR-Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Nov 2022 15:57:05 -0800
Message-ID: <CAEf4BzZE5=OOp6OesB=P8PE=Ps62fkecDSZ9MzwHCD68=+oN0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix error: undeclared
 identifier 'NF_NAT_MANIP_SRC'
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, dxu@dxuuu.xyz,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lkp@intel.com, lorenzo@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, mykolal@fb.com,
        rongtao@cestc.cn, shuah@kernel.org, song@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 17, 2022 at 1:52 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Thu, Nov 17, 2022 at 7:17 AM Rong Tao <rtoax@foxmail.com> wrote:
> >
> > From: Rong Tao <rongtao@cestc.cn>
> >
> > commit 472caa69183f("netfilter: nat: un-export nf_nat_used_tuple")
> > introduce NF_NAT_MANIP_SRC/DST enum in include/net/netfilter/nf_nat.h,
> > and commit b06b45e82b59("selftests/bpf: add tests for bpf_ct_set_nat_info
> > kfunc") use NF_NAT_MANIP_SRC/DST in test_bpf_nf.c.
> >
> > In bpf kself-test config (tools/testing/selftests/bpf/config) nf_nat
> > is compiled as built-in, this issue occurs just if it is compiled as
> > module. We could use BPF CO-RE and ___suffix rule to avoid this.
> >
> > How to reproduce the error:
> >
> >     $ make -C tools/testing/selftests/bpf/
> >     ...
> >       CLNG-BPF [test_maps] test_bpf_nf.bpf.o
> >       error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
> >             bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
> >                                                            ^
> >       error: use of undeclared identifier 'NF_NAT_MANIP_DST'
> >             bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
> >                                                            ^
> >     2 errors generated.
> >
> > Signed-off-by: Rong Tao <rongtao@cestc.cn>
> > ---
> > v2: use BPF CO-RE and ___suffix rule to avoid this error.
> > v1: https://lore.kernel.org/lkml/tencent_29D7ABD1744417031AA1B52C914B61158E07@qq.com/
> > ---
> >  .../testing/selftests/bpf/progs/test_bpf_nf.c | 30 +++++++++++++++++--
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > index 227e85e85dda..1706984e1a6a 100644
> > --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > @@ -2,6 +2,7 @@
> >  #include <vmlinux.h>
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_endian.h>
> > +#include <bpf/bpf_core_read.h>
> >
> >  #define EAFNOSUPPORT 97
> >  #define EPROTO 71
> > @@ -11,6 +12,11 @@
> >
> >  extern unsigned long CONFIG_HZ __kconfig;
> >
> > +enum nf_nat_manip_type___x {
> > +       NF_NAT_MANIP_SRC___x,
> > +       NF_NAT_MANIP_DST___x,
> > +};
> > +
> >  int test_einval_bpf_tuple = 0;
> >  int test_einval_reserved = 0;
> >  int test_einval_netns_id = 0;
> > @@ -58,7 +64,7 @@ int bpf_ct_change_timeout(struct nf_conn *, u32) __ksym;
> >  int bpf_ct_set_status(struct nf_conn *, u32) __ksym;
> >  int bpf_ct_change_status(struct nf_conn *, u32) __ksym;
> >  int bpf_ct_set_nat_info(struct nf_conn *, union nf_inet_addr *,
> > -                       int port, enum nf_nat_manip_type) __ksym;
> > +                       int port, int type) __ksym;
> >
> >  static __always_inline void
> >  nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
> > @@ -151,16 +157,34 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
> >                 union nf_inet_addr saddr = {};
> >                 union nf_inet_addr daddr = {};
> >                 struct nf_conn *ct_ins;
> > +               int manip_src;
> > +               int manip_dst;
> > +               enum nf_nat_manip_type___x mapip_type_x;
> > +
> > +               if (!bpf_core_type_exists(enum nf_nat_manip_type)) {
> > +                       bpf_printk("enum nf_nat_manip_type not exist.\n");
> > +                       return;
> > +               }
> > +
> > +               if (bpf_core_enum_value_exists(mapip_type_x, NF_NAT_MANIP_SRC___x))
> > +                       manip_src = bpf_core_enum_value(mapip_type_x, NF_NAT_MANIP_SRC___x);
> > +               else
> > +                       return;
> > +
> > +               if (bpf_core_enum_value_exists(mapip_type_x, NF_NAT_MANIP_DST___x))
> > +                       manip_dst = bpf_core_enum_value(mapip_type_x, NF_NAT_MANIP_DST___x);
> > +               else
> > +                       return;
> >
> >                 bpf_ct_set_timeout(ct, 10000);
> >                 ct->mark = 77;
> >
> >                 /* snat */
> >                 saddr.ip = bpf_get_prandom_u32();
> > -               bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
> > +               bpf_ct_set_nat_info(ct, &saddr, sport, manip_src);
>
> I'm not sure these co-re checks are helpful. Can we just hardcode 1/0
> here and below?
>
> bpf_ct_set_nat_info(ct, &saddr, sport, 0 /*NF_NAT_MANIP_SRC*/);
> bpf_ct_set_nat_info(ct, &daddr, dport, 1 /*NF_NAT_MANIP_DST*/);
>
> But I'm also overall not sure we need to make this test flexible; we
> have a lot of tests that depend on tools/testing/selftests/bpf/config;
> at some point I was trying to make the tests more tolerant to
> different environments, but it went nowhere..

Agreed. bpf_core_enum_value_exists() makes no sense here.
bpf_core_enum_value(enum nf_nat_manip_type___x, NF_NAT_MANIP_SRC___x)
would be ok, IMHO. It will compile but fail at runtime if the module
is not loaded.

>
>
> >                 /* dnat */
> >                 daddr.ip = bpf_get_prandom_u32();
> > -               bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
> > +               bpf_ct_set_nat_info(ct, &daddr, dport, manip_dst);
> >
> >                 ct_ins = bpf_ct_insert_entry(ct);
> >                 if (ct_ins) {
> > --
> > 2.31.1
> >
