Return-Path: <linux-kselftest+bounces-42123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3980B9462A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B3D16F962
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC33101D2;
	Tue, 23 Sep 2025 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mXTFeAkm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575827511F;
	Tue, 23 Sep 2025 05:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604771; cv=fail; b=hFO8q5smlP3EyF377+lJF7WvMcRgHu5nS9yziJfyzW9HPsbF0k+0c5D78Tl3D7nyCMTdRmZJ4zNQBpx0gl6yKCW2YYjqvdLO0SQ8xyJe7vVheTG96gIdFjNZiHJWPjoksVv6F6tXgh8ikxGCp2lSjR/f+jU1TT5zAAPY5cFuAJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604771; c=relaxed/simple;
	bh=6zya8ZUZSI1/Jpx7Pa58+vLZF/h/A2FNoUkbxQC3gCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEB1j4izVSs9AD2yNz01rJdLkc9UcZwqqRNW9ouY7GRGTglY+r64jxptjs54TBQmEundfDBVbsqxTWN3DxqMMcPIo5o4IL33N7KfRyhpYMe/L8wWgv9NeE4sQ8KjDl82a/jz47bKErVCAGZAqAWHtykB0CnzRtN+JMJRvPVe89A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mXTFeAkm; arc=fail smtp.client-ip=52.101.46.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfTqupZFyTnmTjzAfZUsw41Bw7/W65JxbB9BWabFbFwFWLOKwJPOH5XNoAkvV6ZjkWq7PxjEV7JI27oBzG6yWjgq460Y3KFyIk5DK3atrSUjpMBVwCRPLTWOlPWo2Ay4hpFs12s+09yj2q6gg++XgtZognyE0XWaIZBvH9VRt7acRupjYvOAkLzp6xBb4gIaC3O+2OoDn8YQi/zZTg+ogEZUzJOoa5UQ6qfrafI4zKXR5FCbMBCdIu3BfqXAVqcdc92o2NNN1cyMbHTQXpCWZ0g0e+ueT3LZUabp51zhkCX0AS7c3tPqmQrSph2KCje1yjO//Gt/UWFww0UEr8q/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9g2kC7GJafYz6p6d3zmWi9XVAF4GUMDGn3HWgiuvOQ=;
 b=a8ZCI1ZVR9dnozapH31Ut6ASRWEzxrF8j0ucXFGFr94Xx+8qMNGYVJFqP4RBRI9FHvzLMD21o6AxJbacrFvOoBRVTqNu50TB8YSNUeFOj81ywPWbWiHC5PbaLDPinWxCBDsUQgMQckytk00eYso6MWIYTd59s4lqGlPIskyNJeDvZzCa8A0Ic2DILwWhnyywuQuE+rZHTOlxUa8yqyUie/ZFEkeZbtPkD7OEKVNs3g9mgS1eXl+GKQUlH97ey7WKOcIC4qO1XLMeDjGVH6EHFVMNVpiL0Rmdnt1nbqIBkNI6kya9QjC9m0mwgpEa1leESPVb0OB2Oh+UiAm+6sRxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9g2kC7GJafYz6p6d3zmWi9XVAF4GUMDGn3HWgiuvOQ=;
 b=mXTFeAkm9AI07FgRyewePylItJLaT8ht9fU9gw3lollmpBXdEi9hJav6hN658GwBDYL7i4mHZx+C3cjAXlzO+wwNVniFtHmf69d7YuCFWzFiOZTE3De0Ibmq9bHYTWSVm4sbtDuEFg9CASW5KrPySBVCXvbDMTZQW7cxYSI8qU4=
Received: from SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:19:24 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::54) by SJ0PR03CA0356.outlook.office365.com
 (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:19:23 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:19:18 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 32/35] KVM: selftests: Add IOAPIC tests for Secure AVIC
