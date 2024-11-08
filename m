Return-Path: <linux-kselftest+bounces-21692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE5E9C2051
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EC71C21F13
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5728206E7B;
	Fri,  8 Nov 2024 15:27:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857D21F4726;
	Fri,  8 Nov 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079678; cv=none; b=eRjqeTrNJUEp6wY0rnQR6Xt5R/sZbOtLOlRYRUgOAcr+d6x+uxg3GvvtXTuhe4dPywsNWVUQC6J2DSipnBNacvQfejeebdGTvLzuNCikaD+5JZ9VyuXWAxzLGiIU8lH55Z6JU5ASAuLoG0dfpurqx31nnRNtOe4uxpfKgku8fFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079678; c=relaxed/simple;
	bh=av2vUG9524SNjdWGCpxblDFbqyWMk2o1z0s5ZKbvG/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltgvj+QqTOECukSdJLhszm3git88PrQemStSsjyE60i4HpJ/E9e1efTXmWE2DDpJq8nY7IHaokoE5PNyPWPnMEMyQ2YPfdZ4PQEDSa4dqdqQgHj0lQjVpQj263MgeWLehYoI9NyNkHZcNsK8FzyCEyEJf3l3I9wrH1eIYfEn66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D8FC4CECD;
	Fri,  8 Nov 2024 15:27:56 +0000 (UTC)
Date: Fri, 8 Nov 2024 15:27:54 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fix build with stricter assemblers
Message-ID: <Zy4t-tHV18D6BrXJ@arm.com>
References: <20241108-arm64-selftest-asm-error-v1-1-7ce27b42a677@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108-arm64-selftest-asm-error-v1-1-7ce27b42a677@kernel.org>

On Fri, Nov 08, 2024 at 03:20:46PM +0000, Mark Brown wrote:
> While some assemblers (including the LLVM assembler I mostly use) will
> happily accept SMSTART as an instruction by default others, specifically
> gas, require that any architecture extensions be explicitly enabled.
> The assembler SME test programs use manually encoded helpers for the new
> instructions but no SMSTART helper is defined, only SM and ZA specific
> variants.  Unfortunately the irritators that were just added use plain
> SMSTART so on stricter assemblers these fail to build:
> 
> za-test.S:160: Error: selected processor does not support `smstart'
> 
> Switch to using SMSTART ZA via the manually encoded smstart_za macro we
> already have defined.
> 
> Fixes: d65f27d240bb ("kselftest/arm64: Implement irritators for ZA and ZT")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/fp/za-test.S | 2 +-
>  tools/testing/selftests/arm64/fp/zt-test.S | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
> index 95fdc1c1f228221bc812087a528e4b7c99767bba..9c33e13e9dc4a6f084649fe7d0fb838d9171e3aa 100644
> --- a/tools/testing/selftests/arm64/fp/za-test.S
> +++ b/tools/testing/selftests/arm64/fp/za-test.S
> @@ -157,7 +157,7 @@ function irritator_handler
>  
>  	// This will reset ZA to all bits 0
>  	smstop
> -	smstart
> +	smstart_za

And is smstop ok for assemblers? I think I got the error first on
smstop with my toolchain.

-- 
Catalin

