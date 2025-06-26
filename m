Return-Path: <linux-kselftest+bounces-35842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61FAAE97BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 10:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E42437B2EF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC23F25C833;
	Thu, 26 Jun 2025 08:11:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5D25FA31;
	Thu, 26 Jun 2025 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925508; cv=none; b=PfKejKisjqroZCMFd9pPRINqvhKV//sKArqEoJinITx8mZo88RM7WuNOUC5wCy5v7glpUVMdp9N0cFXvqgyWDeSc2MQuaWqWHMp38LmUkUJATQoBs7OG3+pOJwE/bdfIgmSRE0qqzheUV3tVqSGs/JaXT7GFTCfvDFWIgw8YTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925508; c=relaxed/simple;
	bh=THoZ3zh4lEUZ1e0gLCr+0ltpX18hKyjXK2m+bc4DZ3I=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dbkgWz0IL3arX5+rpHEx8LOHyMbYksA6WYmuurscFBfZxK6hEnsjNDXzYkNYpRCc6PTSAI6Ypplqh/JDX7abONQPe7yB8t12QNm1AmbLpLpHEzeUZb+CxQzUTPTjHIycAHIDCzTG1f1t5/7VRbtnAK2PUFMrdm8sQJX8wZWpk4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bSWZM5wmzz2TSNQ;
	Thu, 26 Jun 2025 16:10:03 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 589061A016C;
	Thu, 26 Jun 2025 16:11:42 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 16:11:42 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 16:11:41 +0800
CC: <yangyicong@hisilicon.com>, <joey.gouly@arm.com>,
	<suzuki.poulose@arm.com>, <yuzenghui@huawei.com>, <shuah@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>, <xuwei5@huawei.com>,
	<tangchengchang@huawei.com>, <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v3 4/7] KVM: arm/arm64: Allow user injection of
 unsupported exclusive/atomic DABT
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20250626080906.64230-1-yangyicong@huawei.com>
 <20250626080906.64230-5-yangyicong@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <02bf0361-1728-607c-03db-c8f9beff7763@huawei.com>
Date: Thu, 26 Jun 2025 16:11:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250626080906.64230-5-yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/6/26 16:09, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The unsupported exclusive/atomic DABT exception is hand to the
> userspace. Provide a way for the userspace to inject this DABT
> to the guest if they want to imitate how this is handled on the
> host.
> 

Tested LS64 fault in VM using kvmtool with below patch, debug information added.
The LS64 DABT injection works as expected.

# Perform LS64 on emulated MMIO
root@localhost:/mnt# lspci -tv
-[0000:00]-+-00.0  Device 1af4:1049
           \-01.0  Device 1af4:1041
root@localhost:/mnt# ./ls64.o -d 0000:00:00.0 -b 2
Start address of 0000:00:00.0 BAR2 is 0x0
mappded va is 0xffff82d20000 addr is 0x4120e8
  Info: esr_iss 93c09000 fault_ipa 50000000 // kvmtool debug information
  Info: correct mapping but emulated MMIO // kvmtool debug information
test FEAT_LS64
Bus error
# Perform LS64 on normal memory
root@localhost:/mnt# ./ls64.o -a
mappded va is 0xffffa5400000 addr is 0x4120e8
test FEAT_LS64
  Info: esr_iss 35 fault_ipa 83971000 // kvmtool debug information
  Info: Injecting DABT since incorrect Guest memory attribute // kvmtool debug information
Bus error

diff --git a/arm/aarch64/include/asm/kvm.h b/arm/aarch64/include/asm/kvm.h
index 66736ff..d3cd866 100644
--- a/arm/aarch64/include/asm/kvm.h
+++ b/arm/aarch64/include/asm/kvm.h
@@ -186,8 +186,9 @@ struct kvm_vcpu_events {
 		__u8 serror_pending;
 		__u8 serror_has_esr;
 		__u8 ext_dabt_pending;
+		__u8 ext_dabt_excl_atom_pending;
 		/* Align it to 8 bytes */
-		__u8 pad[5];
+		__u8 pad[4];
 		__u64 serror_esr;
 	} exception;
 	__u32 reserved[12];