Date: Tue, 23 Sep 2025 10:39:39 +0530
Message-ID: <20250923050942.206116-33-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
References: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 48bab5a2-91f8-4305-15e8-08ddfa60c22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZDpuFzJmYDQNoj63y/f8/7Gy/lwvSM6EzIDKhjJMaZfWknO7qkCAlRrG09/V?=
 =?us-ascii?Q?e7Tj5HuWwzcBux1Feset0WRWJBoe9xFOlPk3d4okJyUWN5YixmKWo1oIwGjE?=
 =?us-ascii?Q?SKsrx25tn8hN2YiNYHOywyhBvh16b3gg8QEzNqhfpZNQAwdPUR9LQ1VYTmZc?=
 =?us-ascii?Q?EDmNALOCTmRPB8C1o89DbEFUrXQyB7jZf/zbxgoJ71xctMG9iF9DTHMTeirr?=
 =?us-ascii?Q?w9l2BoYOYi6EZKqPvWqHjZ705ZEtEI9hLSWKD349tWkOKqfHuxlnKa0uc6Fz?=
 =?us-ascii?Q?NbUFkPnWwjkqd/Lso65zBVQcLPG4j12jSb1yu6+74NqbXa+LBkXyfCreWljY?=
 =?us-ascii?Q?qSRwjZHWE2EDjMPq+FvoZCFWcY1f7JDsr+ukfa7kq6CXlbEi4TQACzDoQq0u?=
 =?us-ascii?Q?Y+Ri7jCRah9FsETs0rNBtuZRCHylJUo6MtgcUywl0Qqx/FbyCsD0nWjKljrr?=
 =?us-ascii?Q?GCFYE1kZADFO9b7PfKBwWy1d2qamZWlV1Sg9UT0l2LB1URiBAtQ7Q1AXbgvL?=
 =?us-ascii?Q?3mmxyzPVoKAxaBc9b9NfgMLBoUQWAJ8pJ+qmkYeTYk8cuPLncZnZoBzC2fhe?=
 =?us-ascii?Q?f9WiqpUIJxS5tOWMtUKGv6lpizDMoIzfIyETWMoloDkQ/SOq9nlO4iflkknB?=
 =?us-ascii?Q?NvJXon+hMfwW64zuOMkWUDB1/wnQauxyP1nSOTKvXqnyPG4ghZ5xqmsKYiJe?=
 =?us-ascii?Q?N8DVWMk2WHFzZNG/lCoUbKQwbZdQmGhMNfl+QvQ+xZ+sGYFTXL55mowphUzA?=
 =?us-ascii?Q?7xiRNLh264EHMoHEmz5EULxBUHGzwrzdImOzC5FyQu1LYG8sq0bp4vcV6uva?=
 =?us-ascii?Q?utTe+Cu02QtgT1r32LMtimYeHCNVA2MnQKjg2Ffx67HvJ7JtEsgu6KkcWXkW?=
 =?us-ascii?Q?xQdXNv0rAqL8GJUvs4BqvGQWS5QMhm5MVtWlv6crcr8kohQO0UMxfxBf/cBf?=
 =?us-ascii?Q?P6s/50fuYxmtkdXF56S4Mx8EVtgMclHmScPHYHHuWd0kdbrmhmMw/slab/wA?=
 =?us-ascii?Q?cvd9BzLUIuoQGoLTjoDkf+aAO958dBb9uy0Of7qxOGjiI54ixS/JOsxuoLWK?=
 =?us-ascii?Q?wd/dxdj+9rnhyA1Flq1OAt9TYS9Akm5N/8Gzlng7yypYyDFtHwwQ62xz9s7G?=
 =?us-ascii?Q?IBee90FOtiggExFsIdRUO+qWhpPzsJ7Sp75OTFRs5S6Uo2mpEcSnSC0jUDLJ?=
 =?us-ascii?Q?Kag9jPtZuyNT0xIQBVBhXErTEOPwriHJKPShTKIgKCSFGDmbdnxA2nbWxGjf?=
 =?us-ascii?Q?ESIMKHAEFUfs2KAxcq+QMN9G0+AuPWV1CtX8trStw2Lx9BaTMas2qR0bXyQN?=
 =?us-ascii?Q?xD/ktWCHLvoOSdpcr00ZQ/zJeuiTUy8cO4CAA8Iv0qkwq1d93EHJkRGZ4ap6?=
 =?us-ascii?Q?6tVFubet5qDyTdsRN54Mq01YdVixVCfVYpzVK0JjUPEX/p7J3d4Tg2OUZsf/?=
 =?us-ascii?Q?TI2dUvVvNZUohv1jKv/nfgtnCRwvX69tPxXU+QbiF8rzRI1atatm00RPoU3B?=
 =?us-ascii?Q?Ro7tppxakx3GOlP7aaTVLZjOrn+rjihEFcVo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:19:23.6530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bab5a2-91f8-4305-15e8-08ddfa60c22b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136

