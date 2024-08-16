Return-Path: <linux-kselftest+bounces-15564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38995516C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 21:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA511F22596
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFA21C4620;
	Fri, 16 Aug 2024 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yYBLprm7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9A1C3F21;
	Fri, 16 Aug 2024 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836298; cv=fail; b=aTKHO/XGVdG4MB69g1bIUK9kYNtdjvuTB2FRYqgovjrq6az0LkdLl6FoWsYiOFlW+sPoIfQeM9GtZRlmket7VWqp+4BfPddVDiHh5skBVzInbKEQczflf7KEDUz/9DoBhoXXiscv1j7/o9P3le+cmU+Z5HuT8YBEbYIUl+6eTLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836298; c=relaxed/simple;
	bh=ti1A8m5XK1ndnnaLRd5Lnh8XHKMMPbhAtdjFlzbibUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiQKH8sEAlhg/8pZ53h81LHRooiuCtf15kVpu8VI1iK65hG7xiihv2R31ucgyjQvcKKhULhAfMEGz8gpfTk82VwpBrcFaNZiQKEQ19NbtFX+Oh1utzH7256PvCbKt8de2U9GeG4ykTij6jWh0G60zlrbF7kBGs/XjqkAll53ZIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yYBLprm7; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efl+UXPlAdN1Yu3nY1bvsboYfUcP7/0TDLRg6lgpPN01Zo8tRqLoOjKdqW1YUle88NDS3sePOsNtafwGhVviSMXQLUHx4vEpkNKlsVH+0LN/Xya3Q2WrGXHJFPj+jnyWFQQcDzKJ2Qv6MQukZktY6jZuzgHfiimfmMi0oEWLf0BFca5FXxXuhrjD701Y3R6llZSB9U8I2cteCU8WBLWzfVtEs12w25nW11rejK0v/QtDEcIcxZw+eW2FQyfbrY6qTtJdBtwYiA6Av/+IdXKSlUB9HoLKPBhFp3TUej92rsTb8IRqe805Y4wkRm1VD4bclKnEgrBQ+NEELksoxgOe/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgoGBdqj8XR4W8IGhzWnhzzpWidDcZTs/2j9X8K9cKs=;
 b=Rdz6qUQ9qPNJD0AjpMTKozpc/Rk/5lBD5WvJnWfdL1j+CYVOz/UuQvg/vnU3euW5FJai7YiVkN5mQTmPFXahHZOjEkMbzNlMU8n7E8HYixi8z5n3VuLdJnuu0k6aS7hLt4pl5iZFggiPnUqT98NGCvoY3/oGPzJQKnQjTIxhEpJQAi6z1Rm59fy1yST4Q83eYuVitM3H354kya1KYpWsFmx6zyvcLFakXBBGf1UK48Qzi60jkcxNIWLxJKhtTFfX9Wug+U5Tob7vF9ogJnC4hiQaYgQj+iIiNm44NATDa5wxCAlGp6yOp2MB7sDup1kiCYf+Y0c2K97emtnuBk2i5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgoGBdqj8XR4W8IGhzWnhzzpWidDcZTs/2j9X8K9cKs=;
 b=yYBLprm79MZKnaw1Cod0lkKDjOvydAl/dvtdvH4yjjRAZTRjjAw8WsnigBcyMAveNryh9GNrXjKxji48Zb9tcuTmqT0692K3maKXEXwLrtk0qgaf1Uu7HVliTxDwIb2lEjUlhOjtwFdlKl38XA5SVZFdmhJna5y4pnMGMyj7dDs=
Received: from SJ0PR05CA0163.namprd05.prod.outlook.com (2603:10b6:a03:339::18)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Fri, 16 Aug
 2024 19:24:49 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::dd) by SJ0PR05CA0163.outlook.office365.com
 (2603:10b6:a03:339::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16 via Frontend
 Transport; Fri, 16 Aug 2024 19:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 19:24:48 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 14:24:47 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 8/9] KVM: selftests: Add a CoCo-specific test for KVM_PRE_FAULT_MEMORY
