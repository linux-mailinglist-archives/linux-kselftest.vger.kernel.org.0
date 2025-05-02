Return-Path: <linux-kselftest+bounces-32147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9582AAA69F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 07:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EDB37A8E6F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 05:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3297C1B413D;
	Fri,  2 May 2025 05:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qpGhHfqB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744015DBB3;
	Fri,  2 May 2025 05:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746162271; cv=fail; b=B+Px6gNU0o6SMduBCk0Xsa75sB/OD6Fb0MX/UC3ceZ+ZW9bwDUqiBq6RcfSuikTrnCZzDBB8hApEWsZdqwUmY+6mlEEdDg9D+sH37yHllsrL5d4F28ickK7H9PWjIMDyoRgkbAQmDJYGOdNSvg1YFhRMX45zjh5tK7UaRk6I3jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746162271; c=relaxed/simple;
	bh=F2Q7/2ZDg+RgbcJfZoB14B3Lq3+0kWON2v3t9CQPA0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1mZefflMwn6/bRD+2eFqfGOvCjOQUwHE1Keoan7D+Ixpu+4l6alZGRb4MxnCisOiepBVBQltbDwUJrEuh+fRxFdsg1H33kKHQtJVIwUQ/X+ZEN++a/3ESG3Ctlr5aIswJTbfTjYNLzYPGVWxpK3Us9Zss7bHa059d4KpdLMF+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qpGhHfqB; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpVu6u/PMN1Pcq94BH1dtLXC2JHLeY5zqJzjvZO8QJTg1eH9z3AiBg2lB1eZVxD8A3xI8evi9g3VyYP6mxGV+2mI1wrOwkdp2b5xmmKh3R0PFYoAo/V7KPxKMazJhFszhWnjTexsu7LrVByNnSBOWzXPY9c48ywbYfnx68+gUA3iAdWicuVeVw6Zrj3zHhqxDszNXdgmjuhJ7qxfVXxpxbMh1dhGRzRlTjGCYJEFsncdIxjwtL+hJCjAGq8/0FglBf/FlZhMUhbc6KaDUDS5w7KXb4ugISCWjGBKTz/k6T4M3yto/5G8LeyHzUfzu4bi7tlJVoc0ysSmBzf3SF+fhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4ZST9Bs3m4Q4ecqFvqRRR/3R7rsUghwJKmTW1CBCsI=;
 b=iolG+XUOJBSx/19E0C+kXRflh25R8Wmm+Vz2CpbAiVDa0J8iDqM4Lu+7CuDmBA2JGiB+QmJNnu4Wc6d4u7oVqbvaw2DSLCvtXwLjUtWJVIloWLu65AUQRNuxho1ZHCx+fLpW4E6GS9WrarLGfG7m2QBAUYcA81iBaa6jSr9s8bPerAieJsPExOc96q8KoxHR9g6anuIOXejKr8oVvNGEkM/YzDDKoHmXi18/5mrNQMReKy/Xyn9MjXsz70xAR7QVHyy9IJ70okuk1JpD5xtyO2ObtCXAV8F46TuzWlbgX4aIcAy0SdSdPvXabPKBoS6z9oY3+ebz5/LYAUfTbP+zfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4ZST9Bs3m4Q4ecqFvqRRR/3R7rsUghwJKmTW1CBCsI=;
 b=qpGhHfqBkMGMnSlbntbo/Az9N9Jc9+rmOfVnhFvKuqmreI5j9+1gNr0/qFyZZh0GJrGX2xJHr1pCSS8M3ThFgqfugUhCEo8LGqhsS/NCrkXxEtFWpZtRrBnRavGOKQLa9lN0GwINhrbiZQqKN5OO5zsSsTOBh5m8ec96JPS3xy8=
Received: from MN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:52f::10)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 05:04:24 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::28) by MN0PR03CA0004.outlook.office365.com
 (2603:10b6:208:52f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Fri,
 2 May 2025 05:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 05:04:24 +0000
Received: from brahmaputra.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 May
 2025 00:04:21 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <nikunj@amd.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v5 4/5] KVM: SVM: Add support for KVM_CAP_X86_BUS_LOCK_EXIT on SVM CPUs
