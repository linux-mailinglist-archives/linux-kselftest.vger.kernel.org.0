Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F841DED04
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 18:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgEVQPM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 12:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729903AbgEVQPL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 12:15:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E072072C;
        Fri, 22 May 2020 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590164111;
        bh=/XVrxxfTMAjEHk3OwtWDf86tYdi151zMugC2bDYrq34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lkIA+w0oI1q4FR1927ERKE+b1Nb0vxkkmihIWMmKWt4vVbpB7wAj3L3/eZqhqgPd+
         v/ocob+yX5/yB9dqw/4MMv62gfNen09QASDdXP+OUIS1T3SNBnwR3HB7FbekWqTJJl
         71wsXKXrdnCohWnAipdGip6n3QBFz9Dz9HK4xFvI=
Date:   Fri, 22 May 2020 17:15:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: vdso: Add a selftest for vDSO getcpu()
Message-ID: <20200522161508.GN5801@sirena.org.uk>
References: <20200505174728.46594-1-broonie@kernel.org>
 <20200505174728.46594-4-broonie@kernel.org>
 <dff4dfbd-f3f1-d683-5dac-4404e9023b2e@kernel.org>
 <20200519174452.GR4611@sirena.org.uk>
 <0f1a7c29-340d-f61b-b102-d300932dc92c@kernel.org>
 <20200522151222.GJ5801@sirena.org.uk>
 <278c9a47-4d68-0e0d-415d-53360337aa6c@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9DptZICXTlJ7FQ09"
Content-Disposition: inline
In-Reply-To: <278c9a47-4d68-0e0d-415d-53360337aa6c@kernel.org>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--9DptZICXTlJ7FQ09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2020 at 09:15:07AM -0600, shuah wrote:
> On 5/22/20 9:12 AM, Mark Brown wrote:

> > That doesn't match the idiom used by any of the surrounding code :(

> I can't parse the idiom statement? Can you clarify it please.

The other code in the vDSO selftests does this (the quoted line was a
cut'n'paste from the gettimeofday() test and most of the functions in
parse_vdso.c are similar).

--9DptZICXTlJ7FQ09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7H+osACgkQJNaLcl1U
h9Druwf/acwMTA58Xw115dS1RbaOYK2H8ATPiTnX/k1VLv9UYljnE6sxyG2Fsu1E
SEgvx13PY3S2kOL9kgydGu47hvPtVN22n02rAmedqj9mS3IwJ/oi5YyYhc2fTDja
HjVuFYDxdSg/xwwhUb8HCaQx9rwCT+mgYMCFWoAaJLaTYxjPbZSP/J7ZZy+kG1j4
eTG7QHgo4hHTujRhYeayDesuF1s6aQR1cJf37ExVNC02vN7rzawZqeB3SRYbUGXq
tWX3PtrzYCWBAegxx06YBs39SeNq4zMAX7bKqj7vjc6EOZIUDBhwdejzCnQ7nj4r
tvrzcmTKkzoZqJeBt7fN/pj4AIDyjQ==
=5VAp
-----END PGP SIGNATURE-----

--9DptZICXTlJ7FQ09--
