Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDD947D1DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbhLVMky (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:40:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:11431 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233073AbhLVMkx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176853; x=1671712853;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q5En1YLY1qoL0SxBUlbxhLuNP84xc/zvaKoK3VJ01+c=;
  b=WNhSDmDbp+Qi4RoVxZ43vnhNKf/sKoMmTtAXvNNT+V332R5epdmDqupM
   Xrt5qfRFfQu1XKKYKXDnnPvO4Xv+OhSea/mVBseznlRaosNRHhtugXLzU
   QoHx3aNXWgKT/qLEh7u0pPEFLfGboXKBscbZjdSQkLpWv2TCB8kw0Lsk4
   rPiK1Q96RyDQh9HATqC3VjlFTmhmg3NkRWCktZq8Fl7nDnLsxd9dVvAm8
   qemDqR3M3RtK0VPUaNQB/1zG0AYtyAfLigNNW038w99D4JSBbDqVG7QF5
   VY0L4eTMdzUyERTNx+9/LK+l3MUiAmp8KDc511pq43v7YHr4Qod3ayRmY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833402"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833402"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:40:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002688"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:40:52 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 00/22] AMX Support in KVM
Date:   Wed, 22 Dec 2021 04:40:30 -0800
Message-Id: <20211222124052.644626-1-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Highly appreciate for your review. We will continue working on
remaining selftest and send out later.

TODO:
  - kvm selftest for AMX is still in progress;

----
v2->v3:
  - Trap #NM until write IA32_XFD with a non-zero value (Thomas)
  - Revise return value in __xstate_request_perm() (Thomas)
  - Revise doc for KVM_GET_SUPPORTED_CPUID (Paolo)
  - Add Thomas's reviewed-by on one patch
  - Reorder disabling read interception of XFD_ERR patch (Paolo)
  - Move disabling r/w interception of XFD from x86.c to vmx.c (Paolo)
  - Provide the API doc together with the new KVM_GET_XSAVE2 ioctl (Paolo)
  - Make KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2) return minimum size of struct
    kvm_xsave (4K) (Paolo)
  - Request permission at the start of vm_create_with_vcpus() in selftest
  - Request permission conditionally when XFD is supported (Paolo)

v1->v2:
  - Live migration supported and verified with a selftest
  - Rebase to Thomas's new series for guest fpstate reallocation [1]
  - Expand fpstate at KVM_SET_CPUID2 instead of when emulating XCR0
    and IA32_XFD (Thomas/Paolo)
  - Accordingly remove all exit-to-userspace stuff
  - Intercept #NM to save guest XFD_ERR and restore host/guest value
    at preemption on/off boundary (Thomas)
  - Accordingly remove all xfd_err logic in preemption callback and
    fpu_swap_kvm_fpstate()
  - Reuse KVM_SET_XSAVE to handle both legacy and expanded buffer (Paolo)
  - Don't return dynamic bits w/o prctl() in KVM_GET_SUPPORTED_CPUID (Paolo)
  - Check guest permissions for dynamic features in CPUID[0xD] instead
    of only for AMX at KVM_SET_CPUID (Paolo)
  - Remove dynamic bit check for 32-bit guest in __kvm_set_xcr() (Paolo)
  - Fix CPUID emulation for 0x1d and 0x1e (Paolo)
  - Move "disable interception" to the end of the series (Paolo)

This series brings AMX (Advanced Matrix eXtensions) virtualization
support to KVM. The preparatory series from Thomas [1] is also included. 

A large portion of the changes in this series is to deal with eXtended
Feature Disable (XFD) which allows resizing of the fpstate buffer to 
support dynamically-enabled XSTATE features with large state component
(e.g. 8K for AMX).

There are a lot of simplications when comparing v2/v3 to the original 
proposal [2] and the first version [3]. Thanks to Thomas and Paolo for
many good suggestions. 

