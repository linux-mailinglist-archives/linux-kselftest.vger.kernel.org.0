Return-Path: <linux-kselftest+bounces-4213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76E384C358
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 05:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2891C238B7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 04:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C12101DA;
	Wed,  7 Feb 2024 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1lWABzF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CA310A0D
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707278607; cv=none; b=auiL7Oqq69kYyQFqQOx7ZTOG7zCes17/0LKasRtlizT2sqlS6nDyfp1uDzGZUfzvUE4/cp7GkAu15daBmX7lifg585qRrkJHUGtMZYvjRPDPurrC3bVblvss43V/dt9zZ+A9jxfX7l6W9CcKaciY/SqFli97vDD5KcLbIvPbIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707278607; c=relaxed/simple;
	bh=JjLVC4wkJU//dBMXZ69oFBlCvjbkdkDiMa8lOoCkIp0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qqF6zjEjl5CcwRpuSp99GKjgPjtait4EqPu6guHXpR3scunWyLg1/CT5EoL5BTTLdwjo2U456akpnD1S+05zfd1Ezf7R89DXy9bqsKbc2FsvwitycGjMafq5BDSKJ5Df3u60R/WvmcG3Zi73Wc94/Ge+LI8hnSeaXJx/WwUV2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q1lWABzF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d96da0f7b1so2705705ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Feb 2024 20:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707278606; x=1707883406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7VdHBOFzG1hpPCE2aT7A9wtUIgr6V8/ADfSs0UT+wFE=;
        b=q1lWABzF771DZPBNDL4sLFt1KNYVKJBv33Rq6R5KPpxbdJQR7MZLAMdsOad47BGWSo
         oMz9eaYT880lOgCzoKyN9tjM1KQy+hJhrltg0XboNAnN+y/0z36TrEO16pJt7Aw0Y+pj
         KYBE9Fyif7Rmk1BvrEXQtgDgYzNs89+DtTr9dtmKsYUTvPRM6jbrQA3X/Fhil2zBGc/y
         +Mq7aKSEZ5IoTDdYBclpSEseAUmJaLbu6G2ooV0BgF91n8flClVZp6gSTTBcO9HQfSiM
         zO1D5+vh0tT09gWAth26jFndcASCvOIG7FelXM2Z3QKH+Az1MDOw2hpulYgTSbXt5ZRX
         0zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707278606; x=1707883406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VdHBOFzG1hpPCE2aT7A9wtUIgr6V8/ADfSs0UT+wFE=;
        b=gDVlJu3eVku4oYJcKjTBLIvrWaN14qBrpbGLUnh84iMNXrex9Q+nndFyexoXgN3pf+
         HXhbx5tHahBj4iGMhjpd8EaMMdxZpfrtT9MCOFv4KfwIhX8Eg9FfwQzVpGTV8qgAac+a
         aWGDFfoiPYUWMJex4D79utRH2dWSeicWax8zInUGOGrPUmhMm/OCf3b5ZuXFrDoDRc9z
         XYCTme9UC2S8qDUvNqI7j6NVDqJ7YRpTu8cdHciJ8zRRl2IwGOEDIBoODe7i78kJ6ihO
         gUz9R3A3476/bBoXL85reSO1FkRE4ohdf5ukUKetzS11hNhYxUcCx4btmfJ6+eF5B42Z
         vi8w==
X-Gm-Message-State: AOJu0YwM6S7e2L1ljs9DSS44yaYcc7LnTqxaeU1a7/rCci+GYlWQ9tAR
	IKgHcC3VhMMY/sY+I23M0AWeyKKuWcn00te19Gs/K4wWWgJiVnn+FTUOpNV8vGyhn3qJyqR0uZ+
	eKQ==
