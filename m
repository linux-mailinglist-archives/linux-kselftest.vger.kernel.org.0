Return-Path: <linux-kselftest+bounces-6309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 400EE87B6A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 04:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17111F24D62
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 03:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442451841;
	Thu, 14 Mar 2024 03:04:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C14B7E1;
	Thu, 14 Mar 2024 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710385452; cv=none; b=Orw62CEscGUZkTsdO3Hqx6sIlcUPxGUI91Vg4Gm3LbvawEkYbpxqI/LBXDDe/Ax+6F+QiyShFRna84M/d4JN4e/+shekRdUV1BaTf38JZlXsygj6MBp2GbESn04wUQ8ghBuyAq7hlLkaNKajh1CT9ikiDk5crta/ERUoudVM4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710385452; c=relaxed/simple;
	bh=WeupC+sep6l8TNqmhA+tJld0CwFHMTozvuXCDeX3nPE=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NeZ5SIF0BbqzHa5yisbg3arftB92SyHkppCkLJf5y33UoiAuPTTyxTW8cFTT45eDR9hcY6fjyHT5IvuLENfaLWSg2RcQc7Gruvh+pW6CZs9CTgneTaD6vtpapYd9S0LKcAjd+ZP81pq6aUiBSwT1OVHQJPOlk4qE5HMJLh6XU68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8CxmeggafJl6PEYAA--.40819S3;
	Thu, 14 Mar 2024 11:04:00 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTs0dafJlhHdZAA--.36976S3;
	Thu, 14 Mar 2024 11:03:59 +0800 (CST)
Subject: Re: [PATCH v7 0/4] KVM: selftests: Add LoongArch support
From: maobibo <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240202041046.3405779-1-maobibo@loongson.cn>
Message-ID: <0276944f-0404-d09f-1e75-8e78e05a563b@loongson.cn>
Date: Thu, 14 Mar 2024 11:03:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240202041046.3405779-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTs0dafJlhHdZAA--.36976S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxury3Xr45Jr4DWF1UAF1fuFX_yoWrXFWfpa
	4I9Fn8Krs7JFyIq3Z7G34kWF1Sya1xKrWxCr1agryUuw42yry8JrWxKFWqyas5Z398XF10
	v3W8twnrW3WUtacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
	e5UUUUU==

Paolo, Sean

ping again -:)

There is little materials for Loongarch. Can I apply merge privilege for 
Loongarch kvm if you are not convenient to give the review comments?

Regards
Bibo Mao

On 2024/2/2 下午12:10, Bibo Mao wrote:
> This patchset adds KVM selftests for LoongArch system, currently only
> some common test cases are supported and pass to run. These testcase
> are listed as following:
>          demand_paging_test
>          dirty_log_perf_test
>          dirty_log_test
>          guest_print_test
>          hardware_disable_test
>          kvm_binary_stats_test
>          kvm_create_max_vcpus
>          kvm_page_table_test
>          memslot_modification_stress_test
>          memslot_perf_test
>          set_memory_region_test
> 
> This patchset originally is posted from zhaotianrui, I continue to work
> on his efforts.
> 
> ---
> Changes in v7:
> 1. Refine code to add LoongArch support in test case
> set_memory_region_test.
> 
> Changes in v6:
> 1. Refresh the patch based on latest kernel 6.8-rc1, add LoongArch
> support about testcase set_memory_region_test.
> 2. Add hardware_disable_test test case.
> 3. Drop modification about macro DEFAULT_GUEST_TEST_MEM, it is problem
> of LoongArch binutils, this issue is raised to LoongArch binutils owners.
> 
> Changes in v5:
> 1. In LoongArch kvm self tests, the DEFAULT_GUEST_TEST_MEM could be
> 0x130000000, it is different from the default value in memstress.h.
> So we Move the definition of DEFAULT_GUEST_TEST_MEM into LoongArch
> ucall.h, and add 'ifndef' condition for DEFAULT_GUEST_TEST_MEM
> in memstress.h.
> 
> Changes in v4:
> 1. Remove the based-on flag, as the LoongArch KVM patch series
> have been accepted by Linux kernel, so this can be applied directly
> in kernel.
> 
> Changes in v3:
> 1. Improve implementation of LoongArch VM page walk.
> 2. Add exception handler for LoongArch.
> 3. Add dirty_log_test, dirty_log_perf_test, guest_print_test
> test cases for LoongArch.
> 4. Add __ASSEMBLER__ macro to distinguish asm file and c file.
> 5. Move ucall_arch_do_ucall to the header file and make it as
> static inline to avoid function calls.
> 6. Change the DEFAULT_GUEST_TEST_MEM base addr for LoongArch.
> 
> Changes in v2:
> 1. We should use ".balign 4096" to align the assemble code with 4K in
> exception.S instead of "align 12".
> 2. LoongArch only supports 3 or 4 levels page tables, so we remove the
> hanlders for 2-levels page table.
> 3. Remove the DEFAULT_LOONGARCH_GUEST_STACK_VADDR_MIN and use the common
> DEFAULT_GUEST_STACK_VADDR_MIN to allocate stack memory in guest.
> 4. Reorganize the test cases supported by LoongArch.
> 5. Fix some code comments.
> 6. Add kvm_binary_stats_test test case into LoongArch KVM selftests.
> 
> ---
> Tianrui Zhao (4):
>    KVM: selftests: Add KVM selftests header files for LoongArch
>    KVM: selftests: Add core KVM selftests support for LoongArch
>    KVM: selftests: Add ucall test support for LoongArch
>    KVM: selftests: Add test cases for LoongArch
> 
>   tools/testing/selftests/kvm/Makefile          |  16 +
>   .../selftests/kvm/include/kvm_util_base.h     |   5 +
>   .../kvm/include/loongarch/processor.h         | 133 +++++++
>   .../selftests/kvm/include/loongarch/ucall.h   |  20 ++
>   .../selftests/kvm/lib/loongarch/exception.S   |  59 ++++
>   .../selftests/kvm/lib/loongarch/processor.c   | 332 ++++++++++++++++++
>   .../selftests/kvm/lib/loongarch/ucall.c       |  38 ++
>   .../selftests/kvm/set_memory_region_test.c    |   2 +-
>   8 files changed, 604 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/kvm/include/loongarch/processor.h
>   create mode 100644 tools/testing/selftests/kvm/include/loongarch/ucall.h
>   create mode 100644 tools/testing/selftests/kvm/lib/loongarch/exception.S
>   create mode 100644 tools/testing/selftests/kvm/lib/loongarch/processor.c
>   create mode 100644 tools/testing/selftests/kvm/lib/loongarch/ucall.c
> 
> 
> base-commit: 6764c317b6bb91bd806ef79adf6d9c0e428b191e
> 


