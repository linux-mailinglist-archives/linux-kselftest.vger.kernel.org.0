Return-Path: <linux-kselftest+bounces-4124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5366A8493A7
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 07:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788AB1C225B1
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 06:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463E3BA30;
	Mon,  5 Feb 2024 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kei2qE6/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B8010A09;
	Mon,  5 Feb 2024 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707113058; cv=fail; b=S3mKy2hEXp8agIBPj3xnse6KXnPL/SaaU/mkmwJuhN16OHBxz01w7fETqbCdi+XJt6nb6lc1qtMLndNRIvoYBj2ef/aWKWDrqpnkr5oN8SkMaXlRANSbkMojgmDXPOzMMazLuuKc6Kf8veUT/CL6Q0k+ZcRclhHnrRHR/dYfdSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707113058; c=relaxed/simple;
	bh=5bdAiRAk/l152HqTBwD2uoe7FkXNh1INEkyYl9QjsRU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mDE/cW4b15vKew3qnPGdVv+U6/PNuonU07TKTRLbX+d1+Z2ri2/7Nm2fz41tq2hGGOWF+UGO5daJEbJNX43Begtvu1jEPcG04+fBWdRZ/J1hjYRd7R/ZdS4jIeJJiOiYvb9o1ZJYaSH638PxzH+5NJbeSYcfaX4btC0WPjKYaOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kei2qE6/; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4GAC7QkUJBTtRcf5bCRibqxTeUp4JB5RfT49vk1EPgKD8t8zZKXQC2VIF95NziuUmeR0m7Hg09vnmu+v04lNt9ntwcN3NvEW0kK+KtKYegF/NdXylP4Zv8rCa/p8L4U80wSUmmwRikMFkkWxp94vw4NgdzIRd2nVB2ZleTL5wqxvmTSEJMM4UNRNTOl1aU1wUjrR+Tpc+jEq3MtOZ2YjUk258w8Bw061y7jm8Fly1IRU+C9UnR+0BFWMRh6E42FpXzhCP/F52194/zBWyL8XhArH3p1IoFJuj592cfux7UOykVEvIkeM+6goheAYvlpCS1v8FItCR5gSfwq0R/YVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8/TJOxeoX5B1QWRHui5UbGv+vdgRdbntv/9SDefCE0=;
 b=QpDsaKjAZMclU3aXUbfpNIgRXZF6fmg/saJddRsBRmIuc4DG7zQSF7chtYqkifZYlSLALmPZWGFImu5k5Dlv7Vt2G21onuSdhNAD/59MbzO8xAPfkIqiga7Xq4+Es51bzX3ipChQx974rAysKw2/+ZOyPtPtMGCriXNaYglVywrA+OCDUZWuEJK1mgW64J3iB53urK/+rYMHfkr/2OtuGzVUsZp+ckBJG9XOUSmbUznP9gmnwxpS2tSecXpX/5iG0C+gndsS1FY9CENS/t/WSFB0xOpSUz1qV2ACT0ccJdC5jiTeV87avOeK/enQ7/7mRP5oQm+p623OPw4jQCvJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8/TJOxeoX5B1QWRHui5UbGv+vdgRdbntv/9SDefCE0=;
 b=kei2qE6/y4zujNZW59lKTqs5Z3Z0k78RSy02RN4KaXSTh1gAjpREnTYS4XBP4dgJ/9Pr4eZVp/fjJPD7+3mpw1KCCX7f/au3RD5CU4xLo76sIlmoicdDPNcyRlp90RkpopWAmB/SRPoiOg1VdiILm3TLteNUBlZIx0IWi/VJNfg=
Received: from MN2PR13CA0019.namprd13.prod.outlook.com (2603:10b6:208:160::32)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Mon, 5 Feb
 2024 06:04:14 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:160:cafe::15) by MN2PR13CA0019.outlook.office365.com
 (2603:10b6:208:160::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Mon, 5 Feb 2024 06:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 06:04:13 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 00:04:07 -0600
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
 Natalenko" <oleksandr@natalenko.name>, Meng Li <li.meng@amd.com>
Subject: [PATCH] Fix the warning of amd-pstate.rst.
Date: Mon, 5 Feb 2024 14:03:05 +0800
Message-ID: <20240205060305.3594942-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b640e8-5d4c-405f-8206-08dc2610476e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AFxNiy0LW1mFXxpkKr+hHM+0lryalU3nxP54abietZc4XXzblZhhHXif3p+M1UDIs89FmC3D4k5gdllA7+JR/3mgM8azi98SAIbIAcyrsOaScUPT43dcQPtRjzogui+3vLvZb083ekDwMLZkfLRL44EXUzJIByhFakr4Fz6BPXwwL+PEfCe5sS0sjVVLW0ZXGymEH6Y4QD9wFl3hmyzzUiYAOjpbPBhQmgoVKfoITqkWsOgzyx14ptBWvXr355m24PJyMzKLLKuf1wQUxKJZ1DKUBqzWLv5/P/WpY0AfYU6BtoEYa+I7sXURfrPZKartXm1tPd8Nj2o+PWSaGfux5+l/WTXgcyRNkshdhKvG+i411rn9Pcrmb40H4YRNhieHM/nfNGVyqz2TT7cJZBZJlt/Y2krIp4mq4h8e1oMYbOqyUBQ5JbTWu5vWEQ2JXvq17Ya0xa+T4hKkq3YA7yFm1bd+G0uQOByYqX1EmBNMQrTHqtZtxpLVTLVCZlU1Sacsmbjl5Us09UYXCtSkSNGPtNk6qloiw5j80PXQ1JjMzG6yBMTB6lyD9AX5lN2LRGLn3AvZkuLUoOu8UXRYrd//WUrFnz9jG1qjQ+yfjm+KWoEBKFyRl7dUrHBPtsLFCCU5D2t10AOzxlP5tc7tivxZBH4ezd+uA2l9FlEhjqc5JMC+Xu/WQjgUubUj0pmTmwfqB4R//V4+Lh0ijUmYRryM1eDPmgYPxm2EW08VUlYmoZVyYhkh1qEmI0ghCFaMpMq/rTK6GSVa4vJMkXwvkLBf+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(110136005)(316002)(6636002)(83380400001)(54906003)(81166007)(82740400003)(356005)(2616005)(26005)(70206006)(7696005)(4326008)(86362001)(2906002)(5660300002)(4744005)(7416002)(70586007)(478600001)(426003)(47076005)(16526019)(1076003)(336012)(8676002)(8936002)(36756003)(40480700001)(40460700003)(36860700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 06:04:13.9055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b640e8-5d4c-405f-8206-08dc2610476e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359

Title under line too short

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 0a3aa6b8ffd5..1e0d101b020a 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -381,7 +381,7 @@ driver receives a message with the highest performance change, it will
 update the core ranking and set the cpu's priority.
 
 ``amd-pstate`` Preferred Core Switch
-=================================
+=====================================
 Kernel Parameters
 -----------------
 
-- 
2.34.1


