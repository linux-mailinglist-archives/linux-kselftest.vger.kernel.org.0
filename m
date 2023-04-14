Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFCB6E1C8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 08:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDNG0F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 02:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjDNG0E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 02:26:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C2255B4;
        Thu, 13 Apr 2023 23:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681453563; x=1712989563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7trrvK1ZlLAQDjKo9f9ZR8zGWgou9qtmAEWUy0Yqn8A=;
  b=F9nXfAWDv6AHonq0DbmPcV1dEael2AcWML7yk1pkbWH5+6Vy7BRgv6Tz
   E2fAvnCioD+dM7JOXm7uWS0QrsVmcvr0Wxykiv6BbFWYETN5bVfMsLk7I
   Vf5E0B+HYHk34dX4nBKl3cEtAktQmejAmu+siRlY0eMK9kUeFxNmnAiFP
   j3loP1y8GeKj2JQnM7fhf4PqKIFgklGe6hBkuRQPyQNHAfOwf1hPaSTAN
   ZbwxfklW5TbSJMlj2CzsR8C7htwBXZWjB0UhJ8auCTKAGMxPHHH+PnTtO
   eoOuMQPnpLZ8u+izpsaMP3YY8l4Ra7tNCK1Rad+V5mUjpDTryZgDKoGpE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="341892660"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="341892660"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 23:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="935885787"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="935885787"
Received: from spr.sh.intel.com ([10.239.53.106])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 23:25:55 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     kvm@vger.kernel.org
Cc:     Jiaan Lu <jiaan.lu@intel.com>, Chao Gao <chao.gao@intel.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Babu Moger <babu.moger@amd.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Matlack <dmatlack@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Nikunj A Dadhania <nikunj@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        Zhang Chen <chen.zhang@intel.com>
Subject: [RFC PATCH v2 00/11] Intel IA32_SPEC_CTRL Virtualization
Date:   Fri, 14 Apr 2023 14:25:21 +0800
Message-Id: <20230414062545.270178-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes since RFC v1:
 * add two kselftests (patch 10-11)
 * set virtual MSRs also on APs [Pawan]
 * enable "virtualize IA32_SPEC_CTRL" for L2 to prevent L2 from changing
   some bits of IA32_SPEC_CTRL (patch 4)
 * other misc cleanup and cosmetic changes

RFC v1: https://lore.kernel.org/lkml/20221210160046.2608762-1-chen.zhang@intel.com/


This series introduces "virtualize IA32_SPEC_CTRL" support. Here are
introduction and use cases of this new feature.

### Virtualize IA32_SPEC_CTRL

"Virtualize IA32_SPEC_CTRL" [1] is a new VMX feature on Intel CPUs. This feature
allows VMM to lock some bits of IA32_SPEC_CTRL MSR even when the MSR is
pass-thru'd to a guest.


### Use cases of "virtualize IA32_SPEC_CTRL" [2]

Software mitigations like Retpoline and software BHB-clearing sequence depend on
CPU microarchitectures. And guest cannot know exactly the underlying
microarchitecture. When a guest is migrated between processors of different
microarchitectures, software mitigations which work perfectly on previous
microachitecture may be not effective on the new one. To fix the problem, some
hardware mitigations should be used in conjunction with software mitigations.
Using virtual IA32_SPEC_CTRL, VMM can enforce hardware mitigations transparently
to guests and avoid those hardware mitigations being unintentionally disabled
when guest changes IA32_SPEC_CTRL MSR.


### Intention of this series

This series adds the capability of enforcing hardware mitigations for guests
transparently and efficiently (i.e., without intecepting IA32_SPEC_CTRL MSR
accesses) to kvm. The capability can be used to solve the VM migration issue in
a pool consisting of processors of different microarchitectures.

Specifically, below are two target scenarios of this series:

Scenario 1: If retpoline is used by a VM to mitigate IMBTI in CPL0, VMM can set
	    RRSBA_DIS_S on parts enumerates RRSBA. Note that the VM is presented
	    with a microarchitecture doesn't enumerate RRSBA.

Scenario 2: If a VM uses software BHB-clearing sequence on transitions into CPL0
	    to mitigate BHI, VMM can use "virtualize IA32_SPEC_CTRL" to set
	    BHI_DIS_S on new parts which doesn't enumerate BHI_NO.

Intel defines some virtual MSRs [2] for guests to report in-use software
mitigations. This allows guests to opt in VMM's deploying hardware mitigations
for them if the guests are either running or later migrated to a system on which
in-use software mitigations are not effective. The virtual MSRs interface is
also added in this series.

### Organization of this series

1. Patch 1-3	Advertise RRSBA_CTRL and BHI_CTRL to guest
2. Patch 4	Add "virtualize IA32_SPEC_CTRL" support
3. Patch 5-9	Allow guests to report in-use software mitigations to KVM so
                that KVM can enable hardware mitigations for guests.
4. Patch 10-11	Add kselftest for virtual MSRs and IA32_SPEC_CTRL

[1]: https://cdrdv2.intel.com/v1/dl/getContent/671368 Ref. #319433-047 Chapter 12
[2]: https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/branch-history-injection.html

Chao Gao (3):
  KVM: VMX: Advertise MITI_ENUM_RETPOLINE_S_SUPPORT
  KVM: selftests: Add tests for virtual enumeration/mitigation MSRs
  KVM: selftests: Add tests for IA32_SPEC_CTRL MSR

Pawan Gupta (1):
  x86/bugs: Use Virtual MSRs to request hardware mitigations

Zhang Chen (7):
  x86/msr-index: Add bit definitions for BHI_DIS_S and BHI_NO
  KVM: x86: Advertise CPUID.7.2.EDX and RRSBA_CTRL support
  KVM: x86: Advertise BHI_CTRL support
  KVM: VMX: Add IA32_SPEC_CTRL virtualization support
  KVM: x86: Advertise ARCH_CAP_VIRTUAL_ENUM support
  KVM: VMX: Advertise MITIGATION_CTRL support
  KVM: VMX: Advertise MITI_CTRL_BHB_CLEAR_SEQ_S_SUPPORT

 arch/x86/include/asm/msr-index.h              |  33 +++-
 arch/x86/include/asm/vmx.h                    |   5 +
 arch/x86/include/asm/vmxfeatures.h            |   2 +
 arch/x86/kernel/cpu/bugs.c                    |  25 +++
 arch/x86/kvm/cpuid.c                          |  22 ++-
 arch/x86/kvm/reverse_cpuid.h                  |   8 +
 arch/x86/kvm/svm/svm.c                        |   3 +
 arch/x86/kvm/vmx/capabilities.h               |   5 +
 arch/x86/kvm/vmx/nested.c                     |  13 ++
 arch/x86/kvm/vmx/vmcs.h                       |   2 +
 arch/x86/kvm/vmx/vmx.c                        | 112 ++++++++++-
 arch/x86/kvm/vmx/vmx.h                        |  43 ++++-
 arch/x86/kvm/x86.c                            |  19 +-
 tools/arch/x86/include/asm/msr-index.h        |  37 +++-
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/x86_64/processor.h  |   5 +
 .../selftests/kvm/x86_64/spec_ctrl_msr_test.c | 178 ++++++++++++++++++
 .../kvm/x86_64/virtual_mitigation_msr_test.c  | 175 +++++++++++++++++
 18 files changed, 676 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/spec_ctrl_msr_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/virtual_mitigation_msr_test.c


base-commit: 400d2132288edbd6d500f45eab5d85526ca94e46
-- 
2.40.0

