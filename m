Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1377B26D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 22:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjI1UvR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 16:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1UvQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 16:51:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8919180
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 13:51:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so1234a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695934273; x=1696539073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR+tb789iQ++AT735vVzgK8uTtZyG8e/qccKe2pjrhQ=;
        b=mfrPnm8E/f26E7eblblgtVVBCcMEI9IQHll2/esCLyb241Y+li47aMKIbLspFd9S1X
         kDGs7sKtYZk6mBM7QJtXZLm7FwRwoemNOFJpjP9Df4bEOoNIK6djF7qFMhHawC9ZVqUA
         eNaWHcq2WV0ixVkF2Ki1RttuRITfT6ucWpYEmEO7Q/K59pJtBasSAH1ZoTcGzV+CII6M
         0XopzWnfOlhJpm83wJ09mok3Nvjz2baPoJiWQLKx0MN2YFZrX8EDwMfoiYayi5d8+JNp
         t3eQi2/LvrNk2TLEgadvCcTWNqsX7mTDRqJtpE4DKzbqJC/NI/CFVGTtV1TUPhdK3f7v
         yCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934273; x=1696539073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR+tb789iQ++AT735vVzgK8uTtZyG8e/qccKe2pjrhQ=;
        b=ujUQaM8AitY6dd8TKdnyblnZb08KAD9VA0m1fRXb8xK6YwF3O0XxX4X2nM3SruOT1o
         8AdYsZa3zPofl3/dZBqTOwCcesBj3FLbTq3aKbJL8PHW1BNEuDUYvlJUDfDWz7DU+7/9
         Ac4MJmefOVbUG7fIL8wkLFJBTeq6gETeIZqUuudJHu1G8mWpsomxMMs43OnHT2c5BrKT
         /npbVERqd5Wm3GRZbH4v0VuHuqe9VPBAeY0v6HbTpMvMAlCc0XKcUX8BV8uimHWQXufX
         XmAkl0lDTPbmH5NubMLPwVdTsomF8o4DIQzo8Vwsa5LAHk/F93gQGFa9a7OYg9OjMNhb
         Er9g==
X-Gm-Message-State: AOJu0YzPI+o25M5SitUAyRuXTkM1ovquacHLhiuiHBdBj6QUNoCCXf0j
        Nle4WUGbyO3cKz79X5WaHW6+ed2aXUn7DZ8sizBVbA==
X-Google-Smtp-Source: AGHT+IHXp8gF3wBAJnFl0UfvMb8M2ipE506qey+EfvbDMEJVyb6m+Dxebv7cilCTJrtxlSnU9+aziCYOinzjhjg+4do=
X-Received: by 2002:a50:aa93:0:b0:52e:f99a:b5f8 with SMTP id
 q19-20020a50aa93000000b0052ef99ab5f8mr452028edc.7.1695934273182; Thu, 28 Sep
 2023 13:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230925175733.1379-1-michal.wajdeczko@intel.com> <20230925175733.1379-2-michal.wajdeczko@intel.com>
In-Reply-To: <20230925175733.1379-2-michal.wajdeczko@intel.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 28 Sep 2023 16:51:00 -0400
Message-ID: <CA+GJov7W-kbFMgnBX3UM_ukvBnKXGvUdWmcJ3bH8Br+adXNvog@mail.gmail.com>
Subject: Re: [PATCH 1/4] kunit: Drop redundant text from suite init failure message
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        David Gow <davidgow@google.com>
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

On Mon, Sep 25, 2023 at 1:58=E2=80=AFPM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> If a suite initialization fails, then our diagnostic message
> will include redundant indent and hash sign as all this was
> already added by the kunit_printk() used by kunit_err() macro.
>
> This could be easily seen if we force some error in our example
> test by modyfing example_test_init_suite() and running:
>
> $ ./tools/testing/kunit/kunit.py run --raw_output \
>         --kunitconfig ./lib/kunit/.kunitconfig "example.*"
>
>     KTAP version 1
>     1..1
>         # example: initializing suite
>         # example:     # failed to initialize (-19)
>     not ok 1 example
>
> Fix that and while around improve error code reporting by using
> error pointer format %pe that gives more user friendly output:
>
>     KTAP version 1
>     1..1
>         # example: initializing suite
>         # example: failed to initialize (-ENODEV)
>     not ok 1 example
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>

Hello!

This change looks good to me.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f2eb71f1a66c..fb5981ce578d 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -568,8 +568,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>         if (suite->suite_init) {
>                 suite->suite_init_err =3D suite->suite_init(suite);
>                 if (suite->suite_init_err) {
> -                       kunit_err(suite, KUNIT_SUBTEST_INDENT
> -                                 "# failed to initialize (%d)", suite->s=
uite_init_err);
> +                       kunit_err(suite, "failed to initialize (%pe)",
> +                                 ERR_PTR(suite->suite_init_err));
>                         goto suite_end;
>                 }
>         }
> --
> 2.25.1
>
