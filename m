Return-Path: <linux-kselftest+bounces-22073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9459C9656
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 00:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C366C1F2162F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 23:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067111B85EB;
	Thu, 14 Nov 2024 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BarHwoIF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6461B3925;
	Thu, 14 Nov 2024 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627776; cv=fail; b=Y52RbZKhKednnAvO50ot18uABYzBOb8pMfBWRl8gJ7LuckIJsCfWQba1FfKP0+chNuMSfCy18MA4L/9YRxwClo81mPyf9EhhDcX0QqUshBnzVDaMLO3eL4VM4byQccg65JYhfQULPPYXpXJLG7bYLl6kIpQOyeIU1M/3uObz7iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627776; c=relaxed/simple;
	bh=U2yetTn7xna0in3cj+HERP67FskIv+YXqO8+GlPaNrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBN02zqB2V3vDJK+AdCaKVTOPnRRND+NnAS7+eWDfxUcU21Io1JyjCjUOjwkS5/5B+oyC5/MeEz+IXlJe48CPhiQ1zIFH1VUcGlgcM9XI3quHRrxGX6H7SdCiILeYQGKjFC7XXGc7k/Hkxr/6Z/88Y6KCfE6UQkgmOXlMh+kRPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BarHwoIF; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuBJsIeX5GeG4jCzxx7LqJIZadhyTtLQcLltJBJF8GOTAuCsjUwOOpCChMGYYeWRBesGk9+446c5rhPVkLKHAHxscFNH9cuEcvzr5LDglGTBBREriOJDW6yDDnToD+RbRnFH5f6HKVEn4tP3dcCRztDJ/URbJ5zqiGzMJVmb7/FiXUGqMwwzYYN4xcCOJ+rla4hs4xO93Ih0VMjT0pKawp0itWw+UvLHuy4nAcLDoy6ag8jbIulrGPWQMj4yFRkDBpyjShFMGwXOWd8PXR8ZsAgT6jAgKZmG8BDV/ewbT6FoJF0ejR2feej9TMfdulusOHgYB5Zw7cLpFgKD+DWuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RocJK05lm5JfsZ6M9FwgHiIIPV/JxGNnH4PzFecApYA=;
 b=TUYzcWXZkawB1GaK2LF6ANzffXEHMLsHU0bdpfc9BaX2v/S/kuHZV479M5/G5DwuGt3zT/b6z5c2ot3bkrExJ2i6SqnH0CI+QGqEhYf8M7/lcEUPwzxvb1ab6WW1MMl5/cfZC0IGQHmlQPfyK5MAT+cAWfg4NqzQDQ7+mPwU7DJjPqVObzJWUtonT7KPGEASCFGoxQu26t9FCW581zFZcVRnDNUrGf4lk92gXDLZ48BdlE2PC+h5JbmToBnDyQgGlJYMSy486oEjxKxbmQsytBueBQRwchgwjFPZ7SeIcMIxDJlF3vf/ugXuwdhDNULjyYXaEbdS9msfYlTVL9vr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RocJK05lm5JfsZ6M9FwgHiIIPV/JxGNnH4PzFecApYA=;
 b=BarHwoIFlKB8mlqfS3OW6Z1MQUsnMbpMUf6RWQPp/Rv/Ekno99+HhQH+myzx1Hi5WX2jsad+N1SsbowmYsgqS+f3Etz5o4mY2Q5/3kSr8C23lyjlwabRJ6d+ySKe0/PwFQ7Ns5F/rCwqjuG7bItp1icJP/NPi9DPmPUm6c5bRjg=
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 23:42:50 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::ce) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 23:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 23:42:49 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 17:42:48 -0600
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sos-linux-ext-patches@mailman-svr.amd.com>, <pratikrajesh.sampat@amd.com>
Subject: [PATCH v4 8/8] KVM: selftests: Add a basic SEV-SNP smoke test
Date: Thu, 14 Nov 2024 17:41:04 -0600
Message-ID: <20241114234104.128532-9-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f74f144-34c1-4a09-861e-08dd05060cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ig7O1uZFI5JEWl/2IEwnKzSWAEOsL4cUWUdCRnFIBp+oNAY7R0aym2y/UKI+?=
 =?us-ascii?Q?L+NTzwYUWGXvZyhvM5g+fPcGnM52bvP583AsrrTl5V0kuAgUH4KCCmqUTfry?=
 =?us-ascii?Q?vu8z1qeFhI00k71wAUGvijWcu5SsgyP/dkyt6uMtJwhFTq5xg8V6GbOvb4v8?=
 =?us-ascii?Q?eo4EIMJ+A1rCkwtnYQGEAhYUW8cf7BI5W2sS0NJk0vLqF7wi9yfDqkwOl8MU?=
 =?us-ascii?Q?OtEnBjaqMNF9Wfj988unHpihQOPzX4n2l2W0Cs55R+e4XRaFd+eMnVJlnQnP?=
 =?us-ascii?Q?k9787lH+VxiCmuK8Wn7cPcm37OucNdCFJWh0dQt4kUtV7JX9OfDBah9IATN4?=
 =?us-ascii?Q?I1PuJcKFd0IjqiXTxX9YwKhugjkrGqj2H5wbu1WdNGaPbn3NrylFdDLJUA2F?=
 =?us-ascii?Q?s9JaaY7Sa6nAYc92PWUow3FnDY7iGCuNSr8n/BZ6EnTap3xxtpgpskYOTnke?=
 =?us-ascii?Q?qEHY/0gexvTBvdWwPxt7/v9Fs9mBu5TT1kBZXrT2V41XEzoz/laJfQrPb5dY?=
 =?us-ascii?Q?zfPjcfCszMZOTKAyh7AauxJd46RgeQDM8Tm/WyaeUrejyoGSAx3enQR2Pum7?=
 =?us-ascii?Q?UVRqr4l1nNVmfI+bZvSOFXQNcLi1h17/S2eYiR/iY/AdhoVOoBagYm4myOgo?=
 =?us-ascii?Q?WPeh1Kunb7jqR78bDVM6MqkPJeDcN+T8W1hHNBAEWZ8gAcX7C8IhW7kEbzKf?=
 =?us-ascii?Q?EZOwyAZv65JCms7GYxwimVuvrVBXu+efEXXDCA9sg5JEishjNkloIPk5NRf1?=
 =?us-ascii?Q?Tb7X6BTlscoMxdvHeiV4iCsUW0//pPRWVOu/Ej6o2T9VGlpIwjUEgEKSo+Vc?=
 =?us-ascii?Q?xgh9n/Qo13eWsKiLal2mp4ORUNoNILvXCGlS0sfYfKttI5dM/n/BdEJeVQII?=
 =?us-ascii?Q?Qa/MbIZtCRorzlFYXgv3mL6qdZcotMJjFXefHSkSvG/JrGcgw342CnvmhAz1?=
 =?us-ascii?Q?mmF19m9mIhv/ZzN/BWGPvY9nkzMQONJUDePEZRqoTcdpu6CbPr8NPgarhcEr?=
 =?us-ascii?Q?rhLK+r2cskc5Alhfef+YRNmc1XeaXpzCfr9KdWuy/lWmz3yQkVqtklifxKas?=
 =?us-ascii?Q?rnEPiNSlNthct0lTKutKwnkGfM48z6YA6+gblk1PIEwlB4ioZd6ajKhZNbj7?=
 =?us-ascii?Q?Oqdm4Kto+WTtyQ/vjBwlZIZew23ACi5VnQhGJaIL40oW6fwFlExbJO8y9biY?=
 =?us-ascii?Q?P2wUteJ2L04op038KuX6EdL0Ob6xo0MvoO/njLM0aiDn0brC7lZNlariOFjh?=
 =?us-ascii?Q?PgQ2VhPY/zWeTM/26YAW74iPLPFU8HmBIVXGYfXOVRSH5Xw1kglys/w3Zk10?=
 =?us-ascii?Q?FEfRFQG1ahlPfbJ/8B3a6fdh+kAYKO0mmd2YDpvTC6nYqCoQOLDlNWogkSui?=
 =?us-ascii?Q?sJaxC47IUDc/qYp29xZp6TkdwwiPKmYl1dCc+JjQhP+CIJKvFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 23:42:49.7850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f74f144-34c1-4a09-861e-08dd05060cd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163

Extend sev_smoke_test to also run a minimal SEV-SNP smoke test that
initializes and sets up private memory regions required to run a simple
SEV-SNP guest.

Similar to its SEV-ES smoke test counterpart, this also does not
support GHCB and ucall yet and uses the GHCB MSR protocol to trigger an
exit of the type KVM_EXIT_SYSTEM_EVENT.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index af1beabbbf8e..ff508d67377d 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
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
 
+	if (kvm_cpu_has(X86_FEATURE_SNP)) {
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


