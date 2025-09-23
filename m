Return-Path: <linux-kselftest+bounces-42122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D65EB94618
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAFB87AA789
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EE23101B5;
	Tue, 23 Sep 2025 05:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aACUWV09"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74B30FF28;
	Tue, 23 Sep 2025 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604754; cv=fail; b=am822VmGi3WD5thnt9kjJH6W2szgtocrQUkegTYOw2smaEs5n+eYiq1iLZXe7wHxAc51KNN2jQkeb/VFp0A7VrogfO4Ntgz7494YMTdiVjESH6szMSMaeQD1x9TuocGW3cLE+5CEkSz93Bpy5cLLW3YYBuNv26FZ+oS4uTwMEqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604754; c=relaxed/simple;
	bh=giMJhY30EOuv/MoNVR4D5QSuFDR5HT+r/1JEh4JlJjE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imROzR69y9uCfHsXFaKFxldX1OTqOgOGkXDD7flalWbP8u1dCMOObVQOiPHER1sGQeotspoHPlggRInGArrqt+e1alp+ewa2YkHeDtuobbnWT26W7n5MeRwc9gRtHnIyQO1f2BBEaajudrL2A37XOs95O2XuUR6c+sYcoN47f0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aACUWV09; arc=fail smtp.client-ip=40.107.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soMCHo182QPFCYq8mkyxaR5q4RxNJNMj7KcKmClP38tMJhW9MkTqIPvX1/zXb00aymxyfLno0LXHyibV6jDOWWH7J2ASq8fBy9szmlx0vfRIBuewT0nN+ZRY73kuUemHxb3/cPXH4LWdx5OOh5LVO9PwsxiX8cuthH0PxqS6tMRGZamgnlOKSlVs4apIihOI4sZ3+aZwPLhHFFnpv4cro74z6mDYw6YmeiLfIhbaAzYBX0jGgm3x825JRLIVA6OstY0LtGQzYghJEQeXF/n1s1bD96Dwnhg9lW9l8b2RKFY4ApgxmTV1p7EpyI2hEV6eg5YE+4NN5ITae2GAEy5/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRFSosfZZgWfg2iNihdj+3hZ/t5JKG00bJzXyPBqY4c=;
 b=b1E2QIznBcBJMABOOm44u07RwOzfzvAgdF8vo4fJtRIQMCYqDx9SYrhwXfNClO2YY6AFzH9N8wFsB688dDaK4xhicvSaOeECi4nBDbibWNK8BZsDIv43iAu8D1DWSe7LtPyqqK96bDWx7quLpgT3w9T8vJxVxero6vjZsyZ4xJna2AMQZX4Mgm3sZEh4zBzMbrw87XGoInOvJpMq5eH2QG+wxEUmLJ8EFKd6bBO/FIXE/Zrr9DjBeKFCazybbQtrL9+dODxktjB0ZklxXMLJpOwyhO4cVXsubX04/+PX+knORXM27/Rkwg6dRs4yyvaHKZ9xd2do//kcvgqFzJi8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRFSosfZZgWfg2iNihdj+3hZ/t5JKG00bJzXyPBqY4c=;
 b=aACUWV09pDsYmi9E21pVBzX6uyamGns+9MV+2/mb6dGn3xX27kIc1k/yjcNvD9gWUB63nqsFf8N92ktaPtw13rvt1cXZpWEWHEmydJy8rwYAQKSWGieOGuTElC6ozdjFBbzhKHItBOV5eZqIb5foeZqh/OnACOZB/OkAVmxUCuc=
Received: from BY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:1d0::20)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:19:06 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::2b) by BY5PR04CA0010.outlook.office365.com
 (2603:10b6:a03:1d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:19:05 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:19:00 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 31/35] KVM: selftests: Extend savic_test with idle halt testing
