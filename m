Return-Path: <linux-kselftest+bounces-8369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65418AA30A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 21:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E696A1C22968
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 19:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C54180A81;
	Thu, 18 Apr 2024 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W6hynQcT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5082C17AD72;
	Thu, 18 Apr 2024 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469370; cv=none; b=rgjScYALs98xbKrVEGjnx7zVmb571yEqbFeH2rQC+WvOE/g9Qot/dUjMydY+NHIK+pa8gO26OwD27YuiL3QyE8UvMZyvztdM56a3LXUFXFoWtaKFzVdNlZUSH2WFLrjkjGaUnsq18B4AlH6O+Hxpt+ZoTPLBUhUYLfGh2jRQF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469370; c=relaxed/simple;
	bh=+x/Ch8/rLQKhFImvy/1gmd+onkqt2sec9kcVyeKMedA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRtkXQJVOWvtpdxztjpEk6rGOew2KyUM46ohOCMXxzuLNg1+ZrGw4gUBC0l3EoSJWS5FvHTw7RK4w1lfgF4iI88OWc6AwASSFQvadfNJFwc90zOk2hNJ9SR4IghrmaCRUPdDun11wzyP9mgFoMeuEx2O+U0eXaoYlb4tunAcEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W6hynQcT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DsRkkj21wdFnjvCf8MfVBZJ9Wy3vTixas3qGCzeZKtE=; b=W6hynQcTwTJUOBp2RgYGprnKoF
	muRGbh3xkhi3uc6BbSI0fr+dHP8h7lEiEz4Aah7SRdg3rk2mhWIHyWruk2J0t1i/T6anOCUwfKoeZ
	Bs6AT4vuqGLzI/GsrycUsCsaWtgFBpmV8YLD5PdA82YGOlpl5s0na9r2rhAobhFUfZt3rwoWogakZ
	Q+cU27nSSUTbwa+kQXbik43ktIGwEQdUgMDhKjWs5keU9chINIJ/jwk7Ec6p/kUbRIr9mtNIWYksq
	iS//oTu//7qZXRIVCWDqIQdlPDSv5oQIUOrueMRFCg+523mkocNvw4w/BZZQuuIJFmGN+xzSlaPeM
	NY0mkmWw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxXXf-0000000C8MN-2qgM;
	Thu, 18 Apr 2024 19:35:32 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxXXe-00000000Asa-3b4r;
	Thu, 18 Apr 2024 20:35:30 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	jalliste@amazon.co.uk,
	sveith@amazon.de
Subject: [PATCH 05/10] KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
Date: Thu, 18 Apr 2024 20:34:44 +0100
Message-ID: <20240418193528.41780-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418193528.41780-1-dwmw2@infradead.org>
References: <20240418193528.41780-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

KVM does make an attempt to cope with non-constant TSC, and has notifiers
to handle host TSC frequency changes. However, it *only* adjusts the KVM
clock, and doesn't adjust TSC frequency scaling when the host changes.

This is presumably because non-constant TSCs were fixed in hardware long
before TSC scaling was implemented, so there should never be real CPUs
which have TSC scaling but *not* CONSTANT_TSC.

Such a combination could potentially happen in some odd L1 nesting
environment, but it isn't worth trying to support it. Just make the
dependency explicit.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/svm/svm.c | 3 ++-
 arch/x86/kvm/vmx/vmx.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0f3b59da0d4a..4d3ec1c3231e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5202,7 +5202,8 @@ static __init int svm_hardware_setup(void)
 		kvm_enable_efer_bits(EFER_FFXSR);
 
 	if (tsc_scaling) {
-		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR)) {
+		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR) ||
+		    !boot_cpu_has(X86_FEATURE_CONSTANT_TSC)) {
 			tsc_scaling = false;
 		} else {
 			pr_info("TSC scaling supported\n");
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6780313914f8..bee830adf744 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8428,7 +8428,7 @@ __init int vmx_hardware_setup(void)
 	if (!enable_apicv || !cpu_has_vmx_ipiv())
 		enable_ipiv = false;
 
-	if (cpu_has_vmx_tsc_scaling())
+	if (cpu_has_vmx_tsc_scaling() && boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
 		kvm_caps.has_tsc_control = true;
 
 	kvm_caps.max_tsc_scaling_ratio = KVM_VMX_TSC_MULTIPLIER_MAX;
-- 
2.44.0


