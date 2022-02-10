Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4C54B18C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 23:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbiBJWqr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 17:46:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345205AbiBJWqr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 17:46:47 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AD75F4E
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 14:46:47 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e11so4661409ils.3
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 14:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B/UXIV3zf866V2KVi395pqDMtj3eD/83YXll34yD54w=;
        b=BDz7AdxsRIcraonOF4GIu+SUGbj1wkvZhku3SLPoSuwmlYMbKzH/x/rw21Zq2qZGN/
         RqnAHnf0EMjXBB/sYR35dmGGeYeSkNIdE78z1g3sh8hGsS4YXwqr7d54V0YXKW9b5Z7y
         h3UK4GKzi0cKc8CQOElBzKDKu3ylqWx4Ex2+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B/UXIV3zf866V2KVi395pqDMtj3eD/83YXll34yD54w=;
        b=2PAcqiIq941T9ctirnSUmGywOBCgaQwwuF2qeaq7N94oU8lr1FNkcsXB4pT8H2RGud
         M+mw5ufxi/pcMwZ7t0JSbARsKqlT9N8OhfHDHyisIRpzMPhQLBUDahXlBY4aOKy7YHmJ
         xXOw6uOhr7akhr/3iPKgwoX3E211sdsfXf7xSPpa/YwyEBQa2UyrCqdZ4Fyhrv91qBbm
         XGGfyg2WyE8Hacich2mAu0+EzKp3iqjhTmY9SmDcOZ4/suQ8KUiuRghavODDDfHrT9ae
         Jov20So9YQ29XKH38MEjcJkE4K2xwiTqIfltx/F6rBvELdpIdj1NpLb4HCFuucH4E9H7
         jpow==
X-Gm-Message-State: AOAM530fE4e/wNjtSsARutfYrxoq1aVhOc2nyYdeENzv30pCb7R6jw+f
        0EmV4SiW46kMl3/7qCadI70jgCqXC6XL6A==
X-Google-Smtp-Source: ABdhPJx4+vBo900qqkINhcheGliA9WQQ0yV4w/bhniIOWepwfYg1sRffUB0hU4xb+Z0iqz9KI3p0bQ==
X-Received: by 2002:a92:1311:: with SMTP id 17mr5118958ilt.42.1644533206807;
        Thu, 10 Feb 2022 14:46:46 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c2sm8558041ilh.43.2022.02.10.14.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 14:46:46 -0800 (PST)
Subject: Re: [PATCH 1/2] selftests: x86: allow expansion of $(CC)
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>
References: <20220210190642.1477814-1-usama.anjum@collabora.com>
 <20220210190642.1477814-2-usama.anjum@collabora.com>
 <a34f2fc8-f4aa-fef4-d1dd-f3fdb5114f72@linuxfoundation.org>
 <81619c13-41e6-3aab-4cf7-9b6d5a11e05c@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <08b8b886-4ec4-994a-4a4b-0da30766df1e@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 15:46:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <81619c13-41e6-3aab-4cf7-9b6d5a11e05c@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/10/22 3:41 PM, Muhammad Usama Anjum wrote:
> On 2/11/22 1:51 AM, Shuah Khan wrote:
>> On 2/10/22 12:06 PM, Muhammad Usama Anjum wrote:
>>> CC can have multiple sub-strings like "ccache gcc". Erorr pops up if
>>> it is treated as single string and double quote are used around it.
>>> This can be fixed by removing the quotes and not treating CC a single
>>> string.
>>>
>>> Fixes: e9886ace222e ("selftests, x86: Rework x86 target architecture
>>> detection")
>>> Reported-by: "kernelci.org bot" <bot@kernelci.org>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>    tools/testing/selftests/x86/check_cc.sh | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/x86/check_cc.sh
>>> b/tools/testing/selftests/x86/check_cc.sh
>>> index 3e2089c8cf549..aff2c15018b53 100755
>>> --- a/tools/testing/selftests/x86/check_cc.sh
>>> +++ b/tools/testing/selftests/x86/check_cc.sh
>>> @@ -7,7 +7,7 @@ CC="$1"
>>>    TESTPROG="$2"
>>>    shift 2
>>>    -if "$CC" -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
>>> +if $CC -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
>>>        echo 1
>>>    else
>>>        echo 0
>>>
>>
>> The intent is testing if $CC is set. Does this change work when
>> $CC is not set?
>>
> Yeah, it works. I've added a debug variable inside sgx/Makefile and it
> is detecting empty argument correctly as well.
> 

Sounds good.

thanks,
-- Shuah
