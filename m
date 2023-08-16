Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBD677E765
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 19:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbjHPRPg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 13:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345186AbjHPRPN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 13:15:13 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB47626A6
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 10:15:12 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77dcff76e35so81508139f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692206112; x=1692810912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7pZ8yXv877xqgWHoGs7GnAl1TuvEBADR0sH782/8U8=;
        b=ON1qj7hzWcby1d53aWfkaayYoCVQPcUlGlMszWIXfnKqPOVZkDoBvKhasvcTUdjeU/
         xbPnlk815G0BzzeedvPkotEJg5nVD00UYV5RJu/wyqT7dUnXewOnWfWiyHv9Gaf3avY2
         yFUOWxNV35R3JrfJuQBrZdMwEkhnH2nlbARVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692206112; x=1692810912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7pZ8yXv877xqgWHoGs7GnAl1TuvEBADR0sH782/8U8=;
        b=fMndG98lpmp7PsRGtMX8LW9vZOl0HfSDpmhY01HQ3MbT8Dnb46bg3T/SXKA3qQXnID
         bBhq8U2ukE9d8Ry2DF2KqY5e7kBMRV4KyfttCf+BM8nsCmSghxxB37yjQqZ5OtXP8bPb
         Qnuub58zxf5D0X23u+LKtxdQS6gHrn/DhCmvnWOeBGEUElnKYj5bdLSkfqztjzjlAP1f
         ywdiSIS2dzHt2RbcYN9na1O4BIjBtsD/NzAKx9Wye4On0XFXfMPLX4JwheHUdqdovMCq
         v2QpYpkHSUyAmdONlYs1/l69/m68Ha7Nl9E3gpv9pKUP2m8t6BBIZr7zMCZoEyZCoq6I
         ShQw==
X-Gm-Message-State: AOJu0YwBCiVTW1Oxx1YMXaeMHwhIFaRguYOxypOwwnoa5Jp/Opfz7zjL
        eUOyS1q0K25f5QA8mUSFNIFmq+XQaGBJI1wH7FI=
X-Google-Smtp-Source: AGHT+IFsVDC5ag7WEIVMgg2Z2P5NR6QcXCAPC6Ahd7mWp5AmaHyYRTxHfuzvfLXohNFvnq72lFsxng==
X-Received: by 2002:a05:6602:3983:b0:783:63e8:3bfc with SMTP id bw3-20020a056602398300b0078363e83bfcmr4086982iob.0.1692206112087;
        Wed, 16 Aug 2023 10:15:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c15-20020a5ea90f000000b0078680780694sm4640181iod.34.2023.08.16.10.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 10:15:11 -0700 (PDT)
Message-ID: <343469cf-47a3-c8de-dc61-dbcf41e5757c@linuxfoundation.org>
Date:   Wed, 16 Aug 2023 11:15:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] selftests: cachestat: use proper syscall number macro
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>,
        Shuah Khan <shuah@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230815155612.2535947-1-andre.przywara@arm.com>
 <20230815155612.2535947-3-andre.przywara@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230815155612.2535947-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/23 09:56, Andre Przywara wrote:
> At the moment the cachestat syscall number is hard coded into the test
> source code.
> Remove that and replace it with the proper __NR_cachestat macro.
> That ensures compatibility should other architectures pick a different
> number.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   tools/testing/selftests/cachestat/test_cachestat.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
> index 54d09b820ed4b..a5a4ac8dcb76c 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -19,7 +19,6 @@ static const char * const dev_files[] = {
>   	"/dev/zero", "/dev/null", "/dev/urandom",
>   	"/proc/version", "/proc"
>   };
> -static const int cachestat_nr = 451;
>   
>   void print_cachestat(struct cachestat *cs)
>   {
> @@ -126,7 +125,7 @@ bool test_cachestat(const char *filename, bool write_random, bool create,
>   		}
>   	}
>   
> -	syscall_ret = syscall(cachestat_nr, fd, &cs_range, &cs, 0);
> +	syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
>   
>   	ksft_print_msg("Cachestat call returned %ld\n", syscall_ret);
>   
> @@ -152,7 +151,7 @@ bool test_cachestat(const char *filename, bool write_random, bool create,
>   			ksft_print_msg("fsync fails.\n");
>   			ret = false;
>   		} else {
> -			syscall_ret = syscall(cachestat_nr, fd, &cs_range, &cs, 0);
> +			syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
>   
>   			ksft_print_msg("Cachestat call (after fsync) returned %ld\n",
>   				syscall_ret);
> @@ -213,7 +212,7 @@ bool test_cachestat_shmem(void)
>   		goto close_fd;
>   	}
>   
> -	syscall_ret = syscall(cachestat_nr, fd, &cs_range, &cs, 0);
> +	syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
>   
>   	if (syscall_ret) {
>   		ksft_print_msg("Cachestat returned non-zero.\n");


Thank you. Applied to linux-kselftest next for Linux 6.6-rc1

thanks,
-- Shuah
