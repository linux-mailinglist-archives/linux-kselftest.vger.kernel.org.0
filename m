Return-Path: <linux-kselftest+bounces-22067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C35D29C9643
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 00:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0142B26565
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 23:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103F11B4C35;
	Thu, 14 Nov 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ICddO8nG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4751B3954;
	Thu, 14 Nov 2024 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627700; cv=fail; b=TXerQAVO/JUPMDihIA6KLSRIXr1rfFGCOT2rNn+OjR5SR7lphOYqEQPSOcGDiffCX3HcLPA/ChfxRo1S7OHwIn7yVX+QeJj6pPFLzbraUYHz0r3K3P1W4cvd2PpopalmFuivUi1LHGoaC8NgnIqdaedB3B+3LXZNz6zYszKebMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627700; c=relaxed/simple;
	bh=L0i8oI0Z8goF1p6yqmbrPMSQC/9WxBa4Ko4+iQdRopk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkTO8jzH+KfxsSLfdRGy/L/YxEQQFGC4gA6cKuwxh+zu53YtxvXDsSZ/rg4T1scSqZduwybUo7zdpSR5ob21rmzQtGbkaUji4Q4euV9eZMWjKPvfAwSCNgL1Kai6m00zf6B+e+Dk5O2r9uys7pfR38ehzH86YxuAJvzHMtuS5UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ICddO8nG; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgo+jO/12na7cRoBdquvzFc/F8/+HQMZ5yFGhKNTyPu3PJPEBWzZjRliH0XVFy/yo5rQKT0K9YBEvbI2RNZh/A0lfwQEJdv4BE8DqxoBx6NGi84ouYPQEjoQoDsk5zyikVwxPT533fJwCrHuG/YGnP8V79grMx9G6ANtyHNskmQbPo1eZ8EVpanLgUcMmAYICp3tD5gGpDeaE0XIGKZCWwA59eWlx2dT8KeLpVLjc+L06xdhoVGTewVMKIUmYKbeHiCpGEcNuzABQzhis3TxiLHC250Sl7eJXCDR8PLPgmxz8ioxvJ6oiuqUvgvOIP4dHaHX4zQc979/QOE7rOYEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLLgD8c9NJWyZ3R9G8OLznuY+bO8mOZsk80XyIH7LTY=;
 b=Z7fnAbbHimCXb+RbVzWUPIyboICzAhtRCsGwVtpbSY5p2HfeqLX+qfOd6SXljz3JTpbxrXnkOKRFdJL0i8NyLvx7t908sqKU1nPXWfSo3gUELKNLRigMgWQXI8ayfZ3nUeMXqKmWQbBuzKmfZcGafiaW6pLFZ8VjcxfDt9HZR6ztAty1Oha7/DbUDcsVVxo7jgKGa6FaTzrEwS2kGHoXGHEpdw9GCuNehdmxQrpoHIn6pErXSIR7D8iJCoXEkToYCXWId3As4LnpJsbcfpCmczv82Uyg1uY7nds4osJaYSwVUI9cP+EhP5YmPRsxWZdeGQBENxuF0571ZguQ94LK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLLgD8c9NJWyZ3R9G8OLznuY+bO8mOZsk80XyIH7LTY=;
 b=ICddO8nGRxS9IeiacrnQ+heoAjuglM8hCZBrgNKtSQpe+6Ki7UuRdmS0tGTzsHuJBG4SdPeQ39oqKFxas0F1yxb2eHVpG1AgrpUVQTAcYJ4vZTSMQxV5ceTNc4NVCiZgT4Cwg91021AnYs8tUctbokjyhbg1saTJGn/lxt/IOPo=
