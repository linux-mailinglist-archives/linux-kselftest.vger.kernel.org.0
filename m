Return-Path: <linux-kselftest+bounces-3229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA0083262F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 10:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C84D28132F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 09:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775D3208C6;
	Fri, 19 Jan 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WrBgEkFC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE33B28E1C;
	Fri, 19 Jan 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655140; cv=fail; b=F6pZRhtl+fcv7PnL4+s/HcAjSfxKNKtdZFQ+IvK4OfpoY3ceMJFmZeKBO7RgF/Yp4KEOr0oVk5BqnAuflLOnW0ULP4SAzj9Lw9woYBTxHXtd1gh1Byz/LnW1wI6bFvxlorS9dWrZ/BDg3UYvmrB2o7qqJMZyaEgkIc3GPKy2r5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655140; c=relaxed/simple;
	bh=fUlgzKnzc3fB7+gCxtVXXAfx38WxKH7jDvv3drZLSn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7todHpEFnP8fIixcxDXvbyIGuAu85vXFuCYdeJDL7wPqfTGZpBESafVRAG81KfUyaFMVdRvj7zLWfZmMLVV3c1H5SgIklYsMVKY4cRagr064GLMybYmFbjqubhXem+4AVQQ6u3lteCgq32O00rXjvtDPbS2AOE4umTjTrylrZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WrBgEkFC; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkNz2dzyOV63dLfEQqcZt0zPMdJ4XfBMeO1rvXBeQ0xBy2bXpYQXJKFLPrabwU5YorkY2eyRHSkoYqHrqhbjPvzhZl6kDTV159N7oj6Zx1dG1meVARKxdP2+QbdkmyRF8YZ97OljzGRjkCGicEy1I3P0D465wRL94d49ImKNefDSfPnz2JHD9uRxGOZIxzV8/VrcaCPW9Dy0RzneKD4lSmflHL6zbn/Rm317dN389lXlRaJkBmRXnndA3gKyppAdXILtwIUVmyAoJun+qWNurfdvn8jxivuI4pvFMLKswAEgtVNdsfzMX5Q8M2+rBFbDJZRRz7FGBN1Ipj3jNIZsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFeQvL7qqacHg17QrBNojIKDaFF8oH6PC0K92FptRRQ=;
 b=QO7bFhXs2VgTLZapHmZ62b8Tu58HLws0MmCByiSVNTjNKU7AsWuWBH6TmjUh/8VsatB6+6NB/zfo7/pa47FShQvD+3y2bCyatqbyomJoaLUbFqzNhYWoPOaLuzIBADLkP0SYiWv8Lyp86MYLECFMUPBz2K+7Qxq4uZY33r85hD0byrmqVtLm3X6igE0JlKiK2T1EWfMdMauTgmjAfAkN+XdtwrqNN6yd+Oc3pQQyA5AXocgy8sHTFhoy/LnhOO0AoxY6fKtsZPr3qjuV9tPQl8XajO5NArFV0k6aLZV8cCUdu35yv0CH55149uvc9sSEUttn/By2SbyIBDQp7vzttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFeQvL7qqacHg17QrBNojIKDaFF8oH6PC0K92FptRRQ=;
 b=WrBgEkFC9BFI71W9epFcGrwFuTx+DG2RI+1VsU17OfzHI1dq60YN/GXBOtE7PPQXBRTD47rRr8VZ+GzkiaaAVHhx0PHSWvK3r6cMm+Ph2SVLeE8077O7XlAiwkhk+PEUVr5LdTl2NFj2Ch/NXIoT24Drby7t6oIp9QR6G3sKCHM=
