Return-Path: <linux-kselftest+bounces-25612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 403B5A266BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 23:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDB13A50C3
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3D3211A3E;
	Mon,  3 Feb 2025 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IIPRU8mE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A62212B09;
	Mon,  3 Feb 2025 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622032; cv=fail; b=uUXWcq2V8eU7UnkLVBVteNefwukmQVDvAZyAuNDsA7z9uDCnafQCz5afUm92jED0/kJ97KJmHmFmXxEbo6xuvq5nTlZrUMjs2am1eHICnvW5xUf6YCJcptvCFnd4DuGZndp/0Rgkfm54/2wmbUBaejpRKzG9yoGG1av3exQOCe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622032; c=relaxed/simple;
	bh=tyrSnNQj7m2pgzsnTmT60Iq30+aK0VbmX2qUnHYg0Do=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isKn8x+H1B6f5123SM0rHvXtsHU2pZ/U40xlzCf9C0XMJpA5KL5YeKOF4IU+36/qKr2HdqEcLtow4CzudNmZdzAERceleejcsjqLRaRyh8u7qovwIQPyC7mMyaJ7cgBleNDcI7CYitX5yeuUPLhOpYBbOL/jHNLYSd/+i7YaMJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IIPRU8mE; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZ7xWb6SFnYo9LUH8UfeteiYXEJuQL2NU4r/oDhs0LlTMrh6eDrz5FZphQnl1EL9+WxA5jizH3Zx3CmrId0HLlPW+eq/bLL1Xc2rV1Affla9ybjl5OBZfES5FUvSsXLkBRzV9APblfak+dh8mp8jPeozXA0278YrIsYco0NmC1vudjxakq7m5fOhfoxi6YC/MP8+oON/f6flPGdlHjKV/SruNfF3vGTu8Qqu9WqQZgZC8KvTdhyJLldFt2Ysz7ACdrf9WBrkDiDoS9P7Sk3IyZNRTJeVisNiISqfjrH1XZIGEJmFX+CC9lF7BGIVixZIkiIllZA3OQE26VFgPpL2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9F2IFI91GFTPbJm2q7dCmQ8NcfczfdPaIYq3U6eKNg=;
 b=TSoVksV3mAxjXMAWlyreYSGMYvcps/3oCARwt1ZvKa/EKc0hH6EPVC/mR/jhHfFEHf2Z8bCaSbPzJPUx5P+8abiGvHCrHEZX+C01R92YevcBk+7OIPcg4+1QiP4mHzK+6/7JdN+fg/iOxpLZnimcLHA+uiheCqi29yOkOpIXUx5TXOkTFojaqG6clewX+OxiVCzIRsKw0lGlvh9BgnYvNfiGXb+5AzCK+Qr+/2PlYeJsURBdWuP56tVDuVh/ViRPCWdwGZKXHHlnFrkwtPGgLaNFfWWgaLlcyWBhhN8GqohOfoM55HrvIf7h0Qvz3Cqr6PY7+XqcgE2orhS142xkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9F2IFI91GFTPbJm2q7dCmQ8NcfczfdPaIYq3U6eKNg=;
 b=IIPRU8mE7+xiCMch4qSU5OwiewAM1Smy6SW0E5OSS+aEPwKLT9pZCCx/XxycmpARW8tIsZ23wx/tiI0Q0j0flX3Z0rBA5sdGtiNck6jCVsmBMEw6QEWHiMtwchYG6SLOQ4r8vXffpre8gQQYYloYkuZaNEbmDGXXI8GwBRFJeCs=
Received: from SN6PR08CA0014.namprd08.prod.outlook.com (2603:10b6:805:66::27)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 22:33:49 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:805:66:cafe::99) by SN6PR08CA0014.outlook.office365.com
 (2603:10b6:805:66::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 22:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 22:33:48 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 16:33:47 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v6 7/9] KVM: selftests: Force GUEST_MEMFD flag for SNP VM type
