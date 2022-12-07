Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828B96455DF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 09:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLGI6q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 03:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLGI6e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 03:58:34 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B4EBEA;
        Wed,  7 Dec 2022 00:58:32 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id n3so12700673pfq.10;
        Wed, 07 Dec 2022 00:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3kRlTBcDxyj5ptNZ14o1YVXGmrqFxRI2/QpD88qWYiQ=;
        b=pgoiqd8jUZVnnOCnDAzMxflF6HGuST/I9gEfUjqkMJROwp6XfWDHZNniCByRWCa7+t
         RnC61XywTSJpzGwcFk6BamEkmE0TXLUXuBJw9eYmqFY6ZYzXW7nOD4FCUBzvlslwE4hh
         K0pelResXxqzJigLV+9v0/HKhyR7+uBGdGzBvQnVFPFW3qjkP+m90rlXFQPR1JI9D/VH
         L5g6nidU/g4vdofdkkcBoJVm68l8jnzFvszrmr/K6mfzVdhYtAoTpkG5xY/PAyO16kOv
         cEikK3MA3tiPlBpiZasPoz3R1O914R9QuaM/oOTufXTHdD8gYkS6RHO9X6YRaEGcsecB
         HpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kRlTBcDxyj5ptNZ14o1YVXGmrqFxRI2/QpD88qWYiQ=;
        b=sSgyWjaLrC4WkZEZRIFMGIQBWtUOBJ9qfSS3ZbJl/UkhHvk62qT0N8TbFnZrOP1tG5
         mWG9YJSyh7XmZkLPgjSX5ksnK7VPzUIdINLjBDYlsnt5jUvHWtPVRmY8ALTMlTq2gxBo
         H04qNJn83mYTuAWPB+p0ACarMVje8gFm04cTUpaFzY+eP8L94C3qroHGcxkIR3Mp0rtg
         Wx4Rt/SVYcsf9vw+UJSD9HE/kuifsxYF6kc32hYEzBJEVzWw+EOXdA14eA9Chr+Is2tC
         B1jFuRJ7+nRF9jqG3386Lx/jGJphc5g3MwEXho3BSDXB7ziz8PI0r4NxA2BcnooyK4SF
         ZjGA==
X-Gm-Message-State: ANoB5pnFx6gxsqK+ueMxZnI89Ca2/zIgkzN6PKHRyfxoRyjwciH3t65o
        cZmXNNIIWwt8CKhjkJGOecw=
X-Google-Smtp-Source: AA0mqf4ZgSAfgs0hcNgueeE8FLs2MF0/38xphbpqsrdRo44kAFrVjIjUCGSHiF/dC/wUBsv7UacLBw==
X-Received: by 2002:a63:1e49:0:b0:46b:1590:2625 with SMTP id p9-20020a631e49000000b0046b15902625mr62802011pgm.569.1670403511826;
        Wed, 07 Dec 2022 00:58:31 -0800 (PST)
Received: from debian.me (subs03-180-214-233-90.three.co.id. [180.214.233.90])
        by smtp.gmail.com with ESMTPSA id ml13-20020a17090b360d00b00219f8eb271fsm740610pjb.5.2022.12.07.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 00:58:31 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id B381A1042C6; Wed,  7 Dec 2022 15:58:28 +0700 (WIB)
Date:   Wed, 7 Dec 2022 15:58:28 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Rae Moar <rmoar@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: kunit: Fix "How Do I Use This" / "Next
 Steps" sections
Message-ID: <Y5BVtHjnwpn5CFzf@debian.me>
References: <20221207043319.1890954-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gQZZMfvjrIhTAV6r"
Content-Disposition: inline
In-Reply-To: <20221207043319.1890954-1-davidgow@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--gQZZMfvjrIhTAV6r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 12:33:19PM +0800, David Gow wrote:
> The "How Do I Use This" section of index.rst and "Next Steps" section of
> start.rst were just copies of the table of contents, and therefore
> weren't really useful either when looking a sphinx generated output
> (which already had the TOC visible) or when reading the source (where
> it's just a list of files that ls could give you).
>=20
> Instead, provide a small number of concrete next steps, and a bit more
> description about what the pages contain.
>=20
> This also removes the broken reference to 'tips.rst', which was
> previously removed.
>=20
> Fixes: 4399c737a97d ("Documentation: kunit: Remove redundant 'tips.rst' p=
age")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>=20
> Thanks everyone for reviewing v1. Since this is pretty much a complete
> rewrite, I've left Reviewed-by tags off, as I don't feel the previous
> reviews totally apply. Feel free to review again if you have any
> comments.
>=20
> Cheers,
> -- David
>=20
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20221129094732.306449-1-davidgow@=
google.com/
> - Totally rewrite both sections to only include (and provide more
>   context for) the most concrete next steps.
>   - Thanks Bagas for pointing out that this basically duplicates the TOC
>     as-is.
>=20
> ---
>  Documentation/dev-tools/kunit/index.rst | 19 ++++++++-----------
>  Documentation/dev-tools/kunit/start.rst | 19 +++++++++----------
>  2 files changed, 17 insertions(+), 21 deletions(-)
>=20
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-=
tools/kunit/index.rst
> index d5629817cd72..b3593ae29ace 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -99,14 +99,11 @@ Read also :ref:`kinds-of-tests`.
>  How do I use it?
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -*   Documentation/dev-tools/kunit/start.rst - for KUnit new users.
> -*   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
> -*   Documentation/dev-tools/kunit/run_wrapper.rst - run kunit_tool.
> -*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kun=
it_tool.
> -*   Documentation/dev-tools/kunit/usage.rst - write tests.
> -*   Documentation/dev-tools/kunit/tips.rst - best practices with
> -    examples.
> -*   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
> -    used for testing.
> -*   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
> -    answers.
> +You can find a step-by-step guide to writing and running KUnit tests in
> +Documentation/dev-tools/kunit/start.rst
> +
> +Alternatively, feel free to look through the rest of the KUnit documenta=
tion,
> +or to experiment with tools/testing/kunit/kunit.py and the example test =
under
> +lib/kunit/kunit-example-test.c
> +
> +Happy testing!
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-=
tools/kunit/start.rst
> index f4f504f1fb15..224387a43543 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -294,13 +294,12 @@ Congrats! You just wrote your first KUnit test.
>  Next Steps
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -*   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
> -*   Documentation/dev-tools/kunit/run_wrapper.rst - run kunit_tool.
> -*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kun=
it_tool.
> -*   Documentation/dev-tools/kunit/usage.rst - write tests.
> -*   Documentation/dev-tools/kunit/tips.rst - best practices with
> -    examples.
> -*   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
> -    used for testing.
> -*   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
> -    answers.
> +If you're interested in using some of the more advanced features of kuni=
t.py,
> +take a look at Documentation/dev-tools/kunit/run_wrapper.rst
> +
> +If you'd like to run tests without using kunit.py, check out
> +Documentation/dev-tools/kunit/run_manual.rst
> +
> +For more information on writing KUnit tests (including some common techn=
iques
> +for testing different things), see Documentation/dev-tools/kunit/usage.r=
st
> +

Much better, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--gQZZMfvjrIhTAV6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5BVrwAKCRD2uYlJVVFO
o90qAP0W0QiL12+wE0JzXPGrOMlc9sFK4uQuxOTzzy+QLsgflwEA+ZWGwB0Yy8f8
m2zrxJFPUg5QDxd6u2KAbBX0ztNinAg=
=m9er
-----END PGP SIGNATURE-----

--gQZZMfvjrIhTAV6r--
