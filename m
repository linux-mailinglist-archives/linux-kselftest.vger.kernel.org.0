Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952EB7B743A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 00:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjJCWo5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 18:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJCWo4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 18:44:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25468E
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Oct 2023 15:44:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4063bfc6c03so33765e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Oct 2023 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696373090; x=1696977890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJuVhq4AjiOW4/fVwzj17aeKZBP7xebx8EAai3VEEdc=;
        b=iIihXQzlHU5GDyy454kzeK1awTUI03/Hitss8nWod74nJgLDN+U3SNsnz6dTtZO2uL
         ix8HevhVU4kY1tuH2SrkRw8rSdIcF4AY7ZkDlZkR6uOrZDOiNo1uyEHqCjIrPQYpGYOq
         9kDW7pSYzPKpFSxHrUUvXef+uOyyLvktZ83sJ98/bgp/4TtHrZksRQbSBALsclN1f2pX
         GaQAXzzIC63LgPcmAcRJ6CYProRGzcOxlCBYdhH4gYn3tq7CbLSPc5B3rVT1GS8OPyru
         /NROIXN73OeMFS8HluP6nSYEHK8Qj5d4GR1ufNxvYJuL093NytLEwhfybu8xN6nzxSWE
         IH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696373090; x=1696977890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJuVhq4AjiOW4/fVwzj17aeKZBP7xebx8EAai3VEEdc=;
        b=a6mN415tpnmpvCdFEakEvmuXqWLf8YDmelkLI57ZcmCZP9DuqPIUFoj2AzfATiBjea
         ff/EHy2C4FErNIE0zun5jhZcMzIhXtAwxOemJ+CphUhvpJK3zKy/1sxl2XWHckhNEzql
         56827g0Wm0y35ehzGOHNg1XsJs3r6mq1JtOhS9PlMxgtB1q2fbptdt0abwoxguzeRLZY
         QcjdKZHWtSYRGC/vDJeAar5tk0tc6C/wq8E+KV1+PvntVp2xWkQGHX9FbMGincSlQqsi
         zCr9F+wZTvd+jrnwqEUqMsCRLCjuOkkaX9q/SDAWVDtB2S18l0rrgOmQiIlJ2Mia6imN
         CAvA==
X-Gm-Message-State: AOJu0YwSmKefBlmsJSntC5iCcbMFmSd+eUeS897FiwuCtKXPZ5gx/I40
        aO7Ue6lla7XNzH5rBjOFMR33eqf8022jk2IJBAnV3fwH8OIXeXtBkCblRg==
X-Google-Smtp-Source: AGHT+IHnmahR39Mh3rxdrJfH23PUXACmCvx79AQ4ekvkJijEJ+mOTspgKu2sI6F5q1/CW3u4j0sP652R61RfBnnNbno=
X-Received: by 2002:a05:600c:1e13:b0:405:35bf:7362 with SMTP id
 ay19-20020a05600c1e1300b0040535bf7362mr43905wmb.0.1696373089587; Tue, 03 Oct
 2023 15:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230925175733.1379-1-michal.wajdeczko@intel.com>
 <20230925175733.1379-3-michal.wajdeczko@intel.com> <CA+GJov4tUcq5_JTm2yON1LZwMyP89_x=EbiqBqYpbVi=Vf9CCw@mail.gmail.com>
 <120ba1d4-b64b-21ea-1fb3-49d5fcb5127a@intel.com>
In-Reply-To: <120ba1d4-b64b-21ea-1fb3-49d5fcb5127a@intel.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 3 Oct 2023 18:44:37 -0400
Message-ID: <CA+GJov5Nh920ekKMVJfCA=L3RSVGdszS8RtZdujBvjBc86oKTQ@mail.gmail.com>
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

On Mon, Oct 2, 2023 at 9:42=E2=80=AFAM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
>
>
> On 28.09.2023 22:52, Rae Moar wrote:
> > On Mon, Sep 25, 2023 at 1:58=E2=80=AFPM Michal Wajdeczko
> > <michal.wajdeczko@intel.com> wrote:
> >>
> >> A kunit suite is a top level test from the KTAP point of view but
> >> all suite diagnostic messages are printed at the subtest level:
> >>
> >>     $ ./tools/testing/kunit/kunit.py run --raw_output \
> >>         --kunitconfig ./lib/kunit/.kunitconfig "example.*simple*"
> >>
> >>     KTAP version 1
> >>     1..1
> >>         # example: initializing suite
> >>         # example: failed to initialize (-ENODEV)
> >>     not ok 1 example
> >>
> >>     KTAP version 1
> >>     1..1
> >>         # example: initializing suite
> >>         KTAP version 1
> >>         # Subtest: example
> >>         # module: kunit_example_test
> >>         1..1
> >>         # example_simple_test: initializing
> >>         # example_simple_test: cleaning up
> >>         ok 1 example_simple_test
> >>         # example: exiting suite
> >>     ok 1 example
> >>
> >> Replace hardcoded indent in kunit_printk() with flexible
> >> indentation based on the argument type (test or suite):
> >>
> >>     KTAP version 1
> >>     1..1
> >>     # example: initializing suite
> >>     # example: failed to initialize (-ENODEV)
> >>     not ok 1 example
> >>
> >>     KTAP version 1
> >>     1..1
> >>     # example: initializing suite
> >>         KTAP version 1
> >>         # Subtest: example
> >>         # module: kunit_example_test
> >>         1..1
> >>         # example_simple_test: initializing
> >>         # example_simple_test: cleaning up
> >>         ok 1 example_simple_test
> >>     # example: exiting suite
> >>     ok 1 example
> >
> > Hi!
> >
> > I am happy to see this change to improve the indentation of
> > parameterized tests. It has been bugging me for a bit. This seems to
> > be working well but I just had a few comments to potentially discuss.
> >
> > Thanks!
> >
> > -Rae
> >

