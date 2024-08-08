Return-Path: <linux-kselftest+bounces-15041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A7494C3F0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 19:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F7A1C22326
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 17:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB50F145B21;
	Thu,  8 Aug 2024 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekqd0hqv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C112CDAE;
	Thu,  8 Aug 2024 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723139673; cv=none; b=X260RzfR3fMYVN93NDs4c/w+XkvXQpdJncYAcrcB9SHnkS9Ln3hFKZvyhO2P5671FG/al2Qi1w2WQxWorLIBCnUXRb3uJaFfbMXVIVOpV1aGgnsJrF76CtTibyt4WCpkxHk0kPPtS2HVESAeH7STwVptFakf3Sf6sABENlWtiH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723139673; c=relaxed/simple;
	bh=J3H9kOyv2IqWJ6BxkDpHlkp1OGHMwH5Wxp6YCl7+Cqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iadxhltGFH7+BMbwUASSjucpQnEebvoQkKmJDEMteE8Gfrqf9aS8mLIDDUlkY7pZ4K0ZozY+Mx0WldU4PCsSUf5pwNvf9HgtaI0U0OMa/5IwudoSIJBYJVy5mS417bPrMISRW7ohFKMSGdTHG5rmDhLpmQIB2JxBFU8PjuSxTNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekqd0hqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E899AC4AF09;
	Thu,  8 Aug 2024 17:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723139672;
	bh=J3H9kOyv2IqWJ6BxkDpHlkp1OGHMwH5Wxp6YCl7+Cqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekqd0hqv0LzONtXLHWyjhNvQhMVw6kw61Z1HTnfJJm8D+VOLzUjcK7euQYterAm+V
	 6WyZWYRYPtICBYiWTje3Evi6FA9e4f/uEZO9kW66s8y/czmR1vjqG/mKFi6UbXupwu
	 JNgA2nnN0nQJGaZN170lM8qwTvVKgih+PNwSsdripnzH+Ph+8du+yP7Q2Oo2Lh8T5V
	 ZQMnEmuzABbR6HCo3Gmu1xLr6zC3SWCf5XlebM8BKLO7ng1Kww6RQf9mFQoEZyLdlA
	 MX9tfcSMY+TxbFHZqqZRlINhp1z8esszCfDRUcUN/ItflR8HVvklxr5XpqlOlkMUr8
	 1hPmX7jVN47Wg==
Date: Thu, 8 Aug 2024 10:54:31 -0700
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
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFT v8 0/9] fork: Support shadow stacks in clone3()
Message-ID: <202408081053.0EABACA@keescook>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>

On Thu, Aug 08, 2024 at 09:15:21AM +0100, Mark Brown wrote:
> The kernel has recently added support for shadow stacks, currently
> x86 only using their CET feature but both arm64 and RISC-V have
> equivalent features (GCS and Zicfiss respectively), I am actively
> working on GCS[1].  With shadow stacks the hardware maintains an
> additional stack containing only the return addresses for branch
> instructions which is not generally writeable by userspace and ensures
> that any returns are to the recorded addresses.  This provides some
> protection against ROP attacks and making it easier to collect call
> stacks.  These shadow stacks are allocated in the address space of the
> userspace process.
> 
> Our API for shadow stacks does not currently offer userspace any
> flexiblity for managing the allocation of shadow stacks for newly
> created threads, instead the kernel allocates a new shadow stack with
> the same size as the normal stack whenever a thread is created with the
> feature enabled.  The stacks allocated in this way are freed by the
> kernel when the thread exits or shadow stacks are disabled for the
> thread.  This lack of flexibility and control isn't ideal, in the vast
> majority of cases the shadow stack will be over allocated and the
> implicit allocation and deallocation is not consistent with other
> interfaces.  As far as I can tell the interface is done in this manner
> mainly because the shadow stack patches were in development since before
> clone3() was implemented.
> 
> Since clone3() is readily extensible let's add support for specifying a
> shadow stack when creating a new thread or process in a similar manner
> to how the normal stack is specified, keeping the current implicit
> allocation behaviour if one is not specified either with clone3() or
> through the use of clone().  The user must provide a shadow stack
> address and size, this must point to memory mapped for use as a shadow
> stackby map_shadow_stack() with a shadow stack token at the top of the
> stack.
> 
> Please note that the x86 portions of this code are build tested only, I
> don't appear to have a system that can run CET avaible to me, I have
> done testing with an integration into my pending work for GCS.  There is
> some possibility that the arm64 implementation may require the use of
> clone3() and explicit userspace allocation of shadow stacks, this is
> still under discussion.
> 
> Please further note that the token consumption done by clone3() is not
> currently implemented in an atomic fashion, Rick indicated that he would
> look into fixing this if people are OK with the implementation.
> 
> A new architecture feature Kconfig option for shadow stacks is added as
> here, this was suggested as part of the review comments for the arm64
> GCS series and since we need to detect if shadow stacks are supported it
> seemed sensible to roll it in here.
> 
> [1] https://lore.kernel.org/r/20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org/
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Kees Cook <kees@kernel.org>

(Testing was done on CET hardware.)

-- 
Kees Cook

