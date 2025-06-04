Return-Path: <linux-kselftest+bounces-34282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C4DACD771
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 07:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3683218980BA
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 05:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573DC265CDF;
	Wed,  4 Jun 2025 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1E5mJqh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6579264A95
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749013756; cv=none; b=lgzd4UUZi6ZiUv37yeq+Cs0INTc/ruUtj97CrFTjGquTt6q04bv0bmaoFC1yLsYVryerld3ITQLLIMWwI6uSXNzDv8sUGCcgyDvCy02Ed3wVz3A6bTeQlclC/5jotIxVPh+zV33tF9auj1KAOR4zj6eDpX1pfVwOhkjRffZbCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749013756; c=relaxed/simple;
	bh=0gfkpc4dNi2Ih4MnTfuUct9EpQso8+ggaMkVuPeWOTc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jm9EqSY344ofgP2Kan4x4uZnVAz2am8nrYc3gc8dUIhct6EOXdKekOAP7NWZl72dUVeRontySPYRFnx2FsQodZfHiFBe5wvkkue9IF7WkB33FBU6LiV4BtgEexjuaNWyAaLpy9SGx4ZVpDRGBczuJ8Vn/FonvP1a/QcAsg36elo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t1E5mJqh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311fa374c2fso8525222a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 22:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749013753; x=1749618553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1C4xwS1oja4BGMpJEnpH51GbWTCvJSr7fg34G4M8Z0=;
        b=t1E5mJqh4c0whgKHdU6foUxlAR874KIYhiRVwf85M4p3AJv03NwGLnpXVwdZKlBWSe
         4ma2bQc9dj6S8FbA5kaWHlUUKY3rXgtQPQWAUo3GPGPEz8uCh77MgBnj4V3/w2BVvN2A
         ILCeLFFlgybnbKKv5E/dGHIJC7C8ODJmbpIF430ZpBXcs9ox3o07yYVL1JtebAUsjHbn
         Ef2p79Uc6YNZtUFXMYzM6JhHxUE4rRxOWwTt3n+95N7b3zP6sAy8yI7dkFMUv6xkCueA
         Q/nIDSDhgm2j4bNkTdcdFx+W3yPolV1gG+0F+twlAi/pyvjZoV9fR6XFWoWZaRkTXbnt
         MVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749013753; x=1749618553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1C4xwS1oja4BGMpJEnpH51GbWTCvJSr7fg34G4M8Z0=;
        b=symvVUj5ZDVZKIXVpH2UTKwe+RkNV8qWY7HlK40otiaM85yYyi2Z0/XKsqPl3qdEyb
         2NB/kev+JAKoy765GP5wEiLHN1/PbIalDUmuw65MGwkMAJi4YHpA/jlcmkuZ6/C4GTuk
         WBdPkP19a+1i3VoedBOkU25FqomMEjqhM0PQ/H4ZfRvsfUvS8TtYP7KxljD184/LbHzY
         vggD0PAtN0qJ8F8M8tLQFST/09ZWwz4MkUoongqyOQUIl4riE21RnlRzEssCViSG7r3x
         BcYh8HHKTJcP+BzY7MTo8llSjyBn/Dzxdwgc3UjcZWUQ5uCx7IIZQZY1hqOMtA1vTibO
         kzIA==
X-Forwarded-Encrypted: i=1; AJvYcCVEm3WO9AQyQiuBc6PwYIyk4UM8Qs4OwgyiUKmSwoC4MgBpJZ8PU4AQn5yBLEZWX6qenggcKSxV3DkcVvvpuGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHrCppOJvRI8osP+aoxknznmTJqNFuTwDsdiifzE3vpK2WYzAw
	FmMyCViwtFn2TpSChhrRruQZhXT4n5kCcOw9CoBddUmE/siAj1uxf0H5XkIZydCUpGOX07e1pvX
	fHwCIhVBuXk63GQ==
X-Google-Smtp-Source: AGHT+IE37oF7FCdLRpvsoThAtQNnQsYjorBYGpuYCRvh2E+9sV6A3UsbG7Yq0ZEVRpNgSOSMEJKUi/G7O4PeZg==
X-Received: from pjbpw6.prod.google.com ([2002:a17:90b:2786:b0:311:4201:4021])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:35c6:b0:30e:ee4:3094 with SMTP id 98e67ed59e1d1-3130ccf5129mr2212286a91.1.1749013752906;
 Tue, 03 Jun 2025 22:09:12 -0700 (PDT)
