Return-Path: <linux-kselftest+bounces-48060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE310CEEBE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 15:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 783043010CDB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 14:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0192312819;
	Fri,  2 Jan 2026 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efWmseMs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B030DD1F
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Jan 2026 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767363877; cv=none; b=Y+vFa963d9t5Jy5uwRSkyUy4PihPwcVSoNs3DOxEhCKHTDuQFdqdiuSEHeOw0QA3/mm0dv6msEq41uroVEFi6+RNuqbildsym9DUjckcuZ7oMzJUaHwnJKriOmzceGxtHIBvfFofanksG52l9Sq5Cjq5Wa2AtNrmMnoJad4I+i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767363877; c=relaxed/simple;
	bh=SW0KvHxcB5Ki/WF5fTbvn7mCbva6OjKHduifm92d7qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=awUeIudwazufPorT+mv7U/R1ID2lc34o7PFccmMY+/YpuXGEhq73TzXH2wvWBIFZINE5ntDiufUNYVZoLC1ykho54/S9pVdJxB4WoDxhvP1xYdMUqwLob7xurzbjzyv9PthEKRw3zq8VDJQ9fOJpdlLkUEGpWkek7VHcr+7Flkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efWmseMs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so95756455e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 06:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767363874; x=1767968674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=my2o2dIzac4OWOq3Y/Xzs5/dD+yeMBpNp7+C9Ouq+1w=;
        b=efWmseMsIdBa0FjkBMPTz932H+aXyuzffRoZIknFj7y6y7Mzrw+LWajNnvFdoVkAAv
         yQuXpTzuDq1C2OvSB0D7yFwnmxfAYRkIQ26Q2t+vQ/irfuQeC5sW+5yO0dHNe9Ag/ZER
         cP4nsclq/k+q1ZfE8ghGIhk+09/iuJZ4fUzDNduA5rMv7VdqUerhvDDZ3f0a72HW8BgA
         tBlmNnFW89HUl/B3aZ1u73je5ENPEFQK4kWNx+V6wnudCaQHzNxBuMyPeRlQcuYY3Tq1
         7CnXQIhoXApiTSlOOfUcZZU7cbaYHHxYdo6eqnfH0SdbEWeuA3pNe+rHKw2e92EduyEV
         5H7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767363874; x=1767968674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=my2o2dIzac4OWOq3Y/Xzs5/dD+yeMBpNp7+C9Ouq+1w=;
        b=hSlKcF6bsGBfOdoq6kU1yf5Z8mDc3OcIJeHF7PduKG4GCZcUNuK1vjGK1YXDDFGKiS
         mS6TWmSsY2+ShT6oiol06KfsrcG8IkbfgVWsHm5ZmV1ceo7AalQ+/4POh2iJi8HIscrN
         7sBwLMnGGPw84rnyv+C3jomZF6k10qlEpDlGGLftG2V63bcgp0c36H7iY9i+trHxBO+d
         pkDMGuXg8y9wZEkMFgfP3HymGq+EBxZGdAShJphnQvkZ0b9lsF2I2KU0+JmCRj/LQlj1
         XFmPfipHE44NBqhqKG/TkJcaDOOwOVGFyHyJsakOoJHZ8vGdj+DyiiFAko4cTFqrfNR+
         fYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgFp+6rq5egAVa9yxCyPPXrUGfortJVVf+bEZi57nBtQe8gml2BwkV6dc6cDYp64vlwFbnsFiIlzXwMdYMXgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/ApRVmlgfwoIP74bAJ2zC+Xa6HnD9tolc1f73SG4GaXeGhO6
	xsAeTdk9wvQPMzj43fULYkNhGS3jucQTSkAYa3gP4/FNndIG7LqT464j
X-Gm-Gg: AY/fxX4CRrkClcxt1yfKSehjncDQJzjd8lSMegFOfSqlUQaAjll1lCaCH8xtPtDPOFg
	Au1QJ3EqffXlRJmHS/xCtzfMTlw7DSEDrsZKMPrpa8yYLajr+PdUezSJNM9vFi6TC3+ldiOJ3sp
	0rGQIqjNmKt5DGPmgiqFVKdM9GA1G92eX5sDSr8MWLYgzHXBoCw3QtPequPoVUnMLqSmVRMLKor
	F8MUtWTr7uLJoA5DlOuvQOqhvmHUQWoBo35COfIVn1VMtkcmIide8Z7PGI/ECvifn+gNm3B7o6b
	D4WTbSP5T6NSWCiGMXZhHPnDiWvslxgKsYbXAQLAFDU3F5eDxOWzkwfHhygp+I5HQD8WlWIvJjW
	wJq/qgIqp8xlWOzycBSCrdzmFaAXPdCED6dCDnYqtsquUBDX76YY8lnND6dWcQeMWyi56FAe/fD
	uCOXa5UXjcE5rLZDs3VcNdThKX8wEmg1RHdrsNHYIbOZVkL4XWMY/1DJ5hVMlCFluxdY3WNSCY5
	CgHHAv4Ku0vjpfPTOEN+Ghwbt/sjbt6
X-Google-Smtp-Source: AGHT+IHKBXGau8MPaeirsCahDaWE9JWXdxyLyEdTLY2SGjXfRl6mxef/BeRFqCvfVfgG/TbOxXbT1Q==
X-Received: by 2002:a05:600c:4511:b0:477:af74:ed64 with SMTP id 5b1f17b1804b1-47d19593992mr491692865e9.27.1767363873762;
        Fri, 02 Jan 2026 06:24:33 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm806409235e9.13.2026.01.02.06.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 06:24:33 -0800 (PST)
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
Subject: [PATCH v4 00/10] KVM: nVMX: Improve performance for unmanaged guest memory
Date: Fri,  2 Jan 2026 14:24:19 +0000
Message-ID: <20260102142429.896101-1-griffoul@gmail.com>
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

v4:
 - Rebase on kvm/next required additional vapic handling in patch 4
   and a tiny fix in patch 5.
 - Fix patch 9 to re-assign vcpu to pfncache if the nested
   context has been recycled, and to clear the vcpu context in
   free_nested().

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
 arch/x86/kvm/nested.c                         | 199 +++++++
 arch/x86/kvm/vmx/hyperv.c                     |   5 +-
 arch/x86/kvm/vmx/hyperv.h                     |  33 +-
 arch/x86/kvm/vmx/nested.c                     | 499 ++++++++++++++----
 arch/x86/kvm/vmx/vmx.c                        |   8 +
 arch/x86/kvm/vmx/vmx.h                        |  16 +-
 arch/x86/kvm/x86.c                            |  19 +-
 include/linux/kvm_host.h                      |  34 +-
 include/linux/kvm_types.h                     |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 .../selftests/kvm/x86/vmx_apic_update_test.c  | 302 +++++++++++
 .../selftests/kvm/x86/vmx_l2_switch_test.c    | 416 +++++++++++++++
 virt/kvm/kvm_main.c                           |   3 +-
 virt/kvm/kvm_mm.h                             |   6 +-
 virt/kvm/pfncache.c                           |  43 +-
 18 files changed, 1496 insertions(+), 126 deletions(-)
 create mode 100644 arch/x86/kvm/nested.c
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_apic_update_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_l2_switch_test.c


base-commit: 0499add8efd72456514c6218c062911ccc922a99
--
2.43.0


