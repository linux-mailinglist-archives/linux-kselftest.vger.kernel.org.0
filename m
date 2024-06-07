Return-Path: <linux-kselftest+bounces-11349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ADE900041
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6131F24C27
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360E315EFC5;
	Fri,  7 Jun 2024 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WWS2h7mK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116E15DBBA;
	Fri,  7 Jun 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754615; cv=none; b=t50IItQcRC+4k6yffGGBQMZ+MCjJOLn0Hunk+uCdhSGPCKKWru7xubw8HQzUVEnZAMllaDvXQX8vDPoN9FxKBwHacdd8GAkBfXQTBjArmc/mlSwR2+63fsUldRbUXBWik1aSqfMlIILR62fCtxvfpP+Fse9vFqz8OXRTKEEvE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754615; c=relaxed/simple;
	bh=amMZc6m1aRSEtTlrDesVe38Db++HH1vW/7Yeem0LOHc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q01kqFWv7iA2Col1oaBs8of71/o88YayZGHLGUIDRZplJ83jMzQvz+R8+1z8QeagtWK5gZrOSxjdnqU0nyTmpld50bHBAmIxxuVNtbGYqQsdXLGaVMZP99tKuGLWRWT39pYHfP2+uopkD6e05RzBLFPtKM77OK1RQ1wB9Xe8M9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WWS2h7mK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717754612;
	bh=amMZc6m1aRSEtTlrDesVe38Db++HH1vW/7Yeem0LOHc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=WWS2h7mKUHQ/KjyyIMm4ZMV44uFbqpA23mdxJKsHdJ7buh3vkY7dDGJuTdJ+wHg+C
	 hkyUxCvAUb8OpmSSwVqodtMbREdF2yIJh8oWpS3sgIfrWZGRnykvdYOjtiJvRM3WKD
	 VrQ7ocvgE2iqIxy970gR/R/51ZwQeoGyQamDPfFUPXNtH8USjPcjkDv1Th+0X3AG0T
	 5mmydkFWRKzfuWp9YyDh6FZFwm+vYJsiKAo+1cZtpbvJ/vc7PbuLoydZLQz4h0WgLe
	 8t5c/hQ6z2cYB5cixQLjsDiHSIuzmGSjqAXgYLs8/A0H88hpnzVlHus8HU89ur6Rss
	 BtW2xhMV7xurg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 517EA37811D1;
	Fri,  7 Jun 2024 10:03:27 +0000 (UTC)
Message-ID: <06c41273-47c3-421a-8fbe-dbcf8321de7e@collabora.com>
Date: Fri, 7 Jun 2024 15:04:01 +0500
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
 <b5e4ca79-8be0-4085-adfa-e8ee1c855fdb@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <b5e4ca79-8be0-4085-adfa-e8ee1c855fdb@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/24 2:44 PM, Muhammad Usama Anjum wrote:
> On 6/6/24 3:36 AM, Edward Liaw wrote:
>> thuge-gen defines MAP_HUGE_* macros that are provided by linux/mman.h
>> since 4.15. Removes the macros and includes linux/mman.h instead.
>>
>> Signed-off-by: Edward Liaw <edliaw@google.com>
>> ---
>>  tools/testing/selftests/mm/thuge-gen.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
>> index ea7fd8fe2876..034635317935 100644
>> --- a/tools/testing/selftests/mm/thuge-gen.c
>> +++ b/tools/testing/selftests/mm/thuge-gen.c
>> @@ -15,6 +15,7 @@
>>  
>>  #define _GNU_SOURCE 1
>>  #include <sys/mman.h>
>> +#include <linux/mman.h>
>>  #include <stdlib.h>
>>  #include <stdio.h>
>>  #include <sys/ipc.h>
>> @@ -28,10 +29,6 @@
>>  #include "vm_util.h"
>>  #include "../kselftest.h"
>>  
>> -#define MAP_HUGE_2MB    (21 << MAP_HUGE_SHIFT)
>> -#define MAP_HUGE_1GB    (30 << MAP_HUGE_SHIFT)
>> -#define MAP_HUGE_SHIFT  26
>> -#define MAP_HUGE_MASK   0x3f
> Totally makes sense.
> Reviewed-by: Muhammad Usama Anjum <usama.anju@collabora.com>
Fixing typo:
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> 
>>  #if !defined(MAP_HUGETLB)
>>  #define MAP_HUGETLB	0x40000
>>  #endif
> 

-- 
BR,
Muhammad Usama Anjum

