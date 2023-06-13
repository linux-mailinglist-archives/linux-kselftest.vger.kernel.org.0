Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4779A72ED3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 22:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbjFMUmb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 16:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbjFMUmb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 16:42:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBEFE59
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 13:42:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-513ea2990b8so3813a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686688947; x=1689280947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt0sT3PFP1cG1jHWeHr+qSJ4GVDfUWLNh/byl46lxgQ=;
        b=dTxxrWfFOzqCHjmwW4EE8LBW2m/S6S7jXKW1fs41Dh5sLvpvIUi4dRH1gGtKpwI+a/
         t2Gjx4hSVDRZwWaL7UzuSGEDoJx9MwN5eF3n/gEWgH5KkWu6Ly+Z8OM5hA5cNVM5S2H2
         4/jFKhm8oLX0JIZ8Vb3/Uzdh7sVAUPbLBShImP/NCxqXZ5uFDsQSzbe1FfOeiPwVHlJJ
         S+i/WiJuh27MA78B/B8kIB3bBg48wXA7xx0FRlyQJSIX1COAmvXIVZsQikJoGm4nj744
         EmzMJ1J2fNVcVXvg0bwWMXNnIMfKaxIxEUtQBs2oIwKDfgHTRwpSS70GNRO6lnCsD24I
         Ctsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688947; x=1689280947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zt0sT3PFP1cG1jHWeHr+qSJ4GVDfUWLNh/byl46lxgQ=;
        b=ItK0UodqgJyxW5dr9/RF8VkyZYGhUw+BDpOOD5md3anLGuyhsENhIttHmO++/ZfC/k
         nxjm7FqpgaSkEV0qavDueqDZkDj+hgNK12Fsgx4uLXtoZ22sPMxTFam5vse9+sJIFtb8
         oZGYDpqu4Vtvgad4JFAAoawGQ5AN3vaftJL5ezl6uSSTk9t1EGvQWDbsBUE4akiP01Pl
         dOREfds0ZUl8yfUhWP0a3Idbk+6uU+4RIDoPQ3TBmqR+AIko9/+QEV4RfbAZSBpD92Xe
         UrvDeKbzhbEuBpyLK3YtDA32K3xQHlEDGu+uMzN7oV5Akx2Wq9xCZjAeG4ZttbBPK5Id
         CvgA==
X-Gm-Message-State: AC+VfDwnuN8AoUGr4C/nE+43GHLGW5O4SJFPnAuMktvK0enHApQUSLkk
        jyxwyYggyyjEQvXB/ncC+suDGlCp+X4GEJU1YA8U0g==
X-Google-Smtp-Source: ACHHUZ6PoYnPrWWK/OU8Ml4a3n5hR47Iju9lXBQRkQzKHEpOnVzg/V1yzun1E28NwNnAjOjHKwbEQXycfViFvBEV8HE=
X-Received: by 2002:a50:ab0b:0:b0:514:95d4:c2bb with SMTP id
 s11-20020a50ab0b000000b0051495d4c2bbmr28130edc.2.1686688946743; Tue, 13 Jun
 2023 13:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com> <20230610005149.1145665-4-rmoar@google.com>
 <CABVgOSmf=4v0jPdgEor-vrsr4YiEn_0wR4Xv+z_jobBT1SaVEQ@mail.gmail.com>
In-Reply-To: <CABVgOSmf=4v0jPdgEor-vrsr4YiEn_0wR4Xv+z_jobBT1SaVEQ@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 13 Jun 2023 16:42:15 -0400
Message-ID: <CA+GJov4b4pP2WfRzcPBeCdD8QudZWtjanO_7Z3TqP85xMUVg3w@mail.gmail.com>
Subject: Re: [RFC v1 3/6] kunit: Add ability to filter attributes
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 10, 2023 at 4:29=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 10 Jun 2023 at 08:52, Rae Moar <rmoar@google.com> wrote:
> >
> > Add filtering of test attributes. Users can filter tests using a
> > module_param_array called "filter". This functionality will be added to
> > kunit.py in the next patch.
> >
> > The filters will be imputed in the format:
> > "<attribute_name><operation><attribute_value>"
> >
> > Example: "speed>slow"
>
> Maybe give a full command-line example of "kunit.filter=3Dspeed>slow"?
>

Hello,

