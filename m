Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C05470C44
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 22:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhLJVPR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 16:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbhLJVPR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 16:15:17 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC465C061746
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 13:11:41 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id t23so14961193oiw.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 13:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ddPQVV/tTQRudtCz1wmnWQGVTL4NkdF6U5BGESIoZIk=;
        b=K612s3Fuy5BAuqxT0vTsPBxg1trDU5wWijgKK96ec/bgtR04y7ecuOlsMuEghseFS+
         pNtAQMrg4srdkdxkco1ivxHIMZMD2QBOn38kdMVJJehKKNWvuhsnBXvYQzQDc+81wCtC
         HJmaLOZu1uR46HiFcqALN/70qd3gyZ+e9kMUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ddPQVV/tTQRudtCz1wmnWQGVTL4NkdF6U5BGESIoZIk=;
        b=O3n6BuyQhYUFzwW8qUyZukKXNDR20c3SqzRApJFxFPuRwr56c4lfasFVV5zkdbi3YY
         TcOQjzDu943mHPK8Hlp1h5dPE9rGUJT6B2O9kHrkhJmIpVx/EJGCyWYHOCkRymyMuLMn
         O9nvW4sju+A3Psb+pS7pr5S9bv6pVT0WDWa46Hv+MccTuSeuUyJl6jiJ2MFHE4vOtGpp
         PEcoMYbCIVeGS2bOPNatRqhmtSdtGUCb3w2JK37o+t8poTD9IytCfklJMPXhaVPiMoST
         8TDPyyX4POTkwoCC5GDb5VlyzEODcGJLetaICyZbDoF4rsTaBZDd+9WtdHLlZM5Rc2p8
         410w==
X-Gm-Message-State: AOAM530RWcHuH6kB+ROxcDqK2iFqMYNzhy8h+YtG1fvAbZ3xngf+C7nc
        2Abo3jI3f1G61rpxTxvWngu1sQ==
X-Google-Smtp-Source: ABdhPJyEtgLvk39lK6eB2KFY6omQ+KE/YL4n+zHawDHNL6h0rcXBzDJyAxY+VbrCCsBPr22P0QZYng==
X-Received: by 2002:aca:1708:: with SMTP id j8mr14346312oii.62.1639170701316;
        Fri, 10 Dec 2021 13:11:41 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm702658ote.41.2021.12.10.13.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 13:11:41 -0800 (PST)
Subject: Re: [RFC PATCH v2] Documentation: dev-tools: Add KTAP specification
To:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, Tim.Bird@sony.com,
        shuah@kernel.org, rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211207190251.18426-1-davidgow@google.com>
 <202112071358.E8E6812D@keescook>
 <8c06e715-a83e-e8c6-74c3-836831b85cdf@linuxfoundation.org>
 <87mtl8qifu.fsf@meer.lwn.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <41323fe3-3f73-4681-7d75-2301f9982a25@linuxfoundation.org>
Date:   Fri, 10 Dec 2021 14:11:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87mtl8qifu.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/10/21 2:05 PM, Jonathan Corbet wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> 
>> On 12/7/21 3:02 PM, Kees Cook wrote:
>>> On Tue, Dec 07, 2021 at 11:02:51AM -0800, David Gow wrote:
>>>> From: Rae Moar <rmoar@google.com>
>>>>
>>>> It does not make any significant additions or changes other than those
>>>> already in use in the kernel: additional features can be added as they
>>>> become necessary and used.
>>>>
>>>> [1]: https://testanything.org/tap-version-13-specification.html
>>>>
>>>> Signed-off-by: Rae Moar <rmoar@google.com>
>>>> Co-developed-by: David Gow <davidgow@google.com>
>>>> Signed-off-by: David Gow <davidgow@google.com>
>>>
>>> I like it! Thank you so much for suffering through my earlier reviews.
>>> :)
>>>
>>> The only concern I have is wonder what'll be needed to kselftest to
>>> deal with indentation changes. As long as this can be implemented
>>> without a subtest knowing it is a subtest, we're good.
>>>
>>
>> A lot of this TAP output is in the wrappers - hopefully it will be okay.
>> Fingers crossed. :)
>>
>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>
>>
>> Looks good to me as well. Thanks for doing this work.
>>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Would you like me to take this through the docs tree, or do you have
> other plans for merging?
> 

Please take this through docs.

thanks,
-- Shuah

