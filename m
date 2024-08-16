Return-Path: <linux-kselftest+bounces-15559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A3595515D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 21:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0175CB243F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AB81C4631;
	Fri, 16 Aug 2024 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yzPCPMb2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6944B1C4602;
	Fri, 16 Aug 2024 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836239; cv=fail; b=btz45YIo3ubr9Hc+yagG0Uu2IpARuHQPVLVxSUtZ0UR/fOEhhNhq5Z9DajsUn5OTKn3p4G8lL7GAPUOLaUXLlAAkgFMSOpZcQtBaUCm5GeoXQKoOi60H5eul9gKtcpncZbAvY7egcrSYuhGZIWfAoi/Nb8gsQnBMfhwuq6M+hiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836239; c=relaxed/simple;
	bh=AX+2EMoa/HLDbMgYoCjGl9+ZiPBGRwWGjjf19h1rcMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzzrWhAFn/iuIS1Mk8RtNxTZ1ljJpJsGWOb2EnNTaKrd8Dw8N9JT4uhj+MHTdsFlif9MbeKmDL/3gf3dHmhe4CC0MTZXWhcogz94AgbsIUzQ1MaZxEUg8aeEdqkqgPaoqbzkfHj0UXPK3r8SAVDt4oBjYuaFtUgSsFf6iSN/TW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yzPCPMb2; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pb1YTI887VBw3j5DVbg/QJiO23psgqzV5u6EHYlSRRvXhAH0UFvTXi6jBjD+/Fkf0Kmht7jdVsOD9xIYfPUaVvQw1PiIA6XH2X0CxDpRyDm6jIPpeXKkEqnlX0yq+ebVUJLpodGfHvXPr/ePqs3/KBU8lF6w7KJEnhuzXt+nBYvSkKa45AX9zQiIvHoB7jbT5xRlpr810Og3WDFpRsXPWueA0x06Qg3lNxZiNnRFnJmdDQ7miNwdMSAzx0yVrTlLM1jss0T0/uUtrs7WwtIT39aPE15t9qTNJVWDBKYSF9IZUltGScWWSTgplNWhqwuLbSYe1Cv0ZRyGCjUqUp81PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdYFkl2xVGNKLXDOwrZh2ldVl6wuOpVobuY1t9dVTvQ=;
 b=FFQ7bP5M1lWV/lylFcK/uGyk6iPGqA1HaNrZHmQ/B1jrJIVXfkS77I3VRhyeWOYvp261x1No+j8cJFtTvLUP/e3swEsy26qgYTqWQ3W4PhNv3iq32gpwFQopYOhaftR7wDfkQh6hrPG5TMzk+YQ4ZWCQhkK32LNGt5hsfQIRzVVqaZtE8C9sx0mcrOlRFdevP0rhLJXjcU/8EjS7+fqu3gX9/nRqEs1xKZQMG1KDxrwC440cUm27l4KFK7PSRj8ejsaMbSbnHEKhxIYiUG55WDpZbq4F3b1qwRxZ/OmnflzEJWYwFbI+7AWDhtspOo86xhxp8kgr4mNe/KBZrCJD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdYFkl2xVGNKLXDOwrZh2ldVl6wuOpVobuY1t9dVTvQ=;
 b=yzPCPMb29vCiUoMU9GgYriqHfmsiHqj0jfzedVhNmK+8r9rsV7tWruVDKkE71ZnQeD0fvOXgX+JqdCQ4SFLXOtG3ytWCl/5WBfTpU7mkm5IlUX2Sm1dpG33ayYxym9umZjx7wGYpDR0ebYi8GC8jnlEe3l42dhaNf8TsHCuMg6c=
Received: from MW4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:303:8f::19)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 19:23:54 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::61) by MW4PR03CA0014.outlook.office365.com
 (2603:10b6:303:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 19:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 19:23:54 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 14:23:53 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/9] KVM: selftests: Add SNP to shutdown testing
