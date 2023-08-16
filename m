Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA58E77E757
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbjHPRMY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345150AbjHPRMJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 13:12:09 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B662D45
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 10:11:51 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3496e3e02f3so5345475ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692205911; x=1692810711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYoS3FzLsOAr5f0S1EEKnI/Ectdz8JgA5KQtKpQFDV4=;
        b=AMv+0pmzEtAON1kkKvAZgz0CRU9HzFF6eZbOn0MLgnGQI2zzR020WXGqXXHGUyebvU
         OvfOa98ihp+NtRXQMaOmmWe2NooUIxbBUFGG+e5MNM6ZvXWEbg8SjQMVZgI8350c7/Hg
         GU2kas2RbxyQ/Kppz74xwUHgUxzuGBOtsw0XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692205911; x=1692810711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYoS3FzLsOAr5f0S1EEKnI/Ectdz8JgA5KQtKpQFDV4=;
        b=QlLN+IhJ2p7gBMoHG4OD90VHr5Fqh8TKB3KHitedEZ4p2AvIt7pYeMB/5YV/pXV5HE
         IbSJlh0kLjv/yHYXN/atFKg3LzyZHptvfQtyRVpx5Iud7EpQLl0a6r9Q4tozVQt2SbeC
         6W++FgfWd01ZuDHaOuBxzeUNCQKEFQbQHC1hWfGOdMufdOJsaW5vo8Dl3HTx8FUk806X
         zHRDxZXI4PY5oJuO/GCjDloJ0DJVvYTbQXAHuY3zIA4tBSqq7rfFR800ZSaQ2tvS/gab
         8/CpyUCSOlgiN4Bpku0BDRJ0bZPGUCnbu59v2gwACg7xzX6YdXP1Nm2+vndoAVNgmat3
         gE3g==
X-Gm-Message-State: AOJu0YwoBskne7gYAcbOXGQYKrEoxpJx7G7eRas6Nbj1ODhFeRAXmDA9
        ecV5NXxcKbmxnGZEtOPXTJI30Q==
X-Google-Smtp-Source: AGHT+IErv/EEWy15Sn057ZKbpCRgOvwG9jec2C11rkrbrBZ//FPdRLPpwEoeD7xt4vH/QgloY06scw==
X-Received: by 2002:a92:c951:0:b0:349:1d60:7250 with SMTP id i17-20020a92c951000000b003491d607250mr3251426ilq.0.1692205911157;
        Wed, 16 Aug 2023 10:11:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t17-20020a02ab91000000b00430a20ce88bsm4370963jan.174.2023.08.16.10.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 10:11:50 -0700 (PDT)
Message-ID: <59c0fcd1-a1f2-de37-c94d-76687934acd5@linuxfoundation.org>
Date:   Wed, 16 Aug 2023 11:11:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] selftests: cachestat: test for cachestat availability
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>,
        Shuah Khan <shuah@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230815155612.2535947-1-andre.przywara@arm.com>
 <20230815155612.2535947-4-andre.przywara@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230815155612.2535947-4-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/23 09:56, Andre Przywara wrote:
> As cachestat is a new syscall, it won't be available on older kernels,
> for instance those running on a build machine. In this case, a run
> reports all tests as "not ok" at the moment.
> 
> Test for the cachestat syscall availability first, before doing further
> tests, and bail out early with a TAP SKIP comment.
> 
> This also uses the opportunity to add the proper TAP headers, and add
> one check for the syscall error handling (illegal file descriptor).
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   .../selftests/cachestat/test_cachestat.c      | 22 ++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
> index a5a4ac8dcb76c..77620e7ecf562 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -15,6 +15,8 @@
>   
>   #include "../kselftest.h"
>   
> +#define NR_TESTS	8
> +
>   static const char * const dev_files[] = {
>   	"/dev/zero", "/dev/null", "/dev/urandom",
>   	"/proc/version", "/proc"
> @@ -235,7 +237,25 @@ bool test_cachestat_shmem(void)
>   
>   int main(void)
>   {
> -	int ret = 0;
> +	int ret;
> +
> +	ksft_print_header();
> +
> +	ret = syscall(__NR_cachestat, -1, NULL, NULL, 0);
> +	if (ret == -1 && errno == ENOSYS) {
> +		printf("1..0 # Skipped: cachestat syscall not available\n");
> +		return KSFT_SKIP;
What happens when other errors besides ENOSYS? The test shouldn't
continue.

> +	}
> +
> +	ksft_set_plan(NR_TESTS);
> +
> +	if (ret == -1 && errno == EBADF) {
> +		ksft_test_result_pass("bad file descriptor recognized\n");
> +		ret = 0;
> +	} else {
> +		ksft_test_result_fail("bad file descriptor ignored\n");
> +		ret = 1;
> +	}
>   
>   	for (int i = 0; i < 5; i++) {
>   		const char *dev_filename = dev_files[i];

thanks,
-- Shuah
