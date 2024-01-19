Return-Path: <linux-kselftest+bounces-3231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3D7832637
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 10:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA461C22D13
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 09:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC0124A1E;
	Fri, 19 Jan 2024 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N2B3XGLH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9833120B04;
	Fri, 19 Jan 2024 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655160; cv=fail; b=H7aE9O12Is7vw2pqnyPVUkrwk0r8TjVEqn58fYAxf+wzfzdde5t9eHf/ZWnMfdcKQs9GHNqEENXJMW/JWwfg6urZVAf/t0g3gQiQ7Z9mcdviYl8jRDXKe/ysEZZ8BYP1GI0722O05SJnniKHPR3+k8qQd5NWEjPzp4R9eyWkQPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655160; c=relaxed/simple;
	bh=V1OayLcmeJlCpgx/UxKBGPk/1NLKOBRH7mNZc0LgEeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VeKXOoebkgWpQUtHsZWs+GpqymtPrjPskDn7oYldOQXyzWEtJn8YWUjNjApJeQNZq22G2St7V1DmRKUUImSn8Mtu4/O43LaY9jWnrMZkK16skNQM2Rm/DBESELe0sJUxrzqzAT2LVdjT7FkXMKXAUplbOdWUWhtC1fvleJQu1do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N2B3XGLH; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfK2zAK0wKKCv5gxJgbeIXwkQavyGxWt4TIkAi2ne6BOID23r2/CKpIkzI3c6cush2lSqo4yLu8ZK2PKKMkInZCZhxOOlYmZCxeCm/XY2AccF8vf058AOzvBnxb7gvBRZYS+MYLkZ00mDdUZhcFEgLwj9QM0gDy+lT60pRDojmkuunACkGIa/Ft50NP53yzULFl/BIDHHxhuXzXMSTelAJ/jj9w1lBlWwtu2YmbM78i8SiXojVaX9Sovv/FUM5wy5CLRRWIY0toKB8AkiAfVKx9lR7NIxjOm26UCIX2CO69y21MC/DUPRSsnlnB/RJ5jGP8fyExjVdOuJ5PQ3xseDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCdg9pmNqmoh1l7U4NuKo2AiiwUzLmS/VGk1gX2Uj/0=;
 b=KsIh+3+lEp4uxNNzMw0fzJtBrC4Bad77rr1EF4euvi3Pl9+WD2uvKNcrxKBGjHmOVyJdfcFeDhgdJYnFPObqFeTmp7H5cUbRheU0FnQeCi8I+21pFQnOcr1UcI9Klo60/rz/NQv2mguJWndbCxsAbf6pf9xy44egm3vD9mHsEYZklzvjMt1eIrzrv7CbKNla8/0GYB34+BGS7uWYzUQn+LtcGdz1zYNB0iOIGHGD+qXqQX81tQmcKo2UlKoibvUxpdtOAlttcrmQwsUgTOS3uA4FiFOe8gqCjqqOLrG+dkJf6esYBzNHz2BLGVmIDifrfddTRKBHa0dFQ6l1WCOwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCdg9pmNqmoh1l7U4NuKo2AiiwUzLmS/VGk1gX2Uj/0=;
 b=N2B3XGLHp4sRzt3Ef4R9bvLs3BrlwNko5FyLje0Hm9CQxPYAHK/J/VrGH8TLM2RKFr+QjFWoHSov+mMbTEW2Iz/yWQFp59Ue3aiIPziUynVCcSckofCVMTW//cVzbzhS2CzAdZPXpP5GYbNT+7eyiRZlHe5acIEWBbycuO3KAk0=
