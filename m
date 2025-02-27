Return-Path: <linux-kselftest+bounces-27774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4FEA48184
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE9A3A8863
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7969230D35;
	Thu, 27 Feb 2025 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tl6wkvrI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD0E2309A8
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666778; cv=none; b=lNNC8ppWJ1rsuARCYO21rQmMHuo6pI06XR4ySEz0AgLaX7u+mIqG1Ut3IoOLJkc00JtAtN+0g69mbOIDamo+a6yC9cUN1YVJTYYACY01hJmfWxKmF5xo+ZDL2X4N52YLgtxtJ7KnW+zHSO5V3qO08N5mmAquAAiVPbvvKapEnU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666778; c=relaxed/simple;
	bh=nwUmpwjVHRe61AX1sa2fDIX4r9ggEykHzNM3puJmYlA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GewcFOqhQhIenj6BDTRH9wmIXXmxsr4wGfJTONUDM//Kdir8eZ+tEFR9QkNTQpS/6iJXuaabOEBXRZc+9c2OHKxtWIKQbQjuN5W0txYrAkeIDu7G4c7y90KQSguEGffA6VN+MXSSRrt6+9Elico4Fy86xrpSctESQqsiwXAA5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tl6wkvrI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe86c01e2bso2245482a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 06:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740666776; x=1741271576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GzX6RifgECI79FHPbY0or0NYOknovZYzIoHacFEQfXE=;
        b=tl6wkvrIOZ+kQTTAeh8FiavqnTxXx5WRhXN0ZsUNeIg2fx3h4ViJg6Szo6y/+CfIZ3
         cF1wHtDDrK9wg/saRt47t80BBwK5krmiqeaLhCcqSQWfd3iD5oSBhd1bcAgDpHyVXCJZ
         hI6R/yOtSI2vKW/ri4NlzNtZi3jBLN8pBkIvgLoF+hL9fEglXQuFnThkEVf+OB8RtHso
         qy6Y8gF1o2hg57Gh4MCEbuK1QgJrX3B35cipTC0djCIZjfbv30vNQUqcv/dYLna23E9c
         AFllXe8UVjCHYK8iGUsKSX4wOtudIvDy56rYjQgiXAwAcSfC6g13UAneuNo6xq8JxaFN
         Bvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740666776; x=1741271576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzX6RifgECI79FHPbY0or0NYOknovZYzIoHacFEQfXE=;
        b=gA/9t/lZ22zOVgJYLDPAeQruNnkKMCCTlc+5ycEivQxF07NtUnhelEkdkZImh8JsmU
         ZhpKeIDiHHhmNpFfHgt1QmiLrJ2w9JgpWOXhxlUs7AierNdb6s9B6uhQRCzRq1bfM0Hp
         L9GBfJpsZ8iLWQQkxPj54dEm2rrdWiFYEyO9rl4zcg8EaGzfC1s9mHRguCkpVaraSIqe
         85Sjuf0Xl/cQTxOWw7z9lFxkNgKMBzL7QzX4mWmxqwsumKKgvnZY5Sdff9WktVNjHgla
         uyZo8gWwnyGtiqXQgta7Nbu4JzcFUGNy8ZHcJM2teJLjBkTW5AbaZfJ1aQ4wCW82uLUY
         oo3A==
X-Forwarded-Encrypted: i=1; AJvYcCWUMjOFuBtscSepMYh5HnAw2Tz/MSf8PuI0IUS1WBYiGX93sN4fySLCtVOJ6cr0Iy1dBS7jTcF+K7Pk4NT+IcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQUx7BMpx5/JxxTQC8rSv5GChJa8H4acrsqEO+iTPNTrKP/p1
	Fca8ZR3CcwJvYGAAtjbX+OdEAcXA2GjTDafjpUvdMlh/GDE6ZFVeMrtcyqnQiznXZ6UsUBC/zPk
	jBQ==
