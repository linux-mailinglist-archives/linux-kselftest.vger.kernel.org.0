Return-Path: <linux-kselftest+bounces-46210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5582FC78B00
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BBBD362EB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67509346E69;
	Fri, 21 Nov 2025 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRQ0dWgl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820CA3321C2
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723487; cv=none; b=Wf7edmwqj4W8T2XbvWM+PqQhJigaYWIBvlQ0PHEi1gbcZLkdUkyZosWIkZydiuRT7vmopKbHwhYwnGxlMH9AnNloC5go6RgeRCF9Qmjrak6a/K0rixLGDPCJSuoY6QeaO6T+KY8gi+2J2k/0RVMub4Jmh9u9HeO1l2GlyLfymDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723487; c=relaxed/simple;
	bh=GTh03DnovL1IfXrIJWOOWsXVB4KulpyzdpPOxbFjAXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJJOWYMRH7GBzDWhcSUzu0o1BfFkf3AwHKObZgzcFaWz/+bDWgArM9VxHNUUtAHD+gQpI0Ad5/FHXJ1YiwabGRh6Ykyq2v6CXzi0et79BdJHMNpxGEv/4DFAbk/C4YapVaRAff+QJb84RFtQD1wumJ4fPqHwb7WxnXj2C2WcREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRQ0dWgl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b31c610fcso1634791f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 03:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723484; x=1764328284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2msaF/pghuykVBiKeYLpA2uXeztIpV3HBLG8Kfba9b0=;
        b=NRQ0dWglCzb6OKJfkoLo+VryyIaJKNwPiLDqsNKZ3Lxsu3fnHYc/hqSU+aH5pZrsD0
         YEXVg8dC4RHNcNc+KHz/EOeRIAdFfIhYvcrw1nTw3JIE8KRxMn+kmfLPiyddBLSK9Orh
         UzV74q7zMcu542GGnCWSlfV3FxJnBZClVtu6PMyoZ96GhzqZ2bVQ/jmImXcZK6y1uve4
         i/b7ySFkC1wKd4LHHaZE/9l+K2GGNj+JJhFU/oLuBv5sQJE+Mfvb6XvscchFyU3kM8AI
         r1a/yWUzzfxUfk20/QX31Cjc2jtnkvdD8jsS2PnVP+U/skPSm176r4Fu/N3m829hK5CQ
         nJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723484; x=1764328284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2msaF/pghuykVBiKeYLpA2uXeztIpV3HBLG8Kfba9b0=;
        b=NQsriZmZZ83HZmG+eD4IYVC4+QqEWWyLrWl6sATHf4KAEznPyipAosomgsvLi77dS+
         cZCK7xPk5vt28xFWlfo5fsHKHpKZ7LIlQJfTXR3NRgOeGuOxOVbznLwAoDtPWJXgLjA4
         HXT/vDiYRpTCYCzd9om+zq2/6HEepldmkgNGPcg5EK7PuWvIh4GboIsAPHE5tQW7BaRE
         vHbg6dY318lLxXUFMTxjW7U61FeNvUiAgBgaZrE8ow0xy9fxI+5888mn/10cPRveBFCC
         ZdXC7YzcVes283fdFaI1DAqBQsvbLC0T5c5IeOjGslPDgAErNz9mwo4m0JCUHrPfXPhR
         Ax/w==
X-Forwarded-Encrypted: i=1; AJvYcCWe0GRJv8lwq43kSJic+ZaJeA7dVHIszL4J+DsCTfbUIVoFoyzi9NQU/qIuFLSrUrRYFpjwZRUgtmq+g/YB6ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkeVwcn0xLBUTfRuCBGC8xvuB+n9rXkZYjH3yp6dDgnVHKRe5m
	oP+I9+OclYWWbRQxdpnQ5eJv6nCvoVU9vBkYLl6xsF6PKKIkXrSnxu+l
X-Gm-Gg: ASbGncvRQpdCUr04i+YThcU62lNAQCSv0UaLiorjocyof4NLizuecM1+RcVDY81d6BF
	L2b1OOygURihzealyQiV3FcDO1rrnJz+QjtQFGaixilseKHZoXoGHyvcNGAN1jxO8SoQjnsmXYp
	Bou2gp+FDZggUDoKTW62ZERZMGllqIXxRwo9pmuOFnNExk0zYmf+gIXticMoj9+SSLvYCZt7M4J
	xxazgLfv4bl3khtIAC6JgYLpppoaOfndD0FS9zZ2GlucTPJpFp4dcUErHespOAd5IhQpSQXQJaI
	Nu8tof9Ed+G6fHyO2e4p6e3E5mPYJn7x4n8YunkR2goszFYcDfn7Z5sthd8vO9lmUEgFfsEP6k3
	u17MHRAhZcOBR4nr4JKmZeY7ZMc5S+M1CZzD6Qswo4J37/OabyUKaait7XjFsa+wX/XqI544loF
	IhBz+HbkqtFPGy1i2ZRKfyQs/DI1DvrxhZI21U3OatlULCTJiinwpV6zzTWwbGpfMX1jmMrCPr/
	DkMR7s2YJJr5NnkUKr8M/wBip9S3ygS
