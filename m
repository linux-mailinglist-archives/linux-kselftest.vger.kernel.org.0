Return-Path: <linux-kselftest+bounces-40538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F91AB3FA19
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39AF67A423D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7A12DFA2B;
	Tue,  2 Sep 2025 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="SkjgygrE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051127466D;
	Tue,  2 Sep 2025 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804903; cv=none; b=ftJGn4cFrhPmjUnFn5Ko4ZrFFpvliY8WYPZurNLOaCQ/aLJ8FXWvxJ7N1jenF3toMkqB7CSZbLo5gQIhbJrlny5AH/AOgS2zHuyjOsMQwOD/3V5qJMO161R9PhVFYUtVmnEWwtfsKf75uogQkmyKHCeg3mLNi90nCLXh9kjr4CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804903; c=relaxed/simple;
	bh=fJ+8zjPxcFduC8vpbJmpStNAHjNkgFzRwt6qlypCTVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfOO+/GNkerEu22/WUx8jWN2vVtjOou1KZX3NSFeM5Kf9TImFkLvQMCab4RoK7VWUUOP0aoTKrojFHNgbkMHPPNgUROpsVGleoYvtvEH3CJCY5fYjF7LmMG6B39RK/60Pgu1ioQl72jS8wJpLCDfK8fiwR8F1Hmn6JPi80dQSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=SkjgygrE; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756804898;
	bh=OxpOJmhECTdLgWfX9uIafSF9DcEyP9WjBjiAh0oefRo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SkjgygrEtp/z3arybBz0wD8TZ9nJJVFCskkBxKWTV4Ucl+viBHNQ6fEFhgnUGCkb0
	 43MkSXwYN1sEz4lC0VfGTuurpOl9OFvKfhn0XXAHsJxLQu4OdlEPbYGX7fcfivANFw
	 71QO72QSUN2oLVfAcV2uZQRe5MQgw+uLzX/z2Kac=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 56221432; Tue, 02 Sep 2025 17:21:34 +0800
X-QQ-mid: xmsmtpt1756804894t1p04q3ox
Message-ID: <tencent_A364CD5CCEAA68BD7E8CAA2092180409150A@qq.com>
X-QQ-XMAILINFO: NwU6Bou9okj/tbdOQoNWWLVwvWA8HB3wvWH6M8x+KFoP19lo9jLr+KYnags3Dx
	 0SBm2+jH32YP8CngseKDGiIXeqNrBC7JVCTwwTShVUHDzd7d0t7QC57O/sPXUPNnNiNotl329G4y
	 G900N+YePazTIfBf9bj+kybeVIVEqJnn15wq/75NMzn5nOv97E4IhfR1/dL2VvfgsZ7I7TY5NtXG
	 QFKZ+hlY42JK9MP459rkbBHAVu/Geh/OmQMRViAA/7dsmclgBuIdw/71hQ8ztxM3Lj56AF4rwJIS
	 l9WKiK1NYIL1lKoAcSe3KxDeBGsMhQ6aVgn4X7oaVVhUqMoxwKyX9UyvjK66cybHwDaBC31n5Xh2
	 JF3nUXv06/O7tYZWXJ2T/Uop4/sywRVWxySf/ShV7/rH3FswuRtjTg0ZR7SL5frT7vmfTUldyqWo
	 hmLT/3c6tRWjTvFlG40NGib5l/yS9Xe6o3h2h0Jt73eFIqMPy6LH9Rt75zW9rAvw5ROfnAB/COZh
	 SHG/lFGWNpgQ0Qqa2n6NI5MYBhmBlmKgb3C6nQiVR3dk+xdnJ/gmUpu4Ah8XeaMXzsJi3RFDqtWw
	 aQUDQ/6q0aHgDPLiebE474Efik6bTu9WpyWFlYgazp/wbHA52hwqVefo3Xi26sYPPgGE9Qj+D5w5
	 bIcAoE0irshIZVsgmL5EqHtCexFwz7jNK7xJH0rGGr5u38Do7e5MI/5elapTWUMGyhlxzIWzaRJC
	 t7PVuBr+vL1JlOhQTCe95zRwfELp4TWihUQtAzMlNhbEvZuYOxL89s//W/REc+mh0AdLG3SVwIvC
	 6ABODXpbNokYC4YazA+4prY+aqtM2FxeFmpp2jApjr3mq5fdb3JBQmQYKQtKNyU5SyMSJEYKFwMI
	 05JSGWsslwHS0pC2Jbo52MFSG4iCc/5Jmdg5C3Wx8gh7W42rN5BEviukGTTFJt4JVQAhR6uKfIZ0
	 Xg9ljZgzOMQUDHFhnZQ408SUqdcM/yjtW/QJEGsKaVJvKb+kYQEV0bDxEXBfi742ETtXOuNxeN+j
	 8dl4Gz1Wbq356nqOpPZukMIlo6THP38migzckgqkJDzR6X2VK8t6k0KLz6y7Y=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <4e5f23c2-32f8-4c6a-a4f3-f92b52007fbb@foxmail.com>
Date: Tue, 2 Sep 2025 17:21:33 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test kfunc bpf_strcasecmp
To: Viktor Malik <vmalik@redhat.com>, andrii@kernel.org, ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1756798860.git.rtoax@foxmail.com>
 <tencent_00107416F7259ACAC62BF8681F22B5C19D06@qq.com>
 <76f6ed83-48a2-4dad-9229-1169050e9552@redhat.com>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <76f6ed83-48a2-4dad-9229-1169050e9552@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/2/25 16:56, Viktor Malik wrote:
