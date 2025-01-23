Return-Path: <linux-kselftest+bounces-25048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C78A1AC50
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 23:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3EB188D2CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F2E1CEEA0;
	Thu, 23 Jan 2025 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OqQ91mu8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE81CAA91;
	Thu, 23 Jan 2025 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669719; cv=fail; b=FLwXVQnNBQiXgVECVH7O40tsxcrRfRipzLW8+ksN1onTv+FdprgWhSKWcILO81agNitqA/44j2cLI3SGavpgMt5cryU34w5r7d/uAAbti2G+KV9JLIEp1gQ9hkGgBtsAePeFjA0j+nol4aby+1lWA4w4hSIbWYb10syLUoC2Z9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669719; c=relaxed/simple;
	bh=iJyRkZuGIdOsuOJh9PkDvFSKVOfbePPf+3pz8N6YMls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd9N420DhCHn6JwFP2ppRONyC58ZTM1aLTLDfl3+isr9ahoQ3NAiU/WISUoKVnSp+GoMh58m+hufDWmUbD/l1pLBZWMe2iIN/c+rJ8lQAzUKCAMmOjlfGJk0hqekwXo4O7YJeZhe3T4ezL9dPXwn4Q019e6xocft42HpDhqKrb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OqQ91mu8; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0qpGSUSjxOCk9MKNJmp6TE9HMdp6ZPh8XR1ddJ6MpltSCGv84+i5FfCe5YO8Nicck5mXqygbVcwQsyBaOwBUYVZ9Q605d1T4LUaWP0mwaNCYjAj28spiEjcG5mS4aIkyDGRy5C+412IJyUwGiyziqQ6gWooMNoDFA85tCfTRQnCPWGtEfaJ7ym1P3aWLwOZO/gC2xTCwhsa1vch74/nwcewrK0b++/Ryl7qvjvV9c0CKZGgM5Rbx7Gf0qzkvXau9R6GaIdh6sNiurjdQHeUDoraYfw01Mk2iT42XgcBp99BwaAlUC0zuYCADCA+GpIbmwi7qwMb/RXnLeVoE18AYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie0kCcGEqRklTROQfzy8+NkelMifHCrXpjcSSus4nME=;
 b=svkpOfhoyd2PdKzVw5m6htRImkXS+gBgpyBKdEfDu53wEuvkViIOWpr0pdc2wkGnRuw77wVxQsc7A60U8C7YfWSCx8GKzaLIW5OPUm8DYMN/mMFDEK2ioCh5PkgPKln17MpZ6qkp/dYpVEMQ0pBzGXkEF1vpZ/mccs4ZquriQxmTKiFFIVu4tyvYPXN/yb5AOU2N49EWqUorhUlzgd6qWg/ET3CligSV57RVIHMB31z2a2gJ/nzAEkBEhm9hOQt5loxmYe9GE+i6mXIgCq2BX0kDUkdsMfAAqFoYDyTqil4cI/7Pvr92/6ThkeRXPcYBaepBg6ZZY8hE/2AeqCZlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie0kCcGEqRklTROQfzy8+NkelMifHCrXpjcSSus4nME=;
 b=OqQ91mu8apzxkdXDLUEVmUAwg0fMW7a0Zem0zg3iu1fy8cj6tcF8oq9tva1cBhWCITP0d3UhK8WzEmdZQ0YnsCn8aeak1MgHybJ/9NaBYF8Wo7ZvpIciz9A44jXYJlX1CeP7XzEbZ9WB3i7TC4iCYb/qd6u58DhMcfbhaunU/58=
Received: from BYAPR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:e0::41)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 22:01:54 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::2b) by BYAPR05CA0100.outlook.office365.com
 (2603:10b6:a03:e0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.18 via Frontend Transport; Thu,
 23 Jan 2025 22:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 22:01:53 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 16:01:52 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
	<sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v5 4/9] KVM: selftests: Add VMGEXIT helper
