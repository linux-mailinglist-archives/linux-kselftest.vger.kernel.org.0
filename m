Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5521F751298
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 23:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjGLVYT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 17:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjGLVYS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 17:24:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F346F1991
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 14:24:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbd200d354so6875e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689197055; x=1691789055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRYKuZmOzn2eDQvpZAyKvdHoA0esQ8YkNB/9CHegYp4=;
        b=68FueLkifnEvI2/dcI4vKg7XoaAraqJYXIGXx0gol2RFbO3i25HIE5zHDAFIpdge9m
         Er7oLzxeLbGK65IGRfHDEIbzzK0NPAP8qL4bT6QkZBYIQ+d3YRLhD0pw+7KdZPXgjCET
         vmQZ0h8ytMBvuMP5MfNUGJgQ1N86ryp2KekjT7lCKvhMM2wuiEvYMQ9itmGX0iGVkF+7
         mh/DsMl5JizoKGsCLpVcJl/dY5oWMhIBoXOe0/XB5wwmX0v/AbY8KZi4dHB1Iu7ysRm1
         KcctGLNOr5Y2I7APbTHVcPrH9Vmbe56O0FpCkLlVahvwqQxDZhlyV1EpC4/iqt9hDEBA
         ug2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689197055; x=1691789055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRYKuZmOzn2eDQvpZAyKvdHoA0esQ8YkNB/9CHegYp4=;
        b=hewQabUyhQBlO520lSZDLqTmxY25DjSESZwq2RqerJreQjPkV3TU08g79xDMiVeV8u
         KBfzDR1uGbFOBQVbk9PDn/jOhtatujgS13RaN2MPEfYnaPIjVciEN4Jbj2Ye8n5pG17g
         wx0uWJQPXPPIbrTF/oTYRaIowdw6tocToSw85iUrA7uZ9V9VrOowGIRWdjrEUi1mHjI8
         06JKpieeUwuTu3QBIGX7Y/iCbgKsUd4ziuX575JwcxFRhueE7nO3gorC9o9udY4lANt2
         okF7BTMSwZaBxabAslsGISg2aSGkrikrdM4f/v8pzCAFfO/KJQU7/6LSN12IbN4Pwy91
         8sQw==
X-Gm-Message-State: ABy/qLZnIFTbHrLYTq3d14Y95kVglVMVWPF0NroH6Pp4RZ9/cYApOQA/
        /Q2diy7Pg+mvzy4JK05dlh6jeywwi69XkFGx/7UxrQ==
X-Google-Smtp-Source: APBJJlFXdAQCwwXOoLVPr3AbRiDWtil+SMJ6P4gYpOLfrjHNtsw+5+LpFSOY+9upmeKIgBiPmvhAQ858pcs1R7p6NeU=
X-Received: by 2002:a05:600c:3b25:b0:3f4:2736:b5eb with SMTP id
 m37-20020a05600c3b2500b003f42736b5ebmr133562wms.1.1689197055355; Wed, 12 Jul
 2023 14:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-9-rmoar@google.com>
 <CAGS_qxpyWAO4567m9uF1ksDiO0zUBQDJ0pAUJRvKxg1PYhrtEA@mail.gmail.com>
In-Reply-To: <CAGS_qxpyWAO4567m9uF1ksDiO0zUBQDJ0pAUJRvKxg1PYhrtEA@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 12 Jul 2023 17:24:02 -0400
Message-ID: <CA+GJov5Ud=X7BiEzYzA1q2yQk-vE7VRaSkqKNjhhaTuOUxhPXw@mail.gmail.com>
Subject: Re: [RFC v2 8/9] kunit: add tests for filtering attributes
To:     Daniel Latypov <dlatypov@google.com>
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

On Mon, Jul 10, 2023 at 2:07=E2=80=AFPM Daniel Latypov <dlatypov@google.com=
> wrote:
>
> On Fri, Jul 7, 2023 at 2:10=E2=80=AFPM Rae Moar <rmoar@google.com> wrote:
> >
> > Add four tests to executor_test.c to test behavior of filtering attribu=
tes.
> >
> > - parse_filter_attr_test - to test the parsing of inputted filters
> >
> > - filter_attr_test - to test the filtering procedure on attributes
> >
> > - filter_attr_empty_test - to test the behavior when all tests are filt=
ered
> >   out
> >
> > - filter_attr_skip_test - to test the configurable filter_skip option
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
>
> I love that I'm able to read this patch first and get a feel for what
> exactly the patch series is doing overall.


