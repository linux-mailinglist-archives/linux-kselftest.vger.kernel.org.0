Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4878F41E
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 22:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347370AbjHaUeW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347366AbjHaUeV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 16:34:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF0E65
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 13:34:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so215e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 13:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693514057; x=1694118857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGFYNx6ryhn4e7u3vf0pxOVRne5P4snGCKQYAh6+R1A=;
        b=UtpC1aYiiNmgFBCOTbsOS2IVcAZ7E+QPJ0N1NqvDH74DXk6AtHwwv2kxtxXRz/MXu1
         TlARV+X61BqMK8GUEEPDvChuvWuwcCqUJT3C2TfyasVHHWSwpA/N29pDi1fylsClZRNS
         A8AXAhMqd/+CG+wo/gPY2+GctdNNAYMZiba18DKKojnhTEuf/OgwUtUluNtvN4d1NFVs
         +nfOpbauhAXfdQ46vOcICAff1C1/gkQE57yuFi/tAqCj9HoHU/AsXN8KnU85xa/Lz9To
         FpfD7MxovAkdSESOh8/vDiV5P/ioWiioL+7LaBUEuzxZJXiYw7b/71wW8sBXVmjOzq7u
         mEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693514057; x=1694118857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGFYNx6ryhn4e7u3vf0pxOVRne5P4snGCKQYAh6+R1A=;
        b=gA/M1UpBpghW4DTT/h6gGWEdKKVuZYSiRA68sS2OVn5knoUNCJvESfS9n7PCEchKUs
         8KUEfPpMTxaVNiQsddFNMZlIJgi+pMM7zdcCTFNdF4jp4OO0Dz2Auw0HrcfyqGuAxKap
         ATB7H6N+7ETVue//1KrIunJvtKInLutHq2K08N10j1J+HzpMEZcz0gka7ayp6165Pzi2
         EGZqs6RmOnCydduTEe2bU1hCVidtqKAcD2UnfN57uELTisDAr9fQm8jLOci6RPzKd4y3
         aCOOWq+GuZY/0ZSt1elPwUmgrdViovVjxQ1+kYViIXWQMq2LIryDbgzDQgsKvpAC8sYI
         /TSw==
X-Gm-Message-State: AOJu0Yw7wxnvW97h7dHWBZYtNBHYodYTF0fwa6vaWUQTlijGdK//EDDX
        lDPQPU6cjmqaZfiU3WUaRka+AmFx1rWwCeE9Kc2RwQ==
X-Google-Smtp-Source: AGHT+IECGmhqOvXLGUHVMsZLR0jW/gDNt9E1bPhOqvToyzS5w2Yg4U+Sor1wrtOkuPDxonTa7tktEXAPL3rILGdhTZM=
X-Received: by 2002:a05:600c:1d0f:b0:3f7:e4d8:2569 with SMTP id
 l15-20020a05600c1d0f00b003f7e4d82569mr7815wms.5.1693514056849; Thu, 31 Aug
 2023 13:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230831071655.2907683-1-ruanjinjie@huawei.com> <20230831071655.2907683-3-ruanjinjie@huawei.com>
In-Reply-To: <20230831071655.2907683-3-ruanjinjie@huawei.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 31 Aug 2023 16:34:03 -0400
Message-ID: <CA+GJov4sxNxNF0-ERMizaNaXyb7Q_gq5n74gbGj2BuC+g8Pw4w@mail.gmail.com>
Subject: Re: [PATCH 2/4] kunit: Fix possible null-ptr-deref in kunit_parse_glob_filter()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        skhan@linuxfoundation.org, jk@codeconstruct.com.au,
        dlatypov@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
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

On Thu, Aug 31, 2023 at 3:17=E2=80=AFAM 'Jinjie Ruan' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Inject fault while probing kunit-example-test.ko, if kzalloc fails
> in kunit_parse_glob_filter(), strcpy() or strncpy() to NULL will
> cause below null-ptr-deref bug. So check NULL for kzalloc() and
> return int instead of void for kunit_parse_glob_filter().
>
>  Unable to handle kernel paging request at virtual address dfff8000000000=
00
>  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>  Mem abort info:
>    ESR =3D 0x0000000096000005
>    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>    SET =3D 0, FnV =3D 0
>    EA =3D 0, S1PTW =3D 0
>    FSC =3D 0x05: level 1 translation fault
>  Data abort info:
>    ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
>    CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>    GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
>  [dfff800000000000] address between user and kernel address ranges
>  Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>  Modules linked in: kunit_example_test cfg80211 rfkill 8021q garp mrp stp=
 llc ipv6 [last unloaded: kunit_example_test]
