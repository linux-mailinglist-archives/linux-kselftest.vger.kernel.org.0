Return-Path: <linux-kselftest+bounces-20382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 954989AA040
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 12:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA25B20E6B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 10:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674BB146A63;
	Tue, 22 Oct 2024 10:45:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4EF13B2A4
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593938; cv=none; b=cM9WP03nNKjJz2Srpbic0Th3p94udwcZjOrHbCfkyzQkvMBna8KjKwSacmmTIKYA3wqpyT21gU3unq0YsleYpX0DF0vu7OSTShoW/054BA5TW1o84lgZ5MrQNipS4Er6ZpVWD/tWeb39IEgzpXc+ouXO/4Kcynfj0tMk1FsQFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593938; c=relaxed/simple;
	bh=2dhzJj3LzFAKpuSgNWfgKJcs1wVXuldCJdzV64br2p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOA7i8EDk1yYdq/xDObo3w1dTac/8fn/mFiHNB1bG9KmdfnrZLdJsz5ADbReQqLoTIUmkHzeeX6/TrYsH6Zwc732NHdtywmr1xJeRAN5jDaeK8XvATn3tqtytUxEb26FCn8vuVXbS6iCpKF7eZgID2fKYI8AAxtq4n0RFFBQmL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E04C4CEE4;
	Tue, 22 Oct 2024 10:45:35 +0000 (UTC)
Date: Tue, 22 Oct 2024 11:45:32 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, dave.hansen@linux.intel.com,
	jeffxu@chromium.org, joey.gouly@arm.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org,
	pierre.langlois@arm.com
Subject: Re: [PATCH 0/5] Improve arm64 pkeys handling in signal delivery
Message-ID: <ZxeCTHmZ_dgDIbIJ@arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <ZxEx5aXPX2mHngoB@e133380.arm.com>
 <627c1297-8151-43d1-b46b-a962301b18fa@arm.com>
 <ZxZXnM9vUj+tex/z@e133380.arm.com>
 <ZxZzfMV0dbjJ55UD@arm.com>
 <20241021171937.GA26179@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021171937.GA26179@willie-the-truck>

On Mon, Oct 21, 2024 at 06:19:38PM +0100, Will Deacon wrote:
> On Mon, Oct 21, 2024 at 04:30:04PM +0100, Catalin Marinas wrote:
> > On Mon, Oct 21, 2024 at 02:31:08PM +0100, Dave P Martin wrote:
> > > > > On Thu, Oct 17, 2024 at 02:39:04PM +0100, Kevin Brodsky wrote:
> > > > >> This series is a follow-up to Joey's Permission Overlay Extension (POE)
> > > > >> series [1] that recently landed on mainline. The goal is to improve the
> > > > >> way we handle the register that governs which pkeys/POIndex are
> > > > >> accessible (POR_EL0) during signal delivery. As things stand, we may
> > > > >> unexpectedly fail to write the signal frame on the stack because POR_EL0
> > > > >> is not reset before the uaccess operations. See patch 3 for more details
> > > > >> and the main changes this series brings.
> > > > >>
> > > > >> A similar series landed recently for x86/MPK [2]; the present series
> > > > >> aims at aligning arm64 with x86. Worth noting: once the signal frame is
> > > > >> written, POR_EL0 is still set to POR_EL0_INIT, granting access to pkey 0
> > > > >> only. This means that a program that sets up an alternate signal stack
> > > > >> with a non-zero pkey will need some assembly trampoline to set POR_EL0
> > > > >> before invoking the real signal handler, as discussed here [3].
> > [...]
> > > Memory with a non-zero pkey cannot be used 100% portably, period, and
> > > having non-RW(X) permissions on pkey 0 at any time is also not
> > > portable, period.  So I'm not sure that having libc magically guess
> > > what userspace's pkeys policy is supposed to be based on racily digging
> > > metadata out of /proc/self/maps or a cache of it etc. would be such a
> > > good idea.
> > 
> > I agree that changing RWX overlay permission for pkey 0 to anything else
> > is a really bad idea. We can't prevent it but we shouldn't actively try
> > to work around it in the kernel either. With the current signal ABI, I
> > don't think we should support anything other than pkey 0 for the stack.
> > Since the user shouldn't change the pkey 0 RWX overlay permission
> > anyway, I don't think we should reset POR_EL0 _prior_ to writing the
> > signal frame. The best we can do is document it somewhere.
> > 
> > So on patch 3 I'd only ensure that we have POR_EL0_INIT when invoking
> > the signal handler and not when performing the uaccess. If the uaccess
> > fails, we'd get a fatal SIGSEGV. The user may have got it already if it
> > made the stack read-only.
> 
> Hmm, but based on what Kevin's saying, this would mean actively choosing
> a different ABI than what x86 is trying to get to.

I was more thinking of not relaxing the ABI further at this point in the
rc cycle rather than completely diverging (x86 did relax the ABI
subsequently to handle non-zero pkey sigaltstack).

> > Currently the primary use of pkeys is for W^X and signal stacks
> > shouldn't fall into this category. If we ever have a strong case for
> > non-zero pkeys on the signal stack, we'll need to look into some new
> > ABI. I'm not sure about SS_* flags though, I think the signal POR_EL0
> > should be associated with the sigaction rather than the stack (the
> > latter would just be mapped by the user with the right pkey, the kernel
> > doesn't need to know which, only what POR_EL0 is needed by the handler).
> > 
> > Until such case turns up, I'd not put any effort into ABI improvements.
> 
> Kevin -- do you know what prompted x86 to want the pkey to be reset early
> in signal delivery? Perhaps such a use-case already exists.

Given the email from Pierre with Chrome potentially using a sigaltstack
with a non-zero pkey, Kevin's patches (and the x86 changes) make more
sense. The question is whether we do this as a fix now or we leave the
relaxation for a subsequent kernel release. I guess we could squeeze it
now if we agree on the implementation.

-- 
Catalin

