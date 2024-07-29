Return-Path: <linux-kselftest+bounces-14355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CB293EF6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 10:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B231C2190E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5427137903;
	Mon, 29 Jul 2024 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XWHF31Tf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F013213C;
	Mon, 29 Jul 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240467; cv=none; b=otFbawJXHISZxPe9sHkL9+6Xvx9RQdbNgOLp9CMT8FHj9i/GPj349SDX7jdW3IoMd53qtRixucBLReiENOv0hFn317r5ZI6dsJoFaTtREC5mqj8Hg8iUKbK5AGsRDmphkHM+sjGUt+YrfI5273QrUr/ZqhMO/aqsHBNO9IHGPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240467; c=relaxed/simple;
	bh=ZhAelpdWyI4K8bBB/7WF6W3C66AcA92rKKB4h13tQ5U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hm3PEuRkhLGH4MkOxOfft9lkmTEkI3t/SZa470BmbFeTvyFKTApoEaikM5ZNd3HpuX3c5x1/M5i5gHJ4XhMFm52KkFWa18wJGkhEHDWiaph7/onarUYKKVBPUVwgWRY4rJwRZadWN6sDaovDTFVgjHYVcQHyGdzyWM6RJ7djOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XWHF31Tf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722240464;
	bh=ZhAelpdWyI4K8bBB/7WF6W3C66AcA92rKKB4h13tQ5U=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XWHF31TfpLk6uydbbWidWpDC7zZlV/IvLnBPJwOTz3rZn0tGk2+BDaXNvD2lCtLlI
	 i9G5XrVMd8Q4G0A+BgCRW4UxS5rfloq0S99bhpMombidm2bUfJnyZPE6RUwL+4AUeP
	 hjhYLzDCcY+vbDGW5iSz8HTAzD7729Z+Q4x06iIkCCvnDOI3vNUeOzyBx+pE9wxEFo
	 TsYE2+SqvCTYXKRdPh/+BgC+BIK4AOTli1k2JhgnBdmR/NnJpDM1Is2mU9iGGnPPLr
	 TblkXp039Vr7b/8bD8DnqEjxhQFctTJXeeKjTgHt8C7Wrvaboiluyvn+hQS4R18FhX
	 k4rgDZEWRGYCQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5F0E13780480;
	Mon, 29 Jul 2024 08:07:41 +0000 (UTC)
Message-ID: <85f575b4-4842-4189-9bba-9ee1085a5e80@collabora.com>
Date: Mon, 29 Jul 2024 13:07:37 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kees@kernel.org, David Gow <davidgow@google.com>,
 John Hubbard <jhubbard@nvidia.com>, kernel@collabora.com
Subject: Re: [PATCH 2/3] bitmap: Rename module
To: Yury Norov <yury.norov@gmail.com>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-3-usama.anjum@collabora.com>
 <ZqUvy_h4YblYkIXU@yury-ThinkPad>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZqUvy_h4YblYkIXU@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/24 10:35 PM, Yury Norov wrote:
> On Fri, Jul 26, 2024 at 04:06:57PM +0500, Muhammad Usama Anjum wrote:
>> Rename module to bitmap_kunit and rename the configuration option
>> compliant with kunit framework.
> 
> ... , so those enabling bitmaps testing in their configs by setting
> "CONFIG_TEST_BITMAP=y" will suddenly get it broken, and will likely
> not realize it until something nasty will happen.
CONFIG_TEST_BITMAP was being enabled by the kselftest suite lib. The bitmap
test and its config option would disappear. The same test can be run by
just enabling KUNIT default config option:

KUNIT_ALL_TESTS=y enables this bitmap config by default.

> 
> Sorry, NAK for config rename.
>  
>> Cc: kees@kernel.org
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  MAINTAINERS                           |  2 +-
>>  lib/Kconfig.debug                     | 15 ++++++++-------
>>  lib/Makefile                          |  2 +-
>>  lib/{test_bitmap.c => bitmap_kunit.c} |  0
>>  4 files changed, 10 insertions(+), 9 deletions(-)
>>  rename lib/{test_bitmap.c => bitmap_kunit.c} (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 12b870712da4a..289b727344d64 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3814,13 +3814,13 @@ F:	include/linux/find.h
>>  F:	include/linux/nodemask.h
>>  F:	include/linux/nodemask_types.h
>>  F:	include/vdso/bits.h
>> +F:	lib/bitmap_kunit.c
>>  F:	lib/bitmap-str.c
>>  F:	lib/bitmap.c
>>  F:	lib/cpumask.c
>>  F:	lib/cpumask_kunit.c
>>  F:	lib/find_bit.c
>>  F:	lib/find_bit_benchmark.c
>> -F:	lib/test_bitmap.c
>>  F:	tools/include/linux/bitfield.h
>>  F:	tools/include/linux/bitmap.h
>>  F:	tools/include/linux/bits.h
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index a30c03a661726..6bb02990a73e7 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -2420,13 +2420,6 @@ config TEST_PRINTF
>>  config TEST_SCANF
>>  	tristate "Test scanf() family of functions at runtime"
>>  
>> -config TEST_BITMAP
>> -	tristate "Test bitmap_*() family of functions at runtime"
>> -	help
>> -	  Enable this option to test the bitmap functions at boot.
>> -
>> -	  If unsure, say N.
>> -
>>  config TEST_UUID
>>  	tristate "Test functions located in the uuid module at runtime"
>>  
>> @@ -2813,6 +2806,14 @@ config USERCOPY_KUNIT_TEST
>>  	  on the copy_to/from_user infrastructure, making sure basic
>>  	  user/kernel boundary testing is working.
>>  
>> +config BITMAP_KUNIT_TEST
>> +	tristate "KUnit Test for bitmap_*() family of functions"
>> +	depends on KUNIT
>> +	default KUNIT_ALL_TESTS
>> +	help
>> +	  This builds the "bitmap_kunit" module that runs tests for
>> +	  bitmaps int the kernel making sure that there isn't any bug.
>> +
>>  config TEST_UDELAY
>>  	tristate "udelay test driver"
>>  	help
>> diff --git a/lib/Makefile b/lib/Makefile
>> index 322bb127b4dc6..37e7359a7065e 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -84,7 +84,6 @@ obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
>>  obj-$(CONFIG_TEST_PRINTF) += test_printf.o
>>  obj-$(CONFIG_TEST_SCANF) += test_scanf.o
>>  
>> -obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
>>  ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
>>  # FIXME: Clang breaks test_bitmap_const_eval when KASAN and GCOV are enabled
>>  GCOV_PROFILE_test_bitmap.o := n
>> @@ -388,6 +387,7 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
>>  obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
>>  obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
>>  obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
>> +obj-$(CONFIG_BITMAP_KUNIT_TEST) += bitmap_kunit.o
>>  
>>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>>  
>> diff --git a/lib/test_bitmap.c b/lib/bitmap_kunit.c
>> similarity index 100%
>> rename from lib/test_bitmap.c
>> rename to lib/bitmap_kunit.c
>> -- 
>> 2.39.2
> 

-- 
BR,
Muhammad Usama Anjum

