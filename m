Return-Path: <linux-kselftest+bounces-20276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CDE9A6E23
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 17:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F87B20DD0
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996219AD71;
	Mon, 21 Oct 2024 15:30:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413CA19ABBD
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524610; cv=none; b=id/StMUSq6gwKI3AUQnGz1aMDs6vKIRCl3uOwsXm2eTEdlLiKcyrPsyiGNu/Aa/WS9DT+ZUzX04erqcvH5RRvDltRw0JxjHZsxIAgxRQYxnhAJIgAsw++pcrnTPnA+dgCuKcfnMLuAUtA2V1rBQBDTP112+gAOOruncCW7aSkgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524610; c=relaxed/simple;
	bh=WUhKvgFzA8q4xUQNuKSndWjbdDM60hjEK/2J28f2M1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5F0C+lDRC7N/tQwVuzvo7rmL/zTPbr5Ll6KGsVum3F93Y2Q553wW3WnqGmBRcShvdU8UEJ8+ARGF18QYCFLFgfSY3wrsWk2BTDzvED4cJWtbtfBG1LBEZdgenJprizttS5YySX8YmmG+QLMHuhIFPVRBppdlPsiA4lXbYpu008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381C7C4CEC3;
	Mon, 21 Oct 2024 15:30:07 +0000 (UTC)
Date: Mon, 21 Oct 2024 16:30:04 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, dave.hansen@linux.intel.com,
	jeffxu@chromium.org, joey.gouly@arm.com, shuah@kernel.org,
	will@kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org,
	pierre.langlois@arm.com
Subject: Re: [PATCH 0/5] Improve arm64 pkeys handling in signal delivery
Message-ID: <ZxZzfMV0dbjJ55UD@arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <ZxEx5aXPX2mHngoB@e133380.arm.com>
 <627c1297-8151-43d1-b46b-a962301b18fa@arm.com>
 <ZxZXnM9vUj+tex/z@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZXnM9vUj+tex/z@e133380.arm.com>

On Mon, Oct 21, 2024 at 02:31:08PM +0100, Dave P Martin wrote:
> > > On Thu, Oct 17, 2024 at 02:39:04PM +0100, Kevin Brodsky wrote:
> > >> This series is a follow-up to Joey's Permission Overlay Extension (POE)
> > >> series [1] that recently landed on mainline. The goal is to improve the
> > >> way we handle the register that governs which pkeys/POIndex are
> > >> accessible (POR_EL0) during signal delivery. As things stand, we may
> > >> unexpectedly fail to write the signal frame on the stack because POR_EL0
> > >> is not reset before the uaccess operations. See patch 3 for more details
> > >> and the main changes this series brings.
> > >>
> > >> A similar series landed recently for x86/MPK [2]; the present series
> > >> aims at aligning arm64 with x86. Worth noting: once the signal frame is
> > >> written, POR_EL0 is still set to POR_EL0_INIT, granting access to pkey 0
> > >> only. This means that a program that sets up an alternate signal stack
> > >> with a non-zero pkey will need some assembly trampoline to set POR_EL0
> > >> before invoking the real signal handler, as discussed here [3].
[...]
> Memory with a non-zero pkey cannot be used 100% portably, period, and
> having non-RW(X) permissions on pkey 0 at any time is also not
> portable, period.  So I'm not sure that having libc magically guess
> what userspace's pkeys policy is supposed to be based on racily digging
> metadata out of /proc/self/maps or a cache of it etc. would be such a
> good idea.

I agree that changing RWX overlay permission for pkey 0 to anything else
is a really bad idea. We can't prevent it but we shouldn't actively try
to work around it in the kernel either. With the current signal ABI, I
don't think we should support anything other than pkey 0 for the stack.
Since the user shouldn't change the pkey 0 RWX overlay permission
anyway, I don't think we should reset POR_EL0 _prior_ to writing the
signal frame. The best we can do is document it somewhere.

So on patch 3 I'd only ensure that we have POR_EL0_INIT when invoking
the signal handler and not when performing the uaccess. If the uaccess
fails, we'd get a fatal SIGSEGV. The user may have got it already if it
made the stack read-only.

Currently the primary use of pkeys is for W^X and signal stacks
shouldn't fall into this category. If we ever have a strong case for
non-zero pkeys on the signal stack, we'll need to look into some new
ABI. I'm not sure about SS_* flags though, I think the signal POR_EL0
should be associated with the sigaction rather than the stack (the
latter would just be mapped by the user with the right pkey, the kernel
doesn't need to know which, only what POR_EL0 is needed by the handler).

Until such case turns up, I'd not put any effort into ABI improvements.
I can think of some light compartmentalisation where we have a pkey
that's "privileged" and all threads have a POR_EL0 that prevents access
to that pkey. The signal handler would have more permissive rights to
that privileged pkey. I'd not proactively add support for this though.

-- 
Catalin

