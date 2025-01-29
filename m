Return-Path: <linux-kselftest+bounces-25356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C96DA21AFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 11:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBE61885E6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80149194C94;
	Wed, 29 Jan 2025 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=commonscaretakers.com header.i=@commonscaretakers.com header.b="N03Q+EN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.commonsconservancy.org (mail.commonsconservancy.org [145.0.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7154B78F58;
	Wed, 29 Jan 2025 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.0.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738146776; cv=none; b=rlBfonPDKVlIoqPEhblhbejG1byVdLyo3se9ZvTJ0sbdaH9ASGrSxcNoenAAG8dzPho9ntmVfrOP2N+nC4+k7KVwTZP/G2ZovOnuW7fZtCcB3TC/GtL5ycY8bvHY6pXkLGbFCaXyTptQbdoVeHqgeQyWLh91YCQdKgCxrujdYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738146776; c=relaxed/simple;
	bh=/Bb9+yUahVxiybeMt26wsFpFFhdk8nOFCIQRstj02OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+7VwJ124SKqIG+LrqzPSQ0Lfou4FDHwJJ2caFpQIYQTSwjnGGkJwkgVqNOrdq9x9jS5zksfiFQYrRu4ukxDYrOW6A2+fOZAHPWfJalQtSs2t5ZX5nsAULRr6XgYsZLXtGBTgjGzERJYDy5Phe84Wiyx5O8d1YqcxudoVrbFPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commonscaretakers.com; spf=pass smtp.mailfrom=commonsconservancy.org; dkim=pass (1024-bit key) header.d=commonscaretakers.com header.i=@commonscaretakers.com header.b=N03Q+EN1; arc=none smtp.client-ip=145.0.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commonscaretakers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commonsconservancy.org
Message-ID: <aaac3569-2c96-45dd-bd3b-4a5080833767@commonscaretakers.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=commonscaretakers.com; s=mail; t=1738146168;
	bh=V06eSdnjjTlzev4rhCe3CaZGQwcPbPD06ftMGctZ3A0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N03Q+EN1CgsKCVwFyLYr/SGc0PcEgef/8MSTed1iO3qPnU0III+zqXLa7yiyQEYbC
	 ueqCZqbc7OMMOw7kgIAwNRR5Xq21+x0II7zi4ZaBFm3k6pGuF5k0enHTKGKguDleb4
	 rbq4hBOmLybYXbpxZqkolm2DIAni3Ye2C9R1xKFE=
Date: Wed, 29 Jan 2025 11:22:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 01/21] bcachefs: remove dead code in is_aligned
To: Andreas Gruenbacher <agruenba@redhat.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250128163859.1883260-1-agruenba@redhat.com>
 <20250128163859.1883260-2-agruenba@redhat.com>
Content-Language: en-US, en-GB, nl
From: Eric Herman <eric@commonscaretakers.com>
In-Reply-To: <20250128163859.1883260-2-agruenba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Andreas,

On 2025-01-28 17:38, Andreas Gruenbacher wrote:
> This statement does nothing.

I would suggest this statement does nothing only in the case of #ifndef 
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.

In the case where CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS _is_ defined, 
it tells the compiler that it should not emit a warning for an unused 
parameter.

Perhaps it should be moved in to an #else of the #ifndef in order to 
more clearly communicate that it is expected and okay to ignore this 
parameter in this case.

Cheers,
-Eric

>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>   fs/bcachefs/eytzinger.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/fs/bcachefs/eytzinger.c b/fs/bcachefs/eytzinger.c
> index 2eaffe37b5e7..c0fdfe909cf2 100644
> --- a/fs/bcachefs/eytzinger.c
> +++ b/fs/bcachefs/eytzinger.c
> @@ -20,7 +20,6 @@ static bool is_aligned(const void *base, size_t size, unsigned char align)
>   {
>   	unsigned char lsbits = (unsigned char)size;
>   
> -	(void)base;
>   #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>   	lsbits |= (unsigned char)(uintptr_t)base;
>   #endif

