Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696396C684E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 13:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCWM3b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 08:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjCWM3a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 08:29:30 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F30CA1E;
        Thu, 23 Mar 2023 05:29:29 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CE6AE5C01B7;
        Thu, 23 Mar 2023 08:29:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 23 Mar 2023 08:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1679574568; x=1679660968; bh=vA
        YrlcWuUhUxbL6Q5rhrK6zmUhSL1yfqxYOTLIcIxe0=; b=lvZmloBoNenDhXuI1o
        iYbpPMDTgd6+a3ftTPuxxGrjmdxuBFFLRCyqbqdnDsZq+R+F23EgqkyL0mwSbVNX
        YHPepPHJ4KeG/u6/SgqOqGiuKK3KOXSjbaTXvt1KqKkQcDvFPa1CmtCy9unh6pBJ
        GgcvEYl+UiPnNjOuill9CwhYi769xroDLzx23bOEtxGWQzlxx54VbFb0/e8QYcEj
        rbk6QARenbIjocVfUg8NqQHcMbCdd+IIIaFo75yB8iCEhDhsGL6oPqMlW4RmqmgQ
        4huuaOUefsCUoEFFBpF2vQh4K9Z8Zp0LN+Fns9M0fJxulDO79p1a5e6qZ34n4MUD
        7cPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679574568; x=1679660968; bh=vAYrlcWuUhUxb
        L6Q5rhrK6zmUhSL1yfqxYOTLIcIxe0=; b=UEEeY1xk5yftWveYFKURyDYXNwiBe
        GvMhcuLcgmnhPyw7yxIR+yfhAdLcBsVLnBTr7tLQIWMmjOgqAGKrcUwyTBn6Ejgs
        llKbYPJDZhUH2CzmXvEvvNg7QaAqxVdELC8AVPTV9aOYJVIuBfmyvGcqmcccjwpJ
        cb6O5J0FQD/O0l86U5WGhkGLF9flRlTBD/LU+m3Fw3LqCPMN4JY+dJn49Wal4OK4
        Z43DcRML/0ivp5hojTbK/9SWpeWPnn6bAFItfK6UeGKG4TWWzhjUckSkzYUZ35ZO
        161rBNdv65qo4nwM2fCUyDrgb9ovtj7cOqWoPC4SuLPx5ynjN9KM+AdoA==
X-ME-Sender: <xms:KEYcZCpScZkETov7v0D6JIg9gMT4kko36NwhAyXDwfahW3fzF3kkiA>
    <xme:KEYcZArUv5cBbnYv-GFboLWJxhoOuBSSuNmt5zK_vUQt53niJoYE6MovmaW9niZoJ
    iCMihOCnaBVtDtJQH0>
X-ME-Received: <xmr:KEYcZHOcxhHF4AjWlRUcG8L_ckfhr1XPLErXB7zEYlPPgPnro94zfaKHLVQ9Ehf7hMeszvSqYtQJoN1rUNkZsalN57ZT4x8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtleekjeeiudefvdfhieffteelhfeivdeliefgieeugffhvdelieffjeei
    geetjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:KEYcZB5bBzvMvlJAKUkKvTjf-6y0pcfhdGpI0zwbaiRdcmkyQiQGNw>
    <xmx:KEYcZB6E6v2l-M7AG7Csff_XvJ4p6oe5HDU_3X6mRA7P775R4_jchQ>
    <xmx:KEYcZBjRGyC1DrbT2-0VvitfABWH66Npu6TDQLxesozb7754zQDhTQ>
    <xmx:KEYcZNNOtNJs8uiCwcwa3qsQTvYIjFV8cJEZmsHQF1pUlI40VpUpSg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 08:29:27 -0400 (EDT)
Date:   Thu, 23 Mar 2023 13:29:25 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20230323122925.kqdnomr7i46qnyo4@houat>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com>
 <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
 <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com>
 <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i6dr7t7p5mo37f5n"
