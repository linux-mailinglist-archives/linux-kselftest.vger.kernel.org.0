Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAE93E93AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 16:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhHKO1Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 10:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232402AbhHKO1P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 10:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628692011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SiFfbJIzEQjG/ygjdfzM4enm4T9jUPJiEOjLRuFPC/w=;
        b=AdPTEI17P85ft/DTL2LdORbf/7vw+HrRGwVe9M/5zbLXLXE8GvFDUxd3TdExTEFMc2o63U
        2tRZxkyYWOsrifgntvI5HKsAVjh7I8os2ARq46yYGY+pzYEz1LJ4lCqZRZ7m7id3ScWRqC
        YEMEfbW56KgasLaPTk15qXPzTtIs7Zg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-8cD_HgouPWiFL5t7N2-KIA-1; Wed, 11 Aug 2021 10:26:50 -0400
X-MC-Unique: 8cD_HgouPWiFL5t7N2-KIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40A91107ACF5;
        Wed, 11 Aug 2021 14:26:47 +0000 (UTC)
Received: from starship (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F2B95D9CA;
        Wed, 11 Aug 2021 14:26:41 +0000 (UTC)
Message-ID: <73f3eff092ca9624ebd55bc02193b39f248c8877.camel@redhat.com>
Subject: Re: [PATCH v3 3/6] KVM: SVM: implement
 force_intercept_exceptions_mask
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 11 Aug 2021 17:26:40 +0300
In-Reply-To: <20210811122927.900604-4-mlevitsk@redhat.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
         <20210811122927.900604-4-mlevitsk@redhat.com>
Content-Type: multipart/mixed; boundary="=-6BVcX+XV7rDFCEbVrCRD"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--=-6BVcX+XV7rDFCEbVrCRD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2021-08-11 at 15:29 +0300, Maxim Levitsky wrote:
> Currently #TS interception is only done once.
> Also exception interception is not enabled for SEV guests.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +
>  arch/x86/kvm/svm/svm.c          | 70 +++++++++++++++++++++++++++++++++
>  arch/x86/kvm/svm/svm.h          |  6 ++-
>  arch/x86/kvm/x86.c              |  5 ++-
>  4 files changed, 80 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 20daaf67a5bf..72fe03506018 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1690,6 +1690,8 @@ int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu);
>  void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
>  void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
>  void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
> +void kvm_queue_exception_e_p(struct kvm_vcpu *vcpu, unsigned nr,
> +			     u32 error_code, unsigned long payload);
>  void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned nr);
>  void kvm_requeue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
>  void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e45259177009..19f54b07161a 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -233,6 +233,8 @@ static const u32 msrpm_ranges[] = {0, 0xc0000000, 0xc0010000};
>  #define MSRS_RANGE_SIZE 2048
>  #define MSRS_IN_RANGE (MSRS_RANGE_SIZE * 8 / 2)
>  
> +static int svm_handle_invalid_exit(struct kvm_vcpu *vcpu, u64 exit_code);
> +
>  u32 svm_msrpm_offset(u32 msr)
>  {
>  	u32 offset;
> @@ -1153,6 +1155,22 @@ static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu,
>  	}
>  }
>  
> +static void svm_init_force_exceptions_intercepts(struct vcpu_svm *svm)
> +{
> +	int exc;
> +
> +	svm->force_intercept_exceptions_mask = force_intercept_exceptions_mask;
> +	for (exc = 0 ; exc < 32 ; exc++) {
> +		if (!(svm->force_intercept_exceptions_mask & (1 << exc)))
> +			continue;
> +
> +		/* Those are defined to have undefined behavior in the SVM spec */
> +		if (exc != 2 && exc != 9)
> +			continue;
> +		set_exception_intercept(svm, exc);

I made a mistake here, during one of the refactoring I think, after I finished
testing this througfully, and I noticed it now while looking again
at the code.

I attached a fix for this, and I also tested more carefully that the
feature works with selftests, kvm unit tests and by booting few VMs.

Best regards,
	Maxim Levitsky

> +	}
> +}
> +
>  static void init_vmcb(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> @@ -1304,6 +1322,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>  
>  	enable_gif(svm);
>  
> +	if (!sev_es_guest(vcpu->kvm))
> +		svm_init_force_exceptions_intercepts(svm);
> +
>  }
>  
>  static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> @@ -1892,6 +1913,17 @@ static int pf_interception(struct kvm_vcpu *vcpu)
>  	u64 fault_address = svm->vmcb->control.exit_info_2;
>  	u64 error_code = svm->vmcb->control.exit_info_1;
>  
> +	if ((svm->force_intercept_exceptions_mask & (1 << PF_VECTOR)))
> +		if (npt_enabled && !vcpu->arch.apf.host_apf_flags) {
> +			/* If the #PF was only intercepted for debug, inject
> +			 * it directly to the guest, since the kvm's mmu code
> +			 * is not ready to deal with such page faults.
> +			 */
> +			kvm_queue_exception_e_p(vcpu, PF_VECTOR,
> +						error_code, fault_address);
> +			return 1;
> +		}
> +
>  	return kvm_handle_page_fault(vcpu, error_code, fault_address,
>  			static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
>  			svm->vmcb->control.insn_bytes : NULL,
> @@ -1967,6 +1999,40 @@ static int ac_interception(struct kvm_vcpu *vcpu)
>  	return 1;
>  }
>  
> +static int gen_exc_interception(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * Generic exception intercept handler which forwards a guest exception
> +	 * as-is to the guest.
> +	 * For exceptions that don't have a special intercept handler.
> +	 *
> +	 * Used only for 'force_intercept_exceptions_mask' KVM debug feature.
> +	 */
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	int exc = svm->vmcb->control.exit_code - SVM_EXIT_EXCP_BASE;
> +
> +	/* SVM doesn't provide us with an error code for the #DF */
> +	u32 err_code = exc == DF_VECTOR ? 0 : svm->vmcb->control.exit_info_1;
> +
> +	if (!(svm->force_intercept_exceptions_mask & (1 << exc)))
> +		return svm_handle_invalid_exit(vcpu, svm->vmcb->control.exit_code);
> +
> +	if (exc == TS_VECTOR) {
> +		/*
> +		 * SVM doesn't provide us with an error code to be able to
> +		 * re-inject the #TS exception, so just disable its
> +		 * intercept, and let the guest re-execute the instruction.
> +		 */
> +		vmcb_clr_intercept(&svm->vmcb01.ptr->control,
> +				   INTERCEPT_EXCEPTION_OFFSET + TS_VECTOR);
> +		recalc_intercepts(svm);
> +	} else if (x86_exception_has_error_code(exc))
> +		kvm_queue_exception_e(vcpu, exc, err_code);
> +	else
> +		kvm_queue_exception(vcpu, exc);
> +	return 1;
> +}
> +
>  static bool is_erratum_383(void)
>  {
>  	int err, i;
> @@ -3065,6 +3131,10 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>  	[SVM_EXIT_WRITE_DR5]			= dr_interception,
>  	[SVM_EXIT_WRITE_DR6]			= dr_interception,
>  	[SVM_EXIT_WRITE_DR7]			= dr_interception,
> +
> +	[SVM_EXIT_EXCP_BASE ...
> +	SVM_EXIT_EXCP_BASE + 31]		= gen_exc_interception,
> +
>  	[SVM_EXIT_EXCP_BASE + DB_VECTOR]	= db_interception,
>  	[SVM_EXIT_EXCP_BASE + BP_VECTOR]	= bp_interception,
>  	[SVM_EXIT_EXCP_BASE + UD_VECTOR]	= ud_interception,
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 524d943f3efc..187ada7c5b03 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -196,6 +196,7 @@ struct vcpu_svm {
>  	bool ghcb_sa_free;
>  
>  	bool guest_state_loaded;
> +	u32 force_intercept_exceptions_mask;
>  };
>  
>  struct svm_cpu_data {
> @@ -351,8 +352,11 @@ static inline void clr_exception_intercept(struct vcpu_svm *svm, u32 bit)
>  	struct vmcb *vmcb = svm->vmcb01.ptr;
>  
>  	WARN_ON_ONCE(bit >= 32);
> -	vmcb_clr_intercept(&vmcb->control, INTERCEPT_EXCEPTION_OFFSET + bit);
>  
> +	if ((1 << bit) & svm->force_intercept_exceptions_mask)
> +		return;
> +
> +	vmcb_clr_intercept(&vmcb->control, INTERCEPT_EXCEPTION_OFFSET + bit);
>  	recalc_intercepts(svm);
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 092e2fad3c0d..e5c7b8fa1f7f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -695,12 +695,13 @@ void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr,
>  }
>  EXPORT_SYMBOL_GPL(kvm_queue_exception_p);
>  
> -static void kvm_queue_exception_e_p(struct kvm_vcpu *vcpu, unsigned nr,
> -				    u32 error_code, unsigned long payload)
> +void kvm_queue_exception_e_p(struct kvm_vcpu *vcpu, unsigned nr,
> +			     u32 error_code, unsigned long payload)
>  {
>  	kvm_multiple_exception(vcpu, nr, true, error_code,
>  			       true, payload, false);
>  }
> +EXPORT_SYMBOL_GPL(kvm_queue_exception_e_p);
>  
>  int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err)
>  {


--=-6BVcX+XV7rDFCEbVrCRD
Content-Disposition: attachment;
	filename="0001-KVM-x86-fix-for-force_intercept_exceptions_mask.patch"
Content-Type: text/x-patch;
	name="0001-KVM-x86-fix-for-force_intercept_exceptions_mask.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAyYmRmODQ3Zjk5OTFmNWJlMWJkYjNhNDdjMGU3OTZhZjkzNWJkYjNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXhpbSBMZXZpdHNreSA8bWxldml0c2tAcmVkaGF0LmNvbT4K
RGF0ZTogV2VkLCAxMSBBdWcgMjAyMSAxNzowMjoxNCArMDMwMApTdWJqZWN0OiBbUEFUQ0hdIEtW
TTogeDg2OiBmaXggZm9yIGZvcmNlX2ludGVyY2VwdF9leGNlcHRpb25zX21hc2sKCi0tLQogYXJj
aC94ODYva3ZtL3N2bS9zdm0uYyB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3N2bS9zdm0uYyBi
L2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMKaW5kZXggNmYxNzU2OWZkNWM4Li44NWU1YTkzZmE3OWEg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMKKysrIGIvYXJjaC94ODYva3ZtL3N2
bS9zdm0uYwpAQCAtMTE2Niw4ICsxMTY2LDcgQEAgc3RhdGljIHZvaWQgc3ZtX2luaXRfZm9yY2Vf
ZXhjZXB0aW9uc19pbnRlcmNlcHRzKHN0cnVjdCB2Y3B1X3N2bSAqc3ZtKQogCiAJCS8qIFRob3Nl
IGFyZSBkZWZpbmVkIHRvIGhhdmUgdW5kZWZpbmVkIGJlaGF2aW9yIGluIHRoZSBTVk0gc3BlYyAq
LwogCQlpZiAoZXhjICE9IDIgJiYgZXhjICE9IDkpCi0JCQljb250aW51ZTsKLQkJc2V0X2V4Y2Vw
dGlvbl9pbnRlcmNlcHQoc3ZtLCBleGMpOworCQkJc2V0X2V4Y2VwdGlvbl9pbnRlcmNlcHQoc3Zt
LCBleGMpOwogCX0KIH0KIAotLSAKMi4yNi4zCgo=


--=-6BVcX+XV7rDFCEbVrCRD--