> On 9/2/25 09:55, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> Add testsuites for kfunc bpf_strcasecmp.
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>   tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c | 6 ++++++
>>   tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c | 1 +
>>   tools/testing/selftests/bpf/progs/string_kfuncs_success.c  | 5 +++++
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
>> index 53af438bd998..99d72c68f76a 100644
>> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
>> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
>> @@ -31,6 +31,8 @@ char *invalid_kern_ptr = (char *)-1;
>>   /* Passing NULL to string kfuncs (treated as a userspace ptr) */
>>   SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_null1(void *ctx) { return bpf_strcmp(NULL, "hello"); }
>>   SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
>> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_null1(void *ctx) { return bpf_strcasecmp(NULL, "HELLO"); }
>> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *ctx) { return bpf_strcasecmp("HELLO", NULL); }
>>   SEC("syscall")  __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) { return bpf_strchr(NULL, 'a'); }
>>   SEC("syscall")  __retval(USER_PTR_ERR)int test_strchrnul_null(void *ctx) { return bpf_strchrnul(NULL, 'a'); }
>>   SEC("syscall")  __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx) { return bpf_strnchr(NULL, 1, 'a'); }
>> @@ -49,6 +51,8 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return
>>   /* Passing userspace ptr to string kfuncs */
>>   SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
>>   SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr2(void *ctx) { return bpf_strcmp("hello", user_ptr); }
>> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr1(void *ctx) { return bpf_strcasecmp(user_ptr, "HELLO"); }
>> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr2(void *ctx) { return bpf_strcasecmp("HELLO", user_ptr); }
>>   SEC("syscall") __retval(USER_PTR_ERR) int test_strchr_user_ptr(void *ctx) { return bpf_strchr(user_ptr, 'a'); }
>>   SEC("syscall") __retval(USER_PTR_ERR) int test_strchrnul_user_ptr(void *ctx) { return bpf_strchrnul(user_ptr, 'a'); }
>>   SEC("syscall") __retval(USER_PTR_ERR) int test_strnchr_user_ptr(void *ctx) { return bpf_strnchr(user_ptr, 1, 'a'); }
>> @@ -69,6 +73,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { re
>>   /* Passing invalid kernel ptr to string kfuncs should always return -EFAULT */
>>   SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault1(void *ctx) { return bpf_strcmp(invalid_kern_ptr, "hello"); }
>>   SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault2(void *ctx) { return bpf_strcmp("hello", invalid_kern_ptr); }
>> +SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault1(void *ctx) { return bpf_strcasecmp(invalid_kern_ptr, "HELLO"); }
>> +SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault2(void *ctx) { return bpf_strcasecmp("HELLO", invalid_kern_ptr); }
>>   SEC("syscall") __retval(-EFAULT) int test_strchr_pagefault(void *ctx) { return bpf_strchr(invalid_kern_ptr, 'a'); }
>>   SEC("syscall") __retval(-EFAULT) int test_strchrnul_pagefault(void *ctx) { return bpf_strchrnul(invalid_kern_ptr, 'a'); }
>>   SEC("syscall") __retval(-EFAULT) int test_strnchr_pagefault(void *ctx) { return bpf_strnchr(invalid_kern_ptr, 1, 'a'); }
>> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
>> index 89fb4669b0e9..e41cc5601994 100644
>> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
>> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
>> @@ -7,6 +7,7 @@
>>   char long_str[XATTR_SIZE_MAX + 1];
>>   
>>   SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp(long_str, long_str); }
>> +SEC("syscall") int test_strcasecmp_too_long(void *ctx) { return bpf_strcasecmp(long_str, long_str); }
> This is not sufficient, you also need to update
> prog_tests/string_kfuncs.c so that the test case is actually triggered.
Thanks Viktor, sorry about that, I just submit v3, please review.
Rong Tao
>
> Viktor
>
>>   SEC("syscall") int test_strchr_too_long(void *ctx) { return bpf_strchr(long_str, 'b'); }
>>   SEC("syscall") int test_strchrnul_too_long(void *ctx) { return bpf_strchrnul(long_str, 'b'); }
>>   SEC("syscall") int test_strnchr_too_long(void *ctx) { return bpf_strnchr(long_str, sizeof(long_str), 'b'); }
>> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
>> index 46697f381878..67830456637b 100644
>> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
>> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
>> @@ -12,6 +12,11 @@ char str[] = "hello world";
>>   /* Functional tests */
>>   __test(0) int test_strcmp_eq(void *ctx) { return bpf_strcmp(str, "hello world"); }
>>   __test(1) int test_strcmp_neq(void *ctx) { return bpf_strcmp(str, "hello"); }
>> +__test(0) int test_strcasecmp_eq1(void *ctx) { return bpf_strcasecmp(str, "hello world"); }
>> +__test(0) int test_strcasecmp_eq2(void *ctx) { return bpf_strcasecmp(str, "HELLO WORLD"); }
>> +__test(0) int test_strcasecmp_eq3(void *ctx) { return bpf_strcasecmp(str, "HELLO world"); }
>> +__test(1) int test_strcasecmp_neq1(void *ctx) { return bpf_strcasecmp(str, "hello"); }
>> +__test(1) int test_strcasecmp_neq2(void *ctx) { return bpf_strcasecmp(str, "HELLO"); }
>>   __test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e'); }
>>   __test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\0'); }
>>   __test(-ENOENT) int test_strchr_notfound(void *ctx) { return bpf_strchr(str, 'x'); }


