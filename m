Return-Path: <linux-kselftest+bounces-25053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24374A1AC69
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 23:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D6A3AE8DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DF11CF5F2;
	Thu, 23 Jan 2025 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tJMQPPW5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83581CEEAA;
	Thu, 23 Jan 2025 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669778; cv=fail; b=W1sNR4V1ZaQRr3B7OLRMJb9goOffWkq9Ddm6Wm7tDuOz7RUdCosTdJEmhAqxIqaJD5eEbxKdfQ0DY6oZyS/bMVJbZknbtOSPcRfUhCdnlJvvmtT1B6IN9ywzdUyLYwxkm+4Ve5lBFj+Jxc/QHXLQ0k7awIJ1VHHU7MQTzpV8SEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669778; c=relaxed/simple;
	bh=baNWJFyvFX53D9vG1aONZADKkeSjZ+6+MU51aeEs3YE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8Bos0ZglelyneoLNywxOQLxOVIyJFVfsNjFwuTS/yQ7gmwR1fPPVYe4j05YL4xLBhBkmmmZ5/Cr+KMZYWM3q+9hkkALqZdYWhVmnn1NGRgaYlazPjuJvokjh0jMJP5SWAgsUHD5bw1rmTd3llqJWQFCNQYUyfOttVXllVUikEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tJMQPPW5; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZX/eqWYa5uKqGQ9jqThD775ZwMVUFqipdosMpCfbpj+6NGeDUHpsr00dK2NYpsUplWai8MvKT0//MdKCQnMHIyRGZ6bycezfftFItrmbtxJQtJffCjDYP5ULcYULS5PWBSpn/DNhDjJ6I4DjlZKhflb4GsdPnVLblcjCb1hSZ31V9hLQu+oMZL/6yWw5qZmGxU76OF0SWPP/YtE2UE/qTk3o0zJq3FMapEqfHbyvYQN2V+N5yMgkEjd3PQwMZxUgNwES1bIZWYVIzxEIqFZjHxKb72eIiZwP5mzKzvgRM8KGWDTj+ZPvtRP+DpClikkOslgyEw2K9VRj3h6valSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvatRHAmmGxgKeSNj+Fz65HPMywfEd3Okhzo3KqvHqA=;
 b=sRjKFgjU6lQa7kd6KmycBANyFC6jjGGhZch5mwlVn+1MCD7MYqsC9bgMO0iVshtdsXGri1EMsRMV3OEhBtiddsrbnW6BEvBUt41Yee82BNgDt+lZZUZRq62WaZkIRii1Oe9A9twQzTLm6dHu2Lhy9gdgu0hgSvRlzkkQy8bhrVbsGWhW7id0fbeX/vow2u90mvwt5JNIZaFsghR7Sb08t04CPstn0NXqBUxJqSkLNvqPZCclAZuqhhek72gNtMyIQS50kMGttU0tk+ZDX+VjNRCIpzQDF1kBFuxGZP9hWn+CO8RNtw8hExCCOcimDx7dfCNnG8Qngv/ZQyENH3/nKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvatRHAmmGxgKeSNj+Fz65HPMywfEd3Okhzo3KqvHqA=;
 b=tJMQPPW5S64Az5wJPH1/GLJ0DLWUX1iQf8RLIUBhh2HdV9WszjrQP7mL8vNUTthTzADwZwo/+6z07G7DqPUYuv4jH3wmdiO07eNitKaiknrBPKpMGmz6b3Cp89xkGfosYslXrdDrQAA/OXdtaXdd0IpoUme2cC5qmrZeM5TFN9U=
Received: from MW4PR04CA0181.namprd04.prod.outlook.com (2603:10b6:303:86::6)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 22:02:51 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::99) by MW4PR04CA0181.outlook.office365.com
 (2603:10b6:303:86::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Thu,
 23 Jan 2025 22:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 22:02:51 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 16:02:49 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
	<sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v5 9/9] KVM: selftests: Add a basic SEV-SNP smoke test
