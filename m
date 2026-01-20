Return-Path: <linux-kselftest+bounces-49459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D18D3C1D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A800C482D5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351413ED135;
	Tue, 20 Jan 2026 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PWc0Hf5G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E83ECBEB;
	Tue, 20 Jan 2026 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896054; cv=none; b=fV30h7Bp99z9yeuz5f2mFOGb+xrdff0kRWh2ggk/9yxXL2VHtDqB36cx37o2nqhC7cmZtjmrN++mnYL5PS1MeazpZhPO5eqGsvMTpAo1a2oD4FYKbb+L8uDOfeWeNuFoU4cGdSpZ5zkUGXRU6r+Hvajb+NIAjaCuIPByFPwM9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896054; c=relaxed/simple;
	bh=qpTXmcjggay0Qs2GhOq2XMSMvtJ99P9d0ghkNSkPhLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PIx+9gXnPmuQ/wrE7a9C62qe8/QqyLdzFIRyCmZfDwjB5HKH8ibVTuoVmmg6e6YUKM7MoSTBwMQN7K4i1H8njHtVBtMb/vH6MxwfeEGK8Q6enq1GfKNRTWjhkMXhOin0/1R3694j4i59zSKUAXnhPuRHLBFVr/jzh1fftG9T0Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PWc0Hf5G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K3sKEi3252355;
	Tue, 20 Jan 2026 08:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=LUwtVb+zh7pOah3RTznusDvjfmcsislhfpa
	71/C+XK4=; b=PWc0Hf5GVi0L4cJ3NTXYA42CqC9NbgBlNdKMAjOVlk3tdOGww4B
	IkRcaD6EjukjbmiVBhDtpAMRfXGI5uPq7VBEIqTx8MXGwse4U5NcGa3K75/SMaXy
	2A/oc+NE339iNsSRkyguuqnirXNB9kl3RcualVPKDuVydwgD1c84t/lrm1oD+FSx
	zPCP0J//Dd8FyRjA3Z/86Bkh8+80RpNrdm4saOzgKwls0Ka0483KJAt7jtfvQ3ef
	Z2lE1vGC5jPGULXAxrV9lJghqUzRMKI1V0O1gidwDt/tg708kPUAb8ZjINAff1R+
	N99GgABx+3qlKzk0HFvnfqubqtk//0iqCmw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt27agnk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60K80Fmq007858;
	Tue, 20 Jan 2026 08:00:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4br3gm8q4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:15 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60K80Fat007833;
	Tue, 20 Jan 2026 08:00:15 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 60K80Flv007823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 08:00:15 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 93FB522B37; Tue, 20 Jan 2026 13:30:14 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH 00/27] Nested virtualization for KVM RISC-V
Date: Tue, 20 Jan 2026 13:29:46 +0530
Message-ID: <20260120080013.2153519-1-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VQ3woIZCChEQITWoDZsuYTYmDwBvlg2X
X-Proofpoint-GUID: VQ3woIZCChEQITWoDZsuYTYmDwBvlg2X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX+seI/qlFN9ds
 6HawpbYn5OSwQSWeC9ptm4pgEO88gxZ3o+JMPgk3U9EWTUwQPTzUxUp/9LpHPwFGCpWL0LeAInM
 92MGwLCUJ5mrD1QMoWeb5dad+/1BD9aq7i47uDI27GDaJtQbHlzmMk5VeTd3d5829f3jlVU8CO0
 514TxJt9VYAwMHSVpn5/af8MkezzjBbj3sKHBEyjwW4ODK1Gjx1NR8ZVrK7BbImQvp8jN8hdxrU
 NMufIYnHEbPDhUo6/s5JOTCpjpAbrrlnW8gCahvehjs3AMnRFJ/fcj31jHC2Wbp23yRuZmvEFtJ
 9ixkwFP7zjAU7HVF05zed1DXezRUjVZlgfQGAZpWqtgcQnrYXM5wG2MQXrrIgU74r1uC5Pcpi1V
 xke6PxqPwPT091aX2x5FAY3lzsi5qrYjgmA8Y3bjMOJHWSXBpjnuJDQc7ZlA+CI6AMrZTiVqAwW
 saeTKq41Nq7/qRuWPng==
X-Authority-Analysis: v=2.4 cv=P6U3RyAu c=1 sm=1 tr=0 ts=696f3613 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=EAKoEhkXCw2zVP5q2N0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200065

Initial nested virtualization support for KVM RISC-V. Using
this series, we can boot Xvisor inside KVM guest and KVM RISC-V
insmod also works inside KVM guest but we can't run nested guest
at the moment due to work-in-progress G-stage emulation (or
G-stage page table walker).

Patch01-to-Patch09: Fixes and preparatory changes
Patch10-to-Patch23: Actual nested virtualization support
Patch24-to-Patch27: ONE_REG interface and get-reg-list selftest

Upcoming work on-top-of this series include:
 * Software MMU emulation for nested guest (aka swtlb)
 * HLV/HSV emulation
 * Sstc emulation for nested guest
 * SBI NACL for guest hypervisor
 * ... and more ...

These patches can also be found in the riscv_kvm_nested_v1
branch at: https://github.com/avpatel/linux.git

