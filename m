Return-Path: <linux-kselftest+bounces-20264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF569A6A5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 15:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C457D281691
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E836D1DDF5;
	Mon, 21 Oct 2024 13:31:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F91946C
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517480; cv=none; b=shY7NOiktB+1u2hlsmc1TNHHnbCVrEI4mei/OPcTnzmGjAK0PV5m8oaatRdPSwVX6fpKl+DWlVaNk45HRwne007mS1o4rTU+2j+lo+33jWHBAuoGzhv577ypUja47UGiF90TbTgOC9XAaqtSPD1ddqRYqPHvI6y6b3B/8W/VhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517480; c=relaxed/simple;
	bh=O1ENYtPDzMMXimxIZbuzacroSqhnycqyL5rEbOOU3Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvxa4bKRH88iPGS5UxtmwwYriK+kaK+59nWMiL2+XLYLOeM5mnPAfveW2iwja2K0LyPoq432xWTCkr3gNujGGy97vYR3YCRM+TFnprsftpgy8U4jLQjs6mTzyb3krvkhp2PLZ4f9ddi8AklM6kfXC+YUX5pRO4vg/2xhkGo9Jpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E8C6DA7;
	Mon, 21 Oct 2024 06:31:47 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B94843F73B;
	Mon, 21 Oct 2024 06:31:15 -0700 (PDT)
Date: Mon, 21 Oct 2024 14:31:08 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, jeffxu@chromium.org,
	joey.gouly@arm.com, shuah@kernel.org, will@kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org,
	pierre.langlois@arm.com
Subject: Re: [PATCH 0/5] Improve arm64 pkeys handling in signal delivery
Message-ID: <ZxZXnM9vUj+tex/z@e133380.arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <ZxEx5aXPX2mHngoB@e133380.arm.com>
 <627c1297-8151-43d1-b46b-a962301b18fa@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <627c1297-8151-43d1-b46b-a962301b18fa@arm.com>

On Mon, Oct 21, 2024 at 12:06:25PM +0200, Kevin Brodsky wrote:
> On 17/10/2024 17:48, Dave Martin wrote:
> > On Thu, Oct 17, 2024 at 02:39:04PM +0100, Kevin Brodsky wrote:
> >> This series is a follow-up to Joey's Permission Overlay Extension (POE)
> >> series [1] that recently landed on mainline. The goal is to improve the
> >> way we handle the register that governs which pkeys/POIndex are
> >> accessible (POR_EL0) during signal delivery. As things stand, we may
> >> unexpectedly fail to write the signal frame on the stack because POR_EL0
> >> is not reset before the uaccess operations. See patch 3 for more details
> >> and the main changes this series brings.
> >>
> >> A similar series landed recently for x86/MPK [2]; the present series
> >> aims at aligning arm64 with x86. Worth noting: once the signal frame is
> >> written, POR_EL0 is still set to POR_EL0_INIT, granting access to pkey 0
> >> only. This means that a program that sets up an alternate signal stack
> >> with a non-zero pkey will need some assembly trampoline to set POR_EL0
> >> before invoking the real signal handler, as discussed here [3].
> > This feels a bit bogus (though it's anyway orthogonal to this series).
> 
> I'm not very fond of this either. However I believe this is the correct
> first step: bring arm64 in line with x86. Removing all restrictions
> before uaccess and then setting POR_EL0 to POR_EL0_INIT enables
> userspace to use any pkey for the alternate signal stack without an ABI
> change, albeit not in a very comfortable way (if the pkey is not 0).

I see: we try not to prevent userspace from using whatever pkey it
likes for the alternate signal stack, but we are only permissive for
the bare minimum operations that userspace can't possibly control for
itself (i.e., writing the signal frame).

This whole thing feels a bit of a botch, though.

Do we know of anyone actually using a sigaltstack with a pkey other
than 0?  Why the urgency?  Code relying on an asm shim on x86 is
already nonportable, unless I've misunderstood something, so simply
turning on arm64 pkeys support in the kernel and libc shouldn't break
anything today?  (At least, nothing that wasn't asking to be broken.)

> 
> > Really, we want some way for userspace to tell the kernel what
> > permissions to use for the alternate signal stack and signal handler
> > using it, and then honour that request consistently (just as we try to
> > do for the main stack today).
> >
> > ss_flags is mostly unused... I wonder whether we could add something in
> > there?  Or add a sigaltstack2()?
> 
> Yes, this would be sensible as a second step (backwards-compatible
> extension). Exactly how that API would look like is not trivial though:
> is the pkey implicitly derived from the pointer provided to
> sigaltstack()? Is there a need to specify another pkey for code, or do
> we just assume that the signal handler is only using code with pkey 0?
> (Not a concern on x86 as MPK doesn't restrict execution.) Would be very
> interested to hear opinions on this.
> 
> Kevin

I would vote for specifying the pkey (or, if feasible, PKRU or
modifications to it) in some bits of ss_flags, or in an additional
flags argument to sigaltstack2().

Memory with a non-zero pkey cannot be used 100% portably, period, and
having non-RW(X) permissions on pkey 0 at any time is also not
portable, period.  So I'm not sure that having libc magically guess
what userspace's pkeys policy is supposed to be based on racily digging
metadata out of /proc/self/maps or a cache of it etc. would be such a
good idea.

There are other ways to approach (or not approach) this though --
I would be interested to hear what other people think too...

Cheers
---Dave

