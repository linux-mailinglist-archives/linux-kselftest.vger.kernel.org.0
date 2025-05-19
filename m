Return-Path: <linux-kselftest+bounces-33318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A879ABBA38
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 11:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2AA189E2F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6B3278756;
	Mon, 19 May 2025 09:44:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD4626E145;
	Mon, 19 May 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647840; cv=none; b=e4lIGkX/4I9eyY/D+PtAlRfZEA3Lr1r7R5IF88F82Jx0qD7UTA5imz5GepbR4bq7hP5X7atZ1EBKXtWHfnoRFvjAKUv/HRYrWOImlH0ZV+ciso2s9QHNrU/OXF8b4R7GAsB+RQncYBcwv2rSITZVAbBkNU4aE/OG5EkkrJHzcpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647840; c=relaxed/simple;
	bh=AvqDbO+/B/tISbPAGjzmpBR9SBGm2kzK0G1DQEkpAJE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PJr+uvii2B8V069HXZaOOLVLfCshOm+vR3ILogt738g7v1FLrDDR7LmilD/FH/TKkkdq0FQaCT5b1oeXGg7mmwdjujHQA8yhSpLcP3DGzCrk+bQ1TMHKHiSh5jveIUMfHx+SbP+qVGW5d6FMa0cCc7GtNShWNST3XGKDp6dBPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Axx2lY_SpoC+_xAA--.29221S3;
	Mon, 19 May 2025 17:43:52 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMCx_cZV_SpoxvjgAA--.55634S3;
	Mon, 19 May 2025 17:43:51 +0800 (CST)
Subject: Re: [PATCH v11 0/5] KVM: selftests: Add LoongArch support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250427064535.242404-1-maobibo@loongson.cn>
 <CAAhV-H7XmHcvea-8NvgnSzfg6dVt5wATyDKmDYp31ThYZa+Fgw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <2a0f6edc-533f-9384-bd1e-e811310dbf2b@loongson.cn>
Date: Mon, 19 May 2025 17:42:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7XmHcvea-8NvgnSzfg6dVt5wATyDKmDYp31ThYZa+Fgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx_cZV_SpoxvjgAA--.55634S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKr18ur15WFyrAF4fJF1xCrX_yoW7uFyxpa
	yI9Fn8Kr4xGF1xA3Z7K34kZFyFyan3Kr4xur13tryUuw1qyry8J3yxKFs0kas3Z398X3WF
	v3WxtF13W3WUtagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcVc_
	UUUUU



On 2025/5/12 下午2:53, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Sun, Apr 27, 2025 at 2:45 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> This patchset adds KVM selftests for LoongArch system, currently only
>> some common test cases are supported and pass to run. These test cases
>> are listed as following:
>>      coalesced_io_test
>>      demand_paging_test
>>      dirty_log_perf_test
>>      dirty_log_test
>>      guest_print_test
>>      hardware_disable_test
>>      kvm_binary_stats_test
>>      kvm_create_max_vcpus
>>      kvm_page_table_test
>>      memslot_modification_stress_test
>>      memslot_perf_test
>>      set_memory_region_test
> I have applied this series [1] but with some modifications (see
> comments in other patches). You can test it to see if everything is
> OK.
> 
> And if it's OK, it is better to fetch the patches from [1] and then send V12.
There is error reporting with checkpatch as followings:
ERROR: trailing statements should be on next line
#281: FILE: tools/testing/selftests/kvm/lib/loongarch/processor.c:192:
+       while (1) ;

This is already solved in V9, which patch does [1] come from?
+void route_exception(struct ex_regs *regs)
+{
+       unsigned long pc, estat, badv;
+
+       pc = regs->pc;
+       estat = regs->estat;
+       badv  = regs->badv;
+       ucall(UCALL_UNHANDLED, 3, pc, estat, badv);
+       while (1)
+               ;
+}

