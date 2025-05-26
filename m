Return-Path: <linux-kselftest+bounces-33777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A25FAC3DFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 12:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0093174FBC
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 10:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D152A1F4C92;
	Mon, 26 May 2025 10:44:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F573194A60;
	Mon, 26 May 2025 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748256286; cv=none; b=JQVJeZCluHANbhIo4WlLV3PwQkuGvfvWsm6kp4oYmMCqcblHYSQgiSmvxi8ftkf+PN7BOXHSKNCdfY46BuUu7C+qRQaMNMHHHgyRQg/cA/3Gm/JTnLkPAyWfemHQwWDqhSH6cxKmrL2tPpxGTpL9Iv43qxzB7KHyaun/mZGlffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748256286; c=relaxed/simple;
	bh=p89WL3H9XtepcbN2i08BnaZtoSNrRvSDLXEExImpKpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UADYjLjZrOQi9UP+oz8ALLiYOutD1jJkwOXtAonxgM/HvqNFFvNeiTLeshrGoYm4HmgKZSC+cDCN09q6aoF9vLpD9c0kvhlEdtEYSXr19beIbNXxoT2sAzNZfxEjZyI0sJ0zQ3qqZXaNN+Hxxn61SqL8jb1qVMuouIKYgLveVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D39991007;
	Mon, 26 May 2025 03:44:28 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFD693F5A1;
	Mon, 26 May 2025 03:44:42 -0700 (PDT)
Date: Mon, 26 May 2025 11:44:40 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kselftest/arm64: Fix test for streaming FPSIMD write
 in sve-ptrace
Message-ID: <aDRGGDgQtlh8sew6@J2N7QTR9R3>
References: <20250523-kselftest-arm64-ssve-fixups-v1-0-65069a263b21@kernel.org>
 <20250523-kselftest-arm64-ssve-fixups-v1-2-65069a263b21@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-kselftest-arm64-ssve-fixups-v1-2-65069a263b21@kernel.org>

On Fri, May 23, 2025 at 04:27:13PM +0100, Mark Brown wrote:
> Since f916dd32a943 ("arm64/fpsimd: ptrace: Mandate SVE payload for
> streaming-mode state") we do not support writing FPSIMD payload data when
> writing NT_ARM_SSVE but the sve-ptrace test has an explicit test for
> this being supported which was not updated to reflect the new behaviour.
> Fix the test to expect a failure when writing FPSIMD data to the
> streaming mode register set.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  tools/testing/selftests/arm64/fp/sve-ptrace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> index c499d5789dd5..7e259907805b 100644
> --- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
> +++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> @@ -301,8 +301,10 @@ static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
>  			p[j] = j;
>  	}
>  
> +	/* This should only succeed for SVE */
>  	ret = set_sve(child, type, sve);
> -	ksft_test_result(ret == 0, "%s FPSIMD set via SVE: %d\n",
> +	ksft_test_result((type->regset == NT_ARM_SVE) == (ret == 0),
> +			 "%s FPSIMD set via SVE: %d\n",
>  			 type->name, ret);
>  	if (ret)
>  		goto out;
> 
> -- 
> 2.39.5
> 

