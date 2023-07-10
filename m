Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F04774DD10
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 20:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjGJSHc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 14:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjGJSHb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 14:07:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3856012B
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jul 2023 11:07:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40371070eb7so35051cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jul 2023 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689012449; x=1691604449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vcZqySAK77JDIKXSlaeSBenWZVW7mTWYU6gz+aOzWM=;
        b=BdM5ipce4ckFapSzvFsz/mz1MFVElMxrIigDKXUC2NAwgySxYK6inciZng1i9V0AcO
         IsBaevYgEA7T5JVFS9OThSicQkIIdRVrZ59Duny7KESaWyiwFT3fPkb9xxDEL3f5hnrc
         KABebBFkRqD6nVaxY4ilKQ2q4CUfVKLIlfMrZIQQDVT0UnyncpRW4tefeh3PSHVWW8V/
         KoohETs+R+TES9Ytbz7qVHNT09mH8NJSCSSDTBP5Xxd73DwtYOSfQMBKWJGAK5jOu3Ay
         W/0LrgFtc+QNrtVoDb0xPG/l+TuAEmfivhiYO3zP6MwYc0dxwo46+I3yIpmOJeh8DiJG
         3sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012449; x=1691604449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vcZqySAK77JDIKXSlaeSBenWZVW7mTWYU6gz+aOzWM=;
        b=kQrWBY0QwOt+eRRdCEua+crWw9vOZLjHsXCPGl6KUY39FEFLjlX/5M5ELI9zeufRkP
         OQ3titO0ZiHRU9c1kHIz4C+t8L68eUUOHTGnt62FSw5HsT+2t7m4PA+SLc1H2hEL9gv+
         NCqQSSGYXaCLK83c/GZ8VMZasGvlwCAMSVTJF9lQAsVOaz6I/4aX+CnHqLGp5LHe9a7S
         gQhpzLU9Bz5T02JyAx8wchtvZMm0dAI3aeyA3IreLo3pViuNdSkbTMNH//NBSnOs4ktR
         IP+DRvK2grbCLf9ZxM5260Bn0o33Knb2mxmBlIkAVWHZprB7G4CDc6mzHkF5NzvJqdAU
         90ow==
X-Gm-Message-State: ABy/qLZJ3Jb8xLRz4FDdszdBZ22ZJLhoTnusjB5j1akcviogWhGiEEo7
        PtlWcpb7xUMVX/ChKJNMlIORBKrfLQmFxZfFXeMnhA==
X-Google-Smtp-Source: APBJJlH34radkf2MwC7ks4EaK+O1likCeOf3VRsMqP8wBCilOVINpD/goU0ECl/wscdW8b9gvJYjciS+5Fg7aB09eF0=
X-Received: by 2002:a05:622a:4d0:b0:403:96e3:4745 with SMTP id
 q16-20020a05622a04d000b0040396e34745mr18230qtx.20.1689012449156; Mon, 10 Jul
 2023 11:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-9-rmoar@google.com>
In-Reply-To: <20230707210947.1208717-9-rmoar@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 10 Jul 2023 11:07:18 -0700
Message-ID: <CAGS_qxpyWAO4567m9uF1ksDiO0zUBQDJ0pAUJRvKxg1PYhrtEA@mail.gmail.com>
Subject: Re: [RFC v2 8/9] kunit: add tests for filtering attributes
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
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

On Fri, Jul 7, 2023 at 2:10=E2=80=AFPM Rae Moar <rmoar@google.com> wrote:
>
> Add four tests to executor_test.c to test behavior of filtering attribute=
s.
>
> - parse_filter_attr_test - to test the parsing of inputted filters
>
> - filter_attr_test - to test the filtering procedure on attributes
>
> - filter_attr_empty_test - to test the behavior when all tests are filter=
ed
>   out
>
> - filter_attr_skip_test - to test the configurable filter_skip option
>
> Signed-off-by: Rae Moar <rmoar@google.com>

I love that I'm able to read this patch first and get a feel for what
exactly the patch series is doing overall.

Some nits and suggestions below.

> ---
>
> Changes since v1:
> - This is a new patch
>
>  lib/kunit/executor_test.c | 107 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index d7ab069324b5..145a78ade33d 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <kunit/test.h>
> +#include <kunit/attributes.h>
>
>  static void kfree_at_end(struct kunit *test, const void *to_free);
>  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
> @@ -22,6 +23,14 @@ static struct kunit_case dummy_test_cases[] =3D {
>         {},
>  };
>
> +static struct kunit_case dummy_attr_test_cases[] =3D {
> +       /* .run_case is not important, just needs to be non-NULL */
> +       { .name =3D "test1", .run_case =3D dummy_test, .module_name =3D "=
dummy",
> +         .attr.speed =3D KUNIT_SPEED_SLOW },
> +       { .name =3D "test2", .run_case =3D dummy_test, .module_name =3D "=
dummy" },
> +       {},
> +};

1) can we move this array to be just above parse_filter_attr_test so
it's next to where it's used?

2) How about renaming "test1" to "slow" to make the assertions in the
test case a bit easier to follow?
Right now readers need to remember which test case was supposed to be
filtered out.


> +
>  static void parse_filter_test(struct kunit *test)
>  {
>         struct kunit_glob_filter filter =3D {NULL, NULL};
> @@ -108,11 +117,109 @@ static void filter_suites_to_empty_test(struct kun=
it *test)
>                                 "should be empty to indicate no match");
>  }
>
> +static void parse_filter_attr_test(struct kunit *test)
> +{
> +       int j, filter_count;
> +       struct kunit_attr_filter *parsed_filters;
> +       char *filters =3D "speed>slow, module!=3Dexample";
> +       int err =3D 0;
> +
> +       filter_count =3D kunit_get_filter_count(filters);
> +       KUNIT_EXPECT_EQ(test, filter_count, 2);
> +
> +       parsed_filters =3D kcalloc(filter_count + 1, sizeof(*parsed_filte=
rs), GFP_KERNEL);

nit: kunit_kcalloc() instead?

> +       for (j =3D 0; j < filter_count; j++)
> +               parsed_filters[j] =3D kunit_next_attr_filter(&filters, &e=
rr);

then here we probably want to check err, i.e.
  KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter '%s'", filters[=
i]);


