Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E0978F3F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 22:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbjHaU3t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 16:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347364AbjHaU3b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 16:29:31 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE10CE5F
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 13:29:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so23965e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 13:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693513764; x=1694118564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d/VcRLHYmClpcNcSZw4Pz/TYlQFv/C7ZobfWofwXhg=;
        b=xJMVmax3/jhMl1Zgvie69ymXpTVoSxlAIuNGc6mD8w7yA3NRJk6FbaFFwGFtI5cKWp
         CIW0YwLsPCk+eAtApDfboJrVnmQmck6+5c5SoepBtzQxaXbZy+WjU3UcgwIwkA/9ksjV
         /GatEZ8N5TRlSU7xtKYusAMYu5TBMmzhfii9WWpDy8S0UQU35YSItBXnOlZTxAgFeykF
         FrsBX/6xOvYNRoEJyfH5/EMZ1iv5v7vcJkAEfbzTbJupSzlNfD5ThaH+7sPFd9C5uaTq
         HcLHJF9Pa9H4b/XUHS6Oz/mhwJuwNsLoXExX39+hkBRZ02GELAy/1DnZxrcaJuIQR6QZ
         B45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693513764; x=1694118564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3d/VcRLHYmClpcNcSZw4Pz/TYlQFv/C7ZobfWofwXhg=;
        b=KQHRyADtI3hHchB9ODQslodPlaZ9YMlMyhUeR1xqPjRbk8KBHW4JbehZ1Y6rqfpznd
         SrlE+GlP5Jo8S9lHSHY0Pdm8hlA8fdV3nWZuGAEfZLVGhPA+wu6ao5KWOAXEMV/wPP7Z
         yPzG+stDvoCSYUEIOsl/aCH9yKDKv4KRLZKBaxbln1tTXz8LHHVw1HZBPnZQvKUVC66l
         JiFoQFDygpGbGoeEBBuZNrzeo0WmgSiWmJPqw5I4DUjIeyAv1ZS7UmuyAEmtTpVAg44V
         LATXwSkEotD7xBmAH/zgnEX0N2mMXRSoryupw+r8CnfD2XHcwr8HpTbOSqMU+LMaXPVT
         6xtA==
X-Gm-Message-State: AOJu0YxhA2u8W+fV4e4z7tN1JvAUO1zoxI+zyUtsGXCBPTpD+bG1AqOM
        ZAhoFlKwSzyCU7Y3x/7/EuKZjX46EVmEXWGwFEZQ8A==
X-Google-Smtp-Source: AGHT+IHpoTP4tHbs4SK2zzsY8ftW/8ibhFWCbcrtMBfHTechyHLYWJvjkDGZguuP3pT8+3okCfbV3836o2L4/T5fDqA=
X-Received: by 2002:a05:600c:3b22:b0:401:c94d:d6de with SMTP id
 m34-20020a05600c3b2200b00401c94dd6demr40499wms.2.1693513764161; Thu, 31 Aug
 2023 13:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230831071655.2907683-1-ruanjinjie@huawei.com> <20230831071655.2907683-2-ruanjinjie@huawei.com>
In-Reply-To: <20230831071655.2907683-2-ruanjinjie@huawei.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 31 Aug 2023 16:29:10 -0400
Message-ID: <CA+GJov4JxtEV_YYO-24FhgsUic7KXf3wLfEXkuGf7Vr4gq8nWw@mail.gmail.com>
Subject: Re: [PATCH 1/4] kunit: Fix wild-memory-access bug in kunit_free_suite_set()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        skhan@linuxfoundation.org, jk@codeconstruct.com.au,
        dlatypov@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
