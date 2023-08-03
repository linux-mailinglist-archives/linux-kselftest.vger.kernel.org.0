Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4377E76F38F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 21:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjHCTjy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 15:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjHCTjv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 15:39:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE67420E
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 12:39:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so3115a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691091578; x=1691696378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5voU2DobUwvkJAMPVyJE9Vwy5Vfeg1yztnxHd6e8HNU=;
        b=SecRJl+zE+rpRyTfAYhjLRInvY0a7dzOSq9heEcWYOLaPJN/kBzD/LQ6dcN95s+H35
         IHcUN3wCtvRp/tiMN55vSePuojmYlP6jdTZRUWeg6MrGCYpECfgLsdjQSnw81ZC30OTj
         scPSP7ZsFVGZ7Js74691eczlD3/r/T4tqEu5Y1GsCrxCgKsUZZJORYm8vAcLD+gEBvkD
         /hoa+8WFQDvBXpqe/EbjZFvGVrW+LevGXV1hv1uMsxpRda8pRQAl+Pp/ZwfJJ20VYiAV
         g4Ey5lqze/kifU8SzoodNF019vuT1SJu0iYzVaOs+aumtgWaGLSsXvSjhLy3w639EnEr
         G4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691091578; x=1691696378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5voU2DobUwvkJAMPVyJE9Vwy5Vfeg1yztnxHd6e8HNU=;
        b=PXCH1OSU1GVa0QLKaEY1rLHOk95qElW0hmgBuprXoeo9xHjGX3yjTaOi9WhXZtQaM0
         RR3EN14U4rv4/AgAj/YE+zka5ohWJfHNdkx8JBMqMM7BkgabJSq0St/+ovyoB0kV7rVO
         050QzWEWp/8GW7NIxMI6up/UH0NumvGLyxWPizku8I7psFnjbjDnEpsYaSSIZXEwqFRV
         lqNyGbuj2phYPJ5BebHfRj5tMPNv9NpTWJEH9TGj6nAzQcxfC5mfwS2CcZGkVlce1yCx
         AGxf+hhEcMOweXv6VQ4ZRO+sA0Zy1OWLf2ar1X4AS53qpDUCwmSlEEefVnH1CmZeGJng
         XA7Q==
X-Gm-Message-State: AOJu0Yz8Di45qH2NsWpG4hdQ4yf2pPpXf6HGbWrVFuNgNuWbXpG0PxKs
        WwbvwvX5+uvsEAIaZOY5jGkVyTqYcE3KhW3DNa9Gzg==
X-Google-Smtp-Source: AGHT+IFMkZB0zQ9qSFpLsqEGAdnPBVsV9TRsnxOXDIUoaDfuP+WVrdcp+hkSjx7Q4Ln+Bg1q31TxAUJsn3N706F3qXw=
X-Received: by 2002:a50:baeb:0:b0:521:d274:fc81 with SMTP id
 x98-20020a50baeb000000b00521d274fc81mr2848ede.2.1691091578007; Thu, 03 Aug
 2023 12:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230802212834.761327-1-rmoar@google.com> <CABVgOSkGL2QhcQ7067NddajXGOJvjN88O7OjdTs3YY2xgMSZPQ@mail.gmail.com>
In-Reply-To: <CABVgOSkGL2QhcQ7067NddajXGOJvjN88O7OjdTs3YY2xgMSZPQ@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 3 Aug 2023 15:39:25 -0400
Message-ID: <CA+GJov6MGXUsDjGa0TyoMVz7jrc+zT05KkHar63jj0gOppTKqA@mail.gmail.com>
Subject: Re: [PATCH -next] kunit: fix uninitialized variables bug in
 attributes filtering
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, brendan.higgins@linux.dev, ruanjinjie@huawei.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 3, 2023 at 4:15=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> On Thu, 3 Aug 2023 at 05:28, Rae Moar <rmoar@google.com> wrote:
> >
> > Fix smatch warnings regarding uninitialized variables in the filtering
> > patch of the new KUnit Attributes feature.
> >
> > Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202307270610.s0w4NKEn-lkp@intel.com/
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> These fixes look good, especially the ones in attributes.c.
>
> There's still a possibility of returning uninitialised or freed
> pointers in executor.c. If we can keep 'filtered' valid at all times,
> this should be easier to deal with, e.g.:
>
> - Initialise 'filtered' to {NULL, NULL}, which is a valid "empty" value.
> - Only ever set start and end at the same time, so don't set 'start'
> immediately after allocation.
> - Wait until the filtering is complete and successful (i.e., where
> 'end' is set now), and set 'start' there as well.
> - Then return filtered will definitely either return the completely
> filtered value, or a valid empty suite_set.
>

