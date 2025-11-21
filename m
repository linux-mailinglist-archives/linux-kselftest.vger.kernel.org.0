Return-Path: <linux-kselftest+bounces-46209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D97C78AFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B1754E133A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8DB342508;
	Fri, 21 Nov 2025 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCmnvvct"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74328468D
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723485; cv=none; b=HpXF/s4QmEB4Q1g8ZH3SN0VSI/6w7bMzrSw68jVaKk5KCijm3HMCeZtNJKi8K/hMgP4bijNS+JjDc88Eqo9lDBj+vOYmnUe3xG2+dsPf8Mq56snVAbobUOLLL48NlhIKr2ksNRpCfblUggrgQaSkfVTW2Ns2kidfQKFzTou1a8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723485; c=relaxed/simple;
	bh=ea5lE3z+X38KwIeBD+4HkrPwqhtLVx6KnsZqPdtzMDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gCsc9BgPgDuaihX2xHNqosZoNOfqkz/D3tt6iU5q59hBYwR18HCSfm4uoU7Wv8E2jh7w2pyLtCzb6976HftydNWEpNoUppxALXlNnBThAekHTNYzsvNj635GT+iQcVZLM99ZzsApuiunHqByganigsnslEZkcFyCBx9bq9X8cEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCmnvvct; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47796a837c7so12421525e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 03:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723482; x=1764328282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrSvNsjaC/3WVr/Zsh1+adlhBYeJfG+lNGfokhPzPQQ=;
        b=BCmnvvct/I24QUGtQv4P9RMY3/oPRC0XZoGBRdbhqhwpaP1KeUDVP0ZzqSnfJR6Adv
         JQmUoGVXohGbpIA4uYjxYx3vU267O98Hs6zRACUSmFCB0/dSoYGfmcVIK7BTjqfI7UNF
         Kf+qaKe/+0QYbF8ppf9uZsiM0VLHcIYJmfIvCCIX/rdK4XmL2uUW4Lst9/RFt6ILN4+v
         ldPgjNpa2QT5jFi03sAS7lYLkrXjADYTKEFgtkA89G9QyUkYgYKxixbN7kMtPdyMeNiC
         //QbKOrSqXeTx2jenqQf5pjgCHglIZ/QF6OVHSgujGqVl99K1Ab9NUlQfYXNn2wTFiv0
         E8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723482; x=1764328282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrSvNsjaC/3WVr/Zsh1+adlhBYeJfG+lNGfokhPzPQQ=;
        b=uMAGg1SWYh/VigtsGL+0DbzmQwDV3ZDiMnPGXfSbx4vIr5l4DVAAigUvg5ItSLkdlD
         mmcRXDLj7sY/Dv9OH3gCLf5gbVjtYOWA4nykAn9yK5TbVoYHu7w3SkBkj9HPhP3mCPm9
         L4YvK/D0ynZyho8c+67/hO0q/39S3N2OjFJ9vQUBkOw9x5vdqZ5OnOrXh94yKQ3f1Hu7
         V+j2TS/gc/rmD28IrCmJ/2JVHScGdWrGOHDZ8LlcboaSICGmkRrMak980VvZBFysxpMB
         1jSAdJab4KMm28yXWiYUhkPQu0rU43t3jNwT4b/o2of2drJA+HPBRcJ+yj4HC+MRnVLA
         T4xg==
X-Forwarded-Encrypted: i=1; AJvYcCVH1jfZELX2mlLcSRNifjR7c7ZWg5vekcYVe9fNgjjnSbDkjleo+3cLKE8vXjCB/wYN3yEEpikIF+IO2bOAiyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+L5SxFobNiL1MrONBoUIJ3+RN7LZszm/JZLhNoACFQOjZM3G
	ptRiYx48rD4n6LOfigt3jXG8cpXYiCz3b1QX/3FhtvQCM+mNAywa8VQj
X-Gm-Gg: ASbGnctov7blR9bWY2yghdU8N545696OEVvJ5cqlFeYl/Pq9Xzbxlc21IBPA7NTurqB
	FHQ0DIchCdF9NNCDNTnlhuHoUIrKzalpVE7PxdD5IHePB6fsTYtXRH3FkXvZWNaRiWUVY3skDzr
	dk4/VYHwaAswLsC/SclQMgaKNkpunAuC18zV+PIWtJIl0w0E+EGgz49r77EJvuMlIjhnUYYPYgg
	AP/DrU7in0trVqeTrgprMNVtOJc5xV2rGt1R4FLdseMg0Tb39USZP2PzUL++uQO8jX1JNPqeUPW
	UdyiAMBJWm7xco9G2GjnSmKcOyxyHNnQC1vZyCCqxXv/CEvWwjSdkqahY1LgEggYYw2i1yyFjyf
	R6JyqJ4wGlW2vQusTjnMbb1XtJQl6FY0j8o989kFY/G5c8UaCDGHpyA5znErdokxuJOW8UJRAT9
	+ZWkJ+izXh2r3PDHliYOAuToFeLpgPHzY9J1n1mXDKdGSVn38rHFXr1UCWw9SLwB2eqtasb0Ykz
	KJA4g7OFNauhSPFGKLq7y7IjsgXnVTa
X-Google-Smtp-Source: AGHT+IEC7hOvqyYPygsb1D7Hq8HrYWfmnLLe9fQ2FxMgvDY1wOad9Qi6jbWaCOYLWB5h194p4b4Gyw==
X-Received: by 2002:a05:600c:468c:b0:477:79f8:daa8 with SMTP id 5b1f17b1804b1-477c01b219amr19202265e9.17.1763723481939;
        Fri, 21 Nov 2025 03:11:21 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363e4sm10484180f8f.12.2025.11.21.03.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:11:21 -0800 (PST)
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
Subject: [PATCH v3 00/10] KVM: nVMX: Improve performance for unmanaged guest memory
Date: Fri, 21 Nov 2025 11:11:03 +0000
Message-ID: <20251121111113.456628-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

