Return-Path: <linux-kselftest+bounces-27858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9E6A495DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386F4189197F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186052586EE;
	Fri, 28 Feb 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uuPA7uMn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E96257AEC;
	Fri, 28 Feb 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736259; cv=fail; b=MCGKkfWcVYDtSV6R7xenhxFKpdr+95YPODTGDocMmU64RmsKmGgcZfKMc6Ips7oLQ+NwMYfe5ATV9jSr1LCCb9xu3IrEPR3GtglZcT03smy/aOL35StQI/zoGOHLdeNT/sPu2xcNjB8qvzr2nSemjgpNLzLJRMKBuA9ocRdQKEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736259; c=relaxed/simple;
	bh=XMTTZtqo8L7DM5SGkAgl9ijrT6nzq8Inz+uzBlBW6Jk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odCfpjnbjbUHuUUOk1s9VuqPzqwkssH2sy6B1W12VhO2x8ndq8JFp5GRecLJZvR4YEDXnqjbmQmYrzZQxeFPt7OhX21uAJ2ZqVRIUO1WWWnDLYUDIwg0Ijikv8DFFifT/HmyOFOqYNKKT6gqFBXoblBD1u5MUvPO5aWLH3AJ9Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uuPA7uMn; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bI3MYHLIFKlYkt/8W1mx7F5FWNqGwdkCyL6o2uWS06v8wER/0l18hfoeYjVFuTlsIBynnBsDZK0uHpr3wBxKem+FjlovmZJE+B2Wve1Eb9CTv8ME7LeaYb1STrvh3ereqaRM9OzJM9cXvU+8wr8FMH4JkBGzZgveJItbGTRFWSfRbYhuhLSrjaOb95htTQF6tchnr29KujQDXNrMTv0WVwAgyyK9YuDxvs/8a3F5QVruwlrIO76x1xL0OcXElF85TeppRxUhzzTQQMszL8Cc1vXEihx7Yqyq/awtS6HiOcnB5hdXltGpgnFDwS57K9nfd3QZO4qJwRy7t/YOlBQhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ongzqT3ft0yi878ilh4B8gyyQ4FtiAWT5kAGVHhaVf4=;
 b=tux9k9B7vfviA1xgDftTlPq6liBga39IEVh+EOlpahvzvHkdNbSXc8uQwOSWPfA4/jlaWYhdArrkMaukEUkCkHIMEcGVKCGloVrGnPIZFrS1vHkWV/2OTElsO5HKPTE4Veg+MimEGU97ResNOBKcgkf4VEsn15YcT3Q1wR32zBwAJNzfitSwLI1sGKJ2KDi3oHObMEwrMI9oBd6kYGO0O57ulxmvmB7xBK2G5qf8HELoZKx56WCpUBHERyd5OUAkzU5ZioUiMTjhJ3O42DLNAJKZScHi4fYRU0K7mdinEa7mjOoceMl0E7LTE5Ki/+L5wfkjLU0iVZbLNzDxD5u9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ongzqT3ft0yi878ilh4B8gyyQ4FtiAWT5kAGVHhaVf4=;
 b=uuPA7uMnlJ6OiH6kAQLRciZXcPKFQA6eU2XJue/olzTOwg9tfFkqIgJRzImxZrG7axC89LHSsL0lTVm3OmRNJ62VOPN8GTaX6cjtHFYcRSjJfovOasnIhT4aD1sIZYTL+//r72SYjWsvGWyjIqnX4uerzccOsSafSdoDFaOfnJM=
Received: from SJ0PR05CA0151.namprd05.prod.outlook.com (2603:10b6:a03:339::6)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 09:50:50 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::df) by SJ0PR05CA0151.outlook.office365.com
 (2603:10b6:a03:339::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Fri,
 28 Feb 2025 09:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:50:50 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:50:33 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 16/31] KVM: selftests: Add SEV guests support in xapic_state_test
