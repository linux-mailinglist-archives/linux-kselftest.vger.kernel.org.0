Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19961481567
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 17:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbhL2QzU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 11:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240963AbhL2QzT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 11:55:19 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AB2C06173F
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Dec 2021 08:55:19 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 7so6324249pgn.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Dec 2021 08:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9E7FQ5pJl/0kU2mdKrZHXW9V28GhR+dlDYye/RF2eb8=;
        b=I2JbWDGrUUngetv4wnjWKzX+2VBf0mXJW4OAMAZaywq39mB15YmYJSFZsasJFQphdT
         OH5KZca2SwBa2SWWvqeshigcVj4zr6NjUn+A9aw1O3pTr6V48n26aDszseuNytggDE2D
         AzRBTlUBQwFKHzpdQog8j/af5XenNuTBpHTvwZcTirj1bw6MTE0MEuVMjfPStB3Lvnw+
         C5lVla6dSDxEK1OfhXvm5om4opW++tQUZ0FygJtgRtW7nRmwzE2/2s2cESGDYY/ItRJm
         Q/87IPDuYXZmTg0YoMCo8inob31v0eAAghz4gPFI3CLPSOgiS9YleESPIbvkpi69n7bb
         PeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9E7FQ5pJl/0kU2mdKrZHXW9V28GhR+dlDYye/RF2eb8=;
        b=0ezlFLBNdNzapZ9YRR25Husp+rNaHQQtWPtQb7+2tProFbaNCM+5fDk7clB59mHkCd
         N+ZDNqb+ylPT5VpfXE4RilSZfS3HzoY27x/xID3nCly5wp5HFs8h4YMFS9MRpvhF2roc
         XeT1MI/bF4x7c2r671J0c1+NOUdexnZOUghHXKehYz09K5eS4x7nGbdai7iigmIn+7GO
         9dE351EVzMvH5ccCnXT+HhBfVJrGlJrHzfFLjUiRFF33DN+TIjWwPDK+72PxuQRcjma0
         DpV7mtGk9jg3Qv80/OgR/p/SXM62KzgKJci1UCHiMQ5RDH9I2t7FUDfB/8hmxgYJ1b21
         v7rQ==
X-Gm-Message-State: AOAM5314JGZnPuM/cLlMXXIsnZ9cN5Iz//1IZwAxTObodYT95dWRGGs0
        97QpCvEqmSyuzzBCND/NGNWGFw==
X-Google-Smtp-Source: ABdhPJzlgn6bllr4ivr30M22qVwS6kDwa0ZQZvBQWsA1/zseUcIF+o9gXta/SctPyC8G0xXlsvSwoQ==
X-Received: by 2002:a63:3d4b:: with SMTP id k72mr13943356pga.564.1640796918825;
        Wed, 29 Dec 2021 08:55:18 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w9sm20241293pge.18.2021.12.29.08.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 08:55:18 -0800 (PST)
Date:   Wed, 29 Dec 2021 16:55:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Zhong <yang.zhong@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH v4 08/21] kvm: x86: Check and enable permitted dynamic
 xfeatures at KVM_SET_CPUID2
Message-ID: <YcyS8lG7vq+jJtLy@google.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
 <20211229131328.12283-9-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229131328.12283-9-yang.zhong@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 29, 2021, Yang Zhong wrote:
> From: Jing Liu <jing2.liu@intel.com>
> 
> Guest xstate permissions should be set by userspace VMM before vcpu
> creation. Extend KVM_SET_CPUID2 to verify that every feature reported
> in CPUID[0xD] has proper permission set. If permission allows, enable
> all xfeatures in guest cpuid with fpstate buffer sized accordingly.
> 
> This avoids introducing new KVM exit reason for reporting permission
> violation to userspace VMM at run-time and also removes the need of
> tricky fpstate buffer expansion in the emulation and restore path of
> XCR0 and IA32_XFD MSR.

How so?  __do_cpuid_func() restricts what is advertised to userspace based on
xstate_get_guest_group_perm(), so it's not like KVM is advertising something it
can't provide?  There should never be any danger to KVM that's mitigated by
restricing guest CPUID because KVM can and should check vcpu->arch.guest_fpu.perm
instead of guest CPUID.

In other words, I believe you're conflating the overall approach of requiring
userspace to pre-acquire the necessary permissions with enforcing what userspace
advertises to the guest.

> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 62 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 4855344091b8..acbc10db550e 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -81,9 +81,12 @@ static inline struct kvm_cpuid_entry2 *cpuid_entry2_find(
>  	return NULL;
>  }
>  
> -static int kvm_check_cpuid(struct kvm_cpuid_entry2 *entries, int nent)
> +static int kvm_check_cpuid(struct kvm_vcpu *vcpu,
> +			   struct kvm_cpuid_entry2 *entries,
> +			   int nent)
>  {
>  	struct kvm_cpuid_entry2 *best;
> +	int r = 0;
>  
>  	/*
>  	 * The existing code assumes virtual address is 48-bit or 57-bit in the
> @@ -93,11 +96,40 @@ static int kvm_check_cpuid(struct kvm_cpuid_entry2 *entries, int nent)
>  	if (best) {
>  		int vaddr_bits = (best->eax & 0xff00) >> 8;
>  
> -		if (vaddr_bits != 48 && vaddr_bits != 57 && vaddr_bits != 0)
> -			return -EINVAL;
> +		if (vaddr_bits != 48 && vaddr_bits != 57 && vaddr_bits != 0) {
> +			r = -EINVAL;
> +			goto out;

Please don't change this to a goto, a return is perfectly ok and more readable
as it doesn't imply there's some functional change that needs to be unwound at
the end.

> +		}
>  	}
>  
> -	return 0;
> +	/*
> +	 * Check guest permissions for dynamically-enabled xfeatures.
> +	 * Userspace VMM is expected to acquire permission before vCPU
> +	 * creation. If permission allows, enable all xfeatures with
> +	 * fpstate buffer sized accordingly. This avoids complexity of
> +	 * run-time expansion in the emulation and restore path of XCR0
> +	 * and IA32_XFD MSR.
> +	 */
> +	best = cpuid_entry2_find(entries, nent, 0xd, 0);
> +	if (best) {
> +		u64 xfeatures;
> +
> +		xfeatures = best->eax | ((u64)best->edx << 32);
> +		if (xfeatures & ~vcpu->arch.guest_fpu.perm) {
> +			r = -ENXIO;

ENXIO is a rather odd error code for insufficient permissions, especially since
the FPU returns -EPERM for what is effectively the same check.

> +			goto out;
> +		}
> +
> +		if (xfeatures != vcpu->arch.guest_fpu.xfeatures) {

xfeatures is obviously not consumed anywhere, which is super confusing and
arguably wrong, e.g. if userspace advertises xfeatures that are a subset of
vcpu->arch.guest_fpu.perm, this will expand XSAVE state beyond what userspace
actually wants to advertise to the guest.  The really confusing case would be if
userspace reduced xfeatures relative to vcpu->arch.guest_fpu.xfeatures and got
an -ENOMEM due to the FPU failing to expand the XSAVE size.

I don't care about the waste of memory, and IIUC userspace would have to
intentionally request permissions for the guest that it then ignores, but that
doesn't make the code any less confusing.  And as written, this check also prevents
advertising non-XFD features that are not supported in hardware.  I doubt there's
a production use case for that (though MPX deprecation comes close), but I've
certainly exposed unsupported features to a guest for testing purposes.

Rather than bleed details from the FPU into KVM, why not have the FPU do any and
all checks?  That also gives the FPU access to requested xfeatures so that it
can opportunistically avoid unnecessary expansion.  We can also tweak the kernel
APIs to be more particular about input values.

At that point, I would be ok with fpu_update_guest_perm_features() rejecting
attempts to advertise features that are not permitted, because then it's an FPU
policy, not a KVM policy, and there's a valid reason for said policy.  It's a bit
of a pedantic distinction, but to me it matters because having KVM explicitly
restrict guest CPUID implies that doing so is necessary for KVM correctness, which
AFAICT is not the case.

E.g. in KVM

	/*
	 * Exposing dynamic xfeatures to the guest requires additional enabling
	 * in the FPU, e.g. to expand the guest XSAVE state size.
	 */
	best = cpuid_entry2_find(entries, nent, 0xd, 0);
	if (!best)
		return 0;

	xfeatures = best->eax | ((u64)best->edx << 32);
	xfeatures &= XFEATURE_MASK_USER_DYNAMIC;
	if (!xfeatures)
		return 0;

	return fpu_enable_guest_xfd_features(&vcpu->arch.guest_fpu, xfeatures);

and then

  int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64 xfeatures)
  {
	lockdep_assert_preemption_enabled();

	/* Nothing to do if all requested features are already enabled. */
	xfeatures &= ~guest_fpu->xfeatures;
	if (!xfeatures)
		return 0;

	/* Dynamic xfeatures are not supported with 32-bit kernels. */
	if (!IS_ENABLED(CONFIG_X86_64))
		return -EPERM;

	return __xfd_enable_feature(xfeatures, guest_fpu);
  }

with 

  int __xfd_enable_feature(u64 xfd_err, struct fpu_guest *guest_fpu)
  {
	struct fpu_state_perm *perm;
	unsigned int ksize, usize;
	struct fpu *fpu;

	if (WARN_ON_ONCE(!xfd_err || (xfd_err & ~XFEATURE_MASK_USER_DYNAMIC)))
		return 0;

	...
  }

which addresses several things:

  a) avoids explicitly restricing guest CPUID in KVM, and in particular doesn't
     prevent userspace from advertising non-XFD features that aren't supported in
     hardware, which for better or worse is allowed today.

  b) returns -EPERM instead of '0' when userspace attempts to enable dynamic
     xfeatures with 32-bit kernels, which isn't a bug as posted only because
     KVM pre-checks vcpu->arch.guest_fpu.perm.

  b) avoids reading guest_perm outside of siglock, which was technically a TOCTOU
     "bug", though it didn't put the kernel at risk because __xstate_request_perm()
     doesn't allow reducing permissions.

  c) allows __xfd_enable_feature() to require the caller to provide just XFD
     features

> +			r = fpu_update_guest_perm_features(
> +						&vcpu->arch.guest_fpu);
> +			if (r)
> +				goto out;
> +		}
> +	}
> +
> +out:
> +	return r
