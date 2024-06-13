Return-Path: <linux-kselftest+bounces-11893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4C1907AD4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646D81F238AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F321D14A600;
	Thu, 13 Jun 2024 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHTItqr0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ADB1459E6
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302585; cv=none; b=ku3vNkO6InaV8JWaZKUkPo2CB6JeXS0ahczOAa75i74Lmug/jYzHl80pMKesLJTpVoxubUT6p5YJhKZIZ0ai3D040KRBxyrW+6szICmnSqOIeZHar5WZb89kXw9ou1lGl5n2xNp38yVWnsObJ1npmd11bgeLKq0NVS69NNAeW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302585; c=relaxed/simple;
	bh=VMV5npPvx2LlJ/v0Vts5oDRx4jTMhD7qJPkKX8wCExc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dquCKiCTSWeAeDjw0xuZaY5cECvE6hKk0l4fvfN3ANAdC21rsyZP+FaFDAZsfOMKHNGfpZx8G8Fgh9vnCfBrJQaJDfo3vylu9JegdNSsScFSjWXAF6m0n1wYfz9me+91YUOdWc46RBuYLiAirT8vmMUgdZRgME1BCMGgIKMzuC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHTItqr0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa7a8147c3so2251221276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 11:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718302583; x=1718907383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HubYKewLWWkCbdNX6Kwg7NPcQhWO6deKo+vfavaox7o=;
        b=MHTItqr0GeqGwp1JpLq43jq01LcN4VRBo2IuHaYCbElbTmbcu5vo21tyGQ760OpBDe
         OwPuKRcDxssUN6/U7pCNfsCzweWVCBgbPITtOsGghjEBpNiJ6zxif7+qbE5C7pnT6FWe
         yZTOAtnKzMWzuRnlDAaMZlHblH6S5X4Pb5YStYpK+YW8DF+QY0F4xUNxH6QZuxKp3BuM
         0u+RDEWMzylCRj9KJhXUUeuKmS5eG8BhS5XLRVWfMbwDiBQz2EILzMdcs1ZF67rylWOp
         5kLP15leUAqStIXqFuEn32fvJU0Wtn2Ex7K04SWC4PN2Dc4OmcYyZEi4sfdBlsKDuQzp
         mCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718302583; x=1718907383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HubYKewLWWkCbdNX6Kwg7NPcQhWO6deKo+vfavaox7o=;
        b=fAjEUM41jbvRTUP6U8U4FAbQw9DeHAdfMxRxz7J+gjGpt1fZJX3GF2I2a7m1ZCs2c8
         deWh1yFt5T+PHSgdr3Wt5S2/EEi14HfBw2BxBXcxKydn4gvOHFLrK4hMg4USUH+xgtQm
         Qxxa4ENJxDZCuF4owt1XtG0aA6NmVctoG3iwnjGI8A92OAbh+GbVJCIRb6vDykPyak0Q
         irhDuVMkAE6doQn0reH9cgOAhArmukDArBV1CDjLRiWgW6ciL5Bi2I/cDV6BxD19FYvo
         NoA0OJsjsHO7ivSacWphGiJwZN6MpRB6GEBQewhPTTmDcqY+4KW3tl/nBxmeFGeic6Yf
         /wpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpFTI8D24qucJ5HyqoEiAK+6v5XRY1O2fwSroJLJLPEu+S0jA/JagzG6y1Y3R800x54nf9iKXuQEIhhasAoFVk+0bXMZRc0Lmx3t/ml1JU
X-Gm-Message-State: AOJu0YxPFkMn++SqUmfZMiQGbcSPx9lnuWwu9kdlfoDZpckL41npRdQE
	H2rIWESHBm2jiVHoM6JbhtI1xcku+ByECtQlc81iXHIfzNtoUGNIEwu9z2YXyhE/kOrZwP5qn+A
	VzQ==
X-Google-Smtp-Source: AGHT+IEpFkCu5iSBXcf5Bl0AwgjGARJpjeA/2ZZwxq9LggA19KheODvNkc7FkwL6B4GvsjAsggv5UiEcpBo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:706:b0:dff:ee8:14d6 with SMTP id
 3f1490d57ef6-dff15454a8bmr84096276.10.1718302583316; Thu, 13 Jun 2024
 11:16:23 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:16:21 -0700
