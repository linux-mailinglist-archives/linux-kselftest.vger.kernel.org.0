Return-Path: <linux-kselftest+bounces-11744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A58904DE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 10:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD5C2821B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 08:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42052168C33;
	Wed, 12 Jun 2024 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xc+92hCH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35115279B;
	Wed, 12 Jun 2024 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180213; cv=none; b=UPjzd8ZWIwWVa5yL8AYDUTCpm5/1A6O0ErL3YArEuhRSCUBp1GEZuIrN469u/HKxgVhcTXHnIJASQEO1p2EwRsSN3b8S239mlU2LLmk2SwENebwKDBRW0TRa4Q89Z0gpVwY7kBVEPuo2zwfBO4r+Ms+hznw0nQQcEl1xw1MzifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180213; c=relaxed/simple;
	bh=Yg97OsjtcY3yk1e+X2kIqRNCmOwcA8lmuN0BccmJp1w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r7DkSc3NdUHV+NnVFaE9lmO/ruBU+72IaWqRXRcm0CeU6TBAjcqOlY2mQj/yrlwleZRKMPgxYDouGX7PJMyOd2fdtcizvkbM427HzaxtZK80MBfZuPppErM4hYObAQAw89BVuxzX2PdnH9Ws3+aq0KQGVSxkMSw9l3CSLc4VGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xc+92hCH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718180209;
	bh=Yg97OsjtcY3yk1e+X2kIqRNCmOwcA8lmuN0BccmJp1w=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Xc+92hCH52rej/sP6x6VK+kHGHGlTm2WhSJg3MJWkGfjDr019xsMMlkisR+4kVWqS
	 KJYh9UP96g88t0hLyrCwmQRUgb/nvkfQZEv/k67Nf+aCu4B8B20iAqz0e2YbEa37l7
	 97X2K2JgZhyXagoQ2bS2tiyb0MXQJ2mVemD4FmjllWbrzOLewAHwNTaS9RIs7PlPJ3
	 5rmSLUzAQR4VYT9gtfD4842oJJa6Zu0Q5vos3emaEv5xFQXv/Puzm/RyGsqLLRsbO1
	 R96kLsBkz36kBGu/M0ZkRNBxQJ46UZ+2P3oU/uYG5rBMlplK8uD65h01wBd2mb4e7p
	 Hf/gaWkJRh4tQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 053CD378216D;
	Wed, 12 Jun 2024 08:16:46 +0000 (UTC)
Message-ID: <87e6beea-4618-4a5c-a883-42ef64a2d584@collabora.com>
Date: Wed, 12 Jun 2024 13:17:23 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH v2 1/4] kselftests: vdso: vdso_test_clock_getres: conform
 test to TAP output
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240610054129.1527389-1-usama.anjum@collabora.com>
 <20240610054129.1527389-2-usama.anjum@collabora.com>
 <7b020209-3b20-48f4-92fb-099d80aee625@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <7b020209-3b20-48f4-92fb-099d80aee625@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/24 1:32 AM, Shuah Khan wrote:
> On 6/9/24 23:41, Muhammad Usama Anjum wrote:
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output messages.
>> Use kselftest_harness.h to conform to TAP as the number of tests depend
>> on the available options at build time. The kselftest_harness makes the
> 
> 
> How does converting to kselftest_harness help with available options ay
> build time? Can you explain?
> 
> I am not seeing any value in converting this test to the harness? I want
> to see a better justification.

Before:
./vdso_test_clock_getres
clock_id: CLOCK_REALTIME [PASS]
clock_id: CLOCK_BOOTTIME [PASS]
clock_id: CLOCK_TAI [PASS]
clock_id: CLOCK_REALTIME_COARSE [PASS]
clock_id: CLOCK_MONOTONIC [PASS]
clock_id: CLOCK_MONOTONIC_RAW [PASS]
clock_id: CLOCK_MONOTONIC_COARSE [PASS]

Here is the output of the test before this patch. The test output test
names and if they are passed or failed. It doesn't output information
related to error when it occurs. I wanted to convert it to standard format
by using kselftest.h where we can get the error related information as
well. But as the number of tests depend on how many of CLOCK_BOOTTIME,
CLOCK_TAI etc are defined, static counting is difficult. Test harness is
best suited for this. Output:

./vdso_test_clock_getres
TAP version 13
1..7
# Starting 7 tests from 1 test cases.
#  RUN           global.clock_realtime ...
#            OK  global.clock_realtime
ok 1 global.clock_realtime
#  RUN           global.clock_boottime ...
#            OK  global.clock_boottime
ok 2 global.clock_boottime
#  RUN           global.clock_tai ...
#            OK  global.clock_tai
ok 3 global.clock_tai
#  RUN           global.clock_realtime_coarse ...
#            OK  global.clock_realtime_coarse
ok 4 global.clock_realtime_coarse
#  RUN           global.clock_monotonic ...
#            OK  global.clock_monotonic
ok 5 global.clock_monotonic
#  RUN           global.clock_monotonic_raw ...
#            OK  global.clock_monotonic_raw
ok 6 global.clock_monotonic_raw
#  RUN           global.clock_monotonic_coarse ...
#            OK  global.clock_monotonic_coarse
ok 7 global.clock_monotonic_coarse
# PASSED: 7 / 7 tests passed.
# Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

Not only the code is simplified, the descriptive error is printed on
console that what went wrong. Example if a test case fails:

