Return-Path: <linux-kselftest+bounces-42102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B126B94521
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691E218A823D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951CD30E0D8;
	Tue, 23 Sep 2025 05:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oUjODJDZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE3030DECF;
	Tue, 23 Sep 2025 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604401; cv=fail; b=WEfh3QwTsH487LRj4I7SQmVtpEf4m2k5ffjywt7SamiOgF225upo9kbGj7U+QY+IMRwU6JLbmcpXHbAr18NPYNOJTjoVfPxVf//WHTyCsUTfVaPj7BH6oiK6tkCT3K3Ont1HWFQ6rtVocTOKFcbjpxg8oDf8jRvrHqoJLHjsiM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604401; c=relaxed/simple;
	bh=aTtUfQLQy1OZ1nnXtpx5RvRYh/Q2CZvVsTPcNsnOoks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqEMvsxRAA/DoZyUV3kQqWrhFwQ5rUkdKds+xrBOA6GVMBFvTLIHOjjoCSst5tRrwxyxhWtBl8fJ9k5ERhjr3z/ZL/cLAdtatyFbD0VO6t5/go6ZH8RXKZrMTSp5C+qIa0b8nS4Fyqv4NxmU36L034croKYDY5ycPTDBotZp9KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oUjODJDZ; arc=fail smtp.client-ip=40.107.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3NvvleDsu6voAYJPVbFoOFM7JZoinnF0hQd0F7tOmbl4XSjc9KFN6SljS9dx2nFB8z0fiNiLTwBUM6I/ZlywwujDzn7DWVYD0Pd7tMblvr9MYHf0uuZDWP2JUHN3vCECtjieE957mOsXuySMJbTAufbpjT/8kd8P9CRmoJMb1fbN5cFAgrT+tRly3cMRwCo5erWig2aCj3g5s5hww10b//mg0JeqL8Hv1f4MoPSbSWsavgvbxveJOoxS7LGETsMqtBd1vdTUvvNGNiHf9xANNwx4EqfPss1P57X/ZxglVFdtfzHlcNqHCHR5+jWTlaapk+Az4BSEkBh95+McXJlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3quAgaIovj0XoMvkwqAjZDXRQC/N2Q6DX4p0HVQoTQ=;
 b=y5+WiNUWI19oqf5D+DBwQrA8DGhinQPlSUrc2dSrBhoJ/KAMVZfcKra1UKP+ijVBugbPCiKvPkjGAxvxeBwbNZrpbRnrWwALASbnLcvHyN+LL8rwhyjykfWpsA1SnLL7wuzVCKvsIEh6vOE5fmy7Ef0mWPvPb12lsObd3ffjuCobS/sDUNkGrw3Qn2fwr4MCq6hFXvFFlXVGXdMbSdHcV3EQGoOrEwsx6gWa40ijiMRvAOS0CgpHl+h8bFIykpXeI7NQJeHqjCDMWiMJywA5A9vNKUo4bYMUkb0UQDI2TsowBNxYHhAKrUZfoDdDAstzF0uVmwiuB33DKP++9P27qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3quAgaIovj0XoMvkwqAjZDXRQC/N2Q6DX4p0HVQoTQ=;
 b=oUjODJDZU+EQF946YGlZrs26Xvj6tkEYj20aZkQ36drtnXOaQHata2hGdN6IE5NnCN5qaaI68rXnNjbNDAantLCPF6rFcDuwdK0daby5ethivKFcyLWrQbnPDJRFxEBzO3x/jrawlUrBk0LUN6FXplR2lQ0C7NmM2IQ/v30fGIA=
Received: from CH2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:610:50::20)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 05:13:13 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::d9) by CH2PR16CA0010.outlook.office365.com
 (2603:10b6:610:50::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:13:13 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:13:05 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 11/35] KVM: selftests: Skip guest memory checks for APIC MMIO mapping