Received: from BY5PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:1e0::15)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 23:41:34 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::7f) by BY5PR03CA0005.outlook.office365.com
 (2603:10b6:a03:1e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 23:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 23:41:33 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 17:41:32 -0600
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sos-linux-ext-patches@mailman-svr.amd.com>, <pratikrajesh.sampat@amd.com>
Subject: [PATCH v4 2/8] KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
Date: Thu, 14 Nov 2024 17:40:58 -0600
Message-ID: <20241114234104.128532-3-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|IA1PR12MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: 975c1e84-a661-4b34-c065-08dd0505df5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?48tZCFVnveGOQ23zuxMpwtUGpAKBK02E6r5ZztssPj0a6yrDOEPzS7gxzSJr?=
 =?us-ascii?Q?YTmozaEXwhWz8udsOu3Ar1QrWNiv0U3GkLsWc8SF3ksiIlCVoVh8MU/l8YSS?=
 =?us-ascii?Q?NvxOgfysJahuW0prfJYWJxN3Ob6sCZ1m6nI0AX9O5XjnHpnRrSF4D1RmaOlI?=
 =?us-ascii?Q?xsJeSnoKInA/ot/axvjWXtoetTCjJusaZT77FSA2vAVEWj4V3p9ld7mMcA1E?=
 =?us-ascii?Q?LYsWr8CSaN+aKml31jbRuvYsIofCBuO9vlj1oYbw0AE1D9DiZy5beIo6U+Js?=
 =?us-ascii?Q?WVE3BoKChxSmtPKZr4f4zEtdt5w16HJ0vCeMWsn1I/WiyhDDxmWH7pP8Jwsf?=
 =?us-ascii?Q?2srUw4VSRN2VxW74lS07F6zppdMo7wMsoTRWAS3LAy4HKm1B8TcdgPfFVnit?=
 =?us-ascii?Q?mKxCCjJBM5ThbDJbb0CRujTA1ZbsEEB/VQiw/Hk+glrWaaKgho4ZnIsbepn4?=
 =?us-ascii?Q?gQ3twEQWH01vdPtbhfbVaQzJKOJvSq4+0B9kAf1Ls1eUwNh04zWqA+wdb8q0?=
 =?us-ascii?Q?LEyCah5IT5yBYT54rKQXRrBpFTMr7MOlDYdZqyLhnVOe+YGp4G+sp4EVoZ3I?=
 =?us-ascii?Q?DHVnm5mUHIL2SiEKowHU3EFNvlymzGv48nLFold1z0qdtF3FS7ZG275AxTd5?=
 =?us-ascii?Q?dBN7FcZlJkPmpEXhLcs3PY5c8bYszLp7SBx5f5JFBhnIDEJ5RJh7uDvzRWeL?=
 =?us-ascii?Q?QJ+K6h/Q5MbwJjv8tyWgyjZ17kV9MmwCBOXyqq/PpxVuQuVCoI5+YXtnr2A0?=
 =?us-ascii?Q?oxff31svNZfHIuojScZ11u+tRPcLkEBTQOPTpzHZUGG4V/fBN316kPi9WPbI?=
 =?us-ascii?Q?cQwNwdiPssHYIsohGmynDF2CJyrvIwvMxttq58bMSJsd2YH0z5uAFvVbaYJl?=
 =?us-ascii?Q?fO3IRKCOaPGmpAMjFuBkQyryUUnOgbBrs+QKh24NcyYpg2IImncMUzMijTZF?=
 =?us-ascii?Q?heDqLaFqo15MXSavyrexJ0FOn7Q2WmZ7d4trrsscVTsPqlwVgZFveqfihQFF?=
 =?us-ascii?Q?jye8NI9vKCFJpJE6/txhjVkFyrADQONhWVNRKW6gcSZuVeNnKatzFI9OI3vK?=
 =?us-ascii?Q?h/H+69Ms/TjM4jix54c7FHfxE8QwBrm1RmioAks8mSG/cug1xXgyUoU+35b0?=
 =?us-ascii?Q?0x7WZ73OI5iD1kQfhv8tfQKDoet02iwkaAOMeKxQOKENHpjNahZaoDY5kM3w?=
 =?us-ascii?Q?TZBA57Af4HcGJajwBLNbOVqOSeZQwseTzufwib0/0Hjs65nIs5Yl+4Ew5wBh?=
 =?us-ascii?Q?r18739x6PZvUdTV3pn5VYva0G/zATC6yIW+0/pZyUXsjLNSbPR/qHXZt9Fju?=
 =?us-ascii?Q?s1sdmPiXiMTUk58xdFQdKCjfTrX4EeBh/1AiOL7ZHv3z9y6l916t/d3Vfhd5?=
 =?us-ascii?Q?ldvsY7gfvOVJBslU12hqZoRSqNvjz3ZGAvUhXeyU4nM5To+RVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 23:41:33.4376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 975c1e84-a661-4b34-c065-08dd0505df5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640

Add the X86_FEATURE_SNP CPU feature to the architectural definition for
the SEV-SNP VM type to exercise the KVM_SEV_INIT2 call. Ensure that the
SNP test is skipped in scenarios where CPUID supports it but KVM does
not, so that a failure is not reported in such cases.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../selftests/kvm/include/x86_64/processor.h        |  1 +
 .../testing/selftests/kvm/x86_64/sev_init2_tests.c  | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 645200e95f89..c18d2405798f 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -199,6 +199,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
+#define X86_FEATURE_SNP			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
 
 /*
  * KVM defined paravirt features.
diff --git a/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
index 3fb967f40c6a..3f8fb2cc3431 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
@@ -28,6 +28,7 @@
 int kvm_fd;
 u64 supported_vmsa_features;
 bool have_sev_es;
+bool have_snp;
 
 static int __sev_ioctl(int vm_fd, int cmd_id, void *data)
 {
@@ -83,6 +84,9 @@ void test_vm_types(void)
 	if (have_sev_es)
 		test_init2(KVM_X86_SEV_ES_VM, &(struct kvm_sev_init){});
 
+	if (have_snp)
+		test_init2(KVM_X86_SNP_VM, &(struct kvm_sev_init){});
+
 	test_init2_invalid(0, &(struct kvm_sev_init){},
 			   "VM type is KVM_X86_DEFAULT_VM");
 	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))
@@ -138,15 +142,24 @@ int main(int argc, char *argv[])
 		    "sev-es: KVM_CAP_VM_TYPES (%x) does not match cpuid (checking %x)",
 		    kvm_check_cap(KVM_CAP_VM_TYPES), 1 << KVM_X86_SEV_ES_VM);
 
+	have_snp = kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SNP_VM);
+	TEST_ASSERT(!have_snp || kvm_cpu_has(X86_FEATURE_SNP),
+		    "sev-snp: KVM_CAP_VM_TYPES (%x) indicates SNP support (bit %d), but CPUID does not",
+		    kvm_check_cap(KVM_CAP_VM_TYPES), KVM_X86_SNP_VM);
+
 	test_vm_types();
 
 	test_flags(KVM_X86_SEV_VM);
 	if (have_sev_es)
 		test_flags(KVM_X86_SEV_ES_VM);
+	if (have_snp)
+		test_flags(KVM_X86_SNP_VM);
 
 	test_features(KVM_X86_SEV_VM, 0);
 	if (have_sev_es)
 		test_features(KVM_X86_SEV_ES_VM, supported_vmsa_features);
+	if (have_snp)
+		test_features(KVM_X86_SNP_VM, supported_vmsa_features);
 
 	return 0;
 }
-- 
2.43.0


