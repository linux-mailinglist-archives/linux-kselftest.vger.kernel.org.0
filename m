Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511BB75862B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 22:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjGRUkh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 16:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjGRUkg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 16:40:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4082BBD
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 13:40:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-521ac15e333so12198a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689712834; x=1692304834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqVfsPSqh0LbeBvoORwyyBidJKmm58T1GcZQwn4bT3I=;
        b=fmdNRvXS3fpla427GqCxknVcPn9s5GjEteFKVdiXaD9jKMdiysLLQTIF4PEJG+HTf0
         x0hc1Do7yqnxVEGeaxl7Y8qKeL23eRc7dY+Z/wO5EBE6mb94jPTinu9sUdhzZ8Clif5K
         jZeFhcixJbbBo8v9KO5gpnyfUFUfkltyHEru089t0eFdsPHQlAX65IT6187OSoAsd8Tn
         84jUFel0vkCD620mq3Y4MLuznQOS02XXLSzfJUaLw0ygrPctOOa2rckXtYHfMjbNfbuY
         Wny7J606C/nRs3m/9wbDT7tlLQChJBcYn2tpVpdfqpOA5cL8T7mkppVgJeneCaC2bzl5
         MOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689712834; x=1692304834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqVfsPSqh0LbeBvoORwyyBidJKmm58T1GcZQwn4bT3I=;
        b=YqZ10dZTPvc1hZNSgPo+xNwBOAdHbbHg59tdNpCwoPINnwmPVMfWnTUT83Di4vqz3D
         9fPEJau23VQVNCQHJ+XprnaH8u+/KVg0GV0rtzTNtXzzS0h/iQHfrenfldn/mLvLSzfo
         AtueE3DLkUrPiKl6/A6FRlwWzDqn16CtXf8YMTTErgGTznLZnnmoj6cNi324E9749sWC
         Ks9yq7NvIx1bikHolJzV4Gc/9Gkt4KHXJrE5aDfd8sNbJh6tYCMTJJ+kAKUQcdPbxzXG
         zrwq1dZqe1ZriG549raxATxmdYWOuIlScyjJ6GEtXZB2U7QJ00vSmliwyKgn55CqBK7O
         D0NA==
X-Gm-Message-State: ABy/qLYqblrpRsDZvhZQkP33E2uM/bZZi8M1iWbLgWdcnLu4l0wjmmZn
        QKe+zecyIR3Msqn9L9NyTEdHFxVXJ9C4K7eLicrlug==
X-Google-Smtp-Source: APBJJlG3lBEsP1lXxKlwOpB3mxCqVoH3SOp32VQ+QEWcVWOuWzsdT00p7z44Z0CxjIrB2aM1IlaYZN88J+q5xjbRbp4=
X-Received: by 2002:a50:9fae:0:b0:51e:295f:4ef0 with SMTP id
 c43-20020a509fae000000b0051e295f4ef0mr160300edf.5.1689712833559; Tue, 18 Jul
 2023 13:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-5-rmoar@google.com>
 <CABVgOS=X+C2g6_q-=3qdzp1YMPjazq8F2C5ZqvFhub+t3_sUdQ@mail.gmail.com>
In-Reply-To: <CABVgOS=X+C2g6_q-=3qdzp1YMPjazq8F2C5ZqvFhub+t3_sUdQ@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 18 Jul 2023 16:40:19 -0400
Message-ID: <CA+GJov4=9T0io-7a=zO=gmabS+93=4EOtABYosz=Aq2Nj-riRw@mail.gmail.com>
Subject: Re: [RFC v2 4/9] kunit: Add ability to filter attributes
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
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 18, 2023 at 3:39=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 8 Jul 2023 at 05:10, Rae Moar <rmoar@google.com> wrote:
> >
> > Add filtering of test attributes. Users can filter tests using the
> > module_param called "filter".
> >
> > Filters are imputed in the format: <attribute_name><operation><value>
> >
> > Example: kunit.filter=3D"speed>slow"
> >
> > Operations include: >, <, >=3D, <=3D, !=3D, and =3D. These operations w=
ill act the
> > same for attributes of the same type but may not between types.
> >
> > Note multiple filters can be inputted by separating them with a comma.
> > Example: kunit.filter=3D"speed=3Dslow, module!=3Dexample"
> >
> > Since both suites and test cases can have attributes, there may be
> > conflicts. The process of filtering follows these rules:
> > - Filtering always operates at a per-test level.
> > - If a test has an attribute set, then the test's value is filtered on.
> > - Otherwise, the value falls back to the suite's value.
> > - If neither are set, the attribute has a global "default" value, which
> >   is used.
> >
> > Filtered tests will not be run or show in output. The tests can instead=
 be