Extend the Secure AVIC (SAVIC) selftest to validate the delivery of
external interrupts via the IOAPIC. This is a critical validation step,
as the interrupt injection path for SAVIC guests is different from
traditional APIC modes and requires explicit guest cooperation.

In SAVIC mode, for the hardware to inject an external interrupt, the
guest must first grant permission for the corresponding vector. This
is done by setting a bit in a designated "allowed IRR" region within
its private APIC backing page. If the vector is not allowed, the
interrupt is dropped by the hardware.

Add a new test case to savic_test.c and verify this entire flow of IOAPIC
interrupt injection for both edge and level-triggered interrupts. Also
test the special-cased RTC GSI (IRQ 8).

To support this, add new helpers for reading/writing the IOAPIC MMIO
region and updating the IOAPIC redirection table.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 .../testing/selftests/kvm/include/x86/apic.h  |  49 ++++
 .../testing/selftests/kvm/include/x86/savic.h |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  17 ++
 .../testing/selftests/kvm/lib/x86/processor.c |   2 +-
 tools/testing/selftests/kvm/lib/x86/savic.c   |  11 +
 tools/testing/selftests/kvm/x86/savic_test.c  | 253 +++++++++++++++++-
 7 files changed, 330 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index e5f322994f44..513e68f88179 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -952,6 +952,7 @@ void *vcpu_map_dirty_ring(struct kvm_vcpu *vcpu);
 void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...);
 
 void kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level);
+void kvm_irq_line_status(struct kvm_vm *vm, uint32_t irq, int level);
 int _kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level);
 
 #define KVM_MAX_IRQ_ROUTES		4096
diff --git a/tools/testing/selftests/kvm/include/x86/apic.h b/tools/testing/selftests/kvm/include/x86/apic.h
index af555638086f..765c463dff33 100644
--- a/tools/testing/selftests/kvm/include/x86/apic.h
+++ b/tools/testing/selftests/kvm/include/x86/apic.h
@@ -12,6 +12,7 @@
 #include "ucall_common.h"
 
 #define APIC_DEFAULT_GPA		0xfee00000ULL
+#define IOAPIC_DEFAULT_GPA		0xfec00000ULL
 
 /* APIC base address MSR and fields */
 #define MSR_IA32_APICBASE		0x0000001b
@@ -122,5 +123,53 @@ static inline void x2apic_write_reg_fault(unsigned int reg, uint64_t value)
 		       APIC_BASE_MSR + (reg >> 4), value, fault);
 }
 
