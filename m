Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330C94D2AAE
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 09:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiCIIdU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 03:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiCIIdS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 03:33:18 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E965710A7D9
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 00:32:19 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id u61so2749416ybi.11
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 00:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXNP/dUkerz8xKSj4rusJS07a77a18F1+lKC1sYQrwk=;
        b=BYKNESOGJPcopvgpGHl5UVuspsI04F8GafhdZGlcVkZ6HbM6TAVK4+ugwrI/Y21rhh
         5gdnaqrwCYQXJ54Y/lJsWXsEhigJsim58ymxtiYJHHPVS/nfBBQPDMsBwkq1+35w3yLv
         Hf9W49DIaDoA4/TzB1iEZqkiFXSGTGGIISHq38fw9PccBpGB1WdW1fJHmH6TTpmA04nj
         jmr7VG1nhbaoF2ASRMovFZKXx9lHGkvtgF8jBDcXFQvqjYE/83jTHEBhP30O9ho1vZru
         I8gmPQwWJ3deMOvuWsgMM5+QXurinWs1n+0hsOPuauvAPuKZtlWnLWgQdn6aTqsBWkZ1
         i+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXNP/dUkerz8xKSj4rusJS07a77a18F1+lKC1sYQrwk=;
        b=qDuDqKS9fC/0ghRRSzs9OGYeYhWV3aN5QXN3fiCXAF459doL4F7oWo7f23tLq7RopG
         hVQelUvqLfsqpFxSmjV3whoITCkyf43xl3eGvgUaZ7HvjpVhE8ix1lWcnD7p6ymO9l0Q
         boEt3QjGC5bSgAnz06q+kh+Yzngi7MUfUMJUDeUWjd5AWaUKAH9x3iED6BnrA1ZaucbC
         Aik7wBoPIal2ziSeyLdyDqAzuaZ1N2yypdVCYvrEf0gRBUS+tV5As3DaF/Sijj2NS+RK
         8KBFlEelXYo7R50VIUlzo74pIVJ8xKWpAAS6SGcbHkEau3ogOVplvWZCS9dEFLLyswpQ
         hI8w==
X-Gm-Message-State: AOAM531rvZ4V/Nenh9cvJcm5PZZl91KHyhc2FqW7gE/K7efrQnoakRoj
        E5HcMiGBh0/Q4rrf5Ebyh7oRLuxokVPn0n0KZtBZVQ==
X-Google-Smtp-Source: ABdhPJzxWtL7dOcNyXG6U+l8RXi0WRUpo5Pn/KAfrEpDnvbNZLdBNKsWeAt1dhv+sEkaeo3erEwCndhlBb1RRx1dGv8=
X-Received: by 2002:a05:6902:184:b0:628:233e:31fe with SMTP id
 t4-20020a056902018400b00628233e31femr14839424ybh.609.1646814738911; Wed, 09
 Mar 2022 00:32:18 -0800 (PST)
MIME-Version: 1.0
References: <20220309083753.1561921-1-liupeng256@huawei.com> <20220309083753.1561921-4-liupeng256@huawei.com>
In-Reply-To: <20220309083753.1561921-4-liupeng256@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Mar 2022 09:31:42 +0100
Message-ID: <CANpmjNN6iRS1xfXq6_dKQaHJ83zrU7heZCWL2odauc=_zkmQog@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kfence: test: try to avoid test_gfpzero trigger rcu_stall
To:     Peng Liu <liupeng256@huawei.com>
Cc:     brendanhiggins@google.com, glider@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        wangkefeng.wang@huawei.com
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
> When CONFIG_KFENCE_NUM_OBJECTS is set to a big number, kfence
> kunit-test-case test_gfpzero will eat up nearly all the CPU's
> resources and rcu_stall is reported as the following log which
> is cut from a physical server.
>
>   rcu: INFO: rcu_sched self-detected stall on CPU
>   rcu:  68-....: (14422 ticks this GP) idle=6ce/1/0x4000000000000002
>   softirq=592/592 fqs=7500 (t=15004 jiffies g=10677 q=20019)
>   Task dump for CPU 68:
>   task:kunit_try_catch state:R  running task
>   stack:    0 pid: 9728 ppid:     2 flags:0x0000020a
>   Call trace:
>    dump_backtrace+0x0/0x1e4
>    show_stack+0x20/0x2c
>    sched_show_task+0x148/0x170
>    ...
>    rcu_sched_clock_irq+0x70/0x180
>    update_process_times+0x68/0xb0
>    tick_sched_handle+0x38/0x74
>    ...
>    gic_handle_irq+0x78/0x2c0
>    el1_irq+0xb8/0x140
>    kfree+0xd8/0x53c
>    test_alloc+0x264/0x310 [kfence_test]
>    test_gfpzero+0xf4/0x840 [kfence_test]
>    kunit_try_run_case+0x48/0x20c
>    kunit_generic_run_threadfn_adapter+0x28/0x34
>    kthread+0x108/0x13c
>    ret_from_fork+0x10/0x18
>
> To avoid rcu_stall and unacceptable latency, a schedule point is
> added to test_gfpzero.
>
> Signed-off-by: Peng Liu <liupeng256@huawei.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  mm/kfence/kfence_test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index caed6b4eba94..1b50f70a4c0f 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -627,6 +627,7 @@ static void test_gfpzero(struct kunit *test)
>                         kunit_warn(test, "giving up ... cannot get same object back\n");
>                         return;
>                 }
> +               cond_resched();
>         }
>
>         for (i = 0; i < size; i++)
> --
> 2.18.0.huawei.25
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220309083753.1561921-4-liupeng256%40huawei.com.
