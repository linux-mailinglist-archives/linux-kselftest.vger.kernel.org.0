Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9BB2A8975
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 23:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbgKEWB0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 17:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732415AbgKEWBZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 17:01:25 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AAEC0613D2
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Nov 2020 14:01:25 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u62so3389762iod.8
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 14:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PDQek47T74MY22gvmOdioXhtKsJNmf69/vnpKoUvh7A=;
        b=INjz6XiqdG/PWl7SBNlG2Rv95cGqNwfrM8BSUb7v3D2Q129IeP2kPnxspVbCfrZ4Ka
         QcjCdOzDONyjUEEBMhC4F7X8Glybw+ZYbkketsLwmn4X8Fig7/HN+JFvLRdflE3hOKVw
         EKUyqMZIGc71QbDUIiWyWezIDmWCnaL97+m18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PDQek47T74MY22gvmOdioXhtKsJNmf69/vnpKoUvh7A=;
        b=oGTQ0vrDLkaN51xJ/GxpHIY3cO2JJExOQKa3e2YB4W6IDGWiweDHt/gsyer7K3JImJ
         DRYfONGozJ4dlM6tUu7QsxM1bhXIxdN9JW6vLtB3V26rGs+jNhHIGpY1aQGR/apjALEt
         7ixsvVF6B4tCd3PX5+ACqI4LuNwDeAL7TQU6hZCnZrHmKERfmZ02rqpA9WCLXUm66Qr8
         YcaUu8B++GvnBsM8JrRFSxZMJoS+DC0GfPUeDO6M8zzlrO0eEg9x/j81iCwS1oxE94zC
         qqTJq4bFoXvMABP3t4Oseo6EOWxRuNDLV4ojcruBgTwRTJC5s5IXufWYwzNFQ6u37pLo
         m89Q==
X-Gm-Message-State: AOAM533bYQzdaLm6siJdgMSKMurSTTp/Eqe534to9xZc+UxdxRE334/L
        cUUZTylFgmD54mjRYUpGqunOBQ==
X-Google-Smtp-Source: ABdhPJw/vu9s627talg3Gz+uacwEgbLp6+XGm24ojMmme8dDNwLVVtuS64/r4JjRuAbm4vvHBqexuw==
X-Received: by 2002:a02:6a2b:: with SMTP id l43mr3827231jac.87.1604613684967;
        Thu, 05 Nov 2020 14:01:24 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f73sm187745ilh.7.2020.11.05.14.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 14:01:24 -0800 (PST)
Subject: Re: Kunit fixes update for Linux 5.10-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <6b9e77b0-7272-221e-d475-41b266b22496@linuxfoundation.org>
 <CAHk-=wiscEwD+a4M2mns1kf2S+yE6gcPp0sn4znVt0ZUxaP3Wg@mail.gmail.com>
 <CAHk-=whPe8hpnMw9UpXyL2s+tyWX3VaG1yL57_zzwFLjP5pw5A@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a0d87f58-7ef2-1854-ea70-5d355b20ed28@linuxfoundation.org>
Date:   Thu, 5 Nov 2020 15:01:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=whPe8hpnMw9UpXyL2s+tyWX3VaG1yL57_zzwFLjP5pw5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/5/20 1:25 PM, Linus Torvalds wrote:
> On Thu, Nov 5, 2020 at 12:02 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Thu, Nov 5, 2020 at 8:55 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>>    .../kunit/test_data/test_config_printk_time.log    | Bin 1584 -> 1605 bytes
>>>    .../test_data/test_interrupted_tap_output.log      | Bin 1982 -> 2003 bytes
>>>    .../test_data/test_kernel_panic_interrupt.log      | Bin 1321 -> 1342 bytes
>>>    .../kunit/test_data/test_multiple_prefixes.log     | Bin 1832 -> 1861
>>
>> This diffstat is a bit annoying.
> 
> Oh, and another note: because you don't have the "[GIT PULL}" marker
> on the subject line, the pr-tracker-bot doesn't react to the pull
> requests, and you didn't get notified that it's been pulled.
> 
> Just FYI - I personally don't care, as your pull requests do show up
> in _my_ queue, because you have "git" and "pull" in the body of the
> message. But the automation doesn't see them.
> 
Oops. I don't usually miss adding [GIT PULL] - will pay more attention.

I am sorry about that. My bad on my part. Can I chalk it up
to this weird week?

thanks,
-- Shuah


