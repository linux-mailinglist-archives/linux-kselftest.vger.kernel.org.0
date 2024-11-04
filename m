Return-Path: <linux-kselftest+bounces-21360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EED9BAD8C
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 09:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F5B1C20FE6
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4DC198E81;
	Mon,  4 Nov 2024 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CGXmNwY9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1DF18CC19;
	Mon,  4 Nov 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707210; cv=none; b=dR2eI6zNS3uJfQjAfO1Z8/WBcDKeyCcIv8qjs3Rfy1864n1V7NjCPN9RO4D8L8wIt7GF6ogFqSQ+DVEk8eKLCOE6yegVtALoKOPqfRTbSo3G8Vt+UUZCyyGb7QnlGIGkeXBh0wyAaQIAZzq+c4qq69FipRYI5r4islNNEkmWUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707210; c=relaxed/simple;
	bh=Jt6/Lrt0MfuL4xVHCjftvxo3kTwH0MyvjmEzBIVOtkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaIJtj/LvWbBfgtzR+N/aYLT+AOhwQ7/Xq49sxIwvxYws/csiZEQGbtM37XrMxudPueEXYE2AHS9PEyUr8MWXP1pksjDKF36oOXC0SRlHM1+0WJQ+hIy2FNv762EV6zuhe9jVqzjNitgg6uJo6TWQqLVfPax8ays4pEjj9DPURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CGXmNwY9; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=wE868tuc8XCTOH7v+BH7jK1IlR5WNOMP0hhNqPWlPE8=;
	b=CGXmNwY9Ic4KuKM1CED19AcaVJbevc4+H8fl1+smvYFBDrOFTDvSIuh1XwAhhy
	HQzld2oL5wVK5CHHamWS8rxSpFeDUEmW8cJ/3gAsrDytFB8Tx7pwtkCd14xAnoxo
	CG6N6RrOzRWoP4zY9cCw7dWbuA+2CvdmVLYxohjss9xHs=
Received: from [10.42.12.92] (unknown [111.48.69.246])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3H6X4fihnBQb9Ew--.3801S2;
	Mon, 04 Nov 2024 15:59:53 +0800 (CST)
Message-ID: <b51c56a5-ddcf-4769-a091-0530aff8a3b3@163.com>
Date: Mon, 4 Nov 2024 15:59:52 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: clone3: Use the capget and capset syscall
 directly
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>, brauner@kernel.org,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhouyuhang <zhouyuhang@kylinos.cn>
References: <20241030025045.1156941-1-zhouyuhang1010@163.com>
 <703c3b4f-399c-45a5-a1e1-45c628fb94fb@linuxfoundation.org>
From: zhouyuhang <zhouyuhang1010@163.com>
In-Reply-To: <703c3b4f-399c-45a5-a1e1-45c628fb94fb@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3H6X4fihnBQb9Ew--.3801S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww4xXr1fZr17KF1rtw15XFb_yoW3Jw4DpF
	Z5Zrs8KFs8Wr1xGFWFvw1DuF10yFyrXr17Jw4UA3W5Cr1akr18tr4Ik3Wjg3Wj9a98Za1F
	qF4Utan3uFyDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jafOrUUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiRRyNJmcoeWWJiwAAsj



在 2024/11/1 06:59, Shuah Khan 写道:
> On 10/29/24 20:50, zhouyuhang wrote:
>> From: zhouyuhang <zhouyuhang@kylinos.cn>
>>
>> The libcap commit aca076443591 ("Make cap_t operations thread safe.")
>> added a __u8 mutex at the beginning of the struct _cap_struct, it 
>> changes
>> the offset of the members in the structure that breaks the assumption
>> made in the "struct libcap" definition in 
>> clone3_cap_checkpoint_restore.c.
>> This will cause the test case to fail with the following output:
>>
>>   #  RUN           global.clone3_cap_checkpoint_restore ...
>>   # clone3() syscall supported
>>   # 
>> clone3_cap_checkpoint_restore.c:151:clone3_cap_checkpoint_restore:Child 
>> has PID 130508
>>   cap_set_proc: Operation not permitted
>
> Sounds like EPERM is returned here. What's the error number from
> cap_set_proc().

Yes, cap_set_proc returns -EPERM here.

>
>>   # 
>> clone3_cap_checkpoint_restore.c:160:clone3_cap_checkpoint_restore:Expected 
>> set_capability() (-1) == 0 (0)
>
> What's the error number here? Looks like this test simply
> uses perror - it is better to use strerror() which includes
> the error number.
>
> Is this related EPERM?

set_capability always returns -1 on failure, which is not related to EPERM.
Here I'll take your advice and use strerror and let set_capability 
return the actual error code.

