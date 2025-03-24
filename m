Return-Path: <linux-kselftest+bounces-29640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF59A6DAC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 14:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D511893EF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5878425F7AB;
	Mon, 24 Mar 2025 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wxDsza8s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6F200CB;
	Mon, 24 Mar 2025 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821399; cv=fail; b=dIpRnfJ6pkMhpHN84TBi+Wm7grEOZjF3iEgkl547/S0QL6P3/2eqbFgdmxTZ5YDuRw52r2yRJEyKVwJbvwFqryR5kpkmNiogEzU6E6h9k9SY3EMUWGrvbnB76atYL7EzKUeJUAg7f9h0s8+xX+zZnQna0j20gXkR3I5cnB5wHB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821399; c=relaxed/simple;
	bh=jhQ4zr7Kfa09cG0Xb8NLSl4V9m28FxwT3T8YrPL6DT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWlOZVEYFRYfl15Z9h6jmsbJlIHLDWC2OwDO9upqqjju2p508l+0HkWCBKqd465yf1Lv0HK3oTTXIpvfGKAyRFKylDdai0cR5DKjqi6Y2FEEigbUr6NS8+jYs2/a0c1EbcDSmrreljQ1JjKu+qutFGnMUMlwCJF7iICpC0zyNrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wxDsza8s; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTE5b/8kok59jHxIjzXVtW6XQHWyVmc0mdYXCIx2bslgW5LZrQF2bGtDjj6nSCPu81McH8XeXZ6+TzSuqKVrMy2ikiSQgF25PGybZk+Jwy/9NXeHu7mKittXVIh9kF4CfvQ6LDFYa7mnMuasUuTWgPz6x/gSs6OZDg+upJzX/arrkM83WEg4GFEv1+38m0iMB+zKnp8vodO7NxcMMfmCoUfTDt3pmAkwamo7DUnYcahPnMlW3jkQauLXv0odHJ8S7y8PDkLbZ31CHbUR7gLZSWuIspeuQF/pDZLdn/ApaQew9CPdImYIQVgiCIQBcvSa7Pc3u0H9HHq05mdr8rxo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yZ9hrH+xnegprnalvkzSPS7ctBOJM3J5fbifm42+fw=;
 b=Ljf3mWFAFg0BbRn5VzmFgjSMAaL6Kt9N/k6S4lbGV7TGvJ8td0KCbwGLzyCObtcUG6WCVkWh3NvYjpX1eF2huwdiJA+ZcdQLhUnTEQpkdsGaQ1w0G82v3n6W8CVruWpD5HA/5yDqlwzwFsvTBzqizq2QOW2Yx7FL8ayCpcgXSCJmrHmmKQLYQPyuqaOe070CuGgpUb2KbExD7IbApccus2ZB1mNNL/L58vlQx+2svj1aJPmOUGuh8jaKWMKD4oa0VUwuqozLxjTTk1mUN39/lfZI4it/9789kwdEgQWCm9qP8EQAd6ppz2uTU+5hvtK6Wr+OvYfcH6sRBl/2BOJVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yZ9hrH+xnegprnalvkzSPS7ctBOJM3J5fbifm42+fw=;
 b=wxDsza8sFBT+H5o00C/MlzPJSyeQH9ulYmvwyVN2xrQmZkex0qt/rLzSsd86qE1rn8z7vQNOnRP/fbBgEuWxQg59mpeOGzahtKJRxh0ZQZX2yTos6ZbzMrx2yJX8Ee+kRILu73iCXqhA0eRvGbprOZaQLqhooCMdynsBq8Mlnfc=
Received: from BYAPR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:74::24)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 13:03:14 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::35) by BYAPR05CA0047.outlook.office365.com
 (2603:10b6:a03:74::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 13:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 13:03:14 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 08:03:11 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <nikunj@amd.com>,
	<thomas.lendacky@amd.com>, <manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v4 4/5] KVM: SVM: Add support for KVM_CAP_X86_BUS_LOCK_EXIT on SVM CPUs
