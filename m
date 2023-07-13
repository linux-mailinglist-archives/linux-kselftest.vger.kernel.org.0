Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DBE752D30
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 00:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjGMWtT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 18:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjGMWtT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 18:49:19 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6A42D45
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 15:49:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so2432a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689288556; x=1691880556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzcnyZs6D3jZP1/90Em2wdIP94ZrD+KbkxYDRuLwWJE=;
        b=YbSBSKEGuVEqFb+8L1xB90bbx9PAx1IFGTDlwilLvm19IfKutZMrVwaN1yOaCXRzw5
         MZUQjJpEWVZM0DR2m5AxleVdTk2ymAh4HpgWCiWdwfTjEVXF/OpyyFu9SpllQ9lrpzdT
         xyz9Ijr8jA8PvvDfPo4oQpv5DJikjRnpxtuIZp0ll1yB/cHvfRQFiMg+OlFSVqnBDCy6
         XZDThvtyAqCF75ID6U6JTpxG0+cS19CczfMsQ91gOY/M4t0H+rGN+4TvSNyxeinNxePx
         0VjKQaZWz00m4npcN3skY9OJrbHcetRubpJbVaAiBp269Hce49FsIai61vXQji+qF6jZ
         yGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689288556; x=1691880556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzcnyZs6D3jZP1/90Em2wdIP94ZrD+KbkxYDRuLwWJE=;
        b=eRTZF4zD8mwos5x2jzlnLk/hpLDudiSdjlgCfaOqiUnKLohH8ogiio0KqcuuGTVLkc
         PJyFLz5QTEkGazdMZnYnX2CcE0OtIWWD506FT1s3XN42kSIpncEukV2KfHJdL5UOtsR4
         9sonDEENTOYHGfO2GixP0Mc8jv2Nb4iUY4lMBqnOZO3AS/7+hhiYBbKPbnS5a3wQBcV6
         Q24W91gPkbejydsAPToZ2TdLSTUJ42RlPJbtBN0UobHf8iE9jB8uiKiorzUk/dvpwwkw
         H/uyvN1eSEQyEfTAESGREbGlSqOnkLJGRtExzPApiU88qM0gQK7cLwCFRCJIUtJ83bAT
         W6DQ==
X-Gm-Message-State: ABy/qLZmbBJDc+V5rADXPKEEjgWCDwvUeGeK6fOza9n9/GNGItkHB+wR
        uLnFmBCqgm07PF9wurXz79JiVvk+8Il6q3HqWJVV5A==
X-Google-Smtp-Source: APBJJlGqtqJFAuAxh5MPiLeVS1ew+4dt62Lqbmv37bwCVq092aGdah1wT/JBThvQYfrLGxPjsNzHlRJYNInGjgUPRpw=
X-Received: by 2002:a50:9ea7:0:b0:514:92e4:ab9f with SMTP id
 a36-20020a509ea7000000b0051492e4ab9fmr297828edf.7.1689288555839; Thu, 13 Jul
 2023 15:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689171160.git.mchehab@kernel.org> <0e5f68ab045965292fee1748254bf9b91db9039a.1689171160.git.mchehab@kernel.org>
In-Reply-To: <0e5f68ab045965292fee1748254bf9b91db9039a.1689171160.git.mchehab@kernel.org>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 13 Jul 2023 18:49:02 -0400
Message-ID: <CA+GJov7ejGbgXPJYWKpve8Cz5M5z8G2vHJ0x+LZeK19OGmuX3A@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] drm: add documentation for drm_buddy_test kUnit test
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        David Gow <davidgow@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Nikolai Kondrashov <spbnick@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mauro.chehab@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 12, 2023 at 10:29=E2=80=AFAM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> As an example for the new documentation tool, add a documentation
> for drm_buddy_test.
>
> I opted to place this on a completely different directory, in order
> to make easier to test the feature with:
>
>         $ make SPHINXDIRS=3D"tests" htmldocs
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were=
 C/C on the cover.
> See [PATCH RFC 0/2] at: https://lore.kernel.org/all/cover.1689171160.git.=
mchehab@kernel.org/
>
>  Documentation/index.rst                |  2 +-
>  Documentation/tests/index.rst          |  6 ++++++
>  Documentation/tests/kunit.rst          |  5 +++++
>  drivers/gpu/drm/tests/drm_buddy_test.c | 12 ++++++++++++
>  4 files changed, 24 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/tests/index.rst
>  create mode 100644 Documentation/tests/kunit.rst
>
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 9dfdc826618c..80a6ce14a61a 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -60,7 +60,7 @@ Various other manuals with useful information for all k=
ernel developers.
>     fault-injection/index
>     livepatch/index
>     rust/index
> -
> +   test/index
>
>  User-oriented documentation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> diff --git a/Documentation/tests/index.rst b/Documentation/tests/index.rs=
t
> new file mode 100644
> index 000000000000..bfc39eb5c0aa
> --- /dev/null
> +++ b/Documentation/tests/index.rst
> @@ -0,0 +1,6 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Kunit documentation test
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::
> +   kunit
> diff --git a/Documentation/tests/kunit.rst b/Documentation/tests/kunit.rs=
t
> new file mode 100644
> index 000000000000..6ffc151988a0
> --- /dev/null
> +++ b/Documentation/tests/kunit.rst
> @@ -0,0 +1,5 @@
> +Kunit tests
> +-----------
> +
> +.. include-test:: drivers/gpu/drm/tests/drm_buddy_test.c
> +
> diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tes=
ts/drm_buddy_test.c
> index 09ee6f6af896..dd6c5afd6cd6 100644
> --- a/drivers/gpu/drm/tests/drm_buddy_test.c
> +++ b/drivers/gpu/drm/tests/drm_buddy_test.c
> @@ -737,6 +737,18 @@ static int drm_buddy_suite_init(struct kunit_suite *=
suite)
>         return 0;
>  }
>
> +/**
> + * KTEST_SUITE: set of tests for drm buddy alloc
> + * Scope: drm subsystem
> + * Mega feature: drm
> + * Feature: buddy_alloc
> + *
> + * KTEST_TEST: drm_test_buddy_alloc_%s
> + * Description: Run DRM buddy allocation %arg[1] test
> + *
> + * arg[1].values: limit, range, optimistic, smoke, pathological
> + */
> +

I apologize that the last email included a HTML attachment of the message.

Just in case anyone was unable to receive the last email here is a
copy of the message:

Hi!

This is such a cool patch series. I just have a few comments related
to the output.

In the html output the tests are listed as:
ktest@drm_buddy_test@...

I wonder if instead of using the file name of "drm_buddy_test" this
could possibly be the suite name, "drm_buddy", as this is what users
will call when using kunit.py to run the tests. Although
"drm_buddy_test" is also the module name so I don't mind it too much.
But in the future the file name and module name are not guaranteed to
be the same for other tests.

Most preferably, there would be a reference to the kunit suite name,
file name, and the module name.

This may be difficult to implement as these can all differ. I am
currently working on the KUnit Attribute framework which saves the
module name and I am thinking about also saving the file path as a
future attribute. This could be a helpful framework for the KUnit
tests specifically.

I am not sure how easy it would be to access c objects/functions using
this system.

Finally, I was wondering if it is the intention to put a list of all
KUnit tests that use this new feature into tests/kunit.rst or would
this be broken up in some way.

Thanks!
-Rae

>  static struct kunit_case drm_buddy_tests[] =3D {
>         KUNIT_CASE(drm_test_buddy_alloc_limit),
>         KUNIT_CASE(drm_test_buddy_alloc_range),
> --
> 2.40.1
>
