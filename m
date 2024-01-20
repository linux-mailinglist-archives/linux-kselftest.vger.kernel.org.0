Return-Path: <linux-kselftest+bounces-3269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40ED833310
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 08:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D342844C1
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 07:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3471FD8;
	Sat, 20 Jan 2024 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tZr/TgsK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36C61FBC;
	Sat, 20 Jan 2024 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705734612; cv=none; b=ijZTHBS/hUEA+Mod9gvbaMv0eeGfgiBtKLr/wn5zEJhxgTvWu/lxxb8smINOY/0XFayy1iDnr5QgDP4ahJ7HdG7TrFH8QDdJhCASVe1agLdm+qvDw3/W1snzSwT3qqYB2dSfR49yEYPyAri3QBYEczc+K/g0JeRb6326H48Q+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705734612; c=relaxed/simple;
	bh=DwXSmU/cQfccTNeaCLP8QOcPkdv1xaPdbaF8ErxT5PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFgEq/dW89OpQmIQigyJ1kcr/3m7Fg/LclkuMTe/qr8GtCarVt/2I7Eu10LO/Er8B37pCtZLlPMypnBLagnK1aXaZUTxb0sgd9LB/HsF0ar8ldsolbS31IpQgV8k/uj4h0pUq9N2iw+70jKL2sXB1hhL8D56DxY7IAWPaiEI5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tZr/TgsK; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705734594; bh=xyoV1t8aKEfAQW2cATwsxg7a8BFBl4JU4b4mWpoQqG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tZr/TgsKCpgkOWNFSioi0h4IJG5x+EVyhhIYoMnAB2UKCPsEEMw7FPu/7vezFQBV6
	 QWSLOKVUphNz6jcdwbEj/l71C4K4POomEjYAG8Z6K0j/Cxv/yRKNtmeUUrykPfFOl0
	 ilBsPZDxq51L84SeKwaMDiAiE2+klBGGQjwi9i5Q=
Received: from [IPV6:240e:379:227b:4f00:cd09:8a0a:600e:c38] ([240e:379:227b:4f00:cd09:8a0a:600e:c38])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 273AB8E0; Sat, 20 Jan 2024 15:09:51 +0800
X-QQ-mid: xmsmtpt1705734591tujaje9qv
Message-ID: <tencent_A80D5721462124BDB19CAF4E10473BD55105@qq.com>
X-QQ-XMAILINFO: NiDupExshEc7/Ce0oCF0ITlo7eRWhrzB6nlMTHy+ibkGPS2vJZZqmzOkIfUhHP
	 lqtmyLmYNWFPhG49RlXuuNrqcch58e7pYQOhLngwkBR+C3HgBzJmj7KjnS3g+Nm7wDty6i03qVYE
	 OGwBF9AClUMjH0K3WM7BRRpI/VZBsqNygbF5/BOfAzarng5X6E9I1IVaxQ8f0atYGkeKel+vxl2Z
	 ly4AxuWjWvYm29z5PAh1biE5dkElDjB0qxwZYrAau3q39p+vPCpQj17OEpU88UuhOIt7o1AIOm5G
	 Ofr5DqHWB8C3n1uk/5WTmohFbGNXo7sUzW/mBOLoj4yYHFvOVl5mMLpaPptiaLYfMUVUGV/Q5uhg
	 NrqmDPzIcbFTxUvN/Dn+l7dfk6mFJ/SrqiEsKe2HlW7V4IOrSDDuuB0tGlgqdrhFEhX73p+wGIr8
	 LdCocRkul0O7MkYWK40DQ4wJBRL3J8nMMbD4Ua67Vw57KudTKLfD3tvDmMqMeTGO2jDVSCfuKYg3
	 TWNX1VJCV4tVJtz8eIhutNPubaADxmigGZHnHFnB5cWVyuZ4TCp6d3oq/DrZECDdeGep4N2x+aJc
	 scnVAjHSMUi5rQAESklo6olqPGg578fA9GqvDy7H58yrEDBOPdxPC/d0144mEKxpDWln3N6yiZdF
	 pLZX01AAxkU8VwMAlXSQ1DuNG2EXyoFEi0hCJq0B872G5OkeVmGqSOs6ltp9BzJXD21HI3hJBbHS
	 R514suSvcnwgUENql1sbp6M5y7tpHRU61YXGiDhSI4HmSCMXx1LCKFcp6bW2dl45OwULQhS+uYZl
	 nFXaCDdvnwtk9s1f9f9k8N5hpSHhEEZu90MUbp0tWcKDvZpuixysCq/8+Rmjb1DUpV5zsPEldVPn
	 IihwtZcYWBBLs5WIjq9fSbW8dtiL7J6Shwj44gWe0LFkLYPA7Beu+vQVGNl1QMVcgDmAHgLEg/Sl
	 uEujmMui7BX3CXxUIwb1HdfRQzXm2kpSRpmOv6Lp1kUUQjxW+e+w==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-OQ-MSGID: <5b25a10f-b3b1-47ae-b8af-34689d30d908@cyyself.name>
