Return-Path: <linux-kselftest+bounces-39394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170EAB2E519
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 20:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19799A27513
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC812798F0;
	Wed, 20 Aug 2025 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WbXYoJyC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0252028E0F;
	Wed, 20 Aug 2025 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755715162; cv=none; b=VbDNG4ULe9xQ03orZsDc5GYeSIxj+nMsMlNENQEbcr1qaHPcmJh+FfB1gL6B5SDYbA/y6c7xJAONbpR5vP4Y8ZjriYGFnc+mvKAZsbybuhQj3srmJm0EwXYhgLE5R3xx6iep4VXdI5BNdt9+YCowXWHvQPKjXCwqNH7YiTafzok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755715162; c=relaxed/simple;
	bh=nEJy948uTX8LRiCWpvguAaV0klAG04jvykpe1HPoxH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NapYXhvoz17D/19QajCrMaZ87wclliZfJE5QSoSVXC5YpNGsWoe/jio3akIQNnd2y1g7Hj5uPRvNUU/qOr58IxmmqCIJMOUOE7cZB6uFCsQNmXUWjKCaTQ/h4N/Ywnw65i0yULiAyE3vqYrcefm0RmALTs9ZGCmx9x98E8R5Vrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WbXYoJyC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0POp/c1KOeqzO/GprTJ0OTlzQ3hXFKiLpUB0jM+6XiQ=; b=WbXYoJyCTDfxnClh3ArubZM3B4
	ISq8adt/vzK04zOgV/MDYVGImwqFYDcvMvlNHo/j305J5Ki8dA/1jNO8obP7xgAdudj9/A8KFB2uU
	3GxooO2O16/yFv4vXy4flBbwd+Cao8OnBX2onrYOyOrb0+3KB9/GCsNZgR1Ui5LgfN9ImqT4vOvL9
	O2TaDCcPnNACOYmafGjYmFqJK2cS1hyGtmLrGkiCtoEcMAMyEV24svXjoVQ9c+/q9LGMbeIdkEzHT
	aKMPEEJ5yM/RKZ+MGlFq5J/thTjjaCjreYR5QlOHE4fHS/mRYvlDqdlBC0IWzsXH/QQfdlZA9kfcw
	dgTlYkPg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoniQ-0000000Eha0-49d5;
	Wed, 20 Aug 2025 18:39:19 +0000
Message-ID: <4b691bb8-c047-4546-9ab2-c9a183a10dc8@infradead.org>
Date: Wed, 20 Aug 2025 11:39:18 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64/sme: Support disabling streaming mode via
 ptrace on SME only systems
To: Mark Brown <broonie@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Oleg Nesterov <oleg@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 David Spickett <david.spickett@arm.com>,
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
 Luis Machado <luis.machado.foss@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250820-arm64-sme-ptrace-sme-only-v1-0-f7c22b2871f8@kernel.org>
 <20250820-arm64-sme-ptrace-sme-only-v1-3-f7c22b2871f8@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250820-arm64-sme-ptrace-sme-only-v1-3-f7c22b2871f8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/25 11:29 AM, Mark Brown wrote:
> diff --git a/Documentation/arch/arm64/sve.rst b/Documentation/arch/arm64/sve.rst
> index 28152492c29c..a61c9d0efe4d 100644
> --- a/Documentation/arch/arm64/sve.rst
> +++ b/Documentation/arch/arm64/sve.rst
> @@ -402,6 +402,11 @@ The regset data starts with struct user_sve_header, containing:
>    streaming mode and any SETREGSET of NT_ARM_SSVE will enter streaming mode
>    if the target was not in streaming mode.
>  
> +* On systems that do not support SVE it is permitted to use SETREGSET to
> +  write SVE_PT_REGS_FPSIMD formatted data via NT_ARM_SVE, in this case the

s/,/;/
or
                                                 NT_ARM_SVE. In this case

> +  vector length should be specified as 0. This allows streaming mode to be
> +  disabled on systems with SME but not SVE.
> +
>  * If any register data is provided along with SVE_PT_VL_ONEXEC then the
>    registers data will be interpreted with the current vector length, not
>    the vector length configured for use on exec.

-- 
~Randy


