Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267D262631B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 21:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiKKUoX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 15:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiKKUoW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 15:44:22 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494C145A26;
        Fri, 11 Nov 2022 12:44:21 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a67so9149115edf.12;
        Fri, 11 Nov 2022 12:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B12MKUKtvOLgGXlIX/YXOWokDcl/6BmGBXPeQeFKB1E=;
        b=QqNbuF6lthzfDA6xT4mz5BzHhSuYLXOIKWaFH2nOgbkCTmUcA3ivV78Yux5CyWdkrL
         1ze/V8s9ZmYHBlQq7wbdbInXAhqER2LdkFcSmTQs/KEqLIHkcpAx7AXucMc4hyl4GGRC
         +VejOznWiluaEmE6ErRdH9xyaRf93sNAez0dvr0fbUHK+F7mRzaG36i6FqLmZyEHCHI2
         KhJeN9+ioCdMSWiStLOb8NB4HsietthS/l17NFUJ4ZN1q1U1j6dkAaWdHmFtcudPPZth
         UitA8kEC6Yy4nNSfqR3crpmqMzWvxtTHMvjbSZtuR5Axsewj1G7h5rKiiasRj2VJC6X1
         +4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B12MKUKtvOLgGXlIX/YXOWokDcl/6BmGBXPeQeFKB1E=;
        b=01xh+wOOlObQnzEaPZNV47TrP9edb50ABQnABRnPyion623cV8IjpHe0Pp7o4HW4wA
         WabQF0dk8P8FMYYe7Q5SfXzVMUBGAlf6BomFLe07p7cDFEjRHfd1hf8w9dcCXDihM70G
         XrjjJW/fRpKJ2fuFj0dDpDuLYfOddL4LFQqUIapAnE3J61c0Bd3LsZc+zvvyoEtCKvjg
         hrSfH6WEObg/z/QM1N9w6UnEQbhYGhsTBsJf4aC+AMXTkoEEIK9R39PKBLfB56KPdolU
         HpFNBbPFJOjf6evgPyrz8MyjPvKd375x2Rc8c9AdyKqMJGB7u9dCq1V9SUCkJG+54Uw7
         FpYw==
X-Gm-Message-State: ANoB5pnlMOVgSLedco/RDcWj9GoyyoiZxeSNCRYklgzqEd1KgrIoJr0e
        +DbIwE/dhQZWhDN93GjdgjvdV4+isVl0D/sez6hYLHKJSFs=
X-Google-Smtp-Source: AA0mqf65vMJWGStXOYx4lgEyY+XIW3owd1Z1kToC9CtK0I3j/Sto130SsJcwTob3QxEL2+brr5Mk0F7obgMm4PMprfo=
X-Received: by 2002:a50:9512:0:b0:457:1323:1b7e with SMTP id
 u18-20020a509512000000b0045713231b7emr2910613eda.311.1668199459685; Fri, 11
 Nov 2022 12:44:19 -0800 (PST)
MIME-Version: 1.0
References: <tencent_29D7ABD1744417031AA1B52C914B61158E07@qq.com>
 <Y26FgIJLR3nVKjcb@google.com> <Y26MSS2twSskZ5J2@lore-desk>
 <CAKH8qBvxZBX7_GQYQzSrZ5j=P3rViyqNq3V3oo5CtEMR9BQepA@mail.gmail.com>
 <Y26QjqvVTosoCgPT@lore-desk> <CAKH8qBsA-r=7S9hrsX=S7wXMaUikNh0gY=PdQK0urjORahrVBw@mail.gmail.com>
