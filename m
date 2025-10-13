Return-Path: <linux-kselftest+bounces-43028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9608FBD5D15
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 20:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4CB18A6FE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AC72DAFBD;
	Mon, 13 Oct 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MiQOklbu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77F2DA740
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381958; cv=none; b=SPW97/TkFdyjwxfl4WKko2EkwCHwuIsUTZcrY5xxkT2Wh0A3wueHwTwf75ImHfzIAzHFPq5kaYAt5fLIRyKIi5axaFr2LtpHBHa1Ma7XCdbrboJlyzBcde2bCzWrNvih5fOnO3a8wmu2AMtl0bwrRmGYG+3qukd2ljCG1eiwqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381958; c=relaxed/simple;
	bh=4FjZOwY6iLfIUw1O3aAoof090jEORs2O09E0JM09G0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H2NSjpurG1lZup/0f17unVWI773lP3wMoUToIjNDkJ1hui+qXg8VqQciGazoprhNkvq9Fk2TFt6pVUg1m4jiiC27ih9qs5KfzMBU5DWtoUKt/+CfSaRS66a5l4lk1ICmO/mNcEoVTEbOLX7ftLA83DNE3VbnRXNMkTGG2/xca+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MiQOklbu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eae48beaaso8574475a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760381956; x=1760986756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUhJwaTYTLlWJW6PvotT0NnhH894vpuEW0sON2hXEJ4=;
        b=MiQOklbuBRewg0P6/TJXUb6SFeHmZ2zaX9lJWr3vgQYYO4opHmnAyECQNHHDOrS+Te
         g1ZvDz03bj6c/OjybuMY8ZR6KeW4Mv3oTo4QVSKO9TNrpDVm40s6Mzo0N3+WZU8Skqh8
         nrsSkIINSzSFbaXatoSImrOZOgIqk4992gqOXaDBeMOfUa+TULT1OCTBPeS7I+3tctmQ
         3pMTppC1PGo3W8DTLdIFj6Z5gShrbD5VsqL74xF2UdcsXP+jO5Pxk5IhNBF0e9/Nvw6h
         uueIfVmIhfYV+aRstH4xn9W08giGMUfK95gevjC0oip8qCAPNMH7UUnjep+t1/aq0y8Z
         N3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760381956; x=1760986756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUhJwaTYTLlWJW6PvotT0NnhH894vpuEW0sON2hXEJ4=;
        b=ecEJoKvDe1lAcgsJ6+uaFtiNAIZQA/uu3efWObG2T1MvEZbEr7/x1LaLJ5vyMn1gMM
         xLoU7ddTQGoT4z0xYWNcJIhhvLsVb1ZaGiPAXmoyZoiKDkah5Xnawk9Zah+x3fhTUIyt
         rk99/sf/+1xbGWvfS6whUPjwvubvPUqQqstj2Y0o+hjlG+MJKkzyV8npsK2a7P3iQ7kS
         NWTqhK4+5t6h4T2XujTopWt4iOVj7it+ZYjDdCeh9lFUn7tCgRDJPDiqLS1ZyjKsEttT
         yqzEhpeaO0M/TNjsu67JqJE4jYmXOS0FQ5FHkxmhBHIXbySUK6oA9kNZBostaC4GVhod
         dRYA==
X-Forwarded-Encrypted: i=1; AJvYcCXNaQpX37n4F83jlLRvfMspk5pMZVpRGe03lJkt/I1tf16TmRgfKwMXJPJQPvgtN8TcpTxkXUPaMsUqyJhLUDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4anbssePxJCSqO2vF7JjGlA/KiWJsCT0OneKFRhFpOOKcHBDw
	lN13RzDmIGPJaqixd0GD0FhrUJkqhG5/h6/2nzzFTpt3pUon8ed65ndIseP0Uj6qjIpHaVdeEQ4
	NnJP+OHLksiGF+w==
