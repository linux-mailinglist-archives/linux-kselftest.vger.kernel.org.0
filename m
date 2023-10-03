Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7067B743C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 00:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjJCWqg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 18:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjJCWqf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 18:46:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0069CAB
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Oct 2023 15:46:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4063bfc6c03so33825e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Oct 2023 15:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696373190; x=1696977990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO3hdXhbDjwU69nME55VLnqKlDKuLndcgy2zdbT9tgA=;
        b=q1oYb2r1Oml+ufmvEdsI8qRh9xK4iu65mjPhXYQ4A60JiFrW0iwCUQqN+8CHDxDZSf
         DsFdfRYMfWThEE/gFX+w8+5LMK/VtJxFyqtHhIsEvpgZRfcq9UL6iVj3M7zW361BKH08
         0n0ZlZCX3g01LD6gMlczmo7uwd2+haBL1aPrlLjyzJ3aHsSBAA/GqzEzGFiz4rahMpD9
         qVX11nLseFeQO7apGJcSJLdSAsinOirO/b4k3oVV6eTMlif7o6ZtEIWp/HlJT0GXO4Cw
         cNISCUpzGpbUf0tcwFjSMz3U1F5cnvgt5vQWTAcgusBZewXDslCd6vMesvhAinQMZ2TL
         rGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696373190; x=1696977990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JO3hdXhbDjwU69nME55VLnqKlDKuLndcgy2zdbT9tgA=;
        b=ZHVxUnBiej0WsJvYt4IkAFWCD6fl8MSGg2a3E1hldxAZXfzKpVpo/nfjU4muTRvtXa
         D+VWL0zyFh8EgGqmx3n9yeYhRIyzi4sjcLYr0vCoEYEsfmrYamS3Or31NYmdVQgn4A4E
         AyHyPwroudVW/+0L84HaAfNT/sC92f2e3u5fvLBTWAqpXqUr52oHExPjYhraljvH+ccS
         +hrYKzSQqfbzRmgJ+EcK1/4MRLKHOs/JzXM2CUEdXbllgFusAcv70yQc+Mju7zTAG79C
         YHXROk7uvE7T/kXe6/CNqSgBuHn0TujUSHW07AUPQbrMA16uELNXhW4tvvA6bCTOY3Nn
         Ribw==
X-Gm-Message-State: AOJu0YwmBtkTHe3+VRF6yaVP9J4S6CO2ula3y25Hjdbb48TOTivcSFFH
        GT+jVLHzEuJUyqXR5g+2vZHlMjiyhwxNPVunR4vIzYV0F4Lz483EwAu5Cw==
X-Google-Smtp-Source: AGHT+IE400Ba0XIFYzPVyVX5nDicNN+P5LGX4QbwVhb03x+ItybhO1Ghr9b8AOB4fAgtx0HOq2M3QTpFT1PeCb6wyWE=
X-Received: by 2002:a05:600c:1e13:b0:405:35bf:7362 with SMTP id
 ay19-20020a05600c1e1300b0040535bf7362mr44054wmb.0.1696373190247; Tue, 03 Oct
 2023 15:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230925175733.1379-1-michal.wajdeczko@intel.com>
 <20230925175733.1379-4-michal.wajdeczko@intel.com> <CA+GJov5L=0tMb+VdHgS+LgFWsQ6dJtVPVb6O2X=1Xa1yR1jzVA@mail.gmail.com>
 <3fa0d3fc-c37a-6470-2a8f-ad1055b86715@intel.com>
In-Reply-To: <3fa0d3fc-c37a-6470-2a8f-ad1055b86715@intel.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 3 Oct 2023 18:46:18 -0400
Message-ID: <CA+GJov4NE6B+2iniTguKHvf3ozvwM9ScCXoMc4419iYxKER6Xw@mail.gmail.com>
Subject: Re: [PATCH 3/4] kunit: Fix indentation of parameterized tests messages
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

