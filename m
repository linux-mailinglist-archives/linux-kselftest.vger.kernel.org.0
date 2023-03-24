Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1565E6C7E5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 14:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCXNCP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 09:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjCXNCO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 09:02:14 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A011F933;
        Fri, 24 Mar 2023 06:02:12 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D8A3932009BB;
        Fri, 24 Mar 2023 09:02:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 24 Mar 2023 09:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1679662929; x=1679749329; bh=i4
        Sd9FtRMRz4lgXnHV+fiW4lqHFaGSNLJzu4glbHTgQ=; b=DN3NNdtp8h4tk5bncu
        svJEXU2VHobdvxqJDWu1VjfO6lc3ej6/vpvrob4Hi8RzHeiO/zrHzJXzGBt1NVH6
        VyPu5pixEPIhgM2q9C+D0Dxx5ZoWxUG2esaKtN1w8XXQiW0hb4bkP6ccMA52DcQ6
        32VHfe/Jt6zO+RKHbdm9vu/6frnijJKQb07KNcc2I7bb78U/iUwJ3cr2n6eRVaj+
        80rbOZo318dG+pVgXGIDB99qjDgkKHbl67oNyFynp2qAn63H8SloAM19GKvJWQpo
        OI+R+q+6GA3BJFmRi8eGY9Y0ZnXK5gle2Gqs4xh17HCybHfJupzCpa7wOvqbtc7H
        fRaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679662929; x=1679749329; bh=i4Sd9FtRMRz4l
        gXnHV+fiW4lqHFaGSNLJzu4glbHTgQ=; b=Mbrf0MccSZkz8u0XECmu0/ek/WA1u
        vxZoopAC943QffS/97KSfcbBt4FaGPP5EKB4jUHJKW7500CK9Ft2M+7ee/oNjtKf
        UcN/HYHKQDHyosVWOWkMoZYuyxkJQbowrsRcE/KFA3zYfxXqrpehpirlnTiyHGIh
        vBKbmCnM4698F9BAba728z6x2zUqJv//woe0daaDRIbRq/V80BJxfxgX6hwrLzz0
        SbreWfCvTkaoTZHlvGsynFRRrivh0Y8sYy+4EEFOTWpGsJhxJvztZ9+GFn9NIv5B
        x/wsAgT2AEtKK55SYNkm23AxrIlS/TLvTLnrv+PmnpJgPwFTQ1BhyYREg==
X-ME-Sender: <xms:UJ8dZBhutbhj4x1UZOfQYVmmbDAupOAdB1KH7qnduMv0FaUzzQESCQ>
    <xme:UJ8dZGCMPzw_DYF1uafquJjmcEvv74Uih5Odn1Wa-SD2llWrh0TVLBn1pz8JWWtnH
    ATKknx2j45aKMKrjCg>
X-ME-Received: <xmr:UJ8dZBFdDV9zJ5_jjrnHGAzxFEKGBHR4O29iU2xsOsOh_2DPP7HWgv5CsGBYH935lopnlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtleekjeeiudefvdfhieffteelhfeivdeliefgieeugffhvdelieffjeei
    geetjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:UJ8dZGRS3UhGkNnIG-iyIQijDXnkO33N5VBdVA_N8cibP5BGsiUPZg>
    <xmx:UJ8dZOywtcbBI0AXrUZJPKPfCgOYFhZAjJhixoV3yGowI246G_2f_w>
    <xmx:UJ8dZM74xhq2LlcbhtbwyJYOr6kkigNW4tBqCxLV7eCJjZyKCnX4HQ>
    <xmx:UZ8dZKH6S-dCRsWG0CJmgjtV-QD7V7N70meP6a7YoKMOI3qaCjM--w>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 09:02:08 -0400 (EDT)
Date:   Fri, 24 Mar 2023 14:02:06 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <20230324130206.di2jatakyjzbtbbz@houat>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com>
 <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
 <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com>
 <20230324123632.rtb52jh6zeopjwht@houat>
 <ZB2a291P5abeah6s@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ak7lv2fpcwgtx3p"
Content-Disposition: inline
In-Reply-To: <ZB2a291P5abeah6s@kroah.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--6ak7lv2fpcwgtx3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 01:43:07PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 24, 2023 at 01:36:32PM +0100, Maxime Ripard wrote:
> > On Thu, Mar 23, 2023 at 11:21:58AM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Mar 23, 2023 at 11:12:16AM +0100, Maxime Ripard wrote:
> > > > On Wed, Mar 22, 2023 at 07:57:10PM +0100, Greg Kroah-Hartman wrote:
> > > > > > > > +/**
> > > > > > > > + * test_kunit_helper_alloc_device - Allocate a mock device=
 for a KUnit test
> > > > > > > > + * @test: The test context object
> > > > > > > > + *
> > > > > > > > + * This allocates a fake struct &device to create a mock f=
or a KUnit
> > > > > > > > + * test. The device will also be bound to a fake driver. I=
t will thus be
> > > > > > > > + * able to leverage the usual infrastructure and most nota=
bly the
> > > > > > > > + * device-managed resources just like a "real" device.
> > > > > > >=20
> > > > > > > What specific "usual infrastructure" are you wanting to acces=
s here?
> > > > > > >=20
> > > > > > > And again, if you want a fake device, make a virtual one, by =
just
> > > > > > > calling device_create().
> > > > > > >=20
> > > > > > > Or are you wanting to do "more" with that device pointer than
> > > > > > > device_create() can give you?
> > > > > >=20
> > > > > > Personally, I was (am) only interested in devm_ unwinding. I gu=
ess the
> > > > > > device_create(), device_add(), device_remove()... (didn't study=
 this
> > > > > > sequence in details so sorry if there is errors) could've been =
sufficient
> > > > > > for me. I haven't looked how much of the code that there is for=
 'platform
> > > > > > devices' should be duplicated to support that sequence for test=
ability
> > > > > > purposes.
> > > > >=20
> > > > > Any device can access devm_ code, there's no need for it to be a
> > > > > platform device at all.
> > > >=20
> > > > Sure but the resources are only released if the device is part of a=
 bus,
> > > > so it can't be a root_device (or bare device) either
> > >=20
> > > The resources are not cleaned up when the device is freed no matter if
> > > it's on a bus or not?  If so, then that's a bug that needs to be fixe=
d,
> > > and tested :)
> >=20
> > Please have a look at:
> > https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb=
@houat/
> >=20
> > I couldn't get an answer on whether it was considered a bug or not last
> > time, but as you can see there's a clear difference between a root
> > device and a platform device that has probed when it comes to resource
> > cleanup.
>=20
> Great, testing shows there are bugs!  :)

I mean, it wasn't clear to me that it was indeed a bug or the intent
behind devm was that it would only work when probed. Both seemed
reasonable.

> That's a great start of a test, how about submitting that in a way that
> I can test it and we can go from there?

Ack.

I guess I'd need to arrange them somewhat differently for it to be
useful and merge-able.

How would you prefer them to be submitted, in two different files
testing both the root devices and platform devices?

Maxime

--6ak7lv2fpcwgtx3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZB2fTgAKCRDj7w1vZxhR
xdpfAP9oZTDAtRR3OFWjK4nljjNoN/eXZOhn5F8nK2vPmIi12AEA8rwLGWNlgYU4
xB/9WOIYtMrwSjbMV2tSTIXRl11ebQ0=
=tbw2
-----END PGP SIGNATURE-----

--6ak7lv2fpcwgtx3p--
