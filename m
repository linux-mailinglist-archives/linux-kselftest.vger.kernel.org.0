Return-Path: <linux-kselftest+bounces-21672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEA59C1DAF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 14:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1871C20BBC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA6C1EABB2;
	Fri,  8 Nov 2024 13:12:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3981E491C
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071535; cv=none; b=iROwbY9cGqYsp2ehcvIAgTo3h1DXm0f57pQMTOqk6QwjDS3pVRScmftZ9YA1IjYd9obMUaK6IrOFPcM1dtTQY1PU+FhSMH1znb/BqacjHRl4S3RtojewvayMm9LcOanVG6Sc7HRICknqmqnxn/Y43wucfPvPUhecc39USyKiQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071535; c=relaxed/simple;
	bh=AgxJUcD0dle+4IaTnMk7AdnrO/1Zt/bfUnzkqPqqH1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggEnLdqfEVqTnOWb5y5eUC8Voh487YH62UgqO8fZUVv3qCNMEdyDr4gA/+3jUyeiV+v40u5Z3U5HD09kRR2m6i0wa+G3N2nCma0uuquBpT8AqtjPniEITDHRejLaWXL5Bqv06BJGOp3bQkQKWGI42yLWHWDVsB9fECqHWjwOGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DF47497;
	Fri,  8 Nov 2024 05:12:43 -0800 (PST)
Received: from [10.57.79.154] (unknown [10.57.79.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B2D13F7D8;
	Fri,  8 Nov 2024 05:12:11 -0800 (PST)
Message-ID: <d3db93f4-679f-43f7-93b2-9eb33f53f855@arm.com>
Date: Fri, 8 Nov 2024 14:12:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix unused function warning for
 aarch64_write_signal_pkey()
To: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>, Joey Gouly <joey.gouly@arm.com>
References: <20241108110549.1185923-1-catalin.marinas@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241108110549.1185923-1-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/11/2024 12:05, Catalin Marinas wrote:
> Since commit 49f59573e9e0 ("selftests/mm: Enable pkey_sighandler_tests
> on arm64"), pkey_sighandler_tests.c (which includes pkey-arm64.h via
> pkey-helpers.h) ends up compiled for arm64. Since it doesn't use
> aarch64_write_signal_pkey(), the compiler warns:
>
> In file included from pkey-helpers.h:106,
>                  from pkey_sighandler_tests.c:31:
> pkey-arm64.h:130:13: warning: ‘aarch64_write_signal_pkey’ defined but not used [-Wunused-function]
>   130 | static void aarch64_write_signal_pkey(ucontext_t *uctxt, u64 pkey)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Make the aarch64_write_signal_pkey() a 'static inline void' function to
> avoid the compiler warning.
>
> Fixes: f5b5ea51f78f ("selftests: mm: make protection_keys test work on arm64")
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

I've got this diff locally, didn't realise it was my patches that
revealed the issue otherwise I'd have posted it earlier. Either way:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

- Kevin

> ---
>
> I'll add this on top of the arm64 for-next/pkey-signal branch together with
> Kevin's other patches.
>
>  tools/testing/selftests/mm/pkey-arm64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/pkey-arm64.h b/tools/testing/selftests/mm/pkey-arm64.h
> index d57fbeace38f..d9d2100eafc0 100644
> --- a/tools/testing/selftests/mm/pkey-arm64.h
> +++ b/tools/testing/selftests/mm/pkey-arm64.h
> @@ -127,7 +127,7 @@ static inline u64 get_pkey_bits(u64 reg, int pkey)
>  	return 0;
>  }
>  
> -static void aarch64_write_signal_pkey(ucontext_t *uctxt, u64 pkey)
> +static inline void aarch64_write_signal_pkey(ucontext_t *uctxt, u64 pkey)
>  {
>  	struct _aarch64_ctx *ctx = GET_UC_RESV_HEAD(uctxt);
>  	struct poe_context *poe_ctx =


