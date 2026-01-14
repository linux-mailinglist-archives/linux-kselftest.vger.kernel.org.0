Return-Path: <linux-kselftest+bounces-48978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23260D2154D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 22:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A84A3305CAC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 21:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47175361658;
	Wed, 14 Jan 2026 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSXJpKYi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA8361678
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425928; cv=none; b=eRTtvxg52fZzAI+kINWtuQt355Bowid/WLWjhJd2A23CBfM21DDtazl3wDkdxl9x28AQqImYfmXe2iK0LgvJhfW/DclgI2z4E3sIJTkw1K6hQLOOxRQ/3Y2QDZh7n0ltyX+6WkDpJOK12X8iSHcY1O3zP5KYHIWz7cgSJGO181c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425928; c=relaxed/simple;
	bh=zb4dyiIPjEf7E3r72RUe47RuzuTNCQQz57NH6qnxHRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mvUuGAhdz8aALTRIeeG68sfo9hXmmz6NZBMzv6xwDADBE5J642l2n20LVfrLtXW2RD0iTAH00z/rGip73lHlbAhJZrA6rciaz9F9kVN/SNYS/5erRMaQF02IxOZWa4iDjQQo/YPybaW4XwTMkApY+ObMAXkNxr3LnefhhBczf2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSXJpKYi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34ea5074935so116884a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 13:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768425921; x=1769030721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KeDMvbaCH6RufsI8Z0v5M8YKe9gGpw4cDxE5ibRGebg=;
        b=aSXJpKYiMaDBvcl7KZEpMede0OG+j+0OANP8YlJrQyWFaJTRVUHBzjB8V4/0PglVrP
         rvvrfUYavl1xYCG/3AMGt3eJfjlYaT4h9pv5JgfpxPY/HKeAP+rg3/Pee9NhFRykY1LI
         7zbHPMOfeSCWSSjKz3oQsnDfXsIY0XLwG07HsoxJbWo1jquTT/EeqVLMYho/yx8dzjlN
         18WS/LT0i0eYBu0idGtuErQz4ntHZ0pEY65c5RSX9Ou2QvJxMnkrzcD5XVb6+y1gbcob
         tq++h8Y6Pyd7cGijQ9HWryOqBwE3nZrWkfmfEDJJdQyLHQ3ODa3RG8cPfSwTXfXR2Z7X
         j8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768425921; x=1769030721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeDMvbaCH6RufsI8Z0v5M8YKe9gGpw4cDxE5ibRGebg=;
        b=vwZrIw2a7qq1MeCUTQMd/Ibye/cDkXs+me2exsJdiEWhizZLicGuXtbF6b2ENT4wyy
         VZsuuQJtGcRNGmpSdyqnYkWqPf2kqkluNm5ujvNuM9lnUl5uQSmML2waa9cWV2TFixQz
         +TGL0KiwjLBWMbXyekN1rta9bFZqU09GORzC1qTfxdUxmCpoaM0t6x1AgGUQOflIea00
         Sfxu6awtlmaHWMXZ5H975Er6ShvvqO9eiWGMDKkS0IGUockm7EI2lMkRZYrLvEyrKVqB
         SQbpeqetdM1AiyAL15EPtavL6iH8Oegh3TynN0KnxRgWcSgzSaGw2CHYF7kCUmBzSJOx
         8ziw==
X-Forwarded-Encrypted: i=1; AJvYcCWDtZMRktZvarEveq/YCIZxiauEFBF5rujyIMEvTpADHh2Tjf2le9PSOzNtTcdxQlMnoxWqvL+vAzK0J3z43vE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxlm10BIFwdiXYvK5eYOaDkzHPDxb0QlOTNmuIXWEhB35DFjO8
	l7cqwNv11o8sI+RNKEM9NLy7gtdILSXpbzbiXvpP7rLiOr+XvYjuwE/lNzaF/m+tJZj08lBMqOy
	JXPJMgg==
X-Received: from pjbco24.prod.google.com ([2002:a17:90a:fe98:b0:33b:b0fe:e54d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5206:b0:343:a631:28a8
 with SMTP id 98e67ed59e1d1-351091a9fcemr4081136a91.37.1768425920938; Wed, 14
 Jan 2026 13:25:20 -0800 (PST)
Date: Wed, 14 Jan 2026 13:25:19 -0800
In-Reply-To: <20260113003016.3511895-3-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260113003016.3511895-1-jmattson@google.com> <20260113003016.3511895-3-jmattson@google.com>
Message-ID: <aWgJv154AfkrvqfQ@google.com>
Subject: Re: [PATCH 02/10] KVM: x86: nSVM: Add VALID_GPAT flag to kvm_svm_nested_state_hdr
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Avi Kivity <avi@redhat.com>, Alexander Graf <agraf@suse.de>, 
	"Radim =?utf-8?B?S3LEjW3DocWZ?=" <rkrcmar@redhat.com>, David Hildenbrand <david@kernel.org>, Cathy Avery <cavery@redhat.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 12, 2026, Jim Mattson wrote:
>  /* for KVM_CAP_NESTED_STATE */
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index a0e5bf1aba52..ed24e08d2d21 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1769,6 +1769,7 @@ static int svm_get_nested_state(struct kvm_vcpu *vcpu,
>  	/* First fill in the header and copy it out.  */
>  	if (is_guest_mode(vcpu)) {
>  		kvm_state.hdr.svm.vmcb_pa = svm->nested.vmcb12_gpa;
> +		kvm_state.hdr.svm.flags = KVM_STATE_SVM_VALID_GPAT;

Assuming this survives to v2, make this:

		kvm_state.hdr.svm.flags |= KVM_STATE_SVM_VALID_GPAT;

both to communicate that there's no pre-existing bug where KVM doesn't initialize
flags, and so that there's less risk of clobbering others flags, e.g. if a new
flag is added in the future and is set before this point.

>  		kvm_state.size += KVM_STATE_NESTED_SVM_VMCB_SIZE;
>  		kvm_state.flags |= KVM_STATE_NESTED_GUEST_MODE;
>  
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

