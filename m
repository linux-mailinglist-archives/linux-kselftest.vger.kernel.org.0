Return-Path: <linux-kselftest+bounces-17232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7045E96D929
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A99528CE85
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9462219D8A2;
	Thu,  5 Sep 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z+AjESgN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933EC19D89E;
	Thu,  5 Sep 2024 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540185; cv=fail; b=TQmXtXVPvpGolDwoMZBqik0HwjxLih1V87Cw7Z4NZQHTo+chGpbJxn/AX0hPVVFlmJyue21UmiOcXDOqxl06WCvx9tcYdKfps3omhmIgjmAZjusWr8QhzLnHUeeqad+ZSH9J+o4it38JJ7b6oKYpvAH8gLZNVj7bN61fV7Lynlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540185; c=relaxed/simple;
	bh=0rZPkZx30jAyRkEDzMpbVO7FsjkprAEIi00IGIH24cE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9n/UvNsJ2KuHlBDR2eP6AJCMhFQd/CoF6ZtZnB4ac5ok8WZVLK/bKQc3YCzyRlke++DBsIv8sPKzVVu5WY31eZpqpzZiZr3uCttCzJdj2pNQC6x6n4Q2FVn+r5XO5IE7hTC5bjlS3axO/gdpTRLk0bqSTaymzrrwFwn9CnRJQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z+AjESgN; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bih+6GKOXUcuu59TdWgR2eU+NhetfDIALJyvCLcHu+2KwYQeg6kora71mYKUdQd0TgDOavEmWQ6OgQZao1a3U2OJ1T5/TD7gIXHUokCiGLcBc9Ix4K4dqLqmWBAUFtWlvtZd8PD2XozdsEArXuV7nT49zcSzdwpBUw+74pYbh2pfXnFIHkmTbto7Rjo6G2UfqKC58Ah/xwjz6ZhCB2BdakaRPlxnfW2tpNlgaeo8pPDxYmGxVPuSSWvlIaz2WItt0Klzu8dJ0M3PzxHWLp+AeJPpTT08dgqFl1GmITn7ZGlY1EQF4C4iCOuiIuN5V8Ar8+IqnmEt/sCD7/+ghWSCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOzKCQfh92zoz0vcEXQeFj8+WcbH+82YnlNWafnVLGs=;
 b=LuvwBG0zXmnu7CoBjniLbAX35d506XjoyrpnsQyT2DRl6qFVjzGg0+Ea7t0ttd0atp1sOc7MA1VRCEHdJpTYScrrCGTdjHtPeZLoSj+rQAKISS4iry29iKiKn3Se1PGoI5UehINHrRy7z+VPSvU2+iSQ1lWw5c2mMzmb5KGigWGbrSEEg3iQGzOpewTHWUzDh+Y+VTPDMmYwusF6dJxDAhzwgLSLQqLqslQnly3MhwXH3s6q/vdaynbSJHKNI5vGDhthUee6msVfQwpiGcUSlTeG/uMOIECbWROPi7cIT1toXDpv3SY++s8ORzRjfz8tjQSvJduySBowM240zzk90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOzKCQfh92zoz0vcEXQeFj8+WcbH+82YnlNWafnVLGs=;
 b=Z+AjESgNfZQQU61rT1ei3EjZ3ikBsPfVQ7s2y0m8Izsw6V2XlY6oDEKX1syEkOdf/v1BFTqVyBF1ABiCVMiTZx8WUMAvNfoN6PTsVlw7hA4DRKcUrFp8++JKBQnbdjtHJgfni1FElRwkIVT9NrxJwl2t8jL+Srmgh91eKIzcmwE=
Received: from BY5PR17CA0030.namprd17.prod.outlook.com (2603:10b6:a03:1b8::43)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 12:42:58 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::68) by BY5PR17CA0030.outlook.office365.com
 (2603:10b6:a03:1b8::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 12:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 12:42:58 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 07:42:56 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 8/9] KVM: selftests: Add a CoCo-specific test for KVM_PRE_FAULT_MEMORY
