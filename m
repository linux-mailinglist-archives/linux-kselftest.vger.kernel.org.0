Return-Path: <linux-kselftest+bounces-15303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA4E9517D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 11:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3131C215DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907B015FA7B;
	Wed, 14 Aug 2024 09:39:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48D15F3E1;
	Wed, 14 Aug 2024 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628341; cv=none; b=Z59kxgcFtaNxPm10BPib/HcL3LLTxsEcJCAtmaeHLnjRII/LQg5HZonNYrNeOjhMKouQgfpksnoG/lE26sKvkUIT+DYhN/h4rBON6woUNL1yr6CEeOR8SvF53JI3bOxHMpqdFU5CyUQcrsjRpHqtn1Dp3lAvqy/d70mc+B4ds44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628341; c=relaxed/simple;
	bh=dMgo2PY9BidnIDV1lYsIxQXlHgxwJtmRP9njkJySyto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGI+BvHDziLU8yyvvaQI/yTJu9dHQu5uz6NcYVv7WTqiCPcGNgGW2+f+rv5r+zzRhNjO2CN+REn6CwwR+0coB8yu1f5MYbCP6HWfcbgxUgsADX+Lbchi4TibVFcQGT0mW+HnvDe4vYZ+qkflBmjSxH0Jy84gKdnf/Tyx//yh2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F87C32786;
	Wed, 14 Aug 2024 09:38:56 +0000 (UTC)
Date: Wed, 14 Aug 2024 10:38:54 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
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
	Will Deacon <will@kernel.org>, jannh@google.com,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Message-ID: <Zrx7Lj09b99ozgAE@arm.com>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <ZrZdrgOQVHhCyWmA@arm.com>
 <Zrag5A5K9pv1K9Uz@finisterre.sirena.org.uk>
 <ZruJCyXDRNhw6U5A@arm.com>
 <e24a93cb-e7ba-4046-a7c6-fe2ea12420e3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e24a93cb-e7ba-4046-a7c6-fe2ea12420e3@sirena.org.uk>

On Tue, Aug 13, 2024 at 07:58:26PM +0100, Mark Brown wrote:
> On Tue, Aug 13, 2024 at 05:25:47PM +0100, Catalin Marinas wrote:
> > However, the x86 would be slightly inconsistent here between clone() and
> > clone3(). I guess it depends how you look at it. The classic clone()
> > syscall, if one doesn't pass CLONE_VM but does set new stack, there's no
> > new shadow stack allocated which I'd expect since it's a new stack.
> > Well, I doubt anyone cares about this scenario. Are there real cases of
> > !CLONE_VM but with a new stack?
> 
> ISTR the concerns were around someone being clever with vfork() but I
> don't remember anything super concrete.  In terms of the inconsistency
> here that was actually another thing that came up - if userspace
> specifies a stack for clone3() it'll just get used even with CLONE_VFORK
> so it seemed to make sense to do the same thing for the shadow stack.
> This was part of the thinking when we were looking at it, if you can
> specify a regular stack you should be able to specify a shadow stack.

Yes, I agree. But by this logic, I was wondering why the current clone()
behaviour does not allocate a shadow stack when a new stack is
requested with CLONE_VFORK. That's rather theoretical though and we may
not want to change the ABI.

> > > > I'm confused that we need to consume the token here. I could not find
> > > > the default shadow stack allocation doing this, only setting it via
> > > > create_rstor_token() (or I did not search enough). In the default case,
> 
> > > As discussed for a couple of previous versions if we don't have the
> > > token and userspace can specify any old shadow stack page as the shadow
> > > stack this allows clone3() to be used to overwrite the shadow stack of
> > > another thread, you can point to a shadow stack page which is currently
> 
> > IIUC, the kernel-allocated shadow stack will have the token always set
> > while the user-allocated one will be cleared. I was looking to
> 
> No, when the kernel allocates we don't bother with tokens at all.  We
> only look for and clear a token with the user specified shadow stack.

Ah, you are right, I misread the alloc_shstk() function. It takes a
set_res_tok parameter which is false for the normal allocation.

> > I guess I was rather questioning the current choices than the new
> > clone3() ABI. But even for the new clone3() ABI, does it make sense to
> > set up a shadow stack if the current stack isn't changed? We'll end up
> > with a lot of possible combinations that will never get tested but
> > potentially become obscure ABI. Limiting the options to the sane choices
> > only helps with validation and unsurprising changes later on.
> 
> OTOH if we add the restrictions it's more code (and more test code) to
> check, and thinking about if we've missed some important use case.  Not
> that it's a *huge* amount of code, like I say I'd not be too unhappy
> with adding a restriction on having a regular stack specified in order
> to specify a shadow stack.

I guess we just follow the normal stack behaviour for clone3(), at least
we'd be consistent with that.

Anyway, I understood this patch now and the ABI decisions. FWIW:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

