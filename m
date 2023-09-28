Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F717B26DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 22:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjI1UxA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 16:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjI1Uw7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 16:52:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303BC19E
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 13:52:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso2112a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695934375; x=1696539175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fv+Tyrbh8hqSiTaMJcwWyfH7CTozIlBBXbaNyfDiYYw=;
        b=Ub1ItqyunAJpvOMR2k+P3XOefSNM33p0XDjXRKnsCzUdt8WzBDp/HuHO5QUbpcrjl5
         4a0jf83J+edjRrPov8DfkTYcQ1cOdFE1YR5qC+eE56g2Nq9aBLq+39g3g9Sd6so2nOnN
         c04gNPqRv5O5aECmY3yAKXlJLfs9cEARazQWR/kAOLVpy5awFt8QeHnZfkzM42vPr7jI
         r/NvLWf3Cy9ytManEhht5Rx5o/fZLIsJGwG7qi5bGsRqn6MDwMWRNx9K+u/L+iSAU7y/
         NSYKnhPPbhLZjELn5Q2pPX7iLhrOu1o2EK36GPhtV3slUwfPhVJxUOdU9ystmRcg6dxD
         G8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934375; x=1696539175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fv+Tyrbh8hqSiTaMJcwWyfH7CTozIlBBXbaNyfDiYYw=;
        b=Uf4JENkZgAYeNdMP5AeBzkaLMOwd+z71p2kj7TJkarWTISZGmtKgUmM0Au3sAkrUPl
         yTFQ4q2WVQAALaoQFfydLQT/h4QXhEcfDtDMRa4uoDX2Hd1Dj89hTRpUsu1xF7WFDmTQ
         Bv3sP5IwsO1fup7M+hmfDaCvuxFFfHx4m3LIuNtI9Ga4rj/cKErfJ7mYiaDHRhFwTmwD
         Po1yBBCn6wed7FLDQA2sOq8mIktTWMnGRqLTsTqz33MRpzgnhdEjjIIrvcXlxqcD7hRX
         yqEkLwtvXj3Yfv1oDkVySOoAJaT59xy9HHhlTB7cu1XZm1MQpMoLt800L3cyvgoMo2lh
         uuaQ==
X-Gm-Message-State: AOJu0YyOXfIzCHP/m35200NFh+CrqvnPe5xmoSxOOn3ORmIWLBCQ5YKl
        zbHXJ2DF4iQhScefuMGqbhldXKawbtC5EGjf1/b8qw==
X-Google-Smtp-Source: AGHT+IGGnJ/kMBzF1QdYtsSxWQOBFlHgI9IDY1xr5+z/+PNtHjEXkIcytMNSD1d5xU3vZxfUgZqnyLcFREtkA1BTyLs=
X-Received: by 2002:a50:c308:0:b0:522:4741:d992 with SMTP id
 a8-20020a50c308000000b005224741d992mr510494edb.4.1695934375431; Thu, 28 Sep
 2023 13:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230925175733.1379-1-michal.wajdeczko@intel.com> <20230925175733.1379-3-michal.wajdeczko@intel.com>
In-Reply-To: <20230925175733.1379-3-michal.wajdeczko@intel.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 28 Sep 2023 16:52:43 -0400
Message-ID: <CA+GJov4tUcq5_JTm2yON1LZwMyP89_x=EbiqBqYpbVi=Vf9CCw@mail.gmail.com>
Subject: Re: [PATCH 2/4] kunit: Fix indentation level of suite messages
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
> A kunit suite is a top level test from the KTAP point of view but
> all suite diagnostic messages are printed at the subtest level:
>
>     $ ./tools/testing/kunit/kunit.py run --raw_output \
>         --kunitconfig ./lib/kunit/.kunitconfig "example.*simple*"
>
>     KTAP version 1
>     1..1
>         # example: initializing suite
>         # example: failed to initialize (-ENODEV)
>     not ok 1 example
>
>     KTAP version 1
>     1..1
>         # example: initializing suite
>         KTAP version 1
>         # Subtest: example
>         # module: kunit_example_test
>         1..1
>         # example_simple_test: initializing
>         # example_simple_test: cleaning up
>         ok 1 example_simple_test
>         # example: exiting suite
>     ok 1 example
>
> Replace hardcoded indent in kunit_printk() with flexible
> indentation based on the argument type (test or suite):
>
>     KTAP version 1
>     1..1
>     # example: initializing suite
>     # example: failed to initialize (-ENODEV)
>     not ok 1 example
>
>     KTAP version 1
>     1..1
>     # example: initializing suite
>         KTAP version 1
>         # Subtest: example
>         # module: kunit_example_test
>         1..1
>         # example_simple_test: initializing
>         # example_simple_test: cleaning up
>         ok 1 example_simple_test
>     # example: exiting suite
>     ok 1 example

