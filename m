Return-Path: <linux-kselftest+bounces-28353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85F3A53D92
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB223A7051
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6C2207A31;
	Wed,  5 Mar 2025 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="utqj5hMN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D259207A23;
	Wed,  5 Mar 2025 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215689; cv=fail; b=ssdAp6eEwWY/MzYbRCbTy+5Uu24F54c5Z8R/4OMU9vXTyJQgoD/+7gNMYMIwiv7srqdJuzA2gNRp4f03iZlI193XCvT9xicIS9llMv6fEenPx9litlgTQ7LrKdpXGmdpnhydmbqYSjbExIr6xci38Vzb6vmOMakXwb54+AaD6yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215689; c=relaxed/simple;
	bh=WlsAbaSPddZ3CkEgeFPrMsin1PTQVo15lUiSgpsZQKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqTaHYcIp2HN0Ej58xIx5QnHazL0Fe91tTLf7JGXf/baPBNovt7M3JLo1AHuxzjg99SUliog3kGiku+Hzx5npoRXD046Lynusa7Tgi7rn9J+qHUn5hoipm6a99S26y2WEpc8mTZcsPDrqMxZqQY08QdpjX8GYuWbzIS7yyjbeNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=utqj5hMN; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqwY1sOcrTNNFJoPrroTyDv+/fhEpj2h1pipIH6UbY5tYR5pguyXvtd0KlNA2YNlC+Dz8sIV9yHP5exnS8wCt2L9cLUxX8xzwCeiaDCpmv67BLjwRM3+8JOwGsqfBLDoaVfju8Ghec8IE456l1PyJ3IWY/B19lyM/e9AYixq72ZaeF+ym1xz2TMY4ceO6tql+zMDLmtQlNRzsaiyVhArbjtqowyljzH/JCm+CbQitQ1rOODAKzOroFZJvZRvf7zdWepmHzl01Sb3OVFtT7GUW+xoUlWxOU+epv/3CSx0IzYwU3Pp+0TOTUbO6FNPT3lgkG7SgTinFs6SbMteUm5Lvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjbCeIzgdbQNBkOx88nh3nWgFZBMP8RIdEU/gh9qBuA=;
 b=UR3uH+LLb4+PpANOalmteGqkQ2FyI6QO4vSP7TGSC+RbD32Z0aft/DDx7sDJKcY/5OIJKhkX1KdKs8i7l+HaWUzBxNF5HwiYKeiVnNPDE1hgJ2wXhNozrJBaSTR6uXPVgzmIAAcksoUGncIA15mdHuSQI5/eukf/2NHNG8dEnEzc1lpyRg1JYnseFV9O5TBnWX7p4R4GukVZ+7yLmKqCcbzZ1AKzqiMGdcYIatjsPvznjoS5/FwWHEPsr+M8Z73DQYlnxTt8Nl8cjqs4wiCTsEoKZ4VNgIuJW+37HiBrBa6vjlsuIJOcJ+ySi0FBX9Pi7SDJgeVZEEf6tRMCAfkY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjbCeIzgdbQNBkOx88nh3nWgFZBMP8RIdEU/gh9qBuA=;
 b=utqj5hMNujZOzClHukNkVgpqSq+xkeFXvH5nIYkjy1HSbkhzHKcomih7TI3JYHx8W5pTzVxGF4XjisNsD+an2vwgOwDB0HOfW0YK8MA/uuwvsgTZ1x/I3AM8S1vzwP8y0H8vyaAsBDv7gtc/YAUgRaKxiF4ui5HeP0KBLLqRALE=