Thanks!

>
>
> Some nits and suggestions below.
>
> > ---
> >
> > Changes since v1:
> > - This is a new patch
> >
> >  lib/kunit/executor_test.c | 107 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >
> > diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> > index d7ab069324b5..145a78ade33d 100644
> > --- a/lib/kunit/executor_test.c
> > +++ b/lib/kunit/executor_test.c
> > @@ -7,6 +7,7 @@
> >   */
> >
> >  #include <kunit/test.h>
> > +#include <kunit/attributes.h>
> >
> >  static void kfree_at_end(struct kunit *test, const void *to_free);
> >  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
> > @@ -22,6 +23,14 @@ static struct kunit_case dummy_test_cases[] =3D {
> >         {},
> >  };
> >
> > +static struct kunit_case dummy_attr_test_cases[] =3D {
> > +       /* .run_case is not important, just needs to be non-NULL */
> > +       { .name =3D "test1", .run_case =3D dummy_test, .module_name =3D=
 "dummy",
> > +         .attr.speed =3D KUNIT_SPEED_SLOW },
> > +       { .name =3D "test2", .run_case =3D dummy_test, .module_name =3D=
 "dummy" },
> > +       {},
> > +};
>
> 1) can we move this array to be just above parse_filter_attr_test so
> it's next to where it's used?

This seems like a great idea. I will move it down.

>
>
> 2) How about renaming "test1" to "slow" to make the assertions in the
> test case a bit easier to follow?
> Right now readers need to remember which test case was supposed to be
> filtered out.

Yes this sounds good. I think including "slow" would be helpful
although I might also consider the name "slow_test".

>
>
> > +
> >  static void parse_filter_test(struct kunit *test)
> >  {
> >         struct kunit_glob_filter filter =3D {NULL, NULL};
> > @@ -108,11 +117,109 @@ static void filter_suites_to_empty_test(struct k=
unit *test)
> >                                 "should be empty to indicate no match")=
;
> >  }
> >
> > +static void parse_filter_attr_test(struct kunit *test)
> > +{
> > +       int j, filter_count;
> > +       struct kunit_attr_filter *parsed_filters;
> > +       char *filters =3D "speed>slow, module!=3Dexample";
> > +       int err =3D 0;
> > +
> > +       filter_count =3D kunit_get_filter_count(filters);
> > +       KUNIT_EXPECT_EQ(test, filter_count, 2);
> > +
> > +       parsed_filters =3D kcalloc(filter_count + 1, sizeof(*parsed_fil=
ters), GFP_KERNEL);
>
> nit: kunit_kcalloc() instead?

Right, that makes sense. Thanks!

>
> > +       for (j =3D 0; j < filter_count; j++)
> > +               parsed_filters[j] =3D kunit_next_attr_filter(&filters, =
&err);
>
> then here we probably want to check err, i.e.
>   KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter '%s'", filter=
s[i]);
>

Sounds good. I will add this.