Date: Sat, 20 Jan 2024 15:09:51 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/4] RISC-V: mm: Make SV48 the default address space
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: alexghiti@rivosinc.com, anup@brainfault.org, aou@eecs.berkeley.edu,
 conor@kernel.org, jrtc27@jrtc27.com, konstantin@linuxfoundation.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, mick@ics.forth.gr, palmer@rivosinc.com,
 paul.walmsley@sifive.com, rdunlap@infradead.org
References: <20230809232218.849726-1-charlie@rivosinc.com>
 <tencent_F9568C6D8872E30EDFAF20ADF686A31D6E06@qq.com>
 <ZasjJ3HPUVuxr2oG@ghost>
 <tencent_FE461EBE274178ED6047005CCF98D710B807@qq.com>
 <Zats/W/oiaphdWTv@ghost>
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <Zats/W/oiaphdWTv@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/20/24 14:49, Charlie Jenkins wrote:
> On Sat, Jan 20, 2024 at 02:13:14PM +0800, Yangyu Chen wrote:
>> Thanks for your reply.
>>
>> On 1/20/24 09:34, Charlie Jenkins wrote:
>>> On Sun, Jan 14, 2024 at 01:26:57AM +0800, Yangyu Chen wrote:
>>>> Hi, Charlie
>>>>
>>>> Although this patchset has been merged I still have some questions about
>>>> this patchset. Because it breaks regular mmap if address >= 38 bits on
>>>> sv48 / sv57 capable systems like qemu. For example, If a userspace program
>>>> wants to mmap an anonymous page to addr=(1<<45) on an sv48 capable system,
>>>> it will fail and kernel will mmaped to another sv39 address since it does
>>>
>>> Thank you for raising this concern. To make sure I am understanding
>>> correctly, you are passing a hint address of (1<<45) and expecting mmap
>>> to return 1<<45 and if it returns a different address you are describing
>>> mmap as failing? If you want an address that is in the sv48 space you
>>> can pass in an address that is greater than 1<<47.
>>>
>>>> not meet the requirement to use sv48 as you wrote:
>>>>
>>>>> 	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
>>>>> 		mmap_end = VA_USER_SV48;			\
>>>>> 	else							\
>>>>> 		mmap_end = VA_USER_SV39;			\
>>>>
>>>> Then, How can a userspace program create a mmap with a hint if the address
>>>>> = (1<<38) after your patch without MAP_FIXED? The only way to do this is
>>>> to pass a hint >= (1<<47) on mmap syscall then kernel will return a random
>>>> address in sv48 address space but the hint address gets lost. I think this
>>>
>>> In order to force mmap to return the address provided you must use
>>> MAP_FIXED. Otherwise, the address is a "hint" and has no guarantees. The
>>> hint address on riscv is used to mean "don't give me an address that
>>> uses more bits than this". This behavior is not unique to riscv, arm64
>>> and powerpc use a similar scheme. In arch/arm64/include/asm/processor.h
>>> there is the following code:
>>>
>>> #define arch_get_mmap_base(addr, base) ((addr > DEFAULT_MAP_WINDOW) ? \
>>> 					base + TASK_SIZE - DEFAULT_MAP_WINDOW :\
>>> 					base)
>>>
>>> arm64/powerpc are only concerned with a single boundary so the code is simpler.
>>>
>>
>> As you say, this code in arm64/powerpc will not meet the issue I address.
>> For example, If the addr here is (1<<50) on arm64, the arch_get_mmap_base
>> will return base+TASK_SIZE-DEFAULT_MAP_WINDOW which is (1<<vabits_actual).
>> And this behavior on arm64/powerpc/x86 does not break anything since we will
>> use a larger address space if the hint address is specified on the address >
>> DEFAULT_MAP_WINDOW. The corresponding behavior on RISC-V should be if the
>> hint address > BIT(47) then use Sv57 address space and use Sv48 when the
>> hint address > BIT(38) if we want Sv39 by default.
>>
>> However, your patch needs the address >= BIT(47) rather than BIT(38) to use
>> Sv48 and address >= BIT(56) to use Sv57, thus breaking existing userspace
>> software to create mapping on the hint address without MAP_FIXED set.
> 
> Code that needs mmap to provide a specific address must use MAP_FIXED.
> On riscv, it was decided that the address returned from mmap cannot be
> greater than the hint address. This is currently implemented by using
> the largest address space that can fit into the hint address. It may be
> possible that this range can be extended to use all of the addresses
> that are less than or equal to the hint address.
> 

