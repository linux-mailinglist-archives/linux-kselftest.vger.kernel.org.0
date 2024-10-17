Return-Path: <linux-kselftest+bounces-19935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BF09A1DBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 10:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C551C20D3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFEA1D6DBC;
	Thu, 17 Oct 2024 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QN3IC5bq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B981D63E6;
	Thu, 17 Oct 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155560; cv=none; b=L9G815aUT2xrkY/SXtMORI9+r+wRDSi5VsdmD39U/v7+rrfEUAzX8EGynVFamUbDAu4GmuwDxNzPGDylln+sEH/S/V3WkXeA23UpXtxpNI6nJHvA6dMQbsGgBkseVS4M8ZLVP2V467zRanUNyf0hl67BaJdqWzt4JhCHs9fUS0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155560; c=relaxed/simple;
	bh=gJhvlJnq8dFTPHfGW9ESvjuesnJAYBifZP+PHZbxdKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0rcf/QhtQxYheiIFVpgsZ3b9sN6JfK42yfiDOG6uB7TNHLZZWM0DcFRfHlYygM6ekiD811+v72M4JHcoDKSQqH5d6l/dYQ+2K0f7ulQ0AKuYl1sxQyd3KSn/gIhrl8fR6RIGniqH3i57TWRuZaPP7jUT2K0rBdLTEoumcTsH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QN3IC5bq; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=MEcogBKGnF5OFql5xBOOEvBxjmUMJdyno0Kir1D6Xqw=;
	b=QN3IC5bqPAqiRYtxxuhtRfUdYTyZF1v/RihQUUPSAigVmPf8rXFvGsC3xbM9xr
	z9VMJWoRmG7hmMaPygAvI01ip3dgvqk4x0vfGWQc6EFc9DejmRpBGdmbvw/l0RVn
	zv/3PfKef1aEnIvkmfiKRMwq1hHeBdZgTLHCV6Ojd6lbs=
Received: from [10.42.12.92] (unknown [111.48.69.246])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnNyzJ0RBnQOslAg--.55500S2;
	Thu, 17 Oct 2024 16:58:51 +0800 (CST)
Message-ID: <43d6a661-b28a-4318-977c-66a4e7593aea@163.com>
Date: Thu, 17 Oct 2024 16:58:49 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: clone3: Use the capget and capset syscall
 directly
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>, brauner@kernel.org,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhouyuhang <zhouyuhang@kylinos.cn>
References: <20241015105955.126994-1-zhouyuhang1010@163.com>
 <806bee31-d740-49c9-abe0-06820cfa7395@linuxfoundation.org>
 <dea6d512-64c7-4ec1-a99d-6796e434c9a4@163.com>
 <a0944037-e90a-4884-b12f-284b373a0d63@linuxfoundation.org>
From: zhouyuhang <zhouyuhang1010@163.com>
In-Reply-To: <a0944037-e90a-4884-b12f-284b373a0d63@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCnNyzJ0RBnQOslAg--.55500S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF18GF45Zr4kJF1kWrW3Wrg_yoWfZw1Upa
	48CF4YkFs5Xr1xGFyIvwsI9Fn2yFW8XF1xXr1UJ34jvrnI9rn7tF40yFyj9F10939xuw4F
	va18KFWfuF98AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jafOrUUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiLxF6JmcQO6uaSAABsW



