Return-Path: <linux-kselftest+bounces-25051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68215A1AC5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 23:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CB01883514
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FD11D63D1;
	Thu, 23 Jan 2025 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iaIzYPLh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CC21CDA3F;
	Thu, 23 Jan 2025 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669755; cv=fail; b=pfruno/29i5O729BWLyCdAQYyY24AHh2DCYunK6BVb0fM2Xw4g4FUosG4S15/z1tVR7LGS3PMKPLyT8NGexR7gArwymn577ADlr/FL/SYGCvTOvv+eJFDy1eURlyS8axdZ5jPau7hJCFbJIoWeS81MtNKfq19omb1UYKIZn0ILg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669755; c=relaxed/simple;
	bh=8Zm+saQvm3iQHWzwa0AFasdrYzPnqdivK+SQZq6xe0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPCUMzuZtAo6Bcwtk4/HHGxRrF9F4XhTqYGwGW0TEoDYsuPpsbtn6lIFiIPEN4c3j1lyIjGwCLaV7ZiZPeg2EO6I6Th3EF2OyMRUcoxdv6Hdl41TZ2+pBYcEAotPYSb7umeQDAqO3lzJPRjXxNUgVUkESEw8dexAU9aKOK1NFfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iaIzYPLh; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ42MVJVy+WGj89pEkX3BZ8HPtXL0OaB+IjRI1rMNylBKUKoFCpQiW4RK7JIyJtwoepV326GPEC89AitBypO0F34a0W+Oj1wMUwvx2oqFFHoJtF0GEtxlg9Mik9fSfyYrWz6tM3ezi74Yf4z/mYbWD8GxLg3DFec1SdyQTjHU8Bz6Tp/xgTGhNIbap54t0KxT/lzxyk1hTAq6DEKx1idMLQ1MHqQ8B5iFEBmnkc/6XO/Pk6uFc3pF76msS76Pf400dT0bvuSqUgOrW09dvjJrzwJ0ToQ0nf472z/xXBH30H/3+H2mcYCf9HK5/D/CLse4e3XSKLc9426mJbXs7NFig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hECz9pFVz/suIaR60vbxBLgnenR1cmtTB1A+tesJQlg=;
 b=d3SRCBFurSbO8ZFa1lJvswpvE0+YUU1DkoRAowS8o4L59v+ACm52+SYZFN2J40DQs0lVpGsU+cph+dwAAPV3NhlNMJp4mTqtIEKvSx5iE0sbzDw7Qic6cfIfzVF7HfAvgk7V++N6o2gnzUWopY1nHzsSQnHw7q2B6aXEOkZdd4bih51U6Dw0wwd9vTBot3a6Jd6GSAmPGq9pTFcxaeBRFqsun/mcQ4Usyodkzo/4Xg1Lxi1OYa9vAKqnmu/grePhq3exzKkvfvfIBoIEUdY/gO0eRXzOsiKtUvyBrQhVwa8XGaPoFeqeJiTWhat55So0kFmUv3jHZCDQxE2AJc8+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hECz9pFVz/suIaR60vbxBLgnenR1cmtTB1A+tesJQlg=;
 b=iaIzYPLhnzjptFgPv2nARL1rMwO8xSvC2KF1ik8PfiQwDoYkjt2vadxrmIFe7Mk3KzTj+PUAAsCJNO0Nxcr5WWvoCr4pc9w6NIQt1Q25fhshnxPKrJT9/p3owE59OWAvIZp5GeJvw4xTtfhDbwktH+pKZzB2+yS+pND2i0Cu6yY=
Received: from SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::34)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Thu, 23 Jan
 2025 22:02:29 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::86) by SJ0P220CA0003.outlook.office365.com
 (2603:10b6:a03:41b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Thu,
 23 Jan 2025 22:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 22:02:27 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 16:02:26 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
	<sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v5 7/9] KVM: selftests: Force GUEST_MEMFD flag for SNP VM type