>
>>   # 
>> clone3_cap_checkpoint_restore.c:161:clone3_cap_checkpoint_restore:Could 
>> not set CAP_CHECKPOINT_RESTORE
>>   # clone3_cap_checkpoint_restore: Test terminated by assertion
>>   #          FAIL  global.clone3_cap_checkpoint_restore
>>
>> Changing to using capget and capset syscall directly here can fix 
>> this error,
>> just like what the commit 663af70aabb7 ("bpf: selftests: Add helpers 
>> to directly
>> use the capget and capset syscall") does.
>
> Is this still accurate for v3 - Does this patch match the
> bpf commit?
>
> What is the output with this patch? Include it in the change log.
>

I think it's a match. The main code has not changed from v1 to v3.
The comment at the beginning of this file says "capabilities related code
based on selftests/bpf/test_verifier.c" and we only need capget and capset,
this is the same as the bpf commit.

The output is as follows:

  #  RUN           global.clone3_cap_checkpoint_restore ...
  # clone3() syscall supported
  # 
clone3_cap_checkpoint_restore.c:147:clone3_cap_checkpoint_restore:Child 
has PID 18631
  # 
clone3_cap_checkpoint_restore.c:91:clone3_cap_checkpoint_restore:[18630] 
Trying clone3() with CLONE_SET_TID to 18631
  # 
clone3_cap_checkpoint_restore.c:58:clone3_cap_checkpoint_restore:Operation 
not permitted - Failed to create new process
  # 
clone3_cap_checkpoint_restore.c:93:clone3_cap_checkpoint_restore:[18630] 
clone3() with CLONE_SET_TID 18631 says:-1
  # 
clone3_cap_checkpoint_restore.c:91:clone3_cap_checkpoint_restore:[18630] 
Trying clone3() with CLONE_SET_TID to 18631
  # clone3_cap_checkpoint_restore.c:73:clone3_cap_checkpoint_restore:I 
am the parent (18630). My child's pid is 18631
  # clone3_cap_checkpoint_restore.c:66:clone3_cap_checkpoint_restore:I 
am the child, my PID is 18631 (expected 18631)
  # 
clone3_cap_checkpoint_restore.c:93:clone3_cap_checkpoint_restore:[18630] 
clone3() with CLONE_SET_TID 18631 says:0
  #            OK  global.clone3_cap_checkpoint_restore
  ok 1 global.clone3_cap_checkpoint_restore
  # PASSED: 1 / 1 tests passed.

>>
>> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>> ---
>
> Please mention the changes from v2 to v3 here so it makes it
> easier for reviewers associating the changes to the reviewer.
>
> I had to go look up v1 and v2.
>

Sorry, I'm not very familiar with this.
The changes from v1 to v3 mainly removed the locally declared
capget and capset system calls. Perhaps you still have an impression of 
this.

---
v3:
     * Remove locally declared system calls and retained the - lcap in 
the Makefile.
v2:
     * Move locally declared system calls to header file.
v1:
     * Directly using capget and capset and declare them locally.
---

>> .../clone3/clone3_cap_checkpoint_restore.c    | 58 +++++++++----------
>>   1 file changed, 27 insertions(+), 31 deletions(-)
>>
>> diff --git 
>> a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c 
>> b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>> index 3c196fa86c99..8b61702bf721 100644
>> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>> @@ -27,6 +27,13 @@
>>   #include "../kselftest_harness.h"
>>   #include "clone3_selftests.h"
>>   +/*
>> + * Prevent not being defined in the header file
>> + */
>> +#ifndef CAP_CHECKPOINT_RESTORE
>> +#define CAP_CHECKPOINT_RESTORE 40
>> +#endif
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
>
> cap_validate_magic() handles _LINUX_CAPABILITY_VERSION_1,
> _LINUX_CAPABILITY_VERSION_2, and _LINUX_CAPABILITY_VERSION_3
>
> It would help to add a comment on why it is necessary to
> set the version here.

CAP_CHECKPOINT_RESTORE is greater than 32, using _LINUX_CAPABILITY_VERSION_1
here causes the kernel to copy only data[0] and ignore data[1], which 
invalidates the
CAP_CHECKPOINT_RESTORE setting.
_LINUX_CAPABILITY_VERSION_2 has already been deprecated.

>
>> +    };
>> +    __u32 cap0 = 1 << CAP_SETUID | 1 << CAP_SETGID;
>> +    __u32 cap1 = 1 << (CAP_CHECKPOINT_RESTORE - 32);
>
> Explain why this is necessary - a comment will help future
> maintenance of this code.
>

CAP_CHECKPOINT_RESTORE is greater than 32, so we need two u32.
They will be combined into a u64 in mk_kernel_cap.
I'll add a few comments above and here.

Thank you very much for the above advice.
I'll make changes in v4.

>> +    int ret;
>> +
>> +    ret = capget(&hdr, data);
>> +    if (ret) {
>> +        perror("capget");
>
>
>>           return -1;
>>       }
>>         /* Drop all capabilities */
>> -    if (cap_clear(caps)) {
>> -        perror("cap_clear");
>> -        goto out;
>> -    }
>> -
>> -    cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_values, CAP_SET);
>> -    cap_set_flag(caps, CAP_PERMITTED, 2, cap_values, CAP_SET);
>> +    memset(&data, 0, sizeof(data));
>>   -    cap = (struct libcap *) caps;
>> +    data[0].effective |= cap0;
>> +    data[0].permitted |= cap0;
>>   -    /* 40 -> CAP_CHECKPOINT_RESTORE */
>> -    cap->data[1].effective |= 1 << (40 - 32);
>> -    cap->data[1].permitted |= 1 << (40 - 32);
>> +    data[1].effective |= cap1;
>> +    data[1].permitted |= cap1;
>>   -    if (cap_set_proc(caps)) {
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


