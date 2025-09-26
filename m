Return-Path: <linux-kselftest+bounces-42459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB4BA37EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D969385924
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE2D2727E5;
	Fri, 26 Sep 2025 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjZWBx2d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352B0212B0A;
	Fri, 26 Sep 2025 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758886672; cv=none; b=KDL9ptbW2bJKONpJJn3i4BNB8IO9IVTtXkpRaFvhRnNHjiYvrinfImhHRISc8D33zqXAZCpkTspKmzQtTND/G08L+mqGAHQuHURUq+Im2EpKHsXh75V2bL9F4s8cqfRV4jm2aM8iloEKwvkRUdhfvYKZupTFOCIm+mrqhi1+bAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758886672; c=relaxed/simple;
	bh=meuVtUA1LPUH2heOJSuuknADu9bGrGrTvWW+pcoXU94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC91CpNj2im3cH1/HDw+0WG+ZdLcEQu6nNvvRNjFXa+hJsD0fAmbbUw/UGWt1l0Q4JGkoA6XhUgxBJ1wZSPeIFKVnTF2fH0CL/Enp5DyoqCtiJxtzNY7RyGi39NTe85VMtX3pTk4XbF93UlJiGScVFPPGjlB2uJeua/0PKSb0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjZWBx2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3EDC4CEF4;
	Fri, 26 Sep 2025 11:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758886670;
	bh=meuVtUA1LPUH2heOJSuuknADu9bGrGrTvWW+pcoXU94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BjZWBx2d0lMQf6lujW5938UHnDj0Dy7zGpTf3KFTc+I13iL2OHwl/ZT09wCl46Z3k
	 s/nPJmK/qp/JrHwW7L4R4yL0evyZX+3UykrlIhrnaapgyTugcVSYPJseMt1vLyDDm7
	 ro7deMBvlkhMTs6N6D6WGqN+vSvg1ojkGuq4SVnWgPBnQUIzQa/6gNmp/4hW7kfPDP
	 1o2vKEL/0XFrJLVIDlmV8Kx0LDpFSypMU/GLf3p8zOVZBMyMTYz8LIxLWHi0Z5EDPt
	 fzU0dMwHJ7zbCk12gNvVEr5tDU0jbvIVoV8wdXzSJn/RjfHEGOM6zjTxH/DHqV63c9
	 X6bmrl94+qfNQ==
Date: Fri, 26 Sep 2025 12:37:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	Carlos O'Donell <codonell@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Szabolcs Nagy <nsz@port70.net>,
	Rich Felker <dalias@libc.org>, libc-alpha@sourceware.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] arm64/gcs: Support reuse of GCS for exited
 threads
Message-ID: <13c4ada9-bc32-46cc-a7b4-3def7a4e94fb@sirena.org.uk>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
 <20250921-arm64-gcs-exit-token-v1-1-45cf64e648d5@kernel.org>
 <aNVx9vlgi8t81V6Y@arm.com>
 <38d629f2-99bb-4b13-a6ed-a4126d130b1f@sirena.org.uk>
 <aNWLwkn1fJDvWUyu@arm.com>
 <41929a12-59f4-419e-9f15-eaa09f0df0f3@sirena.org.uk>
 <aNZ1jVLhc_Zg99Jb@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o4ImZ3Z05RybO8Cj"
Content-Disposition: inline
In-Reply-To: <aNZ1jVLhc_Zg99Jb@arm.com>
X-Cookie: Your canceled check is your receipt.


--o4ImZ3Z05RybO8Cj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 26, 2025 at 12:14:21PM +0100, Catalin Marinas wrote:
> On Thu, Sep 25, 2025 at 08:00:40PM +0100, Mark Brown wrote:

> > Yeah, just I need to convince myself that we're always running the
> > exit_mm() path in the context of the exiting thread.  Like you say it
> > needs checking but hopefully you're right and the current code is more
> > correct than I had thought.

> The only path to gcs_free() is via mm_release() -> deactivate_mm().
> mm_release() is called from either exit_mm_release() or
> exec_mm_release(). These two functions are only called with current and
> current->mm.

> I guess for historical reasons, they take task and mm parameters but in
> recent mainline, they don't seem to get anything other than current.

Thanks for checking for me.  I guess some refactoring might be in
order to make all this clear.

--o4ImZ3Z05RybO8Cj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjWewgACgkQJNaLcl1U
h9CucgfzBm+/4GRXodVm5zfzNvgYFKgTeyWxa44ut0CO5vAZRgdupDDGVW7HNADQ
CRf/avO2tj4REnLqO6dOIxeFYeDJmuVAvRUleh4STLNjo58ayjUzbjW7JEpO2Thj
EgwwUhUPxwLzDEyNAu9Knt4PVzBx0hPI/AqXtS+jjEjhWMDijy7T98iJGjZ+egCr
b+cSIp/DW8wtZ9rB7JybMLCOV8ELy+rnhDXUHfcNBG1QXuw8saSsAu7GbzDRfGpa
RjEGm7vAxPJxTbmHkeThF/OMzvvjMA4qZaGrLGNpqmfGI0l8cPmG1ni+cFHv4ljm
JJXC+geWEjlK/fSO0fsXkt3SklP5
=c8l5
-----END PGP SIGNATURE-----

--o4ImZ3Z05RybO8Cj--