Date: Thu, 23 Jan 2025 16:00:58 -0600
Message-ID: <20250123220100.339867-8-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123220100.339867-1-prsampat@amd.com>
References: <20250123220100.339867-1-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5722aa-6355-4064-082d-08dd3bf9a05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MLgFTW2NG3RL10tuf9wUG3DDbdnhmf0g7YkArwZAw1FP/3/KrbdNTwsHbhlf?=
 =?us-ascii?Q?jbOyCIm7eEf2wRsAU5GkHLsVOy92kAjQ7lvl+a8WVJgb/d8sfd3Qo3I3aQmP?=
 =?us-ascii?Q?OIwkw323PvtVn/ovNFTXjdJYDwP7FZC9UMqCjhVvtshwCZca3TpT/olDcH3i?=
 =?us-ascii?Q?6WQqF/GmyYDOHkMRM/400pRCjexzfc/G59GuvLoAWbK8tGCZkcrfgmHK7cyc?=
 =?us-ascii?Q?SXLa8OoRATLFvjAjkJdpyiar0hKmXosbwuV8u4xYAIi5Od7I2C2dOCwL4i0F?=
 =?us-ascii?Q?mNEco5Zar5oxF5U/BuE3OAkO1f1bvRa4mwvVmI40TT2pKtvfTRgTclUGpe2Z?=
 =?us-ascii?Q?3qzS3GkaQiPGf9zI8avwYu11oPTF+xzXt/dtRFC1SVdpp2iE9Yhts8D/DG1X?=
 =?us-ascii?Q?wXSfNDJlvBRU+sNvslt187PLJasdEx9rP+veVMdVK2dCpnA5RVjIQnpEwCfh?=
 =?us-ascii?Q?9eW+DFmJGTrvnmKf8rj20XI69+5ts61USQaDdHiFPIRkizv2UFMcvuri8D3O?=
 =?us-ascii?Q?kh5in5MzG6gnj2Hg7gdtAEVPTEu3yV9zM62k41vsXQ3Rbi2prk2+xQFIqLMb?=
 =?us-ascii?Q?bS+uZ1sjE0zna7C+kZnr/5ilN+OnSVC6z2d7uFyJuXKEROP8+n4SwW3xfeTt?=
 =?us-ascii?Q?DEb7FPfWNnXaFk4jAbJdhm7tNbehE27AApp3D0FcmMWVjE0G178WdkFot+OZ?=
 =?us-ascii?Q?VMY2PJ3hZUGv5mED4U14kGkt9qYOHV3HCkpEGYPdcD3aQW3Pq/asp4nXCisN?=
 =?us-ascii?Q?EGwkLJV6HsUe66PDhK7TN46foQfBCsL9FdpcQe9sY0XHRYH9rqepgqmfAA2l?=
 =?us-ascii?Q?d/EqGyDTcm/vGNGtOfiafLeww9q/ay6F0jRGB4eFtJpYE61cPFthERRUH9f4?=
 =?us-ascii?Q?IBIEilRdkqCEirg83huRAdcSPa4PH+lsLHPoMMbAh7oSS5aTm3Xsig/Mhpc7?=
 =?us-ascii?Q?vEfavfyeRDlG6Y9F70S5TECvdFXmUbF7CdcYilYOgA5njGpOTuZp81SxPTJ4?=
 =?us-ascii?Q?jwXUcUcWlF1rf2I/6ekAScvlHTeS4rZMRLrDdWYMltaLl1kVsx2X5K2l0V2z?=
 =?us-ascii?Q?bOTiLuk7bYDujTnrfN4OLx3NrB3m6B5abYFNnZHQObA2BjGelpG3X/KSaBM1?=
 =?us-ascii?Q?qRWgq/xSa0WT2C7JG2UKnRONATZfwXjmviJ2Dc1YnjI42oesTtSmbY2yj+fm?=
 =?us-ascii?Q?SmxwtzdpSvhHMopLNMancb6ECbJUmY4XhkuWAH6ylVjAcBmlKI0A0PdeIN6C?=
 =?us-ascii?Q?JZDmlAfrSWz9FQrBAGT/FwisBzmiJp24yyG64xBfOYB6h7dDID9HQy1SpgOw?=
 =?us-ascii?Q?3WJAUF3EAgrQd1w85xRFWtgOGT0HmPluvPZzJk8eDLP+MtBTHu9wYs8XcHyn?=
 =?us-ascii?Q?Hi6E3pxs6Jkx7xUJrryHrO+g0QIU/r0CzmWnP3i8KACL/LGWoO3VkUZrOThV?=
 =?us-ascii?Q?EVq8VvrnYdeN+XU/xr1GJFsSjX/l+xbDi7OUMsb2BEk4b73RfJNkZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:02:27.7975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5722aa-6355-4064-082d-08dd3bf9a05b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186

Force the SEV-SNP VM type to set the KVM_MEM_GUEST_MEMFD flag for the
creation of private memslots.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 33fefeb3ca44..089488e2eaf6 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -413,14 +413,17 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 						 nr_extra_pages);
 	struct userspace_mem_region *slot0;
 	struct kvm_vm *vm;
-	int i;
+	int i, flags = 0;
 
 	pr_debug("%s: mode='%s' type='%d', pages='%ld'\n", __func__,
 		 vm_guest_mode_string(shape.mode), shape.type, nr_pages);
 
 	vm = ____vm_create(shape);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, 0);
+	if (shape.type == KVM_X86_SNP_VM)
+		flags |=  KVM_MEM_GUEST_MEMFD;
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
 	for (i = 0; i < NR_MEM_REGIONS; i++)
 		vm->memslots[i] = 0;
 
-- 
2.43.0