In-Reply-To: <20240207172646.3981-19-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-19-xin3.li@intel.com>
Message-ID: <Zms3dVgcuObZOwRR@google.com>
Subject: Re: [PATCH v2 18/25] KVM: nVMX: Add a prerequisite to
 SHADOW_FIELD_R[OW] macros
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin3.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org, 
	ravi.v.shankar@intel.com, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 07, 2024, Xin Li wrote:
> @@ -32,48 +32,48 @@ BUILD_BUG_ON(1)
>   */
>  
>  /* 16-bits */
> -SHADOW_FIELD_RW(GUEST_INTR_STATUS, guest_intr_status)
> -SHADOW_FIELD_RW(GUEST_PML_INDEX, guest_pml_index)
> -SHADOW_FIELD_RW(HOST_FS_SELECTOR, host_fs_selector)
> -SHADOW_FIELD_RW(HOST_GS_SELECTOR, host_gs_selector)
> +SHADOW_FIELD_RW(GUEST_INTR_STATUS, guest_intr_status, cpu_has_vmx_apicv())
> +SHADOW_FIELD_RW(GUEST_PML_INDEX, guest_pml_index, cpu_has_vmx_pml())
> +SHADOW_FIELD_RW(HOST_FS_SELECTOR, host_fs_selector, true)
> +SHADOW_FIELD_RW(HOST_GS_SELECTOR, host_gs_selector, true)
>  
>  /* 32-bits */
> -SHADOW_FIELD_RO(VM_EXIT_REASON, vm_exit_reason)
> -SHADOW_FIELD_RO(VM_EXIT_INTR_INFO, vm_exit_intr_info)
> -SHADOW_FIELD_RO(VM_EXIT_INSTRUCTION_LEN, vm_exit_instruction_len)
> -SHADOW_FIELD_RO(IDT_VECTORING_INFO_FIELD, idt_vectoring_info_field)
> -SHADOW_FIELD_RO(IDT_VECTORING_ERROR_CODE, idt_vectoring_error_code)
> -SHADOW_FIELD_RO(VM_EXIT_INTR_ERROR_CODE, vm_exit_intr_error_code)
> -SHADOW_FIELD_RO(GUEST_CS_AR_BYTES, guest_cs_ar_bytes)
> -SHADOW_FIELD_RO(GUEST_SS_AR_BYTES, guest_ss_ar_bytes)
> -SHADOW_FIELD_RW(CPU_BASED_VM_EXEC_CONTROL, cpu_based_vm_exec_control)
> -SHADOW_FIELD_RW(PIN_BASED_VM_EXEC_CONTROL, pin_based_vm_exec_control)
> -SHADOW_FIELD_RW(EXCEPTION_BITMAP, exception_bitmap)
> -SHADOW_FIELD_RW(VM_ENTRY_EXCEPTION_ERROR_CODE, vm_entry_exception_error_code)
> -SHADOW_FIELD_RW(VM_ENTRY_INTR_INFO_FIELD, vm_entry_intr_info_field)
> -SHADOW_FIELD_RW(VM_ENTRY_INSTRUCTION_LEN, vm_entry_instruction_len)
> -SHADOW_FIELD_RW(TPR_THRESHOLD, tpr_threshold)
> -SHADOW_FIELD_RW(GUEST_INTERRUPTIBILITY_INFO, guest_interruptibility_info)
> -SHADOW_FIELD_RW(VMX_PREEMPTION_TIMER_VALUE, vmx_preemption_timer_value)
> +SHADOW_FIELD_RO(VM_EXIT_REASON, vm_exit_reason, true)
> +SHADOW_FIELD_RO(VM_EXIT_INTR_INFO, vm_exit_intr_info, true)
> +SHADOW_FIELD_RO(VM_EXIT_INSTRUCTION_LEN, vm_exit_instruction_len, true)
> +SHADOW_FIELD_RO(VM_EXIT_INTR_ERROR_CODE, vm_exit_intr_error_code, true)
> +SHADOW_FIELD_RO(IDT_VECTORING_INFO_FIELD, idt_vectoring_info_field, true)
> +SHADOW_FIELD_RO(IDT_VECTORING_ERROR_CODE, idt_vectoring_error_code, true)
> +SHADOW_FIELD_RO(GUEST_CS_AR_BYTES, guest_cs_ar_bytes, true)
> +SHADOW_FIELD_RO(GUEST_SS_AR_BYTES, guest_ss_ar_bytes, true)
> +SHADOW_FIELD_RW(CPU_BASED_VM_EXEC_CONTROL, cpu_based_vm_exec_control, true)
> +SHADOW_FIELD_RW(PIN_BASED_VM_EXEC_CONTROL, pin_based_vm_exec_control, true)
> +SHADOW_FIELD_RW(EXCEPTION_BITMAP, exception_bitmap, true)
> +SHADOW_FIELD_RW(VM_ENTRY_EXCEPTION_ERROR_CODE, vm_entry_exception_error_code, true)
> +SHADOW_FIELD_RW(VM_ENTRY_INTR_INFO_FIELD, vm_entry_intr_info_field, true)
> +SHADOW_FIELD_RW(VM_ENTRY_INSTRUCTION_LEN, vm_entry_instruction_len, true)
> +SHADOW_FIELD_RW(TPR_THRESHOLD, tpr_threshold, true)
> +SHADOW_FIELD_RW(GUEST_INTERRUPTIBILITY_INFO, guest_interruptibility_info, true)
> +SHADOW_FIELD_RW(VMX_PREEMPTION_TIMER_VALUE, vmx_preemption_timer_value, cpu_has_vmx_preemption_timer())
>  
>  /* Natural width */
> -SHADOW_FIELD_RO(EXIT_QUALIFICATION, exit_qualification)
> -SHADOW_FIELD_RO(GUEST_LINEAR_ADDRESS, guest_linear_address)
> -SHADOW_FIELD_RW(GUEST_RIP, guest_rip)
> -SHADOW_FIELD_RW(GUEST_RSP, guest_rsp)
> -SHADOW_FIELD_RW(GUEST_CR0, guest_cr0)
> -SHADOW_FIELD_RW(GUEST_CR3, guest_cr3)
> -SHADOW_FIELD_RW(GUEST_CR4, guest_cr4)
> -SHADOW_FIELD_RW(GUEST_RFLAGS, guest_rflags)
> -SHADOW_FIELD_RW(CR0_GUEST_HOST_MASK, cr0_guest_host_mask)
> -SHADOW_FIELD_RW(CR0_READ_SHADOW, cr0_read_shadow)
> -SHADOW_FIELD_RW(CR4_READ_SHADOW, cr4_read_shadow)
> -SHADOW_FIELD_RW(HOST_FS_BASE, host_fs_base)
> -SHADOW_FIELD_RW(HOST_GS_BASE, host_gs_base)
> +SHADOW_FIELD_RO(EXIT_QUALIFICATION, exit_qualification, true)
> +SHADOW_FIELD_RO(GUEST_LINEAR_ADDRESS, guest_linear_address, true)
> +SHADOW_FIELD_RW(GUEST_RIP, guest_rip, true)
> +SHADOW_FIELD_RW(GUEST_RSP, guest_rsp, true)
> +SHADOW_FIELD_RW(GUEST_CR0, guest_cr0, true)
> +SHADOW_FIELD_RW(GUEST_CR3, guest_cr3, true)
> +SHADOW_FIELD_RW(GUEST_CR4, guest_cr4, true)
> +SHADOW_FIELD_RW(GUEST_RFLAGS, guest_rflags, true)
> +SHADOW_FIELD_RW(CR0_GUEST_HOST_MASK, cr0_guest_host_mask, true)
> +SHADOW_FIELD_RW(CR0_READ_SHADOW, cr0_read_shadow, true)
> +SHADOW_FIELD_RW(CR4_READ_SHADOW, cr4_read_shadow, true)
> +SHADOW_FIELD_RW(HOST_FS_BASE, host_fs_base, true)
> +SHADOW_FIELD_RW(HOST_GS_BASE, host_gs_base, true)
>  
>  /* 64-bit */
> -SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS, guest_physical_address)
> -SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS_HIGH, guest_physical_address)
> +SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS, guest_physical_address, true)
> +SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS_HIGH, guest_physical_address, true)

This is not a net postive for readability or maintability.  I don't hate the
idea, it just needs MOAR MACROs :-)  E.g. add a layer for the common case where
the field unconditionally exists.

#ifndef __SHADOW_FIELD_RO
#define __SHADOW_FIELD_RO(x, y, c)
#endif
#ifndef __SHADOW_FIELD_RW
#define __SHADOW_FIELD_RW(x, y, c)
#endif

#define SHADOW_FIELD_RO(x, y) __SHADOW_FIELD_RO(x, y, true)
#define SHADOW_FIELD_RW(x, y) __SHADOW_FIELD_RW(x, y, true)

