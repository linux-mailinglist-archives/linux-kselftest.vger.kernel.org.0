Return-Path: <linux-kselftest+bounces-48812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7006D16029
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9C35304DB82
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830BB27FB21;
	Tue, 13 Jan 2026 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlLv602+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B63E23817F
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264245; cv=none; b=eLJ7kOvYJAlXy7M3hVqVovx2UJvbsu7juB4F+GjvSZV2IAeVpj+Q4Z/P0e9mxSfdji3TM42tNBhfTpYi2MJVOOxLwy6misxX4tMxpm2CWsWgdZbuClqItjnnJJjhv77TBrN2v/i2Nt7ETl9u2IOhpM+ND1fWBK4h96yXZVtleKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264245; c=relaxed/simple;
	bh=BV4yn4uZgD22pI4OXIPgJursM5Yw9qJXgqtuIVOlWXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iLOMIk4g9gUQPnpKbY+Kr0AIvKAYGbi+fAIOovhJfp6bmC7hgnlOEehNsKNIFHQHgoPazPc/KOskUTaLuME4VIvXGP9Si9l19raKD4hhRcIoX5GZn4uw8V50aTy9p1s5nxBJAPqXqMTGTlE0pNC4jHOEWOBECf0umn9Pq4yf9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PlLv602+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bce224720d8so5040958a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 16:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768264243; x=1768869043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fb2Z9AbVgMs6TJY4TZ71z6j+l7Y9Wd/VbX+6nslSBY=;
        b=PlLv602+j3BhfTrI5Prlo3JSwI1p4lDeRwY5QOX0hO9EO5NMHryCYxfyPQvTp3PnAA
         vSxR2CbhcYD7PxqJvxjoQgEMxrrujLXu5S1ifoqnCGooDoAe/ro2N1S/5PZhkgOww6Gk
         CAUFE0worDAJj92sjcC/he3/iK3R+DVInZdGZX2fxBCaDjSmATeXl9qswBkMgjiZdfBH
         lS+qNa69/f0jJQqjO2aQmEmPCwUqkFLhCKt/oS3A9qi81x2Wx4Cs7vSc/dyIjjK311D8
         bHyP1KTeV1QG6aIgfFPtJNctqzvP42g95Fta17cCGKTYC2wbP1S0dYIWGjFJc9De5rOm
         SzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768264243; x=1768869043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fb2Z9AbVgMs6TJY4TZ71z6j+l7Y9Wd/VbX+6nslSBY=;
        b=RKj1mfLAmrhTKCphMmxTForCKPkGT+/TpW6dKSv3aKicF6FuPN55OxEZahFJBWeMV+
         T3gvKFIpao8m7Z7wgUgg+c1bc9hGieT4uEF9LXFKBmrvCnxdWTVvJS7rz2X1qtAQPqNF
         b3xEUgxcYtT7BK5MJYJVLsWKUuxn5IZhpVq4mw6jN3mv5lTG4c9+7qRXOrdGJWPtbzhY
         +OATdcmy2EMUXqcuUyzRW5XUfsoLkdxGA5GRNKpbiR5zmsAssehwkoXcOql7zSTc1Rll
         L/+F6xjYzDSUuwUXt+ZhmsovZswGGxLax6JlVzFlW+iqTjcQTM8GMc8lulbFNBbihQP4
         NQxw==
X-Forwarded-Encrypted: i=1; AJvYcCXT4QVXSexUfWtiTqT7MKuhDsfaSyoIDvnkrf56i0KZIVR5KuBBjx6uCTXSqkG4CQkcPxoRJHVWDuqv5uGUm+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lTUb98XffiY1irbjsmVYrdwz/aKGoJBEqf3QPqo3Osb8hZvI
	QMaWQYGA23dmTBkDxKbJ47DLwTOUUVKrlpHhvTiPxWksu6XiiOFVlByveiSQxEd8bOV5Tg6Dgy1
	6MeNgXJ75PAvBBw==
X-Google-Smtp-Source: AGHT+IEi1EtH6A0ZdyIGNglJfjm/gcYEekRFqMDdkAJ75tY+z3Sz51psYSn3Yg2rlzFiSIyo8YCI7Muvi3kfwA==
X-Received: from pgdg6.prod.google.com ([2002:a05:6a02:51c6:b0:c0e:5fe1:6295])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:99a9:b0:384:d0be:9f7c with SMTP id adf61e73a8af0-3898f9b9442mr17140251637.39.1768264243374;
 Mon, 12 Jan 2026 16:30:43 -0800 (PST)
Date: Mon, 12 Jan 2026 16:30:00 -0800
In-Reply-To: <20260113003016.3511895-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260113003016.3511895-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113003016.3511895-6-jmattson@google.com>
Subject: [PATCH 05/10] KVM: x86: nSVM: Cache g_pat in vmcb_save_area_cached
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Avi Kivity <avi@redhat.com>, Alexander Graf <agraf@suse.de>, 
	"=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>, David Hildenbrand <david@kernel.org>, Cathy Avery <cavery@redhat.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

The g_pat field from the vmcb12 save state area must be validated. To
accommodate validation without TOCTTOU issues, add a g_pat field to
the vmcb_save_area_cached struct, and include it in the fields copied
by __nested_copy_vmcb_save_to_cache().

Fixes: 3d6368ef580a ("KVM: SVM: Add VMRUN handler")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 2 ++
 arch/x86/kvm/svm/svm.h    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 9aec836ac04c..ad9272aae908 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -506,6 +506,8 @@ static void __nested_copy_vmcb_save_to_cache(struct vmcb_save_area_cached *to,
 
 	to->dr6 = from->dr6;
 	to->dr7 = from->dr7;
+
+	to->g_pat = from->g_pat;
 }
 
 void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 7d28a739865f..39138378531e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -145,6 +145,7 @@ struct vmcb_save_area_cached {
 	u64 cr0;
 	u64 dr7;
 	u64 dr6;
+	u64 g_pat;
 };
 
 struct vmcb_ctrl_area_cached {
-- 
2.52.0.457.g6b5491de43-goog


