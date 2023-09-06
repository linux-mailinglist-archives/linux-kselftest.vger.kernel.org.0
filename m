Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5679464E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 00:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbjIFWj2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 18:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjIFWj1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 18:39:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AF819AE
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Sep 2023 15:39:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-402bec56ca6so33285e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Sep 2023 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694039962; x=1694644762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyLpoOXcwFkFhP5nUfC2Oc1JLo+RO0y34xG0OWhq0EE=;
        b=oKri3sOCRogXd8fYTrgjGZhOwOdkuNPJtxcxK4h+PDjID/qkLc5i5D+a2nrFmCL1R7
         vzy5L3sjxmZ+cRQFAplo45aXaex94qQDvwZu3vMhtx038sv8Dknr20fkzuIq4Th72YRh
         ktI0u90VqfaFAq7WyfUs3EIz7mg6qLESGc2p/Vb5iw8fO9IqzrKo7kWyN/RQ0zQpXrvm
         zRnctNmRspZ4d+BUeGke6A2LPpjFyuBMDuy2VRZPoBb9y0tig/OJbkYa9LcLmF4f3Ifi
         gjK63YLc/PGuvELodzm/NxQN30a43yXnsj5e1QPx44Ri+dNxpIHCQCkd1C+AyM+zf0lH
         AFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694039962; x=1694644762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyLpoOXcwFkFhP5nUfC2Oc1JLo+RO0y34xG0OWhq0EE=;
        b=Eq99yG81ShCH0Ja/C1A0o/jGuubXEzeOtkprnH8rkIMDEfeOhCm7RuB2Qd+3NVbA8f
         GafsKHCCDAe1p7934BwkJ/lNJvhNgjQx1jBTyPBTmNEYGL8DjEjFGQAPGdeDHEbcTBXk
         rmtkOIHbHozxu/h3lEcAtrC5Vx5tDAJNPi5GsikOfAusVMxiyEg5VyRzXRfWDdgDbjpn
         k5EgsWfn4e12AuM/YLVGNlR3cw+625shvXpXY4MEsFNCGttDbz0/QIs4d/fQU8HCCRSF
         CfbJznQn4ciB2HzwY4mjaC44F8GIGowKDe70k9otCRTCmR1SlmyNupUkp4UZIi9a/sGG
         7BcQ==
X-Gm-Message-State: AOJu0YyEWV/AxzpwD95bfxJGIFsoCPZTorcQFkeCbwG1F9mR4AWkDNJH
        QA15LoarWU3K9SGBsrVSYmtf7vjH2XvVCtn4cyWZEQ==
X-Google-Smtp-Source: AGHT+IFjE7IkWNudt3/ZAtns7s8g7VmC8LdCo6/f7zAueKmVJHutmR5MznXqdcLNUd0jg35qMP4G5z1jptraZwVBqEg=
X-Received: by 2002:a05:600c:1d8b:b0:3f7:e4d8:2569 with SMTP id
 p11-20020a05600c1d8b00b003f7e4d82569mr15129wms.5.1694039961651; Wed, 06 Sep
 2023 15:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689171160.git.mchehab@kernel.org> <0e5f68ab045965292fee1748254bf9b91db9039a.1689171160.git.mchehab@kernel.org>
 <CA+GJov6VPggogod2=pYAxKRnP_hnqO7DMmpTzT4AAU_fiPQOfw@mail.gmail.com> <20230901091146.749cfdfa@sal.lan>
In-Reply-To: <20230901091146.749cfdfa@sal.lan>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 6 Sep 2023 18:39:09 -0400
Message-ID: <CA+GJov6X5pMYDWMOB=7ujv36yyMKQemDGyP6C310VaVz1h2FuA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] drm: add documentation for drm_buddy_test kUnit test
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arthur Grillo <arthurgrillo@riseup.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        David Gow <davidgow@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Nikolai Kondrashov <spbnick@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mauro.chehab@intel.com
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