Date: Fri, 28 Feb 2025 15:00:09 +0530
Message-ID: <20250228093024.114983-17-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: ca125e08-6bc3-4582-ebc3-08dd57dd626b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ED5Y8Eas5203BNgDbELCHqcj1q8IGBZbYXShe753M3gRBuqfR6QAxVMUavcY?=
 =?us-ascii?Q?+QlNovZi6K2X1jlPT7V1fHlFvbF2V6MulEGRKu8vC+L+FbAWKemHeExn7qLR?=
 =?us-ascii?Q?KTYsHO/JRHQ+WKyorUbduv13oSY8mYb5RbJAtYupuamqR9z7wzcKLUodTNn3?=
 =?us-ascii?Q?71Ky+LeO3xGoxZItppOBFu5RoWfcY+qcOYAfhcOD9PblzECYSJZOdoo62pyC?=
 =?us-ascii?Q?UVOpGwn1MTgLxtSid/X4gB2hftMs1CzfXuf8sHhMABYvTkFDAyMowzpyInn3?=
 =?us-ascii?Q?UBm3X2C5az1lNvwKm7Jk5LO/KS2gG8RcU5tLqEgbjuTwAOXIIO4Enf0USKNV?=
 =?us-ascii?Q?t5bc8D5fqjWRi95TdL4cxuQ0GrSdqK9gNH02IrKRL9lNtlioMp0c0b7FanHS?=
 =?us-ascii?Q?OfjFdzr8RqIix7tDKhBENfGS7U2dIDeRMVvIn8xddqokbolr6TyC5l3OiN+R?=
 =?us-ascii?Q?ziTUX0NIJaP8qaUt1JpksMZdkgwL94v6V0UTNCSCq1LHLiENX64x8tzGTOMt?=
 =?us-ascii?Q?BampINTjdPzhgKfhCZ1du+dO8s+PpFwA6bobYBRnDRbSPpDwO4//NOYMiKYe?=
 =?us-ascii?Q?E4Bo0+JAYitCmWKHDouOY7EsW2Xxufsq3w1Oztw0dGt4eMGbSBnaGjG1TuJp?=
 =?us-ascii?Q?vrE8QsAtGQfDIKwP3fu3cWQaBB9CDkavMddAz/zDwyoeR3cl7AH414HXEk0/?=
 =?us-ascii?Q?YMkOpinGbQk+Zbs71IwDg4LROk0AZVPQhdPa5y0tIWNu/W9AVAQNtpSny4Ro?=
 =?us-ascii?Q?mRlkhGeDa5Ym8ab7W1OFUIj/UhmMzm7vl9FUzawcIyrwQTJHqcRDZkUHhYEM?=
 =?us-ascii?Q?RbIT8Vy8sl4pG3cTrYhsCOmDARHP/ZYgd7W8sSlLLNssg0HwZuEmmQBZc61Q?=
 =?us-ascii?Q?/+aPDxYhNM/Jc0EYmI6f1nvplnf2ydBwZPR1W+SoV+cxEQSby8PYM2rJMpNU?=
 =?us-ascii?Q?DhupEmILGK5FA7QnlTKI7/Y1BtGnKdHy4f0vePWF2j9PAKCbQr6wenzRVHOp?=
 =?us-ascii?Q?Uncyd29QODaHiFKkD3jdm+OXeE/eh20CJZelZqwk6zeEdhKny31N8vodvKKb?=
 =?us-ascii?Q?jteVyIHON0L7Ii50GmrDw5sk+FhC6O2+CrdScLlxcFhWrHqqx6AgIKNhVYcZ?=
 =?us-ascii?Q?wf7jSjyalOFFgJ0RRv7wrhtZkAsSF29Z4bBqCjXqrSqaEdJ4LN8JDQDqiexS?=
 =?us-ascii?Q?b158EO9NJCu3rCJiV5Y7dqHU0g0p9aiiFxxS8dP/wetNJ0x/6jPUCqbsa7+2?=
 =?us-ascii?Q?AScxa9sINfDqKYw661zeSu2sYDW1jbU8AuoejksXhk6BdeLDflOjwa+DtyKT?=
 =?us-ascii?Q?o3xF4b5LAHoOOB1beD3uOtQambozzJB6qyEtq2dbbtWKR7rcW5GKp1u2svYw?=
 =?us-ascii?Q?Zij6CzLPyofeIja7Wh2AkCwNDqP7PhqVYGk970QWV2D8K6cjFEPUcmmIoX/c?=
 =?us-ascii?Q?T9GMBhYAQkAqPmWQuKheZzxlQ1vnW94V92z7Uu8KPt+nXm0TSJRbdTSxkBYk?=
 =?us-ascii?Q?E5AoNVda5tkSvYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:50:50.6169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca125e08-6bc3-4582-ebc3-08dd57dd626b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795