> > skipped using the configurable option "kunit.filter_action=3Dskip".
> >
> > Note the default settings for running tests remains unfiltered.
> >
> > Finally, add "filter" methods for the speed and module attributes to pa=
rse
> > and compare attribute values.
> >
> > Note this filtering functionality will be added to kunit.py in the next
> > patch.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> >
> > Changes since v1:
> > - Change method for inputting filters to allow for spaces in filtering
> >   values
> > - Add option to skip filtered tests instead of not run or show them wit=
h
> >   the --filter_skip flag
> >
> >  include/kunit/attributes.h |  31 +++++
> >  lib/kunit/attributes.c     | 256 +++++++++++++++++++++++++++++++++++++
> >  lib/kunit/executor.c       |  94 +++++++++++---
> >  lib/kunit/executor_test.c  |  12 +-
> >  lib/kunit/test.c           |  10 +-
> >  5 files changed, 375 insertions(+), 28 deletions(-)
> >
> > diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
> > index 9fcd184cce36..bc76a0b786d2 100644
> > --- a/include/kunit/attributes.h
> > +++ b/include/kunit/attributes.h
> > @@ -9,6 +9,20 @@
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
> > +/*
> > + * Returns the name of the filter's attribute.
> > + */
> > +const char *kunit_attr_filter_name(struct kunit_attr_filter filter);
> > +
> >  /*
> >   * Print all test attributes for a test case or suite.
> >   * Output format for test cases: "# <test_name>.<attribute>: <value>"
> > @@ -16,4 +30,21 @@
> >   */
> >  void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int =
test_level);
> >
> > +/*
> > + * Returns the number of fitlers in input.
> > + */
> > +int kunit_get_filter_count(char *input);
> > +
> > +/*
> > + * Parse attributes filter input and return an objects containing the
> > + * attribute object and the string input of the next filter.
> > + */
> > +struct kunit_attr_filter kunit_next_attr_filter(char **filters, int *e=
rr);
> > +
> > +/*
> > + * Returns a copy of the suite containing only tests that pass the fil=
ter.
> > + */
> > +struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *=
const suite,
> > +               struct kunit_attr_filter filter, char *action, int *err=
);
> > +
> >  #endif /* _KUNIT_ATTRIBUTES_H */
> > diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> > index 43dcb5de8b8f..91cbcacafba9 100644
> > --- a/lib/kunit/attributes.c
> > +++ b/lib/kunit/attributes.c
> > @@ -67,6 +67,104 @@ static const char *attr_string_to_string(void *attr=
, bool *to_free)
> >         return (char *) attr;
> >  }
> >
> > +/* Filter Methods */
> > +
> > +static const char op_list[] =3D "<>!=3D";
> > +
> > +/*
> > + * Returns whether the inputted integer value matches the filter given
> > + * by the operation string and inputted integer.
> > + */
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
>
> More a nitpick for the kunit.py patch, but I'd love to have this shown
> to the user as an error when run under kunit.py. It's very annoying to
> miss this and only get a "no tests run" error (or worse, unfiltered
> results) back.
>

I agree. I would love to change this. I am currently looking into how
easy this is to change.

It would be nice to at least see a general KUnit executor error in the
output instead of the "no tests run!" error.

>
> > +       return false;
> > +}
