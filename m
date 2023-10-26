Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2187D7EBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjJZIo1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 04:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZIo0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 04:44:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFC410E;
        Thu, 26 Oct 2023 01:44:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11F8C433C9;
        Thu, 26 Oct 2023 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698309864;
        bh=yowgxh+ZAal3kvGvwHLgpiqSAMRMpFsptH1oAAmJZPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UPZxoGfTBX6vOofmCi4A7l0u2oAOx225vgySOyqG7RErH6hpRkD4GYmYa8eUkv3Jy
         DrbvJFwPYcPoMw77JsmQEWU3uZiOqBwnAK5PgLZ5kPi4oEIEEHD6CQLZPXFJByl6Em
         vRjC1ze+kW0oGl7rLlzZFeSArJiGiblnKVYdmYSPxr+qprrSnJMZ+G6Y1SF/QiXCLt
         I3iKSxK5d3VVsVyqmP9xXpIAkEWt51BfrzJpgYutHIjbks3IfxK0l1bbytfLTwFzkw
         AnUlVbZ1bv/TCutiHSMETTf3fsWywWPWFJVI2ao2u8OdB89FfB7kdUvFTL5fBem1sC
         GRaYRSa8QAkeQ==
Date:   Thu, 26 Oct 2023 10:44:21 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kunit: Warn if tests are slow
Message-ID: <5bc2z52ytbws2ezljfwnp2bjchwpfruzy2rjffhd6wlbx2vt6h@mektaexcvojp>
References: <20230920084903.1522728-1-mripard@kernel.org>
 <CABVgOSkLSSkuwM6SqmLKtS3WbCH2SJRcqT8mmv8WwJaYine1yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7htp2anxv25ifq42"
Content-Disposition: inline
In-Reply-To: <CABVgOSkLSSkuwM6SqmLKtS3WbCH2SJRcqT8mmv8WwJaYine1yQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--7htp2anxv25ifq42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 26, 2023 at 03:06:39PM +0800, David Gow wrote:
> On Wed, 20 Sept 2023 at 16:49, Maxime Ripard <mripard@kernel.org> wrote:
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
> >
> > ---
> >
> > To: Brendan Higgins <brendan.higgins@linux.dev>
> > To: David Gow <davidgow@google.com>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Rae Moar <rmoar@google.com>
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: kunit-dev@googlegroups.com
> > Cc: linux-kernel@vger.kernel.org
> >
> > Changes from v1:
> > - Split the patch out of the series
> > - Change to trigger the warning only if the runtime is twice the
> >   threshold (Jani, Rae)
> > - Split the speed check into a separate function (Rae)
> > - Link: https://lore.kernel.org/all/20230911-kms-slow-tests-v1-0-d3800a=
69a1a1@kernel.org/
> > ---
>=20
> I quite like this, though agree somewhat with Rae's comments below.
>=20
> I personally think the time thresholds are, by necessity, very
> 'fuzzy', due to the varying speeds of different hardware. Fortunately,
> the actual runtime of tests seems pretty well stratified, so the exact
> threshold doesn't really matter much.
>=20
> I ran some tests here, and all of the tests currently not marked slow
> take <1s on every machine I tried (including the ancient 66MHz 486),
> except for the drm_mm_* ones (which takes ~6s on my laptop, and times
> out after 15 minutes on the aforementioned 486). Both the 1s and 2s
> timeouts successfully distinguish those cases.

I had a similar experience running the tests in qemu on a Pi4, which is
probably the slowest machine we can reasonably expect.

> Ideally, I think we'd have something like:
> #define KUNIT_SPEED_SLOW_THRESHOLD_S 1 /* 1 sec threshold for 'slow' test=
s */
> #define KUNIT_SPEED_WARNING_MULTIPLIER 2 /* Warn when a test takes >
> twice the threshold. */
> #define KUNIT_SPEED_SLOW_WARNING_THRESHOLD_S
> (KUNIT_SPEED_WARNING_MULTIPLIER * KUNIT_SPEED_SLOW_THRESHOLD_S)
>=20
> Which is perhaps excessively verbose, but is very clear as to what
> we're doing. It also gives more scope to allow the ratio to be
> configured for people with very slow / fast machines in the future.
>=20
> Thoughts?

That looks like a good compromise to me, I'll send another version :)

Thanks!
Maxime

--7htp2anxv25ifq42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZTom5QAKCRDj7w1vZxhR
xVFcAQDyZlc+V/RjD3pAJE5KptUHRFgC14R2vODhzvJETP+bzgEAubJlJ5p3J9q1
g24tsIpRXoo4QWr0ViQlKxG86imxTQ0=
=Vmcx
-----END PGP SIGNATURE-----

--7htp2anxv25ifq42--
