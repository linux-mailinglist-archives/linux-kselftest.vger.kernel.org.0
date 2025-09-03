Return-Path: <linux-kselftest+bounces-40686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B1B42591
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E756417BFC3
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6AA239562;
	Wed,  3 Sep 2025 15:34:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F3A1E1E12;
	Wed,  3 Sep 2025 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913653; cv=none; b=L3cwjztA+RR0lPErGL8MrKY/ztNvzoK4T/9dunCJPWAXkzaOr1XPOF0CHO/qsZXE1tUrjzxRwO7WrhVnRk/tLNhEtR1wDFYG705CM/V8QSOY57fWjAfGOaQmQbd6JSCZUyR6yoEVY4+pglz7mP8ezx27Zfe2abb9qNu3I0jQOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913653; c=relaxed/simple;
	bh=SKxGYBjZVCad35Td5KYLSPQCKCGpbRI8Hm6stRtJ3V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN+6ShUHokfz1IVW2NVdqwCfIJ9/VtvX3a42ksLbUFr3fHW4K4IbgOj4sIAoJSH8xXbseGv1eByFl4pSUzs3rTFghvyeATm3MAYjaW4NPSSHQbrmaVmO85uJmR61hCIYPvLWthCJTrXsVC2k146TKbcPdkgRJn3RyEf/PIUViko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2027C4CEE7;
	Wed,  3 Sep 2025 15:34:07 +0000 (UTC)
Date: Wed, 3 Sep 2025 16:34:05 +0100
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
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v20 4/8] fork: Add shadow stack support to clone3()
Message-ID: <aLhf7XdOO99IyRfA@arm.com>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
 <20250902-clone3-shadow-stack-v20-4-4d9fff1c53e7@kernel.org>
 <aLdbT67auUpaOj2T@arm.com>
 <734e4c2c-a478-4019-86f7-4965c2b042e1@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <734e4c2c-a478-4019-86f7-4965c2b042e1@sirena.org.uk>

On Wed, Sep 03, 2025 at 11:01:05AM +0100, Mark Brown wrote:
> On Tue, Sep 02, 2025 at 10:02:07PM +0100, Catalin Marinas wrote:
> > On Tue, Sep 02, 2025 at 11:21:48AM +0100, Mark Brown wrote:
> > > +	mmap_read_lock(mm);
> > > +
> > > +	addr = untagged_addr_remote(mm, args->shadow_stack_token);
> > > +	page = get_user_page_vma_remote(mm, addr, FOLL_FORCE | FOLL_WRITE,
> > > +					&vma);
> 
> > However, I wonder whether it makes sense to use the remote mm access
> > here at all. Does this code ever run without CLONE_VM? If not, this is
> > all done within the current mm context.
> 
> Yes, userspace can select if it wants CLONE_VM or not so we should
> handle that case.  We discussed this on prior versions and we felt that
> while we couldn't immediately see the use case for !CLONE_VM there
> wasn't a good reason to restrict the creativity of userspace developers,
> and given that you can specify the regular stack in these cases it seems
> logical that you'd also be able to specify the shadow stack.

Yeah. Not sure it makes much sense in practice but if we allow a new
stack without CLONE_VM, we should also allow a shadow stack. Thanks for
the clarification.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

