Return-Path: <linux-kselftest+bounces-17231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719BF96D924
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B98E284C54
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF771A42CC;
	Thu,  5 Sep 2024 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hRLblNbJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB6C19D07A;
	Thu,  5 Sep 2024 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540168; cv=fail; b=b8j2H7P2bxe3wUqqs284sam9jw1UPIG/6hohg9cKyjfYiRdh1ZqZUosoYGjZs71qAIxvEnyhgsMI13YrO6Qsa4CIolgA74YawOXMB8Ws5T3tJX4xlLmk9JVeMBf/aeS5vlz1cXPIly98pINh0875A+3M01UC7F+oSToapuxEkKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540168; c=relaxed/simple;
	bh=6Q8nFEfhg7GYe38zHJNDFOGXjmVYMg2itul2gaHO0UM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsweRJmcAtqiX2OB8Wc8v1pPBCLCRDhgaZKPciDEyHGG8yb+t+Ey+fzf6GMtnQR77WTdhLjmxRfzNqE+KwnojC00x61Nyyjep5+B1d+bTk+INsgrsGxGx6upu6BtUGX4cWDQghdgCxUcf0ObrI2Ni5uj3WzKLzM3vXyMyKMjFyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hRLblNbJ; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJxT6SB80gsMsNfwwDoAaLAFp3QdItCD9qpDlnV+zGZnmJI6uickmVCyZ7Kk04nt3qTTRpbBnDs3acM5tKJYN7ZYqsXbvd1JPAMWJVOkhCZASZUm2DFYuSp7hKBEuyHIS7cNHdIbgBAimuJ7LxAX4BM5FLu3OCcbTh64pfjhGzQIdk2Nbaveo0cMvgU9j+JhRbKqGnlBKfZr//jzKB3Unxohcy6QGCpXQPgH/uQKeHF8O79SWJGvgt/vktEmaUwsIullJK+L+iraX9lzf+d+AFAL+0RhDGv32k9i1oJHxQJ3+kaMjjgwkyXrSvc8FuY9VZG8zuHsCeghjFUVylItOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfQa0IIqqU8PfejFY7pva44xiRK02ZPRmUiIdSOkRoI=;
 b=sfjkHknEnrJQeVeR0div2EzkZYk2DVpDqQ2WneT3+yK/QB7gY9nL8FFl5wezX9EQvAZ3CH5BKXVz4/aNZnR4INjzCaSkBIwgvDKTsVGdH86URewEtjjMrHygme6lHeRz7iDPcr8+WFdrMsYlG6hXIiFTfwGGHgzRyY1rlU4uTT8tt6wN1WPfE+iJHn9qiaGY/q23z+LTILBpj/cAl7QO5gvoL/yDSfGuAVSY0tQjfrC63y+VvlJ753Rzh4vmLsG37cHpKkl5cAGK1KMRX/DGEVvXXtmgmjAvhZTsOgubrZHeEk3DtWz3+JPDYZAwJU1S8LSs6tvuvOF3YY7wurQsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfQa0IIqqU8PfejFY7pva44xiRK02ZPRmUiIdSOkRoI=;
 b=hRLblNbJ5NKwODariyDGqkd1c7fdWXowTbjTt1NWOiUg6bVskEAcabyxpVS189ONXHgAxIhNa4hzpt7wurqb7PEA4alnTfbJYLzEmd8oTbuiorh29HZSQqSEWlI2ogJehBBH5YObj+h3Kjl6dOL8Lx6lD0oCsZVlVuSOqG8g7rY=
Received: from BYAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:a02:a8::16)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 12:42:42 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::34) by BYAPR03CA0003.outlook.office365.com
 (2603:10b6:a02:a8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 12:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 12:42:41 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 07:42:39 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/9] KVM: selftests: Add interface to manually flag protected/encrypted ranges
