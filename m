Return-Path: <linux-kselftest+bounces-33779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C43BAC3E35
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 12:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E721897F18
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 10:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BB51F7575;
	Mon, 26 May 2025 10:57:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02EB1F7092;
	Mon, 26 May 2025 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748257065; cv=none; b=QN2jzo+Rb3arnspYpExZuheskBaFzvrrGCSqzjetejKYre/jYP5AzXwYcHQNaosEHHa/5wI/AIcNxDltNcafpzy+Q7IUF5BmmzCFTTf8LjbcshOfDPH9iZ+IXDvNENnUHg5Sp8LRZPxK9bRdGnf/QB2nznEcUpaYr/dwGLsrbVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748257065; c=relaxed/simple;
	bh=ZKgtYKbwab8bvcpx1RQ13ASkfdddFJWdr1kXL+CtswI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ5UjE2Aqls9vSVCArCFbNno8Gx/ZqerUix/iLt4dSTWphjVG6OCDGOJNlWBRdGCuIFmQR8zyT27trm3+70J+MPt6CLmre2nCR4e36352BjA7tuN5krODj88mjlU3rN1rR/EvNCgzTL6ng16lODos/eUMLRkPdd5NRe2UzmmVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CB1C12FC;
	Mon, 26 May 2025 03:57:27 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 979B23F5A1;
	Mon, 26 May 2025 03:57:41 -0700 (PDT)
Date: Mon, 26 May 2025 11:57:38 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kselftest/arm64: Specify SVE data when testing VL
 set in sve-ptrace
Message-ID: <aDRJIjTOAAe0U8or@J2N7QTR9R3>
References: <20250523-kselftest-arm64-ssve-fixups-v1-0-65069a263b21@kernel.org>
 <20250523-kselftest-arm64-ssve-fixups-v1-3-65069a263b21@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-kselftest-arm64-ssve-fixups-v1-3-65069a263b21@kernel.org>

On Fri, May 23, 2025 at 04:27:14PM +0100, Mark Brown wrote:
> Since f916dd32a943 ("arm64/fpsimd: ptrace: Mandate SVE payload for
> streaming-mode state") we reject attempts to write to the streaming mode
> regset even if there is no register data supplied, causing the tests for
> setting vector lengths and setting SVE_VL_INHERIT in sve-ptrace to
> spuriously fail. Set the flag to avoid the issue, we still support not
> supplying register data.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  tools/testing/selftests/arm64/fp/sve-ptrace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> index 7e259907805b..7f9b6a61d369 100644
> --- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
> +++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
> @@ -170,7 +170,7 @@ static void ptrace_set_get_inherit(pid_t child, const struct vec_type *type)
>  	memset(&sve, 0, sizeof(sve));
>  	sve.size = sizeof(sve);
>  	sve.vl = sve_vl_from_vq(SVE_VQ_MIN);
> -	sve.flags = SVE_PT_VL_INHERIT;
> +	sve.flags = SVE_PT_VL_INHERIT | SVE_PT_REGS_SVE;
>  	ret = set_sve(child, type, &sve);
>  	if (ret != 0) {
>  		ksft_test_result_fail("Failed to set %s SVE_PT_VL_INHERIT\n",
> @@ -235,6 +235,7 @@ static void ptrace_set_get_vl(pid_t child, const struct vec_type *type,
>  	/* Set the VL by doing a set with no register payload */
>  	memset(&sve, 0, sizeof(sve));
>  	sve.size = sizeof(sve);
> +	sve.flags = SVE_PT_REGS_SVE;
>  	sve.vl = vl;
>  	ret = set_sve(child, type, &sve);
>  	if (ret != 0) {
> 
> -- 
> 2.39.5
> 