Received: from MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 23:01:23 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::71) by MN2PR05CA0029.outlook.office365.com
 (2603:10b6:208:c0::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 23:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 23:01:22 +0000
Received: from zenon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 17:01:20 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v8 04/10] KVM: selftests: Add SMT control state helper
Date: Wed, 5 Mar 2025 16:59:54 -0600
Message-ID: <20250305230000.231025-5-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305230000.231025-1-prsampat@amd.com>
References: <20250305230000.231025-1-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: d8219be7-b1dc-43ac-51cd-08dd5c39a651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SiXOgOxdfk5oXhzhIVDc28bd7Ru/dPpo4R8XDsfuv+UA1djnr9URxrpiH4qm?=
 =?us-ascii?Q?fyrkyyvSj882VgmikA/l9wP51Xrkg9jaFWU6CZsnd1oCGBTuirv/G73lZTE0?=
 =?us-ascii?Q?H6DwLlxt2X1aKdNdByqlNz3Ty35fqzZAU2jT39gy5wZ/phNObyjafKzpDzFS?=
 =?us-ascii?Q?BR0eUx9kae+I5SkLsaMAPz1VpgRBFcSvxibgdGPcHAltbSGeXeZQLfDNRUWw?=
 =?us-ascii?Q?hx4bijvtQgjDcg5zfdNHE+0ka1DzpnUDazALNPUqiYJbigq0YijD8+uSxXvv?=
 =?us-ascii?Q?Oxxfofy510b05uKmI4KHRkYwsQy2Qlj3V3Vm0fmsD9/EW7wTt2/wt4uqtS/I?=
 =?us-ascii?Q?eZy9NnjlmX78ADkhWSxGB2aMYYnni1GDCO3lqpUZtGcqdAvxiyT2Pqe3g9j3?=
 =?us-ascii?Q?t6S/kdhRGrJG5C4sOEZ8o7xDKQYQzh5iJFTl1K1V9JGPhTR46KlkgoyBvs2F?=
 =?us-ascii?Q?5fpplbDbyO84QSnJ5Q8yFCseccyalNfVsSbUVUcQX+mMn8z/e6j/3B1Z0M5c?=
 =?us-ascii?Q?0r4QYZ5iFTb0zSRRfDu6EdIFO/tUF/MdjIYAsQZmxXsfAbsSmubrUNKKiN9h?=
 =?us-ascii?Q?o9k5VOFK7Ciz3p4iMQxa2GUJ4enDgqzdZbntylt2OOHGKDbiiSy7/Zbw77CX?=
 =?us-ascii?Q?1FphQztQzX9/WWHnTzh+RgQCpy40azvCdnNHwiertLHGKYjEfmGVN891H0F5?=
 =?us-ascii?Q?Dyavg8kZeVpxJfO3PmZvdYPvHyjPq9aCe06+XBM2szyXnlM27HGd19uoufDD?=
 =?us-ascii?Q?BMvma9a0d+A6Yq7b4Nvhl0z5HMm5YA69YVj8b0VgN5pBp0ikAPHURgueEC7m?=
 =?us-ascii?Q?k1WWvcZRD4rk+3yfSJ7uurrelMkqxm/Ex2UHIDu31tnmgEc7feT8Xp6f21yi?=
 =?us-ascii?Q?F3BzftNJbYutgEwWTk5NwAhN4rVAXsuW2NqqF91MHi+iXiYORHXw6Bzcazic?=
 =?us-ascii?Q?/LjCOAoJTsNoZR9NE3id4r1qrPph2fbWmMzH5IcUfmAayEYc0vNisbgMa3gy?=
 =?us-ascii?Q?YuXmUi0JNkhoZnCehx+k95jh+iVMwjamxusj95zdy56YxZ8BDe15uHNsk6UY?=
 =?us-ascii?Q?DNN5eD8hXPIvKw3847NjD89K4nNuA/sON2wJpzAcVdXbASiUMhQvw4xdsQLE?=
 =?us-ascii?Q?oCZotr+uNY2qwe9ngR1mN7BR3mzq3Ig6ZlCj2qGGDaRKMgzo7loHTszKp21q?=
 =?us-ascii?Q?E+4CDRZf1GwI7MSpZ7S2rtI7IhU0LsWK8Xp7eHwSONysWbNqG/UJvm1EJYiz?=
 =?us-ascii?Q?miIZ3klX7QL4D2E8A/9VUTnBHLMX7kkr4scqOaCXt6cxl3pHWMltxK/EcF+7?=
 =?us-ascii?Q?vFOFMXMaZ8W64p+yzj5ubov9tmu2nQeLmdGdY280Nq1fVfD46W+6AHwub63m?=
 =?us-ascii?Q?/zr2dgRzNJ+zYc08C6RDlFZr1KrUxY6sk9VGqTbk5gBCxVeZtBaBSSpwhqYU?=
 =?us-ascii?Q?/3eaPE4/9rLyxV57FdeWjmHT7rHuBKTs0/IJyPX68vo39pAR+aHopB6OqFvZ?=
 =?us-ascii?Q?vz/RQbXpW9tt0cA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 23:01:22.9248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8219be7-b1dc-43ac-51cd-08dd5c39a651
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053

Move the SMT control check out of the hyperv_cpuid selftest so that it
is generally accessible all KVM selftests. Split the functionality into
a helper that populates a buffer with SMT control value which other
helpers can use to ascertain if SMT state is available and active.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 35 +++++++++++++++++++
 .../testing/selftests/kvm/x86/hyperv_cpuid.c  | 19 ----------
 2 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 4c4e5a847f67..446f04b2710f 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -542,6 +542,41 @@ static inline uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
 	return data;
 }
 
+static inline bool read_smt_control(char *buf, size_t buf_size)
+{
+	FILE *f = fopen("/sys/devices/system/cpu/smt/control", "r");
+	bool ret;
+
+	if (!f)
+		return false;
+
+	ret = fread(buf, sizeof(*buf), buf_size, f) > 0;
+	fclose(f);
+
+	return ret;
+}
+
+static inline bool smt_possible(void)
+{
+	char buf[16];
+
+	if (read_smt_control(buf, sizeof(buf)) &&
+	    (!strncmp(buf, "forceoff", 8) || !strncmp(buf, "notsupported", 12)))
+		return false;
+
+	return true;
+}
+
+static inline bool smt_on(void)
+{
+	char buf[16];
+
+	if (read_smt_control(buf, sizeof(buf)) && !strncmp(buf, "on", 2))
+		return true;
+
+	return false;
+}
+
 void vm_create_irqchip(struct kvm_vm *vm);
 
 static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
diff --git a/tools/testing/selftests/kvm/x86/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86/hyperv_cpuid.c
index 4e920705681a..1eb55d0b7297 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_cpuid.c
@@ -22,25 +22,6 @@ static void guest_code(void)
 {
 }
 
-static bool smt_possible(void)
-{
-	char buf[16];
-	FILE *f;
-	bool res = true;
-
-	f = fopen("/sys/devices/system/cpu/smt/control", "r");
-	if (f) {
-		if (fread(buf, sizeof(*buf), sizeof(buf), f) > 0) {
-			if (!strncmp(buf, "forceoff", 8) ||
-			    !strncmp(buf, "notsupported", 12))
-				res = false;
-		}
-		fclose(f);
-	}
-
-	return res;
-}
-
 static void test_hv_cpuid(struct kvm_vcpu *vcpu, bool evmcs_expected)
 {
 	const bool has_irqchip = !vcpu || vcpu->vm->has_irqchip;
-- 
2.43.0


