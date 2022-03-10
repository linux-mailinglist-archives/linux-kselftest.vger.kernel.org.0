Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234FE4D4238
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 09:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbiCJIKP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 03:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbiCJIKO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 03:10:14 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16942133964
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 00:09:14 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c25so3771040edj.13
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 00:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWbAcZy/i8HBYK2+LI1DmtpGjLhVyIVjDAmA+olRSX0=;
        b=r6m/oi9HM5b3ptgnBPdqU/JT11+emPMCtpY8bhdnL6IBAKJN+vphDQcvrhnJTPc3pR
         1JsCGgXBT8DO2kGWTbC0J+9Z3EF3A1Tp90hZAOCvXwlJkOLfxDgGSS5Pce72/04ugPzQ
         +WnXeDRI7/T/T/lhFL0US+S7Z5tXpNe0WU+/m+G/P7ZZrvOJNGBx2WcsIgtZZQw5yIrK
         UbvFaNl8O93Sd8kRmpWwK+FbCU9LXfog05Qc632veitsNPPygsBjRmw5wWM9NIsRTIpS
         6Az7Jceq2XZi1vWGRXTwAUJYPWZpcrMA1R0yKz/ZJ3fGc1Cg3uz+4B2170k94UUMLIMf
         /KGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWbAcZy/i8HBYK2+LI1DmtpGjLhVyIVjDAmA+olRSX0=;
        b=NfJDwWgQWYPa5wCRniC7JXyaU2ZBE/7JgHz9AyOaQV2oJnHbV6XTpDCoeXP5DTWse2
         IfGuNEN570nE0DDU9Qy5e5S/npb6WaZs8xdujDefa3W/8r5oj55tRieuooJlFTCMUKld
         QM+skHDvyZgh5iS70BOkRx2Xs11AsmPEgoxIqwBv9QvrQDY4Lrq1EdP0b7ovpAHfqHct
         m59Cp6RuP5xNIMKzDZA6fNR9KDNAhWXPuH++4P3EbnLlucmzBmQ54N8l9C5ksE7CWWsa
         +u6vho4AEQt+ogaLXDVS0U3BkF7Yq/UNa6oThdclo5tmfQhPiJPf7MfC3y5BHnYSV5v8
         lNWw==
X-Gm-Message-State: AOAM530rJym1gkUT5S5gUGUi3VO4Zj/96eqk7DP/ekHLDWPbJmj8ppe7
        1LE16BRwrdr23dZgv9p2eIBZ+ttx2ZjSx3H8pyx05Q==
X-Google-Smtp-Source: ABdhPJxKFn6YeDUx1PfZdbOvWIU7l3YrlqtrpTJvp5FIfH8MbYGg9inD0E2JsB/SRJMRmxjPhbDJO14wMifzXIGlkxQ=
X-Received: by 2002:a05:6402:26d3:b0:416:4186:6d7d with SMTP id
 x19-20020a05640226d300b0041641866d7dmr3159206edd.129.1646899752425; Thu, 10
 Mar 2022 00:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20220309083753.1561921-1-liupeng256@huawei.com> <20220309083753.1561921-2-liupeng256@huawei.com>
In-Reply-To: <20220309083753.1561921-2-liupeng256@huawei.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 10 Mar 2022 03:08:59 -0500
Message-ID: <CAFd5g466XMWRszdn=Wdg4GXNv=KR-CZmWYZ0j0bG7_1QXtu-LQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kunit: fix UAF when run kfence test case test_gfpzero
To:     Peng Liu <liupeng256@huawei.com>
Cc:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 9, 2022 at 3:19 AM 'Peng Liu' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
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

Thanks for taking care of this.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
