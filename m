Return-Path: <linux-kselftest+bounces-32145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D645AA69F6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 07:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A75B1BA5532
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 05:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B636E19DF5B;
	Fri,  2 May 2025 05:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XFkRz32v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976815DBB3;
	Fri,  2 May 2025 05:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746162266; cv=fail; b=YdPdiKJc0NnTSPlpeulbHycrGqvyL2aYUMRaKWDXMY89F4+OJIRSZESoMte26jxhsWSRz9SN+FHigeRFucjrtg4r86nKaQDybbj8qh3hj5dSITVvmt06dbD3BPiKk3RNwo9cY5mJ+UanVwLyZRwdQHBfR/p4Nto9eEyzo8BPsms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746162266; c=relaxed/simple;
	bh=lGjVjQJRXXr0fUsJnM3rbo3lTAvg8HsCwhBjGxOIluM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gD3aMBG/92XXNyTMrfqq52ypwojnX1DEfnFkCbihCTZ4iBbDowu3iWDtRUNl7Xtf085wTCoMN/Mu79fFpa8Ts72WHR99BSKR8FkRIdtZEN8FORoAVurcPBmjWrUtMjV3yEQR3Czsvr9xxs65c+RrVyXiTIqFUxdQ2hJNbs6yxaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XFkRz32v; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRm3PQ3xlZ/5Wydu0X4fmn4WF1UNrimMC5T+wsB7Xs17kOSOsqYDDEnRdgLIsWXsXWF0VVRyQxlFAU1jg0/jlP42U7KuwhcgK5X3iUlTmhbSAx+67rpMtflH4k/NLxiv7/2PcvLlxvBh7Mz9ESfwrPtNwE6dibl9gBPr8UfI3aHf4egCDgphEbXkmjJinC7AaLiqXTb6vfCk5R3kbd5XYgaTDxjN38jFeaNgijpOC3CZS5MqY8o94/61osrCZBfxZ/+FVEUCmMoPA1nrifHvPKrCvBpXVvqcxTh+pP6Mgat8hqeKjTfkIxO9pXb4xYt6sh0LGXU4JK8d38pFRHyAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wv8pNiPKbZ/C8A6AHVM3VE+kSkuEsELhEg0MpJeTQc=;
 b=u4E4z//v9Atx7l9LO9zDv0ByUIEHa9UVCE+AAjpXVOBLtFD8aq+vAOSBSjfZMgS6Cbf41pIKEQ/67iBo6WiEicxieZZLDzooajm613VRBEaIJ6BkPVd00EQDQp6DY0iYxd0OlhZhIT7LIfpMzmr3qvtJpzqRb2rtWyiw3Sb/FYD+4niqEotoTBnut4M4e0lKpwEf4/CFL479i3psGj7mK98W+UyKlDounA/uvJa+a6e9vNjTP5EuSxClDJPcZ2NlrrZc0ZetCgSGxvPwJc/7IyYHCQ4VzyXTKXskE2AfTClcShXLjI7/fCjbEg7biL2obNCVmxfR3t9LWYt7RyRjrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wv8pNiPKbZ/C8A6AHVM3VE+kSkuEsELhEg0MpJeTQc=;
 b=XFkRz32vlHj4fSr8GUtgi6TEglonqKuxjH6dBL6KJ6qkXe/Lh8UHRaUnlWocq8VNaHDKqRPn0Omm7Ada4ZhEZfSXAcERA9FAUgS6enozlHr5LYp1NhpD7lYtcVBDgqMMWjqHZOawOUGBXFysx8GEJsq1ijQgr+tEglG6ereI9zk=
Received: from BL6PEPF00013DF6.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:a) by MN0PR12MB6176.namprd12.prod.outlook.com
 (2603:10b6:208:3c3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 2 May
 2025 05:04:20 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2a01:111:f403:c922::3) by BL6PEPF00013DF6.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Fri,
 2 May 2025 05:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 05:04:20 +0000
Received: from brahmaputra.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 May
 2025 00:04:16 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <nikunj@amd.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v5 2/5] x86/cpufeatures: Add CPUID feature bit for the Bus Lock Threshold
