Return-Path: <linux-kselftest+bounces-24003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC47A044E2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 16:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1125618857CE
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81AB1F1311;
	Tue,  7 Jan 2025 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvcWubaS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69661EB9FA;
	Tue,  7 Jan 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264368; cv=none; b=iN5b+2r7jN48EbQuG46SH3rH3I3fLRWBDWCAydeqjTexgQ/kT3xk85wYoQBuPdc3qSU9YGwOzL3od0+AFtnm7vuCPvphyFK01/BP+A4gOd62GVUa20+AU/MzEOiJUzey5ZBRtfiNCafOaXdDgvUzldi0NW1sI/ZX7Xtx+r72/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264368; c=relaxed/simple;
	bh=oD8IZZwblmQdes/eUweJjCun95li3dhJu+Tixr8By8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfaIrRCzMYVVUFd14pw6deYxyHaqVQ/iT5QgK3jERjqbhONe8I+FsNW3lEUxhTXXmSZOelxqYM+5Gyb4xMiNiQvsTRo6TbTL2W/3BHFpTtt84TZBIu3lgVwKegKNr60WikO/QUFFBv+3/lvT5BiD2kieA72z3wucbbSAIwcDNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvcWubaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10E2C4CED6;
	Tue,  7 Jan 2025 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736264366;
	bh=oD8IZZwblmQdes/eUweJjCun95li3dhJu+Tixr8By8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvcWubaS3/P9y4urANkoZVtMDfSIRtNxM86ZjQW81wGXVyxkDitHE4ipa0sS//RXS
	 mfFdJEPfMslBdRELTXEHTcXt6tnmlLNmIiNu+BxQJXdjWBsvElmQ5m0yqNcOWQog+F
	 LmuyODBWk/DXiq1DsEWApRiqbtrHo0qHWPMZgx5dMrQfJMb3AqhewA1SSsUKaiFq0C
	 qOW3Ax73VQYIpgm7lCKiVH4HowMczROQYoy6YnNUTWJhUQZCAe6h+uFcHBOO+/IBsN
	 NOSWHSyLfUFP96hHNybbA1ixMhQZ/4OmilRubx6cO1eW5izbr2WCHFEwhCaSuDDP8c
	 L4JPYDrmq93Ow==
Date: Tue, 7 Jan 2025 15:39:20 +0000
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 5/9] arm64/sysreg: Update ID_AA64SMFR0_EL1 to DDI0601
 2024-09
Message-ID: <20250107153919.GA7728@willie-the-truck>
References: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
 <20241211-arm64-2024-dpisa-v4-5-0fd403876df2@kernel.org>
 <20250107151323.GA7368@willie-the-truck>
 <9e93418d-ef66-42bb-b276-9f92da2596fa@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e93418d-ef66-42bb-b276-9f92da2596fa@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jan 07, 2025 at 03:26:34PM +0000, Mark Brown wrote:
> On Tue, Jan 07, 2025 at 03:13:24PM +0000, Will Deacon wrote:
> > On Wed, Dec 11, 2024 at 01:02:50AM +0000, Mark Brown wrote:
> 
> > > -Res0	27:0
> > > +UnsignedEnum	27	SF8MM8
> > > +	0b0	NI
> > > +	0b1	IMP
> > > +EndEnum
> > > +UnsignedEnum	26	SF8MM4
> > > +	0b0	NI
> > > +	0b1	IMP
> > > +EndEnum
> 
> > afaict, bits 27 and 26 are still RES0 in all the documentation I can
> > find...
> 
> They're in the 2024-09 XML release here:
> 
>    https://developer.arm.com/documentation/ddi0601/2024-09/AArch64-Registers/ID-AA64SMFR0-EL1--SME-Feature-ID-Register-0?lang=en
> 
> which was current at the time the series was sent but I see that they've
> been removed in the 2024-12 release which came out later, right at the
> end of last year:
> 
>    https://developer.arm.com/documentation/ddi0601/2024-12/AArch64-Registers/ID-AA64SMFR0-EL1--SME-Feature-ID-Register-0?lang=en
> 
> so we should just remove these.  I'll respin (or should I do it
> incrementally to save on re-review of the rest of it?).

Gimme a sec as I'm the process of applying the other sysregs bits (which
looked fine).

Will

