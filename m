Return-Path: <linux-kselftest+bounces-47868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D91DCD70F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 21:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC2403023780
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 20:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5017B3081BE;
	Mon, 22 Dec 2025 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IArCkOoJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E9A2F3C22;
	Mon, 22 Dec 2025 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766434923; cv=none; b=Ncni4KftfQE+PcwBHZqbd+u23J7dizbCOoDujTFt8K7hEiwZP/09FXPCnuXoXXGVxXUnkBD34Iqzd4S8WCQ4o3/sEv2d6eEDoekIpWf+dAZaxMEFH6dt63pVKaBH2h2dujXXZCECuII5I9TK/gVEvuHxc/nzHuMb7FyVr0RHApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766434923; c=relaxed/simple;
	bh=il/A5ESFB43qQCBJVEVMQsv6iZegOJ25F7KaRc3mwr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoV7UhRPrtTPgk+DZuKbI1F6Ml277eUMGIR2KqvKifsPcTLy7WyyLA9UTCRkKl+PgkqBFEfp2BZZ0xXuoiuWCcJSvkmg78wtgLZFb3l6881Bz/QhtkMRZNVkxA7UBXIQvSq6ETeiXZSY/d07FOp01SBb02rJmPDT7dseYJ2GI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IArCkOoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459CFC16AAE;
	Mon, 22 Dec 2025 20:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766434922;
	bh=il/A5ESFB43qQCBJVEVMQsv6iZegOJ25F7KaRc3mwr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IArCkOoJyawG/2YzChOl+4dQroQYKMbFOB8CeNQq7fKKfnBsmTpwufvwdaQ4OYR/s
	 5b5JJH8nBoE+G2o3v3S7mUqHiT+sRCWi2s1DqVMPWu2Vuvp2eVJko9yHAOIcwKI3jz
	 VHxM8Pl0p5SD8Ym6J3NDDRJV5vJGS9bVjT0gzyA/nd2vKy6adefXyOzrYCSafDEl+f
	 6oHt7KFJzNhYuBC22SYHw1VkVubPwr/LoTkQHKcsSFpB8qfJ8DnnsHria2NXTeECmw
	 rMMVgXLwOscZwwaHJ6zc8l8DCva9t5Hz/EBWEqKcw22Ur/yKFwVwMFRxx9COfyabDP
	 nkVL8kUuFsM7A==
Date: Mon, 22 Dec 2025 12:22:00 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <raemoar63@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] kunit: Enforce task execution in {soft,hard}irq
 contexts
Message-ID: <20251222202200.GA2188@quark>
References: <20251219085259.1163048-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219085259.1163048-1-davidgow@google.com>

On Fri, Dec 19, 2025 at 04:52:58PM +0800, David Gow wrote:
> The kunit_run_irq_test() helper allows a function to be run in hardirq
> and softirq contexts (in addition to the task context). It does this by
> running the user-provided function concurrently in the three contexts,
> until either a timeout has expired or a number of iterations have
> completed in the normal task context.
> 
> However, on setups where the initialisation of the hardirq and softirq
> contexts (or, indeed, the scheduling of those tasks) is significantly
> slower than the function execution, it's possible for that number of
> iterations to be exceeded before any runs in irq contexts actually
> occur. This occurs with the polyval.test_polyval_preparekey_in_irqs
> test, which runs 20000 iterations of the relatively fast preparekey
> function, and therefore fails often under many UML, 32-bit arm, m68k and
> other environments.
> 
> Instead, ensure that the max_iterations limit counts executions in all
> three contexts, and requires at least one of each. This will cause the
> test to continue iterating until at least the irq contexts have been
> tested, or the 1s wall-clock limit has been exceeded. This causes the
> test to pass in all of my environments.
> 
> In so doing, we also update the task counters to atomic ints, to better
> match both the 'int' max_iterations input, and to ensure they are
> correctly updated across contexts.
> 
> Finally, we also fix a few potential assertion messages to be
> less-specific to the original crypto usecases.
> 
> Fixes: b41dc83f0790 ("kunit, lib/crypto: Move run_irq_test() to common header")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Changes since v1:
> https://lore.kernel.org/all/20251219080850.921416-1-davidgow@google.com/
> - Remove a leftover debug line which forced max_iterations to 1.
> 
> 
>  include/kunit/run-in-irq-context.h | 39 ++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 13 deletions(-)

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-fixes

Thanks!

- Eric