Date: Fri, 16 Aug 2024 14:23:04 -0500
Message-ID: <20240816192310.117456-4-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
References: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd64a3e-4a0f-42e1-9f29-08dcbe28f7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HNZBwdMsAR8Vb6Pmu87EjyUFiDeAPdwECj8BgP2KZke6NyeOKq4e9r7WceBv?=
 =?us-ascii?Q?Ud7abtOrb2I3LLsWBWjop4bSwWxrZJygRtnLlQNVxjQbATCB9x/eHQssmvaW?=
 =?us-ascii?Q?Imcbi8FWH4Tmp2A60eJxDGIwRLux/vgIxGexqXNFGzAJhtaIWMMS5q/JVT2f?=
 =?us-ascii?Q?J26p0Oi72hd4Oot7GUZNfc9iD5+VmxulRwBD7rK5vL3xygXutxjw2FHrKuLO?=
 =?us-ascii?Q?BX8BQwPdMl45o87//IalKtB4K8DqeBTpPDHU+Wv70UUrdd0ZV6QwmTTweYaW?=
 =?us-ascii?Q?MpOpmCnX6he1udNxok2XxC+06GK/MIXps8lR/umyapiY3dbgLwo1P7LEtBjT?=
 =?us-ascii?Q?PpfoyUmpREU9AgK0sE6GkMutAzrgDv8PlAaYF6tIub+XXRQzT03uAR+5WjM8?=
 =?us-ascii?Q?Kgu3ZQxfI3RoG/s8fvTXVJRVqoMloEoznMlBLvVbTl8CmwjtLo0dB5bd8lav?=
 =?us-ascii?Q?a2aL0uCG+rDObNpvh52wmqT9WUx3xPjAkDux+S/cTCi57+s9HHIjfsgs7MFl?=
 =?us-ascii?Q?vMIrE2k5m2pGkwnquB5LeGJxWJ/iVxMhO1T4y0eom0SzIWWe1WwyeLi13OOQ?=
 =?us-ascii?Q?BNlijH0EUF8azSEED9wr7bsSQ7INiQerFjmpaGb5mTAPsmbffnckW40fUsn4?=
 =?us-ascii?Q?iVaXv3pUQlH5dulGiCmhViXtx7X/wH55um3bpPuQQTefKvG1woX+uYn4Cufb?=
 =?us-ascii?Q?rClkBnUcF1Znz6DXjuzKlcXdQqTkNXjOyVFyR3KdJjpBQFvNhYrUS2V+0pxM?=
 =?us-ascii?Q?QsmhXt7ry11elD0G3mk1nHSdEay23JsC96DY54GBrVx2cxr/bTBeG0FD2l22?=
 =?us-ascii?Q?83Y23clvcSt4i5aay/4qJONTKBdi0wOtf+f7THnbso7I9UFmTdh7eOLPCpu2?=
 =?us-ascii?Q?MgYmUlvda+mCIcSB2Telxki78vBBHQ2bwXSydytLKuZKP8VwwxqyHqAzbs4n?=
 =?us-ascii?Q?RiDFIct1IJLiSjV0PA6zd+jXEMnKfUm6qfxQ0NqdLl1AQ83Bx+PAft2vxrLW?=
 =?us-ascii?Q?D15R6eFBypX2nW9K+dktQonNPPVg73Je0RdfsnWya30/ywKX4MIka/p8YYCq?=
 =?us-ascii?Q?Dn1Eo5XhfPuuWAWZzF/cvlbkVIrc5mwOxrsSJEVFNiVjk45UMWI1421lGxeL?=
 =?us-ascii?Q?eJ4LM9iEcn0NmrM8Hi9TjP/2gcyUgRZ4nxEOsfScBNSF1OUIHX3fPY6uhDPy?=
 =?us-ascii?Q?+3W43QiU+tWpK2BsFb68ar4ijNqrRSg5zT8wiuXe2Gq3UMRTG+yQBAJFd5V+?=
 =?us-ascii?Q?VgKYWGBgTtnVgKuMiIB0PpNP5bMdBO14tIn7Bj78Pps3YGIWgMgGoCoT94vk?=
 =?us-ascii?Q?RpfN8oTBU3I7JZwMvTYSwlhXNKiwwsVVEP2tfZReW6WcfGcyUsNqEih7ffTK?=
 =?us-ascii?Q?eCHUSK2E4Zx/VytgWfpSyWoPNgywgShf7X0Xg+243t2yE+8uPKhRyD0ST/Zk?=
 =?us-ascii?Q?xJTlQBuiup4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 19:23:54.4171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd64a3e-4a0f-42e1-9f29-08dcbe28f7d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878

Parameterize the shutdown test to include the SEV-SNP VM type

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 tools/testing/selftests/kvm/x86_64/sev_smoke_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 0b65b59b9b40..c5a9fda49554 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -187,16 +187,14 @@ static void guest_shutdown_code(void)
 	__asm__ __volatile__("ud2");
 }
 
-static void test_sev_es_shutdown(void)
+static void test_sev_shutdown(uint32_t type, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	uint32_t type = KVM_X86_SEV_ES_VM;
-
 	vm = vm_sev_create_with_one_vcpu(type, guest_shutdown_code, &vcpu);
 
-	vm_sev_launch(vm, SEV_POLICY_ES, NULL);
+	vm_sev_launch(vm, policy, NULL);
 
 	vcpu_run(vcpu);
 	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SHUTDOWN,
@@ -217,7 +215,7 @@ int main(int argc, char *argv[])
 		test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
 		test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
 
-		test_sev_es_shutdown();
+		test_sev_shutdown(KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
 
 		if (kvm_has_cap(KVM_CAP_XCRS) &&
 		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
@@ -239,6 +237,8 @@ int main(int argc, char *argv[])
 			 SNP_FW_VER_MAJOR(SNP_FW_REQ_VER_MAJOR) |
 			 SNP_FW_VER_MINOR(SNP_FW_REQ_VER_MINOR));
 
+		test_sev_shutdown(KVM_X86_SNP_VM, snp_policy);
+
 		if (kvm_has_cap(KVM_CAP_XCRS) &&
 		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
 			test_sync_vmsa(KVM_X86_SNP_VM, snp_policy);
-- 
2.34.1


