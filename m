Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C1ABD343
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2019 22:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409794AbfIXUFY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Sep 2019 16:05:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35416 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfIXUFX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Sep 2019 16:05:23 -0400
Received: by mail-io1-f68.google.com with SMTP id q10so7629962iop.2
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2019 13:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tzqNMqA07jBcBpcqIcid0j0G7N4xLkFUhmGjg7IIOuU=;
        b=DCyKK193tOOwAbtGLptlJdOOKYY/0pAfa4quNNXrWUvG3TJ7wXw/pThGwGpG+9QiwN
         FazKM7SpbmIueD8YLUzNgzzgixAWUC4leRTPUG/z7IwX9zqjQydBTyOUnRi/xqLq7O0X
         vwnBLD/ePKlVhAXYcazuiJhoHAT+eKbgJPEi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tzqNMqA07jBcBpcqIcid0j0G7N4xLkFUhmGjg7IIOuU=;
        b=c5yYxOVTBE3ylOweNzoRlwzy1JRfPQzmUa4v+jUVsX2s2KAPZMWlcvy+4hu1miC/0e
         g/ufhLmTRueqhCSuOVz8ChB5gurs88wGwgEQn8cuEiT1JEIhbAo6iS2iOVJULW85tr2F
         FXMjsYw8AsFDigOlfqUVQ3RtZ5qOfquF/wv5n7BPB9gi9MXsKbvhN9TQ/Z4SiBLbeI6K
         I9ktJH1vRPE+9a4Sp09Is73bXRdDIYgOSIaRhZDwzln3UdiWQgbrK0CkjWYS+oxN06jA
         71Q6tJaZeirSzd+Ny2fkHlx7bVOXsYiwHghWJFX9Gh5bQHVgYGce+evX21KzdBbKjbqu
         3VAQ==
X-Gm-Message-State: APjAAAX5BfcvDBWNhV4QXunK6CgsAlTqySk4HL9tgmNqR2newqmOeqOA
        mbQsh8Na5f5Zvnk2RqVRYdb6nQ==
X-Google-Smtp-Source: APXvYqxALuZ+2sOPVcl1PCpmgHoIsSghK1bXD0k9qNItmHh8nea4aKSF+aMNcivHLWvltHMCZ47cgQ==
X-Received: by 2002:a5d:89da:: with SMTP id a26mr4311422iot.61.1569355520865;
        Tue, 24 Sep 2019 13:05:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k66sm4656319iof.25.2019.09.24.13.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 13:05:20 -0700 (PDT)
Subject: Re: [PATCH] selftests: proc: Fix _GNU_SOURCE redefined build warns
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     shuah@kernel.org, akpm@linux-foundation.org,
        sabyasachi.linux@gmail.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20190924181910.23588-1-skhan@linuxfoundation.org>
 <20190924181910.23588-2-skhan@linuxfoundation.org>
 <20190924195253.GA2633@avx2>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f6c20b9b-4984-f865-3698-70b61bcd4be0@linuxfoundation.org>
Date:   Tue, 24 Sep 2019 14:05:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924195253.GA2633@avx2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/24/19 1:52 PM, Alexey Dobriyan wrote:
> On Tue, Sep 24, 2019 at 12:19:10PM -0600, Shuah Khan wrote:
>> Fix the following _GNU_SOURCE redefined build warns:
>>
>> proc-loadavg-001.c:17: warning: "_GNU_SOURCE" redefined
>> proc-self-syscall.c:16: warning: "_GNU_SOURCE" redefined
>> proc-uptime-002.c:18: warning: "_GNU_SOURCE" redefined
> 
>> +#ifndef _GNU_SOURCE
>>   #define _GNU_SOURCE
>> +#endif
> 
> Why are you doing this.
> 
> There are 140 redefinitions of _GNU_SOURCE
> 


Is there something wrong with getting rid of this warning?

thanks,
-- Shuah
