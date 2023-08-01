Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CECC76BF2A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 23:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjHAVXW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 17:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjHAVXU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 17:23:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1942110
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Aug 2023 14:23:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so8945e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Aug 2023 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690924984; x=1691529784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCbET8VXtS0Or6G6hEvHZ023LpWG3zgmVwRATemDSm8=;
        b=BFHZbjY3tb6u7lydJ0IPy5yINldRTctWYf5B3ZtLDjFm9VdnQpkrawcfJix8OQ/fEL
         vnOOb7F9W+Q6Dbf4wweMBaww/ptYKdx5/Tz1GzC5561tGIJt2MqwvsXvuTAbFvHa5SRl
         J/PiXrj3QszkQKAxsEF7oqMpn+jDM5kIIWqPVOz6hGtTho2E5EDNaZwUktCza8U8Zc84
         K+GvqauoZlc+2RXxOSJfJ3NsIksjRIV4sfvBsyEjvmcTOuhLlBJ9VWRz1b5dmHgJnBJT
         LJPj4lFY+9P7usz03spXhVfb1nNDW3IlzeBOP7rCYC5bKK9rWkZ5+m8knmrrXLQPtuBl
         o60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690924984; x=1691529784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCbET8VXtS0Or6G6hEvHZ023LpWG3zgmVwRATemDSm8=;
        b=CtzbJ8hE1FmeBqrwWQ6bJ1wWYe2vqyi2gI2zfpky0Kp3lEC729qKpNE8oAW6xfNZGA
         LrSnz84qpOzTjpEArGVdf3UAKBg35armGh9g4zOSR8UsKd3hhxwtZv9s4C1MPCJDJPnb
         8IVtMfVuPDUownuKsGoGIgQuJdK1DMZ776huySbXbHk/qH0cKZEw+9lFeAFqvceYB1Fa
         RmlgLKTOQlyHZMKFD0VQiFf9jpmhtfjgHTZFL+7Ip/klFgsIQ2bkKYIZXdHH6qD9YBz7
         OwAajxRy5U8vscZx6SRqURfFwcLWDgEy0OJ3WIC2srHMDjsmahZ3wzRSpcw9hTs/M3PT
         HrAg==
X-Gm-Message-State: ABy/qLaF3Kxjn0O0zop0zLZQuGBGg7d7rbVlFyp2cRTuWkt0PrTBW00J
        tMaVRyL10yU8SzXh883Vkg1Ri0uQ6f7us29yGWY7FfxjSRs2xL9Z0jw=
X-Google-Smtp-Source: APBJJlFeWwuOnDHeLb3s0WJ8gsBA3M5MSg1cpIzmjjFR3B4RcqxZM/NDeHQEnHSDH1inUCld0dBihA65NI/dD3ZeLbY=
X-Received: by 2002:a05:600c:68a:b0:3f1:70d1:21a6 with SMTP id
 a10-20020a05600c068a00b003f170d121a6mr298934wmn.0.1690924984048; Tue, 01 Aug
 2023 14:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230801073700.3740895-1-ruanjinjie@huawei.com>
