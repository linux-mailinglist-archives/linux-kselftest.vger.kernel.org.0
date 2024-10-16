Return-Path: <linux-kselftest+bounces-19832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122DB9A053B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 11:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361521C23546
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E251D8E07;
	Wed, 16 Oct 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AOIFTttB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEC718C340;
	Wed, 16 Oct 2024 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070362; cv=none; b=rFIAP95Qc2d0OWZfv0FUaO2FxVfDYU/fd0L716FuqJVZyunKTp0k9O4xw/T1dgNU8wuKKwKkzFHipCf6kyulFkhemJZYecsynG9gYVOSxRxGcAxCOeb48uM+/klLl5o2ZvXOgyegbf9ThVrwzFA3kYMJ3Nb6WccrttWP175bOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070362; c=relaxed/simple;
	bh=73bOvUs5wNzbKFsHil/BudCZ9KCbKZXx8bVT4FczrBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqoqeW8AEMTBuMIIG8/nmdR3IHprCbOhljBIA2JGR1zhD+pdL+XPVJqYl7ibrzaYjPyXSCGOWDUOC8Tc1elrKtELutiGX8pTUEv42Sg4ZXc9JTbrakFw8VPAp3bs3m0nswlTGl3Gq5lqf9xFF4qnvKCo4P3gce54BNk2AGMmafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AOIFTttB; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=WGSXt6ULlR1WLi/9Kbe6qexmm6LVK3aPg0RqCBD2umc=;
	b=AOIFTttBn9/F8zulvHd2ooOdZ2QsEksYI8Jm/cqJ3wBsA8k5EKv47cmPe3P/MW
	F4KTerztfrGMdQ+3IRst13Wq37NWsEZthBTpUDiVvs0onUGji44t6Me/Yhw92ldb
	jQaB+Z5hUwYynPZYH+eWkFbezKxiZiS+pa2+8b+V4TEqc=
Received: from [10.42.12.92] (unknown [111.48.69.246])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3v7jqhA9nmQzbBQ--.7007S2;
	Wed, 16 Oct 2024 17:18:35 +0800 (CST)
Message-ID: <dea6d512-64c7-4ec1-a99d-6796e434c9a4@163.com>
Date: Wed, 16 Oct 2024 17:18:34 +0800
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
From: zhouyuhang <zhouyuhang1010@163.com>
In-Reply-To: <806bee31-d740-49c9-abe0-06820cfa7395@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v7jqhA9nmQzbBQ--.7007S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFyxtFWDXFykKFyDJw4fXwb_yoWxXw1rpa
	48AF4YkFs5Xr1xGa4xZwsruFyFyFWkXF1xtr1UJ34Ykr1a9r1xtr40kFy8K3W29a93uw4r
	Zay0gFWfuFyDJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jvLvtUUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiYBt6JmcPe7fR9wAAsl



