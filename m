Return-Path: <linux-kselftest+bounces-13524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704C92DB9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 00:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB151F26866
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 22:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE4614AD25;
	Wed, 10 Jul 2024 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5sSJaeGI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF61487C1;
	Wed, 10 Jul 2024 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649213; cv=fail; b=tHLDUGGKwGdPQpvW4tnhOIaFc5TXqTwCm2oXLShMrkU0IdijN3dXdUf9LLQZYSWg2HEKQgEA490I4Mj0/Ep4xheYcV4o//oYrP/qvNA/I0B2vVjP31Dp47QiMVYe2UgJVhoWBAxAntEMKqAG9dn7acmlk9wvPV1o5ff7j4WQY20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649213; c=relaxed/simple;
	bh=gtU3qBaKPv6wF4qhoj2ugfNotsBVcQOyA6Q12B94lb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiENKdHpSmbELqZsaaq1bQejRJNQMe4pXAQvmQsuXeNY+S3k25T35kxMEleNPQw6Kee22IMRwQRAdKCA0IYbwtdU8T+D+Vua6vgBMVs+joTKgj0Y3HYTrwvcOxw2gbpORX1gEOH6x+pFGyw+FGx/TgPLh3nGfQrBJZrQi12oYzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5sSJaeGI; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B073m3GaT45BVrvqJyJ4i5BrNxCbjq0x/0ax9BwQ06n9Pn8XNnlAMxPByZrRe7s0WP0onkEIk/JOW3GqA58qObsaWYwXXIoTQeVNLoKiJ5348zPyTM5cxSpofcVvjMRY42Tss9UOkfDTgSramUQ8E5U2Q1afILzEk88lgRo/k8zU7tHFpj04nQDBv0Q4g0XTXc+EVpc1tYFr9PVg8rEPfWoL/NUDyNRXXk7/lpu/Q+lgI2bBG4NDsgEgylQ67CGyV6PXrcn/vydZHJZgaqo1lJmusjaayZm8UlcZGM12UDjU3d67pq6E5/oHmBJY5R8khVK7LPSIbsgJ5jamakHJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDImZNTo8FDvD6FNJzBeJ6/QJZ0FGLwssETrXbipEDY=;
 b=mUH+Q4cHqp13ssyMkANYPwRwRma8A0zTM55X080m3+cZ6GngP4OM1L6ZmySLPK6vKzpQK4aD3pmj2smnYgPCeJPKYAWPjdmkJX9X/ycKYfIfu077l3oXxrvN0Wo6y7bh4Kdiv5C8cxSuIH1wkDcl3kQpx9T+f15OA/pTzFmi9+Uy//xq8IFvi7HH9DjP6cu6bJd3LyliR6d4adM7rl1/6tU97ntrwS4+/FHgoTSxT2PCr5Xql9bYq3MMSR5iXNyW+rshPnAGYahpXCZzryXoipn8Iy1/ROLE07wZsLObVwmCWqKzF9rF6KMdxPufaVmwMVASYTYyAQaO0f3DSEXuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDImZNTo8FDvD6FNJzBeJ6/QJZ0FGLwssETrXbipEDY=;
 b=5sSJaeGIheyk2NkGNtlBeVM+MkvrMC0l+JIES3k1mCCFe9SHWsSayBGc9XrUZdglTlP7dbxPiPep7LLLIgi6IGmJHwoTu0L6yd5vNWRSLgf3jWLc+CSf5Xs0ecy348e/feZUE2r6oUAPF7AYE4MgltpVaHN726NMJNM9CfgWYNc=
Received: from MN2PR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:c0::34)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 22:06:49 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::b0) by MN2PR05CA0021.outlook.office365.com
 (2603:10b6:208:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 22:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 22:06:48 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 17:06:46 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <shuah@kernel.org>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC 5/5] selftests: KVM: SEV-SNP test for KVM_SEV_INIT2
