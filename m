Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D6962E750
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 22:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbiKQVw2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 16:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbiKQVw0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 16:52:26 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933EF720B4
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 13:52:24 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id z15so1630411ilp.4
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIfCf35I7ypehLBPONCdMybY63wBWvIY0HsYk1HXqDc=;
        b=FwFpT9rEAOzbFMrQ1oETE5w3UkjxJG2IuYVttzZ2dC1284aFmSpcPVRiNVHQZcU+so
         RrgucbqQmdEoPE/BmvWYhbHRQHWPyDf5Qvn9dPzT3lMDNGYj+bN+l30DNAsICMaWyM5x
         6MIRb64hzBHkuexsAifzULV9iwNA+Np52/yB+fWncqJtKV1T9GoFBnDfZTl49lNSsyqg
         Dvj4i3R0dSnj/Dn3tbYWx3lurf0ku4zt9sqxvU1JqtGth1EBIECzDZ4wBfU3ikufzXv5
         TlsBiS9URvFZUeHMfzBRvbDUv+LoFCQK/5BMahxU49xLbrsDAYeknF3hWxOgB6gATdkk
         yqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIfCf35I7ypehLBPONCdMybY63wBWvIY0HsYk1HXqDc=;
        b=wb4wOF8UOoAKe+BPshwqIPhuOLqLG0JGiMFCDIoyTx+uSaNEo8gcgoiBFvuGkN0Hvp
         XecZkTohFYwsjozSioJeySsGvm2tOZEp4O3wuEgRVfIfohXaKE8WJQC1CJMTKRnBq/XK
         ldZCkN1DPLCKY6HrUCTvCY/yjqAnVBesy8EcEowIvsB5vCSXLxASoJQ8+bc/mnUwn2j9
         zwsEMwjTe1JUigrp+mBB9V/pvx/So4X3oRzA32O7zuaJKWKA0j7YFTEA59jp2nPiNHO4
         /H788cmhSBJJS3CKtt4LHKjcAHIpX6TKBEYPJ/nfq6Npa/MkBU7un7GMEyVZ3iTk/ef0
         W8rg==
X-Gm-Message-State: ANoB5pnLKmOdOVjfIwantDi+0IktFL+NEls9e9uNBQ+Y/BugJC4mkcwJ
        OxEb0ekBWn2R0+zxMws5nOD9MF5qGSYNC+1sgVWJgg==
X-Google-Smtp-Source: AA0mqf4sHBRBgXFO6vYaegWinsM12EWK6jnEiNEoIlD8jNSI1TQdnDv64G2kvFZuIoVD6UdIdnHz3M94FVFnC+Hfo98=
X-Received: by 2002:a92:c086:0:b0:2ea:ba31:f2ef with SMTP id
 h6-20020a92c086000000b002eaba31f2efmr2001158ile.159.1668721943842; Thu, 17
 Nov 2022 13:52:23 -0800 (PST)
MIME-Version: 1.0
References: <tencent_E1424259BD97672AD1AF00A3468858065E08@qq.com>
In-Reply-To: <tencent_E1424259BD97672AD1AF00A3468858065E08@qq.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 17 Nov 2022 13:52:12 -0800
Message-ID: <CAKH8qBsAC4qHSQ7TYnkXEMM68rqOz8gxuZJBxVdSkzhpQ8MR-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix error: undeclared
 identifier 'NF_NAT_MANIP_SRC'
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, dxu@dxuuu.xyz,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lkp@intel.com, lorenzo@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, mykolal@fb.com,
        rongtao@cestc.cn, shuah@kernel.org, song@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 17, 2022 at 7:17 AM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> commit 472caa69183f("netfilter: nat: un-export nf_nat_used_tuple")
