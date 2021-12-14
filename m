Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94216474C9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 21:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbhLNU1P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 15:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbhLNU1P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 15:27:15 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E186EC061401
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 12:27:14 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so22256494otl.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 12:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5v5jiPKMVhoKa9oPktbJep7rYj1bDC4+fDKLLWPkAzg=;
        b=NtguBbLsXAqG+7WZN7V7gbYjnQ6wkdNPtH9rrzOx5/n8JxhzwtdlfqbHEkHoz3P3IV
         FJFgmp6VQ0XGbAAgXeC7kOwaOeXnllIgaiQTKcFG7nFqzcKGB4OK2YSJh4rIgmD0eLGJ
         QAwc6Wcfy35dEJCzVLdCHqKOTJ2z9wZdSEbZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5v5jiPKMVhoKa9oPktbJep7rYj1bDC4+fDKLLWPkAzg=;
        b=LVHzvhdS7/RYZVjO3Botx39DF+9kQxaV2SF+4l6brehcptM30NU1K9HQ+ovO0CYMSV
         HTHFDygzhReVQMdn2EVq9fUnxyYxeXjg4RQifGdyjARA85R1YTubUxICfGu8NV8ot4o1
         9V6JCoXtWHFqH5NsvSgAbJSvpZMI1HoVDSBOvP6YI5k3O+HbBMNWmzNYjMIyIj4rGgq7
         Fx0KQuEg66znkeMKoG3blxRqjq5DVZiEhEbTjlnONpHM7YO0JYk3fke1fhVQijGwfMMD
         qsRG9Ul0snivC0zxtz2lDY3dU7oNToAH7LoDBjc51JbY0B3jJ+6HorrLXa+ox4R6E8Vf
         BfCQ==
X-Gm-Message-State: AOAM531/V7rAhBUikd6jFcNQC5sShfErVa/hKSh6121xQ6UYsHdpbJKb
        lS3ULjSLuYo1jyeKyGV2hkbsRQ==
X-Google-Smtp-Source: ABdhPJyv4fW5I+F9FWYzifWvOIE6BGPtrx9w3YSbp9hwRop2Lq8hW4DweFB5hVyt2vg/P9gCk9nOuw==
X-Received: by 2002:a05:6830:2aa7:: with SMTP id s39mr6194227otu.151.1639513634160;
        Tue, 14 Dec 2021 12:27:14 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p23sm173635otf.37.2021.12.14.12.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 12:27:13 -0800 (PST)
Subject: Re: [PATCH] selftests/bpf: remove ARRAY_SIZE defines from tests
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211210173433.13247-1-skhan@linuxfoundation.org>
 <CAADnVQ+Fnn-NuGoLq1ZYbHM=kR_W01GB1DCFOnQTHhgfDOrnaA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d367441f-bba0-30eb-787a-89b0c06a65dd@linuxfoundation.org>
Date:   Tue, 14 Dec 2021 13:27:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+Fnn-NuGoLq1ZYbHM=kR_W01GB1DCFOnQTHhgfDOrnaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/11/21 6:53 PM, Alexei Starovoitov wrote:
> On Fri, Dec 10, 2021 at 9:34 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> ARRAY_SIZE is defined in multiple test files. Remove the definitions
>> and include header file for the define instead.
>>
>> Remove ARRAY_SIZE define and add include bpf_util.h to bring in the
>> define.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   tools/testing/selftests/bpf/progs/netif_receive_skb.c | 5 +----
>>   tools/testing/selftests/bpf/progs/profiler.inc.h      | 5 +----
>>   tools/testing/selftests/bpf/progs/test_sysctl_loop1.c | 5 +----
>>   tools/testing/selftests/bpf/progs/test_sysctl_loop2.c | 4 +---
>>   tools/testing/selftests/bpf/progs/test_sysctl_prog.c  | 5 +----
>>   5 files changed, 5 insertions(+), 19 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
>> index 1d8918dfbd3f..7a5ebd330689 100644
>> --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
>> +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
>> @@ -5,6 +5,7 @@
>>   #include <bpf/bpf_helpers.h>
>>   #include <bpf/bpf_tracing.h>
>>   #include <bpf/bpf_core_read.h>
>> +#include <bpf/bpf_util.h>
> 
> It doesn't look like you've built it.
> 
> progs/test_sysctl_prog.c:11:10: fatal error: 'bpf/bpf_util.h' file not found
> #include <bpf/bpf_util.h>
>           ^~~~~~~~~~~~~~~~
>    CLNG-BPF [test_maps] socket_cookie_prog.o
> progs/test_sysctl_loop2.c:11:10: fatal error: 'bpf/bpf_util.h' file not found
> #include <bpf/bpf_util.h>
>           ^~~~~~~~~~~~~~~~
> 1 error generated.
> In file included from progs/profiler2.c:6:
> progs/profiler.inc.h:7:10: fatal error: 'bpf/bpf_util.h' file not found
> #include <bpf/bpf_util.h>
>           ^~~~~~~~~~~~~~~~
> 

Sorry about that. I built it - I think something is wrong in my env. Build
fails complaining about not finding vmlinux - I overlooked that the failure
happened before it got to progs.

Error: failed to load BTF from .../vmlinux: No such file or directory

I do have the kernel built with gcc. Is there a clang dependency?

thanks,
-- Shuah

