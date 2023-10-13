Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758A77C7BC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 04:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjJMC6P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 22:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJMC6O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 22:58:14 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A622B7;
        Thu, 12 Oct 2023 19:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv1BQ7kN5PJCVH7J50F92aG86VBd6DfeQr2+L89L5zMWyyi16VKyOsCLj1WBIO0JO6t8CCnr7JJgYUuogepnrR8H2qcu9iB87vHH2L4NAgXfHbsELsfydjxCgQUVvW9mcOPDmb40SvNXWxHDH4IjJ6I8/79Hr99eMLbX1Vj6tNsT+J0SMMBk2bLU//cx8DZwtyi+QCl/QFIivOyED9fwYNxHz7ydtNVbAgvOihB/O66vMQH+xbPpW4KCCPHMdO9NqxjzIoMGPxgLzKpVc6TweJko2bk7Dj4etm+FpEzwpNkj/3W/WWkrNsb8NOtHmJ4YyHECzxHr74ZW9640kkZd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzEIHZpUA3AMJxzqDK5FWIBnTdRjO3KqmrHE7LsmiW0=;
 b=h0h9mZvjHeNT6s+rPfTwYr6PVNuP+THz0e16OhjF4FSUDmbdDk2VkU4UYQ6BGlkerJMczJFOrWDzIm2pdLjL4mAydf47cb3IVF0smqZk7QIjMO2EGMsT13qMVb8PvH0spoEsqMCk3a7b9LU+0BKHkDrOF3aiv4tTa/1ADJbeYzZtTM2Hy5b+7e3OomSDYxNe9sYKXmd3xVJ/CawI6iS9ed1N+CbTwPjYfwpJzhtRd5NTN1h6T0dc34jzJMOZO+9uF9VP2TQUdW1fFdumzE907Ye5PvUfqLqHG85R3MI5l7wquOHtI9ISAzVwiiunKOS/KjfN80ApCU8Y5fKL/jyK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzEIHZpUA3AMJxzqDK5FWIBnTdRjO3KqmrHE7LsmiW0=;
 b=tk7BZmLptW06vntZpdGea71JTO+V23ydaSlqldqU14nN1EJvxClryL4SPT/B3LEOp/f73m/1Zrj62HQNOHDpr5c9xmEJ0MocACJ+2WNQuKXBn89vM+9cLxu/3IFw6Us4xf92oKB87hka9AvjH7yrX871N7QlJR+d6uIYRNtqkcc=
Received: from MW4PR03CA0226.namprd03.prod.outlook.com (2603:10b6:303:b9::21)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 02:58:08 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::1) by MW4PR03CA0226.outlook.office365.com
 (2603:10b6:303:b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 02:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 02:58:08 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 21:58:01 -0500
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
        Borislav Petkov <bp@alien8.de>,
        "Oleksandr Natalenko" <oleksandr@natalenko.name>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V9 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date:   Fri, 13 Oct 2023 10:57:35 +0800
Message-ID: <20231013025741.3332520-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013025741.3332520-1-li.meng@amd.com>
References: <20231013025741.3332520-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: f834a5b9-5570-4a71-a937-08dbcb983ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WkhYQ/b3pk1uUxIkILhRJ8RawqtiR3H2tTncf7juJUsmD/KU5eDMx7dndAk85RUVSyZOffpT4f8e5BgEgfkiu7D02JfpN5C+kYFCjQJr9HOUKWC69HRhDw7wfvSDWf7aRFKTgZrmWDSyHMk9UrJFHuHrGFH0e3ocjP3NCpTww3lK/N0E21GIQ7+PNmWQjyy2IanZunG3ExSOcFOH2UiyRK8sG/nW3V7NMhQ8PpexDEqYx315N9vhxCSV5If+aeqoKfWBUgFz0/+TqZAgtjIC225O3SNQOJLbs9I92FQKJ6BRjSb4MyzMe2eBprwdavHtITxnmsWKXt8ogPzR25xHkvpYf4lPXUbtyY0evRktIrCbqMABp08O39MYzDOXW3YTDXwmpl3+Xa6CTOwXSNlXkf92zFRahq4l2lr5/2nwQulCalu8JmDwOdjPQXW/TDsWp2axH1JkxQfVnj7RMdykz1xzupa2bfwuLTRqirrJkK/UMfiL3z4t8Bsy5VSSqZAwlOb3Vl0vH5kEiYPWC5i4QM2YGt4TfTVNph+2A4zcI1OxEM9YEb7DdCvRp1DTY5BBwJ5lbg2iAJ834878TYxJARo4KnyxA7srolwPCYvPrpmHzrxt3qs8IWrym06CilspB8rxz8bJSUDLoBeNiNNN0vPH6+MbLO8a59hMhEx4x8P4MSRX9cji9kjWPY+nilM28hp4acO/JGWAm4cfa8BRXtaBrqLcLh5248yK7U0xmEVGWlDQZuYRQAgW/u9sUp/DcS0eCLP18HnAklP5VOplg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(356005)(1076003)(2616005)(7696005)(478600001)(6666004)(47076005)(336012)(426003)(16526019)(26005)(7416002)(2906002)(83380400001)(4744005)(70586007)(54906003)(41300700001)(5660300002)(110136005)(70206006)(8676002)(6636002)(4326008)(8936002)(316002)(82740400003)(40480700001)(81166007)(36860700001)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 02:58:08.1683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f834a5b9-5570-4a71-a937-08dbcb983ab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

amd-pstate driver also uses SCHED_MC_PRIO, so decouple the requirement
of CPU_SUP_INTEL from the dependencies to allow compilation in kernels
without Intel CPU support.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 arch/x86/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfabae8814..a2e163acf623 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1054,8 +1054,9 @@ config SCHED_MC
 
 config SCHED_MC_PRIO
 	bool "CPU core priorities scheduler support"
-	depends on SCHED_MC && CPU_SUP_INTEL
-	select X86_INTEL_PSTATE
+	depends on SCHED_MC
+	select X86_INTEL_PSTATE if CPU_SUP_INTEL
+	select X86_AMD_PSTATE if CPU_SUP_AMD && ACPI
 	select CPU_FREQ
 	default y
 	help
-- 
2.34.1

