Return-Path: <linux-kselftest+bounces-6711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA088E129
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 13:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1BC29EE54
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 12:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975C515573A;
	Wed, 27 Mar 2024 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T+wUnklq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB9115572A;
	Wed, 27 Mar 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541750; cv=none; b=onqtpLX3WkgiCQlVIv+Pil/otxt0JTmzCIa3YRfARJnVoHcPSpFaCBmIdGBJO1W+kCYdj0Q7XY7wxnq9zqSexf96/K0VqvDhBLYllFHeYcK1K9PPWP8EnGQ5L9AKRE34u6zwh2xC/4I1lYlVcRnR0RzniiZps949BqE/7PpphHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541750; c=relaxed/simple;
	bh=k0NLiHpCEzJ5lJ8XZ06wUsWMe4rbmWJ5Hehw3aKgT14=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZIbRps9anZB2gAjLvBEOERcYJaItQENjiglpFQkLkkX09N1EMhtVqfAXok/4CmHHYSk7Z9gOTwrl8DgfmPqvkuilGPpBi5aLpFvKpwTsPH4z1AH3NJeLxfuF7d2o35UELn7mXZHFSvkuaH+z1ciTGn85d26HVE7e/y9ciSnWKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T+wUnklq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711541747;
	bh=k0NLiHpCEzJ5lJ8XZ06wUsWMe4rbmWJ5Hehw3aKgT14=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=T+wUnklqoqOfGP13G/JdBdrKyWYUuvPwp78XkUWc9qIE1DWZBXKYmXMfQ75E6CBgM
	 RYo5TTqCeAzc1D7EFv3zx3N9vHNILPt3RTUoxPbIZ8QBdI15x37JR4JUoI92/cMVI1
	 x9H9o8OJoGxMWB6VgS7BcTKrKWeQ+B2lKGyeXEfPlkgJ8SYGCdVDA9HjrIIxIupfvu
	 gRa5UELl/MW2YeI3fK6entdNqjs/I3oT85DH+W4LPamr55CozhVeyvLcixi22wBwPi
	 N0rBqfYD05Z8IMsF7Hm4S/WFxvWmtu7gqYyluqQ1wZTKnzeST22UbaIPYPihnou/gu
	 nV33NpBg1A0CA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 698C937820E4;
	Wed, 27 Mar 2024 12:15:43 +0000 (UTC)
Message-ID: <0dacf491-29ec-4c24-927e-978056177648@collabora.com>
Date: Wed, 27 Mar 2024 17:16:14 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: x86: test_vsyscall: conform test to TAP
 format output
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240314103216.286603-1-usama.anjum@collabora.com>
 <a1a6f5dd-80ab-4d53-90de-eb003c996cc1@linuxfoundation.org>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <a1a6f5dd-80ab-4d53-90de-eb003c996cc1@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/27/24 1:00 AM, Shuah Khan wrote:
> On 3/14/24 04:32, Muhammad Usama Anjum wrote:
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output messages.
>> Without using TAP messages, the passed/failed/skip test names cannot be
>> found.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
> 
> 
> I am seeing lot more changes than conform and formatting changes.
Counting total number of tests based on architecture was really difficult
until the code needed to be moved around. I'll split this patch into 2. The
first part would just simplify the test by moving functions around and use
#ifdef precisely. The seconds part would convert it to the TAP.