Date: Mon, 24 Mar 2025 13:02:47 +0000
Message-ID: <20250324130248.126036-5-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324130248.126036-1-manali.shukla@amd.com>
References: <20250324130248.126036-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e0113a-ba0a-4475-4dc8-08dd6ad43cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t9zpzz/fhn3YCyZQSSosa9+d+slC0FQuz3PHwVsXRN0SwUmItGSnODGVohCf?=
 =?us-ascii?Q?xo/k9f3NZwUul7OIwlwM/bk+K4w1Er/vNoZIBPbHivDZgkavBXQ5+YoXJnuV?=
 =?us-ascii?Q?HL3/9+JILHeKZHCfrcGcs0SEN8PvzxArdUL0ooQ0a9PN/0RJBRjOvpCxtvOk?=
 =?us-ascii?Q?qbeburawn5AwzSneOcmZZgEi94nLxDW3pSZeNcVt4Qu3GTnuuEx8CaKhota2?=
 =?us-ascii?Q?Zg0ko34XVdEDerBGSoUM3CGHl1/eJlqxSvMcS87EpjgbDDWSEwiALbCr89jh?=
 =?us-ascii?Q?kPAnSp7x6nAHm3SB+EqTukfX8L6zc2pid63ZD7TyeHufYANiJTPBQF+IoqWP?=
 =?us-ascii?Q?bdjhTln+jpNxkL7MCqr11y7yvJBk/lBQvf28MM1kmmLiXienXOjBuN5btTQR?=
 =?us-ascii?Q?VNoJmsfQ/TIotXCgw8hDR+jQQhkDppYpoHPbye1SiCzJIW7vhk/UlZ6hKm9n?=
 =?us-ascii?Q?tZy6SXi2H6yNzgIUSIwOwiymX/40w8E/rU4mrbzjJX4Pwz5f9ox+N1+8JuYg?=
 =?us-ascii?Q?1/TdpnNr7Z5zPWUyay1hKlfrD5NZ+ppxuc1f8a1Wzg69n8vMUfZPM516g+qU?=
 =?us-ascii?Q?7SGmx7/qxk2xdJ4GwL7pfS0g47Ei70sw1KDg190OKZruGcqCvxqUfpHUysQW?=
 =?us-ascii?Q?n/+GqOrmNbDPTM9ixvMuL/A2NTcudhsPmwesBmC7BLlmNvlEqyheHk/cOS20?=
 =?us-ascii?Q?/lYa+BgCL1zYZejnjutcooKuPEFZ2ezvNKXQNmB8ioNYSs24ZkasaxrvOQla?=
 =?us-ascii?Q?2yroAGVWCLvNh5wiXr3tikXaXUM+c2/mhMqQbPtPsV5t2l0Z3CzBOl0hqalp?=
 =?us-ascii?Q?Pjp+nOFt6/El33oK3Ah7XwHsxCvWOIvZOaQdBfLTUKPenpQa7FyBo22p3KB2?=
 =?us-ascii?Q?65XZyRTWII5R0eH0VCe4r4aJuxwRrmSYQJ+rv6wzlgAMxSJf3bzofHPFKqtC?=
 =?us-ascii?Q?a0brxCxFSxzOwOyVxfxc29hlC1cUANviYoSgqC3xYYoM5aOdd9SauuJ0Wlus?=
 =?us-ascii?Q?2/XooPtVpjJUuAYYl40NXRNW3MlpcttNcffW+mEjkL7oW09OxYqX3ZRcyxFe?=
 =?us-ascii?Q?n59DB/f+LIwae0nc1fas5hx4RQHcjJ/YJYHzUTIoA6TGQQ6jVCm+d4xFMqsg?=
 =?us-ascii?Q?8cenqU7I+zleV2oDbG707U9VYkxJyExvOUM5ogivsUuoRxKzJHHQvjTyTyQ1?=
 =?us-ascii?Q?aGXN/tNzItjSF5fG/DDgEYgjimq06XX4ozFYQmZ5dC6J6rs6lyBWFJeWMugH?=
 =?us-ascii?Q?guyPmTZiUmSjft7O+eH0nkmCd3YZA3QP7KaP4cTDXmzWxOJjZIQFjQGtsHKM?=
 =?us-ascii?Q?0886yrBO6nhUnz6lsdcjS6i1uk1UNDxpiUMXh7cGdxOXKSojZwYODpzII32v?=
 =?us-ascii?Q?nhl74Uc63QLmwsLYJ02ud0Pb3Azva++1LADbN00ySRmsnZIgmD9Ihfww9Di9?=
 =?us-ascii?Q?fpnb0vMzb0ggFVB9dYlXpPpS1lBQLxN96PKO4ppP1tOSog4IqnCIOQDiC/p0?=
 =?us-ascii?Q?77UB9Rcax3hb2Wk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 13:03:14.0034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e0113a-ba0a-4475-4dc8-08dd6ad43cbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760

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
 Documentation/virt/kvm/api.rst | 19 +++++++++++++++
 arch/x86/kvm/svm/nested.c      | 42 ++++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c         | 30 ++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h         |  2 ++
 4 files changed, 93 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 5fe84f2427b5..f7c925aa0c4f 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7909,6 +7909,25 @@ apply some other policy-based mitigation. When exiting to userspace, KVM sets
 KVM_RUN_X86_BUS_LOCK in vcpu-run->flags, and conditionally sets the exit_reason
 to KVM_EXIT_X86_BUS_LOCK.
 
