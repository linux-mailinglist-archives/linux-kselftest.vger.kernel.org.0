Return-Path: <linux-kselftest+bounces-15075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A71C994D3C9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 17:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F761C224B9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A17198A39;
	Fri,  9 Aug 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTukblR+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A3198A2F
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218047; cv=none; b=fzGOYzbis8xNCvrjvYlzzHbl5yRNcupGeGS2nmBCaKnakfpLwI4cOlmeKuTqQJ1QT9Po/ottL1Y3L1C6NPIk3ofJeAR6yniqwEvtU9I/M/BgltC2IjSyvhNweI8CFLIUyzrqaEdZDuw2a84J6kylX83x8X1QFb4Ac/BZquRsUeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218047; c=relaxed/simple;
	bh=qYLK/8+7XbwXyc5gcegIRBpIsaI+pvRczdbaYtaSCdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V56Kzqcj0ZYsMMSoZtMyyMc/FtXyGqZHY9V8elz1yCXEKbMLaQGCN6xkb8jjb9roVSc28lCOeG49onvm0EK8X74yU2E4zh8I4jj2dEoLs5i+koNs92gfP8hg4Hq5goyYEbs3f1IEmUnERdpyOrP7ZlUX5Ocd7PxDKp5o2eQY0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rTukblR+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a3c6dd559aso2444966a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2024 08:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723218045; x=1723822845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ErMc17L04Y+frI1FBkQ+3nAwLH6q7Xg4kpfE9NJb3g8=;
        b=rTukblR+lXJim9aJNe/7HYybeb6EyBeiNVE7XKqVlglAFg3q4MmEtTVq2SVUD9UkHT
         9Rc6NiJrfradZSSb7gp9cztf3ZCy9125X8olpgxHccfvc5fNRJgqhDLU7p22Sj4VKs5o
         gIPcZPa83VcdcSWdT1xxKiREIYExuhunQk5pki8qNybKIF61EML+jp6VJKLkVVEVcGD/
         V7PqhthgZjrlPdJW+aA/ydYUHHTia3cYBND6tuyBSM7UvoYgnfUVJpD7DLaYcsSDFOle
         OV3slopw4zhonHNA86AsxS+CEK3FuK7SM+WWPkhCHVC5AbJmF+ETYVDbCvfCZCQad2m3
         pNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723218045; x=1723822845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErMc17L04Y+frI1FBkQ+3nAwLH6q7Xg4kpfE9NJb3g8=;
        b=NqxS8sxTAQzMXEEgTIOjcXSma+EBWa86g3IvCuTQkpfr6jHZs7r2L29hNJxyCfgkAd
         PzL33QFhqoeP5ukzDJ/H1nBnw+fxSSnc7uvK2Wqlaohf//LqfFROGXyndi6jby/WQEkh
         h5YjiFaoaaLNVdqiPjz8lDaRPbp0xRPq6PvCSSiZo4wszAx9LF2RCu2Q+wcj5bCnGz4z
         Pw+rPHw27kxvVejR7S0rr7q34NDrWpGJt52710d3Q9Id8A21m2G0kFXcBkyZZpdI3lQv
         y+qY+TfqGYwOielgj9HUtq4BY6UDX069fDAm+65niuypzSS9/u46cYnbzYQyPp+q57DN
         AR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSMtgjENrgjMLFvE3PNUe8C2Nb1RuKP1/uSJZIBGjlWgPQ57O7B6XmPLMFguY4X4QlB0j/VXwZdzbxz5hTjS7kzXMmJt5OcU1I6Fp53twr
X-Gm-Message-State: AOJu0Yx0U3ATMGOoLz6DBD2tUNVJNXXOLIzBHZfs3G74bKHe0p5QWx8+
	Ec9d7zBgO3o2PAROyP3aTyDY1KYnylhD9DVPiBW5N/ZgyafYzr4jCKv5eOnxNq56PW73+uxUCRd
	Opg==
