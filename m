Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B05626060
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 18:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiKKRZY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 12:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiKKRZX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 12:25:23 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101AD10556
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 09:25:23 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id f189-20020a6238c6000000b0056e3400fdc0so3053827pfa.10
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 09:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=imvO8YpZD2ZcmET02WP0sV4ZEd9lENVaToBwFuzRa9k=;
        b=pac3wqeY16mNG6biNSvoWZoA1M2mFFakQ1O2/aHt7Lg9ZdYW7R5DwwInFCqa/x9aEg
         5AxgSlU9fIeA4u/yD5TH728ZdaghJP+K2CBkJ2uFvkU+pc+nC4eip/uILhuD4ijLNyAw
         gB61YeQRpvaWUJe9189Sju54A6XpF2YQdnrDZPCb4K/86dMeHJCz2ElmtA/oC8OXELE0
         1CziUg4hBDvc74U7yi6bMlVkJnbUCxTOkmEBGX0imwXn2GdXLFDTEbfvfeuUj/kVMu9+
         95fRaGLnL6/SRguRJhLXdT9Wwk2bb4DM3fkkZdcmOJ2JawfliBIdmkZKIVD1n0o2nBnB
         HwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imvO8YpZD2ZcmET02WP0sV4ZEd9lENVaToBwFuzRa9k=;
        b=Q/nF3ZP7hh5h4Ha6lT34jvQ1glOuUv8Cpb7p2fKObTvH9Q5CIvwQlDAdcFQNHDWAKX
         /hN1mqzX/o4i3j55J2s9uyqFisUJ6smuYrmvF1IWlaX3Ym9eKZKS/YBQR7kncyY7vWmD
         5oBgJzWpiYmU+EDKPH9V87RcH3RIcSAMoefVxARydYSVoRq/bLWrsIsT8wJRv2559230
         a2iRBwaEcmBLdAPr6ndj3MzCM+7ySHb713R0cIUxq6TSf+g9KrntxL2TQvcZH/YahZvI
         gY2JJd7dnPOKnUaGbO38DMyYxHk5X4MLIIHyCz+imbQ+iJwWNmY9n5xizOhCpkXkllhk
         uceg==
X-Gm-Message-State: ANoB5pnRqwyRFABPLf6kyXgGlWWFyGgm1qxTCSqQVfFXYIFKuFHpl4+J
        sVC6kLY6OtUO3ltXxWLdTJpUQts=
X-Google-Smtp-Source: AA0mqf68OCEgtibicr7iW7xRQadmbGfWQUpWk2vQrpkeHPWsixQSs9xTua3NBVVtEOaVUTg2DuzYRUI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:4503:b0:200:2069:7702 with SMTP id
 u3-20020a17090a450300b0020020697702mr2956946pjg.239.1668187522509; Fri, 11
 Nov 2022 09:25:22 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:25:20 -0800
In-Reply-To: <tencent_29D7ABD1744417031AA1B52C914B61158E07@qq.com>
Mime-Version: 1.0
References: <tencent_29D7ABD1744417031AA1B52C914B61158E07@qq.com>
Message-ID: <Y26FgIJLR3nVKjcb@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix error undeclared identifier 'NF_NAT_MANIP_SRC'
From:   sdf@google.com
To:     Rong Tao <rtoax@foxmail.com>
Cc:     ast@kernel.org, Rong Tao <rongtao@cestc.cn>,
        kernel test robot <lkp@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/11, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>

> commit 472caa69183f("netfilter: nat: un-export nf_nat_used_tuple")
> introduce NF_NAT_MANIP_SRC/DST enum in include/net/netfilter/nf_nat.h,
> and commit b06b45e82b59("selftests/bpf: add tests for bpf_ct_set_nat_info
> kfunc") use NF_NAT_MANIP_SRC/DST in test_bpf_nf.c. We copy enum
> nf_nat_manip_type to test_bpf_nf.c fix this error.

> How to reproduce the error:

>      $ make -C tools/testing/selftests/bpf/
>      ...
>        CLNG-BPF [test_maps] test_bpf_nf.bpf.o
>        error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
>              bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>                                                             ^
>        error: use of undeclared identifier 'NF_NAT_MANIP_DST'
>              bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>                                                             ^
>      2 errors generated.

$ grep  
NF_NAT_MANIP_SRC ./tools/testing/selftests/bpf/tools/include/vmlinux.h
         NF_NAT_MANIP_SRC = 0,

Doesn't look like your kernel config compiles netfilter nat modules?

> Link: https://lore.kernel.org/lkml/202210280447.STsT1gvq-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>   tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
>   1 file changed, 5 insertions(+)

> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c  
> b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> index 227e85e85dda..307ca166ff34 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> @@ -3,6 +3,11 @@
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>

> +enum nf_nat_manip_type {
> +	NF_NAT_MANIP_SRC,
> +	NF_NAT_MANIP_DST
> +};
> +
>   #define EAFNOSUPPORT 97
>   #define EPROTO 71
>   #define ENONET 64
> --
> 2.31.1