#  RUN           global.clock_realtime ...
# vdso_test_clock_getres.c:66:clock_realtime:Expected 1 (1) == ((x.tv_sec
!= y.tv_sec) || (x.tv_nsec != y.tv_nsec)) (0)
# clock_realtime: Test terminated by assertion
#          FAIL  global.clock_realtime
not ok 1 global.clock_realtime

> 
>> test easy to convert and presents better maintainability.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Update commit message to include that kselftest_harness has been used
>>    to conform to TAP and why
>> ---
>>   .../selftests/vDSO/vdso_test_clock_getres.c   | 68 +++++++++----------
>>   1 file changed, 33 insertions(+), 35 deletions(-)
>>
>> diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
>> b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
>> index 38d46a8bf7cba..c1ede40521f05 100644
>> --- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
>> +++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
>> @@ -25,7 +25,7 @@
>>   #include <unistd.h>
>>   #include <sys/syscall.h>
>>   -#include "../kselftest.h"
>> +#include "../kselftest_harness.h"
>>     static long syscall_clock_getres(clockid_t _clkid, struct timespec *_ts)
>>   {
>> @@ -54,18 +54,8 @@ const char *vdso_clock_name[12] = {
>>   /*
>>    * This function calls clock_getres in vdso and by system call
>>    * with different values for clock_id.
>> - *
>> - * Example of output:
>> - *
>> - * clock_id: CLOCK_REALTIME [PASS]
>> - * clock_id: CLOCK_BOOTTIME [PASS]
>> - * clock_id: CLOCK_TAI [PASS]
>> - * clock_id: CLOCK_REALTIME_COARSE [PASS]
>> - * clock_id: CLOCK_MONOTONIC [PASS]
>> - * clock_id: CLOCK_MONOTONIC_RAW [PASS]
>> - * clock_id: CLOCK_MONOTONIC_COARSE [PASS]
>>    */
>> -static inline int vdso_test_clock(unsigned int clock_id)
>> +static inline void vdso_test_clock(struct __test_metadata *_metadata,
>> unsigned int clock_id)
>>   {
>>       struct timespec x, y;
>>   @@ -73,52 +63,60 @@ static inline int vdso_test_clock(unsigned int
>> clock_id)
>>       clock_getres(clock_id, &x);
>>       syscall_clock_getres(clock_id, &y);
>>   -    if ((x.tv_sec != y.tv_sec) || (x.tv_nsec != y.tv_nsec)) {
>> -        printf(" [FAIL]\n");
>> -        return KSFT_FAIL;
>> -    }
>> -
>> -    printf(" [PASS]\n");
>> -    return KSFT_PASS;
>> +    ASSERT_EQ(0, ((x.tv_sec != y.tv_sec) || (x.tv_nsec != y.tv_nsec)));
>>   }
>>   -int main(int argc, char **argv)
>> -{
>> -    int ret = 0;
>> -
>>   #if _POSIX_TIMERS > 0
>>     #ifdef CLOCK_REALTIME
>> -    ret += vdso_test_clock(CLOCK_REALTIME);
>> +TEST(clock_realtime)
>> +{
>> +    vdso_test_clock(_metadata, CLOCK_REALTIME);
>> +}
>>   #endif
>>     #ifdef CLOCK_BOOTTIME
>> -    ret += vdso_test_clock(CLOCK_BOOTTIME);
>> +TEST(clock_boottime)
>> +{
>> +    vdso_test_clock(_metadata, CLOCK_BOOTTIME);
>> +}
>>   #endif
>>     #ifdef CLOCK_TAI
>> -    ret += vdso_test_clock(CLOCK_TAI);
>> +TEST(clock_tai)
>> +{
>> +    vdso_test_clock(_metadata, CLOCK_TAI);
>> +}
>>   #endif
>>     #ifdef CLOCK_REALTIME_COARSE
>> -    ret += vdso_test_clock(CLOCK_REALTIME_COARSE);
>> +TEST(clock_realtime_coarse)
>> +{
>> +    vdso_test_clock(_metadata, CLOCK_REALTIME_COARSE);
>> +}
>>   #endif
>>     #ifdef CLOCK_MONOTONIC
>> -    ret += vdso_test_clock(CLOCK_MONOTONIC);
>> +TEST(clock_monotonic)
>> +{
>> +    vdso_test_clock(_metadata, CLOCK_MONOTONIC);
>> +}
>>   #endif
>>     #ifdef CLOCK_MONOTONIC_RAW
>> -    ret += vdso_test_clock(CLOCK_MONOTONIC_RAW);
>> +TEST(clock_monotonic_raw)
>> +{
>> +    vdso_test_clock(_metadata, CLOCK_MONOTONIC_RAW);
>> +}
>>   #endif
>>     #ifdef CLOCK_MONOTONIC_COARSE
>> -    ret += vdso_test_clock(CLOCK_MONOTONIC_COARSE);
>> +TEST(clock_monotonic_coarse)
>> +{
>> +    vdso_test_clock(_metadata, CLOCK_MONOTONIC_COARSE);
>> +}
>>   #endif
>>   -#endif
>> -    if (ret > 0)
>> -        return KSFT_FAIL;
>> +#endif /* _POSIX_TIMERS > 0 */
>>   -    return KSFT_PASS;
>> -}
>> +TEST_HARNESS_MAIN
> 
> thanks,
> -- Shuah
> 
> 

-- 
BR,
Muhammad Usama Anjum

