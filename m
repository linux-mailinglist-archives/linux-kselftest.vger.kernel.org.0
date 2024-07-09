Return-Path: <linux-kselftest+bounces-13398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47A992C2D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B49F282110
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3DD180049;
	Tue,  9 Jul 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vi9Yjz8h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9012C549;
	Tue,  9 Jul 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547539; cv=fail; b=LV7S+pHp5YEainR2PY1mOGSDi8mxu7Of2WEAknbdXvbY1ojnO171RuKl2dq4jFeNgmCrBco0tD4GKiO26VhBPv4p+qHtmFbCwAZD/Q+Nls4fgW8oLl/TkGJeXPWi3+o5VIvZ6jVDOKviqiBPXio3J4+JxuaBNNtxGwy1jmM6lBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547539; c=relaxed/simple;
	bh=W27sKtaZhUoGHPO1V2va5NFW6HIOaLCOTGHYuAqh+Yg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fkrp06BTySqR6wmuum3QA+wqcSv/gV5G0miNKmzUsQtBsT4lQpyXPm6xvGK43VUBuoYmvFVHUWDZbFUbaab4hm8iBlDevhfhgGZcNDf+l81UYb5LLTdo/nrhM2Qu422Boyn3WIwV+CaFfqeIf0YE2hHH0rF6fXETF3Z25hlpx8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vi9Yjz8h; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJqTZ1gW5uc5+ee95daVzVx6B+vqds5kIh/mFVZ99eTe0CDja+f12Bv6Sbt1nTF5U59MlKEkvX0UD9ySG0vOGwqhS4u1qHVXhzu4M5F7SVLpyVkGu1diLHkOJcHL8va+gGZZBEfcbQt5CUj2uhVWsn4w6zPBie9E3agpOSTS+veA2GX6wrwN7eqED4+2BUYj+CwgvVAwSOoGuEKZLeq76SNZMns1dtTkcLvnI+QJuJSvbigO3ldFkEV7yC38WaBuwn1+suU7g+y2+9Jze1VeiIHCauI0GdZgZTJB/MTV4s+zPW1UkZyYR3TD7ZxsgDGosHExDtF7Rabf5xnyXkiviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhR0e6Kbl3PNTEsNI5Yopn+uKUvHQaGRBI+INUyF9lA=;
 b=lNBexLI+JTt5/vbQTBczH9mKy6zW1px3Z3XydyXazr5GK5d6KN54mfXOzr2f6LPy93MdV1ttT1Ws43fstx57aliZnHNpvZ9zMKyrMWSXa7opAyEfubnPTXbDv6rSQoZb7CWxDaQ1Lj2DIQjsPWRlD4JAtUWwG/p2CdVaNqOsXRAOcAAZS9jrDKtVceWJXIb+vf/q6byvkCNoMSRGZfNlXU4P73ehHwhR+ZSSjQb60uh7pFGVN9vl/QoTYZLJWeTttJE3G4W7iIqUlUyDMeYlpAQbZoKZS7dTf73ohlzL9aopoq5pfzfu8lH8oWHZlsjaI7Fxmn0we9Ik7LuiyIWTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhR0e6Kbl3PNTEsNI5Yopn+uKUvHQaGRBI+INUyF9lA=;
 b=vi9Yjz8hP227b7F++r1dMZFdyB9wQPckPhYRv4Ee+XyoMKTtfiQ+BvRPrcKZuObBVHEcgwpBu9eVN54aMLIhu+Cl64P724PiLtmkiEqwAPGzsquOmgZTUnsgYgnZbniK58WcFXOMccb7w51n0MuUd+g2Hpcz+hA7FcuJLafdris=
