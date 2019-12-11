Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEB311B410
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2019 16:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbfLKPpu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 10:45:50 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:41153 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388658AbfLKPps (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 10:45:48 -0500
Received: by mail-il1-f196.google.com with SMTP id z90so19821512ilc.8
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2019 07:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wanFKaczLMfU3OqUb1JjxMoDgH35GgWk6HMwR/6djLs=;
        b=Hboi8tbgl13q5vXUiMA/tDWO1s3G8Dq3gtiHOGlv4UapdWcbWC0azlmd5VpIMEZ7a0
         dX02VAzyiD35CB4N0/L4fDo8Tx1jojLrV1nn8pm77iKJlTBN/YVNVVftSJnOnC2ViMVT
         OKFJ6dmmynQpt5Nvf2dkTutchpxyv7w0cPr+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wanFKaczLMfU3OqUb1JjxMoDgH35GgWk6HMwR/6djLs=;
        b=DRK7hn1e9B1wv10sLQenXHCVOGPiQrub4zciKjL96e4mPfj+OnyAltZ0RFFdLEORtR
         mIYc0ta6JPCuZdm/nTDPjaQSnU96Ui/RUtwNPq+4s0jV+/f0V4G1+LCnlbVBSr/8AR3T
         APNiMWaFFYyVjWlALTzTD+IEp8HqUYVtIU/nQe0Pj+cx/JnQd3dKJ6SraAXLCSm1dyaB
         +CvCmGr9A24KO2k6uCya8mPuQ1WqmFC169od0GeeIEVXBA/srXBtcdPRXmvxFmF2c3wg
         2AraYNxN0l7o0DxqV93hpqaPCmES0NPqB55RG+8DLbKAIaQqqOGo4IiNfp5WqwDuM75V
         +qDQ==
X-Gm-Message-State: APjAAAVt74qSRt1J8rCjzlI+QeZ43g9IesVO121uiIEyTTBeCw8Nzdne
        1+6Uf5O4yqAPthUGT+dg2YS7wg==
X-Google-Smtp-Source: APXvYqwWxzDOaxYOxAqGjbjnSVqOCnFFvbbl+B7Ipdp0CLZzaOiNlZCqCL98ytaVistSY/tSdVlAGQ==
X-Received: by 2002:a92:3591:: with SMTP id c17mr3771724ilf.264.1576079147826;
        Wed, 11 Dec 2019 07:45:47 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x25sm586120iob.76.2019.12.11.07.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 07:45:47 -0800 (PST)
Subject: Re: Linux 5.5=rc1 kselftest rseq test build failure
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <2d53b409-31e0-2245-e163-1ab26f52c841@linuxfoundation.org>
 <1871753014.2121.1576077544796.JavaMail.zimbra@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c6b703ef-8481-23bc-0b4c-dfb8d48da74f@linuxfoundation.org>
Date:   Wed, 11 Dec 2019 08:45:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1871753014.2121.1576077544796.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/11/19 8:19 AM, Mathieu Desnoyers wrote:
> ----- On Dec 10, 2019, at 7:27 PM, Shuah Khan skhan@linuxfoundation.org wrote:
> 
>> Hi Mathieu,
>>
>> I am seeing rseq test build failure on Linux 5.5-rc1.
>>
>> gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./
>> param_test.c -lpthread -lrseq -o ...tools/testing/selftests/rseq/param_test
>> param_test.c:18:21: error: static declaration of ‘gettid’ follows
>> non-static declaration
>>     18 | static inline pid_t gettid(void)
>>        |                     ^~~~~~
>> In file included from /usr/include/unistd.h:1170,
>>                   from param_test.c:11:
>> /usr/include/x86_64-linux-gnu/bits/unistd_ext.h:34:16: note: previous
>> declaration of ‘gettid’ was here
>>     34 | extern __pid_t gettid (void) __THROW;
>>        |                ^~~~~~
>> make: *** [Makefile:28: ...tools/testing/selftests/rseq/param_test] Error 1
>>
>>
>> The following obvious change fixes it. However, there could be reason
>> why this was defined here. If you think this is the right fix, I can
>> send the patch. I started seeing this with gcc version 9.2.1 20191008
> 
> This issue is caused by introduction of "gettid()" in glibc 2.30. I don't
> think we want to introduce a build dependency on glibc 2.30 for kernel
> selftests. Removing the gettid() symbol as you propose here will break
> build environments with glibc < 2.30.
> 
> We could eventually try to figure out whether the glibc headers implement
> gettid() at build time (not sure how), or we could simply rename our own
> "gettid()" to "rseq_gettid()", thus removing the namespace clash with
> glibc.
> 
> I can propose a patch renaming gettid() to rseq_gettid() is that approach
> is OK with you.
> 

Looks like you already have a patch to do this. I see it in my Inbox.
I could take that.

thanks,
-- Shuah
