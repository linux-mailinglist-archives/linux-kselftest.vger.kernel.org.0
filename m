Return-Path: <linux-kselftest+bounces-2942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C5B82CA09
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 06:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BDA1C2280F
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 05:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44C3FBEC;
	Sat, 13 Jan 2024 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h5M/1VGt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530EF4F5;
	Sat, 13 Jan 2024 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=yS6I6mddaN1yhy8N4LUTGdLFHpiWXV0zrUgAi9pBpv4=; b=h5M/1VGtX+ODHUeJEoWo69qsbW
	z6FFC22WSyh33kzA7XO2XfdN5fg60WbujwazNJUVxZC0wrH9qzw+Zd5rfqk4DpGaGyFd7651Y3pJa
	5l0Ol3isbnzMD1khnGn/sinOaf7tsVIQGZ969EPt/zIf4PrS0MN3ce6nYiv6K+cIhSO3WSFJYWPLu
	kMhy412zKba0Nso3hCjJw3bqc7sfCgzEiItUuinmJmWOyHQdPLgT8UfCn275137linx2xBu5aM1Vh
	Fg634eI7ESNhLxbYXpCj+X8zTzl8GrrlP4KGg8cRWwzbiQ56xQf3OH4N1miNeVRsVU8G5oeKNG5x8
	A+0Vr+kA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rOX16-004aGO-0f;
	Sat, 13 Jan 2024 05:57:12 +0000
Message-ID: <84df0f74-b165-4076-97bc-9f90e29410d4@infradead.org>
Date: Fri, 12 Jan 2024 21:57:04 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Introduce mseal()
Content-Language: en-US
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
 sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org,
 torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com,
 jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org
References: <20240111234142.2944934-1-jeffxu@chromium.org>
 <c65170fe-f596-4ce0-96e3-ba83f4e60eaf@infradead.org>
 <CABi2SkXt2_eBS=7QkPST0uHGaaEszRJbVLajbwM95RWJrbDXwQ@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CABi2SkXt2_eBS=7QkPST0uHGaaEszRJbVLajbwM95RWJrbDXwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/12/24 20:53, Jeff Xu wrote:
> On Fri, Jan 12, 2024 at 6:20 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 1/11/24 15:41, jeffxu@chromium.org wrote:
>>> From: Jeff Xu <jeffxu@google.com>
>>>
>>> This patchset proposes a new mseal() syscall for the Linux kernel.
>>>
>>
>> Jeff,
>> Building arm64 defconfig, on linux-next-20240112, I get:
>>
> I don't quite get how this is related to my change.
> Can you please send me the steps to reproduce ?  I don't usually build arm.

I don't get how it's related either, but when I build arm64 defconfig without
your patches, it builds without errors. After applying your patches, it has
errors... I did it 2 times just to make sure.

It may just be some difference between x86_64 headers (is that what you
build?) and arm64 headers.

Install the x86_64-hosted arm64 compiler from
https://mirrors.edge.kernel.org/pub/tools/crosstool/ in
e.g. /opt/crosstool .


In the kernel source tree:
mkdir ARM64

make ARCH=arm64 O=ARM64 defconfig
make -j25 CROSS_COMPILE=/opt/crosstool/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux- ARCH=arm64 O=ARM64 all 2>&1 | tee aa64defcon.lst

make ARCH=arm64 O=ARM64 clean
<apply your mseal patches>
make -j25 CROSS_COMPILE=/opt/crosstool/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux- ARCH=arm64 O=ARM64 all 2>&1 | tee aa64mseal.lst


If that does not reproduce the problem, please let me know.

(I use a script, but that's the essence of the script.)



>>   CC      arch/arm64/kernel/asm-offsets.s
>> In file included from ../include/uapi/linux/mman.h:5,
>>                  from ../include/linux/mm.h:33,
>>                  from ../include/linux/memblock.h:12,
>>                  from ../arch/arm64/include/asm/acpi.h:14,
>>                  from ../include/acpi/acpi_io.h:7,
>>                  from ../include/linux/acpi.h:39,
>>                  from ../include/acpi/apei.h:9,
>>                  from ../include/acpi/ghes.h:5,
>>                  from ../include/linux/arm_sdei.h:8,
>>                  from ../arch/arm64/kernel/asm-offsets.c:10:
>> ../arch/arm64/include/asm/mman.h: In function 'arch_calc_vm_prot_bits':
>> ../arch/arm64/include/asm/mman.h:15:24: error: 'VM_ARM64_BTI' undeclared (first use in this function); did you mean 'ARM64_BTI'?
>>    15 |                 ret |= VM_ARM64_BTI;
>>       |                        ^~~~~~~~~~~~
>>       |                        ARM64_BTI
>> ../arch/arm64/include/asm/mman.h:15:24: note: each undeclared identifier is reported only once for each function it appears in
>> ../arch/arm64/include/asm/mman.h:18:24: error: 'VM_MTE' undeclared (first use in this function); did you mean 'VM_MAP'?
>>    18 |                 ret |= VM_MTE;
>>       |                        ^~~~~~
>>       |                        VM_MAP
>> ../arch/arm64/include/asm/mman.h: In function 'arch_calc_vm_flag_bits':
>> ../arch/arm64/include/asm/mman.h:32:24: error: 'VM_MTE_ALLOWED' undeclared (first use in this function)
>>    32 |                 return VM_MTE_ALLOWED;
>>       |                        ^~~~~~~~~~~~~~
>> ../arch/arm64/include/asm/mman.h: In function 'arch_validate_flags':
>> ../arch/arm64/include/asm/mman.h:59:29: error: 'VM_MTE' undeclared (first use in this function); did you mean 'VM_MAP'?
>>    59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
>>       |                             ^~~~~~
>>       |                             VM_MAP
>> ../arch/arm64/include/asm/mman.h:59:52: error: 'VM_MTE_ALLOWED' undeclared (first use in this function)
>>    59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
>>       |                                                    ^~~~~~~~~~~~~~
>>
>>
>> --
>> #Randy
> 

-- 
#Randy