Received: from MW4PR03CA0154.namprd03.prod.outlook.com (2603:10b6:303:8d::9)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 09:05:56 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::ed) by MW4PR03CA0154.outlook.office365.com
 (2603:10b6:303:8d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 09:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Fri, 19 Jan 2024 09:05:55 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 03:05:39 -0600
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
 Natalenko" <oleksandr@natalenko.name>, Meng Li <li.meng@amd.com>, Perry Yuan
	<perry.yuan@amd.com>
Subject: [PATCH V14 4/7] cpufreq: Add a notification message that the highest perf has changed
Date: Fri, 19 Jan 2024 17:04:59 +0800
Message-ID: <20240119090502.3869695-5-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: ac528c5d-d7bc-47c4-fbfe-08dc18cdd878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+HpEZcY04Lm35fvdVgMu16CPiEDbEm4PMfTQA3IR2DKWCnj1Lu39PZgCh7KxyzGEVMw05X6NkX5cpQ8WU02qs7rxm7Qtl2mClnnjV4oIQ9Lrrk4m3qvfpfqNNTODHhvxG26TXXDGgyq1RfpyIqvvD/Vv9l6Wx51J7l8px7Uo1hy+ZpsYPUe3W2qGfQMrhd8jv5BNNGBOKhOe2cd1ihI7W8rQH7DQPbI6FxBdvbSRTB1LVI2P2O4qLIhxTmjbeBrWsulYKrw/CleM+5SCEPBtAwcmg92EI7yB5eyEZaqkaPBrC/mNdn1dr8OcEuU1ZUBCxtNVjMyXZkbiCBPvZgGRIJT+U7Oqbe86Se24fMlfN6AeEHDVQMS3nnzAJUz7axShfOrfzBVgyiq8ahCm9hh6RvNvaWw3dRXB6DFuj+BCPWoIv4PhhugfZf6LjqBi0RJ/Oy/KxSFfwVAEeQNAOL9LgkMf1jDD+uVWPOkIj4+rDWwplFVOPA3UfglZ2uNbntq3EieHBnbyWBFGSMCB3r50JNGGQ9vyVjThLyOcSWRFatzjSms0XwLzraCPy50kKpQ5jytOU57s9HKSmBLdxOTYMEdPdOG7D5zFfEiy29CarastrxWeDcDiUtQJZgONkLxF5dqQDURxcDNyCP9MzP3Y6Da+XzGjkY3b57wem+xRzBdW0Q90MBU7Ao+Q2MGbwWXQRlAucw+8rCOcvDzMv0YA03wruDZITPc5QUjeScF60HOttb310oas+mg2ZZhQW45FIaudO/I7IVUu9Rmu/wCFMGX0icp+9jrfrpOcbupZAF4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(46966006)(40470700004)(36840700001)(16526019)(2616005)(336012)(26005)(83380400001)(426003)(1076003)(7696005)(54906003)(36860700001)(47076005)(7416002)(110136005)(4326008)(8676002)(5660300002)(8936002)(15650500001)(966005)(478600001)(6666004)(2906002)(6636002)(82740400003)(70586007)(70206006)(316002)(86362001)(36756003)(356005)(81166007)(41300700001)(40480700001)(40460700003)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 09:05:55.7531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac528c5d-d7bc-47c4-fbfe-08dc18cdd878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393

BIOS issues the notify 0x85 to OS that the highest performance
changed. And it will affect the ranking of the preferred core.
AMD-pstate driver will set the priority of cores based on the
preferred core ranking.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-device-notification-values
---
 drivers/acpi/processor_driver.c | 6 ++++++
 include/linux/cpufreq.h         | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 4bd16b3f0781..67db60eda370 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -27,6 +27,7 @@
 #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
 #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
 #define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
+#define ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED	0x85
 
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Processor Driver");
@@ -83,6 +84,11 @@ static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  dev_name(&device->dev), event, 0);
 		break;
+	case ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED:
+		cpufreq_update_limits(pr->id);
+		acpi_bus_generate_netlink_event(device->pnp.device_class,
+						  dev_name(&device->dev), event, 0);
+		break;
 	default:
 		acpi_handle_debug(handle, "Unsupported event [0x%x]\n", event);
 		break;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index afda5f24d3dd..9bebeec24abb 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -263,6 +263,7 @@ static inline bool cpufreq_supports_freq_invariance(void)
 	return false;
 }
 static inline void disable_cpufreq(void) { }
+static inline void cpufreq_update_limits(unsigned int cpu) { }
 #endif
 
 #ifdef CONFIG_CPU_FREQ_STAT
-- 
2.34.1


