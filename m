Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB0F299A3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 00:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395528AbgJZXOR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 19:14:17 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45345 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395524AbgJZXOQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 19:14:16 -0400
Received: by mail-ot1-f66.google.com with SMTP id f37so9542576otf.12
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Oct 2020 16:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtnCo2BEv8dnTOOlZbPQs4uRATJRDmvi8k9IkHEHV5Q=;
        b=ruFYXNTj8pNpWPLqOuBoMGZdA1RA5EAmAmEILKFH8Jk1iMOYp6nHwx0GSH/4xR39CI
         RVTtjQlCCTRUovbcRKK2VOnrn3NnoAVYcIj13VfKtN4wmHtAfvO+jPhyZKl9GHtxkJHN
         rI+GONJ+IwxadIlUFjeBKrbrjcdjSqsR4Kj0fLI3RTJFM1n/w8JVC+gc5NS5Bcc972rY
         aWXnHXzgbMgLjSYfYE7XdpA5SntRanq98SBIdHOz73VQjYh9r+U6FvFZgSESb24+XmAz
         tjyd5V9ybLs2K7KBA/iGfAhmvd7KGimB/3Qih9/lJ2ra0BcP/AKWMWcq7WyK899g+DEt
         XI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtnCo2BEv8dnTOOlZbPQs4uRATJRDmvi8k9IkHEHV5Q=;
        b=miAM+TjNgyOEpsFh98ZWw/NtTksw/kptBWV1Hgm8iCk0+vm1gPs/Vet6Xjva4WAvZj
         NNDWnOABgxeDKMIn6wXcU+LelojryurV5IGGxT5EX0Dfr7PpS5sB5CfKuATIBJo/8OJ7
         M7TX5y7XemaKSlIqm0rlAF111aFJJRNrxvVcFmbeOxPsa4ljoKAzwxhl5iq5+MOrl66c
         WXBG4OqFRXwFgaADJmvQ0Ivatxba6NKjdh7GtQbbIchicA5Mblw6RuEiDgGAAuPghdlc
         jUsnLpWkBvLsNcDoogk73tF8Kz6yKMPqlY+82geFlqkBh8IgwMniFRoO7KA6LtUCtIpT
         VlkQ==
X-Gm-Message-State: AOAM532BvbhTjEyr6YAEPIWyIqIo1joFSF0p0BgJzJW82C9hbyyQzu4w
        D1fJE+izvHATVAFUmLl/LXSQSXoVt6Jz005kZ6h2Ow==
X-Google-Smtp-Source: ABdhPJw0F4J4BcLEjSwsurEvo/n9/PqQmt7GchLvDFbNDOZ2IfLtrGTPdNrNvzacbvn5uqCj+klJlJlGCH/v1WBWOY0=
X-Received: by 2002:a9d:649:: with SMTP id 67mr17364102otn.233.1603754054772;
 Mon, 26 Oct 2020 16:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201026183523.82749-1-98.arpi@gmail.com>
In-Reply-To: <20201026183523.82749-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 27 Oct 2020 00:14:03 +0100
Message-ID: <CANpmjNNQtGC_jDp8TSHRHOMXi7aTQgwjtUiCWE+YqBgq-G2z5Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 26 Oct 2020 at 19:36, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Implementation of support for parameterized testing in KUnit.
> This approach requires the creation of a test case using the
> KUNIT_CASE_PARAM macro that accepts a generator function as input.
> This generator function should return the next parameter given the
> previous parameter in parameterized tests. It also provides
> a macro to generate common-case generators.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> Changes v2->v3:
> - Modifictaion of generator macro and method

Great to see it worked as expected!

> Changes v1->v2:
> - Use of a generator method to access test case parameters
>
>  include/kunit/test.h | 32 ++++++++++++++++++++++++++++++++
>  lib/kunit/test.c     | 20 +++++++++++++++++++-
>  2 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index a423fffefea0..16bf9f334e2c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -142,6 +142,12 @@ struct kunit_case {
>         void (*run_case)(struct kunit *test);
>         const char *name;
>
> +       /*
> +        * Pointer to test parameter generator function.
> +        * Used only for parameterized tests.

What I meant was to give a description of the protocol, so that if
somebody wanted, they could (without reading the implementation)
implement their own custom generator without the helper macro.

E.g. something like: "The generator function is used to lazily
generate a series of arbitrarily typed values that fit into a void*.
The argument @prev is the previously returned value, which should be
used to derive the next value; @prev is set to NULL on the initial
generator call. When no more values are available, the generator must
return NULL."

> +        */
> +       void* (*generate_params)(void *prev);
> +
>         /* private: internal use only. */
>         bool success;
>         char *log;
> @@ -162,6 +168,9 @@ static inline char *kunit_status_to_string(bool status)
>   * &struct kunit_case for an example on how to use it.
>   */
>  #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
> +#define KUNIT_CASE_PARAM(test_name, gen_params)                        \
> +               { .run_case = test_name, .name = #test_name,    \
> +                 .generate_params = gen_params }
>
>  /**
>   * struct kunit_suite - describes a related collection of &struct kunit_case
> @@ -208,6 +217,15 @@ struct kunit {
>         const char *name; /* Read only after initialization! */
>         char *log; /* Points at case log after initialization */
>         struct kunit_try_catch try_catch;
> +       /* param_values points to test case parameters in parameterized tests */
> +       void *param_values;
> +       /*
> +        * current_param stores the index of the parameter in
> +        * the array of parameters in parameterized tests.
> +        * current_param + 1 is printed to indicate the parameter
> +        * that causes the test to fail in case of test failure.
> +        */
> +       int current_param;
>         /*
>          * success starts as true, and may only be set to false during a
>          * test case; thus, it is safe to update this across multiple
> @@ -1742,4 +1760,18 @@ do {                                                                            \
>                                                 fmt,                           \
>                                                 ##__VA_ARGS__)
>
> +/**
> + * KUNIT_PARAM_GENERATOR() - Helper method for test parameter generators
> + *                          required in parameterized tests.

This is only for arrays, which is why I suggested KUNIT_ARRAY_PARAM()
as the name.

A generator can very well be implemented without an array, so this
macro name is confusing. In future somebody might want to provide a
macro that takes a start + end value (and maybe a step value) to
generate a series of values. That generator could be named
KUNIT_RANGE_PARAM(name, start, end, step) and gives us a generator
that is also named name##_gen_params. (If you want to try implementing
that macro, I'd suggest doing it as a separate patch.)

And I don't think we need to put "GENERATOR" into the name of these
macros, because the generators are now the fundamental method with
which to get parameterized tests. We don't need to state the obvious,
in favor of some brevity.

> + * @name:  prefix of the name for the test parameter generator function.
> + * @prev: a pointer to the previous test parameter, NULL for first parameter.
> + * @array: a user-supplied pointer to an array of test parameters.
> + */
> +#define KUNIT_PARAM_GENERATOR(name, array)                                                     \
> +       static void *name##_gen_params(void *prev)                                              \
> +       {                                                                                       \
> +               typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);     \
> +               return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;                  \
> +       }
> +
>  #endif /* _KUNIT_TEST_H */

Thanks,
-- Marco
