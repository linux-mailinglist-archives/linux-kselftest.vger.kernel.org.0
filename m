Return-Path: <linux-kselftest+bounces-42119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7786EB94609
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF41818999FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5F130E82D;
	Tue, 23 Sep 2025 05:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g+hddDqc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010069.outbound.protection.outlook.com [52.101.193.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0330DD00;
	Tue, 23 Sep 2025 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604715; cv=fail; b=VYLue8yiOU8zpcejg3gwWEMJNhIyBlmwTgDbib8+fv9bxQxzMqAlX7SXQ5dCMMJlwTh/S2k+6ZXJwKAu0Xynh08YHCX3sVl++h6+hWnb7s2ZZUfhmd4FEnNIukE8w3ArBEQ7aTrRSKVjFfl2ohPXF1aaZDiqtueVUiTQd9YjvwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604715; c=relaxed/simple;
	bh=SoBW1GXPliZAFoXuaD6SY23K6VIk1FXlAO3E5rhbtvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ED3KQZJHoC0sxPoK4C9Ie2E666gVdDr8fnoHKH5aDYcm4aiEj126RUR1Bie3DHPaSlThB1SV6NdsgYmJwVa2tyJe1w2I6W//4qO9nX6u+PgcNAZ+PFjTwLS6wAPpIcDifngd9+3nitHw9Km2+vHbttDxo8+aDjTJRUprAJK359k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g+hddDqc; arc=fail smtp.client-ip=52.101.193.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CneZ9GJMEkJyUUKxwLW3lzDxizOdcNd7JO62jkAfWC53+dF2VRCVpR5pgHmRqZG1j9uK6ZDNm6BOsmmdIgj7h0t2S/DLvr2ZMSF1wavJ0dcrU7RB8zxFiXqvwxNaJEMqr7090IxBry3wuCmoYMLyMhHv9XxjdTp2qIRkYZ0j2Kjn3T8kV0CSNziPCzpwDex36OPdEm+ZmDylhoQjyQE9rIIZdsSFPzt5lYemhlC6LO2rwgw/c7hCvjwhbhs8QSyxzXa1ow07PYyO5c4YO5ckenSagZamKn5nZr4UFa8GGn5YCBf/yzJFYXGUkMIQH65KZK2sgbP0K/8Y1pta9mwTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2TA0sQ7cMworMtQI4Jwe5ToMOstwAkJ41LIjnxFxLw=;
 b=ES2Wqzjz0y/Q+ESuPPJPmSt5rdQXyConGb2g5baJc7zC/xtA0BtLrRwuc52qpTJyAjsH1OIJJDsectY0Pw+JSHvKAKzFgHqTH9wdY1bxxjjT/lsUjKWkU740+E9YiA9s4aTniqxxDeGBGmb0VJELIZXUBu4tjuhoYpHlJGIhFcMfyXa0yq4nnPdD2SUbH4jSrmbzKLvyOO3MaUgrIww3c3I2UGa5YKtaGMzJWD0/5VNcJSe6weC01qiez2ntxeo61TFbOVbrrRbUAdPFXRNbbNXCp1rQ7ZOgKgKJaS0+CdLyppxalrvpdHa0KvuFFwQlGZctfVccgTasxl/xg0oMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2TA0sQ7cMworMtQI4Jwe5ToMOstwAkJ41LIjnxFxLw=;
 b=g+hddDqciS2z+92VHIyuMAtqAcOTVfRCKrBxLvinLkunXGrpHe/5uOaoFvrw9NoPJfdUHiXMfbUtb4x5RB3Pm8Uq5W2Z2KyF/w1ZN8o47D/OCHIWook8rOHQ5iHVNUvgEs22eqi154YriljKdDF/tC/OGumQpAnJyr5rHr6UlPw=
Received: from SJ0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:33a::13)
 by CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 05:18:29 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::fd) by SJ0PR03CA0008.outlook.office365.com
 (2603:10b6:a03:33a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:18:29 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:18:07 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 28/35] KVM: selftests: Add GHCB call for SAVIC backing page notification
