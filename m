Return-Path: <linux-kselftest+bounces-14354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF8893EF5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 10:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B49DB20D70
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 08:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC3139568;
	Mon, 29 Jul 2024 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AJ3LP8Ui"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF0137905;
	Mon, 29 Jul 2024 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240176; cv=none; b=XLbcpYkei4TvwXrueHkQg6rsCkpC2sDhkwGxp1VZ+5hfV9mpSzg/Kxl9+77PA7+JQ529iw8K3b7Ktaa8uGnCDMuIEzoOhjL5GgjaA7IX0+GYM+cdyT+0Tm2EoLcfL9CxTHGUJtUjH3mEZi6gbjoV2S2yq+ndkfNDb6GASkYTnWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240176; c=relaxed/simple;
	bh=K5Blu4NhVstcTox6CDtmdVnku5ODDvROtVnHv5REhxQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kEdCevyENuPi7Eg1zHJAP9eOJeNNH0P5zFO+ZlFx+XHiSNodS3EynlN9mnajubd006IApF39wZ0WslkBNN0zl7JDQGTDR4anYP76tswt6C6VG8RF8aF+XbNtTanfZw9+z30TZzJoXdnI/tEL1KjB+wNHqgoUtYFs9Pd0QhroPqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AJ3LP8Ui; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722240173;
	bh=K5Blu4NhVstcTox6CDtmdVnku5ODDvROtVnHv5REhxQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AJ3LP8UiPvTSDi2C/BbD57pQzgZrq5ZitylHnbJxMFZNaDAtDqvkhcYZVe9kaXEn9
	 Ge4nes8/RZ3NkUPAaBGKy4HRsUAEdVH1yHb7A/uekENPysR/dTPHhanuMlLYxCdytY
	 u7mEinavvhnC4/BoLldY1yKLJckGjlLeUhvoNxFRzDKg8j2GmqjUTCA2EYJ9lFony9
	 cFyDHwUg7u36E+fD63U5HVgyT2mN8Oy66+kaQWdJ3RRxdqCYWqk8IH1ZFuMaVPpn2t
	 HcRX2/i04V7f013AXNr5PHCzZY4pHscDOF8c4eOH6D/9nlJt7N5ybf+CFzLhO/JFsg
	 P99p28E3f6vuw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9EF683780480;
	Mon, 29 Jul 2024 08:02:49 +0000 (UTC)
Message-ID: <ad570a42-fe22-4045-ac93-35b35d92713a@collabora.com>
Date: Mon, 29 Jul 2024 13:02:46 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 John Hubbard <jhubbard@nvidia.com>, David Gow <davidgow@google.com>,
 kees@kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] bitmap: Rename module
To: Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-3-usama.anjum@collabora.com>
 <21671af5-94fe-48bd-a32e-d7f6204563f1@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <21671af5-94fe-48bd-a32e-d7f6204563f1@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/27/24 12:24 AM, Shuah Khan wrote:
> On 7/26/24 05:06, Muhammad Usama Anjum wrote:
>> Rename module to bitmap_kunit and rename the configuration option
>> compliant with kunit framework.
>>
>> Cc: kees@kernel.org
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   MAINTAINERS                           |  2 +-
>>   lib/Kconfig.debug                     | 15 ++++++++-------
>>   lib/Makefile                          |  2 +-
>>   lib/{test_bitmap.c => bitmap_kunit.c} |  0
>>   4 files changed, 10 insertions(+), 9 deletions(-)
>>   rename lib/{test_bitmap.c => bitmap_kunit.c} (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 12b870712da4a..289b727344d64 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3814,13 +3814,13 @@ F:    include/linux/find.h
>>   F:    include/linux/nodemask.h
>>   F:    include/linux/nodemask_types.h
>>   F:    include/vdso/bits.h
>> +F:    lib/bitmap_kunit.c
>>   F:    lib/bitmap-str.c
>>   F:    lib/bitmap.c
>>   F:    lib/cpumask.c
>>   F:    lib/cpumask_kunit.c
>>   F:    lib/find_bit.c
>>   F:    lib/find_bit_benchmark.c
>> -F:    lib/test_bitmap.c
>>   F:    tools/include/linux/bitfield.h
>>   F:    tools/include/linux/bitmap.h
>>   F:    tools/include/linux/bits.h
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index a30c03a661726..6bb02990a73e7 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -2420,13 +2420,6 @@ config TEST_PRINTF
>>   config TEST_SCANF
>>       tristate "Test scanf() family of functions at runtime"
>>   -config TEST_BITMAP
>> -    tristate "Test bitmap_*() family of functions at runtime"
>> -    help
>> -      Enable this option to test the bitmap functions at boot.
>> -
>> -      If unsure, say N.
>> -
> 
> This change will take away the ability to run bitmap tests during
> boot on a non-kunit kernel.
Kees, what opinion do you have on this? [1] has all the discussion though
and my recent thoughts on why I sent this patch.

> 
> Nack on this change. I wan to see all tests that are being removed
> from lib because they have been converted - also it doesn't make
> sense to convert some tests like this one that add the ability test
> during boot.
> 
> thanks,
> -- Shuah
> 

-- 
BR,
Muhammad Usama Anjum

