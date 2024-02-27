Return-Path: <linux-kselftest+bounces-5472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2DA8689A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 08:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8BA1F27731
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 07:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682825465D;
	Tue, 27 Feb 2024 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LdZTQNhL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32452F9F;
	Tue, 27 Feb 2024 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017940; cv=fail; b=dPwYQFNVGyMrpgCO18OPENmdUTzoOTlOrACWBZlTogg1IKAQXAHZGMGtTwW6SYGo3QWAAYKPBG17xdY15OLDLO45CVW9E6T8hE3oRxXCnrmaC5ScIuQM3ubyhpHNGlIteJW55PFTO64IRgDR7rHifAokJYK/HPQRETTAnK94nI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017940; c=relaxed/simple;
	bh=kq1sceurUMchAfpkB1lvXf3zvZZHqE9kat9ss3M+cLY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oZOAJ0XBtlR8uzH/twnInEjHEcOl+VypaZT2OWmg2Sd1+HBgN0TvzuS9bedoxfCsS4xdhZTdGoEmHa2yAtFFhB7QbPwBGWXx5DJanZlxQXO/C3a7wZ7tCoVzIT/9Ih8XiW6yiMFNCE4i3yv9AuNvLwviWTz0qW6cCP3CJpFkxsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LdZTQNhL; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrFIycFe0ARuPo2qt32YOLLhbFmpeAn5lzwgKq60GrcH3UgmOwR1/zFXqUTw/Pkrsar8pENQoM2Rg3uiOtxXoiKJjzfWaKNBLzyIvgnP6Ya+G2fQvA7C8H0YAosi4kkxTwXOvJNtyYWU4n+lLhL8TjQtSPfmPA417YQnvbR7iNEPj/Ep+zUcF+g7DoFOxE3hdJze2EBm0xL57CE4mvGk3mzE9QVBuquWfn8Mf7CDLOx+Xs6CAqNOJx1dfjIaBhkLrzWhvzjLd7PZD3AEKOs4yj9imgHFWAskO37XRGqrP6fVx2pqZoiCDxh50lXvXxKyNFjNNLIYfEIsA4kvw/9dfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3da8yWQ6KFUyu95Iq4EmX/4n199CfeJWjlsA++VfZo=;
 b=f0DuPRcoLmCPQYhHSyf+LleUooD23eaRs7I4K/QfKe/7zSdu2bwu7boCh3vV4gsVDkgfhPRI21ptYdWzqSM0px2/73JUF3wUf2ucY4tdcMAq7Lf0zJJzZgYvSv0P5OwHvYSuJIlsfjAYKTOYDueE59SZILXZSzeMTrCHolfhqwtMzrVyagwFDjx5Xj06R9hDvgLBG15H64gTEI3MgA6RIA7vup8NmCA6F2hazKMT+8LinL0haWIqinANzfUbnL+jfQheCAsijrE2MQkDWpc18EA25pinNlyB8DiG2cwWfFSVH6M5jn8KZPo5MeTXjh0HUgb4TBUC9xQSgE9loNl3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3da8yWQ6KFUyu95Iq4EmX/4n199CfeJWjlsA++VfZo=;
 b=LdZTQNhLv/viNTJjYsDfjcTGTQwi66sRUtI3EvCb7Ix19d9eSvwHRk0I1KT3IuBcOriq+e1Wgrun6uGcPF96BoI596QgkFynFgtKtr1souDB+ewpLtb/B75wXGhcB97bZlAxOjxQfYle4L/iCLdXg4lAz4vUeFibWpYnU5Nf+bs=