X-Google-Smtp-Source: AGHT+IGwKw2KKUU7sXggWm9RjiZAHKpy2+WRk1B7z9K2MDWh7RD36JKtkCJ+xCXkC9ifEG/LznRinzDK984=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:66c4:0:b0:78b:4703:17af with SMTP id
 41be03b00d2f7-7c3d2bed86emr3612a12.6.1723218045232; Fri, 09 Aug 2024 08:40:45
 -0700 (PDT)
Date: Fri, 9 Aug 2024 08:40:43 -0700
In-Reply-To: <20240710220540.188239-3-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com> <20240710220540.188239-3-pratikrajesh.sampat@amd.com>
Message-ID: <ZrY4e39Q2_WxhrkI@google.com>
Subject: Re: [RFC 2/5] selftests: KVM: Decouple SEV ioctls from asserts
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, shuah@kernel.org, thomas.lendacky@amd.com, 
	michael.roth@amd.com, pbonzini@redhat.com, pgonda@google.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 10, 2024, Pratik R. Sampat wrote:
> This commit separates the SEV, SEV-ES, SEV-SNP ioctl calls from its

Don't start with "This commit".  Please read Documentation/process/maintainer-kvm-x86.rst,
and by extension, Documentation/process/maintainer-tip.rst.

> positive test asserts. This is done so that negative tests can be
> introduced and both kinds of testing can be performed independently
> using the same base helpers of the ioctl.
> 
> This commit also adds additional parameters such as flags to improve
> testing coverage for the ioctls.
> 
> Cleanups performed with no functional change intended.
> 
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
> ---
>  .../selftests/kvm/include/x86_64/sev.h        |  20 +--
>  tools/testing/selftests/kvm/lib/x86_64/sev.c  | 145 ++++++++++++------
>  2 files changed, 108 insertions(+), 57 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
> index 43b6c52831b2..ef99151e13a7 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/sev.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
> @@ -37,14 +37,16 @@ enum sev_guest_state {
>  #define GHCB_MSR_TERM_REQ	0x100
>  
>  void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
> -void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
> -void sev_vm_launch_finish(struct kvm_vm *vm);
> +int sev_vm_launch_start(struct kvm_vm *vm, uint32_t policy);
> +int sev_vm_launch_update(struct kvm_vm *vm, uint32_t policy);
> +int sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
> +int sev_vm_launch_finish(struct kvm_vm *vm);
>  
>  bool is_kvm_snp_supported(void);
>  
> -void snp_vm_launch(struct kvm_vm *vm, uint32_t policy);
> -void snp_vm_launch_update(struct kvm_vm *vm);
> -void snp_vm_launch_finish(struct kvm_vm *vm);
> +int snp_vm_launch(struct kvm_vm *vm, uint32_t policy, uint8_t flags);
> +int snp_vm_launch_update(struct kvm_vm *vm, uint8_t page_type);
> +int snp_vm_launch_finish(struct kvm_vm *vm, uint16_t flags);
>  
>  struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
>  					   struct kvm_vcpu **cpu);
> @@ -98,7 +100,7 @@ static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
>  	vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
>  }
>  
> -static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
> +static inline int snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>  					   uint64_t size, uint8_t type)
>  {
>  	struct kvm_sev_snp_launch_update update_data = {
> @@ -108,10 +110,10 @@ static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>  		.type = type,
>  	};
>  
> -	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
> +	return __vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);

Don't introduce APIs and then immediately rewrite all of the users.  If you want
to rework similar APIs, do the rework, then add the new APIs.  Doing things in
this order adds a pile of pointless churn.

But that's a moot point, because it's far easier to just add __snp_launch_update_data().
And if you look through other APIs in kvm_util.h, you'll see that the strong
preference is to let vm_ioctl(), or in this case vm_sev_ioctl(), do the heavy
lifting.  Yeah, it requires copy+pasting marshalling parameters into the struct,
but that's relatively uninteresting code, _and_ piggybacking the "good" version
means you can't do things like pass in a garbage virtual address (because the
"good" version always guarantees a good virtual address).

