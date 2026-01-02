Return-Path: <linux-kselftest+bounces-48075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BF5CEEE4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 16:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF8633011F97
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EEC27B340;
	Fri,  2 Jan 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJcySGrB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKuusD/a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF0279792
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Jan 2026 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368412; cv=none; b=cvUfEEDqaHHLSQq+4noTJFGQsiGpQEocyoLSiTqKB8qvlIWn6+z+zB0QHsjTzsfkJ8Oj6KH/M1j0SYxxVOetEXx4+RF6G9G1dBr7IU7HauhNO0FXbzXi0m72AhHjEmsE3z9NnhCsId8Z/C4kEUbrdIR2KvKz1Bk1o1Ub7bq/JJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368412; c=relaxed/simple;
	bh=IBQ00UslAs5Lok7WESox5wn0+cSAkbMmOGLwasYuRRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BoT3gZEDNUQ+WQkc1VK548lypRTd0R06XP73bn3OyfF25uB2Ixl8COzh7KPOSDFOtH9KkMAUNjBoaxKRGfyl0PCHoBg8Y32sw36jb8fzBxn2pqXYB9FGNHN+btKzX6yFYHyjvrjJwIXLwEmTJ0VvspELc9iEVNd0FsBgiEpwRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJcySGrB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKuusD/a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767368409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAiayzJRY4ItQKaVQXIlfsuuXXNsffQ7Fc+1hVjxa0I=;
	b=XJcySGrBhWXCyfffJGljTQ4DQx8E2MaWOsAp+xquBJlPtpRXoNCY6rvMBbIxYUzT0mcW4C
	ivQ+lsTJ1EuHihh7Cc1vxYcuMe8YwhmIjrVbCk3eCnJDZY8RujxLVqvj5batW8FppMKi8Q
	HzlY/HfKjdBj6gyI7rmF66xIkHeD1Xo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-9A4ih7B5PzeMBaUZnDfYXw-1; Fri, 02 Jan 2026 10:40:06 -0500
X-MC-Unique: 9A4ih7B5PzeMBaUZnDfYXw-1
X-Mimecast-MFC-AGG-ID: 9A4ih7B5PzeMBaUZnDfYXw_1767368406
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-431026b6252so11275131f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 07:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767368406; x=1767973206; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAiayzJRY4ItQKaVQXIlfsuuXXNsffQ7Fc+1hVjxa0I=;
        b=fKuusD/aQazL+PR0eVyaRdeMBTMgRo9o4Gnv2AIiHtCyFSXUZTCvh7Qy0m0vjE16vF
         /TpTrj3y3W4D/Ug8sdVlKngTnkH781x8rUGx81hHmmRT/fk7hjm0X0x1sBuSVINpC/bv
         qPoRjSZ1IZIF65udeS0uArU2vh2G3APsmvUGNUyx9vHaJhcTXsv0cVTU+98HyOCaOrMg
         C/dXoMxtbj6Vnh6fJEOdMJUMF6lmhB4s9XEuPAqVoPVsRPpIUcoOBwSeo9lWlN8U87AJ
         flOrd3Us6pHv++mEHMTxp/9lLH+7cI1PAF3WiCOb5TRVvE9EwJHj8deKmLzM4yd15uda
         wvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767368406; x=1767973206;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAiayzJRY4ItQKaVQXIlfsuuXXNsffQ7Fc+1hVjxa0I=;
        b=aJ1QJFgi2k2OpPzzggw2wAAHUCOMGa1qCj5mbMjkMjp4fde2HfbAI1uGaVrF+8kRtW
         gEdmQ4Wi0tyTVz6gu7XdYy8EYth6jcMbjuqAgXi5iXW1LFh/A3c7SYneIBz5hWwG7i01
         8mSBtoihhAHznBXkxAIH69j9vbw7gBjqVWvCIvxZ3wsoJfwSVtuu4dRWLmx/7z7Orypx
         eFYMS17HFmDdYn9oVTjrEbUjRTixnO9JfwpWtXUTJKuDtvQXXsUCDhxhBvm6i5NQyIKa
         HyWRDGN2WHcD4Ce2V7kqLRZhDYifRnfPLanMKb/jIY8G1kywzcECUfY79AxgC8h3iYp3
         uERg==
