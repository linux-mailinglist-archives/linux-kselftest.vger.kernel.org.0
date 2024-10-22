Return-Path: <linux-kselftest+bounces-20369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A85ED9A98EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 07:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C985D1C21BAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 05:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D5913D613;
	Tue, 22 Oct 2024 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C9L/S1Kc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78C13CA8A;
	Tue, 22 Oct 2024 05:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729576115; cv=fail; b=Ez5JUVIJ4iyfuRbki3meVrx9HTLBmfO6Yl+/na7cXZtLKudhoZ4lXyICMMt3840qdFKe6+X+GOuNYLp0OaAgNLNdd8t71NDj09NRKPzJiXN+unvHph4I7yZCOaKiMwaBbwZY9LTssLr9pMADXk2HiYRgxA9AUmAEN8G3+Zyw3go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729576115; c=relaxed/simple;
	bh=PpEsdxTF0E2GMoW+CVNBUjw6a7ejvVYM8LFpd35YGTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liS/fHJDGkLBYOB34UZYufKJw5Im8isNyB3AkYg3c8ObdpMEkLWgzqqc0EomIsFx9nY7M4OTh8Vw1s7ZgrDl9ROvGZGP1OdcjhWzs7E1+Oal0ED1QWA0eMjzn52jTSNpJ8k2FEyewNqnLRMvjBcf2100jh1zheVJhsyEQrfKlSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C9L/S1Kc; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPnA5iq4Ac7ckrgLLpVUFSwbdj2rPUi78FL1bDyk65CkfsoZiiY/NRqfypEvLY8exiy6SJ27EtcoFHuYhUWJFecMYMREU8lFS03Xy+MJhlcgBmMJWCE+Tkov+vouq3Cx953AZ00b2o3722yhqSRyvQ5GJlbSXBkqgLJATABXAGUh4nVHtxn4i7M96qiTMZ3YZjEiEl7Db+z+adMiYOqrabNymFhsMNT1/e/gHSmIEnz7HNAqUoFYPXdNhb4gUIqUG7M4orLmfNel08lyTA5lC/8oyxUXWh+NrzFbSpziGWcLVPjRWqjH1vBreOMOc16v+xZwpFU8LyDrcjwNH8/liQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HM8DD6gt15aAnodLpHKwLeUrsrPhLQeKb2QZa/iw3mM=;
 b=CuqSAPzBbfcKks/e60HYGiMlw2XvdtWe/ZIjkzS7elHaekS61wcvO/uWgAceSdaRIHquOLSQF90ynKmTTNtb/TfAVNwe2b8eU5fdHvcFA5qlRjbnSCkVUZV6gpnJvwcDazPaqCI04CWsRpfXNEfIq+1TK3fBoVxpkHVxLJnZnPjYhWPMDmhDbe0yXVrK2+iDel1hjG5s+vS2o6xU6K/K9gyZ1yNKVwJoJ/K9kXVUQq5qlphoeLE2popfXQydOdhHWksAXT/g/UbcGyb4sRuAy+eeW+VarBzOCyAIg4dRoQTEZCncDzotS5RVkBrc2+8pNH/ZcSpT01gVn4Y/lAmTpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM8DD6gt15aAnodLpHKwLeUrsrPhLQeKb2QZa/iw3mM=;
 b=C9L/S1Kc2rmOy+ATtO8rwf4jp4H/cd/gR0UkaeHeOiQH7j2mxBytiqbBiVpOA6NhJlgw20E4TdHO3EOhovVq73JX7r0mD14blQGPid7ALBjSXaFOdWA8qnXXXHXzuMfgVXS2G8Ezt+p9bupOCpdB4TMUt/rb3rMU6D9l1i9Vbuc=
Received: from BYAPR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:40::29)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 05:48:29 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::8c) by BYAPR04CA0016.outlook.office365.com
 (2603:10b6:a03:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 05:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 05:48:28 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 00:48:27 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v4 3/4] KVM: nSVM: implement the nested idle halt intercept
