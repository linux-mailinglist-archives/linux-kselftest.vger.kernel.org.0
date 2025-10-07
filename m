Return-Path: <linux-kselftest+bounces-42799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E64BC00ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 05:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2843BE342
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 03:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4631E25E3;
	Tue,  7 Oct 2025 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="E1S6GdYV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBEDDD2;
	Tue,  7 Oct 2025 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759806430; cv=none; b=r6Hu/JjxGK5skQKehqE5PD03rxBdy1/ORC+47yg4ULlC/6CyW7JcoNfdSIFQ08b/vtbh+o9OpwPAhSTbJrFscF7YTDa3qPvnl4xTfNFVNtP1mp2/mwImNfhghRAm9do2UGpIhzU6h+4/OF3B4Xy8D9A3TXmfint1IMkVwVjzu1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759806430; c=relaxed/simple;
	bh=iWuHg+XDKIsqfl1L27XrdXTMvtJhHJk7nPTk37qQmd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPLp+cmqJkRLzEfAswSyzeiCOt7K0gJ4VyimB7ZjlqQBCPw+Jw4UCSE3Ohp8+6v5upD1sqyNO1Tc5UAfG8xxLCqJ1pSGQhBA9tflttJEMzgT5tokcSRA3ZWPQZHQ2QNC8qxDH7WGa+JCZ3OpYFIIVQpIPXWfHtV4hyC2dehU6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=E1S6GdYV; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759806117;
	bh=SE2gaV290pNnHcKMRBAA66T1AeRJNMP1p2qNpVR1Cg0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E1S6GdYVRdjfO8SlDcSgYpm7EmH2dRezjUjBTo339kSbaawTeAliMVJ/++rSc3X7E
	 9r0dUokA18qVPX1Phc7bGJyCXgGALPfSJOMKZVvo6wWH0bcVLb+q4yAQaVJbM2jIO0
	 6i83QxbZhK2qEMQ/aW+xIf4FAiywKK6YG96N40Fk=
Received: from [192.168.2.104] ([183.198.135.10])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id 759E202; Tue, 07 Oct 2025 11:01:53 +0800
X-QQ-mid: xmsmtpt1759806113tg0lobh9b
Message-ID: <tencent_89BDE28D22220E1B0409E564455D0EA8D80A@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2V7TxWyb1zVcKAIoA0D4V9D/5nPN8x1MqtHVfetHpVcHSYzNAv4
	 3JB2Hkkco64/49q6XgsJf2mBmqfqyP7PMphexpC2zwhvL4wJX1Z0dJFSNFcNfTshwCjPQrddvbg7
	 Cc1kwm0ZO3dvLxQsRhRP96k6eKDVtCufU19KovToRHsFkmstIwlV7VHAT3xUo7EZke4lRz+dW+Gw
	 Mc3XznMGjFyaG6U0lu6K8nUUm0oxYQVhmXNjK1EY+PKkxxtha5ZzwCx+e7B/E3X20INfVLoa5+At
	 zlHxArRsvWV9GiMhBKz8VIus6C5PAkXrqOkgX81q+gxgGi8s6XbIumb+qCIDNN6HU74Efv6txRBX
	 kDg+l6YO8BBIEmKCwtnPPCtcN7vm0/nCVWE5CoqCoA0irHS9pWlPNUtN1tfxA1F/+i1+UR0INJ2D
	 M3A4OePl9kyJDaL7RMxarjtSNt7U5WvV3HwlXQ5TTBDPljcVGPYQ6/RkbldWWIX4qwLest3uBLgE
	 TjJhrtI+tHuscaD22IfvlO3L3RbVo4xjgUKvNuYK5whVHbxWSob/sJJI3GlSbEYZvkIP09ZGJ1eD
	 tasxfXXiyfjelnQWaAEEvfPV9j2Kg64yU8OOUZ7FuCcbGocKEXji2jd57FmgDSaQ9q3z8YJXP0rW
	 G1wbC+OnjeajXzFTpdC/CMSIGAazptXus1oNzxDV1JYNdM2xBV3QZtWZXpyThFK1Y359qKOMOdwJ
	 fZ8pyffgD1A6KR9JLl3H206F0sXcRH+5pSAvxPH4v2rxuKgjRwc9qIsO9ei4o3Ml0TMaryemcUBp
	 3ekoswAGmEtWmZriudf1O6szbmCoeIJsk1h1CIm4n6wGRDYwb7MHn6+esebQyC+VLgtXuSC1Nscq
	 FCtXa0nkH84jUAF/bQUaZ4KtCTSWwvKqL+/qG2oFANzcFH6Of/NFB2bDPZ/15RXUSJx+OCdJkeML
	 U5YtQwjdDvO0gXhsGDoxGqc5l7HVcQe6Ti3haFQQEM0dUZuEIWSvAfGi2b7AWFIrLgz+Xmfg8JoV
	 uAWK8bIAhDjQIbxhyZFTmh/zvv4I4=
X-QQ-XMRINFO: OCYC/FIMav1X1DvLmR6nDkA=
X-OQ-MSGID: <8423b6f9-1057-48a8-a55d-bd80e18b5389@foxmail.com>
Date: Tue, 7 Oct 2025 11:01:53 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_strcasestr,bpf_strncasestr
 kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: vmalik@redhat.com, ast@kernel.org, Rong Tao <rongtao@cestc.cn>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1759588929.git.rongtao@cestc.cn>
 <tencent_6D228941AB904DD6E1E58C8ACDEBEC280C06@qq.com>
 <CAEf4BzaEjv1Nc6VK9sAW2y3cGvyKx9WUpOugWn6vZkFW-k7wCA@mail.gmail.com>
Content-Language: en-US
From: "rtoax@foxmail.com" <rtoax@foxmail.com>
In-Reply-To: <CAEf4BzaEjv1Nc6VK9sAW2y3cGvyKx9WUpOugWn6vZkFW-k7wCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/7/25 7:23 AM, Andrii Nakryiko wrote:
> On Sat, Oct 4, 2025 at 7:52 AM Rong Tao <rtoax@foxmail.com> wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> bpf_strcasestr() and bpf_strncasestr() functions perform same like
>> bpf_strstr() and bpf_strnstr() except ignoring the case of the
>> characters.
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>   kernel/bpf/helpers.c | 96 ++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 75 insertions(+), 21 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index c9fab9a356df..4df902e5f208 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3675,34 +3675,20 @@ __bpf_kfunc int bpf_strcspn(const char *s__ign, const char *reject__ign)
>>          return -EFAULT;
>>   }
>>
>> -/**
>> - * bpf_strnstr - Find the first substring in a length-limited string
>> - * @s1__ign: The string to be searched
>> - * @s2__ign: The string to search for
>> - * @len: the maximum number of characters to search
>> - *
>> - * Return:
>> - * * >=0      - Index of the first character of the first occurrence of @s2__ign
>> - *              within the first @len characters of @s1__ign
>> - * * %-ENOENT - @s2__ign not found in the first @len characters of @s1__ign
>> - * * %-EFAULT - Cannot read one of the strings
>> - * * %-E2BIG  - One of the strings is too large
>> - * * %-ERANGE - One of the strings is outside of kernel address space
>> - */
>> -__bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len)
>> +int __bpf_strnstr(const char *s1, const char *s2, size_t len, bool ignore_case)
> keep it static?

Thanks, fixed in v3, please review.

Rong Tao

>
> pw-bot: cr
>
>
> [...]


