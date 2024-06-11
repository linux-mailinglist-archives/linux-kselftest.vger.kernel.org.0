Return-Path: <linux-kselftest+bounces-11702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923259045CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 22:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DC31C22DCF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 20:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C04614F135;
	Tue, 11 Jun 2024 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SlB9vBuj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C79612E61
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137969; cv=none; b=A3Ne2nyYctYCJPTNqOYijVuGuXHM8Mhtgag9C0+TwIl3q/yc53wBnN6iB3n/ZhxF8z6wxP1bdzXSLmezNILxKNrEnqBetMcDZs1qVgd8TIPQldwgc6JVoEPiN/5eoiFCI9eVfT2qZN+fgYa0EpIyBLjMLJmUlMLy5gfCM1AXOzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137969; c=relaxed/simple;
	bh=b0tnxRk55JpxblBUjsK3yCQEBPWg1TI02Rgcr11aIaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEQ3Drb5po1k8u6I7BiUuHrRGtDkAzJhT/nWiZu3H/nbInZJLqlZLOPg4fE/Yn0NWs8iqdm/8EplXS0munILc+29V1lMihPfRO6NAhjekM2YbcqpkT1aqDIeXMl7KsWISi6rX4H+W2UHZ1OdSq2zQZ93fdx6j0nrx5vnGhRNQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SlB9vBuj; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4405ea572ecso1446491cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718137966; x=1718742766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ru7+Mgfc7mgl94OE4z4ZFlKjJ2kecSG9/ABayWePB4U=;
        b=SlB9vBujG8ve0QJONkYwv8kT93mNalMsGz0SFR7q3I2CV2BzjXYzqc1+QCZ/I+uNa7
         AdOltfKGYNl32UpVa/RjXdWDBEBoMjzythHfc3LzOsFpicjxETieC/z7XJZmm7+7aN4g
         MfGanPigNnR8jenowp3We426bgI8w5bvOUW/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718137966; x=1718742766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru7+Mgfc7mgl94OE4z4ZFlKjJ2kecSG9/ABayWePB4U=;
        b=ke+M7eU3bJVIjAnW5DnOxEZDQYCrBcuQOe8tU2mLz9VSUW8cexTLnZ21vkccOtb1j1
         xnQ1bz4LmCi7wXUEs7Q0IZZmcHpGTZ9flnW9i+PSj3eiNiAt4a/6fXT5dsCTXdlIZF3K
         0OFucc9cn32iumuB97LKXHOkrET1oYe27Yh3mcxAkzcuwIlHFztmNF9zlIOhNU7q/2zQ
         5LtuHE3WBnOJYUgiFkTUSU1vxqumB7cod+whQvSAc8MAdSWPQ8jgdUCbH6bg6FSYOqBA
         /MM5wkZLrjzPhRiN3Pgw77i5XatheBjrDuzp11jZCUdQZTSW19Zbzy582owKDeoQIReA
         wyLg==
X-Forwarded-Encrypted: i=1; AJvYcCW3HtenViDllOJbQiF4xrpJwPmo3ASqKvttaYQ1D0planRIW3ZkSP2IBqZjb1MBVW91dbcaFWBRT2YueuX74E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXDachT7b/O6IL+RSlpKNZz8j6DGUs4b/6eLsTIm7yMs0Qtsu0
	ywwCWCOwnAfPNOuZfLyVe5YynCbnaCZDayuUQbBkfkHP3TUd7GhXrZb3DY2yM8tONIXTwVcypQA
	p
X-Google-Smtp-Source: AGHT+IFK7jjopDEBt4JLGnF3rHXBONyzbPrLCNN+4zYVs0NdvsF3aGRSpzJArJhiRJnBqwM0V4BQ7A==
X-Received: by 2002:ad4:4425:0:b0:6b0:6e0a:4da8 with SMTP id 6a1803df08f44-6b06e0a5003mr101070236d6.1.1718137966447;
        Tue, 11 Jun 2024 13:32:46 -0700 (PDT)
