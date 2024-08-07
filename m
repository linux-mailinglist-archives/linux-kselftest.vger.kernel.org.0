Return-Path: <linux-kselftest+bounces-15004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19CB94B398
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 01:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1CB1F22523
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E811415624D;
	Wed,  7 Aug 2024 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWaHE+9F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB06155301;
	Wed,  7 Aug 2024 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072950; cv=none; b=e5TMos2Gb882qG7+IO5PCzpxMzYAOZQVLwT13fw5xk7vT90EfK9b6THIFtdBTj/PkgGI9hh5vPXN1yW5Ai0CkdrhMhUWHIc9uC2FCIO2hNC7elPeHDb4jtyavzCDbC1IG45RFVsv14RbL2FRa0ekanjaNDS1qjEJ/Dy6JrpJTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072950; c=relaxed/simple;
	bh=RaFIQnhHCVfXZhfLSnx0U32F4IlncSulUcGskYU6UtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCCbtHK0VKY6UN4EJ0LGzvYRatGLKozQOuODFJVKlybdzL6oBR/MIvBceNin+RKi5Z6+opahhBt8Cyhq5a53gDiUWKohoDQKRAiHbvQnt1bTDzRLGQWiOA+fniE763AmOV1xIXIVNnTj2vJCaoXTDVJTPBqr6ZSgGKETrBSWF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWaHE+9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A977C4AF10;
	Wed,  7 Aug 2024 23:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723072950;
	bh=RaFIQnhHCVfXZhfLSnx0U32F4IlncSulUcGskYU6UtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWaHE+9F9oZolq2zd7j9sugiqdHgYVE+JJo9M4TUOONrL18B5kBtXLv2vx2JBkIqe
	 U4w/2JUN2xoBkY5RyAtLvrPGPeNiZkm0176mjAaHcaBrboYYS93xLnCEvHBWBjKUqi
	 xdfW/qsEEPs6QGa70quFuBvJHNsz7/TBT0iJVGFoVpyN9TQzknhbkTdAuDLUIBi4Yr
	 7kUgn7GAzgwJRzSOF0YvBHhR4aQZD+tFO2T8zE63mH5Nccleot+f+MSFTB9MGDqYMe
	 yMZG+n9LnWqayTQiTtbk3mXoaT1w8DPFsyvH9RgOHfLNqoQVmAJV8QJBpcnMXCfQf7
	 0w8mWFhHN1Stg==
Date: Wed, 7 Aug 2024 16:22:29 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v7 9/9] selftests/clone3: Test shadow stack support
Message-ID: <202408071620.57E9BBE5D@keescook>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
 <20240731-clone3-shadow-stack-v7-9-a9532eebfb1d@kernel.org>
 <202408052046.00BC7CBC@keescook>
 <19ee6fc9-94d7-4420-abd3-7cfdf612df0c@sirena.org.uk>
 <202408062022.34F3558@keescook>
 <e5e5c0fc-3425-4020-ae7c-4b7fd0f1f263@sirena.org.uk>
 <202408071221.92B6E385C@keescook>
 <ZrPvLIjW0p8j5C1x@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrPvLIjW0p8j5C1x@finisterre.sirena.org.uk>

On Wed, Aug 07, 2024 at 11:03:24PM +0100, Mark Brown wrote:
> On Wed, Aug 07, 2024 at 12:23:01PM -0700, Kees Cook wrote:
> > On Wed, Aug 07, 2024 at 01:39:27PM +0100, Mark Brown wrote:
> 
> > >  		size = args->shadow_stack_size;
> > > +		shstk->base = 0;
> > > +		shstk->size = 0;
> 
> > Yup, that fixes it!
> 
> >   # Totals: pass:23 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> > (The skip is "Shadow stack on system without shadow stack")
> 
> Excellent, thanks!  It's amazing how many dumb mistakes you can find if
> you actually try running the code :/ .

Heh, well, it's tricky work writing it without reference hardware. :) I
just wish there was CET emulation in QEmu...

-- 
Kees Cook