This patch series addresses both performance and correctness issues in
nested VMX when handling guest memory.

During nested VMX operations, L0 (KVM) accesses specific L1 guest pages
to manage L2 execution. These pages fall into two categories: pages
accessed only by L0 (such as the L1 MSR bitmap page or the eVMCS page),
and pages passed to the L2 guest via vmcs02 (such as APIC access,
virtual APIC, and posted interrupt descriptor pages).

The current implementation uses kvm_vcpu_map/unmap, which causes two
issues.

First, the current approach is missing proper invalidation handling in
critical scenarios. Enlightened VMCS (eVMCS) pages can become stale when
memslots are modified, as there is no mechanism to invalidate the cached
mappings. Similarly, APIC access and virtual APIC pages can be migrated
by the host, but without proper notification through mmu_notifier
callbacks, the mappings become invalid and can lead to incorrect
behavior.

Second, for unmanaged guest memory (memory not directly mapped by the
kernel, such as memory passed with the mem= parameter or guest_memfd for
non-CoCo VMs), this workflow invokes expensive memremap/memunmap
operations on every L2 VM entry/exit cycle. This creates significant
overhead that impacts nested virtualization performance.

This series replaces kvm_host_map with gfn_to_pfn_cache in nested VMX.
The pfncache infrastructure maintains persistent mappings as long as the
page GPA does not change, eliminating the memremap/memunmap overhead on
every VM entry/exit cycle. Additionally, pfncache provides proper
invalidation handling via mmu_notifier callbacks and memslots generation
check, ensuring that mappings are correctly updated during both memslot
updates and page migration events.

As an example, a microbenchmark using memslot_perf_test with 8192
memslots demonstrates huge improvements in nested VMX operations with
unmanaged guest memory (this is a synthetic benchmark run on
AWS EC2 Nitro instances, and the results are not representative of
typical nested virtualization workloads):

                        Before          After           Improvement
  map:                  26.12s          1.54s           ~17x faster
  unmap:                40.00s          0.017s          ~2353x faster
  unmap chunked:        10.07s          0.005s          ~2014x faster

The series is organized as follows:

Patches 1-5 handle the L1 MSR bitmap page and system pages (APIC access,
virtual APIC, and posted interrupt descriptor). Patch 1 converts the MSR
bitmap to use gfn_to_pfn_cache. Patches 2-3 restore and complete
"guest-uses-pfn" support in pfncache. Patch 4 converts the system pages
to use gfn_to_pfn_cache. Patch 5 adds a selftest for cache invalidation
and memslot updates.

Patches 6-7 add enlightened VMCS support. Patch 6 avoids accessing eVMCS
fields after they are copied into the cached vmcs12 structure. Patch 7
converts eVMCS page mapping to use gfn_to_pfn_cache.

Patches 8-10 implement persistent nested context to handle L2 vCPU
multiplexing and migration between L1 vCPUs. Patch 8 introduces the
nested context management infrastructure. Patch 9 integrates pfncache
with persistent nested context. Patch 10 adds a selftest for this L2
vCPU context switching.

v3:
  - fixed warnings reported by kernel test robot in patches 7 and 8.

v2:
  - Extended series to support enlightened VMCS (eVMCS).
  - Added persistent nested context for improved L2 vCPU handling.
  - Added additional selftests.

Suggested-by: dwmw@amazon.co.uk


Fred Griffoul (10):
  KVM: nVMX: Implement cache for L1 MSR bitmap
  KVM: pfncache: Restore guest-uses-pfn support
  KVM: x86: Add nested state validation for pfncache support
  KVM: nVMX: Implement cache for L1 APIC pages
  KVM: selftests: Add nested VMX APIC cache invalidation test
  KVM: nVMX: Cache evmcs fields to ensure consistency during VM-entry
  KVM: nVMX: Replace evmcs kvm_host_map with pfncache
  KVM: x86: Add nested context management
  KVM: nVMX: Use nested context for pfncache persistence
  KVM: selftests: Add L2 vcpu context switch test

 arch/x86/include/asm/kvm_host.h               |  32 ++
 arch/x86/include/uapi/asm/kvm.h               |   2 +
 arch/x86/kvm/Makefile                         |   2 +-
 arch/x86/kvm/nested.c                         | 199 ++++++++
 arch/x86/kvm/vmx/hyperv.c                     |   5 +-
 arch/x86/kvm/vmx/hyperv.h                     |  33 +-
 arch/x86/kvm/vmx/nested.c                     | 469 ++++++++++++++----
 arch/x86/kvm/vmx/vmx.c                        |   8 +
 arch/x86/kvm/vmx/vmx.h                        |  16 +-
 arch/x86/kvm/x86.c                            |  19 +-
 include/linux/kvm_host.h                      |  34 +-
 include/linux/kvm_types.h                     |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 .../selftests/kvm/x86/vmx_apic_update_test.c  | 302 +++++++++++
 .../selftests/kvm/x86/vmx_l2_switch_test.c    | 416 ++++++++++++++++
 virt/kvm/kvm_main.c                           |   3 +-
 virt/kvm/kvm_mm.h                             |   6 +-
 virt/kvm/pfncache.c                           |  43 +-
 18 files changed, 1469 insertions(+), 123 deletions(-)
 create mode 100644 arch/x86/kvm/nested.c
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_apic_update_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_l2_switch_test.c


base-commit: 6b36119b94d0b2bb8cea9d512017efafd461d6ac
prerequisite-patch-id: afd3db49735b65c8a642de8dab7d0160d5da4b67
--
2.43.0


