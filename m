Return-Path: <linux-kselftest+bounces-30813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2EA89141
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 03:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7954E189A310
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 01:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5861FECAA;
	Tue, 15 Apr 2025 01:28:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAE019C546;
	Tue, 15 Apr 2025 01:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680512; cv=none; b=MIKsaSLGkuHkIxGe4onnX5ydsEOKnBefj/NHmDGYtqmY8C26VL/CfKf8s+9YHtAnyAPww9Xk8EwBtYLK877IdPpvI7n6B3jIT0D0fC2ymrdPwK2UWfFpXHh+5EEWL0mpfX+Rctzg4w4HEjA7FJMUJkXnY2OqOPUk0jKabnXOJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680512; c=relaxed/simple;
	bh=SaohrLoRmE27lRYQjO06lx8r/oqXRqPYGTDzzwDjF2Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SoZZnthtC4cQD0SQMHVU6/x8ZJ3JOHI8HTq3zcv8N0oFeN27LodBJk+8uPU9gtO7gERsyshvp8Io8FZsUt79RrgPbe8faw9z1Dr2K5dIh3+TFo/QzJ6utU5tQ4R9TnEFC/RQZgagkYTeBmPFxu/b2US/Lsy/cN1ULSm3afudYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxC3Iytv1nfiy9AA--.51612S3;
	Tue, 15 Apr 2025 09:28:18 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMDx_MQutv1nXtyBAA--.54195S3;
	Tue, 15 Apr 2025 09:28:17 +0800 (CST)
Subject: Re: [PATCH v8 1/4] KVM: selftests: Add KVM selftests header files for
 LoongArch
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250410035647.3501139-1-maobibo@loongson.cn>
 <20250410035647.3501139-2-maobibo@loongson.cn>
 <CAAhV-H5-RXzHP8L2Hv6Drvaakwv4v=NYcDQhQUkzOEcgPTMm1Q@mail.gmail.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <190f4d5f-08e3-5200-053e-573e64a5ce11@loongson.cn>
Date: Tue, 15 Apr 2025 09:27:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5-RXzHP8L2Hv6Drvaakwv4v=NYcDQhQUkzOEcgPTMm1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx_MQutv1nXtyBAA--.54195S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xr4Uuw1kKF15CFyUCw15GFX_yoW3Jw48pF
	1UCFy8Kr48tF47K340q3ZYvr12gr4IyF18KryfXrWjkFs8X348Gr1j9F45GFy5Xws5WryU
	Aryvqw4a9r9rK3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
	JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU



On 2025/4/14 下午9:59, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Thu, Apr 10, 2025 at 11:57 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Add KVM selftests header files for LoongArch, including processor.h
>> and kvm_util_base.h. It mainly contains LoongArch CSR register
>> definition and page table entry definition.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   .../testing/selftests/kvm/include/kvm_util.h  |   5 +
>>   .../kvm/include/loongarch/kvm_util_arch.h     |   7 +
>>   .../kvm/include/loongarch/processor.h         | 138 ++++++++++++++++++
>>   3 files changed, 150 insertions(+)
>>   create mode 100644 tools/testing/selftests/kvm/include/loongarch/kvm_util_arch.h
>>   create mode 100644 tools/testing/selftests/kvm/include/loongarch/processor.h
>>
>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>> index 373912464fb4..d9cb62207c57 100644
>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>> @@ -232,6 +232,11 @@ extern enum vm_guest_mode vm_mode_default;
>>   #define MIN_PAGE_SHIFT                 12U
>>   #define ptes_per_page(page_size)       ((page_size) / 8)
>>
>> +#elif defined(__loongarch__)
>> +#define VM_MODE_DEFAULT                        VM_MODE_P36V47_16K
> Maybe we can add VM_MODE_P40V47_16K and VM_MODE_P48V47_16K? That is
> more suitable for LoongArch in my opinion.

yeap, this is reasonable, VM_MODE_P36V47_16K is a little strange. I will 
try to add VM_MODE_P47V47_16K mode, since GPA size cannot be larger than 
HVA size on LoongArch system, GPA size is limited within 47bit.

