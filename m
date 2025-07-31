Return-Path: <linux-kselftest+bounces-38124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E91B17783
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 22:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1907B1AA7295
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 20:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE41261393;
	Thu, 31 Jul 2025 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IH0mWrbO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6398B20B22
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995537; cv=none; b=GWoXZeL2lc22bKSvppBA9yzfU7+XzqF8ZbIyTCxuB/GFFMMvUiak0NRgqs3R9VJ5BZx9TRUMgPN6LmasABuK6SL4HR0fvn7p6Fk00Vb32nJHdg0nCc74m1uUc9I+g1ge8xoJe4wRtiQsnLadLOeQu9ZnG5h2GyG/JchPCFzGyVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995537; c=relaxed/simple;
	bh=+2ElDXYkKRhhehnqaiJ6+gPxxtcT+CNuHtOfsAgMro4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SHgW8RQSb9/hfsB+njya98z1ojpQDak8gnzWE/QgG13hHv/ImnHbii19XQ+xllocj1u9U/h8xy+f4p/ZSExA8a0ngVKCySyZMilDv+t6h+rRXSIYgLyogu6squHG2a3MVRqs7+pEr37jO2DGwXNv7cp1Fi/Wp2j10BgM6LsCumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IH0mWrbO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so218061a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753995534; x=1754600334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1DNL4ZqkcIvug0P6zNDToFEaRqlmYm3XRLwrpfrR4hk=;
        b=IH0mWrbOwkkE8kDASE42V5WQnQoFRaeWWiYFK6aicAKKxmhyvTosPsfJtXLbp1Uz6y
         x0qNUm+kJ2OLSzYIFGjdEUyaMHeACLo5cDELd+eFdDrc5yTrah28WC8if8j7yYzdqjem
         2/ZR6k03/3wQa8KvZRlCp7AfO3cCzmLZTJUaRhp2ANGqpMpX7liEtA0mFcvRlo2HmBB4
         QSIjeSUQMYk1nBsuee8LsuDlQsTNDYZonkt8/jYsmTnUYckhVia8xi/5M4O/JCr0sIeS
         7xjra7/7gNxMOx7+VbfOD1EmFPHW1FU6RrP3kt7zVuBOwkOxRbAs+eJ7Gt4NXenXCg4T
         ykDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753995534; x=1754600334;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DNL4ZqkcIvug0P6zNDToFEaRqlmYm3XRLwrpfrR4hk=;
        b=SetR2I834gJOHLpM0d1Db/zz2bDWNELTJJ8FBmqbUtNBz155+yRvj+v3qeAYKvC1gl
         2r1y3vkJtiUgkx2Bu+zEnu71nh4j+EPID2/oc3VBSfFRugGX+bWUowZ1np5UeoAFAuRL
         n/fgHuw3TJh4oslJDSp5+/DW9ro4SUCqaHHIDxI79/DNPbh+yzuH+XZOqvStQTBOYFxp
         7ed5L2Z7FGzp2m2VMDrjTb4A81/Q4TeSjFBfKZBsIsRSetYk632bo3aqIi93Tkv2yUi+
         1KF1FUYDSfksfLc8FvPUrnxVzfosXYHOmiewKZQmBdLdhqvH7FK7aq2LgNEJyR1RS+Xs
         7lUw==
X-Forwarded-Encrypted: i=1; AJvYcCXQB3mv1Cx53UTdghCKqA2cy3AKj8NJQbq+cE/knIPqk5Xy/LpCafwFqqYIb/W8WwTdZQOeSW6RAk5feq1UTm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDdWVG/W5KDf03AbOGcRO58EU7WaK9LcqOS/BRiRVRl6Sh0M4j
	cTdG4FrA6VCSwahDA+Lu9uE48x6pJHcOc+cwV9sFeREuWN3OCZMxGoI4ismYq5HP+xubWAwqbZm
	q03aO/AtSVKk7eA==
X-Google-Smtp-Source: AGHT+IFtBee05Y+0YcwYG+qw66EBKTnwyLUw2Zd87HU0sy3vcGl9Liy/DQSHpFber1pJeKsCOjefFdN8peNhiQ==
X-Received: from pji5.prod.google.com ([2002:a17:90b:3fc5:b0:31c:2fe4:33b6])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:39c5:b0:311:ea13:2e70 with SMTP id 98e67ed59e1d1-31f5de3ceb7mr12431905a91.14.1753995533793;
 Thu, 31 Jul 2025 13:58:53 -0700 (PDT)
Date: Thu, 31 Jul 2025 20:58:41 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731205844.1346839-1-jiaqiyan@google.com>
Subject: [PATCH v3 0/3] VMM can handle guest SEA via KVM_EXIT_ARM_SEA
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

Problem
=======

When host APEI is unable to claim a synchronous external abort (SEA)
during guest abort, today KVM directly injects an asynchronous SError
into the VCPU then resumes it. The injected SError usually results in
unpleasant guest kernel panic.