Hello!

Thanks for getting back to me.

> >>
> >> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> >> Cc: David Gow <davidgow@google.com>
> >> Cc: Rae Moar <rmoar@google.com>
> >> ---
> >>  include/kunit/test.h | 24 ++++++++++++++++++++++--
> >>  lib/kunit/test.c     |  7 -------
> >>  2 files changed, 22 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/include/kunit/test.h b/include/kunit/test.h
> >> index 20ed9f9275c9..158876c4cb43 100644
> >> --- a/include/kunit/test.h
> >> +++ b/include/kunit/test.h
> >> @@ -509,6 +509,21 @@ void __printf(2, 3) kunit_log_append(struct strin=
g_stream *log, const char *fmt,
> >>                 kunit_try_catch_throw(&((test_or_suite)->try_catch)); =
  \
> >>         } while (0)
> >>
> >> +/* Currently supported test levels */
> >> +enum {
> >> +       KUNIT_LEVEL_SUITE =3D 0,
> >> +       KUNIT_LEVEL_CASE,
> >> +       KUNIT_LEVEL_CASE_PARAM,
> >> +};
> >
> > I do find this slightly confusing to have a KUNIT_LEVEL_SUITE as the
> > suite output occurs on multiple levels. Plus, I also don't see any
> > uses of the SUITE level or the PARAM level anymore. Do you have any
> > ideas on this?
>
> This enum was just promoted as-is from the test.c as I didn't want to
> use magic 0 or 1 in below kunit_level() macro.
>
> Note that the KUNIT_LEVEL_SUITE is now used indirectly whenever you call
> any of kunit_printk() with suite param like here:
>
> ./kunit-example-test.c:60:  kunit_info(suite, "initializing suite\n");
> ./kunit-example-test.c:71:  kunit_info(suite, "exiting suite\n");
>

Oops sorry for missing this instance.

> as this will result in calls to kunit_indent_level(suite) and
> kunit_level(suite) macro.
>
> And KUNIT_LEVEL_CASE_PARAM is maybe a leftover, as now we change test
> levels using direct increase/decrease statements, but still IMO this
> enum nicely reflects what kind of levels we currently do support at this
> point. But could be dropped if needed.

Given the suite level is being used, I am on board with keeping the
enum as is. Plus, although the param level is not explicitly being
used, it does correspond with the value of the test->level field when
running parameterized tests.

>
> Regarding _"suite output occurs on multiple levels"_ I found that also
> confusing, but IMO this is due to the kunit implementation details
> and/or KTAP design decisions as it looks that "suite" is treated
> sometimes as "subtest" and sometimes as a top level "test".
>
> That makes a little trouble while trying to implement printing in a
> consistent manner.  Maybe we should consider introducing concept of the
> "executor" with its own level attribute? Then mapping will be like this:
>
> KTAP version 1                          <- kunit executor (level=3D0)
> 1..1                                    <- kunit executor (level=3D0)
> # Test: example                         <- kunit executor (level=3D0) ??
> # module: kunit_example_test            <- kunit executor (level=3D0) ??
> # example: initializing suite           <- suite (test level=3D0)
>     KTAP version 1                      <- suite executor (level=3D1)
>     # Subtest: example                  <- suite executor (level=3D1)
>     # module: kunit_example_test        <- suite executor (level=3D1)
>     1..2                                <- suite executor (level=3D1)
>     # test_1: initializing              <- test_case (test level=3D1)
>     # test_1: cleaning up               <- test_case (test level=3D1)
>     # test_1: pass:1 fail:0 skip:0 tota <- suite executor (level=3D1)
>     ok 1 test_1                         <- suite executor (level=3D1)
>         KTAP version 1                  <- params executor (level=3D2)
>         # Subtest: test_2               <- params executor (level=3D2)
>         1..2                            <- params executor (level=3D2)
>         # test_2: initializing          <- test_case (test level=3D2)
>         # test_2: cleaning up           <- test_case (test level=3D2)
>         ok 1 example value 1            <- params executor (level=3D2)
>         # test_2: initializing          <- test_case (test level=3D2)
>         # test_2: cleaning up           <- test_case (test level=3D2)
>         ok 2 example value 0            <- params executor (level=3D2)
>     # test_2: pass:2 fail:0 skip:0 tota <- suite executor (level=3D1)
>     ok 2 test_2                         <- suite executor (level=3D1)
> # example: exiting suite                <- suite (test level=3D0)
> # example: pass:2 fail:0 skip:0 total:2 <- kunit executor (level=3D0)
> # Totals: pass:3 fail:0 skip:0 total:3  <- kunit executor (level=3D0)
> ok 1 example                            <- kunit executor (level=3D0)
>
> Then any suite and/or test level will be just based on executor.level
> This could be done as follow-up improvement.
>

