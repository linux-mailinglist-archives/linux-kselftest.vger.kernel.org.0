Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5B678F7F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Sep 2023 07:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjIAFSR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Sep 2023 01:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjIAFSR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Sep 2023 01:18:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F06E7E
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 22:18:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso15335e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 22:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693545492; x=1694150292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y/BWXzrNQOEFTTkPEODETjLBjffdCBrEzEy2kkev72A=;
        b=ACRSCW9QJQq7xqfdCJR2+eDxfdrBXhikgH7cOlC8lPtNvhO12q7igIRlexXGj9BjDP
         lwR+ve0RADWB55yzQcvQldwWff4EtD5AZkrt0Q4WQuSDzxw4tZAjH9pS/8rP7ffYF5HM
         rv9G2MOzj3zbgnWabQygIuezU83e0n6LC2+8GUDi7aCNHhAdE+CoTElMw2IyI3hmHGgl
         1eMI3ZwphaCyuY/PM2ydWqmrAyTTHT6U2VD6rq4h2SEZfGtGSWKNSqbk6YYlfDXvBWK8
         0qLdBd46eMaB4GFk3nzIWssOasNU/LH0khmytjBEhVbYsGYi27tFtqjkQFX+QzqP6wX+
         fJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693545492; x=1694150292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/BWXzrNQOEFTTkPEODETjLBjffdCBrEzEy2kkev72A=;
        b=lLedBcp0SP1kZWiMJCllS6gzhLqySwOBICQCr/k0DXcZkdQO/xUvvnrjZjIF6NsuV+
         VVu4QE+YM09wAzezZwXghuj561jN+EzKfruIKuW6eCQLZtOfLxDc4DBEd9GUABLRfYJB
         elnFXYFjGFnZ72XXeYH6c4k4Kw8A8q1+KTnpQW6vxCdIfo6OWrdxlfh9tg83yzGEOBBt
         Xg8Br24VaTXHAtAXpEKr0YH/ifaFkcL3qsfDuSedL0hclep93vEQokYnZoLrDK5v6DJP
         /zF8lUoE1gDpQXBM3mjWKRK9ZyYQaIlRm9tBSb17aKIf9RSaRwQAIIHFA7rpYg27n/RP
         r93w==
X-Gm-Message-State: AOJu0Yz4XtBciNij+g/kuAVM88+KkgA9G+iDdPvJddat4MMivF2gNw5N
        bvGdLN2kzJXGVhmqrkuP4gtYNFKTwkd/gAFxlJ82fg==
X-Google-Smtp-Source: AGHT+IGyR97VzPJy5ThtTT6q4UScESHmVr1e95+xbmW2hhRCsBRBldnFC6DK/v/51k7ZZlRFPw3pSmSOQFPloQ2dzqA=
X-Received: by 2002:a05:600c:1c88:b0:3f6:f4b:d4a6 with SMTP id
 k8-20020a05600c1c8800b003f60f4bd4a6mr59077wms.7.1693545491668; Thu, 31 Aug
 2023 22:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230831071655.2907683-1-ruanjinjie@huawei.com> <20230831071655.2907683-2-ruanjinjie@huawei.com>
In-Reply-To: <20230831071655.2907683-2-ruanjinjie@huawei.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 1 Sep 2023 13:17:57 +0800
Message-ID: <CABVgOSkTLrmNdtJ++QOrmgPNXr-4P8PCmagO0BjdetnVcX3v_Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] kunit: Fix wild-memory-access bug in kunit_free_suite_set()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, skhan@linuxfoundation.org,
        jk@codeconstruct.com.au, dlatypov@google.com, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 31 Aug 2023 at 15:17, 'Jinjie Ruan' via KUnit Development
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
>  Unable to handle kernel paging request at virtual address ffffff341e942a88
>  KASAN: maybe wild-memory-access in range [0x0003f9a0f4a15440-0x0003f9a0f4a15447]
>  Mem abort info:
>    ESR = 0x0000000096000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x04: level 0 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000441ea000
>  [ffffff341e942a88] pgd=0000000000000000, p4d=0000000000000000
>  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>  Modules linked in: kunit_example_test(-) cfg80211 rfkill 8021q garp mrp stp llc ipv6 [last unloaded: kunit_example_test]
>  CPU: 3 PID: 2035 Comm: modprobe Tainted: G        W        N 6.5.0-next-20230828+ #136
>  Hardware name: linux,dummy-virt (DT)
>  pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
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
> ---

Nice catch, thanks. I'm not seeing the actual panic here (with a quick
hack to fail module loading), but the patch looks sound.

I suspect we may want to split the module loading up into separate
'init' and 'run' phases, tied to MODULE_STATE_COMING and
MODULE_STATE_LIVE respectively, at some point (perhaps when the
planned support for triggering tests from userspace is done), but this
is a good fix in the meantime,

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49698a168437..421f13981412 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -784,12 +784,13 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
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
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230831071655.2907683-2-ruanjinjie%40huawei.com.
