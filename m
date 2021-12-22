Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78A547D3A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 15:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbhLVOZl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 09:25:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241256AbhLVOZl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 09:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640183140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sed+3q7BIrPqRH2oXW0H9yWhS0jLPTp/jKWbYcwpgtQ=;
        b=XVqpWhzsGbfJaT6wpX7hweQ2qgpH/4pxpacP3hJFrCJJ69CdSJ43HXsDQAGLYKJnNAW3dM
        Pq4eavPVmui0awL8FzUy+po6elsdj2ZvnyF39vjfRn+bzp9SKepojaefbfvbyN87GNglnO
        jlRxZR1mO0rhYjSCuIYudTMVQtYaqWU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-ePu4TMavOqe-7MFaqZfjDQ-1; Wed, 22 Dec 2021 09:25:39 -0500
X-MC-Unique: ePu4TMavOqe-7MFaqZfjDQ-1
Received: by mail-wm1-f69.google.com with SMTP id i15-20020a05600c354f00b0034566ac865bso794167wmq.6
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Dec 2021 06:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sed+3q7BIrPqRH2oXW0H9yWhS0jLPTp/jKWbYcwpgtQ=;
        b=PXBz+l8HZDy07iRPan8Z6qBSl93K+z4F5QLT7m2SBhd6mjE3MLH5YYJ3dD6F20KDVX
         ktE3Bik41qi3EfQ/TxUZbcgVg3DE088hNmzSEvg3iSBGKsfIm4iLMccpgrOkjeMTcBPQ
         qEzGndpc8Iq1dYriEpcO+akeak6RXVxZzsUjf1qfILYG7vN5qk2D35cMETMcZzAxrGYA
         pseZC6cwZ7Q5QyQP9gVAkUhN5aCBZfiWcDoyf8qyD6BuGtKfK5h9A42YtuGWDCggvvi/
         RozEA8IRLy6EPDaN+0gU+ZnWCnQCtwnVwfDfUY+ErBB+Hq5wHXFrckXiXhX8Ma1MPHeY
         Lqtg==
X-Gm-Message-State: AOAM532NHABjhOobKiz1Dihh1FD/2lSBf8pQnythnEbLmQW4BCgt+fdw
        236St/aUx6p2GroPV6YyhMkFgpOPtWielMM+/3s9xdxDY1nMVGZtHJaW0uV83qYNQyHep9iN/OK
        ZuYSe/obouuI+SmEWU2XLHJ6BOBr3
X-Received: by 2002:adf:f48e:: with SMTP id l14mr2349816wro.88.1640183136572;
        Wed, 22 Dec 2021 06:25:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwF1H19oReVzIhW/HdovbPos3VfS1M89DowdEAQKVZDSnhnAO8GO941Jyef1dfqEXvlTJiEDA==
X-Received: by 2002:adf:f48e:: with SMTP id l14mr2349780wro.88.1640183136311;
        Wed, 22 Dec 2021 06:25:36 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312::4fa? ([2001:b07:6468:f312::4fa])
        by smtp.googlemail.com with ESMTPSA id p5sm2041160wrd.13.2021.12.22.06.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 06:25:35 -0800 (PST)
Message-ID: <eb23f097-bc37-f656-2d78-96135f0f9fab@redhat.com>
Date:   Wed, 22 Dec 2021 15:25:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 09/13] KVM: SVM: include CR3 in initial VMSA state for
 SEV-ES guests
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Peter Gonda <pgonda@google.com>
References: <20211216171358.61140-1-michael.roth@amd.com>
 <20211216171358.61140-10-michael.roth@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211216171358.61140-10-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/16/21 18:13, Michael Roth wrote:
