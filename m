Return-Path: <linux-kselftest+bounces-19545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4007899A62B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 16:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0121285D23
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A292185AF;
	Fri, 11 Oct 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PyOQgagd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B721E87B
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656469; cv=none; b=NLL/HZKpCHS5f0H+Eu1fk5x6EiTp+3xZnUvmwsbT6n76bLKgvRNEc1WKt3BTVM7stHcsqhLLvGjiwO7dhU18v0DJZEHcPQfoLaSXN5TyvEYOShgnv3OiddT3QAX9ckcVKh0Wk/R98NNYETOB+KOBUj/Fck1tKOHIl+FmybwiWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656469; c=relaxed/simple;
	bh=TYE5vXTXT7Cm/vgRYyKhBt1I+Zc/7FpaevYm7u7Hc7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtIr4q1oAcL7vhehHtURl/tFKi8JLnR3/EeWdv9yMB70diQvndX4hu55SnNyVtA4s/m9NMP5fhj3J27YgZsoBKqPNt7hO4+y6qmA/UAoDUooiRSNA1tDtJZepWnHmdlnpdji/Q1NgU5pLVByVDxeKLd3Wg3oyjL8/YctwfWeM94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PyOQgagd; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a363feabc6so10589635ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 07:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728656466; x=1729261266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x2PJdME7gEpgZm4c7VOyfyN+e8wtfK6RNIHEqseNqOQ=;
        b=PyOQgagdlbt6L5IvYedNskr+0xKmBHYjRW8qsFkj9TDVyFUNsY4oMMc+NP4+YI+R4+
         7tZSYd0RdJfin3huBipBWVmT5BD/0N23T4Pd9yHNvZ1mT5Q1wfmsKHplvEu1TjqwzEsw
         SzGW+FTESdnO1+9dFSGYSZ2MwY2vslOLFh2kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728656466; x=1729261266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2PJdME7gEpgZm4c7VOyfyN+e8wtfK6RNIHEqseNqOQ=;
        b=DoJTpstcmjTdXsSpt70wyoPlVYEViRg70JP7y0f3u0WTxYMo2al4TXrIA9DCuKg+nr
         OkR0dA7ZvR4hwnB94hENEP4boxy1DiZyfsonYWIkERavcpr7bf7pepBNsBxGN/hCasnP
         FbCdi1daYL8YSWILtf7NX6sX+tZrd9aQmoA++0e28VxhJcexbcKasj3is11WDfaBmAu2
         gn+dJu95DEDqw67Il8laf+S+vDM1QUZ7i2AEfJ0Wnt36uPauG3t0GY0vwgZzcVurnIAf
         42ZlH6XkZ+jFg5CrA2zpu7h6e50mahwIVGc0wxVbt98QdVK+2X/jjHHTsnJX2z/4SMyd
         2DeA==
X-Forwarded-Encrypted: i=1; AJvYcCXLwvZnrCblpTY+HbtppNWObJbsiM7HM5QTh2iAjKOOHP0IY5MMKF5bUxU7iUpdE4/x865B+s72JlqRWeU12ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfN6Wp7xNfCiPOuIR8rXHeBV8CCjntiI2S8QhHIkOUlAVkvnP8
	SA8nGIjOWg6+KcM6KSU0uOTPFwhy3aOX9IDby+QD174zpK0l4r+TWB1zgxm98KI=
X-Google-Smtp-Source: AGHT+IEwImqOyQAmT6fExrU/UEB3L6kghbfDP6gdwjhkhbR9nDrNGWSRu/G2qy6foQOPdk8aNrCEHA==
X-Received: by 2002:a05:6e02:1e0a:b0:3a0:ce43:fb62 with SMTP id e9e14a558f8ab-3a3a71ddab2mr42676805ab.11.1728656465812;
        Fri, 11 Oct 2024 07:21:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbad9b0e90sm652358173.15.2024.10.11.07.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 07:21:05 -0700 (PDT)
Message-ID: <b2e02494-0f22-476e-bb79-f3a133b7fa07@linuxfoundation.org>
Date: Fri, 11 Oct 2024 08:21:04 -0600
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
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <a2ab9671-5095-47bf-82cf-0e167320772f@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/24 00:59, zhouyuhang wrote:
> 
> On 2024/10/10 23:50, Shuah Khan wrote:
>> On 10/10/24 06:16, zhouyuhang wrote:
>>> From: zhouyuhang <zhouyuhang@kylinos.cn>
>>>
>>> The libcap commit aca076443591 ("Make cap_t operations thread safe.") added a
>>> __u8 mutex at the beginning of the struct _cap_struct,it changes the offset of
>>> the members in the structure that breaks the assumption made in the "struct libcap"
>>> definition in clone3_cap_checkpoint_restore.c.So use the capget and capset syscall
>>> directly and remove the libcap library dependency like the commit 663af70aabb7
>>> ("bpf: selftests: Add helpers to directly use the capget and capset syscall") does.
>>>
>>
>> NIT: grammar and comma spacing. Please fix those for readability.
>> e.g: Change "struct _cap_struct,it" to "struct _cap_struct, it"
>> Fix others as well.
>>
> 
> Thanks, I'll fix it in V2
> 
> 
>>> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
>>> ---
>>>   tools/testing/selftests/clone3/Makefile       |  1 -
>>>   .../clone3/clone3_cap_checkpoint_restore.c    | 60 +++++++++----------
>>>   2 files changed, 28 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
>>> index 84832c369a2e..59d26e8da8d2 100644
>>> --- a/tools/testing/selftests/clone3/Makefile
>>> +++ b/tools/testing/selftests/clone3/Makefile
>>> @@ -1,6 +1,5 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>>   CFLAGS += -g -std=gnu99 $(KHDR_INCLUDES)
>>> -LDLIBS += -lcap
>>>     TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
>>>       clone3_cap_checkpoint_restore
>>> diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>> index 3c196fa86c99..111912e2aead 100644
>>> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>> @@ -15,7 +15,7 @@
>>>   #include <stdio.h>
>>>   #include <stdlib.h>
>>>   #include <stdbool.h>
>>> -#include <sys/capability.h>
>>> +#include <linux/capability.h>
>>>   #include <sys/prctl.h>
>>>   #include <sys/syscall.h>
>>>   #include <sys/types.h>
>>> @@ -27,6 +27,13 @@
>>>   #include "../kselftest_harness.h"
>>>   #include "clone3_selftests.h"
>>>   +#ifndef CAP_CHECKPOINT_RESTORE
>>> +#define CAP_CHECKPOINT_RESTORE 40
>>> +#endif
>>> +
>>
>> Why is this necessary? This is defined in linux/capability.h.
>>
>>> +int capget(cap_user_header_t header, cap_user_data_t data);
>>> +int capset(cap_user_header_t header, const cap_user_data_t data);
>>
>> In general prototypes such as these should be defined in header
>> file. Why are we defining these here?
>>
>> These are defined in sys/capability.h
>>
>> I don't understand this change. You are removing sys/capability.h
>> which requires you to add these defines here. This doesn't
>> sound like a correct solution to me.
>>
> 
> I tested it on my machine without libcap-dev installed, the /usr/include/linux/capability.h
> 
> is on this machine by default. Successfully compiled using #include <linux/capability.h>
> 
> but not with #include <sys/capability.h>. This patch removes libcap library dependencies.
> 
> And we don't use any part of sys/capability.h other than these two syscalls. So I think that's why it's necessary.

You are changing the code to not include sys/capability.h
What happens if sys/capability.h along with linux/capability.h

Do you see problems?

thanks,
-- Shuah

