Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1985F78F8F3
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Sep 2023 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348460AbjIAHMD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Sep 2023 03:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjIAHMC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Sep 2023 03:12:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CA7E7F;
        Fri,  1 Sep 2023 00:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AEB8B8249D;
        Fri,  1 Sep 2023 07:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4967BC433C8;
        Fri,  1 Sep 2023 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693552315;
        bh=jL6V71q+JQ0fwfAxJn/3YfPCITb3l3CFMd1wVZr+rM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=coSjDrXd6jydcj9Jlh2XcO5LIBYCqbYjPXCkn2TnfOQVh+6sfAm19T81nDvflziH3
         +XikcbhcgxooF3aXODlQyUQR0J/FSzBXLYi/kcQ+rsCJgOxKE/X3D5fba/ZqWK+veX
         xR6qxYlfuSnURekKEvW4WZibxvijlErCNh8Q/i6HqrAtE/ippCllnPPSmaPmKxCSVk
         5RKn7ip2tc+mSGkzbMU5tTfmXj4B2gcKzxn1JdDMCKEbRpK1qAW+wNUNa6CRHINNce
         bDtRIfv+99lehWcty5cGBJhKiOAxm3E4v8g8NOzlGwX3TdKyv8YvyoOvdXPbigfbFV
         3TKMVel82XD8Q==
Date:   Fri, 1 Sep 2023 09:11:46 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Rae Moar <rmoar@google.com>
Cc:     Arthur Grillo <arthurgrillo@riseup.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        David Gow <davidgow@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>,
        Nikolai Kondrashov <spbnick@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mauro.chehab@intel.com
Subject: Re: [PATCH RFC 2/2] drm: add documentation for drm_buddy_test kUnit
 test
Message-ID: <20230901091146.749cfdfa@sal.lan>
In-Reply-To: <CA+GJov6VPggogod2=pYAxKRnP_hnqO7DMmpTzT4AAU_fiPQOfw@mail.gmail.com>
References: <cover.1689171160.git.mchehab@kernel.org>
        <0e5f68ab045965292fee1748254bf9b91db9039a.1689171160.git.mchehab@kernel.org>
        <CA+GJov6VPggogod2=pYAxKRnP_hnqO7DMmpTzT4AAU_fiPQOfw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Rae,

Em Thu, 13 Jul 2023 17:31:19 -0400
Rae Moar <rmoar@google.com> escreveu:

> On Wed, Jul 12, 2023 at 10:29 AM Mauro Carvalho Chehab <mchehab@kernel.or=
g>
> wrote:
>=20
> > As an example for the new documentation tool, add a documentation
> > for drm_buddy_test.
> >
> > I opted to place this on a completely different directory, in order
> > to make easier to test the feature with:
> >
> >         $ make SPHINXDIRS=3D"tests" htmldocs
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > ---
> >
> > To avoid mailbombing on a large number of people, only mailing lists we=
re
> > C/C on the cover.
> > See [PATCH RFC 0/2] at:
> > https://lore.kernel.org/all/cover.1689171160.git.mchehab@kernel.org/
> >
> >  Documentation/index.rst                |  2 +-
> >  Documentation/tests/index.rst          |  6 ++++++
> >  Documentation/tests/kunit.rst          |  5 +++++
> >  drivers/gpu/drm/tests/drm_buddy_test.c | 12 ++++++++++++
> >  4 files changed, 24 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/tests/index.rst
> >  create mode 100644 Documentation/tests/kunit.rst
> >
> > diff --git a/Documentation/index.rst b/Documentation/index.rst
> > index 9dfdc826618c..80a6ce14a61a 100644
> > --- a/Documentation/index.rst
> > +++ b/Documentation/index.rst
> > @@ -60,7 +60,7 @@ Various other manuals with useful information for all
> > kernel developers.
> >     fault-injection/index
> >     livepatch/index
> >     rust/index
> > -
> > +   test/index
> >
> >  User-oriented documentation
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > diff --git a/Documentation/tests/index.rst b/Documentation/tests/index.=
rst
> > new file mode 100644
> > index 000000000000..bfc39eb5c0aa
> > --- /dev/null
> > +++ b/Documentation/tests/index.rst
> > @@ -0,0 +1,6 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +Kunit documentation test
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +
> > +.. toctree::
> > +   kunit
> > diff --git a/Documentation/tests/kunit.rst b/Documentation/tests/kunit.=
rst
> > new file mode 100644
> > index 000000000000..6ffc151988a0
> > --- /dev/null
> > +++ b/Documentation/tests/kunit.rst
> > @@ -0,0 +1,5 @@
> > +Kunit tests
> > +-----------
> > +
> > +.. include-test:: drivers/gpu/drm/tests/drm_buddy_test.c
> > +
> > diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c
> > b/drivers/gpu/drm/tests/drm_buddy_test.c
> > index 09ee6f6af896..dd6c5afd6cd6 100644
> > --- a/drivers/gpu/drm/tests/drm_buddy_test.c
> > +++ b/drivers/gpu/drm/tests/drm_buddy_test.c
> > @@ -737,6 +737,18 @@ static int drm_buddy_suite_init(struct kunit_suite
> > *suite)
> >         return 0;
> >  }
> >
> > +/**
> > + * KTEST_SUITE: set of tests for drm buddy alloc
> > + * Scope: drm subsystem
> > + * Mega feature: drm
> > + * Feature: buddy_alloc
> > + *
> > + * KTEST_TEST: drm_test_buddy_alloc_%s
> > + * Description: Run DRM buddy allocation %arg[1] test
> > + *
> > + * arg[1].values: limit, range, optimistic, smoke, pathological
> > + */ =20
>=20
>=20
> Hi!
>=20
> This is such a cool patch series. I just have a few comments related to t=
he
> output.

