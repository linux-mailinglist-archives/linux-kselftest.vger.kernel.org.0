Return-Path: <linux-kselftest+bounces-32394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B52AA987D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34915189F137
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC51A26B2C8;
	Mon,  5 May 2025 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y3GC/6Ew"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB7326B0A9
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461663; cv=none; b=ljQMX+Hf/+8gbytV3d06kW+5kMaDu3fVt+t+Joy3h4p3ewjQ900AZn7H8LMkPQ+Jb5xK+7VpAB253Wmzb17wQOlWeA8b0WP/k4JkAjJ0sNyXsd+sBfTF4BC7NE3D8ZImcE8uDSYdwEHl0kiwJCVd/Jm5eTuykghWUr6gzrFD7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461663; c=relaxed/simple;
	bh=WNmcRnW25SuTNW/fidnyuzaC0ufF7CU/QhzVlk6Eyk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QWYqJeQgFTITREaXQnZEaghpzsWlruRc4zcXsfmoWzrIXcrzl8Qn6xGsyx/8zzVBXDEhcGQYD8fz4f1c1pye0o8PKlElidF2ftsym9TW45rgEWX+YZFFGwM6juONj+cmz9bOSrI+l59TN97YDJnL2sM7W4e1XeGoz1bhctHuRRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y3GC/6Ew; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242ade807fso71333905ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746461660; x=1747066460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ih0/JpStngeu2lOMQmMMElA7ojSkXNH4xy6u5tdpksc=;
        b=y3GC/6EwVjLQsC9dtPwGfK31ngSOH8Y2h2UeLmZBn9r2UE375VLvVmiG0EBCmseboa
         sCCpM/i9ylGQL6AHx+v1eevWwgUOzrafX+C5dprIS/3CO89MkccX79RBAX1/X0diBLef
         luxSwCZKwYwJh2iHmIN2bk4s2A02SxhWk6o4cOjLy+vsJvR731lEkkhS9C8ePyC8W8Hg
         +737TdUPDpMFcEITdumJ3UAs2roxubWZtsDJUK/FWFq1CdEKx+3YANN6A25F+e+eR5H2
         G+Li3rXUxZYP0p2azMmWBnQbbeKWIcS15Pd7zhgK3CTPmbIl/ZBk5qQpltd6q/WCPBVF
         nzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746461660; x=1747066460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ih0/JpStngeu2lOMQmMMElA7ojSkXNH4xy6u5tdpksc=;
        b=OdTdVhSR6djf2diUQ2bF6oSqQf/DqTeidgqSoiJfrycrLS0hyt5nx20+c4HTw/wYyJ
         RtW+8SZspAa+fPeCyYDyOCUePtdRHBz1rsB8R7k3tqQjlK55wHnkwRDN67+pBHR8jkDY
         Pw2M5OS5RkHcmIZxJoKl/yotjVb6lUczl3QY47Ma2MH4qn16OlteOBn1tVOh9W3csbjX
         +epW6Vj3td4vjh1wQ2pp1Gp4JyILfk2ErMDGLzGaRx0W4mzmAj4xPEzb7VXTZORSFEl0
         P7BN/21vicckvtRSQ4gSVr+NIlgLRcaEZte6ILlNX1X/v51sWbdxSiMAzPgJP5NUxaMp
         h5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcL2TZLLN+IRjGs52O8TjeZdFmQZNNVi1kuk6V3P57q1690s69Ko00W9em+6460jvfC7tAE2Ap+0goVyBiN+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrC0NlEDuXpjyT2g3S2GqDX00J1d67OywApizG3M/8ovPujE1S
	l83H2nh2NfLNlHjzfWjdZVzdEMzZ4jksz7yQIiZY7fSGDFxmHxCRQm59Q1GCLYjKNGvdqBg4eQB
	SMa2yF8QrAg==
X-Google-Smtp-Source: AGHT+IEALx06q4ifLBOjCQ9ZZOZ/gQJWNi+Q92PHdvJDeENKCM2QDj0Em0rsjG/Q7RXdhODS4FzwytaIsf6wMQ==
X-Received: from pfvo15.prod.google.com ([2002:a05:6a00:1b4f:b0:73d:b1c6:c137])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f683:b0:224:f12:3734 with SMTP id d9443c01a7336-22e1ea87368mr99744415ad.30.1746461659950;
 Mon, 05 May 2025 09:14:19 -0700 (PDT)
