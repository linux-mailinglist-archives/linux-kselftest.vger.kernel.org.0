Return-Path: <linux-kselftest+bounces-11346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0658FFFCF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 11:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FFB1C22E67
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 09:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B23215B96E;
	Fri,  7 Jun 2024 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0edyv3px"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AAA15B122;
	Fri,  7 Jun 2024 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753463; cv=none; b=mbpR8/pbZSsK76E3HlUM43xfWYSrf7tL+mh7/MDyn3kmcStbbsljw3/zbZ8MR07XZSoN1reZ6r7JMEEv3W4oIVS30O+hGwzUV5HMeDZCEaW9ahOhcxiYYBVWuB1ghtFY45tlIrb+A9db4nIuPNMtU42jacNsGeHXV5XTtsjfCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753463; c=relaxed/simple;
	bh=dQkXUytkyefTpJTOjW53oGPquKBi+JFRsTG1LaCoypQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dMm5yfeeytbIeZZzSW90i1Xdo3nPq7nOZ0bLPtNutP2Gp5F3z/lZqosmCm+HQmaIc34tX/L9FxB1E15+/9wCoHoOj1LuwiKLt5PdHkMTwMWCry/O9ZliWL1ERDC0vcSpRVVnoe43PRoCnnwgEyFbi/mTkqJbvI5pl7Lv8qYoIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0edyv3px; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717753460;
	bh=dQkXUytkyefTpJTOjW53oGPquKBi+JFRsTG1LaCoypQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=0edyv3px19syu5RPaQqFOA4Iew+3rFhQjoIYCjce4DL3tIFEGwZKamNgJjlD0Yvoz
	 jRaJsNZlpwkfRyRa0GE4my+Vs60ypVSOtmOtdr8fVNTvTszWFiYt+D55PpfVwFhENa
	 WEQ3tPBWskovf5o0I7eyFIPrtYXysUuGRf5O0Dxr5HLcb8MvoWSa9SjXPxvooCK6OJ
	 43J+gZbTV1wg6L89aiSF+h7hqJarpw8rEM03kc943zgD7hi7L9faVKxOUBdCVB7/WJ
	 LCswp/yySfsku6IWwcgnqava8tY+ZAy2gk/TX9U+P2n3B4yD62q/c/8wsyyTbDLYCs
	 k3yKZ1yVnkjSg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E306537811D1;
	Fri,  7 Jun 2024 09:44:15 +0000 (UTC)
Message-ID: <b5e4ca79-8be0-4085-adfa-e8ee1c855fdb@collabora.com>
Date: Fri, 7 Jun 2024 14:44:50 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, cmllamas@google.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, llvm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/2] selftests/mm: Include linux/mman.h
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240605223637.1374969-1-edliaw@google.com>
 <20240605223637.1374969-2-edliaw@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240605223637.1374969-2-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/24 3:36 AM, Edward Liaw wrote:
> thuge-gen defines MAP_HUGE_* macros that are provided by linux/mman.h
> since 4.15. Removes the macros and includes linux/mman.h instead.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/mm/thuge-gen.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index ea7fd8fe2876..034635317935 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -15,6 +15,7 @@
>  
>  #define _GNU_SOURCE 1
>  #include <sys/mman.h>
> +#include <linux/mman.h>
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <sys/ipc.h>
> @@ -28,10 +29,6 @@
>  #include "vm_util.h"
>  #include "../kselftest.h"
>  
> -#define MAP_HUGE_2MB    (21 << MAP_HUGE_SHIFT)
> -#define MAP_HUGE_1GB    (30 << MAP_HUGE_SHIFT)
> -#define MAP_HUGE_SHIFT  26
> -#define MAP_HUGE_MASK   0x3f
Totally makes sense.
Reviewed-by: Muhammad Usama Anjum <usama.anju@collabora.com>

>  #if !defined(MAP_HUGETLB)
>  #define MAP_HUGETLB	0x40000
>  #endif

-- 
BR,
Muhammad Usama Anjum

