Return-Path: <linux-kselftest+bounces-49073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE82AD293AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 00:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96BC23018C8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B68B332900;
	Thu, 15 Jan 2026 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmIyEX/D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F828330329
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519343; cv=none; b=GQ/VLdTuOYuXxNGqqFXqKcR7RbvVWa83mVWTCLElW0642xq3D5nxcS3Ky+oV4him0Cz8Wjvp7H34K5FycqXT9RUQbmtkMaI5UxRERG9j3TTCaXFtFZoIohYFluaa2oF+h1gKXXokVpps4u3tH3vKIoNJN+doF78AEPJnA59+Df4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519343; c=relaxed/simple;
	bh=n9VuXnyas8RzAVq5FNPFG4pbXM3KIqWWE1kNwMcTCbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S3hFBq7noZWlVLRSbzZDrJOEUBVqxnWPGlpowyyf4vkAYzXaPTFvQ1m5Cm1tkmGrfxwrkWuzi3ZHnDa//wZW/mSomOxGGjfUEEqZ91eqSqcbgh3SVk5OaqgkkYO29nY0gEw8BuDYD+FshzLEzVZcGAA06/jBoFX/5guNUo1yG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmIyEX/D; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a31087af17so15002465ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 15:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768519340; x=1769124140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/zBrN190qohWKUBRuSYnE9mFnTLenfIQq4Uzz5XlzA=;
        b=TmIyEX/DYynmIOIJ4etW66jP19V46ZK2mcXN1ZcRtJ+ganeVyCMBbNdWn0USfMTJB/
         VMGEx/rFp5LAWZxOdZvq4u3KJ79sGTJqrXhSAVTdlV4rxZY+ekd7izHDUkulnv3PD/g3
         /z2owod91ZUuwcOIAPVyopqmyz/zsPD/6ERIaaWaCNldtR3PhxrHguxN6S5evrumJ3rc
         SRcykru2Sc4waO82Nf64Gw3sOOuGw08aLjB1btnk3wPpuuMXmvJymDZLvLWJlvQ900sU
         Z7Lpq/eICv6YwaydWOBVjn2/v1HEGkKqn0W4K3gkYBWzCjdXeCojvynoK00ee4uSUneu
         SVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519340; x=1769124140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/zBrN190qohWKUBRuSYnE9mFnTLenfIQq4Uzz5XlzA=;
        b=YOWXngZp2VyuElMM4oQlklqG9Y5HUfaz6bqNLBlbidTrUAoDh8UjXqyMcua/FuoNh9
         I6BwLeH+bH1UdE0S3xY0Sf89KGEoCCFmYaKjDoe4OLdGC4+unq/MisGW20T7OJiq1Cba
         zcIlqFe1I6By7xDZ0VEEfbtVQOKavICx65d9+I3Fv9YOgTTRE98SDJzIKnls6WCpxK/w
         ZAhuggN0D4EwRGgDCMjvM71sgJl+IsinnHcdKTX336gFwDhAoTtahCWYtGroX7AXqd5L
         Cev6vbxxh9goUDJ2hyeN2DFO8WesRgrNGpTinH76MgXb6fh70sC2kg5SHLZVw6PDoHHk
         Hdnw==
X-Forwarded-Encrypted: i=1; AJvYcCXnSDfCcBIFm/G/ckRF5JJ+8J0L/1fXfid6EmD76b58xIeqJkx2z+clEr3nw2+GgSTL3NzbwT9csnboZ9CBzPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5bgun52uZ/mwRDC+Sn9mC1EftIss2cRDNqL1oG5FhkYhiQ6x1
	xWMYZVFVE3Yw6bFO6oyArfww2/aDpJ8eWVrdBdaEsq4GdIu/Ws6WnbgT/RW4/iO00utsmqXSGaW
	IMIMWZmEFQ33etA==
X-Received: from plcl20.prod.google.com ([2002:a17:902:e2d4:b0:2a0:9fe7:eaa6])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f685:b0:2a1:3ee7:cc75 with SMTP id d9443c01a7336-2a717539460mr9150535ad.19.1768519339675;
 Thu, 15 Jan 2026 15:22:19 -0800 (PST)
Date: Thu, 15 Jan 2026 15:21:44 -0800
In-Reply-To: <20260115232154.3021475-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115232154.3021475-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115232154.3021475-6-jmattson@google.com>
Subject: [PATCH v2 5/8] KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on VMEXIT
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

According to the APM volume 3 pseudo-code for "VMRUN," when nested paging
is enabled in the vmcb, the guest PAT register (gPAT) is saved to the vmcb
on emulated VMEXIT.

Under KVM, the guest PAT register lives in the vmcb02 g_pat field. Save
this value to the vmcb12 g_pat field on emulated VMEXIT.

Fixes: 15038e147247 ("KVM: SVM: obey guest PAT")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b0c0184e6e24..5fb31faf2b46 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1189,6 +1189,9 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	vmcb12->save.dr6    = svm->vcpu.arch.dr6;
 	vmcb12->save.cpl    = vmcb02->save.cpl;
 
+	if (nested_npt_enabled(svm))
+		vmcb12->save.g_pat = svm->vmcb->save.g_pat;
+
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK)) {
 		vmcb12->save.s_cet	= vmcb02->save.s_cet;
 		vmcb12->save.isst_addr	= vmcb02->save.isst_addr;
-- 
2.52.0.457.g6b5491de43-goog


