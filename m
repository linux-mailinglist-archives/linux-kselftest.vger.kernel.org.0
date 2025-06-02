Return-Path: <linux-kselftest+bounces-34136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DA5ACADB8
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 13:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5FC189F330
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7C120FAA8;
	Mon,  2 Jun 2025 11:59:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC59E2144C7;
	Mon,  2 Jun 2025 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865567; cv=none; b=SajHsmrofuskEIOU9R51WwkrU0rp2WvXx4iAbsVoMdrNN37HrH4HO30TdaJciiIwU4qdo2kWU7QkT7EccI4ugY3dYICX/Z3FQBHLgwmO7pfPProANHoSO/FoeB9XyqwSjJSf1qzqbrSH/OwqoJsOihmnFJF1z9P15mAtz0OwZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865567; c=relaxed/simple;
	bh=QKYhjdgz2i0aSyodXmoReRggatM/g2F1A8cEcmxYHBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0vZJ+oTajuv5dpGMah/eKRtHcraXSOrBb4HCbEMtuW9Sl5no2DFghkzGSd4pNrCjoNcEk418Cq3uFU/TVrF8rt1MlS1IkVOzKPMuauUAbvV12IgBn+01OOdMVpqiIXqxN6pC+8ZHVwypZnlM4IeFtvJjMBtUAhbFTsY3Yat9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 8D3F772C8CC;
	Mon,  2 Jun 2025 14:59:24 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 3CCEA7CCB3A; Mon,  2 Jun 2025 14:59:24 +0300 (IDT)
Date: Mon, 2 Jun 2025 14:59:24 +0300
From: "Dmitry V. Levin" <ldv@strace.io>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Shuah Khan <shuah@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, strace-devel@lists.strace.io,
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ptrace/get_syscall_info: fix for MIPS n32
Message-ID: <20250602115924.GB329@strace.io>
References: <20250115233747.GA28541@strace.io>
 <0262acf1-4d3f-471b-bd56-4ddf8a2bc1a3@linuxfoundation.org>
 <20250329124856.GA1356@strace.io>
 <alpine.DEB.2.21.2503291345580.47733@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2503291345580.47733@angie.orcam.me.uk>

On Sat, Mar 29, 2025 at 02:02:28PM +0000, Maciej W. Rozycki wrote:
> On Sat, 29 Mar 2025, Dmitry V. Levin wrote:
> 
> > > > +#if defined(_MIPS_SIM) && _MIPS_SIM == _MIPS_SIM_NABI32
> > > > +/*
> > > > + * MIPS N32 is the only architecture where __kernel_ulong_t
> > > > + * does not match the bitness of syscall arguments.
> > > > + */
> > > > +typedef unsigned long long kernel_ulong_t;
> > > > +#else
> > > > +typedef __kernel_ulong_t kernel_ulong_t;
> > > > +#endif
> > > > +
> > > 
> > > What's the reason for adding these typedefs? checkpatch should
> > > have warned you about adding new typedefs.
> > > 
> > > Also this introduces kernel_ulong_t in user-space test code.
> > > Something to avoid.
> > 
> > There has to be a new type for this test, and the natural way to do this
> > is to use typedef.  The alternative would be to #define kernel_ulong_t
> > which is ugly.  By the way, there are quite a few typedefs in selftests,
> > and there seems to be given no rationale why adding new types in selftests
> > is a bad idea.
> 
>  FWIW I agree, and I fail to see a reason why this would be a problem in a 
> standalone test program where the typedef does not propagate anywhere.  
> 
>  The only potential issue I can identify would be a namespace clash, so 
> perhaps the new type could have a name prefix specific to the test, but it 
> doesn't appear to me a widespread practice across our selftests and then
> `kernel_' ought to be pretty safe against ISO C or POSIX, so perhaps let's 
> leave the things alone?

Another similar test I authored (selftests/ptrace/set_syscall_info) has
been merged, so there are two similar tests in the tree now, but only
one of them is permitted to use this approach, creating inconsistency.

Taking all of the above into consideration, please approve this fix.


-- 
ldv