Date: Wed,  4 Jun 2025 05:09:01 +0000
In-Reply-To: <20250604050902.3944054-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604050902.3944054-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604050902.3944054-7-jiaqiyan@google.com>
Subject: [PATCH v2 6/6] Documentation: kvm: new uAPI for handling SEA
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

Document the new userspace-visible features and APIs for handling
synchronous external abort (SEA)
- KVM_CAP_ARM_SEA_TO_USER: How userspace enables the new feature.
- KVM_EXIT_ARM_SEA: When userspace needs to handle SEA and what
  userspace gets while taking the SEA.
- KVM_CAP_ARM_INJECT_EXT_(D|I)ABT: How userspace injects SEA to
  guest while taking the SEA.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 Documentation/virt/kvm/api.rst | 128 +++++++++++++++++++++++++++++----
 1 file changed, 115 insertions(+), 13 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index fe3d6b5d2acca..c58ecb72a4b4d 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1236,8 +1236,9 @@ directly to the virtual CPU).
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
@@ -1292,20 +1293,57 @@ ARM64:
 
 User space may need to inject several types of events to the guest.
 
+Inject SError
+~~~~~~~~~~~~~
+
 Set the pending SError exception state for this VCPU. It is not possible to
 'cancel' an Serror that has been made pending.
 
-If the guest performed an access to I/O memory which could not be handled by
-userspace, for example because of missing instruction syndrome decode
-information or because there is no device mapped at the accessed IPA, then
-userspace can ask the kernel to inject an external abort using the address
-from the exiting fault on the VCPU. It is a programming error to set
-ext_dabt_pending after an exit which was not either KVM_EXIT_MMIO or
-KVM_EXIT_ARM_NISV. This feature is only available if the system supports
-KVM_CAP_ARM_INJECT_EXT_DABT. This is a helper which provides commonality in
-how userspace reports accesses for the above cases to guests, across different
-userspace implementations. Nevertheless, userspace can still emulate all Arm
-exceptions by manipulating individual registers using the KVM_SET_ONE_REG API.
+Inject SEA (synchronous external abort)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- If the guest performed an access to I/O memory which could not be handled by
+  userspace, for example because of missing instruction syndrome decode
+  information or because there is no device mapped at the accessed IPA.
+
+- If the guest consumed an uncorrected memory error, and RAS extension in the
+  Trusted Firmware chooses to notify PE with SEA, KVM has to handle it when
+  host APEI is unable to claim the SEA. For the following types of faults,
+  if userspace has enabled KVM_CAP_ARM_SEA_TO_USER, KVM returns to userspace
+  with KVM_EXIT_ARM_SEA:
+
+  - Synchronous external abort, not on translation table walk or hardware
+    update of translation table.
+
+  - Synchronous external abort on stage-1 translation table walk or hardware
+    update of stage-1 translation table, including all levels.
+
+  - Synchronous parity or ECC error on memory access, not on translation table
+    walk.
+
+  - Synchronous parity or ECC error on memory access on stage-1 translation
+    table walk or hardware update of stage-1 translation table, including
+    all levels.
+
+Note that external abort or ECC error on memory access on stage-2 translation
+table walk or hardware update of stage-2 translation table does not results in
+KVM_EXIT_ARM_SEA, even if KVM_CAP_ARM_SEA_TO_USER is enabled.
+
+For the cases above, userspace can ask the kernel to replay either an external
+data abort (by setting ext_dabt_pending) or an external instruction abort
+(by setting ext_iabt_pending) into the faulting VCPU. KVM will use the address
+from the existing fault on the VCPU. Setting both ext_dabt_pending and
+ext_iabt_pending at the same time will return -EINVAL.
+
+It is a programming error to set ext_dabt_pending or ext_iabt_pending after an
+exit which was not KVM_EXIT_MMIO, KVM_EXIT_ARM_NISV or KVM_EXIT_ARM_SEA.
+Injecting SEA for data and instruction abort is only available if KVM supports
+KVM_CAP_ARM_INJECT_EXT_DABT and KVM_CAP_ARM_INJECT_EXT_IABT respectively.
+
+This is a helper which provides commonality in how userspace reports accesses
+for the above cases to guests, across different userspace implementations.
+Nevertheless, userspace can still emulate all Arm exceptions by manipulating
+individual registers using the KVM_SET_ONE_REG API.
 
 See KVM_GET_VCPU_EVENTS for the data structure.
 
