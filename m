Return-Path: <linux-kselftest+bounces-596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3837F7C75
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 19:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8F51C2112D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD5B3A8C9;
	Fri, 24 Nov 2023 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zoo640W5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754731BF1
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 10:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700849689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jayixR5r6VyMF6ruxCXdvNk+pP1D8SwAjs84TIg2nWE=;
	b=Zoo640W5UvRuC98eSvXgzbJD22EL68xQVbCnnUhUN6rKGIWJTGu31LqdeozAtgjilfOs2L
	bo6iS+WaCtcc5SmtqEyqayiyKsokQbhqUDPXcUD1s51uElwuhACtTVu9aetsXEse0p0xxF
	/RhxLi0wR65IR8tLYUITL8Rj8yK3U/U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-uOs4IviWPcyFHUbbcXa8aA-1; Fri, 24 Nov 2023 13:14:48 -0500
X-MC-Unique: uOs4IviWPcyFHUbbcXa8aA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67a046606ccso17839186d6.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 10:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700849688; x=1701454488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jayixR5r6VyMF6ruxCXdvNk+pP1D8SwAjs84TIg2nWE=;
        b=a2HAUFFt2SDEWWwP0v3qJ5YHSAHRjRw+ogiJxqt3xZwHbZyTw+oxbkaHQeU+flWrIR
         uYXUHvuuYG24M+ZKy49L/FGEdkW/K9+7v4AHDu/jbXPS5+ViWF2f5huMC+6nGxquWvCA
         vh9INNfkEpEPcCAGYE8xmodZ7/2auG/qNyfnjq4yQOA2bGlvfSxAelSLzTUFIM9IY2km
         xF+iCMrOosO3KDdVgZibNz8rsjIKYdAzJBPpEj5vPqfh2C+nSm5UJ8VNqL2ysw00uoAZ
         rvFNggeex3q+rtMUGVSnoCW9tOlj838Vefne9M4SosFRRE4DM6Rk5yjEaPlfXHcypW/8
         Ozng==
X-Gm-Message-State: AOJu0Yyd9sbnHALS8e1GgOtHAmGnQSY4si30VKQLGrbznHx6soRXAomH
	tjXsKSQ+PvImH28bSIEkFprGk+tYjIuJy84ve71g2NaHqC3fn49R6CyEw0F7hv0PlGswpXSi5B4
	u5A97LQC6vi6yuetSeyO1Cg3Sh7XI
X-Received: by 2002:ad4:42a1:0:b0:679:e459:66 with SMTP id e1-20020ad442a1000000b00679e4590066mr3792214qvr.55.1700849687798;
        Fri, 24 Nov 2023 10:14:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9wpyuHWoHfdTHuBWyEG1G0mr4qBCQ3ozLCnEUmhsRho272BBXa5JXGDKRO/WBwS4a5ruh0g==
X-Received: by 2002:ad4:42a1:0:b0:679:e459:66 with SMTP id e1-20020ad442a1000000b00679e4590066mr3792179qvr.55.1700849687550;
        Fri, 24 Nov 2023 10:14:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id jy19-20020a0562142b5300b0067a165ccc72sm674469qvb.22.2023.11.24.10.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 10:14:46 -0800 (PST)
Message-ID: <7b809e6b-aee8-4600-9f0c-07c10fa5d12b@redhat.com>
Date: Fri, 24 Nov 2023 19:14:42 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] KVM: selftests: aarch64: Move the pmu helper
 function into lib/
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, Oliver Upton
 <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.linux.dev
Cc: James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231123063750.2176250-1-shahuang@redhat.com>
 <20231123063750.2176250-3-shahuang@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20231123063750.2176250-3-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaoqin,

On 11/23/23 07:37, Shaoqin Huang wrote:
> Move those pmu helper function into lib/, thus it can be used by other
functions

Not really into lib but rather in vpmu.h header.
> pmu test.

