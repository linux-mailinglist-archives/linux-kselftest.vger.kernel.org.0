Return-Path: <linux-kselftest+bounces-21523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BD29BE589
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 12:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD1AB212CA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7911A1DE8A1;
	Wed,  6 Nov 2024 11:29:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970FB1DE4FC;
	Wed,  6 Nov 2024 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892562; cv=none; b=KTezThOfn80IJ27Yfr9xsf2EVK9KG5NFmmK4IeyRjkeNPv+26NyIpVEes0qkMx5qn4YUY++yX0zeyGDyvupUVSnxvnttNSQHg8zc/PLk++5JIfO0yFuSWrKbAtMiVl0eWKecLKvMPKkX7IbHofmq4oUYKqoVBIA8bQA3NEbONvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892562; c=relaxed/simple;
	bh=BCyrLfZAV1dY3c0w3IQl/h7cMA0B8eAPK6Y+udoyLhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InZGlcPtkvn0zuKOiNIUby3+bQDxDj9aIOECm6HB27B8WomO7ldElVCoGX8yQwvjOQgze2jHeP71PCauGKWF4BQi5nk/FBGRCyrt7stIUM3jClnJnNmvBULUrPZZfmSeC1TNypcLpnb7loO2tU4FgDPuCJfWVLaf6pVNbSrtDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E256B1063;
	Wed,  6 Nov 2024 03:29:49 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5E933F6A8;
	Wed,  6 Nov 2024 03:29:18 -0800 (PST)
Date: Wed, 6 Nov 2024 11:29:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] kselftest/arm64: Correct misleading comments on
 fp-stress irritators
Message-ID: <ZytTDJOfFaynG1rp@J2N7QTR9R3>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
 <20241023-arm64-fp-stress-irritator-v1-1-a51af298d449@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-arm64-fp-stress-irritator-v1-1-a51af298d449@kernel.org>

On Wed, Oct 23, 2024 at 09:38:29PM +0100, Mark Brown wrote:
> The comments in the handlers for the irritator signal in the test threads
> for fp-stress suggest that the irritator will corrupt the register state
> observed by the main thread but this is not the case, instead the FPSIMD
> and SVE irritators (which are the only ones that are implemented) modify
> the current register state which is expected to be overwritten on return
> from the handler by the saved register state. Update the comment to reflect
> what the handler is actually doing.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  tools/testing/selftests/arm64/fp/fpsimd-test.S | 3 +--
>  tools/testing/selftests/arm64/fp/sve-test.S    | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/fpsimd-test.S b/tools/testing/selftests/arm64/fp/fpsimd-test.S
> index 8b960d01ed2e0ef516893b68794078ddf8c01e1f..bdfb7cf2e4ec175fda62c1c2f38c6ebb1a1c48bf 100644
> --- a/tools/testing/selftests/arm64/fp/fpsimd-test.S
> +++ b/tools/testing/selftests/arm64/fp/fpsimd-test.S
> @@ -134,8 +134,7 @@ function check_vreg
>  	b	memcmp
>  endfunction
>  
> -// Any SVE register modified here can cause corruption in the main
> -// thread -- but *only* the registers modified here.
> +// Modify live register state, the signal return will undo our changes
>  function irritator_handler
>  	// Increment the irritation signal count (x23):
>  	ldr	x0, [x2, #ucontext_regs + 8 * 23]
> diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
> index fff60e2a25addfd4850ef71aa3cf6535ac880ffd..e3c0d585684df29723a49265f3df6d23817498c7 100644
> --- a/tools/testing/selftests/arm64/fp/sve-test.S
> +++ b/tools/testing/selftests/arm64/fp/sve-test.S
> @@ -291,8 +291,7 @@ function check_ffr
>  #endif
>  endfunction
>  
> -// Any SVE register modified here can cause corruption in the main
> -// thread -- but *only* the registers modified here.
> +// Modify live register state, the signal return will undo our changes
>  function irritator_handler
>  	// Increment the irritation signal count (x23):
>  	ldr	x0, [x2, #ucontext_regs + 8 * 23]
> 
> -- 
> 2.39.2
> 

