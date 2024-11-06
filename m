Return-Path: <linux-kselftest+bounces-21524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6849BE58A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 12:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0411C218EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17DA1D88BF;
	Wed,  6 Nov 2024 11:30:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9361DE8BC;
	Wed,  6 Nov 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892603; cv=none; b=t1RQgLwgDrKiA0nkR4UhJ3U0CLoxqX9PtagkwJk1Poex1/W2RIQndQbFtlgXxq97eNDFJCOI63z8PXLNZx+tPds3O08+8HK6Dxb+sGtO0CrqZ2r5iYAkxK+7H13SJkLPvPjVp/pNzZEREsCqIlWEXV85nFBfxz0sgw/XAOI4R3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892603; c=relaxed/simple;
	bh=WUrvl6GEpm27m6QyHLw8cQQ/Uk5Lcc3KNq0LHRyFlJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeXFN8242kQm+b6WiwYWAdAhpEC1Lj8FpFHx9Tb04zl6zZRXK0f6iqb7lFT3yr4kH/ixoX14smkMugEEWEobbGPkUovQ1RchfVWIt6b08LbzJFhw5kDTZxuS4www1MuNBEM+m/n4E36wPgTa9QUw3vVSZM2v/KRBNCxtNy6sL1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6136F1063;
	Wed,  6 Nov 2024 03:30:31 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164233F6A8;
	Wed,  6 Nov 2024 03:29:59 -0800 (PST)
Date: Wed, 6 Nov 2024 11:29:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] kselftest/arm64: Remove unused ADRs from irritator
 handlers
Message-ID: <ZytTNXaOGZkH6rME@J2N7QTR9R3>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
 <20241023-arm64-fp-stress-irritator-v1-2-a51af298d449@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-arm64-fp-stress-irritator-v1-2-a51af298d449@kernel.org>

On Wed, Oct 23, 2024 at 09:38:30PM +0100, Mark Brown wrote:
> The irritator handlers for the fp-stress test programs all use ADR to load
> an address into x0 which is then not referenced. Remove these ADRs as they
> just cause confusion.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  tools/testing/selftests/arm64/fp/fpsimd-test.S | 1 -
>  tools/testing/selftests/arm64/fp/sve-test.S    | 1 -
>  tools/testing/selftests/arm64/fp/za-test.S     | 1 -
>  tools/testing/selftests/arm64/fp/zt-test.S     | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/fpsimd-test.S b/tools/testing/selftests/arm64/fp/fpsimd-test.S
> index bdfb7cf2e4ec175fda62c1c2f38c6ebb1a1c48bf..9977ffdd758a51a7af67cd607d019a6c54d3a6c6 100644
> --- a/tools/testing/selftests/arm64/fp/fpsimd-test.S
> +++ b/tools/testing/selftests/arm64/fp/fpsimd-test.S
> @@ -142,7 +142,6 @@ function irritator_handler
>  	str	x0, [x2, #ucontext_regs + 8 * 23]
>  
>  	// Corrupt some random V-regs
> -	adr	x0, .text + (irritator_handler - .text) / 16 * 16
>  	movi	v0.8b, #7
>  	movi	v9.16b, #9
>  	movi	v31.8b, #31
> diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
> index e3c0d585684df29723a49265f3df6d23817498c7..f1fb9745c681786f686f1fafcb7e1154f3c8e1a3 100644
> --- a/tools/testing/selftests/arm64/fp/sve-test.S
> +++ b/tools/testing/selftests/arm64/fp/sve-test.S
> @@ -299,7 +299,6 @@ function irritator_handler
>  	str	x0, [x2, #ucontext_regs + 8 * 23]
>  
>  	// Corrupt some random Z-regs
> -	adr	x0, .text + (irritator_handler - .text) / 16 * 16
>  	movi	v0.8b, #1
>  	movi	v9.16b, #2
>  	movi	v31.8b, #3
> diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
> index 095b45531640966e685408057c08ada67e68998b..1ee0ec36766d2bef92aff50a002813e76e22963c 100644
> --- a/tools/testing/selftests/arm64/fp/za-test.S
> +++ b/tools/testing/selftests/arm64/fp/za-test.S
> @@ -158,7 +158,6 @@ function irritator_handler
>  
>  	// Corrupt some random ZA data
>  #if 0
> -	adr	x0, .text + (irritator_handler - .text) / 16 * 16
>  	movi	v0.8b, #1
>  	movi	v9.16b, #2
>  	movi	v31.8b, #3
> diff --git a/tools/testing/selftests/arm64/fp/zt-test.S b/tools/testing/selftests/arm64/fp/zt-test.S
> index b5c81e81a37946c1bffe810568855939e9ceb08e..ade9c98abcdafc2755ef4796670566d99e919e5c 100644
> --- a/tools/testing/selftests/arm64/fp/zt-test.S
> +++ b/tools/testing/selftests/arm64/fp/zt-test.S
> @@ -127,7 +127,6 @@ function irritator_handler
>  
>  	// Corrupt some random ZT data
>  #if 0
> -	adr	x0, .text + (irritator_handler - .text) / 16 * 16
>  	movi	v0.8b, #1
>  	movi	v9.16b, #2
>  	movi	v31.8b, #3
> 
> -- 
> 2.39.2
> 