On Fri, Sep 1, 2023 at 3:11=E2=80=AFAM Mauro Carvalho Chehab <mchehab@kerne=
l.org> wrote:
>
> Hi Rae,
>
> Em Thu, 13 Jul 2023 17:31:19 -0400
> Rae Moar <rmoar@google.com> escreveu:
>
> > On Wed, Jul 12, 2023 at 10:29 AM Mauro Carvalho Chehab <mchehab@kernel.=
org>
> > wrote:
> >
> > > As an example for the new documentation tool, add a documentation
> > > for drm_buddy_test.
> > >
> > > I opted to place this on a completely different directory, in order
> > > to make easier to test the feature with:
> > >
> > >         $ make SPHINXDIRS=3D"tests" htmldocs
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > ---
> > >
> > > To avoid mailbombing on a large number of people, only mailing lists =
were
> > > C/C on the cover.
> > > See [PATCH RFC 0/2] at:
> > > https://lore.kernel.org/all/cover.1689171160.git.mchehab@kernel.org/
> > >
> > >  Documentation/index.rst                |  2 +-
> > >  Documentation/tests/index.rst          |  6 ++++++
> > >  Documentation/tests/kunit.rst          |  5 +++++
> > >  drivers/gpu/drm/tests/drm_buddy_test.c | 12 ++++++++++++
> > >  4 files changed, 24 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/tests/index.rst
> > >  create mode 100644 Documentation/tests/kunit.rst
> > >
> > > diff --git a/Documentation/index.rst b/Documentation/index.rst
> > > index 9dfdc826618c..80a6ce14a61a 100644
> > > --- a/Documentation/index.rst
> > > +++ b/Documentation/index.rst
> > > @@ -60,7 +60,7 @@ Various other manuals with useful information for a=
ll
> > > kernel developers.
> > >     fault-injection/index
> > >     livepatch/index
> > >     rust/index
> > > -
> > > +   test/index
> > >
> > >  User-oriented documentation
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > diff --git a/Documentation/tests/index.rst b/Documentation/tests/inde=
x.rst
> > > new file mode 100644
> > > index 000000000000..bfc39eb5c0aa
> > > --- /dev/null
> > > +++ b/Documentation/tests/index.rst
> > > @@ -0,0 +1,6 @@
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > +Kunit documentation test
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > +
> > > +.. toctree::
> > > +   kunit
> > > diff --git a/Documentation/tests/kunit.rst b/Documentation/tests/kuni=
t.rst
> > > new file mode 100644
> > > index 000000000000..6ffc151988a0
> > > --- /dev/null
> > > +++ b/Documentation/tests/kunit.rst
> > > @@ -0,0 +1,5 @@
> > > +Kunit tests
> > > +-----------
> > > +
> > > +.. include-test:: drivers/gpu/drm/tests/drm_buddy_test.c
> > > +
> > > diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c
> > > b/drivers/gpu/drm/tests/drm_buddy_test.c
> > > index 09ee6f6af896..dd6c5afd6cd6 100644
> > > --- a/drivers/gpu/drm/tests/drm_buddy_test.c
> > > +++ b/drivers/gpu/drm/tests/drm_buddy_test.c
> > > @@ -737,6 +737,18 @@ static int drm_buddy_suite_init(struct kunit_sui=
te
> > > *suite)
> > >         return 0;
> > >  }
> > >
> > > +/**
> > > + * KTEST_SUITE: set of tests for drm buddy alloc
> > > + * Scope: drm subsystem
> > > + * Mega feature: drm
> > > + * Feature: buddy_alloc
> > > + *
> > > + * KTEST_TEST: drm_test_buddy_alloc_%s
> > > + * Description: Run DRM buddy allocation %arg[1] test
> > > + *
> > > + * arg[1].values: limit, range, optimistic, smoke, pathological
> > > + */
> >
> >
> > Hi!
> >
> > This is such a cool patch series. I just have a few comments related to=
 the
> > output.
>
> Thank you for your comments! Sorry for not answering earlier. I took some
> vacations and this series ended sleeping over other tasks on my
> todo list.
>
> Also, before sending another version, I wanted to have the test_list.py
> changes to make it generic enough to be merged on IGT, to avoid having
> a fork of it. Those got merged today.

Hi Mauro!

No worries at all!

>
> > In the html output the tests are listed as:
> > ktest@drm_buddy_test@=E2=80=A6
> >
> > I wonder if instead of using the file name of =E2=80=9Cdrm_buddy_test=
=E2=80=9D this could
> > possibly be the suite name, =E2=80=9Cdrm_buddy=E2=80=9D, as this is wha=
t users will call
> > when using kunit.py to run the tests. Although "drm_buddy_test" is also=
 the
> > module name so I don't mind it too much. But in the future the file nam=
e
> > and module name are not guaranteed to be the same for other tests.
> >
> > Most preferably, there would be a reference to the kunit suite name, fi=
le
> > name, and the module name.
>
> I guess it shouldn't be hard to do such change in a way that it won't
> affect its usage on IGT. We need to define what would be the best
> pattern. As this can be used for both kunit and selftests, I would
> place kunit at the beginning.
>
> Currently, we're using:
>
>         kunit@<base file name without .c>@<test_name>
>
> Some possible patterns would be:
>
>         kunit@<base file name without .c>@<suite name>@<test_name>
>         kunit@<subsystem>@<base file name without .c>@<suite name>@<test_=
name>
>         kunit@<subsystem>@<suite name>@<test_name>
>
> Would do you think it would work best?

How possible is it to separate out the file and suite name as headers?
I think that this could reduce some of the repetition.

If we are already separating documentation pages by subsystem, a
potential format could be:

File: <base file>

<kunit_or_kselftest> suite: <suite name>
List of Tests:
<test name>
<test name>
...

What do you think?

>
> > This may be difficult to implement as these can all differ. I am curren=
tly
> > working on the KUnit Attribute framework which saves the module name an=
d I
> > am thinking about also saving the file path as a future attribute. This
> > could be a helpful framework for the KUnit tests specifically.
> >
> > I am not sure how easy it would be to access c objects/functions using =
this
> > system.
>
> I would prefer not. C language allows lots of flexibility with macros,
> making it hard to write a parser to read those C objects from the source.
> We have this at kernel-doc. As one of the people that did some work there=
,
> I can say that that several tricks are needed to keep this working.
>
> On the other hand, it should be easy to use the TestList class from
> test_list.py at kunit.py.
>
> So, kunit.py could use the data that came from the documentation
> directly.
>

Got it. So it is possible to get some of this info. Thanks!

> > Finally, I was wondering if it is the intention to put a list of all ku=
nit
> > tests that use this new feature into tests/kunit.rst or would this be
> > broken up in some way
>
> IMO, it makes sense to break this per subsystem, and have an auto-generat=
ed
> index.rst pointing to the entire set of documents.
>
> We're already storing the subsystem at the documentation macros, so, IMO,
> it should shouldn't be hard to implement it.
>
> Regards,
> Mauro

I think breaking this up by subsystems sounds like a good idea,
especially since we still have them documented already.

Thanks for your responses!
-Rae

>
