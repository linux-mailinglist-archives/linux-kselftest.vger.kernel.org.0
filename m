Return-Path: <linux-kselftest+bounces-10869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7A68D4092
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 23:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3214A1F23188
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 21:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A921C9EC2;
	Wed, 29 May 2024 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FI/Vb4UP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B082169AEC
	for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019750; cv=none; b=sK6Im5NnZ3dpm80+c44bbG3KNUL7FiGEobkFUH7+mZDKADnu+59/D27zgOdU3Z81JbF1N6menqROSirPAtpdZQFFoKhix8HzW8/GpM1nRnapjYFT5CK4NJBBM++lgr3rR03ZIWNWd3a7dfWzQRnerKZOiXin5w/M0DrrA6bG2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019750; c=relaxed/simple;
	bh=UNxJLMGZl1gnRZO6sW+znZ/L8AD9EkiPEE3WJ3MdUgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Spz1CJMydRLAbREuG8QYLGXF5EBASqSmF8HKi3A65cKp2VSbWhkajb2xGDZPmLCvl0mubv7+jsnGVttoKwkXzLvWO0Zx6AhcBiVzh7Nu9ZU5IuTwLl8htJa/a+jpLU3QW0hYtmazGe8cIHEcbvVtVehkKDo+d/VtPv+xCLlNuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FI/Vb4UP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6bfe9914116so73944a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717019749; x=1717624549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0O8RdWVLc2UjPDSDGViR160MauFo82inRxl7GpP6bk=;
        b=FI/Vb4UP86exDz3dIJiCXtaFMKxh27cM2trVsP7atzrPcumEz2F1G+FtFyry7U4D8A
         Fha8DDVcjugcrgjcCCbBoSJg8lTTb4RTwiNB+UpkBZNonB21vGIDLzXn6PcALb8RdUBx
         tTUlteIUJBV1wmlGDcPckPc0+s7vGdz5tEtgwVkgEx+xxErqaYorw9uYtXUTppjmMsmX
         Y0GrTT/ftr6abfC7IihASGMF9Nvo0ilZbPvakLP55DLlqhvB8Diir+zBLEtvTB/MAnID
         F1zv+ZRBTEPoaeH7AFLEMy88nBRzK84vyfOtTxv/l8nI3e00iamT0iCxXAhQECepprKG
         WGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717019749; x=1717624549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0O8RdWVLc2UjPDSDGViR160MauFo82inRxl7GpP6bk=;
        b=SLkPFUHAkNwYO31x0zIhIKadEZGdMZiZXH7JQap+yhSNV1NVjDUl87xGiRZlfpVqii
         ZVTYvgYdEpXl5jj9ZjFJVu1Pqo9S/sgzHrWJpqHCgDtbsnXaMrlBDjW4IveQt35jOZsd
         eH6kaYSEsCYC3tMl7lBo2k2YVpkwNXGr7Won7JF/YLjJE4s838QDbfGQIKWLBeC7JofM
         INld2SElQNobu4eL2XRhY6F/86zrkXbYrxKClbRdQmouIdSsxqua6FHYpYFHYTYAmwzY
         8jyNTdMwaP4q7YoeBfnVw4bpNID9QLmjbfeKgehlX5IEK6qr5R5qO29SaWTNZT0/ffTQ
         LfTw==
X-Forwarded-Encrypted: i=1; AJvYcCXVRoUSmkmsMLB96RJzAtbtzLrN8Xr2siqVTip75HTBo4iZ1N+Ckpe8tm3ENoWDHL27ffkoudUAYSOstHf9IRhWnDN9bW1mxEViAhGWdvws
X-Gm-Message-State: AOJu0YybLG6euPdik/kluhr9pIdL0+iApTeYLT9KFysW/LKAPwJPsBMy
	DWU8AnFLQYYq7Ka33k7IGLwGviXVlzO24PHTNLgT/Echb8kQ7HRZ/GoskOcG2IhXCMSBmpqs2S+
	3YQ==
X-Google-Smtp-Source: AGHT+IGx3SrykKCWRo4963j21qgI5u7l1D5l4vFz5cSTor42JO4rQICXW/WPSO9JICYG6TRZvTrpM8pyR8k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:308:b0:65c:f515:1590 with SMTP id
 41be03b00d2f7-6bfdaf2b2f6mr480a12.11.1717019747924; Wed, 29 May 2024 14:55:47
 -0700 (PDT)
Date: Wed, 29 May 2024 14:55:46 -0700
In-Reply-To: <20240529180510.2295118-5-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com> <20240529180510.2295118-5-jthoughton@google.com>
Message-ID: <ZlekYljG7KJwblUj@google.com>
Subject: Re: [PATCH v4 4/7] KVM: Move MMU lock acquisition for
 test/clear_young to architecture
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Ankit Agrawal <ankita@nvidia.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, May 29, 2024, James Houghton wrote:
> For implementation mmu_notifier_{test,clear}_young, the KVM memslot
> walker used to take the MMU lock for us. Now make the architectures
> take it themselves.

Hmm, *forcing* architectures to take mmu_lock is a step backwards.  Rather than
add all of this churn, what about adding CONFIG_KVM_MMU_NOTIFIER_LOCKLESS, e.g.

static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn,
							 unsigned long start,
							 unsigned long end,
							 gfn_handler_t handler)
{
	struct kvm *kvm = mmu_notifier_to_kvm(mn);
	const struct kvm_mmu_notifier_range range = {
		.start		= start,
		.end		= end,
		.handler	= handler,
		.on_lock	= (void *)kvm_null_fn,
		.flush_on_ret	= false,
		.may_block	= false,
		.lockless	= IS_ENABLED(CONFIG_KVM_MMU_NOTIFIER_LOCKLESS),
	};

	return __kvm_handle_hva_range(kvm, &range).ret;
}

