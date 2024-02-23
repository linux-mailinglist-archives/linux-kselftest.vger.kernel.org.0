Return-Path: <linux-kselftest+bounces-5339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B68861477
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 15:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745601F239D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA65224F5;
	Fri, 23 Feb 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjBvEHz6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC979CC;
	Fri, 23 Feb 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699622; cv=none; b=RIn9qiNKqAWUeyzK3Xjnvqdk+zHwOBDoLp8WpnJCLPV5g1JCKTceFZ22Do8sfEmhWiK5NYpDk08oSnBjhDHy6SB+vWjp3PUPxZaBRvvY9E7LDgnPkGx7ocYMK/r20sat4ST547PHVaySDyge1NK7340ptkg39LCcR5AnkgX01/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699622; c=relaxed/simple;
	bh=q8YZ4Jqh0OdMYxUhGwlEvT90DTayzIssQudujNgApkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqZMYz+ytAtoPURM9JeqShB9+31/Drui4isTqUIyyJQF6RNS8MJ/geJie5LhboVAv0L4EebPrhmzWHx4spfxWPlmsWY5uqLdnQMxQ9wp5qMgFvGnPsMiuKWjameRoQ7GRikLusM25EUhiUl16kHERIGDEz+WScfLhQ5lMhGqwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjBvEHz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA50C433F1;
	Fri, 23 Feb 2024 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708699621;
	bh=q8YZ4Jqh0OdMYxUhGwlEvT90DTayzIssQudujNgApkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JjBvEHz6kUl/uCdmc0Fbofl0/L2+tWprk1uNCOiaVJXEhXl8LIF0c2I/PW7XOp7mO
	 9hxJ7iCyymDlgJ8D7fmhHNpFtAL9dF7jz8uNoEJDwtqaIuN4CPuZk0pqcd94YqCOMt
	 EzfKx1lbkpfjTuRw4nbZNVZggJPFmtnsw67EONWnuCRjL0ibPSKpy3X/I/RObxfepK
	 KduLr4jHvMTTec3jaFdRG1x40vDpKD4A0QN6JVDDnJHvpMPVPa2plJsZbLGwKOVcEZ
	 WsnJon4aU1/K+q4D6TXnkdB8C9XMnKkH6Upttv9dPFKtraBaB+rE1K7AsVIdYmLcix
	 EsceGqWSMukMQ==
Date: Fri, 23 Feb 2024 14:46:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dave Martin <dave.martin@arm.com>, kvmarm@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 12/14] KVM: arm64: Support FEAT_FPMR for guests
Message-ID: <Zdiv4E+sjo6JeiP8@finisterre.sirena.org.uk>
References: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
 <20240122-arm64-2023-dpisa-v4-12-776e094861df@kernel.org>
 <86plwn2ztw.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GH+IzJ0CKriU7ph5"
Content-Disposition: inline
In-Reply-To: <86plwn2ztw.wl-maz@kernel.org>
X-Cookie: You might have mail.


--GH+IzJ0CKriU7ph5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 23, 2024 at 11:18:51AM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> >  #define HCRX_GUEST_FLAGS \
> > -	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | \
> > +	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM | \

> No. We don't do that anymore. This can only be enabled if the guest
> has it advertised via ID_AA64PFR2_EL1.FPMR.

Right, as mentioned in the cover letter (and previously discussed with
one of the other serieses) this needs a rework against your at the time
of posting still pending changes to parse the ID registers.  It looks
like everything is there for those now so I'll do that after the merge
window.

--GH+IzJ0CKriU7ph5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXYr+AACgkQJNaLcl1U
h9Cl7gf/de45BtxdA27brC5etmUy5Ui3vnW6bYjHBKBu56enms/PZuUqOqd5/KBL
0ikRdLAXsO+gpmqV1/kHeMeuWfVgcj/s3vM0leABNSKFzJ1AcNSWpNONQGC5zuXJ
6YrBF7gitd+mCXTs+x2JERjw0C7KLd6/uFLX20gqRTS+7GLjpA7KUKfKqyw55vOa
kRroWcD2lXyDZmF0kQ7WbF/zugHWIO0z2VslrYEwMWEWTDN2rqxB+TtY+OniI1Di
uWUX9h41zV0HgJOKFXSAjkEs57KHAGrLzUnDiF3h/dJqZm26BwfH3SYymdcEfdC5
pQBn84s5Thf6r843Z2zamQA6jXx7ZA==
=DQlf
-----END PGP SIGNATURE-----

--GH+IzJ0CKriU7ph5--

