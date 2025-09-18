Return-Path: <linux-kselftest+bounces-41866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659BFB85E76
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F823BC38E
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91D2315D57;
	Thu, 18 Sep 2025 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dscna0nG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E0314A62;
	Thu, 18 Sep 2025 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211455; cv=none; b=fiWGvBhHrjfxASKMnfA7xkL0pRurIOvi14/r1PoNgRZIZQqqX8CmLU93uCdF4sdkI0VefamvfhljZSrc10r2PPBNjek0gWTEBX/rOvgFw/Qgrs1CPqI6fL9JPVYufpdL5Sql9S3IA1Z2sOa4yTW1WnYTvSY+9scoRY2hm+vgRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211455; c=relaxed/simple;
	bh=KoVegkDPh0ZM36aRdHcQyVrYFVVEpjR6Sp+OFwQrv48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQF1z2/SHg4b34vtntgFtRoh3pMwuVMB0YAdzzBY4IGbOf7h5di/inc8WhDh21MnCOMzvsmSWE35RgrczdW8VdKxKZg3LlhRS20+fZ+5WHFCme1k1bmXBBwxP4qWv1NH7+/v7iMJ4wgx/41ponO/YI6uv3MSzahsdIGZFq5Mrng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dscna0nG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145F1C4CEF7;
	Thu, 18 Sep 2025 16:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758211455;
	bh=KoVegkDPh0ZM36aRdHcQyVrYFVVEpjR6Sp+OFwQrv48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dscna0nGYhWGehI2V//TDn/qvcHItUF/gbzWHKcwPKVxSUt2uVtcVXY6GmGg9I/Ek
	 I/S3gCHbNFOHrRMa6c21b57WXDeLXSH1/ul7o3hjTUvnboJdIBqkq0vjskW3rjLBch
	 EtiDlPeSJS+ioTfYmaeXOOPNvJNAfnpOmgvlWDOyFt2nG1fmVJy4MTMxuphCi+/ehm
	 nh8u5Gt7vfbaprkebj1k5Zmpjy2v0W7N7fbxekGIac4ZXpWhz/hfCgaZio/aCTxGOY
	 nfVhloTAhAvQDl2RUMsX+HB3v2nG2J4fm8z1GvnWpD9UiJmADjQLlP6GHupIQRDZEF
	 LfRt9ejSMHiEA==
Date: Thu, 18 Sep 2025 17:04:06 +0100
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>, brauner@kernel.org
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
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>, jannh@google.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v21 4/8] fork: Add shadow stack support to clone3()
Message-ID: <aMwtdtRHT7oHhYLf@willie-the-truck>
References: <20250916-clone3-shadow-stack-v21-0-910493527013@kernel.org>
 <20250916-clone3-shadow-stack-v21-4-910493527013@kernel.org>
 <aMv9XRq_sAQbQwjI@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMv9XRq_sAQbQwjI@willie-the-truck>

On Thu, Sep 18, 2025 at 01:38:53PM +0100, Will Deacon wrote:
> On Tue, Sep 16, 2025 at 12:12:09AM +0100, Mark Brown wrote:
> > Unlike with the normal stack there is no API for configuring the shadow
> > stack for a new thread, instead the kernel will dynamically allocate a
> > new shadow stack with the same size as the normal stack. This appears to
> > be due to the shadow stack series having been in development since
> > before the more extensible clone3() was added rather than anything more
> > deliberate.
> > 
> > Add a parameter to clone3() specifying a shadow stack pointer to use
> > for the new thread, this is inconsistent with the way we specify the
> > normal stack but during review concerns were expressed about having to
> > identify where the shadow stack pointer should be placed especially in
> > cases where the shadow stack has been previously active.  If no shadow
> > stack is specified then the existing implicit allocation behaviour is
> > maintained.
> > 
> > If a shadow stack pointer is specified then it is required to have an
> > architecture defined token placed on the stack, this will be consumed by
> > the new task, the shadow stack is specified by pointing to this token.  If
> > no valid token is present then this will be reported with -EINVAL.  This
> > token prevents new threads being created pointing at the shadow stack of
> > an existing running thread.  On architectures with support for userspace
> > pivoting of shadow stacks it is expected that the same format and placement
> > of tokens will be used, this is the case for arm64 and x86.
> > 
> > If the architecture does not support shadow stacks the shadow stack
> > pointer must be not be specified, architectures that do support the
> > feature are expected to enforce the same requirement on individual
> > systems that lack shadow stack support.
> > 
> > Update the existing arm64 and x86 implementations to pay attention to
> > the newly added arguments, in order to maintain compatibility we use the
> > existing behaviour if no shadow stack is specified. Since we are now
> > using more fields from the kernel_clone_args we pass that into the
> > shadow stack code rather than individual fields.
> > 
> > Portions of the x86 architecture code were written by Rick Edgecombe.
> > 
> > Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>
> > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
> >  arch/arm64/mm/gcs.c              | 47 +++++++++++++++++++-
> >  arch/x86/include/asm/shstk.h     | 11 +++--
> >  arch/x86/kernel/process.c        |  2 +-
> >  arch/x86/kernel/shstk.c          | 53 ++++++++++++++++++++---
> >  include/asm-generic/cacheflush.h | 11 +++++
> >  include/linux/sched/task.h       | 17 ++++++++
> >  include/uapi/linux/sched.h       |  9 ++--
> >  kernel/fork.c                    | 93 ++++++++++++++++++++++++++++++++++------
> >  8 files changed, 217 insertions(+), 26 deletions(-)
> 
> It would be great if Christian could give this the thumbs up, given that
> it changes clone3(). I think the architecture parts are all ready at this
> point.

ah, I may have spoken too soon :/

Catalin pointed me at this glibc thread:

https://marc.info/?l=glibc-alpha&m=175811917427562

which sounds like they're not entirely on board with the new ABI.

Will