Thank you for your comments! Sorry for not answering earlier. I took some
vacations and this series ended sleeping over other tasks on my
todo list.

Also, before sending another version, I wanted to have the test_list.py
changes to make it generic enough to be merged on IGT, to avoid having
a fork of it. Those got merged today.

> In the html output the tests are listed as:
> ktest@drm_buddy_test@=E2=80=A6
>=20
> I wonder if instead of using the file name of =E2=80=9Cdrm_buddy_test=E2=
=80=9D this could
> possibly be the suite name, =E2=80=9Cdrm_buddy=E2=80=9D, as this is what =
users will call
> when using kunit.py to run the tests. Although "drm_buddy_test" is also t=
he
> module name so I don't mind it too much. But in the future the file name
> and module name are not guaranteed to be the same for other tests.
>=20
> Most preferably, there would be a reference to the kunit suite name, file
> name, and the module name.

I guess it shouldn't be hard to do such change in a way that it won't
affect its usage on IGT. We need to define what would be the best
pattern. As this can be used for both kunit and selftests, I would
place kunit at the beginning.

Currently, we're using:

	kunit@<base file name without .c>@<test_name>

Some possible patterns would be:

	kunit@<base file name without .c>@<suite name>@<test_name>
	kunit@<subsystem>@<base file name without .c>@<suite name>@<test_name>
	kunit@<subsystem>@<suite name>@<test_name>

Would do you think it would work best?

> This may be difficult to implement as these can all differ. I am currently
> working on the KUnit Attribute framework which saves the module name and I
> am thinking about also saving the file path as a future attribute. This
> could be a helpful framework for the KUnit tests specifically.
>=20
> I am not sure how easy it would be to access c objects/functions using th=
is
> system.

I would prefer not. C language allows lots of flexibility with macros,
making it hard to write a parser to read those C objects from the source.
We have this at kernel-doc. As one of the people that did some work there,
I can say that that several tricks are needed to keep this working.

On the other hand, it should be easy to use the TestList class from
test_list.py at kunit.py.

So, kunit.py could use the data that came from the documentation
directly.

> Finally, I was wondering if it is the intention to put a list of all kunit
> tests that use this new feature into tests/kunit.rst or would this be
> broken up in some way

IMO, it makes sense to break this per subsystem, and have an auto-generated
index.rst pointing to the entire set of documents.

We're already storing the subsystem at the documentation macros, so, IMO,
it should shouldn't be hard to implement it.

Regards,
Mauro

