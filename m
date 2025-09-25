Return-Path: <linux-kselftest+bounces-42406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CED5DBA10B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 20:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC28C4E0385
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BFC319873;
	Thu, 25 Sep 2025 18:36:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BD43191C9;
	Thu, 25 Sep 2025 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825416; cv=none; b=UbmEyIEBIdVjPZTS/Uo6zaIYx/AhdUHt2BdMtfe1SRk/AYkh5bvAC7zRUb9Lwd76RLovAA33Q4VDGmWYGjM0ilB3erERsgou7PKuYGwauQ3XM8MLkh5iefRhJTmKanS7Yc37+taxpj28hBVHTAg0RuzFkSm2jBXDmaj1A9P7EL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825416; c=relaxed/simple;
	bh=sxFKez82qQVo5EWMBQ+NHEwO3z/ScVrpa3kUSDWZ7co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgcW8pq9HWTqUnDh1Y5EqR+IwO6makGgn8wMWWLeCarenq1o9twlYe7pRB44U09KMBYGXRamT/PnsuyZBZhwwkKfzxlO+r5dCh2aZDP5l5k/MGGnjJwCrp8TtxOaBAGwoWNeLDM0XoeFgoFATMEaiAIK9rny6o1mE/Eut6TapUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDFBC4CEF0;
	Thu, 25 Sep 2025 18:36:53 +0000 (UTC)
Date: Thu, 25 Sep 2025 19:36:50 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
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
Message-ID: <aNWLwkn1fJDvWUyu@arm.com>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
 <20250921-arm64-gcs-exit-token-v1-1-45cf64e648d5@kernel.org>
 <aNVx9vlgi8t81V6Y@arm.com>
 <38d629f2-99bb-4b13-a6ed-a4126d130b1f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38d629f2-99bb-4b13-a6ed-a4126d130b1f@sirena.org.uk>

On Thu, Sep 25, 2025 at 06:01:07PM +0100, Mark Brown wrote:
> On Thu, Sep 25, 2025 at 05:46:46PM +0100, Catalin Marinas wrote:
> > On Sun, Sep 21, 2025 at 02:21:35PM +0100, Mark Brown wrote:
> 
> > > +	} else if (task == current &&
> > > +		   task->thread.gcs_el0_mode & PR_SHADOW_STACK_EXIT_TOKEN) {
> 
> > I checked the code paths leading here and task is always current. But
> > better to keep the test in case the core code ever changes.
> 
> We can't have scheduled?  That's actually a pleasant surprise, that was
> the main hole I was thinking of in the cover letter.

Well, double-check. AFAICT, gcs_free() is only called on the exit_mm()
path when a thread dies.

I think gcs_free() may have been called in other contexts before the
cleanups you had in 6.16 (there were two more call sites for
gcs_free()). If that's the case, we could turn these checks into
WARN_ON_ONCE().

> > > +		/*
> > > +		 * We can't do anything constructive if this fails,
> > > +		 * and the thread might be exiting due to being in a
> > > +		 * bad state anyway.
> > > +		 */
> > > +		put_user_gcs(cap_val, cap_ptr, &ret);
> > > +
> > > +		/*
> > > +		 * Ensure the new cap is ordered before standard
> > > +		 * memory accesses to the same location.
> > > +		 */
> > > +		gcsb_dsync();
> > > +	}
> 
> > The only downside is that, if the thread did not unwind properly, we
> > don't write the token where it was initially. We could save the token
> > address from clone3() and restore it there instead.
> 
> If we do that and the thread pivots away to another GCS and exits from
> there then we'll write the token onto a different stack.  Writing onto
> the location that userspace provided when creating the thread should be
> fine for glibc's needs but it feels like the wrong assumption to bake
> in, to me it feels less bad to have to map a new GCS in the case where
> we didn't unwind properly.  There will be overhead in doing that but the
> thread is already exiting uncleanly so imposing a cost doesn't seem
> disproportionate.

You are right, that's the safest. glibc can always unmap the shadow
stack if the thread did not exit properly.

That said, does glibc ensure the thread unwinds its stack (and shadow
stack) on pthread_exit()? IIUC, it does, at least for the normal stack,
but I'm not familiar with the codebase.

-- 
Catalin