X-Forwarded-Encrypted: i=1; AJvYcCWzxmOtZcWcWgyWd0XVm5VkutfBrp7UF9jPc5hcqzJBYskkM3+eVU7lYHw6MzWa4FZG2O/fTk91ddmlCacurrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtTyootk+RZzZ5qhfbjpD8xslFRPPJOXzlvVvZO1NZdtTHlSsF
	5LKARgAPR3YfpWjxUgCLIZq+TSzzUEd+sbibc83KRfEH/UDLqj3aViG1y3rTw6et+gD3ghZDR5X
	BI+ZldQCRhva47f4bf8Qk3WSFWHgXfSmQ6A61dxbBN+jN6h4iC/TSL4SwuEVciFSVgxZ1Zg==
X-Gm-Gg: AY/fxX774LNG5yP1s2enIcIOHA4Tr/peAde5RHkeTIVZTark7BDFu92+4NdQhG5u8C0
	VqsuVZtYk2TLFT7AttHRCyJGL8jzN8U7Q/9cI+gQQ+GVASULALo68nv+5qSSCSPD2g3dsuFdMfK
	dXKIdzjwCWhHsLH6S/Ymx869kCYNK/Hr7GZtChReaM1B/gacZfMObZ+zDkHO3J0FL9nt+5TzaQN
	AWs6tiDS+KVTr3ku0oMRSdSrOkKIxJREXq861k4IU501WNeGu/9V1/tocOk5fYBaVDAEIJ+pn+s
	oZByoxwHK0X9MOrH9DMDQqH8dMHugfztqu/aX8jgGRP5dSiXE7oG89QuQY/C30YbJqySlN8ZvjN
	7WFMSdQ==
X-Received: by 2002:a05:6000:2509:b0:42f:9f4d:a490 with SMTP id ffacd0b85a97d-4324e4c73e8mr60757705f8f.12.1767368405511;
        Fri, 02 Jan 2026 07:40:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEn5bxm6K3DZOY955faWJJP5hamKzqDm3+/kp9SotyMIyuzEKHtKcoLIsNhJV7Y4+/I3b/8rg==
X-Received: by 2002:a05:6000:2509:b0:42f:9f4d:a490 with SMTP id ffacd0b85a97d-4324e4c73e8mr60757670f8f.12.1767368405030;
        Fri, 02 Jan 2026 07:40:05 -0800 (PST)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa2bdfsm86129275f8f.32.2026.01.02.07.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:40:04 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Fred Griffoul <griffoul@gmail.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, shuah@kernel.org,
 dwmw@amazon.co.uk, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fred Griffoul <fgriffo@amazon.co.uk>
Subject: Re: [PATCH v4 06/10] KVM: nVMX: Cache evmcs fields to ensure
 consistency during VM-entry
In-Reply-To: <20260102142429.896101-7-griffoul@gmail.com>
References: <20260102142429.896101-1-griffoul@gmail.com>
 <20260102142429.896101-7-griffoul@gmail.com>
Date: Fri, 02 Jan 2026 16:40:03 +0100
Message-ID: <87a4ywaur0.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Fred Griffoul <griffoul@gmail.com> writes:

> From: Fred Griffoul <fgriffo@amazon.co.uk>
>
> Cache enlightened VMCS control fields to prevent TOCTOU races where the
> guest could modify hv_clean_fields or hv_enlightenments_control between
> multiple accesses during nested VM-entry.
>
> The cached values ensure consistent behavior across:
> - The evmcs-to-vmcs12 copy operations
> - MSR bitmap validation
> - Clean field checks in prepare_vmcs02_rare()
>
> This eliminates potential guest-induced inconsistencies in nested
> virtualization state management.

