Return-Path: <linux-kselftest+bounces-27869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C352A49691
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 11:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D93E188D03A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216C825E82A;
	Fri, 28 Feb 2025 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mjSZvwey"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3928025E806;
	Fri, 28 Feb 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737121; cv=fail; b=N06YL4efC3WbHoSkP5zd3WEkaAnnXAB/LfMqOXJl0agB1oQ8wlPj/QEX5DQODCtIdMgCBNkanIWuwK8Y4OnEUYwIWSqloahTEOqJTdUIuLTQQLIbzX9KrZrlzepxcH/jDW8+YzlisUYSgSSrOaFNDCxR39+Pvq4PERhCkZ2wzi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737121; c=relaxed/simple;
	bh=XqPwa9CiIqEp5yp2cUh8gKsfkGNNnnISCsIy84qaAnU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WA0/reXDc28ZWVkPU79vtNCsD4f079hBb1MN4FSMAlHDvi6zv6PM3OfnAaWwch5e/PUSpgpnQOhNy7PERTSSgLq95kQAuQosyP+DKIhCVleRosm5BSvpYvqDky94MtChC/91dOpWklH8s6Cy0TSaHE9SpZ+laY8t5K2hAC/vPkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mjSZvwey; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQXe0wSvZfZhrUFGZvVa1Ty5gWSAFrx0ZCeSCXzXeLf9DB+4iM/MnkOxGJk0pT0WYrRJyharu00qhr1O7giFnKQenKj0c5N30j3qx32L8cIuF03TfkRmuCQaA6I/xlvb1+QL/I1Qf+tX4QOtLXHH0NUw4AhCPjmxE2vpQ+EXhEuz9NPJdsXaL/+jB8JvozRuxT/C7xx3MS7vJM9kQEii+ZM6cZvZ/fhrUwZSsRFotkjJg+GPPW7XM7BEk2Xn3Yio2Xiuqe1m6Tla8Yd6/lSjCKUP0Txe2tx4A+OzeLlvd3NRqz4VhWWFO0G145PWnTBngarVv02SifS49BJfSWOLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifE1bSqV7JpPbRCfYrQUd7WyU5nekgwpxobPH0MbUCY=;
 b=cfxTkw5jncf6JGEP0zlGUgaJ0VvLu/aCYMtoJXoy+QRxw0PoGb/ehIvX4tu0rffq+3D0JZ/rtp//PX9XWj2X6esOk+SmkJ+T3iLRXxT5HmCROMoA8oe6cVWrGIKT0k27n7hxCMtnDr6NWD+AKNz9VgShphXaSX0ghI6h9mwFrh8RJVFIA8qXfyUhzKWiqBt8UzGKgN8N/r+KYjROuz8vboT3KjEFE9VoB5dXzUJ6RcntnF6YIJHA24BbNNZ77DTNMyvwj55jnexceoDQhvRFmedn8nJoFjXDgZDvdUa2x3EI4bgLe5ym2jn3ghz5EfFni/Tgr3XRQ3y6ImFqzgROYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifE1bSqV7JpPbRCfYrQUd7WyU5nekgwpxobPH0MbUCY=;
 b=mjSZvweyO6WnV4xpmG2kLzE8VnT9aE2nih5Y6PJERWUwYkXU6G9Dph/+F1C/EXd/jw5KBp8b+XNNLwhjeHThFnJcuOqN+fwDhHnI3J6x5tC3ZHZ7/X5lfvK0ATifwRPgzpoiNNuIcTnJhNg5Paz28ihR669oENGoE4Qu3mU1vPs=
Received: from MW4PR04CA0228.namprd04.prod.outlook.com (2603:10b6:303:87::23)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 10:05:15 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::bb) by MW4PR04CA0228.outlook.office365.com
 (2603:10b6:303:87::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 10:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Fri, 28 Feb 2025 10:05:15 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 04:03:43 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 27/31] KVM: selftests: Extend savic test with idle halt testing
