Return-Path: <linux-kselftest+bounces-4247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F111B84D045
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FB51C25FF4
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 17:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8C182D8E;
	Wed,  7 Feb 2024 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lsl2TtvI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A282C76;
	Wed,  7 Feb 2024 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328740; cv=none; b=G3uauVguXAcLmm4IvDaIw3iQmoGpbFaPngtSjWIwToJxRcYOB18kUFbw5YUgUDdLAHmN2m+JZg7elEmy69qBBE8GDSJfVpNlKZLZh/u+9uKjrlezJKzH5Xf66nruVLbWtPRNdjE/+UhzdBGhiKOIDjm3snDer2uRvTejm5pl0Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328740; c=relaxed/simple;
	bh=lmwp+X4m566IhpL3BVzRtbCOejiCrKvu6IvAyXfd1sY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMsjXvWh/uy3eXaQuYhgLOERZ+ONvyk45JFlQyOSLRVLQtv0Z2eB84suJ6JiTBA/P8Zz++uDTzmUK3rXE9R/5pjSBPhhab4WaylP7b9f5um7XNEYY9ihxKGBhRrFelAE7U4qQ6gdOySfRuOoCgLbqOaeCqBuPgZdh9QZmmB7MII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lsl2TtvI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328735; x=1738864735;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lmwp+X4m566IhpL3BVzRtbCOejiCrKvu6IvAyXfd1sY=;
  b=Lsl2TtvIsfi/Ubfox07I+ss9cNM1nby8zP1138pj7XdlwOhPCLJcgQ3r
   3z/PsU62FAQlqKIyMPxPAfUu8fp3SeLkgymt6WbnPU/MTs4W2tak8fkr+
   B9eW1WpRqTb2KenE2yR/ISUEqoTbwXU5PiYgRyPyFxjN9RYv77caZdRRu
   NyvU1ZJ1hwLD8gXcNXoWTX+Bol8LIBfzyOXRtmXI8lbM78BVrSc/VbLR8
   ztxH8oyd3CHyrO0Wm/hVF7N62KrmFzdC7Ec/rWPraC8bthmeu63GWFwik
   sLbqotoW2V3y1UUyjRHmwGi+NbyOWxJ9TVSiZd3XJsHfc4NMpkkNFOeqH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622474"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622474"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020686"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:53 -0800
From: Xin Li <xin3.li@intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	corbet@lwn.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	shuah@kernel.org,
	vkuznets@redhat.com,
	peterz@infradead.org,
	ravi.v.shankar@intel.com,
	xin@zytor.com
Subject: [PATCH v2 00/25] Enable FRED with KVM VMX
Date: Wed,  7 Feb 2024 09:26:20 -0800
Message-ID: <20240207172646.3981-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set enables the Intel flexible return and event delivery
(FRED) architecture with KVM VMX to allow guests to utilize FRED.

The FRED architecture defines simple new transitions that change
privilege level (ring transitions). The FRED architecture was
designed with the following goals:

1) Improve overall performance and response time by replacing event
   delivery through the interrupt descriptor table (IDT event
   delivery) and event return by the IRET instruction with lower
   latency transitions.

2) Improve software robustness by ensuring that event delivery
   establishes the full supervisor context and that event return
   establishes the full user context.

The new transitions defined by the FRED architecture are FRED event
delivery and, for returning from events, two FRED return instructions.
FRED event delivery can effect a transition from ring 3 to ring 0, but
it is used also to deliver events incident to ring 0. One FRED
instruction (ERETU) effects a return from ring 0 to ring 3, while the
other (ERETS) returns while remaining in ring 0. Collectively, FRED
event delivery and the FRED return instructions are FRED transitions.

Intel VMX architecture is extended to run FRED guests, and the major
changes are:

1) New VMCS fields for FRED context management, which includes two new
event data VMCS fields, eight new guest FRED context VMCS fields and
eight new host FRED context VMCS fields.

2) VMX nested-exception support for proper virtualization of stack
levels introduced with FRED architecture.

Search for the latest FRED spec in most search engines with this search
pattern:

  site:intel.com FRED (flexible return and event delivery) specification

As the native FRED patches are committed in the tip tree "x86/fred"
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/fred,
and we have received a good amount of review comments for v1, it's time
to send out v2 based on this branch for further help from the community.

Patch 1-2 are cleanups to VMX basic and misc MSRs, which were sent
out earlier as a preparation for FRED changes:
https://lore.kernel.org/kvm/20240206182032.1596-1-xin3.li@intel.com/T/#u

Patch 3-15 add FRED support to VMX.
Patch 16-21 add FRED support to nested VMX.
Patch 22 exposes FRED and its baseline features to KVM guests.
Patch 23-25 add FRED selftests.

There is also a counterpart qemu patch set for FRED at:
https://lore.kernel.org/qemu-devel/20231109072012.8078-1-xin3.li@intel.com/T/,
which works with this patch set to allow KVM to run FRED guests.


Changes since v1:
* Always load the secondary VM exit controls (Sean Christopherson).
* Remove FRED VM entry/exit controls consistency checks in
  setup_vmcs_config() (Sean Christopherson).
