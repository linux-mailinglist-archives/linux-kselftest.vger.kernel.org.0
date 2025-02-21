Return-Path: <linux-kselftest+bounces-27234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4682A401B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050B81899155
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F42254B07;
	Fri, 21 Feb 2025 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1C2guFdL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B76B253F14;
	Fri, 21 Feb 2025 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171871; cv=fail; b=Rc2u+pwuin4EyBvYxVYn1DPR2Hhn9M9k41cjfzz+7/FO8xHZe1gziNap1SHTCnhwmbG/o9IoPtEEbG+M0H0F+YiTbrNK8izLTRQ/3ICtVMKbnqtltmTs6DVJb/LgxhDwjGdaOOWZe50VUwfeu9t+iExe9FtlhCdy/FND1xy90Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171871; c=relaxed/simple;
	bh=INfJ+NpqjohDYPuUctzRqsQAlgadvTgj3uFqA6uE7vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTmet9/VSEif9Zw00JDT+G46hNIqCoYkZfyZNF9iNrDznzErvQxQQ3Pd/EVp3VKCGnvnxqxdgomFk3/zGZiLr5WeUdVHJpkM7XG8+MyYRqu3v7FQrNB/4Jy0WyFTs/9i/N09K6ny+gvjmTQ27FKTHyVWyBnE7OSkJWIOXc0wuMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1C2guFdL; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sb1MMAfdN8bKc91/35sNqCABWHqUEGqJ3Ls/xfH3GMVhek+lFdZWs7Rbkvrl56J4IWlpvQQ18Z/gqet8wIq4PysUgj3ToKc1bM27f5kqgjYgKb5I6jYxE9nnEr5id7e9Su5tCDaGsnkEsCrl+5mzdvvAuIdfHfkNKv+m/JdGJhaNKrLRUXIjtP5uHfE5IZ0aFi8wk8Lj07Ej6Xnebv5+nlp/HUqHN2etm6c9oxy0aJ16TvUiQmL1hazxh9burYyFlny3V6vC/Tc7ljTIaOzArdkfYt9i/M5WXXXrYonvWfUzTlAELNtRcE3+77DxtxtWwTHMZRnDdkH8QirZ3k7y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiO9BGjFVpR0LTrV70ejb3AIlQnTSzdi1RH6Hru1I4Q=;
 b=X+JVJtPMHMOOQbYU0MaoKZA+KrLSLmI9ykIIyGmqvY9g0NGrm5+ecFH19pyeILwgyufkclFAVJkLkoNU9QsESooEHlcJVPD0U07GBPquCj57SSalzRKye7lpCM4EFSoy70w/0kn1us4/gsjXTX+wW0nQ7pzB8DSpdlqQXV5KatrAj6DLQI896M6PlwSV3/OZzAv2q7vEg9QhL0TBE6MMg4aUlTV59fuv1suuU9bWmkSUEnE9whNWyTGRy+CHWV759erYiPT3sLYcpGTjNx+p7dPzyWRZKMkcsy4VW3ANcUI1t5PlGHwjT5+oT4cT0IXABIhwzbAM5eVaGidtbuf/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiO9BGjFVpR0LTrV70ejb3AIlQnTSzdi1RH6Hru1I4Q=;
 b=1C2guFdLMcHOneDBb5HhflI90GFrDSbIr+WmfNWD7uLMh+ySAV/tG96/9p4Pce6cAhdWxmfJuFk+JnzZ6odC4wZ8UTYRnarD6XDyvubHvPMYHH9wIX31UQ1LQ0wFw6pehtiqIc71b9FfNEkwfKaxtwcUU4HEOXm3GA4JqRW2UIs=
Received: from BN9PR03CA0179.namprd03.prod.outlook.com (2603:10b6:408:f4::34)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 21:04:26 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::5a) by BN9PR03CA0179.outlook.office365.com
 (2603:10b6:408:f4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 21:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 21:04:26 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 15:04:20 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v7 10/10] KVM: selftests: Add a basic SEV-SNP smoke test
