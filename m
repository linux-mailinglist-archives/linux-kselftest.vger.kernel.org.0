Return-Path: <linux-kselftest+bounces-19592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CE299B219
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 10:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D66283FA3
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EE8145B22;
	Sat, 12 Oct 2024 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Kgm9fux4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3321213E8AE;
	Sat, 12 Oct 2024 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728721743; cv=none; b=QJ2A3dR07JraGdMQcyDsffdfwkna5p2p4Cpb2yvIOcXTu55RfZVgnf8GYU7nuChMEhkgfKx9+gygL81zXFfcMcbkuDPkph0GcDYUMIesJuQ/fjnqucATdnTI47rn5eD3x1sek7JyqRLPWiRRE/LOMVmkrIvM0AZZsAkdO+Ye3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728721743; c=relaxed/simple;
	bh=fd6Niopcwbsban/4b+w7hvlLC7JM4m0/4dHpih0eGEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nr+wCq+6ial+g96SokAtmHR/ZVlTLrKNCt+wr2FWvtC2CJ8CKpln7qBoa6R3RgCHDUCt2O661dnaz2Sb0ROhC8bfLmgEm/XbHPo+JAGa2Zh6KIF1R3ria+vCOVHXslzNcH0MzC4ASauPqnr1Ca1Pti4XxqCRuLsgLbrSccmMLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Kgm9fux4; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=yUrtqcVf1qlAMdA05qZj2TIyHWkuhOXgiMmNJcN+gZo=;
	b=Kgm9fux4pZkgHMTIbpzDD9dTrEFl/0jKRHsUwQFqHVvd9qPeMImaHjAnHx8p58
	rnjmoW9GNevJr6eKVFhiCjyBMRGbcLm0nG97eyTncKv+yj5qiHbLwecV7Hw4ezMZ
	xx62619TAIvPd0/3UjZ4jNwvw3qTgqftWP5xphGHXu9Ak=
Received: from [10.42.12.92] (unknown [111.48.69.246])
	by gzsmtp4 (Coremail) with SMTP id sygvCgC3aTMtMwpnTzVnAA--.21210S2;
	Sat, 12 Oct 2024 16:28:30 +0800 (CST)
Message-ID: <714162ff-a2f8-4fc6-91af-0ecd6376bc7f@163.com>
Date: Sat, 12 Oct 2024 16:28:29 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: clone3: Use the capget and capset syscall
 directly
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>, brauner@kernel.org,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhouyuhang <zhouyuhang@kylinos.cn>
References: <20241010121612.2601444-1-zhouyuhang1010@163.com>
 <5b471a5c-c99d-42a5-943d-bb253127a202@linuxfoundation.org>
 <a2ab9671-5095-47bf-82cf-0e167320772f@163.com>
 <b2e02494-0f22-476e-bb79-f3a133b7fa07@linuxfoundation.org>
From: zhouyuhang <zhouyuhang1010@163.com>
In-Reply-To: <b2e02494-0f22-476e-bb79-f3a133b7fa07@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:sygvCgC3aTMtMwpnTzVnAA--.21210S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw1rJF48JFW5Wr18XF4UCFg_yoW7XFy7p3
	WkAF4UKFs5Gr4xJr1qkwsxtF10yFW8ZF12qryUG34UArnIqr1xtr40yFyUCF18X397W34Y
	vrWIgFWfuF4DJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-KsUUUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiRRt2JmcKLihl0gABsT


