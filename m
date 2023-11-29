Return-Path: <linux-kselftest+bounces-800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59B97FCF74
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 07:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355792812CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 06:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C165F9E9;
	Wed, 29 Nov 2023 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m902KU9M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0553170B;
	Tue, 28 Nov 2023 22:55:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW5VbpPSA/Co1AA7LOR3kno65BRIQe1uaSisUZo/Gg/tj364n44xTdDpcLODgGyze+lVTnr3qUDUAo14x7Oz9CA1VU2rM1d2oawEWCYGPgfdmFUDZlI4b2zIcwrFHqFKr5FWPlvynEa8bTKF+END7SoU2atrlgQXwyquw9GjellhnOFtPiirf1ziyKrqF/hRPaxEO9nZ6rqw8pZ5C7VQ4V3STnqr8HcynstgjjEGE4nHyvyUUyf0ZCN6It1ZxmIV20WEGZSTJuA7pV7ycQ4EO9vAhKQ/CRONOQvkctnplC5hCPMS/N3S8/21Pe9nh7IHhNqA+N4x4pXWYWqXDiZ03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlF2WKiSUPyODRJ7ueMUccEPh7maCKY1Dj6+XRqyp7A=;
 b=oNO4x2zDhy6lfAlPQ1gUM8E9ewLgAGNIHbC6jtqo2TnMYvi4w2EU7GgSIvUaJZ51my1ZrB1784AX8bJ/8rmUdRkGdPqTKzAymzB6pMLKU+ztOrBPvDOk8eAPZN2NiH/Ih6Jqp+1ETc3t1MhFrsS9R49T6oM9Wc3NEqENkTDM4gd2sg15dAWL9vwqqNQUb1Zfcoteimxel0eEep2Kj1YPth/BkUEDotTCpkRRoXMLNmqbMSy4BOAawph9S9lLGo00/XfS2U2CcFhNVTqFrfsRZbm+MTpYuUDQh3+5htpt3vEQeR+UQEVx07f/uB07ywN4XMnAiSHSWmF0svGpzEP0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlF2WKiSUPyODRJ7ueMUccEPh7maCKY1Dj6+XRqyp7A=;
 b=m902KU9MxSu0YGFCv6HNFLqXTjHjjHaYfkn84YQ2llnyPc5rTRNYLXWEMrOqVA8cqkekiMeE2ZAg05GvRvzI6x1W+7X6Vie14Jx4KmN67tXIw35Ra+PnoKX40l6zVNX+d9K1DNC/wcgdZ4pE5HW5z042gNKz8YGyHjo8JNC08A4=
Received: from PR3P192CA0002.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::7) by
 PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Wed, 29 Nov
 2023 06:55:13 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10a6:102:56:cafe::ad) by PR3P192CA0002.outlook.office365.com
 (2603:10a6:102:56::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Wed, 29 Nov 2023 06:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 06:55:12 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 00:55:05 -0600
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
	<viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, "Oleksandr
 Natalenko" <oleksandr@natalenko.name>, Meng Li <li.meng@amd.com>, Wyes Karny
	<wyes.karny@amd.com>
Subject: [PATCH V11 2/7] acpi: cppc: Add get the highest performance cppc control
Date: Wed, 29 Nov 2023 14:54:32 +0800
Message-ID: <20231129065437.290183-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129065437.290183-1-li.meng@amd.com>
References: <20231129065437.290183-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d383dc-f687-4d65-157b-08dbf0a8229f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UZoNGauQVKFcmzJ2KW+OcM1ZavTe0Le7BdFoYnxfc7Y5Ph56J+sP2YVtCCrzCyCuQpGz/8cvNwlDsvpPoED5KQnS0n8ew3N03WZky2wAXHR2shY0IsM8jFvwVmKae2llDOCx5lwSeyUP7LrW25cv4pZn9WAji0dNS/goWOzMYefQ7ulhQiH24H1HXnG8QK5KI7I5aB7MftkMRbWlb4RHUUdxcV1DaA92smJsKVNY5Pj9C1K21nAoB+7fHsh0XXNmeRUJaiPYaAXYfcvVr/mkdsal58MhoT+K9X6rxMv1GoBQXRix0d7E7hvys1dTSy1iujPNiA+taYNe1bjbDxcIIWfEU/l8KtyfcaB+JtFf+z9ufuUIeYbxD7AdQluJ8qPG+kmh6mqst1pBKgcNZAA5Bz3UJ7Br0H3zbrnBjzm3rP5uK3aPl+T/idraKR1EId0UyufrwQphY1hL1U1qT+8iXVpSal6NDuHR9hhFAzWK7ym6946S7Z19QMe8juXd/8XamHfgtSSSIXFXVlszAktfaCaGKSCC4GONOUp1lXeNU6RthuxRij2lqXdNDEOHJLFWlgBUw+7/pLrd+5GwmG7GTAgv8F+LZXQEN8tus9gODFxIocweCntcwWnVE8faIoMqeUPj7zMDqDCL+PXBUxvZKnoyfgexiQUNlc0S5KEwU6WyfHmIwFWIGfdMWFI/FW2l8MhSOJmh8MHpVF8DNZo1DBO89qPD0GRYeQ89WjUdNlgH954DY+0pnw1+FfhO/K4q/O9V+YFS3+mPbgISM/mj7hRA7QGIAnbjyTB437YcQEw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(36756003)(41300700001)(1076003)(81166007)(356005)(47076005)(5660300002)(2906002)(7416002)(82740400003)(336012)(426003)(16526019)(26005)(86362001)(40480700001)(2616005)(36860700001)(7696005)(8936002)(6666004)(8676002)(4326008)(40460700003)(478600001)(966005)(70206006)(110136005)(70586007)(316002)(6636002)(54906003)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 06:55:12.8455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d383dc-f687-4d65-157b-08dbf0a8229f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018

Add support for getting the highest performance to the
generic CPPC driver. This enables downstream drivers
such as amd-pstate to discover and use these values.

Please refer to the ACPI_Spec for details on continuous
performance control of CPPC.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
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


