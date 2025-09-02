Return-Path: <linux-kselftest+bounces-40513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470D1B3F656
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CD8189911F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 07:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8872E62CE;
	Tue,  2 Sep 2025 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="be9OdOMp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A2E1E868;
	Tue,  2 Sep 2025 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797293; cv=none; b=lIzoULCA6cg0/UBVgG8ategExfM1lhAYyyPShKAPTxdk45H2eRqjgmE10nGeTV8kiR5jORhsfiJg6H53sLuTXpTbifhlMQHK9Dg4wMQSnMnkZKWq+rDV1zk9auKAEbyn0hAbWTewER/mlxzslieZGOdEfaj8wjly3IKYobfQ0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797293; c=relaxed/simple;
	bh=5m4wuX0ixnq+slRI1bqds2dMb7HFvtC25MMn9M8I97A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUIKysr7Uk7zQuhANXBtvIaqaAHATRVmmlZCMd2zfs2dJqHlBmVpIRKKGD36kl/Iye/aWWwiQ661t/Qkg33gwQiCvgXChWlhLSu/0BjStZZrIk/+TqSHLrmJOJcQFgAk9xwiD9ON2rHd+I9nZSWKZRA5/nJKV+DIgWyLN9BgMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=be9OdOMp; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756797287;
	bh=vkRxsIhq4dcGKVqQeGmjXbG+Rq+X2vu/ATof8Ui5CQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=be9OdOMpgR+q3S/45tqc41rjN2Um1nZjL44WjlcCJ2ktM6AZ3cNX8s4Hpfz5FcQlM
	 ZJkTivOnbao1gMto9syQJF54ThBTeS7LY0dSyxSqXElXDy1tWj8cH7pm+14I0K1I9F
	 fF+2cN4m2zSjIiwoZVa6Lv0lGpIASGbh/US0IxWY=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 3ABB3CC5; Tue, 02 Sep 2025 15:14:43 +0800
X-QQ-mid: xmsmtpt1756797283tzhqdj16h
Message-ID: <tencent_AC7510F30CC28482B2982E5155905F634609@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwe9m5YIvRivMiHRdlMMnyPKmQre95qFh77h8Op8e/pUczjzqXjd
	 fpuL7Nr8Vm4SJ0FdvQgLrW4wVBzqdQ2TDpvo03Sfhq0VFpWx/+FuXX3VTpHB+6tnFw38TlJsdu4X
	 GK3A8eyF+KLgc9fTyYPF+piiMF1A2kEwAffUcHkDOcWdBHvZ2NHp1r+AOyb146yTwgxPFFwASCqx
	 v4xvul6uW6jU4yRrea2i5qooVXRNma/MPju8u1lspoHKvODH+C1O/ftJ1HV51wqaxCJL0RgUyVDB
	 7iNDUS32cJcTkeRcoyW2EuakvIhlnR1xAIMrW2x0r3LN+aMjBGL9GfWGEKcU/Gh58656/Bg6MZCM
	 PY0BIEfBuIbpEjTaS2B5WXd4srOo3FQGdbDQxGnrpPN1H/2D4B0XirGX7ntlIcbssy+CnxJ4VvtL
	 nutGHn+67i6U3RIZFElSaWfc24PhNHXFv54MvdLDEoS/5Hh4qtPGJlNLWP+2woIgj8cjgFBkvLM6
	 N6OI8wOz7ScMeu4WZdYqBdCROkFmHB/oP/RIqL5E1rn1rtdBjpHj3GC5vTQtQVF75ZwzYZBnBggR
	 tf74sQoGLbOJZ8nxHKVbS4FOYvr96OCNrFRVcbP1WYYY4hCGCidBYYlXHlbrY7Rhb74ZwDgbn3W8
	 ExQrw/iUkDLynJPf094YyQxOPdqznc9dbgJ8tA3MvNQOnEbmrAz8SL7CS6bqledT2xsTsOX/tXkv
	 y8SY6a5nujuq8b8x+8bQVgBcsFtQ+1KhZ1NEZM7dJ5jCPOIZL2xwbqtcL/mmHY+nWAYXMGiFsMng
	 CkueBhKs3tbGMdKQYJBcD3LYISZhub6FIA4akdHa0bbnuh7J+oI6Kn1EYIu4PEofH+GZtyjyP3TZ
	 OaBWy3R2xClLVWvjpiK22+eavB+4ZFC8JQlMph8yEt9E/M3GfrIsr33520o3Co8ScgvSgWmAUKuk
	 JUAZq4AbxHCHK2uHQvMN3jZI7AHZj6UUuLkpEB5IWqMCnFzGv7FGKkrOD/AwjJZyd0326V/Ffzcc
	 5bX0mEiw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <9e482067-14c0-48c5-87d2-8aedf2128d66@foxmail.com>
