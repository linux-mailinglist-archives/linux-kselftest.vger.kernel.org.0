Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B68533422C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 16:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhCJPyq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 10:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhCJPyl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 10:54:41 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F27C061761
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 07:54:40 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id k2so15991050ili.4
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 07:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vnS5jA9i9gI46BON0h6ZM9jTU/INdZkZOvAGVlfFP1Y=;
        b=Jp4I/nkPkxDYWV5jKsar83puIuxuP6Y9g9Ld2s/WRcvIxjs5sBWM5Gchz1UszMTBY7
         TrUV6Juy0G4VzQg9XAvkmF1pcLA9wsONObmXZ0oEmJSvwkiqwwAtqsvt4mw6euWfnmKz
         V9suro+K3Q2x0dtfLguCnaHrnZVv2ZObLzPRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vnS5jA9i9gI46BON0h6ZM9jTU/INdZkZOvAGVlfFP1Y=;
        b=SC/88KA0LDBL+pqC8nm+tRs8W98YHGUdUyPihKRfr+RsbEzMZsmfjrsQkk4E24l8BY
         YSA5Jhmd+th3oMuNQfqQXwWBPWX2DUrBAf1n37YKHEWLSCY3qfJAfbbgL3HNb1Ns+dsB
         VjPNGXADrFlmsMxX76Be+c7Jsz2fXU0TOPqoepgesvkG46kTWGix+nudkWcKnoAj5KuH
         kmCTFMsA3mBYT0F75ubebtcTDCLanABETV9JgsCP3y1CwOIFXr/OzMdu0jYAiODJk7LS
         vrNNjd4yD4xfPT+FPtWZ4gKi253/+eM43lxTyw1DdTcnIZ0QfnRf7LXFuSJHzxYmIqVo
         zIAg==
X-Gm-Message-State: AOAM533jK12qSz/IBehO2H+ZTsxpO7q6BMls4dP+z8B1x1339C+gGCvJ
        rAcwH7FqYwEfUNcop0yno9/Yqw==
X-Google-Smtp-Source: ABdhPJxJZsz0h0G4355L1Dg2Hq03AooUnFtRGqf3RAbfFos4CUc0HiAowIZidO7He/MR9FNBQVQCUg==
X-Received: by 2002:a05:6e02:1d0b:: with SMTP id i11mr2959233ila.206.1615391680364;
        Wed, 10 Mar 2021 07:54:40 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m4sm9511481ilc.53.2021.03.10.07.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 07:54:39 -0800 (PST)
Subject: Re: [PATCH v2] kunit: fix checkpatch warning
To:     Lucas Stankus <lucas.p.stankus@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210303020350.4sahuojkqnkcxquf@smtp.gmail.com>
 <CAFd5g47rjt7i7JXWsYarqX_dShHiqSg8StKb7KCqOye3=eyZDg@mail.gmail.com>
 <20210304043554.jysk6qms4h4hue4i@smtp.gmail.com>
 <d9f1007a-8de4-45e4-b662-846054d50390@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4cef7239-1fef-951a-6b99-07c8c973c091@linuxfoundation.org>
Date:   Wed, 10 Mar 2021 08:54:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d9f1007a-8de4-45e4-b662-846054d50390@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/4/21 4:12 PM, Shuah Khan wrote:
> On 3/3/21 9:35 PM, Lucas Stankus wrote:
>> On Wed, Mar 03, 2021 at 12:56:05PM -0800, Brendan Higgins wrote:
>>> Did you change anything other than fixing the Signed-off-by that Shuah
>>> requested?
>>
>> No, I only fixed the Signed-off-by warning.
>>
>>> Generally when you make a small change after receiving a Reviewed-by
>>> (especially one so small as here), you are supposed to include the
>>> Reviewed-by with the other git commit message footers directly below
>>> the "Signed-off-by". Please remember to do so in the future.
>>>
>>> Also, when you make a change to a patch and send out a subsequent
>>> revision, it is best practice to make note explaining the changes you
>>> made since the last revision in the "comment section" [1] of the
>>> git-diff, right after the three dashes and before the change log as
>>> you can see in this example [2] (note that everything after
>>> "Signed-off-by: David Gow <davidgow@google.com>\n ---" and before
>>> "tools/testing/kunit/configs/broken_on_uml.config | 2 ++" is discarded
>>> by git am).
>>
>> Sorry for the incovenience regarding best practices, I'll keep that
>> noted for further contributions.
>>
> 

Sorry I should have asked you about this. I like to see what is being
fixed in the subject line.

Can you update the subject line. The current one doesn't say anything
about the nature of the fix.

Also please run the checkpatch script on your patches. This tool useful
and can offer you tips on improving your commit log as well as code.

thanks,
-- Shuah
