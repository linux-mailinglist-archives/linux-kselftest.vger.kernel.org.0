Return-Path: <linux-kselftest+bounces-700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183567FB481
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 09:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7D81C20FF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 08:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFA618643;
	Tue, 28 Nov 2023 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFoaMaiD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E5156C2;
	Tue, 28 Nov 2023 08:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFE6C433C8;
	Tue, 28 Nov 2023 08:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701161001;
	bh=9Are99utxUpb51rSuMw8hi7bQqLnSrPy5eLlELhxogY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CFoaMaiDP3S4q1sWspDPyl/BDxvasrWH8wTZVNqFRdOjgYbfmvGeQNqS93I5MgHe1
	 eByXUfqtI03yTIyNdSsveFZ8e/YqOKAAIbuxsdlyr2+N/80e9RidR66SaoaPF9uH5b
	 u/kFTM0zIvyyl2hTacqQwAUXscaRj0kr1gWC4umNdgOOmTJXIJfjCjUGBbT5Rr7q+n
	 zP50EOBPiFjOfifwtPz8OlpSMZP4qHtCz19W61fyv1/bcD6rUguROgtf6L9uKJTPWk
	 piwwOSFmef2LnOXN/LDK4ZCPAt6GJZ1c4+sT/MdSclr5AKfgGtb+I+enmOKKgRb8le
	 TQCKjDwW4Mbnw==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1r7tgc-00H3Kk-8d;
	Tue, 28 Nov 2023 08:43:18 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 28 Nov 2023 08:43:18 +0000
From: Marc Zyngier <maz@kernel.org>
To: Shaoqin Huang <shahuang@redhat.com>, Raghavendra Rao Ananta
 <rananta@google.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, James
 Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] KVM: selftests: aarch64: Move the pmu helper
 function into lib/
In-Reply-To: <CAJHc60wsEjjLmAVUrb3n9Tyftqi7UXWh7V1hE1E90bUXiUk+Tw@mail.gmail.com>
References: <20231123063750.2176250-1-shahuang@redhat.com>
 <20231123063750.2176250-3-shahuang@redhat.com>
 <CAJHc60wsEjjLmAVUrb3n9Tyftqi7UXWh7V1hE1E90bUXiUk+Tw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <ae81aa3f6527b663ef73b64a3fb72e5b@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: shahuang@redhat.com, rananta@google.com, oliver.upton@linux.dev, kvmarm@lists.linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2023-11-27 21:48, Raghavendra Rao Ananta wrote:
