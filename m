Return-Path: <linux-kselftest+bounces-25614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F8A266C6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 23:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B186E165C04
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7EA211491;
	Mon,  3 Feb 2025 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cbC4Ndm5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76720FA9D;
	Mon,  3 Feb 2025 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622058; cv=fail; b=Dvx+OCB8G34EpxIT8dV6jvmJ2Aw4a6xwfe9SPsCYbzJAkRZnTN5b3pdliayRO/Cw5ByqolfWqA8jH4/HdjD4KueNSBWRzPVb5R17+pzHLoanUGYadeOKg+0YgR+TvVFZ4cLH+j74V1jhRsuPs5kVkaqAa5iC8qbqBhOGFgTy2II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622058; c=relaxed/simple;
	bh=9MgVYFLYY4ec9JxQTapimjL+0DXZVB6JSMMKAI32RLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mX2arxG7p/8VRiSku7DXsgQzKicsBX1YqK354g0qn3g2uNKF+KDaYGatetfDE3HZGoI+hYCL/bS5vpPyQ6KrSWV3ZZmAs8U7qLt3Dmw4HKXUvzH8x97hEiSenWCy4Q3als8G8sBEjbDbIMNhw7aErRhyE0Pr+sJTY0FZ4TMhDXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cbC4Ndm5; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBb7AWiiYiqmi+d4xRWucoSl6SLb6NwrNNayw2YVMyvsRBhb3NgBoG4KloZhJ3nNrT5R1FiTmnV1zd3oQNzSPwZDmL126h9lWNVhbnkkPALv68ys3gozpy6KNlSgaTx73+KKOdsrV8db8S5MkxBKgOpl/UBXy8svtpJGsTutR9GPNO2cp06Tr9a7uusvTYyOSYFgV74x+CcNLOBuGAH6Pm04d/lSt1lMPjtECEyga4qYggWKMSNU+zmRPC2flM/jc41hnMx5s9p2E4C7Kr3eSihxqLWC25hsjV3u3TwJWS+MyCqQPBJ+byM68Bdj7fkcqLAk2vbK+0do4AAwtNzF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMonE8Jnl1T77qB+HYCpOlYadKOE73Jwtdt+alX6DUI=;
 b=qDfYspILVXUj48JOkoSdhP6JS+x5gurLCCeccIwWu5IZAb4cI52nU5JjZC3M2ufOcX+PtHbasiuyqVRRP8e0gHYYBkvwRAqxzhRtmqnkaTfcQ26S7SEG/HG5pShQ7SI01jxrl7Nb497016k7R5+iLlIeVxxPENJ5+oIkSxnIFWBGGLtr7obUNCr/1Rj0EvPMgXkD9IjJDQChOboWUshWDbveeN5FwGb/MdQL+2lWMuEmnc0d8fq3KOgqmKmw8ExEdlX6NLGvIfGcGqOZjsuTkImqq9KxU9fD/Ja13KBJ/wcdoLmoPSYIy5b9xg42lUeRHAw2pHl07fJ97NQwQH09RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMonE8Jnl1T77qB+HYCpOlYadKOE73Jwtdt+alX6DUI=;
 b=cbC4Ndm5FMar6RT+XQ08V8J6g4Fg0upDfu18PiEf67P5yXp3H0tHlsCvju+QHGwnBhKE8SxBXGoH3gTIUzk1J0FzaSsURDBaU+vGbvE3788jmfbscspc+OFbZZJ50nf1lsa/92zL006v58KC9LqWF5jXCetmG1LBpfOf75Z4hd0=
Received: from BYAPR06CA0061.namprd06.prod.outlook.com (2603:10b6:a03:14b::38)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 22:34:12 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::5e) by BYAPR06CA0061.outlook.office365.com
 (2603:10b6:a03:14b::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 22:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 22:34:12 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 16:34:10 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v6 9/9] KVM: selftests: Add a basic SEV-SNP smoke test
