Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27F8614697
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 10:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKAJ1A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 05:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiKAJ06 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 05:26:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48FA183A7
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 02:26:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id g24so13035366plq.3
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Nov 2022 02:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slsulP8EecbM6UOBcZjOqPyj8fFELW8Cuwl8ohf0MnM=;
        b=iZezuaLaSibVk9MiUnUu2EovCGsOKUSwwdD8Mfq8lytqPXfRn+azTZd/1W/Nxz+0ap
         MiehmubDmDJaxV4YKmvyCkWflI64zDv91CsDMcJxjG3oALj9iuuWNVmYO1sqrW49T/IR
         Tlnp6yWPcWcZgApW6uvnkBMd1jGzm+F+yxn0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slsulP8EecbM6UOBcZjOqPyj8fFELW8Cuwl8ohf0MnM=;
        b=3YQK2GvbFcNf5mwnDk782TK1uI5cNZv2JkFDgjjyXXkgmPfQxSuG3STW/byav2gPsa
         OdaFy7mrligUVzitExZgdxaS5LvdC5oLI5wPyOUMQaf1gqfFTB2c36a/JHDjJOfzmy5U
         PfPjyK9PaoeebeovScvOzn9ML/PbokxFl3YM6g/Zj3fPyP83Me/twDmaqaQo3O5Q/LOJ
         2yd2wH4VBaS5Oki51EzeRyZI2dHnl4bpzlQwsXzh3MrYPlW4t5BH1ml0Gz+khvaVYQFd
         zjjBU90itHmC8vp4jQbS0j3xsoIhPZFMKtbfYMH32QUkrYTIO2nqnKcdMd1CC5133x+x
         ovRg==
X-Gm-Message-State: ACrzQf3wXfOnI5V+WgufLEoupSKMoAfEHXBX9IIL+hlgKxL57X16ojrB
        0htz4AwXYcHLOynpXCPeu2rw3w==
X-Google-Smtp-Source: AMsMyM4KRG1ogIvZTRdUzNptHX2vbjgUUcbvyTI5rx2kbVnTv74InjscBkLzNbk+ZLvOuVvQG8fErA==
X-Received: by 2002:a17:903:248:b0:172:7520:db07 with SMTP id j8-20020a170903024800b001727520db07mr18594518plh.76.1667294815305;
        Tue, 01 Nov 2022 02:26:55 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id k7-20020aa79727000000b0053e8fe8a705sm6304352pfg.17.2022.11.01.02.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 02:26:54 -0700 (PDT)
Message-ID: <1a756034-25e1-a257-e073-ab84f972d8c8@linuxfoundation.org>
Date:   Tue, 1 Nov 2022 03:26:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V5 0/5] Add tbench/gitsource new test cases for
 amd-pstate-ut
Content-Language: en-US
To:     Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        linux-kselftest@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221031084924.1742169-1-li.meng@amd.com>
 <899fc0ab-18d1-a563-10ea-b91623422570@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <899fc0ab-18d1-a563-10ea-b91623422570@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/31/22 04:04, Shuah Khan wrote:
> On 10/31/22 02:49, Meng Li wrote:
>> Hi all:
>>
>> First, rename amd-pstate-ut.sh to basic.sh as a basic test, mainly for
>> AMD P-State kernel drivers. The purpose of this modification is to
>> facilitate the subsequent addition of gitsource, tbench and other tests.
>>
>> Second, split basic.sh into run.sh and basic.sh.
>> The modification makes basic.sh more pure, just for test basic kernel
>> functions. The file of run.sh mainly contains functions such as test
>> entry, parameter check, prerequisite and log clearing etc.
>>
>> Third, add tbench.sh trigger the tbench testing and monitor the cpu.
>>
>> Fourth, add gitsource.sh trigger the gitsource testing and monitor the cpu
>> information.
>>
>> Finally, modify rst document to introduce test steps and results etc.
>>
> 
>>
>> Changes from V4->V5:
>> - selftests: amd-pstate:
>> - - rename amd-pstate-ut.sh to basic.sh.
>> - - split basic.sh into run.sh and basic.sh.
>> - - modify tbench.sh to prompt to install tbench.
>> - - modify commit messages and description informations of shell files.
>> - Documentation: amd-pstate:
>> - - correct spell errors.
>>
> 
> v5 series looks good. Please cleanup checkpatch errors in a couple of files.
> Not too concerned about long line warnings as these seem like "echo"
> statements with output text.
> 

Applied to linux-kselftest next now after fixing the white space error. Please run
checkpatch in the future.

thanks,
-- Shuah