Now with xapic/x2apic acceses being supported for SEV-ES and
SNP guests, add support for testing these VMs in xapic_state_test.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../selftests/kvm/x86/xapic_state_test.c      | 117 ++++++++++++++++--
 1 file changed, 109 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_state_test.c b/tools/testing/selftests/kvm/x86/xapic_state_test.c
index 88bcca188799..efbc98f04d45 100644
--- a/tools/testing/selftests/kvm/x86/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_state_test.c
@@ -9,6 +9,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "test_util.h"
+#include "sev.h"
 
 struct xapic_vcpu {
 	struct kvm_vcpu *vcpu;
@@ -160,6 +161,27 @@ static void __test_apic_id(struct kvm_vcpu *vcpu, uint64_t apic_base)
 		    expected, apic_id);
 }
 
+static inline bool is_sev_vm_type(int type)
+{
+	return type == KVM_X86_SEV_VM ||
+		type == KVM_X86_SEV_ES_VM ||
+		type == KVM_X86_SNP_VM;
+}
+
+static inline uint64_t get_sev_policy(int vm_type)
+{
+	switch (vm_type) {
+	case KVM_X86_SEV_VM:
+		return SEV_POLICY_NO_DBG;
+	case KVM_X86_SEV_ES_VM:
+		return SEV_POLICY_ES;
+	case KVM_X86_SNP_VM:
+		return snp_default_policy();
+	default:
+		return 0;
+	}
+}
+
 /*
  * Verify that KVM switches the APIC_ID between xAPIC and x2APIC when userspace
  * stuffs MSR_IA32_APICBASE.  Setting the APIC_ID when x2APIC is enabled and
@@ -168,16 +190,22 @@ static void __test_apic_id(struct kvm_vcpu *vcpu, uint64_t apic_base)
  * attempted to transition from x2APIC to xAPIC without disabling the APIC is
  * architecturally disallowed.
  */
-static void test_apic_id(void)
+static void test_apic_id(int vm_type)
 {
 	const uint32_t NR_VCPUS = 3;
 	struct kvm_vcpu *vcpus[NR_VCPUS];
 	uint64_t apic_base;
 	struct kvm_vm *vm;
 	int i;
+	struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = vm_type,
+	};
 
-	vm = vm_create_with_vcpus(NR_VCPUS, NULL, vcpus);
+	vm = __vm_create_with_vcpus(shape, NR_VCPUS, 0, NULL, vcpus);
 	vm_enable_cap(vm, KVM_CAP_X2APIC_API, KVM_X2APIC_API_USE_32BIT_IDS);
+	if (is_sev_vm(vm))
+		vm_sev_launch(vm, get_sev_policy(vm_type), NULL);
 
 	for (i = 0; i < NR_VCPUS; i++) {
 		apic_base = vcpu_get_msr(vcpus[i], MSR_IA32_APICBASE);
@@ -195,15 +223,21 @@ static void test_apic_id(void)
 	kvm_vm_free(vm);
 }
 