Date: Fri, 16 Aug 2024 14:23:09 -0500
Message-ID: <20240816192310.117456-9-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
References: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc01973-af0d-4370-448f-08dcbe291859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5M/isi01rE1jtNTwyaxl6bBJ4ng19QUE7HoT3zj85oJE/zhzvGc5IWDrnVHi?=
 =?us-ascii?Q?p5MHz7/e8CUkzI3h3XtjGGppoLsuSxTtayaP0FiBmE6FaQheWeGy9t4uTciw?=
 =?us-ascii?Q?c9XQK4NJyelh34B6A/GZDXeLI27JMxviBX7hFMLlkM89nluGsZ9QvLDFSt10?=
 =?us-ascii?Q?IeG3poDFTajaM70hYiDeDb4RnmyUqAjvyGW7/6bn3gbzgYdIhLuiG+J2dhMH?=
 =?us-ascii?Q?oPBISLBR4b2Th0LrMrEVwG4dlh5o6/n9JgMeAmfafaPfk59qQsaNtrQuJL+c?=
 =?us-ascii?Q?Y8pu6RX15AObS95Re0sQIjqXU6ktMNx7i/d9BWDfy5ZANmshsj6Ao2I3zoct?=
 =?us-ascii?Q?B0lFsM4xyQXSNjlsoYTpnccUChK+mYXpQr4sPmJqhmIH5GwhRqwRUbhJ1tss?=
 =?us-ascii?Q?KjykbQ0T34JsmuB08sV7DCnfTiR0WwpoG1z5jD2+bVOcoBKBUiacIGcj+FZc?=
 =?us-ascii?Q?ZkppAC3gX7pyTd5iJRTyJebeUo87vwUy9GUsfA4eCqtOd0xbA246698DbuLU?=
 =?us-ascii?Q?J5v6OnWxoHfcwQ2JW0cTWaB/Y7GhJBfk8Y0W1a7mROA/o6Xjtq661vejO413?=
 =?us-ascii?Q?Ni47mgH9KuouZC4cWZYtloBzjV5/feVqbydGWzCsTKHu10NVCTpHQPEH/n77?=
 =?us-ascii?Q?Yuk56LgpPJ5Dm94fTRRhDCKgyVt8Y19zrqembqAd9K/V/nATh6VYOd/8YJ5G?=
 =?us-ascii?Q?qBmCnNn+qBh3WyhU1BmzrbeB9JX0mpLUfurq/xVthyp073NPCjvWs7I53oJQ?=
 =?us-ascii?Q?oj5PQ405hfxxNHKsHC3BbS5G6L0fvJXsj4qQRyFCedlFCU8Lz7KpNkalvlE5?=
 =?us-ascii?Q?bRNuYRO+f+5gGTAbfHKGvLIXmsKhEwGoQdXuoVlT1MO6r8nmxJ9LHrW2U7rX?=
 =?us-ascii?Q?CDpjA79LDprDp4a4wI6qiMAKKUnhMYHS4MCj0UCUdMuI6XOgtG3Mk6SwzX7w?=
 =?us-ascii?Q?70PmaOqJ+elUf5R24ZbFgSPS+H/oikNPXdJ38/MNZAWAuUeh8opnIQ09xA7d?=
 =?us-ascii?Q?m30xfkvAJdpYLwlxPXcnIjgJElW84FXW6OlmeyuzMUSCrCLmGWva7LI2XaUh?=
 =?us-ascii?Q?U+k9jcgq4EY5BQ/kRvcoV0i63IDBvX/BV00YWhKY+Nt1q0AOUik0wnJWlOjb?=
 =?us-ascii?Q?o0UCD+AJHjKPWbA4+NsW+cacWJqE10Kmqc8FGEF9OkuywF0dHILEZvPm4Ht1?=
 =?us-ascii?Q?iChaWQ6MpMCR5kVIfhzX5Vb3B8f0yuiGSXprxDfr2SjXO32RoY4L7rpyPnhT?=
 =?us-ascii?Q?WPYH4zUY0Hcs22Z5xSbh3fmewKINoJYOr0LWeUaIcReNGwZlacqbayrx8jKN?=
 =?us-ascii?Q?BOnAZL25M+c7Wb7huhPVVTDLKDjp9i6WvuvrgbKHc9qmzaWJ9Z6bnXxq45/+?=
 =?us-ascii?Q?UCkebwZc/n+WYDphvUblHpsQyD4ywWEUJ4w/2sQ5OYXL1Vj/myVs696k/U/S?=
 =?us-ascii?Q?bCqUs6x8u5p02KFBi+dtzJWOwTzHeqtO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 19:24:48.9645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc01973-af0d-4370-448f-08dcbe291859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004

