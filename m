Return-Path: <linux-kselftest+bounces-34279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73910ACD763
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 07:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1AD177299
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 05:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C982641E2;
	Wed,  4 Jun 2025 05:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tyijCt5z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD79D262FEB
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749013751; cv=none; b=E/BWgBLdhBftSVtlU+LIIJbE91vcxLr3YdtMBj6rs+V3KjP/J61TqYGUHI7K16kuebAhSHKumXHs++0HHD1HI63felfzzC08um6co8CMkVQKn2KpqRmqFP/EzrvWXh+6WkwQC91qHn0l9aAGKP7VzxvvbFJQO7WXLBpdbb0KDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749013751; c=relaxed/simple;
	bh=HrX0Qja7cb4tAXkvQ2mG5WKvRaCqmmGoaock8a28YSg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nEk94tY+cD7X3c5Y2GzgcIYM8eBk7QUx+yZRbRMwhr4jP3IovD69yLqsTzPIIOBAkhf7dbiMMfiAioQrmyWWOLz6AGS90p6tXbNihEenMYIE8zkxctBL+Sndjm6P7waQQNk1ND4qW0gfb7mNX5l+vzbh7zLFbIQlKKd2D3kr63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tyijCt5z; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b0f807421c9so3996193a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 22:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749013749; x=1749618549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhgMslLmRs4t+ePEWLcUkFGdBSYtjx3MY6fMyfCWERc=;
        b=tyijCt5zBxcu++Z/Mx/ACGgjHGIRvsP2ViTKhCJGsq77CGONTdgUO6vFsnutWi/Qi8
         Gvnl5kuto/PpudPsjlOAw2ThZrL4k4RIO626f1YhkkwGQR7A2Qtl6H5Wd3dunwPFcbaW
         uugleC1i7Ez9EER835XKkBuVrp1W6HIRDfUsoabVJOWf6NS1VWbc1isTubcXJvxgBhry
         6shFOW+54Wm5NgEemVEC6oovMQ0znby1oKoMkiAE8BVmf/Rw9FQPtbeBN51GZMNpA+wS
         dyxHbrcH7tA/Dk+iLKjH46DGUtyeqjk/y0Nl8b8XsgJEN996H6namID/kyUCXh83+0FV
         tnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749013749; x=1749618549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhgMslLmRs4t+ePEWLcUkFGdBSYtjx3MY6fMyfCWERc=;
        b=hHTSwkGyA8Xy33pWIa54t+563iRcRHQPj2uRxaVdjX1fsZRFpVgXtGjs30OD8q7aaG
         K0Yo/N2UQdalGbUy2sF9s8WSdJXKLXIzaJjYF1PZZHqGyM03iSBtM0wQHijXIYY//8JT
         V2Sa91Vy6mogPRWoWFGIkIVuv12COatzqERBKKdRNYEvXdZOXXtp9Ej+Sg8mFCfVz3HE
         QIABIpKwb5UYAaQ72vILyShfku06aIvHkONLDezrfxnDpLxVyHttB+SsZMx3b2ZrMt0K
         XFmCYi36iV3fMJFkzUc18FL8vHgzfzQsCpEuibcQZiqLdOsnBLb3c26vG1FrAGNfYO8U
         5cKw==
X-Forwarded-Encrypted: i=1; AJvYcCWMyjdjQWtwpj0ZK5PdpjZ8Sa/weV4zTdy1DJbhS97i2nNngtgHADQfTRMmPA+1csR2e36kjPOZrme+d6QkVrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwegbEoyj9d+ELS3IdwrhqPcnBHXALmCYFL4NNpWzVkc4BSu9TB
	AALlUbVZTNNePrO08uVdoGTHCqhbmIbKYcC5Uvqun7okHazoSpRehV7syOoTQtY/iJlzCoAGA0o
	a84aWR7TbXDrljw==
X-Google-Smtp-Source: AGHT+IEYYVafnZZHkiG6O7O7lpguUgqLHBjMZ6tioGx87coJ7IpiOn+YvorcADDV9YLWFVwLHCGsICKRIiQ8ag==
X-Received: from pjbsw7.prod.google.com ([2002:a17:90b:2c87:b0:2ea:29de:af10])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d47:b0:30e:9349:2da2 with SMTP id 98e67ed59e1d1-31310fc4f67mr1580065a91.4.1749013748995;
 Tue, 03 Jun 2025 22:09:08 -0700 (PDT)
Date: Wed,  4 Jun 2025 05:08:58 +0000
In-Reply-To: <20250604050902.3944054-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604050902.3944054-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604050902.3944054-4-jiaqiyan@google.com>
Subject: [PATCH v2 3/6] KVM: arm64: Allow userspace to inject external
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

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
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
index 99e0c6c16e437..78e8a82c38cfc 100644
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
index 4fed3fdfb13d6..2fc3775ac1183 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -943,6 +943,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_EL2 240
 #define KVM_CAP_ARM_EL2_E2H0 241
 #define KVM_CAP_ARM_SEA_TO_USER 242
+#define KVM_CAP_ARM_INJECT_EXT_IABT 243
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.49.0.1266.g31b7d2e469-goog