One of the major situation of guest SEA is when VCPU consumes recoverable
uncorrected memory error (UER), which is not uncommon at all in modern
datacenter servers with large amounts of physical memory. Although SError
and guest panic is sufficient to stop the propagation of corrupted memory,
there is room to recover from an UER in a more graceful manner.

Proposed Solution
=================

The idea is, we can replay the SEA to the faulting VCPU. If the memory
error consumption or the fault that cause SEA is not from guest kernel,
the blast radius can be limited to the poison-consuming guest process,
while the VM can keep running.

In addition, instead of doing under the hood without involving userspace,
there are benefits to redirect the SEA to VMM:

- VM customers care about the disruptions caused by memory errors, and
  VMM usually has the responsibility to start the process of notifying
  the customers of memory error events in their VMs. For example some
  cloud provider emits a critical log in their observability UI [1], and
  provides a playbook for customers on how to mitigate disruptions to
  their workloads.

- VMM can protect future memory error consumption by unmapping the poisoned
  pages from stage-2 page table with KVM userfault [2], or by splitting the
  memslot that contains the poisoned pages.

- VMM can keep track of SEA events in the VM. When VMM thinks the status
  on the host or the VM is bad enough, e.g. number of distinct SEAs
  exceeds a threshold, it can restart the VM on another healthy host.

- Behavior parity with x86 architecture. When machine check exception
  (MCE) is caused by VCPU, kernel or KVM signals userspace SIGBUS to
  let VMM either recover from the MCE, or terminate itself with VM.
  The prior RFC proposes to implement SIGBUS on arm64 as well, but
  Marc preferred KVM exit over signal [3]. However, implementation
  aside, returning SEA to VMM is on par with returning MCE to VMM.

Once SEA is redirected to VMM, among other actions, VMM is encouraged
to inject external aborts into the faulting VCPU.

New UAPIs
=========

This patchset introduces following userspace-visible changes to empower
VMM to control what happens for SEA on guest memory:

- KVM_CAP_ARM_SEA_TO_USER. While taking SEA, if userspace has enabled
  this new capability at VM creation, and the SEA is not owned by kernel
  allocated memory, instead of injecting SError, return KVM_EXIT_ARM_SEA
  to userspace.

- KVM_EXIT_ARM_SEA. This is the VM exit reason VMM gets. The details
  about the SEA is provided in arm_sea as much as possible, including
  sanitized ESR value at EL2, faulting guest virtual and physical
  addresses if available.

* From v2 [4]:
  - Rebased on "[PATCH] KVM: arm64: nv: Handle SEAs due to VNCR redirection" [5]
    and kvmarm/next commit 7b8346bd9fce ("KVM: arm64: Don't attempt vLPI
    mappings when vPE allocation is disabled")
  - Took the host_owns_sea implementation from Oliver [6, 7].
  - Excluded the guest SEA injection patches.
  - Updated selftest.

* From v1 [8]:
  - Rebased on commit 4d62121ce9b5 ("KVM: arm64: vgic-debug: Avoid
    dereferencing NULL ITE pointer").
  - Sanitize ESR_EL2 before reporting it to userspace.
  - Do not do KVM_EXIT_ARM_SEA when SEA is caused by memory allocated to
    stage-2 translation table.

[1] https://cloud.google.com/solutions/sap/docs/manage-host-errors
[2] https://lore.kernel.org/kvm/20250109204929.1106563-1-jthoughton@google.com
[3] https://lore.kernel.org/kvm/86pljbqqh0.wl-maz@kernel.org
[4] https://lore.kernel.org/kvm/20250604050902.3944054-1-jiaqiyan@google.com/
[5] https://lore.kernel.org/kvmarm/20250729182342.3281742-1-oliver.upton@linux.dev/
[6] https://lore.kernel.org/kvm/aHFohmTb9qR_JG1E@linux.dev/#t
[7] https://lore.kernel.org/kvm/aHK-DPufhLy5Dtuk@linux.dev/
[8] https://lore.kernel.org/kvm/20250505161412.1926643-1-jiaqiyan@google.com

Jiaqi Yan (3):
  KVM: arm64: VM exit to userspace to handle SEA
  KVM: selftests: Test for KVM_EXIT_ARM_SEA
  Documentation: kvm: new UAPI for handling SEA

 Documentation/virt/kvm/api.rst                |  61 ++++
 arch/arm64/include/asm/kvm_host.h             |   2 +
 arch/arm64/kvm/arm.c                          |   5 +
 arch/arm64/kvm/mmu.c                          |  68 +++-
 include/uapi/linux/kvm.h                      |  10 +
 tools/arch/arm64/include/asm/esr.h            |   2 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/arm64/sea_to_user.c | 327 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |   1 +
 9 files changed, 476 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/arm64/sea_to_user.c

-- 
2.50.1.565.gc32cd1483b-goog


