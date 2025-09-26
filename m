Return-Path: <linux-kselftest+bounces-42458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C81BA3740
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFBA387E4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DC12F530E;
	Fri, 26 Sep 2025 11:14:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DB261B6E;
	Fri, 26 Sep 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758885267; cv=none; b=EduofZnYsWvmpnobfFTrrMU7BDMNyjm2wO0JnG1+9m/0sofmQRbsCbBm8/7gJ7Tyq1Ag1IELoScHXupgVwo5L8DBVq4xi9J6DNEJfz99SUVXr2vUXP/7g/wH+5m4ffGZoVrZlM9ztUdzlyz1KY6GIsvjk/jlSehRgKZYBPQp7Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758885267; c=relaxed/simple;
	bh=bFi6Ek3oe8OLhkTyKum/YZ1r4TzWObqlfujdrk08Olw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGjV+N3NoM+bBTWy63Tw0GlMVYr0TMssyLjJCkd/vSfw/waek3gSc+cuEPPFBVfd9jws7qboB8yL/AxmTzn0vnMkqqaa5LdirWWnYq3IBbbfKtE83/oHhDkJTT0EsBjdoCRyF1Xg52zbihxlTVNISg2U3+dX6Py8wTLnY6Hnslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67574C4CEF4;
	Fri, 26 Sep 2025 11:14:24 +0000 (UTC)
Date: Fri, 26 Sep 2025 12:14:21 +0100
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
Message-ID: <aNZ1jVLhc_Zg99Jb@arm.com>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
 <20250921-arm64-gcs-exit-token-v1-1-45cf64e648d5@kernel.org>
 <aNVx9vlgi8t81V6Y@arm.com>
 <38d629f2-99bb-4b13-a6ed-a4126d130b1f@sirena.org.uk>
 <aNWLwkn1fJDvWUyu@arm.com>
 <41929a12-59f4-419e-9f15-eaa09f0df0f3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41929a12-59f4-419e-9f15-eaa09f0df0f3@sirena.org.uk>

On Thu, Sep 25, 2025 at 08:00:40PM +0100, Mark Brown wrote:
> On Thu, Sep 25, 2025 at 07:36:50PM +0100, Catalin Marinas wrote:
> > On Thu, Sep 25, 2025 at 06:01:07PM +0100, Mark Brown wrote:
> > > On Thu, Sep 25, 2025 at 05:46:46PM +0100, Catalin Marinas wrote:
> > > > On Sun, Sep 21, 2025 at 02:21:35PM +0100, Mark Brown wrote:
> 
> > > We can't have scheduled?  That's actually a pleasant surprise, that was
> > > the main hole I was thinking of in the cover letter.
> 
> > Well, double-check. AFAICT, gcs_free() is only called on the exit_mm()
> > path when a thread dies.
> 
> > I think gcs_free() may have been called in other contexts before the
> > cleanups you had in 6.16 (there were two more call sites for
> > gcs_free()). If that's the case, we could turn these checks into
> > WARN_ON_ONCE().
> 
> Yeah, just I need to convince myself that we're always running the
> exit_mm() path in the context of the exiting thread.  Like you say it
> needs checking but hopefully you're right and the current code is more
> correct than I had thought.

The only path to gcs_free() is via mm_release() -> deactivate_mm().
mm_release() is called from either exit_mm_release() or
exec_mm_release(). These two functions are only called with current and
current->mm.

I guess for historical reasons, they take task and mm parameters but in
recent mainline, they don't seem to get anything other than current.

-- 
Catalin