>  CPU: 4 PID: 6047 Comm: modprobe Tainted: G        W        N 6.5.0-next-=
20230829+ #141
>  Hardware name: linux,dummy-virt (DT)
>  pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : strncpy+0x58/0xc0
>  lr : kunit_filter_suites+0x15c/0xa84
>  sp : ffff800082a17420
>  x29: ffff800082a17420 x28: 0000000000000000 x27: 0000000000000004
>  x26: 0000000000000000 x25: ffffa847e40a5320 x24: 0000000000000001
>  x23: 0000000000000000 x22: 0000000000000001 x21: dfff800000000000
>  x20: 000000000000002a x19: 0000000000000000 x18: 00000000750b3b54
>  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>  x14: 0000000000000000 x13: 34393178302f3039 x12: ffff7508fcea4ec1
>  x11: 1ffff508fcea4ec0 x10: ffff7508fcea4ec0 x9 : dfff800000000000
>  x8 : ffff6051b1a7f86a x7 : ffff800082a17270 x6 : 0000000000000002
>  x5 : 0000000000000098 x4 : ffff028d9817b250 x3 : 0000000000000000
>  x2 : 0000000000000000 x1 : ffffa847e40a5320 x0 : 0000000000000000
>  Call trace:
>   strncpy+0x58/0xc0
>   kunit_filter_suites+0x15c/0xa84
>   kunit_module_notify+0x1b0/0x3ac
>   blocking_notifier_call_chain+0xc4/0x128
>   do_init_module+0x250/0x594
>   load_module+0x37b0/0x44b4
>   init_module_from_file+0xd4/0x128
>   idempotent_init_module+0x2c8/0x524
>   __arm64_sys_finit_module+0xac/0x100
>   invoke_syscall+0x6c/0x258
>   el0_svc_common.constprop.0+0x160/0x22c
>   do_el0_svc+0x44/0x5c
>   el0_svc+0x38/0x78
>   el0t_64_sync_handler+0x13c/0x158
>   el0t_64_sync+0x190/0x194
>  Code: 5400028a d343fe63 12000a62 39400034 (38f56863)
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Oops: Fatal exception
>  SMP: stopping secondary CPUs
>  Kernel Offset: 0x284761400000 from 0xffff800080000000
>  PHYS_OFFSET: 0xfffffd7380000000
>  CPU features: 0x88000203,3c020000,1000421b
>  Memory Limit: none
>  Rebooting in 1 seconds..
>
> Fixes: a127b154a8f2 ("kunit: tool: allow filtering test cases via glob")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Hello!

This also looks good to me. Thanks for catching these!

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/executor.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 5181aa2e760b..25ce8d6e5fe7 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -65,7 +65,7 @@ struct kunit_glob_filter {
>  };
>
>  /* Split "suite_glob.test_glob" into two. Assumes filter_glob is not emp=
ty. */
> -static void kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
> +static int kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
>                                     const char *filter_glob)
>  {
>         const int len =3D strlen(filter_glob);
> @@ -73,16 +73,28 @@ static void kunit_parse_glob_filter(struct kunit_glob=
_filter *parsed,
>
>         if (!period) {
>                 parsed->suite_glob =3D kzalloc(len + 1, GFP_KERNEL);
> +               if (!parsed->suite_glob)
> +                       return -ENOMEM;
> +
>                 parsed->test_glob =3D NULL;
>                 strcpy(parsed->suite_glob, filter_glob);
> -               return;
> +               return 0;
>         }
>
>         parsed->suite_glob =3D kzalloc(period - filter_glob + 1, GFP_KERN=
EL);
> +       if (!parsed->suite_glob)
> +               return -ENOMEM;
> +
>         parsed->test_glob =3D kzalloc(len - (period - filter_glob) + 1, G=
FP_KERNEL);
> +       if (!parsed->test_glob) {
> +               kfree(parsed->suite_glob);
> +               return -ENOMEM;
> +       }
>
>         strncpy(parsed->suite_glob, filter_glob, period - filter_glob);
>         strncpy(parsed->test_glob, period + 1, len - (period - filter_glo=
b));
> +
> +       return 0;
>  }
>
>  /* Create a copy of suite with only tests that match test_glob. */
> @@ -152,8 +164,13 @@ kunit_filter_suites(const struct kunit_suite_set *su=
ite_set,
>         }
>         copy_start =3D copy;
>
> -       if (filter_glob)
> -               kunit_parse_glob_filter(&parsed_glob, filter_glob);
> +       if (filter_glob) {
> +               *err =3D kunit_parse_glob_filter(&parsed_glob, filter_glo=
b);
> +               if (*err) {
> +                       kfree(copy);
> +                       return filtered;
> +               }
> +       }
>
>         /* Parse attribute filters */
>         if (filters) {
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230831071655.2907683-3-ruanjinjie%40huawei.com.
