Return-Path: <linux-kselftest+bounces-42100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F963B94515
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BCF18A80AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861B730E82A;
	Tue, 23 Sep 2025 05:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EOSRkOq/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603730E825;
	Tue, 23 Sep 2025 05:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604360; cv=fail; b=WZbPbYTGhbFrkHUBWVMNZultgo2cYCsSPFgf5Xo98+ui+FylxzcUZuOxiV7IEpRWW+zbHjef2drOe+27MiK4xvieEfPX1fg0EaXmShAbaAGRin5jFtmCYVs7e6F56jD1PHfQXYjd3kPQJOkG4uEdGLStOzruAH+O5d93ZpchDCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604360; c=relaxed/simple;
	bh=3K9j2U2fXoWWSPMPg2qxN0ZFQzGlug6sFRIsPsiXdZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kG+SJM8nCSYNsFBvQtUsxXBA/EdMpCgGwgJfcPYWgHUxHN/T6/FWZZ9NetxNVHNlAZOb7T01n1PopKITDwVLtKoEmxK5OY58clsW17bDV3M0V0gJ6+wYSJp4zu/GSd5ksZT9bJkD+vSX6cZcKnyIBoGaHCFtBZ07g7zt+suAKsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EOSRkOq/; arc=fail smtp.client-ip=40.93.196.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmWn2unVuJaRoJmqAp1P/Kg7aQ4W8gExiZvgZ1ouA7MJqylp/P7U75YmUoabrm3o6/X7BWdOqg63Q/CN/YWTdX1IRzqWn490MtwfY8s+6T2jXCLRYykt8dulkdUDnQ3+HH2Ruw0q65zbhhQKOQMeGjvYt+5uBqQE6YLKI/4teHBw+ydF6FKr/r7YWUfOb48aSMQzQOsDvNsAMVxTTPkAzf6Z818MgYmylnL7ZypFOThco2yUSu6O8SBPVaoGqMpD1817E1Rfq6P5TYEXlrywsKYxsJ4r8pTvneQU2qnHK5/2GLRXpt7dHKyxXOb0AgSFvmYXGWyQuTWEX25lhNILvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rosafdskfJVmzghnjyHVOXJxS7z+dJ9hgLO4xLfN0rI=;
 b=YjvxXd76tmSiyYzKJJOqJz8PGw/MUja/TCuFUkNT+UXD8dHL+lR/K4Nn3IjK39forpJja6H4z4VEk6vggoBO+Ci0Qyn1ki1nSokgpoFfDgmGzBjX+qu0XwI2rOrDgISU9By08vJY+bM8sI+L+b9yQN+1Ipkl7kSRBsHTnh+5ONK5XryifMIPEBC9OOrwvww0veSAHC9HMrpdmhmXMZKfQXXvW3NxCQdTyeZDb8XIlm5MD19no/EoSv+P8Gh3Fe/s1C4BRAOdsl/YcGkns0+YENN5g/9mYdKM3w+teL2ekYABmjObD73DKUDDjVoYu/dauz8FXxZGye1H9NxOsdTFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rosafdskfJVmzghnjyHVOXJxS7z+dJ9hgLO4xLfN0rI=;
 b=EOSRkOq/zQecpGFTSNayCtGrAX6n6M0cetkfPnwb/1zWAzRHLdwQFSzAorVyvEy93lpKsBfow05kgdupkh65YYK76YXhc2sq9DvBZJcBipP5e0Yw/IJzXeL94jKAedgmUkOQ2+zABjVTiEjDgmRfnDmNcJbXFc5DKSi3GbYIifA=
Received: from CH2PR07CA0039.namprd07.prod.outlook.com (2603:10b6:610:5b::13)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 23 Sep
 2025 05:12:35 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::1a) by CH2PR07CA0039.outlook.office365.com
 (2603:10b6:610:5b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:12:35 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:12:29 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 09/35] KVM: selftests: Add #VC exception handler with error code support