Date: Fri, 28 Feb 2025 15:00:20 +0530
Message-ID: <20250228093024.114983-28-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: c9de03c9-af9b-433c-824a-08dd57df65ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6nuM1yOsQ2cJ0abIxYaBvbgTOGN43Q4ZN7RiTc99AUijSFyZTnEUzsz2t9/H?=
 =?us-ascii?Q?d4bT/P+O/1748sXbA04Gd1soLUQqN8EpccvVmBrtDkqG8R4FjDDfU4/hexuw?=
 =?us-ascii?Q?vTT9o9l2RbR+BovC58myGXzZZqQsrmMKYyLBzMDvvyBReb/rxWXSfyPQsGwL?=
 =?us-ascii?Q?RqH0kQoPQpcdAHp76eJtEQa6GGi1/yLdeS0nORZnINaCC3+yRHVb8flas+ZL?=
 =?us-ascii?Q?258BS/oJr90jUmq1CPU0AXPiUIi9sNpI9eetuVRqixArBrmQeQCl59zxmwXO?=
 =?us-ascii?Q?lx3HtMF2fDZrevmZWpdIV3/61i2v0QHRD63C8yQXTC39oIoAhNWVCqMtPSSL?=
 =?us-ascii?Q?t/icYEdxyV4gSSyp0N3rFdjmxgWS5ZnofC+CPWyIIfZ/DtJ8N3eH7P3EHAFa?=
 =?us-ascii?Q?l8m4EIUUCsh+mka/JI/PQyFMFV68GfTOKNCvMjpBob/NikHAP36qqFrlSMBP?=
 =?us-ascii?Q?OowQGNopGfX2vvj1/Bpo+g+0fmXDVd68csvSVK1K7/1Ll8EzAxuuCn6lUzjh?=
 =?us-ascii?Q?fdqtzFoykYLDQPt2MlJXMIcE6IaqNAnLuA9S7HULxxZJluPVxj4JH56tkPZ+?=
 =?us-ascii?Q?6u5P+oIv4Gaz426tLVg3zHXu6TlZhGuw0kRcKWvtyXl6/rA6iRxaPmN4NqHW?=
 =?us-ascii?Q?5bn7L1fu0tcny93lANeOxtdxD1m6Bb9nIA5auk4ShiOWfc5P/SVJ7DRucMwo?=
 =?us-ascii?Q?Vy0868BOcfQ5RYywkrhln10uKmSdhFKjFs/bLhqY34IcViwSzPTxietalGz9?=
 =?us-ascii?Q?qRZ1DkuRl5W3x1DTzkSgKvzSf9292apXqaXvNG7slADWsvA2XV4oGp09B//k?=
 =?us-ascii?Q?eaga9nBXNAP2Fx0jhYbh3GoH6bGB57J1em+bGA1lo66nM1kJUl9VxCHHGQo0?=
 =?us-ascii?Q?rfRV2+WFvPTcgh6R1NyHvbsUI62lo40qucrlye1BYE2GTsEWfUuaXJYwzrBH?=
 =?us-ascii?Q?zPL9fxgmDKtVoI4zAZDFpFLNm/6pMh/XoZ+S3+N6VrspGeGW/+YrgP4FBTd/?=
 =?us-ascii?Q?YPiawWyvgQHL0H4B/yMbhVIpI3djYCo85qksHhVDGM+9+UqGIoqEb06BHY1O?=
 =?us-ascii?Q?3T7CQ3GJ1GzjorHw9z219XcXVzOP/BK1b90zwkakW9w7sb0sW/0W2pbn7pev?=
 =?us-ascii?Q?vBiF8maPy5VEln260SBb48SffMh89vnKcEnTtc0uObCWtyi0cD1C6Uwwk6xn?=
 =?us-ascii?Q?IdRq/36OJO1ceA44sRCjPDArIsgoUTE5PC4fFJOfgxlaXzSqf+Rpt+gofa4k?=
 =?us-ascii?Q?gvCy/0qNbVUm30wG3dcOhaUl/dWGgaxs+EBbQNMJhF90WfvYB5rT3BTaHuzN?=
 =?us-ascii?Q?eSsReNVG0EpqVg7jkQcIG6WFP//Mcc1thizEt65xkwDGN2yb1ik7xQ08WrPt?=
 =?us-ascii?Q?XjenEyw5Pgec0FWpsCy4Z1UhxA8JsfH1EQ+a1oH2jgzDly8SSWvsABrzFqrN?=
 =?us-ascii?Q?3HP2df7h0RmmPOKehNxfJAG93hJrona+xhP64QudHXDWeAl43moolsn6p3zE?=
 =?us-ascii?Q?l+C9NIMqmFsdbd4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:05:15.0200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9de03c9-af9b-433c-824a-08dd57df65ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

Add idle halt entry and exit on pending events test for
Secure AVIC guests. Secure AVIC guests require idle halt
intercept to be enabled. Without idle halt intercept being
enabled, guest can block in halt forever as hv does not
have access to APIC_IRR state to check for pending events.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/x86/savic_test.c | 57 +++++++++++++++++++-
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/savic_test.c b/tools/testing/selftests/kvm/x86/savic_test.c
index 8cba7a81bce2..5c52254f7b1c 100644
--- a/tools/testing/selftests/kvm/x86/savic_test.c
+++ b/tools/testing/selftests/kvm/x86/savic_test.c
@@ -14,7 +14,10 @@
 #include "savic.h"
 
 #define NR_SAVIC_VCPUS	1
+#define IDLE_HLT_INTR_VECTOR     0x30
+#define NUM_ITERATIONS 2000
 
+static bool irq_received;
 static struct kvm_vcpu *vcpus[NR_SAVIC_VCPUS];
 static pthread_t threads[NR_SAVIC_VCPUS];
 
@@ -30,6 +33,7 @@ enum savic_test_state {
 	/* APIC regs state on Secure AVIC enablement */
 	SAVIC_TEST_STATE(SAVIC_EN),
 	SAVIC_TEST_STATE(SAVIC_APIC_MSR_ACCESSES),
+	SAVIC_TEST_STATE(SAVIC_IDLE_HALT),
 };
 
 /* APIC reg values written by host. */