Regards
Bibo Mao
> 
> [1] https://github.com/chenhuacai/linux/commits/loongarch-next
> 
> 
> 
> Huacai
> 
>>
>> ---
>> Changes in v11:
>> 1. Fix a typo issue in notes of patch 2, it is kvm_util_arch.h rather than
>>     kvm_util_base.h
>>
>> Changes in v10:
>> 1. Add PS_64K and remove PS_8K in file include/loongarch/processor.h
>> 2. Fix a typo issue in file lib/loongarch/processor.c
>> 3. Update file MAINTAINERS about LoongArch KVM selftests
>>
>> Changes in v9:
>> 1. Add vm mode VM_MODE_P47V47_16K, LoongArch VM uses this mode by
>>     default, rather than VM_MODE_P36V47_16K.
>> 2. Refresh some spelling issues in changelog.
>>
>> Changes in v8:
>> 1. Porting patch based on the latest version.
>> 2. For macro PC_OFFSET_EXREGS, offsetof() method is used for C header file,
>>     still hardcoded definition for assemble language.
>>
>> Changes in v7:
>> 1. Refine code to add LoongArch support in test case
>> set_memory_region_test.
>>
>> Changes in v6:
>> 1. Refresh the patch based on latest kernel 6.8-rc1, add LoongArch
>> support about testcase set_memory_region_test.
>> 2. Add hardware_disable_test test case.
>> 3. Drop modification about macro DEFAULT_GUEST_TEST_MEM, it is problem
>> of LoongArch binutils, this issue is raised to LoongArch binutils owners.
>>
>> Changes in v5:
>> 1. In LoongArch kvm self tests, the DEFAULT_GUEST_TEST_MEM could be
>> 0x130000000, it is different from the default value in memstress.h.
>> So we Move the definition of DEFAULT_GUEST_TEST_MEM into LoongArch
>> ucall.h, and add 'ifndef' condition for DEFAULT_GUEST_TEST_MEM
>> in memstress.h.
>>
>> Changes in v4:
>> 1. Remove the based-on flag, as the LoongArch KVM patch series
>> have been accepted by Linux kernel, so this can be applied directly
>> in kernel.
>>
>> Changes in v3:
>> 1. Improve implementation of LoongArch VM page walk.
>> 2. Add exception handler for LoongArch.
>> 3. Add dirty_log_test, dirty_log_perf_test, guest_print_test
>> test cases for LoongArch.
>> 4. Add __ASSEMBLER__ macro to distinguish asm file and c file.
>> 5. Move ucall_arch_do_ucall to the header file and make it as
>> static inline to avoid function calls.
>> 6. Change the DEFAULT_GUEST_TEST_MEM base addr for LoongArch.
>>
>> Changes in v2:
>> 1. We should use ".balign 4096" to align the assemble code with 4K in
>> exception.S instead of "align 12".
>> 2. LoongArch only supports 3 or 4 levels page tables, so we remove the
>> hanlders for 2-levels page table.
>> 3. Remove the DEFAULT_LOONGARCH_GUEST_STACK_VADDR_MIN and use the common
>> DEFAULT_GUEST_STACK_VADDR_MIN to allocate stack memory in guest.
>> 4. Reorganize the test cases supported by LoongArch.
>> 5. Fix some code comments.
>> 6. Add kvm_binary_stats_test test case into LoongArch KVM selftests.
>> ---
>> Bibo Mao (5):
>>    KVM: selftests: Add VM_MODE_P47V47_16K VM mode
>>    KVM: selftests: Add KVM selftests header files for LoongArch
>>    KVM: selftests: Add core KVM selftests support for LoongArch
>>    KVM: selftests: Add ucall test support for LoongArch
>>    KVM: selftests: Add test cases for LoongArch
>>
>>   MAINTAINERS                                   |   2 +
>>   tools/testing/selftests/kvm/Makefile          |   2 +-
>>   tools/testing/selftests/kvm/Makefile.kvm      |  18 +
>>   .../testing/selftests/kvm/include/kvm_util.h  |   6 +
>>   .../kvm/include/loongarch/kvm_util_arch.h     |   7 +
>>   .../kvm/include/loongarch/processor.h         | 141 ++++++++
>>   .../selftests/kvm/include/loongarch/ucall.h   |  20 +
>>   tools/testing/selftests/kvm/lib/kvm_util.c    |   3 +
>>   .../selftests/kvm/lib/loongarch/exception.S   |  59 +++
>>   .../selftests/kvm/lib/loongarch/processor.c   | 342 ++++++++++++++++++
>>   .../selftests/kvm/lib/loongarch/ucall.c       |  38 ++
>>   .../selftests/kvm/set_memory_region_test.c    |   2 +-
>>   12 files changed, 638 insertions(+), 2 deletions(-)
>>   create mode 100644 tools/testing/selftests/kvm/include/loongarch/kvm_util_arch.h
>>   create mode 100644 tools/testing/selftests/kvm/include/loongarch/processor.h
>>   create mode 100644 tools/testing/selftests/kvm/include/loongarch/ucall.h
>>   create mode 100644 tools/testing/selftests/kvm/lib/loongarch/exception.S
>>   create mode 100644 tools/testing/selftests/kvm/lib/loongarch/processor.c
>>   create mode 100644 tools/testing/selftests/kvm/lib/loongarch/ucall.c
>>
>>
>> base-commit: 5bc1018675ec28a8a60d83b378d8c3991faa5a27
>> --
>> 2.39.3
>>


