Return-Path: <linux-kselftest+bounces-29925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FACFA75AAC
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 17:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144BB166520
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AED91D798E;
	Sun, 30 Mar 2025 15:36:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BA835973;
	Sun, 30 Mar 2025 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743349015; cv=none; b=FENz5a3pwicfTPeLavfWgDJvVpsoQScKbXKa9Ily5Y3LvSqJvlnY8AW/hzr4fdxTl5hlKXnnUhFy2TxmiSisNUue2nnoTPoCso2NNUzOoAACxBNj62wLNpM9//QzKzj6vb8G2S0tWSRNNNcGTHa2uROpzEOppHjhyAwAYPIO+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743349015; c=relaxed/simple;
	bh=XweAKWXxUC23DUIurG+R29h2z/MkdSB1+ji3iZkr25E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spLNMSwS3LLFznkrcVGxuxOl4SY7Ul8pNzZ9Ei1hegmbCak35zA/yqSVm7sGw8wiC6/W+GvMTB9icuO+U9Ibyq7tCoE5E6+MWzTrq3URPmsfHLHZCkJDUbbK7D22wRk/QZsScUIS6kQjW68cX0TaQbQMxSlJLeCU/974UumJ/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41912441CD;
	Sun, 30 Mar 2025 15:36:50 +0000 (UTC)
Message-ID: <7c3b13e1-425d-4471-91fd-7156c4758719@ghiti.fr>
Date: Sun, 30 Mar 2025 17:36:49 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: riscv: fix v_exec_initval_nolibc.c
Content-Language: en-US
To: Ignacio Encinas Rubio <ignacio@iencinas.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
References: <20250306-fix-v_exec_initval_nolibc-v2-1-97f9dc8a7faf@iencinas.com>
 <14e0cc95-95d7-4e7d-949b-d944366510a3@iencinas.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <14e0cc95-95d7-4e7d-949b-d944366510a3@iencinas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeejgeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeejkeeugfdthefhveelffdvgeetgeelteeijeekheehfeevtdduvdfgteevgfehffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemiegrjeelmeejkedutgemhegsvggsmeelleelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemiegrjeelmeejkedutgemhegsvggsmeelleelhedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemiegrjeelmeejkedutgemhegsvggsmeelleelhegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehighhnrggtihhosehivghntghinhgrshdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfi
 hhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehskhhhrghnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlqdhmvghnthgvvghssehlihhsthhsrdhlihhnuhigrdguvghv
X-GND-Sasl: alex@ghiti.fr

Hi ignacio,

On 30/03/2025 13:12, Ignacio Encinas Rubio wrote:
> Gentle ping :)


No worries, it's either being merged in 6.15-rc1 or rc2!

Thanks,

Alex


>
> On 6/3/25 20:49, Ignacio Encinas wrote:
>> Vector registers are zero initialized by the kernel. Stop accepting
>> "all ones" as a clean value.
>>
>> Note that this was not working as expected given that
>> 	value == 0xff
>> can be assumed to be always false by the compiler as value's range is
>> [-128, 127]. Both GCC (-Wtype-limits) and clang
>> (-Wtautological-constant-out-of-range-compare) warn about this.
>>
>> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
>> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
>> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
>> ---
>> Changes in v2:
>>
>> Remove code that becomes useless now that the only "clean" value for
>> vector registers is 0.
>>
>> - Link to v1: https://lore.kernel.org/r/20250305-fix-v_exec_initval_nolibc-v1-1-b87b60e43002@iencinas.com
>> ---
>>   tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
>> index 35c0812e32de0c82a54f84bd52c4272507121e35..4dde05e45a04122b566cedc36d20b072413b00e2 100644
>> --- a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
>> +++ b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
>> @@ -6,7 +6,7 @@
>>    * the values. To further ensure consistency, this file is compiled without
>>    * libc and without auto-vectorization.
>>    *
>> - * To be "clean" all values must be either all ones or all zeroes.
>> + * To be "clean" all values must be all zeroes.
>>    */
>>   
>>   #define __stringify_1(x...)	#x
>> @@ -14,9 +14,8 @@
>>   
>>   int main(int argc, char **argv)
>>   {
>> -	char prev_value = 0, value;
>> +	char value = 0;
>>   	unsigned long vl;
>> -	int first = 1;
>>   
>>   	if (argc > 2 && strcmp(argv[2], "x"))
>>   		asm volatile (
>> @@ -44,14 +43,11 @@ int main(int argc, char **argv)
>>   			"vsrl.vi " __stringify(register) ", " __stringify(register) ", 8\n\t" \
>>   			".option pop\n\t"					\
>>   			: "=r" (value));					\
>> -		if (first) {							\
>> -			first = 0;						\
>> -		} else if (value != prev_value || !(value == 0x00 || value == 0xff)) { \
>> +		if (value != 0x00) {						\
>>   			printf("Register " __stringify(register)		\
>>   				" values not clean! value: %u\n", value);	\
>>   			exit(-1);						\
>>   		}								\
>> -		prev_value = value;						\
>>   	}									\
>>   })
>>   
>>
>> ---
>> base-commit: 03d38806a902b36bf364cae8de6f1183c0a35a67
>> change-id: 20250301-fix-v_exec_initval_nolibc-498d976c372d
>>
>> Best regards,
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

