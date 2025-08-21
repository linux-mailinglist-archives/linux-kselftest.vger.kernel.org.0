Return-Path: <linux-kselftest+bounces-39430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C79FB2EC31
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 05:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07C13BEED5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 03:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FE82E173F;
	Thu, 21 Aug 2025 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql/ChiIf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661292E7F3F;
	Thu, 21 Aug 2025 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747430; cv=none; b=f4iYSHTlI8iurPoCh28oZ4Cs9widIhIgW3n0nkTXlxfw9gx9gT8l8/M6WDZOL0VEw4aLQdxDJJbLAhJlkFUnZixUO05BdU8cKBbRGWoxELB6BymAmt2IFlDtwgwE7mwsQttH9fCT4KFcnZ1iqGSyqRACB3fIF0mjFZ+YTez7+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747430; c=relaxed/simple;
	bh=nh9dDQLLLpxkYOKYMlE9tT0MxIxgkUC+bSrwomTGalw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTRYMSRe8oYdeeCzxw2hN5E2B11T21wUaPC4GBWjfwyAWBK+veoLpt95pdgMq5G9D/NESfOwmkRCw6HLvj825nvTtbqIWU2lQjsoSzebaTctZDJLDI0osTgYAZxjXclqNujcYJ5SJnBU07fCnELS1ckMCDGu0+tfZghkDxNz4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql/ChiIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E12C16AAE;
	Thu, 21 Aug 2025 03:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755747428;
	bh=nh9dDQLLLpxkYOKYMlE9tT0MxIxgkUC+bSrwomTGalw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ql/ChiIf7DDKz9dZAhyNamU0dmZ8E4W3kGhPHD0Xu/NNd7kTL2tC9cvE9WGNz/Ixd
	 P6i7h104+bTxc9magHj2UBS6EPhgKcjpVobpjzl7jQIoAzr33OKDrcD3cREqvLMZM5
	 9kqYWCJe6JMuzAjevUQODATp4nuc4H64Az9au+INw+2NScXyQkQXY/VvxHdX4FXA3z
	 WiSxR6bAsuEJnWo+BZe428O2zcXkxh4gcAsdtbrhDqVjwFCjCP6dkrmJ0RR1CzjlEv
	 yrbDRORArsGkEhtwCJlQXLzduUzkB8K1w16tvRFGuvLflcVKxh9/x1iYysHgdUM8Ss
	 r9KY6GDhk2zzQ==
Date: Wed, 20 Aug 2025 23:37:06 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 0/3] Test CRC computation in interrupt contexts
Message-ID: <20250821033706.GC185832@quark>
References: <20250811182631.376302-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811182631.376302-1-ebiggers@kernel.org>

On Mon, Aug 11, 2025 at 11:26:28AM -0700, Eric Biggers wrote:
> This series updates crc_kunit to use the same interrupt context testing
> strategy that I used in the crypto KUnit tests.  I.e., test CRC
> computation in hardirq, softirq, and task context concurrently.  This
> detect issues related to use of the FPU/SIMD/vector registers.
> 
> To allow lib/crc/tests/ and lib/crypto/tests/ to share code, move the
> needed helper function to include/kunit/run-in-irq-context.h.
> include/kunit/ seems like the most relevant location for this sort of
> thing, but let me know if there is any other preference.
> 
> The third patch replaces the calls to crypto_simd_usable() in lib/crc/
> with calls to the underlying functions, now that we have a better
> solution that doesn't rely on the test injecting values.  (Note that
> crc_kunit wasn't actually using the injection solution, anyway.)
> 
> I'd like to take this series via crc-next.
> 
> Eric Biggers (3):
>   kunit, lib/crypto: Move run_irq_test() to common header
>   lib/crc: crc_kunit: Test CRC computation in interrupt contexts
>   lib/crc: Use underlying functions instead of crypto_simd_usable()
> 
>  include/kunit/run-in-irq-context.h    | 129 ++++++++++++++++++++++++++
>  lib/crc/arm/crc-t10dif.h              |   6 +-
>  lib/crc/arm/crc32.h                   |   6 +-
>  lib/crc/arm64/crc-t10dif.h            |   6 +-
>  lib/crc/arm64/crc32.h                 |  11 ++-
>  lib/crc/powerpc/crc-t10dif.h          |   5 +-
>  lib/crc/powerpc/crc32.h               |   5 +-
>  lib/crc/tests/crc_kunit.c             |  62 +++++++++++--
>  lib/crc/x86/crc-pclmul-template.h     |   3 +-
>  lib/crc/x86/crc32.h                   |   2 +-
>  lib/crypto/tests/hash-test-template.h | 123 +-----------------------
>  11 files changed, 206 insertions(+), 152 deletions(-)
>  create mode 100644 include/kunit/run-in-irq-context.h

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=crc-next

But, reviews and acks would be greatly appreciated!

- Eric

