Return-Path: <linux-kselftest+bounces-31223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26247A94AAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 04:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B75188DE3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 02:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564C62561A2;
	Mon, 21 Apr 2025 02:15:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2A7645;
	Mon, 21 Apr 2025 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745201700; cv=none; b=dqkJ3aZHqqbpRAGADDNSR5j1vW2XcZUhXIPUQ9jKjJN5Z6FB426pTzqKMLuI3j5J+fZWlBV4hVcPM9we69vhoNiaEvxQ144qKB91Ol01Ul2R+XdYbC4baUB7K5JNEguBhMDI1SguguZwRQSeVeYfJDzQ8BcMD9uH3z00ewWDC7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745201700; c=relaxed/simple;
	bh=alVflVCr762SqWXcb/aZKIF/Wu6wTJ2sggCUoOYmktA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJ464hygFsHOe69lY7N6JMxohXjz8rVQ57nUhTkfovAYkUWc1/Prh6n6xPityIV2Hmiav2cn0uVdr1bOXH3Mxyb6nmHSeQfRAjJSIpPejKY6aCJfxVZXcE41oRLwy5UUiCH1EExcehRWzsN2Zep2Pk9JcJCb2S44zTCp4iaifvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZgppM6SDzz4f3mJ6;
	Mon, 21 Apr 2025 10:14:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4CDB81A158E;
	Mon, 21 Apr 2025 10:14:45 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgDX4WQTqgVo5dAZKA--.45218S2;
	Mon, 21 Apr 2025 10:14:44 +0800 (CST)
Message-ID: <8b800c09-eade-4dcf-90f6-2f5a78170bc4@huaweicloud.com>
Date: Mon, 21 Apr 2025 10:14:43 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: add struct largest member size in
 func model
Content-Language: en-US
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Florent Revest <revest@chromium.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
 <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
 <9da88811-cce0-41df-8069-2e8b67541c39@huaweicloud.com>
 <D9BLCJSCHE9A.1IKHK3XBPF8MU@bootlin.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <D9BLCJSCHE9A.1IKHK3XBPF8MU@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDX4WQTqgVo5dAZKA--.45218S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW3JryUGw4rWryDXr4fZrb_yoWrJw18pF
	ZxX3Z8tF4kJr1xZa1qy3yxZrWSq348KryUCrW5tw13trn8GF1xJFW2gF4Y9Fy5Gr1kG3W2
	vF1jqFy3Za4fZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjTRM6wCDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/21/2025 12:02 AM, Alexis Lothoré wrote:
> Hi Xu,
> 
> On Thu Apr 17, 2025 at 4:10 PM CEST, Xu Kuohai wrote:
>> On 4/17/2025 3:14 PM, Alexis Lothoré wrote:
>>> Hi Andrii,
>>>
>>> On Wed Apr 16, 2025 at 11:24 PM CEST, Andrii Nakryiko wrote:
>>>> On Fri, Apr 11, 2025 at 1:32 PM Alexis Lothoré (eBPF Foundation)
>>>> <alexis.lothore@bootlin.com> wrote:
> 
> [...]
> 
>>>> I might be missing something, but how can the *size* of the field be
>>>> used to calculate that argument's *alignment*? i.e., I don't
>>>> understand why arg_largest_member_size needs to be calculated instead
>>>> of arg_largest_member_alignment...
>>>
>>> Indeed I initially checked whether I could return directly some alignment
>>> info from btf, but it then involves the alignment computation in the btf
>>> module. Since there could be minor differences between architectures about
>>> alignment requirements, I though it would be better to in fact keep alignment
>>> computation out of the btf module. For example, I see that 128 bits values
>>> are aligned on 16 bytes on ARM64, while being aligned on 8 bytes on S390.
>>>
>>> And since for ARM64, all needed alignments are somehow derived from size
>>> (it is either directly size for fundamental types, or alignment of the
>>> largest member for structs, which is then size of largest member),
>>> returning the size seems to be enough to allow the JIT side to compute
>>> alignments.
>>>
>>
>> Not exactly. The compiler's "packed" and "alignment" attributes cause a
>> structure to be aligned differently from its natural alignment.
>>
>> For example, with the following three structures:
>>
>> struct s0 {
>>       __int128 x;
>> };
>>
>> struct s1 {
>>       __int128 x;
>> } __attribute__((packed));
>>
>> struct s2 {
>>       __int128 x;
>> } __attribute__((aligned(64)));
>>
>> Even though the largest member size is the same, s0 will be aligned to 16
>> bytes, s1 and s2 are not aligned the same way. s1 has no alignment due to
>> the "packed" attribute, while s2 will be aligned to 64 bytes.
>>
>> When these three structures are passed as function arguments, they will be
>> located on different positions on the stack.
>>
>> For the following three functions:
>>
>> int f0(__int128 a, __int128 b, __int128 c, int64_t d, __int128 e, int64_t f, struct s0 g);
>> int f1(__int128 a, __int128 b, __int128 c, int64_t d, __int128 e, int64_t f, struct s1 g);
>> int f2(__int128 a, __int128 b, __int128 c, int64_t d, __int128 e, int64_t f, struct s2 g);
>>
>> g will be located at sp+32 in f0, sp + 24 in f1, and some 64-byte aligned
>> stack address in f2.
> 
> Ah, thanks for those clear examples, I completely overlooked this
> possibility. And now that you mention it, I feel a bit dumb because I now
> remember that you mentioned this in Puranjay's series...
> 
> I took a quick look at the x86 JIT compiler for reference, and saw no code
> related to this specific case neither. So I searched in the kernel for
> actual functions taking struct arguments by value AND being declared with some
> packed or aligned attribute. I only found a handful of those, and none
> seems to take enough arguments to have the corresponding struct passed on the
> stack. So rather than supporting this very specific case, I am tempted
> to just return an error for now during trampoline creation if we detect such
> structure (and then the JIT compiler can keep using data size to compute
> alignment, now that it is sure not to receive custom alignments). Or am I
> missing some actual cases involving those very specific alignments ?
> 

How can we reliably 'detect' the case? If a function has such a parameter
but we fail to detect it, the BPF trampoline will pass an incorrect value
to the function, which is also unacceptable.

> Thanks,
> 
> Alexis
> 


