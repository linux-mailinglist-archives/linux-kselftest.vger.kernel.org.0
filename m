Return-Path: <linux-kselftest+bounces-1111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51DF804A4F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 07:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1F728167F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 06:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138DF10958;
	Tue,  5 Dec 2023 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3h06xNYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88625127;
	Mon,  4 Dec 2023 22:38:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN/7LR06pscAwohFv0wY3olpXghnggHJCSJZqXJhWH4cpBOwX8l8eR7or0u+NIpFiv+xODQ7PWfmGMyDWSM7VzjQUOzvbxjBKZL4k1SZKqcXPl/Pvu7spm+0rQeMZjD/S+g7WBWGgszuYRZD6KUgOPp841yOI7FEfucyPUoqvHxH6J9ZpwXHc7Egz2NitEj+MfYCBCUnYXS/UbzeDnUXUBMoYm9wkf8XAhgmhi+xYSquh+c5iU14z2+Qc7E1vIG6qrYyqte756EQlb29dPdNQfi3xFPnPXiQUqFIvtRmlYSmGnB30YDbeIBQeiMc3i9o+/NWYKhwcN0v9GzptIkOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDN7qozXIHo1m/GwVQvM3/83gkcNy5S4f7NMi2axIKs=;
 b=DDxPzLJOBN740YTVjqfUbXDiABYFZi5S28SVued6oUQn0ryl9Dzgf88rlJg6ArCqJfLEK3/Iruz5Zfgd4thV88Ob2RXfnF9YmE5HfB66w2qrGJMqQFyC46smirEqXPjQMOYl0GZP2mWnZO1qFV+j424APFUtGUzpCOcykn64GNqmb8r6SiMoKnJnZcwC43NzQ+ROYTwaZU8Mq7umkxJJ+tYuoaiCi98iO3czonC/YxhPmUoTw71bPH8HTLFxtfSxnQo9w0O6952bCkmDFZ2ruvaqmy0Kr4GwgCCSzaL5iS8C/BHQh+BbY2f1iZHGPTiC8oUAfQYvPukFfSF+tbzjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDN7qozXIHo1m/GwVQvM3/83gkcNy5S4f7NMi2axIKs=;
 b=3h06xNYBXNemOaWsCrHytjrEOjC0K7TqROj4RA0e27e6higZtpbw84ePqY6eoe0sZc3rX+FtqaUbdhiVfum5dw+Fn4XXaKR7xEaJONGBRB+FnkwLaEngDcTdPxHQn3tDoowX4Sfao1lceDV/8vAoYhyAuYKa+lHF6xgkuKSulDM=
Received: from CH0PR03CA0069.namprd03.prod.outlook.com (2603:10b6:610:cc::14)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:38:03 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::90) by CH0PR03CA0069.outlook.office365.com
 (2603:10b6:610:cc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 06:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 06:38:02 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 00:37:55 -0600
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
	<wyes.karny@amd.com>, Perry Yuan <perry.yuan@amd.com>
Subject: [PATCH V12 2/7] acpi: cppc: Add get the highest performance cppc control
Date: Tue, 5 Dec 2023 14:35:32 +0800
Message-ID: <20231205063537.872834-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205063537.872834-1-li.meng@amd.com>
References: <20231205063537.872834-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: cee5df21-9030-4f15-7602-08dbf55cbb32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z5MNp1HAUP5HtK9lCx24Izz8KSVAEiNWuePMFMEme2G3GbqdJ2l2T/PvoMvrnuAg6AEglMdgY/Ft0pvzAb1MI40iN4QcQ0RzOC73PfDaeNJJQyvWsBmGDxXyCpmYrEyal6bWIUsBcHAkelp0Eqh5uTAwWmGnpqGL5RIxsByEku4R62BpV/gmQ2x5x7zHK+j/ZIQpKO6mhlxDOIDMWlAU8BbhXzKhuzW3LEHnGtNVvc4aWWG9/UE4tGeErk2nSANgpjfQ7I3BuvYGswnEDabaNMEmVi7SVoW5CdNXtobLHptOAlCEBtn7rg2a3mm2x67Vl/Ln3EHxm0Tup9JgTko4IhOX+hPKXiCyFzsyWReYGLFFticxAlcbz2wCR5UlZnP98dFlJ6mHCYf/T+8KHncP0feKIQkhHAoM9gtyt2BYQ043oAYDeDZsUpWfhOnpUP5x8BraVASBREIn3JCXp/8vFmXuestnh4W6lPry/3sBnaNd7xFmILgOV4/+pCYhPlrw3Pf7RYmxikvOBTqU7Lk1CxJvlU/e8ftynkicQrZZNAnMnfd3sP7w6h9H+erobbv7GHswQ1cAFi7rZiDxNU9MILVTyABHq9D2UIivDjZlRgDcFfR7PPy4WUwIXnm2kZXtDqz8ryCG7kNOemuSrlWng615zmMAsSYqWPI07pr0NQYvI1ovwQVVwoYhGvD4IymTPK9s23Q3EHr1TGe2UdiiuTKC2NkE+VyARPS3VUIS8CwyaA/J30fM0I4LOjJ8PMM/Nc5aNVjTLnKb+yQQpixGROxqtCBvJjivoLtQY7FgFJo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(478600001)(7696005)(1076003)(966005)(2616005)(47076005)(6666004)(16526019)(26005)(81166007)(8936002)(8676002)(426003)(336012)(6636002)(110136005)(54906003)(4326008)(70206006)(70586007)(316002)(7416002)(36756003)(82740400003)(41300700001)(356005)(5660300002)(2906002)(36860700001)(86362001)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:38:02.8718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cee5df21-9030-4f15-7602-08dbf55cbb32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358

Add support for getting the highest performance to the
generic CPPC driver. This enables downstream drivers
such as amd-pstate to discover and use these values.

Please refer to the ACPI_Spec for details on continuous
performance control of CPPC.

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


