Return-Path: <linux-kselftest+bounces-22071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76479C9650
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 00:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB0E1F22867
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 23:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5BE1BD9CD;
	Thu, 14 Nov 2024 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IQ/0qK79"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4CA1B6D17;
	Thu, 14 Nov 2024 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627753; cv=fail; b=C1HPduRsGDexkxU5a1oDdUsB/NoXLxZOOnFthxJOeWDC/oBMW0QaVBAN/VuECEAm1EwqUoC2tsLZTdVoy9JpLCLw0s+2Utwj9nY0Biit3z3ALJtX9DVggCGdgAub/PGX85PJQ3F43ohreMTAubGizd4ipOwW4k0FzFP7/RobXMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627753; c=relaxed/simple;
	bh=LtmQd1NXBc/0jbr8sYjc2ji2u/3IgAKe6xgNSiBrrHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4CClEPI0KU19i454HN3MTGeumVaw0QvPZmGfxR658bC6xSW4l5n/A6G9ga2hNmVWo/6NERXWEPfURqPDYZrNmAtLs5ysxCCduf3jNx5ZTl5GLHf8IfyEmSinBnyHI3hGa4yn1yWRUsFtbmTE//8q15FXq9lDNoxjRi0PqsieMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IQ/0qK79; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLQTQS3NF9xpVCeu1u/HhB6w+Gm9iODMpno3S20UOCk7m+GsUfBh2K3tdgzKM8Yr74fc3pGIQj62z59tOkEneMP8cg2qvoPuSwOzFIGBEHy0us2BwhHGTDhNhXOw01HivP+Kgfjo0lPVOhlXT4AFspBmdJFpLmTpUYVJQmWXVLSO024IhbReWercnHOZHHgX08GWm/PqGE1J46js0fsAWkHsvhb3R9lh9uzZHkO3QVmfuv6TSRxmRHa41TEhICIsYmwGDWrtp7aAwJfIQH0D821xKEr4a4k38ctA3TuPqQ39zr6ymyAApuG9PD2Gd4my3J8FRpMDy2338dKiaJ5kDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HXd4jTB833Azjve6ljpQvoLFOj1H81YtGXZ38roRgk=;
 b=Ikjn0+s0vnYZeojw5SdhfF+1Qyd2bswxeE4etnPome/OY6Zy+QYiID6U39lwBklW6YsYxMecEkLqOWCUrN9NRzRR6q77aCQQGX14Etc39eVs1wa1wmwRyfIiZCzXeVzs5iJBc5phd8gXz6LE8i9UWwyMWYNGlAd5CRoRo7spTw41zfLJGMy72t/oT4nUvMAQSch3VN3KiQXbsdJzq6wavYB5NPGtv3Lhwu9PpRpbuw8TRnMZ+9Iqw8gPQaq66kv3PcJ2ZlqtOeNEXhflUL6O50kd4iQcwDpdrkIuDtUeU99kyhJKVTbVLcGLtNTAtPLVDSbq0UsbE9pnSieXj2e4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HXd4jTB833Azjve6ljpQvoLFOj1H81YtGXZ38roRgk=;
 b=IQ/0qK790trLj6Oc9VRTqLHnV+997nAzNXp8Io5ExzGOlZ2Qhmo9eEImZ/Zg7v53DDmye6ATwELY1+SgHdkk+GacHCLUnn1tKxZc8XigrxBlB/eFfsuNpDLdBHXTaBzDfJFQ+EW0iOg2f168nNSIBgIjEzu/YQOjukndDFb7iNw=
