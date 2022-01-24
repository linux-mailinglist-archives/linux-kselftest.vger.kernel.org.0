Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCBA499C49
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 23:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379865AbiAXWEY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 17:04:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53050 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454756AbiAXVdh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 16:33:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EACF660C60
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 21:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F97C340E4;
        Mon, 24 Jan 2022 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643060014;
        bh=QcA0kgTmqe+BW4OkegAohlpWWXU3g2h0p7upE+msIro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8EqWj/6OGfrDrSTHiM/qUUSjHoUkl5GAnnhzeGCbHw/3rmV/JpXXDR3TT3EcityN
         DIzGawWXfxtqRdFC67ZgQTPGzEwDndiiottevubpV6UlwTfJxQDK2EX5WYSHwl3+xx
         4FSpvtywmvQ4uJK3Paqj6fCjTcAiI1HWKQWu+AIt+8YEEPPSvXNS1F0MRv2aIxRQHG
         It1hyS3s7tuQF1ywhGk4/VC0bXiZBuLaFurH924u1GWnOSF7tpRobLog5IXUWbZzX0
         TSwr7+nfMKdBsDWNppepvpXkUJiVeWj0LKjAnOuf01P9DCHw2n5bvA821pP8Zc5+wQ
         0OV0Z7Ww0EQRQ==
Date:   Mon, 24 Jan 2022 21:33:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 1/2] kselftest/arm64: Skip VL_INHERIT tests for
 unsupported vector types
Message-ID: <Ye8bKVurkVbhhEgz@sirena.org.uk>
References: <20220124175527.3260234-1-broonie@kernel.org>
 <20220124175527.3260234-2-broonie@kernel.org>
 <e9849218-24aa-cccb-21c4-a0467cffd4fb@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y7siRvzqLjU1cg64"
Content-Disposition: inline
In-Reply-To: <e9849218-24aa-cccb-21c4-a0467cffd4fb@linuxfoundation.org>
X-Cookie: The second best policy is dishonesty.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--Y7siRvzqLjU1cg64
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 24, 2022 at 02:27:07PM -0700, Shuah Khan wrote:
> On 1/24/22 10:55 AM, Mark Brown wrote:

> > -		ptrace_set_get_inherit(child, &vec_types[i]);
> > +		if (getauxval(vec_types[i].hwcap_type) & vec_types[i].hwcap) {
> > +			ptrace_set_get_inherit(child, &vec_types[i]);
> > +		} else {
> > +			ksft_test_result_skip("%s SVE_PT_VL_INHERIT set\n",
> > +					      vec_types[i].name);
> > +			ksft_test_result_skip("%s SVE_PT_VL_INHERIT cleared\n",
> > +					      vec_types[i].name);

> These messages are a bit confusing. Are we skipping two tests?

ptrace_set_get_inherit() logs two test results (one for set, one for get).

> These messages can be combined into one like this one on lin 572:

> ksft_test_result_skip("%s get/set VL %d\n", vec_types[i].name, vl);

If we do that then the number of planned tests won't line up with the
number of expected tests.

--Y7siRvzqLjU1cg64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHvGygACgkQJNaLcl1U
h9DjUAf/bW7xw3dw4g12uhEcF1alQF4petrD4oybwe/Dlh0XmM5Owm6J3V4R7KDb
r1vvDxnAPv7Erf6IhkYPwYSyddzO8RFjYYwN5bY6wFbkbLAAFhQwRomIgG/iJnve
S9FD3KTsc+UW0SfVZWaxG96A5Lh4FoS3l2LHCDIQGPY3gpLX9p+/gq7SZUFfpysY
SUA/BbbBAq2pg3GXOwdPKeCEDmja7GKAfIObTxlddp4c6gQteXMiivTMYHcHx8Jo
sqyOFQ+7Rcx6auAhrUtj2syvvjLrTSwhCDdOqxGyPlUD3zNKQYlR6EvmXpiddnpZ
u3RmM/lvDqhc9KBLrayACvStTJYgDg==
=nZ3r
-----END PGP SIGNATURE-----

--Y7siRvzqLjU1cg64--