Received: from [172.20.14.19] (ool-6c3a3e1d.static.optonline.net. [108.58.62.29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b091d46280sm4945606d6.94.2024.06.11.13.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 13:32:46 -0700 (PDT)
Message-ID: <7b020209-3b20-48f4-92fb-099d80aee625@linuxfoundation.org>
Date: Tue, 11 Jun 2024 14:32:45 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] kselftests: vdso: vdso_test_clock_getres: conform
 test to TAP output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240610054129.1527389-1-usama.anjum@collabora.com>
 <20240610054129.1527389-2-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240610054129.1527389-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/24 23:41, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> Use kselftest_harness.h to conform to TAP as the number of tests depend
> on the available options at build time. The kselftest_harness makes the


How does converting to kselftest_harness help with available options ay
build time? Can you explain?

I am not seeing any value in converting this test to the harness? I want
to see a better justification.

> test easy to convert and presents better maintainability.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Update commit message to include that kselftest_harness has been used
>    to conform to TAP and why
> ---
>   .../selftests/vDSO/vdso_test_clock_getres.c   | 68 +++++++++----------
>   1 file changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
> index 38d46a8bf7cba..c1ede40521f05 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
> @@ -25,7 +25,7 @@
>   #include <unistd.h>
>   #include <sys/syscall.h>
>   
> -#include "../kselftest.h"
> +#include "../kselftest_harness.h"
>   
>   static long syscall_clock_getres(clockid_t _clkid, struct timespec *_ts)
>   {
> @@ -54,18 +54,8 @@ const char *vdso_clock_name[12] = {
>   /*
>    * This function calls clock_getres in vdso and by system call
>    * with different values for clock_id.
> - *
> - * Example of output:
> - *
> - * clock_id: CLOCK_REALTIME [PASS]
> - * clock_id: CLOCK_BOOTTIME [PASS]
> - * clock_id: CLOCK_TAI [PASS]
> - * clock_id: CLOCK_REALTIME_COARSE [PASS]
> - * clock_id: CLOCK_MONOTONIC [PASS]
> - * clock_id: CLOCK_MONOTONIC_RAW [PASS]
> - * clock_id: CLOCK_MONOTONIC_COARSE [PASS]
>    */
> -static inline int vdso_test_clock(unsigned int clock_id)
> +static inline void vdso_test_clock(struct __test_metadata *_metadata, unsigned int clock_id)
>   {
>   	struct timespec x, y;
>   
> @@ -73,52 +63,60 @@ static inline int vdso_test_clock(unsigned int clock_id)
>   	clock_getres(clock_id, &x);
>   	syscall_clock_getres(clock_id, &y);
>   
> -	if ((x.tv_sec != y.tv_sec) || (x.tv_nsec != y.tv_nsec)) {
> -		printf(" [FAIL]\n");
> -		return KSFT_FAIL;
> -	}
> -
> -	printf(" [PASS]\n");
> -	return KSFT_PASS;
> +	ASSERT_EQ(0, ((x.tv_sec != y.tv_sec) || (x.tv_nsec != y.tv_nsec)));
>   }
>   
> -int main(int argc, char **argv)
> -{
> -	int ret = 0;
> -
>   #if _POSIX_TIMERS > 0
>   
>   #ifdef CLOCK_REALTIME
> -	ret += vdso_test_clock(CLOCK_REALTIME);
> +TEST(clock_realtime)
> +{
> +	vdso_test_clock(_metadata, CLOCK_REALTIME);
> +}
>   #endif
>   
>   #ifdef CLOCK_BOOTTIME
> -	ret += vdso_test_clock(CLOCK_BOOTTIME);
> +TEST(clock_boottime)
> +{
> +	vdso_test_clock(_metadata, CLOCK_BOOTTIME);
> +}
>   #endif
>   
>   #ifdef CLOCK_TAI
> -	ret += vdso_test_clock(CLOCK_TAI);
> +TEST(clock_tai)
> +{
> +	vdso_test_clock(_metadata, CLOCK_TAI);
> +}
>   #endif
>   
>   #ifdef CLOCK_REALTIME_COARSE
> -	ret += vdso_test_clock(CLOCK_REALTIME_COARSE);
> +TEST(clock_realtime_coarse)
> +{
> +	vdso_test_clock(_metadata, CLOCK_REALTIME_COARSE);
> +}
>   #endif
>   
>   #ifdef CLOCK_MONOTONIC
> -	ret += vdso_test_clock(CLOCK_MONOTONIC);
> +TEST(clock_monotonic)
> +{
> +	vdso_test_clock(_metadata, CLOCK_MONOTONIC);
> +}
>   #endif
>   
>   #ifdef CLOCK_MONOTONIC_RAW
> -	ret += vdso_test_clock(CLOCK_MONOTONIC_RAW);
> +TEST(clock_monotonic_raw)
> +{
> +	vdso_test_clock(_metadata, CLOCK_MONOTONIC_RAW);
> +}
>   #endif
>   
>   #ifdef CLOCK_MONOTONIC_COARSE
> -	ret += vdso_test_clock(CLOCK_MONOTONIC_COARSE);
> +TEST(clock_monotonic_coarse)
> +{
> +	vdso_test_clock(_metadata, CLOCK_MONOTONIC_COARSE);
> +}
>   #endif
>   
> -#endif
> -	if (ret > 0)
> -		return KSFT_FAIL;
> +#endif /* _POSIX_TIMERS > 0 */
>   
> -	return KSFT_PASS;
> -}
> +TEST_HARNESS_MAIN

thanks,
-- Shuah


