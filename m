Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928274D2CBD
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 11:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiCIKFF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 05:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiCIKFF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 05:05:05 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F3913CEF2
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 02:04:07 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2dc348dab52so16795357b3.6
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 02:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Snnx2gCzpEJKOVry4K+to5AuKutoJTTCZRIqxcxA9Nk=;
        b=ZoGSXpWHdTYaLziLCfUaWUf3m1iTHxUZqAHXTFCoiNG9YYUbShXsEwbpmc+xfCAViy
         MsyoeP3h9gtdIGxclP+Bm5yQqDX5yJJFVmiOhE2v+dY/WDs4ua8HSIN5swxC77NUXv4F
         baUj8KL1I7hWYZ1+Nm2PACBxxRpn4JvZZNQNcpxG/IDZIclwjZngWLQ3MfEtzu/yoGS1
         2DFBncpJCiTFZk70jLQRET515HnC/JGGCYxdfJbma5Q7wfxZY7XqiigOVCHvEY3YPaRk
         2d35iOQgZpDFRCr31RCQWvR19lWSmEVQ3gYnG33V933UM3axMOT6a/BdpNHD/GCHg3Jc
         9A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Snnx2gCzpEJKOVry4K+to5AuKutoJTTCZRIqxcxA9Nk=;
        b=bCRgKqB4Vx28aBIWVjkAsJvER/uOZ/LEQVrHBl5qT4A5p4rObP6F4mzRfXoz5Xha6U
         Xr0AqnwNQ34TTsItu+QSSx7SD55YfM5KQYs0bC7JCwI+LZcPIClM9/cNE1hrqAAQWcMm
         TyKvmL+rpsCfZBx7wIGJc7SUIwwoANPklmpyAbniQytz9WV1cl0b/B30ehL1hrQX6XUZ
         aImGjt1vxnXQgK4k27gqY9WmU0yb9RlnrTKfahvCmFP/ka6p23yDY+Po72hZz0+bRp95
         r3E7lGKa7fsWnl0/ijIj/kC3h+QDlVTRQtYs98P61kWx6OWVFgdD3kyLlSCVsD30kGTf
         0/Ag==
X-Gm-Message-State: AOAM5326zlmFx73WaqQGUdO5Cf3FO3C2r/ufdCJIxjaXUDuxKYjicS1+
        hhVQ/b5aSHnDy6JqOOrvNClHP7mkkBev0lCR0mbRGA==
X-Google-Smtp-Source: ABdhPJzfh0259sDflgr3TRJzqUoYoF5lrF6coJwBqb1KbMrihdQh7+BYnKkeVezNkQCMEMleBRmlOArjIB/8uTRgEyI=
X-Received: by 2002:a81:8985:0:b0:2dc:472:ff3f with SMTP id
 z127-20020a818985000000b002dc0472ff3fmr16171043ywf.333.1646820245970; Wed, 09
 Mar 2022 02:04:05 -0800 (PST)
MIME-Version: 1.0
References: <20220309083753.1561921-1-liupeng256@huawei.com> <20220309083753.1561921-2-liupeng256@huawei.com>
In-Reply-To: <20220309083753.1561921-2-liupeng256@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Mar 2022 11:03:28 +0100
Message-ID: <CANpmjNPkewkNv32+LFA8bHixL8E=Cm_deVttoqTeTMO5aeOtSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kunit: fix UAF when run kfence test case test_gfpzero
To:     Peng Liu <liupeng256@huawei.com>
Cc:     brendanhiggins@google.com, glider@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        wangkefeng.wang@huawei.com, Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 9 Mar 2022 at 09:19, 'Peng Liu' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Kunit will create a new thread to run an actual test case, and the
> main process will wait for the completion of the actual test thread
> until overtime. The variable "struct kunit test" has local property
> in function kunit_try_catch_run, and will be used in the test case
> thread. Task kunit_try_catch_run will free "struct kunit test" when
> kunit runs overtime, but the actual test case is still run and an
> UAF bug will be triggered.
>
> The above problem has been both observed in a physical machine and
> qemu platform when running kfence kunit tests. The problem can be
> triggered when setting CONFIG_KFENCE_NUM_OBJECTS = 65535. Under
> this setting, the test case test_gfpzero will cost hours and kunit
> will run to overtime. The follows show the panic log.
>
>   BUG: unable to handle page fault for address: ffffffff82d882e9
>
>   Call Trace:
>    kunit_log_append+0x58/0xd0
>    ...
>    test_alloc.constprop.0.cold+0x6b/0x8a [kfence_test]
>    test_gfpzero.cold+0x61/0x8ab [kfence_test]
>    kunit_try_run_case+0x4c/0x70
>    kunit_generic_run_threadfn_adapter+0x11/0x20
>    kthread+0x166/0x190
>    ret_from_fork+0x22/0x30
>   Kernel panic - not syncing: Fatal exception
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>   Ubuntu-1.8.2-1ubuntu1 04/01/2014
>
> To solve this problem, the test case thread should be stopped when
> the kunit frame runs overtime. The stop signal will send in function
> kunit_try_catch_run, and test_gfpzero will handle it.
>
> Signed-off-by: Peng Liu <liupeng256@huawei.com>

Reviewed-by: Marco Elver <elver@google.com>

Also Cc'ing more KUnit folks to double-check this is the right solution.

> ---
>  lib/kunit/try-catch.c   | 1 +
>  mm/kfence/kfence_test.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index be38a2c5ecc2..6b3d4db94077 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -78,6 +78,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
>         if (time_remaining == 0) {
>                 kunit_err(test, "try timed out\n");
>                 try_catch->try_result = -ETIMEDOUT;
> +               kthread_stop(task_struct);
>         }
>
>         exit_code = try_catch->try_result;
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 50dbb815a2a8..caed6b4eba94 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -623,7 +623,7 @@ static void test_gfpzero(struct kunit *test)
>                         break;
>                 test_free(buf2);
>
> -               if (i == CONFIG_KFENCE_NUM_OBJECTS) {
> +               if (kthread_should_stop() || (i == CONFIG_KFENCE_NUM_OBJECTS)) {
>                         kunit_warn(test, "giving up ... cannot get same object back\n");
>                         return;
>                 }
> --
> 2.18.0.huawei.25
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220309083753.1561921-2-liupeng256%40huawei.com.
