Return-Path: <linux-kselftest+bounces-34760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABD6AD60EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0731BC1E04
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCC4244661;
	Wed, 11 Jun 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tX0dj0C6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056DD1A8F82
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676619; cv=none; b=QpzkyptP3SNVZgiRF+K9ZeHg4ySLsR2PsR6Ff8jNvv48kZ7S0DMkH7rY7U3hnpbg3z98xb9kWXlpBP7LAN3CjaskOLZ2M2GRsk1TuNAUScPHnaK1cuPSgy/F/F6JEgAN1vff+3VUySZx4jcFtFyhyjXQonppdVp1bzqOYMycLfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676619; c=relaxed/simple;
	bh=1J2BNASlNa1Dhe5jluI1gAN0W9RVPLyHfYbBUQPkC54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jv9cAXIaWfyhP4jHzF6szEUxcWuf5Qm64CuJ4B617Ze/NfNHSdcIADtWC8nGaeW4ty1zbrzKnHQOil5QqWF+nPm93muqb2W7RVygUX5/vESj1mxCNnHJi4jNeVIIbGAkykI3t8PE9GZ6kVNwzyZ7QRkPEel6/elP+iXBkiI2dU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tX0dj0C6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747cebffd4eso193726b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749676617; x=1750281417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JVZUY5qeKcLxvon3A1qgzFOnqGD8w3UB+MEi0rObhNA=;
        b=tX0dj0C6FlJ+8eMNwdZODidXdYTeEqpSRvjX9G1HOn1NuSC4Z0Zn3+2CocNpvgyFJ/
         4ddOneDuYzDCBy6xehXPXgZaK5cxZ+41J+tUNhynqUKn0agFJ4SAO1DV6EsEY8zXt7kr
         wvfXG4/jMJrHxtfE7tjOC/2kwmEVrI1vh3aaR/ZvZObH7Z8uYnXePADn0bh+SU0qe6wp
         iLJL+YvTz+oj7v/eMnu70WaJ522v6jI/BK0/1ZO8aGDiOwNEmIkAdNuXW6NAB4ye+tgo
         pMkS41hMyBeHWl6Nh47llY/7Mtl3gPshfdtNc321TLrH4M17R7m7XVBswzhEK/d7rzlp
         H8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749676617; x=1750281417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVZUY5qeKcLxvon3A1qgzFOnqGD8w3UB+MEi0rObhNA=;
        b=wRzIqCXx6jNA8wBGZ9Q32pfLBZnOUTrhOwBxPHwezj5kz7GZW25q/crYgzM5PNW6Du
         hT/VJstYLd5ecaVXDxE6ib2MNjNeee7bdnBjKVrMSwfa4kDXHBi0MkQFl8/2EpVOhwWo
         aj3qq03CPZZCvYXT6ElCNKLMcD6tUFCb/HYQ0U358P50TxiDjiNL5yX+rzQWEYpw5ErM
         CpAjY3ncjCv1JsYMBYgo5HYVqWNCoAfVTcX29SPWRgMQu2vLokmGuY+iXbWUUitCWsTk
         7zMINDmEyFZ96uTWeLljGKTi+f4KPw7phpD3UA/s9F1oHxzuDxIRFC2LIcnhHp2EtLmk
         /Obw==
X-Forwarded-Encrypted: i=1; AJvYcCWfPXZCASV//Q1TTxnrHm/OtNFHaIxOmkqpCTRXu1K4yDU9lJskEbozWWV+e370JqFYpI7rtIWE+wOSGQwdvmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8TCuCarY6cAGG11gOirX/VaZSDih6eAjboYuOMOJ3p9slAogC
	sUczmpl/yBdvf/FJJ708MzdSu6qCX7VHRVzXlhrxs7+R5oEvTQu4nsjIoImGF8/TelCEdfYhqtA
	6PThf6fKbaA==
