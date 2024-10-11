Return-Path: <linux-kselftest+bounces-19517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7E3999D4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 08:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAF22855C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 06:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22FE209671;
	Fri, 11 Oct 2024 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Jeblmu9r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B02719923C;
	Fri, 11 Oct 2024 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629972; cv=none; b=eXVIqIbH0jKmvScyZ87i2n/LLV4ahLIwPlmgw/NtXV3Sb9dTOek/MKUTE4mepaR5mdo00PEvN13y9KDQ87Rdyv1R4SabJfzXVBoUUHdSW6s8Rf/LuxkgtOFG11pjEaN0TEjcYZKQjKjbU2nEfg1NXG+EPGGtM35NI+UorOiI9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629972; c=relaxed/simple;
	bh=RXsbcIwM0bpb3OKMw3AG95muLvmersqGQsb/lSXL9d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riF4xeJ7/o3lRmKclw5fijPf2el3qRMLWSS1KhQ/YlF8hjpPaoewQsMfoqYw77SCcnyDzSpiygybvwcU1UKQBrWErIyJJUVOCbWpPYC5xjsa6YURJ/7l+KdF4VEoyiJUdxWF+2BgPBGdnSbtz/jkM4ylRcrp8jL2CLZq7CO1MjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Jeblmu9r; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=tRtlnkfofpTmHCU4ZghcA6ATCzDyTL3ZqRpdapOK7sw=;
	b=Jeblmu9r7h7dyRxogvj5t2TJmJjEXI8QjeMYqpBxYYxTnw8BRMVXd3DCs9Or+6
	BgcW4bNY+HTepx4DDQ7VWde2apSOiX6UJY3TZ6BdKHfGJuAMEqYUC4tUG/QapG/f
	JfdHnodHTPiJJUruUONxqGfzO5uWZqQwlHNOHx3pbR+Jc=
Received: from [10.42.12.92] (unknown [111.48.69.246])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnr868zAhnL4aoAQ--.44197S2;
	Fri, 11 Oct 2024 14:59:09 +0800 (CST)
Message-ID: <a2ab9671-5095-47bf-82cf-0e167320772f@163.com>
Date: Fri, 11 Oct 2024 14:59:08 +0800
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
From: zhouyuhang <zhouyuhang1010@163.com>
In-Reply-To: <5b471a5c-c99d-42a5-943d-bb253127a202@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr868zAhnL4aoAQ--.44197S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF1kKryfXw4rJrWrAw4fZrb_yoW7XrW8pF
	ykAF43KFsYqr1xGrW09wsrZF10yF95Xr1Iqr1UGw1Yyr1a9r1xtF40kFy8K3W7ua97uw4r
	Zay0gFZ3uFyDJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-KsUUUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiRR11JmcIyJoEzgABs9


On 2024/10/10 23:50, Shuah Khan wrote:
> On 10/10/24 06:16, zhouyuhang wrote:
>> From: zhouyuhang <zhouyuhang@kylinos.cn>
>>
>> The libcap commit aca076443591 ("Make cap_t operations thread safe.") 
>> added a
>> __u8 mutex at the beginning of the struct _cap_struct,it changes the 
>> offset of
>> the members in the structure that breaks the assumption made in the 
>> "struct libcap"
>> definition in clone3_cap_checkpoint_restore.c.So use the capget and 
>> capset syscall
>> directly and remove the libcap library dependency like the commit 
>> 663af70aabb7
>> ("bpf: selftests: Add helpers to directly use the capget and capset 
>> syscall") does.
>>
>
> NIT: grammar and comma spacing. Please fix those for readability.
> e.g: Change "struct _cap_struct,it" to "struct _cap_struct, it"
> Fix others as well.
>

Thanks, I'll fix it in V2


>> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
>> ---
>>   tools/testing/selftests/clone3/Makefile       |  1 -
>>   .../clone3/clone3_cap_checkpoint_restore.c    | 60 +++++++++----------
>>   2 files changed, 28 insertions(+), 33 deletions(-)
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
>> index 3c196fa86c99..111912e2aead 100644
>> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>> @@ -15,7 +15,7 @@
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <stdbool.h>
>> -#include <sys/capability.h>
>> +#include <linux/capability.h>
>>   #include <sys/prctl.h>
>>   #include <sys/syscall.h>
>>   #include <sys/types.h>
>> @@ -27,6 +27,13 @@
>>   #include "../kselftest_harness.h"
>>   #include "clone3_selftests.h"
>>   +#ifndef CAP_CHECKPOINT_RESTORE
>> +#define CAP_CHECKPOINT_RESTORE 40
>> +#endif
>> +
>
> Why is this necessary? This is defined in linux/capability.h.
>
>> +int capget(cap_user_header_t header, cap_user_data_t data);
>> +int capset(cap_user_header_t header, const cap_user_data_t data);
>
> In general prototypes such as these should be defined in header
> file. Why are we defining these here?
>
> These are defined in sys/capability.h
>
> I don't understand this change. You are removing sys/capability.h
> which requires you to add these defines here. This doesn't
> sound like a correct solution to me.
>

I tested it on my machine without libcap-dev installed, the 
/usr/include/linux/capability.h

is on this machine by default. Successfully compiled using #include 
<linux/capability.h>

but not with #include <sys/capability.h>. This patch removes libcap 
library dependencies.

And we don't use any part of sys/capability.h other than these two 
syscalls. So I think that's why it's necessary.


>> +
>>   static void child_exit(int ret)
>>   {
>>       fflush(stdout);
>> @@ -87,47 +94,36 @@ static int test_clone3_set_tid(struct 
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
>
> thanks,
> -- Shuah


