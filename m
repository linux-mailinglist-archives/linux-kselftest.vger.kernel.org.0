Return-Path: <linux-kselftest+bounces-3267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB108332EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 07:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1981F22E3A
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 06:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA431871;
	Sat, 20 Jan 2024 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xJ9PCjYI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559A1858;
	Sat, 20 Jan 2024 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705731590; cv=none; b=Re0SbUjyBLDdQ840gPt3/VICsev24wOjOAO2iuxRE71bNFhHWitgAEs1QGiEQzW8bVY+62IfeyRziyGaEX2Ibr6kpYnvaeXedqQLWUV3N6RfC2IQrWMc+WFIXxj92NVsQxuOLMHCI0Y9AZ3mXvMdpL+F58LdEj2pE65CxlsL3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705731590; c=relaxed/simple;
	bh=FqLLGv/lbGLEEWWEPR0aQ1IfODLoQX9CDS7SfoUmZZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMTCGYrHWEQORuFKkJQjyQ2WDbqcWDSBb35wUsLfbip+EpVszhObscSFQcN/L/KxBKV9LcK8TSQqh5fAWPHtVqUuQdRBQolqHHX3Wac8Zv/IEfNeX58RPNFudVKvykePVQ9qaLIz0oL181I+uVPhwCYfjxrNP7SsNHUlngm/PI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xJ9PCjYI; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705731576; bh=FSgOORcQO5lgUOwo8yV1k/rvCE07D2OesQo7olHJxB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=xJ9PCjYIyxS91osERfxhtCS02jfrwfHMGXByfVR8hqIFcqIVdkztL+PVIqavW+46W
	 H3AdklhYOD7K+/67egWVk30Ksoh8Vb4tzpW8INN3/0HCOYr8h8XJGFH3jg8fXpNyVk
	 LNfyIPWumwJhgDAb3E9+QFgK/gPhxyqllYrCxeAQ=
Received: from [IPV6:240e:379:227b:4f00:cd09:8a0a:600e:c38] ([240e:379:227b:4f00:cd09:8a0a:600e:c38])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 34E26442; Sat, 20 Jan 2024 14:13:14 +0800
X-QQ-mid: xmsmtpt1705731194tluox7vxj
Message-ID: <tencent_FE461EBE274178ED6047005CCF98D710B807@qq.com>
X-QQ-XMAILINFO: NmRjDopJZVxOa26de14HAXFoYHQ08j8Qs7V+SVV1ET7ciwxp9PLNUzI2cE9Wef
	 JrxZSkfaZRH2wlaa99VkKVAYrKXHu81wW84VPVtM+5epuQxmeSU3dP+DZ57h3v6U9zBUF+Lc17U1
	 OMU1JxUx/NQSR6AonfLKr2piq76uQC9qAMyeZIwJDhx2rYdLAnP+DH7dxnv/Ak17+EyLH0uDUw00
	 Y+uvvIOm7OswqTOf5XWyhoEdJRulUGT55UYuaUz8YsFIl8HRCOaYJF2e39+dCtDVpl5S7YVbOybp
	 X85jc94s0oV+5ODm73hLQWxP1eQRDlZbbwXWViKsDf12XLH9r0RqdDbNstKYiw6ZK2ju+LsgFBzQ
	 wiwvBvCT4cVrv+z0WpbAMDP/ea1Xd1HC7edRVnSYrXgEIv1uHE4v8DUeGwB1BcoKN40kfyQp+Uk1
	 aTHzCghkVl9518xsgeizUuEZqIy8xghrdB4Zqa/ay+EVPJjEHgCvTUjUXbv+R+CnKyBft6zhgqXd
	 dT9E20V3Xeboyfpz345GPnXr1vXMPafyfqixTWXlDq2YKt83amMGKJjfPkhGQNVnNsazXXXaFb6l
	 NKhy6mt3aQpqbvU3Wm6pN9Lc9pYRBqa9CAJ3Y/sodWZAlQgTxROw8vSq8ZIzjDmv87CYXBAccb5J
	 YTsTVvXcAKscFKTdrmtbhd22jD+goO1q50QsJS1UrHur5z6C9BSQTZ16uQZlUvJqn/Mrmtm0T/NZ
	 ajunfU/gCEDC3AQ8fiH+bfg8hjzDi2KoF4SYEu1+YKXwSz1AQ6jotwLFMoVVeO5tlYVZ1yERuI2S
	 fD+NvLiVc1O2S83eSRdH3vsm5i8nIJFljhyE2tjwZjGfcPj/Uq++mrQQXRWtPUGCiH1a6b2y4+EE
	 DeP4b+e1PljbZHlr+C2j3NvUM20adqTXEJ+h0FinfDveFc4uMJsK1fsVWhGCw7gYxgHE/k8ose6g
	 lMbVPBhrwW0Z32xxN8W9j934P0aX02
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <1ee2f17b-4cd2-41c6-89c3-6842d87e03ce@cyyself.name>
Date: Sat, 20 Jan 2024 14:13:14 +0800
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
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <ZasjJ3HPUVuxr2oG@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for your reply.

