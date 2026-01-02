Return-Path: <linux-kselftest+bounces-48061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EB4CEEBF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 15:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE3430213E8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2893128AB;
	Fri,  2 Jan 2026 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/EausUd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C730FC04
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Jan 2026 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767363879; cv=none; b=o4Uj4nhylSIRRJ1FFJH3gDQu2BHGCpva/NZD/76Fj76qlfn6ZN9nZzVPGOc37t1Vf7kGwpDU4UQLV6pW/Y4vfe3KkO8WwVjpDNqNfgGtIvAvv9GsaHoNFAhRmNSM5Zvpkpc+vQgHFecUU8hogE/atceH73AhajFyFTdPpTr4+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767363879; c=relaxed/simple;
	bh=qkJ6JAYcrs+0evRbc1XguSQp/NOkvvUJ6Gu8d9gaFSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5rUG5dzBaQ/DRB1X+mG+biRxHM4ptCZ8z3s9GKfG+kck6CsJuTqjuzsGUZunhU9yo2DX/78qTyhv0nAV7K1UUbMx5IK/ZJ+00nn3eNgVRfoU9c0AgF2fAljwUj7WdhVgWzMfV09JaBnfvjMs0m/01xbG2P36dyok/g1/iBGJ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/EausUd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477632d9326so74213765e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 06:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767363876; x=1767968676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J60Xdi70b8YPTh9aUUDeAbilBIfKKJTZhh0QWhRHf+Y=;
        b=H/EausUdHXNZ0A1lIleMpe4p1RrCjJzvwcNxC/wrXgGVL/VFlfZbRlmg4TN2cICrG7
         7pdvwRFxkE98p62ssHPpTtlQ4fEU/XJ1tWD8/FvPLrivu4ZbtyCu8KRkPVysB+WuY8hZ
         7/upzxUXEb8k1Og0cLZtCE+bPsa7G7zQBaApU/cEW2domU4OKlM1arV0LqNw81VI4pzi
         w++SpLTvBzYFQtsyMJX+VU7ent1stZfEFno4nZCXRCoh5w8BDy3dplTgx3nJRpua5i6H
         JflDWDJDPKieZpqfBPCUJLl8Jync+IrqQOsJyG7va+sDXGISwye5IC33yzh1JyUkNNsR
         02uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767363876; x=1767968676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J60Xdi70b8YPTh9aUUDeAbilBIfKKJTZhh0QWhRHf+Y=;
        b=k+FYNcLSKWHt95kvVIsp01/o3U3FFM9pifJ1O+jE+nP0XO8G6Ko3h21ZinZnXKlPEY
         Pj/6j3msABcoYuCBdzaHO4RyLqdhj1ieDL480GnYie3WcDSj/JyFiMCEV9VooW4x6ILg
         gns7VUEm4qoDYqRqCUegMzUmzvJMn9PjMj1ZfGadbfDF71J2Gn/ajL1P7FCEwUcoYXZe
         PUBh742nuvSo52inJnK9kjH6gqt2ShBtCBj6qdAjA1dW4CBhbaFvo1FrGLIS6NFeJmZU
         pubF1T4Mw8S89vt6eD2ijF/peCuoGm+SkrlfPfbCFIX/QrrXBRYKryuD9ZGaltP+k3A+
         SRBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgAhVoSTjXbY52Zz4S0ccxKZPxAWBExvzxnfcxiLp7At9jDN6AWcEdIPpOh2SWIyd+xCiM65EAvTQCyNQjkqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd9T3nFX/tK6EQCdelzOnT+maBOS9Q5vtJDYL8gCzcu1mZZ2Sz
	Rel4U5mueB/qHh+awQwhlqXXk153CqpKfTTyfGVUTBmw+CjO38nTLeky
X-Gm-Gg: AY/fxX4kbvqDgCKtvlN879oK8IqmyIwTCjQQhN+On/hF+rUy0vozaXYJm4HuGc4fwJi
	/1HlVlEnCbXJkffjXv25X4GgdemtiZbobbCpow07JEweUEwmIy8cfPGQD337mUOwselwPh8K2tG
	70iUCZLBZ5ed6ZxRlau+9aBz5bdGKIT7+m9TPOQAtVzVuANzK2IMQ+ZVz0UdAsZwuAzDMiSeXCz
	eg0FbO1aniHdOQK8KHDFPJu1NXcBiCItDFU3fhinN+rFZLcYkgq9B+3GPpdk43F9Vm2O56pZNlk
	MsT790tyJ7u0kfTULUE2SIN00xH5rNKgGN+LrqYuzV7xYBrTbqlu34TlVVQkqvNpPO32BTyFGi0
	/HOiAHca2bohdM+YIQz3e/GP8VRlnyaHa/B0gJni/JJovBmB+w2F27RDzuUoAIqkp1C3gnRIfAj
	44dcf/F+4uUyBYlISF+nd/6sjwzPnCSpsrXpHeFv8JaG+XeB46EtG8QCi76EAcO6yc/mWlXWRAl
	oe6Eo/p4fZsnjjFQ5jeNukI1kDr64aA
X-Google-Smtp-Source: AGHT+IGQoDeWAiTZoJDZHvtVqUfazfvhk9i0WN4yVtGOa9iSzYJs0aIdX+FO4/q4uGtgO97BYLQWOg==
X-Received: by 2002:a05:600c:64c7:b0:479:1a09:1c4a with SMTP id 5b1f17b1804b1-47d2950b309mr512874395e9.31.1767363875873;
        Fri, 02 Jan 2026 06:24:35 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm806409235e9.13.2026.01.02.06.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 06:24:35 -0800 (PST)
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
Subject: [PATCH v4 01/10] KVM: nVMX: Implement cache for L1 MSR bitmap
Date: Fri,  2 Jan 2026 14:24:20 +0000
Message-ID: <20260102142429.896101-2-griffoul@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102142429.896101-1-griffoul@gmail.com>
References: <20260102142429.896101-1-griffoul@gmail.com>
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
index 6137e5307d0f..f05828aca7e5 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -316,6 +316,34 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
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
@@ -345,6 +373,9 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
+
+	kvm_gpc_deactivate(&vmx->nested.msr_bitmap_cache);
+
 	free_vpid(vmx->nested.vpid02);
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = INVALID_GPA;
@@ -629,7 +660,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	int msr;
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = vmx->nested.vmcs02.msr_bitmap;
-	struct kvm_host_map map;
+	struct gfn_to_pfn_cache *gpc;
 
 	/* Nothing to do if the MSR bitmap is not in use.  */
 	if (!cpu_has_vmx_msr_bitmap() ||
@@ -652,10 +683,11 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
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
@@ -743,7 +775,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
 					 MSR_IA32_PL3_SSP, MSR_TYPE_RW);
 
-	kvm_vcpu_unmap(vcpu, &map);
+	nested_gpc_unlock(gpc);
 
 	vmx->nested.force_msr_bitmap_recalc = false;
 
@@ -5440,6 +5472,8 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 
 	vmx->nested.vpid02 = allocate_vpid();
 
+	kvm_gpc_init(&vmx->nested.msr_bitmap_cache, vcpu->kvm);
+
 	vmx->nested.vmcs02_initialized = false;
 	vmx->nested.vmxon = true;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index bc3ed3145d7e..a6268cddc937 100644
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


