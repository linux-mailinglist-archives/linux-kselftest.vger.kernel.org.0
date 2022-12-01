Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A3063F128
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 14:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiLANEy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 08:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiLANEh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 08:04:37 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E097B9E474;
        Thu,  1 Dec 2022 05:03:50 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id E32BA5803D4;
        Thu,  1 Dec 2022 08:03:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 01 Dec 2022 08:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1669899829; x=1669907029; bh=WNe2ZaoFKQ
        D4oljvp7EpbhZ90+6/RSN0zGkVNyucd3E=; b=PiY7ewqeYTYUyhKSenMQ1lm1h+
        wDE0YujOYyzgUtA9SIpAK/QYIq12uaQQb7gwtxutN0C39O/UJVc/Hy9EKt3eXfid
        abLLarhbQWHb46EE2b7jjLfKKx9C9AQRZHE8d8SUhTss5HnXFe8JVA/xuHCpPtJu
        Pk/EGC8VkA4ImFxzhsL9lPKp8lu5I32N3a2xCKZbsLuqfGSQIyBrvJ+5UoG9reUc
        gKHZtokIHwBXeatVXex1/9FvRqGJfoYqzqRoQ2iTXLk5ryI9R2rVv4Dj0fy09bZF
        VvJKHPI1T0dJIxfx9+VJ8tUT+BLlq8aCDlB4jbuBpTGGyYzEgmzoLWlfuRrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669899829; x=1669907029; bh=WNe2ZaoFKQD4oljvp7EpbhZ90+6/
        RSN0zGkVNyucd3E=; b=aAJII91dFUut4+tFeFDIaHX/zw1TswvxVzirq5xfC9sI
        4DRkGBYNW4NQrQbo81OubswB53Vkr517gNeAoVcoqHcjeY9iMFpeP7TZUsYWxkwa
        JaLwouDclYT+rEnP+JQZwF8Zt5Qx2wjbtQ36XnjejzbWTRXyGJ0PpB6nxLDFWDZK
        u17a9KhSO++J/w6+pJgI+BkB1objEr6QwZaKGFbhvVfBEiIQVEP5jQaN8Xehyf0w
        Vmnigb05vA+EooAus7koUwMqaiWDoP147VAXWkA+cjEFebkFSVRHfKDjwjZbRssL
        u7MB8cafidTaIVo/p5TXKoLTq0B4UByrMm5dMWMzpw==
X-ME-Sender: <xms:NaaIY0zKMydcp742u4piLoUn2nVmWv2VtZJXkFrf9Nzsq3uMHZNFKA>
    <xme:NaaIY4SG0-Z0uYTAntKh6-bVjlD64kJaVC79_a68zu4KXouj84zSqnZ_bzGDZaykm
    zmSQsjSP25G45h7MJY>
X-ME-Received: <xmr:NaaIY2U2-8Nni73vnFjAwTD7Sbb94JQMW3noJVIHEjlOi_BDpCXnsM10VFfOMvTZLEu1C194MxRKx1Z_LjNxA6rhgyl4y3TO5SQ_L6eDVdNOew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleejuefggeevteelveekteffgeduveeiteeiueegueegiedvtdejjedvfeef
    tefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:NaaIYyhT1CT3FzKzlTfkLLwYoznI71Dh_zUCGbAn_dbaig-Uy5cxPg>
    <xmx:NaaIY2AcQQbBj2Q5acelH2UUf2tx9bBvfw2PNC0NoPyz4cqbkwfL8Q>
    <xmx:NaaIYzLxnRIJogEa25sEETalVvr4mHp--x6OzM94fkIy5qK0NSNRjQ>
    <xmx:NaaIYzM7IqG8zbbp3GPImPxmK1wzC7ls6Hpwi4dJB_XcJlPIqwP_hA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Dec 2022 08:03:48 -0500 (EST)
Date:   Thu, 1 Dec 2022 14:03:46 +0100
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
Subject: Re: [PATCH v2 15/17] drm/vc4: tests: Introduce a mocking
 infrastructure
Message-ID: <20221201130346.by6zzfdbuyidwekb@houat>
References: <20221123-rpi-kunit-tests-v2-0-efe5ed518b63@cerno.tech>
 <20221123-rpi-kunit-tests-v2-15-efe5ed518b63@cerno.tech>
 <98d47486-d04c-b81a-6ae4-fa7f62828a0e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jln5wp2b5zhcs7vh"
