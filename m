Return-Path: <linux-kselftest+bounces-19717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A64B899E1F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 11:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C4DB218A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 09:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4209317DFEC;
	Tue, 15 Oct 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Nz+R/8cT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0861E29A0;
	Tue, 15 Oct 2024 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982892; cv=none; b=WmZWZbHKEypmZBEcIppdC1blQ5vFpMK3MkReph9k98FKGYt/MjxOBZ3IAqoKGr3yRlLGQunlA/lUqCjseWj3W1tNb9dyYrKPbi4d2EeKUh0SYi2g8UdbO3qjy0R2ZXys67/1UIg257TwfFc399lmngr8AbFg4mLqnjhYlCcEIt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982892; c=relaxed/simple;
	bh=c/vVix7pdj1nwQwH6DyIBMW8KgTC3cw8UjOEoy/HijY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSkEb595yYQeXOMYg/lAvIHCK+2nDMDe1KLMg2aRS5Zg3ZeRIsorEpTQrOfTyvrvHaREtqx/WGXUGWy5KI3/kCy/F5thIJITHkKgQK+Ct4TWLD2NsKP3s9q9TAR5Vrr0e93MFQxKXL3cQ1dEj8OwtRX2Kiu+BiH+ywHMG3CKY0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Nz+R/8cT; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=rHwpWLvt8XnLwVrX/JUeWFo05r4tBAC5fiNuOPeiw6c=;
	b=Nz+R/8cTxbPUepAKHiitk1iS8e8hhlMlvFVvx8c7xm7HsDWornsKHIxnHKK6+V
	nF2tBveuOVst2Q3XSzc00RlOY7KKDU18gjFecjnhEaJEXn+uNrWcm9h9xeC5YcZb
	Ffkg3g1/ln9hmoAmkBo6X/ttVclOMej2lh8bWJWo0RzJ8=
Received: from [10.42.12.92] (unknown [111.48.69.246])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBnb0gxLw5npU01Ag--.63997S2;
	Tue, 15 Oct 2024 17:00:33 +0800 (CST)
Message-ID: <5c4272c4-3f9c-4ce8-ba73-50b5f16ab605@163.com>
Date: Tue, 15 Oct 2024 17:00:33 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: clone3: Use the capget and capset syscall
 directly
To: Shuah Khan <skhan@linuxfoundation.org>, brauner@kernel.org,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhouyuhang <zhouyuhang@kylinos.cn>
References: <20241010121612.2601444-1-zhouyuhang1010@163.com>
 <5b471a5c-c99d-42a5-943d-bb253127a202@linuxfoundation.org>
 <a2ab9671-5095-47bf-82cf-0e167320772f@163.com>
 <b2e02494-0f22-476e-bb79-f3a133b7fa07@linuxfoundation.org>
 <714162ff-a2f8-4fc6-91af-0ecd6376bc7f@163.com>
 <0f79692e-ed68-462d-8ec7-955219116282@linuxfoundation.org>
Content-Language: en-US
From: zhouyuhang <zhouyuhang1010@163.com>
In-Reply-To: <0f79692e-ed68-462d-8ec7-955219116282@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnb0gxLw5npU01Ag--.63997S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr18uF17JFW8Zw1kAryUtrb_yoWxGr4kp3
	W8AF4UKFs5Jr4xJr1qkwsxtF10yFW8Xr17XryUG34UZrnIqr1xtr40yFyUCFyDX397Wa45
	ZrWxXFWfuF4DJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jvLvtUUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiLwd5JmcOLWIswAAAs9


