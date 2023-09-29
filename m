Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC77B3AC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 21:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjI2Tjb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 15:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjI2Tj3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 15:39:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999A09C
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Sep 2023 12:39:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4063bfc6c03so13725e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Sep 2023 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696016366; x=1696621166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90f/Zz2xXkd/fk9EBfBRyC9+enBe5NnMj8fUlHN7bi8=;
        b=3pglj1KnZTYFtSMpQTg4vAoOm3LvVdkUac4kCrRToUVANM0vVJ+/zj4KqrD+K9OhN2
         Qh7/nxxWfCHtlIC+A5PNNIK8xjgofEkgae2BsDFXuxtLOsldZ1ID3e/94PVOOZdwYbaZ
         LhHhyTeOgSPHhXQf48eWzG5eUkQbPeU6zmJ9CFqy4/QV0/65S6jXjcvGDEi80i5wGHbo
         pgpLF5Ar57Hiu39CEys05EBuLdkkkmwIpqK+khNrtf6z/gImuiFvd4VDkTxpxZVx8UbO
         tfUP3Ilk3gWC52ywY7txJawpCgA6mxXDNc7zIQJ9zGKTEDMzMOCikvARVazqf90whlt0
         vKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696016366; x=1696621166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90f/Zz2xXkd/fk9EBfBRyC9+enBe5NnMj8fUlHN7bi8=;
        b=J7QIx4/bX66XbeVtKo5Nl3gYrbmycJ7XkjfrvNgR39peDlOO+3Mj6I+Xp7LX6nyCj7
         ViEcGJs1VnGw9bnhkB4UH7NYQkyrM3e1X4bLW6YUWceK9020APe6YdS0NHMhCE/5NbA5
         MhqbvLnl8f60NnhlOzVOVXzNMGdP5I/VIM7gkkEUT0XUokDJ19E0SNYeJUBsxBSVI5//
         7cruGNAT+wPvT5REVLDJUsd/ozFDLt/8O+z8w/e1s7poQQrt/84sF2Zba73otLwAnns2
         5NLPdBZyMqwbO43Cz2lSeLPNnuprssKdbrnN0MQ8m4Sco9HjCM8zrkaGfC5LvLrOMx+q
         sYJw==
X-Gm-Message-State: AOJu0YzuAf+7Vu8NDKykMlMiYDi1WFj/yf9TSOJlhT1SnFrqUNEa9q90
        cJnNeGwLocl3p8Z7imWKKd32T8mKgr1HKZ+Qc33C8g==
X-Google-Smtp-Source: AGHT+IEddQF9uzdYbAgIrFR3ke1bpnCa7eeTunJm/Kp5S0NJp72sjQkooeZkLrSqPWuFJ75Gn6aaeu22fIzDZJjCO5s=
X-Received: by 2002:a05:600c:3b06:b0:3fe:e9ea:9653 with SMTP id
 m6-20020a05600c3b0600b003fee9ea9653mr26656wms.4.1696016365916; Fri, 29 Sep
 2023 12:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230926220208.1423-1-michal.wajdeczko@intel.com>
In-Reply-To: <20230926220208.1423-1-michal.wajdeczko@intel.com>
From:   Rae Moar <rmoar@google.com>
Date:   Fri, 29 Sep 2023 15:39:13 -0400
Message-ID: <CA+GJov7=jDe82ZXSz0hf4Kb2ENhU0yacPQaEPi+P8S3ixi3GgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: Add param generator macro for zero terminated arrays
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

On Tue, Sep 26, 2023 at 6:02=E2=80=AFPM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> The existing macro KUNIT_ARRAY_PARAM can produce parameter
> generator function but only when we fully know the definition
> of the array. However, there might be cases where we would like
> to generate test params based on externaly defined array, which
> is defined as zero-terminated array, like pci_driver.id_table.
>
> Add helper macro KUNIT_ZERO_ARRAY_PARAM that can work with zero
> terminated arrays and provide example how to use it.
>
> $ ./tools/testing/kunit/kunit.py run \
>         --kunitconfig ./lib/kunit/.kunitconfig *.example_params*
>
> [ ] Starting KUnit Kernel (1/1)...
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D example  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D example_par=
ams_test  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] [SKIPPED] example value 3
> [ ] [PASSED] example value 2
> [ ] [PASSED] example value 1
> [ ] [SKIPPED] example value 0
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] example_params=
_test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D example_par=
ams_test  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] [SKIPPED] example value 3
> [ ] [PASSED] example value 2
> [ ] [PASSED] example value 1
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] example_params=
_test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASS=
ED] example =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] Testing complete. Ran 7 tests: passed: 4, skipped: 3
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> ---
>  include/kunit/test.h           | 22 ++++++++++++++++++++++
>  lib/kunit/kunit-example-test.c |  2 ++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 20ed9f9275c9..280113ceb6a6 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1514,6 +1514,28 @@ do {                                              =
                              \
>                 return NULL;                                             =
                       \
>         }
>
> +/**
> + * KUNIT_ZERO_ARRAY_PARAM() - Define test parameter generator from a zer=
o terminated array.
> + * @name:  prefix for the test parameter generator function.
> + * @array: zero terminated array of test parameters.
> + * @get_desc: function to convert param to description; NULL to use defa=
ult
> + *
> + * Define function @name_gen_params which uses zero terminated @array to=
 generate parameters.
> + */
> +#define KUNIT_ZERO_ARRAY_PARAM(name, array, get_desc)                   =
                       \
> +       static const void *name##_gen_params(const void *prev, char *desc=
)                      \
> +       {                                                                =
                       \
> +               typeof((array)[0]) *__prev =3D prev;                     =
                         \
> +               typeof(__prev) __next =3D __prev ? __prev + 1 : (array); =
                         \
> +               void (*__get_desc)(typeof(__next), char *) =3D get_desc; =
                         \
> +               for (; memchr_inv(__next, 0, sizeof(*__next)); __prev =3D=
 __next++) {             \
> +                       if (__get_desc)                                  =
                       \
> +                               __get_desc(__next, desc);                =
                       \
> +                       return __next;                                   =
                       \
> +               }                                                        =
                       \
> +               return NULL;                                             =
                       \
> +       }
> +

Hello!

This overall looks good to me. I am not sure how many uses there are
for zero-terminated arrays for parameterized tests.

However, since it seems to be a well designed feature, I think it
should be good to add this to KUnit.

Thanks for including an example! Just one other comment below.

-Rae

>  // TODO(dlatypov@google.com): consider eventually migrating users to exp=
licitly
>  // include resource.h themselves if they need it.
>  #include <kunit/resource.h>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-tes=
t.c
> index 6bb5c2ef6696..ad9ebcfd513e 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -202,6 +202,7 @@ static void example_param_get_desc(const struct examp=
le_param *p, char *desc)
>  }
>
>  KUNIT_ARRAY_PARAM(example, example_params_array, example_param_get_desc)=
;
> +KUNIT_ZERO_ARRAY_PARAM(example_zero, example_params_array, example_param=
_get_desc);
>
>  /*
>   * This test shows the use of params.
> @@ -246,6 +247,7 @@ static struct kunit_case example_test_cases[] =3D {
>         KUNIT_CASE(example_all_expect_macros_test),
>         KUNIT_CASE(example_static_stub_test),
>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
> +       KUNIT_CASE_PARAM(example_params_test, example_zero_gen_params),

I would prefer if the name of the new params test was a bit different
just to differentiate them. Maybe: example_params_zero_test

>         KUNIT_CASE_SLOW(example_slow_test),
>         {}
>  };
> --
> 2.25.1
>
