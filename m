Return-Path: <linux-kselftest+bounces-42099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC2DB94524
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B3A7AEE84
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9841F30DD25;
	Tue, 23 Sep 2025 05:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B807+3xk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0781E272E5A;
	Tue, 23 Sep 2025 05:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604344; cv=fail; b=osl7BpDQgMJsCjzyX4y36dcGn60AchKqPrYPhxASlYGkEOqxd8hVYlJsuM6cHbQFwHJrgqgEJt/ACxuvkzJQvPVxmb4YvTn7216qM5RpkxvKwMW/b3v3WzxLfKR4Pt5zzVjBjwj9edhLZhyhtPF8G5JFbrbu6oHC2kD2BLzZ7FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604344; c=relaxed/simple;
	bh=cfuya4EEi8oI/+WmrtyAfsC/M5zrCHYRzoDI5e1mt3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFGOPI92zsTIVoeZmuJMfMSFBA5nzuQJWV778U7pz65LRWFNIRpabScVFHVt4innH83Kqp0LNeBwrdFlQZR9/FQf9Pe564qDqrrVGDjhRyCM0NnuuJy4lGPkDxJBXDIA1SWJVzsDv9pb+Hhm/ECSBtnbAsdQ8wM4XW3GrlkOql4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B807+3xk; arc=fail smtp.client-ip=52.101.56.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbBI6OmwAogLAXdY+vUalWIFFFtlpXtyR9RLA2EeIrn/ywwrEquta6vqXLG8u3esjE4qsQzia1YWHjewsdTVCUMc6pT9roS373egWAUKPxZDs4oCPrmecTseNIMgvMhdDM0dY22Bctfu3TfmpioQE49uwY8aTiJTUW+pqJml44rbJg0slf8DBwiCjzjr4ZcSMrWHzcMtYSqkwWLVEFWjHyhvqmM6Atd3PtY0EsmNJFQnjfVFA+5Kzr4FJgPi8Uo/h0YIyNDF//lN+o9wMlBLYwhE5tDQ2looJdimUhyY9pNuXuOyBn25f6NQL6eVv3tsMm+rnyEicOR/Q90omhVNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFCNr+EEcIiPrzgteF56PKu8ebDoTXVm0HeVyhc45WI=;
 b=HXZThhJWl2vLLbox7J5Y7nHy0P52nnBFxUGIhKPs+01gpM5XXcVELdGnR4x1Yh//txk9vSjbzPnup/DvGiP9X/E461QkSCTWUTNP5G7mM3XBjM+H8fGjOrdqx/CZ2uf4lEN4ueUrqVxIps7MRJlP3epI521uiI8zFa8jFEKQQ1wqU0wNF/qSCaJIb73FC6CLS9GdwsmWNuql/Eaj2oWHJDurDTZPY4dXmqfnY1lW+zz4nS0x2Pc7kqaZhZYpskkMjNKOBSO/UXMchdunNoqmg/YGdmeBI6ssiQ71Dhuf72pS4LAcl/Sk/A1cmrDfovEbZerPtaMW2NQP55WnmRu4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFCNr+EEcIiPrzgteF56PKu8ebDoTXVm0HeVyhc45WI=;
 b=B807+3xkocDrywRhDVX/PUKi8CyvUgLAbdp2CoM8zhNkyXlblWE5kLK+lQSrqnqOyuJjgSzZfFm5ajtk65USSN2/jOhB6qtKhpA8pEguDIcQFrt36XNcFEfiBERCUkVJtkJvBwp1ijmRYbUQdKYUWuXPxtbI2Qibfag7dfDgQuo=
Received: from CH0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:610:32::18)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:12:18 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::e5) by CH0PR07CA0013.outlook.office365.com
 (2603:10b6:610:32::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:12:18 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:12:11 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 08/35] KVM: selftests: Align GHCB entry struct to page size
