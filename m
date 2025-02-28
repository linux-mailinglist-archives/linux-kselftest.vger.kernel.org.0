Return-Path: <linux-kselftest+bounces-27870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CABBA4969A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 11:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF08188DC64
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5B325F987;
	Fri, 28 Feb 2025 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3ykR+Iyd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366425F985;
	Fri, 28 Feb 2025 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737153; cv=fail; b=TTAjkNGNl8bLemREYc1SYaQqrhhpSfcH/X2es8NKj/uMC5Z/WcWuCUhVXlRKKoEkEW0/i4fRxCYTGobl/hmBSpUwNNIo2CSxGBSKtxGUqIU8REz/++O7dmz9MO3ZWh+ICd7vPRPRuJdQ+liuV817sKMeF49lwg+F6SLjWWq5ZEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737153; c=relaxed/simple;
	bh=QTPBDHzoVmoljYBZCCQyufVu+dUwDiPAePQMhYXcNd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMRb0YhBPNigni+seQl5DwlU6xGX4kajxNG0jny/s9HXhMkZ72O3eGc64ktwuManw/evkRNXP1cyaabP6rOzL2Sthz9VvKSCGuEnwMU21Rn24+NlAtuqNNVPB3kbqASiHip+wwaKZ5AIsJDLDE+7hdrjOw9jUmAzidJBoxK+9ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3ykR+Iyd; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrugsQCJBzlxG+/Iom58bAW5cPTjQUf8t0w3A4iUOVteFuMBEkMWvRMAPEfsb+iuvQFbv8zF9UhD26hF1MdfulyjkuVK3T3V7icuFzOXfoB/m6Gm9KoVth4nftoKGkXGSsqHm6bsgKbKIXlefy2R7nZVtiLL4MlkYR95Hk5BHni1PDhmVFKvR3GqiUf6AlNj4PWBiVCrtDrNNw7KMINnYfv8uce9dIgixGenPW/Gq8IcQiE9+zh6kyJ43Jkq6GEc6lO+bpNXZeUQLYytrwEvX63Vfl1tgRAVksVL1HiCfYIcMYn9JMvaFHrF7qpbCs8jSvq5XLVNdCiaCrAxMV9jmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWFbYfJcwhS358TrK/q4sfsz5815/j8tpJP8JUzvYVE=;
 b=pkqfw1DppgA0XvsuDGAphGMPzWOBe7Qj01OLWV5wHzEN2n9UcHQwsIvB80KNDlSI2ILLx76h3f76LfaD+nmlQFQZg28PKsugtqPDC1q1ya84JMa2kQguyG/1gX/WekGixFLjtgmrdA6K0fT66t8DpKeCHjS+DNcujHiWyQIHuqnf0RrddjoVleKLnKXzZJkIr+seGY39az9mx7FhWHURO8ljHscdT+wnod+sI3+CRJO0bTgRwULQ2C+YUx/Imcl9CEpIKfhzsM2DnkpyyQmj9lNiKGmLKYILRZWfv576H+BjNa5vur+7WBm8imF1bDvbi5vGICN7cOeJtCScnUCivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWFbYfJcwhS358TrK/q4sfsz5815/j8tpJP8JUzvYVE=;
 b=3ykR+IydJ8XBZg/D0iqetqycHmcsURW7r8XUfbw6Ue86YVWG8Q5BtF9n3B5uQMwM+DzRQLh0KOEgHgY85iLEB6j4P2SI6emTVGtVN3RtVWyGr5gVCCzpbysE9lgZTdI+SgGYtkZ59X1jZteD4La2bPKp3lafuGvLDcN2tLVDx8k=
Received: from PH7PR03CA0006.namprd03.prod.outlook.com (2603:10b6:510:339::25)
 by IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:05:48 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:339:cafe::d4) by PH7PR03CA0006.outlook.office365.com
 (2603:10b6:510:339::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 10:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Fri, 28 Feb 2025 10:05:48 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 04:05:27 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 28/31] KVM: selftests: Add IOAPIC tests for Secure AVIC