Received: from DM6PR10CA0003.namprd10.prod.outlook.com (2603:10b6:5:60::16) by
 PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 17:52:14 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::7b) by DM6PR10CA0003.outlook.office365.com
 (2603:10b6:5:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 17:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 17:52:14 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 12:52:11 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [RFC PATCH v1 3/4] KVM: x86: nSVM: Implement support for nested Bus Lock Threshold
Date: Tue, 9 Jul 2024 17:51:44 +0000
Message-ID: <20240709175145.9986-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709175145.9986-1-manali.shukla@amd.com>
References: <20240709175145.9986-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: a0307e64-050e-4671-fa05-08dca03fdddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q4uDOYVeyzpNx3XsBiXhGrFfv0sskfQFsuMpAiv+GjK72L0VmsIwmQ4x6dQj?=
 =?us-ascii?Q?2lcs6/ewHSvH/vD+ooKW5tBNlXTFZXJDwz5BJxri2A8xqXjwXFAl5yFACrdf?=
 =?us-ascii?Q?nJqESy1SH5S8PmpXgj9q29i2AjI/ph8PrpO9cgqQbU03YgYunTlQ6sMmeXFZ?=
 =?us-ascii?Q?Ko2wlIFB6ctqrcLKMvUbTlaO9rqVdQiByw+YsG0PL8EqgvFCB9urL7c0e+it?=
 =?us-ascii?Q?Th9x1u4LJ8BlkDGPlZSCLEcFtx2kfD9Q5OeEv+pGgC7nKTHajw/pHqFqDrh7?=
 =?us-ascii?Q?NM5XOZAbCs1lotqD/Js6O6av4O68Ao2SLxghEUzm+5v8qk7ETw6lX5gV3MI6?=
 =?us-ascii?Q?QjwBnzE1vXl58ZlFoa56edhvPXbn8ZtSqAt2BN8GPkZiijM4P2i9H/0Od2Mu?=
 =?us-ascii?Q?DOF0E5sAdhBTw5FnW7ap2pvV4VdfX4iqgXqa0zcG6j7aYoggKGR62fJsY6ap?=
 =?us-ascii?Q?cEEedyzwD5hVIpNd8WzuqZaGhN2mjPX20l3cL+Lsbb5u/xH07LY1kt25xYiT?=
 =?us-ascii?Q?Xli6iV5ztnhNizIc9JNH3yduLxiW5mKDZvCZF/8mC5JOkhEHUXlkOyfYt8jc?=
 =?us-ascii?Q?HY81VcQnL5sTT5/neRxMn0SpGT2XcEVXBayP6Cuxd+zq8g536pojH3ApzzmT?=
 =?us-ascii?Q?rSHfBWbsr8oP9vSxZqw88yh8shLgkJ9jZuiC1PeyLSdFFift9dZUVHUvxiNv?=
 =?us-ascii?Q?l1Ie/HgYiioKz5oDAmymE1uX2qclgmP5hAe4WDL9bljGCND0fT8LXRMNT0VA?=
 =?us-ascii?Q?2j3yYeIzi9YT6twerM/wmZAtakQExpimEVKwJsKlMxpXlXXsR5BTmYKwboMP?=
 =?us-ascii?Q?ZXYHqp2hvnPwNDk207aIeeKmHpUsgyfrwmZco+jKglhlQM5jdstCfTZFvob7?=
 =?us-ascii?Q?wvSnmsfnZam60WwHqhxZgpl+sC+9GoEN+kJKobyN2s0SXIGlpcCAle5Chucn?=
 =?us-ascii?Q?HPcTWdcFxswYZLGYrz5MTcwYtCbO6wFxk+1yYS2C1mzakktakjFlaE3cZGV5?=
 =?us-ascii?Q?PGrdeliJiWfo2cjPRrffdx7iL6aqjrpQbZu2IO9h5uy1Jpoqdp9LrMok4kcf?=
 =?us-ascii?Q?xJ/GpfSvcS/nPesek87RMY3WkRhABNWbrkX0W7TKWB1kZiIU+5fV5pWw1E5d?=
 =?us-ascii?Q?WvgpLsjiHJy44qXvuZP36syksd1VRQHcrcJr2IlOnfye7argxujiUuFk1jKP?=
 =?us-ascii?Q?Qq6C1qPhLVTv0BMjPqlUfs31atNK6M1Oqep0bLgDBAcn+2qf1LQ6zxVntQAM?=
 =?us-ascii?Q?uenAeVF300eiscbO7U8X3Jy9GnWqyJtu+XWCx3UyvP/wUvGoyMl6phMIiiiZ?=
 =?us-ascii?Q?AC2BJqU/isL2DQDXMBm/ISjJNmgVLD66N1HBnbrIt1TVtFOzpp18EwIjmklo?=
 =?us-ascii?Q?Ct1P32zyqwRgR6ayO2cjXKldKGAWf70Jc5i+ON7EBlFoz9xamvjawG803/95?=
 =?us-ascii?Q?I08nGOYAxu8m3NBuD673qNHhDnDgOYqI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 17:52:14.2469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0307e64-050e-4671-fa05-08dca03fdddf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374

Expose the Bus Lock Threshold in the guest CPUID and support its
functionality in nested guest.

Ensure proper restoration and saving of the bus_lock_counter at VM
Entry and VM Exit respectively in nested guest scenarios.

Case 1:
L0 supports buslock exit and L1 does not: use buslock counter from L0
and exits happen to L0 VMM.

Case 2:
Both L0 and L1 supports buslock exit: use L1 buslock counter value and
exits happen to L1 VMM.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/kvm/governed_features.h |  1 +
 arch/x86/kvm/svm/nested.c        | 25 +++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c           |  5 +++++
 arch/x86/kvm/svm/svm.h           |  1 +
 4 files changed, 32 insertions(+)

diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
index ad463b1ed4e4..0982eb107f0b 100644
--- a/arch/x86/kvm/governed_features.h
+++ b/arch/x86/kvm/governed_features.h
@@ -17,6 +17,7 @@ KVM_GOVERNED_X86_FEATURE(PFTHRESHOLD)
 KVM_GOVERNED_X86_FEATURE(VGIF)
 KVM_GOVERNED_X86_FEATURE(VNMI)
 KVM_GOVERNED_X86_FEATURE(LAM)
+KVM_GOVERNED_X86_FEATURE(BUS_LOCK_THRESHOLD)
 
 #undef KVM_GOVERNED_X86_FEATURE
 #undef KVM_GOVERNED_FEATURE
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 6f704c1037e5..d09434225e4d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -363,6 +363,7 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->virt_ext            = from->virt_ext;
 	to->pause_filter_count  = from->pause_filter_count;
 	to->pause_filter_thresh = from->pause_filter_thresh;
+	to->bus_lock_counter    = from->bus_lock_counter;
 
 	/* Copy asid here because nested_vmcb_check_controls will check it.  */
 	to->asid           = from->asid;
@@ -758,6 +759,16 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 		}
 	}
 