no functional change intended
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  .../kvm/aarch64/vpmu_counter_access.c         | 118 -----------------
>  .../selftests/kvm/include/aarch64/vpmu.h      | 119 ++++++++++++++++++
>  2 files changed, 119 insertions(+), 118 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> index 17305408a334..62d6315790ab 100644
> --- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> +++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> @@ -20,12 +20,6 @@
>  #include <perf/arm_pmuv3.h>
>  #include <linux/bitfield.h>
>  
> -/* The max number of the PMU event counters (excluding the cycle counter) */
> -#define ARMV8_PMU_MAX_GENERAL_COUNTERS	(ARMV8_PMU_MAX_COUNTERS - 1)
> -
> -/* The cycle counter bit position that's common among the PMU registers */
> -#define ARMV8_PMU_CYCLE_IDX		31
> -
>  static struct vpmu_vm *vpmu_vm;
>  
>  struct pmreg_sets {
> @@ -35,118 +29,6 @@ struct pmreg_sets {
>  
>  #define PMREG_SET(set, clr) {.set_reg_id = set, .clr_reg_id = clr}
>  
> -static uint64_t get_pmcr_n(uint64_t pmcr)
> -{
> -	return (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
> -}
> -
> -static void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
> -{
> -	*pmcr = *pmcr & ~(ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
> -	*pmcr |= (pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
> -}
> -
> -static uint64_t get_counters_mask(uint64_t n)
> -{
> -	uint64_t mask = BIT(ARMV8_PMU_CYCLE_IDX);
> -
> -	if (n)
> -		mask |= GENMASK(n - 1, 0);
> -	return mask;
> -}
> -
> -/* Read PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
> -static inline unsigned long read_sel_evcntr(int sel)
> -{
> -	write_sysreg(sel, pmselr_el0);
> -	isb();
> -	return read_sysreg(pmxevcntr_el0);
> -}
> -
> -/* Write PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
> -static inline void write_sel_evcntr(int sel, unsigned long val)
> -{
> -	write_sysreg(sel, pmselr_el0);
> -	isb();
> -	write_sysreg(val, pmxevcntr_el0);
> -	isb();
> -}
> -
> -/* Read PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
> -static inline unsigned long read_sel_evtyper(int sel)
> -{
> -	write_sysreg(sel, pmselr_el0);
> -	isb();
> -	return read_sysreg(pmxevtyper_el0);
> -}
> -
> -/* Write PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
> -static inline void write_sel_evtyper(int sel, unsigned long val)
> -{
> -	write_sysreg(sel, pmselr_el0);
> -	isb();
> -	write_sysreg(val, pmxevtyper_el0);
> -	isb();
> -}
> -
> -static inline void enable_counter(int idx)
> -{
> -	uint64_t v = read_sysreg(pmcntenset_el0);
> -
> -	write_sysreg(BIT(idx) | v, pmcntenset_el0);
> -	isb();
> -}
> -
> -static inline void disable_counter(int idx)
> -{
> -	uint64_t v = read_sysreg(pmcntenset_el0);
> -
> -	write_sysreg(BIT(idx) | v, pmcntenclr_el0);
> -	isb();
> -}
> -
> -static void pmu_disable_reset(void)
> -{
> -	uint64_t pmcr = read_sysreg(pmcr_el0);
> -
> -	/* Reset all counters, disabling them */
> -	pmcr &= ~ARMV8_PMU_PMCR_E;
> -	write_sysreg(pmcr | ARMV8_PMU_PMCR_P, pmcr_el0);
> -	isb();
> -}
> -
> -#define RETURN_READ_PMEVCNTRN(n) \
> -	return read_sysreg(pmevcntr##n##_el0)
> -static unsigned long read_pmevcntrn(int n)
> -{
> -	PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
> -	return 0;
> -}
> -
> -#define WRITE_PMEVCNTRN(n) \
> -	write_sysreg(val, pmevcntr##n##_el0)
> -static void write_pmevcntrn(int n, unsigned long val)
> -{
> -	PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
> -	isb();
> -}
> -
> -#define READ_PMEVTYPERN(n) \
> -	return read_sysreg(pmevtyper##n##_el0)
> -static unsigned long read_pmevtypern(int n)
> -{
> -	PMEVN_SWITCH(n, READ_PMEVTYPERN);
> -	return 0;
> -}
> -
> -#define WRITE_PMEVTYPERN(n) \
> -	write_sysreg(val, pmevtyper##n##_el0)
> -static void write_pmevtypern(int n, unsigned long val)
> -{
> -	PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
> -	isb();
> -}
> -
>  /*
>   * The pmc_accessor structure has pointers to PMEV{CNTR,TYPER}<n>_EL0
>   * accessors that test cases will use. Each of the accessors will
> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> index 0a56183644ee..e0cc1ca1c4b7 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> @@ -1,10 +1,17 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  
>  #include <kvm_util.h>
> +#include <perf/arm_pmuv3.h>
>  
>  #define GICD_BASE_GPA	0x8000000ULL
>  #define GICR_BASE_GPA	0x80A0000ULL
>  
> +/* The max number of the PMU event counters (excluding the cycle counter) */
> +#define ARMV8_PMU_MAX_GENERAL_COUNTERS	(ARMV8_PMU_MAX_COUNTERS - 1)
> +
> +/* The cycle counter bit position that's common among the PMU registers */
> +#define ARMV8_PMU_CYCLE_IDX		31
> +
>  struct vpmu_vm {
>  	struct kvm_vm *vm;
>  	struct kvm_vcpu *vcpu;
> @@ -14,3 +21,115 @@ struct vpmu_vm {
>  struct vpmu_vm *create_vpmu_vm(void *guest_code);
>  
>  void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm);
> +
> +static inline uint64_t get_pmcr_n(uint64_t pmcr)
> +{
> +	return (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
> +}
> +
> +static inline void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
> +{
> +	*pmcr = *pmcr & ~(ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
> +	*pmcr |= (pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
> +}
> +
> +static inline uint64_t get_counters_mask(uint64_t n)
> +{
> +	uint64_t mask = BIT(ARMV8_PMU_CYCLE_IDX);
> +
> +	if (n)
> +		mask |= GENMASK(n - 1, 0);
> +	return mask;
> +}
> +
> +/* Read PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
> +static inline unsigned long read_sel_evcntr(int sel)
> +{
> +	write_sysreg(sel, pmselr_el0);
> +	isb();
> +	return read_sysreg(pmxevcntr_el0);
> +}
> +
> +/* Write PMEVTCNTR<n>_EL0 through PMXEVCNTR_EL0 */
> +static inline void write_sel_evcntr(int sel, unsigned long val)
> +{
> +	write_sysreg(sel, pmselr_el0);
> +	isb();
> +	write_sysreg(val, pmxevcntr_el0);
> +	isb();
> +}
> +
> +/* Read PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
> +static inline unsigned long read_sel_evtyper(int sel)
> +{
> +	write_sysreg(sel, pmselr_el0);
> +	isb();
> +	return read_sysreg(pmxevtyper_el0);
> +}
> +
> +/* Write PMEVTYPER<n>_EL0 through PMXEVTYPER_EL0 */
> +static inline void write_sel_evtyper(int sel, unsigned long val)
> +{
> +	write_sysreg(sel, pmselr_el0);
> +	isb();
> +	write_sysreg(val, pmxevtyper_el0);
> +	isb();
> +}
> +
> +static inline void enable_counter(int idx)
> +{
> +	uint64_t v = read_sysreg(pmcntenset_el0);
> +
> +	write_sysreg(BIT(idx) | v, pmcntenset_el0);
> +	isb();
> +}
> +
> +static inline void disable_counter(int idx)
> +{
> +	uint64_t v = read_sysreg(pmcntenset_el0);
> +
> +	write_sysreg(BIT(idx) | v, pmcntenclr_el0);
> +	isb();
> +}
> +
> +static inline void pmu_disable_reset(void)
> +{
> +	uint64_t pmcr = read_sysreg(pmcr_el0);
> +
> +	/* Reset all counters, disabling them */
> +	pmcr &= ~ARMV8_PMU_PMCR_E;
> +	write_sysreg(pmcr | ARMV8_PMU_PMCR_P, pmcr_el0);
> +	isb();
> +}
> +
> +#define RETURN_READ_PMEVCNTRN(n) \
> +	return read_sysreg(pmevcntr##n##_el0)
> +static inline unsigned long read_pmevcntrn(int n)
> +{
> +	PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
> +	return 0;
> +}
> +
> +#define WRITE_PMEVCNTRN(n) \
> +	write_sysreg(val, pmevcntr##n##_el0)
> +static inline void write_pmevcntrn(int n, unsigned long val)
> +{
> +	PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
> +	isb();
> +}
> +
> +#define READ_PMEVTYPERN(n) \
> +	return read_sysreg(pmevtyper##n##_el0)
> +static inline unsigned long read_pmevtypern(int n)
> +{
> +	PMEVN_SWITCH(n, READ_PMEVTYPERN);
> +	return 0;
> +}
> +
> +#define WRITE_PMEVTYPERN(n) \
> +	write_sysreg(val, pmevtyper##n##_el0)
> +static inline void write_pmevtypern(int n, unsigned long val)
> +{
> +	PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
> +	isb();
> +}

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


