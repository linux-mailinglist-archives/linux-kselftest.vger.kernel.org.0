Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B616772ED1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 22:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbjFMUgp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 16:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbjFMUgk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 16:36:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E98919BC
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 13:36:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51400fa347dso3581a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 13:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686688595; x=1689280595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvp9VR53NHMx2Nxwbwha6epkjNmHsrcFhnkId01Oo0w=;
        b=beCOcsGYIxROiL5XAxO1XzUMpzOsANRBocVO/xvektfIJWY51KIR6JMzdJsLWqwrI+
         /1EdSaPwQcYmAxDkaA3FB4YUYFjliszrbHDs5q/p4AhKFgLPor4sR45K8DVG5fojYyU7
         wyIeZcnB4I7bp6sm6GAxEAQRFBbRjpG1cNDY4A9M8rcTptV8TY+LxjHA0pth2NIJRgFi
         uEXub08vswUnTBo+pRSjVTd0tQK7akSED9BJMFnFzi3dl/6ak32eC+VHqRwxEAXbmwZ1
         tXz1BI7nFU06M4/YcO3WcGnTb8mlwpVur+9aUqRY2/trXy875pacsQXj67/JJ8pGsgXZ
         QFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688595; x=1689280595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvp9VR53NHMx2Nxwbwha6epkjNmHsrcFhnkId01Oo0w=;
        b=KyA/uVZ4Xlp0J31Zm5yd/CtrDZC6KEs6yYTLszGhTT72MhE2RKEsTHiOtFH3ChEfbF
         96lHY+3SdMvgS3aDYTUzvN0k2I+ENgI5ECWfIwtEOs0Lpvnr0/FLMx39cDyCZHPFt4vN
         z8N9OIh4ZzdNo5BaPTHp0p4RC+Dm6NbJKGy5seMR5cRnxojq4dBt5Gn3vaT65/eI2jwA
         Vc4LNah0ioyxHwmzwKMctFY/DcXCpB9+xOIhD+r33Se7n5jSUCWmfARhknjQZ44fCWiz
         K1ZetKq/GOBJQtgPDm1WAGMoVuzg42EtHyKU8af1TLDpYzK2G/Gi0npMWuFJpKI51lmU
         rlqw==
X-Gm-Message-State: AC+VfDyOr5C+9n5HQlbf6XpPp6f/4FgQs5DnAOXsFxWhur8PThkv0NGE
        vgtxPXF8I3+Z04+PVfT7ph10Ricay5JEELHiE9Vllg==
X-Google-Smtp-Source: ACHHUZ6BnKLIFHWWTEmcQAa6gHjCULW9tDWGzSsEIcba9Wo8ccTHEPeAlaY3jArVycxwPUZpkF6w9fnLqD7JFhh3xUo=
X-Received: by 2002:a50:cd57:0:b0:50d:bb88:a80c with SMTP id
 d23-20020a50cd57000000b0050dbb88a80cmr22553edj.3.1686688594596; Tue, 13 Jun
 2023 13:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com> <20230610005149.1145665-2-rmoar@google.com>
 <CABVgOS=PS1VAX7KwKE77foM0ZVbenKwJ25uZR1XOUhwwyJ4Ydw@mail.gmail.com>
In-Reply-To: <CABVgOS=PS1VAX7KwKE77foM0ZVbenKwJ25uZR1XOUhwwyJ4Ydw@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 13 Jun 2023 16:36:22 -0400
Message-ID: <CA+GJov45Y2_8Yyg0CJMRkymNKeY_AL0YHedat5JBg893MG=jaw@mail.gmail.com>
Subject: Re: [RFC v1 1/6] kunit: Add test attributes API structure
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
> >
> > Use this method to report attributes in the KTAP output and _list_tests
> > output.
>
> Can we have a link to the draft KTAP spec for this?
>

Here is the link: https://docs.kernel.org/dev-tools/ktap.html. I will
also add a link in the next version.

> Also, by _list_tests, I assume we're talking about the
> kunit.action=3Dlist option. That's been an "internal" feature for the
> kunit script thus far, but kunit.py doesn't use this attribute info
> anywhere yet, apart from to print it out via --list_tests. Maybe we
> should make including the attributes optional, as the raw list of
> tests is currently more useful.
>

Oh this is an interesting idea. I could pass in the option to include
or not include attributes. Maybe the flag could then be
--list_tests_attrs? I could also remove the plain test information in
this new option. However, I do like seeing tests that have no set
attributes in the output. I'll work on this implementation.

> >
> > In test.h, add fields and associated helper functions to test cases and
> > suites to hold user-inputted test attributes.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> >  include/kunit/attributes.h | 19 +++++++++++
> >  include/kunit/test.h       | 33 +++++++++++++++++++
> >  lib/kunit/Makefile         |  3 +-
> >  lib/kunit/attributes.c     | 65 ++++++++++++++++++++++++++++++++++++++
> >  lib/kunit/executor.c       | 10 +++++-
> >  lib/kunit/test.c           | 17 ++++++----
> >  6 files changed, 138 insertions(+), 9 deletions(-)
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
> This is a placeholder as attributes won't be included until patch 2, righ=
t?

Yes, this is just a placeholder until the next patch. Should I add a
temporary comment?

>
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
>
> This is a bit awkward, as the attributes are either entirely unset
> (i.e., zero-initialised), or have to be specified here. I assume the
> plan is to use designated initialisers, e.g.:
> KUNIT_CASE_ATTR(foo_test, {.speed =3D KUNIT_SPEED_SLOW, .flaky =3D true})=
.
>
> That at least makes it reasonably user-friendly, though the whole need
> to make sure zero-initialised values are the defaults is a bit icky.
>

Yeah there seem to be positives and negatives to this approach. If we
allow attributes to be uninitialized, the user experience is slightly
better and it is evident if the attribute is set or not.

However, this results in the negative implication that attributes with
a zero-equivalent value are treated as if they are unset. This results
in requiring enum values to have an unset option at the zero-index
(which I think is a fine solution) and it requires boolean attributes
to allow false values to act as the default (a little bit messier, but
a solution to this is switching booleans to enums when necessary).

>
>
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
> > index 000000000000..0ea641be795f
> > --- /dev/null
> > +++ b/lib/kunit/attributes.c
> > @@ -0,0 +1,65 @@
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
> > +};
> > +
> > +/* List of all Test Attributes */
> > +
> > +static struct kunit_attr kunit_attr_list[1] =3D {};
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
> > index 74982b83707c..767a84e32f06 100644
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
> > @@ -180,10 +181,17 @@ static void kunit_exec_list_tests(struct suite_se=
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
> > +               kunit_print_attr((void *)(*suites), false, 0);
> > +
> > +               /* Print test case name and attributes in suite */
> >                 kunit_suite_for_each_test_case((*suites), test_case) {
> >                         pr_info("%s.%s\n", (*suites)->name, test_case->=
name);
> > +                       kunit_print_attr((void *)test_case, true, 0);
> >                 }
> > +       }
> >  }
> >
> >  int kunit_run_all_tests(void)
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
> > 2.41.0.162.gfafddb0af9-goog
> >