Date: Tue, 23 Sep 2025 10:39:38 +0530
Message-ID: <20250923050942.206116-32-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5c64cb-2232-424a-2d39-08ddfa60b783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KU1NmQhtug0tH/S0Pl1E2fbSB/uf+pVJi6Axvw1TgtNJFrY9hZPvynrEceS/?=
 =?us-ascii?Q?xWm5Iz7b20QwNF33yb0oxMr8NP/0h+/jvVruCBLMChoLEDTbYeFvwSwYFZwI?=
 =?us-ascii?Q?6wutL406goL2hs6BHOQB8+Mr+zbAcO/JpcbaA3sI1eGaxWnRTYnccRbaJTA/?=
 =?us-ascii?Q?cNKZFqedJrPp8DeD53WR7ZLYiqv8D5Mgy9dXPqYoREowea+WqqaYITNtXxII?=
 =?us-ascii?Q?vK74hsaFODdandIw9p0ajv3JR/hL1HtmQWhP/L4qUDth6vt/fI/4WoRJOMya?=
 =?us-ascii?Q?Gy2LtHZf+WBDWLYGHeEZ1fYsW0LSwCLrYJJFVy6VrbZZmPGms76Cf5m0N2b9?=
 =?us-ascii?Q?GhRB7TVuuqC9kbN5OyNOMOc/pgiB6esLOm/WNf4axNZhOet5YecD7bvva8MX?=
 =?us-ascii?Q?XT0l2dKBJ0+hdE0q1J8kGegqi6WbOt9/ayGvY9cYJjNozcTLZLk97DMcJIvq?=
 =?us-ascii?Q?YXhQOQGc6pqWEOOEEObEMSsmFHZu5OlTNxFI0/SCHZk5iucdDSSKtqpoD8pG?=
 =?us-ascii?Q?S8r+Vjh/27g5IcwfYRybCqh9uevbCuw2DHpF5LMB4i4taz56bVwtQ2Uv3nzY?=
 =?us-ascii?Q?i2k9TJcJQKL0ijT+/geJ1ZPQwomorFdRaIfZou1NLUcGJFqAGtNpIyQTIqe6?=
 =?us-ascii?Q?9th8/FybLNNc5L3mR7ROe/r4gt7/ZYuh6X/gdZ1vpsOJJUJHm2epB5RNYn4+?=
 =?us-ascii?Q?P6IX0WZzSWIZYQKs13LtRJ/JsusHK7XkSMWJOlRjW79oDOxsPKxYWEV7Hu4Y?=
 =?us-ascii?Q?nThzKBWQULTcXrDiWEGSRGnoVV8nH29o1N+MPX/1ut0WlAYen6I0L50hlsZU?=
 =?us-ascii?Q?f2m0H20/0Kc+aGKLdRULJkve+jbLn7I9JB4ns/8skPs17TWwD+c2nOrVD1jg?=
 =?us-ascii?Q?7YELSzCqxZtoJbiLeQ+pWWPmL5ia+f/F1qt1uE7FAc6W+/S3YuXlrd+q7UWg?=
 =?us-ascii?Q?dqhEgGt3j8rMaLPuXivzY8GjzAwnS4RD1seMGh0AHdTi0xyR4cD9jccp5Z/f?=
 =?us-ascii?Q?Tz2pMcYm19tXXBdyw9/KNXRlSjIYEOKm05VwEJqtfzBPUlzlL9BfTahtFWcJ?=
 =?us-ascii?Q?j0RR0Av8vTSUV8k9EMaIibay9Jyj4Mh2X2hiuo+TJjKbcma9M7iJjUSmDijF?=
 =?us-ascii?Q?pyOOS7k3CSSrmN6JcxXDiq/8XOm9cTMkhKSW/Angkx6ifOW118i9IKpg+JqM?=
 =?us-ascii?Q?GVF13XtObhdi3LAZQTjLR6dpOaTZx9/LH3TN+W8a4i0G6HAaCUzY2V5NVvNa?=
 =?us-ascii?Q?tppFrJAVTDaoe5QmxB6s2zXAQmzsvUjwAspaGkfzRlf8cs3AoFgGFDs6P5av?=
 =?us-ascii?Q?21IHcIVFVaRwSjn6oea1K+7wONalo1mnBhGArKmdrdOB344/FREWu07ofiuQ?=
 =?us-ascii?Q?gIThxLtNj2nwUApn7Lykb4Tm/0DXvmdG5qBQB71wM2vPZla84UOynzlwCcUd?=
 =?us-ascii?Q?k+w61try4q6UpLI96R0xS+BCAcNYauy8djJWOYAo8mPluD3YshR7/SbHuvxi?=
 =?us-ascii?Q?NvkTLSbh4ZGh1NLGuCkD4ZnVajQIAofD3FZa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:19:05.7759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5c64cb-2232-424a-2d39-08ddfa60b783
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006