X-Google-Smtp-Source: AGHT+IG2PPDPZf8UPHTOJABx6M+gZeVvnxbUern2G3J+X4qXywNyMM258LB942uRWNr2zyc2eNvSNrfvxhM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4cf:b0:1d9:a466:ed5b with SMTP id
 o15-20020a170902d4cf00b001d9a466ed5bmr10654plg.6.1707278605717; Tue, 06 Feb
 2024 20:03:25 -0800 (PST)
Date: Tue, 6 Feb 2024 20:03:24 -0800
In-Reply-To: <20240115125707.1183-9-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115125707.1183-1-paul@xen.org> <20240115125707.1183-9-paul@xen.org>
Message-ID: <ZcMBDP6H5PRo5C2d@google.com>
Subject: Re: [PATCH v12 08/20] KVM: pfncache: allow a cache to be activated
 with a fixed (userspace) HVA
From: Sean Christopherson <seanjc@google.com>
To: Paul Durrant <paul@xen.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"

+s390 folks (question on kvm_is_error_gpa() for ya)

On Mon, Jan 15, 2024, Paul Durrant wrote:
> @@ -1398,7 +1414,9 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc);
>  static inline void kvm_gpc_mark_dirty(struct gfn_to_pfn_cache *gpc)
>  {
>  	lockdep_assert_held(&gpc->lock);
> -	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
> +
> +	if (gpc->gpa != KVM_XEN_INVALID_GPA)

KVM_XEN_INVALID_GPA absolutely doesn't belong in common code.  Not to mention
that it will break when Paolo (rightly) moves it to an x86 header.

https://lore.kernel.org/all/20240131233056.10845-3-pbonzini@redhat.com

> +		mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
>  }
>  
>  void kvm_sigset_activate(struct kvm_vcpu *vcpu);
> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> index 97eec8ee3449..ae822bff812f 100644
> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c
> @@ -48,7 +48,10 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
>  	if (!gpc->active)
>  		return false;
>  
> -	if (gpc->generation != slots->generation || kvm_is_error_hva(gpc->uhva))
> +	if (gpc->gpa != KVM_XEN_INVALID_GPA && gpc->generation != slots->generation)

This needs a comment.  I know what it's doing, but it wasn't obvious at first
glance, and it definitely won't be intuitive for readers that aren't intimately
familiar with memslots.

> +		return false;
> +
> +	if (kvm_is_error_hva(gpc->uhva))
>  		return false;
>  
>  	if (offset_in_page(gpc->uhva) + len > PAGE_SIZE)
> @@ -209,11 +212,13 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
>  	return -EFAULT;
>  }
>  
> -static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
> +static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
>  			     unsigned long len)
>  {
>  	struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
> -	unsigned long page_offset = offset_in_page(gpa);
> +	unsigned long page_offset = (gpa != KVM_XEN_INVALID_GPA) ?
> +		offset_in_page(gpa) :
> +		offset_in_page(uhva);

This formatting is funky.  I also think it would be worth adding a helper to pair
with kvm_is_error_hva().

But!  kvm_is_error_gpa() already exists, and it very, very sneakily does a memslot
lookup and checks for a valid HVA.

s390 people, any objection to renaming kvm_is_error_gpa() to something like
kvm_gpa_has_memslot() or kvm_gpa_is_in_memslot()?  s390 is the only code that
uses the existing helper.

That would both to free up the name to pair with kvm_is_error_hva(), and would
make it obvious what the helper does; I was quite surprised that "error" means
"is covered by a valid memslot".

Back to this code, then we can have a slightly cleaner:

	unsigned long page_offset = kvm_is_error_gpa(gpa) ? offset_in_page(gpa) :
							    offset_in_page(uhva);


And I think it's worth asserting that exactly _one_ of GPA or HVA is valid, e.g.
to ensure KVM doesn't end up with botched offsets, and to make it a bit more
clear what's going on.


	if (WARN_ON_ONCE(kvm_is_error_gpa(gpa) == kvm_is_error_hva(uhva))
		return -EINVAL;