Date: Mon, 3 Feb 2025 16:32:03 -0600
Message-ID: <20250203223205.36121-8-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203223205.36121-1-prsampat@amd.com>
References: <20250203223205.36121-1-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: d94e016b-fefd-41f1-0e6f-08dd44a2d41d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YI328HS5YJ6334dh6r9c3zQ5dUnpFIjp5quQr/xMhDB/YOuVo7127F9EGCp3?=
 =?us-ascii?Q?BW8MdXugLG/N0FdK3q04pKcLROJNNmQAXKFfyJDf+MB0a6yBIAb8q2OgZQ4l?=
 =?us-ascii?Q?ssUbF8+74bOiX++cU29bIeto2SFOlHYfW/45QBhzUSd26m7X9slojijYdFDV?=
 =?us-ascii?Q?1yikFaRxr8Jmdyex3KfB7z0BDJtp1LOql6p5yHgXX8RyuuiIY7YSxecCAe2G?=
 =?us-ascii?Q?PbsjGsJiG1Mcsxpi3DJ4gJe0009gFaTvnaSz3JvGkxDtntuKQdCYpBZ9f4Jc?=
 =?us-ascii?Q?dKAT6ZIur/iJIEd1C09XbYmdwfZs58n5lAJBddgV8gUSMQNQeciMomYdhFKO?=
 =?us-ascii?Q?SLIT7fCHguZ06AhBFyXC9pwnOyWKv0Qbze0rV556KBRnek6OVz5lvI/bX/bJ?=
 =?us-ascii?Q?0JTtUWS8JFkc0QMTvU72g70o6TjY9DM2rKkQ9oZRDE8veNWr1nMc+F4IzlEe?=
 =?us-ascii?Q?2kG7u3Usv8sqmuNynga6i8UnrndUyuM8nUIFa9Hod+9GKLw4cyBnTx8DaxVH?=
 =?us-ascii?Q?zj7ShnBRYChuVmIWICsEbOmqQcPuimGmtDSH15a4BiAgxUuPbAonMWjPDBC0?=
 =?us-ascii?Q?VJMZ3EXsunilvSRxvNf1b+6bNJqzKsl+t9Cv6meq1eM02C2LVKHlhx/UYeAW?=
 =?us-ascii?Q?sCefpySeKq/nvObnPoJQ1CwWPxR5M4xZDJoBeUGcMeonoYmZIM96Zoc0auGY?=
 =?us-ascii?Q?yQuHmyk7kXDHxbchuzgKqTxMa2sYyw5yEmnGORom/pb9RQpLpgCRFW7Xny7K?=
 =?us-ascii?Q?VayHZciABt7BbtAN32AoopUy7aLjLR3QQ3H8SfCPLrgFyYexa03Wrj2L+oab?=
 =?us-ascii?Q?ot73B0FX50d2lPUBPTopFimtKICp5BptH4lq8FmzYa0EjFzO2GmHilhTnJvA?=
 =?us-ascii?Q?AdOdbfrd8GP4UxK9oRAlVCOtDxIdqHFUYBKcHqadkUIyMEJC3PljVtRnmddd?=
 =?us-ascii?Q?53XEN37eEWNHI6X7BXcC0K+1vkV7zXwWomC3Ic5LwwesWFTyxmvvMJJXFjCr?=
 =?us-ascii?Q?+nbub6opPM6veUS4ma1afj7Mpoux7Kgn5K153Q5a2pr6VnkP7pamXnIbi1Bb?=
 =?us-ascii?Q?FFf3zURllGc7Sh5qWhAiCQUAMWPy8jJadp9Ksn/WNbihZFkRd9+no9ImKDLi?=
 =?us-ascii?Q?x2LhTtj6M2Vf0tnQqeLBjsHCV+2aEFRdwLl3vTgR4TmaYBJiuIW4uRFQMpx8?=
 =?us-ascii?Q?YNLNK9RTQdDHPLIHldBkJXKsF7m63WAMI0sdYEgST2054LSIvSg4zJkbN4vg?=
 =?us-ascii?Q?3cPJO4ziayIlOdPfwt0PyAhUIl5fbu96TvO7SJ2ZChdOqUvhzAUjSowFJng0?=
 =?us-ascii?Q?v115//szqXp6xBq84tod1MkrVsEoBWRqx1rZ4TihXoPeeBwhYzwsXg0OzECm?=
 =?us-ascii?Q?KDunnZvBoyBeZJ3r5Eam7cudlPF0qqVznKGJ4aL6XsDmiaJ85DrASlrVSJxX?=
 =?us-ascii?Q?Hf+v5M0ky8Xs/pjiKG/B3p75jJRvqXuPzOa/L6J9fuwRZOtuDL2Aig28g0F6?=
 =?us-ascii?Q?xxxKKb+1923/htc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:33:48.9761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d94e016b-fefd-41f1-0e6f-08dd44a2d41d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750

Force the SEV-SNP VM type to set the KVM_MEM_GUEST_MEMFD flag for the
creation of private memslots.

Tested-by: Srikanth Aithal <sraithal@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v5..v6:

* Collected tags from Srikanth.
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