+struct ioapic_redirect_entry {
+	uint8_t vector;
+	uint8_t delivery_mode:3;
+	uint8_t dest_mode:1;
+	uint8_t delivery_status:1;
+	uint8_t polarity:1;
+	uint8_t remote_irr:1;
+	uint8_t trig_mode:1;
+	uint8_t mask:1;
+	uint8_t reserve:7;
+	uint8_t reserved[4];
+	uint8_t dest_id;
+};
+
+enum trigger_mode {
+	TRIGGER_EDGE = 0,
+	TRIGGER_LEVEL,
+	TRIGGER_MAX,
+};
+
+static void *ioapic_addr = (void *)IOAPIC_DEFAULT_GPA;
+
+static inline void ioapic_write_reg(uint32_t reg, uint32_t val)
+{
+	*(volatile uint32_t *)ioapic_addr = reg;
+	*(volatile u32 *)(ioapic_addr + 0x10) = val;
+}
+
+static inline void ioapic_write_redir(unsigned int line, struct ioapic_redirect_entry e)
+{
+	ioapic_write_reg(0x10 + line * 2 + 0, ((uint32_t *)&e)[0]);
+	ioapic_write_reg(0x10 + line * 2 + 1, ((uint32_t *)&e)[1]);
+}
+
+static inline uint32_t ioapic_read_reg(unsigned int reg)
+{
+	*(volatile uint32_t *)ioapic_addr = reg;
+	return *(volatile uint32_t *)(ioapic_addr + 0x10);
+}
+
+static inline struct ioapic_redirect_entry ioapic_read_redir(unsigned int line)
+{
+	struct ioapic_redirect_entry e;
+
+	((u32 *)&e)[0] = ioapic_read_reg(0x10 + line * 2 + 0);
+	((u32 *)&e)[1] = ioapic_read_reg(0x10 + line * 2 + 1);
 
+	return e;
+}
 #endif /* SELFTEST_KVM_APIC_H */
diff --git a/tools/testing/selftests/kvm/include/x86/savic.h b/tools/testing/selftests/kvm/include/x86/savic.h
index 33f19f5e39b3..73965edfef5c 100644
--- a/tools/testing/selftests/kvm/include/x86/savic.h
+++ b/tools/testing/selftests/kvm/include/x86/savic.h
@@ -21,4 +21,5 @@ void savic_enable(void);
 int savic_nr_pages_required(uint64_t page_size);
 void savic_vc_handler(struct ex_regs *regs);
 struct guest_apic_page *get_guest_apic_page(void);
+void savic_allow_vector(int vec);
 #endif
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 23272f797f5f..e830425d5d60 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1964,6 +1964,23 @@ void kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level)
 	TEST_ASSERT(ret >= 0, KVM_IOCTL_ERROR(KVM_IRQ_LINE, ret));
 }
 
+int _kvm_irq_line_status(struct kvm_vm *vm, uint32_t irq, int level)
+{
+	struct kvm_irq_level irq_level = {
+		.irq    = irq,
+		.level  = level,
+	};
+
+	return __vm_ioctl(vm, KVM_IRQ_LINE_STATUS, &irq_level);
+}
+
+void kvm_irq_line_status(struct kvm_vm *vm, uint32_t irq, int level)
+{
+	int ret = _kvm_irq_line_status(vm, irq, level);
+
+	TEST_ASSERT(ret >= 0, KVM_IOCTL_ERROR(KVM_IRQ_LINE_STATUS, ret));
+}
+
 struct kvm_irq_routing *kvm_gsi_routing_create(void)
 {
 	struct kvm_irq_routing *routing;
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index fc57b948c041..af2604483e60 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -229,7 +229,7 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
 		    "PTE already present for 4k page at vaddr: 0x%lx", vaddr);
 	*pte = PTE_PRESENT_MASK | PTE_WRITABLE_MASK | (paddr & PHYSICAL_PAGE_MASK);
 