Date: Tue, 23 Sep 2025 10:39:16 +0530
Message-ID: <20250923050942.206116-10-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed430c0-5fed-4679-594b-08ddfa5fcea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lpY72coTuEcPFpc9Q5mWU7ZLDwOnGJyKYMA48Llvtut7V9e9K4JR/mzaNJcg?=
 =?us-ascii?Q?vfKW4YBLx8kdTeLI/+ocHI323T+J5cDp7tIVqEM/hnIpE2XW3yTZlBl+sjUl?=
 =?us-ascii?Q?H4FF0woyisxFYkmgzbbdZHDdWBxfKTbNe47nhf2ENJv5MwZJuZd6qvmK0vmV?=
 =?us-ascii?Q?oucAA4m/ZtJHqlDDtbtYtZLGo31Rih/wk7Havaob1auMmsLOcthTVlIP21k6?=
 =?us-ascii?Q?uYYZsLXramLIvOa+YWLkuTZRmhvxe1r+gIX72ygSCH7Td/ta1ndSVbn/pLiM?=
 =?us-ascii?Q?iJiKl6Y4VM4v2LCg3HcKDLr5fh/5ARkLSELIzrtHc4U28T9M2VeCHG9N7xNE?=
 =?us-ascii?Q?V/7sIem5Omiv5MLUXjIO6R0Av0h67Uc21M3xFt/SfUcoOcvXgMHyvgPeVfAl?=
 =?us-ascii?Q?IeITXNIddKr9NylvSRH4/plvz75lLcMyUVFji0vEHMU0frYjL6z5tEA7SnmH?=
 =?us-ascii?Q?Tl5MY7rbgtlfUq1Wfbhvf00QFieasfJHlMbmi2qA9stezp4QD4A3LapwEVxD?=
 =?us-ascii?Q?n525DF6V3NWoc0cvZLBki0UjMJ7WAei0hM6jLR/LhHTFzbFIzkiijVn/FQor?=
 =?us-ascii?Q?RRjJW/JwAT989Q3zsTWMmh3HIayF+C/a5BlfXSgKYQ6ABBAGsoL1HgD2/OtE?=
 =?us-ascii?Q?Tur0diXp9Z4iDkdNlpXL6uE3iQTUQtR/21XiLLEG7wvX0QylFy4unMVyqXL9?=
 =?us-ascii?Q?Mpb4BTVUZaIfczD5GVaee4JNe7jX3OS+K/b9GtkQ00Fz3Vphhoy8iZ6YyPfJ?=
 =?us-ascii?Q?IvjRin7gvPIgWymWdtxFz5GicX77ofXX1szTk3fgBj2d7C6AjwjpTq5T4DIb?=
 =?us-ascii?Q?cZfDB8Fji7FVU81sutvSZFDkdADDKpHLEDwhA3pP4RkoesWnoPETdB1Fcxv4?=
 =?us-ascii?Q?t/g9ScoP5fDQKyibdmEBLIb1W6XpKIc1HgNPoCjuNEu9j2zQOm2mFIN/+Ews?=
 =?us-ascii?Q?6/FtUyQ7NLqANzIj73Ho8BNeiHfRYlTuI1BmIb57PGOhboZ7erw46kzGSVJm?=
 =?us-ascii?Q?NltdHb0syhNI1pKQNP92/xjTlwzOSjut9T4RXhdwwSNj5ab0tBtENG4tLSsm?=
 =?us-ascii?Q?QXr4yqZnAN/M/NjNdTwTomK1zodIBF02E1ruOdT8FAjroIQKmbiQO8wfcDo4?=
 =?us-ascii?Q?lv+9Rb9D3XWaxt1c6K6pMIozQff2L0lDlVZqVqmwDaUT9ODNxl4wcYfgmT13?=
 =?us-ascii?Q?oN4J3mV78rQnZnF+DwulfB1NpkQECYdaz8qN8SobSDNABpYW9aIENmEA22GE?=
 =?us-ascii?Q?vm/N7+4s0N3tnW6hEIaeqM0f3uOEV1zqX4YBkq70cNkr1+cskobUarwHefng?=
 =?us-ascii?Q?4v8XBMkrKaqW8FDnoYoyaId9VLVXVXqmc12bRAPC6RWSjMOC0D5nSqZP5D5t?=
 =?us-ascii?Q?OQDTnE5RxwlR1At26VdnFRhvLDjnH6hgIty/hEdwf28AX4wYCa+zMGX7qMkU?=
 =?us-ascii?Q?tdablgH4GtWa9cU6vCkjKqCr2tsz0uUxC8/gvPwJ21ZP6Jja93caNkalZGnp?=
 =?us-ascii?Q?i28bEvdAFRJEBd9UMOSEpYizS8EMDc/BREQU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:12:35.1794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed430c0-5fed-4679-594b-08ddfa5fcea6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463

The VMM Communication Exception (#VC, vector 29) pushes an error
code onto the stack, similar to exceptions like #PF or #GP.

The generic IDT handler generation macro in the selftests incorrectly
assumed that all vectors from 18 to 255 do not have an error code. For
new tests (added in subsequent commits) which trigger #VC exception,
this incorrect assumption caused the handler to misinterpret the stack
frame and the ex_regs fields, leading to stack corruption upon IRET.

Fix this by explicitly defining a handler for vector 29 that correctly
accounts for the error code.

This allows selftests to properly catch and handle #VC exceptions, which
is a prerequisite for testing features like SEV-ES.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/lib/x86/handlers.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/handlers.S b/tools/testing/selftests/kvm/lib/x86/handlers.S
index 7629819734af..19715a58f5d2 100644
--- a/tools/testing/selftests/kvm/lib/x86/handlers.S
+++ b/tools/testing/selftests/kvm/lib/x86/handlers.S
@@ -76,6 +76,8 @@ idt_handler_code:
 	HANDLERS has_error=1 from=10 to=14
 	HANDLERS has_error=0 from=15 to=16
 	HANDLERS has_error=1 from=17 to=17
-	HANDLERS has_error=0 from=18 to=255
+	HANDLERS has_error=0 from=18 to=28
+	HANDLERS has_error=1 from=29 to=29
+	HANDLERS has_error=0 from=30 to=255
 
 .section        .note.GNU-stack, "", %progbits
-- 
2.34.1


