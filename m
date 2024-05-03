Return-Path: <linux-kselftest+bounces-9366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DAB8BAB4D
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 13:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A456F1F2154C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF931514EC;
	Fri,  3 May 2024 11:00:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5B2139D12;
	Fri,  3 May 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734016; cv=none; b=TfJYMffRudrYxR2PhzGDcMhYaQcgkIYOkUinAdbRuiw1K/oHLHHz2ZaLhfB5+7glN0xeiOjdPsLFVMtgamVy3sgFoNR1SZFiNkkH7dHWEB+sZ9/Jm30yvJsBgHfhCXpsUXk9C8YWAgs961cQ+RZC4LzMtvBxeqF5jIx38gVmPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734016; c=relaxed/simple;
	bh=k4xkTuo7hYK9PbTnqwBgQ2Efeb49h1b70uqJXQeoiuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8RvBQbuni2Dn7SokGCsPGlZpHB6DKt8g0SpVs0yj42cL25w9B7vaATU5wZHD2NHqNwan1+NnIAejogm06gGd5mPRKitNsZzl70Tc2j+edvvid6+8yFbPSFeEGNcz/DvU3JINjGMwgs/vgr0M7ckzF3GnHr+CgoEkjy39eAfEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69CEC2F4;
	Fri,  3 May 2024 04:00:38 -0700 (PDT)
Received: from [10.57.67.51] (unknown [10.57.67.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D620B3F793;
	Fri,  3 May 2024 04:00:09 -0700 (PDT)
Message-ID: <5f90431c-f27d-4b59-bf5a-32fd66101230@arm.com>
Date: Fri, 3 May 2024 12:00:08 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] selftest mm/mseal: fix arm build
Content-Language: en-GB
To: jeffxu@chromium.org, Aishwarya TCV <Aishwarya.TCV@arm.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, corbet@lwn.net,
 dave.hansen@intel.com, deraadt@openbsd.org, gregkh@linuxfoundation.org,
 groeck@chromium.org, jannh@google.com, jeffxu@google.com,
 jorgelo@chromium.org, keescook@chromium.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, merimus@google.com,
 pedro.falcato@gmail.com, rdunlap@infradead.org, sroettger@google.com,
 surenb@google.com, torvalds@linux-foundation.org, usama.anjum@collabora.com,
 willy@infradead.org
References: <20240502225331.3806279-1-jeffxu@chromium.org>
 <20240502225331.3806279-2-jeffxu@chromium.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240502225331.3806279-2-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/05/2024 23:53, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> add include linux/mman.h to fix arm build
> fix a typo
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>

I confirm this has fixed our issue. Thanks!

Tested-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  tools/testing/selftests/mm/mseal_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index ca8dbee0c612..41998cf1dcf5 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #define _GNU_SOURCE
> +#include <linux/mman.h>
>  #include <sys/mman.h>
>  #include <stdint.h>
>  #include <unistd.h>
> @@ -29,7 +30,7 @@
>  # define PKEY_DISABLE_WRITE     0x2
>  #endif
>  
> -#ifndef PKEY_BITS_PER_KEY
> +#ifndef PKEY_BITS_PER_PKEY
>  #define PKEY_BITS_PER_PKEY      2
>  #endif
>  


