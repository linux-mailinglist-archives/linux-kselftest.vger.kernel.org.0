Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6906F4CC8C2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 23:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiCCWXc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 17:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiCCWXa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 17:23:30 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0BF1A820
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 14:22:44 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id j5so5195065ila.2
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 14:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TNK7mhTSQKMompxr7UxPsHe7o86ucXNFMfMpNpBeHGw=;
        b=Q2UXydu9CxiIQI0WJzqjioYeRSaL1Xljov5yf9JZT8ahSpyIsCY2QSIwG7CQcCvTcZ
         E1DMhtMqcCMPMXowRPySYUU6ccF7ae4HBr4gwIij7ZOHZbkyH5hs7htFtAZB/cjg5dTr
         RzHdHoN2yQXJVOQYt7+FnixJjLizFekgk3+PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TNK7mhTSQKMompxr7UxPsHe7o86ucXNFMfMpNpBeHGw=;
        b=hCHT0aE0I7kqbPps54Ow5O9gPOZAV1EY3RpH/J8dMDuyFIcukMHB7eGZZFol2V0Lht
         E2bwlPu/osiGCn5T6pZxrZAcIs8xq+NbBmtVjxNxcYr6Gr2x0P3tz88NOSKdf4GCMvVO
         BI0BueCwSmIN/0LPnU1u1lHp1qAyuuHB2e3KuptBwUN4TDwWyAhVy8OmpQ7oBaL9ulI8
         P8YBHt6ygijR1xIdEOL6hSkSCcvHquOwU0IW6XCimTklqN/crZRWLHp8abtW2bTU/9oe
         pNM7n1I2dsSbRVpiUZYnoIpmh5w2LCdmZSlPg4KjE3ufpZ790niLvJWMZo0so3ZEKWRu
         XNXA==
X-Gm-Message-State: AOAM530WJmpY0CrlbgQBdwSE5F2Rl6DgdVYbrZf7R1JiC1mLy+8LzmiB
        ufyOLiqg+t/XuMiGBVFqUh1AWQ==
X-Google-Smtp-Source: ABdhPJyWWs4Ckhs2DeTv9c5lfO3t7TPMGVwC4BNNIp7NBCxiAFzIZuWvhbplP4+SEqsbSpQvBv582w==
X-Received: by 2002:a05:6e02:1bc3:b0:2c1:a992:9ffa with SMTP id x3-20020a056e021bc300b002c1a9929ffamr35510563ilv.124.1646346163936;
        Thu, 03 Mar 2022 14:22:43 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id a9-20020a92c549000000b002c5a2c047ecsm3407792ilj.4.2022.03.03.14.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 14:22:43 -0800 (PST)
Subject: Re: [PATCH V2 2/3] selftests/exec: add generated files to .gitignore
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220302180121.1717581-1-usama.anjum@collabora.com>
 <20220302180121.1717581-2-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <49791479-3973-6ce4-04c5-9ba943c83533@linuxfoundation.org>
Date:   Thu, 3 Mar 2022 15:22:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220302180121.1717581-2-usama.anjum@collabora.com>
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

On 3/2/22 11:01 AM, Muhammad Usama Anjum wrote:
> Add generated files non-regular and null-argv to .gitignore file.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/exec/.gitignore | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
> index 9e2f00343f15..90c238ba6a4b 100644
> --- a/tools/testing/selftests/exec/.gitignore
> +++ b/tools/testing/selftests/exec/.gitignore
> @@ -7,6 +7,8 @@ execveat.moved
>   execveat.path.ephemeral
>   execveat.ephemeral
>   execveat.denatured
> +non-regular
> +null-argv
>   /load_address_*
>   /recursion-depth
>   xxxxxxxx*
> 

Applied to linux-kselftest next for Linux 5.18-rc1

thanks,
-- Shuah