Content-Disposition: inline
In-Reply-To: <98d47486-d04c-b81a-6ae4-fa7f62828a0e@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--jln5wp2b5zhcs7vh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Wed, Nov 30, 2022 at 10:59:37AM +0100, Javier Martinez Canillas wrote:
> On 11/28/22 15:53, Maxime Ripard wrote:
> > In order to test the current atomic_check hooks we need to have a DRM
> > device that has roughly the same capabilities and layout that the actual
> > hardware. We'll also need a bunch of functions to create arbitrary
> > atomic states.
> >=20
> > Let's create some helpers to create a device that behaves like the real
> > one, and some helpers to maintain the atomic state we want to check.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
>=20
> [...]
>=20
> > +
> > +config DRM_VC4_KUNIT_TEST
> > +	bool "KUnit tests for VC4" if !KUNIT_ALL_TESTS
> > +	depends on DRM_VC4 && KUNIT
>=20
> shouldn't this depend on DRM_KUNIT_TEST instead ?
>=20
> [...]

You're right, but the rework suggested by Ma=EDra will add a select to the
helpers Kconfig symbol there so we should be safe.

> > +static struct vc4_dev *__mock_device(struct kunit *test, bool is_vc5)
> > +{
> > +	struct drm_device *drm;
> > +	const struct drm_driver *drv =3D is_vc5 ? &vc5_drm_driver : &vc4_drm_=
driver;
> > +	const struct vc4_mock_desc *desc =3D is_vc5 ? &vc5_mock : &vc4_mock;
> > +	struct vc4_dev *vc4;
>=20
> Since it could be vc4 or vc5, maybe can be renamed to just struct vc_dev =
*vc ?

vc4_dev is the main structure in the driver for the DRM device, so we
can't rename it easily.

Generally speaking the driver was (and still is) called vc4 after the IP
name in the original RaspberryPi SoC.

There's been a new generation since, but we supported it through the vc4
driver. Even if it's a bit ambiguous, vc4 refers to both the driver name
and is used extensively in the infrastructure, but also refers to the
initial generation we supported. vc5 is only the new generation.

I'm not sure removing the number would be less confusing.

> > +struct vc4_dummy_plane *vc4_dummy_plane(struct kunit *test,
> > +					struct drm_device *drm,
> > +					enum drm_plane_type type)
> > +{
> > +	struct vc4_dummy_plane *dummy_plane;
> > +	struct drm_plane *plane;
> > +
> > +	dummy_plane =3D drmm_universal_plane_alloc(drm,
> > +						 struct vc4_dummy_plane, plane.base,
> > +						 0,
> > +						 &vc4_dummy_plane_funcs,
> > +						 vc4_dummy_plane_formats,
> > +						 ARRAY_SIZE(vc4_dummy_plane_formats),
> > +						 NULL,
> > +						 DRM_PLANE_TYPE_PRIMARY,
> > +						 NULL);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dummy_plane);
> > +
> > +	plane =3D &dummy_plane->plane.base;
> > +	drm_plane_helper_add(plane, &vc4_dummy_plane_helper_funcs);
> > +
> > +	return dummy_plane;
> > +}
>=20
> I guess many of these helpers could grow to be generic, like this one sin=
ce
> most drivers support the DRM_FORMAT_XRGB8888 format for their primary pla=
ne.

Yeah, that's what I'd expect at some point as well :)

> > +extern const struct vc4_pv_data bcm2835_pv0_data;
> > +extern const struct vc4_pv_data bcm2835_pv1_data;
> > +extern const struct vc4_pv_data bcm2835_pv2_data;
> > +extern const struct vc4_pv_data bcm2711_pv0_data;
> > +extern const struct vc4_pv_data bcm2711_pv1_data;
> > +extern const struct vc4_pv_data bcm2711_pv2_data;
> > +extern const struct vc4_pv_data bcm2711_pv3_data;
> > +extern const struct vc4_pv_data bcm2711_pv4_data;
> > +
>=20
> Maybe the driver could expose a helper function to get the pixelvalve data
> and avoid having to expose all of these variables? For example you could
> define an enum vc4_pixelvalve type and have something like the following:
>=20
> const struct vc4_pv_data *vc4_crtc_get_pixelvalve_data(enum vc4_pixelvalv=
e pv);
>=20
> All these are small nits though, the patch looks great to me and I think =
is
> awesome to have this level of testing with KUnit. Hope other drivers foll=
ow
> your lead.

I'm not sure. It adds an interface for something we don't really need,
so I'm not sure if it's really beneficial.

David pointed at that patch though, which seems more promising:
https://lore.kernel.org/linux-kselftest/20221102175959.2921063-1-rmoar@goog=
le.com/

Maxime

--jln5wp2b5zhcs7vh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY4imMgAKCRDj7w1vZxhR
xcrRAQDU2AjAdKl8Lz9EVmvZL0MtLMtF6tuSl/Al2cKN4Nlc0wD/cRAIduKDlxZi
pjemK6JK1GLDi6UiLchHE6nBdkPySw4=
=F2NM
-----END PGP SIGNATURE-----

--jln5wp2b5zhcs7vh--
