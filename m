Return-Path: <linux-kselftest+bounces-25607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008BFA266AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 23:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79300160A6B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D66211472;
	Mon,  3 Feb 2025 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YX3v200V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61020A5C7;
	Mon,  3 Feb 2025 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621972; cv=fail; b=tDwBmH8Ks/zABy7J0dg33cVWhCLhHMl6BXHd+pjaQqn804Zh0BRyuD/6v7h5EB+B4jn62YkKKmN591Of1apMFsB8NtDMYT1BysMLF5vwYDbHbAa4pRKgjNtgcS/hOxdVv/jQ9t84VzVg+rzIH2VCwRYtD78SBjoCEkna5X8B1Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621972; c=relaxed/simple;
	bh=SAgHb+w8s0Cx/tQ+BIasVcOybs03Xt0KB1rHp17EQ+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5u2rb468hSUYWDJejCVRwzoKnUEWFGcC3otmn1LmBxlFdspm2egYkTdCdM+9oPZDKIPwuQwBOk68zvxDQhs+3u545JxmHYO6EpNWhXe5A2RuLWnxIDzzRqy+CfOyniDEeGuxrfouezKdKfuPZPhQmEWYON0WhXHL8KIiMMy8Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YX3v200V; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slZ+NDrOpUokUdnFs636hC7y7xd+TT41KGKr0JqoU8HotXNKnbv8u8hm3L7ltSXKNrWZrA1VuTID51/4Pxe7MfmXDafGEzaI8mKvzb7qFGt5WM+SbF0+ZHsfEifJIc//97Tk38cMUEX1t9kVNF6VRKJUDkC4EwtBmRgN3LC07zGhtbEikDzzSu1vMQ9bHb+S/IvPqEg7gna4jahvJBYXdnO9JOQmMYj4ATfYyl48wQs+Sl2WQbk0wKDMI8jehCctB98cqivXJiLzT74A2w6+T4i2BGMi1ASKv1bt1cu3MEH159TWEv5N0NE4kH+oacubmuQW9n82Wo3y3kH3PsByGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfAS1e2bE3hJdMmPqPf/CguUbzLMoCqv3MVBJ+76no4=;
 b=saZh5pd3zoYTKmXqTTz9ZpCFsa/94arL506AzJ4KsPJfzFYf3qKtXPiwdws7TnQmj2v2669JdPO7DIxIK7qDgSduPzzHo0Y1ykdZdRLwZhHHh7QGQbCLuKx1AXdduRo7KDVPdHGP6Fspzy6dsskMs3sXE/D9xGvPARO3GDGq+ea6iHDlPDkpRXR2Swhgb7VAO88QLZaFMTRmIkIrsUHJerG3/G+J9Mt6Hx/Sjllbb84dv+rDFFMD2PpNCMQrKy6bWGj1fr4Iq12m4Zbef7sdgCeVBOVy+/7wHxtASJU1kN3d1vNXD0KiLXvQQgpQPmT/84L6yjo6MblKaKVdGuiScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfAS1e2bE3hJdMmPqPf/CguUbzLMoCqv3MVBJ+76no4=;
 b=YX3v200VMKYt0H5cLxlH6iIijpoxazCdXiNfSgKCRRH7VdFD4V8TRF1gW20iYRhkv1/U9CDWZYxaw4uRC15uyfuVmPk2NzH2G96W85N7pn0M6ZNIxp4fvsC9YkAEBVVwbxaCX7ZuERgEqUE19Cm7IDnGZrekyN9hgZ+YQUtq+aI=
Received: from SN4PR0501CA0117.namprd05.prod.outlook.com
 (2603:10b6:803:42::34) by MN2PR12MB4318.namprd12.prod.outlook.com
 (2603:10b6:208:1d8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Mon, 3 Feb
 2025 22:32:46 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:803:42:cafe::2b) by SN4PR0501CA0117.outlook.office365.com
 (2603:10b6:803:42::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.10 via Frontend Transport; Mon,
 3 Feb 2025 22:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 22:32:45 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 16:32:44 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v6 2/9] KVM: SEV: Disable SEV on platform init failure
