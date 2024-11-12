Return-Path: <linux-kselftest+bounces-21854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2299C569F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 12:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5691F265EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 11:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F367B1F7798;
	Tue, 12 Nov 2024 11:30:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8657230987;
	Tue, 12 Nov 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411018; cv=none; b=oxejWufrw8QSTysfD0AYTEY1ik2RPjw0jUViKycS+Q/txyN2ivgwcNC8w29GkhzzO0IV89LhcskwB/jljrCeThHALG/Tl9UFVzvYCqdElHqcxJqXiy3aAm+myKTN3h/f1wOCrff65KwkJaZIBlaWc0F+o1mkC47j5odKGUU10go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411018; c=relaxed/simple;
	bh=V85IKCyAnvefMBzgwDVTsX/iR1iOFRKsBkbu5jaPOnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRob297tAUdh2yawkdgLJQ2NWJfrft5e71P4VwmFSah/HZEzVYkG2+lv+pPgq0PxY8PATzVKUV/YeFDLmLeNbJuPLmNRkGBG82OjYOELMeH5FUdNlKlQRdjXL8WmKQThIGfsaxT7Oq/bK7dJ+e0ZIw8wQ0NmCVgAcGfjTz3OemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A035C4CECD;
	Tue, 12 Nov 2024 11:30:17 +0000 (UTC)
Date: Tue, 12 Nov 2024 11:30:14 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Check that SVCR is 0 in signal handlers
Message-ID: <ZzM8RrD248eSW5bG@arm.com>
References: <20241106-arm64-fpmr-signal-test-v1-1-31fa34ce58fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-arm64-fpmr-signal-test-v1-1-31fa34ce58fe@kernel.org>

On Wed, Nov 06, 2024 at 05:07:51PM +0000, Mark Brown wrote:
> diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
> index 6dbe48cf8b09ed8b7a5ab47690bd87e39e18e1e6..3dee68fa36d1cf2716f54d5f328b3f4077493c3b 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
> +++ b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
> @@ -85,6 +85,11 @@ static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
>  	fprintf(stderr, "Got expected size %u and VL %d\n",
>  		head->size, ssve->vl);
>  
> +	if (get_svcr() != 0) {
> +		fprintf(stderr, "Unexpected SVCR %llx\n", get_svcr());
> +		return 1;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/tools/testing/selftests/arm64/signal/testcases/za_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
> index b9e13f27f1f9aaf55db2a5e391f360993561d0b7..9fff4c50030414d06157e0da0c29fd794f707309 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/za_regs.c
> +++ b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
> @@ -91,6 +91,11 @@ static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
>  		return 1;
>  	}
>  
> +	if (get_svcr() != 0) {
> +		fprintf(stderr, "Unexpected SVCR %llx\n", get_svcr());
> +		return 1;
> +	}

I think I'll change both printf specifiers to %lx here since in the libc
I have installed, uin64_t is an unsigned long (the kernel defines it as
unsigned long long). Both gcc and clang complain but the compiler
shouldn't matter since the headers come with glibc.

-- 
Catalin