Date: Thu, 23 Jan 2025 16:00:55 -0600
Message-ID: <20250123220100.339867-5-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ea9010-1a49-49ce-03ae-08dd3bf98c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EW1OpYmmQJqnqn3CYA9+KfMEEUX9/Fo5TgR0IlNFlQLJbBpgq9C8guMuhrdU?=
 =?us-ascii?Q?/qrJvXQwNR5mPboDuVvel2tbs7eZtQn9ZCqdLcrFtMwu+EVARHV7rQsJCTw1?=
 =?us-ascii?Q?dkIPvRWdH7+WmqgNrHm215RCOAV/zDh/FMxNnt0xO26JYu71Z8N2fU9YhnT5?=
 =?us-ascii?Q?D5u1y4QZ7AT/arcNt8g27UA8L+RQnvrHC2ToSZ987M83nI4HJHWmh4BNv22g?=
 =?us-ascii?Q?6flFDjCnyJISWAl6IyUCRH3PbI48rr2hDyr28Ym9cTiYr3dn2S/z+0a4AcJ9?=
 =?us-ascii?Q?EnDuv+wKBiMGWDNUaXJ6BJuwx/gtVBqRzDIME/3YvMJ1ELt6exqJpRC7FOFk?=
 =?us-ascii?Q?ifvulN8qq7FtYPSbazh5j5iCZ5MT6IU2LFDO6JB65uIbX4olSCdZNAuGuuAM?=
 =?us-ascii?Q?iGZZlhOX+0OvuZtyv5iJp8ZKkb1vGWuZjvAvL67lKdh5aNxQrsPJ6zRHY5y0?=
 =?us-ascii?Q?wu4Sb+j2EgLPU8y8/7Z/CErlnTYdQSdPi+cYTjL6t/g0CPpXL/mZluqlXlDh?=
 =?us-ascii?Q?hLt/rCIHH/CWTFXaG/U3QpHaePl1qmTqC9f3bwmXF38/cPUTIiNhaP3cJ9mq?=
 =?us-ascii?Q?dluuaWqkhqk04KKnmltcuvcJrJ5nWKe4cI15KcL/wqWL5FS7DaCfu1kqX+cK?=
 =?us-ascii?Q?niq2F3NOxP+4yMjPRuulFzj1HubTMVekal+2WQ9qtRXhr9PfXHvd+ZLeQNlK?=
 =?us-ascii?Q?BEtwHEz+dnqtFWDEtarRHqlDtatRfLgWRP3jZg3eVPbhVEJOiEv3z8vls5v2?=
 =?us-ascii?Q?M+YgImWqrXZNDTWoBpg+LWtoAs5WS8o6HmskHcNphnPN+hNB2GAJ7+NsPWJT?=
 =?us-ascii?Q?Pv5vpnmzJtK3ri7JQpptJpeTG8Zq32RFKNl7mRY7vY1E9xkIHeVC6QJKvLs+?=
 =?us-ascii?Q?tqWbOOtEttar7thit373fZd8feBo5oDaT/5fXqjEzT7fRgCZW26XQVQWVywv?=
 =?us-ascii?Q?+pYXJrm1cUbw0jHUbu9Sf3W+O6FStLl57foDJ2WHyP1464UcXoSUg2o/kDAX?=
 =?us-ascii?Q?MDmZet45Yy0XEs6ABQq3Qddh9B1B0P+Yt2rXaaTRkHEP5Qe8wSTzmE2gyhcJ?=
 =?us-ascii?Q?Uf1JmDVhNobhBw/XsYbPeCne8N0Ksno+6j6lbp6cG2IxGOJQyGOBnY5cyTET?=
 =?us-ascii?Q?iYWkRNyCDwsDbuOjleyLWevvYvk+1TbOmiXe7BcwlC5H6WcDmDkH5zo4OWWl?=
 =?us-ascii?Q?FKPubIPtLPAGXEHQFN3XbMeSDn6eZr4txA4LlSLP9YX2tT4l6DU8qy8uU5+n?=
 =?us-ascii?Q?dq9SYma/Sicsm4DEc6kvrKlfJe5V9ddPtMiV9+ubItqCjfCYESERlyerUbIy?=
 =?us-ascii?Q?V1r8L/vHe5QFQmserscAzMOwQTfY1BpkWFzLUNMMY+aSbDDXvZGHvJRvSDyY?=
 =?us-ascii?Q?od4aMM8PNb82y9IEpxdFBfLFAbFEhiAcS1eaeAscbYc2Gd9c99e3UBX4ll9H?=
 =?us-ascii?Q?P9DBvvv8ODVwFpGKFXVZPFfMW+XQuSvnmTmU6MN48udGGtm7naqL59ITzmQE?=
 =?us-ascii?Q?f1gib6E0Sl5qLXQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:01:53.8130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ea9010-1a49-49ce-03ae-08dd3bf98c17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185

Abstract rep vmmcall coded into the VMGEXIT helper for the sev
library.

No functional change intended.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 tools/testing/selftests/kvm/include/x86/sev.h    | 2 ++
 tools/testing/selftests/kvm/x86/sev_smoke_test.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 82c11c81a956..e7df5d0987f6 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -27,6 +27,8 @@ enum sev_guest_state {
 
 #define GHCB_MSR_TERM_REQ	0x100
 
+#define VMGEXIT()		{ __asm__ __volatile__("rep; vmmcall"); }
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index a1a688e75266..38f647fe55d2 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -27,7 +27,7 @@ static void guest_sev_es_code(void)
 	 * force "termination" to signal "done" via the GHCB MSR protocol.
 	 */
 	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
-	__asm__ __volatile__("rep; vmmcall");
+	VMGEXIT();
 }
 
 static void guest_sev_code(void)
-- 
2.43.0


