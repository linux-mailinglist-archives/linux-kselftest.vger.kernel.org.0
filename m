Return-Path: <linux-kselftest+bounces-21525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CBA9BE594
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 12:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F03281AE2
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A101DC1BA;
	Wed,  6 Nov 2024 11:31:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7057257333;
	Wed,  6 Nov 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892683; cv=none; b=OmgpXOoOp+ozrGm39TfL6EwWZ510V56guGTOsJJ6XGyaPXPXmBhCuZlznD3bYfYfie4AmQp5b84pfh4FzTn1qBAMKDr7qFyVHlOGv7yGFDOZs2Y1TEBpDBuyaNRYZ2S+yP+5Xu/tBEgnWeHLPFANmSdKPo3iEnfxkla16FjaaF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892683; c=relaxed/simple;
	bh=d5Weyf0/a8St5f6mQmr5hcR7paw6sjTPLo9tW8uYR0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoqhbalDw1io///x7ziryyI0O9A6YZIJNxbK8AW2hD2Nfi5IncLLFT8NFNOS7nyfhxuGw3pQg17yTeYEuwPd3EpERiowbOiNkSNqNnDbBlCBtxUIJiURK4y7amcFOTgn8az/m1zrNATHwopd7FZA8n0GwcClyvySdLFCmelSJL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA94F1063;
	Wed,  6 Nov 2024 03:31:51 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8209C3F6A8;
	Wed,  6 Nov 2024 03:31:20 -0800 (PST)
Date: Wed, 6 Nov 2024 11:31:17 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] kselftest/arm64: Implement irritators for ZA and ZT
Message-ID: <ZytThS7U3u-uqkSC@J2N7QTR9R3>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
 <20241023-arm64-fp-stress-irritator-v1-4-a51af298d449@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-arm64-fp-stress-irritator-v1-4-a51af298d449@kernel.org>

On Wed, Oct 23, 2024 at 09:38:32PM +0100, Mark Brown wrote:
> Currently we don't use the irritator signal in our floating point stress
> tests so when we added ZA and ZT stress tests we didn't actually bother
> implementing any actual action in the handlers, we just counted the signal
> deliveries. In preparation for using the irritators let's implement them,
> just trivially SMSTOP and SMSTART to reset all bits in the register to 0.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  tools/testing/selftests/arm64/fp/za-test.S | 12 ++++--------
>  tools/testing/selftests/arm64/fp/zt-test.S | 12 ++++--------
>  2 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
> index 1ee0ec36766d2bef92aff50a002813e76e22963c..f902e6ef9077bfa34fa7f85ce572ce3df4346789 100644
> --- a/tools/testing/selftests/arm64/fp/za-test.S
> +++ b/tools/testing/selftests/arm64/fp/za-test.S
> @@ -148,20 +148,16 @@ function check_za
>  	b	memcmp
>  endfunction
>  
> -// Any SME register modified here can cause corruption in the main
> -// thread -- but *only* the locations modified here.
> +// Modify the live SME register state, signal return will undo our changes
>  function irritator_handler
>  	// Increment the irritation signal count (x23):
>  	ldr	x0, [x2, #ucontext_regs + 8 * 23]
>  	add	x0, x0, #1
>  	str	x0, [x2, #ucontext_regs + 8 * 23]
>  
> -	// Corrupt some random ZA data
> -#if 0
> -	movi	v0.8b, #1
> -	movi	v9.16b, #2
> -	movi	v31.8b, #3
> -#endif
> +	// This will reset ZA to all bits 0
> +	smstop
> +	smstart
>  
>  	ret
>  endfunction
> diff --git a/tools/testing/selftests/arm64/fp/zt-test.S b/tools/testing/selftests/arm64/fp/zt-test.S
> index ade9c98abcdafc2755ef4796670566d99e919e5c..c96cb7c2ad4b406c54099fe3f73917259bd947e4 100644
> --- a/tools/testing/selftests/arm64/fp/zt-test.S
> +++ b/tools/testing/selftests/arm64/fp/zt-test.S
> @@ -117,20 +117,16 @@ function check_zt
>  	b	memcmp
>  endfunction
>  
> -// Any SME register modified here can cause corruption in the main
> -// thread -- but *only* the locations modified here.
> +// Modify the live SME register state, signal return will undo our changes
>  function irritator_handler
>  	// Increment the irritation signal count (x23):
>  	ldr	x0, [x2, #ucontext_regs + 8 * 23]
>  	add	x0, x0, #1
>  	str	x0, [x2, #ucontext_regs + 8 * 23]
>  
> -	// Corrupt some random ZT data
> -#if 0
> -	movi	v0.8b, #1
> -	movi	v9.16b, #2
> -	movi	v31.8b, #3
> -#endif
> +	// This will reset ZT to all bits 0
> +	smstop
> +	smstart
>  
>  	ret
>  endfunction
> 
> -- 
> 2.39.2
> 