I like this concept of a general executor or test object. I would be
interested in David's opinion on this.

However, this may be a future task for when we change the overall
KUnit test implementation to be more general (remove the strict
concept of suite vs test case).

Perhaps for now we should keep your current implementation.

> >
> > We could consider just using the test->level field introduced in the
> > next patch to manage the levels. Or I wouldn't mind keeping this just
> > for clarity?
>
> We still need some definition for initial level, no?
> And at this point in series, we still need at least two defs.
>

To use the test->level field we would need to alter the overall KUnit
implementation to use a general test structure. Since that is not our
current structure, let's keep the original design.

> >
> >> +
> >> +#define kunit_level(test_or_suite)                                   =
  \
> >> +       _Generic((test_or_suite),                                     =
  \
> >> +                struct kunit_suite * : KUNIT_LEVEL_SUITE,            =
  \
> >> +                struct kunit * : KUNIT_LEVEL_CASE)
> >> +
> >
> > I am not super familiar with using _Generic so I would want David's opi=
nion.
> >
> > Also I can think of cases where it would be helpful to add an option
> > for struct kunit_case *, however, that may be an addition for the
> > future.
>
> I had entry for struct kunit_test_case* but removed that as it was never
> used in current code (no calls to kunit_log() with test_case)
>

That seems fine to me. We can always add this in later.

> >
> > And then additionally, this macro seems to be only used for the struct
> > kunit * case. Will we plan to use this in the future for suites?
>
> As pointed above we already use it for test and suite:
>
> ./kunit-example-test.c:60:  kunit_info(suite, "initializing suite\n");
> ./kunit-example-test.c:71:  kunit_info(suite, "exiting suite\n");
>
> >
> >> +#define kunit_indent_level(test_or_suite)                            =
  \
> >> +       (KUNIT_INDENT_LEN * kunit_level(test_or_suite))
> >> +
> >>  /*
> >>   * printk and log to per-test or per-suite log buffer.  Logging only =
done
> >>   * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/=
used.
> >> @@ -520,9 +535,14 @@ void __printf(2, 3) kunit_log_append(struct strin=
g_stream *log, const char *fmt,
> >>                                  ##__VA_ARGS__);                      =
  \
> >>         } while (0)
> >>
> >> +#define kunit_log_indent(lvl, test_or_suite, fmt, ...)               =
  \
> >> +       kunit_log(lvl, test_or_suite, "%*s" fmt,                      =
  \
> >> +                 kunit_indent_level(test_or_suite), "",              =
  \
> >> +                 ##__VA_ARGS__)
> >> +
> >>  #define kunit_printk(lvl, test, fmt, ...)                            =
  \
> >> -       kunit_log(lvl, test, KUNIT_SUBTEST_INDENT "# %s: " fmt,       =
  \
> >> -                 (test)->name, ##__VA_ARGS__)
> >> +       kunit_log_indent(lvl, test, "# %s: " fmt,                     =
  \
> >> +                        (test)->name, ##__VA_ARGS__)
> >>
> >
> > I wonder if we could consider removing the need to use
> > KUNIT_SUBTEST_INDENT in all locations. I am primarily thinking about
> > its uses in debugfs.c and test.c.
> >
> > For example in debugfs.c:
> > pr_info(KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> >
> > Although, as this is a suite object that is printing at the test case
> > level, I am not quite sure how to use the existing macros.
>
> We could add some wrapper like kunit_pr() that takes suite/test/executor
> from which we can derive right indent level, but that would be another
> follow up task once we agree on location and use of .level attribute.
>

I think it would be great to offer the kunit_pr option or some general
macro for formatting given the level.

Thanks!
-Rae

> Michal
>
> >
> >
> >>  /**
> >>   * kunit_info() - Prints an INFO level message associated with @test.
> >> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> >> index fb5981ce578d..d10e6d610e20 100644
> >> --- a/lib/kunit/test.c
> >> +++ b/lib/kunit/test.c
> >> @@ -135,13 +135,6 @@ size_t kunit_suite_num_test_cases(struct kunit_su=
ite *suite)
> >>  }
> >>  EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
> >>
> >> -/* Currently supported test levels */
> >> -enum {
> >> -       KUNIT_LEVEL_SUITE =3D 0,
> >> -       KUNIT_LEVEL_CASE,
> >> -       KUNIT_LEVEL_CASE_PARAM,
> >> -};
> >> -
> >>  static void kunit_print_suite_start(struct kunit_suite *suite)
> >>  {
> >>         /*
> >> --
> >> 2.25.1
> >>