> 
>>   tools/testing/selftests/x86/test_vsyscall.c | 506 +++++++++-----------
>>   1 file changed, 238 insertions(+), 268 deletions(-)
>>
>> diff --git a/tools/testing/selftests/x86/test_vsyscall.c
>> b/tools/testing/selftests/x86/test_vsyscall.c
>> index 47cab972807c4..d4c8e8d79d389 100644
>> --- a/tools/testing/selftests/x86/test_vsyscall.c
>> +++ b/tools/testing/selftests/x86/test_vsyscall.c
>> @@ -21,6 +21,13 @@
>>   #include <sys/uio.h>
>>     #include "helpers.h"
>> +#include "../kselftest.h"
>> +
>> +#ifdef __x86_64__
>> +#define TOTAL_TESTS 13
>> +#else
>> +#define TOTAL_TESTS 8
>> +#endif
>>     #ifdef __x86_64__
>>   # define VSYS(x) (x)
>> @@ -39,18 +46,6 @@
>>   /* max length of lines in /proc/self/maps - anything longer is skipped
>> here */
>>   #define MAPS_LINE_LEN 128
>>   -static void sethandler(int sig, void (*handler)(int, siginfo_t *, void
>> *),
>> -               int flags)
>> -{
>> -    struct sigaction sa;
>> -    memset(&sa, 0, sizeof(sa));
>> -    sa.sa_sigaction = handler;
>> -    sa.sa_flags = SA_SIGINFO | flags;
>> -    sigemptyset(&sa.sa_mask);
>> -    if (sigaction(sig, &sa, 0))
>> -        err(1, "sigaction");
>> -}
>> -
> 
> Why is this deleted?
> 
>>   /* vsyscalls and vDSO */
>>   bool vsyscall_map_r = false, vsyscall_map_x = false;
>>   @@ -75,83 +70,25 @@ static void init_vdso(void)
>>       if (!vdso)
>>           vdso = dlopen("linux-gate.so.1", RTLD_LAZY | RTLD_LOCAL |
>> RTLD_NOLOAD);
>>       if (!vdso) {
>> -        printf("[WARN]\tfailed to find vDSO\n");
>> +        ksft_print_msg("[WARN] failed to find vDSO\n");
>>           return;
>>       }
>>         vdso_gtod = (gtod_t)dlsym(vdso, "__vdso_gettimeofday");
>>       if (!vdso_gtod)
>> -        printf("[WARN]\tfailed to find gettimeofday in vDSO\n");
>> +        ksft_print_msg("[WARN] failed to find gettimeofday in vDSO\n");
>>         vdso_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
>>       if (!vdso_gettime)
>> -        printf("[WARN]\tfailed to find clock_gettime in vDSO\n");
>> +        ksft_print_msg("[WARN] failed to find clock_gettime in vDSO\n");
>>         vdso_time = (time_func_t)dlsym(vdso, "__vdso_time");
>>       if (!vdso_time)
>> -        printf("[WARN]\tfailed to find time in vDSO\n");
>> +        ksft_print_msg("[WARN] failed to find time in vDSO\n");
>>         vdso_getcpu = (getcpu_t)dlsym(vdso, "__vdso_getcpu");
>>       if (!vdso_getcpu)
>> -        printf("[WARN]\tfailed to find getcpu in vDSO\n");
>> -}
>> -
>> -static int init_vsys(void)
>> -{
>> -#ifdef __x86_64__
>> -    int nerrs = 0;
>> -    FILE *maps;
>> -    char line[MAPS_LINE_LEN];
>> -    bool found = false;
>> -
>> -    maps = fopen("/proc/self/maps", "r");
>> -    if (!maps) {
>> -        printf("[WARN]\tCould not open /proc/self/maps -- assuming
>> vsyscall is r-x\n");
>> -        vsyscall_map_r = true;
>> -        return 0;
>> -    }
>> -
>> -    while (fgets(line, MAPS_LINE_LEN, maps)) {
>> -        char r, x;
>> -        void *start, *end;
>> -        char name[MAPS_LINE_LEN];
>> -
>> -        /* sscanf() is safe here as strlen(name) >= strlen(line) */
>> -        if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
>> -               &start, &end, &r, &x, name) != 5)
>> -            continue;
>> -
>> -        if (strcmp(name, "[vsyscall]"))
>> -            continue;
>> -
>> -        printf("\tvsyscall map: %s", line);
>> -
>> -        if (start != (void *)0xffffffffff600000 ||
>> -            end != (void *)0xffffffffff601000) {
>> -            printf("[FAIL]\taddress range is nonsense\n");
>> -            nerrs++;
>> -        }
>> -
>> -        printf("\tvsyscall permissions are %c-%c\n", r, x);
>> -        vsyscall_map_r = (r == 'r');
>> -        vsyscall_map_x = (x == 'x');
>> -
>> -        found = true;
>> -        break;
>> -    }
>> -
>> -    fclose(maps);
>> -
>> -    if (!found) {
>> -        printf("\tno vsyscall map in /proc/self/maps\n");
>> -        vsyscall_map_r = false;
>> -        vsyscall_map_x = false;
>> -    }
>> -
>> -    return nerrs;
>> -#else
>> -    return 0;
>> -#endif
>> +        ksft_print_msg("[WARN] failed to find getcpu in vDSO\n");
>>   }
>>   
> 
> What's going on here?
> 
> These changes are more extensive than the changelog indicates.
> Additional explanation is needed before I can accept this>
> thanks,
> -- Shuah
> 

-- 
BR,
Muhammad Usama Anjum