> Normally guests will set up CR3 themselves, but some guests, such as
> kselftests, and potentially CONFIG_PVH guests, rely on being booted
> with paging enabled and CR3 initialized to a pre-allocated page table.
> 
> Currently CR3 updates via KVM_SET_SREGS* are not loaded into the guest
> VMCB until just prior to entering the guest. For SEV-ES/SEV-SNP, this
> is too late, since it will have switched over to using the VMSA page
> prior to that point, with the VMSA CR3 copied from the VMCB initial
> CR3 value: 0.
> 
> Address this by sync'ing the CR3 value into the VMCB save area
> immediately when KVM_SET_SREGS* is issued so it will find it's way into
> the initial VMSA.
> 
> Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   arch/x86/include/asm/kvm-x86-ops.h |  1 +
>   arch/x86/include/asm/kvm_host.h    |  1 +
>   arch/x86/kvm/svm/svm.c             | 19 +++++++++++++++++++
>   arch/x86/kvm/vmx/vmx.c             |  6 ++++++
>   arch/x86/kvm/x86.c                 |  1 +
>   5 files changed, 28 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index cefe1d81e2e8..a3172bd59690 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -35,6 +35,7 @@ KVM_X86_OP(get_cpl)
>   KVM_X86_OP(set_segment)
>   KVM_X86_OP_NULL(get_cs_db_l_bits)
>   KVM_X86_OP(set_cr0)
> +KVM_X86_OP(post_set_cr3)
>   KVM_X86_OP(is_valid_cr4)
>   KVM_X86_OP(set_cr4)
>   KVM_X86_OP(set_efer)
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index d5fede05eb5f..22f384320ed1 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1342,6 +1342,7 @@ struct kvm_x86_ops {
>   			    struct kvm_segment *var, int seg);
>   	void (*get_cs_db_l_bits)(struct kvm_vcpu *vcpu, int *db, int *l);
>   	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
> +	void (*post_set_cr3)(struct kvm_vcpu *vcpu, unsigned long cr3);
>   	bool (*is_valid_cr4)(struct kvm_vcpu *vcpu, unsigned long cr0);
>   	void (*set_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
>   	int (*set_efer)(struct kvm_vcpu *vcpu, u64 efer);
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 208566f63bce..76e906d83a84 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1792,6 +1792,24 @@ static void svm_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
>   	vmcb_mark_dirty(svm->vmcb, VMCB_DT);
>   }
>   
> +static void svm_post_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +
> +	/*
> +	 * For guests that don't set guest_state_protected, the cr3 update is
> +	 * handled via kvm_mmu_load() while entering the guest. For guests
> +	 * that do (SEV-ES/SEV-SNP), the cr3 update needs to be written to
> +	 * VMCB save area now, since the save area will become the initial
> +	 * contents of the VMSA, and future VMCB save area updates won't be
> +	 * seen.
> +	 */
> +	if (sev_es_guest(vcpu->kvm)) {
> +		svm->vmcb->save.cr3 = cr3;
> +		vmcb_mark_dirty(svm->vmcb, VMCB_CR);
> +	}
> +}
> +
>   void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
>   {
>   	struct vcpu_svm *svm = to_svm(vcpu);
> @@ -4622,6 +4640,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
>   	.get_cpl = svm_get_cpl,
>   	.get_cs_db_l_bits = kvm_get_cs_db_l_bits,
>   	.set_cr0 = svm_set_cr0,
> +	.post_set_cr3 = svm_post_set_cr3,
>   	.is_valid_cr4 = svm_is_valid_cr4,
>   	.set_cr4 = svm_set_cr4,
>   	.set_efer = svm_set_efer,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 63615d242bdf..075107c1b3f5 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -3124,6 +3124,11 @@ static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
>   		vmcs_writel(GUEST_CR3, guest_cr3);
>   }
>   
> +
> +void vmx_post_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
> +{
> +}
> +
>   static bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>   {
>   	/*
> @@ -7597,6 +7602,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
>   	.get_cpl = vmx_get_cpl,
>   	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
>   	.set_cr0 = vmx_set_cr0,
> +	.post_set_cr3 = vmx_post_set_cr3,
>   	.is_valid_cr4 = vmx_is_valid_cr4,
>   	.set_cr4 = vmx_set_cr4,
>   	.set_efer = vmx_set_efer,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 26cb3a4cd0e9..c0d84a4c8049 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10609,6 +10609,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
>   	*mmu_reset_needed |= kvm_read_cr3(vcpu) != sregs->cr3;
>   	vcpu->arch.cr3 = sregs->cr3;
>   	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
> +	static_call(kvm_x86_post_set_cr3)(vcpu, sregs->cr3);
>   
>   	kvm_set_cr8(vcpu, sregs->cr8);
>   
> 

I'm going to apply this one now, just with a small change to avoid 
vmx_post_set_cr3 and a remark about why kvm_set_cr3 is not calling the 
new hook.

diff --git a/arch/x86/include/asm/kvm-x86-ops.h 
b/arch/x86/include/asm/kvm-x86-ops.h
index 8803773539a0..37624a9e3e40 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -35,7 +35,7 @@ KVM_X86_OP(get_cpl)
  KVM_X86_OP(set_segment)
  KVM_X86_OP_NULL(get_cs_db_l_bits)
  KVM_X86_OP(set_cr0)
-KVM_X86_OP(post_set_cr3)
+KVM_X86_OP_NULL(post_set_cr3)
  KVM_X86_OP(is_valid_cr4)
  KVM_X86_OP(set_cr4)
  KVM_X86_OP(set_efer)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a39da103e33c..fe06b02994e6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3135,10 +3135,6 @@ static void vmx_load_mmu_pgd(struct kvm_vcpu 
*vcpu, hpa_t root_hpa,
  }


-void vmx_post_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
-{
-}
-
  static bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
  {
  	/*
@@ -7608,7 +7604,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
  	.get_cpl = vmx_get_cpl,
  	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
  	.set_cr0 = vmx_set_cr0,
-	.post_set_cr3 = vmx_post_set_cr3,
  	.is_valid_cr4 = vmx_is_valid_cr4,
  	.set_cr4 = vmx_set_cr4,
  	.set_efer = vmx_set_efer,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index db118066c653..c194a8cbd25f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1179,6 +1179,7 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned 
long cr3)

  	vcpu->arch.cr3 = cr3;
  	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
+	/* Do not call post_set_cr3, we do not get here for confidential 
guests.  */

  handle_tlb_flush:
  	/*
@@ -10636,7 +10637,7 @@ static int __set_sregs_common(struct kvm_vcpu 
*vcpu, struct kvm_sregs *sregs,
  	*mmu_reset_needed |= kvm_read_cr3(vcpu) != sregs->cr3;
  	vcpu->arch.cr3 = sregs->cr3;
  	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
-	static_call(kvm_x86_post_set_cr3)(vcpu, sregs->cr3);
+	static_call_cond(kvm_x86_post_set_cr3)(vcpu, sregs->cr3);

  	kvm_set_cr8(vcpu, sregs->cr8);

Paolo

