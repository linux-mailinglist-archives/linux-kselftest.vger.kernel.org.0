Return-Path: <linux-kselftest+bounces-5671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0223F86D594
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 22:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03441C22F5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 21:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B164F13E7D8;
	Thu, 29 Feb 2024 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fgc97zkX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B513E7CB;
	Thu, 29 Feb 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240056; cv=none; b=ZyB0NHt83raIm8lngIz4UUoqaMBIVdKSUcNYuf7dHR2vxdfeQA3Qn6RDLw3H2F91YZwBXiG4vl8+rr0J76cHB0FaBPmCbLrybreEW0yr2RdHJ419HKyvxEL+TgvUjTqFPYcCt1QUS5xIZSHuyNxDkWyQAtBGQImVJ8Gr1M3BNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240056; c=relaxed/simple;
	bh=CmtwSBef1JC9TfIjMoVhFpJObvZIJh5tjAxkO8PNahE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3mqHcEY04AaiyCYVXmnivb55h6ExBmQwkPgJkATj4wB24gC1ZRc8i4BBtWtYNqNvqzhgHHNpeFIaHaLR1SbbBH9ReggX6mJKd48U1Kl7BkjB+xolr8UTJZUgVo2hq4XtpGEw1NCBgBsJRiteH1xkne9Uh//q6zSAtqD49B9beI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fgc97zkX; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709240050; bh=ehzUn72V5ueX+yEJjzR1+l140emrjCPV14a1vt2eR/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fgc97zkXJgvEbrrjZndEc99saf9p6C7GKRY/9VWGiyHBnBuwkdeY7nj6tkXHIECy/
	 fuOxt22fg2pzGlXqq0TxIseUijOEt9eUvaWYSQRA3jaii0Q4jhtKrDO362WyE13BUv
	 n1cVqT16r01GvtskXopjCeMRIBpu9Q+ZtmfMDA30=
Received: from [IPV6:2001:da8:c800:d084:427:1102:8aff:8b6e] ([2001:da8:c800:d084:427:1102:8aff:8b6e])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id D86284AF; Fri, 01 Mar 2024 04:54:06 +0800
X-QQ-mid: xmsmtpt1709240046tvhx1n7hu
Message-ID: <tencent_BA062F64BB719A8F42F0435BCD3117B73F05@qq.com>
X-QQ-XMAILINFO: MoPVgyGdM21e/Qx/u9cMnKlPtejjo+JK012PTw7vGNtRqaTcQblue8l4YSaw5K
	 nDqZqpPsZxXNRRtixIO499/IcQenEJPqbp+ZCtpPPQ3ZDPqTOiYYRkk4VsQgTcherkGxC0S2K/XP
	 SVZqLeiGUBUcmXkaEbjn4f9Y2HdpjGX+eJ6ztmmPwo2YScrl20XoPGKbMK5/hPMGNZ52OGFIiWsN
	 hPQs8J5uG/xsIx0anS687SAmN/DUs1o8gFruafp41Hvmu6ItbHsaT0HPgP8kFrRHQACMUuqSmWgF
	 LqfOdsl90gqWDSuEzxgTB4Xp8tbwywRS268ZL8wnhfIOZSHGVBy11jWASOUl/YWPKgV7JT0bQeyv
	 XesE6eBLkVk0A9x747u+ccsJgBpzdZIJUncxk0a/WQwG73QtN8kehcw68lWvLKOmSZ6qjeZkUBRy
	 oB1wAechDy04HpJ6gmQ49JZWeg4CrFfYJRV17PZp5g5fJitBkIVsh3UTg6x8Lr91UFq6MHk1CC/S
	 BFAbx27nk7FmK6tGK3bAbRy4LgsrnaVMudxCX+Ox1ROyFZXTPivaXxA3yaXdZgy9wVvB/RsVvssy
	 OXkY3A/hOLY3QBu93hDZIIaxwcYhuZZICl8RDuCVFWCP+JLIGcXLFpFv+u3326s5Y1PrP6WD97Ca
	 wso2O95mq2oCXjPslsCSeeB3G2WuD/QJb91B5Hzki2stoMyHze0bjUpC4IxyNgcZ2w6FOI9bpM/m
	 OKK8BDrMrEnvP8iE2LwPSuTVLRoDlI8QuLP3LImXLWWq1Nsaqtc0+uuMhiT68PmbJea3uhmZNpsx
	 XFjw4Bo0cmtLcFJPKAYERSa8zm+OkyfYfq8ZaVP4xUks+2wWZ0jvV4gAq1msZoubQEnaUdsSAQ7W
	 cwpsiZnjFviWUneKsv0liy/QK7MJdubEi0uAwsJitaLJ3ErOgeyz1P8Be9J9eOGMEfZKMEpcNm3e
	 AWVDWptaTxpTn0qJfpqanue3+tSylathcULDFpJremTaENSviDzcqcOGiIfBvsbQTec1XJ+j+s6u
	 agxUqXSpljkZ7C03/QAC7/mE/3+bXssi2sPc+c6w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <ac1ce6c7-d79d-4e23-ac50-a6dd7350a7e4@cyyself.name>
