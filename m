Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85017E5D90
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjKHTAU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKHTAU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158B1210A;
        Wed,  8 Nov 2023 11:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470019; x=1731006019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CGCl93jPHfMwJ3CMMd312/g/vAJzCAfUxs25Pz0yXYY=;
  b=iacNhMBM1AZFukoBREiqp8uoFR3SlcyNYVtxRDS4CJKa9jYYHalJqSE5
   GmXzQvf0RH2KxBctzzJ1DCxbPx95gTfQkeJQjTjpUBVdFk3VHjDGhlrGU
   FmJojx3CK1iYj1WjX9MfZADGZa+bFpNpownBc4jgaqb5DWkq/7DTaAbDe
   CZpDm8gH+imhAb5jfd8VXTRXSbSRV2BEpnqilE7+bsC2A1CszHzZTYJgU
   CoWtpIPzow+nY0pTpg/+yba+dCKEmgmjCKZQKJ1web45dTCZjr/lJiHLL
   7llCaK/5ugeEyeG/NtFjCwxC07i1SIdVanYBx7MsbeE100/Z8LiccDHil
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486198"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486198"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892400"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:14 -0800
From:   Xin Li <xin3.li@intel.com>
To:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, pbonzini@redhat.com, corbet@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, vkuznets@redhat.com, peterz@infradead.org,
        ravi.v.shankar@intel.com
Subject: [PATCH v1 00/23] Enable FRED with KVM VMX
Date:   Wed,  8 Nov 2023 10:29:40 -0800
Message-ID: <20231108183003.5981-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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

Intel VMX architecture is extended to run FRED guests, and the changes
are majorly:

1) New VMCS fields for FRED context management, which includes two new
event data VMCS fields, eight new guest FRED context VMCS fields and
eight new host FRED context VMCS fields.

2) VMX nested-Exception support for proper virtualization of stack
levels introduced with FRED architecture.

Search for the latest FRED spec in most search engines with this search pattern:

  site:intel.com FRED (flexible return and event delivery) specification

We want to send out the FRED VMX patch set for review while the FRED
native patch set v12 is being reviewed @
https://lkml.kernel.org/kvm/20231003062458.23552-1-xin3.li@intel.com/.
For easier review, I have set up a base tree with the latest FRED native
patch set on top of tip tree in the 'fred_v12' branch of repo
    https://github.com/xinli-intel/linux-fred-public.git.

Patch 1-2 are cleanups to VMX basic and misc MSRs, which were sent
out earlier as a preparation for FRED changes:
https://lore.kernel.org/kvm/20231030233940.438233-1-xin@zytor.com/.

Patch 3-14 add FRED support to VMX.
Patch 15-18 add FRED support to nested VMX.
Patch 19 exposes FRED to KVM guests to complete the enabling.
Patch 20-23 adds FRED selftests.


Shan Kang (1):
  KVM: selftests: Add fred exception tests

Xin Li (22):
  KVM: VMX: Cleanup VMX basic information defines and usages
  KVM: VMX: Cleanup VMX misc information defines and usages
  KVM: VMX: Add support for the secondary VM exit controls
  KVM: x86: Mark CR4.FRED as not reserved
  KVM: VMX: Initialize FRED VM entry/exit controls in vmcs_config
  KVM: VMX: Defer enabling FRED MSRs save/load until after set CPUID
  KVM: VMX: Disable intercepting FRED MSRs
  KVM: VMX: Initialize VMCS FRED fields
  KVM: VMX: Switch FRED RSP0 between host and guest
  KVM: VMX: Add support for FRED context save/restore
  KVM: x86: Add kvm_is_fred_enabled()
  KVM: VMX: Handle FRED event data
  KVM: VMX: Handle VMX nested exception for FRED
  KVM: VMX: Dump FRED context in dump_vmcs()
  KVM: nVMX: Add support for the secondary VM exit controls
  KVM: nVMX: Add FRED VMCS fields
  KVM: nVMX: Add support for VMX FRED controls
  KVM: nVMX: Add VMCS FRED states checking
  KVM: x86: Allow FRED/LKGS/WRMSRNS to be exposed to guests
  KVM: selftests: Add FRED VMCS fields to evmcs
  KVM: selftests: Run debug_regs test with FRED enabled
  KVM: selftests: Add a new VM guest mode to run user level code

 Documentation/virt/kvm/x86/nested-vmx.rst     |  19 +
 arch/x86/include/asm/hyperv-tlfs.h            |  19 +
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/include/asm/msr-index.h              |  15 +-
 arch/x86/include/asm/vmx.h                    |  57 ++-
 arch/x86/kvm/cpuid.c                          |   4 +-
 arch/x86/kvm/kvm_cache_regs.h                 |  10 +
 arch/x86/kvm/svm/svm.c                        |   4 +-
 arch/x86/kvm/vmx/capabilities.h               |  20 +-
 arch/x86/kvm/vmx/hyperv.c                     |  61 ++-
 arch/x86/kvm/vmx/nested.c                     | 315 ++++++++++++--
 arch/x86/kvm/vmx/nested.h                     |   2 +-
 arch/x86/kvm/vmx/vmcs.h                       |   1 +
 arch/x86/kvm/vmx/vmcs12.c                     |  19 +
 arch/x86/kvm/vmx/vmcs12.h                     |  38 ++
 arch/x86/kvm/vmx/vmcs_shadow_fields.h         |   6 +-
 arch/x86/kvm/vmx/vmx.c                        | 404 ++++++++++++++++--
 arch/x86/kvm/vmx/vmx.h                        |  14 +-
 arch/x86/kvm/x86.c                            |  55 ++-
 arch/x86/kvm/x86.h                            |   5 +-
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/kvm_util_base.h     |   1 +
 .../selftests/kvm/include/x86_64/evmcs.h      | 146 +++++++
 .../selftests/kvm/include/x86_64/processor.h  |  33 ++
 .../selftests/kvm/include/x86_64/vmx.h        |  20 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   5 +-
 .../selftests/kvm/lib/x86_64/processor.c      |  15 +-
 tools/testing/selftests/kvm/lib/x86_64/vmx.c  |   4 +-
 .../testing/selftests/kvm/x86_64/debug_regs.c |  50 ++-
 .../testing/selftests/kvm/x86_64/fred_test.c  | 262 ++++++++++++
 30 files changed, 1464 insertions(+), 150 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/fred_test.c


base-commit: d49b86c24e836941c85c4906e9519fca9426a6e0
-- 
2.42.0