Content-Disposition: inline
In-Reply-To: <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--i6dr7t7p5mo37f5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
> Hi Maxime, all
>=20
> On 3/23/23 12:21, Greg Kroah-Hartman wrote:
> > On Thu, Mar 23, 2023 at 11:12:16AM +0100, Maxime Ripard wrote:
> > > On Wed, Mar 22, 2023 at 07:57:10PM +0100, Greg Kroah-Hartman wrote:
> > > > > > > +/**
> > > > > > > + * test_kunit_helper_alloc_device - Allocate a mock device f=
or a KUnit test
> > > > > > > + * @test: The test context object
> > > > > > > + *
> > > > > > > + * This allocates a fake struct &device to create a mock for=
 a KUnit
> > > > > > > + * test. The device will also be bound to a fake driver. It =
will thus be
> > > > > > > + * able to leverage the usual infrastructure and most notabl=
y the
> > > > > > > + * device-managed resources just like a "real" device.
> > > > > >=20
> > > > > > What specific "usual infrastructure" are you wanting to access =
here?
> > > > > >=20
> > > > > > And again, if you want a fake device, make a virtual one, by ju=
st
> > > > > > calling device_create().
> > > > > >=20
> > > > > > Or are you wanting to do "more" with that device pointer than
> > > > > > device_create() can give you?
> > > > >=20
> > > > > Personally, I was (am) only interested in devm_ unwinding. I gues=
s the
> > > > > device_create(), device_add(), device_remove()... (didn't study t=
his
> > > > > sequence in details so sorry if there is errors) could've been su=
fficient
> > > > > for me. I haven't looked how much of the code that there is for '=
platform
> > > > > devices' should be duplicated to support that sequence for testab=
ility
> > > > > purposes.
> > > >=20
> > > > Any device can access devm_ code, there's no need for it to be a
> > > > platform device at all.
> > >=20
> > > Sure but the resources are only released if the device is part of a b=
us,
> > > so it can't be a root_device (or bare device) either
> >=20
> > The resources are not cleaned up when the device is freed no matter if
> > it's on a bus or not?  If so, then that's a bug that needs to be fixed,
> > and tested :)
>=20
> This is strange. I just ran a test on a beaglebone black using Linux
> 6.3.0-rc2 + the IIO patches we se here (but the IIO test patch modified to
> use the root_device_register() and root_device_unregister().
>=20
> I passed the device pointer from root_device_register() to the
> devm_iio_init_iio_gts()
>=20
> // snip
>         dev =3D root_device_register(IIO_GTS_TEST_DEV);
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
>         if (IS_ERR_OR_NULL(dev))
>                 return NULL;
>=20
>         ret =3D devm_iio_init_iio_gts(dev, TEST_SCALE_1X, 0, g_table, num=
_g,
>                                     i_table, num_i, gts);
>=20
>  - and saw the tables for available scales allocated:
>=20
>  if (gts.num_avail_all_scales)
>                 pr_info("GTS: table allocation succeeded\n");
>         else
>                 pr_info("GTS: table allocation failed\n");
>=20
>         pr_info("gts: num_avail_all_scales %d\n", gts.num_avail_all_scale=
s);
>=20
> (this printed:
> [   52.132966]     # Subtest: iio-gain-time-scale
> [   52.132982]     1..7
> [   52.157455] GTS: table allocation succeeded
> [   52.164077] gts: num_avail_all_scales 16
>=20
> Next I unregister the root-device and check if the unwinding code which
> frees the tables and zeroes the scale count was ran:
>=20
>         root_device_unregister(dev);
>         pr_info("gts: num_avail_all_scales %d\n", gts.num_avail_all_scale=
s);
>=20
>         if (gts.num_avail_all_scales)
>                 pr_info("devm unwinding not done\n");
>         else
>                 pr_info("devm unwinding succeeded\n");
>=20
> Which printed:
> [   52.168101] gts: num_avail_all_scales 0
> [   52.171957] devm unwinding succeeded
>=20
> I can send patch(es) just for testing this on other machines if someone
> want's to see if the lack of devm unwinding is somehow architecture speci=
fic
> (which sounds very strange to me) - although using this IIO series just f=
or
> checking the unwinding is a bit of an overkill. I just happened to have
> these tests at my hands / in my tree for testing.
>=20
> In any case, devm unwinding using root_device_[un]register() seems to "wo=
rk
> on my machine".
>=20
> Naxime, what was the environment where you observed lack of unwinding? (H=
uh,
> I am so afraid of sending this post out - I've experienced too many "Oh, =
boy
> - how I didn't notice THAT" moments in the past and maybe I am again
> overlooking something...)

This is the description of what was happening:
https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/

Maxime

--i6dr7t7p5mo37f5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZBxGJQAKCRDj7w1vZxhR
xdhsAQCbIqDA/bx7dLbm02G0KT571W8TdWC/gIyeN34Y0ZsbLgEA/TaanKk/j5Lt
vJ7EH9Qr0mHxmO4N84OZKg0S4c/UhAI=
=HAQ+
-----END PGP SIGNATURE-----

--i6dr7t7p5mo37f5n--