-	if (paddr == APIC_DEFAULT_GPA) {
+	if (paddr == APIC_DEFAULT_GPA || paddr == IOAPIC_DEFAULT_GPA) {
 		*pte |= vm->arch.s_bit;
 		return;
 	}
diff --git a/tools/testing/selftests/kvm/lib/x86/savic.c b/tools/testing/selftests/kvm/lib/x86/savic.c
index da01bb5deae1..c941fd3f22df 100644
--- a/tools/testing/selftests/kvm/lib/x86/savic.c
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -45,6 +45,7 @@ enum lapic_lvt_entry {
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS      0x402
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI            0x401
 
+#define SAVIC_ALLOWED_IRR               (APIC_IRR + 0x4)
 #define SAVIC_NMI_REQ_OFFSET            0x278
 
 /*
@@ -107,6 +108,16 @@ struct guest_apic_page *get_guest_apic_page(void)
 	return &apic_page_pool->guest_apic_page[x2apic_read_reg(APIC_ID)];
 }
 
+void savic_allow_vector(int vec)
+{
+	struct guest_apic_page *apage = get_guest_apic_page();
+
+	savic_write_reg(apage, SAVIC_ALLOWED_IRR + APIC_REG_OFF(vec),
+			savic_read_reg(apage, SAVIC_ALLOWED_IRR + APIC_REG_OFF(vec)) |
+			BIT_ULL(APIC_VEC_POS(vec)));
+
+}
+
 /*
  * Write APIC reg offset in the guest APIC backing page.
  *
diff --git a/tools/testing/selftests/kvm/x86/savic_test.c b/tools/testing/selftests/kvm/x86/savic_test.c
index 9108ac0077a9..aa8a7244aa55 100644
--- a/tools/testing/selftests/kvm/x86/savic_test.c
+++ b/tools/testing/selftests/kvm/x86/savic_test.c
@@ -14,9 +14,15 @@
 #include "savic.h"
 
 #define NR_SAVIC_VCPUS	1
-#define IDLE_HLT_INTR_VECTOR     0x30
 #define NUM_ITERATIONS 2000
 
+#define IDLE_HLT_INTR_VECTOR     0x30
+#define IOAPIC_VECTOR_START      0x81
+#define IOAPIC_NUM_EDGE_VECTORS 2
+#define IOAPIC_NUM_LEVEL_VECTORS 2
+#define RTC_GSI	8
+#define RTC_GSI_IRQ 0x85
+
 static bool irq_received;
 static struct kvm_vcpu *vcpus[NR_SAVIC_VCPUS];
 static pthread_t threads[NR_SAVIC_VCPUS];
@@ -28,8 +34,21 @@ static pthread_t threads[NR_SAVIC_VCPUS];
 enum savic_test_state {
 	SAVIC_TEST_STATE(SAVIC_APIC_MSR_ACCESSES),
 	SAVIC_TEST_STATE(SAVIC_IDLE_HALT),
+	SAVIC_TEST_STATE(SAVIC_IOAPIC),
+	SAVIC_TEST_STATE(SAVIC_IOAPIC2),
+};
+
+/* Data struct shared between host main thread and vCPUs */
+struct test_data_page {
+	uint64_t ioapic_eirq1_count;
+	uint64_t ioapic_eirq2_count;
+	uint64_t ioapic_lirq1_count;
+	uint64_t ioapic_lirq2_count;
+	uint64_t ioapic_rtc_gsi_irq_count;
 };
 
+static struct test_data_page *test_data[NR_SAVIC_VCPUS];
+
 #define SAVIC_GUEST_SYNC(sync, func) ({\
 	GUEST_SYNC(sync ## _START); \
 	func(id); \
@@ -262,6 +281,177 @@ static void guest_savic_idle_halt(int id)
 	}
 }
 
+static void _ioapic_level_irq_handler(int vec)
+{
+	uint32_t isr, tmr;
+	int offset, pos;
+
+	offset = APIC_REG_OFF(vec);
+	pos = APIC_VEC_POS(vec);
+	isr = savic_hv_read_reg(APIC_ISR + offset);
+	tmr = savic_hv_read_reg(APIC_TMR + offset);
+
+	__GUEST_ASSERT(tmr & BIT_ULL(pos),
+		"IOAPIC level vector %d trigger mode in not set in host TMR: %x",
+		vec, tmr);
+	__GUEST_ASSERT(isr & BIT_ULL(pos),
+			"IOAPIC level vector %d in not set in host ISR: %x",
+			vec, isr);
+
+	x2apic_write_reg(APIC_EOI, 0x00);
+	savic_hv_write_reg(APIC_EOI, 0);
+
+	isr = savic_hv_read_reg(APIC_ISR + offset);
+	__GUEST_ASSERT(!(isr & BIT_ULL(pos)),
+		"IOAPIC level vector %d set in host ISR after EOI",
+		vec);
+}
+
+static void ioapic_level_irq1_intr_handler(struct ex_regs *regs)
+{
+	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	int vec;
+
+	vec = IOAPIC_VECTOR_START + IOAPIC_NUM_EDGE_VECTORS;
+	WRITE_ONCE(data->ioapic_lirq1_count, data->ioapic_lirq1_count + 1);
+	_ioapic_level_irq_handler(vec);
+}
+
+static void ioapic_level_irq2_intr_handler(struct ex_regs *regs)
+{
+	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	int vec;
+
+	vec = IOAPIC_VECTOR_START + IOAPIC_NUM_EDGE_VECTORS + 1;
+	WRITE_ONCE(data->ioapic_lirq2_count, data->ioapic_lirq2_count + 1);
+	_ioapic_level_irq_handler(vec);
+}
+
+static void ioapic_edge_irq1_intr_handler(struct ex_regs *regs)
+{
+	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+
+	WRITE_ONCE(data->ioapic_eirq1_count, data->ioapic_eirq1_count + 1);
+	x2apic_write_reg(APIC_EOI, 0x00);
+}
+
+static void ioapic_edge_irq2_intr_handler(struct ex_regs *regs)
+{
+	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+
+	WRITE_ONCE(data->ioapic_eirq2_count, data->ioapic_eirq2_count + 1);
+	x2apic_write_reg(APIC_EOI, 0x00);
+}
+
+static void ioapic_rtc_gsi_intr_handler(struct ex_regs *regs)
+{
+	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+
+	WRITE_ONCE(data->ioapic_rtc_gsi_irq_count, data->ioapic_rtc_gsi_irq_count + 1);
+	x2apic_write_reg(APIC_EOI, 0x00);
+}
+
+static void __savic_ioapic(int count)
+{
+	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+	int vec = IOAPIC_VECTOR_START;
+
+	__GUEST_ASSERT(READ_ONCE(data->ioapic_eirq1_count) == count,
+			"Invalid ioapic edge irq %d count: %ld, expected: %d",
+			vec, READ_ONCE(data->ioapic_eirq1_count), count);
+	__GUEST_ASSERT(READ_ONCE(data->ioapic_eirq2_count) == count,
+			"Invalid ioapic edge irq %d count: %ld, expected: %d",
+			vec + 1, READ_ONCE(data->ioapic_eirq2_count), count);
+	__GUEST_ASSERT(READ_ONCE(data->ioapic_lirq1_count) == count,
+			"Invalid ioapic level irq %d count: %ld, expected: %d",
+			vec + 2, READ_ONCE(data->ioapic_lirq1_count), count);
+	__GUEST_ASSERT(READ_ONCE(data->ioapic_lirq2_count) == count,
+			"Invalid ioapic level irq %d count: %ld, expected: %d",
+			vec + 3, READ_ONCE(data->ioapic_lirq2_count), count);
+	__GUEST_ASSERT(READ_ONCE(data->ioapic_rtc_gsi_irq_count) == count,
+			"Invalid ioapic RTC irq %d count: %ld, expected: %d",
+			RTC_GSI_IRQ, READ_ONCE(data->ioapic_rtc_gsi_irq_count),
+			count);
+}
+
+static void savic_ioapic(int id)
+{
+	__savic_ioapic(1);
+}
+
+static void savic_ioapic2(int id)
+{
+	__savic_ioapic(2);
+}
+
+static void ioapic_set_redir(unsigned int line, unsigned int vec,
+			     enum trigger_mode trig_mode)
+{
+	struct ioapic_redirect_entry e = {
+		.vector = vec,
+		.delivery_mode = 0,
+		.dest_mode = 0,
+		.trig_mode = trig_mode,
+		.mask = 0,
+		.dest_id = 0,
+		.delivery_status = 0,
+		.remote_irr = 0,
+	};
+
+	ioapic_write_redir(line, e);
+}
+
+static void guest_setup_ioapic(int id)
+{
+	int vec = IOAPIC_VECTOR_START;
+	struct ioapic_redirect_entry e;
+	int i, line = 0;
+
+	for (i = 0; i < IOAPIC_NUM_EDGE_VECTORS; i++) {
+		ioapic_set_redir(line, vec, TRIGGER_EDGE);
+		e = ioapic_read_redir(line);
+		__GUEST_ASSERT(
+			e.vector == vec && e.trig_mode == TRIGGER_EDGE &&
+			e.dest_id == 0,
+			"Invalid IOAPIC redir entry for line : %d, trig_mode: %d vector: %d",
+			line, e.trig_mode, e.vector);
+		vec++;
+		line++;
+	}
+
+	for (i = 0; i < IOAPIC_NUM_LEVEL_VECTORS; i++) {
+		ioapic_set_redir(line, vec, TRIGGER_LEVEL);
+		e = ioapic_read_redir(line);
+		__GUEST_ASSERT(
+			e.vector == vec && e.trig_mode == TRIGGER_LEVEL &&
+			e.dest_id == 0,
+			"Invalid IOAPIC redir entry for line : %d, trig_mode: %d vector: %d",
+			line, e.trig_mode, e.vector);
+		line++;
+		vec++;
+	}
+
+	vec = RTC_GSI_IRQ;
+	line = RTC_GSI;
+	ioapic_set_redir(line, vec, TRIGGER_EDGE);
+	e = ioapic_read_redir(line);
+	__GUEST_ASSERT(
+		e.vector == vec && e.trig_mode == TRIGGER_EDGE &&
+		e.dest_id == 0,
+		"Invalid IOAPIC redir entry for line : %d, trig_mode: %d vector: %d",
+		line, e.trig_mode, e.vector);
+
+	x2apic_write_reg(APIC_TASKPRI, 0);
+
+	for (i = 0; i < (IOAPIC_NUM_EDGE_VECTORS + IOAPIC_NUM_LEVEL_VECTORS); i++) {
+		vec = IOAPIC_VECTOR_START + i;
+		savic_allow_vector(vec);
+	}
+
+	vec = RTC_GSI_IRQ;
+	savic_allow_vector(vec);
+}
+
 static void guest_code(int id)
 {
 	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SNP_SECURE_AVIC);
@@ -274,9 +464,41 @@ static void guest_code(int id)
 
 	SAVIC_GUEST_SYNC(SAVIC_IDLE_HALT, guest_savic_idle_halt);
 
+	guest_setup_ioapic(id);
+	SAVIC_GUEST_SYNC(SAVIC_IOAPIC, savic_ioapic);
+	SAVIC_GUEST_SYNC(SAVIC_IOAPIC2, savic_ioapic2);
+
 	GUEST_DONE();
 }
 