On 2024/10/11 22:21, Shuah Khan wrote:
> On 10/11/24 00:59, zhouyuhang wrote:
>>
>> On 2024/10/10 23:50, Shuah Khan wrote:
>>> On 10/10/24 06:16, zhouyuhang wrote:
>>>> From: zhouyuhang <zhouyuhang@kylinos.cn>
>>>>
>>>> The libcap commit aca076443591 ("Make cap_t operations thread 
>>>> safe.") added a
>>>> __u8 mutex at the beginning of the struct _cap_struct,it changes 
>>>> the offset of
>>>> the members in the structure that breaks the assumption made in the 
>>>> "struct libcap"
>>>> definition in clone3_cap_checkpoint_restore.c.So use the capget and 
>>>> capset syscall
>>>> directly and remove the libcap library dependency like the commit 
>>>> 663af70aabb7
>>>> ("bpf: selftests: Add helpers to directly use the capget and capset 
>>>> syscall") does.
>>>>
>>>
>>> NIT: grammar and comma spacing. Please fix those for readability.
>>> e.g: Change "struct _cap_struct,it" to "struct _cap_struct, it"
>>> Fix others as well.
>>>
>>
>> Thanks, I'll fix it in V2
>>
>>
>>>> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
>>>> ---
>>>>   tools/testing/selftests/clone3/Makefile       |  1 -
>>>>   .../clone3/clone3_cap_checkpoint_restore.c    | 60 
>>>> +++++++++----------
>>>>   2 files changed, 28 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/clone3/Makefile 
>>>> b/tools/testing/selftests/clone3/Makefile
>>>> index 84832c369a2e..59d26e8da8d2 100644
>>>> --- a/tools/testing/selftests/clone3/Makefile
>>>> +++ b/tools/testing/selftests/clone3/Makefile
>>>> @@ -1,6 +1,5 @@
>>>>   # SPDX-License-Identifier: GPL-2.0
>>>>   CFLAGS += -g -std=gnu99 $(KHDR_INCLUDES)
>>>> -LDLIBS += -lcap
>>>>     TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
>>>>       clone3_cap_checkpoint_restore
>>>> diff --git 
>>>> a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c 
>>>> b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>>> index 3c196fa86c99..111912e2aead 100644
>>>> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>>> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>>> @@ -15,7 +15,7 @@
>>>>   #include <stdio.h>
>>>>   #include <stdlib.h>
>>>>   #include <stdbool.h>
>>>> -#include <sys/capability.h>
>>>> +#include <linux/capability.h>
>>>>   #include <sys/prctl.h>
>>>>   #include <sys/syscall.h>
>>>>   #include <sys/types.h>
>>>> @@ -27,6 +27,13 @@
>>>>   #include "../kselftest_harness.h"
>>>>   #include "clone3_selftests.h"
>>>>   +#ifndef CAP_CHECKPOINT_RESTORE
>>>> +#define CAP_CHECKPOINT_RESTORE 40
>>>> +#endif
>>>> +
>>>
>>> Why is this necessary? This is defined in linux/capability.h.
>>>
>>>> +int capget(cap_user_header_t header, cap_user_data_t data);
>>>> +int capset(cap_user_header_t header, const cap_user_data_t data);
>>>
>>> In general prototypes such as these should be defined in header
>>> file. Why are we defining these here?
>>>
>>> These are defined in sys/capability.h
>>>
>>> I don't understand this change. You are removing sys/capability.h
>>> which requires you to add these defines here. This doesn't
>>> sound like a correct solution to me.
>>>
>>
>> I tested it on my machine without libcap-dev installed, the 
>> /usr/include/linux/capability.h
>>
>> is on this machine by default. Successfully compiled using #include 
>> <linux/capability.h>
>>
>> but not with #include <sys/capability.h>. This patch removes libcap 
>> library dependencies.
>>
>> And we don't use any part of sys/capability.h other than these two 
>> syscalls. So I think that's why it's necessary.
>
> You are changing the code to not include sys/capability.h
> What happens if sys/capability.h along with linux/capability.h
>
> Do you see problems?
>

I'm sorry, maybe I wasn't clear enough.
When we install the libcap library it will have the following output:

test@test:~/work/libcap$ sudo make install | grep capability
install -m 0644 include/sys/capability.h /usr/include/sys
install -m 0644 include/sys/capability.h /usr/include/sys
/usr/share/man/man5 capability.conf.5 \

It installs sys/capability.h in the correct location, but does not

install linux/capability.h, so sys/capability.h is bound to the libcap 
library

and they will either exist or disappear together. Now I want to remove

the dependency of the test on libcap library so I changed the code that it

does not contain sys/capability.h but instead linux/capability.h,

so that the test can compile successfully without libcap being installed,

these two syscalls are not declared in linux/capability.h(It is 
sufficient for test use except for these two syscalls)

so we need to declare them here. I think that's why the commit 663af70aabb7

("bpf: selftests: Add helpers to directly use the capget and capset 
syscall") I refered to

does the same thing. As for your question "What happens if 
sys/capability.h along

with linux/capability.h", I haven't found the problem yet, I sincerely 
hope you can

help me improve this code. Thank you very much.


> thanks,
> -- Shuah