> +
> +       KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[0]=
), "speed");
> +       KUNIT_EXPECT_STREQ(test, parsed_filters[0].input, ">slow");
> +
> +       KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[1]=
), "module");
> +       KUNIT_EXPECT_STREQ(test, parsed_filters[1].input, "!=3Dexample");
> +
> +       kfree(parsed_filters);
> +}
> +
> +static void filter_attr_test(struct kunit *test)
> +{
> +       struct kunit_suite *subsuite[3] =3D {NULL, NULL};
> +       struct suite_set suite_set =3D {.start =3D subsuite, .end =3D &su=
bsuite[2]};
> +       struct suite_set got;
> +       int err =3D 0;
> +
> +       subsuite[0] =3D alloc_fake_suite(test, "suite1", dummy_attr_test_=
cases);
> +       subsuite[1] =3D alloc_fake_suite(test, "suite2", dummy_attr_test_=
cases);
> +       subsuite[1]->attr.speed =3D KUNIT_SPEED_SLOW; // Set suite attrib=
ute

Similarly, perhaps we can rename suite2 to "slow_suite"?
That would cause this line to go over 80 characters wide, but since
that's no longer a hard limit, I think this would be a decent place to
go past it.

> +
> +       /* Want: suite1(test1, test2), suite2(test1, test2), NULL -> suit=
e1(test2), NULL */
> +       got =3D kunit_filter_suites(&suite_set, NULL, "speed>slow", NULL,=
 &err);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
> +       KUNIT_ASSERT_EQ(test, err, 0);
> +       kfree_at_end(test, got.start);
> +
> +       /* Validate we just have suite1 */
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
> +       KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->name, "suite=
1");
> +       KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
> +
> +       /* Now validate we just have test2 */
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
> +       KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0=
].name, "test2");
> +       KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
> +}
> +
> +static void filter_attr_empty_test(struct kunit *test)
> +{
> +       struct kunit_suite *subsuite[3] =3D {NULL, NULL};
> +       struct suite_set suite_set =3D {.start =3D subsuite, .end =3D &su=
bsuite[2]};
> +       struct suite_set got;
> +       int err =3D 0;
> +
> +       subsuite[0] =3D alloc_fake_suite(test, "suite1", dummy_attr_test_=
cases);
> +       subsuite[1] =3D alloc_fake_suite(test, "suite2", dummy_attr_test_=
cases);
> +
> +       got =3D kunit_filter_suites(&suite_set, NULL, "module!=3Ddummy", =
NULL, &err);
> +       KUNIT_ASSERT_EQ(test, err, 0);
> +       kfree_at_end(test, got.start); /* just in case */
> +
> +       KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
> +                               "should be empty to indicate no match");
> +}
> +
> +static void filter_attr_skip_test(struct kunit *test)
> +{
> +       struct kunit_suite *subsuite[2] =3D {NULL};
> +       struct suite_set suite_set =3D {.start =3D subsuite, .end =3D &su=
bsuite[1]};
> +       struct suite_set got;
> +       int err =3D 0;
> +
> +       subsuite[0] =3D alloc_fake_suite(test, "suite1", dummy_attr_test_=
cases);
> +
> +       /* Want: suite1(test1, test2), NULL -> suite1(test1 with SKIP, te=
st2), NULL */
> +       got =3D kunit_filter_suites(&suite_set, NULL, "speed>slow", "skip=
", &err);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
> +       KUNIT_ASSERT_EQ(test, err, 0);
> +       kfree_at_end(test, got.start);
> +
> +       /* Validate we have both test1 and test2 */
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);

Should we assert that we have 2 test cases before we dereference the second=
 one?
The other code in this file (that I wrote) is being a bit sloppy and
deref'ing test_cases[0] without checking. It's doing that since I was
relying on the fact that the filtering code drops suites with no test
cases, so we don't necessarily need to check len(test_cases) >=3D 1.
(In terms of best practices, we should be defensive and checking that, thou=
gh).

But in this case, we have no such guarantee about the second element.

> +       KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0=
].name, "test1");
> +       KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[1=
].name, "test2");

Trying to remember, I think the cast to `const char *` is no longer
necessary after one of David's changes...
I think we might just never have gotten around to cleaning that up due
to the ordering in which the patches went in...

> +
> +       /* Now ensure test1 is skipped and test2 is not */
> +       KUNIT_EXPECT_EQ(test, got.start[0]->test_cases[0].status, KUNIT_S=
KIPPED);
> +       KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].status);

Should we check that it's equal to KUNIT_SUCCESS instead?


> +}
> +
>  static struct kunit_case executor_test_cases[] =3D {
>         KUNIT_CASE(parse_filter_test),
>         KUNIT_CASE(filter_suites_test),
>         KUNIT_CASE(filter_suites_test_glob_test),
>         KUNIT_CASE(filter_suites_to_empty_test),
> +       KUNIT_CASE(parse_filter_attr_test),
> +       KUNIT_CASE(filter_attr_test),
> +       KUNIT_CASE(filter_attr_empty_test),
> +       KUNIT_CASE(filter_attr_skip_test),
>         {}
>  };
>
> --
> 2.41.0.255.g8b1d071c50-goog
>
