Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F906261AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 19:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiKKSz1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 13:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiKKSz1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 13:55:27 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE54D71F28
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 10:55:25 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id x16so2939108ilm.5
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 10:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g9eX0z58SKZAsOdWY7m+4OycDcrautiSe0xtp5Jr/YA=;
        b=oBkyoNti/n1H5DmNo5si5qEcD97KnH26ULsAv7/mh/gPF0I34K0iSx2MPU9UD9msZm
         OGWU3y4E2vepo7LW/uixh9h+9a92AbtaGcYsE1/LjAjOXmzCpzvh3pmBPWttCVExH/yf
         feeD9w1lk1m/pbK2qonPx/ctIIAYxGBHzYU6udBvP0y03PWol2GJBNV1HgVh6+oZjGEK
         SNJqvAdzsOZnmzyY/CR8tGtwXuJHbnVwSHCM4QqJRXM4ocObhIWDmVZZwsRl/gLI3mso
         +yKkXrnYTky4dY+fCjs0mZjcSZGlgSgVsw6+uxDkLuRJP5GQWH63URM3rN3hWmdNpy2d
         nO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9eX0z58SKZAsOdWY7m+4OycDcrautiSe0xtp5Jr/YA=;
        b=asnJvcHevWn1nhxnNL5Vg2rtrifemzA5qOtoir8ek53oAmgeOP9grjr8EFDY8G2ujX
         fk4kIEmEkVdrdi/B89xtXeDmQ1oxU0fJdTnPfUq4lzlrskz5bBhYi0HdUFAL99sMh+1P
         xqGURb81V5LxkmgGBatpMpCJQ9y0caJ9p6SifiuC33pWPMRWfJBQBOK/uhgdWQux8HcL
         m7SCD2jRhGBMDeLT3hP4Zc2AbawdRkMWzb8sy+/qw8TFQMuJVTRmE7/Tl88gtncaDNyp
         PtxTMYtdvy25TdW5c7AYFvc00MMdH3OzJxgR4GbAB9xtvWxWPFF2o81AKqiTpVT35VDI
         xkOw==
X-Gm-Message-State: ANoB5pkcHMJ9CZHeoY8JezrxknXFwP5Ql1LGueJUkuRLXNgMj7YfSrfI
        muGUWkJfmb4ZgUKzW+z2dB0vacTfKW1d8alinM4VwA==
X-Google-Smtp-Source: AA0mqf6hLmbobvzmsTs81beRE0LT0fUFgNcuW/eZQJXVhOOi5VsuVDwTovAvzok6/rTjGxsKTMoroYPCFtGti9Yy2CA=
X-Received: by 2002:a92:de41:0:b0:2ff:9e9f:6604 with SMTP id
 e1-20020a92de41000000b002ff9e9f6604mr1734778ilr.20.1668192925093; Fri, 11 Nov
 2022 10:55:25 -0800 (PST)
MIME-Version: 1.0
References: <tencent_29D7ABD1744417031AA1B52C914B61158E07@qq.com>
 <Y26FgIJLR3nVKjcb@google.com> <Y26MSS2twSskZ5J2@lore-desk>
 <CAKH8qBvxZBX7_GQYQzSrZ5j=P3rViyqNq3V3oo5CtEMR9BQepA@mail.gmail.com> <Y26QjqvVTosoCgPT@lore-desk>
In-Reply-To: <Y26QjqvVTosoCgPT@lore-desk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 11 Nov 2022 10:55:14 -0800
Message-ID: <CAKH8qBsA-r=7S9hrsX=S7wXMaUikNh0gY=PdQK0urjORahrVBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix error undeclared identifier 'NF_NAT_MANIP_SRC'
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Rong Tao <rtoax@foxmail.com>, ast@kernel.org,
        Rong Tao <rongtao@cestc.cn>, kernel test robot <lkp@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Daniel Xu <dxu@dxuuu.xyz>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Fri, Nov 11, 2022 at 10:12 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > On Fri, Nov 11, 2022 at 9:54 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >
> > > > On 11/11, Rong Tao wrote:
> > > > > From: Rong Tao <rongtao@cestc.cn>
> > > >
> > > > > commit 472caa69183f("netfilter: nat: un-export nf_nat_used_tuple")
> > > > > introduce NF_NAT_MANIP_SRC/DST enum in include/net/netfilter/nf_nat.h,
> > > > > and commit b06b45e82b59("selftests/bpf: add tests for bpf_ct_set_nat_info
> > > > > kfunc") use NF_NAT_MANIP_SRC/DST in test_bpf_nf.c. We copy enum
> > > > > nf_nat_manip_type to test_bpf_nf.c fix this error.
> > > >
> > > > > How to reproduce the error:
> > > >
> > > > >      $ make -C tools/testing/selftests/bpf/
> > > > >      ...
> > > > >        CLNG-BPF [test_maps] test_bpf_nf.bpf.o
> > > > >        error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
> > > > >              bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
> > > > >                                                             ^
> > > > >        error: use of undeclared identifier 'NF_NAT_MANIP_DST'
> > > > >              bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
> > > > >                                                             ^
> > > > >      2 errors generated.
> > > >
> > > > $ grep NF_NAT_MANIP_SRC
> > > > ./tools/testing/selftests/bpf/tools/include/vmlinux.h
> > > >         NF_NAT_MANIP_SRC = 0,
> > > >
> > > > Doesn't look like your kernel config compiles netfilter nat modules?
> > >
> > > yes, in bpf kself-test config (tools/testing/selftests/bpf/config) nf_nat
> > > is compiled as built-in. This issue occurs just if it is compiled as module.
> >
> > Right, but if we unconditionally define this enum, I think you'll
> > break the case where it's compiled as a built-in?
> > Since at least in my vmlinux.h I have all the defines and this test
> > includes vmlinux.h...
>
> yes, it is correct.

And it will break the CI:

$ grep NETFILTER tools/testing/selftests/bpf/config
CONFIG_NETFILTER=y

So yeah, not sure what to do here. The selftests expect "sane" configs
(see that bpf/config above) which is not what the bot seems to be
doing...

> > > Regards,
> > > Lorenzo
> > >
> > > >
> > > > > Link: https://lore.kernel.org/lkml/202210280447.STsT1gvq-lkp@intel.com/
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Signed-off-by: Rong Tao <rongtao@cestc.cn>
> > > > > ---
> > > > >   tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
> > > > >   1 file changed, 5 insertions(+)
> > > >
> > > > > diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > > > b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > > > index 227e85e85dda..307ca166ff34 100644
> > > > > --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > > > +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > > > @@ -3,6 +3,11 @@
> > > > >   #include <bpf/bpf_helpers.h>
> > > > >   #include <bpf/bpf_endian.h>
> > > >
> > > > > +enum nf_nat_manip_type {
> > > > > +   NF_NAT_MANIP_SRC,
> > > > > +   NF_NAT_MANIP_DST
> > > > > +};
> > > > > +
> > > > >   #define EAFNOSUPPORT 97
> > > > >   #define EPROTO 71
> > > > >   #define ENONET 64
> > > > > --
> > > > > 2.31.1
> > > >
