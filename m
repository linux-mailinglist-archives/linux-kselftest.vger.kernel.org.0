Return-Path: <linux-kselftest+bounces-19682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3423599D9D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 00:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936571F2244C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 22:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354371D1E62;
	Mon, 14 Oct 2024 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VZZ4a7DI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738E1CF2AF
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945508; cv=none; b=Gd7DaV/9TKiYRd2IJ8VcdkJi/o+NB718jEN8rDjntZonpzB9uOsBIry/I1vZ+xGegXKqcOK4o6deI4gQtVoxe3g2abfY4oLM88wh0WostfmCNUzxDUWUsqrGIQe5ui4MJiSH3Zjx7d7i8bm3tOH078/FXLa0Q6wyOd0cPzvyW0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945508; c=relaxed/simple;
	bh=O8OKq8HDwbJjRTWzd1uS/ZHiUvAuLk/CNimbphejG5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSiZCVQ0znTjRk273gGIqTNtfvW1J9cWHM5VGCyRNWK/uF4GiNqYIzX4jVFIWx3618N7cx72kWmBcIe9XVk6CAtOhtJXDDu93twd9fadKPOi0pxaVJzJU1QVHkMrzN/DYtNPd8m/+TPqkfnyGVvxTspuMpLyUC44cXOAZCK5lEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VZZ4a7DI; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8377fd76112so169844839f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 15:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728945505; x=1729550305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AIonu1LkVfLUVFewo4PfSaVbZJxpryIcr1kRznLAruM=;
        b=VZZ4a7DIWxFBF0w8QLIdIo8HJb4VFhtbJBzwzfBqk2m3Vcwup/o5hZqVCFbfixo1QI
         A5QfemGgqOtmsK68txPRIFCGDL9yilI+qvRdhhRPGe+y1yFnxlmC+ZoVOpg6FSnrDsoG
         TmWeM/kVU7bji2IZFQaQgIhdhXrJ8DtEFd9go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728945505; x=1729550305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIonu1LkVfLUVFewo4PfSaVbZJxpryIcr1kRznLAruM=;
        b=YptcjWUcC2vAvFb22vR3B9lJlPYtVApqdOweHLZg+KOFkjm7wbcDvnpW3jlOk6vhDZ
         QVr9vJ0WMp4Ef8p0gwWMbXjYQ89c7HRF6jOBlciCVUGoNAA3pQwu+0DhARFlGrnjFAbe
         t0LXtdn4KAUtilUEg+QOZbsIzNQSNAtS6KcWYMZGnUYWT2zXLqLf2lK9oZWFTmajpsC1
         TT0XTzRpvLGSRzbdOX2kOC9/qUMwLEUqtfHJfAxJ88mkc/Lmz5cK6VauontDg/y42XiO
         sOh7NEaKbVJ422my7rYLGBsnh/Tzqo9lDWc8WmRcRd/8095DJ9JzIBdUSfzqyTokrFnO
         P1Pw==
X-Forwarded-Encrypted: i=1; AJvYcCW5FB+33FkLV9hGvvh5s7tFKMu+jQf+wgN4nMInRqyk21QuR9D3lWoE6/B/lkHz+XPUdIMNYL5AYZOci9DfFUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoVcaebbWqWbUyR28WxNHijs5Edq6TDgrdPu1dP/WTezHNOWqs
	3R3VyzzD+GHUEeCmAz8lB9SJKyxJbvuAb9lMAJ5lHgcGB2JPNgAA60ZcmQ2I3cY=
X-Google-Smtp-Source: AGHT+IHpEqUp+akex3EK/CJOQyx8TJduGjR4UjuL/G45Ogs0SFpV2pbARlLAAZYTHhTjtTIubmr86g==
X-Received: by 2002:a05:6e02:1a0b:b0:39f:5efe:ae73 with SMTP id e9e14a558f8ab-3a3b5f1deaamr118636665ab.5.1728945505169;
        Mon, 14 Oct 2024 15:38:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec837620sm25823173.0.2024.10.14.15.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 15:38:24 -0700 (PDT)
Message-ID: <0f79692e-ed68-462d-8ec7-955219116282@linuxfoundation.org>
Date: Mon, 14 Oct 2024 16:38:23 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: clone3: Use the capget and capset syscall
 directly
To: zhouyuhang <zhouyuhang1010@163.com>, brauner@kernel.org, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhouyuhang <zhouyuhang@kylinos.cn>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241010121612.2601444-1-zhouyuhang1010@163.com>
 <5b471a5c-c99d-42a5-943d-bb253127a202@linuxfoundation.org>
 <a2ab9671-5095-47bf-82cf-0e167320772f@163.com>
 <b2e02494-0f22-476e-bb79-f3a133b7fa07@linuxfoundation.org>
 <714162ff-a2f8-4fc6-91af-0ecd6376bc7f@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <714162ff-a2f8-4fc6-91af-0ecd6376bc7f@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/24 02:28, zhouyuhang wrote:
