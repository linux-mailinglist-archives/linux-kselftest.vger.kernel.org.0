Return-Path: <linux-kselftest+bounces-43271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A88ABE11FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 02:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 323434E29EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 00:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A878F188000;
	Thu, 16 Oct 2025 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CgOUAEuQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A1138DDB
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760575215; cv=none; b=ChHHZfE1HWlB+uF64Ryz8dVLB935+hGCE8+9WZEbP1/+LdfiWJtgufDCyiNr0hRwe8k9D/Nd5vzWMLRyL0uixnOkwEp7Kfju261M+Lkznumr9kvzgGZ5oCI6l26Gm/ME/YnuXyAx1OSK2cOiA2DHYfi1q/zcu4AAnHXdl4sdGvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760575215; c=relaxed/simple;
	bh=7vY9PzWr/yiLC8CW0M2fmrsK2IW0Vzer5uITSO+BXpo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mA3DjWY3NZEehryF/WWuqq4sc36kdfLKmjUQMjH5MfGR8gOmiVaZd1bTb6RboIhB0bkHwqbG8JzSur6yxQDYmEmm5aMfq3dKNdcExMJ0xOMGOdj64RqqF5bI06l53gUPYCluJb+w29q80JIwZNW01ZF8279b0Asuz1gGphgSDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CgOUAEuQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befc5bso287727a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 17:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760575213; x=1761180013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3dNlCURooSIJX80Bj3EYkA9QRwRQzSg6kTNlO7f/Gn4=;
        b=CgOUAEuQazcDZPeyqs2s5ACE9C6Y0AJJPmwpGYGC/76AgNkRfLmc9ar7aHVrfFHQ5l
         BbNimUVOtLVJ5uhKaIiJ4j4nqJsCLBubYpnvqli/eQ+HV9NMQ/MOCAPZellBnP3mYVrx
         X/sHoKHWdZ0jrmZ+fDH0RKaDdA0c576nUzSVsGySo2r4+dXYGCSQqGNp+hiZM4iB986+
         1JUTivF7jKYLig8KuQfrENpabOaJTfjAQOWAIJArPii3F7ZFtKrsDtnpLHtoNdHakwIp
         AYzAFMkXD3cnOWm6vFvdxG1AztNU4PnezoSEM2Q0MLZJ6SYDW2IQzT9gVwCrn8Mecy66
         Op4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760575213; x=1761180013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dNlCURooSIJX80Bj3EYkA9QRwRQzSg6kTNlO7f/Gn4=;
        b=MJku28OJREDRrbUHB7azhLNy4EEC454q3Z8adtlPk7vqh72dDWTjLedWxceZXOxXtX
         OO/jj7Z2JXJzdqf2igVduDLbQ5FttgmrrmyCNSLZ37RMIbZcnSVmd0HJqLPCGIYq5Urm
         kjL3ewbT1KYFogq1B+F9BBs5KQk8fGuszEVYItWnP8UKniR5V2Vt5/ASJ8ceVAyxaYx7
         sdaDfLWbzZGK6V4udszND+yLbAoW1xvkx1ZjjjuL4JnBVL5+Gb5oKbh6lC8q4Qk5Eq54
         0DI3x5YSqs4HYtJ9lGeTfOYVS58Bq9ovCi6VmfvhB8m+bXigyaQj8Rs6pE17E7RVd+Nv
         1+mg==
X-Forwarded-Encrypted: i=1; AJvYcCWQbVfKkGpotMy/apmVxl3M0ihdBRyb62on3yNxj/GgFAWx5dhhTiaGfqO8e2Na0smsHWNr1mZm2CikP86kobU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+gShFfP3ZgYg2Xp9CES0SWAnVzTVj6hBKsIbFILo9scqjfgw
	kw+dH3gekhdNRUuuPmVckiDFcHR5goegY+vbRbZZk/RMAN8k7GKhByZLGYdoyVCghqPLKNzie0A
	657HlKA==
