Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD4B4D6847
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 19:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349304AbiCKSIH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 13:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiCKSIG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 13:08:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AAF1BA17B;
        Fri, 11 Mar 2022 10:07:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 178EB61E70;
        Fri, 11 Mar 2022 18:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AEBC340E9;
        Fri, 11 Mar 2022 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647022021;
        bh=FbqNvOscYJ7Bfr/Vx00UgkhPaUqUnhlZCF+USYAVP7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vOMJW+v9J+BqQYR/PnmJ698oQuG3E+dq1i4rfVycrdqD+cso8RQTZa5pT2Yo4F9LD
         1xtdIuzSSBeZcdQ96Kbk9RN5+OYHpfdue+UzoY3aB6SU5fKqE1TQlTGFMJygCFc1EP
         pFK3kzS7x2d1SfpMUz5b+96BnjndaCnL3HRyaSVI2TFYBQToCgbIz0lSWd9CWrq8bG
         LVLkcTRBT+tWtgdRhTNsce+EUu/l7QLK7ZlZFGRCDcw+jPkopTFWyLAE5KrPS6espp
         J/DSeNVhR/jDSNkGi6xHavFIrUTqc4sN119HRZv1mFz+qnkc2xwSt8J5xD6WvekkeU
         gzrqZFrmzJR1w==
Date:   Fri, 11 Mar 2022 18:06:54 +0000
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
Message-ID: <YiuPvkQroV/WdFpx@sirena.org.uk>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-10-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MolxjZU9V35M/+dw"
Content-Disposition: inline
In-Reply-To: <20220311162445.346685-10-vincent.whitchurch@axis.com>
X-Cookie: A fool and his money are soon popular.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--MolxjZU9V35M/+dw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 11, 2022 at 05:24:44PM +0100, Vincent Whitchurch wrote:

This looks like it could be useful, modulo the general concerns with
mocking stuff.  I've not looked at the broader framework stuff in any
meanigful way.

> +    @classmethod
> +    def setUpClass(cls) -> None:
> +        insmod("tps6286x-regulator")

Shouldn't this get figured out when the device gets created in DT (if it
doesn't I guess the tests found a bug...)?

> +    def setUp(self) -> None:
> +        self.driver = I2CDriver("tps6286x")
> +        self.hw = Hardware("i2c")
> +        self.hw.load_model(TPS62864)

This feels like there could be some syntactic sugar to say "create this
I2C device" in one call?  In general a lot of the frameworkish stuff
feels verbose.

> +    def test_voltage(self) -> None:
> +        with (
> +            self.driver.bind(self.dts["normal"]),
> +            PlatformDriver("reg-virt-consumer").bind(
> +                "tps62864_normal_consumer"
> +            ) as consumerdev,
> +        ):
> +            maxfile = consumerdev.path / "max_microvolts"
> +            minfile = consumerdev.path / "min_microvolts"
> +
> +            write_int(maxfile, 1675000)
> +            write_int(minfile, 800000)
> +
> +            mock = self.hw.update_mock()
> +            mock.assert_reg_write_once(self, REG_CONTROL, 1 << 5)
> +            mock.assert_reg_write_once(self, REG_VOUT1, 0x50)
> +            mock.reset_mock()

Some comments about the assertations here would seem to be in order.
It's not altogether clear what this is testing - it looks to be
verifying that the regulator is enabled with the voltage set to 800mV
mapping to 0x50 in VOUT1 but I'm not sure that the idle reader would
pick that up.

> +            mV = 1000
> +            data = [
> +                (400 * mV, 0x00),
> +                (900 * mV, 0x64),
> +                (1675 * mV, 0xFF),
> +            ]
> +
> +            for voltage, val in data:
> +                write_int(minfile, voltage)
> +                mock = self.hw.update_mock()
> +                mock.assert_reg_write_once(self, REG_VOUT1, val)
> +                mock.reset_mock()

For covering regulators in general (especially those like this that use
the generic helpers) I'd be inclined to go through every single voltage
that can be set which isn't so interesting for this driver with it's
linear voltage control but more interesting for something that's not
continuous.  I'd also put a cross check in that the voltage and enable
state that's reported via the read interface in sysfs is the one that we
think we've just set, that'd validate that the framework's model of
what's going on matches both what the driver did to the "hardware" and
what the running kernel thinks is going on so we're joined up top to
bottom (for the regulator framework the read values come from the
driver so it is actually covering the driver).

This all feels like it could readily be factored out into a generic
helper, much as the actual drivers are especially when they're more data
driven.  Ideally with the ability to override the default I/O operations
for things with sequences that need to be followed instead of just a
bitfield to update.  Callbacks to validate enable state, voltage, mode
and so on in the hardware.  If we did that then rather than open coding
every single test for every single device we could approach things at
the framework level and give people working on a given device a pile of
off the shelf tests which are more likely to catch things that an
individual driver author might've missed, it also avoids the test
coverage being more laborious than writing the actual driver.

This does raise the questions I mentioned about how useful the testing
really is of course, even more so when someone works out how to generate
the data tables for the test and the driver from the same source, but
that's just generally an issue for mocked tests at the conceptual level
and clearly it's an approach that's fairly widely used and people get
value from.

--MolxjZU9V35M/+dw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIrj70ACgkQJNaLcl1U
h9D1Rgf9Ftqa1fE0HqpChhmXg9bevuB0hQF8ey0T0Ypw/UorQPenedWbtt0/waZY
K8rGaxJFPJbpC26PeXga6PnVPe7rm+uJtKQe7kICGvkvdCzVfqEH6uNxUfMwPki3
zD2nhS1EvX7bB4NUDP8a3BgrFu8KWh6Npx2yj1cUKUoKFAPBhktCFs/wP5xfhvDV
16sVYMN3QInL8IERk5F+lJSZHHOqfyt0lu7hgW70d+GoAlix/NwXL67ezPMykft/
iyATJkFPB6KoBG2IChUzCFOzMN8KVfjXMCcl5JxOgSpER4jqMeDIbjTsv4uilzFf
LUaSWbjwsd5iJoc7O2UJ+5I6S6vUDA==
=X5TK
-----END PGP SIGNATURE-----

--MolxjZU9V35M/+dw--
