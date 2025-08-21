Return-Path: <linux-kselftest+bounces-39485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85343B2FAAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0147622201
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126E33376A8;
	Thu, 21 Aug 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vy5RIbZv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255843376A9;
	Thu, 21 Aug 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783118; cv=none; b=gj7ozBuONvqAS83hqqsB2T7ZU7UFMtsGfCILyPLW9vz8RVTCk4soIW5Fz2hPQ9jvqueaBIQkdkzq4Fnw+jpYo6EMTKvLu8Ah/pnL3j+sH/of6I3TbHXAay1m9ovb2y5KOLY4VZNv7uGVZI8/1FoQxkk64GdFjpOnb1bkbjT/0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783118; c=relaxed/simple;
	bh=5SpbS9sGztTEFvTIf6UWojiQ2c+TxlInkOtmfnNI2XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukDeurOOjfoinlUxdH42Z/8iDrPRWlWSusEOayIgbtDzuGbZazjSVU8zO6Qhrscuzfx9bcnGHwOpD9jqfJEwlQEEScRHZ7hKx62si2pTy8uurT8JGA846SCwwv2zFNl95d4xvi0NGZ0ahVC6TE9BCdPZk2/olmV6vXtTnGJN+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vy5RIbZv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755783116; x=1787319116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5SpbS9sGztTEFvTIf6UWojiQ2c+TxlInkOtmfnNI2XI=;
  b=Vy5RIbZveJzytkV4PZcLDWU0KYm0ir0jZ0j6RJfzr2IX5GWY5P1WEHNA
   SAMco9F/vyR9lFPKGH790g6md5+R4Bf6CFRQ5MDvyz6ybOkzt4/gt735G
   105y62J76LHTpzftqvCHkFVP91dUx4++39HpF+XU3ZsOyO8x6a9ivd17w
   MvrasLLNJY1tymV3s2bHJiFLHM8zY6VdhXrm5+8vSB6J2h2g/RlErkaKl
   tm8L+91+pWfzPhICeXTulP7DljoHRLamyhO1+8J+CIcVPWo0J9yB+rRvH
   fyS6GRHzFsEyjekTWVuTpe8Q7YMI0SscvbL2Z/CWbN9zGF72bYpakADWs
   w==;
X-CSE-ConnectionGUID: /2JWbNbzQK+LvKxYEO+TnA==
X-CSE-MsgGUID: fDsZFzxfTmmjsfBO/XPRiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69446059"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="69446059"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 06:31:55 -0700
X-CSE-ConnectionGUID: 4ZyHEcdSQH+HLXuDdFfbNQ==
X-CSE-MsgGUID: yEhMBDd4T4aqTc8eYtNnAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="199285385"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 06:31:37 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: chao.gao@intel.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	john.allen@amd.com,
	mingo@redhat.com,
	minipli@grsecurity.net,
	mlevitsk@redhat.com,
	pbonzini@redhat.com,
	rick.p.edgecombe@intel.com,
	seanjc@google.com,
	tglx@linutronix.de,
	weijiang.yang@intel.com,
	x86@kernel.org,
	xin@zytor.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	"Pratik R. Sampat" <prsampat@amd.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v13 00/21] Enable CET Virtualization
Date: Thu, 21 Aug 2025 06:30:34 -0700
Message-ID: <20250821133132.72322-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FPU support for CET virtualization has already been merged into 6.17-rc1.
Building on that, this series introduces Intel CET virtualization support for
KVM.

Changes in v13
1. Add "arch" and "size" fields to the register ID used in
   KVM_GET/SET_ONE_REG ioctls
2. Add a kselftest for KVM_GET/SET_ONE_REG ioctls
3. Advertise KVM_CAP_ONE_REG
4. Document how the emulation of SSP MSRs is flawed for 32-bit guests
5. Don't pass-thru MSR_IA32_INT_SSP_TAB and report it as unsupported for
   32-bit guests
6. Refine changelog to clarify why CET MSRs are pass-thru'd.
7. Limit SHSTK to 64-bit kernels
8. Retain CET state if L1 doesn't set VM_EXIT_LOAD_CET_STATE
9. Rename a new functions for clarity

---
Control-flow Enforcement Technology (CET) is a kind of CPU feature used
to prevent Return/CALL/Jump-Oriented Programming (ROP/COP/JOP) attacks.
It provides two sub-features(SHSTK,IBT) to defend against ROP/COP/JOP
style control-flow subversion attacks.

Shadow Stack (SHSTK):
  A shadow stack is a second stack used exclusively for control transfer
  operations. The shadow stack is separate from the data/normal stack and
  can be enabled individually in user and kernel mode. When shadow stack
  is enabled, CALL pushes the return address on both the data and shadow
  stack. RET pops the return address from both stacks and compares them.
  If the return addresses from the two stacks do not match, the processor
  generates a #CP.

Indirect Branch Tracking (IBT):
  IBT introduces new instruction(ENDBRANCH)to mark valid target addresses
  of indirect branches (CALL, JMP etc...). If an indirect branch is
  executed and the next instruction is _not_ an ENDBRANCH, the processor
  generates a #CP. These instruction behaves as a NOP on platforms that
  doesn't support CET.