Date: Wed, 10 Jul 2024 17:05:40 -0500
Message-ID: <20240710220540.188239-6-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SN7PR12MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c4b485-eb53-4f86-a22a-08dca12c9872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r4hWDWniwoGwCec+oA8VHNSwx4zjmNXud34RXMmpp1rqwVbeJ6eCKjxmhwR4?=
 =?us-ascii?Q?tKyIC27YQD8N4+NnDA+267qkqkv80dlw6yI22l/AdXiZor8yfKAd3v0Ds/90?=
 =?us-ascii?Q?MYe5lGqNxNSRcJ+KfJjbMXC6aOYUsydlOiDURR6APYdiSZj6ylC6CVa7MT8l?=
 =?us-ascii?Q?Eq4AoPrRGMGLRpZaRFQz1bS+V0/LN90SLDOsQYY9cyW58FNj5ENWtXLtU4iT?=
 =?us-ascii?Q?IFPQ0dgNtS7y2t6zyVzV+VhfEoDJhyUMnXZHdX0DSsAWNPCkIHg4QOrktAkx?=
 =?us-ascii?Q?EKm8BAHnpiNujFSiQPH5fMXHKuwedFa9X9dhHiq88spp5q2t8RWz766Os03r?=
 =?us-ascii?Q?SEa+/w25GI51Im9XP6fTmo5QRjK4G6IZtuD4Rx1gtP33mWRW49c69yoUCFDH?=
 =?us-ascii?Q?cnkKGYOsNKbypCeshKU3KJi48+/xwCVBiG19b3iWRaKjiLrzxFNNYW3TdiC4?=
 =?us-ascii?Q?DkDfGVTiNu4+A7BxmHOnPDAQukZaAM7i8TpdMW9thrTy9XOMQdXny1CghKlw?=
 =?us-ascii?Q?dv/yTAaQKn4kHplDaRMz5xFQdsPdI7hpRxlFATsq4PU0myZsYJOaGCb+e1mM?=
 =?us-ascii?Q?aCsxdIn+BwzCfaMkx0sXWI/svl9z+WU90iP+mqjcRs/uKPgX/CUzQMB59GY8?=
 =?us-ascii?Q?wLHwvh5BNJYHTBjKG37PMrvOsLoxp8KH/nHQ5FuNUO13NQfk2SX2OHA0akpD?=
 =?us-ascii?Q?i17YCakCDwTRFTZgv5qogU6ouUUdm8fSFE+4JUjJkI8te2thq/UEicctlx0v?=
 =?us-ascii?Q?CINqBaKhZMOo5ZL/BziEjcZLb+g1cdItMJ2YtBuv4HFVMlt3DWE9hW7ZgPmn?=
 =?us-ascii?Q?6YRAwK1VQaA+k4k4mqu9HxNitRFcpiZdptEvj7GOMouc0P3t7j55rxHaQMDi?=
 =?us-ascii?Q?1OojSZ6coOQH/3ouW8FLZ+DmqJCt3JLdeBrCAQsifhnJNzZk3m9iAQtasWKC?=
 =?us-ascii?Q?aiuYTrmdpeyhH5OlFI1o4tqSUYCi5/EW9C+irRmBVcfk4ChgDiYoUKi9bLBF?=
 =?us-ascii?Q?9rgu3LbCPFZhyfxXCV5XeUDLdGhdml+FWItSma9d5AtYdEvTrQPVRRlmSZMl?=
 =?us-ascii?Q?59agTpj7Z+ewO8FG0MIjJbBdD64+mGbQAprhBPbOE4lt44lKuFM6iN/XKPkZ?=
 =?us-ascii?Q?p01gxTu/puY00xukGSpMqcyvaW1qizo1Rh/EYPTAqEHFwtDTEN7YEJuSqSxB?=
 =?us-ascii?Q?4Q64Nj+TrkHqtjlPGnRunpA+QhpLukiS2imxxmOLtsDmQhIBOvZdCOQEf/oO?=
 =?us-ascii?Q?RG1h9hg7EP7T20nVRwidCKqzofwThTiChAF1baJRFJUoFjOrCeVBS0LXu2b0?=
 =?us-ascii?Q?NAdBpVLg8u77vR8WXAMgxhkUCOLycFmjSmrjx1+762tPWwi95RTGJeoLQr6V?=
 =?us-ascii?Q?HjOHhqP3QKrbZTLcKaSokML+SatjHb50+SKT7h9EG2M6UhcnNrYcA0KsV8Yk?=
 =?us-ascii?Q?72FScAwRayavnEbUeklfSlfnOycXmIFa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 22:06:48.4456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c4b485-eb53-4f86-a22a-08dca12c9872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935

Add SEV-SNP VM type to exercise the KVM_SEV_INIT2 call.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../testing/selftests/kvm/x86_64/sev_init2_tests.c  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
index 7a4a61be119b..68f7edaa5526 100644
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
 
+	have_snp = kvm_cpu_has(X86_FEATURE_SNP);
+	TEST_ASSERT(have_snp == !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SNP_VM)),
+		    "sev-snp: KVM_CAP_VM_TYPES (%x) does not match cpuid (checking %x)",
+		    kvm_check_cap(KVM_CAP_VM_TYPES), 1 << KVM_X86_SNP_VM);
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
2.34.1


