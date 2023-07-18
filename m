Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B25C758662
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 23:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjGRVBu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 17:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjGRVBt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 17:01:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA29198C
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 14:01:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f86840c45dso4830e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689714104; x=1692306104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSeAtmxK2ozxMkX1W97pDOi5lgnNWrQJB78BEx5wwuo=;
        b=IjRvNmFtlPn0r3sT+H04vStVCoPlDKQl53ex466GeRQYr+dQIc0x+rwk7noiEB3Jwr
         qZVi8XjAzjA8RtIYeZgVYQVGn2QFog+bPJtVIuI+DNc/uQ4DeS/7sFy370xX/si2+X1Q
         1IrPEBRrTHHyf9vaE+Zo7cHxWi43YUVHDpw7KfxASYnBe9FV9lVT+CbJuceRcMajQpdP
         cTGdjZ8zk/JFYoexzFtZzQaqP2CJWxmU8r8XvosafECB0KRx4sMCIC0775gOiQydn+/m
         aMpOyfj6r1e9W2aTCRpRPIHUcy+3gU8/7TYFhxhdSnwi5xSDoUL6Jj4LI79IVBb3DAHT
         B1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689714104; x=1692306104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSeAtmxK2ozxMkX1W97pDOi5lgnNWrQJB78BEx5wwuo=;
        b=GG8IJFLjnli4oYL78Z8VaM8wqq+ffcej3pT8+OMik+66nezrvxY5/HBClIJpMj2pGb
         wFu9lxLT74Ff38lZGKyVYLVwCY0h0hGI+7Z9et2SyeKJ0SPcaNj/Df916iZOMZ4WZrO7
         okHtTl9rxXaVIJhYzsTEOu2fhTSpwo8yxS8QnliJX/OTceipoXzDlsilgtB81mA7F2fP
         NuODlYoAb1hnqbaPf2vcIcyZk50+EXlADr/r9delXFb/6gERPeSvYJr0sLNUB1+FBcqM
         1+ENWy51h0VjBEYfrOjKCPMTWC4JP7+Li8WfFWVr9YQWPmxheWRXoZcZQ3BF2orMANJr
         B9Nw==
X-Gm-Message-State: ABy/qLbgP1p7LMtiOjFgq+zAxAqzt2WKdK2NfJTzskmD7epeZXnFNWnW
        blw1oOP54ZEQtir91SjPC70sq3n3H+pKQf19fJ3Fjw==
X-Google-Smtp-Source: APBJJlFlVPDF78BNASzD1gAKNvUNQb81r0wEFJnwAIB3I7LO8xrJ5ZkLREIX06Bp7nhPyq3xMX3SU743LX/3XBmJ1iM=
X-Received: by 2002:ac2:4c14:0:b0:4f2:5b90:7ca9 with SMTP id
 t20-20020ac24c14000000b004f25b907ca9mr125185lfq.4.1689714103902; Tue, 18 Jul
 2023 14:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-2-rmoar@google.com>
 <CABVgOSkoKUVHE8=Z0gwsn-SfhgVy8rO62s5mHbfu6GXB54OfWA@mail.gmail.com>
