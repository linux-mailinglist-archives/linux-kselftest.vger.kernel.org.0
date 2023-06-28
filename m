Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E475F741B1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 23:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjF1Vsc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 17:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjF1Vsa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 17:48:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B896D1FFA
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 14:48:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bacd408046cso3902276.3
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 14:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687988908; x=1690580908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBAOCpxxY6L+xppfuwkPLmAxm1yPkGzXInR22ufWOpM=;
        b=YVML83wEmbg4z49lGpnhvJcNHwNFsXfzHOofD/6psqz7DAsZgSRglTP9HMqIUrLJLO
         amYNaaiC9LepsQW/msLyjnBRNYr3+nnvdocuiw5W0rQsxjcd1Pt6bEXaMwAe/XblhwlB
         35uLv6DE1G9rZDcWj2yGpq96oIFV5nW18ClZixVVi2wg3QNq9Oa3fSKCnrHlgb+uQQdY
         uwBsExrsHbIv6au3xIEYtawDnaSYytzzIgZOu52M3Oka9FilZgm170GEPZTIguM8Xcrg
         xLie20Ql88rSrQMW7CauBKdPzisrGa2w31RtPXY8AwKF6MzKOLu3YvAq2R0QDXaIt3V3
         n2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687988908; x=1690580908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBAOCpxxY6L+xppfuwkPLmAxm1yPkGzXInR22ufWOpM=;
        b=Da8zUh9/ejU3ug/iDQPJNkSjBDWZFS7G9gD3sVDmI7fnCOSejJ8hM0tW/7waVeA1Jz
         Ox3IkGNcZPmduk+7uy0ThJAsm2UmdPac8vL6IgAoSmRUzWNjSxdIcSN02wUotNpqrsDj
         9mudmBR99gYpGYAJ3Qbo7SnE/zDa1qcAmuqMntYIIzZX0PVEc8x5M/GWSNZCKQ+ZscgC
         Kx2cJ9EipnWx3i1SxTJAy5n16sEuxOHMzRftZYvot/zDXdM1JGG6Fn/byJqCnu/6YTdG
         rXnabp9SlVUVRTlRhL4jBIBDLnYpewuRCkMB9Fj4QU51kEcgW7bChn+boB/NAEWAL2yU
         i3Tw==
X-Gm-Message-State: AC+VfDzUmJiX0cXA0/FUEmGC/xyG7nK6gAeyoS172viWsjjOx48hZyFe
        BRNlH9fN9XxCbFaxL+xzCk23arR028U=
X-Google-Smtp-Source: ACHHUZ5BobjkPyAgyVSzEX3hl0yUPj5HOm/gV/2a3aBUQtZu/nvWXzFrwZs0vi521XZjSBobqyTQIRUkl2s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:4007:0:b0:bc4:8627:57c3 with SMTP id
 n7-20020a254007000000b00bc4862757c3mr14293171yba.9.1687988908020; Wed, 28 Jun
 2023 14:48:28 -0700 (PDT)
Date:   Wed, 28 Jun 2023 14:48:26 -0700
In-Reply-To: <20230608113420.14695-2-cloudliang@tencent.com>
Mime-Version: 1.0
References: <20230608113420.14695-1-cloudliang@tencent.com> <20230608113420.14695-2-cloudliang@tencent.com>
Message-ID: <ZJyqqg/UW3m0EHmB@google.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Test consistency of setting MSR_IA32_DS_AREA
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 08, 2023, Jinrong Liang wrote:
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> Tests have been added to this commit to check if setting
> MSR_IA32_DS_AREA with a non-classical address causes a fault. By
> verifying that KVM is correctly faulting non-classical addresses
> in MSR_IA32_DS_AREA, it helps ensure the accuracy and stability
> of the KVM subsystem.
> 
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> index 4c90f76930f9..02903084598f 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> @@ -19,6 +19,9 @@
>  #include "kvm_util.h"
>  #include "vmx.h"
>  
> +#define MAX_LINEAR_ADDR_MASK		GENMASK_ULL(15, 8)
> +#define ADDR_OFS_BIT			8

Similar to other comments, please spell this out.  Whatever "OFS" stands for, it
isn't common knowledge (unless I'm way out of the loop).

