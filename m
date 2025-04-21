Return-Path: <linux-kselftest+bounces-31221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89D7A94A22
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 03:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5F73AF77A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 01:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2111BDDA9;
	Mon, 21 Apr 2025 01:24:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D312A8C1;
	Mon, 21 Apr 2025 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745198665; cv=none; b=YSJq0cO5TRDiznLe60f38pjEteVM/eSgnPG6YyYh00dwq7JEIjF18fDTIBjoOqw+Py6MYSvdkqldKA60mpXf0p0F4XKRN5xjWDS3HnNvFOZFsFwPvOL/DYDEYxn/Bveh8MDchHG7P4rT7xqLFLrD6pYOyAnZs/rQMzEAEmDE6Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745198665; c=relaxed/simple;
	bh=38P/4m6kz7UcP/LeFd38nmslSW1QRvYi5OSQ/+dn1SY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Df5eNIJSc1cNd5aM18FCOmcuKQC7r7KSi8MfNs9UJCxJNG8mJFXUSmjZT2PyQpxWMnk7zqiIVR9rbiJKii/SstH7CDKvz29JzqeyQ/m/4hrIk4jVFugFhOMVbnMwyTKpJBGoS6DF20pg2ukzoipaVzpJAodz9tpE3rLoiA++Omc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxbKxDngVoCSXDAA--.61039S3;
	Mon, 21 Apr 2025 09:24:19 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMBxXsU5ngVoHZqNAA--.23617S3;
	Mon, 21 Apr 2025 09:24:13 +0800 (CST)
Subject: Re: [PATCH v9 2/5] KVM: selftests: Add KVM selftests header files for
 LoongArch
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250416035455.25996-1-maobibo@loongson.cn>
 <20250416035455.25996-3-maobibo@loongson.cn>
 <CAAhV-H7p7KM=Qwf8w5qd2JrS0dn+iqZzzWm9xBpFvXA+uG_ALA@mail.gmail.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <88ca6a5e-701f-9eb3-69b6-40e1e3aa691b@loongson.cn>
Date: Mon, 21 Apr 2025 09:23:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7p7KM=Qwf8w5qd2JrS0dn+iqZzzWm9xBpFvXA+uG_ALA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxXsU5ngVoHZqNAA--.23617S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww15uw1UZFy5CF4xZFy7Arc_yoWxKr1rpF
	1UCFy8Kr48tF47K340q3ZYvw12gr4IyF1UKryfXrWqkFs8X348Gr1j9F45GFy5Xws5WryU
	AFyvqw4a9r9rK3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1
	WlkUUUUU=



On 2025/4/20 下午3:38, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Wed, Apr 16, 2025 at 11:55 AM Bibo Mao <maobibo@loongson.cn> wrote:
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
>> index f8faed8c8024..93013564428b 100644
>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>> @@ -233,6 +233,11 @@ extern enum vm_guest_mode vm_mode_default;
>>   #define MIN_PAGE_SHIFT                 12U
>>   #define ptes_per_page(page_size)       ((page_size) / 8)
>>
>> +#elif defined(__loongarch__)
>> +#define VM_MODE_DEFAULT                        VM_MODE_P47V47_16K
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
> As I said in V8, the page size supported by kernel is 4K, 16K and 64K,
> so you can remove 8K and add 64K.
Sorry for this. I do not notice this comments.
Will remove 8K and add 64K support.

Regards
Bibo Mao
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