Date: Tue, 2 Sep 2025 15:14:43 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strcasecmp kfunc
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
References: <cover.1756793624.git.rongtao@cestc.cn>
 <tencent_5AE811A28781BE106AD6CDE59F4ADD2BFA06@qq.com>
 <f0194235-19ae-43de-b73d-b2d8b7f77035@redhat.com>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <f0194235-19ae-43de-b73d-b2d8b7f77035@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/2/25 15:08, Viktor Malik wrote:
> On 9/2/25 08:17, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> bpf_strcasecmp() function performs same like bpf_strcmp() except ignoring
>> the case of the characters.
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>   kernel/bpf/helpers.c | 56 +++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 42 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 401b4932cc49..e807a708e5fc 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3349,20 +3349,7 @@ __bpf_kfunc void __bpf_trap(void)
>>    * __get_kernel_nofault instead of plain dereference to make them safe.
>>    */
>>   
>> -/**
>> - * bpf_strcmp - Compare two strings
>> - * @s1__ign: One string
>> - * @s2__ign: Another string
>> - *
>> - * Return:
>> - * * %0       - Strings are equal
>> - * * %-1      - @s1__ign is smaller
>> - * * %1       - @s2__ign is smaller
>> - * * %-EFAULT - Cannot read one of the strings
>> - * * %-E2BIG  - One of strings is too large
>> - * * %-ERANGE - One of strings is outside of kernel address space
>> - */
>> -__bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>> +int __bpf_strcasecmp(const char *s1__ign, const char *s2__ign, bool ignore_case)
> No need to use the `__ign` suffix here.

Viktor, Thanks for your review, i'll submit v2 soon.

Rong Tao

>
> Otherwise LGTM. I guess that it could be useful in some applications.
>
> Viktor
>
>>   {
>>   	char c1, c2;
>>   	int i;
>> @@ -3376,6 +3363,10 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>>   	for (i = 0; i < XATTR_SIZE_MAX; i++) {
>>   		__get_kernel_nofault(&c1, s1__ign, char, err_out);
>>   		__get_kernel_nofault(&c2, s2__ign, char, err_out);
>> +		if (ignore_case) {
>> +			c1 = tolower(c1);
>> +			c2 = tolower(c2);
>> +		}
>>   		if (c1 != c2)
>>   			return c1 < c2 ? -1 : 1;
>>   		if (c1 == '\0')
>> @@ -3388,6 +3379,42 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>>   	return -EFAULT;
>>   }
>>   
>> +/**
>> + * bpf_strcmp - Compare two strings
>> + * @s1__ign: One string
>> + * @s2__ign: Another string
>> + *
>> + * Return:
>> + * * %0       - Strings are equal
>> + * * %-1      - @s1__ign is smaller
>> + * * %1       - @s2__ign is smaller
>> + * * %-EFAULT - Cannot read one of the strings
>> + * * %-E2BIG  - One of strings is too large
>> + * * %-ERANGE - One of strings is outside of kernel address space
>> + */
>> +__bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>> +{
>> +	return __bpf_strcasecmp(s1__ign, s2__ign, false);
>> +}
>> +
>> +/**
>> + * bpf_strcasecmp - Compare two strings, ignoring the case of the characters
>> + * @s1__ign: One string
>> + * @s2__ign: Another string
>> + *
>> + * Return:
>> + * * %0       - Strings are equal
>> + * * %-1      - @s1__ign is smaller
>> + * * %1       - @s2__ign is smaller
>> + * * %-EFAULT - Cannot read one of the strings
>> + * * %-E2BIG  - One of strings is too large
>> + * * %-ERANGE - One of strings is outside of kernel address space
>> + */
>> +__bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
>> +{
>> +	return __bpf_strcasecmp(s1__ign, s2__ign, true);
>> +}
>> +
>>   /**
>>    * bpf_strnchr - Find a character in a length limited string
>>    * @s__ign: The string to be searched
>> @@ -3832,6 +3859,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>>   #endif
>>   BTF_ID_FLAGS(func, __bpf_trap)
>>   BTF_ID_FLAGS(func, bpf_strcmp);
>> +BTF_ID_FLAGS(func, bpf_strcasecmp);
>>   BTF_ID_FLAGS(func, bpf_strchr);
>>   BTF_ID_FLAGS(func, bpf_strchrnul);
>>   BTF_ID_FLAGS(func, bpf_strnchr);


