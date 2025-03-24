Return-Path: <linux-kselftest+bounces-29637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EDBA6DAC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 14:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782D118964A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE5025EFAC;
	Mon, 24 Mar 2025 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RYekrwdm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A118FC80;
	Mon, 24 Mar 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821396; cv=fail; b=eZl/wvAI0+vEgX98m0cQQOEzNg4q+VrcTRA0fn5FzWg6UYFpOjMmml2bPNIsy7xuMbkV5cEjo9jyOGrLZnUGlN/tgfvNrTQ+kiRuqxRQ2+9EDlb+mvXDRJzAgo13WSKZEl+SdRuk0niDpY1reV6xlxsunh8zI/RzBFDC719kkZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821396; c=relaxed/simple;
	bh=+phLJBiIwUgkBYxA3zkuYmW4If+tkPTLvSOP7khcv3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8bBSR0pc7CskHk8m2MswLp5f60Yo6lioTaBSja+dLD9Mag/FLDU+6DJpKr8WXGPOBn2Tccn7EbdYfKsoOugyGh0QhSiOmYshzxQZYUBs6UCLseOhNBm3TkM1vGRxd9fAymzWD0CNWOiCw5oszr/oHJtgXAWYL9PyPz9WV0BLLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RYekrwdm; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmz7COFke8KyCbPvR4GApZoW4E+wLdT5cTOMqEHUjAqliGbXaC4Gb6iAS8eULzcJgVWjDvP+uMAjDEVLsWKALjZYGY3zRumGFMZI19roaph4WMh2nfMrW+AYSwkUfGXshp6NzPtcYhwJEqggwbLlslW9ETD3yqWeRgzqvDbwac3VTRmzwaSASLKUjeW4eJYSrhL2y6qey+jDvOjxhQBrq6axowDSMenF5oS0Xwt4DfCAck10NpklhuIlz1zGy47Mq1aoK1FPgLbges8iDcLRlVcUJkeNGEJVV3e4F1+yub/NtGUh/IlzWEjXiXWLLEXPl4cy/Uk8YRHwUMCFUTTe+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLnvJc5Cf5oWadc/ZkcBLJlrGhY/U1X3HSxtAbqzze0=;
 b=J3Zt+a3Yb4S66dS7T3AzZdxVE1NWpN8/GM3O9G3Ct/MT04CfbUAFcqUHWPrKSCZ7FAUPST0/vPXvb4yLj2ge3/GIyJuxqZjh71ePg6Fk+gaq0D2oBiYUigE8YMZ+AhHQEK2o2Fw+oTuwSBHITbsF780iiBnYenBlCkl0ZCiqfUQd1XR6qY0TsVsxvDW/CaRrRwr6ja/OO86ifGYnys7fkxgipxCLk3749msJYTA99Nap1KQ9yqoyLcjg9zCL7AXEQ8BrR0AZmgUqBmN7AkmGw48I/vLHhkFfA6FLlcFn10ci13ibfhu+5kKKmWjCUT4eQEatmBBT/gGS9AA9bvICVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLnvJc5Cf5oWadc/ZkcBLJlrGhY/U1X3HSxtAbqzze0=;
 b=RYekrwdmArKHtC51Mi8vIJrNXh1qnTaKiSrxU0oIrpEMGvnqNvDlWdxj8WnuXREhv4ocT8Tpr0Wk8SaOWgRM1wX53vhi9GGL6g12kPiTzKsBhXqyc9+eTL2u89fgn/cuuRfJviWKgerIfl0PLe5wYLoK9qHWdLMhX3wOhfAD2uw=
Received: from BYAPR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:74::29)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 13:03:12 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::81) by BYAPR05CA0052.outlook.office365.com
 (2603:10b6:a03:74::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 13:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 13:03:12 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 08:03:10 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <nikunj@amd.com>,
	<thomas.lendacky@amd.com>, <manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v4 2/5] x86/cpufeatures: Add CPUID feature bit for the Bus Lock Threshold
