Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578B6767FD1
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjG2N4Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 09:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjG2N4N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 09:56:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC4A4202
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Jul 2023 06:56:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbf3da0ea9so7673925ad.2
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Jul 2023 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638961; x=1691243761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfoQUM4lEW8Q3ZhTs0RxTR7DnAZuspuZO2+FxyeamBE=;
        b=VkNcC1LAc4HIr9JigTnDlUpdZrxUnU7vxWZzeIS8yQHhO25AbIPVcErdiugNuUTM2l
         C392xEvhrBHq3Eit75C6TSR86Aml1akGOcr8uSKn43GaKTv+KNlFafiHvIHJVqrUOe+u
         2DxPiNk7gcYfE3Bjj9OTm9ur8Qrtw9KN8kRwyq2vfj7BFkHePYrNzcmH99Vf5slh1QP7
         K3tTHbAMZnUuv17TMCkcLmaARjSEi2WHx5rY7ZfsZzoWdtOmXwbmcHkgLJVxlfWxvfQE
         kit5akMCWDMcn6bsjY0Oq6/GBPaQUHlTe7BV6nvn2oBq8ZBPyOhtxH2mCSSE/FW97snt
         edvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638961; x=1691243761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfoQUM4lEW8Q3ZhTs0RxTR7DnAZuspuZO2+FxyeamBE=;
        b=WNKi7ZiJ+AofbPlso6+d3Bll75xvCn4+dGEU42iiv1nPtQrOooCKcbhfX2lP0Fs0Nv
         oc5SFNkwLrEhr9CK7o9kfu7fsc8QxTgIw4pa5lrhYX2TOsO6nj/RJmpXXRxVTZVPaXE7
         EWTxKyS1KxDRLEc/WRod1MkYv8JBTNn7Qv+GV+B0cHL1nGAjXr9S8N8CTYTesTu8m1Dk
         PRdlaebb3wgRIGJb7wtbz3QFGJZchWVeRU02r7RULO6VNME6HKDZ64fgQ9r1VO2+xcsH
         JgWz/74Doo+Zxj+9wq6KSBk/nbSkOKHErsZo4VmwUTIQ43i+hMwTUQ8+PON4bRCvEuK7
         E4yQ==
X-Gm-Message-State: ABy/qLZ9ugsqYC4uK2+rIIarGokhk6D4y/UubNn0pRXFuihGeW/P+anQ
        iahuFeLhEtVjk7gquBQdlZM=
X-Google-Smtp-Source: APBJJlEMwnShiFinJYzadcfhbXmuvBbmoN/GRkIE0SHl27sMmsIzBQL6eeW98gTPctZZN9d0cGb4eQ==
X-Received: by 2002:a17:902:74cb:b0:1b9:d310:e85b with SMTP id f11-20020a17090274cb00b001b9d310e85bmr4042756plt.68.1690638960727;
        Sat, 29 Jul 2023 06:56:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b001b9be2e2b3esm5299843plg.277.2023.07.29.06.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:56:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 29 Jul 2023 06:55:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH -next v2] kunit: fix wild-memory-access bug in
 kunit_filter_suites()