> +
>  union perf_capabilities {
>  	struct {
>  		u64	lbr_format:6;
> @@ -232,6 +235,102 @@ static void test_lbr_perf_capabilities(union perf_capabilities host_cap)
>  	kvm_vm_free(vm);
>  }
>  
> +/*
> + * Generate a non-canonical address for a given number of address bits.
> + * @addr_bits: The number of address bits used in the system.
> + *
> + * This function calculates a non-canonical address by setting the most
> + * significant bit to 1 and adding an offset equal to the maximum value
> + * that can be represented by the remaining bits. This ensures that the
> + * generated address is outside the valid address range and is consistent.
> + */
> +static inline uint64_t non_canonical_address(unsigned int addr_bits)
> +{
> +	return (1ULL << (addr_bits - 1)) + ((1ULL << (addr_bits - 1)) - 1);
> +}

Eh, I don't know that I would 

> +
> +static uint64_t get_addr_bits(struct kvm_vcpu *vcpu)
> +{
> +	const struct kvm_cpuid_entry2 *kvm_entry;
> +	unsigned int addr_bits;
> +	struct kvm_sregs sregs;
> +
> +	kvm_entry = get_cpuid_entry(kvm_get_supported_cpuid(), 0x80000008, 0);
> +	addr_bits = (kvm_entry->eax & MAX_LINEAR_ADDR_MASK) >> ADDR_OFS_BIT;

*sigh*

X86_PROPERTY_MAX_VIRT_ADDR, or even better, vcpu->vm->va_bits.

> +	/*
> +	 * Get the size of the virtual address space by checking the LA57 bit
> +	 * in the CR4 control register. If the LA57 bit is set, then the virtual
> +	 * address space is 57 bits. Otherwise, it's 48 bits.
> +	 */
> +	if (addr_bits != 32) {
> +		vcpu_sregs_get(vcpu, &sregs);
> +		addr_bits = (sregs.cr4 & X86_CR4_LA57) ? 57 : 48;
> +	}
> +
> +	return addr_bits;

(a) None of this is PMU specific.  (b) Selftests don't support LA57 (yet).
(c) IMO there's no reason to get this fancy.  Just hardcode a value that's
guaranteed to be non-canonical and call it good.

E.g.

#define NONCANONICAL	(0xaaaULL << 48)

That way the "bad" value can be used from the guest directly.

Or if you want to handle LA57 right now and verify that the guest can set values
that are canonical for LA57 but not for LA48, something like

static inline vm_vaddr_t get_noncanonical_address(bool is_la57)
{
	return is_la57 ? BIT(57) : BIT(48);
}

and then the guest can invoke it by reading and passing in the current CR4, i.e.
still doesn't require splitting logic across the guest and host.

> +}
> +
> +static void test_ds_guest_code(uint64_t bad_addr)
> +{
> +	uint8_t vector = 0;
> +
> +	vector = wrmsr_safe(MSR_IA32_DS_AREA, bad_addr);
> +	GUEST_SYNC(vector);

GUEST_ASSERT(vector == GP_VECTOR);

Aaron's fancy printf() stuff is coming, and even without that, splitting logic
across the guest and host is generally a bad idea as it makes it much harder to
understand what the test does.

> +}
> +
> +/* Check if setting MSR_IA32_DS_AREA in guest and kvm userspace will fail. */
> +static void test_ds_area_noncanonical_address(union perf_capabilities host_cap)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +	unsigned int r, addr_bits;
> +	uint64_t bad_addr, without_pebs_fmt_caps;
> +	struct ucall uc;

Reverse xmas tree.

> +
> +	vm = vm_create_with_one_vcpu(&vcpu, test_ds_guest_code);
> +	vm_init_descriptor_tables(vm);
> +	vcpu_init_descriptor_tables(vcpu);
> +
> +	/* Check that Setting MSR_IA32_DS_AREA with 0 should succeed. */

Drop the comment, the assert covers everything.

> +	r = _vcpu_set_msr(vcpu, MSR_IA32_DS_AREA, 0);
> +	TEST_ASSERT(r, "Setting MSR_IA32_DS_AREA with 0 should succeed.");

Eh, I would just do vcpu_set_msr() and let it assert for you.

> +	/*
> +	 * Check that if PEBS_FMT is not set setting MSR_IA32_DS_AREA will
> +	 * succeed.

I don't understand what this comment is trying to say.  The below tests that
writing MSR_IA32_DS_AREA *fails*, not succeeds.
		
> +	 */
> +	without_pebs_fmt_caps = host_cap.capabilities & ~PERF_CAP_PEBS_FORMAT;
> +	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, without_pebs_fmt_caps);
> +	r = _vcpu_set_msr(vcpu, MSR_IA32_DS_AREA, 1);
> +	TEST_ASSERT(r, "Setting MSR_IA32_DS_AREA with bad addr should fail.");

Print the actual "bad" value, and be more descriptive, i.e. state *why* '1' is
a bad value.

> +
> +	/*
> +	 * Check that setting MSR_IA32_DS_AREA in kvm userspace to use a
> +	 * non-canonical address should fail.
> +	 */
> +	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
> +	addr_bits = get_addr_bits(vcpu);
> +	bad_addr = non_canonical_address(addr_bits);
> +	r = _vcpu_set_msr(vcpu, MSR_IA32_DS_AREA, bad_addr);
> +	TEST_ASSERT(!r, "Setting MSR_IA32_DS_AREA with bad addr should fail.");

Same comment here.