-static void test_x2apic_id(void)
+static void test_x2apic_id(int vm_type)
 {
 	struct kvm_lapic_state lapic = {};
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	int i;
+	bool is_sev = is_sev_vm_type(vm_type);
 
-	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+	if (is_sev)
+		vm = vm_sev_create_with_one_vcpu(vm_type, NULL, &vcpu);
+	else
+		vm = vm_create_with_one_vcpu(&vcpu, NULL);
 	vcpu_set_msr(vcpu, MSR_IA32_APICBASE, MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE);
+	if (is_sev)
+		vm_sev_launch(vm, get_sev_policy(vm_type), NULL);
 
 	/*
 	 * Try stuffing a modified x2APIC ID, KVM should ignore the value and
@@ -222,6 +256,46 @@ static void test_x2apic_id(void)
 	kvm_vm_free(vm);
 }
 
+void get_cmdline_args(int argc, char *argv[], int *vm_type)
+{
+	for (;;) {
+		int opt = getopt(argc, argv, "t:");
+
+		if (opt == -1)
+			break;
+		switch (opt) {
+		case 't':
+			*vm_type = parse_size(optarg);
+			switch (*vm_type) {
+			case KVM_X86_DEFAULT_VM:
+				break;
+			case KVM_X86_SEV_VM:
+				TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
+				break;
+			case KVM_X86_SEV_ES_VM:
+				TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV_ES));
+				break;
+			case KVM_X86_SNP_VM:
+				TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SNP));
+				break;
+			default:
+				TEST_ASSERT(false, "Unsupported VM type :%d",
+					    *vm_type);
+			}
+			break;
+		default:
+			TEST_ASSERT(false,
+				    "Usage: -t <vm type>. Default is %d.\n"
+				    "Supported values:\n"
+				    "0 - default\n"
+				    "2 - SEV\n"
+				    "3 - SEV-ES\n"
+				    "4 - SNP",
+				    KVM_X86_DEFAULT_VM);
+		}
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	struct xapic_vcpu x = {
@@ -229,8 +303,24 @@ int main(int argc, char *argv[])
 		.is_x2apic = true,
 	};
 	struct kvm_vm *vm;
+	int vm_type = KVM_X86_DEFAULT_VM;
+	bool is_sev;
+
+	get_cmdline_args(argc, argv, &vm_type);
+	is_sev = is_sev_vm_type(vm_type);
+
+	if (is_sev)
+		vm = vm_sev_create_with_one_vcpu(vm_type, x2apic_guest_code,
+				&x.vcpu);
+	else
+		vm = vm_create_with_one_vcpu(&x.vcpu, x2apic_guest_code);
+
+	if (is_sev_es_vm(vm))
+		vm_install_exception_handler(vm, 29, sev_es_vc_handler);
+
+	if (is_sev)
+		vm_sev_launch(vm, get_sev_policy(vm_type), NULL);
 
-	vm = vm_create_with_one_vcpu(&x.vcpu, x2apic_guest_code);
 	test_icr(&x);
 	kvm_vm_free(vm);
 
@@ -239,7 +329,15 @@ int main(int argc, char *argv[])
 	 * the guest in order to test AVIC.  KVM disallows changing CPUID after
 	 * KVM_RUN and AVIC is disabled if _any_ vCPU is allowed to use x2APIC.
 	 */
-	vm = vm_create_with_one_vcpu(&x.vcpu, xapic_guest_code);
+	if (is_sev)
+		vm = vm_sev_create_with_one_vcpu(vm_type, xapic_guest_code,
+				&x.vcpu);
+	else
+		vm = vm_create_with_one_vcpu(&x.vcpu, xapic_guest_code);
+
+	if (is_sev_es_vm(vm))
+		vm_install_exception_handler(vm, 29, sev_es_vc_handler);
+
 	x.is_x2apic = false;
 
 	/*
@@ -254,9 +352,12 @@ int main(int argc, char *argv[])
 	vcpu_clear_cpuid_feature(x.vcpu, X86_FEATURE_X2APIC);
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+	if (is_sev)
+		vm_sev_launch(vm, get_sev_policy(vm_type), NULL);
+
 	test_icr(&x);
 	kvm_vm_free(vm);
 
-	test_apic_id();
-	test_x2apic_id();
+	test_apic_id(vm_type);
+	test_x2apic_id(vm_type);
 }
-- 
2.34.1