Message-ID: <27711736-7751-484f-a85e-d1e24835a8fb@roeck-us.net>
References: <20230729010003.4058582-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729010003.4058582-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 29, 2023 at 09:00:03AM +0800, Ruan Jinjie wrote:
> As for kunit_filter_suites(), When the filters arg = NULL, such as
> the call of kunit_filter_suites(&suite_set, "suite2", NULL, NULL, &err)
> in filter_suites_test() tese case in kunit, both filter_count and
> parsed_filters will not be initialized.
> 
> So it's possible to enter kunit_filter_attr_tests(), and the use of
> uninitialized parsed_filters will cause below wild-memory-access.
> 
>  RIP: 0010:kunit_filter_suites+0x780/0xa40
>  Code: fe ff ff e8 42 87 4d ff 41 83 c6 01 49 83 c5 10 49 89 dc 44 39 74 24 50 0f 8e 81 fe ff ff e8 27 87 4d ff 4c 89 e8 48 c1 e8 03 <66> 42 83 3c 38 00 0f 85 af 01 00 00 49 8b 75 00 49 8b 55 08 4c 89
>  RSP: 0000:ff1100010743fc38 EFLAGS: 00010203
>  RAX: 03fc4400041d0ff1 RBX: ff1100010389a900 RCX: ffffffff9f940ad9
>  RDX: ff11000107429740 RSI: 0000000000000000 RDI: ff110001037ec920
>  RBP: ff1100010743fd50 R08: 0000000000000000 R09: ffe21c0020e87f1e
>  R10: 0000000000000003 R11: 0000000000032001 R12: ff110001037ec800
>  R13: 1fe2200020e87f8c R14: 0000000000000000 R15: dffffc0000000000
>  FS:  0000000000000000(0000) GS:ff1100011b000000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ff11000115201000 CR3: 0000000113066001 CR4: 0000000000771ef0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? die_addr+0x3c/0xa0
>   ? exc_general_protection+0x148/0x220
>   ? asm_exc_general_protection+0x26/0x30
>   ? kunit_filter_suites+0x779/0xa40
>   ? kunit_filter_suites+0x780/0xa40
>   ? kunit_filter_suites+0x779/0xa40
>   ? __pfx_kunit_filter_suites+0x10/0x10
>   ? __pfx_kfree+0x10/0x10
>   ? kunit_add_action_or_reset+0x3d/0x50
>   filter_suites_test+0x1b7/0x440
>   ? __pfx_filter_suites_test+0x10/0x10
>   ? __pfx___schedule+0x10/0x10
>   ? try_to_wake_up+0xa8e/0x1210
>   ? _raw_spin_lock_irqsave+0x86/0xe0
>   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>   ? set_cpus_allowed_ptr+0x7c/0xb0
>   kunit_try_run_case+0x119/0x270
>   ? __kthread_parkme+0xdc/0x160
>   ? __pfx_kunit_try_run_case+0x10/0x10
>   kunit_generic_run_threadfn_adapter+0x4e/0xa0
>   ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
>   kthread+0x2c7/0x3c0
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x2c/0x70
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1b/0x30
>   </TASK>
>  Modules linked in:
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  ---[ end trace 0000000000000000 ]---
>  RIP: 0010:kunit_filter_suites+0x780/0xa40
>  Code: fe ff ff e8 42 87 4d ff 41 83 c6 01 49 83 c5 10 49 89 dc 44 39 74 24 50 0f 8e 81 fe ff ff e8 27 87 4d ff 4c 89 e8 48 c1 e8 03 <66> 42 83 3c 38 00 0f 85 af 01 00 00 49 8b 75 00 49 8b 55 08 4c 89
>  RSP: 0000:ff1100010743fc38 EFLAGS: 00010203
>  RAX: 03fc4400041d0ff1 RBX: ff1100010389a900 RCX: ffffffff9f940ad9
>  RDX: ff11000107429740 RSI: 0000000000000000 RDI: ff110001037ec920
>  RBP: ff1100010743fd50 R08: 0000000000000000 R09: ffe21c0020e87f1e
>  R10: 0000000000000003 R11: 0000000000032001 R12: ff110001037ec800
>  R13: 1fe2200020e87f8c R14: 0000000000000000 R15: dffffc0000000000
>  FS:  0000000000000000(0000) GS:ff1100011b000000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ff11000115201000 CR3: 0000000113066001 CR4: 0000000000771ef0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Kernel panic - not syncing: Fatal exception
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  Kernel Offset: 0x1da00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>  Rebooting in 1 seconds..
> 
> Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> v2:
> - add fixes tag
> ---
>  lib/kunit/executor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 483f7b7873a7..5b5bed1efb93 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -125,7 +125,8 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>  						char *filter_action,
>  					    int *err)
>  {
> -	int i, j, k, filter_count;
> +	int i, j, k;
> +	int filter_count = 0;
>  	struct kunit_suite **copy, *filtered_suite, *new_filtered_suite;
>  	struct suite_set filtered;
>  	struct kunit_glob_filter parsed_glob;
> -- 
> 2.34.1
> 
