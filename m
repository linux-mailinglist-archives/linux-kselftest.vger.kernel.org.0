Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D794E63EDB9
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 11:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiLAK2N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 05:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiLAK2J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 05:28:09 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7657D5F99;
        Thu,  1 Dec 2022 02:27:59 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 32628580452;
        Thu,  1 Dec 2022 05:27:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 01 Dec 2022 05:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1669890479; x=1669897679; bh=eip0JYxLwA
        AvXLG5NBGWWs0mG1joDIdVXmK8+H3wc1I=; b=Ifcsm7mFF1kDXPSQsE2BjtauEl
        4bwtK3ys+M8QAe1DT6cDljjLeiP9u7O0waPCTSzJZvOmYsNzMNupyKSk7RlXCn+z
        SIt1N4VnFoe4DRug4ptdM/z7kJGtGgRWYHRgCq/DKQ6rEmGJI/hv+ECAVO3zMQeo
        m/6LelTKZuZRwHGi73LM3aKWDMjnFswHYQHFCEMLH1tLxRaMBy4KGPefilNGDnna
        6EK9Iysjbf14LMFylHM+HCptA8YYGFlPnzMz5BBJ2Eh0H5sA0SE1O0qzDtKn1/0s
        9fwoHGL9mP8OuXk1t9ZuXLI8vy7GGe+YC/LR8Z/wxq+3RwzxSR5zYC46inuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669890479; x=1669897679; bh=eip0JYxLwAAvXLG5NBGWWs0mG1jo
        DIdVXmK8+H3wc1I=; b=jHUQhnx+FI055/Dk7FSqjW8PozYbbmB3jI+xMqePY5Jj
        0UQDS9Y8DOSGFbJpQ4QEN9aB7JffyVZkvEDR0TvX5/EzJf+vOAqw79xBlTUNz7+W
        KJ0LinhY/5xoBand1PEsJ0azU99iEa5mlvOM30ACai17rfRBbmuaM4K74XyirEBt
        3bdKNePuRK7UFfRbZL8DsWMnAinS/Nin6J9uI9cwHq1W2z0iwwD3dx8k2i25xwvt
        Nvl4b6krJS5AIgr1bDa3eNVaF4kqOl0r/OVmPhb/RYd1D44m+b6kCfijbWUlpNQD
        qpJjMNXHbnnt75kCuekTNKj6DTBZHrZDeWEHpqPKXw==
X-ME-Sender: <xms:roGIY3t5EVZ6P2nmvzYh2n3KX1wn5jjGpXvnR_UMoii3VMCt7HzlbA>
    <xme:roGIY4dX70cqC8xyYYQZj1dMJaBWiGC6MgELboTwMB-kZwhyR6iQLWrSjM5W5iWVU
    pgvIZu9hJ57oIJZQ44>
X-ME-Received: <xmr:roGIY6zmX2PjGrVQ_9LAsGEJTWJ3icluf8JDoPz0NpBX8paAhbeL7jtLsJzHakw2XJKg9g0Tz6XO_DNKI9Hurpfi1Whh19sUL2BOd8R4ZMhYlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdehgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:roGIY2Mrh4wLnI7uI2YewVbvhK3flXFU53LCcK--03OlrKntaKrl8w>
    <xmx:roGIY38vEFyFckc2pabqAl8ozfHf0tdmLRtbjwDz8NpJU2xRwCFSUA>
    <xmx:roGIY2XviimfKRkxKNJvK6RXgTp7kk1xgLBBWK0mjxWstfwn18GKsQ>
    <xmx:r4GIY8I0DibJnlROOBEyRBqM50z2I12pSKhLfsOYzZPX_ytFUHGQuQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Dec 2022 05:27:58 -0500 (EST)
Date:   Thu, 1 Dec 2022 11:27:56 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Subject: Re: [PATCH v2 01/17] drm/tests: helpers: Move the helper header to
 include/drm
Message-ID: <20221201102756.cdvxu4iryhu3rjpf@houat>
References: <20221123-rpi-kunit-tests-v2-0-efe5ed518b63@cerno.tech>
 <20221123-rpi-kunit-tests-v2-1-efe5ed518b63@cerno.tech>
 <ebe02c21-7770-0415-096e-76a839bad154@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mtc5qjwrdj4bgosl"
Content-Disposition: inline
In-Reply-To: <ebe02c21-7770-0415-096e-76a839bad154@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--mtc5qjwrdj4bgosl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Wed, Nov 30, 2022 at 09:00:03AM +0100, Javier Martinez Canillas wrote:
> On 11/28/22 15:53, Maxime Ripard wrote:
> > We'll need to use those helpers from drivers too, so let's move it to a
> > more visible location.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  drivers/gpu/drm/tests/drm_client_modeset_test.c            | 3 +--
> >  drivers/gpu/drm/tests/drm_kunit_helpers.c                  | 3 +--
> >  drivers/gpu/drm/tests/drm_modes_test.c                     | 3 +--
> >  drivers/gpu/drm/tests/drm_probe_helper_test.c              | 3 +--
> >  {drivers/gpu/drm/tests =3D> include/drm}/drm_kunit_helpers.h | 0
> >  5 files changed, 4 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/=
gpu/drm/tests/drm_client_modeset_test.c
> > index 52929536a158..ed2f62e92fea 100644
> > --- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
> > +++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> > @@ -8,12 +8,11 @@
> >  #include <drm/drm_connector.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_drv.h>
> > +#include <drm/drm_kunit_helpers.h>
>=20
> I wonder if now that this header was moved outside of the tests directory,
> if we should add stub functions in the header file that are just defined
> but do nothing if CONFIG_DRM_KUNIT_TEST isn't enabled. So that including
> it in drivers will be a no-op.
>=20
> Or do you plan to conditionally include this header file in drivers? So
> that is only included when CONFIG_DRM_KUNIT_TEST is enabled?

I'm not entirely sure. I'd expect only the tests to include it, and thus
would depend on DRM_KUNIT_TEST already. But we can always add the stubs
if it's ever included in a different context.

> Another thing that wondered is if we want a different namespace for this
> header, i.e: <drm/testing/drm_kunit_helpers.h>, to make it clear that is
> not part of the DRM API but just for testing helpers.

If there's a single header, I don't think we need to create the
directory. This is also something we can consolidate later on if needed.

> But these are open questions really, and they can be done as follow-up:
>=20
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks :)
Maxime

--mtc5qjwrdj4bgosl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY4iBrAAKCRDj7w1vZxhR
xRpOAQDHwNPpAQkoE6hXFx/5LBWCsUpiuUg3V17tLDsBtosnuAD/TKCoP+W/vHA/
r8y7Tk1Pv3JAJ6pNY93sYVLHX2HmKQM=
=Kavk
-----END PGP SIGNATURE-----

--mtc5qjwrdj4bgosl--
