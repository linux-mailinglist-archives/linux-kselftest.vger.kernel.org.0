Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A58501DAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 23:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbiDNVv0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 17:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbiDNVvZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 17:51:25 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2057195A1E
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 14:48:59 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p21so6858805ioj.4
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OmTrbVZbb3w4KmRSUrb4q7Rzh5oX9eyi3T1MDFP0KjU=;
        b=L0ITK16Dy0IulWrdQyDKQ385h5ypzAheqavuhQtIQ4WthfcqHAKDNmY714eWVBWVkd
         0lH5+srAWBGwoZGuRFGvxgF5ndFpH5MI5HwM+B2POrV/utMgPDIQYEMYFpwBaugtYjn3
         RKd+NKmkrd+Wq7xUVVUwT07zs/glJxUNPjTEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OmTrbVZbb3w4KmRSUrb4q7Rzh5oX9eyi3T1MDFP0KjU=;
        b=zE45EgUjPYeEeNZT3yVa5cjCPWVkmK8N1w9VSSpuNO0jdURobBDDzRSYCP8Etakg/J
         x9SgPRbK3pvXdp03yPZ91QEyZn91qZcLabIH6NqLD/pzwsLZf+aVRGVNxBZs4BjVVaH5
         NOVeMJfTaTFq9z0eM3+109Goj8nogv8fJDbSchi0oW2TjUuU7Hlzx0blE9wHr6/dImRK
         8lQ0N67OiaCBJP4Mx+7S8ffroFdJ0bKMvVlTGclJH1hEDCoIpoAkDWv8VCudJc0n8Nho
         Xu7QWTU7G4HjWn+DMuvgyezEJxHKcVFR2D91djXdni76wgAHdwddrb1RmECwliBLN4fk
         5wAQ==
X-Gm-Message-State: AOAM5307RlJ8tPorvL314nEaEfLIiDrnSONAcvucC9VDPmvqxr6s+dQF
        FBa4fAGzEzJSte56jVWQsy3uCg==
X-Google-Smtp-Source: ABdhPJwFB9gnU6H5kQKv6sg6zZUUef1cdcX0RES3LTxpZRh8PGSuFNjTFiSA6oTKwMbW7jV7ifdjtA==
X-Received: by 2002:a05:6638:2047:b0:323:7f2c:f5c4 with SMTP id t7-20020a056638204700b003237f2cf5c4mr2095401jaj.88.1649972938520;
        Thu, 14 Apr 2022 14:48:58 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id w3-20020a92d2c3000000b002cbca0cd15fsm1681010ilg.8.2022.04.14.14.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 14:48:58 -0700 (PDT)
Subject: Re: [PATCH 3/4] selftest/vm: support xfail in mremap_test
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, shuah@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220414171529.62058-1-sidhartha.kumar@oracle.com>
 <20220414171529.62058-4-sidhartha.kumar@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a43b3460-a744-1563-eeff-b697ac2595da@linuxfoundation.org>
Date:   Thu, 14 Apr 2022 15:48:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220414171529.62058-4-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/14/22 11:15 AM, Sidhartha Kumar wrote:
> Use ksft_test_result_xfail for the tests which
> are expected to fail.
> 

Same Nit about commit log lines.

> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>   tools/testing/selftests/vm/mremap_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
> index 98e9cff34aa7..ace9c3596ed7 100644
> --- a/tools/testing/selftests/vm/mremap_test.c
> +++ b/tools/testing/selftests/vm/mremap_test.c
> @@ -269,7 +269,7 @@ static void run_mremap_test_case(struct test test_case, int *failures,
>   
>   	if (remap_time < 0) {
>   		if (test_case.expect_failure)
> -			ksft_test_result_pass("%s\n\tExpected mremap failure\n",
> +			ksft_test_result_xfail("%s\n\tExpected mremap failure\n",
>   					      test_case.name);
>   		else {
>   			ksft_test_result_fail("%s\n", test_case.name);
> 

Thank you. Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