Date: Thu, 5 Sep 2024 07:41:05 -0500
Message-ID: <20240905124107.6954-8-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 06dd68cf-ea5c-4d8b-0666-08dccda83bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bpRfCk5CyerC8JbJK4Su0v4HxszxRDmg+C1LoyAKD5RgtoPFbdao1S2QSFl4?=
 =?us-ascii?Q?1cI2nBdpPzGSVb6blLxQHhuSe8Mlm+69ayikJGOeQFLfq2gAv67ypNAjDMPy?=
 =?us-ascii?Q?Fgy0EA/NzCGpyMQuMj2NtH2elXvT+kmNH2EE+Dzihxkx5EYgXSp3XBNRHJUp?=
 =?us-ascii?Q?GOkgCWcRUWEV/UxShrb7kXAULw9hvlUSa0h4mGOFoXZfwvUe5FU4hE7WXoLu?=
 =?us-ascii?Q?UIXhqj54hwFkVvPGmYZ2JD8rzWIukxiY8aPQKgYdU3h/FpLwooK8QY7xP3ha?=
 =?us-ascii?Q?i9KMd2wOy0j7cfYlISMBmmd8Q4xXmJiAGcXSYmd9hK4tG3eFHN8tfe18Rmbz?=
 =?us-ascii?Q?Jr6HJN/ws7+0qZwvWRKr/q0N9JCFPitlfRx30wlc/P++5RbD1pKlMoOtZdNg?=
 =?us-ascii?Q?WYTWDAWtCcMPKx5SII6gKybpZNfh7fzegv30quFXYcpwFOXRjp0QlmwZH1t/?=
 =?us-ascii?Q?D7IzgRq6aipFn2t9p1NIPtajV13PIctKcDKDUujUehfBbBwOXLE0RbxpU41l?=
 =?us-ascii?Q?DqfmEGdHoCMJGWu1+kuWyRSpeD3TTSY1mHXJ7uLlh33DAzpr4nqsSPn7f43E?=
 =?us-ascii?Q?J9EQdHvBvwTgik4/Ek611HPtMrbBRdvKWK16RUTRV7BAntGdtAiPGS1HDK3e?=
 =?us-ascii?Q?fMWtrnD9BG+zPcbI3OEq3X0yPaEqdzi0Ze/8rVFaDGVH6kGBkefGJMNvvOEN?=
 =?us-ascii?Q?Pdzf4M4QwVr95KzQfRrORQ1hySFu9nITfYcbqChGjLz1NUQG4kT4I+OfnwGx?=
 =?us-ascii?Q?pT4kq41ef4XF47+6IoY0nOrrZxre6l1YDrM84nCLMI5j23VoJ43k3B/UmgED?=
 =?us-ascii?Q?+XK0e4I4ew6ohDwaYFuC0FUdK4xnSWmVnWHzipaJ+KYbjUdqRoypI5yirmd4?=
 =?us-ascii?Q?SHHgVeM2TNJVtX+EyHNcJLLIEw4pDEMG7idjP7TjNmyKlrdA4vhxhKvTdBsH?=
 =?us-ascii?Q?1Pcvo6ZsFBBjv0SmPKBfvgh/cQOZ1dp3YZqVVhX6DBMXZEIEii8syAVmyVpy?=
 =?us-ascii?Q?+kuj3Cg1HdGjpERV1I/RChdYcfLkhRzs/LwrzTQa+25DHvOUYkWfEIQQEWUc?=
 =?us-ascii?Q?nwUu9WCtebu8VC9W1auw8wAh9BrH00drTuqvebOlJKl3C+/Aae/EGVcCCs34?=
 =?us-ascii?Q?9ygGL+FW2nNLD1LshU8+gyCgiM6Cof98tf5jn/pqLmzf3jvTphhFmDKhxfla?=
 =?us-ascii?Q?8EnhisKOtcaDjnB7ZnvycnqZH0XhyEN3YGEOvixI5/JI7WBGkULPaIXhq5I+?=
 =?us-ascii?Q?I7GrLIZO9AtU7l5wSNkm/oRyCGUmLVV6R+TBHhWNLOWUp2FjX6Yw+EOz/k2p?=
 =?us-ascii?Q?8CrZMVmUxiVEULUPuwL7FuuCfoLA1ZMZKEZPBN2Qxs41HElj36aktPWDxel/?=
 =?us-ascii?Q?qq6d6Tb4zjEfhY4xvKCbk1H5M19xZuckgIeGksAYcnnwIodFVsNTwj0IcYeN?=
 =?us-ascii?Q?B2dkvZhG0QubBR+HPyrEA8k15q4oAZQ2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:42:41.8205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dd68cf-ea5c-4d8b-0666-08dccda83bbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443

From: Michael Roth <michael.roth@amd.com>

For SEV and SNP, currently __vm_phy_pages_alloc() handles setting the
region->protected_phy_pages bitmap to mark that the region needs to be
encrypted/measured into the initial guest state prior to
finalizing/starting the guest. It also marks what GPAs need to be mapped
as encrypted in the initial guest page table.

This works when using virtual/physical allocators to manage memory, but
if the test manages allocations/mapping directly then an alternative is
needed to set region->protected_phy_pages directly. Add an interface to
handle that.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
Tested-by: Peter Gonda <pgonda@google.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 45 +++++++++++++++++--
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index ab213708b551..642740fe1c59 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -394,6 +394,8 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
 }
 
+void vm_mem_set_protected(struct kvm_vm *vm, uint32_t memslot,
+			  vm_paddr_t paddr, size_t num);
 
 static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
 				      uint64_t size)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index bbf90ad224da..d44a37aebcec 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1991,6 +1991,43 @@ const char *exit_reason_str(unsigned int exit_reason)
 	return "Unknown";
 }
 
+/*
+ * Set what guest GFNs need to be encrypted prior to finalizing a CoCo VM.
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   memslot - Memory region to allocate page from
+ *   paddr - Start of physical address to mark as encrypted
+ *   num - number of pages
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Generally __vm_phy_pages_alloc() will handle this automatically, but
+ * for cases where the test handles managing the physical allocation and
+ * mapping directly this interface should be used to mark physical pages
+ * that are intended to be encrypted as part of the initial guest state.
+ * This will also affect whether virt_map()/virt_pg_map() will map the
+ * page as encrypted or not in the initial guest page table.
+ *
+ * If the initial guest state has already been finalized, then setting
+ * it as encrypted will essentially be a noop since nothing more can be
+ * encrypted into the initial guest state at that point.
+ */
+void vm_mem_set_protected(struct kvm_vm *vm, uint32_t memslot,
+			  vm_paddr_t paddr, size_t num)
+{
+	struct userspace_mem_region *region;
+	sparsebit_idx_t pg, base;
+
+	base = paddr >> vm->page_shift;
+	region = memslot2region(vm, memslot);
+
+	for (pg = base; pg < base + num; ++pg)
+		sparsebit_set(region->protected_phy_pages, pg);
+}
+
 /*
  * Physical Contiguous Page Allocator
  *
@@ -2048,11 +2085,11 @@ vm_paddr_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 		abort();
 	}
 
-	for (pg = base; pg < base + num; ++pg) {
+	for (pg = base; pg < base + num; ++pg)
 		sparsebit_clear(region->unused_phy_pages, pg);
-		if (protected)
-			sparsebit_set(region->protected_phy_pages, pg);
-	}
+
+	if (protected)
+		vm_mem_set_protected(vm, memslot, base << vm->page_shift, num);
 
 	return base * vm->page_size;
 }
-- 
2.34.1