+Note! KVM_CAP_X86_BUS_LOCK_EXIT on AMD CPUs with the Bus Lock Threshold is close
+enough  to INTEL's Bus Lock Detection VM-Exit to allow using
+KVM_CAP_X86_BUS_LOCK_EXIT for AMD CPUs.
+
+The biggest difference between the two features is that Threshold (AMD CPUs) is
+fault-like i.e. the bus lock exit to user space occurs with RIP pointing at the
+offending instruction, whereas Detection (Intel CPUs) is trap-like i.e. the bus
+lock exit to user space occurs with RIP pointing at the instruction right after
+the guilty one.
+
+The bus lock threshold on AMD CPUs provides a per-VMCB counter which is
+decremented every time a bus lock occurs, and a VM-Exit is triggered if and only
+if the bus lock counter is '0'.
+
+To provide Detection-like semantics for AMD CPUs, the bus lock counter has been
+initialized to '0', i.e. exit on every bus lock, and when re-executing the
+guilty instruction, the bus lock counter has been set to '1' to effectively step
+past the instruction.
+
 Note! Detected bus locks may be coincident with other exits to userspace, i.e.
 KVM_RUN_X86_BUS_LOCK should be checked regardless of the primary exit reason if
 userspace wants to take action on all detected bus locks.
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 834b67672d50..a42ef7dd9143 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -678,6 +678,36 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
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
+	if (vmcb02->save.rip && (svm->nested.ctl.bus_lock_rip == vmcb02->save.rip)) {
+		vmcb02->control.bus_lock_counter = 1;
+		svm->bus_lock_rip = svm->nested.ctl.bus_lock_rip;
+	} else {
+		vmcb02->control.bus_lock_counter = 0;
+	}
+	svm->nested.ctl.bus_lock_rip = INVALID_GPA;
+
 	/* Done at vmrun: asid.  */
 
 	/* Also overwritten later if necessary.  */
@@ -1039,6 +1069,18 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	}
 
+	/*
+	 * If bus_lock_counter is nonzero and the guest has not moved past the
+	 * guilty instruction, save bus_lock_rip in svm_nested_state. This will
+	 * help determine at nested VMRUN whether to stash vmcb02's counter or
+	 * reset it to '0'.
+	 */
+	if (vmcb02->control.bus_lock_counter &&
+	    svm->bus_lock_rip == vmcb02->save.rip)
+		svm->nested.ctl.bus_lock_rip = svm->bus_lock_rip;
+	else
+		svm->nested.ctl.bus_lock_rip = INVALID_GPA;
+
 	nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
 
 	svm_switch_vmcb(svm, &svm->vmcb01);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 244e099e7262..ea12e93ae983 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3310,6 +3310,35 @@ static int invpcid_interception(struct kvm_vcpu *vcpu)
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
+	svm->bus_lock_rip = vcpu->arch.cui_linear_rip;
+	vcpu->arch.complete_userspace_io = complete_userspace_buslock;
+
+	return 0;
+}
+
 static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_READ_CR0]			= cr_interception,
 	[SVM_EXIT_READ_CR3]			= cr_interception,
@@ -3379,6 +3408,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_INVPCID]                      = invpcid_interception,
 	[SVM_EXIT_IDLE_HLT]			= kvm_emulate_halt,
 	[SVM_EXIT_NPF]				= npf_interception,
+	[SVM_EXIT_BUS_LOCK]                     = bus_lock_exit,
 	[SVM_EXIT_RSM]                          = rsm_interception,
 	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
 	[SVM_EXIT_AVIC_UNACCELERATED_ACCESS]	= avic_unaccelerated_access_interception,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index d4490eaed55d..7a4c5848c952 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -169,6 +169,7 @@ struct vmcb_ctrl_area_cached {
 	u64 nested_cr3;
 	u64 virt_ext;
 	u32 clean;
+	u64 bus_lock_rip;
 	union {
 #if IS_ENABLED(CONFIG_HYPERV) || IS_ENABLED(CONFIG_KVM_HYPERV)
 		struct hv_vmcb_enlightenments hv_enlightenments;
@@ -327,6 +328,7 @@ struct vcpu_svm {
 
 	/* Guest GIF value, used when vGIF is not enabled */
 	bool guest_gif;
+	u64 bus_lock_rip;
 };
 
 struct svm_cpu_data {
-- 
2.34.1