+static void host_send_ioapic_irq(struct kvm_vm *vm, int id)
+{
+	kvm_irq_line(vm, 0, 1);
+	kvm_irq_line(vm, 1, 1);
+	kvm_irq_line(vm, 0, 0);
+	kvm_irq_line(vm, 1, 0);
+	kvm_irq_line(vm, 2, 1);
+	kvm_irq_line(vm, 2, 0);
+	kvm_irq_line(vm, 3, 1);
+	kvm_irq_line(vm, 3, 0);
+	kvm_irq_line_status(vm, RTC_GSI, 1);
+	kvm_irq_line_status(vm, RTC_GSI, 0);
+}
+
+static void host_test_savic(struct kvm_vm *vm, int id, enum savic_test_state test_state)
+{
+	switch (test_state) {
+	case SAVIC_IOAPIC_START:
+		host_send_ioapic_irq(vm, id);
+		break;
+	case SAVIC_IOAPIC2_START:
+		host_send_ioapic_irq(vm, id);
+		break;
+	default:
+		break;
+	}
+}
+
 static void *vcpu_thread(void *arg)
 {
 	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)arg;
@@ -288,6 +510,7 @@ static void *vcpu_thread(void *arg)
 		vcpu_run(vcpu);
 		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
+			host_test_savic(vcpu->vm, vcpu->id, uc.args[1]);
 			break;
 		case UCALL_DONE:
 			return NULL;
