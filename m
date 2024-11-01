Return-Path: <linux-kselftest+bounces-21292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B359B90E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 13:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15191C210E5
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 12:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3134B19CC17;
	Fri,  1 Nov 2024 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="HBWA42gI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B811719CC02;
	Fri,  1 Nov 2024 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462717; cv=pass; b=VcQisreRKtcyrTCiCUCE9W+DW0uTBHpFc4NHEE791XhZjl44fmE9IcOI6Zpp77yqD9mX1DV8ims3UiMyxO91PrHojJb8fAvrwj4TgEFR5m5Nioh6d7YkxGQDjFHZE9+WT2hMazoqCw+5cuXJwcdlxwaqwayr20K2KCDxs1pAOiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462717; c=relaxed/simple;
	bh=pb795XVY7Sp+qLhUbQk6MrXNjqEpUOfM6y7ZI3gevHA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T+P7lc+kSwXH0+EsqxQ3QeDuxNVTeBNzoj12hOSgog+TCgCNev/sSXq1p0j83NCn6qvSlFCyzRwYFdxAr/7/KPYGnHQWkiJyT+OIeu8sM+d5zINirUGafg1K26q+G1YYkZMzZ5qbr0u+uH1HcMANJkqvBGul+o2/yZ2aydHiFLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=HBWA42gI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730462681; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EK3LpHZfnTpGyfXurU1xjh1Z2ukDCE/4TYlfbRj3jelnAcwy1yPeaTL16fUIPqoNzwTwjuvcYhAAoc/sI2Qo4QsTbHsEJkUytoYz6aYwwVFhh1SQOhGNkYTL80Z2rgMVdZ0yZnECAYtnCXtYUZK0GtQz2Uu2hxCtj4zkHN2fQMs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730462681; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/NMi3pGigRmlDzj0TOeS5jZ0ve4nP+ZwL2yz0+HO+fQ=; 
	b=HnQY1B8nKe8laGMa+/u4t5ms0w1FequDIDXiPhhPdWCG8zXI3pKqITck3MCcm/Ih20Xeq1KYa1I/U+x6P5EsXmCIxC4Bhs0SU2G/5kesX5N3HBxSfRDtlqKkPeMpaRaub2foZuyDAQsq6KlzojbRTiC7/ldvDKouMF3vJJvOzoM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730462681;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/NMi3pGigRmlDzj0TOeS5jZ0ve4nP+ZwL2yz0+HO+fQ=;
	b=HBWA42gISrcL6C+foXidrBwRXThCQcXWGJBbL92XEK2DsW9Z+eAqKCvMVcl+n/O7
	i3mIjx5aav4uABK+8HAElYvSnhjhtpXPVMlXxr12rcw+HSyAIZofpXYQG0itAsvVIAD
	oEgo6pDHf7ulXUQBuQQ7F1KDZZeMFtoGau8t9AcU=
Received: by mx.zohomail.com with SMTPS id 173046267927518.196252159989967;
	Fri, 1 Nov 2024 05:04:39 -0700 (PDT)
Message-ID: <a2a9995c-deed-4545-bf65-9ce7a811609a@collabora.com>
Date: Fri, 1 Nov 2024 17:04:25 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 1/2] selftests/x86/syscall: fix coccinelle WARNING
 recommending the use of ARRAY_SIZE()
To: Mirsad Todorovac <mtodorovac69@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241101111523.1293193-2-mtodorovac69@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241101111523.1293193-2-mtodorovac69@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/1/24 4:15 PM, Mirsad Todorovac wrote:
> Coccinelle gives WARNING recommending the use of ARRAY_SIZE() macro definition
> to improve the code readability:
> 
> ./tools/testing/selftests/x86/syscall_numbering.c:316:35-36: WARNING: Use ARRAY_SIZE
> 
> Fixes: 15c82d98a0f78 ("selftests/x86/syscall: Update and extend syscall_numbering_64")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  v1: initial version.
> 
>  tools/testing/selftests/x86/syscall_numbering.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
> index 991591718bb0..41c42b7b54a6 100644
> --- a/tools/testing/selftests/x86/syscall_numbering.c
> +++ b/tools/testing/selftests/x86/syscall_numbering.c
> @@ -25,6 +25,7 @@
>  #include <sys/mman.h>
>  
>  #include <linux/ptrace.h>
> +#include "../kselftest.h"
>  
>  /* Common system call numbers */
>  #define SYS_READ	  0
> @@ -313,7 +314,7 @@ static void test_syscall_numbering(void)
>  	 * The MSB is supposed to be ignored, so we loop over a few
>  	 * to test that out.
>  	 */
> -	for (size_t i = 0; i < sizeof(msbs)/sizeof(msbs[0]); i++) {
> +	for (size_t i = 0; i < ARRAY_SIZE(msbs); i++) {
>  		int msb = msbs[i];
>  		run("Checking system calls with msb = %d (0x%x)\n",
>  		    msb, msb);

-- 
BR,
Muhammad Usama Anjum