Date: Mon, 3 Feb 2025 16:32:05 -0600
Message-ID: <20250203223205.36121-10-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1566f9-3a56-4293-b237-08dd44a2e1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+xiATD8DH8VnUlLZQy2uhFLJxLlxBXD3nUCnra4qGkLPoPtVo76abBAR/Y4i?=
 =?us-ascii?Q?k7oqXmmHXUMbkDmtwWYr18qMm7RTno/r/g4QnQBSuM8MeF3l/5+v9MPe4Raz?=
 =?us-ascii?Q?02AUuncQx2uM4V+V71h+Fgpr9cBxAjWQa5o2w6To0qPWW6Vr4DxjYwo+Voqe?=
 =?us-ascii?Q?iWthr7kf0IxgG4RJXg000qaxav4TXw7MhXi5IXIli2hJgPpLVFgqkwqmXg+R?=
 =?us-ascii?Q?cOL8TD0MmqR16XFxiXa6mDBTr9MZOo5aypKsqk9MBVYgJEyHFzOxloHuIHWx?=
 =?us-ascii?Q?fRaIPHtowIPWkqArjIj7T+8NDqmtW/NORlsVNazw9C01jB3RBMZzLW/2hQ1W?=
 =?us-ascii?Q?FkoR062A0MalkprIPI3Qc/AFyniqesITHsGIHfUpTzFVqfPM/yvFmWEFi5iF?=
 =?us-ascii?Q?cAUUMBmRU2yXkyVMmoPm0agr+sNt0AC+z/avygGankJQMW6B/GqAPnV4PLSo?=
 =?us-ascii?Q?vBDviish3glK6cgliNPPNpEvhfu/fCMkJn6qy7KKXSsUU7gjm6SxmAQHSyl/?=
 =?us-ascii?Q?M9WX8kMMU8u7fTgQ7xlCOX8EzWmDeiiZsZ8YayUPEIVL9PKh/2UZ3hWW5szc?=
 =?us-ascii?Q?+VJUVLoFYuj9ySZeKd0bMGOhZ02PiUqX6tJazIGDfrhLrRjYg9pmoImZXVg5?=
 =?us-ascii?Q?9oiOqdUKxMG4G7tqsxe1ClNu3D1G4zS5u6lgT6uxkuZrrQ7vr50Ck+NzyyXY?=
 =?us-ascii?Q?J9I3+ocDbSAeibQnThUl/hSxBLeS9IWKZvoFU4hFtBT4hjFbAJsd+1e2pFm9?=
 =?us-ascii?Q?2vvZZrCaq6pVLer7pJxDvUf9/aNgJfeJDyGHZScMzA8Hcohwytl67fmWpTXK?=
 =?us-ascii?Q?dJvY7B79T3iiBAw3MTNT646XtRXYYdI3DvtwQJPhMTPWzJDsBr7F1ftNBdSA?=
 =?us-ascii?Q?QU5mUB1P1WICcWR64nfZwmaech6AhADPJoeRRaGqV3BrNA5WLBjeRTd27Um6?=
 =?us-ascii?Q?D0/RS9bE4AO1F/J4SYnAE2yQWpaxFsQs7K/DbGFXzohTopSnhqUnaLWj9BGQ?=
 =?us-ascii?Q?Np29Jg+FgICkeASvccZ8ol3KenYa0c5loSeG1SOreN1Tb++D6Z5RWHZNyUqB?=
 =?us-ascii?Q?5wUqMhRqshOdk/rm5oK156WIaDWAueQfm+0tbX4oK9rRfMYYr9p8kvzQTPn0?=
 =?us-ascii?Q?DxgX4zDO3qny5C2b1XqIHfBV3D2xn6bTjzmqgeZt82w+cai52JkRP+yBLJzt?=
 =?us-ascii?Q?3vKv/jIW3szQxEN30BxLbxdm05BtMv/MMPpz0VCJcFQxs2XRBvu0FwHZG8h3?=
 =?us-ascii?Q?JD2ZgrcpsrCMzJyik+VJ6wk84owW4mLuXlJy4UQVKkSnbKO9sH5/AAJZ2nVd?=
 =?us-ascii?Q?cIB1Ii2CCvtzpPnGaRT/iAc2wsxCGsACyvU9ONhf95KRt5c5XWWmaS/MN9N3?=
 =?us-ascii?Q?gYxhV3fAiSY/M2qh3rJZVWXAsx1tPa5qPFPL93ZA7TlN5r1jLQJMxPt4zNnh?=
 =?us-ascii?Q?167oEGLjGCVWUCYtfOeYXM2D1qcCfdB1IwA/uEG963HptsWu/fky3zxXIHeo?=
 =?us-ascii?Q?gScUj+iuUVmHTj0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:34:12.1604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1566f9-3a56-4293-b237-08dd44a2e1ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599

Extend sev_smoke_test to also run a minimal SEV-SNP smoke test that
initializes and sets up private memory regions required to run a simple
SEV-SNP guest.

Similar to its SEV-ES smoke test counterpart, this also does not
support GHCB and ucall yet and uses the GHCB MSR protocol to trigger an
exit of the type KVM_EXIT_SYSTEM_EVENT.

Tested-by: Srikanth Aithal <sraithal@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v5..v6:

* Rename KVM CPU feature X86_FEATURE_SNP to X86_FEATURE_SEV_SNP (Nikunj)
* Collected tags from Srikanth.
---
 .../selftests/kvm/x86/sev_smoke_test.c        | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 3a36cd3ca151..3336550152c0 100644
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
+	VMGEXIT();
+}
+
 static void guest_sev_es_code(void)
 {
 	/* TODO: Check CPUID after GHCB-based hypercall support is added. */
@@ -157,11 +169,21 @@ static void test_sev_es(uint64_t policy)
 	__test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, policy);
 }
 
+static void test_snp(uint64_t policy)
+{
+	__test_sev(guest_snp_code, KVM_X86_SNP_VM, policy);
+}
+
 static void test_sync_vmsa_sev_es(uint64_t policy)
 {
 	__test_sync_vmsa(KVM_X86_SEV_ES_VM, policy);
 }
 
+static void test_sync_vmsa_snp(uint64_t policy)
+{
+	__test_sync_vmsa(KVM_X86_SNP_VM, policy);
+}
+
 static void guest_shutdown_code(void)
 {
 	struct desc_ptr idt;
@@ -195,6 +217,11 @@ static void test_sev_es_shutdown(uint64_t policy)
 	__test_sev_shutdown(KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
 }
 
+static void test_snp_shutdown(uint64_t policy)
+{
+	__test_sev_shutdown(KVM_X86_SNP_VM, policy);
+}
+
 int main(int argc, char *argv[])
 {
 	const u64 xf_mask = XFEATURE_MASK_X87_AVX;
@@ -217,5 +244,20 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (kvm_cpu_has(X86_FEATURE_SEV_SNP)) {
+		uint64_t snp_policy = snp_default_policy();
+
+		test_snp(snp_policy);
+		/* Test minimum firmware level */
+		test_snp(snp_policy | SNP_FW_VER_MAJOR(SNP_MIN_API_MAJOR) |
+			SNP_FW_VER_MINOR(SNP_MIN_API_MINOR));
+
+		test_snp_shutdown(snp_policy);
+
+		if (kvm_has_cap(KVM_CAP_XCRS) &&
+		    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask)
+			test_sync_vmsa_snp(snp_policy);
+	}
+
 	return 0;
 }
-- 
2.43.0