X-Google-Smtp-Source: AGHT+IHo5C0rwkC/ovLdq93KgTIAbuzG1TA3/TDefcWM5XOmUmrdZ1+NEnJ8PSLvBfBcBoCYrETpjg==
X-Received: by 2002:a05:6000:40c7:b0:429:9323:2bec with SMTP id ffacd0b85a97d-42cc1d1981dmr2054714f8f.40.1763723483713;
        Fri, 21 Nov 2025 03:11:23 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363e4sm10484180f8f.12.2025.11.21.03.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:11:23 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	vkuznets@redhat.com,
	shuah@kernel.org,
	dwmw@amazon.co.uk,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: [PATCH v3 01/10] KVM: nVMX: Implement cache for L1 MSR bitmap
Date: Fri, 21 Nov 2025 11:11:04 +0000
Message-ID: <20251121111113.456628-2-griffoul@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121111113.456628-1-griffoul@gmail.com>
References: <20251121111113.456628-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

Introduce a gfn_to_pfn_cache to optimize L1 MSR bitmap access by
replacing map/unmap operations. This optimization reduces overhead
during L2 VM-entry where nested_vmx_prepare_msr_bitmap() merges L1's MSR
intercepts with L0's requirements.

Current implementation using kvm_vcpu_map_readonly() and
kvm_vcpu_unmap() creates significant performance impact, mostly with
unmanaged guest memory.

The cache is initialized when entering VMX operation and deactivated
when VMX operation ends.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/kvm/vmx/nested.c | 42 +++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/vmx/vmx.h    |  2 ++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8b131780e981..0de84b30c41d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -315,6 +315,34 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 	vcpu->arch.regs_dirty = 0;
 }
 
+/*
+ * Maps a single guest page starting at @gpa and lock the cache for access.
+ */
+static int nested_gpc_lock(struct gfn_to_pfn_cache *gpc, gpa_t gpa)
+{
+	int err;
+
+	if (!PAGE_ALIGNED(gpa))
+		return -EINVAL;
+retry:
+	read_lock(&gpc->lock);
+	if (!kvm_gpc_check(gpc, PAGE_SIZE) || (gpc->gpa != gpa)) {
+		read_unlock(&gpc->lock);
+		err = kvm_gpc_activate(gpc, gpa, PAGE_SIZE);
+		if (err)
+			return err;
+
+		goto retry;
+	}
+
+	return 0;
+}
+
+static void nested_gpc_unlock(struct gfn_to_pfn_cache *gpc)
+{
+	read_unlock(&gpc->lock);
+}
+
 static void nested_put_vmcs12_pages(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -344,6 +372,9 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
+
+	kvm_gpc_deactivate(&vmx->nested.msr_bitmap_cache);
+
 	free_vpid(vmx->nested.vpid02);
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = INVALID_GPA;
@@ -625,7 +656,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	int msr;
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = vmx->nested.vmcs02.msr_bitmap;
-	struct kvm_host_map map;
+	struct gfn_to_pfn_cache *gpc;
 
 	/* Nothing to do if the MSR bitmap is not in use.  */
 	if (!cpu_has_vmx_msr_bitmap() ||
@@ -648,10 +679,11 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 			return true;
 	}
 
-	if (kvm_vcpu_map_readonly(vcpu, gpa_to_gfn(vmcs12->msr_bitmap), &map))
+	gpc = &vmx->nested.msr_bitmap_cache;
+	if (nested_gpc_lock(gpc, vmcs12->msr_bitmap))
 		return false;
 
-	msr_bitmap_l1 = (unsigned long *)map.hva;
+	msr_bitmap_l1 = (unsigned long *)gpc->khva;
 
 	/*
 	 * To keep the control flow simple, pay eight 8-byte writes (sixteen
@@ -739,7 +771,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
 					 MSR_IA32_PL3_SSP, MSR_TYPE_RW);
 
-	kvm_vcpu_unmap(vcpu, &map);
+	nested_gpc_unlock(gpc);
 
 	vmx->nested.force_msr_bitmap_recalc = false;
 
@@ -5490,6 +5522,8 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 
 	vmx->nested.vpid02 = allocate_vpid();
 
+	kvm_gpc_init(&vmx->nested.msr_bitmap_cache, vcpu->kvm);
+
 	vmx->nested.vmcs02_initialized = false;
 	vmx->nested.vmxon = true;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index ea93121029f9..d76621403c28 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -152,6 +152,8 @@ struct nested_vmx {
 
 	struct loaded_vmcs vmcs02;
 
+	struct gfn_to_pfn_cache msr_bitmap_cache;
+
 	/*
 	 * Guest pages referred to in the vmcs02 with host-physical
 	 * pointers, so we must keep them pinned while L2 runs.
-- 
2.43.0


