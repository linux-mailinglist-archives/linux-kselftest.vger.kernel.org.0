Return-Path: <linux-kselftest+bounces-40668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0F7B41110
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 01:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F0F5E6E97
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F1F2EAB82;
	Tue,  2 Sep 2025 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="a3EkTwFR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D202277CB6;
	Tue,  2 Sep 2025 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857461; cv=none; b=tx7oCmggObodO8zxlJSX1PW8F47F64Uuy6DmTGL6bG+WjPNJjq94ud9XDwyRognrd36g9M1f5B+FjnApyqC+jA+6h+qObGphneBakODILHkavZuhcUdBioAwcfEJSIfgbEJNHgWJkCD3Q3ymO3VJRkQ1+GevJsjU/ymwna0ubWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857461; c=relaxed/simple;
	bh=UKRV8zqIZvmEUKJw7/IUU3WRzDcW6oHIiaAA/kuvLgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmGrXnRF5w43sQGUKOjVAwgpDCSaZsYxn/FRyMZmYvpt+QJXCT5If0KYeOyaRlRVxtIvL3cb4kwcPE47UT2gJYSNRFK7LrUktnzEP70f29U4QviYkbK133e4zRlB05JRrFbYF0OeyKwP7tsSde9ivfPZ7HHDCmNAr1hIt4ldciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=a3EkTwFR; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756857456;
	bh=F2obJWGDhr+R33s1tIhyS3cq15WFRqq0Gm0kntRQQvQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a3EkTwFR9uZ1NGMJ05FzHEwjY/R6oL9bCDgzbb8jBIfJ1BB1WLE+MhEPUxZGws9+R
	 aOxgAUwz0Jooc10CQg9HYTVBexyOha7e/E8z0mrfCXce1E+LksXUk4hL6v7edznpt4
	 uDGnqBbs3F7GElqYc/dFkFMNA0ezhyG9isyd3D2E=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id C493BE26; Wed, 03 Sep 2025 07:49:09 +0800
X-QQ-mid: xmsmtpt1756856949tpmm49ws0
Message-ID: <tencent_C34BE7725EE5E7556B540B91C3A05E083D05@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCQR1bTXfLR1W02/D0qL61NJCdby35Lb/mvilCAmZEgHPfeIw1G8
	 pQ478bblMfWiK1MgML23lts38Y7fgTHwh8b6F0SEyaiEfDPiZX4i8BWpj4TpnDErSOB4gxmX5H1N
	 5kiIPCQwLYJ+YYJYgilHKkK09UAHC7BcLprxNNHVdwis58CCgNv0TKAJdcpkNuxDVyg0KmD8Oiey
	 pqbBLCAXMNhWzlexB8fEe+RxKaD27ZYu2t+J7ZQeJ7b+EHErnZoT+PjFxSnAgFRXhaG/w+p5GEwd
	 OhUB5F0FTLUDgtvu23+oej+6noLGPVeeQo3yHDRQWFEEhOH0TQxb7mgGWvQK7P0IX5eCbyO4aC0O
	 587V2aKvOthYgjYHhjttBLj6ZKYEBZovgm8InTNbpVrcmBp8h68ehqmbtKxIkmK5WBi4zwtFAEQc
	 pkBbIiOenGAKi+cmW8RTqXDxztd1giNdz21kAJ90SdoLNYUZHYTf4/vtxEVJLpc5+PxhL+ZUPssJ
	 gxAmO0tzaButi458PCfbCLuURgaMWOmKf7BSaPEKijngrhIecMATxwj6F//ZcHP8Tak4I6fU2y4n
	 OofezAGaDwPlX+sNV+Sv2s7lH9ivUjpzXFGvrfAWPlyEWGle+ICtNt1QD0N9DauaIjCnFZQZRPmc
	 d19CLhRDOKKevqWb3WBb72dBOmyvy4hLQCY3bYllGDWMjrYz6uFLnGA1mBOEfRmAsTQvJR3T2lIU
	 n5qBTXFGkMpUXBVNaEFlYmNnY8gwsCZqN5koiujbZ8bglFxFCPKT4M7MZJyhO4b2AfmJV2fkyis7
	 EpJwN3mA5x+Zzw8PiIaDpx/QTXvr0otsPXrEFN0O8qMDlzC2vHaaqf5poaPQk/r2QJmnzTL1+waC
	 05G9SLcAIjQ4EQfBRchn0DrAeuYiWCZfMVTuj14JxM5tOvV6HGPCfCC9p5mbhBsocOppf9kwa9fn
	 GtyTOHiny0V/y+oSXTnilA/A0GrAW2qo+aYWSf6dJvliQjpsM9wUfAiF6ElcbbALSr13HzZxs3u0
	 h1cpmXkzfmisz26mTO582A/tPDm1I=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <9322fc15-794d-42e2-89f6-9dba9f5068b4@foxmail.com>
