Return-Path: <linux-kselftest+bounces-15557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1D6955157
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 21:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D9CB23A24
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D63C1C3F11;
	Fri, 16 Aug 2024 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EpDdcDIH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F378C7D;
	Fri, 16 Aug 2024 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836215; cv=fail; b=u2NVyOG+zwCCGD56WP2PsscUEUVmUkn7OeTtTF+xDcBQQzsrai/fkYM8utWVA+POzbZYVI5K8QGPU4dWELEAf1+00CzLR7xXut4WC4biThS8NitTjHmnYOM78Juip+Kj3ohq3g0lcHl9fZbtA/49DAOJcwY9YdARxmqRDjBRTuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836215; c=relaxed/simple;
	bh=JB9sUIYO6DnLGORuHJch66YMSGJ0Md6ImACNLwLkT3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Go0YU/DCWpvId5Dk7F0szkVuDMZg5u2KPtw0zM+iULnd5u1LG2a6T7Bot++kmcnVjecrnvlanZE7CkGki8vL4tzpyZepePErWGUPd7/cl2FwWNoXRPEaKT2wh4dpNQ/wxuLFNdK0hMqejXfQTFxo/xp04FT/AJ46hNVYkyl9lzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EpDdcDIH; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC7dC4gNEYTyvCyd+Esvcv1nl+/jJT1MCgc2NiVCWEysHjyT6Ltqjsakzr54tNwXx3wqglSBLQiyan6hzfnW2jbzuFGUq4aZ549PJNEo86HirnSSJ/66OxVY0eJhjxd/T3JyvKKVtZiXQkQQtZTTesAW3UlYtCXxHCVY1+ejby45EWDJBERAPewhA2u47jxy+VO7W8pHDkdFJnjVcv7zRJND+41w4YHGY0NfQC2okmZCTlokkni5uoLxcoCZGVtmWcYaksRB0k7nmL474kHAJ1W2V9ge6NplXzSi8f2LSz2pZ+tnS2xLViTUOWnEFE8trK1Ou0jeA2HJTCxRIhfwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw6Yz72/tjVZeurtHL9dYw5golvC71teAzlJ+iE06wE=;
 b=CBLU37eCYKRkLGPFYPkHXqX5ffxf6aYjiNdm3G6vcOHdjF2PuHt7TiwioxeOKMcPEeWDX6lYxk5Uy5Xf9PqzzY4Yz31B7fXeyoBVTpdDmcU1qh/aXKKKMBT7V21MKhG4ZLALY8eyE2+uwaHpfFmi4kRI3fqGHVITPsqlP02TfTo7KG8MCM5dX7YyWxwlU6KpydntEJxGCWlR8dJ9GtR4vGdL1oXrgiduClw/rXXK2U6BsT4iGYz6Li7B4h21lD0dJnsIv/fyPRRCqmBpnlJXKCemrAT8TK8q/SZ4U+GlkLchSq/7aZfULtrCazUNmguiJjvw5LeKFsLnZzg+2L3c+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw6Yz72/tjVZeurtHL9dYw5golvC71teAzlJ+iE06wE=;
 b=EpDdcDIH9sjVPfDYptZ9KKuvgoLJf0H3otCWlurj/ITnC0kXOk1Ar0FSyCWxsPIAjCyG/PT7mTkCGRueFzOnqg9UwFv7rQNYDE7w7ZTsTVBkwRh3MGJ7DPViHyAlk/ztW5k7M8H4l/rbaGEsDoYIWfqHPCbh3TlTj0mgCynU5Mc=
Received: from SJ0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:a03:39e::6)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 19:23:28 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::85) by SJ0PR03CA0271.outlook.office365.com
 (2603:10b6:a03:39e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 19:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 19:23:27 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 14:23:26 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/9] KVM: selftests: Decouple SEV ioctls from asserts