Date: Tue, 23 Sep 2025 10:39:35 +0530
Message-ID: <20250923050942.206116-29-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CY1PR12MB9697:EE_
X-MS-Office365-Filtering-Correlation-Id: a95aac2a-9ced-4a4d-c515-08ddfa60a1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ev+1ZW4t+abkKnzKNSgztNaKNY6BuL2f7lnWjWD71jo+s1RDdXIoIH9h8fR5?=
 =?us-ascii?Q?uzuex2AXIpgxTbkRFWJYntH+a4CO0amC++sdb1/K4resy9n9Qeq6H0iC6MjG?=
 =?us-ascii?Q?S43QSRsxIeDC1KQdArKfvlW1q1S+L7pqCuSf7uxkSIazoBozvhVaBj7j7Qja?=
 =?us-ascii?Q?5+puleeRxLoFosY9wxKgvYTefCCq3NBonvmst7YBb7W/bqzPpnKk6dKjTxdk?=
 =?us-ascii?Q?2OFYkx9dq1pINHsSd1OhTqDcfCNr2ucjEi65eirxLh7ZE6CXK12AXlN7G0/a?=
 =?us-ascii?Q?Oh8huc1JLDIXGYT99KuDJIQeD/GSTtQdPiTHoBdP3tJjgi+k7QF2cYwNsIT3?=
 =?us-ascii?Q?grr1puzNNwd0QYBXBUBpEC+C2nwD16k4Z5AGHiMOn4+KWTlbhbYWPCiMOO9h?=
 =?us-ascii?Q?75Jymz9dZ9NJjUguHeqxuAaTtWcswxcDH4SgRNQPBSDHhZyBH9yNdrkTSnkZ?=
 =?us-ascii?Q?eNNfBiTM3+nkRt6JWt7LXWtEa31YR2ic8SJvt5BfU3ZbFa0SVmeGd63gxRtC?=
 =?us-ascii?Q?Cvr0RD1TxSDQvn1PNWShB26WngGJdaqkHXmCOKH4je5lE53KE4EoVafRqIEt?=
 =?us-ascii?Q?oTiOmGTg53X8+dPhTZYZHhH+X9HLKtJg2F0x4SZ9mDsaCVzLaToFGKunSuRF?=
 =?us-ascii?Q?JdJm13AswbdunZGjSTRiCyr983J4+hc2/waYCzDwJ3GkXRxWswG+H282KYhY?=
 =?us-ascii?Q?dpRR9Tixz6Nm5cDxC6r4uRY8P//rGPVtXstvmCEj63350oKuCP4nJPmpqO4n?=
 =?us-ascii?Q?0RBHmeSzvCY+oSsMOAAv6oYQ+R0htXXjArmPpPriKcudG9HqVAO670Jwtjq7?=
 =?us-ascii?Q?9/l05OhswnJ1wZ80uiLxJcrmdFnUAVsvAmrB2Adjzmd8ve75Rdg6Ma2+UOGO?=
 =?us-ascii?Q?kNxovVcNnRAa7mXMW1Rm+Z4Q8AIoxEV0M0+TMsKeV7NKvJHj3m+Nulp9rMJx?=
 =?us-ascii?Q?XGvUs0Gnu/KtC9fhlJ7r83T5tD5XZw8wfQv5kZE98SguDLAhoiA7YytcucSs?=
 =?us-ascii?Q?AvbJRktCZ+R0Wm9CB0hSS8UyoeTMye8Kn1tMTiloSqPMheZidT5jkoNvV2ZB?=
 =?us-ascii?Q?gZDfcvlE29i10egGCZP9zm0v/lZaIQ8omfhpOzZ4LJdjxt0ASyka/JBRxK1H?=
 =?us-ascii?Q?l72WsElDWv5W7UA33Z1WC4pzggRBmkWPD9e4s5MXYz1xlNi1WZt94jxm7U6Y?=
 =?us-ascii?Q?tHFnU8sR9ql0EzoHtuEMnU6DNWTF0rsq7BoZeRY9LMy+gi4/vIQkqxcuW6lI?=
 =?us-ascii?Q?3roS1y/vkRmHjxaPsOsLD1Xbsq8kI778Y+IFnXib7J16/EThKgybh3Tlj/le?=
 =?us-ascii?Q?twcj/0J13T0wI12D2BrX/XsPsfGDgvzmRN2lJjeaB3CxEh2QeHs436cOYMBE?=
 =?us-ascii?Q?qezwdm8ryXDoGkcRbaNlq3hKU5xYkygdfFXvalLRhvcfDsatuW6X9M6zCiHt?=
 =?us-ascii?Q?F+yeAe1naap0FVDscBuC/iI/EjxqqSh5tEI+2QQoPFq2GaeK3dZtvfGi9FsD?=
 =?us-ascii?Q?lYb5cZGsbcF6PRhB7UfnM/fcwGz/78aMRXkY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:18:29.4539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95aac2a-9ced-4a4d-c515-08ddfa60a1dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9697

