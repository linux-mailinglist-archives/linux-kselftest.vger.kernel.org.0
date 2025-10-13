Return-Path: <linux-kselftest+bounces-43025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69076BD5CF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 20:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C26B3351753
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7127224F3;
	Mon, 13 Oct 2025 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1PfRJXxy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667502561AA
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381950; cv=none; b=QyOfK+DmXstjGgHWUerKWZd9KVPNgFD0HMfzaEturi5xfECM+ZEZ9Tej/HmsuAFGjr0IrcHUeAwU0idIxdFzX56/2j9zBnG0prkyzvXlESWbfaMzI+sqBAPwoO9iLvoQcAXIZg9HPm1i7fYKjgL3WLU6dEpBFljHhByXq0af3xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381950; c=relaxed/simple;
	bh=D2DBVOyfmDfuJQ3NbYBcT2oWdkkwKPWux1rjkEGJ5uE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QEoc6EEA0IJ2eb0kDiujqKgzbV2P+3sMZ0TLpcp5L4KglqGIViDHPsPH7hJKXuzLAZULbeOPTWucCDoWwqrWSIHHPdR90KFjcUA05PqlBM307czOHAyYSaqxipASksDP9v5mpGq290jhBqYT27KzQMPSdu2pf6UdVibyzvn0de4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1PfRJXxy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befbbaso10982812a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760381948; x=1760986748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3zyOsXjgR2slTOTUParrmMvaOPp3Y8R1z3YFebNy+kY=;
        b=1PfRJXxynwvRiatGmDVBkdpDqCkFgOpboiCejEs+hgpKN9o9803KUbunV39Sep8NSZ
         U8lKZTQwBzGeq/D3Q7eJdJidPucazCJTcclHoXcINZbyd9qkycyTWx1Sr0pYz2Tnz1di
         kYDMOUEJLs3EEIV4MaphLUK1/BjGZq/ImrhiD9AbUdFCo9VKH2gjvYZEiKYFbLQ7xRQI
         c3SSh1W9QkjktEE8Fjzk53UbmgQTIA54aAMKkbSjw+Y+Vh84WFSaCNxeAkKVGpcVvIbC
         cl+LdRc8IX1m2VR9UhTECOG/hPl7YjXl9g0K1f9wrUEwfCMWjMCMDf0SYuCR7kglyUyv
         D0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760381948; x=1760986748;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3zyOsXjgR2slTOTUParrmMvaOPp3Y8R1z3YFebNy+kY=;
        b=RSVevrpk0m0kUNQwNvTHBSApZxoVyrOfOW9zrh1COUfbFGJfV8QpGshTo9vI/cDcbD
         JK5YVKfOYbxackqHXIpZ0HOSg9jzOgIEgnhnrKMKztbd2KFttpqTmR20c9w+Mwf1x+6R
         U6xcLQJU/uAqSl9TvZ7A6FYiOLBRsgX2ijDmJ2V5YxejxQN02elvsQ8npFyupqpZeQeG
         bJbkB6G1iLTJ0ZqqHyzdHWaHtUCZbBwksjMwSG7wxyPw6xMUrAMFpfo3VvzYu18nPxXF
         9XfOi91hEHXH8WaKDfIbzrhoR8DBo5+pPt1VX//dUVkPOTbt0nfg7Cp+04R8yI7LrDWM
         qFzA==
X-Forwarded-Encrypted: i=1; AJvYcCWvUHycG20diP/HfdAsoe1LNIlFzo8SSKWiSWNz+3r7C7W+rvjVims4xTgLeB4xJoGADKJ1IwhIDDgp6g28UDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/g3dTPZRM0eNN3pcR+HQFytreyl5Q4ReoHi4lb/e4OrnqtjOl
	43uaeqiT7oexh7ZfYMfUksFKZrb9OirTlb1oLqLWx2my26P18HELPk4W3sR1NQ6xi+g/SZD5sdf
	DbqC6cWTH9LR/bg==
X-Google-Smtp-Source: AGHT+IFQCZ0F3mAV98Keda3BZRrx76PXArL7t60ZigncnYG4BTa+6j6T70pbIysH6cLO49q77f6O/f7NZYgb1A==
X-Received: from pjbkw19.prod.google.com ([2002:a17:90b:2213:b0:330:8c66:4984])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3e82:b0:339:a4ef:c8b9 with SMTP id 98e67ed59e1d1-33b5127ac7fmr33043099a91.17.1760381947731;
 Mon, 13 Oct 2025 11:59:07 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:59:00 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Message-ID: <20251013185903.1372553-1-jiaqiyan@google.com>
Subject: [PATCH v4 0/3] VMM can handle guest SEA via KVM_EXIT_ARM_SEA
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

* From v3 [4]
  - Rebased on commit 3a8660878839 ("Linux 6.18-rc1").
  - In selftest, print a message if GVA or GPA expects to be valid.

* From v2 [5]:
  - Rebased on "[PATCH] KVM: arm64: nv: Handle SEAs due to VNCR redirection" [6]
    and kvmarm/next commit 7b8346bd9fce6 ("KVM: arm64: Don't attempt vLPI
    mappings when vPE allocation is disabled")
  - Took the host_owns_sea implementation from Oliver [7, 8].
  - Excluded the guest SEA injection patches.
  - Updated selftest.

* From v1 [9]:
  - Rebased on commit 4d62121ce9b5 ("KVM: arm64: vgic-debug: Avoid
    dereferencing NULL ITE pointer").
  - Sanitize ESR_EL2 before reporting it to userspace.
  - Do not do KVM_EXIT_ARM_SEA when SEA is caused by memory allocated to
    stage-2 translation table.

[1] https://cloud.google.com/solutions/sap/docs/manage-host-errors
[2] https://lore.kernel.org/kvm/20250109204929.1106563-1-jthoughton@google.com
[3] https://lore.kernel.org/kvm/86pljbqqh0.wl-maz@kernel.org
[4] https://lore.kernel.org/kvmarm/20250731205844.1346839-1-jiaqiyan@google.com
[5] https://lore.kernel.org/kvm/20250604050902.3944054-1-jiaqiyan@google.com
[6] https://lore.kernel.org/kvmarm/20250729182342.3281742-1-oliver.upton@linux.dev
[7] https://lore.kernel.org/kvm/aHFohmTb9qR_JG1E@linux.dev
[8] https://lore.kernel.org/kvm/aHK-DPufhLy5Dtuk@linux.dev
[9] https://lore.kernel.org/kvm/20250505161412.1926643-1-jiaqiyan@google.com

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
 .../testing/selftests/kvm/arm64/sea_to_user.c | 331 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |   1 +
 9 files changed, 480 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/arm64/sea_to_user.c

-- 
2.51.0.760.g7b8bcc2412-goog


