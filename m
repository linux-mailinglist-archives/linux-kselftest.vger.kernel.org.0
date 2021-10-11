Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E97428D7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 15:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhJKNEP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 09:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232277AbhJKNEP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 09:04:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9934D60E08;
        Mon, 11 Oct 2021 13:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633957335;
        bh=CoYoJamo+BhxaDE+VFzXDpH6lw6wexLMwa6DyI5FyTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODdTLyIKcCcJ/8YxnDZg4U4czb1bIJfYVaBt5gEOOh9RBfj4d86Rkxm+RiAUg/GSH
         3XZ/mOnSy86N0O5wQT1EBew6pe6zu7ZLa/k/qszBpfzJ0e8s6VyHIObvQ2sZ4XrIRW
         PHUrA5F/uWamKS896pt2j2OtUgPFZtFtOm2Lt2RvzBheZbaPq1w/sK6rNeXQZtoq/1
         dNxp8M5Ctqbhsegl4SmbNG+4NWAd7cyEKMPNPVsvpYQ9BEGcCwu8Ua31P6nuDbcEbu
         MVkEhannKiDmpN7UXSXwYVIuBVuqR0+ygJunmMIysGWE43uDck3hyjc6jMs2lHo93j
         SaHO969umaKkw==
Date:   Mon, 11 Oct 2021 14:02:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 01/38] arm64/fp: Reindent fpsimd_save()
Message-ID: <YWQ11M8gzqJiGZUy@sirena.org.uk>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-2-broonie@kernel.org>
 <20211011103959.00003d8a@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q4lhg99skX22zewd"
Content-Disposition: inline
In-Reply-To: <20211011103959.00003d8a@Huawei.com>
X-Cookie: Your ignorance cramps my conversation.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--q4lhg99skX22zewd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 11, 2021 at 10:39:59AM +0100, Jonathan Cameron wrote:

> > +	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
> > +	    test_thread_flag(TIF_SVE)) {

> Trivial, but - the above now fits nicely on oneline under 80 chars.

> Looks like you have another instance of this in patch 21 in roughly the same place.

> Then you drop at least some of this code later. hohum, maybe not worth tidying up.

Yes, indeed.  I think I deliberately didn't reindent to help make it a
bit more obviously mechanical given that as you've noticed there's going
to be meaningful changes replacing the actual code later.  Given that
this is at the start of a very large series I'll just leave things as
they are unless Catalin or Will really wants the reformatting here.

--q4lhg99skX22zewd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkNdMACgkQJNaLcl1U
h9A2Pgf/fW+Ga+cBouA0dQQZWloet8RTKIaeEkFRaC3dNJRODqIjb68bt90L/vTw
nl2ggPPYtXECtoKi4QuVQHIR3Ono5P6TQQjbPmixw9bDJiDrxoQkRsAiPzLqybkS
VMpFydwQyRs6jVKfh6+lybxhMn5kG0QCl/xS78gGYq2EE6owilLfO2c8pBB0hQAp
Pe66WA9ll3oqVOGSZIeeiaKe6ePCESuVvN67ZnLD6LDhH+7iSwMvxmTlLEcR+4ZQ
YyfloRyB8YIIi1hIc8sJngxFxEKwOzuhzo52J/WagcVf7XVsveVZmRcMn0yEqZxR
X7+07HpxCjO5gUmcg+wY3sm0VewF6Q==
=c13s
-----END PGP SIGNATURE-----

--q4lhg99skX22zewd--