Yes I will add that in the next version.

> >
> > Operations include: >, <, >=3D, <=3D, !=3D, and =3D. These operations d=
o not need
> > to act the same for every attribute.
>
> I assume here that operations should act the same for attributes of
> the same type, but a string attribute might behave differently from an
> int, an enum, an array, etc.
>
> As a design principle, I think we definitely want the same operation
> to act the same way between different attributes, unless there's an
> extraordinarily good reason.
>

This is a mistake on my end. I should clarify that operations should
act the same for attributes of the same type but then may differ
between the types (like ints and strings).

> >
> > Add method to parse inputted filters.
> >
> > Add the process of filtering tests based on attributes. The process of
> > filtering follows these rules:
> >
> > A test case with a set attribute overrides its parent suite's attribute
> > during filtering.
> >
> > Also, if both the test case attribute and suite attribute are unset the
> > test acts as the default attribute value during filtering.
>
> This behaviour probably needs to be documented more clearly in the
> final version.
>
> As I understand it:
> - Both tests and suites have attributes.
> - Filtering always operates at a per-test level.
> - If a test has an attribute set, then the test's value is filtered on.
> - Otherwise, the value falls back to the suite's value.
> - If neither are set, the attribute has a global "default" value, which i=
s used.
> - If an entire suite is filtered out, it's removed, giving the
> appearance that filtering can operate on a suite level.
>

Yes, this is a great description of how it should behave. I will be
more explicit in my description for the next version.

> I actually quite like these rules, but we do need to document them.
> I'd perhaps argue that the "default attribute" could be done away with
> and we just rely on the filter function choosing whether or not
> "unset" matches a filter or not, but on the other hand, it does make
> reusing filter functions potentially easier.
>

This is true I could do away with the default. However, I do think it
helps to document how an unset attribute acts.

It may seem more unclear why an unset attribute is filtered out for
speed<=3Dslow but not speed>slow. But this could then be documented
separate from the code.

I'm leaning toward keeping it but let me know what you think.

> >
> > Finally, add a "filter" method for the speed attribute to parse and com=
pare
> > enum values of kunit_speed.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> One other idea: do we want filtered-out tests to totally disappear (as
> this patch does), to mark them as skipped (potentially useful, too),
> or have configurable behaviour.
>
> I think there are good reasons for each of those: having them totally
> disappear is much cleaner, but it's also useful to see what tests
> you're actually, well, skipping.

I like this idea a lot. I also really like the idea of this being a
configurable behavior.

>
> >  include/kunit/attributes.h |  22 +++++
> >  lib/kunit/attributes.c     | 172 +++++++++++++++++++++++++++++++++++++
> >  lib/kunit/executor.c       |  79 +++++++++++++----
> >  lib/kunit/executor_test.c  |   8 +-
> >  4 files changed, 258 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
> > index 9fcd184cce36..bca60d1181bb 100644
> > --- a/include/kunit/attributes.h
> > +++ b/include/kunit/attributes.h
> > @@ -9,6 +9,15 @@
> >  #ifndef _KUNIT_ATTRIBUTES_H
> >  #define _KUNIT_ATTRIBUTES_H
> >
> > +/*
> > + * struct kunit_attr_filter - representation of attributes filter with=
 the
> > + * attribute object and string input
> > + */
> > +struct kunit_attr_filter {
> > +       struct kunit_attr *attr;
> > +       char *input;
> > +};
> > +
> >  /*
> >   * Print all test attributes for a test case or suite.
> >   * Output format for test cases: "# <test_name>.<attribute>: <value>"
> > @@ -16,4 +25,17 @@
> >   */
> >  void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int =
test_level);
> >
> > +/*
> > + * Parse attributes filter input and return an object containing the a=
ttribute
> > + * object and the string input.
> > + */
> > +struct kunit_attr_filter kunit_parse_filter_attr(char *input, int *err=
);
>
> Should we rename this kunit_parse_attr_filter, as it returns a
> kunit_attr_filter?
>

I will change this. I think that is cleaner.