In-Reply-To: <CABVgOSkoKUVHE8=Z0gwsn-SfhgVy8rO62s5mHbfu6GXB54OfWA@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 18 Jul 2023 17:01:30 -0400
Message-ID: <CA+GJov73sM+rfYXopfdwBtVcwNJhmqAB3b7dOe6NBh47Mxukgg@mail.gmail.com>
Subject: Re: [RFC v2 1/9] kunit: Add test attributes API structure
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 18, 2023 at 3:39=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 8 Jul 2023 at 05:09, Rae Moar <rmoar@google.com> wrote:
> >
> > Add the basic structure of the test attribute API to KUnit, which can b=
e
> > used to save and access test associated data.
> >
> > Add attributes.c and attributes.h to hold associated structs and functi=
ons
> > for the API.
> >
> > Create a struct that holds a variety of associated helper functions for
> > each test attribute. These helper functions will be used to get the
> > attribute value, convert the value to a string, and filter based on the
> > value. This struct is flexible by design to allow for attributes of
> > numerous types and contexts.
> >
> > Add a method to print test attributes in the format of "# [<test_name i=
f
> > not suite>.]<attribute_name>: <attribute_value>".
> >
> > Example for a suite: "# speed: slow"
> >
> > Example for a test case: "# test_case.speed: very_slow"
>
> So, this is the one thing I'm a little unsure about here, and it's
> really more of a problem with test names overall.
>
> As noted in the KTAPv2 attributes and test name proposals, the names
> and attributes are only really defined for "suites", hence the need to
> have a different output format for test cases.
>
> Personally, I'd prefer to keep the formats the same if we can (at
> least for the actual KTAP output; I'm less concerned with the
> list_attr option). That might make things a bit more difficult to
> parse, though.
>
> One possibility would be to combine the KTAP attributes and test name
> specs and suggest that every test has a "test name" attribute, which
> must be the first attribute output.
>
> The output would then look something like:
> KTAP version 2
> # Name: my_suite
> # Other-Attr: value
> 1..2
>   KTAP version 2
>   # Name: test_1
>   # Other-Attr: value
>   ok 1 test_1
>   # Name: test_2
>   # Other-Attr: value
>   not ok 2 test_2
> ok 1 my_suite
>
> Would there be any problems with something like that?
>
> I'm less concerned with the list_attr option, as that's not something
> totally standardised in the way KTAP is.
>

This is a really interesting idea. I like that this standardizes the
concept of KTAP test metadata for both test suites and test cases. I
would love to discuss this concept further as KTAP v2 is developed.

My main concern would be that there is push back on stating the test
name when it is already present in the result line. This adds
potentially unnecessary lines to the output. However, one positive to
this is that diagnostic data could be printed under this header which
would reduce any confusion for which test the diagnostic data refers
to.

I would be interested if anyone else has any opinions on this.

> >
> > Use this method to report attributes in the KTAP output (KTAP spec:
> > https://docs.kernel.org/dev-tools/ktap.html) and _list_tests output whe=
n
> > kernel's new kunit.action=3Dlist_attr option is used. Note this is deri=
vative
> > of the kunit.action=3Dlist option.
> >
> > In test.h, add fields and associated helper functions to test cases and
> > suites to hold user-inputted test attributes.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> The only other thing I'd really like to support one day is having
> attributes for individual parameters in parameterised tests. I think
> it makes sense as a follow-up, though.
>

That is an exciting idea! I think that would be ideal as a follow-up.

> >
> > Changes since v1:
> > - Add list_attr option to only include attribute in the _list_tests out=
put
> >   when this module param is set
> > - Add printing options for attributes to print always, print only for
> >   suites, or print never.
> >
> >  include/kunit/attributes.h | 19 +++++++++
> >  include/kunit/test.h       | 33 ++++++++++++++++
> >  lib/kunit/Makefile         |  3 +-
> >  lib/kunit/attributes.c     | 80 ++++++++++++++++++++++++++++++++++++++
> >  lib/kunit/executor.c       | 21 ++++++++--
> >  lib/kunit/test.c           | 17 ++++----
> >  6 files changed, 161 insertions(+), 12 deletions(-)
> >  create mode 100644 include/kunit/attributes.h
> >  create mode 100644 lib/kunit/attributes.c
> >
> > diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
> > new file mode 100644
> > index 000000000000..9fcd184cce36
> > --- /dev/null
> > +++ b/include/kunit/attributes.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * KUnit API to save and access test attributes
> > + *
> > + * Copyright (C) 2023, Google LLC.
> > + * Author: Rae Moar <rmoar@google.com>
> > + */
> > +
> > +#ifndef _KUNIT_ATTRIBUTES_H
> > +#define _KUNIT_ATTRIBUTES_H
> > +
> > +/*
> > + * Print all test attributes for a test case or suite.
> > + * Output format for test cases: "# <test_name>.<attribute>: <value>"
> > + * Output format for test suites: "# <attribute>: <value>"
> > + */
> > +void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int =
test_level);
> > +
> > +#endif /* _KUNIT_ATTRIBUTES_H */
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 23120d50499e..1fc9155988e9 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -63,12 +63,16 @@ enum kunit_status {
> >         KUNIT_SKIPPED,
> >  };
> >
> > +/* Holds attributes for each test case and suite */
> > +struct kunit_attributes {};
>
> Do we want a separate set of attributes for test cases and suites?
> (I think probably not, but it's worth making sure.)
>

I'm thinking if our goal is to eventually move to arbitrary nesting
for tests it would be easiest to try to keep this list the same. But I
agree. There may definitely be attributes that are more applicable for
test cases or suites. I'm inclined to keep it this way.

> > +
> >  /**
> >   * struct kunit_case - represents an individual test case.
> >   *
> >   * @run_case: the function representing the actual test case.
> >   * @name:     the name of the test case.
> >   * @generate_params: the generator function for parameterized tests.
> > + * @attr:     the attributes associated with the test
> >   *
> >   * A test case is a function with the signature,
> >   * ``void (*)(struct kunit *)``
> > @@ -104,6 +108,7 @@ struct kunit_case {
> >         void (*run_case)(struct kunit *test);
> >         const char *name;
> >         const void* (*generate_params)(const void *prev, char *desc);
> > +       struct kunit_attributes attr;
> >
> >         /* private: internal use only. */
> >         enum kunit_status status;
> > @@ -133,6 +138,18 @@ static inline char *kunit_status_to_ok_not_ok(enum=
 kunit_status status)
> >   */
> >  #define KUNIT_CASE(test_name) { .run_case =3D test_name, .name =3D #te=
st_name }
> >
> > +/**
> > + * KUNIT_CASE_ATTR - A helper for creating a &struct kunit_case
> > + * with attributes
> > + *
> > + * @test_name: a reference to a test case function.
> > + * @attributes: a reference to a struct kunit_attributes object contai=
ning
> > + * test attributes
> > + */
> > +#define KUNIT_CASE_ATTR(test_name, attributes)                 \
> > +               { .run_case =3D test_name, .name =3D #test_name,    \
> > +                 .attr =3D attributes }
> > +
> >  /**
> >   * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct ku=
nit_case
> >   *
> > @@ -154,6 +171,20 @@ static inline char *kunit_status_to_ok_not_ok(enum=
 kunit_status status)
> >                 { .run_case =3D test_name, .name =3D #test_name,    \
> >                   .generate_params =3D gen_params }
> >
> > +/**
> > + * KUNIT_CASE_PARAM_ATTR - A helper for creating a parameterized &stru=
ct
> > + * kunit_case with attributes
> > + *
> > + * @test_name: a reference to a test case function.
> > + * @gen_params: a reference to a parameter generator function.
> > + * @attributes: a reference to a struct kunit_attributes object contai=
ning
> > + * test attributes
> > + */
> > +#define KUNIT_CASE_PARAM_ATTR(test_name, gen_params, attributes)      =
 \