Date: Tue, 23 Sep 2025 10:39:15 +0530
Message-ID: <20250923050942.206116-9-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: 8964688f-635c-4a30-de22-08ddfa5fc4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QQ3TFZMelSAXI7Zjmly7DhnaMXmytJPELfbSJTubLagZ1pVPyG5hLrUTyavf?=
 =?us-ascii?Q?cflWRIsmV+KPWtLVCu06roOGp4ubkPArCqEbJUxVDgMEPPJ5UppwAjqLPlio?=
 =?us-ascii?Q?Fk3kZZfW2GErqmAGAMEKGcbqwEqLU3vVY9rKFOVcuF9I5z6NvUbhPm1Xo6ZU?=
 =?us-ascii?Q?k+27Y4eHlXrlyG4fUwPTzqjEFWo8djDgRcYmbw9NklvVxdgFB+XkPZkQmD0t?=
 =?us-ascii?Q?rvN4HikfWAfESK3QJ+9CKynVBev1Jw5gYpwrlvxHZWOB7PlQ6GgWpUfWtS/P?=
 =?us-ascii?Q?jnBRwVRXd6gfcfbC6BdqfJQbVeLmCf0ivuOogMMj255EzSwafIYpZMn+7Q//?=
 =?us-ascii?Q?misKBT1C4J7yv/okCQ28fD0HbLS/jgs+Z6OdMEqtUKu3rmjrJmR4y2Ul2/du?=
 =?us-ascii?Q?xkiqssShg+j0lmAO+oAAT69Iq5k3p4db35234hE1kZ+CcfISn8xN4JO0Ifq3?=
 =?us-ascii?Q?E7oeezaQvNBL4koOFc2AqDDqMrKfBCI3anjAT5smy1fTYTviS9SRLDHtm0RT?=
 =?us-ascii?Q?FOZ2YtJ97ENqzoBjnrfZogM8/P7i/qPuRSEtzLaY/3sP53zXjQpFyPZnyE0z?=
 =?us-ascii?Q?M5bQY7U6vFtjcfWUJqwC5gr05vNDBb8fQuDlsYKQJWN0xds035Zl5So24tPL?=
 =?us-ascii?Q?m7TEz4FIab2qPtjyclTwuvECLSJ1n/dNuEiqHgI+TsAlJi6FUMe9PoDGCsyM?=
 =?us-ascii?Q?rEGIQbsu0GlJnd1Bw6eHYli5UC5UWrekHEPwF2saDxGwn/XXeZITGeJZ5Zhy?=
 =?us-ascii?Q?jpjy4MHPfB4Of7c0Wg8wd1rhatlg9FVjF7TWTBw0BzwsRom+HPU79jxLjIrB?=
 =?us-ascii?Q?BHDcMO+OFMwlN7a+ytM7a/KnmToOY3NOWaW2xdzB3tWodgE4IVzDjdwZ6n9G?=
 =?us-ascii?Q?wR1zehcFSBAiqv3//KNv6ED2yqhpiwVzBT3mVMbP7CQl2YaLy+ohCKHg1R1f?=
 =?us-ascii?Q?pOetRjQqQBm9FxZ6hg5LDAzQSMlPCE13eufZWtz6A7Qy98HL7RDt62n4P0cX?=
 =?us-ascii?Q?PXSh0vb0yHGj3z+rEv76gwdPzJFmOuIGhKjfWpWXBws6YoEniJ9511VD2pV4?=
 =?us-ascii?Q?m+h1dES6dvfH32WXdbkSjujMFVGSSnbdijGBE1fG9oUMCq/XRYf6AhWgMCAy?=
 =?us-ascii?Q?hNTHqk8D5gtbHqHht2rfIkFvyYYBU5Aid/gUf/eZV+NPscdzOIfdSV4vP2oP?=
 =?us-ascii?Q?Ifa55McivXCPJmaC0LIKLUpoiYNd157WS3C25m6GzzW6yI04KQ7vtd5MRCfY?=
 =?us-ascii?Q?7kNsAvX0joQjJ+k5AhShyoTQW9TormoczybtDJ/U5d/EcRO5M5GQHFwKqDZy?=
 =?us-ascii?Q?+7ykj8WVSHKKL7ouLFrKUQJr40P+3VYWy3MgBYWWZrF76AntaEIFbZFBaIcD?=
 =?us-ascii?Q?nssret6LewZv8Y6bs6H4tx1l/x3tUxfQLecdjOdmb/6/bFPishQscjC17hJ9?=
 =?us-ascii?Q?gDne4GI6nxolt19IaZJ32VC4EN18iuz83TMT80mYq/hS9AEqtwlnGjjP6KFm?=
 =?us-ascii?Q?Y74v3mD+1i6rS/gq/82rt/Di+EwU5pv2rL2g?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:12:18.4307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8964688f-635c-4a30-de22-08ddfa5fc4aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357

The SEV GHCB specification defines two methods for a guest to register
its GHCB page with the hypervisor: an MSR-based protocol and a GPA-based
protocol. The hypervisor (KVM) distinguishes between them by inspecting
the value written to the MSR_AMD64_SEV_ES_GHCB MSR. If the value has its
lower 12 bits as zero, it is treated as a page-aligned Guest Physical
Address (GPA). Otherwise, it is interpreted as a command for the
MSR-based protocol.

The selftest's ghcb_entry struct is not explicitly page-aligned. When
the test guest attemptd to register the GHCB by writing its unaligned
GPA to the MSR, KVM would incorrectly interpret the request as a
malformed MSR-based command instead of a GPA registration. This caused
GHCB initialization to fail.

Fix this by aligning the ghcb_entry struct definition to PAGE_SIZE.
This forces the structure to be page-aligned, ensuring its GPA has
zero in the lower 12 bits and allowing KVM to correctly recognize
it as a GPA registration request.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/lib/x86/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 3090a6518066..edefba7f49ce 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -22,7 +22,7 @@ struct ghcb_entry {
 
 	/* Host virtual address of this struct. */
 	struct ghcb_entry *hva;
-};
+} __aligned(PAGE_SIZE);
 
 struct ghcb_header {
 	struct ghcb_entry ghcbs[KVM_MAX_VCPUS];
-- 
2.34.1