* Clear FRED VM entry/exit controls if FRED is not enumerated (Chao Gao).
* Use guest_can_use() to trace FRED enumeration in a vcpu (Chao Gao).
* Enable FRED MSRs intercept if FRED is no longer enumerated in CPUID
  (Chao Gao).
* Move guest FRED states init into __vmx_vcpu_reset() (Chao Gao).
* Don't use guest_cpuid_has() in vmx_prepare_switch_to_{host,guest}(),
  which are called from IRQ-disabled context (Chao Gao).
* Reset msr_guest_fred_rsp0 in __vmx_vcpu_reset() (Chao Gao).
* Fail host requested FRED MSRs access if KVM cannot virtualize FRED
  (Chao Gao).
* Handle the case FRED MSRs are valid but KVM cannot virtualize FRED
  (Chao Gao).
* Add sanity checks when writing to FRED MSRs.
* Explain why it is ok to only check CR4.FRED in kvm_is_fred_enabled()
  (Chao Gao).
* Document event data should be equal to CR2/DR6/IA32_XFD_ERR instead
  of using WARN_ON() (Chao Gao).
* Zero event data if a #NM was not caused by extended feature disable
  (Chao Gao).
* Set the nested flag when there is an original interrupt (Chao Gao).
* Dump guest FRED states only if guest has FRED enabled (Nikolay Borisov).
* Add a prerequisite to SHADOW_FIELD_R[OW] macros
* Remove hyperv TLFS related changes (Jeremi Piotrowski).
* Use kvm_cpu_cap_has() instead of cpu_feature_enabled() to decouple
  KVM's capability to virtualize a feature and host's enabling of a
  feature (Chao Gao).


Xin Li (25):
  KVM: VMX: Cleanup VMX basic information defines and usages
  KVM: VMX: Cleanup VMX misc information defines and usages
  KVM: VMX: Add support for the secondary VM exit controls
  KVM: x86: Mark CR4.FRED as not reserved
  KVM: VMX: Initialize FRED VM entry/exit controls in vmcs_config
  KVM: VMX: Defer enabling FRED MSRs save/load until after set CPUID
  KVM: VMX: Set intercept for FRED MSRs
  KVM: VMX: Initialize VMCS FRED fields
  KVM: VMX: Switch FRED RSP0 between host and guest
  KVM: VMX: Add support for FRED context save/restore
  KVM: x86: Add kvm_is_fred_enabled()
  KVM: VMX: Handle FRED event data
  KVM: VMX: Handle VMX nested exception for FRED
  KVM: VMX: Disable FRED if FRED consistency checks fail
  KVM: VMX: Dump FRED context in dump_vmcs()
  KVM: VMX: Invoke vmx_set_cpu_caps() before nested setup
  KVM: nVMX: Add support for the secondary VM exit controls
  KVM: nVMX: Add a prerequisite to SHADOW_FIELD_R[OW] macros
  KVM: nVMX: Add FRED VMCS fields
  KVM: nVMX: Add support for VMX FRED controls
  KVM: nVMX: Add VMCS FRED states checking
  KVM: x86: Allow FRED/LKGS/WRMSRNS to be exposed to guests
  KVM: selftests: Run debug_regs test with FRED enabled
  KVM: selftests: Add a new VM guest mode to run user level code
  KVM: selftests: Add fred exception tests

 Documentation/virt/kvm/x86/nested-vmx.rst     |  19 +
 arch/x86/include/asm/kvm_host.h               |   8 +-
 arch/x86/include/asm/msr-index.h              |  15 +-
 arch/x86/include/asm/vmx.h                    |  59 ++-
 arch/x86/kvm/cpuid.c                          |   4 +-
 arch/x86/kvm/governed_features.h              |   1 +
 arch/x86/kvm/kvm_cache_regs.h                 |  17 +
 arch/x86/kvm/svm/svm.c                        |   4 +-
 arch/x86/kvm/vmx/capabilities.h               |  30 +-
 arch/x86/kvm/vmx/nested.c                     | 329 ++++++++++++---
 arch/x86/kvm/vmx/nested.h                     |   2 +-
 arch/x86/kvm/vmx/vmcs.h                       |   1 +
 arch/x86/kvm/vmx/vmcs12.c                     |  19 +
 arch/x86/kvm/vmx/vmcs12.h                     |  38 ++
 arch/x86/kvm/vmx/vmcs_shadow_fields.h         |  80 ++--
 arch/x86/kvm/vmx/vmx.c                        | 385 +++++++++++++++---
 arch/x86/kvm/vmx/vmx.h                        |  15 +-
 arch/x86/kvm/x86.c                            | 103 ++++-
 arch/x86/kvm/x86.h                            |   5 +-
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/kvm_util_base.h     |   1 +
 .../selftests/kvm/include/x86_64/processor.h  |  36 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |   5 +-
 .../selftests/kvm/lib/x86_64/processor.c      |  15 +-
 tools/testing/selftests/kvm/lib/x86_64/vmx.c  |   4 +-
 .../testing/selftests/kvm/x86_64/debug_regs.c |  50 ++-
 .../testing/selftests/kvm/x86_64/fred_test.c  | 297 ++++++++++++++
 27 files changed, 1320 insertions(+), 223 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/fred_test.c


base-commit: e13841907b8fda0ae0ce1ec03684665f578416a8
-- 
2.43.0