Date: Fri, 21 Feb 2025 15:02:00 -0600
Message-ID: <20250221210200.244405-11-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221210200.244405-1-prsampat@amd.com>
References: <20250221210200.244405-1-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7be86d-2b31-44a9-2917-08dd52bb5329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w6+QIEBXmlwZCkF11mcLPU1/W3KizEITbYlMaYB0wPM99kBsetfbHis3xe84?=
 =?us-ascii?Q?3rBgCcXEi8H6KB8LEhdlKdz58EQGe5wPSgqMOmKekH9bQs58KY0dSUCwTYH4?=
 =?us-ascii?Q?w8u3UtN2DElz5nPM+jQAqozJ6H7uegapzMYuh3yXPSiqmRYdXDPDvxyfd315?=
 =?us-ascii?Q?v05ongdfhlZqSzwKZPwBwRTNoP/0J4vom3QCXqYaejkLHioplAGyzqQoePdU?=
 =?us-ascii?Q?E14DCMp9es8vKwGGgxl29FmYFOiUCDmnSKAOWmGGmJBvIQbA4M8tfC4LGdtx?=
 =?us-ascii?Q?t1P7FkwhfpF2EAv9QazdorkxWIG/Y7FwFjzm+4BJeG1e7SDROXDBCOFMRiHf?=
 =?us-ascii?Q?xhmHjWN/MSS9gGAQNhCVsEHvk83qb1kq+2dBVInUiuYECf9M/GhPaaF3FapQ?=
 =?us-ascii?Q?F3+Z0kPYGj3nU+9XzfWzd/hSXy3xHbisflNIn4Rx97wyOfZPbk3jLx+KhH54?=
 =?us-ascii?Q?jGBKB19LCtNeJq0YxLMeRpEB5pnW1ezB5oli78CeOh5A47qI7MEGaqkQkq71?=
 =?us-ascii?Q?qDHQaXitkxqvOkdJvTI+4uI/nLie6aras3Sn+uJ4tpIihORFsjEEU0eQY18r?=
 =?us-ascii?Q?xe5p7cOsYlIaQEQBPyGjqORspPwG0bOYI+KqA+BZ6CAs04X2PsEtNu26Jj8s?=
 =?us-ascii?Q?/wdzsLGu+cpFOFU4l6B/Mj67rCwNvQVWS1JHnje+ohTt1AZwVdrnXq6swUpw?=
 =?us-ascii?Q?BuK5fGFuPUBGP/gHA+1Sifm9EKgKg/0zoSJKgBV25iLY2FaYWCNEZaZgmMsL?=
 =?us-ascii?Q?L2gRcRelhT6XNWyMnVexDd7NTrriazJdXs1egAwbkp4buoS7xMwlE55/ReaM?=
 =?us-ascii?Q?9ZfPhf/HjeaCjakujuW/O8YRbYfCCMx2DNBx5UFmmpuiNDG2J+Y1K5GVjiof?=
 =?us-ascii?Q?Psp5Q4h48s63WlrLcH63H1ckaAaaQpX3vPh/Q7KxKOjqgnH2DX7c9pXM84bv?=
 =?us-ascii?Q?lFcY1oog86qRdFfK0uzNKn8wYlJNTPVETMOaFljxVpZpHi9hJOWzJPemhUzV?=
 =?us-ascii?Q?469j/XRpyuc5o5oN/9xHf2q64BY0zAyiF5/cgxgRB5isvT2PXc48kGj3VFey?=
 =?us-ascii?Q?TsRxTpSLCMu1s4UiZ37OcibV+9OX3iU5K8rlAjoFC0YpFGUkU4SxOvQk9DWE?=
 =?us-ascii?Q?0YOx9aO9rYSJzXPGqtflWsVSwmmOsbY+52E3JohbQ7cuy4W58Y3kipUGmRzW?=
 =?us-ascii?Q?fbUIMCc7PKXjELci6rnWVgz69biod2Q/1LPx1FC87UyUWXXF4oodv1Kot4zi?=
 =?us-ascii?Q?VodJQjeBx6AAlJawG3Psiwn0lFZON7Zf+4D35nX6vXSOtiI7Hb3qFFcq/huo?=
 =?us-ascii?Q?lNKK0pc1zNcnAhBMU3HhIiX/d4I97KXY6+v7ufXD0yjHaowOUv3roIVgIFYm?=
 =?us-ascii?Q?X51OP1gwqp8V+pOXoaH8b0Q3bR5NEum7xgd1Qj2l7mbu7FhZ+zVVeau2CYF3?=
 =?us-ascii?Q?/rR2tHQpI0/TCoNjuLX66wkhjQKSAOQ6p1akdbQWTjx1YIJN1/BJ9lp9Pjcl?=
 =?us-ascii?Q?HmU55eeOrPcnSJE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:04:26.3265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7be86d-2b31-44a9-2917-08dd52bb5329
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106

