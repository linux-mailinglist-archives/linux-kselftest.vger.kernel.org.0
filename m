Return-Path: <linux-kselftest+bounces-32397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFD9AA9888
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90542189F519
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B1D26FA59;
	Mon,  5 May 2025 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjLX4CbE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15426D4E0
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461667; cv=none; b=BjF0XMDipKrOIcyHIKQ4sRblxIFir8t5oNP7j8b5j9gkiFIExaGxfhMEy7F7a619cEpUVocycoJX/RILVfnp4JHiW0VFW8QrpODag9uI8HMft/G2ziXX+djO8TdZr12ocfSh9KyK0cFnBDtpIMstcP9eVfhu0Ec31g2d9UTb7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461667; c=relaxed/simple;
	bh=fyGzyoomoTYo9P/p+ApF12DGGrn8h/VhXiAUSg88UfE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sQq+8TlDD3HhetDhiyK7g3ckH3+A6g5SzzJ4jrjUCM3Tk4xzuXZdZZMOGaruO7/fe3KLlgQvAAD4QyZMSGqcfNkl8LS/5e5YvAgf74Qbte4hZVA6smSEU3tJJnjjQgg9CW9s3KY1wcvi6d1KWRY2+Z/UTsj09Wa3X+lGcq0QqCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JjLX4CbE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736cd36189bso6538250b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746461664; x=1747066464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qCRTPaLL/ddSZCO1i6dVdhSDdFDF5EjuW/HmAYg1Ry0=;
        b=JjLX4CbEoI+2S1VRPgO5cgh/LAQ5gedaYVo9IK9XWCblD8R069jq+QHSdrX9ijz9Na
         x5onDG5LYYy2sjhiu/VwW59NpFhwJ08fm82kGvNJAmx5x+dFABnWuk77ggmHZQhx39Lh
         rtdk9X5PD+H92zftPKpwBRzxKQMQ+cQ/1KllcM/zbSL7zy7nMuuAX2uEqjL5jmUq3Q66
         rp9x983JaJX1PSoMe9RlMvRMfgPIA/vU+DJxwdSbOh8rjuM9Saei/fSXrTXj84kW/Cz2
         Xv+E+kjORA+R6knHiZ+W8ycm5lp30v6pRW5Bzf1RmZMRzkR0bsKS7jPD2KudT05bFDf7
         cS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746461664; x=1747066464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCRTPaLL/ddSZCO1i6dVdhSDdFDF5EjuW/HmAYg1Ry0=;
        b=wG+nV5m/5t7oPU8SMzX/PV1QvtnisIEth63q+V4+kvxy7JU37BpvL75RrYI1BDnERG
         AyY4kQCjvWXOJQLy0D8VRd4ASSvQW7mxnzJ96afMY9JxflzACFN/tafvtLaaOH5h4KT5
         ZYvtyxJ/ZKCvhEDX7DSs+GOLNQTzHS7XSFkl92q4SoS8MTf8ysDDG9rl9I/GHMTV7PQL
         hdH4DQuQG235sZ4Uq92k9V15bZIMjr1J/J6qRcZPmeNelS/M6xqKE+N+EHuz66Z8K75a
         baaMCrDP48ZiDMj/GkZu/GNEhvY2Rg4qLnyt/bu/4dkRt6zCOcGV8WpnHQ/L3smSnkS8
         Urgw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Zw0wdzcfeXT2GBGl/ZYHoKrZ5b041zRoF2xhankymLTQjDGqUiR1HcpPx7dRJA9sAQL/GcUEKqI1H6l0u+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUaNRnHe5ENGdNSYN9u5La71shtSQzsgMBkgovlZwBt5uUzGyA
	C53BdaJoKvq+EP78yyZnvSVtzL9w7rLI5drGipumXMtDpUUH3alhhMqS3eXzrrnzPezhGDltxCe
	PKMq1mC+AOQ==
X-Google-Smtp-Source: AGHT+IE1SVeU3n4ai6CrxrMJm0u9dBQoZvk8Si1b7xa5PwydPXT87LL3o3Oqy2HVQLl3IBAbqfHn31O9UmD3SA==
X-Received: from pfbki23.prod.google.com ([2002:a05:6a00:9497:b0:73d:b1c4:5d7f])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e9d:b0:740:6f7f:7645 with SMTP id d2e1a72fcca58-7406f7f7a1amr12841654b3a.8.1746461664178;
 Mon, 05 May 2025 09:14:24 -0700 (PDT)