> introduce NF_NAT_MANIP_SRC/DST enum in include/net/netfilter/nf_nat.h,
> and commit b06b45e82b59("selftests/bpf: add tests for bpf_ct_set_nat_info
> kfunc") use NF_NAT_MANIP_SRC/DST in test_bpf_nf.c.
>
> In bpf kself-test config (tools/testing/selftests/bpf/config) nf_nat
> is compiled as built-in, this issue occurs just if it is compiled as
> module. We could use BPF CO-RE and ___suffix rule to avoid this.
>
> How to reproduce the error:
>
>     $ make -C tools/testing/selftests/bpf/
>     ...
>       CLNG-BPF [test_maps] test_bpf_nf.bpf.o
>       error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
>             bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>                                                            ^
>       error: use of undeclared identifier 'NF_NAT_MANIP_DST'
>             bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>                                                            ^
>     2 errors generated.
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
> v2: use BPF CO-RE and ___suffix rule to avoid this error.
> v1: https://lore.kernel.org/lkml/tencent_29D7ABD1744417031AA1B52C914B61158E07@qq.com/
> ---
>  .../testing/selftests/bpf/progs/test_bpf_nf.c | 30 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> index 227e85e85dda..1706984e1a6a 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> @@ -2,6 +2,7 @@
>  #include <vmlinux.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_endian.h>
> +#include <bpf/bpf_core_read.h>
>
>  #define EAFNOSUPPORT 97
>  #define EPROTO 71
> @@ -11,6 +12,11 @@
>
>  extern unsigned long CONFIG_HZ __kconfig;
>
> +enum nf_nat_manip_type___x {
> +       NF_NAT_MANIP_SRC___x,
> +       NF_NAT_MANIP_DST___x,
> +};
> +
>  int test_einval_bpf_tuple = 0;
>  int test_einval_reserved = 0;
>  int test_einval_netns_id = 0;
> @@ -58,7 +64,7 @@ int bpf_ct_change_timeout(struct nf_conn *, u32) __ksym;
>  int bpf_ct_set_status(struct nf_conn *, u32) __ksym;
>  int bpf_ct_change_status(struct nf_conn *, u32) __ksym;
>  int bpf_ct_set_nat_info(struct nf_conn *, union nf_inet_addr *,
> -                       int port, enum nf_nat_manip_type) __ksym;
> +                       int port, int type) __ksym;
>
>  static __always_inline void
>  nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
> @@ -151,16 +157,34 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
>                 union nf_inet_addr saddr = {};
>                 union nf_inet_addr daddr = {};
>                 struct nf_conn *ct_ins;
> +               int manip_src;
> +               int manip_dst;
> +               enum nf_nat_manip_type___x mapip_type_x;
> +
> +               if (!bpf_core_type_exists(enum nf_nat_manip_type)) {
> +                       bpf_printk("enum nf_nat_manip_type not exist.\n");
> +                       return;
> +               }
> +
> +               if (bpf_core_enum_value_exists(mapip_type_x, NF_NAT_MANIP_SRC___x))
> +                       manip_src = bpf_core_enum_value(mapip_type_x, NF_NAT_MANIP_SRC___x);
> +               else
> +                       return;
> +
> +               if (bpf_core_enum_value_exists(mapip_type_x, NF_NAT_MANIP_DST___x))
> +                       manip_dst = bpf_core_enum_value(mapip_type_x, NF_NAT_MANIP_DST___x);
> +               else
> +                       return;
>
>                 bpf_ct_set_timeout(ct, 10000);
>                 ct->mark = 77;
>
>                 /* snat */
>                 saddr.ip = bpf_get_prandom_u32();
> -               bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
> +               bpf_ct_set_nat_info(ct, &saddr, sport, manip_src);

I'm not sure these co-re checks are helpful. Can we just hardcode 1/0
here and below?

bpf_ct_set_nat_info(ct, &saddr, sport, 0 /*NF_NAT_MANIP_SRC*/);
bpf_ct_set_nat_info(ct, &daddr, dport, 1 /*NF_NAT_MANIP_DST*/);

But I'm also overall not sure we need to make this test flexible; we
have a lot of tests that depend on tools/testing/selftests/bpf/config;
at some point I was trying to make the tests more tolerant to
different environments, but it went nowhere..


>                 /* dnat */
>                 daddr.ip = bpf_get_prandom_u32();
> -               bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
> +               bpf_ct_set_nat_info(ct, &daddr, dport, manip_dst);
>
>                 ct_ins = bpf_ct_insert_entry(ct);
>                 if (ct_ins) {
> --
> 2.31.1
>
