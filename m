Return-Path: <linux-kselftest+bounces-29915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC457A7568A
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 15:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6727D16E19F
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0261D5CEA;
	Sat, 29 Mar 2025 14:02:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60A73596F;
	Sat, 29 Mar 2025 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743256958; cv=none; b=rXIMCfDoEY5mLZGXZW1h4g11ZyXq1yRbb4staoNGr9bgxYW7+WDiGx/VLYQKvQjZV2FFjmyCoKifAK92TkaADjqsJKbTvvRA+EfeDBnVFOZhEYEuSa8dr9I0IcjiKQenZI+L33dwJIn57aNng1TUaqM9HklCVAbVLEmn9neXNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743256958; c=relaxed/simple;
	bh=hL2LR4YRTbUHCeLjHYKPP0/AH4zkVFtQlxJUBIOjHbY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pAtE0dR7GQOS/kiMRZ6Y0BikrWpsaNJshlasT9NAr0fdEtja+cEWvSCZee6B1X23mcxLrifpgNr3fqDOfjWjYKroc67pn0CI9qMUqH1h5vH6qHvp6zZRmkW9NoBybmDh3S7cpehvmAMvChgcee+pvJTS/SysuyKzMvLT3Yq/Uhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 34D7C92009C; Sat, 29 Mar 2025 15:02:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 25BE492009B;
	Sat, 29 Mar 2025 14:02:28 +0000 (GMT)
Date: Sat, 29 Mar 2025 14:02:28 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: "Dmitry V. Levin" <ldv@strace.io>
cc: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
    Oleg Nesterov <oleg@redhat.com>, strace-devel@lists.strace.io, 
    linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ptrace/get_syscall_info: fix for MIPS n32
In-Reply-To: <20250329124856.GA1356@strace.io>
Message-ID: <alpine.DEB.2.21.2503291345580.47733@angie.orcam.me.uk>
References: <20250115233747.GA28541@strace.io> <0262acf1-4d3f-471b-bd56-4ddf8a2bc1a3@linuxfoundation.org> <20250329124856.GA1356@strace.io>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 29 Mar 2025, Dmitry V. Levin wrote:

> > > +#if defined(_MIPS_SIM) && _MIPS_SIM == _MIPS_SIM_NABI32
> > > +/*
> > > + * MIPS N32 is the only architecture where __kernel_ulong_t
> > > + * does not match the bitness of syscall arguments.
> > > + */
> > > +typedef unsigned long long kernel_ulong_t;
> > > +#else
> > > +typedef __kernel_ulong_t kernel_ulong_t;
> > > +#endif
> > > +
> > 
> > What's the reason for adding these typedefs? checkpatch should
> > have warned you about adding new typedefs.
> > 
> > Also this introduces kernel_ulong_t in user-space test code.
> > Something to avoid.
> 
> There has to be a new type for this test, and the natural way to do this
> is to use typedef.  The alternative would be to #define kernel_ulong_t
> which is ugly.  By the way, there are quite a few typedefs in selftests,
> and there seems to be given no rationale why adding new types in selftests
> is a bad idea.

 FWIW I agree, and I fail to see a reason why this would be a problem in a 
standalone test program where the typedef does not propagate anywhere.  

 The only potential issue I can identify would be a namespace clash, so 
perhaps the new type could have a name prefix specific to the test, but it 
doesn't appear to me a widespread practice across our selftests and then
`kernel_' ought to be pretty safe against ISO C or POSIX, so perhaps let's 
leave the things alone?

  Maciej