From: Michael Roth <michael.roth@amd.com>

SEV, SEV-ES, and SNP have a few corner cases where there is potential
for KVM_PRE_FAULT_MEMORY to behave differently depending on when it is
issued during initial guest setup. Exercising these various paths
requires a bit more fine-grained control over when the
KVM_PRE_FAULT_MEMORY requests are issued while setting up the guests.

Since these CoCo-specific events are likely to be architecture-specific
KST helpers, take the existing generic test in pre_fault_memory_test.c
as a starting template, and then introduce an x86-specific version of
it with expanded coverage for SEV, SEV-ES, and SNP.

Since there's a reasonable chance that TDX could extend this for similar
testing of TDX, give it a "coco-" prefix rather than an SEV-specific
one.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Co-developed-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/x86_64/coco_pre_fault_memory_test.c   | 314 ++++++++++++++++++
 2 files changed, 315 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 48d32c5aa3eb..65d19b277b06 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -129,6 +129,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/amx_test
 TEST_GEN_PROGS_x86_64 += x86_64/max_vcpuid_cap_test
 TEST_GEN_PROGS_x86_64 += x86_64/triple_fault_event_test
 TEST_GEN_PROGS_x86_64 += x86_64/recalc_apic_map_test
+TEST_GEN_PROGS_x86_64 += x86_64/coco_pre_fault_memory_test
 TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