In-Reply-To: <20230801073700.3740895-1-ruanjinjie@huawei.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 1 Aug 2023 17:22:51 -0400
Message-ID: <CA+GJov57JgEDN-hryh4nmLAAyDTvrWCnnHow5wP0RQCXcRmoZQ@mail.gmail.com>
Subject: Re: [PATCH -next] kunit: fix possible memory leak in kunit_filter_suites()
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 1, 2023 at 3:37=E2=80=AFAM 'Ruan Jinjie' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Inject fault while probing drm_kunit_helpers.ko, if one of
> kunit_next_attr_filter(), kunit_filter_glob_tests() and
> kunit_filter_attr_tests() fails, parsed_filters,
> parsed_glob.suite_glob/test_glob alloced in
> kunit_parse_glob_filter() is leaked.
> And the filtered_suite->test_cases alloced in kunit_filter_glob_tests()
> or kunit_filter_attr_tests() may also be leaked.
>
> unreferenced object 0xff110001067e4800 (size 1024):
>   comm "kunit_try_catch", pid 96, jiffies 4294671796 (age 763.547s)
>   hex dump (first 32 bytes):
>     73 75 69 74 65 32 00 00 00 00 00 00 00 00 00 00  suite2..........
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000116e8eba>] __kmalloc_node_track_caller+0x4e/0x140
>     [<00000000e2f9cce9>] kmemdup+0x2c/0x60
>     [<000000002a36710b>] kunit_filter_suites+0x3e4/0xa50
>     [<0000000045779fb9>] filter_suites_test+0x1b7/0x440
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000105d79b00 (size 192):
>   comm "kunit_try_catch", pid 96, jiffies 4294671796 (age 763.547s)
>   hex dump (first 32 bytes):
>     f0 e1 5a 88 ff ff ff ff 60 59 bb 8a ff ff ff ff  ..Z.....`Y......
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<000000006afe50bd>] kunit_filter_suites+0x424/0xa50
>     [<0000000045779fb9>] filter_suites_test+0x1b7/0x440
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff110001067e6000 (size 1024):
>   comm "kunit_try_catch", pid 98, jiffies 4294671798 (age 763.545s)
>   hex dump (first 32 bytes):
>     73 75 69 74 65 32 00 00 00 00 00 00 00 00 00 00  suite2..........
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000116e8eba>] __kmalloc_node_track_caller+0x4e/0x140
>     [<00000000e2f9cce9>] kmemdup+0x2c/0x60
>     [<000000002a36710b>] kunit_filter_suites+0x3e4/0xa50
>     [<00000000f452f130>] filter_suites_test_glob_test+0x1b7/0x660
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000103f3a800 (size 96):
>   comm "kunit_try_catch", pid 98, jiffies 4294671798 (age 763.545s)
>   hex dump (first 32 bytes):
>     f0 e1 5a 88 ff ff ff ff 40 39 bb 8a ff ff ff ff  ..Z.....@9......
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<000000006afe50bd>] kunit_filter_suites+0x424/0xa50
>     [<00000000f452f130>] filter_suites_test_glob_test+0x1b7/0x660
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000101a72ac0 (size 16):
>   comm "kunit_try_catch", pid 104, jiffies 4294671814 (age 763.529s)
>   hex dump (first 16 bytes):
>     00 00 00 00 00 00 00 00 e0 2a a7 01 01 00 11 ff  .........*......
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<00000000c7b724e7>] kunit_filter_suites+0x108/0xa50
>     [<00000000bad5427d>] filter_attr_test+0x1e9/0x6a0
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000103caf880 (size 32):
>   comm "kunit_try_catch", pid 104, jiffies 4294671814 (age 763.547s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<00000000c47b0f75>] kunit_filter_suites+0x189/0xa50
>     [<00000000bad5427d>] filter_attr_test+0x1e9/0x6a0
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000101a72ae0 (size 16):
>   comm "kunit_try_catch", pid 106, jiffies 4294671823 (age 763.538s)
>   hex dump (first 16 bytes):
>     00 00 00 00 00 00 00 00 00 2b a7 01 01 00 11 ff  .........+......
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<00000000c7b724e7>] kunit_filter_suites+0x108/0xa50
>     [<0000000096255c51>] filter_attr_empty_test+0x1b0/0x310
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000103caf9c0 (size 32):
>   comm "kunit_try_catch", pid 106, jiffies 4294671823 (age 763.538s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<00000000c47b0f75>] kunit_filter_suites+0x189/0xa50
>     [<0000000096255c51>] filter_attr_empty_test+0x1b0/0x310
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
> unreferenced object 0xff11000101a72b00 (size 16):
>   comm "kunit_try_catch", pid 108, jiffies 4294671832 (age 763.529s)
>   hex dump (first 16 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000000d6e4891>] __kmalloc+0x4d/0x140
>     [<00000000c47b0f75>] kunit_filter_suites+0x189/0xa50
>     [<00000000881258cc>] filter_attr_skip_test+0x148/0x770
>     [<00000000cd1104a7>] kunit_try_run_case+0x119/0x270
>     [<00000000c654c917>] kunit_generic_run_threadfn_adapter+0x4e/0xa0
>     [<00000000d195ac13>] kthread+0x2c7/0x3c0
>     [<00000000b79c1ee9>] ret_from_fork+0x2c/0x70
>     [<000000001167f7e6>] ret_from_fork_asm+0x1b/0x30
>
> Fixes: 5d31f71efcb6 ("kunit: add kunit.filter_glob cmdline option to filt=
er suites")
> Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Hello!

I have tested this and this all looks good to me. Sorry for the delay
in responding to the patches addressing the bugs in filtering. I have
been out of the office for a few days. Thanks for addressing this!

Reviewed-by: Rae Moar <rmoar@google.com>

-Rae

> ---
>  lib/kunit/executor.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 5b5bed1efb93..481901d245d0 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -151,7 +151,7 @@ static struct suite_set kunit_filter_suites(const str=
uct suite_set *suite_set,
>                 for (j =3D 0; j < filter_count; j++)
>                         parsed_filters[j] =3D kunit_next_attr_filter(&fil=
ters, err);
>                 if (*err)
> -                       return filtered;
> +                       goto err;
>         }
>
>         for (i =3D 0; &suite_set->start[i] !=3D suite_set->end; i++) {
> @@ -163,7 +163,7 @@ static struct suite_set kunit_filter_suites(const str=
uct suite_set *suite_set,
>                                         parsed_glob.test_glob);
>                         if (IS_ERR(filtered_suite)) {
>                                 *err =3D PTR_ERR(filtered_suite);
> -                               return filtered;
> +                               goto err;
>                         }
>                 }
>                 if (filter_count) {
> @@ -172,15 +172,18 @@ static struct suite_set kunit_filter_suites(const s=
truct suite_set *suite_set,
>                                                 parsed_filters[k], filter=
_action, err);
>
>                                 /* Free previous copy of suite */
> -                               if (k > 0 || filter_glob)
> +                               if (k > 0 || filter_glob) {
> +                                       kfree(filtered_suite->test_cases)=
;
>                                         kfree(filtered_suite);
> +                               }
> +
>                                 filtered_suite =3D new_filtered_suite;
>
>                                 if (*err)
> -                                       return filtered;
> +                                       goto err;
>                                 if (IS_ERR(filtered_suite)) {
>                                         *err =3D PTR_ERR(filtered_suite);
> -                                       return filtered;
> +                                       goto err;
>                                 }
>                                 if (!filtered_suite)
>                                         break;
> @@ -194,6 +197,10 @@ static struct suite_set kunit_filter_suites(const st=
ruct suite_set *suite_set,
>         }
>         filtered.end =3D copy;
>
> +err:
> +       if (*err)
> +               kfree(copy);
> +
>         if (filter_glob) {
>                 kfree(parsed_glob.suite_glob);
>                 kfree(parsed_glob.test_glob);
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230801073700.3740895-1-ruanjinjie%40huawei.com.
