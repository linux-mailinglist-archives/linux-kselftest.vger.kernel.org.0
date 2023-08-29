Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF81278BEC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 08:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjH2GpW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 02:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjH2Go6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 02:44:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E2919A;
        Mon, 28 Aug 2023 23:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNB+XwKS+KPBNDoQJBiOLob8As0b5Xh97HxpZSzBXHPAXJftCH8e1gb62BOLlRyDMVdLKjgLdEhE9dLhvs37lkIQh9dHKpP0Y9nK4qDc/laBpOiZnpCON/o9BV5PdLz1Zt+8tuDX2ShzwsGJaV/nJzkVJMkodXRqKq9H1yZsC11v+6slXe3ty22G7NOIYq5zSpSaM69FZx3SY/wGnl5Do169hc3MsQKDojkgBQS7E+1kR/t9Sl0RsAjmltbCuuQEee6aMh7RtXeg7pFUsuNA9k3IWM59yL+HwoIhs7xSb69kLCz7g7Kp3zyB6sQWytCiD/gfbgrtuWcz2fMKtLUHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySCDkY3SwHwajCWe5ajIKv7sRTob2fWHJA9p1ak4XkU=;
 b=EiLyd6Pi9eHxQV2pY7I8r+xGY/u9GHA33ne2ZpCwGdIh+mZXZq4qjWWWEkTFueVZKtYV4c43+K+ymSsKVSULfgCLdcOHPacISafOhRqtJtcjl4b9qfyyFYkzsFKFoPKLpbzC1vp6GiDgrhNTdqHKdJ0OQsWbxJW95/vsf47o9SWi30F4Ln9EXJp5b7zzRHFiTla/GVykz2NLXB1oqUE9SegxHfrbrN0TqVkKCALpJUZWRZcsTZurCCRHHQRXAZ6AtLWy0FE4s02uyDu/GStOoMmIOXBiiPchp0QDzjme6BmKlTSbrJIAF8k+Uthzvw5VZDNK8YVuDoFHAr6rO+B3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySCDkY3SwHwajCWe5ajIKv7sRTob2fWHJA9p1ak4XkU=;
 b=mqKpK5aIS9cvBHntOCZZVf2ngyLSMvKh2kskghC4k2jQvWx5oTzcnP/1O4yDfa4uNMFda9l0xumHjXhckC1H6CtSgAE1wBLKV+wdPcXJ5txD7qV1dAvuD5H/bN9fVC6xiupIpJovr+vfasTALM4becRAFciD/Z44JM3CeWySMKg=
Received: from BYAPR07CA0026.namprd07.prod.outlook.com (2603:10b6:a02:bc::39)
 by MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 06:44:53 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::17) by BYAPR07CA0026.outlook.office365.com
 (2603:10b6:a02:bc::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 06:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 06:44:53 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:44:48 -0500
From:   Meng Li <li.meng@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        "Nathan Fontenot" <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH V4 7/7] Documentation: introduce AMD Pstate Preferrd Core mode kernel command line options
Date:   Tue, 29 Aug 2023 14:43:40 +0800
Message-ID: <20230829064340.1136448-8-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829064340.1136448-1-li.meng@amd.com>
References: <20230829064340.1136448-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MW6PR12MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 727fb938-e65d-4dfb-8e67-08dba85b737a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JSfa2ABAbD9Jm1DIz7/7qh8f438JdjC1TlyBiI/8w9+QUkHAXOLwWjtzAL+je3phyaIbH4H8+ztz/vLavx2RrbkxNC6cpCF3aA9/dQthBFouH04KqOry1M5B/Cvjf14LS6f81by9wL6Nx+pdwH265QwSCZMCZ/WeNTV4+/2dORZlwt6zAuyF2RfdR0gExnvqOpSLP53MlwQjmRhosICACGZJfm1whPvhHYkddMmmujw8cD29TeOmVGWd0SJbtrHQs+8nzgOHewBmHTyePGDXD+JyZ7z0aapaX8v0xxVNBB6CoYExN0aAph6OWSvEx6J9/9dbP77XtD1b7HSM8JeTTT01lEP8PJBkZgE37kio5IUCL3f4Solp4WRa4QoIVzH94SHG+YVTKMb3fIbJyILXE55uTehsmz6D3CfxAZAMo52S1vckEnECFo1gtdWAADo46cYploi5IsZzrBAZALnK32vzy6qrUNq+g0JBi/LID6RM5kXs0I3D+2v0LxgSjJuQaNqGRaOAjMaQqNP8yFmb0qcJBZwEsV86j7zZ56UXlAehQ5ZxL4vGwn2TIlxvmMotiV5TiMSKu5sCqoVAoIhnZAug3bEkrmg4UaGL/OyH/l9R//BZGiKrFF74PRJNoqg8Q4pcT2UfnhXFp3WCsA7KIvjJX5ZjKy+SKjsYLyBqYDj7BG1qbBWTxuuL2ZKL2xfxUHo5/KQbijLwJGQSMJzv3xu4ivTF5jTZoQX+d3u8PKMp3F1tbokRTv8Gf8uoVVziT8fDU3aHRhHFKkhkR583TQenau4GgQXiUyMLpAqlONpiNbXjK+bl+Z7AXCazbdP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199024)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(8676002)(8936002)(4326008)(316002)(2906002)(54906003)(6636002)(110136005)(36756003)(70206006)(70586007)(5660300002)(41300700001)(40460700003)(40480700001)(36860700001)(7696005)(16526019)(426003)(26005)(336012)(1076003)(81166007)(82740400003)(356005)(2616005)(478600001)(47076005)(83380400001)(86362001)(6666004)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:44:53.4240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 727fb938-e65d-4dfb-8e67-08dba85b737a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7072
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

AMD Pstate driver support enable/disable Preferred core.
Default enabled on platforms supporting AMD Preferred Core.
Disable AMD Pstate Preferred Core with
"amd_prefcore=disable" added to the kernel command line.

Signed-off-by: Meng Li <li.meng@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 23ebe34ff901..4f78067bb8af 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -363,6 +363,11 @@
 			  selects a performance level in this range and appropriate
 			  to the current workload.
 
+	amd_prefcore=
+			[X86]
+			disable
+			  Disable AMD Pstate Preferred Core.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
-- 
2.34.1

