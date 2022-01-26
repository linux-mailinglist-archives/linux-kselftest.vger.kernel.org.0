Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2211F49D1DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 19:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiAZShY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 13:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiAZShX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 13:37:23 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8826BC06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 10:37:23 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id s18so634438ioa.12
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 10:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TR6UGBsD6mZqSpy2OctJC0zY4UM/MRElTKB7h5irR9k=;
        b=e92ituru0/YRtRP0mrQjeZXgaq1Lsye1MNE2Wy6UZs/QPU/ZO53qD9Zo374/WcdHU9
         d4/rmHBAgTo/+pfGico+jxFEwgNxJGTXUkGkS8Fus0OAIiVdskj/JfrpaxhuS2DpVQhS
         DiiPVZrLMwwdRgGO0lztBkHKdQSqSA1knX+D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TR6UGBsD6mZqSpy2OctJC0zY4UM/MRElTKB7h5irR9k=;
        b=DxbOqSnjNqW6dOuhwFz1+I79XYR8vAnjyEcwqhJttSdNFqEsu7p54hYU3ICCLF6buv
         fVg9JqKsCpDqJR1izd91WBhtsvYfBtWIqXr0LlNS6MPOLQS1EKLF9ifUHcLbxwJvkc7x
         SxEL83UwJbWsqlZBeazoy82yb2TnwqhsiNtelkiDMLqdjCcwHDFrbSWKT0k6uCjEDvbZ
         aHe9hkcIQ8nGM9OVVQynYlpPOJTmX9xmAAK3kz0YZuZw8wAVqiKiZFNCYyhx7qMxFc+x
         lF+Li517GUgrSpiIwwG9+joxDhmDS6TD2qKb1wxZ81tLdm2RHOpeBegVDml1l/uqScgG
         ickg==
X-Gm-Message-State: AOAM533+sa6hwWha/RD0MSsjk4CjQS6xc3YlqnM4IovOgxeRQm8EEBBo
        HqL6/3cYhYU01LgIt5a/MFeZFQ==
X-Google-Smtp-Source: ABdhPJwmnJbruWZjQGV10qzT5AZHzBBPFqlhooBLiMGSnM8yC/ySZqz7Sw7iaJSJal/XANPtnRcRfA==
X-Received: by 2002:a05:6602:2c0d:: with SMTP id w13mr14373413iov.158.1643222242361;
        Wed, 26 Jan 2022 10:37:22 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:f2e:a7f7:d853:1e3? ([2601:282:8200:4c:f2e:a7f7:d853:1e3])
        by smtp.gmail.com with ESMTPSA id a10sm12034794ilv.44.2022.01.26.10.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 10:37:22 -0800 (PST)
Subject: Re: [PATCH 1/3] selftests/zram: Remove obsolete max_comp_streams
 interface
To:     Petr Vorel <pvorel@suse.cz>
Cc:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        "aleksei.kodanev@bell-sw.com" <aleksei.kodanev@bell-sw.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1146337d-718e-a369-1012-224f06bc9c2f@linuxfoundation.org>
 <61F0D9F7.1080200@fujitsu.com> <YfD0hiUSf40jX82d@pevik>
 <590c1f1c-2da1-583a-d055-83c15969cf80@linuxfoundation.org>
 <YfGR9xZ2EuMXyAzb@pevik>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e495f173-4e4d-8233-b7a7-2d0707f28df0@linuxfoundation.org>
Date:   Wed, 26 Jan 2022 11:37:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YfGR9xZ2EuMXyAzb@pevik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/26/22 11:24 AM, Petr Vorel wrote:
>> On 1/26/22 12:13 AM, Petr Vorel wrote:
>>> Hi all,
> 
>>>> on 2022/1/26 4:33, Shuah Khan wrote :
>>>>> On 12/15/21 2:56 AM, Yang Xu wrote:
>>>>>> Since kernel commit 43209ea2d17a ("zram: remove max_comp_streams
>>>>>> internals"), zram has
>>>>>> switched to per-cpu streams. Even kernel still keep this interface for
>>>>>> some reasons, but
>>>>>> writing to max_comp_stream doesn't take any effect. So remove it.
> 
>>>>> I get that max_comp_stream doesn't do anything since this referenced
>>>>> commit. Don't we need this test on older kernels since older kernels
>>>>> still support max_comp_stream?
> 
>>>> I read the following info from kernel selftest documentation
>>>> https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
> 
>>>> "The kernel contains a set of “self tests” under the
>>>> tools/testing/selftests/ directory. These are intended to be small tests
>>>> to exercise individual code paths in the kernel. Tests are intended to
>>>> be run after building, installing and booting a kernel."
> 
>>>> So, we can build older kernel(use older kernel source) if we want to
>>>> test older kernel.
> 
>>>> IMO, kernel selftest is different from other testsuit(ie ltp, this
>>>> shuould think about api changes because ltp may test on different kernel).
>>> Yes, that's how I understand the difference with approach of in kselftest - the
>>> kernel tree testsuite and LTP - the out-of-tree testsuite.
> 
> 
>> Removing max_comp_stream test appears to be motivated by the fact it isn't
>> needed on newer kernels.
> 
>> Kselftest from mainline can be run on older stable kernels. This is a use-case
>> for a lot test rings. The idea is that when a new test gets added for older
>> code to regression test a bug, we should be able to run that test on an older
>> kernel. This is the reason why we don't remove code that can still test an older
>> kernel and make sure it skips gracefully.
> 
> Thanks for clarifying this approach. It might be worth of documenting it in
> dev-tools/kselftest.rst.
> 

I will send out a patch clarifying this.

thanks,
-- Shuah
