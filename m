Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8AA4DCCF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 18:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbiCQRyr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 13:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiCQRyr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 13:54:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DA514F107;
        Thu, 17 Mar 2022 10:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F13B60C2B;
        Thu, 17 Mar 2022 17:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC39C340E9;
        Thu, 17 Mar 2022 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647539608;
        bh=G3vTTUVjzClhBp/Uh6N1QJFyi0WktLqSYrQr2Sarmvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYQDd4fdZ3b3iIRkJA/LH1g5oppy0x2AcD0Dv4pMFjtEjkhBy259htydTKrnoyTuc
         T3wUMnW7Q780oR8WVyLyk4VO6O2nb0EkAtuSQAKIUd/sgtMcaoGrP+jRgzbLym/o0n
         d0mMT29hka51UlK5pla4jF0bUw2V3b6Dk/WTbnSn6WZjqkdEuPZQfkRtbobStoocF6
         +iydm8uCvLqDT3flTgTX7aBKNg3+RwM7m0q14Vktk42gzb+JouvMzczci5ii9lakTC
         /yKNRYqNhljr9ERGYhIUmm67FVkH0ZCH/Bj6XI2CnGjpH9nDz6NnI3GdXdjgjytBwh
         iNuGfR38HIttA==
Date:   Thu, 17 Mar 2022 17:53:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-kernel@vger.kernel.org, kernel@axis.com,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        shuah@kernel.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, lgirdwood@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [RFC v1 09/10] regulator: tps62864: add roadtest
Message-ID: <YjN1ksNGujV611Ka@sirena.org.uk>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-10-vincent.whitchurch@axis.com>
 <YiuPvkQroV/WdFpx@sirena.org.uk>
 <20220317151326.GA7832@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3BInDUkmR9BH6QDl"
Content-Disposition: inline
In-Reply-To: <20220317151326.GA7832@axis.com>
X-Cookie: What foods these morsels be!
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--3BInDUkmR9BH6QDl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 17, 2022 at 04:13:26PM +0100, Vincent Whitchurch wrote:
> On Fri, Mar 11, 2022 at 06:06:54PM +0000, Mark Brown wrote:

> > > +    @classmethod
> > > +    def setUpClass(cls) -> None:
> > > +        insmod("tps6286x-regulator")

> > Shouldn't this get figured out when the device gets created in DT (if it
> > doesn't I guess the tests found a bug...)?

> The system isn't set up to load modules automatically.  The reason for
> this is to give the test cases full control of when the module is loaded
> and unload, since the tests could want to load the module with specific
> options.

That seems like the uncommon case which could remove the module if it
explicitly needed it.

> Also, the framework splits up logs and shows errors that occurs during
> each specific test if the tests fail, and this would become less useful
> if all modules for all the devices in the devicetree get loaded on
> startup when the devicetree is parsed and one of the modules failed to
> load or crashed when loaded.

That sounds like stuff that would be covered already by normal boot
testing?

> > > +                write_int(minfile, voltage)
> > > +                mock = self.hw.update_mock()
> > > +                mock.assert_reg_write_once(self, REG_VOUT1, val)
> > > +                mock.reset_mock()

> > For covering regulators in general (especially those like this that use
> > the generic helpers) I'd be inclined to go through every single voltage
> > that can be set which isn't so interesting for this driver with it's
> > linear voltage control but more interesting for something that's not
> > continuous.

> That could be useful in some cases, but if going through all the
> voltages in a loop requires that the test implement the exact same
> voltage-to-bitfield conversion function as the driver, then the benefit
> of that part of the test is unclear.  That's the reason why for example
> the OPT3001 test uses known values from the datasheet rather than just
> copying the conversion function in the driver to Python.

That's just a generic problem with mocking though - ultimately you have
to type the same values into the mock and the driver somehow, it's just
a question of if you type in all the values or some of the values and if
you use the same format to type them in.  My inclination is to get
better coverage since it makes it more likely that the interesting cases
will be picked up, and you can make tests that do things like combine
multiple settings which might turn something up.

> > This all feels like it could readily be factored out into a generic
> > helper, much as the actual drivers are especially when they're more data
> > driven.  Ideally with the ability to override the default I/O operations
> > for things with sequences that need to be followed instead of just a
> > bitfield to update.  Callbacks to validate enable state, voltage, mode
> > and so on in the hardware.  If we did that then rather than open coding
> > every single test for every single device we could approach things at
> > the framework level and give people working on a given device a pile of
> > off the shelf tests which are more likely to catch things that an
> > individual driver author might've missed, it also avoids the test
> > coverage being more laborious than writing the actual driver.

> Things could certainly be factored out in the future, but I'm a bit wary
> of attempting to do that when we have a test for only one regulator
> driver, and a very minimal regulator driver at that.

My thinking here is that since the driver is so minimal and data driven
it's clear that any tests for it can also be generalised to cover at the
very least all similarly data driven drivers.

> > This does raise the questions I mentioned about how useful the testing
> > really is of course, even more so when someone works out how to generate
> > the data tables for the test and the driver from the same source, but
> > that's just generally an issue for mocked tests at the conceptual level
> > and clearly it's an approach that's fairly widely used and people get
> > value from.

> For the regulator drivers which are purely-data driven such as the ones
> mostly implemented by setting the various fields in struct
> regulator_desc along with the helpers in the framework, it could perhaps
> be useful to implement kunit tests in the regulator subsystem which test
> that using the various fields actually results in the expected
> consumer-visible behaviour with the regulator API.

> Then, for the indivudal drivers themselves, roadtests could cover things
> like probe handling, functions implemented without using helpers, checks
> that the correct variant's registers are used in drivers supporting
> multiple variants, custom devicetree properties, interrupt handling, and
> the like.

That would be the more obvious approach than roadtest, but that's what's
there in the patch I was reviewing so...  There is also the fact that
the external pattern for the operations is the same no matter if they're
for a simple data driven driver or one using custom ops so you should
really be able to get the core coverage for every driver set up in a way
that lets you plug in a model of how the I/O performing each operation
is expected to work and then have the framework crunch through
combinations of actions to make sure that all the corner cases check out.

--3BInDUkmR9BH6QDl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIzdZEACgkQJNaLcl1U
h9B4rAf/ZpllSWKucbyOqwVRoPGzNotZ9RmGuzBTvHuM047iZNtftHLSpZBvc/tJ
aisx5jUAVHZjAUDPBcoboPOu2KBTUU+irzH6Kab2394Wp62uPH/FZ74fTTWCW6Po
KThSSPxuV6DZ/LeNXZFyVGAvR7++odTcXrUfWtbBpm1jut29th0on3LoHbh+QNrO
/YmSFNJRfgaD5PMyrteebEOn7ZRZT4W/dLLeV0oJUiEb1vv6h47H3yJiSOET3v2P
YU/J5eQwdovc6iiPkiXcrhdsf7pdpcLDlxertBVzqdJLrD26eMmOn9cSZfiTGwC4
ADj2eVE8IYCqR7V4BGqbRlircjsd4A==
=bHyi
-----END PGP SIGNATURE-----

--3BInDUkmR9BH6QDl--
