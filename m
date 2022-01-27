Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0561049EE61
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 00:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbiA0XCD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 18:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbiA0XCD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 18:02:03 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E609C061714
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 15:02:03 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id y17so3906930ilm.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 15:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/udoNmOdToKZ46JixRPRrkFS07mcQhi4GHZVYYVEkbc=;
        b=JbObllQ61T/iGnBUjULS9/tBm7bjFLR+cUslbw4rxf/RHEdNUXRLGNH1OQE1R1MAzC
         q7UY5vIIWqOJtz0a0PAM3vf4YwRtuLNO46PyqyWtRRoy64vBGofSZnluxWLr+h+usGJh
         KSuk+fFej0loknxj937nOtODaRaL5x5T4VVIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/udoNmOdToKZ46JixRPRrkFS07mcQhi4GHZVYYVEkbc=;
        b=RH/l9kn8p3ODyC5CiQUJnidG9UZQKWY7QLGVs5+9A78V7gsxt7h2uvggba7CVVGsnD
         Cf03pnTzZHv1yrw2WR4mVuR7ZZ4ohB7fBRVGTo0TWyWAbJGQ8zBrB9b490q4YCMj/qkR
         dY09gJI6CdbwQsv1Hwot+smY0YgqW6uLKUBr/2FXMNODZ1sydyMjrmb3FeOibr4abraB
         min98ickvwoWR2VPfpMemKaQrCxuGfBNBoR2ZW208/u5or8J0m3c1/nkSTMpqUSLVOJh
         Sy3NR74tvHCGnwS5XmsmeHQQoARH04swgNwUZHJ2D1fzTfZblEuyEemZ6cJgd1EWY+YD
         zo9g==
X-Gm-Message-State: AOAM533qExbC07QYqtuakUaOFG/RuB718csTW08UKqLUbz7Pki0FYsbr
        foPiXDRqCAvvJz78IpLjJORcR7VLYyJoGg==
X-Google-Smtp-Source: ABdhPJw7snTnsDnp2NSxNMlJZgf+Ks8g/n0IOMPOVZLcnCw/cpfCGHXpCKnBGD88sSz5Dq3YV4zEVA==
X-Received: by 2002:a05:6e02:188c:: with SMTP id o12mr4196131ilu.95.1643324522750;
        Thu, 27 Jan 2022 15:02:02 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id m4sm12666632iln.48.2022.01.27.15.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:02:02 -0800 (PST)
Subject: Re: [PATCH 2/5] kselftest: Fix vdso_test_time to pass on skips
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126102723.23300-1-cristian.marussi@arm.com>
 <20220126102723.23300-3-cristian.marussi@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3603bae9-d292-8c67-331f-18fe54586355@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 16:02:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220126102723.23300-3-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/26/22 3:27 AM, Cristian Marussi wrote:
> When a vDSO symbol is not found, all the testcases in vdso_test_abi usually
> report a SKIP, which, in turn, is reported back to Kselftest as a PASS.
> 
> Testcase vdso_test_time, instead, reporting a SKIP, causes the whole set of
> tests within vdso_test_abi to be considered FAIL when symbol is not found.
> 
> Fix it reporting a PASS when vdso_test_time cannot find the vdso symbol.
> 
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Seen as a failure on both a JUNO and a Dragonboard on both recent and old
> kernels/testruns:
> 
> root@deb-buster-arm64:~# /opt/ksft/vDSO/vdso_test_abi
> [vDSO kselftest] VDSO_VERSION: LINUX_2.6.39
> The time is 1637922136.675304
> The time is 1637922136.675361000
> The resolution is 0 1
> clock_id: CLOCK_REALTIME [PASS]
> The time is 1927.760604900
> The resolution is 0 1
> clock_id: CLOCK_BOOTTIME [PASS]
> The time is 1637922136.675649700
> The resolution is 0 1
> clock_id: CLOCK_TAI [PASS]
> The time is 1637922136.672000000
> The resolution is 0 4000000
> clock_id: CLOCK_REALTIME_COARSE [PASS]
> The time is 1927.761005600
> The resolution is 0 1
> clock_id: CLOCK_MONOTONIC [PASS]
> The time is 1927.761132780
> The resolution is 0 1
> clock_id: CLOCK_MONOTONIC_RAW [PASS]
> The time is 1927.757093740
> The resolution is 0 4000000
> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
> Could not find __kernel_time              <<< This caused a FAIL as a whole
> root@deb-buster-arm64:~# echo $?
> 1
> 
> e.g.: https://lkft.validation.linaro.org/scheduler/job/2192570#L27778
> ---
>   tools/testing/selftests/vDSO/vdso_test_abi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
> index 3d603f1394af..7dcc66d1cecf 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_abi.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
> @@ -90,8 +90,9 @@ static int vdso_test_time(void)
>   		(vdso_time_t)vdso_sym(version, name[2]);
>   
>   	if (!vdso_time) {
> +		/* Skip if symbol not found: consider skipped tests as passed */
>   		printf("Could not find %s\n", name[2]);
> -		return KSFT_SKIP;
> +		return KSFT_PASS;

Skip is a the right option here. Pass indicates that the functionality
has been tested and it passed. There is a clear message that says that
the symbol isn't found

thanks,
-- Shuah