> 
> On 2024/10/11 22:21, Shuah Khan wrote:
>> On 10/11/24 00:59, zhouyuhang wrote:
>>>
>>> On 2024/10/10 23:50, Shuah Khan wrote:
>>>> On 10/10/24 06:16, zhouyuhang wrote:
>>>>> From: zhouyuhang <zhouyuhang@kylinos.cn>
>>>>>
>>>>> The libcap commit aca076443591 ("Make cap_t operations thread safe.") added a
>>>>> __u8 mutex at the beginning of the struct _cap_struct,it changes the offset of
>>>>> the members in the structure that breaks the assumption made in the "struct libcap"
>>>>> definition in clone3_cap_checkpoint_restore.c.So use the capget and capset syscall
>>>>> directly and remove the libcap library dependency like the commit 663af70aabb7
>>>>> ("bpf: selftests: Add helpers to directly use the capget and capset syscall") does.
>>>>>
>>>>
>>>> NIT: grammar and comma spacing. Please fix those for readability.
>>>> e.g: Change "struct _cap_struct,it" to "struct _cap_struct, it"
>>>> Fix others as well.
>>>>
>>>
>>> Thanks, I'll fix it in V2
>>>
>>>
>>>>> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
>>>>> ---
>>>>>   tools/testing/selftests/clone3/Makefile       |  1 -
>>>>>   .../clone3/clone3_cap_checkpoint_restore.c    | 60 +++++++++----------
>>>>>   2 files changed, 28 insertions(+), 33 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
>>>>> index 84832c369a2e..59d26e8da8d2 100644
>>>>> --- a/tools/testing/selftests/clone3/Makefile
>>>>> +++ b/tools/testing/selftests/clone3/Makefile
>>>>> @@ -1,6 +1,5 @@
>>>>>   # SPDX-License-Identifier: GPL-2.0
>>>>>   CFLAGS += -g -std=gnu99 $(KHDR_INCLUDES)
>>>>> -LDLIBS += -lcap
>>>>>     TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
>>>>>       clone3_cap_checkpoint_restore
>>>>> diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>>>> index 3c196fa86c99..111912e2aead 100644
>>>>> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>>>> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>>>> @@ -15,7 +15,7 @@
>>>>>   #include <stdio.h>
>>>>>   #include <stdlib.h>
>>>>>   #include <stdbool.h>
>>>>> -#include <sys/capability.h>
>>>>> +#include <linux/capability.h>
>>>>>   #include <sys/prctl.h>
>>>>>   #include <sys/syscall.h>
>>>>>   #include <sys/types.h>
>>>>> @@ -27,6 +27,13 @@
>>>>>   #include "../kselftest_harness.h"
>>>>>   #include "clone3_selftests.h"
>>>>>   +#ifndef CAP_CHECKPOINT_RESTORE
>>>>> +#define CAP_CHECKPOINT_RESTORE 40
>>>>> +#endif
>>>>> +
>>>>
>>>> Why is this necessary? This is defined in linux/capability.h.
>>>>
>>>>> +int capget(cap_user_header_t header, cap_user_data_t data);
>>>>> +int capset(cap_user_header_t header, const cap_user_data_t data);
>>>>
>>>> In general prototypes such as these should be defined in header
>>>> file. Why are we defining these here?
>>>>
>>>> These are defined in sys/capability.h
>>>>
>>>> I don't understand this change. You are removing sys/capability.h
>>>> which requires you to add these defines here. This doesn't
>>>> sound like a correct solution to me.
>>>>
>>>
>>> I tested it on my machine without libcap-dev installed, the /usr/include/linux/capability.h
>>>
>>> is on this machine by default. Successfully compiled using #include <linux/capability.h>
>>>
>>> but not with #include <sys/capability.h>. This patch removes libcap library dependencies.
>>>
>>> And we don't use any part of sys/capability.h other than these two syscalls. So I think that's why it's necessary.
>>
>> You are changing the code to not include sys/capability.h
>> What happens if sys/capability.h along with linux/capability.h
>>
>> Do you see problems?
>>
> 
> I'm sorry, maybe I wasn't clear enough.
> When we install the libcap library it will have the following output:
> 
> test@test:~/work/libcap$ sudo make install | grep capability
> install -m 0644 include/sys/capability.h /usr/include/sys
> install -m 0644 include/sys/capability.h /usr/include/sys
> /usr/share/man/man5 capability.conf.5 \
> 
> It installs sys/capability.h in the correct location, but does not
> 
> install linux/capability.h, so sys/capability.h is bound to the libcap library

It won't install inux/capability.h unless you run "make headers" in
the kernel repo.

> 
> and they will either exist or disappear together. Now I want to remove
> 
> the dependency of the test on libcap library so I changed the code that it
> 
> does not contain sys/capability.h but instead linux/capability.h,
> 
> so that the test can compile successfully without libcap being installed,
> 
> these two syscalls are not declared in linux/capability.h(It is sufficient for test use except for these two syscalls)
> 
> so we need to declare them here. I think that's why the commit 663af70aabb7
> 
> ("bpf: selftests: Add helpers to directly use the capget and capset syscall") I refered to
> 
> does the same thing. As for your question "What happens if sys/capability.h along
> 
> with linux/capability.h", I haven't found the problem yet, I sincerely hope you can
> 
> help me improve this code. Thank you very much.

Try this:

Run make headers in the kernel repo.
Build without making any changes.
Then add you changes and add linux/capability.h to include files

Tell me what happens.

The change you are making isn't correct. Because you don't want to
define system calls locally in your source file.

thanks,
-- Shuah

