Return-Path: <linux-kselftest+bounces-2938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C96A82C918
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 03:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E622870BA
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 02:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570EF18E0F;
	Sat, 13 Jan 2024 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uOJsv9LK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81C17C8B;
	Sat, 13 Jan 2024 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hDwqzNi1PcXZTLlr68PnvxDCWLFZWTpmEkp1rt/m4/s=; b=uOJsv9LKLFU46WnzBBpwUqtmi8
	LCSk0L0PpV3GaYhg/Xf7wjHac8APVuZQOKdD6QCJUgVcUmEvnmtkkeMHnkpLwPzcg1zGS0UiOto42
	aBdWVAbkyVOpEdUeOwth/kGWbbiqQn8+gE9E/f9LKhwI+meNbnxl4Cz1lXBXS3Pvba9pzsnnnzG/q
	iI22qaV/YaMiPrSPrNE6iqpJ6dY6eNfG9Y+kz/H7jxOxHFmXpz0iSqx5fUlQIQ1Cpm3kCOE1gohHe
	XHbHQNIe5Z8wDvQxBpGVfogNb8b9YmFlkPeXBOPtOpz5K7Uo467Tgh8XcpwCmw/RBQWfF1UbslFSi
	VbEQbC1g==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rOTcs-004RUV-22;
	Sat, 13 Jan 2024 02:19:58 +0000
Message-ID: <c65170fe-f596-4ce0-96e3-ba83f4e60eaf@infradead.org>
Date: Fri, 12 Jan 2024 18:19:55 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Introduce mseal()
Content-Language: en-US
To: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
 jannh@google.com, sroettger@google.com, willy@infradead.org,
 gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
 usama.anjum@collabora.com
Cc: jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org
References: <20240111234142.2944934-1-jeffxu@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240111234142.2944934-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/11/24 15:41, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> This patchset proposes a new mseal() syscall for the Linux kernel.
> 

Jeff,
Building arm64 defconfig, on linux-next-20240112, I get:

  CC      arch/arm64/kernel/asm-offsets.s
In file included from ../include/uapi/linux/mman.h:5,
                 from ../include/linux/mm.h:33,
                 from ../include/linux/memblock.h:12,
                 from ../arch/arm64/include/asm/acpi.h:14,
                 from ../include/acpi/acpi_io.h:7,
                 from ../include/linux/acpi.h:39,
                 from ../include/acpi/apei.h:9,
                 from ../include/acpi/ghes.h:5,
                 from ../include/linux/arm_sdei.h:8,
                 from ../arch/arm64/kernel/asm-offsets.c:10:
../arch/arm64/include/asm/mman.h: In function 'arch_calc_vm_prot_bits':
../arch/arm64/include/asm/mman.h:15:24: error: 'VM_ARM64_BTI' undeclared (first use in this function); did you mean 'ARM64_BTI'?
   15 |                 ret |= VM_ARM64_BTI;
      |                        ^~~~~~~~~~~~
      |                        ARM64_BTI
../arch/arm64/include/asm/mman.h:15:24: note: each undeclared identifier is reported only once for each function it appears in
../arch/arm64/include/asm/mman.h:18:24: error: 'VM_MTE' undeclared (first use in this function); did you mean 'VM_MAP'?
   18 |                 ret |= VM_MTE;
      |                        ^~~~~~
      |                        VM_MAP
../arch/arm64/include/asm/mman.h: In function 'arch_calc_vm_flag_bits':
../arch/arm64/include/asm/mman.h:32:24: error: 'VM_MTE_ALLOWED' undeclared (first use in this function)
   32 |                 return VM_MTE_ALLOWED;
      |                        ^~~~~~~~~~~~~~
../arch/arm64/include/asm/mman.h: In function 'arch_validate_flags':
../arch/arm64/include/asm/mman.h:59:29: error: 'VM_MTE' undeclared (first use in this function); did you mean 'VM_MAP'?
   59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
      |                             ^~~~~~
      |                             VM_MAP
../arch/arm64/include/asm/mman.h:59:52: error: 'VM_MTE_ALLOWED' undeclared (first use in this function)
   59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
      |                                                    ^~~~~~~~~~~~~~


-- 
#Randy