>
> > +
> > +       KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[=
0]), "speed");
> > +       KUNIT_EXPECT_STREQ(test, parsed_filters[0].input, ">slow");
> > +
> > +       KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[=
1]), "module");
> > +       KUNIT_EXPECT_STREQ(test, parsed_filters[1].input, "!=3Dexample"=
);
> > +
> > +       kfree(parsed_filters);
> > +}
> > +
> > +static void filter_attr_test(struct kunit *test)
> > +{
> > +       struct kunit_suite *subsuite[3] =3D {NULL, NULL};
> > +       struct suite_set suite_set =3D {.start =3D subsuite, .end =3D &=
subsuite[2]};
> > +       struct suite_set got;
> > +       int err =3D 0;
> > +
> > +       subsuite[0] =3D alloc_fake_suite(test, "suite1", dummy_attr_tes=
t_cases);
> > +       subsuite[1] =3D alloc_fake_suite(test, "suite2", dummy_attr_tes=
t_cases);
> > +       subsuite[1]->attr.speed =3D KUNIT_SPEED_SLOW; // Set suite attr=
ibute
>
> Similarly, perhaps we can rename suite2 to "slow_suite"?
> That would cause this line to go over 80 characters wide, but since
> that's no longer a hard limit, I think this would be a decent place to
> go past it.

Like above, I like this idea. I'll change the name. Interesting idea
about the 80 character limit also.

>
>
> > +
> > +       /* Want: suite1(test1, test2), suite2(test1, test2), NULL -> su=
ite1(test2), NULL */
> > +       got =3D kunit_filter_suites(&suite_set, NULL, "speed>slow", NUL=
L, &err);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
> > +       KUNIT_ASSERT_EQ(test, err, 0);
> > +       kfree_at_end(test, got.start);
> > +
> > +       /* Validate we just have suite1 */
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
> > +       KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->name, "sui=
te1");
> > +       KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
> > +
> > +       /* Now validate we just have test2 */
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
> > +       KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases=
[0].name, "test2");
> > +       KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
> > +}
> > +
> > +static void filter_attr_empty_test(struct kunit *test)
> > +{
> > +       struct kunit_suite *subsuite[3] =3D {NULL, NULL};
> > +       struct suite_set suite_set =3D {.start =3D subsuite, .end =3D &=
subsuite[2]};
> > +       struct suite_set got;
> > +       int err =3D 0;
> > +
> > +       subsuite[0] =3D alloc_fake_suite(test, "suite1", dummy_attr_tes=
t_cases);
> > +       subsuite[1] =3D alloc_fake_suite(test, "suite2", dummy_attr_tes=
t_cases);
> > +
> > +       got =3D kunit_filter_suites(&suite_set, NULL, "module!=3Ddummy"=
, NULL, &err);
> > +       KUNIT_ASSERT_EQ(test, err, 0);
> > +       kfree_at_end(test, got.start); /* just in case */
> > +
> > +       KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
> > +                               "should be empty to indicate no match")=
;
> > +}
> > +
> > +static void filter_attr_skip_test(struct kunit *test)
> > +{
> > +       struct kunit_suite *subsuite[2] =3D {NULL};
> > +       struct suite_set suite_set =3D {.start =3D subsuite, .end =3D &=
subsuite[1]};
> > +       struct suite_set got;
> > +       int err =3D 0;
> > +
> > +       subsuite[0] =3D alloc_fake_suite(test, "suite1", dummy_attr_tes=
t_cases);
> > +
> > +       /* Want: suite1(test1, test2), NULL -> suite1(test1 with SKIP, =
test2), NULL */
> > +       got =3D kunit_filter_suites(&suite_set, NULL, "speed>slow", "sk=
ip", &err);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
> > +       KUNIT_ASSERT_EQ(test, err, 0);
> > +       kfree_at_end(test, got.start);
> > +
> > +       /* Validate we have both test1 and test2 */
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>
> Should we assert that we have 2 test cases before we dereference the seco=
nd one?
> The other code in this file (that I wrote) is being a bit sloppy and
> deref'ing test_cases[0] without checking. It's doing that since I was
> relying on the fact that the filtering code drops suites with no test
> cases, so we don't necessarily need to check len(test_cases) >=3D 1.
> (In terms of best practices, we should be defensive and checking that, th=
ough).
>
> But in this case, we have no such guarantee about the second element.

Good point. I'll add an assert statement here about the length of test_case=
s.

>
>
> > +       KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases=
[0].name, "test1");
> > +       KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases=
[1].name, "test2");
>
> Trying to remember, I think the cast to `const char *` is no longer
> necessary after one of David's changes...
> I think we might just never have gotten around to cleaning that up due
> to the ordering in which the patches went in...

Ahh got it. That is my bad. I'll double check if these are necessary.

>
>
> > +
> > +       /* Now ensure test1 is skipped and test2 is not */
> > +       KUNIT_EXPECT_EQ(test, got.start[0]->test_cases[0].status, KUNIT=
_SKIPPED);
> > +       KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].status);
>
> Should we check that it's equal to KUNIT_SUCCESS instead?
>

I wouldn't expect the status to be set in this case. But the status is
returning as 0 so it would pass for both the assert statement above
and if it's equal to KUNIT_SUCCESS. But since it is not supposed to be
set to KUNIT_SUCCESS, I'm inclined to keep it this way.

Thanks for all the comments Daniel!
-Rae

>
>
> > +}
> > +
> >  static struct kunit_case executor_test_cases[] =3D {
> >         KUNIT_CASE(parse_filter_test),
> >         KUNIT_CASE(filter_suites_test),
> >         KUNIT_CASE(filter_suites_test_glob_test),
> >         KUNIT_CASE(filter_suites_to_empty_test),
> > +       KUNIT_CASE(parse_filter_attr_test),
> > +       KUNIT_CASE(filter_attr_test),
> > +       KUNIT_CASE(filter_attr_empty_test),
> > +       KUNIT_CASE(filter_attr_skip_test),
> >         {}
> >  };
> >
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
