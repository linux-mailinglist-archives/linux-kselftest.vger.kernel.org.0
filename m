Return-Path: <linux-kselftest+bounces-794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F80D7FCDA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 04:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29DE1C20D83
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 03:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7582E6131;
	Wed, 29 Nov 2023 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fnm5aptX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE70182
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 19:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701229920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RL0c3l03fnSRdfvhrTd6aq49DEaPt0ziC4ZLt8/nvFs=;
	b=Fnm5aptXowmPoxSnw+WzwVZnbf7mShdjHp/pjw3bBcltK0RnKw3HxgtSSJqLeSSb8dIPYp
	DF0YLY0dBzKKWCWjd/kg85OLjVfpe1+MmqrBjObEKgrvXdSMJxj0g6A47aUjBSn21igjf1
	sH3vYzJn7leoA6idql2rVcKjaf00qX0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-MufAXJtKMiGZsVAJEjxupQ-1; Tue, 28 Nov 2023 22:51:59 -0500
X-MC-Unique: MufAXJtKMiGZsVAJEjxupQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6cbbca2d077so1033129b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 19:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701229918; x=1701834718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RL0c3l03fnSRdfvhrTd6aq49DEaPt0ziC4ZLt8/nvFs=;
        b=nNXfsBzzeWeCp4X9VPTrumFcJALIFEnshE7qlsHbAWbnqUWKnz20t1S67kg38a9nA7
         TpPZNEQcIQ+swICRbj3iJfRGjo/nzO3K9MCm1IaMB1Z0PgyXjka1pdTYMu+zHPD2giKw
         R4kRyTpeUmjpPVZmjMVhhrhZrc9J7+V8sPaP56rYr/8wwODjJ/AvlnK12Nr9sPADn9cb
         xUkqksXRdlZz1Bm7IkP+ju3LJzsQRKpvI3JRXks2n5RY1pP0DH7zq/z8pOFNzc+SxX89
         H+RFIudlN+L2Nd3Zm4eOhnjzlbQdDz0KlUFd0PsfrWUJsTaGbdbmppmFSYLdCBgnm0IG
         s7ow==
X-Gm-Message-State: AOJu0YwhtVRAEvGhXXvnEK0DOOgpGwHY42KWnnlSqCW2rKlsyxpsWB0T
	j/CDHjQ8YzvToKqs4zYrr8kzwNlSL35IutO21eHah6kDYDIIdXSgpMfNDHaJxObPJ8z2cx3KTVw
	ngeOn8+IcOemIUIEOnEVZMDrmsMOq
X-Received: by 2002:a05:6a21:a598:b0:18b:d26a:375c with SMTP id gd24-20020a056a21a59800b0018bd26a375cmr24224152pzc.1.1701229918441;
        Tue, 28 Nov 2023 19:51:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEuDrFqfI++q1HzePhrNvjhTKWNoYA3fmnYwqAztsr4+77Q0lO8uC6ksPK8HeU2Qvw5KciOw==
X-Received: by 2002:a05:6a21:a598:b0:18b:d26a:375c with SMTP id gd24-20020a056a21a59800b0018bd26a375cmr24224130pzc.1.1701229918105;
        Tue, 28 Nov 2023 19:51:58 -0800 (PST)
Received: from [10.72.112.34] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090aca8a00b002851c9f7a77sm256560pjt.38.2023.11.28.19.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 19:51:57 -0800 (PST)
Message-ID: <621ea04b-ae10-c2a5-8711-dcb8c6d2b322@redhat.com>
Date: Wed, 29 Nov 2023 11:51:53 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/3] KVM: selftests: aarch64: Move the pmu helper
 function into lib/
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231123063750.2176250-1-shahuang@redhat.com>
 <20231123063750.2176250-3-shahuang@redhat.com>
 <CAJHc60wsEjjLmAVUrb3n9Tyftqi7UXWh7V1hE1E90bUXiUk+Tw@mail.gmail.com>
 <ae81aa3f6527b663ef73b64a3fb72e5b@kernel.org>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ae81aa3f6527b663ef73b64a3fb72e5b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marc,