Received: from MW4PR03CA0052.namprd03.prod.outlook.com (2603:10b6:303:8e::27)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 09:05:36 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::a) by MW4PR03CA0052.outlook.office365.com
 (2603:10b6:303:8e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Fri, 19 Jan 2024 09:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Fri, 19 Jan 2024 09:05:36 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 03:05:29 -0600
From: Meng Li <li.meng@amd.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Borislav Petkov
	<bpetkov@amd.com>, Huang Rui <ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-acpi@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, <linux-kselftest@vger.kernel.org>, "Nathan
 Fontenot" <nathan.fontenot@amd.com>, Deepak Sharma <deepak.sharma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Shimmer Huang <shimmer.huang@amd.com>, "Perry
 Yuan" <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, "Oleksandr
 Natalenko" <oleksandr@natalenko.name>, Meng Li <li.meng@amd.com>, Wyes Karny
	<wyes.karny@amd.com>, Perry Yuan <perry.yuan@amd.com>
Subject: [PATCH V14 2/7] ACPI: CPPC: Add get the highest performance cppc control
Date: Fri, 19 Jan 2024 17:04:57 +0800
Message-ID: <20240119090502.3869695-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119090502.3869695-1-li.meng@amd.com>
References: <20240119090502.3869695-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff1bd3b-bdb3-4360-d980-08dc18cdcccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7LR1pr21SbhKmL5DIXr4nc9BMB3zH8+0CJghDwkYCdtXz9HnlBBxjDk2pOy9hfdXA/fdMdoRUe099SZlIhWM7+PY7yj+35p40ZOd6qjb5uSUJDmKjbtE8S1+6LFNao0wVoOBIJWxaQ/Z3LePgIRMGoof8VwX2KyksyW0fIz8sSApjyMUMFoaTdrX+2Vqj6kUuR5PEs325Dz78+Eg3IMlk5ZsguTwprzGFQif2j6wzY7yQq/T6koAZJIw47WzwDgII4S51IUkdXuLE4msFkBpKKvTMP64jbcybBOPXHUM5G77RwRZbPqRTCIFEGJ52e+20A3Dgpm0Rr7aC+6npxYQtPTHv0G7k8Vd8hS+WB8lBmz8NUgZLy4TAv6sgVwgz3xBHYAwi6L2t9Y7cWUNyx5HCmge4EGSPuDtDyBatJnjpHfg9YcxLdn6B4Eo9n033/6ED0o8G+gnUlnB9WrW2Q+44fsXdFkbpLDG4GB1/PdLh1ZnNesUBb4sKP3KcHdZwskvFusp8OuTrNNi1Lyh258v1Dt4OTMeh2TMMQyqjQ/U7vfpyYX+vYF1upAM0mXcUQ7ocXkO41zjUlpyuQASy6rPgj88dYUHq31iN2yTJNT15veLvzNy1/6LGdIAp9vSABSG9fyfUbV/Y5n7cR8/m+0fnq1NWo90TAP6+eTFi6lIbzbLgCXuO8VAfZt6/rIES3e2doppP35UNZ35zVncmYXuLtUjPvVg/8kn8YzLvxmtummCIsVrMJTbL/9zQsrVsbN3KUH6/J5GWTXX8qhf3yaifw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(356005)(41300700001)(110136005)(336012)(86362001)(36756003)(81166007)(16526019)(426003)(70206006)(36860700001)(6666004)(47076005)(2616005)(1076003)(966005)(478600001)(5660300002)(26005)(316002)(2906002)(70586007)(54906003)(82740400003)(8936002)(7696005)(4326008)(6636002)(7416002)(8676002)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 09:05:36.1741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff1bd3b-bdb3-4360-d980-08dc18cdcccf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170

Add support for getting the highest performance to the
generic CPPC driver. This enables downstream drivers
such as amd-pstate to discover and use these values.

Please refer to Chapter 8.4.6.1.1.1. Highest Performance
of ACPI Specification 6.5 for details on continuous
performance control of CPPC. Also see the Link below.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
Link: https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#highest-performance
---
 drivers/acpi/cppc_acpi.c | 13 +++++++++++++
 include/acpi/cppc_acpi.h |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index d155a86a8614..a50e70abdf19 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1157,6 +1157,19 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
 	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
 }
 
+/**
+ * cppc_get_highest_perf - Get the highest performance register value.
+ * @cpunum: CPU from which to get highest performance.
+ * @highest_perf: Return address.
+ *
+ * Return: 0 for success, -EIO otherwise.
+ */
+int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
+{
+	return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
+
 /**
  * cppc_get_epp_perf - Get the epp register value.
  * @cpunum: CPU from which to get epp preference value.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 3a0995f8bce8..930b6afba6f4 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -139,6 +139,7 @@ struct cppc_cpudata {
 #ifdef CONFIG_ACPI_CPPC_LIB
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
+extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
@@ -167,6 +168,10 @@ static inline int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
 {
 	return -ENOTSUPP;
 }
+static inline int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
+{
+	return -ENOTSUPP;
+}
 static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 {
 	return -ENOTSUPP;
-- 
2.34.1


