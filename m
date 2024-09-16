Return-Path: <linux-kselftest+bounces-18017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D2E979B2A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2212C1C228E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 06:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D34B3D0A9;
	Mon, 16 Sep 2024 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="kKRVD98Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A562744E;
	Mon, 16 Sep 2024 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726468371; cv=pass; b=PjwEXSzOgkQEr2HDa5wwss/gtcv0jIlMYSavZ7S/QpCiLhBLrqZwoGzVxtwRaa2QyFGOlurnyiWtLN2jLYb+LWPJjdvypz0Eog0jh4vV9oL0Hxlc0OPNVedpV+/IIdjAytUg1HWPBOnlJz47+WnD3Ct+XPEEQO0CRuwrNOeKLsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726468371; c=relaxed/simple;
	bh=NKgAJfLL2Qz3OGqs8RUyqaDTU72Y7lKocc08ZKevzgc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DSRpWziagEoghuy/k9PQ5NspN8fCPhEb4DbU99c379eQcxIse8PXZfn1EQQLGCfpwopWI7QfJyZncteh05Sjwr1bYMY4Z6YmZ73dzDoFHBXSFKOkA6up72vF9//1dlF0nIYCZt2w6F4JG07ykVAP+l7OkwgldqV83pSa1YFGUzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=kKRVD98Q; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726468351; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S8NTHwkOE1u6lfxkSptXXRdSSwvIN+gWBEUVLExRZfly56WRXNBuG9p96nm9bp4eOPCwNL7pKA6L+vfPAuEKG4+oSzyFyIJ03GyKmzBMdUELjXBt7fpgednbYNA1cO799MuEg19tDsVl01yu31n21NqznSZvAASqi88pmyrvd1g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726468351; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2utergmwaDia08m6LN7t4dPgvnAwmwLOjnXGjzsRf7Q=; 
	b=maQZW938tvN5JCYXToS01Hk2liEbUcEAMJydKy4e3+SaZTUdecC13I7yFq9nOecmRJThvuF3DUjw4ygPXiNSLypSSRLG1SpAJ0Zc1KxFrWy8kCZNdXWCRXQl1RNIhvbZ957gYBrGUkae72cCihTrox/NFVbf8d4Vcdx8McXIk6Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726468351;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2utergmwaDia08m6LN7t4dPgvnAwmwLOjnXGjzsRf7Q=;
	b=kKRVD98Q8L76jTz/4ykCP0cjACRAXAdgjCOjffSaVMdNQyCNQitoGVVnkcAmNAcu
	J7CEKlQNjbLviTYu/s2onsaEtxx7WGEiVFu72Qv4YCdQyU349ydEsYD7FqFtwqjGLOG
	EM+nzqFFK1uF6x+9URY+sKhCpcOoPYFXHm4D3ZJQ=
Received: by mx.zohomail.com with SMTPS id 1726468348435996.2519911765199;
	Sun, 15 Sep 2024 23:32:28 -0700 (PDT)
Message-ID: <3cb9d266-4d4b-4031-8603-da7fd9e3ad47@collabora.com>
Date: Mon, 16 Sep 2024 11:32:20 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kselftests: mm: Fix wrong __NR_userfaultfd value
To: Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, David Hildenbrand <david@redhat.com>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
 <a9ae7dc4-275d-43c3-bf4c-b0090cb6bb12@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <a9ae7dc4-275d-43c3-bf4c-b0090cb6bb12@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 9/12/24 8:44 PM, Shuah Khan wrote:
> On 9/12/24 04:31, Muhammad Usama Anjum wrote:
>> The value of __NR_userfaultfd was changed to 282 when
>> asm-generic/unistd.h was included. It makes the test to fail every time
>> as the correct number of this syscall on x86_64 is 323. Fix the header
>> to asm/unistd.h.
>>
> 
> "please elaborate every time" - I just built on my x86_64 and built
> just fine.
The build isn't broken.

> I am not saying this isn't a problem, it is good to
> understand why and how it is failing before making the change.
I mean to say that the test is failing at run time because the correct
userfaultfd syscall isn't being found with __NR_userfaultfd = 282.
_NR_userfaultfd's value depends on the header. When asm-generic/unistd.h
is included, its value (282) is wrong. I've tested on x86_64.

The fix is simple. Add the correct header which has _NR_userfaultfd = 323.

> 
>> Fixes: a5c6bc590094 ("selftests/mm: remove local __NR_* definitions")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   tools/testing/selftests/mm/pagemap_ioctl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c
>> b/tools/testing/selftests/mm/pagemap_ioctl.c
>> index fc90af2a97b80..bcc73b4e805c6 100644
>> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
>> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
>> @@ -15,7 +15,7 @@
>>   #include <sys/ioctl.h>
>>   #include <sys/stat.h>
>>   #include <math.h>
>> -#include <asm-generic/unistd.h>
>> +#include <asm/unistd.h>
>>   #include <pthread.h>
>>   #include <sys/resource.h>
>>   #include <assert.h>
> 
> Also please generate a series with these two patches with cover-letter.
> 
> thanks,
> -- Shuah

-- 
BR,
Muhammad Usama Anjum