Date: Thu, 23 Jan 2025 16:01:00 -0600
Message-ID: <20250123220100.339867-10-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: f1071918-f6df-44f2-e83b-08dd3bf9ae3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p7ii+zJXzjPT3keNxKoE2XYvUlngNQAonIiRLD9QeJddBL8IPiM0bKgyn7VO?=
 =?us-ascii?Q?mpT5beL11k/m46aS5pzzrMGULrUba1mPYClA20HTc7AsEOhhFDlsWfD/2aCX?=
 =?us-ascii?Q?5fWtf3r0UUGW1ePbFHU0+BH994UZ2jTDy3mcHq4M5IYex2sN7RE3DCBEvcwO?=
 =?us-ascii?Q?pQebTJ8+iV895wlhv7BzB77vBVKIaEQFqg1iiFYGt4GEaLB7iS9hWCHpx87p?=
 =?us-ascii?Q?/GELoKwRH2UbcKTHJTsLQ7TwJCb3xJyCbIXSC07NBTfqFDLK/cN0ZInJSpMR?=
 =?us-ascii?Q?P05nkOvAUIEbCG4YUiAD8AlATtejvvoZFYKurydvCOdhHHcGbkzWRufO9pLB?=
 =?us-ascii?Q?hG5Zv34O4ZZrBWLaH/vOT5HNQ+1q1PjUvmbAyk6XQLZQ0TULR1NX5mbzQ48a?=
 =?us-ascii?Q?1LR6BKugrJvPVnqpZu7drmYeUJ0GhfVevSb5OjOzwouo7VMt/QtqehSbqnc3?=
 =?us-ascii?Q?GIhdvr2ocJgmJlvYauMz9ragoUGs0WIWNhqHe0EsI3OeKpaiIkFQw2zZYKk3?=
 =?us-ascii?Q?uweJVAAu9xsg2Fvw3oJaJw2V1aRORTY4OuJEExo5v4gIv0T6XaB9yx2OP/CY?=
 =?us-ascii?Q?QwLbfNt7ICndotbdUjCJu6lvpI2k60lcMR0gOmJ/yPSS8/niTungLQqlaGHN?=
 =?us-ascii?Q?/A0nHYIY4A7JcqAYqWBOt4Y7KcUN5lemC8l1WPZK8flnWxvQkWjt8QZWkjsw?=
 =?us-ascii?Q?qYSp+ny7B1tsUTi/LWsSGZU+yGgK+razRhEbxJ6dL12kT5+FQFf9IGUCgjVN?=
 =?us-ascii?Q?6tTA0ApiX0wCz4662q0nrp/x79wA5TPWRN6xdQkUz+XyveUR7ERlkdTe+l79?=
 =?us-ascii?Q?zX3SX2VCcT6TQgQgkwu6goGyn/woxu9dBOWUgQJJFj3tqzqqQ/wCWPKWj/UT?=
 =?us-ascii?Q?HjO07/MieheJbo4GVCpRpiaaU8BMNS5RKhRTzLcwNrKdqKzbXqaHi2Q+Qspt?=
 =?us-ascii?Q?j8pz0/b4dz2rTFqFld3oRq3nYRMXTYluBEGkX7sAm19ENsf7ukMUHg1KIwEK?=
 =?us-ascii?Q?lzR8rkxKYZ+4g5zGY0CfxbbrSo1e9gyw7ypDqgsq1tRwKDfZiGCtL6RfM6uD?=
 =?us-ascii?Q?PVUtiBmZZk6nMnWuHOKWfxk25wu6uwKnfh5RGndRMY/tJItGiRZSde5xx38H?=
 =?us-ascii?Q?QWlTVNBsdudzQUlVV1jnVUnVgfM0NYk13bA3KWuk7Z3XgtN4+gSJG0mKe2yR?=
 =?us-ascii?Q?xltEx65I5fGhnd6ZoS9djDRbZjBG9MaU8AeZn9EK0XFPMQOF3FYob6OOi2lY?=
 =?us-ascii?Q?51wvrq7uY91MCRGJIikwWEar0FJnVLC0PycILF4gr/EjGFGsVSBTtmOnLyky?=
 =?us-ascii?Q?5ifHdy171ZnykoJzE5PPdWxpffKkuJZ6hC4+JH8HGSercRJG8OdY9P1AIKY4?=
 =?us-ascii?Q?0SrKXDKTUON1r9+CK3YmBHB9Z5roDdg5a7LRayIY8dRLJLjg0l4nDBOZXVhd?=
 =?us-ascii?Q?zT+0cyY9hKpiKtGXTj63c6IlqiLwcm9evnV/nUjDwjDpQq/RZr8nTx8YRkBQ?=
 =?us-ascii?Q?RrK7av26uyi6Fdg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:02:51.1169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1071918-f6df-44f2-e83b-08dd3bf9ae3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026

Extend sev_smoke_test to also run a minimal SEV-SNP smoke test that
initializes and sets up private memory regions required to run a simple
SEV-SNP guest.

Similar to its SEV-ES smoke test counterpart, this also does not
support GHCB and ucall yet and uses the GHCB MSR protocol to trigger an
exit of the type KVM_EXIT_SYSTEM_EVENT.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 .../selftests/kvm/x86/sev_smoke_test.c        | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 3a36cd3ca151..4fcd0f6290ae 100644
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


