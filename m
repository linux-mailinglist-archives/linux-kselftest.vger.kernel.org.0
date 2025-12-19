Return-Path: <linux-kselftest+bounces-47741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A8CD18AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 20:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A5D43012770
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC6133C193;
	Fri, 19 Dec 2025 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gyf4mvEB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F733B95B;
	Fri, 19 Dec 2025 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766171157; cv=none; b=FW1xZqtgBcr6Sfxi9dgHB63BNj0fUjRHKxnpMyGa5s+6FyLiNLkRj65XTKJNEnFSH3MtG12NWwH+3QqdWgsO6i+RMKsfXScd/sxcqguCCV8KmpdkubeKm/YJW1QkywF4d96WKWWGhMe2edWdg0wMkTFUyoHWeYirzRW7NOXATz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766171157; c=relaxed/simple;
	bh=jOt+IHeHyCo3duS8J6L1jt+GWVwHJk8BXs8jKj8mQsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1oLNrBh8FseisTM73QbFfeJwK/Iwpxi1gvz/eqLcW+MnBRVGbEaMsxPSGLpYk+Gn0WHrqA+UZFVXOL+YwTPcxIwr8g2/yyxAPpgW5svlvPOwHPGYSQorCWCHWnS2hn+bbEzhepVU6LgbBnatRZUBFgedUZMswP8V+TB8Jpszlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gyf4mvEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11B9C4CEF1;
	Fri, 19 Dec 2025 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766171156;
	bh=jOt+IHeHyCo3duS8J6L1jt+GWVwHJk8BXs8jKj8mQsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gyf4mvEBtBVI3aBwv4bX/OhCY2Nvlgq+ug/BF3JdxnUnZtTL2xuxLOSzRp5DxDVDi
	 xDO+5JJ+SQLzgIsSFf+7zceKIKKvlABq92dgdlo0VkjQOWH8dAcS1C2eSeydQAS+aP
	 bhA4UzRtoPOTFbpWbzy1fV5jWGEUmFCLE2NtQbnXdQaJuYd+0wEFGAZAYEIwuuDtE7
	 pY6nBduwFAu9SpBfNZ6GXpnXVCjcZLFpzwuhKLIKzfpTnYK0VPuEHI2KgtxwJEf8ZQ
	 +AzNciyWWia+eHjAiR1NsAoMC2+AM4mQD5opoSQeNRMJJxUJGdlM9N6QDA5iGfA48l
	 TPwC4DVwT31IQ==
Date: Fri, 19 Dec 2025 11:05:47 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <raemoar63@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] kunit: Enforce task execution in {soft,hard}irq
 contexts
Message-ID: <20251219190547.GB1602@sol>
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

Thanks!  I'd like to take this through libcrypto-fixes, if that's okay
with the KUnit folks (acks would be appreciated).  kunit_run_irq_test()
is a recently-added helper function used by the crypto and CRC tests.

For the Fixes commit, we should use the initial addition of this code:

    Fixes: 950a81224e8b ("lib/crypto: tests: Add hash-test-template.h and gen-hash-testvecs.py")

- Eric

