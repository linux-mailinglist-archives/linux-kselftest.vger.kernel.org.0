Return-Path: <linux-kselftest+bounces-21522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA11E9BE57F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 12:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71241B2321E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25C51DE4ED;
	Wed,  6 Nov 2024 11:27:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31748646;
	Wed,  6 Nov 2024 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892459; cv=none; b=YPUJYtmdd+BuI6Q9c6kyQow0qy2E5ewwAiON572aZyACf3svV/yQdXQPCtJsGNpyRo5AQ/WrzaKz3H1ukD7XKW5qAW/mXLmS6kYdXniCuDnyD8ASUo8QzyQhwwcLwKIUUYIxLDwnddvk8gHDMaKtBKeOWjZakX7Am759rLRl6sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892459; c=relaxed/simple;
	bh=N9y/w/cDYpCJnfhYNfQkAJX6iw92DVdB3EFOMljdx6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoEvfb9auXA0nFEDlKgmrUU1yxaFQ8Ro7ZvTv/96YHUDLylv3Ca/QgRl8LvOtMqfLwGmmAZGT4qbPwC90/MmbwhFw7phfJZidBz2veoxPyx5nTFvBJNeDdBA59IJSCWBT0Q07aHri6xQaRmdc+XRvtq8NVx7/WDjo5T3OGKSsxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 586871063;
	Wed,  6 Nov 2024 03:28:06 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 585EA3F6A8;
	Wed,  6 Nov 2024 03:27:35 -0800 (PST)
Date: Wed, 6 Nov 2024 11:27:24 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] kselftest/arm64: Corrupt P15 in the irritator when
 testing SSVE
Message-ID: <ZytSnBSk4r81a3z1@J2N7QTR9R3>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
 <20241023-arm64-fp-stress-irritator-v1-3-a51af298d449@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-arm64-fp-stress-irritator-v1-3-a51af298d449@kernel.org>

On Wed, Oct 23, 2024 at 09:38:31PM +0100, Mark Brown wrote:
> When building for streaming SVE the irritator for SVE skips updates of both
> P15 and FFR. While FFR is skipped since it might not be present there is no
> reason to skip corrupting P15 so move the ifdef appropriately.

I think you mean P0 rather than P15 here? 

	rdffr   p0.b

... reads from the FFR and writes to P0, modifying P0.

	wrffr   p15.b

... reads from P15 and writes to the FRR, leaving P15 unchanged.

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/fp/sve-test.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
> index f1fb9745c681786f686f1fafcb7e1154f3c8e1a3..3c88dfe9c8cad29f44217314aeaffa984bac05e5 100644
> --- a/tools/testing/selftests/arm64/fp/sve-test.S
> +++ b/tools/testing/selftests/arm64/fp/sve-test.S
> @@ -302,9 +302,9 @@ function irritator_handler
>  	movi	v0.8b, #1
>  	movi	v9.16b, #2
>  	movi	v31.8b, #3
> -#ifndef SSVE
>  	// And P0
>  	rdffr	p0.b
> +#ifndef SSVE
>  	// And FFR
>  	wrffr	p15.b
>  #endif

Both RDFFR and WRFFR are illegal in streaming mode unless FEAT_FA64 is
implemented and enabled, so we cannot use DRFFR in the SSVE case.

Is there a different instruction we can use?

Mark.