Received: from PH8P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::24)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Tue, 27 Feb
 2024 07:12:13 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::e7) by PH8P222CA0008.outlook.office365.com
 (2603:10b6:510:2d7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 07:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 07:12:12 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 01:11:59 -0600
From: Meng Li <li.meng@amd.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Huang Rui
	<ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-acpi@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, <linux-kselftest@vger.kernel.org>, "Nathan
 Fontenot" <nathan.fontenot@amd.com>, Deepak Sharma <deepak.sharma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Shimmer Huang <shimmer.huang@amd.com>, "Perry
 Yuan" <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, Meng Li
	<li.meng@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: fix setting policy current frequency value
Date: Tue, 27 Feb 2024 15:11:33 +0800
Message-ID: <20240227071133.3405003-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac0c605-562c-4ba5-3903-08dc37636bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qN+SPSzs6vncy/9fpOB2BpN0lgl7HTnjFwFDl5ma8+/0mxK/bCUwMDIFd4GSqqG/Z0ddUKFFFiAUd9zzNzo3BFlZ3pKrTNdiZGP7PqmjmU/6lBsP2Am6l/YKIyyigvzVw+t4+w/8jzqDRzQlKEojPYExd2kjiC5TIvGhIaJjktKJxogGHOT+olTzgRY3RUrasz3sfAGafdA8nXbD6VKKxq6zTNITNPkMzPrIYahUmLFIofV2l3pV58izuG4uMAn2A5hfOKHWnAw03VRxnwSj7JqHj75gh9FLA7t+1khEsSAsFX0tLEqfsAjvrwbxcxEKKtp1Bj+5E42yE9x/otGflSFFwmDav+Mgk55XHuolgCpvlJNGRfv/14MHvXRAcvrh8fUF4m+CHnJK2SJbidBIcL2BoN4+mI0YmMf3qEzPiGLl+t+DBnsr2haCMr4WKcGZHxkbyOm4//VgIb2APO3QehkoCxCzlJlIi3TY6SH8F9IB9cQ6SRKKGlC8gH1LnkNXYPGssmNZ+g0b/O2TpcmmcuCtK5DIBvFIcT/a8JI6VIeesVN075Pb3kRcBbvtUz50chAp/7vuOhta+an3iEJwrZ270gLdGk5GTmFW26Z8ItHED1c1tRT8z8nv0xZDnl49k70xThp058bsHKn40RyShxgZivSMriPuwp2VQ9aO14VP6uVCOr+rAYzw04B8LlzveBzW+bYLRWag/w8gmdDOMlov2R00KyGiCKVrDVFPN6qMc0IjT0f+o74/nR2saym/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 07:12:12.9896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac0c605-562c-4ba5-3903-08dc37636bda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305

When scaling min/max freq values were being setted,
the value of policy->cur need to update.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index aa5e57e27d2b..a1062bc06a60 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -437,6 +437,8 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
 {
+	unsigned long max_freq;
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
 
@@ -446,6 +448,9 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			cpudata->max_limit_perf);
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 
+	max_freq = READ_ONCE(cpudata->max_limit_freq);
+	policy->cur = div_u64(des_perf * max_freq, max_perf);
+
 	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
 		min_perf = des_perf;
 		des_perf = 0;
@@ -560,10 +565,9 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 				   unsigned long capacity)
 {
 	unsigned long max_perf, min_perf, des_perf,
-		      cap_perf, lowest_nonlinear_perf, max_freq;
+		      cap_perf, lowest_nonlinear_perf;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata = policy->driver_data;
-	unsigned int target_freq;
 
 	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
 		amd_pstate_update_min_max_limit(policy);
@@ -571,7 +575,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
-	max_freq = READ_ONCE(cpudata->max_freq);
 
 	des_perf = cap_perf;
 	if (target_perf < capacity)
@@ -589,8 +592,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 		max_perf = min_perf;
 
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
-	target_freq = div_u64(des_perf * max_freq, max_perf);
-	policy->cur = target_freq;
 
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
 			policy->governor->flags);
@@ -1449,6 +1450,12 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 
 	amd_pstate_epp_update_limit(policy);
 
+	/*
+	 * policy->cur is never updated with the amd_pstate_epp driver, but it
+	 * is used as a stale frequency value. So, keep it within limits.
+	 */
+	policy->cur = policy->min;
+
 	return 0;
 }
 
-- 
2.34.1


