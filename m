Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7218467C2A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 18:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbhLCRGq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 12:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhLCRGq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 12:06:46 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C77C061353
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 09:03:22 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i6so3411728ila.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Dec 2021 09:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cwxHCbenFCripjeUjs6tCpolH4DmLSPfSlC/W5NUvwU=;
        b=UnNTzVNfryaWbpSuR2ZXK+nlsa2MZJTa4qw0dhixOeol5VA8qCTVeaBL85KrdIkL2M
         Twn1uyUZc5mZ2z0osmLwcC8yI6DdCR2LM1V3n6rLOK9EK/g58rCAYcvnTYgsFgS1s+gW
         FkN7AC9w7HL1CzaP2wTyZdFSEU3Qp7dpU12f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cwxHCbenFCripjeUjs6tCpolH4DmLSPfSlC/W5NUvwU=;
        b=3CDAl5c9VJe5JSlMHJFzF0u+clQkbcUB/IdZ9AfWs3rPnHvgq66SMozTEaw1c3dyEB
         JdsHL58J9i/pMgUlFrxdydH/3Tzxv2undFzvzUB2O1pBPo43MmSNl/8O9/OfVcCcbjZb
         rrwrCfP2yyyHkPgiB88M68BbRi0ZWxIv91d0Qr8tHGLRfJAvi9hVEbsVflK6uVyMznV7
         ZScKbNK4KcSjuunPRuAmeP4ouHdkSf6h/aQFuhQVBfjBlBPp8u1eiVnx7YUgwHw7awg6
         SalG6bdqfnYJaXpAd4JJ+ap4Co+IeOXYRXbjz1JoDLfIft/EWrrFV2w/3Qg5cupe4soL
         eSvw==
X-Gm-Message-State: AOAM532/uBlxmd1EMxVYBmj9XWCM3Xs1St8whLeX5ytyahEf45eCjI1r
        qAAuavcqC9tM1rrz8wmEvRe95g==
X-Google-Smtp-Source: ABdhPJyZpS6sg5hnDg8ut0BnNoPlbIah10gQ/bDD44Dxcz9yDYWQ02+U2Hjt9Wnr7/U6Hb7nYednLA==
X-Received: by 2002:a92:c244:: with SMTP id k4mr18431483ilo.169.1638551001558;
        Fri, 03 Dec 2021 09:03:21 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a25sm1811479ioa.24.2021.12.03.09.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 09:03:21 -0800 (PST)
Subject: Re: [PATCH 2/2] ksefltest: pidfd: Fix wait_states: Test terminated by
 timeout
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211029024528.8086-1-lizhijian@cn.fujitsu.com>
 <20211029024528.8086-2-lizhijian@cn.fujitsu.com>
 <20211029083248.7vttuxbwbtdylrnq@wittgenstein>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e5567974-42ba-0864-4340-c435db6ad0c1@linuxfoundation.org>
Date:   Fri, 3 Dec 2021 10:03:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211029083248.7vttuxbwbtdylrnq@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/29/21 2:32 AM, Christian Brauner wrote:
> On Fri, Oct 29, 2021 at 10:45:28AM +0800, Li Zhijian wrote:
>> 0Day/LKP observed that the kselftest blocks foever since one of the
>> pidfd_wait doesn't terminate in 1 of 30 runs. After digging into
>> the source, we found that it blocks at:
>> ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);
>>
>> we can reproduce it by:
>> $ while true; do make run_tests -C pidfd; done
>>
>> a delay to ensure that the parent can see child process WCONTINUED.
>>
>> CC: Christian Brauner <christian@brauner.io>
>> CC: Shuah Khan <shuah@kernel.org>
>> CC: Philip Li <philip.li@intel.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> ---
> 
> Not a fan of the usleep() solution but if it fixes it it's fine for
> a test, I think.
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 

I don't like introducing usleep() which will increase the kselftest
run-time. Every little bit adds up if we allow usleep() in tests.

thanks,
-- Shuah