Anup Patel (27):
  RISC-V: KVM: Fix error code returned for Smstateen ONE_REG
  RISC-V: KVM: Fix error code returned for Ssaia ONE_REG
  RISC-V: KVM: Check host Ssaia extension when creating AIA irqchip
  RISC-V: KVM: Introduce common kvm_riscv_isa_check_host()
  RISC-V: KVM: Factor-out ISA checks into separate sources
  RISC-V: KVM: Move timer state defines closer to struct in UAPI header
  RISC-V: KVM: Add hideleg to struct kvm_vcpu_config
  RISC-V: KVM: Factor-out VCPU config into separate sources
  RISC-V: KVM: Don't check hstateen0 when updating sstateen0 CSR
  RISC-V: KVM: Initial skeletal nested virtualization support
  RISC-V: KVM: Use half VMID space for nested guest
  RISC-V: KVM: Extend kvm_riscv_mmu_update_hgatp() for nested
    virtualization
  RISC-V: KVM: Extend kvm_riscv_vcpu_config_load() for nested
    virtualization
  RISC-V: KVM: Extend kvm_riscv_vcpu_update_timedelta() for nested virt
  RISC-V: KVM: Extend trap redirection for nested virtualization
  RISC-V: KVM: Check and inject nested virtual interrupts
  RISC-V: KVM: Extend kvm_riscv_isa_check_host() for nested virt
  RISC-V: KVM: Trap-n-emulate SRET for Guest HS-mode
  RISC-V: KVM: Redirect nested supervisor ecall and breakpoint traps
  RISC-V: KVM: Redirect nested WFI and WRS traps
  RISC-V: KVM: Implement remote HFENCE SBI calls for guest
  RISC-V: KVM: Add CSR emulation for nested virtualization
  RISC-V: KVM: Add HFENCE emulation for nested virtualization
  RISC-V: KVM: Add ONE_REG interface for nested virtualization state
  RISC-V: KVM: selftests: Add nested virt state to get-reg-list test
  RISC-V: KVM: Add ONE_REG interface for nested virtualization CSRs
  RISC-V: KVM: selftests: Add nested virt CSRs to get-reg-list test

 arch/riscv/include/asm/csr.h                  |  17 +
 arch/riscv/include/asm/insn.h                 |   9 +
 arch/riscv/include/asm/kvm_gstage.h           |   2 +
 arch/riscv/include/asm/kvm_host.h             |  29 +-
 arch/riscv/include/asm/kvm_isa.h              |  20 +
 arch/riscv/include/asm/kvm_mmu.h              |   2 +-
 arch/riscv/include/asm/kvm_tlb.h              |  37 +-
 arch/riscv/include/asm/kvm_vcpu_config.h      |  25 ++
 arch/riscv/include/asm/kvm_vcpu_nested.h      | 163 ++++++++
 arch/riscv/include/asm/kvm_vcpu_timer.h       |   1 +
 arch/riscv/include/asm/kvm_vmid.h             |   1 +
 arch/riscv/include/uapi/asm/kvm.h             |  36 +-
 arch/riscv/kvm/Makefile                       |   6 +
 arch/riscv/kvm/aia.c                          |   4 +
 arch/riscv/kvm/aia_device.c                   |   5 +
 arch/riscv/kvm/gstage.c                       |  14 +
 arch/riscv/kvm/isa.c                          | 259 ++++++++++++
 arch/riscv/kvm/main.c                         |  13 +-
 arch/riscv/kvm/mmu.c                          |  18 +-
 arch/riscv/kvm/tlb.c                          | 135 +++++-
 arch/riscv/kvm/vcpu.c                         | 117 ++----
 arch/riscv/kvm/vcpu_config.c                  | 130 ++++++
 arch/riscv/kvm/vcpu_exit.c                    |  62 ++-
 arch/riscv/kvm/vcpu_fp.c                      |   9 +-
 arch/riscv/kvm/vcpu_insn.c                    |  46 +++
 arch/riscv/kvm/vcpu_nested.c                  | 258 ++++++++++++
 arch/riscv/kvm/vcpu_nested_csr.c              | 389 ++++++++++++++++++
 arch/riscv/kvm/vcpu_nested_insn.c             | 140 +++++++
 arch/riscv/kvm/vcpu_nested_swtlb.c            | 146 +++++++
 arch/riscv/kvm/vcpu_onereg.c                  | 334 +++------------
 arch/riscv/kvm/vcpu_pmu.c                     |   5 +-
 arch/riscv/kvm/vcpu_sbi_replace.c             |  63 ++-
 arch/riscv/kvm/vcpu_timer.c                   |  24 +-
 arch/riscv/kvm/vcpu_vector.c                  |   5 +-
 arch/riscv/kvm/vmid.c                         |  33 +-
 .../selftests/kvm/riscv/get-reg-list.c        | 106 ++++-
 36 files changed, 2244 insertions(+), 419 deletions(-)
 create mode 100644 arch/riscv/include/asm/kvm_isa.h
 create mode 100644 arch/riscv/include/asm/kvm_vcpu_config.h
 create mode 100644 arch/riscv/include/asm/kvm_vcpu_nested.h
 create mode 100644 arch/riscv/kvm/isa.c
 create mode 100644 arch/riscv/kvm/vcpu_config.c
 create mode 100644 arch/riscv/kvm/vcpu_nested.c
 create mode 100644 arch/riscv/kvm/vcpu_nested_csr.c
 create mode 100644 arch/riscv/kvm/vcpu_nested_insn.c
 create mode 100644 arch/riscv/kvm/vcpu_nested_swtlb.c

-- 
2.43.0