Date: Mon,  5 May 2025 16:14:09 +0000
In-Reply-To: <20250505161412.1926643-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250505161412.1926643-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505161412.1926643-4-jiaqiyan@google.com>
Subject: [PATCH v1 3/6] KVM: arm64: Allow userspace to inject external
 instruction aborts
From: Jiaqi Yan <jiaqiyan@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	duenwen@google.com, rananta@google.com, jthoughton@google.com, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Raghavendra Rao Ananta <rananta@google.com>

When KVM returns to userspace for KVM_EXIT_ARM_SEA, the userspace is
encouraged to inject the abort into the guest via KVM_SET_VCPU_EVENTS.

KVM_SET_VCPU_EVENTS currently only allows injecting external data aborts.
However, the synchronous external abort that caused KVM_EXIT_ARM_SEA
is possible to be an instruction abort. Userspace is already able to
tell if an abort is due to data or instruction via kvm_run.arm_sea.esr,
by checking its Exception Class value.

Extend the KVM_SET_VCPU_EVENTS ioctl to allow injecting instruction
abort into the guest.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/include/uapi/asm/kvm.h |  3 ++-
 arch/arm64/kvm/arm.c              |  1 +
 arch/arm64/kvm/guest.c            | 13 ++++++++++---
 include/uapi/linux/kvm.h          |  1 +
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index ed5f3892674c7..643e8c4825451 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -184,8 +184,9 @@ struct kvm_vcpu_events {
 		__u8 serror_pending;
 		__u8 serror_has_esr;
 		__u8 ext_dabt_pending;
+		__u8 ext_iabt_pending;
 		/* Align it to 8 bytes */
-		__u8 pad[5];
+		__u8 pad[4];
 		__u64 serror_esr;
 	} exception;
 	__u32 reserved[12];
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 47544945fba45..dc2efb627f450 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -319,6 +319,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_IRQ_LINE_LAYOUT_2:
 	case KVM_CAP_ARM_NISV_TO_USER:
 	case KVM_CAP_ARM_INJECT_EXT_DABT:
+	case KVM_CAP_ARM_INJECT_EXT_IABT:
 	case KVM_CAP_SET_GUEST_DEBUG:
 	case KVM_CAP_VCPU_ATTRIBUTES:
 	case KVM_CAP_PTP_KVM:
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 2196979a24a32..4917361ecf5cb 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -825,9 +825,9 @@ int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 		events->exception.serror_esr = vcpu_get_vsesr(vcpu);
 
 	/*
-	 * We never return a pending ext_dabt here because we deliver it to
-	 * the virtual CPU directly when setting the event and it's no longer
-	 * 'pending' at this point.
+	 * We never return a pending ext_dabt or ext_iabt here because we
+	 * deliver it to the virtual CPU directly when setting the event
+	 * and it's no longer 'pending' at this point.
 	 */
 
 	return 0;
@@ -839,6 +839,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 	bool serror_pending = events->exception.serror_pending;
 	bool has_esr = events->exception.serror_has_esr;
 	bool ext_dabt_pending = events->exception.ext_dabt_pending;
+	bool ext_iabt_pending = events->exception.ext_iabt_pending;
 
 	if (serror_pending && has_esr) {
 		if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
@@ -852,8 +853,14 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 		kvm_inject_vabt(vcpu);
 	}
 
+	/* DABT and IABT cannot happen at the same time. */
+	if (ext_dabt_pending && ext_iabt_pending)
+		return -EINVAL;
+
 	if (ext_dabt_pending)
 		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
+	else if (ext_iabt_pending)
+		kvm_inject_pabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 
 	return 0;
 }
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 79dc4676ff74b..bcf2b95b79123 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -941,6 +941,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_X86_GUEST_MODE 238
 #define KVM_CAP_ARM_WRITABLE_IMP_ID_REGS 239
 #define KVM_CAP_ARM_SEA_TO_USER 240
+#define KVM_CAP_ARM_INJECT_EXT_IABT 241
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.49.0.967.g6a0df3ecc3-goog


