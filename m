Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35A83D8C73
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 13:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhG1LHQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 07:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhG1LHN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 07:07:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65B7460F9C;
        Wed, 28 Jul 2021 11:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627470431;
        bh=qlWsw0tfvN2JxK90J+h7ML3tVf+kz0m7CKzLgfjitmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/c0dW4ESlILbt6GIJg0yoZeu0NC1wK8wM95Us1eEA3OeynAZs9rwf9F9ugYgCuvC
         HsgY7+18MVDrS+Jze5W8C/w8RYvNxrupTvSqUZJ+vwimT9EJCUDzQkRfwRxcDj55DU
         lJxNRN/Paid3Wc+GQm/D8mUMrV8uvG5r9ZrodeaK0lQxaxNyYYjvKPKXyovj4IoU/P
         Ya744ara5rAaL2LHfjYeQ3IIHfzndp365i/jSbRojKjrMOoCHBZ57s/G/iW41LtfUU
         TuIypFZQADLvmELtPDlnEnB9WTGqy5LlLOCo71dwm47QBC00itamom8M5jp0ToY9+t
         fGH02sSZ9628Q==
Date:   Wed, 28 Jul 2021 12:07:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/3] kselftest/arm64: Validate vector lengths are set
 in sve-probe-vls
Message-ID: <20210728110701.GC4670@sirena.org.uk>
References: <20210727180649.12943-1-broonie@kernel.org>
 <20210727180649.12943-3-broonie@kernel.org>
 <20210728094151.GB1724@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8Bkcj4NmnZ79d4W7"
Content-Disposition: inline
In-Reply-To: <20210728094151.GB1724@arm.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--8Bkcj4NmnZ79d4W7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 28, 2021 at 10:41:51AM +0100, Dave Martin wrote:

> This test was originally a diagnostic tool, so the way VLs are probed
> aims to be efficient, rather than being defensive against the kernel
> doing weird stuff.

Yeah, the whole probing thing doesn't really fit into kselftest's idea
of what a test is - I just put this in here since it seemed like a cheap
extra validation that we could add in with little bother rather than
because it's a complete and thorough validation of every possible thing
that could go wrong.  I'd be just as happy to not modify this at all but
since it does try the intermediate VLs it didn't seem like a terrible
idea to throw in some validation while we're at it.

> If the kernel returns a vl > than the one we tried to set, we'll end
> up in an infinite loop because of the way the loop deliberately uses the
> kernel's return value to skip unsupported VLs.  So, it might be better
> to probe every single architecturally possible VL and sanity check
> everything instead.

Yup, that'd obviously be a complete rewrite though.  We'd not only need
to probe every possible vector length, but also validate that any
unsupported vector lengths report the expected vector length instead
when we try them.

> > +		if (rdvl_sve() != vl)
> > +			ksft_exit_fail_msg("Set VL %d, RDVL %d\n",
> > +					   vl, rdvl_sve());

> If this fails, the VL vl wasn't "Set" at all.  I found this a bit
> confusing from just looking at this hunk.

> Can we write something like "PR_SVE_SET_VL reports VL %d, RDVL %d"?

Sure.

> I'm not sure of the correct option for forcing SVE off against the
> compiler default -- check with the tools folks.  If there isn't a
> proper way to do this, it's a toolchain defect so we should flag it up,
> but -mgeneral-regs-only might work for us even though it's a bit of a
> sledgehammer.

-march should do the trick (if it doesn't the base kernel already has
issues).  This is a separate issue that affects all the arm64 selftests
I think.

--8Bkcj4NmnZ79d4W7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEBOlUACgkQJNaLcl1U
h9CNaAf/VSsulObCA1kB5of7qrxDb9cXC2lKiuv/SK94Szr6awIQ52xxms2NGq5B
5UaCpyQNHfZDcgo5VtFRoM8xv77Vg5Sjr0HdXtAsbh8PwIRSA8QmAaY/18p4iDeU
hXVvHzh1qhc8XrPf6u2CvXwYuO3Dsf62j79dnuANZzthavYhH6KgbezK6oaJCqa6
A5joEq0mCfNd5XWJQBrEquS70nk3sAYNIutRPZ0Yy/0Fhe4FPDC7Jnh7/2rcaOr/
Cgmqg8UiMK0I8rA/HKu2ujvYZPDg6/GbKQNV9YqeF2o64fWzoG+Tk3rq37NSjLkL
lz16N710YbSIdEEHuUROVIhdd/9+LQ==
=3LWW
-----END PGP SIGNATURE-----

--8Bkcj4NmnZ79d4W7--