Extend sev_smoke_test to also run a minimal SEV-SNP smoke test that
initializes and sets up private memory regions required to run a simple
SEV-SNP guest.

Similar to its SEV-ES smoke test counterpart, this also does not
support GHCB and ucall yet and uses the GHCB MSR protocol to trigger an
exit of the type KVM_EXIT_SYSTEM_EVENT.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v6..v7:

* Remove FW version checks for SNP (Sean)
* Include testing for policy flag SNP_POLICY_DBG
* Rework test in accordance with the last deduplication cleanup of
  main()
---
 .../selftests/kvm/x86/sev_smoke_test.c        | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 620aa7c41f7a..0505cde77358 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -16,6 +16,18 @@
 
 #define XFEATURE_MASK_X87_AVX (XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM)
 
+static void guest_snp_code(void)
+{
+	uint64_t sev_msr = rdmsr(MSR_AMD64_SEV);
+
+	GUEST_ASSERT(sev_msr & MSR_AMD64_SEV_ENABLED);
+	GUEST_ASSERT(sev_msr & MSR_AMD64_SEV_ES_ENABLED);
+	GUEST_ASSERT(sev_msr & MSR_AMD64_SEV_SNP_ENABLED);
+
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
+	vmgexit();
+}
+
 static void guest_sev_es_code(void)
 {
 	/* TODO: Check CPUID after GHCB-based hypercall support is added. */
@@ -179,7 +191,10 @@ static void test_sev_smoke(void *guest, uint32_t type, uint64_t policy)
 {
 	const u64 xf_mask = XFEATURE_MASK_X87_AVX;
 
-	test_sev(guest, type, policy | SEV_POLICY_NO_DBG);
+	if (type == KVM_X86_SNP_VM)
+		test_sev(guest, type, policy | SNP_POLICY_DBG);
+	else
+		test_sev(guest, type, policy | SEV_POLICY_NO_DBG);
 	test_sev(guest, type, policy);
 
 	if (type == KVM_X86_SEV_VM)
@@ -190,7 +205,10 @@ static void test_sev_smoke(void *guest, uint32_t type, uint64_t policy)
 	if (kvm_has_cap(KVM_CAP_XCRS) &&
 	    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask) {
 		test_sync_vmsa(type, policy);
-		test_sync_vmsa(type, policy | SEV_POLICY_NO_DBG);
+		if (type == KVM_X86_SNP_VM)
+			test_sync_vmsa(type, policy | SNP_POLICY_DBG);
+		else
+			test_sync_vmsa(type, policy | SEV_POLICY_NO_DBG);
 	}
 }
 
@@ -203,5 +221,8 @@ int main(int argc, char *argv[])
 	if (kvm_cpu_has(X86_FEATURE_SEV_ES))
 		test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
 
+	if (kvm_cpu_has(X86_FEATURE_SEV_SNP))
+		test_sev_smoke(guest_snp_code, KVM_X86_SNP_VM, snp_default_policy());
+
 	return 0;
 }
-- 
2.43.0