> > +
> > +
> > +/*
> > + * Returns a copy of the suite containing only tests that pass the fil=
ter.
> > + */
> > +struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *=
const suite,
> > +               struct kunit_attr_filter filter, int *err);
> > +
> >  #endif /* _KUNIT_ATTRIBUTES_H */
> > diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> > index e17889f94693..4f753a28e4ee 100644
> > --- a/lib/kunit/attributes.c
> > +++ b/lib/kunit/attributes.c
> > @@ -49,6 +49,66 @@ static const char *attr_speed_to_string(void *attr, =
bool *to_free)
> >         return attr_enum_to_string(attr, speed_str_list, to_free);
> >  }
> >
> > +/* Filter Methods */
> > +
> > +static int int_filter(long val, const char *op, int input, int *err)
> > +{
> > +       if (!strncmp(op, "<=3D", 2))
> > +               return (val <=3D input);
> > +       else if (!strncmp(op, ">=3D", 2))
> > +               return (val >=3D input);
> > +       else if (!strncmp(op, "!=3D", 2))
> > +               return (val !=3D input);
> > +       else if (!strncmp(op, ">", 1))
> > +               return (val > input);
> > +       else if (!strncmp(op, "<", 1))
> > +               return (val < input);
> > +       else if (!strncmp(op, "=3D", 1))
> > +               return (val =3D=3D input);
> > +       *err =3D -EINVAL;
> > +       pr_err("kunit executor: invalid filter operation: %s\n", op);
> > +       return false;
> > +}
> > +
> > +static int attr_enum_filter(void *attr, const char *input, int *err,
> > +               const char * const str_list[], int max)
>
> As this is a generic helper function to be used by multiple types of
> attributes, let's document it a bit.

Sounds great. I will add documentation here.