> Inject fault while probing kunit-example-test.ko, if kstrdup()
> fails in mod_sysfs_setup() in load_module(), the mod->state will
> switch from MODULE_STATE_COMING to MODULE_STATE_GOING instead of
> from MODULE_STATE_LIVE to MODULE_STATE_GOING, so only
> kunit_module_exit() will be called without kunit_module_init(), and
> the mod->kunit_suites is no set correctly and the free in
> kunit_free_suite_set() will cause below wild-memory-access bug.
>
> The mod->state state machine when load_module() succeeds:
>
> MODULE_STATE_UNFORMED ---> MODULE_STATE_COMING ---> MODULE_STATE_LIVE
>          ^                                              |
>          |                                              | delete_module
>          +---------------- MODULE_STATE_GOING <---------+
>
> The mod->state state machine when load_module() fails at
> mod_sysfs_setup():
>
> MODULE_STATE_UNFORMED ---> MODULE_STATE_COMING ---> MODULE_STATE_GOING
>         ^                                               |
>         |                                               |
>         +-----------------------------------------------+
>
> Call kunit_module_init() at MODULE_STATE_COMING state to fix the issue
> because MODULE_STATE_LIVE is transformed from it.
>
>  Unable to handle kernel paging request at virtual address ffffff341e942a=
88
>  KASAN: maybe wild-memory-access in range [0x0003f9a0f4a15440-0x0003f9a0f=
4a15447]
>  Mem abort info:
>    ESR =3D 0x0000000096000004
>    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>    SET =3D 0, FnV =3D 0
>    EA =3D 0, S1PTW =3D 0
>    FSC =3D 0x04: level 0 translation fault
>  Data abort info:
>    ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
>    CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>    GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
>  swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000441ea000
>  [ffffff341e942a88] pgd=3D0000000000000000, p4d=3D0000000000000000
>  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>  Modules linked in: kunit_example_test(-) cfg80211 rfkill 8021q garp mrp =
stp llc ipv6 [last unloaded: kunit_example_test]
>  CPU: 3 PID: 2035 Comm: modprobe Tainted: G        W        N 6.5.0-next-=
20230828+ #136
>  Hardware name: linux,dummy-virt (DT)
>  pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : kfree+0x2c/0x70
>  lr : kunit_free_suite_set+0xcc/0x13c
>  sp : ffff8000829b75b0
>  x29: ffff8000829b75b0 x28: ffff8000829b7b90 x27: 0000000000000000
>  x26: dfff800000000000 x25: ffffcd07c82a7280 x24: ffffcd07a50ab300
>  x23: ffffcd07a50ab2e8 x22: 1ffff00010536ec0 x21: dfff800000000000
>  x20: ffffcd07a50ab2f0 x19: ffffcd07a50ab2f0 x18: 0000000000000000
>  x17: 0000000000000000 x16: 0000000000000000 x15: ffffcd07c24b6764
>  x14: ffffcd07c24b63c0 x13: ffffcd07c4cebb94 x12: ffff700010536ec7
>  x11: 1ffff00010536ec6 x10: ffff700010536ec6 x9 : dfff800000000000
>  x8 : 00008fffefac913a x7 : 0000000041b58ab3 x6 : 0000000000000000
>  x5 : 1ffff00010536ec5 x4 : ffff8000829b7628 x3 : dfff800000000000
>  x2 : ffffff341e942a80 x1 : ffffcd07a50aa000 x0 : fffffc0000000000
>  Call trace:
>   kfree+0x2c/0x70
>   kunit_free_suite_set+0xcc/0x13c
>   kunit_module_notify+0xd8/0x360
>   blocking_notifier_call_chain+0xc4/0x128
>   load_module+0x382c/0x44a4
>   init_module_from_file+0xd4/0x128
>   idempotent_init_module+0x2c8/0x524
>   __arm64_sys_finit_module+0xac/0x100
>   invoke_syscall+0x6c/0x258
>   el0_svc_common.constprop.0+0x160/0x22c
>   do_el0_svc+0x44/0x5c
>   el0_svc+0x38/0x78
>   el0t_64_sync_handler+0x13c/0x158
>   el0t_64_sync+0x190/0x194
>  Code: aa0003e1 b25657e0 d34cfc42 8b021802 (f9400440)
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Oops: Fatal exception
>  SMP: stopping secondary CPUs
>  Kernel Offset: 0x4d0742200000 from 0xffff800080000000
>  PHYS_OFFSET: 0xffffee43c0000000
>  CPU features: 0x88000203,3c020000,1000421b
>  Memory Limit: none
>  Rebooting in 1 seconds..
>
> Fixes: 3d6e44623841 ("kunit: unify module and builtin suite definitions")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Hello!

This looks good to me. It seems to be working well.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49698a168437..421f13981412 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -784,12 +784,13 @@ static int kunit_module_notify(struct notifier_bloc=
k *nb, unsigned long val,
>
>         switch (val) {
>         case MODULE_STATE_LIVE:
> -               kunit_module_init(mod);
>                 break;
>         case MODULE_STATE_GOING:
>                 kunit_module_exit(mod);
>                 break;
>         case MODULE_STATE_COMING:
> +               kunit_module_init(mod);
> +               break;
>         case MODULE_STATE_UNFORMED:
>                 break;
>         }
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230831071655.2907683-2-ruanjinjie%40huawei.com.