Date: Tue, 22 Oct 2024 05:48:09 +0000
Message-ID: <20241022054810.23369-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022054810.23369-1-manali.shukla@amd.com>
References: <20241022054810.23369-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: b195b657-b185-4e5b-ea0f-08dcf25d27b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v6Fcf/nkdkRRch4/EzOoT7aTvk4w5A90Cf6C1Tq7ZvTN9ZH1DRocmaHH//yd?=
 =?us-ascii?Q?EkuQGYAdV2tl0dovi/imQOe53jgq1LtDEYAESejPRpOAimqv5hQOP0AqAGpL?=
 =?us-ascii?Q?OAZvD5SSGrnFtubX/BtSyvTjmiVv3PM9SUG90Ysu4Y3uMDoxjruw98sGV0ML?=
 =?us-ascii?Q?beXLe4OnsQy2oYY8iLyzgkpAn7ArZn3pgs1ZqAdYRQouAyoyxuYgDUaA3UOc?=
 =?us-ascii?Q?Ja+3TX0WCpCUpva/QEwzNWTJbRYGhnjDKpWFUjsK5yyeiXD2xE4OCQGHABFn?=
 =?us-ascii?Q?cXgstQVoNjNFfBYeojHzKhngRG5bVFOPWQLFpHJYs9QwkQqo3yuIyhenbUZ4?=
 =?us-ascii?Q?J5KTh2NpRGZo0xR4WlpROZHs5N6ptvde44K5XRZkn0oM6HAkq40VTVCyc0IF?=
 =?us-ascii?Q?eqpXCAO2M89JjCkYzKH6tVlC0sCLIjyQWAvGMfPSQZy4k8LYg3fFr9oFTVtH?=
 =?us-ascii?Q?WvcaZmntGsD8RLy2RJTbsuXMtMKcyIgvish5byLdGC4CnyYUKnfplI8Gh2JC?=
 =?us-ascii?Q?AZTfwviZgxxUonNNf62mAvVihRP3+qCiI79nA+3Nx1KuBbCGyIumStBXYAzd?=
 =?us-ascii?Q?8m+fUNFIVuU7JgIO7wKteviczEUX60rR+xh+Y9y/oNt+B01O4hkseBvuar84?=
 =?us-ascii?Q?1R9x1Aqgn0NzlF92bRj1EPEwOwmJr9YJHxBM+zRE5pz9oGGW9WD1TIy3iGpN?=
 =?us-ascii?Q?gx8m1JDDfexjom/EO7o0W+lI6B9Iw/ZsLby7xfeGd0+W52JzYQqQHHo/mEc/?=
 =?us-ascii?Q?kpX+MdQIU9e2E8QGUkn3Qla5/DMiVhOYytksTPV0x4t3Ou3h7QIblLgPWulE?=
 =?us-ascii?Q?0ukS0kRZo6s2aPHr2tz6Eck29nYOX/xDVihs3eQTxsRXCsoxCscvPDq7xrzI?=
 =?us-ascii?Q?mkFLLFkBB/KlT0MG3OLppsVuiZuiWY87mIuaw1ZvDuYlgOmSLhCtLZEgbbLt?=
 =?us-ascii?Q?8+wKXhLf2CxdIPowJDUlVjBD8D5OwWEd5IiI6ubPlaIJ4z02IoEpB3gBBZ2X?=
 =?us-ascii?Q?2NKjaRdH0uFUvqbf0t3MeiSyzQpnrsjSDCsAYmO4XtoEj1HXsgmWfRxVttJw?=
 =?us-ascii?Q?jXZqSPeNzSR7wEOMb8pW3uVjddAlxJO7xDYJOUdHDhLzKSUHeXNxvCoqsKgm?=
 =?us-ascii?Q?qJacCJ7FGuLDN/q6rmo7Od9ENQxTIk79FimaZgfMgi/SYgsASuT2A8/sr2b6?=
 =?us-ascii?Q?rEP8RiO4de+qm6+DriK03zlg53eP2H/cMfxCBQVsN6olVJ1+BiBPPO6k+Tq9?=
 =?us-ascii?Q?C4yhgVlrQineGtJDalKQ2/KuXnrkBJJjDnP4ME5RorjsvlZ9TjLD7j1ynr/X?=
 =?us-ascii?Q?bhWF/Z0bbJfpkToqToq77lslYlSzIk1GtyBfJCVHXENRzOjQgxV+sItcWzs8?=
 =?us-ascii?Q?+1lEVZHE0JQAh/6VStc4ktQHCFgFImQ9XcMB/0eyVbk7gFPK8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:48:28.9809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b195b657-b185-4e5b-ea0f-08dcf25d27b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343

Enable the idle HLT intercept for the L2 guest when it is available on
the platform and the L2 guest can utilize the Idle HLT intercept
feature. This is achieved by clearing the HLT intercept for the L1
hypervisor in the recalc_interrupts() function. The Idle HLT intercept
requires that the HLT intercept is cleared and the Idle HLT intercept
is set to properly enable the feature.

The nested idle halt intercept was tested by booting L1,L2 (all Linux)
and checking there are only idle-hlt vmexits happened.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/kvm/governed_features.h | 1 +
 arch/x86/kvm/svm/nested.c        | 8 ++++++++
 arch/x86/kvm/svm/svm.c           | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
index ad463b1ed4e4..0154012721cb 100644
--- a/arch/x86/kvm/governed_features.h
+++ b/arch/x86/kvm/governed_features.h
@@ -17,6 +17,7 @@ KVM_GOVERNED_X86_FEATURE(PFTHRESHOLD)
 KVM_GOVERNED_X86_FEATURE(VGIF)
 KVM_GOVERNED_X86_FEATURE(VNMI)
 KVM_GOVERNED_X86_FEATURE(LAM)
+KVM_GOVERNED_X86_FEATURE(IDLE_HLT)
 
 #undef KVM_GOVERNED_X86_FEATURE
 #undef KVM_GOVERNED_FEATURE
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d5314cb7dff4..feb241110f1a 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -178,6 +178,14 @@ void recalc_intercepts(struct vcpu_svm *svm)
 	} else {
 		WARN_ON(!(c->virt_ext & VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK));
 	}
+
+	/*
+	 * Clear the HLT intercept for L2 guest when the Idle HLT intercept feature
+	 * is enabled on the platform and the guest can use the Idle HLT intercept
+	 * feature.
+	 */
+	if (guest_can_use(&svm->vcpu, X86_FEATURE_IDLE_HLT))
+		vmcb_clr_intercept(c, INTERCEPT_HLT);
 }
 
 /*
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e86b79e975d3..38d546788fc6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4425,6 +4425,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_PFTHRESHOLD);
 	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VGIF);
 	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VNMI);
+	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_IDLE_HLT);
 
 	svm_recalc_instruction_intercepts(vcpu, svm);
 
@@ -5228,6 +5229,9 @@ static __init void svm_set_cpu_caps(void)
 		if (vnmi)
 			kvm_cpu_cap_set(X86_FEATURE_VNMI);
 
+		if (cpu_feature_enabled(X86_FEATURE_IDLE_HLT))
+			kvm_cpu_cap_set(X86_FEATURE_IDLE_HLT);
+
 		/* Nested VM can receive #VMEXIT instead of triggering #GP */
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
-- 
2.34.1


