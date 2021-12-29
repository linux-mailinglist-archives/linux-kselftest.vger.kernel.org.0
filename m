Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B4A480E45
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 01:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbhL2Aii (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Dec 2021 19:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbhL2Aih (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Dec 2021 19:38:37 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDBAC06173E
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Dec 2021 16:38:36 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id l16so2591681plg.10
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Dec 2021 16:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hjUAN9+iAYchoekHcAxgltTkGjYeMuzObvv9td4+9a4=;
        b=C+GxiYcVqyCWYFi9nIBdcAjF5+71YdP+ddRsA4ncIdJ+2un/4sai3g+KS2Qs93clRx
         941Bg8yzaXMHrVBE/brgwXy6fKRjpKWHD9oomOCPvmO278PTUViUIQc6Uq5EPSz6JFVA
         4umrBnTGni6cHaybpagiMTbiL/aWQ3/zpc9a50p+wJuBWV7UA+zVxENyCdTtNuE+lYCt
         t8FUkDx3+VlDJfPw5CoppaOsA6vOjg6SEdh60X6+P4/zcex0fwf57eTLymwRRhWFGBlU
         rTkfWrMHXAAYgoJMQKy3vujnOjDQwJXqV8jWYi8smuvhhKDvdG72dcInT4J5lUIfAPYQ
         c+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hjUAN9+iAYchoekHcAxgltTkGjYeMuzObvv9td4+9a4=;
        b=x4hrw0wmifLUii4rmbiveEkrED8gigopCidM7AKyCG8SIAApilBsfcO+djIGETF7aQ
         bLTxjiRdf9dQQ9eM7EjSKO5M/By6FMbUjfc9zlfNcYZ+PbyhzObsCA/O5L4pvvrM1WzB
         GBso1+yTm7+nzTc4k27AcmGcFpbevjhN7Mx8UDGEZWWC2WivbrAW/kQKjd2sGUaiN7RD
         EeN8+ywvzIHMDTvmT7cITfJh3w+GhW91I+votDvFYKZ9zrR8T5q+WU4pTKgVkg4O4JgP
         0kG0xqkFhBbj3dPvpV2JWUW9gBak5g7/gZtwyiz8Y3mnAaMmq7EuZlOgTxiP1bhFjkYj
         CZ3w==
X-Gm-Message-State: AOAM530YaA/RPm4KyoIcVL5o4u+bSOve5mOfq1gaFPh19l8ajrJVe+C/
        GwbcI/13yzVqCj/bzX6vc6y7tw==
X-Google-Smtp-Source: ABdhPJzyxzL1SmeyMHBKiG3Hok/7s0LwyPr5oMw7ZZmLDNjluQeMElELTXAK75NFNqjmZtHM6KzE6w==
X-Received: by 2002:a17:903:41c5:b0:148:a658:8d33 with SMTP id u5-20020a17090341c500b00148a6588d33mr24150162ple.153.1640738316228;
        Tue, 28 Dec 2021 16:38:36 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p1sm13586433pgj.46.2021.12.28.16.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 16:38:35 -0800 (PST)
Date:   Wed, 29 Dec 2021 00:38:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jing Liu <jing2.liu@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, guang.zeng@intel.com,
        wei.w.wang@intel.com, yang.zhong@intel.com
Subject: Re: [PATCH v3 19/22] kvm: x86: Get/set expanded xstate buffer
Message-ID: <YcuuCMCQryzUFoAZ@google.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-20-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222124052.644626-20-jing2.liu@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shortlog needs to have a verb somewhere.

On Wed, Dec 22, 2021, Jing Liu wrote:
> From: Guang Zeng <guang.zeng@intel.com>
> 
> When AMX is enabled it requires a larger xstate buffer than
> the legacy hardcoded 4KB one. Exising kvm ioctls

Existing

> (KVM_[G|S]ET_XSAVE under KVM_CAP_XSAVE) are not suitable for
> this purpose.

...

> Reuse KVM_SET_XSAVE for both old/new formats by reimplementing it to
> do properly-sized memdup_user() based on the guest fpu container.

I'm confused, the first sentence says KVM_SET_XSAVE isn't suitable, the second
says it can be reused with minimal effort.

> Also, update the api doc with the new KVM_GET_XSAVE2 ioctl.

...

> @@ -5367,7 +5382,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		break;
>  	}
>  	case KVM_SET_XSAVE: {
> -		u.xsave = memdup_user(argp, sizeof(*u.xsave));
> +		int size = vcpu->arch.guest_fpu.uabi_size;

IIUC, reusing KVM_SET_XSAVE works by requiring that userspace use KVM_GET_XSAVE2
if userspace has expanded the guest FPU size by exposing relevant features to
the guest via guest CPUID.  If so, then that needs to be enforced in KVM_GET_XSAVE,
otherwise userspace will get subtle corruption by invoking the wrong ioctl, e.g.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2c9606380bca..5d2acbd52df5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5386,6 +5386,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
                break;
        }
        case KVM_GET_XSAVE: {
+               r -EINVAL;
+               if (vcpu->arch.guest_fpu.uabi_size > sizeof(struct kvm_xsave))
+                       break;
+
                u.xsave = kzalloc(sizeof(struct kvm_xsave), GFP_KERNEL_ACCOUNT);
                r = -ENOMEM;
                if (!u.xsave)

> +
> +		u.xsave = memdup_user(argp, size);
>  		if (IS_ERR(u.xsave)) {
>  			r = PTR_ERR(u.xsave);
>  			goto out_nofree;
> @@ -5376,6 +5393,26 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = kvm_vcpu_ioctl_x86_set_xsave(vcpu, u.xsave);
>  		break;
>  	}
> +
> +	case KVM_GET_XSAVE2: {
> +		int size = vcpu->arch.guest_fpu.uabi_size;
> +
> +		u.xsave = kzalloc(size, GFP_KERNEL_ACCOUNT);
> +		if (!u.xsave) {
> +			r = -ENOMEM;

I hate the odd patterns in this code as much as anyone, but for better or worse
the style throughout is:

		r = -ENOMEM;
		u.xsave = kzalloc(size, GFP_KERNEL_ACCOUNT);
		if (u.xsave)
			break;

> +			break;
> +		}
> +
> +		kvm_vcpu_ioctl_x86_get_xsave2(vcpu, u.buffer, size);
> +
> +		if (copy_to_user(argp, u.xsave, size)) {
> +			r = -EFAULT;
> +			break;

Same style thing here.

> +		}
> +		r = 0;
> +		break;
> +	}
> +
>  	case KVM_GET_XCRS: {
>  		u.xcrs = kzalloc(sizeof(struct kvm_xcrs), GFP_KERNEL_ACCOUNT);
>  		r = -ENOMEM;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 1daa45268de2..9d1c01669560 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1131,6 +1131,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
>  #define KVM_CAP_ARM_MTE 205
>  #define KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM 206
> +#define KVM_CAP_XSAVE2 207
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> @@ -1610,6 +1611,9 @@ struct kvm_enc_region {
>  #define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
>  #define KVM_S390_CLEAR_RESET	_IO(KVMIO,   0xc4)
>  
> +/* Available with KVM_CAP_XSAVE2 */
> +#define KVM_GET_XSAVE2		  _IOR(KVMIO,  0xcf, struct kvm_xsave)
> +
>  struct kvm_s390_pv_sec_parm {
>  	__u64 origin;
>  	__u64 length;
> -- 
> 2.27.0
> 