Date: Fri, 2 May 2025 05:03:45 +0000
Message-ID: <20250502050346.14274-5-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502050346.14274-1-manali.shukla@amd.com>
References: <20250502050346.14274-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3d0d8a-f24f-469f-a256-08dd8936cea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gesTTCDwcJDPwN6+NnXMoTM8FLcrHkIY3ikf4Mlivky8AB4WqbzBNrGi6Y9T?=
 =?us-ascii?Q?/TzzLVjybo6Iir+Okdn2OnuGBADqqBrwcuuwTEzdO4ULXLLy/4DrxtFdAbRo?=
 =?us-ascii?Q?yyMvqKeek2rdGtPX1jqaLeOW4GeDaRZaLSD/fnGUqv8ixJeuUnqC5Ys+jHEa?=
 =?us-ascii?Q?xlfG7ZgHKFSB8vi/ZIvfDAh9lavS+YjN33+BzeT7cIYUCNZxaddiJj+WoONF?=
 =?us-ascii?Q?nvGEhognVdxqRbGc6cJSm+VCcl04znTuj8Zs3atieKxKJVnmiFsREJjQztWX?=
 =?us-ascii?Q?aQ6FBX1Ub7EAJL60I5c40ZI6svJNgISRfXmAYsm/qKJ+UBaSp6bzaGEHf4DQ?=
 =?us-ascii?Q?d4fLgSrks4m30rT5TCpZCqudcA0bRhEqyf+G32nq9mvCHbMPJOR6drt80x5R?=
 =?us-ascii?Q?P8allC2MhUjZ/BvPLwF4Q8rFWmiwVeIkTLeya6QTpRpmrfyCY73l3jMQuIXr?=
 =?us-ascii?Q?tbxbaJnmGs2h+EhCRSoMT4HdjRsecKRiCpTTSd/IyOcNSsJeV1RsgTFQC7rr?=
 =?us-ascii?Q?FlNs+Pii/pNbtQygv/bhnF5ZDYlncWi0NM1qc3LSqtnuuoiwxI3NhkrxX6pY?=
 =?us-ascii?Q?iEBt3IYUIMfrI0dcjK/bkbXlOnqBFPvYcu6uKtSPqx2heYwYHrbVB/QX5R+K?=
 =?us-ascii?Q?Gx/jh4jEAPTGthPXW5g1OdAxr304mUDYK4uOC+sIGfdsh5rGJvK9Ynp2CD5b?=
 =?us-ascii?Q?5U9oeY1zoLOy+g0FVcGs6Bfov4ZUinc8vn6rr73MIZ1GisFDRwE+7CD8ay81?=
 =?us-ascii?Q?ekpLMEGHtYs2VzyzFZECEerd5O4v6K4Nnos/U2f3VAtg8F9z1MZpcnOM4JKu?=
 =?us-ascii?Q?nSYK84lNtuQBWnDMsAS93Mox3OelMXZzt4wPZTz0sub7dorB/3CJCmHbUWY/?=
 =?us-ascii?Q?2foCAJ8cSMzgbOBfHK7XfufVTIytTiirQMMs15Edywmx7PLUmDFg2R86AWC7?=
 =?us-ascii?Q?NuX56Tv8UiASMMJjSFm8JIF4N5LYhl3w1DSlRN5sjarbNqk2sltDeY3BirOH?=
 =?us-ascii?Q?/NvazDSTIP6Xz+imrXCd3cLL4C48uzFm9BGiuO4YwcavfdXOGZF1g0+d/fhy?=
 =?us-ascii?Q?/N6P3PAf8B9jjs/IMBuT9wpXmKoU1KFZ7fQKX0M6OawnaWW53BE+6cm+8T1u?=
 =?us-ascii?Q?1wRfC3JbIUsViGG7Ai7wQzGlHSw0hPFZST0vMFChLrunMIQ03zqNiT455SZD?=
 =?us-ascii?Q?SHq49W/BI+rT2cI8cdIQP0iIJDFV7qADpYyZDb9mBjiwfBm6FfUeE5X0OTtO?=
 =?us-ascii?Q?frNBb3WCRARGe+dCIcBYvICb8vw3ZwFX5EENdSE0LxOEgxbwwwZts4i6sMXO?=
 =?us-ascii?Q?AtqUez1DmQNLnDMvaA6SCPY/D89rXM7qot9P8ptbuWRrN+pZ3WdrxIPD5Rhc?=
 =?us-ascii?Q?yctlC14whWEK2bBOj1E9KUcTVRYO4Q2a8zhNM4/GjB3QeJ98ZH2TUV6tb6he?=
 =?us-ascii?Q?xmChaUfBAh0ISCYWMoe5c/7knbpH86Kfs4/BudyYFnArtRk65rERqrK8SteI?=
 =?us-ascii?Q?5cHmO9B9NdUAg+ude4T2LUETIxFINaRVXd3q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 05:04:24.4027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3d0d8a-f24f-469f-a256-08dd8936cea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844