Date: Fri, 28 Feb 2025 15:00:21 +0530
Message-ID: <20250228093024.114983-29-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
References: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|IA1PR12MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e735f30-704d-4cd0-3cf8-08dd57df7971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?82VYl5FMqFh/lUgmPMFnGeB2qqxwo4ORBlm4XM+SKbxR0OnXKVu6Dk6Ji7B9?=
 =?us-ascii?Q?SmtugEBbzXq5CxpUs3HG8IgGVofRXzqv+5Jom5utpGZfk3CTJy7GikaJaddd?=
 =?us-ascii?Q?9b4jlwTz1P6EWwrepnKywBxX2sMCtRs90Kl8I2hXVosU1HhgGFhX201qLnXV?=
 =?us-ascii?Q?zCGBvQvesMp/tELzFUD16rsI98yVL9Wsl9L1CMKCafCUHTJJA7+7sQAZdTGc?=
 =?us-ascii?Q?+XUYLtkZn+joOQkOLD3Y9oAevUj8OGVQQZfnxhRbCwtLk9O/jJM1crHnvcgd?=
 =?us-ascii?Q?PRBfu7+YL2rznd7TDRFRmnv4INmrukHEHqZUnl0D5XPmDeLnVt5eckuuGaMS?=
 =?us-ascii?Q?5kIx4QPewZoO+LJ4NndMMUizVkg7tfdSxBHu6oJfL6B9RcSY0KSW8jbIq7Ho?=
 =?us-ascii?Q?5tF/pZAwktd+buiNqflsmarXOUiqAaq0zDH8VKPsfEgGtL3pQJa99Dq8NBzZ?=
 =?us-ascii?Q?yUO00y2c1wzsTAIXDolGSzb8kov5vzchHxvwMOVu0Xjj0w7WhJHZKQPCUAQn?=
 =?us-ascii?Q?7k5i5E8AWGbsdioQPIW41gkbUKanX3SDdU2rJ5GCsUCfLlTr6EajC8YEcGoD?=
 =?us-ascii?Q?yhNbe9BEzezzdE5toDBUvs7COEzsH+ZJR+o0nHEZpPlnSztMAvt9jT/CupNa?=
 =?us-ascii?Q?PIM6uwunJtcNs+PhSo5p7AjCvCM603zZa0i4WIN4ud/BxRabycujt4mnxSQ9?=
 =?us-ascii?Q?nhx7S45OuQH3aMcCmtl/mfSWOAEZt87iag20qGQx/LROfAmPBGe6YCH7K8Gx?=
 =?us-ascii?Q?iO+DJMWyIekTjRca9u4AukKwB+UzHcAfahMHbH/vTk83hJ/r6wqwstZQqT3o?=
 =?us-ascii?Q?z7rIpzgjuPTJa1bCcmBCuLZlpxxBiY+2E4WzgrUBEEBHOo0d3D4PQ1UAUIv1?=
 =?us-ascii?Q?PC5v8bUvUePmip/+Hil5sC4kr/nKcPySQwrD6e7dfQJuySaJfeVkTPwLPLE7?=
 =?us-ascii?Q?kSA1QbntS8LMjxwNKW2MZ+jfVqD3fB0Cr1vloKyvlIpEQ6C28fM+hGKbpYqD?=
 =?us-ascii?Q?7dou1oqvLkM7RvrXKvjicPg7Mr32Hx7ikpgU2fQMirUxFXTNqgei57jmWhA/?=
 =?us-ascii?Q?xLnKPCezqZDsopzF9qrR6DIkMz094uyoKHc0EmN2wEPi1A4+lImc5fcGxSct?=
 =?us-ascii?Q?x6SnmP2npEHtH5uPx5A+TstluIxxhMyG2gfAGBU5GsOKKZoHp2lPSM3xOuo2?=
 =?us-ascii?Q?t3X+m4dZfbmHOMiOOFIKT3Hei8LmZxNXnkhwr7liZnQE+p8lohI9NIHuA8rG?=
 =?us-ascii?Q?EGAk6BJ8DUdgIyGclDmNQNEyIpv7A+8UdQQE6HRCkLS/Y63HcTjHghFHjMJZ?=
 =?us-ascii?Q?ZgnaV5cSVWAA9yqCfWDUcPWMOy+UXVu9QUWbgCueDOHm1eCgRlqPObR6JnIy?=
 =?us-ascii?Q?dzenJs2tHB2QKW8O2nscRzuVjMmyWp54+yGUh/qC5kvF/XQe1mjTqv+gPm4z?=
 =?us-ascii?Q?c5aEJULuD7U5SSNVzjfolhNHdNSKS5e3+5DetJOLcyhq6x3i7Sw70X5qk6h6?=
 =?us-ascii?Q?IiTmcalA7jds2Z4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:05:48.1547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e735f30-704d-4cd0-3cf8-08dd57df7971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162

