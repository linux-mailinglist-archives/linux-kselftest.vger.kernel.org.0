Return-Path: <linux-kselftest+bounces-11438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED8900CC5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF421F22568
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AEC4D11B;
	Fri,  7 Jun 2024 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NBHhDVRe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF2619D89B
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791336; cv=none; b=lg1TmNcY9rTUZbc72RXQqOZbCLd/5BOdfFAwmHHMITwrcL5EkRCIeUkd4GMThtvB1sxTMr8POgXvaWVNPup2gngQoIIctqiz2sdiVdNxsw5c7kVwKI/ekxnO5uEIoax8WkaCqy1c4vxIZJTRn5tZ/L0kg7MKNKGnmsjDY0+6hRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791336; c=relaxed/simple;
	bh=8ZFQFPCQ4XXTULP5PE2A/hOB45BjJEr+QOidNYQ3gh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bphk6oWUaLfUqxP+fXer1hbQiV1+oqbZczlgFVV6yTsePH9BiBXJDzcDpsuViCo/VmizhCF+ID1smC2RcWb0FSlX4cMmENXCBqaonGaUahD84hGwy6Ic4j8eS94zSC/uj5fjkxOScaKR9RG3WCv9TjrP2lpGBSARoPBKZb6916s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NBHhDVRe; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7eada3145f8so5585839f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717791334; x=1718396134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8Xxh/Ngaec4PNLmxPRy2PuypzgB45wSzw/ULqzPxUA=;
        b=NBHhDVReq3YMh3TdZuiV5vhoMwPCrmqLFAZnaL2zUWP4/Jw7C4AqqmNJdTlSaRvn+g
         9/vi6bhI3rlIDPWT+VTjQw0065I9sz1jFMj3+PzSksRry5a9XMbNBtaUKeX+uc637wsR
         GFNhV8Iq6osfwU2BeHV5diFCmEVaWr9Sn6eSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717791334; x=1718396134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8Xxh/Ngaec4PNLmxPRy2PuypzgB45wSzw/ULqzPxUA=;
        b=XdGoEcmCJ9dxq4FxQt/YNcvGRuRIKeKkfCaLvNeqyW5s+ytVblAP6ySkzy1LW0Mj0N
         djFMb07JAFQZUKdjnUm95NodtCxTMUtSfZ4yqVt/KWMTCfjFd2OKvAPaYUA20/D103uh
         v2moANgBX9AbCG/Jf8DmsahZmu0L1xRGUSvBikc2pS7+o/j4unz4YUlMu46reSWhnQRn
         vvGw0oCMLUZzqePn8PbRzOqs4uaoUoEOABKuHQUma+qHVVheJXy/RLFZMMA+wKkd0cbS
         2PavkjOSgAU4NrDlfFSAOPDFsIY7hpwJl+5Z9dnhXsrbrm2igEWGtrtn8SvkYURNxhsn
         E0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCV9T9vSkad4yxpSxhy+TbN9SHLPG8S3lfQS38Svcn71ZDPYGPyyZ2u9ooNXFLl830hViovRxspfWwRip7bBvpaDJdkBBM07wSEOMYGMMWuq
X-Gm-Message-State: AOJu0YwcGXGh9Eyvz1OZSLj04EHaY0qdt8H/7F9g0tliNaeq9U3NbRXE
	BQQNQ912U4G71KW2KV7AyII91fI5j/1u9Nn/VV9aainPzMUulH36xRmbv+oQi7E=
X-Google-Smtp-Source: AGHT+IFjt9n7MceFJ56j5EGGZXyZHBAx91KrQNRWYlCOUZsx281CbKYOqAW30JkztIFgbDxHIMIxrg==
X-Received: by 2002:a05:6602:8ca:b0:7eb:2c80:5354 with SMTP id ca18e2360f4ac-7eb5712c5a8mr362495539f.0.1717791333928;
        Fri, 07 Jun 2024 13:15:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a2386dc6sm1006305173.85.2024.06.07.13.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:15:33 -0700 (PDT)
Message-ID: <b1f1302f-faa2-4081-a73d-b57f9c924e23@linuxfoundation.org>
Date: Fri, 7 Jun 2024 14:15:32 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] kselftests: vdso: vdso_test_clock_getres: conform
 test to TAP output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Colin Ian King <colin.i.king@gmail.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240529072454.2522495-1-usama.anjum@collabora.com>
 <20240529072454.2522495-2-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240529072454.2522495-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 01:24, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

The message doesn't match the change. This patch converts the
test to use kselftest_harness.h

Please fix the message to indicate what changes are being made and
why.

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