The support is based on following key changes:

  - Guest permissions for dynamically-enabled XSAVE features

    Native tasks have to request permission via prctl() before touching
    a dynamic-resized XSTATE compoenent. Introduce guest permissions 
    for the similar purpose. Userspace VMM is expected to request guest
    permission only once when the first vCPU is created.

    KVM checks guest permission in KVM_SET_CPUID2. Setting XFD in guest
    cpuid w/o proper permissions fails this operation. In the meantime,
    unpermitted features are also excluded in KVM_GET_SUPPORTED_CPUID.

  - Extend fpstate reallocation mechanism to cover guest fpu

    Unlike native tasks which have reallocation triggered from #NM 
    handler, guest fpstate reallocation is requested by KVM when it
    identifies the intention on using dynamically-enabled XSAVE
    features inside guest.

    Extend fpu core to allow KVM request fpstate buffer expansion
    for a guest fpu containter.

  - Trigger fpstate reallocation in KVM

    This could be done either statically (before guest runs) or
    dynamically (in the emulation path). According to discussion [1]
    we decide to statically enable all xfeatures allowed by guest perm
    in KVM_SET_CPUID2, with fpstate buffer sized accordingly. This spares
    a lot of code and also avoid imposing an ordered restore sequence
    (XCR0, XFD and XSTATE) to userspace VMM.

  - RDMSR/WRMSR emulation for IA32_XFD

    Because fpstate expansion is completed in KVM_SET_CPUID2, emulating
    r/w access to IA32_XFD simply involves the xfd field in the guest 
    fpu container. If write and guest fpu is currently active, the 
    software state (guest_fpstate::xfd and per-cpu xfd cache) is also
    updated.

  - RDMSR/WRMSR emulation for XFD_ERR

    When XFD causes an instruction to generate #NM, XFD_ERR contains
    information about which disabled state components are being accessed.
    It'd be problematic if the XFD_ERR value generated in guest is 
    consumed/clobbered by the host before the guest itself doing so. 

    Intercept #NM exception to save the guest XFD_ERR value when write
    IA32_XFD with a non-zero value for 1st time. There is at most one
    interception per guest task given a dynamic feature.

    RDMSR/WRMSR emulation uses the saved value. The host value (always
    ZERO outside of the host #NM handler) is restored before enabling
    preemption. The saved guest value is restored right before entering
    the guest (with preemption disabled).

  - Get/set dynamic xfeature state for migration

    Introduce new capability (KVM_CAP_XSAVE2) to deal with >4KB fpstate
    buffer. Reading this capability returns the size of the current 
    guest fpstate (e.g. after expansion). Userspace VMM uses a new ioctl
    (KVM_GET_XSAVE2) to read guest fpstate from the kernel and reuses
    the existing ioctl (KVM_SET_XSAVE) to update guest fpsate to the
    kernel. KVM_SET_XSAVE is extended to do properly_sized memdup_user()
    based on the guest fpstate.

  - Expose related cpuid bits to guest

    The last step is to allow exposing XFD, AMX_TILE, AMX_INT8 and
    AMX_BF16 in guest cpuid. Adding those bits into kvm_cpu_caps finally
    activates all previous logics in this series

  - Optimization: disable interception for IA32_XFD

    IA32_XFD can be frequently updated by the guest, as it is part of
    the task state and swapped in context switch when prev and next have
    different XFD setting. Always intercepting WRMSR can easily cause
    non-negligible overhead.

    Disable r/w emulation for IA32_XFD after intercepting the first
    WRMSR(IA32_XFD) with a non-zero value. However MSR passthrough 
    implies the software state (guest_fpstate::xfd and per-cpu xfd
    cache) might be out of sync with MSR. This suggests KVM needs to
    re-sync them at VM-exit before preemption is enabled.

To verify AMX virtualization overhead on non-AMX usages, we run the
Phoronix kernel build test in the guest w/ and w/o AMX in cpuid. The 
result shows no observable difference between two configurations.

Thanks Jun Nakajima and Kevin Tian for the design suggestions when
this version is being internally worked on.

[1] https://lore.kernel.org/all/20211214022825.563892248@linutronix.de/
[2] https://www.spinics.net/lists/kvm/msg259015.html
[3] https://lore.kernel.org/lkml/20211208000359.2853257-1-yang.zhong@intel.com/

Thanks,
Jing

---
Guang Zeng (1):
  kvm: x86: Get/set expanded xstate buffer

Jing Liu (13):
  kvm: x86: Fix xstate_required_size() to follow XSTATE alignment rule
  kvm: x86: Exclude unpermitted xfeatures at KVM_GET_SUPPORTED_CPUID
  kvm: x86: Check permitted dynamic xfeatures at KVM_SET_CPUID2
  x86/fpu: Make XFD initialization in __fpstate_reset() a function
    argument
  kvm: x86: Enable dynamic XSAVE features at KVM_SET_CPUID2
  kvm: x86: Add emulation for IA32_XFD
  x86/fpu: Prepare xfd_err in struct fpu_guest
  kvm: x86: Intercept #NM for saving IA32_XFD_ERR
  kvm: x86: Emulate IA32_XFD_ERR for guest
  kvm: x86: Disable RDMSR interception of IA32_XFD_ERR
  kvm: x86: Add XCR0 support for Intel AMX
  kvm: x86: Add CPUID support for Intel AMX
  kvm: x86: Disable interception for IA32_XFD on demand

Kevin Tian (2):
  x86/fpu: Provide fpu_update_guest_perm_features() for guest
  x86/fpu: Provide fpu_update_guest_xfd() for IA32_XFD emulation

Thomas Gleixner (5):
  x86/fpu: Extend fpu_xstate_prctl() with guest permissions
  x86/fpu: Prepare guest FPU for dynamically enabled FPU features
  x86/fpu: Add guest support to xfd_enable_feature()
  x86/fpu: Add uabi_size to guest_fpu
  x86/fpu: Provide fpu_sync_guest_vmexit_xfd_state()

Wei Wang (1):
  kvm: selftests: Add support for KVM_CAP_XSAVE2

 Documentation/virt/kvm/api.rst                |  46 +++++-
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/fpu/api.h                |  11 ++
 arch/x86/include/asm/fpu/types.h              |  32 ++++
 arch/x86/include/asm/kvm_host.h               |   2 +
 arch/x86/include/uapi/asm/kvm.h               |  16 +-
 arch/x86/include/uapi/asm/prctl.h             |  26 ++--
 arch/x86/kernel/fpu/core.c                    | 104 ++++++++++++-
 arch/x86/kernel/fpu/xstate.c                  | 147 +++++++++++-------
 arch/x86/kernel/fpu/xstate.h                  |  15 +-
 arch/x86/kernel/process.c                     |   2 +
 arch/x86/kvm/cpuid.c                          |  93 ++++++++---
 arch/x86/kvm/vmx/vmcs.h                       |   5 +
 arch/x86/kvm/vmx/vmx.c                        |  32 +++-
 arch/x86/kvm/vmx/vmx.h                        |   2 +-
 arch/x86/kvm/x86.c                            | 102 +++++++++++-
 include/uapi/linux/kvm.h                      |   4 +
 tools/arch/x86/include/uapi/asm/kvm.h         |  16 +-
 tools/include/uapi/linux/kvm.h                |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   2 +
 .../selftests/kvm/include/x86_64/processor.h  |  10 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  32 ++++
 .../selftests/kvm/lib/x86_64/processor.c      |  67 +++++++-
 .../testing/selftests/kvm/x86_64/evmcs_test.c |   2 +-
 tools/testing/selftests/kvm/x86_64/smm_test.c |   2 +-
 .../testing/selftests/kvm/x86_64/state_test.c |   2 +-
 .../kvm/x86_64/vmx_preemption_timer_test.c    |   2 +-
 27 files changed, 668 insertions(+), 111 deletions(-)

-- 
2.27.0

