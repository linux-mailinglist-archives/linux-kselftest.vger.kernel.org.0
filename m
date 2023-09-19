Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496587A6CD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 23:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjISVSj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 17:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjISVSi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 17:18:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EBAAF
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 14:18:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so5696a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 14:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695158311; x=1695763111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhSYUXj8kWCHLffUNNdf94p8EUTWJOpFUsbEFn8DTGs=;
        b=xa7aB/e/5zsWh+FEmgjv8Y3N5c01SbzLEx7miMHyAUuAWHzLsct+Wr2mVFKBGsqsHM
         n0Bze68Vc1YLKObUJLHVMxilK2HhnqWaxDcx5iLcYX19vs9EUCg6J7Vth7lEOTKpEj+z
         pfbTTiBlBcfqVr3sSD4oxqa7MN2V14D2yuoHDwYNx3rObpGwur8xvENyRBxJLLAFpgxL
         UhclUm84stGrqEeTUREQSLPc85Ac56AEU2DadOZ3bxcTUn3d1fIG/eldhS7lPMREi3D3
         2FVBfylMqYDUEc43lphnZjaf0Thw04oYXlJg3Cm27vORq1vMnVPNLtGCuZMPDPet8pWW
         mLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695158311; x=1695763111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhSYUXj8kWCHLffUNNdf94p8EUTWJOpFUsbEFn8DTGs=;
        b=vez4bR0ykmqXiJTMMcFdmzfhTK2Jd8QpsDReEF9VyJ3jmitlxX5PDaA88yyyRbPfeo
         UOY+LxQK3DsKi68pWsDtWv88r1FWw+BdKah2iu/3IIQWrkdVirSNOrOUU8QqfeuAIzWP
         GEdMhrtSq+6/C8mcMIi0kwiU8OJueC3Dan6HmI+hAObq2XFH/cfa//xdHydoosHB8gCU
         pXNZWLH+h55GJKxqcRHIdk+tE/9yARIPEzcYiKNPBOuxmkVcnzm4ue1hbEcG7bI2nzMO
         aTg205z/VvwH4qX5ht9hPggx1Xa/N6IQMBuQLHdekgE9X4Sl88NN3KfttdiEd9HZY9Ez
         ZArA==
X-Gm-Message-State: AOJu0YxMkTLTzbTZjcmHzfXVXKQzCLO3bYqvVqJdisiFDy27xqyUk8R7
        MQp+zkx7vELLbeX3BcHrFCEugH0ulMpd4DuXegz4RQ==
X-Google-Smtp-Source: AGHT+IFHjfdT2NyXYRlGmt3EyZwsJ45UsHWOiuEbaONn5KdbzGptSkNWiNpVSFxIdr87It9ic+Jzo5p4nRZ+G3B0TK0=
X-Received: by 2002:a50:d6c1:0:b0:519:7d2:e256 with SMTP id
 l1-20020a50d6c1000000b0051907d2e256mr24473edj.0.1695158310810; Tue, 19 Sep
 2023 14:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230914114629.1517650-1-ruanjinjie@huawei.com> <20230914114629.1517650-2-ruanjinjie@huawei.com>
In-Reply-To: <20230914114629.1517650-2-ruanjinjie@huawei.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 19 Sep 2023 17:18:18 -0400
Message-ID: <CA+GJov59XzvoyEJKeeqPPcYx6gPsXFUwbJttN1y-aENobJUW5w@mail.gmail.com>
Subject: Re: [PATCH 1/4] kunit: Fix missed memory release in kunit_free_suite_set()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        skhan@linuxfoundation.org, dlatypov@google.com,
        janusz.krzysztofik@linux.intel.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 7:47=E2=80=AFAM 'Jinjie Ruan' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> modprobe cpumask_kunit and rmmod cpumask_kunit, kmemleak detect
> a suspected memory leak as below.
>
> If kunit_filter_suites() in kunit_module_init() succeeds, the
> suite_set.start will not be NULL and the kunit_free_suite_set() in
> kunit_module_exit() should free all the memory which has not
> been freed. However the test_cases in suites is left out.
>
> unreferenced object 0xffff54ac47e83200 (size 512):
>   comm "modprobe", pid 592, jiffies 4294913238 (age 1367.612s)
>   hex dump (first 32 bytes):
>     84 13 1a f0 d3 b6 ff ff 30 68 1a f0 d3 b6 ff ff  ........0h......
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000008dec63a2>] slab_post_alloc_hook+0xb8/0x368
>     [<00000000ec280d8e>] __kmem_cache_alloc_node+0x174/0x290
>     [<00000000896c7740>] __kmalloc+0x60/0x2c0
>     [<000000007a50fa06>] kunit_filter_suites+0x254/0x5b8
>     [<0000000078cc98e2>] kunit_module_notify+0xf4/0x240
>     [<0000000033cea952>] notifier_call_chain+0x98/0x17c
>     [<00000000973d05cc>] notifier_call_chain_robust+0x4c/0xa4
>     [<000000005f95895f>] blocking_notifier_call_chain_robust+0x4c/0x74
>     [<0000000048e36fa7>] load_module+0x1a2c/0x1c40
>     [<0000000004eb8a91>] init_module_from_file+0x94/0xcc
>     [<0000000037dbba28>] idempotent_init_module+0x184/0x278
>     [<00000000161b75cb>] __arm64_sys_finit_module+0x68/0xa8
>     [<000000006dc1669b>] invoke_syscall+0x44/0x100
>     [<00000000fa87e304>] el0_svc_common.constprop.1+0x68/0xe0
>     [<000000009d8ad866>] do_el0_svc+0x1c/0x28
>     [<000000005b83c607>] el0_svc+0x3c/0xc4
>
> Fixes: e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in .=
kunit_test_suites")
> Fixes: b67abaad4d25 ("kunit: Allow kunit test modules to use test filteri=
ng")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Hello!

This looks good to me.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!

-Rae

> ---
>  lib/kunit/executor.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index a6348489d45f..a037a46fae5e 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -137,8 +137,10 @@ void kunit_free_suite_set(struct kunit_suite_set sui=
te_set)
>  {
>         struct kunit_suite * const *suites;
>
> -       for (suites =3D suite_set.start; suites < suite_set.end; suites++=
)
> +       for (suites =3D suite_set.start; suites < suite_set.end; suites++=
) {
> +               kfree((*suites)->test_cases);
>                 kfree(*suites);
> +       }
>         kfree(suite_set.start);
>  }
>
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230914114629.1517650-2-ruanjinjie%40huawei.com.
