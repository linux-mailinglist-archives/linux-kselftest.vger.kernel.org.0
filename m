Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880784CC82C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 22:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiCCVkZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 16:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiCCVkZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 16:40:25 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36C5E1B45
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 13:39:38 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id y5so5077615ill.13
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 13:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GrVA4wCtJ9ZZHjn3qb/7bEScChq15mZGv+SPu/mtxIM=;
        b=VCCqrS+5HnBr+1wxFMQSWauFi4Qp22D2JmhF5xNptWdbB+RRGVsOw0hr43SMv8QQSA
         FvZ+O4XYQKizNzZzSiTG6DT1LKtSG1W1CjmvdyiW4yNigLzrBVqP0UZvQuGRu9juEqcV
         N78vuK7UANHhsr7DbY+xfl5U00+fswtNYm4jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GrVA4wCtJ9ZZHjn3qb/7bEScChq15mZGv+SPu/mtxIM=;
        b=MLuX0w4YG5UqMak7N73qA/JrYLXA/dMW+AhB5AR00xvvNXiZx5NheIAYPK7xojFjYb
         dJHsBDcPsDyaaxIYW6fIHpy5YBbJWrwIHDF61PYjvFFFfiURbRf6cOPL1dsHilYuebce
         Tdqxr7UJbwwrJRQIqOuVsLUFj+ncpRm9RPTSZhg0vcdS9Hbfpqv9lcxs2vRFYekoFIKD
         rBiTTz2tUOXZokAHRinQUK39loo+VJlXAzbHA9WFm+egsueibtSmv7r60GTGbFpD5ZN6
         5D79k1kW28rqGC7uFEZxt74VRBUsCVMcLLFlczBAmox9t8b8OrnqqWj2wFQ2mWFyReYS
         aPag==
X-Gm-Message-State: AOAM530eEZFhj/VMj8Dc72CelWJp0L3o+9otASlLaKYJ8lSPuL/nbw6k
        Yr5X5Qbd2akIWTYE/d0XXXOTIw==
X-Google-Smtp-Source: ABdhPJzbbv3ggQn9TAbpL4V/TQDXEGyuOp2p0inmz8pxdQifa0sBXO4Vk4R6ADVOl5MwgFyzP/zxzw==
X-Received: by 2002:a92:c5aa:0:b0:2c5:f753:9069 with SMTP id r10-20020a92c5aa000000b002c5f7539069mr6683520ilt.71.1646343578331;
        Thu, 03 Mar 2022 13:39:38 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id f4-20020a92b504000000b002c21ef70a81sm3233325ile.7.2022.03.03.13.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 13:39:37 -0800 (PST)
Subject: Re: [PATCH] selftests/interpreter: fix separate directory build
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220303110629.2072927-1-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b97fe611-0a2d-6907-b924-a9132e2d427f@linuxfoundation.org>
Date:   Thu, 3 Mar 2022 14:39:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220303110629.2072927-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/3/22 4:06 AM, Muhammad Usama Anjum wrote:
> Separate directory build fails of this test as headers include path isn't
> set correctly in that case. Fix it by including KHDR_INCLUDES.
> 
> make -C tools/testing/selftests O=build1
> gcc -Wall -O2 -I../../../../usr/include    trust_policy_test.c -lcap -o /linux_mainline/build1/kselftest/interpreter/trust_policy_test
> trust_policy_test.c:14:10: fatal error: linux/trusted-for.h: No such file or directory
>     14 | #include <linux/trusted-for.h>
>        |          ^~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/interpreter/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/interpreter/Makefile b/tools/testing/selftests/interpreter/Makefile
> index 7402fdb6533f..51dde8e01e32 100644
> --- a/tools/testing/selftests/interpreter/Makefile
> +++ b/tools/testing/selftests/interpreter/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> -CFLAGS += -Wall -O2 -I$(khdr_dir)
> +CFLAGS += -Wall -O2 -I$(khdr_dir) $(KHDR_INCLUDES)
>   LDLIBS += -lcap
>   

Change looks fine to me.

>   src_test := $(wildcard *_test.c)
> 

I am not seeing this test in linux-kselftest next for sure. Which tree is
this patch based on? Please  add the repo info to the patch subject line
in the future.

Either way I don't have the patch that added in liunx-kselftest repo:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