Add support for KVM_CAP_X86_BUS_LOCK_EXIT on SVM CPUs with Bus Lock
Threshold, which is close enough to VMX's Bus Lock Detection VM-Exit to
allow reusing KVM_CAP_X86_BUS_LOCK_EXIT.

The biggest difference between the two features is that Threshold is
fault-like, whereas Detection is trap-like.  To allow the guest to make
forward progress, Threshold provides a per-VMCB counter which is
decremented every time a bus lock occurs, and a VM-Exit is triggered if
and only if the counter is '0'.

To provide Detection-like semantics, initialize the counter to '0', i.e.
exit on every bus lock, and when re-executing the guilty instruction, set
the counter to '1' to effectively step past the instruction.

Note, in the unlikely scenario that re-executing the instruction doesn't
trigger a bus lock, e.g. because the guest has changed memory types or
patched the guilty instruction, the bus lock counter will be left at '1',
i.e. the guest will be able to do a bus lock on a different instruction.
In a perfect world, KVM would ensure the counter is '0' if the guest has
made forward progress, e.g. if RIP has changed.  But trying to close that
hole would incur non-trivial complexity, for marginal benefit; the intent
of KVM_CAP_X86_BUS_LOCK_EXIT is to allow userspace rate-limit bus locks,
not to allow for precise detection of problematic guest code.  And, it's
simply not feasible to fully close the hole, e.g. if an interrupt arrives
before the original instruction can re-execute, the guest could step past
a different bus lock.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 Documentation/virt/kvm/api.rst |  5 +++++
 arch/x86/kvm/svm/nested.c      | 34 ++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c         | 38 ++++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h         |  1 +
 4 files changed, 78 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index ad1859f4699e..f7d2d477c3cf 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7989,6 +7989,11 @@ apply some other policy-based mitigation. When exiting to userspace, KVM sets
 KVM_RUN_X86_BUS_LOCK in vcpu-run->flags, and conditionally sets the exit_reason
 to KVM_EXIT_X86_BUS_LOCK.
 
+Due to differences in the underlying hardware implementation, the vCPU's RIP at
+the time of exit diverges between Intel and AMD.  On Intel hosts, RIP points at
+the next instruction, i.e. the exit is trap-like.  On AMD hosts, RIP points at
+the offending instruction, i.e. the exit is fault-like.
+
 Note! Detected bus locks may be coincident with other exits to userspace, i.e.
 KVM_RUN_X86_BUS_LOCK should be checked regardless of the primary exit reason if
 userspace wants to take action on all detected bus locks.
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 834b67672d50..5369d9517fbb 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -678,6 +678,33 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
 	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
 
