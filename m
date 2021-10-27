Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4265443D154
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 21:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbhJ0TCf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 15:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhJ0TCe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 15:02:34 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B40AC061745
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 12:00:08 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r194so4972531iod.7
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXKCRvYW+G/U3lCt5Bb406ecBZvxMrSVY/Zc9yEqb98=;
        b=JzW/KRnOs36+qiUImtSUHxPTHogPFxD/HyvIaGOpbyqDP6UWSNjZESlNnNXdG7qc5r
         AOJvgF/J0F2v8NdyUM12Ek/0kcHtSCoWu+9psXlZgl3FfrIYxAMmmSxStB4ilq2L8ikc
         0DCCVMyvRYI4Mx9kTv2gUUgUORl3/jSUAhEPAxbhKIaUnkBSBA3ERg6Uu7V4l/TcebPs
         CMMTrLHzggpXA+tyFPDCrLNZwkr8hPpltgN+vF5CZaJpU+K5YILQR8VuxCGyHQw0X8Z2
         fY48qUx1qErXd7uz1QwwT3ML5p10B2ZC9yx1KqX2egWksVNV/+GpsF/R+pvj0HSkc081
         h2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXKCRvYW+G/U3lCt5Bb406ecBZvxMrSVY/Zc9yEqb98=;
        b=Mis34dNiR9spPhi1yBiOAc/nrcCs/ck/uNUDxQvAvRlizTsZwviQN9GB2+Rgg4X4g9
         JaL+4Ekx2mGv0ZYe5v8HUb1EsUkIObIakOKGAu9nPtnLwUFjLsEvcaW2ptFY3Tn4hsTk
         BJOjKY3JclgYlTqSLvLX+TAyIBNn+g46bluUfRiNEOGa58ub/jf8JpVhvRx3r1jzXwk2
         CEfE0IV7Ostdz2ClHlbt8DkZebUfVY+jZSogXcCGj32wrkco+uA7IOoS4CqFziybGXKU
         LreEQR5o9z5dpcD9CRr03o984kdr9R9Q0208lf3DTYfDZkrX0nMf3yHcCNmKz1+CZ5kV
         Ukng==
X-Gm-Message-State: AOAM530Z6rmlOTf78UE0wfHIBLG4TbTHhXs9xJ7wVriVc0mG4FcqLE28
        wmgOgsk0scur+QEw6R1/OCaHQdW/NtVJyfsCGZdkNQ==
X-Google-Smtp-Source: ABdhPJxLBNMYnPhlvTfJ3h65LeVfM2OrbYYAMCXnwzpGjtBk+VleJKFtur6a+yaGJ4iS8fBHLaAPxgfPIb/Ybswfaik=
X-Received: by 2002:a02:a907:: with SMTP id n7mr15849878jam.96.1635361207311;
 Wed, 27 Oct 2021 12:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211027013702.2039566-1-davidgow@google.com> <20211027013702.2039566-3-davidgow@google.com>
In-Reply-To: <20211027013702.2039566-3-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 27 Oct 2021 11:59:55 -0700
Message-ID: <CAGS_qxqbJd+8U4TQCusmcNND0vdUCF2EJqBqXhtx3NBt4KAAGQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] kunit: Don't crash if no parameters are generated
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 26, 2021 at 6:37 PM David Gow <davidgow@google.com> wrote:
>
> It's possible that a parameterised test could end up with zero
> parameters. At the moment, the test function will nevertheless be called
> with NULL as the parameter. Instead, don't try to run the test code, and
> just mark the test as SKIPped.
>
> Reported-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  lib/kunit/test.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 3bd741e50a2d..e028d98e4f5b 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -500,7 +500,10 @@ int kunit_run_tests(struct kunit_suite *suite)
>         kunit_print_subtest_start(suite);
>
>         kunit_suite_for_each_test_case(suite, test_case) {
> -               struct kunit test = { .param_value = NULL, .param_index = 0 };
> +               /* The initial param value is nonzero, as we want
> +                * non-parametrised tests to run once.
> +                */
> +               struct kunit test = { .param_value = (void *)-1, .param_index = 0 };

(Not a strong preference)

Hmm, I'd slightly prefer we don't set a dummy value of -1 for this.
I personally think something like this is a bit less subtle:

/* Run non-parameterised tests once */
while (!test_case->generate_param || test.param_value) {

  if (!test_case->generate_param) break;
}

Alternatively, we don't need to share the loop

if (!test_case->generate_param) {
  kunit_run_case_catch_errors(suite, test_case, &test);
  kunit_update_stats(&param_stats, test.status);
} else while (test_param.value) {
   kunit_run_case_catch_errors(suite, test_case, &test);
   kunit_update_stats(&param_stats, test.status);
   /* print subtest and advance next param */
}

}


>                 struct kunit_result_stats param_stats = { 0 };
>                 test_case->status = KUNIT_SKIPPED;
>
> @@ -510,7 +513,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         test.param_value = test_case->generate_params(NULL, param_desc);
>                 }
>
> -               do {
> +               while (test.param_value) {
>                         kunit_run_case_catch_errors(suite, test_case, &test);
>
>                         if (test_case->generate_params) {
> @@ -530,11 +533,12 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                 param_desc[0] = '\0';
>                                 test.param_value = test_case->generate_params(test.param_value, param_desc);
>                                 test.param_index++;
> -                       }
> +                       } else
> +                               test.param_value = NULL;
>
>                         kunit_update_stats(&param_stats, test.status);
>
> -               } while (test.param_value);
> +               }
>
>                 kunit_print_test_stats(&test, param_stats);
>
> --
> 2.33.0.1079.g6e70778dc9-goog
>