在 2024/10/17 07:10, Shuah Khan 写道:
> On 10/16/24 03:18, zhouyuhang wrote:
>>
>>
>> 在 2024/10/15 23:31, Shuah Khan 写道:
>>> On 10/15/24 04:59, zhouyuhang wrote:
>>>> From: zhouyuhang <zhouyuhang@kylinos.cn>
>>>>
>>>> The libcap commit aca076443591 ("Make cap_t operations thread safe.")
>>>> added a __u8 mutex at the beginning of the struct _cap_struct, it 
>>>> changes
>>>> the offset of the members in the structure that breaks the assumption
>>>> made in the "struct libcap" definition in 
>>>> clone3_cap_checkpoint_restore.c.
>>>> This will make the test fail. So use the capget and capset syscall
>>>> directly and remove the libcap library dependency like the
>>>> commit 663af70aabb7 ("bpf: selftests: Add helpers to directly use
>>>> the capget and capset syscall") does.
>>>>
>>>> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
>>>> ---
>>>>   tools/testing/selftests/clone3/Makefile       |  1 -
>>>>   .../clone3/clone3_cap_checkpoint_restore.c    | 53 
>>>> ++++++++-----------
>>>>   .../selftests/clone3/clone3_cap_helpers.h     | 23 ++++++++
>>>>   3 files changed, 44 insertions(+), 33 deletions(-)
>>>>   create mode 100644 
>>>> tools/testing/selftests/clone3/clone3_cap_helpers.h
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
>>>> index 3c196fa86c99..242088eeec88 100644
>>>> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>>> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>>> @@ -15,7 +15,6 @@
>>>>   #include <stdio.h>
>>>>   #include <stdlib.h>
>>>>   #include <stdbool.h>
>>>> -#include <sys/capability.h>
>>>>   #include <sys/prctl.h>
>>>>   #include <sys/syscall.h>
>>>>   #include <sys/types.h>
>>>> @@ -26,6 +25,7 @@
>>>>     #include "../kselftest_harness.h"
>>>>   #include "clone3_selftests.h"
>>>> +#include "clone3_cap_helpers.h"
>>>>     static void child_exit(int ret)
>>>>   {
>>>> @@ -87,47 +87,36 @@ static int test_clone3_set_tid(struct 
>>>> __test_metadata *_metadata,
>>>>       return ret;
>>>>   }
>>>>   -struct libcap {
>>>> -    struct __user_cap_header_struct hdr;
>>>> -    struct __user_cap_data_struct data[2];
>>>> -};
>>>> -
>>>>   static int set_capability(void)
>>>>   {
>>>> -    cap_value_t cap_values[] = { CAP_SETUID, CAP_SETGID };
>>>> -    struct libcap *cap;
>>>> -    int ret = -1;
>>>> -    cap_t caps;
>>>> -
>>>> -    caps = cap_get_proc();
>>>> -    if (!caps) {
>>>> -        perror("cap_get_proc");
>>>> +    struct __user_cap_data_struct data[2];
>>>> +    struct __user_cap_header_struct hdr = {
>>>> +        .version = _LINUX_CAPABILITY_VERSION_3,
>>>> +    };
>>>> +    __u32 cap0 = 1 << CAP_SETUID | 1 << CAP_SETGID;
>>>> +    __u32 cap1 = 1 << (CAP_CHECKPOINT_RESTORE - 32);
>>>> +    int ret;
>>>> +
>>>> +    ret = capget(&hdr, data);
>>>> +    if (ret) {
>>>> +        perror("capget");
>>>>           return -1;
>>>>       }
>>>>         /* Drop all capabilities */
>>>> -    if (cap_clear(caps)) {
>>>> -        perror("cap_clear");
>>>> -        goto out;
>>>> -    }
>>>> +    memset(&data, 0, sizeof(data));
>>>>   -    cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_values, CAP_SET);
>>>> -    cap_set_flag(caps, CAP_PERMITTED, 2, cap_values, CAP_SET);
>>>> +    data[0].effective |= cap0;
>>>> +    data[0].permitted |= cap0;
>>>>   -    cap = (struct libcap *) caps;
>>>> +    data[1].effective |= cap1;
>>>> +    data[1].permitted |= cap1;
>>>>   -    /* 40 -> CAP_CHECKPOINT_RESTORE */
>>>> -    cap->data[1].effective |= 1 << (40 - 32);
>>>> -    cap->data[1].permitted |= 1 << (40 - 32);
>>>> -
>>>> -    if (cap_set_proc(caps)) {
>>>> -        perror("cap_set_proc");
>>>> -        goto out;
>>>> +    ret = capset(&hdr, data);
>>>> +    if (ret) {
>>>> +        perror("capset");
>>>> +        return -1;
>>>>       }
>>>> -    ret = 0;
>>>> -out:
>>>> -    if (cap_free(caps))
>>>> -        perror("cap_free");
>>>>       return ret;
>>>>   }
>>>>   diff --git a/tools/testing/selftests/clone3/clone3_cap_helpers.h 
>>>> b/tools/testing/selftests/clone3/clone3_cap_helpers.h
>>>> new file mode 100644
>>>> index 000000000000..3fa59ef68fb8
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/clone3/clone3_cap_helpers.h
>>>> @@ -0,0 +1,23 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +#ifndef __CLONE3_CAP_HELPERS_H
>>>> +#define __CLONE3_CAP_HELPERS_H
>>>> +
>>>> +#include <linux/capability.h>
>>>> +
>>>> +/*
>>>> + * Compatible with older version
>>>> + * header file without defined
>>>> + * CAP_CHECKPOINT_RESTORE.
>>>> + */
>>>> +#ifndef CAP_CHECKPOINT_RESTORE
>>>> +#define CAP_CHECKPOINT_RESTORE 40
>>>> +#endif
>>>> +
>>>> +/*
>>>> + * Removed the libcap library dependency.
>>>> + * So declare them here directly.
>>>> + */
>>>> +int capget(cap_user_header_t header, cap_user_data_t data);
>>>> +int capset(cap_user_header_t header, const cap_user_data_t data);
>>>
>>> Sorry you haven't addressed my comments on your v1 yet.
>>>
>>> I repeat that this is not the right direction to define system
>>> calls locally.
>>>
>>
>> I got it. I am willing to modify the code so that syscalls are not 
>> defined in local files,
>> but this would require including sys/capability.h which would not 
>> remove the
>> dependency on the libcap library. So, should we directly use syscalls 
>> or use the
>> libcap library function in the "set_capability" function, or do you 
>> have a better way.
>> I'd like to refer to your advice.
>>
>>> Try this:
>>>
>>> Run make headers in the kernel repo.
>>> Build without making any changes.
>>> Then add you changes and add linux/capability.h to include files
>>>
>>> Tell me what happens.
>>>
>>> thanks,
>>> -- Shuah
>>
>> I tried this, here are my steps.
>>
>> Firstly, I ran 'make headers' in the kernel repo and it was successful.
>> Then I wasn't quite sure which path you were referring to as' build ',
>
> Sorry if what I said wasn't clear:
>
> - This test depends on libcap and yes you will have to install it.
> - Run ake headers in the kernel repo.
> - Build the test without your patch (changes)
> - If you don't have libcap, the test build will fail
> - Install libcap
> - Build and run.
>
> Looks like you have done the above. Now:
>
> - Add your patch without the local capget() and capset()
>   and without removing

It will generate the following warning but can be compiled successfully,
because my patch only includes linux/capability.h and removes the local 
capget() and capset().

CC       clone3_cap_checkpoint_restore
clone3_cap_checkpoint_restore.c: In function ‘set_capability’:
clone3_cap_checkpoint_restore.c:105:8: warning: implicit declaration of 
function ‘capget’ [-Wimplicit-function-declaration]
105 |  ret = capget(&hdr, data);
|        ^~~~~~
clone3_cap_checkpoint_restore.c:120:8: warning: implicit declaration of 
function ‘capset’ [-Wimplicit-function-declaration]
120 |  ret = capset(&hdr, data);

>
>> so I compiled and installed libcap, and also compiled test, all of 
>> which were successful.
>
> Why do you need to compile libcap? Is it because this latest
> change isn't available to install from the distro you are using?

No, I just didn't fully understand the path you were referring to as 
"build",
so I compiled libcap as well, which wasn't really necessary.

>
>> Afterwards, I applied my patch and the test was successfully built 
>> and running.
>> I guess what you're trying to express may be that these system calls 
>> have already
>> been defined in sys/capability, and those defined in the local file 
>> are duplicated with it.
>
> Correct. You don't need the local defines and in fact you should not
> define them locally.
>
>> So I included sys/capability.h and linux/capability.h and defined the 
>> system calls in the test,
>> but there were no errors.
>
> Please don't define system calls locally. What happens if you don't?

I know it can be successfully compiled without any warnings.
Because I added sys/capability.h here, which was not included earlier.

What I want to express is that I tested that defining them again in the
local file would not cause compilation errors, but I know this is 
incorrect,
so I will remove them and modify the test to make it pass.

Let's go back to this code.
I think there may be the following solutions to modify this code on the 
basis of removing local system calls:

1. Includes linux/capability.h, using capget and capset, but this will 
result in compilation warnings.
2. Includes sys/capability.h, using capget and capset.
3. Includes sys/capability.h, using libcap library functions.

I tend to use capget and capset, By doing so, test may not need to be 
maintained again in the future.
Which of the above solutions do you think is better, and I will refer to 
your suggestions to modify the code and resend the patch.

>
> thanks,
> -- Shuah


