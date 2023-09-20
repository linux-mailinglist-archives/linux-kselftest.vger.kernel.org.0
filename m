Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B37A73AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 09:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjITHHD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 03:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjITHHB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 03:07:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1462D3;
        Wed, 20 Sep 2023 00:06:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCF0C433C7;
        Wed, 20 Sep 2023 07:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695193611;
        bh=uAwpxEnfMfZSyuDkr+wBXoclcsWoX/crp/2v537NsYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVXelshMFXxpUMfQZXtgjcSNRlJArQohPg0xpfnyMtmW4OvryXBUR7wRRgGk7z2Tc
         rr22LZTDQMfKWzCuVXubSyjSdGRmx+fvwSPEWJ1Vf0Q8IlZgs3Bgta8c8GtEJRQmup
         pavE6spjJxNZviF8lFQyyYVwz12TM2LcXhO0OvdbxWCsrUBiBsAg5dqgmFjnjXJn4N
         U5SO1PsVaLOOtk5ku7whFpscYsxzhh+PvcJV9dJ4XJtxki63+Bzk3rlwO5qnCPlxXV
         gPBDia1CD6nd1qTCW5dp7hdA9aCbmsBIFGfksWmjwhtIU4eR3GuWuOSmwJH8TWCJ36
         bhOGsTfM0Smmw==
Date:   Wed, 20 Sep 2023 09:06:48 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Rae Moar <rmoar@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] kunit: Warn if tests are slow
Message-ID: <2rks5qxxetsbv657qhnevsxyq4q2wi7m3y66wit5fg2cg4rbb6@zpwsmru3khmi>
References: <20230911-kms-slow-tests-v1-0-d3800a69a1a1@kernel.org>
 <20230911-kms-slow-tests-v1-1-d3800a69a1a1@kernel.org>
 <CA+GJov6sQMmEiTQ7cupyC2cx-aWvV7M6ki4W8naEHyA8tbSbdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w74ncfsnmb5fumc5"
Content-Disposition: inline
In-Reply-To: <CA+GJov6sQMmEiTQ7cupyC2cx-aWvV7M6ki4W8naEHyA8tbSbdg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--w74ncfsnmb5fumc5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 19, 2023 at 03:48:55PM -0400, Rae Moar wrote:
> On Mon, Sep 11, 2023 at 5:51=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
> >
> > Kunit recently gained support to setup attributes, the first one being
> > the speed of a given test, then allowing to filter out slow tests.
> >
> > A slow test is defined in the documentation as taking more than one
> > second. There's an another speed attribute called "super slow" but whose
> > definition is less clear.
> >
> > Add support to the test runner to check the test execution time, and
> > report tests that should be marked as slow but aren't.
> >
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
>
> I like this idea especially if it was helpful in identifying slow
> tests already! I have a few thoughts on this. I share Jani's concern
> for warning all tests on slow machines. I can think of a few options.
>=20
> First, we could increase the threshold to about 2s even though that
> would eliminate warnings on potentially slow tests. However, this
> would point out the slowest tests.

I don't have a strong opinion there, so whatever works for you :)

> Second, we could change this to warn users only when they choose by
> making this a configurable option or making this a script to output a
> list of all unmarked slow tests.

I'm not really sure. Adding an option would hide it away from users and
only a fraction of the users (including devs working on tests) would see
that their test should actually be marked as slow.

That will prevent the wider use of it imo, and instead of catching it
early (when we're working on it), will lead to more patches.

Plus, a runtime of more than a second, no matter the platform, is
usually a good indication that what your test is doing probably
shouldn't be done that way.

> Third, we could leave this as is. As the KUnit warnings do not show up
> in the kunit.py output and do not cause the test to fail in any way
> they are relatively harmless if they are unwanted by the user.

I was looking at it the other day, and I think we can modify the TAP
output to expose the warning through the kunit.py command to the user.

It looks like it allows to provide any keyword after the comment mark
and allows to extend it, so we could have something like

ok $TEST # KUNIT_WARN $MESSAGE

and then parse that in kunit.py, pretty much like we handle SKIP. But
that's a separate discussion really.

But yeah, whether or not this is reported to the user, it must not fail
the test.

> Not quite sure which I prefer? The second option might be the cleanest
> for the user and the time threshold could even be customizable. Let me
> know what you think.

I'm in favour of the second one as well.

> > ---
> >  lib/kunit/test.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 49698a168437..a3b924501f3d 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -379,6 +379,9 @@ static void kunit_run_case_internal(struct kunit *t=
est,
> >                                     struct kunit_suite *suite,
> >                                     struct kunit_case *test_case)
> >  {
> > +       struct timespec64 start, end;
> > +       struct timespec64 duration;
> > +
> >         if (suite->init) {
> >                 int ret;
> >
> > @@ -390,7 +393,20 @@ static void kunit_run_case_internal(struct kunit *=
test,
> >                 }
> >         }
> >
> > +       ktime_get_ts64(&start);
> > +
> >         test_case->run_case(test);
> > +
> > +       ktime_get_ts64(&end);
> > +
> > +       duration =3D timespec64_sub(end, start);
> > +
> > +       if (duration.tv_sec >=3D 1 &&
> > +           (test_case->attr.speed =3D=3D KUNIT_SPEED_UNSET ||
> > +            test_case->attr.speed >=3D KUNIT_SPEED_NORMAL))
> > +               kunit_warn(test,
> > +                          "Test should be marked slow (runtime: %lld.%=
09lds)",
> > +                          duration.tv_sec, duration.tv_nsec);
>=20
> I would consider moving this if statement into a separate function.

Ack.

I'll send a v2 with your suggestions

Thanks!
Maxime

--w74ncfsnmb5fumc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQqaCAAKCRDj7w1vZxhR
xWFVAQCscyH4BdpULUcyKdzrJnqg4NjTunlwcCoBUnaXdcwPuAEAtSZgjTTai4MB
pmFajOsaPbjnfsaZqqQlaWvbK+LxdgQ=
=RD7P
-----END PGP SIGNATURE-----

--w74ncfsnmb5fumc5--