So this decision might be wrong. It requires some userspace software to 
modify their mmap flags to fit with this. For example, a binary 
translate JIT compiler already probes this platform is capable with 
Sv48, then want to create mapping on some address specified on the mmap 
hint to align with foreign binary native address but also provide a 
fallback path with performance overhead. Your patch here will always let 
userspace software use a fallback path with performance overhead until 
the userspace software changes its syscall to use MAP_FIXED. But it is 
not required in x86, arm64, powerpc.

>  From reading the code even on arm64 if you pass an address that is
> greater than DEFAULT_MAP_WINDOW it is not guaranteed that mmap will
> return an address that is greater than DEFAULT_MAP_WINDOW. It may still
> be provide an address that is less than DEFAULT_MAP_WINDOW if it fails
> to find an address above. This seems like this would also break your use
> case.
> 

Yeah. As I said before, this patch will always let userspace software 
use a fallback path and this only happens in RISC-V. Make default sv48 
is right, but RISC-V implementation for this and changing the hint 
address behavior might be wrong. And x86, arm64, powerpc already use
48-bit address space by default but do not change the meaning of hint 
address on mmap.

>>
>>>> violate the principle of mmap syscall as kernel should take the hint and
>>>> attempt to create the mapping there.
>>>
>>> Although the man page for mmap does say "on Linux, the kernel will pick
>>> a nearby page boundary" it is still a hint address so there is no strict
>>> requirement (and the precedent has already been set by arm64/powerpc).
>>>
>>
>> Yeah. There is no strict requirement. But currently x86/arm64/powerpc works
>> in this situation well. The hint address on these ISAs is not used as the
>> upper bound to allocating the address. However, on RISC-V, you treat this as
>> the upper bound.
>>
>>>>
>>>> I don't think patching in this way is right. However, if we only revert
>>>> this patch, some programs relying on mmap to return address with effective
>>>> bits <= 48 will still be an issue and it might expand to other ISAs if
>>>> they implement larger virtual address space like RISC-V sv57. A better way
>>>> to solve this might be adding a MAP_48BIT flag to mmap like MAP_32BIT has
>>>> been introduced for decades.
>>>>
>>>> Thanks,
>>>> Yangyu Chen
>>>>
>>>
>>> - Charlie
>>>
>>


