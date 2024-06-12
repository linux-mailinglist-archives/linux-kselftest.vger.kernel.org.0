Return-Path: <linux-kselftest+bounces-11804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D46905E49
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 00:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13C41F2267D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 22:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C7412B170;
	Wed, 12 Jun 2024 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s//GaH7E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49E127E3F
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718230436; cv=none; b=QtarsQ1RaD9lpnAKbK4BUtx7RfJwfo2q0me32AotA1GkZyRRVd+Yl4kt3wF13fYdaszST0R2y/oIqBtJXbiz7SPPhPlZzN5ByhuOaBw+PPdXIuHBmJXdayFBzqRoXQ//kZb/9i9B/VTuQVIGMoyN/tSKcX7MIjemBPWvYpqCjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718230436; c=relaxed/simple;
	bh=GwfBCcHjkevNkWnlhNs7s7LtsNgX3NNWwh13LjsHl2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dL7aRRthk7D6i1gruc+pRf4C9I0u5hoIfeP6/eNtB2x7juRbDSle7AHwMp561RmRvfzjwIlukh5seDuLnsVyyZy28iwiVyukDqyzgmpZ42AdG/pyKqHePFA1DJHDf1vygNnol9oLSCdCnxBOHiolYqEw8aDp1gGKkDWTSu7FiS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s//GaH7E; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62fc0568219so6466997b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 15:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718230434; x=1718835234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPX3/Z0GWf3goqQnQ+80IAoevnNEBGSkkJOiBvmG4jY=;
        b=s//GaH7EOLTmaXUl1rmYJN1rO/2MMS3WFL/FmLQy72muCUwpBXJdkimk4Zp+zGmG56
         Gad94F4y7yknfrh9EMlah0PXnZfI0yM4yiuEWqCOkvDQkuQsqz7YmRxMB7kG2hpSiTW5
         k/5rQYS36eV21ARWug4Xl8y5srpiuW9U3KmaFWunNhB6PQwPswRGB11cwmucIx9Czx4+
         +mNaGCiLxeqkHE6yqosioiE0B9T6M4WWaubTjRMNbuymK5tR2G0BE+x/4DDcjGMgwDJT
         8P23GTan20gqVn7DbXDn4b2mJGh//PkuDWLHI164cWS5qr+fsYCs+hcAi62efO4tWfMK
         FfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718230434; x=1718835234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPX3/Z0GWf3goqQnQ+80IAoevnNEBGSkkJOiBvmG4jY=;
        b=JAm1luk53/03+3Uz9LW0a9hVmHUljHy2utpi+UmNYjNb/gQRWKLoscjVJAnoOBgUXw
         qtaZ5mVilJNse8arGp8HNjKWgnYXTCteXeSqwZsmz5vJJDHESIBi0Qqs6T40Mt/rfSf/
         Vn8KQdFc9yQ4Yn8+3QUznqLWW8yq/zraaXPCxlKc/9e4jVDws57Z/lP/eMgfROt2QgnT
         3WIWSgjWGYShE3K+Tq7YLTXQtu0BeKy0+My7PLfc6+XfxDp0nQgL0DJKT6FZ0cfwa3Un
         JdwFJBmglHuUWPAKQH3Lub9G3laY9lfCwiPlIx7SZOixhAFzN5I/yG/LjANEsVkBT7ve
         EZCg==
X-Forwarded-Encrypted: i=1; AJvYcCWHjUxymfN9JxLrVdY1TiXleKgS1oQDAL6ZeXMdKMFmL89C6eLqHeOqzCjIwUlSWPwqaATFG8o1BooHjT7Nf/49Jnza58aREiEwJdBTdjau
X-Gm-Message-State: AOJu0YyAnuzNNcVuaiiR8r+PWSTC5D2MfpV5Eb5ISdYmgCx8ebpevtA9
	sSGqSZL94OI/wc9e91voaVtAK2h6YsQ0GncZg44CRJJOHEEQ9xfvEJeZySrilyEdB9lTda+QXIB
	ACA==
X-Google-Smtp-Source: AGHT+IHQk/QK4uDOLMVdbV04IdfTlJ2Btibfi42Ivx9v36nGEO3157fO4+iqYDDxzqE9oJh20Eg6PCiUsJk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:150f:b0:de5:2694:45ba with SMTP id
 3f1490d57ef6-dfe62d1ee23mr813079276.0.1718230434092; Wed, 12 Jun 2024
 15:13:54 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:13:52 -0700
In-Reply-To: <20240207172646.3981-12-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-12-xin3.li@intel.com>
Message-ID: <ZmodoHj_ebGza4Sj@google.com>
Subject: Re: [PATCH v2 11/25] KVM: x86: Add kvm_is_fred_enabled()
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
> Add kvm_is_fred_enabled() to get if FRED is enabled on a vCPU.
> 
> Signed-off-by: Xin Li <xin3.li@intel.com>
> Tested-by: Shan Kang <shan.kang@intel.com>
> ---
> 
> Change since v1:
> * Explain why it is ok to only check CR4.FRED (Chao Gao).
> ---
>  arch/x86/kvm/kvm_cache_regs.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
> index 75eae9c4998a..1d431c703fdf 100644
> --- a/arch/x86/kvm/kvm_cache_regs.h
> +++ b/arch/x86/kvm/kvm_cache_regs.h
> @@ -187,6 +187,23 @@ static __always_inline bool kvm_is_cr4_bit_set(struct kvm_vcpu *vcpu,
>  	return !!kvm_read_cr4_bits(vcpu, cr4_bit);
>  }
>  
> +/*
> + * It's enough to check just CR4.FRED (X86_CR4_FRED) to tell if
> + * a vCPU is running with FRED enabled, because:
> + * 1) CR4.FRED can be set to 1 only _after_ IA32_EFER.LMA = 1.
> + * 2) To leave IA-32e mode, CR4.FRED must be cleared first.
> + *
> + * More details at FRED Spec 6.0 Section 4.2 Enabling in CR4.
> + */
> +static __always_inline bool kvm_is_fred_enabled(struct kvm_vcpu *vcpu)

Maybe just is_fred_enabled(), or even just is_fred()?  Most helpers in x86.h that
wrap CR4/CR0 in similar ways omit the "kvm_", partly for brevity, but also because
the check is architectural, not KVM-defined (though the state obviously comes
from KVM).

> +{
> +#ifdef CONFIG_X86_64
> +	return kvm_is_cr4_bit_set(vcpu, X86_CR4_FRED);
> +#else
> +	return false;
> +#endif
> +}
> +
>  static inline ulong kvm_read_cr3(struct kvm_vcpu *vcpu)
>  {
>  	if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
> -- 
> 2.43.0
> 

