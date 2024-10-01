Return-Path: <linux-kselftest+bounces-18719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9C698B47B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 08:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8746F28194F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 06:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248E71BC072;
	Tue,  1 Oct 2024 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Isb4fkXf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DCC191F8D;
	Tue,  1 Oct 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764479; cv=fail; b=t72Vvh6YhWa/KvGVuOY6oeJKdMxFZLEJiTasYSXIBrLXGpoe+wOOQdPXm3hPUNxIAee1XoKD3+QNSAlWl3TOyvRA02c74hRduTZyfZZhCHMgD8IdhRKCPGO2mQmnL+cQ1Rsf6Ry88c0zQGLU8i3d8Bwyr6JM/LB8MTx3UYf5vaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764479; c=relaxed/simple;
	bh=2cLSKYtsJqDsTiaCoSnL0iBpF4qf49xcBWyCMhG6EZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=So2mcHG/MDzONhz+nANnIssUSSboYE12hSHX4OO6qJy1rdrCmlK8TkAnJ3KQs4hlqRFeMEbrN9dkEkzdthAteLTEnD0QdL8bO4bFwymYLWrgd2TaRFhmz3DgDVvsB0Pc2KByjliYw0gXi4A6Foltobl/bFVyi23JNubjWc3YTDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Isb4fkXf; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1z8Y00oVx3wf2U5TThOzj4dxLhJZws+i0KlFYkuOzIxjx02dgBXNZbcosDclFdd3QsVOgvTpslMMeklUG90Rcq5Lbg8dQH90GHY9MFW7lZ14/TtJvPO1/u/mZn/Z6IdRaU/VeKBlz56ZlFELM/y7tQS85r5bM2MoW7C7+avQ07PzHNU+CY61xtljjZJRK66nt5iPTbOc9w2YxTAIffoaCyUges835oWOKJsatNYMmq7yivGqxdSzedBwngZJxnd+aF44SgSlvwcBgB5GZe+cqIV4Kl+MhFPZuOM82Xy/l0Otg+2Gv9VnO0SQrVRnVzplMCHPbMCyMx6OJKSXX/qPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyraQc5xYEIcZtxALqC+LJI71Na9wW1pEYFQJt2zxRI=;
 b=ExFyjhdCwtbBQZ70qHiSAVbxSBbXx/u69HT+r4IYZtBb8LaZ9oh4TmJJFfBuVqk8F/njcqHhFEOCoqmJ5eex53WzEwVNfhn5ZF6XXP2ZCDgqTBC0X3FMJXOQXDZTI6CCRl9f0nRBbT3JZ3/CrzmMfzhBAxmxY5Ph90S42QimdgH1daxLMzNWPX1jsPVmjiFBABPU8U3qaCN2VII76GSBqPW63RBNLwHPes79bnW6gfJLFuRsQJOm8wUC2SV93J675h9B3+vtX888SilIOBsOn+T3ZJo5VizK4jDa0beMv5JJf0FjnK+ZSS6gLkx5dVVsgfxdz1EUWWi7WChMjdPFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyraQc5xYEIcZtxALqC+LJI71Na9wW1pEYFQJt2zxRI=;
 b=Isb4fkXf/ZtDgUmkaPKAtb2kB4frgfzMXWiJalVObvIoP/6uGn0lpo+n7f6BpX+QmBdQD8ef2Wi4QIC+UJShsEVyyrEYOcIGVkEmTa44IwD/BQIMRpHq+KmKDGkjOQCvxqqapfJvQlEtxX5COYrcJKjEWmysx8luQT2/15Kjsuw=
