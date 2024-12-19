Return-Path: <linux-kselftest+bounces-23610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BDA9F80CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 17:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CD7188BE0E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7911171E7C;
	Thu, 19 Dec 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9simPy5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245586337;
	Thu, 19 Dec 2024 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627427; cv=none; b=hxbWQRbAt77HCoaLs1pXhsg52/CMqwRIs+bu4LtLyX9JORBs7FRnI7/HD49xi7+tAxk1RPGLvSh+T6zLxL3MKMrNlQKHxPfz/iOgysi19Th+TWkSqS+Sy5vyimr9ECucWLYfqsKJ4temZAVZXaDL7aLlenyJ4q8uztq6t0EkuY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627427; c=relaxed/simple;
	bh=WwHpP68WsS0yrXAj1bsIoT9Q9TikJFuGrs1v0icekw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBN8v6yldP0AJaajxMI+gjUGv6/d/V3n9TkzwfwFDQMY1ppk5XEnpswxm1vrTpjIckOL8zTLf4wgX8G/m01lIrhM5vQk2xAccWQDJAIPIwD5BrKXhuWrnG1iqi6Zleq7sG2Q8hi3cWajAbywyVlogEphvh9bT4m8VpX5XfOlgBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9simPy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38F5C4CED6;
	Thu, 19 Dec 2024 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627426;
	bh=WwHpP68WsS0yrXAj1bsIoT9Q9TikJFuGrs1v0icekw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9simPy5gm7FERVFtGSRbSFPrG9gxD1rQigXcOaP39LyDClM0qvcWifLvJM7SsPGf
	 rW399gxR+RuOwG+kDIlTPYw5Ia0CK/NK72MzjrcIG3X2fHjZNQaTelKDyoor/eapNQ
	 M2LNZ6pBcDzUDhEpDyPjlNrxxOvHvnItzMyBFF1Oqw58ybSznANlRSrj7wPw1nd49O
	 CU8BS5jtqMT3B0qn1tpooIz08+Gj40Tz7t5o7jFR3tZOEnj+xWalZD3MedPKsMq5am
	 8gufCvpAkyri/Uij8dTM/6YsB3rz3bxSMLBZ1NmAoy28Unij+VG/VyIbcw1GRX2WBt
	 7QBALVNVD6VYw==
Date: Thu, 19 Dec 2024 16:57:00 +0000
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
Subject: Re: [PATCH v3 2/9] arm64/sysreg: Update ID_AA64ISAR3_EL1 to DDI0601
 2024-09
Message-ID: <20241219165659.GI24724@willie-the-truck>
References: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
 <20241203-arm64-2024-dpisa-v3-2-a6c78b1aa297@kernel.org>
 <20241210170953.GB16075@willie-the-truck>
 <b859bdcd-7343-4d53-9f3a-f374deca725a@sirena.org.uk>
 <20241211224015.GB17836@willie-the-truck>
 <248dea18-bfad-4ec9-9a7d-5c87c7f48c84@sirena.org.uk>
 <20241219155547.GC24724@willie-the-truck>
 <51632b4e-19a0-487f-878d-f03abeea2553@sirena.org.uk>
 <317e06e8-6e85-48cb-902b-4b3c7748bd8f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <317e06e8-6e85-48cb-902b-4b3c7748bd8f@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Dec 19, 2024 at 04:49:05PM +0000, Mark Brown wrote:
> On Thu, Dec 19, 2024 at 04:39:11PM +0000, Mark Brown wrote:
> > On Thu, Dec 19, 2024 at 03:55:48PM +0000, Will Deacon wrote:
> > > On Thu, Dec 12, 2024 at 11:33:05AM +0000, Mark Brown wrote:
> 
> > > > That'd be useful, yes - unfortunately I think that's still something I
> > > > can't work on myself at the moment for the above mentioned non-technical
> > > > reasons.
> 
> > > Is anybody able to work on it? Without insight into the "non-technical
> > > reasons", I don't know what I'm supposed to do other than write the tool
> > > myself (which means finding some spare cycles...) or refusing to take
> > > wholesale sysreg definitions until it's been ironed out :/
> 
> > Similar issues will apply to anyone at Arm as things currently stand.
> 
> Oh, actually - shortly after I sent this mail I got a notification that
> there's now an "Open Source Machine Readable Data" package at:
> 
>   https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads
> 
> as part of the 2024-12 which should unblock this, just in time for
> Christmas.  There's just the small matter of free time to resolve!

<party.gif>

That's great! Hopefully we can knock up some basic linter tools in the
new year.

Thanks,

Will

