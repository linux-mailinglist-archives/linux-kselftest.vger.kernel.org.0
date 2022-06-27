Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D92655D008
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 15:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiF0RAV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 13:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiF0RAV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 13:00:21 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C21F101EA
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 10:00:20 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r133so10223498iod.3
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1n5+tTXfxvB7wLEdpHqCm9+HbbRZEAGOiM6JchYLEEA=;
        b=TuIDyDjh+Fh8IvzIgcxLkECsvGgepX8QCxNW5muxgMj4AuxdvJykORfH+B33q2pSUz
         aCPMMkkphNHOGRuWbIWhyQThYGYG0oAT8QKG8Ii+lgnwRaCSFyvSV15xWdJalgo72ieJ
         BaaPgTXTMUgSePlhvCeaA9m9fgtz63Wslx2qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1n5+tTXfxvB7wLEdpHqCm9+HbbRZEAGOiM6JchYLEEA=;
        b=kKdbEWDXn45qvRlFApm9vlYMCCIb5oph0pJ14BkokdK/QLqHtwrsuM0LdzwIpE5Gkv
         mFtS/Shj71SEi2MPTyDFhH8ByDXkrfiJMS8l5uoRLAC58GHA5Q5k3+w1z8HKIogtStsy
         L9Hg+bEO4/nE+dGIFyt/nTL0A6/wPKoIuJ9rERW+J2XMEf2YDRvLC7nZhPCpaTEHc6tR
         jXcgedf2ni5NskLwtjzwjSNAGIMZYvQkk/vXEDMysGgAsuqDgMLyj4rKU1rOSTI+VNDO
         yuEDizLc1Qnc3LLTeKGWqbq9I4exMcOB/gW/8n0NzD+oyQ1LP4TXubSzPr1qgBq2lawo
         nKag==
X-Gm-Message-State: AJIora/U5rdvEBAm6EjxC0yLA0+w0oHsw84vBmabHjbqSPyZp9mUaQds
        j//NzrdrBOQ9Alku0Cbj27a6EA==
X-Google-Smtp-Source: AGRyM1vka6RjReMyIAyXcFVuxqCEEEXnk7tcE9JyWX3Aza/OqWoGpuS3GK/cWr9ft69qR0A9bFPljQ==
X-Received: by 2002:a02:c48e:0:b0:33c:25bb:a1b2 with SMTP id t14-20020a02c48e000000b0033c25bba1b2mr6820280jam.180.1656349219772;
        Mon, 27 Jun 2022 10:00:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f11-20020a02a80b000000b0033c14d2386bsm3090948jaj.75.2022.06.27.10.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 10:00:19 -0700 (PDT)
Subject: Re: [PATCH v4] kselftests/damon: add support for cases where debugfs
 cannot be read
To:     SeongJae Park <sj@kernel.org>, Gautam <gautammenghani201@gmail.com>
Cc:     shuah@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220625200334.83818-1-sj@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7d6b7de6-4609-e6ca-0a88-1f9799c70769@linuxfoundation.org>
Date:   Mon, 27 Jun 2022 11:00:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220625200334.83818-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/25/22 2:03 PM, SeongJae Park wrote:
> Hi Gautam,
> 
> On Sun, 26 Jun 2022 01:22:45 +0530 Gautam <gautammenghani201@gmail.com> wrote:
> 
>> The kernel is in lockdown mode when secureboot is enabled and hence
>> debugfs cannot be used. Add support for this and other general cases
>> where debugfs cannot be read and communicate the same to the user before
>> running tests.
>>
>> Signed-off-by: Gautam <gautammenghani201@gmail.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> 
> Thanks,
> SJ
> 
>> ---
>> Changes in v2:
>> 1. Modify the error message to account for general cases.
>> 2. Change the return code so that the test is skipped.
>>
>> Changes in v3:
>> 1. Change the name of variable holding the error message.
>>
>> Changes in v4:
>> 1. Correct the mode of the source file.
>>
>>   tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
>> index 0189db81550b..0328ac0b5a5e 100644
>> --- a/tools/testing/selftests/damon/_chk_dependency.sh
>> +++ b/tools/testing/selftests/damon/_chk_dependency.sh
>> @@ -26,3 +26,13 @@ do
>>   		exit 1
>>   	fi
>>   done
>> +
>> +permission_error="Operation not permitted"
>> +for f in attrs target_ids monitor_on
>> +do
>> +	status=$( cat "$DBGFS/$f" 2>&1 )
>> +	if [ "${status#*$permission_error}" != "$status" ]; then
>> +		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"

btw - does this run as a regular user or does it need root privilege?
If so add a test for that and skip with a message.
>> +		exit $ksft_skip
>> +	fi
>> +done
>> -- 
>> 2.36.1
>
thanks,
-- Shuah