+	/*
+	 * If guest intercepts BUSLOCK, use guest's bus_lock_counter value,
+	 * otherwise use host bus_lock_counter value.
+	 */
+	if (guest_can_use(vcpu, X86_FEATURE_BUS_LOCK_THRESHOLD) &&
+	    vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_BUSLOCK))
+		vmcb02->control.bus_lock_counter = svm->nested.ctl.bus_lock_counter;
+	else
+		vmcb02->control.bus_lock_counter = vmcb01->control.bus_lock_counter;
+
 	nested_svm_transition_tlb_flush(vcpu);
 
 	/* Enter Guest-Mode */
@@ -1035,6 +1046,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	}
 
+	if (guest_can_use(vcpu, X86_FEATURE_BUS_LOCK_THRESHOLD) &&
+	    vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_BUSLOCK))
+		vmcb12->control.bus_lock_counter = vmcb02->control.bus_lock_counter;
+	else
+		vmcb01->control.bus_lock_counter = vmcb02->control.bus_lock_counter;
+
 	nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
 
 	svm_switch_vmcb(svm, &svm->vmcb01);
@@ -1333,6 +1350,13 @@ static int nested_svm_intercept(struct vcpu_svm *svm)
 		vmexit = NESTED_EXIT_DONE;
 		break;
 	}
+	case SVM_EXIT_BUS_LOCK: {
+		if (!(vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_BUSLOCK)))
+			vmexit = NESTED_EXIT_HOST;
+		else
+			vmexit = NESTED_EXIT_DONE;
+		break;
+	}
 	default: {
 		if (vmcb12_is_intercept(&svm->nested.ctl, exit_code))
 			vmexit = NESTED_EXIT_DONE;
@@ -1572,6 +1596,7 @@ static void nested_copy_vmcb_cache_to_control(struct vmcb_control_area *dst,
 	dst->virt_ext              = from->virt_ext;
 	dst->pause_filter_count   = from->pause_filter_count;
 	dst->pause_filter_thresh  = from->pause_filter_thresh;
+	dst->bus_lock_counter     = from->bus_lock_counter;
 	/* 'clean' and 'hv_enlightenments' are not changed by KVM */
 }
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9f1d51384eac..bb2437a7694c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4373,6 +4373,8 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_FLUSH_CMD, 0,
 				     !!guest_cpuid_has(vcpu, X86_FEATURE_FLUSH_L1D));
 
+	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_BUS_LOCK_THRESHOLD);
+
 	if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD) &&
 	    vcpu->kvm->arch.bus_lock_detection_enabled) {
 		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
@@ -5183,6 +5185,9 @@ static __init void svm_set_cpu_caps(void)
 		if (vnmi)
 			kvm_cpu_cap_set(X86_FEATURE_VNMI);
 
+		if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD))
+			kvm_cpu_cap_set(X86_FEATURE_BUS_LOCK_THRESHOLD);
+
 		/* Nested VM can receive #VMEXIT instead of triggering #GP */
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 8983eabf8f84..f49ea38187ba 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -150,6 +150,7 @@ struct vmcb_ctrl_area_cached {
 	u64 nested_cr3;
 	u64 virt_ext;
 	u32 clean;
+	u16 bus_lock_counter;
 	union {
 #if IS_ENABLED(CONFIG_HYPERV) || IS_ENABLED(CONFIG_KVM_HYPERV)
 		struct hv_vmcb_enlightenments hv_enlightenments;
-- 
2.34.1


