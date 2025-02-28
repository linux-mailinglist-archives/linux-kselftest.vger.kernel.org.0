Return-Path: <linux-kselftest+bounces-27853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6FEA495A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED1918954E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1B325744D;
	Fri, 28 Feb 2025 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1jAnl7JP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BD41A254C;
	Fri, 28 Feb 2025 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735968; cv=fail; b=TGFKsB7yF9mrx7KAZLIygxB2G00mr47fvsZsXxCTXM5D6KGLnWcZ/SDx6I+9JGJUWMCiGyeBjp7JIuxcWo1VzE9P0EkRcm4imKZJTm/f92h0hhQXjiB3BJqUWnTwodoH0FJCdfK8SQ+9fYIqT/HtmuMN5tgeTk4R4sgcv5GCvEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735968; c=relaxed/simple;
	bh=0OKzUlXC6g3sJ76Gi0iBLTEuTWtq0Owg2m+pipRnxVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPQ3OakhxiL1Woxh5zIquTykD9NGNdHqcXYuqzX2elsiy8MtvGk/4UnWvCgmfuuEHm0vBMuE76mEdgJqeiyG+MXI4qqzyS/FaM6YK3MnQTx1IE1ZgOgB7h4AWuJcfD3pwUi5SCMPRuFZnaBi1/ET5owh4t4kTHhFnhNY8BKLulk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1jAnl7JP; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yvh1J5V1MHJPcBnfvZaWl/7XY6t8qVEb0lGX5BovbvGa9uQtCYNkbALUKaolpqW+5O+rumJAqXil8IgjLzlj+zGFFRae5JjI9vAWHq7rXezI9im4sl0OyD3+e1BG9ZMJjYqqjjUpAjnAxn5oJXTjCEeAiHnrv3yQDNIKRaK1RK4ZF2olXr7k+JE+pBtPVi+LqPqYeguluL6iWMrskCOlp0FZe7k53ydnFm9VsWDzB6A4kuk1SAq/sHSLDsgaJu53VZW4C6uFVfEoPqVcO3scZlWK61/oZaNycIUpWVd9Tonco4hr+RLjT/SE3T2+VxwA/YeVm8szPfV9x1yaNF5JNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SK27t4v9cX9vnEPKXypfGSzep290BNlHFpCkQCsXYJA=;
 b=k7uZsm8NFDk35xf/HaUsJZYsThu74Y5tDbOT/KCwCW8Vnqt5BGbPNCTY5ugva0xgyCfoyhWPlfhd/LHo3+RB94I3wcRIa98xO/2gNKrs3gEslrfBNVgXklYuDqq69ifzB8Ezz1w1K/nuJWOOUkWenxQgP1LHu0iu8lY9MufHJNAeCt6nH1ifcoGbyQp5RTNAVktMy3GtOmjsAwuMEHbIWZ5vc7zZcnBKPBcl6S8G70fI9h9roQLJ+ekcUrvvx2lUeS7Pa62Z6bOWKtNXtRvOyy/W3dVhRvDQckyWXif6xQU2NujdXdho3VOaHMoxj7IORzhmeS9xw4NV4DdqG1ujgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SK27t4v9cX9vnEPKXypfGSzep290BNlHFpCkQCsXYJA=;
 b=1jAnl7JPuJsI3278J4PK46XYJDtDYJ09H+yz4pkqMs1o33UloxzRXmGQvSxnvQ7+q3F4gcA8o6dF+jq81oIWqBgOZTgSfWR9gHgoEA8CfypsvfzH2t5w816OxUojodl+Qsl/BH4Px4W9Dv2JCoTF8C6jo/duIRS/ecd51N9pW6M=
Received: from CH0PR03CA0418.namprd03.prod.outlook.com (2603:10b6:610:11b::19)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 09:46:04 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:11b:cafe::43) by CH0PR03CA0418.outlook.office365.com
 (2603:10b6:610:11b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 09:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Fri, 28 Feb 2025 09:46:03 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:44:52 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 11/31] KVM: selftests: Skip vm_is_gpa_protected() call for APIC MMIO base
