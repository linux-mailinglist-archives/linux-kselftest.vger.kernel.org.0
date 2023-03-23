Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA366C647A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 11:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjCWKMX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 06:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjCWKMW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 06:12:22 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCDB12BC4;
        Thu, 23 Mar 2023 03:12:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1A02932001C6;
        Thu, 23 Mar 2023 06:12:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 23 Mar 2023 06:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1679566338; x=1679652738; bh=cZ
        xHKXBZ21bZ6K9A2HYjfRbp4aeJPjlsC5O/xK/dOIE=; b=P/ahRNyon56M8IZuK1
        ywYfTgXwzwN+dPwd8hhNDADBtCjZdyQhRFlXHY10himQfH+gUi1Z9mePUo56K/7p
        gMQ2e9kqE9mTi59ucP12oxgpFPun4WsDBnuYq7+rngBmpUC6hhsX1Ttc35/T4JQ3
        pgU9iQ/CHz9b6WdDY5ocFUazQXkMlBoa3DUSaqsvG2n9PdtCFSy2NxuRd6JPWzav
        1Nw3jyuysE5ayy6KH/020i/SJP5Vy9ObKD+SutpmOPaS6tnJKxJ4m+MviYUGOqTy
        ElOIltjCcQfR4Y0Z7E93pWgX2vnfC2EUx9qwAqURSg450qcW5z8lpUvMDREUvVJs
        MLng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679566338; x=1679652738; bh=cZxHKXBZ21bZ6
        K9A2HYjfRbp4aeJPjlsC5O/xK/dOIE=; b=KfcP3+xUf+8DB0z3agWxrRSu95Wmv
        TrxhgBRBsA+AeDCv9SuhqXdu9dWU+vANITnezTsq2nGvEY8AIZEpvkWjwEV0iWSV
        Bqo0Lks+fj9cyXRthBSvIDayKbm0SvYs/r+bJd2TBcOn7HYOQuMShYWiG2N/2KaJ
        G27cdjAc1sqRiGlfRxnFhqNYLdKxXWpeIxwHNZSzRme05QuKxFbA5OwiACHwStUt
        7zEpA0ojGHrHstbzW6Ida0i+zVpll4ShGevbNuyW2hMDj4W9faVQ1j6UVIzUvHkz
        yAOHdQ//Eh/4P7c0V7gsr827pNvdMevMFinVm5QBAhRahALsdT/NK05oA==
X-ME-Sender: <xms:AiYcZJn_FchdEOUBNvREqSUl4ixwDEb2mnVMn0EMghZ7rABEpoorQA>
    <xme:AiYcZE1mA4wvTfZyimKU5_KqSkg86oq2ySrggnyz7IbPgcMPQvbBYFOX3AicD4es2
    OPBzv-lt_cFuPGYrbw>
X-ME-Received: <xmr:AiYcZPoUuLfSpMGrE8UXS1DDXyV0FOq3ZkEyuhnhv9tzN-CW6l_h8X13dTr-TNfEGQ-AEOWPFommkDSVMTFFKhZ2JH3TITM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:AiYcZJn2lAONPiY-Kh8MC-e14UAAiJHBKglJohap7FvTlaTyQ8W95A>
    <xmx:AiYcZH05SptfUayg5irD02DMFMbKPFk2PnHmAlWrQz-Kd4HJB83-Jw>
    <xmx:AiYcZItkY7QjAeZ-tlWAZ5swV9Xk-KOgXylrFiT_iGzyYetej83cJw>
    <xmx:AiYcZLIfDXmhaNDWRg6c6t_9MAWMwYrm1yPErm_gUodj9uNjAjJmeA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 06:12:17 -0400 (EDT)
Date:   Thu, 23 Mar 2023 11:12:16 +0100
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
Message-ID: <20230323101216.w56kz3rudlj23vab@houat>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com>
 <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o473qzwbd5lb4d5q"
Content-Disposition: inline
In-Reply-To: <ZBtPhoelZo4U5jwC@kroah.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--o473qzwbd5lb4d5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 07:57:10PM +0100, Greg Kroah-Hartman wrote:
> > > > +/**
> > > > + * test_kunit_helper_alloc_device - Allocate a mock device for a K=
Unit test
> > > > + * @test: The test context object
> > > > + *
> > > > + * This allocates a fake struct &device to create a mock for a KUn=
it
> > > > + * test. The device will also be bound to a fake driver. It will t=
hus be
> > > > + * able to leverage the usual infrastructure and most notably the
> > > > + * device-managed resources just like a "real" device.
> > >=20
> > > What specific "usual infrastructure" are you wanting to access here?
> > >=20
> > > And again, if you want a fake device, make a virtual one, by just
> > > calling device_create().
> > >=20
> > > Or are you wanting to do "more" with that device pointer than
> > > device_create() can give you?
> >=20
> > Personally, I was (am) only interested in devm_ unwinding. I guess the
> > device_create(), device_add(), device_remove()... (didn't study this
> > sequence in details so sorry if there is errors) could've been sufficie=
nt
> > for me. I haven't looked how much of the code that there is for 'platfo=
rm
> > devices' should be duplicated to support that sequence for testability
> > purposes.
>=20
> Any device can access devm_ code, there's no need for it to be a
> platform device at all.

Sure but the resources are only released if the device is part of a bus,
so it can't be a root_device (or bare device) either

Maxime

--o473qzwbd5lb4d5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZBwmAAAKCRDj7w1vZxhR
xcNBAQDSXxwFY9SnlOiifKsShUzZ9vn3t2jQGwBUwDob7I57jAD/c0M4qZV5QxOp
2nfAsQutY88p59v6z9OzS6W/PqsxaQo=
=NWug
-----END PGP SIGNATURE-----

--o473qzwbd5lb4d5q--
