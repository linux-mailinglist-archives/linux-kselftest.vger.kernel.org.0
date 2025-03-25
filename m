Return-Path: <linux-kselftest+bounces-29734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE9DA6EC77
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 10:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4363B08CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A794F1AAA0F;
	Tue, 25 Mar 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQPBiIft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF339479;
	Tue, 25 Mar 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742894996; cv=none; b=qX9EaiLdPZUI02rp8huM91UYrI3LcMGHFaZ7fyUfq5FtXHYu8kTOiUzfTNIR90QMwkGIxFrcoJGfUgFxX+X6w4NdcvM2huRWezBp/sEgL/yOoPsAXe5bMCIEyvy1Zra5DaSAb8KsbaonpleeGq1NINBNphL1jVh3NfOIiFaI21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742894996; c=relaxed/simple;
	bh=1XjDA2TRQ9ihwHMJrSFe2XivT2loKmM8kBKqbZDguA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X44bywfvWD/xQdUiEQ+xAHJwmis0sY6L5bIZURr4mpnCw70nwqXbxFHn/Mvggre0lCsXo8qnZGRKcDDi0cPGVPGfEaUlRALKke4AJKiXC7XqZhx04GyqqsjgGqJvq7njdEqRzkdMB18W6VnkwSVzA7zKQ0twkGPhu8OOWelMlYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQPBiIft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B00C4CEE4;
	Tue, 25 Mar 2025 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742894995;
	bh=1XjDA2TRQ9ihwHMJrSFe2XivT2loKmM8kBKqbZDguA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQPBiIftEH0lvxjFB8hXV0PxoDv28RSBSsmtwOPnUI+VjkqwEsM9dcrcyVHuGbme7
	 7FdB3NhiIxTFbR9O0A9wgzP46Q1hYE4bxtjP+Xtuov1/RPQI/h20u9vNwaeYv+2DXW
	 x0yc32lRrYPb/83/NAHzFqoERTWKruHNERopDWkWX1q77nGfIXRGD+fk2qsLf4eOqe
	 QBTZGVA0pkqgXyMYumnAFCuZ8k2Q0bsRf/tf3b8DJlWNwj+hHaFqv+lrwyy1r0zJxW
	 6ZUy6BBDcgvu4dKXbb8+NMchkD8WmpkXVhpa4/jwv1fnnSS4Vt7NZ/S11KRr4zvjGC
	 DA9EEO8ZS16gw==
Date: Tue, 25 Mar 2025 10:29:50 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Malaya Kumar Rout <malayarout91@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/x86/lam: fix memory leak and resource leak in
 lam.c
Message-ID: <Z-J3jlYcocf_w4M_@gmail.com>
References: <malayarout91@gmail.com>
 <20250324124810.883767-1-malayarout91@gmail.com>
 <20250324125108.GH14944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324125108.GH14944@noisy.programming.kicks-ass.net>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Mar 24, 2025 at 06:17:50PM +0530, Malaya Kumar Rout wrote:
> > Static Analyis for bench_htab_mem.c with cppcheck:error
> > tools/testing/selftests/x86/lam.c:585:3:
> > error: Resource leak: file_fd [resourceLeak]
> > tools/testing/selftests/x86/lam.c:593:3:
> > error: Resource leak: file_fd [resourceLeak]
> > tools/testing/selftests/x86/lam.c:600:3:
> > error: Memory leak: fi [memleak]
> > tools/testing/selftests/x86/lam.c:1066:2:
> > error: Resource leak: fd [resourceLeak]
> > 
> > fix the issue by closing the file descriptors and 
> > releasing the allocated memory.
> > 
> 
> But but but, doesn't the program just exit on any of those 'errors'
> anyway?
> 
> That is, iirc this is a single shot program.

While that's true, still proper cleanup of resources is a good practice 
- and in more complicated tools it's useful to fix even these 
semi-false-positives, to make sure other warnings don't get missed. 

Having said that, the error/cleanup control flow here doesn't look 
overly clean here to begin with, so I'd suggest fixing that (with goto 
labels or such) - which would fix the file_fd 'leak' as a happy side 
effect.

Thanks,

	Ingo

