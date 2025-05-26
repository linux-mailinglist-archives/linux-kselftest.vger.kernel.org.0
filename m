Return-Path: <linux-kselftest+bounces-33776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671FBAC3DE6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 12:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2463B9416
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 10:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284521F4CBF;
	Mon, 26 May 2025 10:30:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9FB1885A1;
	Mon, 26 May 2025 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255455; cv=none; b=HYxntBNUnv9JIPrlucTq+5CVNUzTeJh4MR7BDxsIu58blaVRWdw84mFwQHs11hTkokpmHuQYlzWEg6vVBSHgj6ghvSFhQNo9i7l/wXhQKoVWv7cqSk09XoY4riiaeCd3Q8evi+yQ2ycgGtBYzSSFYEzjXKWcyhwZJj6+QFl31yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255455; c=relaxed/simple;
	bh=eqq9mvdtmV+u0J80UCNQOsXE89t6MP1L/Dyt+TiUW0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltNu6eE9Wb/UomPapYuf3Js1xF3EjPUGyhvZN8KgrfMsGe+BLJTGfRVmTTF0SDCT/BM++qpYq8CU9MNxYdvoRPyuCnP36Wuf08UviuT8KzhkFpVJmSvCSz4yrNCbMnLpsQITSQuenBJrE452UNFn0NI2DqwqGSycTCNE47oGkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E12D42F;
	Mon, 26 May 2025 03:30:36 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2A163F5A1;
	Mon, 26 May 2025 03:30:50 -0700 (PDT)
Date: Mon, 26 May 2025 11:30:48 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kselftest/arm64: Fix check for setting new VLs in
 sve-ptrace
Message-ID: <aDRC2BJddPL8v8TD@J2N7QTR9R3>
References: <20250523-kselftest-arm64-ssve-fixups-v1-0-65069a263b21@kernel.org>
 <20250523-kselftest-arm64-ssve-fixups-v1-1-65069a263b21@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-kselftest-arm64-ssve-fixups-v1-1-65069a263b21@kernel.org>

On Fri, May 23, 2025 at 04:27:12PM +0100, Mark Brown wrote:
> The check that the new vector length we set was the expected one was typoed
> to an assignment statement which for some reason the compilers didn't spot,
> most likely due to the macros involved.
> 
> Fixes: 0dca276ac4d2 ("selftests: arm64: Add test for the SVE ptrace interface")

I don't think that fixes tag is correct. AFAICT, this code was
introduced in commit:

  a1d7111257cd ("selftests: arm64: More comprehensively test the SVE ptrace interface")

... and there wasn't something equivalent prior to that.

With that fixed:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> index 577b6e05e860..c499d5789dd5 100644
> --- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
> +++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> @@ -253,7 +253,7 @@ static void ptrace_set_get_vl(pid_t child, const struct vec_type *type,
>  		return;
>  	}
>  
> -	ksft_test_result(new_sve->vl = prctl_vl, "Set %s VL %u\n",
> +	ksft_test_result(new_sve->vl == prctl_vl, "Set %s VL %u\n",
>  			 type->name, vl);
>  
>  	free(new_sve);
> 
> -- 
> 2.39.5
> 

