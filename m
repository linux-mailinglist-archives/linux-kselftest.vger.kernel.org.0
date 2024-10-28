Return-Path: <linux-kselftest+bounces-20815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ECC9B3377
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 15:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983DE1C2129B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93B81DD89F;
	Mon, 28 Oct 2024 14:26:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ED31DE3C6;
	Mon, 28 Oct 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125614; cv=none; b=WSyRBgcr9NQJgnYE6415GeVxm6gFrM1A3NyD/ZVFL2evLj4Ru2XySxrcZoQfRbR/tHJJgNjwmzu/TRqNjMc512KPNi8+pzsVhrT8qTyygYAYwpr588fl+XLjnOMQ5vPiKbO03NdqBkl3VRjEQt5dbtN1hpB4MhxidtuD4hbOgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125614; c=relaxed/simple;
	bh=iq9Wl1uyCw5tq9oG+BKQG3+OcMuua5p/qAtUFxuWOU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS+Wcn7ouLWl0WJnqqbW01pZotXuUEJAhMwmXlBwgoMz6txjqfkYeOzWdp1qigxdowmHaZMuaaFdcLRGkOoYJ26Tr5j7DItMmDFHOPODRiuiicNJXNJdGv45tEXGpFauwY3JlN801CU8ZevTv5BIFnRsGrl7FSOzUfsGcBOHBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADA90497;
	Mon, 28 Oct 2024 07:27:20 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D8D03F66E;
	Mon, 28 Oct 2024 07:26:49 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:26:44 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] kselftest/arm64: Test floating point signal context
 restore in fp-stress
Message-ID: <Zx-fEtzrpxrL4N3_@J2N7QTR9R3>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>

On Wed, Oct 23, 2024 at 09:38:28PM +0100, Mark Brown wrote:
> Currently we test signal delivery to the programs run by fp-stress but
> our signal handlers simply count the number of signals seen and don't do
> anything with the floating point state.  The original fpsimd-test and
> sve-test programs had signal handlers called irritators which modify the
> live register state, verifying that we restore the signal context on
> return, but a combination of misleading comments and code resulted in
> them never being used and the equivalent handlers in the other tests
> being stubbed or omitted.
> 
> Clarify the code, implement effective irritator handlers for the test
> programs that can have them and then switch the signals generated by the
> fp-stress program over to use the irritators, ensuring that we validate
> that we restore the saved signal context properly.

Superficially these look good, but two thing stand out:

1) We only singal the tasks once a second. Dave's original shell test
   script hammered this constantly, and it makes a substantial impact
   actually triggering a bug.

   Without these patches, I hacked the fp-stress.c main loop to trigger
   a signal every ~1ms (by reducing the epoll_wait() timeout to 1 and
   scaling the overall timeout to 10000 accordingly), and those changes
   make the tests reliably trigger the "Bad SVCR" splats within a few
   seconds after a few hundred signals, even if only using the SIGUSR2
   tickle handlers.

   Can we change the fp-stress.c main loop to signal threads more often?

   I had some minor changes to only log every ~1000 iterations or so, to
   avoid spamming the log.

2) The SIGUSR2 tickle handlers are left behind. 

   Given they're unused, it'd be nice to clean them up.

Mark.

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Mark Brown (6):
>       kselftest/arm64: Correct misleading comments on fp-stress irritators
>       kselftest/arm64: Remove unused ADRs from irritator handlers
>       kselftest/arm64: Corrupt P15 in the irritator when testing SSVE
>       kselftest/arm64: Implement irritators for ZA and ZT
>       kselftest/arm64: Provide a SIGUSR1 handler in the kernel mode FP stress test
>       kselftest/arm64: Test signal handler state modification in fp-stress
> 
>  tools/testing/selftests/arm64/fp/fp-stress.c   |  2 +-
>  tools/testing/selftests/arm64/fp/fpsimd-test.S |  4 +---
>  tools/testing/selftests/arm64/fp/kernel-test.c |  4 ++++
>  tools/testing/selftests/arm64/fp/sve-test.S    |  6 ++----
>  tools/testing/selftests/arm64/fp/za-test.S     | 13 ++++---------
>  tools/testing/selftests/arm64/fp/zt-test.S     | 13 ++++---------
>  6 files changed, 16 insertions(+), 26 deletions(-)
> ---
> base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
> change-id: 20241023-arm64-fp-stress-irritator-5415fe92adef
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 