Hi!

I am happy to see this change to improve the indentation of
parameterized tests. It has been bugging me for a bit. This seems to
be working well but I just had a few comments to potentially discuss.

Thanks!

-Rae

>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> ---
>  include/kunit/test.h | 24 ++++++++++++++++++++++--
>  lib/kunit/test.c     |  7 -------
>  2 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 20ed9f9275c9..158876c4cb43 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -509,6 +509,21 @@ void __printf(2, 3) kunit_log_append(struct string_s=
tream *log, const char *fmt,
>                 kunit_try_catch_throw(&((test_or_suite)->try_catch));   \
>         } while (0)
>
> +/* Currently supported test levels */
> +enum {
> +       KUNIT_LEVEL_SUITE =3D 0,
> +       KUNIT_LEVEL_CASE,
> +       KUNIT_LEVEL_CASE_PARAM,
> +};

I do find this slightly confusing to have a KUNIT_LEVEL_SUITE as the
suite output occurs on multiple levels. Plus, I also don't see any
uses of the SUITE level or the PARAM level anymore. Do you have any
ideas on this?

We could consider just using the test->level field introduced in the
next patch to manage the levels. Or I wouldn't mind keeping this just
for clarity?

> +
> +#define kunit_level(test_or_suite)                                     \
> +       _Generic((test_or_suite),                                       \
> +                struct kunit_suite * : KUNIT_LEVEL_SUITE,              \
> +                struct kunit * : KUNIT_LEVEL_CASE)
> +

I am not super familiar with using _Generic so I would want David's opinion=
.

Also I can think of cases where it would be helpful to add an option
for struct kunit_case *, however, that may be an addition for the
future.

And then additionally, this macro seems to be only used for the struct
kunit * case. Will we plan to use this in the future for suites?

> +#define kunit_indent_level(test_or_suite)                              \
> +       (KUNIT_INDENT_LEN * kunit_level(test_or_suite))
> +
>  /*
>   * printk and log to per-test or per-suite log buffer.  Logging only don=
e
>   * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/use=
d.
> @@ -520,9 +535,14 @@ void __printf(2, 3) kunit_log_append(struct string_s=
tream *log, const char *fmt,
>                                  ##__VA_ARGS__);                        \
>         } while (0)
>
> +#define kunit_log_indent(lvl, test_or_suite, fmt, ...)                 \
> +       kunit_log(lvl, test_or_suite, "%*s" fmt,                        \
> +                 kunit_indent_level(test_or_suite), "",                \
> +                 ##__VA_ARGS__)
> +
>  #define kunit_printk(lvl, test, fmt, ...)                              \
> -       kunit_log(lvl, test, KUNIT_SUBTEST_INDENT "# %s: " fmt,         \
> -                 (test)->name, ##__VA_ARGS__)
> +       kunit_log_indent(lvl, test, "# %s: " fmt,                       \
> +                        (test)->name, ##__VA_ARGS__)
>

I wonder if we could consider removing the need to use
KUNIT_SUBTEST_INDENT in all locations. I am primarily thinking about
its uses in debugfs.c and test.c.

For example in debugfs.c:
pr_info(KUNIT_SUBTEST_INDENT "KTAP version 1\n");

Although, as this is a suite object that is printing at the test case
level, I am not quite sure how to use the existing macros.


>  /**
>   * kunit_info() - Prints an INFO level message associated with @test.
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index fb5981ce578d..d10e6d610e20 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -135,13 +135,6 @@ size_t kunit_suite_num_test_cases(struct kunit_suite=
 *suite)
>  }
>  EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
>
> -/* Currently supported test levels */
> -enum {
> -       KUNIT_LEVEL_SUITE =3D 0,
> -       KUNIT_LEVEL_CASE,
> -       KUNIT_LEVEL_CASE_PARAM,
> -};
> -
>  static void kunit_print_suite_start(struct kunit_suite *suite)
>  {
>         /*
> --
> 2.25.1
>