> > +               { .run_case =3D test_name, .name =3D #test_name,    \
> > +                 .generate_params =3D gen_params,                     =
           \
> > +                 .attr =3D attributes }
> > +
>
> I do worry a bit that we'll end up with a huge list of variants of the
> KUNIT_CASE_* macros if we start adding more things here. I can't think
> of a better way to handle it at the moment, though.
>
>

I agree. If this becomes an issue, this could be a follow up change?

>
> >  /**
> >   * struct kunit_suite - describes a related collection of &struct kuni=
t_case
> >   *
> > @@ -163,6 +194,7 @@ static inline char *kunit_status_to_ok_not_ok(enum =
kunit_status status)
> >   * @init:      called before every test case.
> >   * @exit:      called after every test case.
> >   * @test_cases:        a null terminated array of test cases.
> > + * @attr:      the attributes associated with the test suite
> >   *
> >   * A kunit_suite is a collection of related &struct kunit_case s, such=
 that
> >   * @init is called before every test case and @exit is called after ev=
ery
> > @@ -182,6 +214,7 @@ struct kunit_suite {
> >         int (*init)(struct kunit *test);
> >         void (*exit)(struct kunit *test);
> >         struct kunit_case *test_cases;
> > +       struct kunit_attributes attr;
> >
> >         /* private: internal use only */
> >         char status_comment[KUNIT_STATUS_COMMENT_SIZE];
> > diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> > index cb417f504996..46f75f23dfe4 100644
> > --- a/lib/kunit/Makefile
> > +++ b/lib/kunit/Makefile
> > @@ -6,7 +6,8 @@ kunit-objs +=3D                           test.o \
> >                                         string-stream.o \
> >                                         assert.o \
> >                                         try-catch.o \
> > -                                       executor.o
> > +                                       executor.o \
> > +                                       attributes.o
> >
> >  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
> >  kunit-objs +=3D                          debugfs.o
> > diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> > new file mode 100644
> > index 000000000000..9bda5a5f4030
> > --- /dev/null
> > +++ b/lib/kunit/attributes.c
> > @@ -0,0 +1,80 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit API to save and access test attributes
> > + *
> > + * Copyright (C) 2023, Google LLC.
> > + * Author: Rae Moar <rmoar@google.com>
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <kunit/attributes.h>
> > +
> > +/* Options for printing attributes:
> > + * PRINT_ALWAYS - attribute is printed for every test case and suite i=
f set
> > + * PRINT_SUITE - attribute is printed for every suite if set but not f=
or test cases
> > + * PRINT_NEVER - attribute is never printed
> > + */
> > +enum print_ops {
> > +       PRINT_ALWAYS,
> > +       PRINT_SUITE,
> > +       PRINT_NEVER,
> > +};
> > +
> > +/**
> > + * struct kunit_attr - represents a test attribute and holds flexible
> > + * helper functions to interact with attribute.
> > + *
> > + * @name: name of test attribute, eg. speed
> > + * @get_attr: function to return attribute value given a test
> > + * @to_string: function to return string representation of given
> > + * attribute value
> > + * @filter: function to indicate whether a given attribute value passe=
s a
> > + * filter
> > + */
> > +struct kunit_attr {
> > +       const char *name;
> > +       void *(*get_attr)(void *test_or_suite, bool is_test);
> > +       const char *(*to_string)(void *attr, bool *to_free);
> > +       int (*filter)(void *attr, const char *input, int *err);
> > +       void *attr_default;
> > +       enum print_ops print;
> > +};
> > +
> > +/* List of all Test Attributes */
> > +
> > +static struct kunit_attr kunit_attr_list[] =3D {};
> > +
> > +/* Helper Functions to Access Attributes */
> > +
> > +void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int =
test_level)
> > +{
> > +       int i;
> > +       bool to_free;
> > +       void *attr;
> > +       const char *attr_name, *attr_str;
> > +       struct kunit_suite *suite =3D is_test ? NULL : test_or_suite;
> > +       struct kunit_case *test =3D is_test ? test_or_suite : NULL;
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(kunit_attr_list); i++) {
> > +               if (kunit_attr_list[i].print =3D=3D PRINT_NEVER ||
> > +                               (test && kunit_attr_list[i].print =3D=
=3D PRINT_SUITE))
> > +                       continue;
> > +               attr =3D kunit_attr_list[i].get_attr(test_or_suite, is_=
test);
> > +               if (attr) {
> > +                       attr_name =3D kunit_attr_list[i].name;
> > +                       attr_str =3D kunit_attr_list[i].to_string(attr,=
 &to_free);
> > +                       if (test) {
> > +                               kunit_log(KERN_INFO, test, "%*s# %s.%s:=
 %s",
> > +                                       KUNIT_INDENT_LEN * test_level, =
"", test->name,
> > +                                       attr_name, attr_str);
> > +                       } else {
> > +                               kunit_log(KERN_INFO, suite, "%*s# %s: %=
s",
> > +                                       KUNIT_INDENT_LEN * test_level, =
"", attr_name, attr_str);
> > +                       }
> > +
> > +                       /* Free to_string of attribute if needed */
> > +                       if (to_free)
> > +                               kfree(attr_str);
> > +               }
> > +       }
> > +}
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 74982b83707c..12e38a48a5cc 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -2,6 +2,7 @@
> >
> >  #include <linux/reboot.h>
> >  #include <kunit/test.h>
> > +#include <kunit/attributes.h>
> >  #include <linux/glob.h>
> >  #include <linux/moduleparam.h>
> >
> > @@ -24,7 +25,8 @@ module_param_named(action, action_param, charp, 0);
> >  MODULE_PARM_DESC(action,
> >                  "Changes KUnit executor behavior, valid values are:\n"
> >                  "<none>: run the tests like normal\n"
> > -                "'list' to list test names instead of running them.\n"=
);
> > +                "'list' to list test names instead of running them.\n"
> > +                "'list_attr' to list test names and attributes instead=
 of running them.\n");