On 1/20/24 09:34, Charlie Jenkins wrote:
> On Sun, Jan 14, 2024 at 01:26:57AM +0800, Yangyu Chen wrote:
>> Hi, Charlie
>>
>> Although this patchset has been merged I still have some questions about
>> this patchset. Because it breaks regular mmap if address >= 38 bits on
>> sv48 / sv57 capable systems like qemu. For example, If a userspace program
>> wants to mmap an anonymous page to addr=(1<<45) on an sv48 capable system,
>> it will fail and kernel will mmaped to another sv39 address since it does
> 
> Thank you for raising this concern. To make sure I am understanding
> correctly, you are passing a hint address of (1<<45) and expecting mmap
> to return 1<<45 and if it returns a different address you are describing
> mmap as failing? If you want an address that is in the sv48 space you
> can pass in an address that is greater than 1<<47.
> 
>> not meet the requirement to use sv48 as you wrote:
>>
>>> 	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
>>> 		mmap_end = VA_USER_SV48;			\
>>> 	else							\
>>> 		mmap_end = VA_USER_SV39;			\
>>
>> Then, How can a userspace program create a mmap with a hint if the address
>>> = (1<<38) after your patch without MAP_FIXED? The only way to do this is
>> to pass a hint >= (1<<47) on mmap syscall then kernel will return a random
>> address in sv48 address space but the hint address gets lost. I think this
> 
> In order to force mmap to return the address provided you must use
> MAP_FIXED. Otherwise, the address is a "hint" and has no guarantees. The
> hint address on riscv is used to mean "don't give me an address that
> uses more bits than this". This behavior is not unique to riscv, arm64
> and powerpc use a similar scheme. In arch/arm64/include/asm/processor.h
> there is the following code:
> 
> #define arch_get_mmap_base(addr, base) ((addr > DEFAULT_MAP_WINDOW) ? \
> 					base + TASK_SIZE - DEFAULT_MAP_WINDOW :\
> 					base)
> 
> arm64/powerpc are only concerned with a single boundary so the code is simpler.
> 

As you say, this code in arm64/powerpc will not meet the issue I 
address. For example, If the addr here is (1<<50) on arm64, the 
arch_get_mmap_base will return base+TASK_SIZE-DEFAULT_MAP_WINDOW which 
is (1<<vabits_actual). And this behavior on arm64/powerpc/x86 does not 
break anything since we will use a larger address space if the hint 
address is specified on the address > DEFAULT_MAP_WINDOW. The 
corresponding behavior on RISC-V should be if the hint address > BIT(47) 
then use Sv57 address space and use Sv48 when the hint address > BIT(38) 
if we want Sv39 by default.

However, your patch needs the address >= BIT(47) rather than BIT(38) to 
use Sv48 and address >= BIT(56) to use Sv57, thus breaking existing 
userspace software to create mapping on the hint address without 
MAP_FIXED set.

>> violate the principle of mmap syscall as kernel should take the hint and
>> attempt to create the mapping there.
> 
> Although the man page for mmap does say "on Linux, the kernel will pick
> a nearby page boundary" it is still a hint address so there is no strict
> requirement (and the precedent has already been set by arm64/powerpc).
> 

Yeah. There is no strict requirement. But currently x86/arm64/powerpc 
works in this situation well. The hint address on these ISAs is not used 
as the upper bound to allocating the address. However, on RISC-V, you 
treat this as the upper bound.

>>
>> I don't think patching in this way is right. However, if we only revert
>> this patch, some programs relying on mmap to return address with effective
>> bits <= 48 will still be an issue and it might expand to other ISAs if
>> they implement larger virtual address space like RISC-V sv57. A better way
>> to solve this might be adding a MAP_48BIT flag to mmap like MAP_32BIT has
>> been introduced for decades.
>>
>> Thanks,
>> Yangyu Chen
>>
> 
> - Charlie
> 