On 11/28/23 16:43, Marc Zyngier wrote:
> On 2023-11-27 21:48, Raghavendra Rao Ananta wrote:
>> Hi Shaoqin,
>>
>> On Wed, Nov 22, 2023 at 10:39 PM Shaoqin Huang <shahuang@redhat.com> 
>> wrote:
>>>
>>> Move those pmu helper function into lib/, thus it can be used by other
>>> pmu test.
>>>
>>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>>> ---
>>>  .../kvm/aarch64/vpmu_counter_access.c         | 118 -----------------
>>>  .../selftests/kvm/include/aarch64/vpmu.h      | 119 ++++++++++++++++++
>>>  2 files changed, 119 insertions(+), 118 deletions(-)
>>>
>>> diff --git 
>>> a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c 
>>> b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
>>> index 17305408a334..62d6315790ab 100644
>>> --- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
>>> +++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
>>> @@ -20,12 +20,6 @@
>>>  #include <perf/arm_pmuv3.h>
>>>  #include <linux/bitfield.h>
>>>
>>> -/* The max number of the PMU event counters (excluding the cycle 
>>> counter) */
>>> -#define ARMV8_PMU_MAX_GENERAL_COUNTERS (ARMV8_PMU_MAX_COUNTERS - 1)
>>> -
>>> -/* The cycle counter bit position that's common among the PMU 
>>> registers */
>>> -#define ARMV8_PMU_CYCLE_IDX            31
>>> -
>>>  static struct vpmu_vm *vpmu_vm;
>>>
>>>  struct pmreg_sets {
>>> @@ -35,118 +29,6 @@ struct pmreg_sets {
>>>
>>>  #define PMREG_SET(set, clr) {.set_reg_id = set, .clr_reg_id = clr}
>>>
>>> -static uint64_t get_pmcr_n(uint64_t pmcr)
>>> -{
>>> -       return (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
>>> -}
>>> -
>>> -static void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
>>> -{
>>> -       *pmcr = *pmcr & ~(ARMV8_PMU_PMCR_N_MASK << 
>>> ARMV8_PMU_PMCR_N_SHIFT);
>>> -       *pmcr |= (pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
>>> -}
>>> -
>>> -static uint64_t get_counters_mask(uint64_t n)
>>> -{
>>> -       uint64_t mask = BIT(ARMV8_PMU_CYCLE_IDX);
>>> -
>>> -       if (n)
>>> -               mask |= GENMASK(n - 1, 0);
>>> -       return mask;
>>> -}
>>> -
>>> -/* Read PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
>>> -static inline unsigned long read_sel_evcntr(int sel)
>>> -{
>>> -       write_sysreg(sel, pmselr_el0);
>>> -       isb();
>>> -       return read_sysreg(pmxevcntr_el0);
>>> -}
>>> -
>>> -/* Write PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
>>> -static inline void write_sel_evcntr(int sel, unsigned long val)
>>> -{
>>> -       write_sysreg(sel, pmselr_el0);
>>> -       isb();
>>> -       write_sysreg(val, pmxevcntr_el0);
>>> -       isb();
>>> -}
>>> -
>>> -/* Read PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
>>> -static inline unsigned long read_sel_evtyper(int sel)
>>> -{
>>> -       write_sysreg(sel, pmselr_el0);
>>> -       isb();
>>> -       return read_sysreg(pmxevtyper_el0);
>>> -}
>>> -
>>> -/* Write PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
>>> -static inline void write_sel_evtyper(int sel, unsigned long val)
>>> -{
>>> -       write_sysreg(sel, pmselr_el0);
>>> -       isb();
>>> -       write_sysreg(val, pmxevtyper_el0);
>>> -       isb();
>>> -}
>>> -
>>> -static inline void enable_counter(int idx)
>>> -{
>>> -       uint64_t v = read_sysreg(pmcntenset_el0);
>>> -
>>> -       write_sysreg(BIT(idx) | v, pmcntenset_el0);
>>> -       isb();
>>> -}
>>> -
>>> -static inline void disable_counter(int idx)
>>> -{
>>> -       uint64_t v = read_sysreg(pmcntenset_el0);
>>> -
>>> -       write_sysreg(BIT(idx) | v, pmcntenclr_el0);
>>> -       isb();
>>> -}
>>> -
>>> -static void pmu_disable_reset(void)
>>> -{
>>> -       uint64_t pmcr = read_sysreg(pmcr_el0);
>>> -
>>> -       /* Reset all counters, disabling them */
>>> -       pmcr &= ~ARMV8_PMU_PMCR_E;
>>> -       write_sysreg(pmcr | ARMV8_PMU_PMCR_P, pmcr_el0);
>>> -       isb();
>>> -}
>>> -
>>> -#define RETURN_READ_PMEVCNTRN(n) \
>>> -       return read_sysreg(pmevcntr##n##_el0)
>>> -static unsigned long read_pmevcntrn(int n)
>>> -{
>>> -       PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
>>> -       return 0;
>>> -}
>>> -
>>> -#define WRITE_PMEVCNTRN(n) \
>>> -       write_sysreg(val, pmevcntr##n##_el0)
>>> -static void write_pmevcntrn(int n, unsigned long val)
>>> -{
>>> -       PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
>>> -       isb();
>>> -}
>>> -
>>> -#define READ_PMEVTYPERN(n) \
>>> -       return read_sysreg(pmevtyper##n##_el0)
>>> -static unsigned long read_pmevtypern(int n)
>>> -{
>>> -       PMEVN_SWITCH(n, READ_PMEVTYPERN);
>>> -       return 0;
>>> -}
>>> -
>>> -#define WRITE_PMEVTYPERN(n) \
>>> -       write_sysreg(val, pmevtyper##n##_el0)
>>> -static void write_pmevtypern(int n, unsigned long val)
>>> -{
>>> -       PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
>>> -       isb();
>>> -}
>>> -
>>>  /*
>>>   * The pmc_accessor structure has pointers to PMEV{CNTR,TYPER}<n>_EL0
>>>   * accessors that test cases will use. Each of the accessors will
>>> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h 
>>> b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>>> index 0a56183644ee..e0cc1ca1c4b7 100644
>>> --- a/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>>> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>>> @@ -1,10 +1,17 @@
>>>  /* SPDX-License-Identifier: GPL-2.0 */
>>>
>>>  #include <kvm_util.h>
>>> +#include <perf/arm_pmuv3.h>
>>>
>>>  #define GICD_BASE_GPA  0x8000000ULL
>>>  #define GICR_BASE_GPA  0x80A0000ULL
>>>
>>> +/* The max number of the PMU event counters (excluding the cycle 
>>> counter) */
>>> +#define ARMV8_PMU_MAX_GENERAL_COUNTERS (ARMV8_PMU_MAX_COUNTERS - 1)
>>> +
>>> +/* The cycle counter bit position that's common among the PMU 
>>> registers */
>>> +#define ARMV8_PMU_CYCLE_IDX            31
>>> +
>>>  struct vpmu_vm {
>>>         struct kvm_vm *vm;
>>>         struct kvm_vcpu *vcpu;
>>> @@ -14,3 +21,115 @@ struct vpmu_vm {
>>>  struct vpmu_vm *create_vpmu_vm(void *guest_code);
>>>
>>>  void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm);
>>> +
>>> +static inline uint64_t get_pmcr_n(uint64_t pmcr)
>>> +{
>>> +       return (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
>>> +}
>>> +
>>> +static inline void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
>>> +{
>>> +       *pmcr = *pmcr & ~(ARMV8_PMU_PMCR_N_MASK << 
>>> ARMV8_PMU_PMCR_N_SHIFT);
>>> +       *pmcr |= (pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
>>> +}
>>> +
>>> +static inline uint64_t get_counters_mask(uint64_t n)
>>> +{
>>> +       uint64_t mask = BIT(ARMV8_PMU_CYCLE_IDX);
>>> +
>>> +       if (n)
>>> +               mask |= GENMASK(n - 1, 0);
>>> +       return mask;
>>> +}
>>> +
>>> +/* Read PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
>>> +static inline unsigned long read_sel_evcntr(int sel)
>>> +{
>>> +       write_sysreg(sel, pmselr_el0);
>>> +       isb();
>>> +       return read_sysreg(pmxevcntr_el0);
>>> +}
>>> +
>>> +/* Write PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
>>> +static inline void write_sel_evcntr(int sel, unsigned long val)
>>> +{
>>> +       write_sysreg(sel, pmselr_el0);
>>> +       isb();
>>> +       write_sysreg(val, pmxevcntr_el0);
>>> +       isb();
>>> +}
>>> +
>>> +/* Read PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
>>> +static inline unsigned long read_sel_evtyper(int sel)
>>> +{
>>> +       write_sysreg(sel, pmselr_el0);
>>> +       isb();
>>> +       return read_sysreg(pmxevtyper_el0);
>>> +}
>>> +
>>> +/* Write PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
>>> +static inline void write_sel_evtyper(int sel, unsigned long val)
>>> +{
>>> +       write_sysreg(sel, pmselr_el0);
>>> +       isb();
>>> +       write_sysreg(val, pmxevtyper_el0);
>>> +       isb();
>>> +}
>>> +
>>> +static inline void enable_counter(int idx)
>>> +{
>>> +       uint64_t v = read_sysreg(pmcntenset_el0);
>>> +
>>> +       write_sysreg(BIT(idx) | v, pmcntenset_el0);
>>> +       isb();
>>> +}
>>> +
>>> +static inline void disable_counter(int idx)
>>> +{
>>> +       uint64_t v = read_sysreg(pmcntenset_el0);
>>> +
>>> +       write_sysreg(BIT(idx) | v, pmcntenclr_el0);
>>> +       isb();
>>> +}
>>> +
>> As mentioned in [1], the current implementation of disable_counter()
>> is buggy and would end up disabling all the counters.
>> However if you intend to keep it (even though it would remain unused),
>> may be change the definition something to:
>>
>> static inline void disable_counter(int idx)
>> {
>>     write_sysreg(BIT(idx), pmcntenclr_el0);
>>     isb();
>> }
> 
> Same thing for the enable_counter() function, by the way.
> It doesn't have the same disastrous effect, but it is
> buggy (imagine an interrupt disabling a counter between
> the read and the write...).
> 
> In general, the set/clr registers should always be used
> in their write form, never in a RMW form.
> 

Thanks for your explaination. I will fix the enable_counter together 
with the disable_counter.

Thanks,
Shaoqin

> Thanks,
> 
>          M.