Date: Tue, 23 Sep 2025 10:39:18 +0530
Message-ID: <20250923050942.206116-12-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed27ce2-9d92-43ce-9fe3-08ddfa5fe55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rsYgwFlTRjYjAH37lieT4EKxpWLd5I5j/KmvMDRcp9JyvduwttM2LkAY6Q3H?=
 =?us-ascii?Q?ojtW243gGTzShe7exRwEgSWWt++TK0cPIQ6hfS/OB1Uaz7rykP0faO3owJhH?=
 =?us-ascii?Q?goO6wiZvUnW4S1gj88MqipkAm34qSIdBSvpfe4bcnnbxJzCqAYB97E9ipUdw?=
 =?us-ascii?Q?NSwKRNGMgn/aFBNbzX/Sz7xGiHBAHiKQo5d2jCTQbgb+VjD2GFihZxK0Ck9S?=
 =?us-ascii?Q?he9QF18EUHvr6qeRWejuEZMwrX52gMChbo+HNglOJwmVx1o9VtuE+cSqqm+R?=
 =?us-ascii?Q?kjanloS78LoWLckq8q45Q9ayk/iW0s2jpg/tVbx5O6qLJ/8+G2bgB+cBvEH2?=
 =?us-ascii?Q?hses4sBWQqlRQri1JhZTN2H1iu0LKHA9iPu2D+gy95ps9Ee1peaEYeo6p26C?=
 =?us-ascii?Q?LqkxqstfZg1WiOVKVkdXl94gop6ZPP93NduVRn0dZz9Pc9QZfAOFJTN322Pv?=
 =?us-ascii?Q?vRaw2wyTUmYGEQPyFX33uw7SJGk+c3jQtTsc05sZ2v56bGjwyAzBArYR5PBw?=
 =?us-ascii?Q?Wr7g/GYC//WU3iFhCwmpUumHd46UMyuo4H6VF6ixtoeLDV/otvZyCjGiDNF0?=
 =?us-ascii?Q?RkYCplNtepMr2zkKSB335fHXZX1G5Te7hNZWs/wePlK16Vvyif9JnFjJtrhw?=
 =?us-ascii?Q?5OUgHaEBEOC97kBSMvjyqc69qyfcuDo0qCXmfyDCLKoUE0CuuhBjUlvMIE2H?=
 =?us-ascii?Q?oSarhDhm4GlUjB1ROAgyW1rlLftz38ebz2ULDuuIENLN0m9M4/mq3lI21BKf?=
 =?us-ascii?Q?mWV5Dbq/iLh+E5d91Hql/0tGyFC39K8qhpo13VzKaHQUvMkGYD2MSnVhqkHh?=
 =?us-ascii?Q?lMDXhkgrwGq6+YOonIo++6g+/JZPADuYcV3fFRFG5+TZ5yILzmWQy9w3GnIx?=
 =?us-ascii?Q?hnFcUa5XTIlUW+Qrtk8TgCKrewrBDu718KZ7M5fEMvKz05Ic67tjzP1nmCZk?=
 =?us-ascii?Q?Nryi+kSdYPxiRp6KQKJmo/ydTU6KAgACkleW7u8gV2zVWJ/6WXK8T3hAUvO/?=
 =?us-ascii?Q?S3ue1iWe+s16Sa1nUNsQWYbicEXkdVsoLdDmH12E/2xY7elLcLqPJM7ndmPb?=
 =?us-ascii?Q?xOtv3OJcIxCbJv9z2pypYAd6TZ7X02I1RyiRMr0SJ0Vj/kxZkLeU+EWhNdFT?=
 =?us-ascii?Q?yD8SukmYjcEGiE3PdwOLCXb1/ziC0pya9ZdMvK6GYWOb7rZ19JzNvD3C+0oP?=
 =?us-ascii?Q?/mqyk2WutvU7OjVATOUzv2KxWBh5MXsIieSaUR///PYvwJfeIaVIKJqTMy8J?=
 =?us-ascii?Q?W2RR4lvRVMhWbx/BdS3H88fFtow1SegAeh8PPeqkGF4VFzfYuesZqO+EpHmM?=
 =?us-ascii?Q?jtRrc7vdoFxAvk580uaevisBLx0PuKp9Tg2SKXD5IH6QqqcFcoKf1FaJfF8L?=
 =?us-ascii?Q?OQANoc+ZFBdUYS2fmxeal8Hcmvd6vP4gKxGH6vhs0DyW+59AbeRiLTYs8aNm?=
 =?us-ascii?Q?D/lq2hEbRsWmiq0tObiXArjwNTctDkCrg/+pWR1G5Ica2TB5ZJp5PNqtDhm1?=
 =?us-ascii?Q?svfAuvHpPgVCbM7MH1O6BD4TsnAXRgE57RBm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:13:13.2903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed27ce2-9d92-43ce-9fe3-08ddfa5fe55d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879

The __virt_pg_map() helper function, used to build guest page tables,
calls vm_is_gpa_protected() to determine the correct memory protection
attributes for a given Guest Physical Address (GPA). This check works
by looking up the GPA in the VM's defined physical memory regions.

This approach fails when mapping the local APIC's base address
(0xfee00000), as this is a Memory-Mapped I/O (MMIO) region, not part of
the guest's RAM. Consequently, the lookup fails, and virt_pg_map()
aborts with the error: "No vm physical memory at 0xfee00000".

Fix this by introducing a special case for the APIC base address. When
the physical address being mapped is APIC_DEFAULT_GPA, bypass the
vm_is_gpa_protected() call. Since the APIC MMIO region is always
treated as shared, explicitly set the shared bit in its Page Table Entry
(PTE) and return immediately.

This allows selftests to correctly map the APIC MMIO region, which is
necessary for tests involving protected guests.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index d72eb96efb7c..181f1943c4be 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -8,6 +8,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "sev.h"
+#include "apic.h"
 
 #ifndef NUM_INTERRUPTS
 #define NUM_INTERRUPTS 256
@@ -227,6 +228,11 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
 		    "PTE already present for 4k page at vaddr: 0x%lx", vaddr);
 	*pte = PTE_PRESENT_MASK | PTE_WRITABLE_MASK | (paddr & PHYSICAL_PAGE_MASK);
 
+	if (paddr == APIC_DEFAULT_GPA) {
+		*pte |= vm->arch.s_bit;
+		return;
+	}
+
 	/*
 	 * Neither SEV nor TDX supports shared page tables, so only the final
 	 * leaf PTE needs manually set the C/S-bit.
-- 
2.34.1


