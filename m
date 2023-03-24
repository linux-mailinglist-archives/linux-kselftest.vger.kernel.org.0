Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CF06C7E20
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 13:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjCXMgj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 08:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCXMgi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 08:36:38 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C41312F39;
        Fri, 24 Mar 2023 05:36:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CC28532004ED;
        Fri, 24 Mar 2023 08:36:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 24 Mar 2023 08:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1679661394; x=1679747794; bh=af
        dOnuzoGC2hJ2+nQwyk48eOOUaDI/2Z1f/itKfGaWo=; b=Zj2H+tK7F7eO6I+zvE
        0xVguDgmSQp+fo9etx0v3GaZgfiH85nQGr5z9g1OMrOdDnexZMyNHzMxKhLLKsDm
        ifGwXC026mGH0O9cm+BLsavrgA103pCTDR9B59UcQHDyxM7CPiA6CJWZCCzPBmNy
        VpLMxiJ1aBhVCEI7y4Cmvczv8YFwAO4xNfjIotkxJd2btMBz5SgXsNJY1e69ZOzO
        deyZTnsB28JQrnCXAnRDmlMms5ABY00nCAovD35rRtUVanlo4kPHcEFwvPuQ78Sm
        vh9seDcht1PdF95NXi0k4/GmSLWNIfEx4V0G8IaV7Jaj1CPHSHNEENfizOh1rFbN
        8kBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679661394; x=1679747794; bh=afdOnuzoGC2hJ
        2+nQwyk48eOOUaDI/2Z1f/itKfGaWo=; b=TsViZBBdp8szx3UJ/rk9bbUqlm5MJ
        x0JO7cr6ESljPUGRp8wrccdDHrfGqVHZXIgdC0ZLv2wl4/tUJCziAL24ZsTjaLqY
        Z9cJ8GkNCpcPh92wbacV5ViUVifhQsgyzX2eVAvZW9SP91NWJcFUrE4CW4yQfqzE
        t9SD/X+js0QABLUl5gdF6BANZOqkE8zk+g99DKTQmD/L+KJn4t1dvrN8+d59LKVo
        U98r83luTqlpisBI9O4LkWpXcWpRPo/indLfZQkM3cLVSdzqU4S2VP8ZGQK93nYm
        t4wAsOleXFQ15zlHelsf9s3CzfJRmVkHeyOctHHvHQgbi7drYWL3MxRwQ==
X-ME-Sender: <xms:UpkdZJXC2rJfLBhpT85JkFzMtrMLT20Y5jdvpVc6HCAvQw0wMLxK_Q>
    <xme:UpkdZJnTSJEL_ZnfSnoFpELQUX2tuCks1cf2616C_Ry988YWGjAB-Iiu0eVD-l_9c
    gdFHr4iy9Go_RGjMpY>
X-ME-Received: <xmr:UpkdZFbmiQBtDjWoLOncaSoCizF_2mZq1MrRoMSOHbutz6EgAm41MEyrBD3K0nRoo4FfQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtleekjeeiudefvdfhieffteelhfeivdeliefgieeugffhvdelieffjeei
    geetjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:UpkdZMXC00_mVk2yAUhFbKAUaV7x4_hW1MbTNPt0BTw_IN90Cy5sjg>
    <xmx:UpkdZDmwBt6adSMoYyrg-qjcK3iMCK6Q3Yk9vICUD1l_1pQJT1vIgA>
    <xmx:UpkdZJfanu4cKae9JEbV1cB2suSQwtNzgCdmslux-L0VZS1EkIpeRg>
    <xmx:UpkdZG6kVxdOTyzXkL-wmNF-1owK03Qk2mVDToq5rvfMoVtYBGxkOg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 08:36:33 -0400 (EDT)
Date:   Fri, 24 Mar 2023 13:36:32 +0100
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
Message-ID: <20230324123632.rtb52jh6zeopjwht@houat>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com>
 <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
 <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ixhyyonac24t3jtj"
Content-Disposition: inline
In-Reply-To: <ZBwoRgc2ICBJX/Lq@kroah.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ixhyyonac24t3jtj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 11:21:58AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 23, 2023 at 11:12:16AM +0100, Maxime Ripard wrote:
> > On Wed, Mar 22, 2023 at 07:57:10PM +0100, Greg Kroah-Hartman wrote:
> > > > > > +/**
> > > > > > + * test_kunit_helper_alloc_device - Allocate a mock device for=
 a KUnit test
> > > > > > + * @test: The test context object
> > > > > > + *
> > > > > > + * This allocates a fake struct &device to create a mock for a=
 KUnit
> > > > > > + * test. The device will also be bound to a fake driver. It wi=
ll thus be
> > > > > > + * able to leverage the usual infrastructure and most notably =
the
> > > > > > + * device-managed resources just like a "real" device.
> > > > >=20
> > > > > What specific "usual infrastructure" are you wanting to access he=
re?
> > > > >=20
> > > > > And again, if you want a fake device, make a virtual one, by just
> > > > > calling device_create().
> > > > >=20
> > > > > Or are you wanting to do "more" with that device pointer than
> > > > > device_create() can give you?
> > > >=20
> > > > Personally, I was (am) only interested in devm_ unwinding. I guess =
the
> > > > device_create(), device_add(), device_remove()... (didn't study this
> > > > sequence in details so sorry if there is errors) could've been suff=
icient
> > > > for me. I haven't looked how much of the code that there is for 'pl=
atform
> > > > devices' should be duplicated to support that sequence for testabil=
ity
> > > > purposes.
> > >=20
> > > Any device can access devm_ code, there's no need for it to be a
> > > platform device at all.
> >=20
> > Sure but the resources are only released if the device is part of a bus,
> > so it can't be a root_device (or bare device) either
>=20
> The resources are not cleaned up when the device is freed no matter if
> it's on a bus or not?  If so, then that's a bug that needs to be fixed,
> and tested :)

Please have a look at:
https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb@hou=
at/

I couldn't get an answer on whether it was considered a bug or not last
time, but as you can see there's a clear difference between a root
device and a platform device that has probed when it comes to resource
cleanup.

Maxime

--ixhyyonac24t3jtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZB2ZUAAKCRDj7w1vZxhR
xTziAQDzlNBv8r3FNR5xvsqs6kFN7cJ9NsebxwnXFMkkCLheBQEA5tvTfjjuyRCb
JuPrsPFwK6lStlKQEqRnhY5AgTCOxgM=
=Neh7
-----END PGP SIGNATURE-----

--ixhyyonac24t3jtj--