Extend Secure AVIC tests to test edge and level
ioapic based interrupt flow. In addition, test
RTC_GSI IOAPIC line which has special casing
in KVM. Add new interfaces to read and write to
IOAPIC redirect tables.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 .../testing/selftests/kvm/include/x86/apic.h  |  49 ++++
 .../testing/selftests/kvm/include/x86/savic.h |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  17 ++
 .../testing/selftests/kvm/lib/x86/processor.c |   2 +-
 tools/testing/selftests/kvm/lib/x86/savic.c   |  11 +
 tools/testing/selftests/kvm/x86/savic_test.c  | 270 +++++++++++++++++-
 7 files changed, 347 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 7f97bade5797..33326c5975c0 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -861,6 +861,7 @@ void *vcpu_map_dirty_ring(struct kvm_vcpu *vcpu);
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
index 93b8e2ccc7b3..900fbad7258c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1861,6 +1861,23 @@ void kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level)
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
index 09474be27986..da2f8d974f60 100644
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
index c637e486b6e8..ee2d6b66d6ce 100644
--- a/tools/testing/selftests/kvm/lib/x86/savic.c
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -46,6 +46,7 @@ enum lapic_lvt_entry {
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS      0x402
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI            0x401
 
+#define SAVIC_ALLOWED_IRR               (APIC_IRR + 0x4)
 #define SAVIC_NMI_REQ_OFFSET            0x278
 
 /*
@@ -108,6 +109,16 @@ struct guest_apic_page *get_guest_apic_page(void)
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
index 5c52254f7b1c..3399ccefc37d 100644
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
@@ -34,6 +40,8 @@ enum savic_test_state {
 	SAVIC_TEST_STATE(SAVIC_EN),
 	SAVIC_TEST_STATE(SAVIC_APIC_MSR_ACCESSES),
 	SAVIC_TEST_STATE(SAVIC_IDLE_HALT),
+	SAVIC_TEST_STATE(SAVIC_IOAPIC),
+	SAVIC_TEST_STATE(SAVIC_IOAPIC2),
 };
 
 /* APIC reg values written by host. */
@@ -108,6 +116,17 @@ enum context {
 
 static struct kvm_lapic_state apic_state[NR_SAVIC_VCPUS];
 
+/* Data struct shared between host main thread and vCPUs */
+struct test_data_page {
+	uint64_t ioapic_eirq1_count;
+	uint64_t ioapic_eirq2_count;
+	uint64_t ioapic_lirq1_count;
+	uint64_t ioapic_lirq2_count;
+	uint64_t ioapic_rtc_gsi_irq_count;
+};
+
+static struct test_data_page *test_data[NR_SAVIC_VCPUS];
+
 /*
  * Write APIC reg from host or guest context.
  *
@@ -519,6 +538,177 @@ static void guest_savic_idle_halt(int id)
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
@@ -537,6 +727,10 @@ static void guest_code(int id)
 
 	SAVIC_GUEST_SYNC(SAVIC_IDLE_HALT, guest_savic_idle_halt);
 
+	guest_setup_ioapic(id);
+	SAVIC_GUEST_SYNC(SAVIC_IOAPIC, savic_ioapic);
+	SAVIC_GUEST_SYNC(SAVIC_IOAPIC2, savic_ioapic2);
+
 	GUEST_DONE();
 }
 
@@ -611,6 +805,46 @@ static void host_post_savic_en_end(int id)
 	test_apic_vals(id, false, CTXT_HOST, true, true);
 }
 
+static void host_send_ioapic_irq(struct kvm_vm *vm, int id)
+{
+	int i;
+	int vec, offset, pos;
+	uint32_t regval;
+
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
+
+	vcpu_ioctl(vcpus[id], KVM_GET_LAPIC, &apic_state[id]);
+
+	for (i = 0; i < IOAPIC_NUM_EDGE_VECTORS; i++) {
+		vec = IOAPIC_VECTOR_START + i;
+		offset = APIC_REG_OFF(vec);
+		regval = *(uint32_t *)&apic_state[id].regs[APIC_TMR + offset];
+		pos = APIC_VEC_POS(vec);
+		TEST_ASSERT(!(regval & BIT_ULL(pos)), "TMR should be 0 for vector: %x", vec);
+		regval = *(uint32_t *)&apic_state[id].regs[APIC_IRR + offset];
+		TEST_ASSERT(regval & BIT_ULL(pos), "IRR should be 1 for vector: %x", vec);
+	}
+
+	for (i = 0; i < IOAPIC_NUM_LEVEL_VECTORS; i++) {
+		vec = IOAPIC_VECTOR_START + 2 + i;
+		offset = APIC_REG_OFF(vec);
+		regval = *(uint32_t *)&apic_state[id].regs[APIC_TMR + offset];
+		pos = APIC_VEC_POS(vec);
+		TEST_ASSERT(regval & BIT_ULL(pos), "TMR should be 1 for vector: %x", vec);
+		regval = *(uint32_t *)&apic_state[id].regs[APIC_IRR + offset];
+		TEST_ASSERT(regval & BIT_ULL(pos), "IRR should be 1 for vector: %x", vec);
+	}
+}
+
 static void host_test_savic(struct kvm_vm *vm, int id, enum savic_test_state test_state)
 {
 	switch (test_state) {
@@ -632,6 +866,12 @@ static void host_test_savic(struct kvm_vm *vm, int id, enum savic_test_state tes
 	case SAVIC_EN_END:
 		host_post_savic_en_end(id);
 		break;
+	case SAVIC_IOAPIC_START:
+		host_send_ioapic_irq(vm, id);
+		break;
+	case SAVIC_IOAPIC2_START:
+		host_send_ioapic_irq(vm, id);
+		break;
 	default:
 		break;
 	}
@@ -660,7 +900,6 @@ static void *vcpu_thread(void *arg)
 		default:
 			TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
 		}
-
 	}
 
 	return NULL;
@@ -670,6 +909,11 @@ static void install_exception_handlers(struct kvm_vm *vm)
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
@@ -677,8 +921,10 @@ int main(int argc, char *argv[])
 	struct kvm_sev_init args = { .vmsa_features = BIT_ULL(SVM_FEAT_SECURE_AVIC) |
 					BIT_ULL(SVM_FEAT_ALLOWED_SEV_FEATURES_VALID)
 				   };
+	struct test_data_page *shared_data[NR_SAVIC_VCPUS];
+	vm_vaddr_t test_data_page_vaddr;
 	struct kvm_vm *vm;
-	int r;
+	int i, r;
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SNP));
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SECURE_AVIC));
@@ -687,11 +933,21 @@ int main(int argc, char *argv[])
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
@@ -699,6 +955,14 @@ int main(int argc, char *argv[])
 
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