X-Google-Smtp-Source: AGHT+IEJ/qdunyiMvwsT10mftztZECZsqDYMcHYykS/gDMvyJ2du0eMtdA6wuu+sltqOX8qT0k9ifIs5X5dW
X-Received: from pfble12.prod.google.com ([2002:a05:6a00:4fcc:b0:746:1d26:e8c8])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:394b:b0:21f:775d:107e
 with SMTP id adf61e73a8af0-21f9b9f75ebmr370105637.17.1749676617125; Wed, 11
 Jun 2025 14:16:57 -0700 (PDT)
Date: Wed, 11 Jun 2025 21:16:28 +0000
In-Reply-To: <cover.1749672978.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1749672978.git.afranji@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <884dc45a13920578973d5628c7cad79d8d50b7a2.1749672978.git.afranji@google.com>
Subject: [RFC PATCH v2 01/10] KVM: Split tdp_mmu_pages to mirror and direct counters
From: Ryan Afranji <afranji@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: sagis@google.com, bp@alien8.de, chao.p.peng@linux.intel.com, 
	dave.hansen@linux.intel.com, dmatlack@google.com, erdemaktas@google.com, 
	isaku.yamahata@intel.com, kai.huang@intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de, 
	zhi.wang.linux@gmail.com, ackerleytng@google.com, andrew.jones@linux.dev, 
	david@redhat.com, hpa@zytor.com, kirill.shutemov@linux.intel.com, 
	linux-kselftest@vger.kernel.org, tabba@google.com, vannapurve@google.com, 
	yan.y.zhao@intel.com, rick.p.edgecombe@intel.com, 
	Ryan Afranji <afranji@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Sagi Shahar <sagis@google.com>

tdp_mmu_pages counts all the active pages used by the mmu. When we
transfer the state during intra-host migration we need to transfer the
mirror pages but not the direct ones. The direct pages are going to
be re-faulted as needed on the destination, but that approach doesn't
work for mirrored pages which stores information in the secure EPT.

Keeping them in separate counters makes this transfer more efficient.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 arch/x86/include/asm/kvm_host.h |  7 +++++--
 arch/x86/kvm/mmu/tdp_mmu.c      | 11 +++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 999872c13722..b9966394acda 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1484,10 +1484,13 @@ struct kvm_arch {
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_KVM_PROVE_MMU
 	/*
-	 * The number of TDP MMU pages across all roots.  Used only to sanity
-	 * check that KVM isn't leaking TDP MMU pages.
+	 * The number of non-mirrored TDP MMU pages across all roots.
+	 * Used only to sanity check that KVM isn't leaking TDP MMU pages.
 	 */
 	atomic64_t tdp_mmu_pages;
+
+	/* Same as tdp_mmu_pages but only for mirror pages. */
+	atomic64_t tdp_mirror_mmu_pages;
 #endif
 
 	/*
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7f3d7229b2c1..115af5e4c5ed 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -42,6 +42,7 @@ void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
 
 #ifdef CONFIG_KVM_PROVE_MMU
 	KVM_MMU_WARN_ON(atomic64_read(&kvm->arch.tdp_mmu_pages));
+	KVM_MMU_WARN_ON(atomic64_read(&kvm->arch.tdp_mirror_mmu_pages));
 #endif
 	WARN_ON(!list_empty(&kvm->arch.tdp_mmu_roots));
 
@@ -328,7 +329,10 @@ static void tdp_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	kvm_account_pgtable_pages((void *)sp->spt, +1);
 #ifdef CONFIG_KVM_PROVE_MMU
-	atomic64_inc(&kvm->arch.tdp_mmu_pages);
+	if (sp->role.is_mirror)
+		atomic64_inc(&kvm->arch.tdp_mirror_mmu_pages);
+	else
+		atomic64_inc(&kvm->arch.tdp_mmu_pages);
 #endif
 }
 
@@ -336,7 +340,10 @@ static void tdp_unaccount_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	kvm_account_pgtable_pages((void *)sp->spt, -1);
 #ifdef CONFIG_KVM_PROVE_MMU
-	atomic64_dec(&kvm->arch.tdp_mmu_pages);
+	if (sp->role.is_mirror)
+		atomic64_dec(&kvm->arch.tdp_mirror_mmu_pages);
+	else
+		atomic64_dec(&kvm->arch.tdp_mmu_pages);
 #endif
 }
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog


