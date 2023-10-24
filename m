Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC327D5BB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 21:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjJXTlv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 15:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjJXTlu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 15:41:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A4010A
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Oct 2023 12:41:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so2a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Oct 2023 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698176506; x=1698781306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRzA/IZOuzI29NSKstVbB17mcLz9Ekp9gOm2EMMOm3k=;
        b=E9buZADaRmBQT4R8hKA+IEcvGechukfOoe4iepswqI/ZoVWwnc0G9OGupgJoI9gjuY
         fdtdkzSLh4l2lzd/tdz8l/xYRxnmwsrhEzy0Ay6Amn1so5JgRUw726UpAQ2oopvDIiLc
         HsB1UnCMFdzNdZa6OmQvk9gOBRtNpSVNR/go9YA0IvdPhT5Kj9SlowPzYjIgNU/Bqfh/
         gqbWFW2sIPqvSUbCjZgMlrAJRi6/z+9KF2bSu/yiR4D6SjO4N8365qqQ8NVvz2g7fh0S
         b9QMbLDQ+NrWEh3zmJWrGt0dKpvCIrVvQ9/3FtXZ+X1mKsQE0oyDjbABNuSiCqto4FQM
         6A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176506; x=1698781306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRzA/IZOuzI29NSKstVbB17mcLz9Ekp9gOm2EMMOm3k=;
        b=knyPic74u4QyDe/cbcsazuv2qec+AQVp7d4hzqj0X3dYFKGOXuMS5kS/Lspiv6NQQK
         RQVWZArtWJS5SP47E66AeSeQW40lun4j3nW4ZgkbTW6KAQOEIOszkLmOOjTHjBtayJS/
         ADlQ3FphviVIl48Q6g/uwIGUlHj2CL8Oka9Ct7WY/mz/J7+ODUHC8saTmhenqyamfAUE
         isVyoIb+bK639AnV1myRmw0PsPtdMiemHmQ03/VEn+zgr88fhJOHpJ9tfCPb/yaVEHhq
         3IKSEPCgmzpn//vGNKCq3OtMVLBhgW7piTNBfcXI5v2nSUHKWAdZYot4Z0STWIxJwj5X
         Q51Q==
X-Gm-Message-State: AOJu0YyYF/g6udaRM9QVwcIxITB7iR7IorJtAVf9qlooI6nCzZjMeItD
        dEsXYuCrHIidAffgPhtP5WM4qksT07khuAIOwgSG+A==
X-Google-Smtp-Source: AGHT+IEPIU+kYIVhHwrvwUjZxXuZlwCFBoZ6R3V9YsifmVQOw/OC9L8FQJw/1zkBycfz+i9X5qIFfw4rvRWE5EMm9TQ=
X-Received: by 2002:a05:600c:4746:b0:408:3e63:f457 with SMTP id
 w6-20020a05600c474600b004083e63f457mr3058wmo.2.1698176505660; Tue, 24 Oct
 2023 12:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230920084903.1522728-1-mripard@kernel.org>
In-Reply-To: <20230920084903.1522728-1-mripard@kernel.org>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 24 Oct 2023 15:41:33 -0400
Message-ID: <CA+GJov6YQ2YcfqudffKzAKmcwbgCvuXpd8HzKnwSuytF-ozvww@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Warn if tests are slow
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

On Wed, Sep 20, 2023 at 4:49=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> Kunit recently gained support to setup attributes, the first one being
> the speed of a given test, then allowing to filter out slow tests.
>
> A slow test is defined in the documentation as taking more than one
> second. There's an another speed attribute called "super slow" but whose
> definition is less clear.
>
> Add support to the test runner to check the test execution time, and
> report tests that should be marked as slow but aren't.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>

Hello!

Thanks for following up! Sorry for the delay in this response.

This looks great to me. I do have one comment below regarding the
KUNIT_SPEED_SLOW_THRESHOLD_S macro but other than that I would be
happy with this patch.

This patch does bring up the question of how to handle KUnit warnings
as mentioned before. But I am happy to approach that in a future
patch.

And I do still have concerns with this being annoying for those on
slower architectures but again that would depend on how we deal with
KUnit warnings.

Thanks!
-Rae

> ---
>
> To: Brendan Higgins <brendan.higgins@linux.dev>
> To: David Gow <davidgow@google.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-kernel@vger.kernel.org
>
> Changes from v1:
> - Split the patch out of the series
> - Change to trigger the warning only if the runtime is twice the
>   threshold (Jani, Rae)
> - Split the speed check into a separate function (Rae)
> - Link: https://lore.kernel.org/all/20230911-kms-slow-tests-v1-0-d3800a69=
a1a1@kernel.org/
> ---
>  lib/kunit/test.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49698a168437..a1d5dd2bf87d 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -372,6 +372,25 @@ void kunit_init_test(struct kunit *test, const char =
*name, char *log)
>  }
>  EXPORT_SYMBOL_GPL(kunit_init_test);
>
> +#define KUNIT_SPEED_SLOW_THRESHOLD_S   1
> +
> +static void kunit_run_case_check_speed(struct kunit *test,
> +                                      struct kunit_case *test_case,
> +                                      struct timespec64 duration)
> +{
> +       enum kunit_speed speed =3D test_case->attr.speed;
> +
> +       if (duration.tv_sec < (2 * KUNIT_SPEED_SLOW_THRESHOLD_S))

I think I would prefer that KUNIT_SPEED_SLOW_THRESHOLD_S is instead
set to 2 rather than using 2 as the multiplier. I realize the actual
threshold for the attributes is 1 sec but for the practical use of
this warning it is 2 sec.

Also I would still be open to this being 1 sec depending on others
opinions. David, what are your thoughts on this?

> +               return;
> +
> +       if (speed =3D=3D KUNIT_SPEED_VERY_SLOW || speed =3D=3D KUNIT_SPEE=
D_SLOW)
> +               return;
> +
> +       kunit_warn(test,
> +                  "Test should be marked slow (runtime: %lld.%09lds)",
> +                  duration.tv_sec, duration.tv_nsec);
> +}
> +
>  /*
>   * Initializes and runs test case. Does not clean up or do post validati=
ons.
>   */
> @@ -379,6 +398,8 @@ static void kunit_run_case_internal(struct kunit *tes=
t,
>                                     struct kunit_suite *suite,
>                                     struct kunit_case *test_case)
>  {
> +       struct timespec64 start, end;
> +
>         if (suite->init) {
>                 int ret;
>
> @@ -390,7 +411,13 @@ static void kunit_run_case_internal(struct kunit *te=
st,
>                 }
>         }
>
> +       ktime_get_ts64(&start);
> +
>         test_case->run_case(test);
> +
> +       ktime_get_ts64(&end);
> +
> +       kunit_run_case_check_speed(test, test_case, timespec64_sub(end, s=
tart));
>  }
>
>  static void kunit_case_internal_cleanup(struct kunit *test)
> --
> 2.41.0
>
