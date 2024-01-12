Return-Path: <linux-kselftest+bounces-2907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883E782BD15
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 10:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F572861D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 09:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EB457329;
	Fri, 12 Jan 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MmcxIbpg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB895D8FA;
	Fri, 12 Jan 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpZYEyMJQ+fF/BqBErpIWDHo/iEVRqDGMWai5rjohKgUDf3oZWICbTxF2ylRFbZMBf/Qfota17ZH/Or33WV8eDGFKLJxcHnxXrhCoMsf80H4vf9oBeE7fG0ousD9ITYZUixm+6yiSReJzAScT6e7DfUdHHuMdn9dq7re1iTB/g6zW9mMxLS2G+HlkCVyTghtFrqsb0qSWClHlWuIhXQycOGK8yEayD/1NLXSQYD39WP/VlUsCVuOOL5pqk4OXZsNFyrCQzW5Lv7nVO3mhaJsF+70E7OYQxwKQW3YWKciP3nPmJOFlJZcsfctzLjmFQqN97LxGn7BRwVc8aB4wkV6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhAG+etjlvt9pFUINrcsqVSFIZOqQVdlYf2BbLl182M=;
 b=hY6dHSkF90EZcpUT3g0XRyX/edJYtxIKK108xi0SwSHWB5P/wnmvH8/H/NitYXn3YI+uWrLibL0bsfMtXdJ/M9I+5hEfdpUwI/BgB+ZCNs9qC7Az9TBK2axQKVaT4YiS8V8IyaZxndvK4c7MCVXEA6HbG9dJUtZ4UXNpYy4/JNpPlkX9p+CcXYxbs0FizQ1HlEtp58JJUWaTGD1sBPDSbz4K9oy3y3KzcJMJsEHt2L4yxr5MdyiL5Ci6Lnx+O6wJX8YXUZTtaIRbVwLn0zyxT0/28PqUusYe20kwLKxap2DqTLQV+WNoOBK5e3DMrFpjuKSXFMhQINBswI7Ita+zgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhAG+etjlvt9pFUINrcsqVSFIZOqQVdlYf2BbLl182M=;
 b=MmcxIbpgRjstQmzClW1JWsa6hZypx52SxSRQ3QZi5oeBOzJxMhSqkAdVl7FEpzZ8q/Mc+hEpUK9HXF6EqznsE88dEbt9GLhIdIPvnGqssxgA0ehOUXyFEOfQynsskV5HHi9dCBwEj9nkZ5ZfosuvX9lJiYgrmp/fkp8dL65Kiso=
Received: from DM6PR03CA0022.namprd03.prod.outlook.com (2603:10b6:5:40::35) by
 MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Fri, 12 Jan
 2024 09:26:01 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::a9) by DM6PR03CA0022.outlook.office365.com
 (2603:10b6:5:40::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Fri, 12 Jan 2024 09:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 09:26:01 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 03:25:56 -0600
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
Subject: [PATCH V13 2/7] ACPI: CPPC: Add get the highest performance cppc control
Date: Fri, 12 Jan 2024 17:25:26 +0800
Message-ID: <20240112092531.789841-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112092531.789841-1-li.meng@amd.com>
References: <20240112092531.789841-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c6799b-fefd-4736-2b35-08dc13507e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ehNQefelvG43YL2ne//PgVJG+vSRvzEwlbzT8PDWQqd4kqUtfxQ9YOtJQr5hw37+MX1qTZB0KaTPgH2qEhf34ZQsTskIUlnrdFqXN7zrpUka69vXTicPqg6DhERoO/WylMzifoIR8jdr5D/Ll5sqcOdxQ4mskmm7fQ3EH0xR/5+/OCaEHmtABnbcsSUxtYBAp4GiGa9fkLpQenn+biz/o6j667A1f7DO1deDkwMyu1O2R6vzs11baUBegdQsSxM59Lquf78Twqwqcgd/d0nBaG5FAfVH4n8F8AvVRq2iYcuM5anccyZtvT5piMac1R8HDxgq82M7iPUkr1S4xfw34Sm+IRRGfPyEOF0AUqtCVvvfUA93UsRQeu/Rv03qUOXkUmIfPHchcNxpThAnoc9M0d7pahDHJ8SBDu3cCL2WjCdWwFzH5f3ebq98Q/wLk1rwGlVk2BLa/32KCDb+0f84uKv5e450hWzbksJLf+7TwfXQJffvoYmG46uyP+86x6s3rpFS6b2djQWu6ufqSjU2UV4cj853aQcM3GYrtRl92pj1tQ5Lqu+sUO8sGUejTJJ2zL5E+s9y3lQVY4ZGer6AkvEHGw0sgXPS+9n4H2cWw4nrFCphxqdyvkphc1s3jXQZDoszdsKr+JyulO7qz+txlhld1n8zXznWzs3VE55e5ICnNSZQZUObAX+QNMwSiS7jE/KD44TT9jxs8Qo3GOzopOYfeviOv5sWfaxOLnL4V6ECPqsJZfAreS9zPM3cUi73LYkwamGz4XMN8ffyfLBR8Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(36860700001)(5660300002)(8676002)(36756003)(54906003)(41300700001)(70206006)(6636002)(316002)(8936002)(70586007)(2906002)(110136005)(356005)(2616005)(81166007)(4326008)(336012)(86362001)(16526019)(7416002)(47076005)(82740400003)(966005)(426003)(1076003)(7696005)(6666004)(26005)(478600001)(40460700003)(40480700001)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 09:26:01.5316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c6799b-fefd-4736-2b35-08dc13507e43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295

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
index 7ff269a78c20..ad388a0e8484 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1154,6 +1154,19 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
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
index 6126c977ece0..c0b69ffe7bdb 100644
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
@@ -165,6 +166,10 @@ static inline int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
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


