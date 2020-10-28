Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBB729E086
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 02:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgJ1WEy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 18:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbgJ1WCA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:02:00 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9DCC0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:02:00 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id o70so493591ybc.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kBQEJAcsNoDypblzItIVRGC5xJLK4RkxOtKNMPRA5Z8=;
        b=M4LUqheCRVN4aDlx34+QxY/4pY3jpcrJREx0gbY0u9MfglfuhcSTufiKC6drQol5GY
         RjFX3yP1cSgS+W3lGG4ggcRHlYoTEIuUgNow6adQ6cHP6YMEjWoGOP8Lj/sV/7uB5fxy
         hViG/0s2Oer/cQ5vkGhBNAv6FTV3qzFqPFWbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kBQEJAcsNoDypblzItIVRGC5xJLK4RkxOtKNMPRA5Z8=;
        b=KtQcsRINSu6sPeyQMfp6Dx6CgLXAa1rXZeSHFqclTF2vj42+X7/58okun/H72+SXh/
         ABpLv0wsihOkOW5XvUcSlQ+LMaOnzLF7KyVDp8zMKUden0MUDbi+7spzBO0cU/JkXeNR
         AWZN5lFc/fuRqVxcL+NBINRmBJ47524Mf1XTj3tnsnH87tetSAHrLal/LJGmyQVUVtsh
         alT+nuEGejVTbChmb3hK4GDWRfrGf8XF+qNZcshOoP6R+nIb2J5n4lLekpMuFMI2d544
         w7tHjJ5P8rqTfXKvJNoAW9PMNZFxwR0mvsuM/v9V29JDQtp9lmVg6LW3MAeyQ3fUCClD
         oDSg==
X-Gm-Message-State: AOAM533oIqqdgsTRnkX0rJo1fxTTkfoC/ZXs/kIW9dDykZWbec7x/AtG
        YXeezqj6IFLAy/YCKgRq1ws8ZZfYQYAUBg==
X-Google-Smtp-Source: ABdhPJxjTy3T36nWQmk8c0DFM/H14BocDfoMWVqNtagjPo1S/SOliv1XFcYQLMM5E1xEglS9gQWtRQ==
X-Received: by 2002:a05:6830:400d:: with SMTP id h13mr5615792ots.371.1603897570814;
        Wed, 28 Oct 2020 08:06:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 19sm2498132oin.54.2020.10.28.08.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 08:06:10 -0700 (PDT)
Subject: Re: [PATCH] selftests: intel_pstate: ftime() is deprecated
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201016132245.73378-1-tommi.t.rantala@nokia.com>
 <d315994a-3398-be41-1b26-e78f8359aa5c@linuxfoundation.org>
 <d4adb97b3325ac93295d5e42dc07e8381fb9efab.camel@nokia.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <459bc6a0-8046-e223-f88e-10e643a36dd7@linuxfoundation.org>
Date:   Wed, 28 Oct 2020 09:06:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d4adb97b3325ac93295d5e42dc07e8381fb9efab.camel@nokia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/28/20 1:36 AM, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> On Tue, 2020-10-27 at 14:08 -0600, Shuah Khan wrote:
>>
>>> @@ -73,8 +80,8 @@ int main(int argc, char **argv) {
>>>    	aperf = new_aperf-old_aperf;
>>>    	mperf = new_mperf-old_mperf;
>>>    
>>> -	start = before.time*1000 + before.millitm;
>>> -	finish = after.time*1000 + after.millitm;
>>> +	start = before.tv_sec*1000 + before.tv_nsec/1000000L;
>>> +	finish = after.tv_sec*1000 + after.tv_nsec/1000000L;
>>
>> Why not use timespec dNSEC_PER_MSEC define from  include/vdso/time64.h?
> 
> Hi,
> 
> If the define was available in the UAPI headers, then certainly would make
> sense to use it. But I would not mess with the kernel internal headers here.

Suggested the wrong file while looking up the define. I was thinking
linux/time64.h

However it isn't part of headers_install, so can't use that one.

Considering the number of places NSEC_PER_MSEC is hard coded
and defined in headers e.g: tools/include/linux/time64.h, probably
should be included in timespec block in time.h

Not something to worry about for this patch. Please add a NSEC_PER_MSEC
define for now in this file.

thanks,
-- Shuah