On Mon, Oct 2, 2023 at 9:43=E2=80=AFAM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
>
>
> On 28.09.2023 22:53, Rae Moar wrote:
> > On Mon, Sep 25, 2023 at 1:58=E2=80=AFPM Michal Wajdeczko
> > <michal.wajdeczko@intel.com> wrote:
> >>
> >> When running parametrized test cases, diagnostic messages
> >> are not properly aligned with the test result lines:
> >>
> >>     $ ./tools/testing/kunit/kunit.py run --raw_output \
> >>         --kunitconfig ./lib/kunit/.kunitconfig *.example_params*
> >>
> >>     KTAP version 1
> >>     1..1
> >>     # example: initializing suite
> >>         KTAP version 1
> >>         # Subtest: example
> >>         # module: kunit_example_test
> >>         1..1
> >>             KTAP version 1
> >>             # Subtest: example_params_test
> >>         # example_params_test: initializing
> >>         # example_params_test: cleaning up
> >>             ok 1 example value 3 # SKIP unsupported param value 3
> >>         # example_params_test: initializing
> >>         # example_params_test: cleaning up
> >>             ok 2 example value 2
> >>         # example_params_test: initializing
> >>         # example_params_test: cleaning up
> >>             ok 3 example value 1
> >>         # example_params_test: initializing
> >>         # example_params_test: cleaning up
> >>             ok 4 example value 0 # SKIP unsupported param value 0
> >>         # example_params_test: pass:2 fail:0 skip:2 total:4
> >>         ok 1 example_params_test
> >>     # example: exiting suite
> >>     # Totals: pass:2 fail:0 skip:2 total:4
> >>     ok 1 example
> >>
> >> Add test level attribute and use it to generate proper indent
> >> at the runtime:
> >>
> >>     KTAP version 1
> >>     1..1
> >>     # example: initializing suite
> >>         KTAP version 1
> >>         # Subtest: example
> >>         # module: kunit_example_test
> >>         1..1
> >>             KTAP version 1
> >>             # Subtest: example_params_test
> >>             # example_params_test: initializing
> >>             # example_params_test: cleaning up
> >>             ok 1 example value 3 # SKIP unsupported param value 3
> >>             # example_params_test: initializing
> >>             # example_params_test: cleaning up
> >>             ok 2 example value 2
> >>             # example_params_test: initializing
> >>             # example_params_test: cleaning up
> >>             ok 3 example value 1
> >>             # example_params_test: initializing
> >>             # example_params_test: cleaning up
> >>             ok 4 example value 0 # SKIP unsupported param value 0
> >>         # example_params_test: pass:2 fail:0 skip:2 total:4
> >>         ok 1 example_params_test
> >>     # example: exiting suite
> >>     # Totals: pass:2 fail:0 skip:2 total:4
> >>     ok 1 example
> >>
> >> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> >> Cc: David Gow <davidgow@google.com>
> >> Cc: Rae Moar <rmoar@google.com>
> >
> > Hello!
> >
> > Great to see these changes! Just a few comments below.
> >
> > Thanks!
> > -Rae
> >
> >> ---
> >>  include/kunit/test.h |  3 ++-
> >>  lib/kunit/test.c     | 52 ++++++++++++++++++++-----------------------=
-
> >>  2 files changed, 26 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/include/kunit/test.h b/include/kunit/test.h
> >> index 158876c4cb43..4804d539e10f 100644
> >> --- a/include/kunit/test.h
> >> +++ b/include/kunit/test.h
> >> @@ -276,6 +276,7 @@ struct kunit {
> >>         void *priv;
> >>
> >>         /* private: internal use only. */
> >> +       unsigned int level; /* Helps in proper log indent */
> >>         const char *name; /* Read only after initialization! */
> >>         struct string_stream *log; /* Points at case log after initial=
ization */
> >>         struct kunit_try_catch try_catch;
> >> @@ -519,7 +520,7 @@ enum {
> >>  #define kunit_level(test_or_suite)                                   =
  \
> >>         _Generic((test_or_suite),                                     =
  \
> >>                  struct kunit_suite * : KUNIT_LEVEL_SUITE,            =
  \
> >> -                struct kunit * : KUNIT_LEVEL_CASE)
> >> +                struct kunit * : ((struct kunit *)(test_or_suite))->l=
evel)
> >>
> >>  #define kunit_indent_level(test_or_suite)                            =
  \
> >>         (KUNIT_INDENT_LEN * kunit_level(test_or_suite))
> >> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> >> index d10e6d610e20..43c3efc286e4 100644
> >> --- a/lib/kunit/test.c
> >> +++ b/lib/kunit/test.c
> >> @@ -99,14 +99,13 @@ static void kunit_print_test_stats(struct kunit *t=
est,
> >>         if (!kunit_should_print_stats(stats))
> >>                 return;
> >>
> >> -       kunit_log(KERN_INFO, test,
> >> -                 KUNIT_SUBTEST_INDENT
> >> -                 "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
> >> -                 test->name,
> >> -                 stats.passed,
> >> -                 stats.failed,
> >> -                 stats.skipped,
> >> -                 stats.total);
> >> +       kunit_log_indent(KERN_INFO, test,
> >> +                        "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
> >> +                        test->name,
> >> +                        stats.passed,
> >> +                        stats.failed,
> >> +                        stats.skipped,
> >> +                        stats.total);
> >
> > I would prefer if we keep the same indentation level as before.
>
> note that then scripts/checkpatch.pl will complain with:
>
> CHECK: Alignment should match open parenthesis
> #109: FILE: lib/kunit/test.c:103:
> +       kunit_log_indent(KERN_INFO, test,
>                   "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
>
> CHECK: Alignment should match open parenthesis
> #141: FILE: lib/kunit/test.c:178:
> +               kunit_log_indent(KERN_INFO, test,
> +                         "%s %zd %s%s%s",
>
> are you ok with that?
>
> Michal

Hello!

I understand now. It is unfortunate that the previous indentation
causes a checkpatch warning. I suppose KUnit should fix the
indentation of the file as a whole in a separate patch then.

Since the issue of the indentation is resolved, I am happy with this
current patch.

Thanks!
-Rae

>
> > Otherwise looks good.
> >
> >>  }
> >>
> >>  /* Append formatted message to log. */
> >> @@ -154,7 +153,6 @@ static void kunit_print_suite_start(struct kunit_s=
uite *suite)
> >>  }
> >>
> >>  static void kunit_print_ok_not_ok(struct kunit *test,
> >> -                                 unsigned int test_level,
> >>                                   enum kunit_status status,
> >>                                   size_t test_number,
> >>                                   const char *description,
> >> @@ -163,12 +161,6 @@ static void kunit_print_ok_not_ok(struct kunit *t=
est,
> >>         const char *directive_header =3D (status =3D=3D KUNIT_SKIPPED)=
 ? " # SKIP " : "";
> >>         const char *directive_body =3D (status =3D=3D KUNIT_SKIPPED) ?=
 directive : "";
> >>
> >> -       /*
> >> -        * When test is NULL assume that results are from the suite
> >> -        * and today suite results are expected at level 0 only.
> >> -        */
> >> -       WARN(!test && test_level, "suite test level can't be %u!\n", t=
est_level);
> >> -
> >>         /*
> >>          * We do not log the test suite results as doing so would
> >>          * mean debugfs display would consist of an incorrect test
> >> @@ -182,12 +174,11 @@ static void kunit_print_ok_not_ok(struct kunit *=
test,
> >>                         test_number, description, directive_header,
> >>                         directive_body);
> >>         else
> >> -               kunit_log(KERN_INFO, test,
> >> -                         "%*s%s %zd %s%s%s",
> >> -                         KUNIT_INDENT_LEN * test_level, "",
> >> -                         kunit_status_to_ok_not_ok(status),
> >> -                         test_number, description, directive_header,
> >> -                         directive_body);
> >> +               kunit_log_indent(KERN_INFO, test,
> >> +                                "%s %zd %s%s%s",
> >> +                                kunit_status_to_ok_not_ok(status),
> >> +                                test_number, description, directive_h=
eader,
> >> +                                directive_body);
> >
> > Again, I would prefer we keep the same indentation as before as it
> > matches the rest of the file.
> >
> >
> >>  }
> >>
> >>  enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite=
)
> >> @@ -213,7 +204,7 @@ static size_t kunit_suite_counter =3D 1;
> >>
> >>  static void kunit_print_suite_end(struct kunit_suite *suite)
> >>  {
> >> -       kunit_print_ok_not_ok(NULL, KUNIT_LEVEL_SUITE,
> >> +       kunit_print_ok_not_ok(NULL,
> >>                               kunit_suite_has_succeeded(suite),
> >>                               kunit_suite_counter++,
> >>                               suite->name,
> >> @@ -322,6 +313,7 @@ void kunit_init_test(struct kunit *test, const cha=
r *name, struct string_stream
> >>  {
> >>         spin_lock_init(&test->lock);
> >>         INIT_LIST_HEAD(&test->resources);
> >> +       test->level =3D KUNIT_LEVEL_CASE;
> >>         test->name =3D name;
> >>         test->log =3D log;
> >>         if (test->log)
> >> @@ -584,14 +576,15 @@ int kunit_run_tests(struct kunit_suite *suite)
> >>                         kunit_run_case_catch_errors(suite, test_case, =
&test);
> >>                         kunit_update_stats(&param_stats, test.status);
> >>                 } else {
> >> +                       /* Parameterized test is one level up from sim=
ple test-case. */
> >> +                       test.level++;
> >> +
> >>                         /* Get initial param. */
> >>                         param_desc[0] =3D '\0';
> >>                         test.param_value =3D test_case->generate_param=
s(NULL, param_desc);
> >>                         test_case->status =3D KUNIT_SKIPPED;
> >> -                       kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDE=
NT KUNIT_SUBTEST_INDENT
> >> -                                 "KTAP version 1\n");
> >> -                       kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDE=
NT KUNIT_SUBTEST_INDENT
> >> -                                 "# Subtest: %s", test_case->name);
> >> +                       kunit_log_indent(KERN_INFO, &test, "KTAP versi=
on 1\n");
> >> +                       kunit_log_indent(KERN_INFO, &test, "# Subtest:=
 %s", test_case->name);
> >>
> >>                         while (test.param_value) {
> >>                                 kunit_run_case_catch_errors(suite, tes=
t_case, &test);
> >> @@ -601,7 +594,7 @@ int kunit_run_tests(struct kunit_suite *suite)
> >>                                                  "param-%d", test.para=
m_index);
> >>                                 }
> >>
> >> -                               kunit_print_ok_not_ok(&test, KUNIT_LEV=
EL_CASE_PARAM,
> >> +                               kunit_print_ok_not_ok(&test,
> >>                                                       test.status,
> >>                                                       test.param_index=
 + 1,
> >>                                                       param_desc,
> >> @@ -616,13 +609,16 @@ int kunit_run_tests(struct kunit_suite *suite)
> >>                                 test.status =3D KUNIT_SUCCESS;
> >>                                 test.status_comment[0] =3D '\0';
> >>                         }
> >> +
> >> +                       /* Return to parent (test-case) level. */
> >> +                       test.level--;
> >>                 }
> >>
> >>                 kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_=
CASE);
> >>
> >>                 kunit_print_test_stats(&test, param_stats);
> >>
> >> -               kunit_print_ok_not_ok(&test, KUNIT_LEVEL_CASE, test_ca=
se->status,
> >> +               kunit_print_ok_not_ok(&test, test_case->status,
> >>                                       kunit_test_case_num(suite, test_=
case),
> >>                                       test_case->name,
> >>                                       test.status_comment);
> >> --
> >> 2.25.1
> >>