diff --git a/include/kvm/kvm.h b/include/kvm/kvm.h
index eb23e2f..56b985d 100644
--- a/include/kvm/kvm.h
+++ b/include/kvm/kvm.h
@@ -129,6 +129,8 @@ bool kvm__emulate_mmio(struct kvm_cpu *vcpu, u64 phys_addr, u8 *data, u32 len, u
 int kvm__destroy_mem(struct kvm *kvm, u64 guest_phys, u64 size, void *userspace_addr);
 int kvm__register_mem(struct kvm *kvm, u64 guest_phys, u64 size, void *userspace_addr,
 		      enum kvm_mem_type type);
+bool kvm__valid_mmio(struct kvm_cpu *vcpu, u64 phys_addr, u32 len);
+
 static inline int kvm__register_ram(struct kvm *kvm, u64 guest_phys, u64 size,
 				    void *userspace_addr)
 {
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 502ea63..fa01051 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -178,6 +178,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_NOTIFY           37
 #define KVM_EXIT_LOONGARCH_IOCSR  38
 #define KVM_EXIT_MEMORY_FAULT     39
+#define KVM_EXIT_ARM_LDST64B      41

 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
diff --git a/kvm-cpu.c b/kvm-cpu.c
index 7362f2e..f544cf4 100644
--- a/kvm-cpu.c
+++ b/kvm-cpu.c
@@ -238,6 +238,42 @@ int kvm_cpu__start(struct kvm_cpu *cpu)
 				goto exit_kvm;
 			};
 			break;
+		case KVM_EXIT_ARM_LDST64B: {
+			struct kvm_run *kvm_run = cpu->kvm_run;
+			__u64 ipa = kvm_run->arm_nisv.fault_ipa;
+			int ret;
+
+			pr_info("esr_iss %llx fault_ipa %llx",
+				kvm_run->arm_nisv.esr_iss, ipa);
+
+			if (!kvm__valid_mmio(cpu, ipa, 64)) {
+				struct kvm_vcpu_events events = {
+					.exception.ext_dabt_excl_atom_pending = 1,
+				};
+
+				pr_info("Injecting DABT since incorrect Guest memory attribute");
+
+				ret = ioctl(cpu->vcpu_fd, KVM_SET_VCPU_EVENTS, &events);
+				if (ret) {
+					pr_err("err inject DABT");
+					goto panic_kvm;
+				}
+			} else {
+				struct kvm_vcpu_events events = {
+					.exception.ext_dabt_excl_atom_pending = 1,
+				};
+
+				pr_info("correct mapping but emulated MMIO");
+
+				ret = ioctl(cpu->vcpu_fd, KVM_SET_VCPU_EVENTS, &events);
+				if (ret) {
+					pr_err("err inject DABT");
+					goto panic_kvm;
+				}
+			}
+
+			break;
+		}
 		default: {
 			bool ret;

diff --git a/mmio.c b/mmio.c
index 231ce91..7071d3a 100644
--- a/mmio.c
+++ b/mmio.c
@@ -195,6 +195,11 @@ bool kvm__deregister_iotrap(struct kvm *kvm, u64 phys_addr, unsigned int flags)
 	return true;
 }

+bool kvm__valid_mmio(struct kvm_cpu *vcpu, u64 phys_addr, u32 len)
+{
+	return !!mmio_get(&mmio_tree, phys_addr, len);
+}
+
 bool kvm__emulate_mmio(struct kvm_cpu *vcpu, u64 phys_addr, u8 *data,
 		       u32 len, u8 is_write)
 {


> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  arch/arm64/include/asm/kvm_emulate.h |  1 +
>  arch/arm64/include/uapi/asm/kvm.h    |  3 ++-
>  arch/arm64/kvm/guest.c               |  4 ++++
>  arch/arm64/kvm/inject_fault.c        | 29 ++++++++++++++++++++++++++++
>  4 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 0720898f563e..df141ae77019 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -47,6 +47,7 @@ void kvm_skip_instr32(struct kvm_vcpu *vcpu);
>  void kvm_inject_undefined(struct kvm_vcpu *vcpu);
>  void kvm_inject_vabt(struct kvm_vcpu *vcpu);
>  void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
> +void kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, unsigned long addr);
>  void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
>  void kvm_inject_size_fault(struct kvm_vcpu *vcpu);
>  
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index ed5f3892674c..69985acda668 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -184,8 +184,9 @@ struct kvm_vcpu_events {
>  		__u8 serror_pending;
>  		__u8 serror_has_esr;
>  		__u8 ext_dabt_pending;
> +		__u8 ext_dabt_excl_atom_pending;
>  		/* Align it to 8 bytes */
> -		__u8 pad[5];
> +		__u8 pad[4];
>  		__u64 serror_esr;
>  	} exception;
>  	__u32 reserved[12];
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 2196979a24a3..47bc09ea50c3 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -839,6 +839,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>  	bool serror_pending = events->exception.serror_pending;
>  	bool has_esr = events->exception.serror_has_esr;
>  	bool ext_dabt_pending = events->exception.ext_dabt_pending;
> +	bool ext_dabt_excl_atom_pending = events->exception.ext_dabt_excl_atom_pending;
>  
>  	if (serror_pending && has_esr) {
>  		if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
> @@ -855,6 +856,9 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>  	if (ext_dabt_pending)
>  		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
>  
> +	if (ext_dabt_excl_atom_pending)
> +		kvm_inject_dabt_excl_atomic(vcpu, kvm_vcpu_get_hfar(vcpu));
> +
>  	return 0;
>  }
>  
> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> index a640e839848e..d64650a1aefe 100644
> --- a/arch/arm64/kvm/inject_fault.c
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -171,6 +171,35 @@ void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr)
>  		inject_abt64(vcpu, false, addr);
>  }
>  
> +/**
> + * kvm_inject_dabt_excl_atomic - inject a data abort for unsupported exclusive
> + *				 or atomic access
> + * @vcpu: The VCPU to receive the data abort
> + * @addr: The address to report in the DFAR
> + *
> + * It is assumed that this code is called from the VCPU thread and that the
> + * VCPU therefore is not currently executing guest code.
> + */
> +void kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, unsigned long addr)
> +{
> +	u64 esr = 0;
> +
> +	/* Reuse the general DABT injection routine and modify the DFSC */
> +	kvm_inject_dabt(vcpu, addr);
> +
> +	if (match_target_el(vcpu, unpack_vcpu_flag(EXCEPT_AA64_EL1_SYNC))) {
> +		esr = vcpu_read_sys_reg(vcpu, ESR_EL1);
> +		esr &= ~ESR_ELx_FSC;
> +		esr |= ESR_ELx_FSC_EXCL_ATOMIC;
> +		vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
> +	} else {
> +		esr = vcpu_read_sys_reg(vcpu, ESR_EL2);
> +		esr &= ~ESR_ELx_FSC;
> +		esr |= ESR_ELx_FSC_EXCL_ATOMIC;
> +		vcpu_write_sys_reg(vcpu, esr, ESR_EL2);
> +	}
> +}
> +
>  /**
>   * kvm_inject_pabt - inject a prefetch abort into the guest
>   * @vcpu: The VCPU to receive the prefetch abort
> 

