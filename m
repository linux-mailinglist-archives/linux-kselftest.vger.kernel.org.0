Return-Path: <linux-kselftest+bounces-5520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A8086AA71
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 09:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376A91C21201
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 08:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BB82D052;
	Wed, 28 Feb 2024 08:51:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131EA2D604;
	Wed, 28 Feb 2024 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110263; cv=none; b=L5iqttCwwpEgnsCC7Ba0gq0R1Znrf0rTkPgD/isThNJpqLOPnMcChOozsJOwJg9MUmRziyplKAtc/EWt2+i1BeFjocMQ+KVLQzqyPZUSde+FzApDXWehaPh1FODu8Jj0vIQruLCY3FSNd4wVhaPncuLpb3Y0uiLoGFR78hFdAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110263; c=relaxed/simple;
	bh=FF65Jmeuin6I8vITgMeAspe0JypO8S2zvX1rI8TCGZo=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fu95PwZco2l0aKYvDLVnfoq9csEAVFEADcmXgqzLmfm83tCMRoWDMA9iXhmh+UdjocAugYojNxWo4uAhJP+qMpCZKNnVbUheumu2XIOEdOtbnr6883ZdxLcVuxbug83M6wxWZZ36rfwrXTF/lMJnmi+YlY7HQcrctaceA2uADYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8Ax++jr895lq1YSAA--.26909S3;
	Wed, 28 Feb 2024 16:50:51 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnhPm895lSq5JAA--.10005S3;
	Wed, 28 Feb 2024 16:50:48 +0800 (CST)
Subject: Re: [PATCH v7 0/4] KVM: selftests: Add LoongArch support
From: maobibo <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240202041046.3405779-1-maobibo@loongson.cn>
Message-ID: <14864f68-83a9-da9c-4dd2-d8fb69f551cc@loongson.cn>
Date: Wed, 28 Feb 2024 16:51:09 +0800
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
X-CM-TRANSID:AQAAf8BxnhPm895lSq5JAA--.10005S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr15trW3Ww4UWF4ftrWUGFX_yoWrGFy5pa
	4I9Fn5Krs7GFy2q3Z3G34ku3WSya1xKrWxCr1agryUuw12yry8JrWxKFZ0yas5Z398XF10
	v3W8twnxW3WUtacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
	e5UUUUU==

ping.

Can it be merged for 6.9?

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


