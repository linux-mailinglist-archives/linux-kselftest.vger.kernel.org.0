Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B524A5030
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jan 2022 21:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiAaUe0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 15:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378880AbiAaUeV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 15:34:21 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77E4C06173D
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 12:34:21 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q204so18517028iod.8
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 12:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SqlLCj31diSETKI5A6zt06jP40coWDSpw6yL95StcfA=;
        b=P30SRyq13MwhIF8XlMuefEe3P67inPXs0nFpbmH/icwIOAQ0aDndG0JIgDdNbCK5yb
         0V0iJ6UXoheW8yHtizJ4zFSQAZod/4FTR++npNCWfVzwTVyKX94w8fI2cC3CRX10joOC
         g4b/gA0SS3wezzev5ypNpF5FpkBkZknJd/plA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SqlLCj31diSETKI5A6zt06jP40coWDSpw6yL95StcfA=;
        b=k1KbQ5p24d9HBqxukGPa6Na6SoYwVtHXnjAUqAgbCjQWQxiM7ys5flNyULkvheQjzV
         NVxlg25uKQRqNNE8Wcwgm8Zf4UynZWM9lKEhQSmsDyEGovSQlwkWoQyzg2sjNjKPho/w
         pwdFSBlAUcrNnZvK3vw4+sQO33HefPztJNfXhL6Po4XKx24Q7+U2qx1/FAdBy5UpUTVg
         g/1eKWEoCQNb35rmFwU1wZyVzRUioTQ1T7nXAj7CLtMjpWCl3QbrYu4PcXEuzfdB1G37
         yrenwD4G2AcJWiJ47JAAZGW9e1eRjpRbngNtEYtOKEmaBDZCVXOybtTSfqFaDtwpPDfz
         jaWw==
X-Gm-Message-State: AOAM5308X1zEV7OKV/pXkvwKUKvIAs2zrgfOwx4Gg52O3Nhv4KAPC7Cd
        EBUISsWvlB2UiUDSbx1XBRg0Mg==
X-Google-Smtp-Source: ABdhPJzRDSD7BH07yxHZSXU3zHUyotopYZ3oCSl7gkGQdNx+PzavyxNrRF3r2fdm3XO4znlZgqW53Q==
X-Received: by 2002:a05:6602:2e90:: with SMTP id m16mr12378473iow.74.1643661261246;
        Mon, 31 Jan 2022 12:34:21 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b5sm18324029iln.54.2022.01.31.12.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 12:34:21 -0800 (PST)
Subject: Re: [PATCH] docs/kselftest: clarify running mainline tests on stables
To:     Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126201341.55771-1-skhan@linuxfoundation.org>
 <7ba5e99a-9169-75c4-2324-f9a3ce9a506e@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bb1ba6f5-4cd8-742c-62b7-a62a6f4cef91@linuxfoundation.org>
Date:   Mon, 31 Jan 2022 13:34:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7ba5e99a-9169-75c4-2324-f9a3ce9a506e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

On 1/31/22 12:37 PM, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 1/26/2022 12:13 PM, Shuah Khan wrote:
>> Update the document to clarifiy support for running mainline
>> kselftest on stable releases and the reasons for not removing
>> test code that can test older kernels.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   Documentation/dev-tools/kselftest.rst | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
>> index dcefee707ccd..a833ecf12fbc 100644
>> --- a/Documentation/dev-tools/kselftest.rst
>> +++ b/Documentation/dev-tools/kselftest.rst
>> @@ -7,6 +7,14 @@ directory. These are intended to be small tests to exercise individual code
>>   paths in the kernel. Tests are intended to be run after building, installing
>>   and booting a kernel.
>>   
>> +Kselftest from mainline can be run on older stable kernels. Running tests
>> +from mainline offers the best coverage. Several test rings run mainline
>> +kselftest suite on stable releases. The reason is that when a new test
>> +gets added to test existing code to regression test a bug, we should be
>> +able to run that test on an older kernel. Hence, it is important to keep
>> +code that can still test an older kernel and make sure it skips the test
>> +gracefully on newer releases.
>> +
>>   You can find additional information on Kselftest framework, how to
>>   write new tests using the framework on Kselftest wiki:
>>   
> 
> (My apologies if this is already documented, I was not able to find this guidance
> in Documentation/dev-tools/kselftest.rst nor when looking at the
> "Kselftest use-cases..." slides linked from https://kselftest.wiki.kernel.org/)
> 
> Could you please clarify what the requirement/expectation is regarding fixes
> to tests? Since the recommendation in the above change is that Kselftest from
> mainline should be run on older stable kernels, is it required to backport
> fixes to the tests themselves to stable kernels?
> 

Couple of things to consider.

- A new test gets added to regression test a bug in stable and mainline
- A new test gets added to test a kernel module/feature/API that has been
   supported by stable and mainline releases

In both of these cases, running mainline kselftest on stables gives you the
best coverage.

Kselftest fixes get pulled into stables like any other kernel fixes. If a few
fixes are missing, it is a good idea to back-port if they fall into above two
categories. If the test is for a new feature then, it doesn't make sense to
back-port.

Hope this is helpful.

thanks,
-- Shuah


