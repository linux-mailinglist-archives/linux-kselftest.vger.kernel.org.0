Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260906CF392
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 21:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjC2Trh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 15:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjC2TrV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 15:47:21 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1197ED1;
        Wed, 29 Mar 2023 12:46:13 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 78BFA32007F1;
        Wed, 29 Mar 2023 15:46:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 29 Mar 2023 15:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1680119171; x=1680205571; bh=zo
        jQa1YLfWakbyG6by6LrH71dsPpXEzFqhE+LyL8iNE=; b=f94NQcHS7VQkFwhd2T
        lQmPb/+vs32rNGXlq8MK65yIssXnmd7EmKp+o/fL01cI0ueUUZ9vYhypWMA1T0rB
        jCDrorQRxAG03EWO6IunfBk66GlAxo4S6MeNZwpEVYBjXBy+J0f+G+xau2ojokju
        ZSSX0vwaqQh1dLcVHFBpcOZlVMpUeab5LYVEAEEGPjV2SrSGY9fVeFvObpnOyd0M
        vqgNJRgHx3phaHNOIS3hW4/ghEghuyZYhkxqYFKyQ15VSyk1CMbLoXbr3va0iCEt
        CDZOFluulLlgjhBzjYrX8HGEZ912MpH/WzdOW4qN/6KZ6Ap3B+mIfuG5CxSlWge8
        7B0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680119171; x=1680205571; bh=zojQa1YLfWakb
        yG6by6LrH71dsPpXEzFqhE+LyL8iNE=; b=fu8eitjJyrwP8Dm2aWwPOnMFuesE7
        IvCqhd9eduPE7dKnPswR8K9JADc/nTiA9hL0aaPZxt2BcXUhU3b15xsCgrvX2PCc
        yDWM43mhtALwBlI6Y56e2iQ20CjGrgPHV7pPNPAtT/z9qzZCnmZmFyzjub0B8iDN
        9Lxu+0TfzEOTULOEnu9mIQIA9niIWO9sszInE06a6PGvtTGxbbDF1Bg5Ur+eHcXj
        T3ZuI0zTfUG0mMakfBv9trI65wO8syiqyLcqHwu/NSVBYF0O67476B/ot2hrPA/6
        CJjLZCX/9bi1nHv0EySZqdq/VdGPgsgEzelieKImuNJ5AbWok53xftUOQ==
X-ME-Sender: <xms:gpUkZAQvLCQskVD20nQyHx97BwU8jejN8-2xyh66OY7_I4czTEbSWA>
    <xme:gpUkZNy4szB7l33j11gvKjWuc77tAfd41f8hYWdm630RZmAcn_rUl3kgOYxAt_PZY
    ayTewqoQr-lYmxecdM>
X-ME-Received: <xmr:gpUkZN21y14C_7xnOwqXxBC0Vd0oQpp9sGs7Zwjy3m0KTCxPzd1xsWumGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehiedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheptdelkeejiedufedvhfeiffetlefhiedvleeigfeiuefghfdvleeiffej
    ieegteejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:g5UkZEBpwPSEZ_8uEFhbK1MofzLIozz1zdNDcuvuk_srfLeWZ6OzqQ>
    <xmx:g5UkZJgUwNdYM1HRkmgIZbZlFSBNil6tmi1ffKI2r188jCYr7hhZtA>
    <xmx:g5UkZArxT7xn2Tmoo5oOug5xquSGRfJTe_7S3Ho2yZ7wvmhxprjRpQ>
    <xmx:g5UkZMTMqIuUPOQPjOfr1WGA1wHIZ8OMuAbxrPeH4SkG1bjabdOjlg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Mar 2023 15:46:10 -0400 (EDT)
Date:   Wed, 29 Mar 2023 21:46:09 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <20230329194609.7u2hgidxdk34emsf@penduick>
References: <ZBtPhoelZo4U5jwC@kroah.com>
 <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com>
 <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
 <20230323122925.kqdnomr7i46qnyo4@houat>
 <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
 <20230323163639.xtwpid2uunwnzai4@houat>
 <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
 <20230324123157.bbwvfq4gsxnlnfwb@houat>
 <20230325175044.7bee9e7d@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l6s2nrpwzcaaz3jq"