Hi!

Great point. I will definitely change this. This is definitely a flaw
in the code. I have sent out a v2 of this patch with your suggested
changes above. Let me know what you think.

Thanks!
-Rae

> Otherwise, this looks good.
>
> -- David
>
> >
> > Note that this is rebased on top of the recent fix:
> > ("kunit: fix possible memory leak in kunit_filter_suites()").
> >
> >  lib/kunit/attributes.c | 40 +++++++++++++++++-----------------------
> >  lib/kunit/executor.c   | 10 +++++++---
> >  2 files changed, 24 insertions(+), 26 deletions(-)
> >
> > diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> > index d37c40c0ce4f..5e3034b6be99 100644
> > --- a/lib/kunit/attributes.c
> > +++ b/lib/kunit/attributes.c
> > @@ -102,7 +102,7 @@ static int int_filter(long val, const char *op, int=
 input, int *err)
> >  static int attr_enum_filter(void *attr, const char *input, int *err,
> >                 const char * const str_list[], int max)
> >  {
> > -       int i, j, input_int;
> > +       int i, j, input_int =3D -1;
> >         long test_val =3D (long)attr;
> >         const char *input_val =3D NULL;
> >
> > @@ -124,7 +124,7 @@ static int attr_enum_filter(void *attr, const char =
*input, int *err,
> >                         input_int =3D j;
> >         }
> >
> > -       if (!input_int) {
> > +       if (input_int < 0) {
> >                 *err =3D -EINVAL;
> >                 pr_err("kunit executor: invalid filter input: %s\n", in=
put);
> >                 return false;
> > @@ -186,8 +186,10 @@ static void *attr_module_get(void *test_or_suite, =
bool is_test)
> >         // Suites get their module attribute from their first test_case
> >         if (test)
> >                 return ((void *) test->module_name);
> > -       else
> > +       else if (kunit_suite_num_test_cases(suite) > 0)
> >                 return ((void *) suite->test_cases[0].module_name);
> > +       else
> > +               return (void *) "";
> >  }
> >
> >  /* List of all Test Attributes */
> > @@ -221,7 +223,7 @@ const char *kunit_attr_filter_name(struct kunit_att=
r_filter filter)
> >  void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int =
test_level)
> >  {
> >         int i;
> > -       bool to_free;
> > +       bool to_free =3D false;
> >         void *attr;
> >         const char *attr_name, *attr_str;
> >         struct kunit_suite *suite =3D is_test ? NULL : test_or_suite;
> > @@ -255,7 +257,7 @@ void kunit_print_attr(void *test_or_suite, bool is_=
test, unsigned int test_level
> >
> >  int kunit_get_filter_count(char *input)
> >  {
> > -       int i, comma_index, count =3D 0;
> > +       int i, comma_index =3D 0, count =3D 0;
> >
> >         for (i =3D 0; input[i]; i++) {
> >                 if (input[i] =3D=3D ',') {
> > @@ -272,7 +274,7 @@ int kunit_get_filter_count(char *input)
> >  struct kunit_attr_filter kunit_next_attr_filter(char **filters, int *e=
rr)
> >  {
> >         struct kunit_attr_filter filter =3D {};
> > -       int i, j, comma_index, new_start_index;
> > +       int i, j, comma_index =3D 0, new_start_index =3D 0;
> >         int op_index =3D -1, attr_index =3D -1;
> >         char op;
> >         char *input =3D *filters;
> > @@ -316,7 +318,7 @@ struct kunit_attr_filter kunit_next_attr_filter(cha=
r **filters, int *err)
> >                 filter.attr =3D &kunit_attr_list[attr_index];
> >         }
> >
> > -       if (comma_index) {
> > +       if (comma_index > 0) {
> >                 input[comma_index] =3D '\0';
> >                 filter.input =3D input + op_index;
> >                 input =3D input + new_start_index;
> > @@ -356,31 +358,22 @@ struct kunit_suite *kunit_filter_attr_tests(const=
 struct kunit_suite *const suit
> >
> >         /* Save filtering result on default value */
> >         default_result =3D filter.attr->filter(filter.attr->attr_defaul=
t, filter.input, err);
> > -       if (*err) {
> > -               kfree(copy);
> > -               kfree(filtered);
> > -               return NULL;
> > -       }
> > +       if (*err)
> > +               goto err;
> >
> >         /* Save suite attribute value and filtering result on that valu=
e */
> >         suite_val =3D filter.attr->get_attr((void *)suite, false);
> >         suite_result =3D filter.attr->filter(suite_val, filter.input, e=
rr);
> > -       if (*err) {
> > -               kfree(copy);
> > -               kfree(filtered);
> > -               return NULL;
> > -       }
> > +       if (*err)
> > +               goto err;
> >
> >         /* For each test case, save test case if passes filtering. */
> >         kunit_suite_for_each_test_case(suite, test_case) {
> >                 test_val =3D filter.attr->get_attr((void *) test_case, =
true);
> >                 test_result =3D filter.attr->filter(filter.attr->get_at=
tr(test_case, true),
> >                                 filter.input, err);
> > -               if (*err) {
> > -                       kfree(copy);
> > -                       kfree(filtered);
> > -                       return NULL;
> > -               }
> > +               if (*err)
> > +                       goto err;
> >
> >                 /*
> >                  * If attribute value of test case is set, filter on th=
at value.
> > @@ -406,7 +399,8 @@ struct kunit_suite *kunit_filter_attr_tests(const s=
truct kunit_suite *const suit
> >                 }
> >         }
> >
> > -       if (n =3D=3D 0) {
> > +err:
> > +       if (n =3D=3D 0 || *err) {
> >                 kfree(copy);
> >                 kfree(filtered);
> >                 return NULL;
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 481901d245d0..b6e07de2876a 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -130,7 +130,7 @@ static struct suite_set kunit_filter_suites(const s=
truct suite_set *suite_set,
> >         struct kunit_suite **copy, *filtered_suite, *new_filtered_suite=
;
> >         struct suite_set filtered;
> >         struct kunit_glob_filter parsed_glob;
> > -       struct kunit_attr_filter *parsed_filters;
> > +       struct kunit_attr_filter *parsed_filters =3D NULL;
> >
> >         const size_t max =3D suite_set->end - suite_set->start;
> >
> > @@ -147,7 +147,11 @@ static struct suite_set kunit_filter_suites(const =
struct suite_set *suite_set,
> >         /* Parse attribute filters */
> >         if (filters) {
> >                 filter_count =3D kunit_get_filter_count(filters);
> > -               parsed_filters =3D kcalloc(filter_count + 1, sizeof(*pa=
rsed_filters), GFP_KERNEL);
> > +               parsed_filters =3D kcalloc(filter_count, sizeof(*parsed=
_filters), GFP_KERNEL);
> > +               if (!parsed_filters) {
> > +                       kfree(copy);
> > +                       return filtered;
>
> Is 'filtered' properly initialised here?
> filtered.start is already set to 'copy' by this point (so, having
> freed 'copy', this would now be an invalid pointer).
> filtered.end is uninitialised.
>
> Can we instead initialise filtered to {NULL, NULL} at the start, and
> only set start and end after the filtering has succeeded?
>
> > +               }
> >                 for (j =3D 0; j < filter_count; j++)
> >                         parsed_filters[j] =3D kunit_next_attr_filter(&f=
ilters, err);
> >                 if (*err)
> > @@ -166,7 +170,7 @@ static struct suite_set kunit_filter_suites(const s=
truct suite_set *suite_set,
> >                                 goto err;
> >                         }
> >                 }
> > -               if (filter_count) {
> > +               if (filter_count > 0 && parsed_filters !=3D NULL) {
> >                         for (k =3D 0; k < filter_count; k++) {
> >                                 new_filtered_suite =3D kunit_filter_att=
r_tests(filtered_suite,
> >                                                 parsed_filters[k], filt=
er_action, err);
> >
> > base-commit: 3bffe185ad11e408903d2782727877388d08d94e
> > --
> > 2.41.0.585.gd2178a4bd4-goog
> >