Date: Mon, 3 Feb 2025 16:31:58 -0600
Message-ID: <20250203223205.36121-3-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 602bab0e-45aa-4413-a6cb-08dd44a2ae8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h+t1Z2HoeQsgDKVRbAMTTA9kSGOUhfDiN3VN8/T3vpPpM5G4/Anf0xNNb7nN?=
 =?us-ascii?Q?MlhiI8QHpcwreCtqWf4iNch0scF+xhJn1Ncd59ECp0bMCLRkJGDOmqVIQE7U?=
 =?us-ascii?Q?OI+LAtIUIawn2W4LUqVm/GfXGjtzwSBzygQ6ywnxf4QijbdXLbH4mOBfX/LM?=
 =?us-ascii?Q?rMn/tFjEiaAb18LCeXsNP3IFM0+ZnyXDsOc+btMeFKAvY2yx2Zugjp/B6jJy?=
 =?us-ascii?Q?lzLiynuCg43MMxrz97Htp+HhIO4qdm4Ur2nuk9nzGles/FpCM+iCphx3Qv50?=
 =?us-ascii?Q?oDsHLzEV69bpuetytN91VVMDdLLf/7GkDiruQlOtbAJZ7UmJ57uDjYMOjIiY?=
 =?us-ascii?Q?lE29vnBja339kPa8FbWgxnyXuyEJfEAnE2eSZxF1a1zDw7gsc6pvuIQr2CfG?=
 =?us-ascii?Q?sZH0ARTvI62sL2SqZ1XK09emFRrBjJ40mXC2JmzoaLlx45iTCg4e+wQbv62Y?=
 =?us-ascii?Q?slC3sPScLXoUM3OVdZn980YRHQI3Eau5EZtnhJltgHtD8eKK1Nkvll3bMcnW?=
 =?us-ascii?Q?rqA1PZu+d6SUSg1Q9SAvBdt5w/u4prkeD4aIO5BxffZaTzB2VyicdRwsPGZs?=
 =?us-ascii?Q?DMgCkL0fnYVaR2SpEonCEdY7gf4u59EmFm7icxvhwHRjllUaHW22HvEq39qO?=
 =?us-ascii?Q?AI/dlvZbO4aDW5mm0SD51DYANhmPHIEEhz3f8MWLjSbxUJUeuAPH1M20/jqP?=
 =?us-ascii?Q?+pYUuuf82Yhv6DthjWIFjFzpdfZfXsuz6ajFKrYaWm9iin5CBFXcXxjd3FOr?=
 =?us-ascii?Q?I6/DO6vX64ZwF7vgC90pHuLhsDtWgybLK1NFR+rsVpkCqk5AWi8GiVsOmj7d?=
 =?us-ascii?Q?Ix1OVy0LUx4ivAMP48nCLNOQqRmNGL78RurGyOjrK9Rtb3iEGLkhNzArAnR1?=
 =?us-ascii?Q?EGliR0bh7+3SJ0BiLRE/R3Qva7D/eAs3Lp5xiO7CmZ5F4iUaok4SrRLIbMbh?=
 =?us-ascii?Q?j1dhSPNVQ5u4zeVLZ27CrNogIe14Ma64+t0CFJKmR0Hyw+Cqqhh0nO5pvtiC?=
 =?us-ascii?Q?E5T8zk/XlghHa2Rx0rRic17PEz+06jHWj2k8PX3q8sRvfMHGodaw+qP+C1Nl?=
 =?us-ascii?Q?JM6wQ2DC8WPWHrP4h7/MM5kkvwE81/AjKchpUjIPLgpDNcak3F7dLLNTw8pX?=
 =?us-ascii?Q?eGsKtIAZ/yJm4+FFICBkay/6qJVPMhGXI/71/u520cOt/5alq2CaCCihc+7S?=
 =?us-ascii?Q?20N1M5WyPmES7laRheVEqGPyaa5sD4463JAUJ/ahM7vtdqtymck8Q+i54+W6?=
 =?us-ascii?Q?RCF9fsY2iFXo8+uyUG0svUIshvy4cHjeWgSsOmFvcaen1NV9Id39ckA1jnB2?=
 =?us-ascii?Q?znFmjQULiSF4DJnDn2rTeKnX87wU3Kv5VZJWiRIZnYPRrAYtO8r9qvhCdVy0?=
 =?us-ascii?Q?gHkQfErJJItaADFKXN1J06Yt96QmnJ2SjxrZVY8If+diudy2XFAlT4gZ4ACE?=
 =?us-ascii?Q?e0J058O6R75W/rsA86OIMfAU5ZM7WxWfKWLS++pCPiHl7uKzMVhaLh5USuL6?=
 =?us-ascii?Q?XV14h48VHzwz9SI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:32:45.9606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 602bab0e-45aa-4413-a6cb-08dd44a2ae8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318

