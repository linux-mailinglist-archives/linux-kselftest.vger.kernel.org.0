Return-Path: <linux-kselftest+bounces-42801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D85A6BC00F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 05:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31891899DDA
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 03:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF95620296E;
	Tue,  7 Oct 2025 03:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MFp3sdQv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB541E25E3;
	Tue,  7 Oct 2025 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759806540; cv=none; b=fRa+BBM4mPBqqsxvwCFh1JHEkn2U2pOJWS3e5dLxd+MDGCF8dWp9OorwGw1tkvdWdUQBENRGjtF9cqoGxXV4+y5tAswcUdRJLAw9XExuj++OipxLYLJRibp0fsG6dCSLJYGzJz3jWNZmJTCTp5rnN3jAvqQmO+XOHnXKeVBu8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759806540; c=relaxed/simple;
	bh=jgICUWtPzkeiKLbWfzEgymYTFHrYqtGhRfEkmbgrZGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guOwZ2s24abzMfO8Ld1uXObdtN5iXgOxENrgqsNeem5PZTqD2Jr05w3+8XkqsFz7koxjJwgZJkmZGpbSoQJGKc585pADNXFdZI+92SAx8pEqUh05fHRZw9QbVMg8rF5wTbcGWxZivccrpxxdguRRlfu1fZgktJEB4dNVJAMeLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MFp3sdQv; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759806528;
	bh=7VGcpBpEmd76FllPkLbkoZa3URr6bWYKVX4gHzg/Gfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MFp3sdQv4dgAzCkEkpFbKamubZ7AvzIbs6QyKc7+SIaZLDSZkkN9W7VSIy6FZ/SNb
	 R0ZCX10WMwNyXhtY/4NGIRf0Tu4NOjemj+AqcZEHtvkFN+TiJudU+M8348d2Q9yrIB
	 BBcNcatfQQ7oWQk67Mvdi4el6ihhao5bmZCp/L5U=
Received: from [192.168.2.104] ([183.198.135.10])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id A228E81; Tue, 07 Oct 2025 11:02:34 +0800
X-QQ-mid: xmsmtpt1759806154tl5lfwz36
Message-ID: <tencent_F14B16E125884ADA6BE0E81BA295C181D006@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeXrGXEHeCn20GAoDgtD4FkAjBcIn5BeXaCIBnUeChU3qRMS4hx9
	 yL3TznmopCj0MGyBuALvabNBNIUISDk58YGEJW4Glw57jUUkPhXQUSkclaQXEmMNohUCgw+8KzwZ
	 NJpx/4T6RO4micp0cITnCvlw1CVeJQyxh2pmT4X+ThxrkZ3HRmK3jV6KEtQ3Vck5tx6Czas/JWzb
	 PRPWlMavD7U3mbbT0gqpJpfimeF5WLSuwn+0Vy6vreU4aX9ZKAumqtZv5dBrrke7Fbio5zC7vd3L
	 yHJAblA0PXyeXj+PpQCdg5dDkvEya8kpUZ1olLjj/9tmh+FvClh5JeqJk/imS8cpPNmbpH/9irP4
	 ukyYbNoOO9JCHW7St21ZUFnsektc3A60SE89kjH6N3RB3/IXec52BdS9G7uw2sd4F2oqdgIjRglT
	 CLG4WKk1Q55BGXabAPqtXRZjZhdG/m9C59SvLO0jFPNQMND0z/VQdJd6YLR9Eck6INmb/sAxk4HR
	 78FvsHoqLmod7mx5lC+gBYUSI99Ccl1BhwnKTd13jeh4JwUancdiKwu1m+s7RrkeIsNNHnXLZHsM
	 PBsc063TGFnejH6xV7hveaFrQLQmMvyEHqVqp4DIoH65bCm1o/6b6/L6qRUz7mfmdQgiq5DCNGTb
	 V/xPS9fnMbC2BFoh4nT38DfbvjSkuFiiYEV1kgHp3nFdnbcRbKIj32QLmsb2rwOqcUDmiDZq2RXU
	 /SzVxa9dGPAS+31onGcFxENOcJdD77zyfTblyMMpj+ahRs0TjRIEtsZfLeL9y/tJnDkBzBv+y52S
	 C+poPaW8uiK1THHfmls6PDXnQnyWD1kR89czHqUnG0IE6VkwB4yZakZpw+7oEK3ZUM+yqIKk2CWp
	 S8NJhzaMiQCxI84jUPfMJIcMACb/kae3RPb2InpGegiYOk3dPoGLyeqmRRgAdNPpUkD2O9yWL+aD
	 t9Ro+6xsJFPXnUNUvE/ZTiL/HGm2hrHcibgcYO2TeFdcpxnXLL/TG08Dgom7HxA0MWrlbHw3KfcY
	 Sn7a8yWVgyQaugMC6xvpgQOF4KELtWldYAtpiaf2X43vTCRJh6nsLsGRsBlO3vrwzpY8QRWA==