Date: Mon, 24 Mar 2025 13:02:45 +0000
Message-ID: <20250324130248.126036-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324130248.126036-1-manali.shukla@amd.com>
References: <20250324130248.126036-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a151ddd-974d-47c2-e27e-08dd6ad43bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?enwKaCOXY18ncYg1ThqcQFXtJ3NdgFg6DeQjLkaPS7+9igOj7nRyo8MFJoPK?=
 =?us-ascii?Q?Y0o0aXKj1QBJRCcqmnuDoVj2n6dliN/mfn3G7Jsr8PYC1m6TyB0SonnyR6l7?=
 =?us-ascii?Q?QIebnwm7VyM9PA/KMthNJZpMoHk2PS0i9YQvi94sRFbwArXaI6KSK7+Nvp3T?=
 =?us-ascii?Q?Yx9SRVWD1eIeYN9AEPi0c2B+YZlA2yB2Ya0A07XFeVxPgiRcnphdBbdymz9c?=
 =?us-ascii?Q?ZMEwrqqvALQdO+Q2R+6CGBws8dsG4HuotXJ+a8eqrkzyw+d5CfOzpIth76KT?=
 =?us-ascii?Q?5ygYH5jN8E+Cg/dajPUmnT23FXULVnbSm/JaIcTaar1PqynrkCaGMfcqAphs?=
 =?us-ascii?Q?tG06LoNvooDxuqCz+gy9r1w5Lhk6gNuXZRwROyOmh24VldBawdoEZBWpqmMs?=
 =?us-ascii?Q?P7ZWEISyNspNe2x6e4+wFaOdph4QJ/6CoceWFgvuf70bWqWbAmeCFBHjDSnB?=
 =?us-ascii?Q?TaofT7FBwq/m2VFLgbc0ZdRubvJsVmzFZSgf9+q9DslfvVC1s6dHXNi2crpM?=
 =?us-ascii?Q?Crw9ZsB/y/wAns0nok4ysq+cHdJzUtoaZtT/PJmrQUVcW/e9VcIT8X6RGYYN?=
 =?us-ascii?Q?w5SaQKhNvqCncqSH+7a1whpGNgzTUK4lcexFse7L7L2CWrMeUR/IPv+UHJxz?=
 =?us-ascii?Q?HK2K4/cMQyMsmKFZN8sksnGDqFIK55qsRpvYEBkz0lLSlVQwsKrdlk7vxxXa?=
 =?us-ascii?Q?+q+e5mUhdhAkMaMmb+HfADLt0zY4fP0NGyQD5OgyFTxZudw2ynGEwIS6X52V?=
 =?us-ascii?Q?lgUe/Jg2DPVkngiUF9RkLQtvmsNATTUU3KMc02DkIkyj8RWDztBmOtuT4mp7?=
 =?us-ascii?Q?pvTXyaHAOZfhnW61HMxjT4BTG6inKxTKRsk9tMYu48cEmd49a1VM5N/d8pSO?=
 =?us-ascii?Q?w1uyUyrkeIAfN+v4yYtuQL9k/2ESAyyh9ZP64X42GMxTgab2lRc9I5TiTOlr?=
 =?us-ascii?Q?cWdDgzNdpbOgtp7bXU40pWxcYiWGguLAdmrm+hD2OQPY8+HnK2NnaBZF9Uk9?=
 =?us-ascii?Q?N1vYx3ddubzZGTKaglcLiXR0xAuryPIRmbDHDaIzqPDapJ5aSf/KapuKpDZT?=
 =?us-ascii?Q?ZC8SBjeywEi4BDWi2bhs2hqxeWk4WD97Jo0dvYDPZ2QmKPqbqL7SqpNeZbga?=
 =?us-ascii?Q?k8/Bz6vUkWFKMu1WZdXzOzHftPklp1L7wgavyawJiKCBYOBX58t5UFwobjwS?=
 =?us-ascii?Q?In6AjNSyWP7NM4Rn2vO11YelndqrzAn7zbuA0Ue7F5hUhwSpg7AYXerjERSX?=
 =?us-ascii?Q?G/QUHPG9gxLPl0zKOK45MVwXPXjIfUKXX+Cse2PYyZb3fKcfsl3ABu6HUOmt?=
 =?us-ascii?Q?jkOrPM6NpUuKNvgKsn1JO0ttzNlH2wGHyIv7a3kOr1JJ/Px2F9uIDWePKY6o?=
 =?us-ascii?Q?y+Bsl0cUrC0T9n9A2821nCUD/rrptQxyudHGHb3Z6MSqQKOENLz59OiCb8rE?=
 =?us-ascii?Q?8Cj1O6jvsAl7jN8NhrvY/fFtSMAijGQomw3TC/nExwL6/G7HVTnrA/oE3T2w?=
 =?us-ascii?Q?849xfoSbgRsmZXY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 13:03:12.4878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a151ddd-974d-47c2-e27e-08dd6ad43bce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197

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
index 8f8aaf94dc00..a3ab8d1f5c17 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -386,6 +386,7 @@
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
+#define X86_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* "buslock" Bus lock threshold */
 #define X86_FEATURE_IDLE_HLT		(15*32+30) /* IDLE HLT intercept */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
-- 
2.34.1


