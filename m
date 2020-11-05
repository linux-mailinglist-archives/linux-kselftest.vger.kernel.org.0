Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32852A89E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 23:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgKEWeY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 17:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEWeY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 17:34:24 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93D8C0613D2
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Nov 2020 14:34:23 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e16so2866226ile.0
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 14:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3rfBBGqUd3cpCM+8AbvtqRCTDWM5yRKCwCQaMviS5/4=;
        b=M874ykKUTT83N9TFM7sfPy+JKh1rfxRCDr9KOe4FyA3uKKvS+aYXtPxmaumOMKLjTy
         n/p4k7ALHcgpp+NmRsH8YDSBXfNGWTt6lYKi5sw+qw66d1pRJiJ+nUCNjSi73tKh50DG
         bQ8n5JZAtXRxF7fHsxnzdgfWoEpXSXOQ7KO+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3rfBBGqUd3cpCM+8AbvtqRCTDWM5yRKCwCQaMviS5/4=;
        b=LZVPQzItWmaeuYmLp5BUJm4yB2VwBUoT0aIKy2fGrtvdg3igM74uCPx8d8mPp57WYp
         EnnWkmmgzO+xTBEi+CoDqJTtezWmpKnw+PVajN/6H6lMMXg1WD6LDU0kHc3Jt5EVtTq/
         eOf4kVfABBAa4cJkSHbtw+wqAyEbO6IXgZxVf+gVNMNTJ2TXiuxKeePEiA6URg58Ojqr
         ZPXaMmKrj/WYfSfmQz+rClbB24h53qtnSzgbzLjCdwcn4sdpaxQIoPIadhenxXAYf3vd
         O3acLJ96OVF33La+NbnCq2wPhM7jz5aGF5MSuS1Ln0jYDnS6gEwB/iifAIVkfcyPo24V
         TEuw==
X-Gm-Message-State: AOAM533Q2HT+YiTD4O+JPwzmIoDijDw1tUpCLBFCfMwyeuxfYqT9OUmN
        kEDiwNK6R40aVtclSaGPSpCCFbsMYTsGHA==
X-Google-Smtp-Source: ABdhPJzShoZItpQGoHq+b5r/u50oBoRVZfFSjV0khamnbun7OYnYCNu3XBH1Ge9ctgjMsihg+++9Gg==
X-Received: by 2002:a92:7a0c:: with SMTP id v12mr3174449ilc.37.1604615662963;
        Thu, 05 Nov 2020 14:34:22 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y3sm1857480ilc.49.2020.11.05.14.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 14:34:22 -0800 (PST)
Subject: Re: Kunit fixes update for Linux 5.10-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <6b9e77b0-7272-221e-d475-41b266b22496@linuxfoundation.org>
 <CAHk-=wiscEwD+a4M2mns1kf2S+yE6gcPp0sn4znVt0ZUxaP3Wg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8fda76e3-4495-571b-6f8b-0b76da511108@linuxfoundation.org>
Date:   Thu, 5 Nov 2020 15:34:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiscEwD+a4M2mns1kf2S+yE6gcPp0sn4znVt0ZUxaP3Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/5/20 1:02 PM, Linus Torvalds wrote:
> On Thu, Nov 5, 2020 at 8:55 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>>    .../kunit/test_data/test_config_printk_time.log    | Bin 1584 -> 1605 bytes
>>    .../test_data/test_interrupted_tap_output.log      | Bin 1982 -> 2003 bytes
>>    .../test_data/test_kernel_panic_interrupt.log      | Bin 1321 -> 1342 bytes
>>    .../kunit/test_data/test_multiple_prefixes.log     | Bin 1832 -> 1861
> 
> This diffstat is a bit annoying.
> 
> And the reason is that we have
> 
>      [torvalds@ryzen linux]$ cat tools/testing/kunit/.gitattributes
>      test_data/* binary
> 
> iow, you're telling git that everything in that test_data directory is
> binary blobs. Which isn't actually true.
> 
> This isn't new, but it was just more noticeable this time around.
> 
> That binary marker comes from commit afc63da64f1e ("kunit:
> kunit_parser: make parser more robust") and I'm not really seeing the
> reason for it.
> 

You are right. It appears there is no need to add these binary blobs.
Brendan and I discussed this and he will send a fix to remove the blobs
and redo the test output. In other words fix commit afc63da64f1e.

Sorry for not catching this earlier.

thanks,
-- Shuah