Could you please split the commit to simplify the review and bughunting
if (when?) issues are discovered? In particular, I would've split this
into at least:

- hv_flush_hypercall caching/handling
- hv_msr_bitmap caching/handling
- nested_vmx_is_evmptr12_valid() instead of vmx->nested.hv_evmcs checks
- adding 'bool copy' argument to nested_vmx_handle_enlightened_vmptrld()
and moving copy_enlightened_to_vmcs12() there from nested_vmx_run()
- hv_clean_fields caching/handling.

I want to be extra careful with clean fields. I may had forgotten the
details since I've implemented it but I still remember some pain over
inconsistent state upon migrations, namely

commit d6bf71a18c74de61548ddad44ff95306fe85f829
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Wed May 26 15:20:22 2021 +0200

    KVM: nVMX: Ignore 'hv_clean_fields' data when eVMCS data is copied in vmx_get_nested_state()

Unfortunatelly, I don't think we have good test coverage for all this in
'hyperv_evmcs' selftest :-( I've seen you added evmcs support to
'vmx_l2_switch_test' in this series, thanks a lot for doing that!

>
> Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
> ---
>  arch/x86/kvm/vmx/hyperv.c |  5 ++--
>  arch/x86/kvm/vmx/hyperv.h | 20 +++++++++++++
>  arch/x86/kvm/vmx/nested.c | 62 ++++++++++++++++++++++++---------------
>  arch/x86/kvm/vmx/vmx.h    |  5 +++-
>  4 files changed, 65 insertions(+), 27 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
> index fa41d036acd4..961b91b9bd64 100644
> --- a/arch/x86/kvm/vmx/hyperv.c
> +++ b/arch/x86/kvm/vmx/hyperv.c
> @@ -213,12 +213,11 @@ bool nested_evmcs_l2_tlb_flush_enabled(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> -	struct hv_enlightened_vmcs *evmcs = vmx->nested.hv_evmcs;
>  
> -	if (!hv_vcpu || !evmcs)
> +	if (!hv_vcpu || !nested_vmx_is_evmptr12_valid(vmx))
>  		return false;
>  
> -	if (!evmcs->hv_enlightenments_control.nested_flush_hypercall)
> +	if (!vmx->nested.hv_flush_hypercall)
>  		return false;
>  
>  	return hv_vcpu->vp_assist_page.nested_control.features.directhypercall;
> diff --git a/arch/x86/kvm/vmx/hyperv.h b/arch/x86/kvm/vmx/hyperv.h
> index 11a339009781..3c7fea501ca5 100644
> --- a/arch/x86/kvm/vmx/hyperv.h
> +++ b/arch/x86/kvm/vmx/hyperv.h
> @@ -52,6 +52,16 @@ static inline bool guest_cpu_cap_has_evmcs(struct kvm_vcpu *vcpu)
>  	       to_vmx(vcpu)->nested.enlightened_vmcs_enabled;
>  }
>  
> +static inline u32 nested_evmcs_clean_fields(struct vcpu_vmx *vmx)
> +{
> +	return vmx->nested.hv_clean_fields;
> +}
> +
> +static inline bool nested_evmcs_msr_bitmap(struct vcpu_vmx *vmx)
> +{
> +	return vmx->nested.hv_msr_bitmap;
> +}
> +
>  u64 nested_get_evmptr(struct kvm_vcpu *vcpu);
>  uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu);
>  int nested_enable_evmcs(struct kvm_vcpu *vcpu,
> @@ -85,6 +95,16 @@ static inline struct hv_enlightened_vmcs *nested_vmx_evmcs(struct vcpu_vmx *vmx)
>  {
>  	return NULL;
>  }
> +
> +static inline u32 nested_evmcs_clean_fields(struct vcpu_vmx *vmx)
> +{
> +	return 0;
> +}
> +
> +static inline bool nested_evmcs_msr_bitmap(struct vcpu_vmx *vmx)
> +{
> +	return false;
> +}
>  #endif
>  
>  #endif /* __KVM_X86_VMX_HYPERV_H */
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index cb4b85edcb7a..5790e1a26456 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -236,6 +236,9 @@ static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
>  	kvm_vcpu_unmap(vcpu, &vmx->nested.hv_evmcs_map);
>  	vmx->nested.hv_evmcs = NULL;
>  	vmx->nested.hv_evmcs_vmptr = EVMPTR_INVALID;
> +	vmx->nested.hv_clean_fields = 0;
> +	vmx->nested.hv_msr_bitmap = false;
> +	vmx->nested.hv_flush_hypercall = false;
>  
>  	if (hv_vcpu) {
>  		hv_vcpu->nested.pa_page_gpa = INVALID_GPA;
> @@ -737,10 +740,10 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>  	 *   and tells KVM (L0) there were no changes in MSR bitmap for L2.
>  	 */
>  	if (!vmx->nested.force_msr_bitmap_recalc) {
> -		struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
> -
> -		if (evmcs && evmcs->hv_enlightenments_control.msr_bitmap &&
> -		    evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP)
> +		if (nested_vmx_is_evmptr12_valid(vmx) &&
> +		    nested_evmcs_msr_bitmap(vmx) &&
> +		    (nested_evmcs_clean_fields(vmx)
> +		     & HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP))
>  			return true;
>  	}
>  
> @@ -2214,10 +2217,11 @@ static void copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
>   * instruction.
>   */
>  static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
> -	struct kvm_vcpu *vcpu, bool from_launch)
> +	struct kvm_vcpu *vcpu, bool from_launch, bool copy)
>  {
>  #ifdef CONFIG_KVM_HYPERV
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	struct hv_enlightened_vmcs *evmcs;
>  	bool evmcs_gpa_changed = false;
>  	u64 evmcs_gpa;
>  
> @@ -2297,6 +2301,22 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
>  		vmx->nested.force_msr_bitmap_recalc = true;
>  	}
>  
> +	/* Cache evmcs fields to avoid reading evmcs after copy to vmcs12 */
> +	evmcs = vmx->nested.hv_evmcs;
> +	vmx->nested.hv_clean_fields = evmcs->hv_clean_fields;
> +	vmx->nested.hv_flush_hypercall = evmcs->hv_enlightenments_control.nested_flush_hypercall;
> +	vmx->nested.hv_msr_bitmap = evmcs->hv_enlightenments_control.msr_bitmap;
> +
> +	if (copy) {
> +		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> +
> +		if (likely(!vmcs12->hdr.shadow_vmcs)) {
> +			copy_enlightened_to_vmcs12(vmx, vmx->nested.hv_clean_fields);
> +			/* Enlightened VMCS doesn't have launch state */
> +			vmcs12->launch_state = !from_launch;
> +		}
> +	}
> +
>  	return EVMPTRLD_SUCCEEDED;
>  #else
>  	return EVMPTRLD_DISABLED;
> @@ -2655,10 +2675,12 @@ static void vmcs_write_cet_state(struct kvm_vcpu *vcpu, u64 s_cet,
>  
>  static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>  {
> -	struct hv_enlightened_vmcs *hv_evmcs = nested_vmx_evmcs(vmx);
> +	u32 hv_clean_fields = 0;
>  
> -	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
> -			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
> +	if (nested_vmx_is_evmptr12_valid(vmx))
> +		hv_clean_fields = nested_evmcs_clean_fields(vmx);
> +
> +	if (!(hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
>  
>  		vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
>  		vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
> @@ -2700,8 +2722,7 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>  		vmx_segment_cache_clear(vmx);
>  	}
>  
> -	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
> -			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1)) {
> +	if (!(hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1)) {
>  		vmcs_write32(GUEST_SYSENTER_CS, vmcs12->guest_sysenter_cs);
>  		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
>  			    vmcs12->guest_pending_dbg_exceptions);
> @@ -2792,7 +2813,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  			  enum vm_entry_failure_code *entry_failure_code)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> -	struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
> +	struct hv_enlightened_vmcs *evmcs;
>  	bool load_guest_pdptrs_vmcs12 = false;
>  
>  	if (vmx->nested.dirty_vmcs12 || nested_vmx_is_evmptr12_valid(vmx)) {
> @@ -2800,7 +2821,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  		vmx->nested.dirty_vmcs12 = false;
>  
>  		load_guest_pdptrs_vmcs12 = !nested_vmx_is_evmptr12_valid(vmx) ||
> -			!(evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1);
> +			!(nested_evmcs_clean_fields(vmx)
> +			  & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1);
>  	}
>  
>  	if (vmx->nested.nested_run_pending &&
> @@ -2929,7 +2951,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  	 * bits when it changes a field in eVMCS. Mark all fields as clean
>  	 * here.
>  	 */
> -	if (nested_vmx_is_evmptr12_valid(vmx))
> +	evmcs = nested_vmx_evmcs(vmx);
> +	if (evmcs)
>  		evmcs->hv_clean_fields |= HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
>  
>  	return 0;
> @@ -3477,7 +3500,7 @@ static bool nested_get_evmcs_page(struct kvm_vcpu *vcpu)
>  	if (guest_cpu_cap_has_evmcs(vcpu) &&
>  	    vmx->nested.hv_evmcs_vmptr == EVMPTR_MAP_PENDING) {
>  		enum nested_evmptrld_status evmptrld_status =
> -			nested_vmx_handle_enlightened_vmptrld(vcpu, false);
> +			nested_vmx_handle_enlightened_vmptrld(vcpu, false, false);
>  
>  		if (evmptrld_status == EVMPTRLD_VMFAIL ||
>  		    evmptrld_status == EVMPTRLD_ERROR)
> @@ -3867,7 +3890,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>  	if (!nested_vmx_check_permission(vcpu))
>  		return 1;
>  
> -	evmptrld_status = nested_vmx_handle_enlightened_vmptrld(vcpu, launch);
> +	evmptrld_status = nested_vmx_handle_enlightened_vmptrld(vcpu, launch, true);
>  	if (evmptrld_status == EVMPTRLD_ERROR) {
>  		kvm_queue_exception(vcpu, UD_VECTOR);
>  		return 1;
> @@ -3893,15 +3916,8 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>  	if (CC(vmcs12->hdr.shadow_vmcs))
>  		return nested_vmx_failInvalid(vcpu);
>  
> -	if (nested_vmx_is_evmptr12_valid(vmx)) {
> -		struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
> -
> -		copy_enlightened_to_vmcs12(vmx, evmcs->hv_clean_fields);
> -		/* Enlightened VMCS doesn't have launch state */
> -		vmcs12->launch_state = !launch;
> -	} else if (enable_shadow_vmcs) {
> +	if (!nested_vmx_is_evmptr12_valid(vmx) && enable_shadow_vmcs)
>  		copy_shadow_to_vmcs12(vmx);
> -	}
>  
>  	/*
>  	 * The nested entry process starts with enforcing various prerequisites
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 90fdf130fd85..cda96196c56c 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -205,8 +205,11 @@ struct nested_vmx {
>  
>  #ifdef CONFIG_KVM_HYPERV
>  	gpa_t hv_evmcs_vmptr;
> -	struct kvm_host_map hv_evmcs_map;
> +	u32 hv_clean_fields;
> +	bool hv_msr_bitmap;
> +	bool hv_flush_hypercall;
>  	struct hv_enlightened_vmcs *hv_evmcs;
> +	struct kvm_host_map hv_evmcs_map;
>  #endif
>  };

-- 
Vitaly


