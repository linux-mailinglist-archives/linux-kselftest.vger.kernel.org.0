Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D608759050
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 10:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjGSIbo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjGSIbg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 04:31:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5151FDB
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 01:31:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so174515e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689755487; x=1690360287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gEBiDOaOyFPjxHtBGm3slicngRSV5fqfeDQDIFLCBwE=;
        b=k3pI9l3u+9cZ4oMNpyfGIf6wpJ//pH7wqWmBna2l1F2W8duYot7lbP2BCClAPuwQir
         KA/MuOTTOH5dfPIdLLgKiLLkHfnN/4vUfsvexc6xiJ8H8t3y3kF5dmBymrJSZqj03evO
         ZW8Y8UIqpXclZGxbOU7VVQcL9EFhsOKM9XNt9lT8zsJRj2K6DQ909fT7CpF+FxAQ4XOp
         OsPEoJXUkhk5jxwW2x1VxdWDCekrAmyXS0GZdhWnczcG37Nsoe8DqW9vjf+pj9+oIMv/
         SjxgZOFuWwD1wxMTLxG2HUFNCTtlJICnG5+j8P8ujt2vpwE6rFVuyjmLKlFbgZ1QCXFD
         wLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689755487; x=1690360287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEBiDOaOyFPjxHtBGm3slicngRSV5fqfeDQDIFLCBwE=;
        b=ArlTWSMhMDqsYORqaxN4IQIzL0C/rrr4GSkb5HSQQXWVYF86fnisPgTDNA7FN94ONr
         AuhD6DO1PWfdh1Oq+pHyn8aJ8pRjzL+DCFHjuG7XC8ycNvBgnurWbh7hOEl4gugA1AcP
         iymhUaYjW50ru6DTai2aqIYGAoslXQ6OYnzh4LZJsj2P0w2GB+gGgLts9d16jiVbKXpC
         sEIRUg5LAFBFBWvgqCQ1FKINXOPp1kT3w4f86+H0n5xNTGDzoSb+N52TS6qw60rUcLj4
         Q19JJVOUCusUPDt4uWCLTIWyY/ccWKsLbawLvifd2bOOGu78eEpOkuJ8mTpSzBEJlFlB
         j0uQ==
X-Gm-Message-State: ABy/qLYyVJ+VHLBaXbiQobrsOm++x3pzVYlMw5S/FAEA1g1CKTd0uaMf
        eIvbxQXo80deyOilmYgMODlaIspQlNhOpZ0j3Fb+Yw==
X-Google-Smtp-Source: APBJJlGOnhehm3ZeWjwy+P5lqqP/SIPdDn42kZQx3wkaS9l/eAlU8uBHKMkG4isi5v0sNlATBK607CD/SzssK7l6ynY=
X-Received: by 2002:a05:600c:5129:b0:3f1:9a3d:4f7f with SMTP id
 o41-20020a05600c512900b003f19a3d4f7fmr185819wms.1.1689755486831; Wed, 19 Jul
 2023 01:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-2-rmoar@google.com>
 <CABVgOSkoKUVHE8=Z0gwsn-SfhgVy8rO62s5mHbfu6GXB54OfWA@mail.gmail.com> <CA+GJov73sM+rfYXopfdwBtVcwNJhmqAB3b7dOe6NBh47Mxukgg@mail.gmail.com>
In-Reply-To: <CA+GJov73sM+rfYXopfdwBtVcwNJhmqAB3b7dOe6NBh47Mxukgg@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Jul 2023 16:31:15 +0800
Message-ID: <CABVgOS=s09xCJYuwA2eVd34E3vCRV=T4f4XgWxLXa6m1k=T4Bw@mail.gmail.com>
Subject: Re: [RFC v2 1/9] kunit: Add test attributes API structure
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000094e7580600d2dbb1"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000094e7580600d2dbb1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Jul 2023 at 05:01, Rae Moar <rmoar@google.com> wrote:
>
> On Tue, Jul 18, 2023 at 3:39=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> >
> > On Sat, 8 Jul 2023 at 05:09, Rae Moar <rmoar@google.com> wrote:
> > >
> > > Add the basic structure of the test attribute API to KUnit, which can=
 be