@@ -7163,6 +7201,58 @@ The valid value for 'flags' is:
   - KVM_NOTIFY_CONTEXT_INVALID -- the VM context is corrupted and not valid
     in VMCS. It would run into unknown result if resume the target VM.
 
+::
+
+    /* KVM_EXIT_ARM_SEA */
+    struct {
+      __u64 esr;
+  #define KVM_EXIT_ARM_SEA_FLAG_GVA_VALID   (1ULL << 0)
+  #define KVM_EXIT_ARM_SEA_FLAG_GPA_VALID   (1ULL << 1)
+      __u64 flags;
+      __u64 gva;
+      __u64 gpa;
+    } arm_sea;
+
+Used on arm64 systems. When the VM capability KVM_CAP_ARM_SEA_TO_USER is
+enabled, a VM exit is generated if guest causes a synchronous external abort
+(SEA) and the host APEI fails to handle the SEA.
+
+Historically KVM handles SEA by first delegating the SEA to host APEI as there
+is high chance that the SEA is caused by consuming uncorrected memory error.
+However, not all platforms support SEA handling in APEI, and KVM's fallback
+handling is to inject an async SError into the guest, which usually panics
+guest kernel unpleasantly. As an alternative, userspace can participate into
+the SEA handling by enabling KVM_CAP_ARM_SEA_TO_USER at VM creation, after
+querying the capability. Once enabled, when KVM has to handle the guest
+caused SEA, it returns to userspace with KVM_EXIT_ARM_SEA, with details
+about the SEA available in 'arm_sea'.
+
+The 'esr' field holds the value of the exception syndrome register (ESR) while
+KVM taking the SEA, which tells userspace the character of the current SEA,
+such as its Exception Class, Synchronous Error Type, Fault Specific Code and
+so on. For more details on ESR, check the Arm Architecture Registers
+documentation.
+
+The 'flags' field indicates if the faulting addresses are valid while taking
+the SEA:
+
+  - KVM_EXIT_ARM_SEA_FLAG_GVA_VALID -- the faulting guest virtual address
+    is valid and userspace can get its value in the 'gva' field.
+  - KVM_EXIT_ARM_SEA_FLAG_GPA_VALID -- the faulting guest physical address
+    is valid and userspace can get its value in the 'gpa' field.
+
+Userspace needs to take actions to handle guest SEA synchronously, namely in
+the same thread that runs KVM_RUN and receives KVM_EXIT_ARM_SEA. One of the
+encouraged approaches is to utilize the KVM_SET_VCPU_EVENTS to inject the SEA
+to the faulting VCPU. This way, the guest has the opportunity to keep running
+and limit the blast radius of the SEA to the particular guest application that
+caused the SEA. If the Exception Class indicated by 'esr' field in 'arm_sea'
+is data abort, userspace should inject data abort. If the Exception Class is
+instruction abort, userspace should inject instruction abort. Userspace may
+also emulate the SEA to VM by itself using the KVM_SET_ONE_REG API. In this
+case, it can use the valid values from 'gva' and 'gpa' fields to manipulate
+VCPU's registers (e.g. FAR_EL1, HPFAR_EL1).
+
 ::
 
 		/* Fix the size of the union. */
@@ -8490,7 +8580,7 @@ ENOSYS for the others.
 When enabled, KVM will exit to userspace with KVM_EXIT_SYSTEM_EVENT of
 type KVM_SYSTEM_EVENT_SUSPEND to process the guest suspend request.
 
-7.37 KVM_CAP_ARM_WRITABLE_IMP_ID_REGS
+7.42 KVM_CAP_ARM_WRITABLE_IMP_ID_REGS
 -------------------------------------
 
 :Architectures: arm64
@@ -8508,6 +8598,18 @@ aforementioned registers before the first KVM_RUN. These registers are VM
 scoped, meaning that the same set of values are presented on all vCPUs in a
 given VM.
 
+7.43 KVM_CAP_ARM_SEA_TO_USER
+----------------------------
+
+:Architecture: arm64
+:Target: VM
+:Parameters: none
+:Returns: 0 on success, -EINVAL if unsupported.
+
+This capability, if KVM_CHECK_EXTENSION indicates that it is available, means
+that KVM has an implementation that allows userspace to participate in handling
+synchronous external abort caused by VM, by an exit of KVM_EXIT_ARM_SEA.
+
 8. Other capabilities.
 ======================
 
-- 
2.49.0.1266.g31b7d2e469-goog