diff --git a/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
new file mode 100644
index 000000000000..e16fe185fb5a
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/sizes.h>
+
+#include <test_util.h>
+#include <kvm_util.h>
+#include <processor.h>
+#include "sev.h"
+
+/* Arbitrarily chosen values */
+#define TEST_SIZE		(SZ_2M + PAGE_SIZE)
+#define TEST_NPAGES		(TEST_SIZE / PAGE_SIZE)
+#define TEST_SLOT		10
+#define TEST_GPA		0x100000000ul
+#define TEST_GVA		0x100000000ul
+
+enum prefault_snp_test_type {
+	/* Skip pre-faulting tests. */
+	NO_PREFAULT_TYPE = 0,
+	/*
+	 * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping non-private memory
+	 * before finalizing the initial guest contents (e.g. via
+	 * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
+	 *
+	 * This should result in failure since KVM explicitly disallows
+	 * KVM_PRE_FAULT_MEMORY from being issued prior to finalizing the
+	 * initial guest contents.
+	 */
+	PREFAULT_SHARED_BEFORE_FINALIZING = 0,
+	/*
+	 * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping private memory
+	 * before finalizing the initial guest contents (e.g. via
+	 * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
+	 *
+	 * This should result in failure since KVM explicitly disallows
+	 * KVM_PRE_FAULT_MEMORY from being issued prior to finalizing the
+	 * initial guest contents.
+	 */
+	PREFAULT_PRIVATE_BEFORE_FINALIZING,
+	/*
+	 * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping shared/private
+	 * memory after finalizing the initial guest contents
+	 * (e.g. via * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
+	 *
+	 * This should succeed since pre-faulting is supported for both
+	 * non-private/private memory once the guest contents are finalized.
+	 */
+	PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING
+};
+
+static void guest_code_sev(void)
+{
+	int i;
+
+	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
+
+	for (i = 0; i < TEST_NPAGES; i++) {
+		uint64_t *src = (uint64_t *)(TEST_GVA + i * PAGE_SIZE);
+		uint64_t val = *src;
+
+		/* Validate the data stored in the pages */
+		if ((i < TEST_NPAGES / 2 && val != i + 1) ||
+		    (i >= TEST_NPAGES / 2 && val != 0)) {
+			GUEST_FAIL("Inconsistent view of memory values in guest");
+		}
+	}
+
+	if (rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED) {
+		wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
+		__asm__ __volatile__("rep; vmmcall");
+		GUEST_FAIL("This should be unreachable.");
+	}
+
+	GUEST_DONE();
+}
+
+static void __pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa, u64 size,
+			       u64 left, bool expect_fail)
+{
+	struct kvm_pre_fault_memory range = {
+		.gpa = gpa,
+		.size = size,
+		.flags = 0,
+	};
+	int ret, save_errno;
+	u64 prev;
+
+	do {
+		prev = range.size;
+		ret = __vcpu_ioctl(vcpu, KVM_PRE_FAULT_MEMORY, &range);
+		save_errno = errno;
+		TEST_ASSERT((range.size < prev) ^ (ret < 0),
+			    "%sexpecting range.size to change on %s",
+			    ret < 0 ? "not " : "",
+			    ret < 0 ? "failure" : "success");
+	} while (ret >= 0 ? range.size : save_errno == EINTR);
+
+	TEST_ASSERT(expect_fail ? !(range.size == left) : (range.size == left),
+		    "[EXPECT %s] completed with %lld bytes left, expected %" PRId64,
+		    expect_fail ? "FAIL" : "PASS",
+		    range.size, left);
+
+	if (left == 0) {
+		TEST_ASSERT(expect_fail ? ret : !ret,
+			    "[EXPECT %s] KVM_PRE_FAULT_MEMORY",
+			    expect_fail ? "FAIL" : "PASS");
+	} else {
+		/*
+		 * For shared memory, no memory slot causes RET_PF_EMULATE. It
+		 * results in -ENOENT.
+		 *
+		 * For private memory, no memory slot is an error case returning
+		 * -EFAULT, but it also possible the only the GPA ranges backed
+		 *  by a slot are marked as private, in which case the noslot
+		 *  range will also result in -ENOENT.
+		 *
+		 *  So allow both errors for now, but in the future it would be
+		 *  good to distinguish between these cases to tighten up the
+		 *  error-checking.
+		 */
+		TEST_ASSERT(expect_fail ? !ret :
+			    (ret && (save_errno == EFAULT || save_errno == ENOENT)),
+			    "[EXPECT %s] KVM_PRE_FAULT_MEMORY",
+			    expect_fail ? "FAIL" : "PASS");
+	}
+}
+
+static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa,
+			     u64 size, u64 left)
+{
+	__pre_fault_memory(vcpu, gpa, size, left, false);
+}
+
+static void pre_fault_memory_negative(struct kvm_vcpu *vcpu, u64 gpa,
+				      u64 size, u64 left)
+{
+	__pre_fault_memory(vcpu, gpa, size, left, true);
+}
+
+static void pre_fault_memory_snp(struct kvm_vcpu *vcpu, struct kvm_vm *vm,
+				 bool private, enum prefault_snp_test_type p_type)
+{
+	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
+		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
+
+	snp_vm_launch_start(vm, SNP_POLICY);
+
+	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
+		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
+
+	if (private) {
+		/*
+		 * Make sure when pages are pre-faulted later after
+		 * finalization they are treated the same as a private
+		 * access by the guest so that the expected gmem
+		 * backing pages are used.
+		 */
+		vm_mem_set_private(vm, TEST_GPA, TEST_SIZE);
+		if (p_type == PREFAULT_PRIVATE_BEFORE_FINALIZING)
+			pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
+	} else {
+		if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
+			pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
+	}
+
+	snp_vm_launch_update(vm);
+
+	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
+		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
+
+	snp_vm_launch_finish(vm);
+
+	/*
+	 * After finalization, pre-faulting either private or shared
+	 * ranges should work regardless of whether the pages were
+	 * encrypted as part of setting up initial guest state.
+	 */
+	if (p_type == PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING) {
+		pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
+		pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
+		pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
+	}
+}
+
+static void pre_fault_memory_sev(unsigned long vm_type, struct kvm_vcpu *vcpu,
+				 struct kvm_vm *vm)
+{
+	uint32_t policy = (vm_type == KVM_X86_SEV_ES_VM) ? SEV_POLICY_ES : 0;
+
+	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
+	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
+	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
+
+	sev_vm_launch(vm, policy);
+
+	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
+	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
+	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
+
+	sev_vm_launch_measure(vm, alloca(256));
+
+	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
+	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
+	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
+
+	sev_vm_launch_finish(vm);
+
+	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
+	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
+	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
+}
+
+static void test_pre_fault_memory_sev(unsigned long vm_type, bool private,
+				      enum prefault_snp_test_type p_type)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	int i;
+
+	vm = vm_sev_create_with_one_vcpu(vm_type, guest_code_sev, &vcpu);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    TEST_GPA, TEST_SLOT, TEST_NPAGES,
+				    (vm_type == KVM_X86_SNP_VM) ? KVM_MEM_GUEST_MEMFD : 0);
+
+	/*
+	 * Make sure guest page table is in agreement with what pages will be
+	 * initially encrypted by the ASP.
+	 */
+	if (private)
+		vm_mem_set_protected(vm, TEST_SLOT, TEST_GPA, TEST_NPAGES);
+
+	virt_map(vm, TEST_GVA, TEST_GPA, TEST_NPAGES);
+
+	/*
+	 * Populate the pages to compare data read from the guest
+	 * Populate the first half with data and second half as all zeros.
+	 */
+	for (i = 0; i < TEST_NPAGES; i++) {
+		uint64_t *hva = addr_gva2hva(vm, TEST_GVA + i * PAGE_SIZE);
+
+		if (i < TEST_NPAGES / 2)
+			*hva = i + 1;
+		else
+			*hva = 0;
+	}
+
+	if (vm_type == KVM_X86_SNP_VM)
+		pre_fault_memory_snp(vcpu, vm, private, p_type);
+	else
+		pre_fault_memory_sev(vm_type, vcpu, vm);
+
+	vcpu_run(vcpu);
+
+	if (vm->type == KVM_X86_SEV_ES_VM || vm->type == KVM_X86_SNP_VM) {
+		TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
+			    "Wanted SYSTEM_EVENT, got %s",
+			    exit_reason_str(vcpu->run->exit_reason));
+		TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_SEV_TERM);
+		TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 1);
+		TEST_ASSERT_EQ(vcpu->run->system_event.data[0], GHCB_MSR_TERM_REQ);
+		goto out;
+	}
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("Unexpected exit: %s",
+			  exit_reason_str(vcpu->run->exit_reason));
+	}
+
+out:
+	kvm_vm_free(vm);
+}
+
+static void test_pre_fault_memory(unsigned long vm_type, bool private)
+{
+	int pt;
+
+	if (vm_type && !(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type))) {
+		pr_info("Skipping tests for vm_type 0x%lx\n", vm_type);
+		return;
+	}
+
+	switch (vm_type) {
+	case KVM_X86_SEV_VM:
+	case KVM_X86_SEV_ES_VM:
+		test_pre_fault_memory_sev(vm_type, private, NO_PREFAULT_TYPE);
+		break;
+	case KVM_X86_SNP_VM:
+		for (pt = 0; pt <= PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING; pt++)
+			test_pre_fault_memory_sev(vm_type, private, pt);
+		break;
+	default:
+		abort();
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_PRE_FAULT_MEMORY));
+
+	test_pre_fault_memory(KVM_X86_SEV_VM, false);
+	test_pre_fault_memory(KVM_X86_SEV_VM, true);
+	test_pre_fault_memory(KVM_X86_SEV_ES_VM, false);
+	test_pre_fault_memory(KVM_X86_SEV_ES_VM, true);
+	test_pre_fault_memory(KVM_X86_SNP_VM, false);
+	test_pre_fault_memory(KVM_X86_SNP_VM, true);
+
+	return 0;
+}
-- 
2.34.1