Content-Disposition: inline
In-Reply-To: <20230325175044.7bee9e7d@jic23-huawei>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--l6s2nrpwzcaaz3jq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 25, 2023 at 05:50:44PM +0000, Jonathan Cameron wrote:
> On Fri, 24 Mar 2023 13:31:57 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> > On Fri, Mar 24, 2023 at 08:11:52AM +0200, Matti Vaittinen wrote:
> > > On 3/23/23 18:36, Maxime Ripard wrote: =20
> > > > On Thu, Mar 23, 2023 at 03:02:03PM +0200, Matti Vaittinen wrote: =
=20
> > > > > On 3/23/23 14:29, Maxime Ripard wrote: =20
> > > > > > On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
> > > > > >=20
> > > > > > This is the description of what was happening:
> > > > > > https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiy=
tl@houat/ =20
> > > > >=20
> > > > > Thanks Maxime. Do I read this correcty. The devm_ unwinding not b=
eing done
> > > > > when root_device_register() is used is not because root_device_un=
register()
> > > > > would not trigger the unwinding - but rather because DRM code on =
top of this
> > > > > device keeps the refcount increased? =20
> > > >=20
> > > > There's a difference of behaviour between a root_device and any dev=
ice
> > > > with a bus: the root_device will only release the devm resources wh=
en
> > > > it's freed (in device_release), but a bus device will also do it in
> > > > device_del (through bus_remove_device() -> device_release_driver() =
->
> > > > device_release_driver_internal() -> __device_release_driver() ->
> > > > device_unbind_cleanup(), which are skipped (in multiple places) if
> > > > there's no bus and no driver attached to the device).
> > > >=20
> > > > It does affect DRM, but I'm pretty sure it will affect any framework
> > > > that deals with device hotplugging by deferring the framework struc=
ture
> > > > until the last (userspace) user closes its file descriptor. So I'd
> > > > assume that v4l2 and cec at least are also affected, and most likely
> > > > others. =20
> > >=20
> > > Thanks for the explanation and patience :)
> > >  =20
> > > >  =20
> > > > > If this is the case, then it sounds like a DRM specific issue to =
me. =20
> > > >=20
> > > > I mean, I guess. One could also argue that it's because IIO doesn't
> > > > properly deal with hotplugging. =20
> > >=20
> > > I must say I haven't been testing the IIO registration API. I've only=
 tested
> > > the helper API which is not backed up by any "IIO device". (This is f=
ine for
> > > the helper because it must by design be cleaned-up only after the
> > > IIO-deregistration).
> > >=20
> > > After your explanation here, I am not convinced IIO wouldn't see the =
same
> > > issue if I was testing the devm_iio_device_alloc() & co. =20
> >=20
> > It depends really. The issue DRM is trying to solve is that, when a
> > device is gone, some application might still have an open FD and could
> > still poke into the kernel, while all the resources would have been
> > free'd if it was using devm.
> >=20
> > So everything is kept around until the last fd is closed, so you still
> > have a reference to the device (even though it's been removed from its
> > bus) until that time.
> >=20
> > It could be possible that IIO just doesn't handle that case at all. I
> > guess most of the devices aren't hotpluggable, and there's not much to
> > interact with from a userspace PoV iirc, so it might be why.
>=20
> Lars-Peter Clausen (IIRC) fixed up the IIO handling of the similar cases a
> long time ago now. It's simpler that for some other subsystems as we don't
> have as many interdependencies as occur in DRM etc.
>=20
> I 'think' we are fine in general with the IIO approach to this (I think we
> did have one report of a theoretical race condition in the remove path th=
at
> was never fully addressed).
>=20
> For IIO we also have fds that can be open but all accesses to them are pr=
oxied
> through the IIO core and one of the things iio_device_unregister() or the=
 devm
> equivalent does is to set indio_dev->info =3D NULL  (+ wake up anyone wai=
ting on
> data etc). Alongside removing the callbacks, that is also used as a flag
> to indicate the device has gone.

Sorry if it came as trying to put IIO under a bad light, it certainly
wasn't my intention. I was trying to come up with possible explanations
as to why IIO's design was simpler than DRM is :)

> Note that we keep a reference to the struct indio_dev->dev (rather that t=
he
> underlying device) so that is not freed until the last fd is closed.
> Thus, although devm unwinding has occurred that doesn't mean all the data
> that was allocated with devm_xx calls is cleared up immediately.

I'm not sure I get that part though. devm unwinding can happen even if the =
refcount is > 1

Maxime

--l6s2nrpwzcaaz3jq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZCSVgQAKCRDj7w1vZxhR
xaenAP950SFm/YscP/OZNbX+eEpJynPuAwfDyd1PtJuqNfChOQD+LJmD189z9X+y
U5CselZugPJllYdyXVUeK0Apq+k7KAE=
=+cge
-----END PGP SIGNATURE-----

--l6s2nrpwzcaaz3jq--