Date: Wed, 3 Sep 2025 07:49:09 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strcasecmp kfunc
To: Yonghong Song <yonghong.song@linux.dev>, andrii@kernel.org,
 ast@kernel.org, vmalik@redhat.com
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1756804522.git.rtoax@foxmail.com>
 <tencent_0E0C830021A02CBCCB6D95AE57CFD100C407@qq.com>
 <e960900d-3811-4b8b-b4b3-bb23048ef5d6@linux.dev>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <e960900d-3811-4b8b-b4b3-bb23048ef5d6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/3/25 00:54, Yonghong Song wrote:
>
>
> On 9/2/25 2:19 AM, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> bpf_strcasecmp() function performs same like bpf_strcmp() except 
>> ignoring
>> the case of the characters.
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>   kernel/bpf/helpers.c | 68 +++++++++++++++++++++++++++++++-------------
>>   1 file changed, 48 insertions(+), 20 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 401b4932cc49..238fd992c786 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3349,45 +3349,72 @@ __bpf_kfunc void __bpf_trap(void)
>>    * __get_kernel_nofault instead of plain dereference to make them 
>> safe.
>>    */
>>   -/**
>> - * bpf_strcmp - Compare two strings
>> - * @s1__ign: One string
>> - * @s2__ign: Another string
>> - *
>> - * Return:
>> - * * %0       - Strings are equal
>> - * * %-1      - @s1__ign is smaller
>> - * * %1       - @s2__ign is smaller
>> - * * %-EFAULT - Cannot read one of the strings
>> - * * %-E2BIG  - One of strings is too large
>> - * * %-ERANGE - One of strings is outside of kernel address space
>> - */
>> -__bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>> +int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>
> The function __bpf_strcasecmp should be a static function.

Thanks a lot, I just add 'static' and tested it, submit V4, please review.

Rong Tao

>
>>   {
>>       char c1, c2;
>>       int i;
>>   -    if (!copy_from_kernel_nofault_allowed(s1__ign, 1) ||
>> -        !copy_from_kernel_nofault_allowed(s2__ign, 1)) {
>> +    if (!copy_from_kernel_nofault_allowed(s1, 1) ||
>> +        !copy_from_kernel_nofault_allowed(s2, 1)) {
>>           return -ERANGE;
>>       }
>>         guard(pagefault)();
>>       for (i = 0; i < XATTR_SIZE_MAX; i++) {
>> -        __get_kernel_nofault(&c1, s1__ign, char, err_out);
>> -        __get_kernel_nofault(&c2, s2__ign, char, err_out);
>> +        __get_kernel_nofault(&c1, s1, char, err_out);
>> +        __get_kernel_nofault(&c2, s2, char, err_out);
>> +        if (ignore_case) {
>> +            c1 = tolower(c1);
>> +            c2 = tolower(c2);
>> +        }
>>           if (c1 != c2)
>>               return c1 < c2 ? -1 : 1;
>>           if (c1 == '\0')
>>               return 0;
>> -        s1__ign++;
>> -        s2__ign++;
>> +        s1++;
>> +        s2++;
>>       }
>>       return -E2BIG;
>>   err_out:
>>       return -EFAULT;
>>   }
>>   +/**
>> + * bpf_strcmp - Compare two strings
>> + * @s1__ign: One string
>> + * @s2__ign: Another string
>> + *
>> + * Return:
>> + * * %0       - Strings are equal
>> + * * %-1      - @s1__ign is smaller
>> + * * %1       - @s2__ign is smaller
>> + * * %-EFAULT - Cannot read one of the strings
>> + * * %-E2BIG  - One of strings is too large
>> + * * %-ERANGE - One of strings is outside of kernel address space
>> + */
>> +__bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>> +{
>> +    return __bpf_strcasecmp(s1__ign, s2__ign, false);
>> +}
>> +
>> +/**
>> + * bpf_strcasecmp - Compare two strings, ignoring the case of the 
>> characters
>> + * @s1__ign: One string
>> + * @s2__ign: Another string
>> + *
>> + * Return:
>> + * * %0       - Strings are equal
>> + * * %-1      - @s1__ign is smaller
>> + * * %1       - @s2__ign is smaller
>> + * * %-EFAULT - Cannot read one of the strings
>> + * * %-E2BIG  - One of strings is too large
>> + * * %-ERANGE - One of strings is outside of kernel address space
>> + */
>> +__bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char 
>> *s2__ign)
>> +{
>> +    return __bpf_strcasecmp(s1__ign, s2__ign, true);
>> +}
>> +
>>   /**
>>    * bpf_strnchr - Find a character in a length limited string
>>    * @s__ign: The string to be searched
>> @@ -3832,6 +3859,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, 
>> KF_ITER_DESTROY | KF_SLEEPABLE)
>>   #endif
>>   BTF_ID_FLAGS(func, __bpf_trap)
>>   BTF_ID_FLAGS(func, bpf_strcmp);
>> +BTF_ID_FLAGS(func, bpf_strcasecmp);
>>   BTF_ID_FLAGS(func, bpf_strchr);
>>   BTF_ID_FLAGS(func, bpf_strchrnul);
>>   BTF_ID_FLAGS(func, bpf_strnchr);
>