Regards
Bibo Mao
> 
>> +#define MIN_PAGE_SHIFT                 12U
>> +#define ptes_per_page(page_size)       ((page_size) / 8)
>> +
>>   #endif
>>
>>   #define VM_SHAPE_DEFAULT       VM_SHAPE(VM_MODE_DEFAULT)
>> diff --git a/tools/testing/selftests/kvm/include/loongarch/kvm_util_arch.h b/tools/testing/selftests/kvm/include/loongarch/kvm_util_arch.h
>> new file mode 100644
>> index 000000000000..e43a57d99b56
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/include/loongarch/kvm_util_arch.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef SELFTEST_KVM_UTIL_ARCH_H
>> +#define SELFTEST_KVM_UTIL_ARCH_H
>> +
>> +struct kvm_vm_arch {};
>> +
>> +#endif  // SELFTEST_KVM_UTIL_ARCH_H
>> diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
>> new file mode 100644
>> index 000000000000..e95dd2059605
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
>> @@ -0,0 +1,138 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#ifndef SELFTEST_KVM_PROCESSOR_H
>> +#define SELFTEST_KVM_PROCESSOR_H
>> +
>> +#ifndef __ASSEMBLER__
>> +#include "ucall_common.h"
>> +
>> +#else
>> +/* general registers */
>> +#define zero                           $r0
>> +#define ra                             $r1
>> +#define tp                             $r2
>> +#define sp                             $r3
>> +#define a0                             $r4
>> +#define a1                             $r5
>> +#define a2                             $r6
>> +#define a3                             $r7
>> +#define a4                             $r8
>> +#define a5                             $r9
>> +#define a6                             $r10
>> +#define a7                             $r11
>> +#define t0                             $r12
>> +#define t1                             $r13
>> +#define t2                             $r14
>> +#define t3                             $r15
>> +#define t4                             $r16
>> +#define t5                             $r17
>> +#define t6                             $r18
>> +#define t7                             $r19
>> +#define t8                             $r20
>> +#define u0                             $r21
>> +#define fp                             $r22
>> +#define s0                             $r23
>> +#define s1                             $r24
>> +#define s2                             $r25
>> +#define s3                             $r26
>> +#define s4                             $r27
>> +#define s5                             $r28
>> +#define s6                             $r29
>> +#define s7                             $r30
>> +#define s8                             $r31
>> +#endif
>> +
>> +/* LoongArch page table entry definition */
>> +#define _PAGE_VALID_SHIFT              0
>> +#define _PAGE_DIRTY_SHIFT              1
>> +#define _PAGE_PLV_SHIFT                        2  /* 2~3, two bits */
>> +#define  PLV_KERN                      0
>> +#define  PLV_USER                      3
>> +#define  PLV_MASK                      0x3
>> +#define _CACHE_SHIFT                   4  /* 4~5, two bits */
>> +#define _PAGE_PRESENT_SHIFT            7
>> +#define _PAGE_WRITE_SHIFT              8
>> +
>> +#define _PAGE_VALID                    BIT_ULL(_PAGE_VALID_SHIFT)
>> +#define _PAGE_PRESENT                  BIT_ULL(_PAGE_PRESENT_SHIFT)
>> +#define _PAGE_WRITE                    BIT_ULL(_PAGE_WRITE_SHIFT)
>> +#define _PAGE_DIRTY                    BIT_ULL(_PAGE_DIRTY_SHIFT)
>> +#define _PAGE_USER                     (PLV_USER << _PAGE_PLV_SHIFT)
>> +#define   __READABLE                   (_PAGE_VALID)
>> +#define   __WRITEABLE                  (_PAGE_DIRTY | _PAGE_WRITE)
>> +/* Coherent Cached */
>> +#define _CACHE_CC                      BIT_ULL(_CACHE_SHIFT)
>> +#define PS_4K                          0x0000000c
>> +#define PS_8K                          0x0000000d
>> +#define PS_16K                         0x0000000e
> The page size supported by kernel is 4K, 16K and 64K, so remove 8K and add 64K?
> 
> Huacai
> 
>> +#define PS_DEFAULT_SIZE                        PS_16K
>> +
>> +/* LoongArch Basic CSR registers */
>> +#define LOONGARCH_CSR_CRMD             0x0 /* Current mode info */
>> +#define  CSR_CRMD_PG_SHIFT             4
>> +#define  CSR_CRMD_PG                   BIT_ULL(CSR_CRMD_PG_SHIFT)
>> +#define  CSR_CRMD_IE_SHIFT             2
>> +#define  CSR_CRMD_IE                   BIT_ULL(CSR_CRMD_IE_SHIFT)
>> +#define  CSR_CRMD_PLV_SHIFT            0
>> +#define  CSR_CRMD_PLV_WIDTH            2
>> +#define  CSR_CRMD_PLV                  (0x3UL << CSR_CRMD_PLV_SHIFT)
>> +#define  PLV_MASK                      0x3
>> +#define LOONGARCH_CSR_PRMD             0x1
>> +#define LOONGARCH_CSR_EUEN             0x2
>> +#define LOONGARCH_CSR_ECFG             0x4
>> +#define LOONGARCH_CSR_ESTAT            0x5  /* Exception status */
>> +#define LOONGARCH_CSR_ERA              0x6  /* ERA */
>> +#define LOONGARCH_CSR_BADV             0x7  /* Bad virtual address */
>> +#define LOONGARCH_CSR_EENTRY           0xc
>> +#define LOONGARCH_CSR_TLBIDX           0x10 /* TLB Index, EHINV, PageSize */
>> +#define  CSR_TLBIDX_PS_SHIFT           24
>> +#define  CSR_TLBIDX_PS_WIDTH           6
>> +#define  CSR_TLBIDX_PS                 (0x3fUL << CSR_TLBIDX_PS_SHIFT)
>> +#define  CSR_TLBIDX_SIZEM              0x3f000000
>> +#define  CSR_TLBIDX_SIZE               CSR_TLBIDX_PS_SHIFT
>> +#define LOONGARCH_CSR_ASID             0x18 /* ASID */
>> +#define LOONGARCH_CSR_PGDL             0x19
>> +#define LOONGARCH_CSR_PGDH             0x1a
>> +/* Page table base */
>> +#define LOONGARCH_CSR_PGD              0x1b
>> +#define LOONGARCH_CSR_PWCTL0           0x1c
>> +#define LOONGARCH_CSR_PWCTL1           0x1d
>> +#define LOONGARCH_CSR_STLBPGSIZE       0x1e
>> +#define LOONGARCH_CSR_CPUID            0x20
>> +#define LOONGARCH_CSR_KS0              0x30
>> +#define LOONGARCH_CSR_KS1              0x31
>> +#define LOONGARCH_CSR_TMID             0x40
>> +#define LOONGARCH_CSR_TCFG             0x41
>> +/* TLB refill exception entry */
>> +#define LOONGARCH_CSR_TLBRENTRY                0x88
>> +#define LOONGARCH_CSR_TLBRSAVE         0x8b
>> +#define LOONGARCH_CSR_TLBREHI          0x8e
>> +#define  CSR_TLBREHI_PS_SHIFT          0
>> +#define  CSR_TLBREHI_PS                        (0x3fUL << CSR_TLBREHI_PS_SHIFT)
>> +
>> +#define EXREGS_GPRS                    (32)
>> +
>> +#ifndef __ASSEMBLER__
>> +void handle_tlb_refill(void);
>> +void handle_exception(void);
>> +
>> +struct ex_regs {
>> +       unsigned long regs[EXREGS_GPRS];
>> +       unsigned long pc;
>> +       unsigned long estat;
>> +       unsigned long badv;
>> +};
>> +
>> +#define PC_OFFSET_EXREGS               offsetof(struct ex_regs, pc)
>> +#define ESTAT_OFFSET_EXREGS            offsetof(struct ex_regs, estat)
>> +#define BADV_OFFSET_EXREGS             offsetof(struct ex_regs, badv)
>> +#define EXREGS_SIZE                    sizeof(struct ex_regs)
>> +
>> +#else
>> +#define PC_OFFSET_EXREGS               ((EXREGS_GPRS + 0) * 8)
>> +#define ESTAT_OFFSET_EXREGS            ((EXREGS_GPRS + 1) * 8)
>> +#define BADV_OFFSET_EXREGS             ((EXREGS_GPRS + 2) * 8)
>> +#define EXREGS_SIZE                    ((EXREGS_GPRS + 3) * 8)
>> +#endif
>> +
>> +#endif /* SELFTEST_KVM_PROCESSOR_H */
>> --
>> 2.39.3
>>