@@ -346,7 +350,8 @@ static void guest_verify_host_guest_reg(struct guest_apic_page *apage, uint32_t
 	hval = savic_hv_read_reg(reg);
 	__GUEST_ASSERT(gval == val, "Unexpected Guest %s 0x%lx, expected val:0x%lx\n",
 			regname, gval, val);
-	__GUEST_ASSERT(gval == gval2, "Unexpected Guest %s backing page value : 0x%lx, msr read val:0x%lx\n",
+	__GUEST_ASSERT(gval == gval2,
+			"Unexpected %s Guest backing page value : 0x%lx, msr read val:0x%lx\n",
 			regname, gval, gval2);
 
 	switch (reg) {
@@ -418,6 +423,7 @@ static void guest_savic_apic_msr_accesses(int id)
 	val = savic_read_reg(apage, APIC_IRR + APIC_REG_OFF(vec));
 	GUEST_ASSERT((val & BIT_ULL(APIC_VEC_POS(vec))) == BIT_ULL(APIC_VEC_POS(vec)));
 	savic_wrmsr(APIC_TASKPRI, 0x0);
+	savic_write_reg(apage, APIC_IRR + APIC_REG_OFF(vec), 0);
 
 	/* Triggers GP fault */
 	savic_rdmsr(APIC_EOI);
@@ -476,6 +482,43 @@ static void guest_savic_apic_msr_accesses(int id)
 	}
 }
 
+static void guest_idle_hlt_intr_handler(struct ex_regs *regs)
+{
+	struct guest_apic_page *apage = get_guest_apic_page();
+	uint32_t isr, reg;
+
+	WRITE_ONCE(irq_received, true);
+	reg = APIC_ISR + APIC_REG_OFF(IDLE_HLT_INTR_VECTOR);
+	isr = savic_read_reg(apage, reg);
+	__GUEST_ASSERT(isr & BIT(APIC_VEC_POS(IDLE_HLT_INTR_VECTOR)),
+				"Idle halt vector not set in APIC_ISR");
+	x2apic_write_reg(APIC_EOI, 0);
+	isr = savic_read_reg(apage, reg);
+	__GUEST_ASSERT(!(isr & BIT(APIC_VEC_POS(IDLE_HLT_INTR_VECTOR))),
+				"Idle halt vector set in APIC_ISR after EOI");
+}
+
+static void guest_savic_idle_halt(int id)
+{
+	uint32_t icr_val;
+	uint32_t irr;
+	int i;
+
+	x2apic_write_reg(APIC_TASKPRI, 0);
+	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | IDLE_HLT_INTR_VECTOR);
+
+	for (i = 0; i < NUM_ITERATIONS; i++) {
+		asm volatile("cli");
+		x2apic_write_reg(APIC_ICR, icr_val);
+		irr = x2apic_read_reg(APIC_IRR + APIC_REG_OFF(IDLE_HLT_INTR_VECTOR));
+		__GUEST_ASSERT(irr & BIT(APIC_VEC_POS(IDLE_HLT_INTR_VECTOR)),
+				"Idle halt vector not set in APIC_IRR");
+		asm volatile("sti; hlt;" : : : "memory");
+		GUEST_ASSERT(READ_ONCE(irq_received));
+		WRITE_ONCE(irq_received, false);
+	}
+}
+
 static void guest_code(int id)
 {
 	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SNP_SECURE_AVIC);
@@ -492,6 +535,8 @@ static void guest_code(int id)
 
 	SAVIC_GUEST_SYNC(SAVIC_APIC_MSR_ACCESSES, guest_savic_apic_msr_accesses);
 
+	SAVIC_GUEST_SYNC(SAVIC_IDLE_HALT, guest_savic_idle_halt);
+
 	GUEST_DONE();
 }
 
@@ -621,6 +666,12 @@ static void *vcpu_thread(void *arg)
 	return NULL;
 }
 
+static void install_exception_handlers(struct kvm_vm *vm)
+{
+	vm_install_exception_handler(vm, IDLE_HLT_INTR_VECTOR, guest_idle_hlt_intr_handler);
+	vm_install_exception_handler(vm, 29, savic_vc_handler);
+}
+
 int main(int argc, char *argv[])
 {
 	struct kvm_sev_init args = { .vmsa_features = BIT_ULL(SVM_FEAT_SECURE_AVIC) |
@@ -631,14 +682,16 @@ int main(int argc, char *argv[])
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SNP));
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SECURE_AVIC));
+	TEST_REQUIRE(this_cpu_has(X86_FEATURE_IDLE_HLT));
 
 	vm = _vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_code, &vcpus[0], &args);
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
 
+	install_exception_handlers(vm);
+
 	vcpu_args_set(vcpus[0], 1, vcpus[0]->id);
 
-	vm_install_exception_handler(vm, 29, savic_vc_handler);
 	vm_sev_launch(vm, snp_default_policy(), NULL);
 
 	r = pthread_create(&threads[0], NULL, vcpu_thread, vcpus[0]);
-- 
2.34.1