CET states management
=====================
KVM cooperates with host kernel FPU framework to manage guest CET registers.
With CET supervisor mode state support in this series, KVM can save/restore
full guest CET xsave-managed states.

CET user mode and supervisor mode xstates, i.e., MSR_IA32_{U_CET,PL3_SSP}
and MSR_IA32_PL{0,1,2}, depend on host FPU framework to swap guest and host
xstates. On VM-Exit, guest CET xstates are saved to guest fpu area and host
CET xstates are loaded from task/thread context before vCPU returns to
userspace, vice-versa on VM-Entry. See details in kvm_{load,put}_guest_fpu().

CET supervisor mode states are grouped into two categories : XSAVE-managed
and non-XSAVE-managed, the former includes MSR_IA32_PL{0,1,2}_SSP and are
controlled by CET supervisor mode bit(S_CET bit) in XSS, the later consists
of MSR_IA32_S_CET and MSR_IA32_INTR_SSP_TBL.

VMX introduces new VMCS fields, {GUEST|HOST}_{S_CET,SSP,INTR_SSP_TABL}, to
facilitate guest/host non-XSAVES-managed states. When VMX CET entry/exit load
bits are set, guest/host MSR_IA32_{S_CET,INTR_SSP_TBL,SSP} are loaded from
equivalent fields at VM-Exit/Entry. With these new fields, such supervisor
states require no addtional KVM save/reload actions.

Tests
======
This series has successfully passed the basic CET user shadow stack test
and kernel IBT test in both L1 and L2 guests. The newly added
KVM-unit-tests [2] also passed, and its v11 has been tested with the AMD
CET series by John [3].

For your convenience, you can use my WIP QEMU [1] for testing.

[1]: https://github.com/gaochaointel/qemu-dev qemu-cet
[2]: https://lore.kernel.org/kvm/20250626073459.12990-1-minipli@grsecurity.net/
[3]: https://lore.kernel.org/kvm/aH6CH+x5mCDrvtoz@AUSJOHALLEN.amd.com/


Chao Gao (4):
  KVM: nVMX: Add consistency checks for CR0.WP and CR4.CET
  KVM: nVMX: Add consistency checks for CET states
  KVM: nVMX: Advertise new VM-Entry/Exit control bits for CET state
  KVM: selftest: Add tests for KVM_{GET,SET}_ONE_REG

Sean Christopherson (2):
  KVM: x86: Report XSS as to-be-saved if there are supported features
  KVM: x86: Load guest FPU state when access XSAVE-managed MSRs

Yang Weijiang (15):
  KVM: x86: Introduce KVM_{G,S}ET_ONE_REG uAPIs support
  KVM: x86: Refresh CPUID on write to guest MSR_IA32_XSS
  KVM: x86: Initialize kvm_caps.supported_xss
  KVM: x86: Add fault checks for guest CR4.CET setting
  KVM: x86: Report KVM supported CET MSRs as to-be-saved
  KVM: VMX: Introduce CET VMCS fields and control bits
  KVM: x86: Enable guest SSP read/write interface with new uAPIs
  KVM: VMX: Emulate read and write to CET MSRs
  KVM: x86: Save and reload SSP to/from SMRAM
  KVM: VMX: Set up interception for CET MSRs
  KVM: VMX: Set host constant supervisor states to VMCS fields
  KVM: x86: Don't emulate instructions guarded by CET
  KVM: x86: Enable CET virtualization for VMX and advertise to userspace
  KVM: nVMX: Virtualize NO_HW_ERROR_CODE_CC for L1 event injection to L2
  KVM: nVMX: Prepare for enabling CET support for nested guest

 arch/x86/include/asm/kvm_host.h               |   5 +-
 arch/x86/include/asm/vmx.h                    |   9 +
 arch/x86/include/uapi/asm/kvm.h               |  24 ++
 arch/x86/kvm/cpuid.c                          |  17 +-
 arch/x86/kvm/emulate.c                        |  46 ++-
 arch/x86/kvm/smm.c                            |   8 +
 arch/x86/kvm/smm.h                            |   2 +-
 arch/x86/kvm/svm/svm.c                        |   4 +
 arch/x86/kvm/vmx/capabilities.h               |   9 +
 arch/x86/kvm/vmx/nested.c                     | 163 ++++++++++-
 arch/x86/kvm/vmx/nested.h                     |   5 +
 arch/x86/kvm/vmx/vmcs12.c                     |   6 +
 arch/x86/kvm/vmx/vmcs12.h                     |  14 +-
 arch/x86/kvm/vmx/vmx.c                        |  84 +++++-
 arch/x86/kvm/vmx/vmx.h                        |   9 +-
 arch/x86/kvm/x86.c                            | 267 +++++++++++++++++-
 arch/x86/kvm/x86.h                            |  61 ++++
 tools/arch/x86/include/uapi/asm/kvm.h         |  24 ++
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/get_set_one_reg.c       |  35 +++
 20 files changed, 752 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/get_set_one_reg.c

-- 
2.47.3


