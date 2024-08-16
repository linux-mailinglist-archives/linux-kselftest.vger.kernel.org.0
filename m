Return-Path: <linux-kselftest+bounces-15562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651D7955166
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 21:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D26B23E8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651061C4635;
	Fri, 16 Aug 2024 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nXiU418R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCA01C3F32;
	Fri, 16 Aug 2024 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836276; cv=fail; b=ZbxxpHLCUssHkx67pa2nj4GtunqhyT1Vh1Y4Uznq8UFWRSMzVhjvx37CBxb+iJqnHqa7lXsX1vm2E03vayrhRA512vLil1ZX/Itn4a8TN2mBVBkNyOYq6JJ7FvXzlgaXM2tFYyJGMEpieVW7B3R8xKVQbfe4pmDKXc30S86ob1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836276; c=relaxed/simple;
	bh=ey6nI2l3D4+9GfClCS9p2cOk+n8CYkiWZD8oJZUQru8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGL9UAZkyrjOTK2hjopQ2+40bdlh9yEAclGoURhSn8UiuNSNdbnpQnWfigS77ZfIwWa4nyfqgbCeAKRwCEOpjPbVssWrisL00Y9/a8MzZ8kLGhxwxkB8duPcKz32wXlUjfjqqLqSOF++WyK+hM1D5y00KqKw38dMehdB2sXjWdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nXiU418R; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZoJjlE2R3tX9s3DkF1b4BcwwnTtiN/wXGAMMavjTEq9E9eI82F9ASKr4MumJGIi/BZybEJXy5v578HIhOLK/Et4GWVXf3zDHpmss5AJ9CjssVKewJXjkWqAigV2neqTd8xG3qBgRFhH66TqBsNa+ifrLInXlBGZPhOL4W1fSS8gXWNaq4SF9oYk0gwpIWRn08nfCqYHo7DJA+ZE0Qjq1D2uD76vJRYsxZiv3/3d9Es0rOuobtNmc/jTvZbVcSVuj4hXReWeKiAuSbgtJSz8MXtJxgv4tNLYH4Q3lH/EPlWJEdg8p8cESn0/wPvzZeY5nVzXcSnv/eqogbyXd8Omgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwjcYrvsvWYVwD4AlWGt3YT9WCWEQ+3QVrWeNkt3rRo=;
 b=s0uf0ytAIoLqLhpiBhcvpdn1N1Bw8+L22MtdzHagmGJLUeqSe+Ys2fGsLMIw6TlK0PVHKM7PJqR8jzSjHh5sSCjDR3oPRu1/KdkT0RVIAoJxlWJL/lwEs+SPfiNvVPtJV7owhT8kfJcYRfTrWPrU/q0SHZzXGiaU8rP055lmuhZKneLbc9ShE8DrYBZ8uLypcJOsLpF4mSj5FCaxkUfaxPaNs/DryS9wHQtlEnYeI8GMV/ja0n7uJjsVT0cEfPOdB+meFC5RKvrs3tJUIRV6XVGZcxm4hzC/iI5gQ+q24lALYF54AIFjiUbBraYYxNV+ij/Sv+LeDL+b7c4Ea9rOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwjcYrvsvWYVwD4AlWGt3YT9WCWEQ+3QVrWeNkt3rRo=;
 b=nXiU418Rk0gqf+AoJTK/Lio28BjHoDKZc/EavUYTC+b9iWxHIZNRg78lqVBm5i2ZETmV9YMlkelCyAn6+ngPOEf/t4TGYMOnP0RIsDJ86K/xooM0EDlFrWySVoUceWYkNnkoKv+cKDt9xqV4JDeEjZoVfMOyL6mq7qTiLu6iQVU=
Received: from SJ0PR13CA0136.namprd13.prod.outlook.com (2603:10b6:a03:2c6::21)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 19:24:28 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::61) by SJ0PR13CA0136.outlook.office365.com
 (2603:10b6:a03:2c6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.9 via Frontend
 Transport; Fri, 16 Aug 2024 19:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 19:24:27 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 14:24:25 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/9] KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