在 2024/10/15 06:38, Shuah Khan 写道:
> On 10/12/24 02:28, zhouyuhang wrote:
>>
>> On 2024/10/11 22:21, Shuah Khan wrote:
>>> On 10/11/24 00:59, zhouyuhang wrote:
>>>>
>>>> On 2024/10/10 23:50, Shuah Khan wrote:
>>>>> On 10/10/24 06:16, zhouyuhang wrote:
>>>>>> From: zhouyuhang <zhouyuhang@kylinos.cn>
>>>>>>
>>>>>> The libcap commit aca076443591 ("Make cap_t operations thread 
>>>>>> safe.") added a
>>>>>> __u8 mutex at the beginning of the struct _cap_struct,it changes 
>>>>>> the offset of
>>>>>> the members in the structure that breaks the assumption made in 
>>>>>> the "struct libcap"
>>>>>> definition in clone3_cap_checkpoint_restore.c.So use the capget 
>>>>>> and capset syscall
>>>>>> directly and remove the libcap library dependency like the commit 
>>>>>> 663af70aabb7
>>>>>> ("bpf: selftests: Add helpers to directly use the capget and 
>>>>>> capset syscall") does.
>>>>>>
>>>>>
>>>>> NIT: grammar and comma spacing. Please fix those for readability.
>>>>> e.g: Change "struct _cap_struct,it" to "struct _cap_struct, it"
>>>>> Fix others as well.
>>>>>
>>>>
>>>> Thanks, I'll fix it in V2
>>>>
>>>>
>>>>>> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
>>>>>> ---
>>>>>>   tools/testing/selftests/clone3/Makefile       |  1 -
>>>>>>   .../clone3/clone3_cap_checkpoint_restore.c    | 60 
>>>>>> +++++++++----------
>>>>>>   2 files changed, 28 insertions(+), 33 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/clone3/Makefile 
>>>>>> b/tools/testing/selftests/clone3/Makefile
>>>>>> index 84832c369a2e..59d26e8da8d2 100644
>>>>>> --- a/tools/testing/selftests/clone3/Makefile
>>>>>> +++ b/tools/testing/selftests/clone3/Makefile
>>>>>> @@ -1,6 +1,5 @@
>>>>>>   # SPDX-License-Identifier: GPL-2.0
>>>>>>   CFLAGS += -g -std=gnu99 $(KHDR_INCLUDES)
>>>>>> -LDLIBS += -lcap
>>>>>>     TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
>>>>>>       clone3_cap_checkpoint_restore
>>>>>> diff --git 
>>>>>> a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c 
>>>>>> b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>>>>> index 3c196fa86c99..111912e2aead 100644
>>>>>> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>>>>> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>>>>> @@ -15,7 +15,7 @@
>>>>>>   #include <stdio.h>
>>>>>>   #include <stdlib.h>
>>>>>>   #include <stdbool.h>
>>>>>> -#include <sys/capability.h>
>>>>>> +#include <linux/capability.h>
>>>>>>   #include <sys/prctl.h>
>>>>>>   #include <sys/syscall.h>
>>>>>>   #include <sys/types.h>
>>>>>> @@ -27,6 +27,13 @@
>>>>>>   #include "../kselftest_harness.h"
>>>>>>   #include "clone3_selftests.h"
>>>>>>   +#ifndef CAP_CHECKPOINT_RESTORE
>>>>>> +#define CAP_CHECKPOINT_RESTORE 40
>>>>>> +#endif
>>>>>> +
>>>>>
>>>>> Why is this necessary? This is defined in linux/capability.h.

Sorry for not noticing this before.
This is to be compatible with some older versions of linux/capability.h 
that do not define this macro.

>>>>>
>>>>>> +int capget(cap_user_header_t header, cap_user_data_t data);
>>>>>> +int capset(cap_user_header_t header, const cap_user_data_t data);
>>>>>
>>>>> In general prototypes such as these should be defined in header
>>>>> file. Why are we defining these here?
>>>>>
>>>>> These are defined in sys/capability.h
>>>>>
>>>>> I don't understand this change. You are removing sys/capability.h
>>>>> which requires you to add these defines here. This doesn't
>>>>> sound like a correct solution to me.
>>>>>
>>>>
>>>> I tested it on my machine without libcap-dev installed, the 
>>>> /usr/include/linux/capability.h
>>>>
>>>> is on this machine by default. Successfully compiled using #include 
>>>> <linux/capability.h>
>>>>
>>>> but not with #include <sys/capability.h>. This patch removes libcap 
>>>> library dependencies.
>>>>
>>>> And we don't use any part of sys/capability.h other than these two 
>>>> syscalls. So I think that's why it's necessary.
>>>
>>> You are changing the code to not include sys/capability.h
>>> What happens if sys/capability.h along with linux/capability.h
>>>
>>> Do you see problems?
>>>
>>
>> I'm sorry, maybe I wasn't clear enough.
>> When we install the libcap library it will have the following output:
>>
>> test@test:~/work/libcap$ sudo make install | grep capability
>> install -m 0644 include/sys/capability.h /usr/include/sys
>> install -m 0644 include/sys/capability.h /usr/include/sys
>> /usr/share/man/man5 capability.conf.5 \
>>
>> It installs sys/capability.h in the correct location, but does not
>>
>> install linux/capability.h, so sys/capability.h is bound to the 
>> libcap library
>
> It won't install inux/capability.h unless you run "make headers" in
> the kernel repo.
>
>>
>> and they will either exist or disappear together. Now I want to remove
>>
>> the dependency of the test on libcap library so I changed the code 
>> that it
>>
>> does not contain sys/capability.h but instead linux/capability.h,
>>
>> so that the test can compile successfully without libcap being 
>> installed,
>>
>> these two syscalls are not declared in linux/capability.h(It is 
>> sufficient for test use except for these two syscalls)
>>
>> so we need to declare them here. I think that's why the commit 
>> 663af70aabb7
>>
>> ("bpf: selftests: Add helpers to directly use the capget and capset 
>> syscall") I refered to
>>
>> does the same thing. As for your question "What happens if 
>> sys/capability.h along
>>
>> with linux/capability.h", I haven't found the problem yet, I 
>> sincerely hope you can
>>
>> help me improve this code. Thank you very much.
>
> Try this:
>
> Run make headers in the kernel repo.
> Build without making any changes.
> Then add you changes and add linux/capability.h to include files
>
> Tell me what happens.
>
> The change you are making isn't correct. Because you don't want to
> define system calls locally in your source file.
>

Thanks, I see.
Maybe I should move them to a new header file and resend a patch.

> thanks,
> -- Shuah


