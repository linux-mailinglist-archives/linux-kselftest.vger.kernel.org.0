Return-Path: <linux-kselftest+bounces-8973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 947A08B45D5
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC262B2175E
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E098F4AEEC;
	Sat, 27 Apr 2024 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cmn7aYhf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C55495CC;
	Sat, 27 Apr 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216785; cv=none; b=ey8EDXetESwbmn18W6XLAzijjbV4KnTWXB5Aet5A9a2P+8A3Fr4xIhcMBw8TjI6SYmp3zMtdsJkdiX1Iazx7WxiNi7ATUV8n1gH+1SXu1vIiHjszF24PMU8Biaqvo0c9DAIpmeP9e674NPjQOCHvRs4jJEi2xdReKy4ajT7FS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216785; c=relaxed/simple;
	bh=iOmvqV+vbYDKZG4Z0hPkoNLgaOP2tzUKcwotb2WDGfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrfr90tgWZdeM2481wSJT4veZnljYL3vuAX0oqGzn7hVc/cg+U1ySGa27ajsTEZy0CqhcGYUJgHIzFOL8jT0IVZcX7PJ+IHEdpIRCx4kdB/F4lGM7jxEzZTpkNxQv/lufRdsNIRXHnXVxYoSt8KSRjUHO415ZeEiYrHefyge2so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cmn7aYhf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vQRg8jTSE/w84X85rubENd1tTskSzNXDiSVdMmVU2k0=; b=cmn7aYhfwh7DslkWnh5DqUZEIx
	j9fX5K6GH0V9zbxwMg3+0ZIl9hHP+KQ/z/B9Zv/oQRJg/gjuQlViVmqmce4HtfXOe0GtacMer0Vzk
	ES7aVffN34pEVqZkTxXUuvI5QTx1wLclppF/bBswcoiRkHXhVTE1vKS1ZpKfSIAki1+2o9lp6Z8Cs
	pS2/wSeYj7ddIwxXXJnQzFI+HUTvkJi9QDt/9dr1yQ4mkIPAmGGaNVt/LlSWXd+cN7NZp3bIkzNnr
	T0gUJY0VuLBoesPKzPyxKkz35NojO96EiIEIzm2ONrbz1Fp0RiCYAfXCBOXkHblB2MhnbJpKQWrGL
	x90YaXoQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5g-00000007Jwj-2Dkw;
	Sat, 27 Apr 2024 11:19:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5g-000000002bJ-0XQk;
	Sat, 27 Apr 2024 12:19:36 +0100
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
	sveith@amazon.de,
	zide.chen@intel.com,
	Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH v2 05/15] KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
Date: Sat, 27 Apr 2024 12:05:02 +0100
Message-ID: <20240427111929.9600-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240427111929.9600-1-dwmw2@infradead.org>
References: <20240427111929.9600-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

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
Reviewed-by: Paul Durrant <paul@xen.org>
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