Date: Fri, 16 Aug 2024 14:23:07 -0500
Message-ID: <20240816192310.117456-7-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 163ada2e-b03e-40e9-e198-08dcbe290b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MGbhRBcxh1ZsjU6tnCkeuo2qKK5Zt2htPF2jcO/jqwF+G1dovveH5GsmnKxU?=
 =?us-ascii?Q?obvvk32CeQnePFaBFDXYIdWvfh7fmrGy2XOhO12YtKU/vSyFkhVrulaT5nPU?=
 =?us-ascii?Q?SIOqiCZaUM62T7DC7/qWH4JQ8/qDNlLwd/icaOANMC6WL1QxyogvNi6p6i3O?=
 =?us-ascii?Q?nQOx3182Ug4u5leMT9HUfi5FrAS1lDjbY0TdpySYAyLGywnw1/aHEUjexSB7?=
 =?us-ascii?Q?WnGW7AAi4LFRRAU33CjiQftJwM13nnE+pZMtFx7Nrg/UtS71+caVlBOQkLzg?=
 =?us-ascii?Q?C38b8ZL6aGB9vnzvKIhqjShi9T3b0Z7LFa7pE/bTAMUPLVddK+LQFwZXk7TY?=
 =?us-ascii?Q?kFfDjftYjONNNzqY1J3il250x3iG9NOInvgtPMQtngKSHsMrg7CkqVTbMdsc?=
 =?us-ascii?Q?BoKUrHwv+BjkRrBzV4t9DU4lxXbG7r812+J33CHsJqvOo9DYLkSV7S8XdFpC?=
 =?us-ascii?Q?k0VqQFEzyMFd2chnXmUa9BfJreaJREopC5ufRBE8uSKUdAqOY2bDj07b10m8?=
 =?us-ascii?Q?a7gy0Xq1b+eTa8rbPtqroRMIMcuypBRuiFgd3fNEs1+c5llDPDlVeEptxaK0?=
 =?us-ascii?Q?R9j7CSL2YLgHMh/KVUio2OfXHsoNG5qdHPP9wNBOdK2cpXJUuB5JyND2C+90?=
 =?us-ascii?Q?tqW7SS4RiQW0sQgo+JJuhllfXcCDkqsyiH20Y7p1Al4x4Y52zoLeEqGHAsB8?=
 =?us-ascii?Q?8G+PZqXKN3L/US5GPfDl52RzE9EsWoR6kOYDmmrXMJte8uh4VsODbTSYOcqS?=
 =?us-ascii?Q?UjU+ebP/idp+WVkAfHJYuQsCo1dhAIYblJcSN3kjrfNDwLDN1sVIGIDv3y7+?=
 =?us-ascii?Q?rjOLNxSE6/IqkCGvrKF1qUSyUqoqv9h2uacpoOXi9ezAWZs5Xl9LuD//9i+K?=
 =?us-ascii?Q?KQb3k5EqCPMH+NeFYk8RJeSDUi8N4HfpmILL5PVKCgEJpFqy83r7jUmtMqL6?=
 =?us-ascii?Q?zgG4XG1+b+HIC704L5PqAMf4AtlSgqlCXtTAZwCBfoGXnAlpnNIg29B4zPOj?=
 =?us-ascii?Q?hpbWw7yA/bnIJhioAq7Chu8/+MrB3kuWKsSpEXS/O+ijxvo1cbwesyuE7Q/o?=
 =?us-ascii?Q?Ez6LnrQLaovMJk6RH8qACq2UtkS/p14xIwARw8rQ2my4wkRw/3O84eFkL2wc?=
 =?us-ascii?Q?5IQ64IXZry67gafP+LCKeBiPLd7P1XWTml/Q2uo+vtUx6GtiGxK7CUSrXYRc?=
 =?us-ascii?Q?vqau4caw7aTSkAQ4ovmDNQ6z/4lpYvv8SI3YbCwo/vdIgqASLogoixjq54d7?=
 =?us-ascii?Q?1cGYbBicDYcLUD1gjAVYnQXsEiS0GsCjd+9iki/6FXjgoFXqZHHgyf6SWn3X?=
 =?us-ascii?Q?Qzs0CUSVgrW8DnSl/snmu7pixNbF4v7C9XYDXV7SXI5EplVbqldSY/ZwQdzt?=
 =?us-ascii?Q?WON9IvO5bXV5M6u1zX+F4HhS6tOFOlYKVjMwUStORxRtuB2ln3OamfAsC2Hj?=
 =?us-ascii?Q?9Aw+e6Tfty8CIWajD8XUOD7NgHHbaanK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 19:24:27.1344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 163ada2e-b03e-40e9-e198-08dcbe290b53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

Add SEV-SNP VM type to exercise the KVM_SEV_INIT2 call.

Also ensure that SNP case is skipped for scenarios where CPUID supports
it but KVM does not so that a failure is not reported for such cases.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../testing/selftests/kvm/x86_64/sev_init2_tests.c  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

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
2.34.1