In-Reply-To: <CAKH8qBsA-r=7S9hrsX=S7wXMaUikNh0gY=PdQK0urjORahrVBw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Nov 2022 12:44:07 -0800
Message-ID: <CAEf4BzY0dsog-_1v9Phskt2YzyavL_fNsSi2hUvGZboggDqM2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix error undeclared identifier 'NF_NAT_MANIP_SRC'
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Rong Tao <rtoax@foxmail.com>, ast@kernel.org,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 11, 2022 at 10:55 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Fri, Nov 11, 2022 at 10:12 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >
> > > On Fri, Nov 11, 2022 at 9:54 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > > >
> > > > > On 11/11, Rong Tao wrote:
> > > > > > From: Rong Tao <rongtao@cestc.cn>
> > > > >
> > > > > > commit 472caa69183f("netfilter: nat: un-export nf_nat_used_tuple")
> > > > > > introduce NF_NAT_MANIP_SRC/DST enum in include/net/netfilter/nf_nat.h,
> > > > > > and commit b06b45e82b59("selftests/bpf: add tests for bpf_ct_set_nat_info
> > > > > > kfunc") use NF_NAT_MANIP_SRC/DST in test_bpf_nf.c. We copy enum
> > > > > > nf_nat_manip_type to test_bpf_nf.c fix this error.
> > > > >
> > > > > > How to reproduce the error:
> > > > >
> > > > > >      $ make -C tools/testing/selftests/bpf/
> > > > > >      ...
> > > > > >        CLNG-BPF [test_maps] test_bpf_nf.bpf.o
> > > > > >        error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
> > > > > >              bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
> > > > > >                                                             ^
> > > > > >        error: use of undeclared identifier 'NF_NAT_MANIP_DST'
> > > > > >              bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
> > > > > >                                                             ^
> > > > > >      2 errors generated.
> > > > >
> > > > > $ grep NF_NAT_MANIP_SRC
> > > > > ./tools/testing/selftests/bpf/tools/include/vmlinux.h
> > > > >         NF_NAT_MANIP_SRC = 0,
> > > > >
> > > > > Doesn't look like your kernel config compiles netfilter nat modules?
> > > >
> > > > yes, in bpf kself-test config (tools/testing/selftests/bpf/config) nf_nat
> > > > is compiled as built-in. This issue occurs just if it is compiled as module.
> > >
> > > Right, but if we unconditionally define this enum, I think you'll
> > > break the case where it's compiled as a built-in?
> > > Since at least in my vmlinux.h I have all the defines and this test
> > > includes vmlinux.h...
> >
> > yes, it is correct.
>
> And it will break the CI:
>

It does break CI ([0]). We could use BPF CO-RE and ___suffix rule to
avoid this. But we can also say that selftests/bpf/config{,<arch>} has
to be used by bots that want to build BPF selftests.

  [0] https://github.com/kernel-patches/bpf/actions/runs/3446651033/jobs/5752592868

> $ grep NETFILTER tools/testing/selftests/bpf/config
> CONFIG_NETFILTER=y
>
> So yeah, not sure what to do here. The selftests expect "sane" configs
> (see that bpf/config above) which is not what the bot seems to be
> doing...
>
> > > > Regards,
> > > > Lorenzo
> > > >
> > > > >
> > > > > > Link: https://lore.kernel.org/lkml/202210280447.STsT1gvq-lkp@intel.com/
> > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > Signed-off-by: Rong Tao <rongtao@cestc.cn>
> > > > > > ---
> > > > > >   tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
> > > > > >   1 file changed, 5 insertions(+)
> > > > >
> > > > > > diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > > > > b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > > > > index 227e85e85dda..307ca166ff34 100644
> > > > > > --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > > > > +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > > > > @@ -3,6 +3,11 @@
> > > > > >   #include <bpf/bpf_helpers.h>
> > > > > >   #include <bpf/bpf_endian.h>
> > > > >
> > > > > > +enum nf_nat_manip_type {
> > > > > > +   NF_NAT_MANIP_SRC,
> > > > > > +   NF_NAT_MANIP_DST
> > > > > > +};
> > > > > > +
> > > > > >   #define EAFNOSUPPORT 97
> > > > > >   #define EPROTO 71
> > > > > >   #define ENONET 64
> > > > > > --
> > > > > > 2.31.1
> > > > >
