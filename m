Return-Path: <linux-kselftest+bounces-15231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52755950913
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 17:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844D11C2260A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F14C1A01CD;
	Tue, 13 Aug 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2w2yaZH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AA1A01B3
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562865; cv=none; b=Ks4+i/DEwtu0rmi4ur4QAugQTUAFOSst+HLjc/R15ua9pEZJ8/Eul/WZSIBeTERDOLTYhSd/KFE/1THQIcy6trLUTY6SF5U5OQR7WFNf3VdcXJZgUbhhxRcsALUTdZ2qSlc86621PFNz7yTiSnHmOflkNMHcZsuuTjmN+WwHxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562865; c=relaxed/simple;
	bh=9iTZYX0IOdViDbeJkPHjoGuAtLhEKo08YiRbSxrLWqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KBuhyWjJDhrCbSrS5zkeneAKLcuhTKYDqe0gBznw84IcnlPm6C407AVQ+p/RT3qG6ocC4ngT+1HvbZUtJwmU616xKAfhgatAwXXlXvJX8yHVNbDjHJyweC1LodkJufqFEPiFoAqZ3pBCyT1SDK6NqnD6seaY/C7TpezRjtNP52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2w2yaZH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64b70c4a269so114658757b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723562862; x=1724167662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YgS/CxIk8degf9Ujhn4Jhee8VQkdqlo8w99w+08tpPY=;
        b=a2w2yaZHMmLpQP8kQxh1tQm4t02IZjobXzjA2xjIeMLYKyAxYcBE+XL/WC4k9hiTR3
         56jwEhnRKsdicoFO9LxjdulJPDOKk4TE2V8B45YhN/NQdkH5tJgPC36PrCX+GqzPRnx0
         6Axp1Og8bl1CGZ9VNAt8qYWjIdDuQL44MY6nWIDEsva3cqxamYuw6l8sV5bcj6DGDVpI
         oPzxixDDij4OlHepWfX+RT1F6H03Ooqgd824lmcMVaTeP3OBw0ZfK09bIhmI2suvuuxV
         9P1mxcsH8xumbm0r2uFycNc9owKUvDg9ti58wLBzX5MDqfYABFuebQxYBHTgG9Lrf3+T
         1Uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562862; x=1724167662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgS/CxIk8degf9Ujhn4Jhee8VQkdqlo8w99w+08tpPY=;
        b=PomQM4O+DxY1S2MwUIeEwxx58CfBXUO2V78XNGs86US4y/+LLWuNb+eV1Lu00Z1UXJ
         5yoNgy9pGNp99BhsQ9kYVDOo32Wk/6U2pp5KUw0HYr9a8KEKfjfBhxydLy55OaydxdnY
         8C6bRr62y3IvAXizN6h24+yYwwrmfSJlrqEkrZ0BSUYmr5c13ASuzx6npAE6aws6TUwv
         ZJ2pa2ys5OEWYyRMuLzeTJZt4UZCkYNlWcMnbs1HhbrHGmkNPkTPFALCJFiCAwoSpHJR
         dirO9ZExJ8/5JZecqrYnPsz6SeJkO2GCS5xw8aZui3Gf6PabwZl43dPZS1aD3i5bGZEo
         TjMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqp9ROO4pPkCaZXv1aVY8d/aFm321CME8kpH28noGByLuOmHdiE0KoB6m9itobNxodzStoTY041Czr0clFb0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFoavHVmFbMQ49a+iC0sd+fNhWfS1xZ5N0V0MVFdat6A1/lWD
	qxMb9XEjYW8Xixp5afsNKDbXEp66v4d1jrxHxlTuZhEr+bnASRqxk7b12vPMvfvQehdG/nDDUst
	6eQ==
X-Google-Smtp-Source: AGHT+IGN0g/iWJrWmwNOf6QYh3EnGuzEizz0+U/tevvxu9l/FVCnp8wtI05EYtrERSQOTEdtYRcJIz2Rvno=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:fc03:0:b0:64b:5dc3:e4fe with SMTP id
 00721157ae682-6a97151ca3cmr1036657b3.1.1723562862655; Tue, 13 Aug 2024
 08:27:42 -0700 (PDT)
Date: Tue, 13 Aug 2024 08:27:41 -0700
In-Reply-To: <5b32da03-addf-4f34-bcf4-76fbe420b8f5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
 <20240710220540.188239-3-pratikrajesh.sampat@amd.com> <ZrY4e39Q2_WxhrkI@google.com>
 <5b32da03-addf-4f34-bcf4-76fbe420b8f5@amd.com>
Message-ID: <Zrt7bRGQJ1C9XZGy@google.com>
Subject: Re: [RFC 2/5] selftests: KVM: Decouple SEV ioctls from asserts
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, shuah@kernel.org, thomas.lendacky@amd.com, 
	michael.roth@amd.com, pbonzini@redhat.com, pgonda@google.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 13, 2024, Pratik R. Sampat wrote:
> On 8/9/2024 10:40 AM, Sean Christopherson wrote:
> > On Wed, Jul 10, 2024, Pratik R. Sampat wrote:
> >> @@ -98,7 +100,7 @@ static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
> >>  	vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
> >>  }
> >>  
> >> -static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
> >> +static inline int snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
> >>  					   uint64_t size, uint8_t type)
> >>  {
> >>  	struct kvm_sev_snp_launch_update update_data = {
> >> @@ -108,10 +110,10 @@ static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
> >>  		.type = type,
> >>  	};
> >>  
> >> -	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
> >> +	return __vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
> > 
> > Don't introduce APIs and then immediately rewrite all of the users.  If you want
> > to rework similar APIs, do the rework, then add the new APIs.  Doing things in
> > this order adds a pile of pointless churn.
> > 
> > But that's a moot point, because it's far easier to just add __snp_launch_update_data().
> > And if you look through other APIs in kvm_util.h, you'll see that the strong
> > preference is to let vm_ioctl(), or in this case vm_sev_ioctl(), do the heavy
> > lifting.  Yeah, it requires copy+pasting marshalling parameters into the struct,
> > but that's relatively uninteresting code, _and_ piggybacking the "good" version
> > means you can't do things like pass in a garbage virtual address (because the
> > "good" version always guarantees a good virtual address).
> 
> I am a little confused by this.
> 
> Are you suggesting that I leave the original functions intact with using
> vm_sev_ioctl() and have an additional variant such as
> __snp_launch_update_data() which calls into __vm_sev_ioctl() to decouple
> the ioctl from the assert for negative asserts?

Yes, this one.

> Or, do you suggest that I alter vm_sev_ioctl() to handle both positive
> and negative asserts?
> 
> Thanks!
> -Pratik
> 