@@ -299,7 +522,6 @@ static void *vcpu_thread(void *arg)
 		default:
 			TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
 		}
-
 	}
 
 	return NULL;
@@ -309,6 +531,11 @@ static void install_exception_handlers(struct kvm_vm *vm)
 {
 	vm_install_exception_handler(vm, IDLE_HLT_INTR_VECTOR, guest_idle_hlt_intr_handler);
 	vm_install_exception_handler(vm, 29, savic_vc_handler);
+	vm_install_exception_handler(vm, IOAPIC_VECTOR_START, ioapic_edge_irq1_intr_handler);
+	vm_install_exception_handler(vm, IOAPIC_VECTOR_START + 1, ioapic_edge_irq2_intr_handler);
+	vm_install_exception_handler(vm, IOAPIC_VECTOR_START + 2, ioapic_level_irq1_intr_handler);
+	vm_install_exception_handler(vm, IOAPIC_VECTOR_START + 3, ioapic_level_irq2_intr_handler);
+	vm_install_exception_handler(vm, RTC_GSI_IRQ, ioapic_rtc_gsi_intr_handler);
 }
 
 int main(int argc, char *argv[])
@@ -316,8 +543,10 @@ int main(int argc, char *argv[])
 	struct kvm_sev_init args = {
 		.vmsa_features = BIT_ULL(SVM_FEAT_SECURE_AVIC)
 	};