Date: Fri, 16 Aug 2024 14:23:02 -0500
Message-ID: <20240816192310.117456-2-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8d343a-3eaf-4613-fc5a-08dcbe28e7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TnFXCeb7688YoYs3h5lRwzvijQTYVZDVS1gzgWztI3uHTiqwG3843UyA1vI4?=
 =?us-ascii?Q?z2XY8ASRO0BBrQOwYkAb2kgd0wnyH5B279QXt6znVKpPwbYbSoVn8wSYk2T8?=
 =?us-ascii?Q?iFjXxE93UjKE920MDkLiquQlE6hKSdaY3B5GAoNeHiwNO/F/93gcc1MRaIIq?=
 =?us-ascii?Q?xwFq0zvRCG5mNBG25ncmxNh+zk4xMEJ35NYNtusQ7MLjRWeduK0RyuooQv6G?=
 =?us-ascii?Q?p2fGpaYrcqyoTFx4nl42niFabGvYhtrzG3o6ifGCC+Ap8iOyMs02M5t/zWrb?=
 =?us-ascii?Q?2cLIlnAOK3PYOBFCyxM9rsebNN4bjWgG19y69/XSx7TOKPhJr77wEKrp64Ih?=
 =?us-ascii?Q?xljczK3+i97WojkxdMRl8VOLxsFJ3mwTlP6AVJo5MQsA/n/26++BkfRpPOWZ?=
 =?us-ascii?Q?JbG5sgwvDIbLJODSN2s4a+G1JAeFKnl29UswLo6L3FBhVnVG2KQ1M8gR0GZF?=
 =?us-ascii?Q?o+p7hmgp2bYxhq0vO7jARyGSJsyUMc1hgoYwjmhyB2dq3+ct/jHVVHcA69S0?=
 =?us-ascii?Q?IOW47s9tV9G5BYC3TfYxONLQ+W06TRZkbz9F+/VfrxIsuLAa0wlEwqeOAFot?=
 =?us-ascii?Q?YEG4vB7PCO54L4sBruHJseIinC13PZvzGVQKlQbZin2PmvhMzudmot9fLfBj?=
 =?us-ascii?Q?TfjRMU3ls5nFXUe/uH+Y5My3tPNPAOA6gTitUJ18weBEgwhunck+IsX+6lIf?=
 =?us-ascii?Q?aeDd6qfqWTtRfoYVgRYlLtEvNOPLIFjSpq0lODONy1JEMncVoYTOQ/JWNZy7?=
 =?us-ascii?Q?tkkTNEXai+fEOMdYhMHQVRxtfQxHm5837X8vff0YLFVylYbVDZk/v70BcTBG?=
 =?us-ascii?Q?h/ZPSHTpit2kkm5RhxX0L8sG1EYfT7MpIcIxr2QRRCrJ1a+v6OrTnVUvWwRk?=
 =?us-ascii?Q?NvCfX+Iio5TgRG66I9M6+eBnPY9A3V1ciMcKsbUgl4SVPww/zPJX9TpvxRjD?=
 =?us-ascii?Q?uSNp5sv5EpysM+Gw4L9+v1C8Ertu7J6e+maYlJOZwvTG8V5Erk83YAwUiV6c?=
 =?us-ascii?Q?UK0md3/c0TonP+JysQf7TbEG0zZqWe2NFzVEljIf8/oYlBCg4s3KRsLHTNY8?=
 =?us-ascii?Q?9K2IhtWNOwlm0nc/+54qL72JJcQln4glxB2C1LgHdekgtd7uvGfISiKUOMUK?=
 =?us-ascii?Q?XkkMA59yJYkvRfouSud9kL8UoZHx4lSaHG69blt8VzUuYPskCw/g5b+wEofH?=
 =?us-ascii?Q?Ow2t8Csu8eck+v7P6h0+H3B2wbnORH8Bnbal/pJLO1prJTG0yjLA4xP93auN?=
 =?us-ascii?Q?CcJG02UmLRGZzuMxirc4a37uXXw1OsTontONZcjVJjftyBuRY1Gs7SGLRLVY?=
 =?us-ascii?Q?lfIE7CXiaMdl4tRoH/DOEa2Cwpz2XzIk37L3iDxcu4JSNBFXGTDYUQN6nveq?=
 =?us-ascii?Q?2zUD6gLS2luGWdFi/zXY6D8t73kkXFbMBh8YpfAVt4nLNxNV5sLhBTkX4/av?=
 =?us-ascii?Q?KKIWLjOVxijLgUUNqaqiJS6U/BvLlLUC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 19:23:27.4817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8d343a-3eaf-4613-fc5a-08dcbe28e7c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025

Add variants of sev, sev-es launch path that return the status of the
ioctl call instead of asserting for success. This enables both positive
and negative testing of the path.

Cleanups are performed with no functional change intended.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../selftests/kvm/include/x86_64/sev.h        | 22 +++++-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 78 +++++++++++++++----
 2 files changed, 80 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index 82c11c81a956..3998152cc081 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -27,6 +27,12 @@ enum sev_guest_state {
 
 #define GHCB_MSR_TERM_REQ	0x100
 
+/* Variants of the SEV launch path that do not assert the ioctl status */
+int __sev_vm_launch_start(struct kvm_vm *vm, uint32_t policy);
+int __sev_vm_launch_update(struct kvm_vm *vm, uint32_t policy);
+int __sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
+int __sev_vm_launch_finish(struct kvm_vm *vm);
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
@@ -82,15 +88,23 @@ static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
 	vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
 }
 