> Hi Shaoqin,
> 
> On Wed, Nov 22, 2023 at 10:39 PM Shaoqin Huang <shahuang@redhat.com> 
> wrote:
>> 
>> Move those pmu helper function into lib/, thus it can be used by other
>> pmu test.
>> 
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
>>  .../kvm/aarch64/vpmu_counter_access.c         | 118 -----------------
>>  .../selftests/kvm/include/aarch64/vpmu.h      | 119 
>> ++++++++++++++++++
>>  2 files changed, 119 insertions(+), 118 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c 
>> b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
>> index 17305408a334..62d6315790ab 100644
>> --- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
>> +++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
>> @@ -20,12 +20,6 @@
>>  #include <perf/arm_pmuv3.h>
>>  #include <linux/bitfield.h>
>> 
>> -/* The max number of the PMU event counters (excluding the cycle 
>> counter) */
>> -#define ARMV8_PMU_MAX_GENERAL_COUNTERS (ARMV8_PMU_MAX_COUNTERS - 1)
>> -
>> -/* The cycle counter bit position that's common among the PMU 
>> registers */
>> -#define ARMV8_PMU_CYCLE_IDX            31
>> -
>>  static struct vpmu_vm *vpmu_vm;
>> 
>>  struct pmreg_sets {
>> @@ -35,118 +29,6 @@ struct pmreg_sets {
>> 
>>  #define PMREG_SET(set, clr) {.set_reg_id = set, .clr_reg_id = clr}
>> 
>> -static uint64_t get_pmcr_n(uint64_t pmcr)
>> -{
>> -       return (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & 
>> ARMV8_PMU_PMCR_N_MASK;
>> -}
>> -
>> -static void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
>> -{
>> -       *pmcr = *pmcr & ~(ARMV8_PMU_PMCR_N_MASK << 
>> ARMV8_PMU_PMCR_N_SHIFT);
>> -       *pmcr |= (pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
>> -}
>> -
>> -static uint64_t get_counters_mask(uint64_t n)
>> -{
>> -       uint64_t mask = BIT(ARMV8_PMU_CYCLE_IDX);
>> -
>> -       if (n)
>> -               mask |= GENMASK(n - 1, 0);
>> -       return mask;
>> -}
>> -
>> -/* Read PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
>> -static inline unsigned long read_sel_evcntr(int sel)
>> -{
>> -       write_sysreg(sel, pmselr_el0);
>> -       isb();
>> -       return read_sysreg(pmxevcntr_el0);
>> -}
>> -
>> -/* Write PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
>> -static inline void write_sel_evcntr(int sel, unsigned long val)
>> -{
>> -       write_sysreg(sel, pmselr_el0);
>> -       isb();
>> -       write_sysreg(val, pmxevcntr_el0);
>> -       isb();
>> -}
>> -
>> -/* Read PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
>> -static inline unsigned long read_sel_evtyper(int sel)
>> -{
>> -       write_sysreg(sel, pmselr_el0);
>> -       isb();
>> -       return read_sysreg(pmxevtyper_el0);
>> -}
>> -
>> -/* Write PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
>> -static inline void write_sel_evtyper(int sel, unsigned long val)
>> -{
>> -       write_sysreg(sel, pmselr_el0);
>> -       isb();
>> -       write_sysreg(val, pmxevtyper_el0);
>> -       isb();
>> -}
>> -
>> -static inline void enable_counter(int idx)
>> -{
>> -       uint64_t v = read_sysreg(pmcntenset_el0);
>> -
>> -       write_sysreg(BIT(idx) | v, pmcntenset_el0);
>> -       isb();
>> -}
>> -
>> -static inline void disable_counter(int idx)
>> -{
>> -       uint64_t v = read_sysreg(pmcntenset_el0);
>> -
>> -       write_sysreg(BIT(idx) | v, pmcntenclr_el0);
>> -       isb();
>> -}
>> -
>> -static void pmu_disable_reset(void)
>> -{
>> -       uint64_t pmcr = read_sysreg(pmcr_el0);
>> -
>> -       /* Reset all counters, disabling them */
>> -       pmcr &= ~ARMV8_PMU_PMCR_E;
>> -       write_sysreg(pmcr | ARMV8_PMU_PMCR_P, pmcr_el0);
>> -       isb();
>> -}
>> -
>> -#define RETURN_READ_PMEVCNTRN(n) \
>> -       return read_sysreg(pmevcntr##n##_el0)
>> -static unsigned long read_pmevcntrn(int n)
>> -{
>> -       PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
>> -       return 0;
>> -}
>> -
>> -#define WRITE_PMEVCNTRN(n) \
>> -       write_sysreg(val, pmevcntr##n##_el0)
>> -static void write_pmevcntrn(int n, unsigned long val)
>> -{
>> -       PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
>> -       isb();
>> -}
>> -
>> -#define READ_PMEVTYPERN(n) \
>> -       return read_sysreg(pmevtyper##n##_el0)
>> -static unsigned long read_pmevtypern(int n)
>> -{
>> -       PMEVN_SWITCH(n, READ_PMEVTYPERN);
>> -       return 0;
>> -}
>> -
>> -#define WRITE_PMEVTYPERN(n) \
>> -       write_sysreg(val, pmevtyper##n##_el0)
>> -static void write_pmevtypern(int n, unsigned long val)
>> -{
>> -       PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
>> -       isb();
>> -}
>> -
>>  /*
>>   * The pmc_accessor structure has pointers to PMEV{CNTR,TYPER}<n>_EL0
>>   * accessors that test cases will use. Each of the accessors will
>> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h 
>> b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>> index 0a56183644ee..e0cc1ca1c4b7 100644
>> --- a/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
>> @@ -1,10 +1,17 @@
>>  /* SPDX-License-Identifier: GPL-2.0 */
>> 
>>  #include <kvm_util.h>
>> +#include <perf/arm_pmuv3.h>
>> 
>>  #define GICD_BASE_GPA  0x8000000ULL
>>  #define GICR_BASE_GPA  0x80A0000ULL
>> 
>> +/* The max number of the PMU event counters (excluding the cycle 
>> counter) */
>> +#define ARMV8_PMU_MAX_GENERAL_COUNTERS (ARMV8_PMU_MAX_COUNTERS - 1)
>> +
>> +/* The cycle counter bit position that's common among the PMU 
>> registers */
>> +#define ARMV8_PMU_CYCLE_IDX            31
>> +
>>  struct vpmu_vm {
>>         struct kvm_vm *vm;
>>         struct kvm_vcpu *vcpu;
>> @@ -14,3 +21,115 @@ struct vpmu_vm {
>>  struct vpmu_vm *create_vpmu_vm(void *guest_code);
>> 
>>  void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm);
>> +
>> +static inline uint64_t get_pmcr_n(uint64_t pmcr)
>> +{
>> +       return (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & 
>> ARMV8_PMU_PMCR_N_MASK;
>> +}
>> +
>> +static inline void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
>> +{
>> +       *pmcr = *pmcr & ~(ARMV8_PMU_PMCR_N_MASK << 
>> ARMV8_PMU_PMCR_N_SHIFT);
>> +       *pmcr |= (pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
>> +}
>> +
>> +static inline uint64_t get_counters_mask(uint64_t n)
>> +{
>> +       uint64_t mask = BIT(ARMV8_PMU_CYCLE_IDX);
>> +
>> +       if (n)
>> +               mask |= GENMASK(n - 1, 0);
>> +       return mask;
>> +}
>> +
>> +/* Read PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
>> +static inline unsigned long read_sel_evcntr(int sel)
>> +{
>> +       write_sysreg(sel, pmselr_el0);
>> +       isb();
>> +       return read_sysreg(pmxevcntr_el0);
>> +}
>> +
>> +/* Write PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
>> +static inline void write_sel_evcntr(int sel, unsigned long val)
>> +{
>> +       write_sysreg(sel, pmselr_el0);
>> +       isb();
>> +       write_sysreg(val, pmxevcntr_el0);
>> +       isb();
>> +}
>> +
>> +/* Read PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
>> +static inline unsigned long read_sel_evtyper(int sel)
>> +{
>> +       write_sysreg(sel, pmselr_el0);
>> +       isb();
>> +       return read_sysreg(pmxevtyper_el0);
>> +}
>> +
>> +/* Write PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
>> +static inline void write_sel_evtyper(int sel, unsigned long val)
>> +{
>> +       write_sysreg(sel, pmselr_el0);
>> +       isb();
>> +       write_sysreg(val, pmxevtyper_el0);
>> +       isb();
>> +}
>> +
>> +static inline void enable_counter(int idx)
>> +{
>> +       uint64_t v = read_sysreg(pmcntenset_el0);
>> +
>> +       write_sysreg(BIT(idx) | v, pmcntenset_el0);
>> +       isb();
>> +}
>> +
>> +static inline void disable_counter(int idx)
>> +{
>> +       uint64_t v = read_sysreg(pmcntenset_el0);
>> +
>> +       write_sysreg(BIT(idx) | v, pmcntenclr_el0);
>> +       isb();
>> +}
>> +
> As mentioned in [1], the current implementation of disable_counter()
> is buggy and would end up disabling all the counters.
> However if you intend to keep it (even though it would remain unused),
> may be change the definition something to:
> 
> static inline void disable_counter(int idx)
> {
>     write_sysreg(BIT(idx), pmcntenclr_el0);
>     isb();
> }

Same thing for the enable_counter() function, by the way.
It doesn't have the same disastrous effect, but it is
buggy (imagine an interrupt disabling a counter between
the read and the write...).

In general, the set/clr registers should always be used
in their write form, never in a RMW form.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

