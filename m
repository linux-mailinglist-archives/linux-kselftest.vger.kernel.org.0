Return-Path: <linux-kselftest+bounces-13308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB566929F20
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 11:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF75C28449A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF0447F4D;
	Mon,  8 Jul 2024 09:33:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCA1849C;
	Mon,  8 Jul 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431227; cv=none; b=WEFF1fIj9He9eJvd/1iUaCdMUjmcwwa2ooVOJ04V6lovPDZLDlsC1WOEcRsu5TGLAh45HWRiQtfqlJuZimQLJxM5evE6+9BmyCVEvXFfE3yGme3attCqwund6tqMUtWM4QTuvI3rm4+Wn+Zgn6GYIDHsQcqpd4mifjiM1SLLb80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431227; c=relaxed/simple;
	bh=XSyLWfuXMQi0H+g2rzt4cSb+GFD/9fQIsO2keu4kgGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OVwHVyR2U6kXYFxRZemLA1Q2r865PYr2/oN0BiDucJZwoDWpMvMWLt9VHNVExIsNwKYonV6Qyo/A+xG4lnDztqAL3emX+POMHF7nzqa+2r4MoCMZ1z6YAeEN9LTAx2z6pll8f3W8pDuT0FoA9bkHAFlhD/vsPc47c8TT4hZDrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WHf7V5kS0z4f3jt8;
	Mon,  8 Jul 2024 17:33:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 59C611A0184;
	Mon,  8 Jul 2024 17:33:34 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCn9_Bpsotmp+f9BQ--.47233S2;
	Mon, 08 Jul 2024 17:33:31 +0800 (CST)
Message-ID: <6a6f7a80-89aa-4fef-b489-262447dbdb1a@huaweicloud.com>
Date: Mon, 8 Jul 2024 17:33:29 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] arm64, bpf: Add 12-argument support for bpf
 trampoline
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240705125336.46820-1-puranjay@kernel.org>
 <5c43f532-c849-41c9-92dc-83925f5835d7@huaweicloud.com>
 <mb61py16c45rp.fsf@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <mb61py16c45rp.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCn9_Bpsotmp+f9BQ--.47233S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy3Aw15CF4DXFyfKrykZrb_yoW5AFyrpa
	95Z3ZIkrWDZr1Sqw47Kw43Xr4Sv395uw4UurW3Jw1UAFWqkFy8JrWI93WY9ryDWrWkua42
	yr1aqF9xGay3AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/8/2024 5:00 PM, Puranjay Mohan wrote:
> Xu Kuohai <xukuohai@huaweicloud.com> writes:
> 
>> On 7/5/2024 8:53 PM, Puranjay Mohan wrote:
>>> The arm64 bpf JIT currently supports attaching the trampoline to
>>> functions with <= 8 arguments. This is because up to 8 arguments can be
>>> passed in registers r0-r7. If there are more than 8 arguments then the
>>> 9th and later arguments are passed on the stack, with SP pointing to the
>>> first stacked argument. See aapcs64[1] for more details.
>>>
>>> If the 8th argument is a structure of size > 8B, then it is passed fully
>>> on stack and r7 is not used for passing any argument. If there is a 9th
>>> argument, it will be passed on the stack, even though r7 is available.
>>>
>>> Add the support of storing and restoring arguments passed on the stack
>>> to the arm64 bpf trampoline. This will allow attaching the trampoline to
>>> functions that take up to 12 arguments.
>>>
>>> [1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#parameter-passing
>>>
>>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>>> ---
>>> Changes in V1 -> V2:
>>> V1: https://lore.kernel.org/all/20240704173227.130491-1-puranjay@kernel.org/
>>> - Fixed the argument handling for composite types (structs)
>>> ---
>>>    arch/arm64/net/bpf_jit_comp.c                | 139 ++++++++++++++-----
>>>    tools/testing/selftests/bpf/DENYLIST.aarch64 |   3 -
>>>    2 files changed, 107 insertions(+), 35 deletions(-)
>>>
> 
> [SNIP]
> 
>>>    fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>>
>> It looks like this patch, similar to [1], also does not handle
>> parameter alignment properly [2].
>>
>> For example:
>>
>> int func(__int128 a, __int128 b, __int128 c, int64_t d, __int128 e, int64_t f, __int128 g)
>> {
>> }
>>
>> parameter a~d are passed through register x0~x6, while parameter
>> e~g are passed through stack. Since __int128 is 16-byte aligned,
>> parameter e, f, and g should be placed at sp + 0, +16, and +32
>> respectively, with 8 bytes **padding** between f and g.
>>
>>
>> And the compiler's alignment or packed attribute may make things
>> worse, causing parameters to be placed on the stack at positions
>> that are not naturally aligned.
> 
> Hi Xu,
> Thanks for explaining this. I was not aware that you have already sent a
> patch[1] to add this support to arm64.
> 
> So, I see that it will be non-trivial to calculate padding for each
> argument passed on the stack. If you are not planning to work on this
> then I can try to implement it.
>

Sure, go ahead and do it.

> Alsoi, do we currently have a selftest that checks for this edge case? if
> not I can try to add that too.
>

Not yet, feel free to add it. Thanks.

> Thanks,
> Puranjay
> 
>> [1] https://lore.kernel.org/bpf/20230917150752.69612-1-xukuohai@huaweicloud.com/
>> [2] https://lore.kernel.org/bpf/CABRcYmLtk8aQEzoUFw+j5Rdd-MXf-q+i7RHXZtu-skjRz11ZDw@mail.gmail.com/