When a vCPU enables Secure AVIC (SAVIC), the hardware needs to directly
access the guest's APIC backing page. For this to work correctly, the
hypervisor must be aware of the guest physical address (GPA) of this
page so it can ensure the page is mapped and pinned in the nested page
tables (NPT) while the vCPU is running.

Introduce a paravirtual GHCB call that the guest uses to notify the
hypervisor of the backing page's GPA before activating SAVIC.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/include/x86/sev.h |  1 +
 tools/testing/selftests/kvm/lib/x86/savic.c   |  1 +
 tools/testing/selftests/kvm/lib/x86/sev.c     | 25 ++++++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 73a23043d6c5..3a95b13fb6c0 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -171,4 +171,5 @@ void sev_es_ucall_port_write(uint32_t port, uint64_t data);
 void sev_es_vc_handler(struct ex_regs *regs);
 void sev_es_pv_msr_rw(uint64_t msr, uint64_t *data, bool write);
 void sev_es_pv_mmio_rw(uint32_t *reg_gpa, uint32_t *data, bool write);
+void sev_es_savic_notify_gpa(uint64_t gpa);
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/savic.c b/tools/testing/selftests/kvm/lib/x86/savic.c
index 016e5e9e43f6..24ee15cc5603 100644
--- a/tools/testing/selftests/kvm/lib/x86/savic.c
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -203,6 +203,7 @@ void savic_enable(void)
 	apic_page = &apic_page_pool->guest_apic_page[apic_id];
 
 	savic_init_backing_page(apic_page, apic_id);
+	sev_es_savic_notify_gpa(apic_page->gpa);
 	set_savic_control_msr(apic_page, true, true);
 	savic_ctrl_msr_val = rdmsr(MSR_AMD64_SECURE_AVIC_CONTROL);
 	exp_msr_val = apic_page->gpa | BIT_ULL(MSR_AMD64_SECURE_AVIC_EN_BIT) |
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 257988fce107..840504f0243c 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -8,6 +8,7 @@
 #include "linux/bitmap.h"
 #include "svm.h"
 #include "svm_util.h"
+#include "savic.h"
 
 #define IOIO_TYPE_STR (1 << 2)
 #define IOIO_SEG_DS (1 << 11 | 1 << 10)
@@ -17,7 +18,8 @@
 #define SW_EXIT_CODE_IOIO	0x7b
 #define SW_EXIT_CODE_MSR	0x7c
 #define SVM_VMGEXIT_MMIO_READ		   0x80000001
-#define SVM_VMGEXIT_MMIO_WRITE		  0x80000002
+#define SVM_VMGEXIT_MMIO_WRITE		   0x80000002
+#define SVM_VMGEXIT_SECURE_AVIC	   0x8000001a
 
 struct ghcb_entry {
 	struct ghcb ghcb;
@@ -727,3 +729,24 @@ void sev_es_vc_handler(struct ex_regs *regs)
 		__GUEST_ASSERT(0, "No VC handler\n");
 	}
 }
+
+void sev_es_savic_notify_gpa(uint64_t gpa)
+{
+	struct ghcb_entry *entry;
+	struct ghcb *ghcb;
+	int ret;
+
+	entry = ghcb_alloc();
+	ghcb = &entry->ghcb;
+
+	register_ghcb_page(entry->gpa);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SECURE_AVIC);
+	ghcb_set_rax(ghcb, -1ULL);
+	ghcb_set_rbx(ghcb, gpa);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+	do_vmg_exit(entry->gpa);
+	ret = ghcb->save.sw_exit_info_1 & 0xffffffff;
+	__GUEST_ASSERT(!ret, "Secure AVIC GPA notification failed, ret: %d", ret);
+	ghcb_free(entry);
+}
-- 
2.34.1