> >
> >  /* glob_match() needs NULL terminated strings, so we need a copy of fi=
lter_glob_param. */
> >  struct kunit_test_filter {
> > @@ -172,7 +174,7 @@ static void kunit_exec_run_tests(struct suite_set *=
suite_set)
> >         __kunit_test_suites_init(suite_set->start, num_suites);
> >  }
> >
> > -static void kunit_exec_list_tests(struct suite_set *suite_set)
> > +static void kunit_exec_list_tests(struct suite_set *suite_set, bool in=
clude_attr)
> >  {
> >         struct kunit_suite * const *suites;
> >         struct kunit_case *test_case;
> > @@ -180,10 +182,19 @@ static void kunit_exec_list_tests(struct suite_se=
t *suite_set)
> >         /* Hack: print a ktap header so kunit.py can find the start of =
KUnit output. */
> >         pr_info("KTAP version 1\n");
> >
> > -       for (suites =3D suite_set->start; suites < suite_set->end; suit=
es++)
> > +       for (suites =3D suite_set->start; suites < suite_set->end; suit=
es++) {
> > +               /* Print suite name and suite attributes */
> > +               pr_info("%s\n", (*suites)->name);
> > +               if (include_attr)
> > +                       kunit_print_attr((void *)(*suites), false, 0);
> > +
> > +               /* Print test case name and attributes in suite */
> >                 kunit_suite_for_each_test_case((*suites), test_case) {
> >                         pr_info("%s.%s\n", (*suites)->name, test_case->=
name);
> > +                       if (include_attr)
> > +                               kunit_print_attr((void *)test_case, tru=
e, 0);
> >                 }
> > +       }
> >  }
> >
> >  int kunit_run_all_tests(void)
> > @@ -206,7 +217,9 @@ int kunit_run_all_tests(void)
> >         if (!action_param)
> >                 kunit_exec_run_tests(&suite_set);
> >         else if (strcmp(action_param, "list") =3D=3D 0)
> > -               kunit_exec_list_tests(&suite_set);
> > +               kunit_exec_list_tests(&suite_set, false);
> > +       else if (strcmp(action_param, "list_attr") =3D=3D 0)
> > +               kunit_exec_list_tests(&suite_set, true);
> >         else
> >                 pr_err("kunit executor: unknown action '%s'\n", action_=
param);
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 84e4666555c9..9ee55139ecd1 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -9,6 +9,7 @@
> >  #include <kunit/resource.h>
> >  #include <kunit/test.h>
> >  #include <kunit/test-bug.h>
> > +#include <kunit/attributes.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/moduleparam.h>
> > @@ -168,6 +169,13 @@ size_t kunit_suite_num_test_cases(struct kunit_sui=
te *suite)
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
> >
> > +/* Currently supported test levels */
> > +enum {
> > +       KUNIT_LEVEL_SUITE =3D 0,
> > +       KUNIT_LEVEL_CASE,
> > +       KUNIT_LEVEL_CASE_PARAM,
> > +};
> > +
> >  static void kunit_print_suite_start(struct kunit_suite *suite)
> >  {
> >         /*
> > @@ -181,17 +189,11 @@ static void kunit_print_suite_start(struct kunit_=
suite *suite)
> >         pr_info(KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> >         pr_info(KUNIT_SUBTEST_INDENT "# Subtest: %s\n",
> >                   suite->name);
> > +       kunit_print_attr((void *)suite, false, KUNIT_LEVEL_CASE);
> >         pr_info(KUNIT_SUBTEST_INDENT "1..%zd\n",
> >                   kunit_suite_num_test_cases(suite));
> >  }
> >
> > -/* Currently supported test levels */
> > -enum {
> > -       KUNIT_LEVEL_SUITE =3D 0,
> > -       KUNIT_LEVEL_CASE,
> > -       KUNIT_LEVEL_CASE_PARAM,
> > -};
> > -
> >  static void kunit_print_ok_not_ok(struct kunit *test,
> >                                   unsigned int test_level,
> >                                   enum kunit_status status,
> > @@ -651,6 +653,7 @@ int kunit_run_tests(struct kunit_suite *suite)
> >                         }
> >                 }
> >
> > +               kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_C=
ASE);
> >
> >                 kunit_print_test_stats(&test, param_stats);
> >
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