Date: Fri, 1 Mar 2024 04:54:05 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] RISC-V: mm: do not treat hint addr on mmap as the
 upper bound to search
Content-Language: en-US
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: alexghiti@rivosinc.com, andy.chiu@sifive.com,
 Charlie Jenkins <charlie@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org,
 jszhang@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>
References: <mhng-67b02dff-5423-466d-bd90-f3ad3a3ab6a9@palmer-ri-x1c9a>
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <mhng-67b02dff-5423-466d-bd90-f3ad3a3ab6a9@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/1 03:21, Palmer Dabbelt wrote:
> On Thu, 29 Feb 2024 04:10:03 PST (-0800), cyy@cyyself.name wrote:
>> This patch has not been reviewed for more than a month. There is 
>> another patch that did the same fix but in another way and still has 
>> not been reviewed like this. I'm here to do a comparison of some 
>> choices briefly to let the maintainer understand the issues and the 
>> solutions. I think it's time to make a decision before the next Linux 
>> LTS v6.9. As a number of sv48 chips will be released this year.
>>
>> Issues:
>>
>> Since commit add2cc6b6515 ("RISC-V: mm: Restrict address space for 
>> sv39,sv48,sv57") from patch [1], userspace software cannot create 
>> virtual address memory mapping on the hint address if the address 
>> larger than (1<<38) on sv48, sv57 capable CPU using mmap without 
>> MAP_FIXED set.
>>
>> This is because since that commit, the hint address is treated as the 
>> upper bound to create the mapping when the hint address is larger than 
>> (1<<38).
>>
>> Existing regression for userspace software since that commit:
>> - box64 [2]
> 
> Is this the same regression as before?  IIUC the real issue there is 
> that userspace wasn't passing MAP_FIXED and expecting a fixed address to 
> be mapped.  That's just a bug in userspace.
> 
> Is there any software that uses mmap() in a legal way that the flags 
> patch caused a regression in?  If that's the case then we'll need to 
> figure out what it's doing so we can avoid the regression.
> 
> The only thing I can think of are realloc-type schemes, where rounding 
> the hint address down would result in performance problems.  I don't 
> know of anything like that specifically, but I think Charlie's patch 
> would fix it.
> 

Yes. The regression for a legal mmap is only on performance for 
userspace software, not on functionality.

>> Some choices are:
>>
>> 1. Do not change it
>>
>> Con:
>>
>> This behavior is not the same as x86, arm64, and powerpc when treating 
>> memory address space larger than 48-bit. On x86, arm64, and powerpc, 
>> if the hint address is larger than 48-bit, mmap will not limit the 
>> upper bound to use.
>>
>> Also, these ISAs limit the mmap to 48-bit by default. However, RISC-V 
>> currently uses sv39 by default, which is not the same as the document 
>> and commit message.
> 
> IIUC arm64/amd64 started with 48-bit-capable hardware and kernels, and 
> thus the only regression was when moving to the larger VA spaces.  We 
> started with sv39-based VA space,

It's about the document and the commit message says it uses sv48 by 
default. However, the code in the kernel uses sv39 by default. The 
reasons for using sv48 by default has been talked about in that patch 
review previously. [4]

Whatever, the document or the code can be simply fixed if we decide not 
to change it.

Another concern is that if we can't make this decision in time to catch 
up with v6.9 we don't want some bad things to happen as a large number 
of sv48 machines might appear this year and they may run on the next 
v6.9 LTS kernel, Shall we change the code in the kernel to use sv48 by 
default right now?

[4] https://lore.kernel.org/linux-riscv/ZJzgi8RyqG3Mjt0R@ghost/

>> 2. Use my patch
>>
>> which limits the upper bound of mmap to 47-bit by default, if the hint 
>> address is larger than (1<<47), then no limit.
>>
>> Pros: Let the behavior of mmap align with x86, arm64, powerpc
>>
>> Cons: A new regression for software that assumes mmap will not return 
>> an address larger than the hint address if the hint address is larger 
>> than (1<<38) as it has been documented on RISC-V since v6.6. However, 
>> there is no change in the widespread sv39 systems we use now.
> 
> The OpenJDK and Go people have at least talked about using the interface 
> as it is currently defined.  I'm trying to chase down some of the folks 
> around here who understand that stuff, but it might take a bit...
> 
Roger that.

>> 3. Use Charlie's patch [3]
>>
>> which adjusts the upper bound to hint address + size.
> 
> IMO we can call that compatible with the docs.  There's sort of a grey 
> area in "A hint address passed to mmap will cause the largest
> address space that fits entirely into the hint to be used" as to how 
> that hint address is used, but I think interpreting it as the base 
> address is sane and we can just update the docs.
> 
> This also should fix the realloc-type cases I can think of, though those 
> are sort of theoretical right now.
> 
>> Pros: Still has upper-bound limit using hint address but allows 
>> userspace to create mapping on the hint address without MAP_FIXED set.
>>
>> Cons: That patch will introduce a new regression even for the sv39 
>> system when creating mmap with the same hint address more than one 
>> time if the hint address is less than round-gap.
> 
> I'm not quite sure what you're trying to say there.  If users are 
> passing a hint that's already allocated then they're not going to get 
> that address allocated, so as long as we give them something else we're OK.
> 

In this case, mmap will return MAP_FAILED in the second time. But on 
arm64, x86, it will pick an address in 48-bit space to use. However, 
after reviewing the code, I think it's not easy to make Charlie's patch 
search for another space to create the mapping without any changes 
outside of arch/riscv.

> We might want to take more advantage of the clause in the docs that 
> allows larger addresses to be allocated under memory pressure to avoid 
> too many allocation failures, but that applies to any of these schemes.
> 

Indeed. After thinking about it for a while, especially for the OpenJDK 
and Go people have at least talked about using the interface. If it is 
not used now, I have an idea is that to port Charlie's patch to Linux-mm 
not only for RISC-V, and pick a flag like MAP_UPPERBOUND to use it. And 
then change the mmap behavior on RISC-V to align with x86, arm64, and 
powerpc. So we have all ISAs take advantage to use Charlie's idea and 
all ISAs will treat mmap in the same way, which makes userspace 
developers happy as they don't need to care about the ISA-specific behavior.

>> 4. Some new ideas currently are not on the mailing list
>>
>> Hope this issue can be fixed before the Linux v6.9 release.
>>
>> Thanks,
>> Yangyu Chen
>>
>> [1] 
>> https://lore.kernel.org/linux-riscv/20230809232218.849726-2-charlie@rivosinc.com/
>> [2] 
>> https://github.com/ptitSeb/box64/commit/5b700cb6e6f397d2074c49659f7f9915f4a33c5f
>> [3] 
>> https://lore.kernel.org/linux-riscv/20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com/