> > > used to save and access test associated data.
> > >
> > > Add attributes.c and attributes.h to hold associated structs and func=
tions
> > > for the API.
> > >
> > > Create a struct that holds a variety of associated helper functions f=
or
> > > each test attribute. These helper functions will be used to get the
> > > attribute value, convert the value to a string, and filter based on t=
he
> > > value. This struct is flexible by design to allow for attributes of
> > > numerous types and contexts.
> > >
> > > Add a method to print test attributes in the format of "# [<test_name=
 if
> > > not suite>.]<attribute_name>: <attribute_value>".
> > >
> > > Example for a suite: "# speed: slow"
> > >
> > > Example for a test case: "# test_case.speed: very_slow"
> >
> > So, this is the one thing I'm a little unsure about here, and it's
> > really more of a problem with test names overall.
> >
> > As noted in the KTAPv2 attributes and test name proposals, the names
> > and attributes are only really defined for "suites", hence the need to
> > have a different output format for test cases.
> >
> > Personally, I'd prefer to keep the formats the same if we can (at
> > least for the actual KTAP output; I'm less concerned with the
> > list_attr option). That might make things a bit more difficult to
> > parse, though.
> >
> > One possibility would be to combine the KTAP attributes and test name
> > specs and suggest that every test has a "test name" attribute, which
> > must be the first attribute output.
> >
> > The output would then look something like:
> > KTAP version 2
> > # Name: my_suite
> > # Other-Attr: value
> > 1..2
> >   KTAP version 2
> >   # Name: test_1
> >   # Other-Attr: value
> >   ok 1 test_1
> >   # Name: test_2
> >   # Other-Attr: value
> >   not ok 2 test_2
> > ok 1 my_suite
> >
> > Would there be any problems with something like that?
> >
> > I'm less concerned with the list_attr option, as that's not something
> > totally standardised in the way KTAP is.
> >
>
> This is a really interesting idea. I like that this standardizes the
> concept of KTAP test metadata for both test suites and test cases. I
> would love to discuss this concept further as KTAP v2 is developed.
>
> My main concern would be that there is push back on stating the test
> name when it is already present in the result line. This adds
> potentially unnecessary lines to the output. However, one positive to
> this is that diagnostic data could be printed under this header which
> would reduce any confusion for which test the diagnostic data refers
> to.

Yeah, I think the main advantage is that the test name is known when
any diagnostic/other lines are read, and the main disadvantage is that
for trivial cases, it becomes pretty redundant.

>
> I would be interested if anyone else has any opinions on this.
>

Let's stick with what we're doing for now, and take this to the KTAP thread=
.