Add a test case to savic_test.c to verify the correct handling of HLT
instructions in Secure AVIC (SAVIC) enabled guests.

This validation is crucial for the SAVIC feature. With SAVIC, the IRR
is managed in the guest's private memory (the APIC backing page), making
it invisible to the hypervisor. In the absence of idle HLT intercept,
the hypervisor would be unaware of pending interrupts in the IRR and
would incorrectly block the vCPU.

Additionally, verify the corresponding ISR and EOI behavior for the
delivered interrupt within the SAVIC model.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/x86/savic_test.c | 57 +++++++++++++++++++-
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/savic_test.c b/tools/testing/selftests/kvm/x86/savic_test.c
index bac56f85caea..9108ac0077a9 100644
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
 
@@ -24,6 +27,7 @@ static pthread_t threads[NR_SAVIC_VCPUS];
 
 enum savic_test_state {
 	SAVIC_TEST_STATE(SAVIC_APIC_MSR_ACCESSES),
+	SAVIC_TEST_STATE(SAVIC_IDLE_HALT),
 };
 
 #define SAVIC_GUEST_SYNC(sync, func) ({\
@@ -89,7 +93,8 @@ static void guest_verify_host_guest_reg(struct guest_apic_page *apage, uint32_t
 	hval = savic_hv_read_reg(reg);
 	__GUEST_ASSERT(gval == val, "Unexpected Guest %s 0x%lx, expected val:0x%lx\n",
 			regname, gval, val);
-	__GUEST_ASSERT(gval == gval2, "Unexpected Guest %s backing page value : 0x%lx, msr read val:0x%lx\n",
+	__GUEST_ASSERT(gval == gval2,
+			"Unexpected %s Guest backing page value : 0x%lx, msr read val:0x%lx\n",
 			regname, gval, gval2);
 
 	switch (reg) {
@@ -161,6 +166,7 @@ static void guest_savic_apic_msr_accesses(int id)
 	val = savic_read_reg(apage, APIC_IRR + APIC_REG_OFF(vec));
 	GUEST_ASSERT((val & BIT_ULL(APIC_VEC_POS(vec))) == BIT_ULL(APIC_VEC_POS(vec)));
 	savic_wrmsr(APIC_TASKPRI, 0x0);
+	savic_write_reg(apage, APIC_IRR + APIC_REG_OFF(vec), 0);
 
 	/* Triggers GP fault */
 	savic_rdmsr(APIC_EOI);
@@ -219,6 +225,43 @@ static void guest_savic_apic_msr_accesses(int id)
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
@@ -229,6 +272,8 @@ static void guest_code(int id)
 
 	SAVIC_GUEST_SYNC(SAVIC_APIC_MSR_ACCESSES, guest_savic_apic_msr_accesses);
 
+	SAVIC_GUEST_SYNC(SAVIC_IDLE_HALT, guest_savic_idle_halt);
+
 	GUEST_DONE();
 }
 
@@ -260,6 +305,12 @@ static void *vcpu_thread(void *arg)
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
 	struct kvm_sev_init args = {
@@ -270,14 +321,16 @@ int main(int argc, char *argv[])
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV_SNP));
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


