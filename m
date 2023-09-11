Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A624579BC73
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345299AbjIKVT2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbjIKLZb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 07:25:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354C9CF0;
        Mon, 11 Sep 2023 04:25:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F433C433C7;
        Mon, 11 Sep 2023 11:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694431526;
        bh=EawFgFNxTGjsJlWqhpuJ848r9v1XFD1NX8Vu8QQ6TjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jO0WffPeuErMHhfcC3J7dNtdQz66zQu2iwFfVzC1cMw8x/yE8ao1Bull7dXvgGRYu
         5cL2043vY5RhN4nqTmdXw6AgkX5DGJUzMs+Ul+hrPKtnyC2JFu2JFbuUVo/iZ7gmaL
         FesHFRoiYdYdWqcLu/cWHT5zryfwqQoqPN+eePSqCOqlWrXG6HdinHg+mzFvMyW8ii
         6PhKr/X39RAIPqc4noWg1Kqtqy0KemXXHgh0eGgQCHEOuSinP033sRAWIhUAaMHlm6
         4n8wQoox3WtnQpp4YGrcNtnKop/TQu9A9FT98fbrMzGVovmRJ4bZZkbCTExfJ9JwAT
         8eo2dzc+W1Dxg==
Date:   Mon, 11 Sep 2023 13:25:23 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH 1/2] kunit: Warn if tests are slow
Message-ID: <l2eeghk7kz4rzsvlvvsj4vayo5s4ctnrizwkjolhaa2p3xdz75@jcczdtol52y7>
References: <20230911-kms-slow-tests-v1-0-d3800a69a1a1@kernel.org>
 <20230911-kms-slow-tests-v1-1-d3800a69a1a1@kernel.org>
 <87leddf2fs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rllaj5tmvs7jz32f"
Content-Disposition: inline
In-Reply-To: <87leddf2fs.fsf@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--rllaj5tmvs7jz32f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jani,

On Mon, Sep 11, 2023 at 01:07:35PM +0300, Jani Nikula wrote:
> On Mon, 11 Sep 2023, Maxime Ripard <mripard@kernel.org> wrote:
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
> >  				    struct kunit_suite *suite,
> >  				    struct kunit_case *test_case)
> >  {
> > +	struct timespec64 start, end;
> > +	struct timespec64 duration;
> > +
> >  	if (suite->init) {
> >  		int ret;
> > =20
> > @@ -390,7 +393,20 @@ static void kunit_run_case_internal(struct kunit *=
test,
> >  		}
> >  	}
> > =20
> > +	ktime_get_ts64(&start);
> > +
> >  	test_case->run_case(test);
> > +
> > +	ktime_get_ts64(&end);
> > +
> > +	duration =3D timespec64_sub(end, start);
> > +
> > +	if (duration.tv_sec >=3D 1 &&
> > +	    (test_case->attr.speed =3D=3D KUNIT_SPEED_UNSET ||
> > +	     test_case->attr.speed >=3D KUNIT_SPEED_NORMAL))
> > +		kunit_warn(test,
> > +			   "Test should be marked slow (runtime: %lld.%09lds)",
> > +			   duration.tv_sec, duration.tv_nsec);
>=20
> Two thoughts:
>=20
> Should there be some tolerance here? Otherwise we're flagging this on
> the slowest machines, and we'll be defining tests slow based on
> that. Like, warn if it takes more than 2 seconds.

I'm not sure what the expectation from David and Brendan are here. I'll
follow what they suggest, but with a couple of hundreds tests like we
have in DRM at the moment, the difference in run time can be up to 5
minutes :/

> What if someone makes a test faster, but forgets to update the
> attribute? Should we also flag slow tests that are in fact fast?

I'm not sure we can do that actually, because it certainly depends on
the hardware running the tests. So I would definitely expect most of the
slow tests to be running faster on some hardware.

Like, running kunit natively on my workstation clears all the DRM tests
in 6s, while it takes about 60s using qemu to test it on arm64, so they
would be considered slow on arm64 but not by default.

Maxime

--rllaj5tmvs7jz32f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZP75IwAKCRDj7w1vZxhR
xTcYAP9N6vHg5h6885y/C3Tc0z1f6IQ0dk+FGmjUeus+bW/YOQEAl7UhCwI0k+Hm
xYUWCTOJcXuebaOI4VfAA+udV4uSJgM=
=sWMz
-----END PGP SIGNATURE-----

--rllaj5tmvs7jz32f--