X-Google-Smtp-Source: AGHT+IGwypBb0mDfdIn0W0YpuT1qvoN3uirrptacGmPUlbNvOoNVC+pU0bOpfORyj1duGVbXmE/Ph8TFfVXERw==
X-Received: from pjuq15.prod.google.com ([2002:a17:90a:d38f:b0:32e:ae63:2947])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1641:b0:330:4a1d:223c with SMTP id 98e67ed59e1d1-33b5116a6a6mr32151423a91.15.1760381955636;
 Mon, 13 Oct 2025 11:59:15 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:59:03 +0000
In-Reply-To: <20251013185903.1372553-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013185903.1372553-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Message-ID: <20251013185903.1372553-4-jiaqiyan@google.com>
Subject: [PATCH v4 3/3] Documentation: kvm: new UAPI for handling SEA
From: Jiaqi Yan <jiaqiyan@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: duenwen@google.com, rananta@google.com, jthoughton@google.com, 
	vsethi@nvidia.com, jgg@nvidia.com, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Document the new userspace-visible features and APIs for handling
synchronous external abort (SEA)
- KVM_CAP_ARM_SEA_TO_USER: How userspace enables the new feature.
- KVM_EXIT_ARM_SEA: exit userspace gets when it needs to handle SEA
  and what userspace gets while taking the SEA.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 Documentation/virt/kvm/api.rst | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 6ae24c5ca5598..43bc2a1d78e01 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7272,6 +7272,55 @@ exit, even without calls to ``KVM_ENABLE_CAP`` or similar.  In this case,
 it will enter with output fields already valid; in the common case, the
 ``unknown.ret`` field of the union will be ``TDVMCALL_STATUS_SUBFUNC_UNSUPPORTED``.
 Userspace need not do anything if it does not wish to support a TDVMCALL.
+
+::
+		/* KVM_EXIT_ARM_SEA */
+		struct {
+  #define KVM_EXIT_ARM_SEA_FLAG_GPA_VALID   (1ULL << 0)
+			__u64 flags;
+			__u64 esr;
+			__u64 gva;
+			__u64 gpa;
+		} arm_sea;
+
+Used on arm64 systems. When the VM capability KVM_CAP_ARM_SEA_TO_USER is
+enabled, a VM exit is generated if guest causes a synchronous external abort
+(SEA) and the host APEI fails to handle the SEA.
+
+Historically KVM handles SEA by first delegating the SEA to host APEI as there
+is high chance that the SEA is caused by consuming uncorrected memory error.
+However, not all platforms support SEA handling in APEI, and KVM's fallback
+is to inject an asynchronous SError into the guest, which usually panics
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
+The following values are defined for the 'flags' field
+
+  - KVM_EXIT_ARM_SEA_FLAG_GPA_VALID -- the faulting guest physical address
+    is valid and userspace can get its value in the 'gpa' field.
+
+Note userspace can tell whether the faulting guest virtual address is valid
+from the FnV bit in 'esr' field. If FnV bit in 'esr' field is not set, the
+'gva' field hols the valid faulting guest virtual address.
+
+Userspace needs to take actions to handle guest SEA synchronously, namely in
+the same thread that runs KVM_RUN and receives KVM_EXIT_ARM_SEA. One of the
+encouraged approaches is to utilize the KVM_SET_VCPU_EVENTS to inject the SEA
+to the faulting VCPU. This way, the guest has the opportunity to keep running
+and limit the blast radius of the SEA to the particular guest application that
+caused the SEA. Userspace may also emulate the SEA to VM by itself using the
+KVM_SET_ONE_REG API. In this case, it can use the valid values from 'gva' and
+'gpa' fields to manipulate VCPU's registers (e.g. FAR_EL1, HPFAR_EL1).
+
 ::
 
 		/* Fix the size of the union. */
@@ -8689,6 +8738,18 @@ This capability indicate to the userspace whether a PFNMAP memory region
 can be safely mapped as cacheable. This relies on the presence of
 force write back (FWB) feature support on the hardware.
 
+7.45 KVM_CAP_ARM_SEA_TO_USER
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
2.51.0.760.g7b8bcc2412-goog