+	/*
+	 * Stash vmcb02's counter if the guest hasn't moved past the guilty
+	 * instrution; otherwise, reset the counter to '0'.
+	 *
+	 * In order to detect if L2 has made forward progress or not, track the
+	 * RIP at which a bus lock has occurred on a per-vmcb12 basis.  If RIP
+	 * is changed, guest has clearly made forward progress, bus_lock_counter
+	 * still remained '1', so reset bus_lock_counter to '0'. Eg. In the
+	 * scenario, where a buslock happened in L1 before VMRUN, the bus lock
+	 * firmly happened on an instruction in the past. Even if vmcb01's
+	 * counter is still '1', (because the guilty instruction got patched),
+	 * the vCPU has clearly made forward progress and so KVM should reset
+	 * vmcb02's counter to '0'.
+	 *
+	 * If the RIP hasn't changed, stash the bus lock counter at nested VMRUN
+	 * to prevent the same guilty instruction from triggering a VM-Exit. Eg.
+	 * if userspace rate-limits the vCPU, then it's entirely possible that
+	 * L1's tick interrupt is pending by the time userspace re-runs the
+	 * vCPU.  If KVM unconditionally clears the counter on VMRUN, then when
+	 * L1 re-enters L2, the same instruction will trigger a VM-Exit and the
+	 * entire cycle start over.
+	 */
+	if (vmcb02->save.rip && (svm->nested.ctl.bus_lock_rip == vmcb02->save.rip))
+		vmcb02->control.bus_lock_counter = 1;
+	else
+		vmcb02->control.bus_lock_counter = 0;
+
 	/* Done at vmrun: asid.  */
 
 	/* Also overwritten later if necessary.  */
@@ -1039,6 +1066,13 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	}
 
+	/*
+	 * Invalidate bus_lock_rip unless KVM is still waiting for the guest
+	 * to make forward progress before re-enabling bus lock detection.
+	 */
+	if (!vmcb02->control.bus_lock_counter)
+		svm->nested.ctl.bus_lock_rip = INVALID_GPA;
+
 	nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
 
 	svm_switch_vmcb(svm, &svm->vmcb01);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index dca87d9e5850..a79eea2b421d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1384,6 +1384,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		svm->vmcb->control.int_ctl |= V_GIF_ENABLE_MASK;
 	}
 
+	if (vcpu->kvm->arch.bus_lock_detection_enabled)
+		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
+
 	if (sev_guest(vcpu->kvm))
 		sev_init_vmcb(svm);
 
@@ -3317,6 +3320,37 @@ static int invpcid_interception(struct kvm_vcpu *vcpu)
 	return kvm_handle_invpcid(vcpu, type, gva);
 }
 
+static inline int complete_userspace_buslock(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	/*
+	 * If userspace has NOT changed RIP, then KVM's ABI is to let the guest
+	 * execute the bus-locking instruction.  Set the bus lock counter to '1'
+	 * to effectively step past the bus lock.
+	 */
+	if (kvm_is_linear_rip(vcpu, vcpu->arch.cui_linear_rip))
+		svm->vmcb->control.bus_lock_counter = 1;
+
+	return 1;
+}
+
+static int bus_lock_exit(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
+	vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
+
+	vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
+	vcpu->arch.complete_userspace_io = complete_userspace_buslock;
+
+	if (is_guest_mode(vcpu))
+		svm->nested.ctl.bus_lock_rip = vcpu->arch.cui_linear_rip;
+
+	return 0;
+}
+
 static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_READ_CR0]			= cr_interception,
 	[SVM_EXIT_READ_CR3]			= cr_interception,
@@ -3386,6 +3420,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_INVPCID]                      = invpcid_interception,
 	[SVM_EXIT_IDLE_HLT]			= kvm_emulate_halt,
 	[SVM_EXIT_NPF]				= npf_interception,
+	[SVM_EXIT_BUS_LOCK]			= bus_lock_exit,
 	[SVM_EXIT_RSM]                          = rsm_interception,
 	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
 	[SVM_EXIT_AVIC_UNACCELERATED_ACCESS]	= avic_unaccelerated_access_interception,
@@ -5388,6 +5423,9 @@ static __init void svm_set_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
 
+	if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD))
+		kvm_caps.has_bus_lock_exit = true;
+
 	/* CPUID 0x80000008 */
 	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
 	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5ce34a1faf6a..a991a839bb6d 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -173,6 +173,7 @@ struct vmcb_ctrl_area_cached {
 	u64 nested_cr3;
 	u64 virt_ext;
 	u32 clean;
+	u64 bus_lock_rip;
 	union {
 #if IS_ENABLED(CONFIG_HYPERV) || IS_ENABLED(CONFIG_KVM_HYPERV)
 		struct hv_vmcb_enlightenments hv_enlightenments;
-- 
2.34.1


