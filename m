Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E784F6B67
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 22:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiDFU3v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Apr 2022 16:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiDFU3a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Apr 2022 16:29:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FD83588A9
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Apr 2022 11:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2012FCE2523
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Apr 2022 18:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDC7C385A3;
        Wed,  6 Apr 2022 18:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649271065;
        bh=2fT+20Z739gNXrMUeQltBNML4IctEm0mvhoLD0BqRsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSiP2cDt1x0DqNO2Zkcw/tFGQnVFNVwo+wo36rzGp9fKkEZdMtEM25bZcYVWSy6gd
         MrZlVB+fddCQ/0nqJUZ5jIh/a2eBXR2NeDllcrJanw7oZYg4xl+w9A4729bk/nqjln
         CMKsgZCcibH2Fnln0QAkjSu8vKyH/Bq0byanmZ6j7TmaZEXlz1IcKel5ZMn55Gnk7K
         D5y5OwOHdswAQ6VccJLrwsJ4MzmqaEhUhB5jc1gxvXE48C247v8jqCF/gK2DeOeYZh
         60Wak0CcIlGHFbvU1LVUCYhG7OIuPy5ndy/aY1/GUsbaABdidnwynV+3ZuwZedd3ti
         FpIpN14uWXe9A==
Date:   Wed, 6 Apr 2022 19:50:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <Alan.Hayward@arm.com>,
        Luis Machado <Luis.Machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant KumarDwivedi <Basant.KumarDwivedi@arm.com>,
        James Morse <James.Morse@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Subject: Re: [PATCH v12 06/40] arm64/sme: Provide ABI documentation for SME
Message-ID: <Yk3hDLe8Cce8zkvI@sirena.org.uk>
References: <20220225165923.1474372-1-broonie@kernel.org>
 <20220225165923.1474372-7-broonie@kernel.org>
 <20220311172051.GA257833@arm.com>
 <YiuYMcR8zk73eBLo@sirena.org.uk>
 <YkXRUlaoyDKQqndc@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H1j3yX+RCi/MNkHL"
Content-Disposition: inline
In-Reply-To: <YkXRUlaoyDKQqndc@arm.com>
X-Cookie: Look ere ye leap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--H1j3yX+RCi/MNkHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2022 at 04:05:38PM +0000, Szabolcs Nagy wrote:

> i think it's slightly better to treat ZA like TPIDR2,
> so only clear if CLONE_SETTLS is set.

> otherwise in principle the child can return to the frame
> where ZA was used and expect it to work (it's hard to
> come up with a reason why would some code do that, but
> this is valid in a single-threaded fork child).

=46rom an implementation point of view it's a bit clearer if we just
always preserve PSTATE.ZA and ZA contents on clone() and clear them on
exec.  Do you see a problem with that?

--H1j3yX+RCi/MNkHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJN4QsACgkQJNaLcl1U
h9D/0Af/X1DilGAOK3sriwKJp5fLyyuDLxIFTmLf9TjhEV4uEC9eB8UJsletqocL
+v7AV/5HwBHKEgvMsbfwpGseBv50gcsQDFsqoW7oxanOYYqzM8HRYoLnDWdficvJ
1wWCX6YKDmMAwk1l0RxACHCWEa2kUP2DBP+R9hM0AQxJJA7TLp3uynOSpiTTFj/G
XYiKrekc9LKiFYK75M9M0pmdN5yU0vRUVMoM5ktKxoyGwrM6ti6TGHOR4i9MWcMr
oYZhizp9w4mkngBuOSYyx/hXmrzonZ2czTAoDER0BMjkVyyCD8GiVE/o6zAJnZ5x
vbmt37o9xQoZ52+YJfzipOm70jAZow==
=KTCH
-----END PGP SIGNATURE-----

--H1j3yX+RCi/MNkHL--
