Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D9480E69
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 02:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbhL2BEq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Dec 2021 20:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbhL2BEp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Dec 2021 20:04:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CDFC061401
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Dec 2021 17:04:45 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id iy13so17176843pjb.5
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Dec 2021 17:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RLUvpUldajX/uD1hF4CF9MP1nePIdmqOD0SE6y2fK84=;
        b=ZAJQUiNgwa7h6tf1b5DH8PL5DwiQB1uiDF6VCT2xJ937ktLUHqlZMr1OrGN3yMHHy7
         zNavcz5GkHXyE+iyX/2f/QlTZJbm+e6knE075WVt+g3fQhfnsQh7evH8DVkMxMZcbGwl
         zuJuofe1ImCJuz0y0/15qY6DYdvZyYQzlY1ed0INydoLp5SyFkQJ/Rxb2ZodcYeytW2b
         EDrJb0m8WuxfIJvxsUu2RyPvkfLnw6yaLAqV3jMJ/zKucENjt5XxXV9DqfaD8HGjBw/M
         4NbLbAiunbr+hKk47MzhyQhe9LU2qw1sjXO4kRPYblqCY/9deHSaLTDmvJaqW225bYAI
         HSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RLUvpUldajX/uD1hF4CF9MP1nePIdmqOD0SE6y2fK84=;
        b=69XVSKsliLlb+5B7JJlikn9wTIidq5XHJXtG9C4F4zmjaJWe93V2KathVY56/Rlo8m
         z1elAbIrZHUE/0I5NH/sv7xn5EAScLAuPVJRg/XOTxYeDFtYGQzQNy2FMTR2PYkOjuzw
         NDus3ykb4oxR670ddRdH+CG3im3lmyHZtBpCoGTIPpDduiHEdzQPnBAxhN4FCmPJhwM/
         Us7zbJFM0VsxFlGAJYBk7mVNDgndvn8yzWaKAEXFFj2Hekmpaphpe7qJDUNzKAURrv9/
         nxuis28c9109ngD+4/gD2QabFi8Kepq67BmVfJ9zSXjaM635WM40veayW4MuOvWfE89L
         JnPQ==
X-Gm-Message-State: AOAM531ZrkbbrdXStFNbf+QErqQm5APeVMfoKcdL4EuEMeYlERzDY+cc
        1heYIWkGlEBmGIR/6Osd0K9pVA==
X-Google-Smtp-Source: ABdhPJxqI/tGgRuoxNXf1qM/sP5Q59qSN4lnMoNghPBa9dHEqeb9RCXuW33Z11sDTzhasWq1HxOiBQ==
X-Received: by 2002:a17:902:7ed0:b0:149:663a:13d5 with SMTP id p16-20020a1709027ed000b00149663a13d5mr19181930plb.102.1640739884890;
        Tue, 28 Dec 2021 17:04:44 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n64sm6454137pfn.49.2021.12.28.17.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 17:04:44 -0800 (PST)
Date:   Wed, 29 Dec 2021 01:04:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jing Liu <jing2.liu@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, guang.zeng@intel.com,
        wei.w.wang@intel.com, yang.zhong@intel.com
Subject: Re: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Message-ID: <Ycu0KVq9PfuygKKx@google.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-23-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222124052.644626-23-jing2.liu@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 22, 2021, Jing Liu wrote:
> @@ -1968,6 +1969,9 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_IA32_XFD:
>  		ret = kvm_set_msr_common(vcpu, msr_info);
>  		if (!ret && data) {
> +			vmx_disable_intercept_for_msr(vcpu, MSR_IA32_XFD, MSR_TYPE_RW);
> +			vcpu->arch.xfd_out_of_sync = true;

xfd_out_of_sync is a poor name, as XFD _may_ be out of sync, or it may not.  It's
also confusing that it's kept set after XFD is explicitly synchronized in
vcpu_enter_guest().

> +
>  			vcpu->arch.trap_nm = true;
>  			vmx_update_exception_bitmap(vcpu);

Ah, this is why #NM interception was made sticky many patches ago.  More at the end.

>  		}
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index bf9d3051cd6c..0a00242a91e7 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -340,7 +340,7 @@ struct vcpu_vmx {
>  	struct lbr_desc lbr_desc;
>  
>  	/* Save desired MSR intercept (read: pass-through) state */
> -#define MAX_POSSIBLE_PASSTHROUGH_MSRS	14
> +#define MAX_POSSIBLE_PASSTHROUGH_MSRS	15
>  	struct {
>  		DECLARE_BITMAP(read, MAX_POSSIBLE_PASSTHROUGH_MSRS);
>  		DECLARE_BITMAP(write, MAX_POSSIBLE_PASSTHROUGH_MSRS);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 3b756ff13103..10a08aa2aa45 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10024,6 +10024,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	if (vcpu->arch.guest_fpu.xfd_err)
>  		wrmsrl(MSR_IA32_XFD_ERR, 0);
>  
> +	if (vcpu->arch.xfd_out_of_sync)

Rather than adding a flag that tracks whether or not the MSR can be written by
the guest, can't this be:

	if (!vmx_test_msr_bitmap_write(vcpu->loaded_vmcs->msr_bitmap))
		fpu_sync_guest_vmexit_xfd_state();

That might be marginally slower than checking a dedicated flag?  But is has the
advantage of doing the correct thing for nested guests instead of penalizing them
with an unnecessary sync on every exit.  If performance of the check is an issue,
we could add a static key to skip the code unless at least one vCPU has triggered
the XFD crud, a la kvm_has_noapic_vcpu (which may or may not provide any real
performance benefits).

Speaking of nested, interception of #NM in vmx_update_exception_bitmap() is wrong
with respect to nested guests.  Until XFD is supported for L2, which I didn't see
in this series, #NM should not be intercepted while L2 is running.

For the earlier patch that introduced arch.trap_nm, if it's not too gross and not
racy, the code could be:

	if (is_guest_mode(vcpu))
		eb |= get_vmcs12(vcpu)->exception_bitmap;
        else {
		...

		if (vcpu->arch.guest_fpu.fpstate.xfd)
			eb |= (1u << NM_VECTOR);
	}

Though I'm ok with a semi-temporary flag if that's gross/racy.

Then this patch can change it to:

	if (is_guest_mode(vcpu))
		eb |= get_vmcs12(vcpu)->exception_bitmap;
        else {
		...

		if (!vmx_test_msr_bitmap_write(vcpu->vmcs01.msr_bitmap))
			eb |= (1u << NM_VECTOR);
	}

> +		fpu_sync_guest_vmexit_xfd_state();
> +
>  	/*
>  	 * Consume any pending interrupts, including the possible source of
>  	 * VM-Exit on SVM and any ticks that occur between VM-Exit and now.
> -- 
> 2.27.0
> 
