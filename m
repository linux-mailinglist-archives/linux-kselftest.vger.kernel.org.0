Return-Path: <linux-kselftest+bounces-21000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6649B5252
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 20:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D3E1C22A19
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8F01FF7CC;
	Tue, 29 Oct 2024 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4vSj3Oo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5F2107;
	Tue, 29 Oct 2024 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228498; cv=none; b=Qf3VRP0DvKbNeDA/4aKvV+Uhm5ZsMGJrTsHThEnuBtP3+2nifhpnf+lU9tKXiwb3PJ7WlE3LNnUvZBDcfs7Fjsjh6z0A4XSgrnbebRTrQ1tOH9JXjP+WdhA6WU5RNNYNW7isEnM8fwb7AWDnvLo8M+1L2OKoysfVVgK0r//tDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228498; c=relaxed/simple;
	bh=Vh6G+8uwL9uUOhvODAwVdWDZL/F4D+Frm1lZVOFHCHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEkLwFV8MUXFe2OasVIDuu/X1mo/blpP5zPI1xmGTtthEOIlNOMj70eptXORrc+5WADxA7ppu0pn5U0EK50/vV2qT8E3bMy/bWdPwjVYlNMZ4ANFdpmtnRy2AUXVzV58PDWB+9shM5UxvFyWMYPeffSjOu7pK/COEgoZje0r67c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4vSj3Oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBD4C4CEE4;
	Tue, 29 Oct 2024 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730228498;
	bh=Vh6G+8uwL9uUOhvODAwVdWDZL/F4D+Frm1lZVOFHCHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4vSj3Oov1VK0ycqbj88Tprzv8GWpeSYgx4q3BPI73sQDVdT0D4NCWH4rS0FlShxU
	 OnwHuLhX95JSvX7+SbZmrPQBcGynkzjdOpIej32blGefWmR0IXdg3SiVKvCRaM8I2U
	 ZVC3ZKe/ukljcJWgtVyK5b1r3odbMv1nvyGGsubFSyl51D0CVbzv7h3V/tpG8BjPh/
	 +U7yuGclZV8lHd7IMKpfhEXv0CawSsmMkMCGXpNoT0+itAsW9N9qEcFDPsxUpOs1uN
	 mmhDMKKj7HjeAUcy3biVkq9yZopZGuGrDbtJI2dP8HgTx2xadQZf3HamPiDp3R/5ZP
	 8yYvihQKxgYTg==
Date: Tue, 29 Oct 2024 19:01:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 8/9] KVM: arm64: Allow control of dpISA extensions in
 ID_AA64ISAR3_EL1
Message-ID: <bc0998d2-fc06-41e5-87aa-25a963947800@sirena.org.uk>
References: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
 <20241028-arm64-2024-dpisa-v1-8-a38d08b008a8@kernel.org>
 <867c9q3lkj.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Vm6UmZvhyOSk+XV"
Content-Disposition: inline
In-Reply-To: <867c9q3lkj.wl-maz@kernel.org>
X-Cookie: May be too intense for some viewers.


--4Vm6UmZvhyOSk+XV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2024 at 04:45:00PM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > +	ID_WRITABLE(ID_AA64ISAR3_EL1, (ID_AA64ISAR3_EL1_FPRCVT |
> > +				       ID_AA64ISAR3_EL1_FAMINMAX)),

> Please add the required sanitisation of the register so that we do not
> get any surprise exposure of unhandled features when someone changes
> ftr_id_aa64isar3[].

Hrm, right - sorry I missed that.  The other registers I was looking at
don't do any filtering.  This feels like something the helpers should do
but that's simply not how things are structured right now.

--4Vm6UmZvhyOSk+XV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmchMQwACgkQJNaLcl1U
h9BBIQf/fJ4ZRG5K2io8YpnuhLePrlnfVtSz0vdMqL26hdM384DyHOtHBnj7tobz
wcMxqJtvV/+nwxaKpTfaJwtriyBqlYLexywJpttHwplCdDoS6DKLAssSkoE5Dlge
RqqtygC4CbFgdwJ54vFke5Ku97EJLhKvEWCMGPKgM7KWXR56f5FyipMzhJDDGkRd
ZP5cCMs0b0vocUbd9URiNhDL28tVUIWLOFarxRwFnlbIDiuedEvyrtaBKh30Mw6o
nb5KPJ8r5N8V8ylHTrFlGmIWrpMTFVLqhYrdc1SBr2wL/fZ8xAO3UkAL8AraIbMC
i9whjaoox3OTBniFy9I7+95eM3Z/lg==
=y7Ds
-----END PGP SIGNATURE-----

--4Vm6UmZvhyOSk+XV--

