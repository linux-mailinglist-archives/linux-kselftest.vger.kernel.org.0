Return-Path: <linux-kselftest+bounces-27225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0170A4018C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBE94201DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95476253F0B;
	Fri, 21 Feb 2025 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ydF8IlXz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9C253B7D;
	Fri, 21 Feb 2025 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171755; cv=fail; b=SE3MiVdgKYzbDpOT0n9NJrhFxKcYvBJYIi5Mk+zIpNRQHMVae/k9E/PxL+cG+5N4GfuDlo4S2udMvByzvEMOYh6gpzJRAxcvd97f3vqM9peoUcj3OBi/TAVS4D26HpZ1Gi8KjxnTuj5sI5/ZyvWpvWIfmNiZTd7R2FmT4lPo7zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171755; c=relaxed/simple;
	bh=A6Ex4kXAt5vwR94gZ9EiRS/RwKr6itF8Jiyj9S9goKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzX1HR2E0LlIcWXfUhm3WmcJaB3C+WawgMSlnDCBbYjOASLyD9he+8dwjigbuadnTyOY6lThStlEBcsxUQbuaar8arKq/AA30ItazRlzQHKqYHLeyNFtR1W2e8wP2djK5t/hXG/CPO+WDeMU9BBEfBxv0P30bueqzXK8L6ofYg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ydF8IlXz; arc=fail smtp.client-ip=40.107.95.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHbPBoAR7Jw1y3T9GlfkfJnDwPfNFVrhJqRVnKOEko2oj/Grv0LwujSA98YttwSNQ7w1QVbtIb5zv3PS9SI7s61hTaqspCL5mULFqhjZEyuvGkwH3JPr5CH7nteFYRlAFhwGnLZhIlvm7VcuPxmQxpFz9Yu4cQx21+yiBB9wcoRKYrt78I8j0K1cFcEGG5RBC9YlC1SiUaMLX/3yEUF6ZLhiw1/VGAC3crC8lfr99f5EVPdqnPmOz3jOVys9TrEfTDyZhLeqQlqGLjVgwARgi2xKW+CRfL4sxnA5aL025qdVQR6cLpmvveD/VjccxU0QK3umZhfmqBV00KeFb0FevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HLu+pTgiLakqtGsMaAZ2/hfYv7YYd6/E0yW0I8O61U=;
 b=HGDMxXZa8/f5jhxedqj5GWbW+te2YSHD8QsIY8ZwmxUlS8vSvMEaUputjeQ/cfQmC1edSajsPZPfr6UsLE5tq8+yLdtu6VcnYc83HFop6HFPHIzirBQ2eZ4LocqYzBJp9DInyNEvPh+OWmvnzH0FnsenRe5Q8W7INI/1e9XxlEnOx9LY11Rs2h+uz1zOD3YtDZeMZ5rzMMI01Is+WMGnwGBn1b9eOZdEsvGONl/cQyMxm1Cq50eUm37nrpUaV8F3F2vr+OzEMo9e0ia0qnzkCVEuk1By6HUZ03ZrcSsdZsi6DbOjOcJQChaXMfjbPsJe9HnjW9T+RMrG+FOJzhmJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HLu+pTgiLakqtGsMaAZ2/hfYv7YYd6/E0yW0I8O61U=;
 b=ydF8IlXzLBQKaBvGbKctnTkBaQuhiF8WSXcIEYAA+/PmmlduwPdGBErLmCqI4bTDEN+ilV4qivubvvRNH34VjC8EvNXRwpyxZsF/MvWWb69aqQp+j4HWWFxy77oGAJiyVExNLwvLDI6hjOzqzkvtHmsAWe50q49aG9onZqHzpTk=
Received: from MN2PR02CA0001.namprd02.prod.outlook.com (2603:10b6:208:fc::14)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 21:02:27 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::2a) by MN2PR02CA0001.outlook.office365.com
 (2603:10b6:208:fc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 21:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 21:02:26 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 15:02:24 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v7 01/10] KVM: SEV: Disable SEV-SNP support on initialization failure