Received: from BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::13)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 23:42:28 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::16) by BY1P220CA0007.outlook.office365.com
 (2603:10b6:a03:59d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 23:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 23:42:27 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 17:42:26 -0600
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sos-linux-ext-patches@mailman-svr.amd.com>, <pratikrajesh.sampat@amd.com>
Subject: [PATCH v4 6/8] KVM: selftests: Force GUEST_MEMFD flag for SNP VM type
Date: Thu, 14 Nov 2024 17:41:02 -0600
Message-ID: <20241114234104.128532-7-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: be1cff15-7619-4ffc-4e39-08dd0505ff90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AOpjWPE7p3ehCh5WhQ9Pa17qnGtc0P0EoJ1QllZeuxQGV+x5gxH8n9UjgIUz?=
 =?us-ascii?Q?Kw3kp2lweUYNf5oe4pwCGVlA/JApJXOBMP4o77FZkj5xPwKa4uCdn1RsZkO3?=
 =?us-ascii?Q?WniRCTwtx7IyLDZifV3erNhX5oj5/SDvHbgyE5Cw3ZNV5ztgznSlTg0ULDin?=
 =?us-ascii?Q?bJuvtircSdB9oH1/hCF0tRvWII+DmlvXl2Pnj5rPz80XbqT4cvkRjTJgopKT?=
 =?us-ascii?Q?4cAar42rlzDn/d/SbtAUcPgDXyL6GmYXu2+v2l8oVxk1lDVR7rB17vln58Mv?=
 =?us-ascii?Q?sos1cb0ZisiAexwbzKeIeRxvmWhQXrbZ9vFWQbJzWz7DZQAuhg4TJ/ZRN82Z?=
 =?us-ascii?Q?TP7Z2hzGuAMaSy0HksoqmAppok4EYi+wxErJNPhFBI6xL5hLH0K0BeZq9Sfm?=
 =?us-ascii?Q?HsaFMDo+etMGbD9fN9jaIMZ6V2X4UzV3QHhuA7fz7DzGBet8NEFDaNUJvCdK?=
 =?us-ascii?Q?rQWbQI0UDwVeY/113i7HBtxrjtGUwYKY8Cg8XKg4fqUC4ZG0ifhG+yNXnMAj?=
 =?us-ascii?Q?cGQK9v/QKt8n1ZAlZZ+mzt7Tb4VBzs6XvljPZCeGFJCUGvXw8X4DOiV2Rf7q?=
 =?us-ascii?Q?EXZIoIwoeb/znr8D6nbwOxi8xXv4F6DApxkMaIk/CeluQQdcrY+bBWYadUr/?=
 =?us-ascii?Q?yKI5eyM8dddXR6g4QTxW8BUjlVUGdR+Uz+KjMmbbTMchCd//t+g92vs+wYVq?=
 =?us-ascii?Q?WPNs6NKnWX0+TIGtIjn3rCV1c+IbPJ55Swb1SwR2jYlKMakrGnbSMzISsNqw?=
 =?us-ascii?Q?qQMlpPGoOXDW7QqXAWctLcNetE26lErNtEXgYjKGAlpMzte4geyZ9trVCwBh?=
 =?us-ascii?Q?60wjfc7p89qabHZHjSAl4PclX6DpNDNrgyKD4enJNnDbdT+FNwVLbr/eB4TP?=
 =?us-ascii?Q?n9K5NGGVfZRxAcoA4oo3s0nGB0Xsx0RAUBBlXEUsyQAKZhHj2qYNiONs8QW9?=
 =?us-ascii?Q?eKH33Q9wtKAgWCXnNxZrUWmpPM2X6bOD4+0Y9gN7aTjtHKU6MKfUIkk1e97R?=
 =?us-ascii?Q?rv4vE3tEI0tOcn/dDINd9hXYR21mwOi3JQV7tOZAJmVwHm5bVB5W0s1YsPe8?=
 =?us-ascii?Q?TCItc4jR63jMPGm4/b9zHcseqD7m21DIJatXgjirv/8VDnu+CmySMGG/BWvW?=
 =?us-ascii?Q?BcveX/eWDE/v+a9Epam5BlbRHxzzTMt7HMtgAFE9n/UQCHgdlQ664PzP245f?=
 =?us-ascii?Q?eoTULFXIrqQdCFwNIHweMQEFkGQZOVy3n8ZWPOGpfR380pik4FAnaNvhYHsQ?=
 =?us-ascii?Q?8/Ss/lqht5NRgqXlVuYMbXRRqoTxYw5g+MlPQxe2M6wvmZhFlXHiWVLc8DDe?=
 =?us-ascii?Q?/RgukvFHDWX54pNjYKK4mNgNh7OF6XSJz9xKYvtk8OVG1xXEtF8rONC6skWB?=
 =?us-ascii?Q?re5tc9ycr+xeIue933WsqynwZ/IT1c5YEmZDzVzel19PY9CaSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 23:42:27.5382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be1cff15-7619-4ffc-4e39-08dd0505ff90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725

Force the SEV-SNP VM type to set the KVM_MEM_GUEST_MEMFD flag for the
creation of private memslots.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 480e3a40d197..26179fb2f0e7 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -413,14 +413,17 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 						 nr_extra_pages);
 	struct userspace_mem_region *slot0;
 	struct kvm_vm *vm;
-	int i;
+	int i, flags = 0;
 
 	pr_debug("%s: mode='%s' type='%d', pages='%ld'\n", __func__,
 		 vm_guest_mode_string(shape.mode), shape.type, nr_pages);
 
 	vm = ____vm_create(shape);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, 0);
+	if (shape.type == KVM_X86_SNP_VM)
+		flags |=  KVM_MEM_GUEST_MEMFD;
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
 	for (i = 0; i < NR_MEM_REGIONS; i++)
 		vm->memslots[i] = 0;
 
-- 
2.43.0