>
> > +{
> > +       int i, j, input_int;
> > +       long test_val =3D (long)attr;
> > +       const char *input_val;
> > +
> > +       for (i =3D 0; input[i]; i++) {
> > +               if (!strchr("<!=3D>", input[i])) {
>
> Can we yoink this string of "operation characters" into a global or
> #define or something, as it recurs a few times here, and it'd be best
> to only have it in one place.

Right, that sounds good. I will change this.

>
> > +                       input_val =3D input + i;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (!input_val) {
> > +               *err =3D -EINVAL;
> > +               pr_err("kunit executor: filter operation not found: %s\=
n", input);
> > +               return false;
> > +       }
> > +
> > +       for (j =3D 0; j <=3D max; j++) {
> > +               if (!strcmp(input_val, str_list[j]))
> > +                       input_int =3D j;
> > +       }
> > +
> > +       if (!input_int) {
> > +               *err =3D -EINVAL;
> > +               pr_err("kunit executor: invalid filter input: %s\n", in=
put);
> > +               return false;
> > +       }
> > +
> > +       return int_filter(test_val, input, input_int, err);
> > +}
> > +
> > +static int attr_speed_filter(void *attr, const char *input, int *err)
> > +{
> > +       return attr_enum_filter(attr, input, err, speed_str_list, KUNIT=
_SPEED_MAX);
> > +}
> > +
> >  /* Get Attribute Methods */
> >
> >  static void *attr_speed_get(void *test_or_suite, bool is_test)
> > @@ -68,6 +128,7 @@ static const struct kunit_attr speed_attr =3D {
> >         .name =3D "speed",
> >         .get_attr =3D attr_speed_get,
> >         .to_string =3D attr_speed_to_string,
> > +       .filter =3D attr_speed_filter,
> >         .attr_default =3D (void *)KUNIT_SPEED_NORMAL,
> >  };
> >
> > @@ -106,3 +167,114 @@ void kunit_print_attr(void *test_or_suite, bool i=
s_test, unsigned int test_level
> >                 }
> >         }
> >  }
> > +
> > +/* Helper Functions to Filter Attributes */
> > +
> > +struct kunit_attr_filter kunit_parse_filter_attr(char *input, int *err=
)
> > +{
> > +       struct kunit_attr_filter filter;
> > +       int i, j, op_index =3D 0;
> > +       int attr_index =3D -1;
> > +       char op;
> > +
> > +       /* Parse input until operation */
> > +       for (i =3D 0; input[i]; i++) {
> > +               if (strchr("<>!=3D", input[i])) {
> > +                       op_index =3D i;
> > +                       break;
> > +               }
> > +               if (input[i] =3D=3D ' ')
> > +                       break;
> > +       }
> > +
> > +       if (!op_index) {
> > +               *err =3D -EINVAL;
> > +               pr_err("kunit executor: filter operation not found: %s\=
n", input);
> > +               return filter;
> > +       }
> > +
> > +       op =3D input[op_index];
> > +       input[op_index] =3D '\0';
> > +
> > +       /* Find associated kunit_attr object */
> > +       for (j =3D 0; j < ARRAY_SIZE(kunit_attr_list); j++) {
> > +               if (!strcmp(input, kunit_attr_list[j].name)) {
> > +                       attr_index =3D j;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       input[op_index] =3D op;
> > +       filter.input =3D input + op_index;
> > +
> > +       if (attr_index < 0) {
> > +               *err =3D -EINVAL;
> > +               pr_err("kunit executor: attribute not found: %s\n", inp=
ut);
> > +       } else {
> > +               filter.attr =3D &kunit_attr_list[attr_index];
> > +       }
> > +
> > +       return filter;
> > +}
> > +
> > +struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *=
const suite,
> > +               struct kunit_attr_filter filter, int *err)
> > +{
> > +       int n =3D 0;
> > +       struct kunit_case *filtered, *test_case;
> > +       struct kunit_suite *copy;
> > +       void *suite_val, *test_val;
> > +       bool suite_result, test_result, default_result;
> > +
> > +       /* Allocate memory for new copy of suite and list of test cases=
 */
> > +       copy =3D kmemdup(suite, sizeof(*copy), GFP_KERNEL);
> > +       if (!copy)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       kunit_suite_for_each_test_case(suite, test_case) { n++; }
> > +
> > +       filtered =3D kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
> > +       if (!filtered) {
> > +               kfree(copy);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +
> > +       n =3D 0;
> > +
> > +       /* Save filtering result on default value */
> > +       default_result =3D filter.attr->filter(filter.attr->attr_defaul=
t, filter.input, err);
> > +
> > +       /* Save suite attribute value and filtering result on that valu=
e */
> > +       suite_val =3D filter.attr->get_attr((void *)suite, false);
> > +       suite_result =3D filter.attr->filter(suite_val, filter.input, e=
rr);
> > +
> > +       /* For each test case, save test case if passes filtering. */
> > +       kunit_suite_for_each_test_case(suite, test_case) {
> > +               test_val =3D filter.attr->get_attr((void *) test_case, =
true);
> > +               test_result =3D filter.attr->filter(filter.attr->get_at=
tr(test_case, true),
> > +                               filter.input, err);
> > +               /*
> > +                * If attribute value of test case is set, filter on th=
at value.
> > +                * If not, filter on suite value if set. If not, filter=
 on
> > +                * default value.
> > +                */
> > +               if (test_val) {
> > +                       if (test_result)
> > +                               filtered[n++] =3D *test_case;
> > +               } else if (suite_val) {
> > +                       if (suite_result)
> > +                               filtered[n++] =3D *test_case;
> > +               } else if (default_result) {
> > +                       filtered[n++] =3D *test_case;
> > +               }
> > +       }
> > +
> > +       if (n =3D=3D 0) {
> > +               kfree(copy);
> > +               kfree(filtered);
> > +               return NULL;
> > +       }
> > +
> > +       copy->test_cases =3D filtered;
> > +       return copy;
> > +}
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 767a84e32f06..c67657821eec 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -15,8 +15,12 @@ extern struct kunit_suite * const __kunit_suites_end=
[];
> >
> >  #if IS_BUILTIN(CONFIG_KUNIT)
> >
> > +#define MAX_FILTERS 10 // Limit of number of attribute filters
> >  static char *filter_glob_param;
> >  static char *action_param;
> > +static int filter_count;
> > +static char *filter_param[MAX_FILTERS];
> > +
> >
> >  module_param_named(filter_glob, filter_glob_param, charp, 0);
> >  MODULE_PARM_DESC(filter_glob,
> > @@ -26,15 +30,16 @@ MODULE_PARM_DESC(action,
> >                  "Changes KUnit executor behavior, valid values are:\n"
> >                  "<none>: run the tests like normal\n"
> >                  "'list' to list test names instead of running them.\n"=
);
> > +module_param_array_named(filter, filter_param, charp, &filter_count, 0=
);
> >
> >  /* glob_match() needs NULL terminated strings, so we need a copy of fi=
lter_glob_param. */
> > -struct kunit_test_filter {
> > +struct kunit_glob_filter {
> >         char *suite_glob;
> >         char *test_glob;
> >  };
> >
> >  /* Split "suite_glob.test_glob" into two. Assumes filter_glob is not e=
mpty. */
> > -static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
> > +static void kunit_parse_filter_glob(struct kunit_glob_filter *parsed,
> >                                     const char *filter_glob)
> >  {
> >         const int len =3D strlen(filter_glob);
> > @@ -56,7 +61,7 @@ static void kunit_parse_filter_glob(struct kunit_test=
_filter *parsed,
> >
> >  /* Create a copy of suite with only tests that match test_glob. */
> >  static struct kunit_suite *
> > -kunit_filter_tests(const struct kunit_suite *const suite, const char *=
test_glob)
> > +kunit_filter_glob_tests(const struct kunit_suite *const suite, const c=
har *test_glob)
> >  {
> >         int n =3D 0;
> >         struct kunit_case *filtered, *test_case;
> > @@ -110,12 +115,15 @@ static void kunit_free_suite_set(struct suite_set=
 suite_set)
> >
> >  static struct suite_set kunit_filter_suites(const struct suite_set *su=
ite_set,
> >                                             const char *filter_glob,
> > +                                               char **filters,
> > +                                               int filter_count,
> >                                             int *err)
> >  {
> > -       int i;
> > -       struct kunit_suite **copy, *filtered_suite;
> > +       int i, j, k;
> > +       struct kunit_suite **copy, *filtered_suite, *new_filtered_suite=
;
> >         struct suite_set filtered;
> > -       struct kunit_test_filter filter;
> > +       struct kunit_glob_filter parsed_glob;
> > +       struct kunit_attr_filter parsed_filters[MAX_FILTERS];
> >
> >         const size_t max =3D suite_set->end - suite_set->start;
> >
> > @@ -126,17 +134,49 @@ static struct suite_set kunit_filter_suites(const=
 struct suite_set *suite_set,
> >                 return filtered;
> >         }
> >
> > -       kunit_parse_filter_glob(&filter, filter_glob);
> > +       if (filter_glob)
> > +               kunit_parse_filter_glob(&parsed_glob, filter_glob);
> >
> > -       for (i =3D 0; &suite_set->start[i] !=3D suite_set->end; i++) {
> > -               if (!glob_match(filter.suite_glob, suite_set->start[i]-=
>name))
> > -                       continue;
> > +       /* Parse attribute filters */
> > +       if (filter_count) {
> > +               for (j =3D 0; j < filter_count; j++) {
> > +                       parsed_filters[j] =3D kunit_parse_filter_attr(f=
ilters[j], err);
> > +                       if (*err)
> > +                               return filtered;
> > +               }
> > +       }
> >
> > -               filtered_suite =3D kunit_filter_tests(suite_set->start[=
i], filter.test_glob);
> > -               if (IS_ERR(filtered_suite)) {
> > -                       *err =3D PTR_ERR(filtered_suite);
> > -                       return filtered;
> > +       for (i =3D 0; &suite_set->start[i] !=3D suite_set->end; i++) {
> > +               filtered_suite =3D suite_set->start[i];
> > +               if (filter_glob) {
> > +                       if (!glob_match(parsed_glob.suite_glob, filtere=
d_suite->name))
> > +                               continue;
> > +                       filtered_suite =3D kunit_filter_glob_tests(filt=
ered_suite,
> > +                                       parsed_glob.test_glob);
> > +                       if (IS_ERR(filtered_suite)) {
> > +                               *err =3D PTR_ERR(filtered_suite);
> > +                               return filtered;
> > +                       }
> >                 }
> > +               if (filter_count) {
> > +                       for (k =3D 0; k < filter_count; k++) {
> > +                               new_filtered_suite =3D kunit_filter_att=
r_tests(filtered_suite,
> > +                                               parsed_filters[k], err)=
;
> > +
> > +                               /* Free previous copy of suite */
> > +                               if (k > 0 || filter_glob)
> > +                                       kfree(filtered_suite);
> > +                               filtered_suite =3D new_filtered_suite;
> > +
> > +                               if (*err)
> > +                                       return filtered;
> > +                               if (IS_ERR(filtered_suite)) {
> > +                                       *err =3D PTR_ERR(filtered_suite=
);
> > +                                       return filtered;
> > +                               }
> > +                       }
> > +               }
> > +
> >                 if (!filtered_suite)
> >                         continue;
> >
> > @@ -144,8 +184,8 @@ static struct suite_set kunit_filter_suites(const s=
truct suite_set *suite_set,
> >         }
> >         filtered.end =3D copy;
> >
> > -       kfree(filter.suite_glob);
> > -       kfree(filter.test_glob);
> > +       kfree(parsed_glob.suite_glob);
> > +       kfree(parsed_glob.test_glob);
> >         return filtered;
> >  }
> >
> > @@ -203,8 +243,9 @@ int kunit_run_all_tests(void)
> >                 goto out;
> >         }
> >
> > -       if (filter_glob_param) {
> > -               suite_set =3D kunit_filter_suites(&suite_set, filter_gl=
ob_param, &err);
> > +       if (filter_glob_param || filter_count) {
> > +               suite_set =3D kunit_filter_suites(&suite_set, filter_gl=
ob_param,
> > +                               filter_param, filter_count, &err);
> >                 if (err) {
> >                         pr_err("kunit executor: error filtering suites:=
 %d\n", err);
> >                         goto out;
> > @@ -218,7 +259,7 @@ int kunit_run_all_tests(void)
> >         else
> >                 pr_err("kunit executor: unknown action '%s'\n", action_=
param);
> >
> > -       if (filter_glob_param) { /* a copy was made of each suite */
> > +       if (filter_glob_param || filter_count) { /* a copy was made of =
each suite */
> >                 kunit_free_suite_set(suite_set);
> >         }
> >
> > diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> > index ce6749af374d..4c8cb46857b2 100644
> > --- a/lib/kunit/executor_test.c
> > +++ b/lib/kunit/executor_test.c
> > @@ -24,7 +24,7 @@ static struct kunit_case dummy_test_cases[] =3D {
> >
> >  static void parse_filter_test(struct kunit *test)
> >  {
> > -       struct kunit_test_filter filter =3D {NULL, NULL};
> > +       struct kunit_glob_filter filter =3D {NULL, NULL};
> >
> >         kunit_parse_filter_glob(&filter, "suite");
> >         KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
> > @@ -50,7 +50,7 @@ static void filter_suites_test(struct kunit *test)
> >         subsuite[1] =3D alloc_fake_suite(test, "suite2", dummy_test_cas=
es);
> >
> >         /* Want: suite1, suite2, NULL -> suite2, NULL */
> > -       got =3D kunit_filter_suites(&suite_set, "suite2", &err);
> > +       got =3D kunit_filter_suites(&suite_set, "suite2", NULL, 0, &err=
);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
> >         KUNIT_ASSERT_EQ(test, err, 0);
> >         kfree_at_end(test, got.start);
> > @@ -74,7 +74,7 @@ static void filter_suites_test_glob_test(struct kunit=
 *test)
> >         subsuite[1] =3D alloc_fake_suite(test, "suite2", dummy_test_cas=
es);
> >
> >         /* Want: suite1, suite2, NULL -> suite2 (just test1), NULL */
> > -       got =3D kunit_filter_suites(&suite_set, "suite2.test2", &err);
> > +       got =3D kunit_filter_suites(&suite_set, "suite2.test2", NULL, 0=
, &err);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
> >         KUNIT_ASSERT_EQ(test, err, 0);
> >         kfree_at_end(test, got.start);
> > @@ -100,7 +100,7 @@ static void filter_suites_to_empty_test(struct kuni=
t *test)
> >         subsuite[0] =3D alloc_fake_suite(test, "suite1", dummy_test_cas=
es);
> >         subsuite[1] =3D alloc_fake_suite(test, "suite2", dummy_test_cas=
es);
> >
> > -       got =3D kunit_filter_suites(&suite_set, "not_found", &err);
> > +       got =3D kunit_filter_suites(&suite_set, "not_found", NULL, 0, &=
err);
> >         KUNIT_ASSERT_EQ(test, err, 0);
> >         kfree_at_end(test, got.start); /* just in case */
> >
>
> It'd be nice to add some more tests for attribute filtering specifically =
here.

Yeah, I agree. I will go ahead and add some here.

Thanks for all the comments!
-Rae

>
>
>
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