X-Google-Smtp-Source: AGHT+IHfPvjhnedJTgg6CAxnlq4B1q8xkwPd3n+ogO/h0bax4t2Y4qg32T1rBL73rr/Fp9d7GqAYfHy1jZw=
X-Received: from pjbrv22.prod.google.com ([2002:a17:90b:2c16:b0:329:6ac4:ea2e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2412:b0:33b:ade7:51d3
 with SMTP id 98e67ed59e1d1-33bade7553bmr476752a91.20.1760575213249; Wed, 15
 Oct 2025 17:40:13 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:40:11 -0700
In-Reply-To: <aPAnWWmo555uB0-H@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917215031.2567566-1-jmattson@google.com> <20250917215031.2567566-4-jmattson@google.com>
 <aPAnWWmo555uB0-H@google.com>
Message-ID: <aPA-60vV0WQUCmc2@google.com>
Subject: Re: [PATCH 3/4] KVM: selftests: Add VM_MODE_PXXV57_4K VM mode
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	"Pratik R. Sampat" <prsampat@amd.com>, Kai Huang <kai.huang@intel.com>, 
	Eric Auger <eric.auger@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 15, 2025, Sean Christopherson wrote:
> On Wed, Sep 17, 2025, Jim Mattson wrote:
> > Add a new VM mode, VM_MODE_PXXV57_4K, to support tests that require
> > 5-level paging on x86. This mode sets up a 57-bit virtual address
> > space and sets CR4.LA57 in the guest.

Thinking about this more, unless it's _really_ painful, e.g. because tests assume
4-level paging or 48-bit non-canonical address, I would rather turn VM_MODE_PXXV48_4K
into VM_MODE_PXXVXX_4K and have ____vm_create() create the "maximal" VM.  That
way tests don't need to go out of their way just to use 5-level paging, e.g. a
"TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_LA57))" is all that is needed.  It will also
gives quite a bit of coverage for free, e.g. that save/restore works with and
without 5-level paging (contrived example, but you get the point).

The NONCANONICAL #define works for LA57, so hopefully making tests play nice with
LA57 is straightforward?

> > @@ -358,6 +360,25 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
> >  		vm->va_bits = 48;
> >  #else
> >  		TEST_FAIL("VM_MODE_PXXV48_4K not supported on non-x86 platforms");
> > +#endif
> > +		break;
> > +	case VM_MODE_PXXV57_4K:
> > +#ifdef __x86_64__
> > +		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
> > +		kvm_init_vm_address_properties(vm);
> > +		/*
> > +		 * For 5-level paging, KVM requires LA57 to be enabled, which
> > +		 * requires a 57-bit virtual address space.
> > +		 */
> > +		TEST_ASSERT(vm->va_bits == 57,
> > +			    "Linear address width (%d bits) not supported for VM_MODE_PXXV57_4K",
> > +			    vm->va_bits);
> > +		pr_debug("Guest physical address width detected: %d\n",
> > +			 vm->pa_bits);
> > +		vm->pgtable_levels = 5;
> > +		vm->va_bits = 57;
> > +#else
> > +		TEST_FAIL("VM_MODE_PXXV57_4K not supported on non-x86 platforms");
> >  #endif
> 
> That's a lot of copy+paste, especially given the #ifdefs.  How about this (untested)?
> 
> 	case VM_MODE_PXXV48_4K:
> 	case VM_MODE_PXXV57_4K:
> #ifdef __x86_64__
> 		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
> 		kvm_init_vm_address_properties(vm);
> 
> 		/*
> 		 * Ignore KVM support for 5-level paging (vm->va_bits == 57) if
> 		 * the target mode is 4-level paging (48-bit virtual address
> 		 * space), as 5-level paging only takes effect if CR4.LA57=1.
> 		 */
> 		TEST_ASSERT(vm->va_bits == 57 ||
> 			    (vm->va_bits == 48 && vm->mode == VM_MODE_PXXV48_4K),
> 			    "Linear address width (%d bits) not supported",
> 			    vm->va_bits);
> 		pr_debug("Guest physical address width detected: %d\n",
> 			 vm->pa_bits);
> 		if (vm->mode == VM_MODE_PXXV48_4K) {
> 			vm->pgtable_levels = 4;
> 			vm->va_bits = 48;
> 		} else {
> 			vm->pgtable_levels = 5;
> 			vm->va_bits = 57;
> 		}
> #else
> 		TEST_FAIL("VM_MODE_PXXV{48,57}_4K not supported on non-x86 platforms");
> #endif
> 		break;