Date: Thu, 5 Sep 2024 07:41:06 -0500
Message-ID: <20240905124107.6954-9-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: c0bfe983-c9db-4890-e064-08dccda84597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dpCOl8zcns5kKhm6Swx8nMZCyEJOZ0BB7XiLKYIbhbXyZWVHXbnW5QSeARTv?=
 =?us-ascii?Q?LlVGIB0zNwFjv8NFJXHh82rZ95IopRi7Y7XZ3V6HHBFjAYdTtc9PeGLj+sNw?=
 =?us-ascii?Q?QmypTCGs/aFMPJi65awgMNh3mNLhWysosr+wmlaVSFuRDDUUaCMPL0fLfthh?=
 =?us-ascii?Q?ALGFYsy1V1pXIj4XLy7IJ73D7xSVhrpOyXKlWPZla/tDRcVrZiqLQtjqVYEh?=
 =?us-ascii?Q?8XRGOYMVZcgnkW5X7m/bicI0uwD+NWaWOnVnvxh+Ow6y2QRTarF3h/fI2Byd?=
 =?us-ascii?Q?xR0PX4KLyXjuNdiHGHoleh4zespHcfb46NU6/qxDQgQ4WO+hEskbr2sRHFTp?=
 =?us-ascii?Q?eXw9F3ziJhJ+eJXyXIiRdDEvI07h6YdRNiLOgEBvGD5ZPyBtKwT8ctOqEHmV?=
 =?us-ascii?Q?uTI03R1savAq5FKpfUsiBDVk9JSLfOqKnjjAz2F7n0seZNlbdD3mTNclP53n?=
 =?us-ascii?Q?1JBHDFXcFdWA6XHS+2yDuYBk0h8AdNERkdyJLzE0nCie1o6A5np2mL7i00pI?=
 =?us-ascii?Q?+5wjR+dlitklGVy+c/TSEcFspUSG0e9rYQt18Prai4tGBhHol6iq8Y+Rq75p?=
 =?us-ascii?Q?EWnTgLf877jf41N6W/lDdnon6+dTcN2Re8NJucBPQ0kQEy+so4lN8FtCADly?=
 =?us-ascii?Q?SjD+xACfl32+Atbhk/866LCXhXmFHalpD0cWHI3yzfvY/ZCSqazJT9dftN+c?=
 =?us-ascii?Q?IJKa46VLp5ReX+THRYvBbjEL6HxviidBInuvNjgAnx4Zu1HNxf+A+vxi4LU7?=
 =?us-ascii?Q?NtUewCHk3cgiDkjkJL+cnqC3PTz2I4clVW5JSSmE3/YXc0otW4A9bTYUovmv?=
 =?us-ascii?Q?H6KgX+7p+XIRSkugoSLmvCbT+r727PQT35lQ29Y23fM8v8xBk7Zy0YBSsprY?=
 =?us-ascii?Q?ctS3bvHlf34m/8y/mMtb3i72g1xBiGgBAlW03/eNEJlofkmegTqsyZvecLW9?=
 =?us-ascii?Q?4uBgMKuZD1Foeg6SoOk5I17T8LSfwjxgEsnKt34KCddApdG+5hrrtAUJpCeq?=
 =?us-ascii?Q?WxzBL+FonDZFrXyNU+lA+FApBE82RWVCRxsc7bY0C3c6acr2KIVHB/KmhxfA?=
 =?us-ascii?Q?jIMUm+0SWr+0Dr/5FcCCfGis4mrmocC8/Yg+H1oxdgbq6EtHA8O0n5dPRFeh?=
 =?us-ascii?Q?LFEAEH3aR6wSR9S8eBGlEIovimjydG/1fOUsqAHCNwaEE1VVHTbPKtLFx2Cw?=
 =?us-ascii?Q?iVLXLcpMabjrA35kDM8esS5WRLeChWqe3BvMG+fFq50GIRGgej058CCUNXqP?=
 =?us-ascii?Q?43C3/qnmq3wPWZzZk2Iw6Yl4kbck+uICT3ddwjXbweWLk7PSnmfzxhn2ZZeb?=
 =?us-ascii?Q?tIplz+l+N0+afCbVQ28FVLGMdVFrP+2qlXZxIJZYic3b9IhrbN1OR0DGFS94?=
 =?us-ascii?Q?MiLuA6D2eCK7dB1za6N8OgAaikk20HoHcaEHhe6X5wWRmyzFBb0y2bF1IpUq?=
 =?us-ascii?Q?9ESaFt20GvkDeO3jg6+8iDF8zdmlq1DD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:42:58.3986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bfe983-c9db-4890-e064-08dccda84597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259

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
Tested-by: Peter Gonda <pgonda@google.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/x86_64/coco_pre_fault_memory_test.c   | 314 ++++++++++++++++++
 2 files changed, 315 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 45cb70c048bb..7b97750a7d71 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -129,6 +129,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/amx_test
 TEST_GEN_PROGS_x86_64 += x86_64/max_vcpuid_cap_test
 TEST_GEN_PROGS_x86_64 += x86_64/triple_fault_event_test
 TEST_GEN_PROGS_x86_64 += x86_64/recalc_apic_map_test
+TEST_GEN_PROGS_x86_64 += x86_64/coco_pre_fault_memory_test
 TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
 TEST_GEN_PROGS_x86_64 += coalesced_io_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
diff --git a/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
new file mode 100644
index 000000000000..c31a5f9e18f4
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
+	NO_PREFAULT_TYPE,
+	/*
+	 * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping non-private memory
+	 * before finalizing the initial guest contents (e.g. via
+	 * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
+	 *
+	 * This should result in failure since KVM explicitly disallows
+	 * KVM_PRE_FAULT_MEMORY from being issued prior to finalizing the
+	 * initial guest contents.
+	 */
+	PREFAULT_SHARED_BEFORE_FINALIZING,
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
+		 * -EFAULT. However, it is also possible that only the GPA
+		 *  ranges backed by a slot are marked as private, in which case
+		 *  the noslot range will also result in -ENOENT.
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
+	 * Populate the pages to compare data consistency in the guest
+	 * Fill the first half with data and second half with zeros
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