> > >
> > > Use this method to report attributes in the KTAP output (KTAP spec:
> > > https://docs.kernel.org/dev-tools/ktap.html) and _list_tests output w=
hen
> > > kernel's new kunit.action=3Dlist_attr option is used. Note this is de=
rivative
> > > of the kunit.action=3Dlist option.
> > >
> > > In test.h, add fields and associated helper functions to test cases a=
nd
> > > suites to hold user-inputted test attributes.
> > >
> > > Signed-off-by: Rae Moar <rmoar@google.com>
> > > ---
> >
> > The only other thing I'd really like to support one day is having
> > attributes for individual parameters in parameterised tests. I think
> > it makes sense as a follow-up, though.
> >
>
> That is an exciting idea! I think that would be ideal as a follow-up.
>

Yeah, definitely no pressure to have that in the next version.

> > >
> > > Changes since v1:
> > > - Add list_attr option to only include attribute in the _list_tests o=
utput
> > >   when this module param is set
> > > - Add printing options for attributes to print always, print only for
> > >   suites, or print never.
> > >
> > >  include/kunit/attributes.h | 19 +++++++++
> > >  include/kunit/test.h       | 33 ++++++++++++++++
> > >  lib/kunit/Makefile         |  3 +-
> > >  lib/kunit/attributes.c     | 80 ++++++++++++++++++++++++++++++++++++=
++
> > >  lib/kunit/executor.c       | 21 ++++++++--
> > >  lib/kunit/test.c           | 17 ++++----
> > >  6 files changed, 161 insertions(+), 12 deletions(-)
> > >  create mode 100644 include/kunit/attributes.h
> > >  create mode 100644 lib/kunit/attributes.c
> > >
> > > diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
> > > new file mode 100644
> > > index 000000000000..9fcd184cce36
> > > --- /dev/null
> > > +++ b/include/kunit/attributes.h
> > > @@ -0,0 +1,19 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * KUnit API to save and access test attributes
> > > + *
> > > + * Copyright (C) 2023, Google LLC.
> > > + * Author: Rae Moar <rmoar@google.com>
> > > + */
> > > +
> > > +#ifndef _KUNIT_ATTRIBUTES_H
> > > +#define _KUNIT_ATTRIBUTES_H
> > > +
> > > +/*
> > > + * Print all test attributes for a test case or suite.
> > > + * Output format for test cases: "# <test_name>.<attribute>: <value>=
"
> > > + * Output format for test suites: "# <attribute>: <value>"
> > > + */
> > > +void kunit_print_attr(void *test_or_suite, bool is_test, unsigned in=
t test_level);
> > > +
> > > +#endif /* _KUNIT_ATTRIBUTES_H */
> > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > index 23120d50499e..1fc9155988e9 100644
> > > --- a/include/kunit/test.h
> > > +++ b/include/kunit/test.h
> > > @@ -63,12 +63,16 @@ enum kunit_status {
> > >         KUNIT_SKIPPED,
> > >  };
> > >
> > > +/* Holds attributes for each test case and suite */
> > > +struct kunit_attributes {};
> >
> > Do we want a separate set of attributes for test cases and suites?
> > (I think probably not, but it's worth making sure.)
> >
>
> I'm thinking if our goal is to eventually move to arbitrary nesting
> for tests it would be easiest to try to keep this list the same. But I
> agree. There may definitely be attributes that are more applicable for
> test cases or suites. I'm inclined to keep it this way.
>

Agreed: having them share the same thing is definitely more future proof.

> > > +
> > >  /**
> > >   * struct kunit_case - represents an individual test case.
> > >   *
> > >   * @run_case: the function representing the actual test case.
> > >   * @name:     the name of the test case.
> > >   * @generate_params: the generator function for parameterized tests.
> > > + * @attr:     the attributes associated with the test
> > >   *
> > >   * A test case is a function with the signature,
> > >   * ``void (*)(struct kunit *)``
> > > @@ -104,6 +108,7 @@ struct kunit_case {
> > >         void (*run_case)(struct kunit *test);
> > >         const char *name;
> > >         const void* (*generate_params)(const void *prev, char *desc);
> > > +       struct kunit_attributes attr;
> > >
> > >         /* private: internal use only. */
> > >         enum kunit_status status;
> > > @@ -133,6 +138,18 @@ static inline char *kunit_status_to_ok_not_ok(en=
um kunit_status status)
> > >   */
> > >  #define KUNIT_CASE(test_name) { .run_case =3D test_name, .name =3D #=
test_name }
> > >
> > > +/**
> > > + * KUNIT_CASE_ATTR - A helper for creating a &struct kunit_case
> > > + * with attributes
> > > + *
> > > + * @test_name: a reference to a test case function.
> > > + * @attributes: a reference to a struct kunit_attributes object cont=
aining
> > > + * test attributes
> > > + */
> > > +#define KUNIT_CASE_ATTR(test_name, attributes)                 \
> > > +               { .run_case =3D test_name, .name =3D #test_name,    \
> > > +                 .attr =3D attributes }
> > > +
> > >  /**
> > >   * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct =
kunit_case
> > >   *
> > > @@ -154,6 +171,20 @@ static inline char *kunit_status_to_ok_not_ok(en=
um kunit_status status)
> > >                 { .run_case =3D test_name, .name =3D #test_name,    \
> > >                   .generate_params =3D gen_params }
> > >
> > > +/**
> > > + * KUNIT_CASE_PARAM_ATTR - A helper for creating a parameterized &st=
ruct
> > > + * kunit_case with attributes
> > > + *
> > > + * @test_name: a reference to a test case function.
> > > + * @gen_params: a reference to a parameter generator function.
> > > + * @attributes: a reference to a struct kunit_attributes object cont=
aining
> > > + * test attributes
> > > + */
> > > +#define KUNIT_CASE_PARAM_ATTR(test_name, gen_params, attributes)    =
   \
> > > +               { .run_case =3D test_name, .name =3D #test_name,    \
> > > +                 .generate_params =3D gen_params,                   =
             \
> > > +                 .attr =3D attributes }
> > > +
> >
> > I do worry a bit that we'll end up with a huge list of variants of the
> > KUNIT_CASE_* macros if we start adding more things here. I can't think
> > of a better way to handle it at the moment, though.
> >
> >
>
> I agree. If this becomes an issue, this could be a follow up change?
>
Yeah, sounds good.


> >
> > >  /**
> > >   * struct kunit_suite - describes a related collection of &struct ku=
nit_case
> > >   *
> > > @@ -163,6 +194,7 @@ static inline char *kunit_status_to_ok_not_ok(enu=
m kunit_status status)
> > >   * @init:      called before every test case.
> > >   * @exit:      called after every test case.
> > >   * @test_cases:        a null terminated array of test cases.
> > > + * @attr:      the attributes associated with the test suite
> > >   *
> > >   * A kunit_suite is a collection of related &struct kunit_case s, su=
ch that
> > >   * @init is called before every test case and @exit is called after =
every
> > > @@ -182,6 +214,7 @@ struct kunit_suite {
> > >         int (*init)(struct kunit *test);
> > >         void (*exit)(struct kunit *test);
> > >         struct kunit_case *test_cases;
> > > +       struct kunit_attributes attr;
> > >
> > >         /* private: internal use only */
> > >         char status_comment[KUNIT_STATUS_COMMENT_SIZE];
> > > diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> > > index cb417f504996..46f75f23dfe4 100644
> > > --- a/lib/kunit/Makefile
> > > +++ b/lib/kunit/Makefile
> > > @@ -6,7 +6,8 @@ kunit-objs +=3D                           test.o \
> > >                                         string-stream.o \
> > >                                         assert.o \
> > >                                         try-catch.o \
> > > -                                       executor.o
> > > +                                       executor.o \
> > > +                                       attributes.o
> > >
> > >  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
> > >  kunit-objs +=3D                          debugfs.o
> > > diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> > > new file mode 100644
> > > index 000000000000..9bda5a5f4030
> > > --- /dev/null
> > > +++ b/lib/kunit/attributes.c
> > > @@ -0,0 +1,80 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * KUnit API to save and access test attributes
> > > + *
> > > + * Copyright (C) 2023, Google LLC.
> > > + * Author: Rae Moar <rmoar@google.com>
> > > + */
> > > +
> > > +#include <kunit/test.h>
> > > +#include <kunit/attributes.h>
> > > +
> > > +/* Options for printing attributes:
> > > + * PRINT_ALWAYS - attribute is printed for every test case and suite=
 if set
> > > + * PRINT_SUITE - attribute is printed for every suite if set but not=
 for test cases
> > > + * PRINT_NEVER - attribute is never printed
> > > + */
> > > +enum print_ops {
> > > +       PRINT_ALWAYS,
> > > +       PRINT_SUITE,
> > > +       PRINT_NEVER,
> > > +};
> > > +
> > > +/**
> > > + * struct kunit_attr - represents a test attribute and holds flexibl=
e
> > > + * helper functions to interact with attribute.
> > > + *
> > > + * @name: name of test attribute, eg. speed
> > > + * @get_attr: function to return attribute value given a test
> > > + * @to_string: function to return string representation of given
> > > + * attribute value
> > > + * @filter: function to indicate whether a given attribute value pas=
ses a
> > > + * filter
> > > + */
> > > +struct kunit_attr {
> > > +       const char *name;
> > > +       void *(*get_attr)(void *test_or_suite, bool is_test);
> > > +       const char *(*to_string)(void *attr, bool *to_free);
> > > +       int (*filter)(void *attr, const char *input, int *err);
> > > +       void *attr_default;
> > > +       enum print_ops print;
> > > +};
> > > +
> > > +/* List of all Test Attributes */
> > > +
> > > +static struct kunit_attr kunit_attr_list[] =3D {};
> > > +
> > > +/* Helper Functions to Access Attributes */
> > > +
> > > +void kunit_print_attr(void *test_or_suite, bool is_test, unsigned in=
t test_level)
> > > +{
> > > +       int i;
> > > +       bool to_free;
> > > +       void *attr;
> > > +       const char *attr_name, *attr_str;
> > > +       struct kunit_suite *suite =3D is_test ? NULL : test_or_suite;
> > > +       struct kunit_case *test =3D is_test ? test_or_suite : NULL;
> > > +
> > > +       for (i =3D 0; i < ARRAY_SIZE(kunit_attr_list); i++) {
> > > +               if (kunit_attr_list[i].print =3D=3D PRINT_NEVER ||
> > > +                               (test && kunit_attr_list[i].print =3D=
=3D PRINT_SUITE))
> > > +                       continue;
> > > +               attr =3D kunit_attr_list[i].get_attr(test_or_suite, i=
s_test);
> > > +               if (attr) {
> > > +                       attr_name =3D kunit_attr_list[i].name;
> > > +                       attr_str =3D kunit_attr_list[i].to_string(att=
r, &to_free);
> > > +                       if (test) {
> > > +                               kunit_log(KERN_INFO, test, "%*s# %s.%=
s: %s",
> > > +                                       KUNIT_INDENT_LEN * test_level=
, "", test->name,
> > > +                                       attr_name, attr_str);
> > > +                       } else {
> > > +                               kunit_log(KERN_INFO, suite, "%*s# %s:=
 %s",
> > > +                                       KUNIT_INDENT_LEN * test_level=
, "", attr_name, attr_str);
> > > +                       }
> > > +
> > > +                       /* Free to_string of attribute if needed */
> > > +                       if (to_free)
> > > +                               kfree(attr_str);
> > > +               }
> > > +       }
> > > +}
> > > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > > index 74982b83707c..12e38a48a5cc 100644
> > > --- a/lib/kunit/executor.c
> > > +++ b/lib/kunit/executor.c
> > > @@ -2,6 +2,7 @@
> > >
> > >  #include <linux/reboot.h>
> > >  #include <kunit/test.h>
> > > +#include <kunit/attributes.h>
> > >  #include <linux/glob.h>
> > >  #include <linux/moduleparam.h>
> > >
> > > @@ -24,7 +25,8 @@ module_param_named(action, action_param, charp, 0);
> > >  MODULE_PARM_DESC(action,
> > >                  "Changes KUnit executor behavior, valid values are:\=
n"
> > >                  "<none>: run the tests like normal\n"
> > > -                "'list' to list test names instead of running them.\=
n");
> > > +                "'list' to list test names instead of running them.\=
n"
> > > +                "'list_attr' to list test names and attributes inste=
ad of running them.\n");
> > >
> > >  /* glob_match() needs NULL terminated strings, so we need a copy of =
filter_glob_param. */
> > >  struct kunit_test_filter {
> > > @@ -172,7 +174,7 @@ static void kunit_exec_run_tests(struct suite_set=
 *suite_set)
> > >         __kunit_test_suites_init(suite_set->start, num_suites);
> > >  }
> > >
> > > -static void kunit_exec_list_tests(struct suite_set *suite_set)
> > > +static void kunit_exec_list_tests(struct suite_set *suite_set, bool =
include_attr)
> > >  {
> > >         struct kunit_suite * const *suites;
> > >         struct kunit_case *test_case;
> > > @@ -180,10 +182,19 @@ static void kunit_exec_list_tests(struct suite_=
set *suite_set)
> > >         /* Hack: print a ktap header so kunit.py can find the start o=
f KUnit output. */
> > >         pr_info("KTAP version 1\n");
> > >
> > > -       for (suites =3D suite_set->start; suites < suite_set->end; su=
ites++)
> > > +       for (suites =3D suite_set->start; suites < suite_set->end; su=
ites++) {
> > > +               /* Print suite name and suite attributes */
> > > +               pr_info("%s\n", (*suites)->name);
> > > +               if (include_attr)
> > > +                       kunit_print_attr((void *)(*suites), false, 0)=
;
> > > +
> > > +               /* Print test case name and attributes in suite */
> > >                 kunit_suite_for_each_test_case((*suites), test_case) =
{
> > >                         pr_info("%s.%s\n", (*suites)->name, test_case=
->name);
> > > +                       if (include_attr)
> > > +                               kunit_print_attr((void *)test_case, t=
rue, 0);
> > >                 }
> > > +       }
> > >  }
> > >
> > >  int kunit_run_all_tests(void)
> > > @@ -206,7 +217,9 @@ int kunit_run_all_tests(void)
> > >         if (!action_param)
> > >                 kunit_exec_run_tests(&suite_set);
> > >         else if (strcmp(action_param, "list") =3D=3D 0)
> > > -               kunit_exec_list_tests(&suite_set);
> > > +               kunit_exec_list_tests(&suite_set, false);
> > > +       else if (strcmp(action_param, "list_attr") =3D=3D 0)
> > > +               kunit_exec_list_tests(&suite_set, true);
> > >         else
> > >                 pr_err("kunit executor: unknown action '%s'\n", actio=
n_param);
> > >
> > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > index 84e4666555c9..9ee55139ecd1 100644
> > > --- a/lib/kunit/test.c
> > > +++ b/lib/kunit/test.c
> > > @@ -9,6 +9,7 @@
> > >  #include <kunit/resource.h>
> > >  #include <kunit/test.h>
> > >  #include <kunit/test-bug.h>
> > > +#include <kunit/attributes.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > >  #include <linux/moduleparam.h>
> > > @@ -168,6 +169,13 @@ size_t kunit_suite_num_test_cases(struct kunit_s=
uite *suite)
> > >  }
> > >  EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
> > >
> > > +/* Currently supported test levels */
> > > +enum {
> > > +       KUNIT_LEVEL_SUITE =3D 0,
> > > +       KUNIT_LEVEL_CASE,
> > > +       KUNIT_LEVEL_CASE_PARAM,
> > > +};
> > > +
> > >  static void kunit_print_suite_start(struct kunit_suite *suite)
> > >  {
> > >         /*
> > > @@ -181,17 +189,11 @@ static void kunit_print_suite_start(struct kuni=
t_suite *suite)
> > >         pr_info(KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> > >         pr_info(KUNIT_SUBTEST_INDENT "# Subtest: %s\n",
> > >                   suite->name);
> > > +       kunit_print_attr((void *)suite, false, KUNIT_LEVEL_CASE);
> > >         pr_info(KUNIT_SUBTEST_INDENT "1..%zd\n",
> > >                   kunit_suite_num_test_cases(suite));
> > >  }
> > >
> > > -/* Currently supported test levels */
> > > -enum {
> > > -       KUNIT_LEVEL_SUITE =3D 0,
> > > -       KUNIT_LEVEL_CASE,
> > > -       KUNIT_LEVEL_CASE_PARAM,
> > > -};
> > > -
> > >  static void kunit_print_ok_not_ok(struct kunit *test,
> > >                                   unsigned int test_level,
> > >                                   enum kunit_status status,
> > > @@ -651,6 +653,7 @@ int kunit_run_tests(struct kunit_suite *suite)
> > >                         }
> > >                 }
> > >
> > > +               kunit_print_attr((void *)test_case, true, KUNIT_LEVEL=
_CASE);
> > >
> > >                 kunit_print_test_stats(&test, param_stats);
> > >
> > > --
> > > 2.41.0.255.g8b1d071c50-goog
> > >

--00000000000094e7580600d2dbb1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBU
eoQMtDPZD2Pl+1e69Cgg5uW4vpg6/0/MFZzRrBrTXDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTkwODMxMjdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALr/ZhIqUIWesukWdAUfO
Yhlxl3Oc6Lsxea4gg6nGq6vhKD0AGEmFzYXaFz7rGroUvbpbOT7lbvMBuiKl19YmwevwV258sK64
fweDdyv7+MUy22BaxR/7+DFHTazVwHeJFNYizLhGSWdpLmA4PpPztvk6qH4BxSsyAnj0JBl9UYMd
arVqnvZHyAYElq019VRW9/XFT2IHFHTaq0n6+4ptC7zZpgiHnq9Jt9hG67fz5sCI9aKcrXP+hc4G
hAN66Aucps2VPB9xs+/67Ydi/xJy1eR++9l89spBQF7gvUz4EdCGNIHIuATMcBuEyq54rlsNVxKw
6+u+GsgjIFCuiDymPw==
--00000000000094e7580600d2dbb1--