-static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
-					  uint64_t size)
+static inline int __sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
+					   uint64_t hva, uint64_t size)
 {
 	struct kvm_sev_launch_update_data update_data = {
-		.uaddr = (unsigned long)addr_gpa2hva(vm, gpa),
+		.uaddr = hva,
 		.len = size,
 	};
 
-	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
+	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
+}
+
+static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
+					  uint64_t hva, uint64_t size)
+{
+	int ret = __sev_launch_update_data(vm, gpa, hva, size);
+
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_UPDATE_DATA, ret, vm);
 }
 
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index e9535ee20b7f..290eb0bd495e 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -14,15 +14,16 @@
  * and find the first range, but that's correct because the condition
  * expression would cause us to quit the loop.
  */
-static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
+static int encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
 {
 	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
 	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
 	const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
 	sparsebit_idx_t i, j;
+	int ret;
 
 	if (!sparsebit_any_set(protected_phy_pages))
-		return;
+		return 0;
 
 	sev_register_encrypted_memory(vm, region);
 
@@ -30,8 +31,15 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 		const uint64_t size = (j - i + 1) * vm->page_size;
 		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
 
-		sev_launch_update_data(vm, gpa_base + offset, size);
+		ret = __sev_launch_update_data(vm, gpa_base + offset,
+					       (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
+					       size);
+		if (ret)
+			return ret;
+
 	}
+
+	return 0;
 }
 
 void sev_vm_init(struct kvm_vm *vm)
@@ -60,38 +68,74 @@ void sev_es_vm_init(struct kvm_vm *vm)
 	}
 }
 
-void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
+int __sev_vm_launch_start(struct kvm_vm *vm, uint32_t policy)
 {
 	struct kvm_sev_launch_start launch_start = {
 		.policy = policy,
 	};
+
+	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_START, &launch_start);
+}
+
+int __sev_vm_launch_update(struct kvm_vm *vm, uint32_t policy)
+{
 	struct userspace_mem_region *region;
-	struct kvm_sev_guest_status status;
 	int ctr;
 
-	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_START, &launch_start);
-	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		int ret = encrypt_region(vm, region);
 
-	TEST_ASSERT_EQ(status.policy, policy);
-	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
-
-	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
-		encrypt_region(vm, region);
+		if (ret)
+			return ret;
+	}
 
 	if (policy & SEV_POLICY_ES)
 		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 
 	vm->arch.is_pt_protected = true;
+
+	return 0;
 }
 
-void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement)
+int __sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement)
 {
 	struct kvm_sev_launch_measure launch_measure;
-	struct kvm_sev_guest_status guest_status;
 
 	launch_measure.len = 256;
 	launch_measure.uaddr = (__u64)measurement;
-	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_MEASURE, &launch_measure);
+
+	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_MEASURE, &launch_measure);
+}
+
+int __sev_vm_launch_finish(struct kvm_vm *vm)
+{
+	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_FINISH, NULL);
+}
+
+void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
+{
+	struct kvm_sev_guest_status status;
+	int ret;
+
+	ret = __sev_vm_launch_start(vm, policy);
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_START, ret, vm);
+
+	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
+
+	TEST_ASSERT_EQ(status.policy, policy);
+	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
+
+	ret = __sev_vm_launch_update(vm, policy);
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_UPDATE_DATA, ret, vm);
+}
+
+void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement)
+{
+	struct kvm_sev_guest_status guest_status;
+	int ret;
+
+	ret = __sev_vm_launch_measure(vm, measurement);
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_FINISH, ret, vm);
 
 	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &guest_status);
 	TEST_ASSERT_EQ(guest_status.state, SEV_GUEST_STATE_LAUNCH_SECRET);
@@ -100,13 +144,15 @@ void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement)
 void sev_vm_launch_finish(struct kvm_vm *vm)
 {
 	struct kvm_sev_guest_status status;
+	int ret;
 
 	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
 	TEST_ASSERT(status.state == SEV_GUEST_STATE_LAUNCH_UPDATE ||
 		    status.state == SEV_GUEST_STATE_LAUNCH_SECRET,
 		    "Unexpected guest state: %d", status.state);
 
-	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_FINISH, NULL);
+	ret = __sev_vm_launch_finish(vm);
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_MEASURE, ret, vm);
 
 	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
 	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_RUNNING);
-- 
2.34.1