Date: Fri, 2 May 2025 05:03:43 +0000
Message-ID: <20250502050346.14274-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502050346.14274-1-manali.shukla@amd.com>
References: <20250502050346.14274-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 40752ba8-8098-4a84-ec9d-08dd8936cc4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R0yEs6ppwAGLde3s+OU/yiTbhovv7SKXgb9PToGw+xX0JFL0ScRYKeFO5HF4?=
 =?us-ascii?Q?yWC1eo3W4yCfSWbYZuL+yM+mSJ3/HBHo9iqysHLBvPi1GPwb/uuafYyb2d9o?=
 =?us-ascii?Q?HZIJ2Ss5O8zspseWnKWn0IoEYxaOmq1piei91iiS+Sg5dtI82pcot9Wvkzv3?=
 =?us-ascii?Q?40oIUsCnc56zNFdZitJamQ3BIm+VlewKK/nI2Pq35QHq64/ldjR+kr8zJkLP?=
 =?us-ascii?Q?2RS512AAcMHB+qK3Ou25i5eYwfISXj+OlfzxyrHUkaZVyQMZFAOQd2prnBMu?=
 =?us-ascii?Q?R+LfNcX4bkKYBv4jyzwcZD8vQM67vWKXRDIiEthQQ3iTU7sGjaez1a+5J1Qq?=
 =?us-ascii?Q?csMl/Jht/hNt5UsDW8aFwFhS/xlpq3xdlx+qCyYNZrwml/1ygqvr4USNq44B?=
 =?us-ascii?Q?Eih2XULH0/mn4kEr6qnF50oz8noNEb5Ls6Tcn5aSJ/rLaPThfu0rVUBdPFkV?=
 =?us-ascii?Q?XP91A0X0lCV+x9UanHcyKtU5/M0n8o+zg6WlezSWlEK9HrQIqeugx6XlUH82?=
 =?us-ascii?Q?1yjZwPIYmJ98cUhw+YGJGA5UQYnONNaqIfpo3qVQWHMhLwd26tt0pIc03J/f?=
 =?us-ascii?Q?qnKaRaPll8OAvyfv1rHSi3TR/rgp7y+vEimdOHWHLukbe8iBXJv1cijLtEMt?=
 =?us-ascii?Q?btciJLSYeoKWqgvE4x/P7qRLZisU7bjr62msL0+DTAP0Gp+gYZ4zkrvw/iZn?=
 =?us-ascii?Q?FGTHamov/j8jqcufqpRQcR+DDDdtCXGO896P8nEmxz3yr/zTQb7hjWZS4W8h?=
 =?us-ascii?Q?L9NX0b6Z2aVV0p+qnnXNNRo820hJP9Mn2HsTzka9HgZrSLx4k3wx67UAdVAg?=
 =?us-ascii?Q?3dReeLjG+glkM8KSDK6/FsWlijLFBD7m5Jy+duREUuyKsalq09yKkGm+tBTs?=
 =?us-ascii?Q?oEKd345RVe/K722461PwDQ14mcF5WhmrSDxTtUMtM5Fv9fpOToFoeAAI2r45?=
 =?us-ascii?Q?tZTbpetggHQFcyi2upvYNvDShCRBG8uTzZe/+x4A18d+5H6+0enyPtb0fCUe?=
 =?us-ascii?Q?xqIoH/MeHddQkZuaYsHKt6+56tAXVrxp27qcwhpfXqf+vZXOSCoXZmippRGA?=
 =?us-ascii?Q?MrP15/9OCm1waLyOaDjDPel6CeVAkTBaDfijJltop0z5uHds0s2bAtI30KKJ?=
 =?us-ascii?Q?416TaTC2FKJ1jW6Brh/ettwBZjU9uFJEopeqcCsU+0OGZdriJeqV5A+usNPw?=
 =?us-ascii?Q?ucAcP97LrAn3HY/pB8WMrJdrNWRLMbEPBSGLohLoVvW7LkGpyQlL1UxpVZ+Y?=
 =?us-ascii?Q?vDnpLXgwQtaTQd5GtxlmGh8oPggoDyRaLD9+NYiYP0HWxGdZ8d/vScnwPGar?=
 =?us-ascii?Q?wTCVZbSW9ArM3fEuk15Pcpe9f1VK/qQAYzRJKcbwHG3b4NQNRILm20o1K+u1?=
 =?us-ascii?Q?fIb9QoIs7EqFrzSnoOvmr8YiuyDD8tbt6T35aoNjCQbqjqIQ2/dUECa8wsk6?=
 =?us-ascii?Q?BJhlNwsq4FqMLcWp/90Zm5ju/AHF41QdYZcze0XRZEgROcDktjgKpNLnDnly?=
 =?us-ascii?Q?pjr3MpqZGPxlkLGAXwuykT3RiUSne1CNGX9q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 05:04:20.4729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40752ba8-8098-4a84-ec9d-08dd8936cc4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176

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
index e95a8e9ef22b..b51f3ce84032 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -378,6 +378,7 @@
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
+#define X86_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* Bus lock threshold */
 #define X86_FEATURE_IDLE_HLT		(15*32+30) /* IDLE HLT intercept */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
-- 
2.34.1