Date: Fri, 21 Feb 2025 15:01:51 -0600
Message-ID: <20250221210200.244405-2-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 74079dfe-da3c-4585-68e8-08dd52bb0ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/4Z4Jzwm2o8nq2oms1kY1ks9LdvEDHcOlz71i87YY0++zw3J4Ittm9hDsaZ+?=
 =?us-ascii?Q?e+w9knZqhP3Qgqt8yiIKNqL68rpp89s2z6ZkgzBFSiYM8fySaHCzdsWYZExa?=
 =?us-ascii?Q?54G/bzhJU2SZvGSOyICLjgNxP72F2ABlREkMvf/WJE5K6x1cawduLI1QwSIC?=
 =?us-ascii?Q?OZwX7Q/GDezRwAoZx7yB7WUJNM825WI014CDgQkUZL4Lm7SE7u+1j7GYxgEN?=
 =?us-ascii?Q?zIU2oQx2ZyBRTKzCf0sKzpYVw1ztnyDAf1ZA0hBPu6k4onClZB7UNeLHYdDK?=
 =?us-ascii?Q?wi/LVJUgyHR6AjdEqmDyaVm1d4VHoLOpzW5Ol+1b4jcOKxZCRqkApMMK+xOS?=
 =?us-ascii?Q?pAYXKkEFTTlPRpeAeh56mk7yUMDIiDVjPFBb9h9ZAcMObwqLJl90VQeYuRkC?=
 =?us-ascii?Q?4S1Bg3v64S33fzKQ2K+nEK5ENCRC2zpDX+TVOJ0oaS2i9AEvRL5Zy3Ug34ch?=
 =?us-ascii?Q?N2gKwLciheTvD9AF3zsNi2hVhMoCXv+tBOcTTCmAUt/LBIWbFqNx3KxPr4Vt?=
 =?us-ascii?Q?ni1HUdRklYB0zLWghHOn2QIqQ8p79wHuVSMXuMMpghIs9GIk7xhUNaEFIIVY?=
 =?us-ascii?Q?Rr6Q6c7Qlmy56+IH0AVf27l3WUdRW7pgcuagR+V6rbuU3topmqCbRbosxaJt?=
 =?us-ascii?Q?8nTG+ZOATCJLjgvm8NUrkYVDyQgOjWqDarQ21a1PB9TM+R7jS5c/JXM2clTT?=
 =?us-ascii?Q?mDFyJVNvbncIRbpHzYKA0pTpqmfL5g4kgt5NYOQTVNYgDPqwOJ2jf9/t7gKa?=
 =?us-ascii?Q?RD4v0V367wTSz32QJzuLn968qSBT7TeyzBmiSTda+xL0gIIUYZik1N6mPSSo?=
 =?us-ascii?Q?LtCBcOJ75jvrcy4c2Z4tpqfRUqxOTlL+wcNVR/SsyYpSjuViKN6z7V4dYWtK?=
 =?us-ascii?Q?EGZOqSiAq+ncsLg34gN4O92U2OTegHWOC/CbCxa7FMFYcvz/C8znzeglNuyh?=
 =?us-ascii?Q?mz8iGOcxRafDvmSTbL/jjKmNjZjPIh91vhF8ejv0Q6Po9ibUgxIW+SaaiKI+?=
 =?us-ascii?Q?AMXTGbrMc1EneGR/zJo1hp5M4TWURftJFcrEeh2Mgcd0qXGFcpgKXpVw44he?=
 =?us-ascii?Q?5qaiEMZm33esSdMh+7qeetuuXz/l1Sk7+fw3h/77q/gQCAOEcYoAvBomjEdM?=
 =?us-ascii?Q?qiG2pgxzs/ohyWHn4nZjtutJaGYpsmCzhhA67Hte+CwEGfl27BB1LAj5UfqW?=
 =?us-ascii?Q?x4mJ5zmMr+IeTCOZiTVjtFQ8im1hAUKSbaHA/uEtL0Lx4ZeXO+xe2ee4ogTp?=
 =?us-ascii?Q?IcJ+69PzOXaeaCuo8er2vXlGIX3dwS8oN0KMimSICdbm8upw59JsqS7LIu0D?=
 =?us-ascii?Q?9NvI7flcfuZOP4laciSfjBT/+Qbt6izm/WXXpeI/cuyNhxytwlPPQznju/gi?=
 =?us-ascii?Q?MjnyG7mG+ocm9Cmg+SLeG9yqqQhrIq6toBsajSrcB+C+L436UOpy54YSABSb?=
 =?us-ascii?Q?1qdXAZxUV/fnB9J0sK4jEHuHmPlUTC/5GoVbTqvRJmlnz7noF91iuit0Q2tb?=
 =?us-ascii?Q?PSNoqRawjZO+BY4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:02:26.3358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74079dfe-da3c-4585-68e8-08dd52bb0ba6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

During platform init, SNP initialization may fail for several reasons,
such as firmware command failures and incompatible versions. However,
the KVM capability may continue to advertise support for it. Export this
information to KVM and withdraw SEV-SNP support if has not been
successfully initialized.

Fixes: 1dfe571c12cf ("KVM: SEV: Add initial SEV-SNP support")
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v6..v7:

* Replace FW version check with sev->snp_initialized (Sean)
---
 arch/x86/kvm/svm/sev.c       | 4 +++-
 drivers/crypto/ccp/sev-dev.c | 8 ++++++++
 include/linux/psp-sev.h      | 3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0dbb25442ec1..87b5d63a5817 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3050,7 +3050,9 @@ void __init sev_hardware_setup(void)
 	sev_es_asid_count = min_sev_asid - 1;
 	WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count));
 	sev_es_supported = true;
-	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
+	sev_snp_supported = (sev_snp_enabled &&
+			    cc_platform_has(CC_ATTR_HOST_SEV_SNP) &&
+			    snp_initialized());
 
 out:
 	if (boot_cpu_has(X86_FEATURE_SEV))
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 2e87ca0e292a..8d2cf8552bc2 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1352,6 +1352,14 @@ int sev_platform_init(struct sev_platform_init_args *args)
 }
 EXPORT_SYMBOL_GPL(sev_platform_init);
 
+bool snp_initialized(void)
+{
+	struct sev_device *sev = psp_master->sev_data;
+
+	return sev->snp_initialized;
+}
+EXPORT_SYMBOL_GPL(snp_initialized);
+
 static int __sev_platform_shutdown_locked(int *error)
 {
 	struct psp_device *psp = psp_master;
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index f3cad182d4ef..d34068c87a28 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -954,6 +954,7 @@ int sev_do_cmd(int cmd, void *data, int *psp_ret);
 void *psp_copy_user_blob(u64 uaddr, u32 len);
 void *snp_alloc_firmware_page(gfp_t mask);
 void snp_free_firmware_page(void *addr);
+bool snp_initialized(void);
 
 #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
 
@@ -988,6 +989,8 @@ static inline void *snp_alloc_firmware_page(gfp_t mask)
 
 static inline void snp_free_firmware_page(void *addr) { }
 
+static inline bool snp_initialized(void) { return false; }
+
 #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
 
 #endif	/* __PSP_SEV_H__ */
-- 
2.43.0