X-QQ-XMRINFO: NHo+0iP/cI22KKbm8YtzDH0=
X-OQ-MSGID: <ddb3f2b6-524f-47a5-b1a6-f8d07c9f6de5@foxmail.com>
Date: Tue, 7 Oct 2025 11:02:33 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test
 bpf_strcasestr,bpf_strncasestr kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>, vmalik@redhat.com, ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1759588929.git.rongtao@cestc.cn>
 <tencent_FC91DA604BE83F2BE3524865EA956DB41A05@qq.com>
 <405da03e33853622da3a70ad88df3396c85926e4.camel@gmail.com>
Content-Language: en-US
From: "rtoax@foxmail.com" <rtoax@foxmail.com>
In-Reply-To: <405da03e33853622da3a70ad88df3396c85926e4.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/7/25 8:29 AM, Eduard Zingerman wrote:
> On Sat, 2025-10-04 at 22:47 +0800, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> Add tests for new kfuncs bpf_strcasestr() and bpf_strncasestr().
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
>> index 2e3498e37b9c..d21330b4cc3b 100644
>> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
>> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
>> @@ -33,8 +33,12 @@ __test(11) int test_strnlen(void *ctx) { return bpf_strnlen(str, 12); }
>>   __test(5) int test_strspn(void *ctx) { return bpf_strspn(str, "ehlo"); }
>>   __test(2) int test_strcspn(void *ctx) { return bpf_strcspn(str, "lo"); }
>>   __test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str, "world"); }
>> +__test(6) int test_strcasestr_found1(void *ctx) { return bpf_strcasestr(str, "world"); }
>> +__test(6) int test_strcasestr_found2(void *ctx) { return bpf_strcasestr(str, "WORLD"); }
> Nit: I'd compress these two tests into one:
>       __test(6) int test_strcasestr_found1(void *ctx) { return bpf_strcasestr(str, "woRLD"); }
>       (and did the same for (str, "hello") variants below).

I just submit v3, please review, thanks.

Rong Tao

>
>>   __test(-ENOENT) int test_strstr_notfound(void *ctx) { return bpf_strstr(str, "hi"); }
>> +__test(-ENOENT) int test_strcasestr_notfound(void *ctx) { return bpf_strcasestr(str, "hi"); }
>>   __test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str, ""); }
>> +__test(0) int test_strcasestr_empty(void *ctx) { return bpf_strcasestr(str, ""); }
>>   __test(0) int test_strnstr_found1(void *ctx) { return bpf_strnstr("", "", 0); }
>>   __test(0) int test_strnstr_found2(void *ctx) { return bpf_strnstr(str, "hello", 5); }
>>   __test(0) int test_strnstr_found3(void *ctx) { return bpf_strnstr(str, "hello", 6); }
>> @@ -42,5 +46,14 @@ __test(-ENOENT) int test_strnstr_notfound1(void *ctx) { return bpf_strnstr(str,
>>   __test(-ENOENT) int test_strnstr_notfound2(void *ctx) { return bpf_strnstr(str, "hello", 4); }
>>   __test(-ENOENT) int test_strnstr_notfound3(void *ctx) { return bpf_strnstr("", "a", 0); }
>>   __test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str, "", 1); }
>> +__test(0) int test_strncasestr_found1(void *ctx) { return bpf_strncasestr("", "", 0); }
>> +__test(0) int test_strncasestr_found2(void *ctx) { return bpf_strncasestr(str, "hello", 5); }
>> +__test(0) int test_strncasestr_found3(void *ctx) { return bpf_strncasestr(str, "hello", 6); }
>> +__test(0) int test_strncasestr_found4(void *ctx) { return bpf_strncasestr(str, "HELLO", 5); }
>> +__test(0) int test_strncasestr_found5(void *ctx) { return bpf_strncasestr(str, "HELLO", 6); }
>> +__test(-ENOENT) int test_strncasestr_notfound1(void *ctx) { return bpf_strncasestr(str, "hi", 10); }
>> +__test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_strncasestr(str, "hello", 4); }
>> +__test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_strncasestr("", "a", 0); }
>> +__test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr(str, "", 1); }
>>   
>>   char _license[] SEC("license") = "GPL";