Date: Mon,  5 May 2025 16:14:12 +0000
In-Reply-To: <20250505161412.1926643-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250505161412.1926643-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505161412.1926643-7-jiaqiyan@google.com>
Subject: [PATCH v1 6/6] Documentation: kvm: new uAPI for handling SEA
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
 Documentation/virt/kvm/api.rst | 120 +++++++++++++++++++++++++++++----
 1 file changed, 107 insertions(+), 13 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 47c7c3f92314e..fa91a123e1b88 100644
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
@@ -1292,20 +1293,52 @@ ARM64:
 
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
+  Trusted Firmware choose to notify PE with SEA, KVM has to handle it when
+  host APEI is unable to claim the SEA. For the following types of faults,
+  if userspace enabled KVM_CAP_ARM_SEA_TO_USER, KVM returns to userspace with
+  KVM_EXIT_ARM_SEA:
+
+  - Synchronous external abort, not on translation table walk or hardware
+    update of translation table.
+
+  - Synchronous external abort on translation table walk or hardware update of
+    translation table, including all levels.
+
+  - Synchronous parity or ECC error on memory access, not on translation table
+    walk.
+
+  - Synchronous parity or ECC error on memory access on translation table walk
+    or hardware update of translation table, including all levels.
+
+For the cases above, userspace can ask the kernel to replay either an external
+data abort (by setting ext_dabt_pending) or an external instruciton abort
+(by setting ext_iabt_pending) into the faulting VCPU. KVM will use the address
+from the exiting fault on the VCPU. Setting both ext_dabt_pending and
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
 
@@ -7151,6 +7184,55 @@ The valid value for 'flags' is:
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
+	    __u64 gpa;
+    } arm_sea;
+
+Used on arm64 systems. When the VM capability KVM_CAP_ARM_SEA_TO_USER is
+enabled, a VM exit is generated if guest caused a synchronous external abort
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
+The 'esr' filed holds the value of the exception syndrome register (ESR) while
+KVM taking the SEA, which tells userspace the character of the current SEA,
+such as its Exception Class, Synchronous Error Type, Fault Specific Code and
+so on. For more details on ESR, check the Arm Architecture Registers
+documentation.
+
+The 'flags' field indicates if the faulting addresses are available while
+taking the SEA:
+
+  - KVM_EXIT_ARM_SEA_FLAG_GVA_VALID -- the faulting guest virtual address
+    is valid and userspace can get its value in the 'gva' field.
+  - KVM_EXIT_ARM_SEA_FLAG_GPA_VALID -- the faulting guest physical address
+    is valid and userspace can get its value in the 'gpa' filed.
+
+Userspace needs to take actions to handle guest SEA synchronously, namely in
+the same thread that runs KVM_RUN and receives KVM_EXIT_ARM_SEA. One of the
+encouraged approaches is to utilize the KVM_SET_VCPU_EVENTS to inject the SEA
+to the faulting VCPU. This way, the guest has the opportunity to keep running
+and limit the blast radius of the SEA to the particular guest application that
+caused the SEA. If the Exception Class indicated by 'esr' field in 'arm_sea'
+is data abort, userspace should inject data abort. If the Exception Class is
+instruction abort, userspace should inject instruction abort.
+
 ::
 
 		/* Fix the size of the union. */
@@ -8478,7 +8560,7 @@ ENOSYS for the others.
 When enabled, KVM will exit to userspace with KVM_EXIT_SYSTEM_EVENT of
 type KVM_SYSTEM_EVENT_SUSPEND to process the guest suspend request.
 
-7.37 KVM_CAP_ARM_WRITABLE_IMP_ID_REGS
+7.42 KVM_CAP_ARM_WRITABLE_IMP_ID_REGS
 -------------------------------------
 
 :Architectures: arm64
@@ -8496,6 +8578,18 @@ aforementioned registers before the first KVM_RUN. These registers are VM
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
2.49.0.967.g6a0df3ecc3-goog


