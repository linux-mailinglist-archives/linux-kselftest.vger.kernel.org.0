Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFE07A057F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 15:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbjINNYr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 09:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbjINNYr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 09:24:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697991BEB;
        Thu, 14 Sep 2023 06:24:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D36C433C8;
        Thu, 14 Sep 2023 13:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694697883;
        bh=ApqBLmkZaOR9bG+HCuUd45NKWx9gUEFfpn0IjLXQiSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsZpkq2Qfg4PGoVIOMmE06NU8NwcxYgQWuzHyaEdgO4eFr1TmqhlFmr3Zow5EoaoY
         NsyBod+a1fCTNP5TSmgFnVSn1TOyVnmR08NOdRzzpc4hroDQEoXQrOPVTxXrLyAbh1
         bZqy+saUO0I+jw60sp06sPMEJ5CzQVLPF82U2v3/d/YbUfwCrT8j4bQTuVW9xLrOH8
         Z/89qoW9RZsKT9zz9x2CeDZk4saVDdP5F+rg9aLHKKw9/JC8U3ufljvKGLZ7UtmbUy
         xzIKb2ALVWNZrWf79H2I4PIvOSF5T4M6KKF453tW+3ZBgznKKmRm0gO/RrJCGi47p8
         O7vc+ggnYTsgg==
Date:   Thu, 14 Sep 2023 15:24:40 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/tests: Flag slow tests as such
Message-ID: <wnqxfgo7tljhecw2cajoeb3aga3szfen6eohowjrepfqwakka5@pm6a7iaii7fy>
References: <20230911-kms-slow-tests-v1-0-d3800a69a1a1@kernel.org>
 <20230911-kms-slow-tests-v1-2-d3800a69a1a1@kernel.org>
 <ZQAU7Juw5WM1LAAM@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s2sns2gwxynnnns6"
Content-Disposition: inline
In-Reply-To: <ZQAU7Juw5WM1LAAM@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--s2sns2gwxynnnns6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sima,

(For some reason, it looks like your mailer sets up the headers to reply
to every recipient but you)

On Tue, Sep 12, 2023 at 09:36:12AM +0200, Daniel Vetter wrote:
> On Mon, Sep 11, 2023 at 11:51:06AM +0200, Maxime Ripard wrote:
> > Kunit recently gained a speed attribute that allows to filter out slow
> > tests. A slow test is defined in the documentation as a test taking more
> > than a second to execute.
> >=20
> > Let's flag the few tests that are doing so on my machine when running:
> >=20
> > ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/gpu/drm/test=
s \
> > 	--cross_compile aarch64-linux-gnu- --arch arm64
> >=20
> > Suggested-by: David Gow <davidgow@google.com>
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
>=20
> Ugh ... not a fan.
>=20
> igt has a really bad habit of making disastrously combinatorial tests with
> impossible runtimes, and then just filtering these out so it's still fast.
>=20
> Maybe some stress tests for overall system make sense like this, but
> absolutely not for unit tests.

I agree, I didn't want to reduce testing though.

> And I did spot check some of these, they're just combinatorial
> explosions with large repetition counts and some fun stuff like going
> through prime numbers because surely that's a good idea.
>=20
> Imo delete them all, and if that causes a real gap in coverage, ask
> the authors to write some actual good unit tests for these corner
> cases.

Ack, I will send a patch doing so.

Thanks!
Maxime

--s2sns2gwxynnnns6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQMJmAAKCRDj7w1vZxhR
xWU7AQCec2+TjFtEJCwvBH+eX+OLCselkl5YoaquXV57CrLH8gEApqmPauoZqE05
5F2myjAiz2vFlA78a+oQ1h6+efFs6Qc=
=Lwvb
-----END PGP SIGNATURE-----

--s2sns2gwxynnnns6--