X-Google-Smtp-Source: AGHT+IFLgt1HXgLiOKtKDvHYRpSTc3CznmCb5CmKQq3WTADWz9n0nIbP0qGZSkrWbsy0knvFAOa1tCwXrI8=
X-Received: from pjboh11.prod.google.com ([2002:a17:90b:3a4b:b0:2fe:800f:23a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3cc4:b0:2ee:ee77:227c
 with SMTP id 98e67ed59e1d1-2fce868cbb8mr36260845a91.3.1740666776586; Thu, 27
 Feb 2025 06:32:56 -0800 (PST)
Date: Thu, 27 Feb 2025 06:32:55 -0800
In-Reply-To: <454ba4ae-4be7-49ae-a9b9-3b25cad8433a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250128124812.7324-1-manali.shukla@amd.com> <20250128124812.7324-3-manali.shukla@amd.com>
 <Z74_HQaQ1jY4eKBB@google.com> <454ba4ae-4be7-49ae-a9b9-3b25cad8433a@amd.com>
Message-ID: <Z8B3l8VGA2RHRI1j@google.com>
Subject: Re: [PATCH v6 2/3] KVM: SVM: Add Idle HLT intercept support
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com, 
	neeraj.upadhyay@amd.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 27, 2025, Manali Shukla wrote:
> On 2/26/2025 3:37 AM, Sean Christopherson wrote:
> >> @@ -5225,6 +5230,8 @@ static __init void svm_set_cpu_caps(void)
> >>  		if (vnmi)
> >>  			kvm_cpu_cap_set(X86_FEATURE_VNMI);
> >>  
> >> +		kvm_cpu_cap_check_and_set(X86_FEATURE_IDLE_HLT);
> > 
> > I am 99% certain this is wrong.  Or at the very least, severly lacking an
> > explanation of why it's correct.  If L1 enables Idle HLT but not HLT interception,
> > then it is KVM's responsibility to NOT exit to L1 if there is a pending V_IRQ or
> > V_NMI.
> > 
> > Yeah, it's buggy.  But, it's buggy in part because *existing* KVM support is buggy.
> > If L1 disables HLT exiting, but it's enabled in KVM, then KVM will run L2 with
> > HLT exiting and so it becomes KVM's responsibility to check for valid L2 wake events
> > prior to scheduling out the vCPU if L2 executes HLT.  E.g. nVMX handles this by
> > reading vmcs02.GUEST_INTERRUPT_STATUS.RVI as part of vmx_has_nested_events().  I
> > don't see the equivalent in nSVM.
> > 
> > Amusingly, that means Idle HLT is actually a bug fix to some extent.  E.g. if there
> > is a pending V_IRQ/V_NMI in vmcb02, then running with Idle HLT will naturally do
> > the right thing, i.e. not hang the vCPU.
> > 
> > Anyways, for now, I think the easiest and best option is to simply skip full nested
> > support for the moment.
> > 
> 
> Got it, I see the issue you're talking about. I'll need to look into it a bit more to
> fully understand it. So yeah, we can hold off on full nested support for idle HLT 
> intercept for now.
> 
> Since we are planning to disable Idle HLT support on nested guests, should we do
> something like this ?
> 
> @@ -167,10 +167,15 @@ void recalc_intercepts(struct vcpu_svm *svm)
>         if (!nested_svm_l2_tlb_flush_enabled(&svm->vcpu))
>                 vmcb_clr_intercept(c, INTERCEPT_VMMCALL);
> 
> +       if (!guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_IDLE_HLT))
> +               vmcb_clr_intercept(c, INTERCEPT_IDLE_HLT);
> +
> 
> When recalc_intercepts copies the intercept values from vmc01 to vmcb02, it also copies
> the IDLE HLT intercept bit, which is set to 1 in vmcb01. Normally, this isn't a problem 
> because the HLT intercept takes priority when it's on. But if the HLT intercept gets 
> turned off for some reason, the IDLE HLT intercept will stay on, which is not what we
> want.

Why don't we want that?