+	struct test_data_page *shared_data[NR_SAVIC_VCPUS];
+	vm_vaddr_t test_data_page_vaddr;
 	struct kvm_vm *vm;
-	int r;
+	int i, r;
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV_SNP));
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SECURE_AVIC));
@@ -326,11 +555,21 @@ int main(int argc, char *argv[])
 	vm = _vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_code, &vcpus[0], &args);
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+	virt_pg_map(vm, IOAPIC_DEFAULT_GPA, IOAPIC_DEFAULT_GPA);
 
 	install_exception_handlers(vm);
 
 	vcpu_args_set(vcpus[0], 1, vcpus[0]->id);
 
+	for (i = 0; i < NR_SAVIC_VCPUS; i++) {
+		test_data_page_vaddr = vm_vaddr_alloc_page_shared(vm);
+		test_data[i] = (struct test_data_page *)test_data_page_vaddr;
+		shared_data[i] = addr_gva2hva(vm, test_data_page_vaddr);
+		vm_mem_set_shared(vm, addr_hva2gpa(vm, shared_data[i]), getpagesize());
+	}
+
+	sync_global_to_guest(vm, test_data);
+
 	vm_sev_launch(vm, snp_default_policy(), NULL);
 
 	r = pthread_create(&threads[0], NULL, vcpu_thread, vcpus[0]);
@@ -338,6 +577,14 @@ int main(int argc, char *argv[])
 
 	pthread_join(threads[0], NULL);
 
+	for (i = 0; i < NR_SAVIC_VCPUS; i++) {
+		struct test_data_page *shared_state = shared_data[i];
+
+		fprintf(stderr, "VCPU %d ioapic edge irq1 count: %ld edge irq2 count: %ld\n", i, shared_state->ioapic_eirq1_count, shared_state->ioapic_eirq2_count);
+		fprintf(stderr, "VCPU %d ioapic level irq1 count: %ld level irq2 count: %ld\n", i, shared_state->ioapic_lirq1_count, shared_state->ioapic_lirq2_count);
+		fprintf(stderr, "VCPU %d ioapic RTC GSI irq1 count: %ld\n", i, shared_state->ioapic_rtc_gsi_irq_count);
+	}
+
 	kvm_vm_free(vm);
 
 	return 0;
-- 
2.34.1