Received: from PH7PR03CA0009.namprd03.prod.outlook.com (2603:10b6:510:339::33)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 06:34:33 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::4) by PH7PR03CA0009.outlook.office365.com
 (2603:10b6:510:339::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 06:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 06:34:33 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 01:34:31 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [RFC PATCH v2 2/5] x86/cpufeatures: Add CPUID feature bit for the Bus Lock Threshold
Date: Tue, 1 Oct 2024 06:34:10 +0000
Message-ID: <20241001063413.687787-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001063413.687787-1-manali.shukla@amd.com>
References: <20241001063413.687787-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fb2aac-6ef1-418b-e5be-08dce1e31c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qXVJLuk3N79PiHt37FqqDF3ENf/f/fZYb1DyUbUuVBq3QstE+4qhIaFAcSTD?=
 =?us-ascii?Q?8LkMq+nI9Gaay/opH7+zROfhHbXV4f+3QyuZKPzBs/ruF6tI3Ch7uNGb6vTZ?=
 =?us-ascii?Q?znjjDWQE9amX3yB6iwY6BD/OeR0TAylP9ROe4Y1czjDbjcgNju3cVKoc3bXU?=
 =?us-ascii?Q?nywfiVMu3BUIwh8C+IRvalROoHs8+ub+ajgWzWkZ6KXoVeJ+c8frCkU9U+u6?=
 =?us-ascii?Q?+11cGwg3tcf/uGnkk860UHXSYJU8GzJSJOQuswXf3X5Xa09Qn3tFziQmTiCW?=
 =?us-ascii?Q?wBzL3fkWHBYjlx8GUJz0YJ3kwoqnBYxOc+eEg944eBMUwxWtcJXHoerQZ7D6?=
 =?us-ascii?Q?B3d9DwHu5z8ejtZHV5XfzKg4ss0lNOUqaXhmZIcu/CzIGDrAQw6GZMcD8PAl?=
 =?us-ascii?Q?OtDuTKBWC+E9pTubxCLHrkEUPwu5QbivSG+j2OULogVYasYYLw+3mF5FPrsK?=
 =?us-ascii?Q?bEhCCTz+QuKTUbcQ/ODUsdTbTjsNSu3kUKWTAFUVS0l+nCp5tYcP4VSWScHP?=
 =?us-ascii?Q?8ahaOhnzug2qc5+5wZYo6YBuBurNHcl+4Pn19MNXYMp/wS4bRapVrMGojWD6?=
 =?us-ascii?Q?cDJAa5aTMPkKVp4F4aNxEN3Rz8tYwusIc7bb1dGvq64DG3v9tiGtoe/zcaS1?=
 =?us-ascii?Q?6RRRCS99g4TGiUjLN2amfb1z9bspv6zD0ylglrhOKIBi40cENnZ08Eph65dh?=
 =?us-ascii?Q?TPPnA6oJno+P/Bp+ebXAaSCWbQFjMP29AmJ/fqvMRdtGKV/OTdVmQ8gd530+?=
 =?us-ascii?Q?t2kpehZgZcjKfb5WOZd72g+Hp0fCwh5D0SE0YrQAl0g8l9BuD4YJhRaJljbu?=
 =?us-ascii?Q?xGM3/tn3V+idN0cHojlq8F+eTMR941VD17sQz9xlxst3muyLqREBv9AYopUf?=
 =?us-ascii?Q?PThM1yKmyBrPUOtg1Yxcvslor6J9XlGuR6HOT6leGMDMA3NDu0pGNGfs+Slf?=
 =?us-ascii?Q?7j/5NOKwpLkHoIIrXo7xkWh07eYqXDbfXa35pRJsJZ87pY0Hc3Mbl7E0Ce4G?=
 =?us-ascii?Q?DaPQSfXMkrIyEt4HTwkdwX+ORO54k8krGuTTb0Lmbioxf1NQfA7hNpr4eYRU?=
 =?us-ascii?Q?Oiau/GR2Cm4XpN48iG+Uz9Hi+CRxEBB0ympXPZlTr7Cyb9PLChUyiysAnezS?=
 =?us-ascii?Q?ARcddfFvT9KyolQxcH6iAVaU81ISK9TWewJDVq9BxzbaRLEydwMN8faTgibB?=
 =?us-ascii?Q?zWkX3s3m1BrUeIqAigep24qiXlQdJlLr6B8RXGJRxXfyGEk2sLEMHJCfVCZt?=
 =?us-ascii?Q?I0FLvSc/VRBjZvgToZh4VCUqWR+ZsMOVntIZrve6vrBXjCahHHxeg5oFA36H?=
 =?us-ascii?Q?hzK7LERSeCMy85qTLPAnEUITheH7o/p+5m5xgyQ0IkIAbpnKiPsLATzCqmMK?=
 =?us-ascii?Q?6qA7UQh2RlS8rsVGdGBSCkPZTzyvLtWJxyZgb5APtvfp1GgRjkG+lloaL5HS?=
 =?us-ascii?Q?PT3BjoZOCCgkUHmGOpiB+9bGOzoE5Ftd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 06:34:33.0890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fb2aac-6ef1-418b-e5be-08dce1e31c7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712

Misbehaving guests can cause bus locks to degrade the performance of
the system. The Bus Lock Threshold feature can be used to address this
issue by providing capability to the hypervisor to limit guest's
ability to generate bus lock, thereby preventing system slowdown due
to performance penalities.

When the Bus Lock Threshold feature is enabled, the processor checks
the bus lock threshold count before executing the buslock and decides
whether to trigger bus lock exit or not.

The value of the bus lock threshold count '0' generates bus lock
exits, and if the value is greater than '0', the bus lock is executed
successfully and the bus lock threshold count is decremented.

Presence of the Bus Lock threshold feature is indicated via CPUID
function 0x8000000A_EDX[29].

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dd4682857c12..20f389ee0079 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -382,6 +382,7 @@
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
+#define X86_VIRT_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* "buslock" Bus lock threshold */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
 #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* "avx512vbmi" AVX512 Vector Bit Manipulation instructions*/
-- 
2.34.1


