Return-Path: <linux-kselftest+bounces-4944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC0B85ADE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 22:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD5F1C21633
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 21:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F8454F94;
	Mon, 19 Feb 2024 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8W6g3xF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688CF53E32
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 21:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378933; cv=none; b=pXpP/JqLgS6D87+t5rdedvz5wFOA2dcvqOw4/hgn9VeiNmqlchQNAdJqpw4Qi4vu8fGtPolsY7V98s4e6WyzhA3TuNXjmTrLFwPm84bQPlBuaX1Q3qBbuBNvVmbXgcN2bkI0jRDYN/9VYlykfS5qE42tNEaD91kqXTlomYhsKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378933; c=relaxed/simple;
	bh=X/JQNewlP0vjO6jTDKr0e8KEBVYmNgVrFfyXrgV4mFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M2vhBoIYsdJFTsVr9SQ9YcsYhsAKpCzHsmPN5VQ+EDCrDBd1AL5r/LyrttwOZJOQyeKSOzmHVhGOgijZes6CcxRGEySP8t7c2jR9MollG76NJZ3qDX6gMaurTSSb+TgAjopD6aukj6zbCTD19rw6x5hmss8w4xTpsEjGlA4Y7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8W6g3xF; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5dc992f8c8aso4597428a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 13:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708378928; x=1708983728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8pCPeHHqio6jkpHM74ywYCDIbICUYC0WuI3ZsK0Xes=;
        b=D8W6g3xFdxsLnpo9T3gSkE+PwxH+Rz3RgvW2UCiVvziW27U7KYoVdlK5E45sITSc7x
         MuKfqe+bIhFbWfSgsNTJqnF2g5lp7sEwCnDxw/jyJuzo2pJWeZwe7yBZR/1eAmIA3WH7
         Jt9ls/brQsJoJ8Pd3y5TnwiXKoxNYzYkd2AKSg1bn+qvwVt75gSxmf7AuxcL9VgEJ3Gf
         /O+OsrYF8ko4cWiZCWk1OXhugUk6K+uUJieP9eci7xUSiLniMY3LTi35gDCzaIbZbn+d
         JR6gIYnAvpw+QlBT/ecpHXxB84cy4qAvW6lSQh5pHYKMtHQnLkweiD0CypSA166rnb4u
         kDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708378928; x=1708983728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8pCPeHHqio6jkpHM74ywYCDIbICUYC0WuI3ZsK0Xes=;
        b=IQ1YbcfGT87yzJ2sqr/l8z6rU95kjDf521qXH9OQpFodhHQnrNSSwZQ2K31LLiPaTr
         w1Su/cNK4HjNPa0hweP8xsovs7wMYcF7UkkKzN+6DKHGZmSLnQwh5z/sDPprcnFpfH9u
         jcIkgHEcRh929rAJALRQGhz4mTuK3p21Ir8EuSg52mBNtP8vYARLDtRNpKkLocI3E78G
         LkqsPbXUYablFq8n3xj7ApUKbFSzXEHNB+aT+RhApWeGUH3XXXeRNvqZr4TjUnzg3cuM
         VnQYjm7z8GFBhjh6f7qK4jGOSTHsSrVqd+AbkTte4pJbinAZcIIzFB4tQABeMuJ7mBIw
         TCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEptLk1wg7lfdlatkQUK4+OLp32gdUIHF+nvHdxdhFeDUXIo5djRIesmvXsPcN6ORgJc8BVA34HeGBTORjmVAAJnOq5v2yu00bHKx07Sdl
X-Gm-Message-State: AOJu0YyyvTyRrrJeyeJ2stLAAXgvehxu0uibyHMmKjj0h3DyNez8hFdR
	cYwQVgDwrDios5mZt8deHicW36XpSbAfQE/gmjCcmX7vmCiFT95/cuKn23DZGce5tHD1NIohV1Y
	bLg==
X-Google-Smtp-Source: AGHT+IHqdE3KIsgW0NC+8GHUODTOmDylpK2DdX8ikWVklG5BvSIeuNAnpXNIboNkdrJqpTmuvilDIVPPeCY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6742:0:b0:5db:e194:873f with SMTP id
 c2-20020a656742000000b005dbe194873fmr35852pgu.10.1708378927816; Mon, 19 Feb
 2024 13:42:07 -0800 (PST)
Date: Mon, 19 Feb 2024 13:42:06 -0800
In-Reply-To: <20240215152916.1158-5-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215152916.1158-1-paul@xen.org> <20240215152916.1158-5-paul@xen.org>
Message-ID: <ZdPLLsdNnAb5eXiZ@google.com>
Subject: Re: [PATCH v13 04/21] KVM: pfncache: add a mark-dirty helper
From: Sean Christopherson <seanjc@google.com>
To: Paul Durrant <paul@xen.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 15, 2024, Paul Durrant wrote:
> +/**
> + * kvm_gpc_mark_dirty_in_slot - mark a cached guest page as dirty.
> + *
> + * @gpc:	   struct gfn_to_pfn_cache object.

Meh, just omit the kerneldoc comment.  

> + */
> +static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
> +{
> +	lockdep_assert_held(&gpc->lock);
> +	if (gpc->memslot)
> +		mark_page_dirty_in_slot(gpc->kvm, gpc->memslot,
> +					gpc->gpa >> PAGE_SHIFT);

It's kinda silly, but I think it's worth landing this below gpa_to_gfn() so that
there's no need to open code the shift.

And I have a (very) slight preference for an early return.

static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
{
	lockdep_assert_held(&gpc->lock);

	if (!gpc->memslot)
		return;

	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpa_to_gfn(gpc->gpa));
}

> +}
> +
>  void kvm_sigset_activate(struct kvm_vcpu *vcpu);
>  void kvm_sigset_deactivate(struct kvm_vcpu *vcpu);
>  
> -- 
> 2.39.2
> 

