Return-Path: <linux-kselftest+bounces-21864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A23C09C5949
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721981F2116F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 13:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4C1170A16;
	Tue, 12 Nov 2024 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7skn3Kb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FAE1586CB;
	Tue, 12 Nov 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418684; cv=none; b=jpDTNHz4brr0bKlBUY7Z5hJGpuWsi0BLrrBS/qXVaOt/ok25C73yceUuUb/C3hkTApydaQ/aMEe3qkbl8fKg13kV55IrIFR/PRR+cnG5vws37zau0Nmqrne9xxyOBpUyloREyMKeudFD4lJ4evLlr0kcxXajO7baMrkqyL1qN4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418684; c=relaxed/simple;
	bh=pAVnpThhWdYJeNyxXAkFL3AIKR99WrRrYPiq8nNjjd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svDLRedNFfAIl/t7q3scCmcZkrJLZ9vzKQaSB2JWlU92hUEsNtHMTQ1jHKN3nxuPi5BASbUH0CCDO3WE0aWQ3t62gg0k4PRocfsLqUybF0wmbt13yP5jCedDMBPJ98GdGtchZQ/d360wfTf/agYD/LHrFXNTF/NbdeXNw8EnMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7skn3Kb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542CBC4CECD;
	Tue, 12 Nov 2024 13:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731418683;
	bh=pAVnpThhWdYJeNyxXAkFL3AIKR99WrRrYPiq8nNjjd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7skn3KboyWXib0zh2vjY77DelF5J0MYbRjN/MXavNECa9pjUt6HHvv4jkcoTpJMH
	 j5G6PNm1K5kersBkmjwFfx4G07hhVmWcRpO+80MlHnrrZHgQCuuDdA76J8pGrNuJ8u
	 sYBF0Mdi2VdzNLk5WKYBWPT0BUMmyRGueZexG4FbI2QlQm7RPVIac2h7GJHd/G4oPu
	 mHjCcETvIaZWf78XArHChMzeRdl8nDZowzaQ1vaSVzxBdtyIfjezHoru3ZJOWHHhD6
	 4kG/uBPedRMl+VZ+WJuci8S/25tj9usoIpC/l2zetr7BDyuIVCpNAKxb7fnb6vza64
	 zmyGiI5rRVKhg==
Date: Tue, 12 Nov 2024 13:38:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/3] kselftest/arm64: Add FPMR coverage to fp-ptrace
Message-ID: <ZzNaOSjRrO5bAJ46@finisterre.sirena.org.uk>
References: <20241112-arm64-fp-ptrace-fpmr-v2-0-250b57c61254@kernel.org>
 <20241112-arm64-fp-ptrace-fpmr-v2-3-250b57c61254@kernel.org>
 <ZzNXnJ3Jc45CctCs@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xLlvf2gTixCAyurB"
Content-Disposition: inline
In-Reply-To: <ZzNXnJ3Jc45CctCs@arm.com>
X-Cookie: Editing is a rewording activity.


--xLlvf2gTixCAyurB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2024 at 01:26:52PM +0000, Catalin Marinas wrote:
> On Tue, Nov 12, 2024 at 01:08:16PM +0000, Mark Brown wrote:
> > +	// This has to come after we set PSTATE.SM
> > +check_fpmr_in:
> > +	tbz	x0, #HAVE_FPMR_SHIFT, wait_for_writes
> > +	adrp	x7, fpmr_in
> > +	ldr	x7, [x7, :lo12:fpmr_in]
> > +	msr	FPMR, x7

> Did this build for you? I may not have a new enough assembler.

Yes, it even ran through tests.  I suspect it's picking up some
(possibly stale generated?) header file which has the FPMR define in it.

> fp-ptrace-asm.S:149:6: error: expected writable system register or pstate
>  msr FPMR, x7

> I changed it to REG_FPMR locally.

Thanks.

--xLlvf2gTixCAyurB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmczWjYACgkQJNaLcl1U
h9AK0wf/aSgAZAm9PsjG6AMul8uMPl9LX5dIhjhyUsdde7iFjz8U4B7TvxrqBZiR
rr+rca1ee3yjWRcrQ1UsXuIbDkYhI/Ecg+sRVj/dwnVLRwS9/bbqqinOiqnZ/c91
b+NXock5wFZqFH29iHs/mKXqWoc8uvYliS52YBTpYX1wyyQPPvYvxsftEEgMiS2r
mSsqdwrmIbINgAXcXY1SnhJmfyhm4P1pkMpb1VP6z8hGO5dJclyJM8unkWCpPfvE
JAHyzFbGC8HvKO2ULXiRHJa4H4SlCfg3Y3zvOF70aF8X1x/tw9KHFLDlGUh5eJAL
APX15s2e7Jv2beg5d7DxA1wKcU6rng==
=D64q
-----END PGP SIGNATURE-----

--xLlvf2gTixCAyurB--

