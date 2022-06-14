Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE57A54B78C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 19:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbiFNRV6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 13:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiFNRV5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 13:21:57 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6423531DFC
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 10:21:56 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bf7so11207328oib.11
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ywm3mNyiKeLVTgO84COA1L5/j176F2hvLnvyrxiZpk=;
        b=AWkMw8qDDxUsyjkc8/EdDf0vDUNZI4+1avXvECNWeq65H7wYaV4MeZ7v1OOHLMhMj4
         FLzKW+OKYNmbUaKtFTWofkfTtgV129jDjarxpLM2bUCsQZEJhSLUpDJXEL1nc94wUk6Q
         JKafkc/wNofuOHkWC95WULU92xyVIeZA23cc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ywm3mNyiKeLVTgO84COA1L5/j176F2hvLnvyrxiZpk=;
        b=NRyL7zt/PEGhlMtp5+41qMSROFS42SfZEaXy+v+YmstHA4zOa0va2IhRk0wkX31rpE
         z+P+e/UDuMJyCMLBVYrCxGGENdfORAzMVESEE7oUElJNqJ0Xp02J/48DbJMmaQ9401sr
         7E3w3jGDhaBBgQ17DRjVip091dzJRSH+gSc+jV6shGIWzmPii9oIaNdV6Coih8gRyX5M
         yW0Gy93vtXQowD2eAuYSV+EUBEAYxMTcpGTHe38GRTYarprEeI0212CSuY6K4jV2ahDO
         rX6U6fquiiIjOt/9s5N1jwSCpbxxN1enVcgE6M2Pd3pVR/9t6IWbMMLqVvUYDD0Qi+Vq
         8C1Q==
X-Gm-Message-State: AOAM53001EEiGkeePflvHsyV8zk9X7q6FmeOUXeJUNU8SnNTiKZW5m/X
        4pATdC/z42WIO9RE71+nCpKVJg==
X-Google-Smtp-Source: ABdhPJyyL3I7o6YWcvJMsSOx0GWGShRXku1QmIK25GsYA4K+0gPS+KzviOpXpB43NXZuolmRy3EWsQ==
X-Received: by 2002:a05:6808:10d3:b0:32f:51ae:6245 with SMTP id s19-20020a05680810d300b0032f51ae6245mr2636903ois.125.1655227315718;
        Tue, 14 Jun 2022 10:21:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p7-20020a056830318700b0060bfb4e4033sm4914235ots.9.2022.06.14.10.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 10:21:55 -0700 (PDT)
Subject: Re: [PATCH] selftests: Fix clang cross compilation
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220614121045.1046475-1-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b4965ab7-c619-16b9-c027-aeb6986f76b7@linuxfoundation.org>
Date:   Tue, 14 Jun 2022 11:21:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220614121045.1046475-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/14/22 6:10 AM, Mark Brown wrote:
> Unlike GCC clang uses a single compiler image to support multiple target
> architectures meaning that we can't simply rely on CROSS_COMPILE to select
> the output architecture. Instead we must pass --target to the compiler to
> tell it what to output, kselftest was not doing this so cross compilation
> of kselftest using clang resulted in kselftest being built for the host
> architecture.
> 
> More work is required to fix tests using custom rules but this gets the
> bulk of things building.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/lib.mk | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 

Thank you. I will apply this for the next rc.

thanks,
-- Shuah

