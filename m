Return-Path: <linux-kselftest+bounces-48813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A28EED16032
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD0223026F26
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BCB285CA2;
	Tue, 13 Jan 2026 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKOIwGp5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E6827E045
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264246; cv=none; b=ITMCv9lV+YSJHyhEwijEhQPI7JcronDGFBUK9akG97ZNec70X0yWoSPx6v09nSCjfendO67CyiKFuevfnmKMykz81kJI1lfqqztSxKa21XtEOAlVTISDRcW5DZowQMK17KSEggpFTfC7aZTB6PiG5Haz1+3x3ZbOKeoXwVdpB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264246; c=relaxed/simple;
	bh=8ohubJfSSIGOHbF9QvJ9OM9WGWtPjCtGiMvy3iiTUfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FThJoDbowyMuGhb/C1EvxRDP3GxjhaX8skJACdqpVSkdX/uuoKwCODPnEIUVU79VfPsFOxDpjf3ZgAsHCGnd/RBf3SELD/fVrBHGQYudcx5AzSfQ2eGyZZnTR+xvV9crZuX4xM0NxXbGU348EaVA8qN3NzaOETdj/cK771ZYcC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKOIwGp5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a08cbeb87eso78307275ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 16:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768264245; x=1768869045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V759ctxKOPBWxlGUqocasSXfPjVLuxnctmfzspXRRJ4=;
        b=bKOIwGp58DVDRdFew+B9JNZ+jwgY7ie8iBpSQUgybMS0ISyy18eVoLfU7yy0fb+ij5
         txlI6O7+uXKUk3XrEdf+SrNdzW7n2AtEDRRTtFrlDtwD5A8gnjG/5lOAy/TR8QHT5Npb
         oXCOac7H2VR3tuVDLqW+AAyr2KE2HGnwdN6+1W+f4fZOtVZa6FLyiP++V8J3gXn6m7fW
         QKel6/z5neeF2u3PA6fc/r5/qQR3q5h1175L+Cn8zFrbD1UH/1q2mvnO903pYrfO/M1c
         SiwlDW8KyZBhgBV+4LRGY1dcC61Xf4gWegt2/DHwJd2041ADHT00oMyo4NjadhzOm1bT
         xdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768264245; x=1768869045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V759ctxKOPBWxlGUqocasSXfPjVLuxnctmfzspXRRJ4=;
        b=qrsyxVatfhyeZ6c/CRS3c6brAu4Ekm7IlE7BjPEwGAeb3Fib66fB0iBHSzzbOiqj63
         fwXERLhsiUzQSvo6sWG+Hi5mVg0m/R61KH2o7NBWJ2MX7TfxZi4XUxaH3s3AIdXf8SCi
         VwHKK0e42faDPSD1KxoAiNYYpNaThad/3CJgl7Sk+NSF+yUblP+S345mGWQufJmdqinb
         kLa6ARzuzq6RkaDcYapl+Z8fbLFL3rze8dS2R71iKHN39kOhzS/vm0WUh37vhbOTg46h
         DS3fk1U8TaXybVtUdiJr7rPe/L4lIZtJQbsNiv/zovz7mK1ES3gjsHZUaJ6UzDDVYV/B
         gk4A==
X-Forwarded-Encrypted: i=1; AJvYcCXUrJTOHmkhS3+b2khBEW2SC9u3u9xIaNDCitEyILB09rEBroihT6DicQLV1oaubriDJY0d9QR/vN5hrmx8M7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJ+vxIX/l2hfkw+wSwrvNcVwj7pRkb3A5zyTtCpYv4nxaBihg
	uIN5q6WWd3VniLBbgYX3l6JlXArElAVcpK9O6DcNOSi9jEvI7uQSVbdvYpv2T4qSTrWKjeMrBCt
	DVO1yZwGzTbImAw==
X-Google-Smtp-Source: AGHT+IG18O1vEYIIlSpSnJ0FYZsqsE17F4nPDlHh9RJI1lHPIQGjp9YKBIaGBb4woEZ+NfAfrwtFxg7I+F1J5w==
X-Received: from plly13.prod.google.com ([2002:a17:902:7c8d:b0:295:16a7:a285])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:46cc:b0:2a2:d2e8:9f2d with SMTP id d9443c01a7336-2a3ee4ab671mr201515325ad.48.1768264244752;
 Mon, 12 Jan 2026 16:30:44 -0800 (PST)
Date: Mon, 12 Jan 2026 16:30:01 -0800
In-Reply-To: <20260113003016.3511895-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260113003016.3511895-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113003016.3511895-7-jmattson@google.com>
Subject: [PATCH 06/10] KVM: x86: nSVM: Add validity check for VMCB12 g_pat
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

When nested paging is enabled for VMCB12, an invalid g_pat causes an
immediate #VMEXIT with exit code VMEXIT_INVALID, as specified in the
APM, volume 2: "Nested Paging and VMRUN/#VMEXIT."

Fixes: 3d6368ef580a ("KVM: SVM: Add VMRUN handler")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ad9272aae908..501102625f69 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -369,7 +369,8 @@ static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 
 /* Common checks that apply to both L1 and L2 state.  */
 static bool __nested_vmcb_check_save(struct kvm_vcpu *vcpu,
-				     struct vmcb_save_area_cached *save)
+				     struct vmcb_save_area_cached *save,
+				     struct vmcb_ctrl_area_cached *control)
 {
 	if (CC(!(save->efer & EFER_SVME)))
 		return false;
@@ -400,6 +401,10 @@ static bool __nested_vmcb_check_save(struct kvm_vcpu *vcpu,
 	if (CC(!kvm_valid_efer(vcpu, save->efer)))
 		return false;
 
+	if (CC((control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) &&
+	       npt_enabled && !kvm_pat_valid(save->g_pat)))
+		return false;
+
 	return true;
 }
 
@@ -407,8 +412,9 @@ static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb_save_area_cached *save = &svm->nested.save;
+	struct vmcb_ctrl_area_cached *ctl = &svm->nested.ctl;
 
-	return __nested_vmcb_check_save(vcpu, save);
+	return __nested_vmcb_check_save(vcpu, save, ctl);
 }
 
 static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
@@ -1911,7 +1917,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(save->cr0 & X86_CR0_PG) ||
 	    !(save->cr0 & X86_CR0_PE) ||
 	    (save->rflags & X86_EFLAGS_VM) ||
-	    !__nested_vmcb_check_save(vcpu, &save_cached))
+	    !__nested_vmcb_check_save(vcpu, &save_cached, &ctl_cached))
 		goto out_free;
 
 
-- 
2.52.0.457.g6b5491de43-goog