If the platform initialization sev_platform_init() fails, SEV cannot be
set up and a secure VM cannot be spawned. Therefore, in this case,
ensure that KVM does not set up, nor advertise support for SEV, SEV-ES,
and SEV-SNP.

Suggested-by: Nikunj A Dadhania <nikunj@amd.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v5..v6:

* Rename is_sev_platform_init to sev_fw_initialized (Nikunj)
* Collected tags from Srikanth.
---
 arch/x86/kvm/svm/sev.c       |  2 +-
 drivers/crypto/ccp/sev-dev.c | 10 ++++++++++
 include/linux/psp-sev.h      |  3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b709c2f0945c..42d1309f8a54 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2957,7 +2957,7 @@ void __init sev_hardware_setup(void)
 	bool sev_es_supported = false;
 	bool sev_supported = false;
 
-	if (!sev_enabled || !npt_enabled || !nrips)
+	if (!sev_fw_initialized() || !sev_enabled || !npt_enabled || !nrips)
 		goto out;
 
 	/*
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index b45cd60c19b0..bd166b997ac9 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -81,6 +81,8 @@ MODULE_FIRMWARE("amd/amd_sev_fam19h_model1xh.sbin"); /* 4th gen EPYC */
 static bool psp_dead;
 static int psp_timeout;
 
+static bool platform_init;
+
 /* Trusted Memory Region (TMR):
  *   The TMR is a 1MB area that must be 1MB aligned.  Use the page allocator
  *   to allocate the memory, which will return aligned memory for the specified
@@ -1358,6 +1360,12 @@ int sev_platform_init(struct sev_platform_init_args *args)
 }
 EXPORT_SYMBOL_GPL(sev_platform_init);
 
+bool sev_fw_initialized(void)
+{
+	return platform_init;
+}
+EXPORT_SYMBOL_GPL(sev_fw_initialized);
+
 static int __sev_platform_shutdown_locked(int *error)
 {
 	struct psp_device *psp = psp_master;
@@ -2427,6 +2435,8 @@ void sev_pci_init(void)
 	if (rc)
 		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
 			args.error, rc);
+	else
+		platform_init = true;
 
 	dev_info(sev->dev, "SEV%s API:%d.%d build:%d\n", sev->snp_initialized ?
 		"-SNP" : "", sev->api_major, sev->api_minor, sev->build);
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index e841a8fbbb15..55ef473953e3 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -946,6 +946,7 @@ void *psp_copy_user_blob(u64 uaddr, u32 len);
 void *snp_alloc_firmware_page(gfp_t mask);
 void snp_free_firmware_page(void *addr);
 bool snp_fw_valid(void);
+bool sev_fw_initialized(void);
 
 #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
 
@@ -982,6 +983,8 @@ static inline void snp_free_firmware_page(void *addr) { }
 
 static inline bool snp_fw_valid(void) { return false; }
 
+static inline bool sev_fw_initialized(void) { return false; }
+
 #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
 
 #endif	/* __PSP_SEV_H__ */
-- 
2.43.0