Date: Fri, 28 Feb 2025 15:00:04 +0530
Message-ID: <20250228093024.114983-12-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 755c202c-37de-4788-33a5-08dd57dcb77b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7YlUY17kna1PwAfyLke5HqiOyrEKCqM3jGNTRmaJJ1BpLts38RBfTNfan+Ck?=
 =?us-ascii?Q?EoEMjWxoMSLyXqPN4JEZrYniGWflYDIKz1zQ6x2ULKhol64HZ9N7cS5+itgm?=
 =?us-ascii?Q?LQt6OM/7fwkeGqKo/DO16Mu+/JLa15oTkelrHXdnP04meeag/XSsVMbPocOU?=
 =?us-ascii?Q?ZrLoi5a3GAb8a/OvQzwFHND7NUi3y2a62ToUDjP6cPBLGEjNH3CMu93rNQ/1?=
 =?us-ascii?Q?KtVUQU2688CDnqEsZvDUm1ptJkHc9/NTM1BLfry+ij6ov30yJvojhcqIpvlp?=
 =?us-ascii?Q?mFI/tCHiyRvW8AbA6KRH84/uWJ23pkdwr/oD9E30lay55ZHzNQiOsqsNIaDw?=
 =?us-ascii?Q?3Fh5VN96fCUK2+g5lmIEKv0sVVYOVSi2ZgezDLJqvqZMo1pc+RoiIZ0N+iZM?=
 =?us-ascii?Q?17RudejrbWxxiGPkXVSE5+Kk4lUBzrWQPKYY0fczGR/T6C8sx9jJIFc2ad7M?=
 =?us-ascii?Q?p6rcwvGE07Wq7cBE1RN53iTi4cdzrBP7WZiWZ8bCZ9OBqBDvGWu05fztuiey?=
 =?us-ascii?Q?nB2W7DVJOQ3azdneRTJdBDpdKOFTau0lGfR9R81Xtg52lqKNK7JLDkgD5Ubj?=
 =?us-ascii?Q?Tiv6h4N39+nnMSbXWVFnEYUmWo9fkeqQp066oHI03YuMljNhiP5kMb6zHXHu?=
 =?us-ascii?Q?+ieF+5BspsL0I5Eg1E7FUiaOMjTgc7u3C4Z4bMf0Y8FzLc0XXnTeScx7tEbk?=
 =?us-ascii?Q?V7OI6q3lj+ydCny1jl7vlYcX46kq7bKDlPzWU8/7G3sFobcuTJvjDbyechOu?=
 =?us-ascii?Q?09I95b1Km3Wutb3iDOEDV/MciDPfPue+pNX/JLCMr5onbbfF+TJETFC/JHTX?=
 =?us-ascii?Q?os5s9pVTQy5hrGsZAAOm/EW3Dmq89tcZOH3WPjxJDKTw+nYUIXRrFWPDvNVC?=
 =?us-ascii?Q?pXgcb7rWv87w0HHhNgX8TM1E4Gn4F5WvQ6JCaiaonl167sOxqb59vVWODGKz?=
 =?us-ascii?Q?HPIMIDIUFirIzt4YjUDZAshJlLwb54yEvk+VmBLe/N3SwCjOxIfpywK2MNYY?=
 =?us-ascii?Q?joQxn2v3x7xwYigoOTD4h7ZpNFKuLrRv2hqeviiOCMQNTXg2MISgrrkr1Sjc?=
 =?us-ascii?Q?WLYbntSxCxAfFmih8euWrxpkeTShufzBtopHSzOWt3wb7BMlHbBKuN3ezGKT?=
 =?us-ascii?Q?VVuokLi4H48izi8XBRgHx9LGHQk9L07dh2hSPSP9pHRCeIZ4L6nBSX7WJdCU?=
 =?us-ascii?Q?VSSHkMWKtDGhGfeSmaeg7+Ln2ZX8tzBGhJYz3zL+sxhrVnVxvvdMps0Q0n31?=
 =?us-ascii?Q?+E5AnUP+RG4DxriXVZjWjxk0aa0HSH6qSjavJNcqhb1gEFMW9egy4ci+YUh9?=
 =?us-ascii?Q?F+JZaJ1vwljXNuf9nXWnrL5sbv21f/ZJ+R3VvDg+D3V9vz2G9dAdaOGyou/V?=
 =?us-ascii?Q?wOvPqCP2Y+88qF1GuEaNLZ2E8OV6txCfqC3ADxVScnB6JMirOxIzkftt+jmJ?=
 =?us-ascii?Q?ZiUE9397eO3TSxMbefm5OZTWqRRIVpdLb1J6WAEZ4h5AjalI7dC80QUua1vT?=
 =?us-ascii?Q?cVXiGBIpybTTW+o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:46:03.8579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 755c202c-37de-4788-33a5-08dd57dcb77b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625

Skip vm_is_gpa_protected() call for APIC MMIO address in __virt_pg_map().
Without this change, the virt_pg_map() fails with below error for
APIC MMIO address.

    No vm physical memory at 0xfee00000

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 7129dfb652c4..197110ff1380 100644
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


