Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A074774DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 15:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbhLPOmf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 09:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbhLPOmf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 09:42:35 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B211C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 06:42:35 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 14so35291583ioe.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 06:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=90t3NH6y3rHFem3c05354TVkhqLDF/TSYMRbi9fk4K0=;
        b=DrebHczD6kxSqJFBYodZSklsRzBgT5lHDYXVWZ0RsVZxfJgn2SZWC4f4dyH/6YiVCM
         5FjeK1lqOWkSa6wfHdzLh8zeizJWsc+x50mNvaWh0hNYpKvUZ9OZ09Do+tpMlTGyilD5
         qNc72AgtlcBS029yZ6rY9FWnFX6pHWs0PeEw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=90t3NH6y3rHFem3c05354TVkhqLDF/TSYMRbi9fk4K0=;
        b=KnQx1jEQ46gA+eV6FKSOqtWknem7agtxGamEEANlj48SVpymbhyMMF+vAHPaIvoW5M
         nN/JtBEYRRcineWbE+aKmopo7xMhQAQOdOSfyc1uPJyTh5Gp4xafVBAK+9cxukBtvPQK
         4TQjkc6vkG8oWFVU+DUYFWp3nQc+ovudPS2IaRiXYAGPx22l2LEUeyBN4xpIa8BLZz2u
         o/amFyEovRMSt+njUTzaWCqHNPU21JwFGiq7LmKl4iBI5hR+FOFdsh+WGgxa44YqUBBV
         cKnyrv1Wg56gbSvZDvFVWAOt5yRlbNBarQbXUsEh+SuDxs6xBTC3KdnvuQowztXZ5jvE
         psbw==
X-Gm-Message-State: AOAM531zxPKsU77ZaIvq+j3yR3x2/idAE5T29JYLz6TmpSiqPRI9jJFf
        4TtdXBj29+Rit3a7CDTHCT66AQ==
X-Google-Smtp-Source: ABdhPJzgIGkU86mMhl+z1BhmlrPdA9HVQEegcOWPq7ug2X32i8/WPm46kYkgC4VpVIOBK4P6cZTF2w==
X-Received: by 2002:a6b:2bc3:: with SMTP id r186mr9543325ior.167.1639665754388;
        Thu, 16 Dec 2021 06:42:34 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f10sm2743677iob.7.2021.12.16.06.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 06:42:34 -0800 (PST)
Subject: Re: [PATCH] selftests/bpf: remove ARRAY_SIZE defines from tests
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211210173433.13247-1-skhan@linuxfoundation.org>
 <CAADnVQ+Fnn-NuGoLq1ZYbHM=kR_W01GB1DCFOnQTHhgfDOrnaA@mail.gmail.com>
 <d367441f-bba0-30eb-787a-89b0c06a65dd@linuxfoundation.org>
 <CAEf4BzahZhCEroeMWNTu-kGsuFCDaNCvbkiFW7ci0EUOWTwmqQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d3c1b7f4-5363-c23e-4837-5eaf07f63ebc@linuxfoundation.org>
Date:   Thu, 16 Dec 2021 07:42:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzahZhCEroeMWNTu-kGsuFCDaNCvbkiFW7ci0EUOWTwmqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/15/21 9:04 PM, Andrii Nakryiko wrote:
> On Tue, Dec 14, 2021 at 12:27 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 12/11/21 6:53 PM, Alexei Starovoitov wrote:
>>> On Fri, Dec 10, 2021 at 9:34 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> ARRAY_SIZE is defined in multiple test files. Remove the definitions
>>>> and include header file for the define instead.
>>>>
>>>> Remove ARRAY_SIZE define and add include bpf_util.h to bring in the
>>>> define.
>>>>
>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>> ---
>>>>    tools/testing/selftests/bpf/progs/netif_receive_skb.c | 5 +----
>>>>    tools/testing/selftests/bpf/progs/profiler.inc.h      | 5 +----
>>>>    tools/testing/selftests/bpf/progs/test_sysctl_loop1.c | 5 +----
>>>>    tools/testing/selftests/bpf/progs/test_sysctl_loop2.c | 4 +---
>>>>    tools/testing/selftests/bpf/progs/test_sysctl_prog.c  | 5 +----
>>>>    5 files changed, 5 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
>>>> index 1d8918dfbd3f..7a5ebd330689 100644
>>>> --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
>>>> +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
>>>> @@ -5,6 +5,7 @@
>>>>    #include <bpf/bpf_helpers.h>
>>>>    #include <bpf/bpf_tracing.h>
>>>>    #include <bpf/bpf_core_read.h>
>>>> +#include <bpf/bpf_util.h>
>>>
>>> It doesn't look like you've built it.
>>>
>>> progs/test_sysctl_prog.c:11:10: fatal error: 'bpf/bpf_util.h' file not found
>>> #include <bpf/bpf_util.h>
>>>            ^~~~~~~~~~~~~~~~
>>>     CLNG-BPF [test_maps] socket_cookie_prog.o
>>> progs/test_sysctl_loop2.c:11:10: fatal error: 'bpf/bpf_util.h' file not found
>>> #include <bpf/bpf_util.h>
>>>            ^~~~~~~~~~~~~~~~
>>> 1 error generated.
>>> In file included from progs/profiler2.c:6:
>>> progs/profiler.inc.h:7:10: fatal error: 'bpf/bpf_util.h' file not found
>>> #include <bpf/bpf_util.h>
>>>            ^~~~~~~~~~~~~~~~
>>>
>>
>> Sorry about that. I built it - I think something is wrong in my env. Build
>> fails complaining about not finding vmlinux - I overlooked that the failure
>> happened before it got to progs.
>>
>> Error: failed to load BTF from .../vmlinux: No such file or directory
> 
> Please make sure that you build vmlinux before you build selftests,
> BPF selftests use vmlinux to generate vmlinux.h with all kernel types
> (among other things). So please also make sure that all the setting in
> selftests/bpf/config were used in your Kconfig.
> 
>>

The problem in my env. is that I don't have CONFIG_DEBUG_INFO_BTF in
my config and then don't have the dwarves and llvm-strip on my system.
Pains of upgrading.

I am all set now. On the other hand the vmlinux.h is a mess. It has
no guards for defines and including stdio.h and this generated
vmlinux.h causes all sorts of problems.

thanks,
-- Shuah