在 2024/10/15 23:31, Shuah Khan 写道:
> On 10/15/24 04:59, zhouyuhang wrote:
>> From: zhouyuhang <zhouyuhang@kylinos.cn>
>>
>> The libcap commit aca076443591 ("Make cap_t operations thread safe.")
>> added a __u8 mutex at the beginning of the struct _cap_struct, it 
>> changes
>> the offset of the members in the structure that breaks the assumption
>> made in the "struct libcap" definition in 
>> clone3_cap_checkpoint_restore.c.
>> This will make the test fail. So use the capget and capset syscall
>> directly and remove the libcap library dependency like the
>> commit 663af70aabb7 ("bpf: selftests: Add helpers to directly use
>> the capget and capset syscall") does.
>>
>> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
>> ---
>>   tools/testing/selftests/clone3/Makefile       |  1 -
>>   .../clone3/clone3_cap_checkpoint_restore.c    | 53 ++++++++-----------
>>   .../selftests/clone3/clone3_cap_helpers.h     | 23 ++++++++
>>   3 files changed, 44 insertions(+), 33 deletions(-)
>>   create mode 100644 tools/testing/selftests/clone3/clone3_cap_helpers.h
>>
>> diff --git a/tools/testing/selftests/clone3/Makefile 
>> b/tools/testing/selftests/clone3/Makefile
>> index 84832c369a2e..59d26e8da8d2 100644
>> --- a/tools/testing/selftests/clone3/Makefile
>> +++ b/tools/testing/selftests/clone3/Makefile
>> @@ -1,6 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   CFLAGS += -g -std=gnu99 $(KHDR_INCLUDES)
>> -LDLIBS += -lcap
>>     TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
>>       clone3_cap_checkpoint_restore
>> diff --git 
>> a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c 
>> b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>> index 3c196fa86c99..242088eeec88 100644
>> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>> @@ -15,7 +15,6 @@
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <stdbool.h>
>> -#include <sys/capability.h>
>>   #include <sys/prctl.h>
>>   #include <sys/syscall.h>
>>   #include <sys/types.h>
>> @@ -26,6 +25,7 @@
>>     #include "../kselftest_harness.h"
>>   #include "clone3_selftests.h"
>> +#include "clone3_cap_helpers.h"
>>     static void child_exit(int ret)
>>   {
>> @@ -87,47 +87,36 @@ static int test_clone3_set_tid(struct 
>> __test_metadata *_metadata,
>>       return ret;
>>   }
>>   -struct libcap {
>> -    struct __user_cap_header_struct hdr;
>> -    struct __user_cap_data_struct data[2];
>> -};
>> -
>>   static int set_capability(void)
>>   {
>> -    cap_value_t cap_values[] = { CAP_SETUID, CAP_SETGID };
>> -    struct libcap *cap;
>> -    int ret = -1;
>> -    cap_t caps;
>> -
>> -    caps = cap_get_proc();
>> -    if (!caps) {
>> -        perror("cap_get_proc");
>> +    struct __user_cap_data_struct data[2];
>> +    struct __user_cap_header_struct hdr = {
>> +        .version = _LINUX_CAPABILITY_VERSION_3,
>> +    };
>> +    __u32 cap0 = 1 << CAP_SETUID | 1 << CAP_SETGID;
>> +    __u32 cap1 = 1 << (CAP_CHECKPOINT_RESTORE - 32);
>> +    int ret;
>> +
>> +    ret = capget(&hdr, data);
>> +    if (ret) {
>> +        perror("capget");
>>           return -1;
>>       }
>>         /* Drop all capabilities */
>> -    if (cap_clear(caps)) {
>> -        perror("cap_clear");
>> -        goto out;
>> -    }
>> +    memset(&data, 0, sizeof(data));
>>   -    cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_values, CAP_SET);
>> -    cap_set_flag(caps, CAP_PERMITTED, 2, cap_values, CAP_SET);
>> +    data[0].effective |= cap0;
>> +    data[0].permitted |= cap0;
>>   -    cap = (struct libcap *) caps;
>> +    data[1].effective |= cap1;
>> +    data[1].permitted |= cap1;
>>   -    /* 40 -> CAP_CHECKPOINT_RESTORE */
>> -    cap->data[1].effective |= 1 << (40 - 32);
>> -    cap->data[1].permitted |= 1 << (40 - 32);
>> -
>> -    if (cap_set_proc(caps)) {
>> -        perror("cap_set_proc");
>> -        goto out;
>> +    ret = capset(&hdr, data);
>> +    if (ret) {
>> +        perror("capset");
>> +        return -1;
>>       }
>> -    ret = 0;
>> -out:
>> -    if (cap_free(caps))
>> -        perror("cap_free");
>>       return ret;
>>   }
>>   diff --git a/tools/testing/selftests/clone3/clone3_cap_helpers.h 
>> b/tools/testing/selftests/clone3/clone3_cap_helpers.h
>> new file mode 100644
>> index 000000000000..3fa59ef68fb8
>> --- /dev/null
>> +++ b/tools/testing/selftests/clone3/clone3_cap_helpers.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __CLONE3_CAP_HELPERS_H
>> +#define __CLONE3_CAP_HELPERS_H
>> +
>> +#include <linux/capability.h>
>> +
>> +/*
>> + * Compatible with older version
>> + * header file without defined
>> + * CAP_CHECKPOINT_RESTORE.
>> + */
>> +#ifndef CAP_CHECKPOINT_RESTORE
>> +#define CAP_CHECKPOINT_RESTORE 40
>> +#endif
>> +
>> +/*
>> + * Removed the libcap library dependency.
>> + * So declare them here directly.
>> + */
>> +int capget(cap_user_header_t header, cap_user_data_t data);
>> +int capset(cap_user_header_t header, const cap_user_data_t data);
>
> Sorry you haven't addressed my comments on your v1 yet.
>
> I repeat that this is not the right direction to define system
> calls locally.
>

I got it. I am willing to modify the code so that syscalls are not 
defined in local files,
but this would require including sys/capability.h which would not remove 
the
dependency on the libcap library. So, should we directly use syscalls or 
use the
libcap library function in the "set_capability" function, or do you have 
a better way.
I'd like to refer to your advice.

> Try this:
>
> Run make headers in the kernel repo.
> Build without making any changes.
> Then add you changes and add linux/capability.h to include files
>
> Tell me what happens.
>
> thanks,
> -- Shuah

I tried this, here are my steps.

Firstly, I ran 'make headers' in the kernel repo and it was successful.
Then I wasn't quite sure which path you were referring to as' build ',
so I compiled and installed libcap, and also compiled test, all of which 
were successful.
Afterwards, I applied my patch and the test was successfully built and 
running.
I guess what you're trying to express may be that these system calls 
have already
been defined in sys/capability, and those defined in the local file are 
duplicated with it.
So I included sys/capability.h and linux/capability.h and defined the 
system calls in the test,
but there were no errors.

I think there may be a problem with my operation, and I hope you can 
point it out.


