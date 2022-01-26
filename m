Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24FC49D2CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 20:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiAZTxA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 14:53:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47636 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiAZTw5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 14:52:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77F9C61757
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 19:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF9DC340E3;
        Wed, 26 Jan 2022 19:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643226776;
        bh=lYnTOPW2Pkwco72TKCwFmkv1sef05aWRjM7kJ34pSNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lf/8QN+efHRUBfI9x5RtjPSYqDl/9+Vt/n2mflRhwUO2g89GtR9sqOYZUNtdYNxCK
         Mxk5v9efCffbhIjWYHHpgWYumiMyHVdaop1XSqTwg0Mw3nubmEf6oCr8mn51BryUhy
         rg9YqUPniua+/iqn5yaYxlnm0BbFA6WAZ5aMNUUA16sFRsFmTelG4tOfr3B6ZIEDuN
         R9s0/LtCeR4Uh0TFGhEx7IgPuXiZwxBpkECopl+QpWaomzGihDbbIGf6y4jdoCDWWd
         /58BRDmHaJDOgxiC34WfnJaiOQyQ8uP6fI5JuMG4e9OTEOs2FidzXFWhC1TQLDCcJh
         FCiyXMswOy3NQ==
Date:   Wed, 26 Jan 2022 19:52:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
Message-ID: <YfGmk1I8l+ROoE/k@sirena.org.uk>
References: <20220126145242.3473836-1-broonie@kernel.org>
 <4424dd30-f74b-006f-b540-dbaf02e45e28@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="URcG2D/2QfQA1Gjm"
Content-Disposition: inline
In-Reply-To: <4424dd30-f74b-006f-b540-dbaf02e45e28@linuxfoundation.org>
X-Cookie: Use only in a well-ventilated area.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--URcG2D/2QfQA1Gjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 26, 2022 at 12:22:41PM -0700, Shuah Khan wrote:
> On 1/26/22 7:52 AM, Mark Brown wrote:

> > +	ret = vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
> > +	if (ret < 0) {
> > +		print_skip("Failed to create vgic-v3");

> Printing the negative error code returned by vgic_v3_setup will be useful.

If the function fails for any reason other than the system not
supporting vgic-v3 it will abort rather than return.

--URcG2D/2QfQA1Gjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHxppIACgkQJNaLcl1U
h9Drpwf/VP/AtJtHPAgAVlI1NnA4IzzzhMgNH0jsweAqajJFm2bSjc/BLmWJ1PH6
MdO7y23ckqvapSbg9Gmlw/AhR495m4AmRf1h0mMNdGo6D8fljhbRT0ICiw24GpI9
H0Tz3wMrTPIIVpr3Iq/LvXYSeLZ0qHsVpZAKC6NoBN/Iok5fWOJBcCvwNMkBsgyl
GmseUwlAfaHmJxuVX18ZesoAw6poYVHbRjcVEMlsVgl49DOq6yXemS7us3bhr6qJ
265lzlaP2T1j5nM6lfTORUGlFlWMYLd3Uj3V40iU9zCWiJT5H5VY1Dd0w6vdewOd
7vKTsJkiQGSaPF5f3+qcgNNIP/1qeg==
=IcN4
-----END PGP SIGNATURE-----

--URcG2D/2QfQA1Gjm--
