Return-Path: <linux-kselftest+bounces-2909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B5D82BD1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 10:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F9C285F75
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 09:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5FD5DF0F;
	Fri, 12 Jan 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VaWReXv/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D85DF02;
	Fri, 12 Jan 2024 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXou3Mbuf5/GZpTYPGmzVL+NRyHGS66pVFyMgowKRw9NTgGKH1pZU011O8sWAdHAXuMQ2Uh393PjbZrnh2lT30NZg0/7nHtoldPKNxeh5k8N72FebLhbw1iFAywij8FlQJ7bGU+qauDhv6cgmWQXqYW+UgSEiKBY82min2im/+9SVQlKVPMdD7beoBgGLZwKWiJb17l17/B21jfJYW/drKf2Lacqp+EZgJvT4TeD1gNnAG6hIbmqFbYLL3/A4KW6qZYw9OS0fFrbwskRgXjytJfUOGuxb6EPXT22AqYas2Du7f0F5QcwyVpb1AiDnzW2urABw09diZkspN1ednYYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hu+YEu2Sbk5GsR0yEizZBiZEKUntkXmdXSeViAKSt+8=;
 b=brFxmHJNUPb+hnYhMbMZR5vlZmkDcnAeauLCmP+mHvvRTp8Q0y/ThcIeXnTIgQV1QC/t818j1dVShdeC6IyF3CcgdYuJpE8IsYOZEYb/XrTmL6q8W5YMBHgOugiIV7e2ZQWY8zqbItQ5gy649CTN+8EwAa6w1jJGPVLXCRdj1YIe779lh9EDdssgaU221i0URICCyyMI8edzmU6o6/xUN2WhbHJCzKpKPp7yH9j3Ov+CA99WrGpjKFm2kL9FRLU2VU8YSr9CRj0rr/u7b07aWiZSj1KAhmDtT616oAp2KIwPGbK14Il1SMZ6nFwbMmdFCjrRadyxdnSux9FBIy2d6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu+YEu2Sbk5GsR0yEizZBiZEKUntkXmdXSeViAKSt+8=;
 b=VaWReXv/BPR8SQ0iwXg1ZA0MYNAE8FSTwOJvPqNIzFlex3dzT3lo6PA1K16Jt4FJXi1qFxXcEvAPK2tdvNExm9e7q6CB+LwJ/5PhCgOjPrrRQE142UMAV9+1Rs8/mMLoPkhboMDY4A69uZIK5fqqZ0dG74G/89PWaD1WYP5vZqM=
Received: from DM6PR07CA0091.namprd07.prod.outlook.com (2603:10b6:5:337::24)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 09:26:12 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::ce) by DM6PR07CA0091.outlook.office365.com
 (2603:10b6:5:337::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Fri, 12 Jan 2024 09:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 09:26:11 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 03:26:06 -0600
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
Subject: [PATCH V13 4/7] cpufreq: Add a notification message that the highest perf has changed
Date: Fri, 12 Jan 2024 17:25:28 +0800
Message-ID: <20240112092531.789841-5-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: cf901fd6-485e-4886-6d4b-08dc1350844d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2c7Xt0F8oRAAsEvVg8nWjqLtEW7Bl8HjKEWOBw8iiDZeQ761X0UWj2HrOqGYHusYnB1qticff00LtnngJbLn0061NHwt+23rwj9udCUBKbmNv6YkUbjZSSkFhaAh2a5EBGq7SrEwLVVuL1zr7ZlJONoY9iCWiLLMbIhxYc/uR+4jGkHcRGB9tF+nAAZ3bcp+97A5wIrs8Lhv80D8X1l2iQz2i+twPI1/3DJG6rHinYqpNAa+O/s8wWH9k74zXuldrcc5lEa1vnB3SEY4tUogPLqKTDMpYdx+FkFp7bIZ+bOeQ8X5F3HUHMX7Mtmg1Y3YEb2Gu4ykHcMmwjsZ+Kj1WNKkzSPMl4oSNPtz54ZhcRuTCGffHaM0YY2rVQ4pCkadizRJgrxm5p6x0GMg56mcs1D2uTIB27m2XaGRnW0JIHjWKKE4JtkuxWhJgd2rszvFQLqjLaU05ier/8XMvm1Xwf66Pfxt1DJW3/Nl1otS1eXyTAMJgYj92qrfvxZ7sCWasJv3OM63t1He4n+3o1KeEXPnJ108LQjeonnhpDl9Q9faCMUsFMBV0EtzJesUPy1yW5+r8YC2u6jn9SZmFNL1fTkXOObJbH1j5GT7TZXPlwYWasMzezikCnDFQ0AJWmhwevinICavka+R45o7JDTvZWgMlX/5rFeeI/VVJdF4C2O+FRSWDHeC0o75Dt9RfA+H9TuLutrrE9MlYfBAmpIxLsGXN8ceCOUQtNH5GsxavEASdz0DpkGifMP3kkM44uHMZQH66/LP/JR8gljeqKTQ64gGkQG2doR+Wl2CkBH0XMY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(46966006)(36840700001)(40470700004)(426003)(16526019)(86362001)(83380400001)(41300700001)(7696005)(6666004)(966005)(336012)(478600001)(2616005)(26005)(1076003)(6636002)(47076005)(4326008)(82740400003)(40480700001)(36756003)(70586007)(70206006)(8676002)(8936002)(54906003)(316002)(81166007)(110136005)(40460700003)(7416002)(2906002)(356005)(5660300002)(15650500001)(36860700001)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 09:26:11.6808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf901fd6-485e-4886-6d4b-08dc1350844d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362

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
 1 file changed, 6 insertions(+)

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
-- 
2.34.1


