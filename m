Return-Path: <linux-kselftest+bounces-5477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B998689FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 08:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BD12897AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 07:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6D055E5D;
	Tue, 27 Feb 2024 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2+s3DIBQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F454F95;
	Tue, 27 Feb 2024 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019600; cv=fail; b=YlCO/RZ2WeFlcq2fcZXqYxxrYYSPAT3PwdIfR1bwqFDzod29NFW8QHi2TPszeIPsOkjpodDbl8COynPvDyJFWeFTX5QQoTvIBAOFoJTfbXzloaNDvwbLSShVa/n22ny4zkzdUIh8H7jBywskYLFrV34WNo1E53/CLPQ8nUuVF58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019600; c=relaxed/simple;
	bh=Yz3G3Ts7bvjNPaenbCkoZodvCZN9SQ9omF0RnlMrY2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iMHAz2y30bGeWr7yk8hoMPoipNUwqMWJ/HPccePVVx5VEoNdBzgpGICPJzhsnbxGjD3FLYhtHn5hcG4sLK8i0ZCEbTJaaH2hArZq1gf6nJxm29olk3DKtery5A+J28c55kK1r7CclgfOv91IQBg5SZ3QvmfXlP8oaCT52TlTLBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2+s3DIBQ; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJmYZ8fo7sn4CghnoKF2FcuYy14f7VhCW8PoSKJNLtIsmFkolP2JbDQSzzD2PIrwxa5tCPZWjqV+gb+LnLEzP/XFwsd/6gItGPbuPmkQGeGxQkFSBTUi+e2qhPdJtSRLc+nvgcJ+n6DedN7IjMKlSEvBDmFxZo81jDn9w+tfBP1GVCbJJu9zUhYA03/NV7GjI365csfDNKW6LoiJa/7ZqzLv0yR9q3sKWQn9hZ9nD72hSaGXFSVZoiXhga2jUQ58DnFITlMMIxfO7BHiMYN9+VkECnk780nkNcW+CHtszJJUxpc3KLZqknbYV9XqNV4hYk8rPgvO8uyw1NwRmZkpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DltwduLNgEfdqdfL67TzkuGukkI/LSD+thPg1GrHSP8=;
 b=H7LPKHCI75EbjXPh9z79l+WsBlxI2LQtcjtYDMmjJheq474i0xSLiZQAerHHWzXyPwv81lvhlUxawe0+28UVquazZCLDR1dEng7UWRx4iGN9DrwxulhQkL9oV5ECNbku+gus3lQt89hAtWnZDTreVYX4ob/b6UghV6pY902agcYYMiDwyeqDPlivVoMW9CY/H63LxtybkoqCv6s/KQ2SqFx/Om38qMr4pXJzDOozXm/TZwj/re57/NdbhZ0fX6VkddKse0vwxSXucHhvLffU1ONY9FDwqv4NUkbARCQzolWkrZjQc+RZBNh1Jcowq0amSsam3tFhYm140XgJgOmzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DltwduLNgEfdqdfL67TzkuGukkI/LSD+thPg1GrHSP8=;
 b=2+s3DIBQk+DABrPUGsT+r+a+QYNnpUUMjkT1UkA2hqJQmP7WijIIVydnQC/2upTPaGp1Arig+rLLIHpAGcRqz9NoMkI6wmCwRC2lpPvLHBxcciyQRd/NnFI2IXiO0ViyZmqtDT+IwT93WmAWhr3JG765TBPz2P0wA6tzLwMzRKQ=
Received: from CY5PR19CA0104.namprd19.prod.outlook.com (2603:10b6:930:83::21)
 by SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 07:39:55 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:83:cafe::be) by CY5PR19CA0104.outlook.office365.com
 (2603:10b6:930:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 07:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 07:39:55 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 01:39:49 -0600
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
Subject: [PATCH] cpufreq: amd-pstate: adjust min/max limit perf
Date: Tue, 27 Feb 2024 15:39:24 +0800
Message-ID: <20240227073924.3573398-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4e8e8c-fd83-49d2-9c12-08dc37674a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ADOHcWBtVy8+awhDpXNDG51PAeLRdhpWKCmDI1I11sDsEjdHDD18hfAj+UvOJxrElVjn+vkuRCnRNUhskKusg5n81opgG43P6cQb18epEmy+Xy0Phepg4i8CYoXVmnIKkc7fLEMeNA8dNYUEG4sLHdf4XuBMGHBlnwYZu13TXH8wWKJXdrK8ok8/crwL/bT8Qzkk/kg9GO1weOz+DMnyqMOstNSNEEc8mlYKTBdrawKdHW8RQNHDFyVWolpx7omkfA7vLDfJV8lfBwUlBTpE6hoj24WkMWjolfdMy0a5AtY4XsBCqTor+0IYe4DBHhUbUNXH6nOjc7RuHxFw80uA8YOKljG2E957Ub2VCnLTYF11XkbJ3zeLp+XfS5ZFb9Il5quRpT3oEA7ECfDuVVEcjtJto2Uk9w2NusJzoYVKGSO6JrgXaU38jSr9NEoYX3KTaj1P13aIdoRSEgvdEp/wh9xLGRfvPAifK+YzBrd2n+7NdXQ/mc0VLjOnEKLvjSTF7VJBDft4CEabwMY+3IH20bbBOH+v+sqTT4RQ5abWDYTeHJr82rwG1dlhT2w0S7UGWE3aWtHi3wO4iEoAyYL/HEioTulFqYJ/YI3AtLbRHRaH0/J0IrlB1F5qtOyHbHhnwjNz8L0IeYuaZYJLjvwG0SomWuHQ6U77Os40xoyNRDtMEMJAsdIsVnORHqXEaxz9Zros5J5d+P3jQLLw+iiM58CyyDWuiTcb+eOSX1mbMX/YKJ3wRrpJGcTl8d3OBGoG
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 07:39:55.0103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4e8e8c-fd83-49d2-9c12-08dc37674a85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159

The min/max limit perf values calculated based on frequency
may exceed the reasonable range of perf(highest perf, lowest perf).

Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index aa5e57e27d2b..2015c9fcc3c9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -484,12 +484,19 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
 
 static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 {
-	u32 max_limit_perf, min_limit_perf;
+	u32 max_limit_perf, min_limit_perf, lowest_perf;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
 	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
 
+	lowest_perf = READ_ONCE(cpudata->lowest_perf);
+	if (min_limit_perf < lowest_perf)
+		min_limit_perf = lowest_perf;
+
+	if (max_limit_perf < min_limit_perf)
+		max_limit_perf = min_limit_perf;
+
 	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
 	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
 	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
@@ -1387,6 +1394,12 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
 	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
 
+	if (min_limit_perf < min_perf)
+		min_limit_perf = min_perf;
+
+	if (max_limit_perf < min_limit_perf)
+		max_limit_perf = min_limit_perf;
+
 	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
 	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
 
-- 
2.34.1


