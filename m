Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C822D77C7B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 08:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjHOGUB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 02:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbjHOGTW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 02:19:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EDC2D42;
        Mon, 14 Aug 2023 23:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwbS2qY1le5pxV+06Ofjn+5LOoqb1/kBf9GJVEXq/mLto+Y0/i5kSwivfxTTu5QUiHNwDP9u5cILIYHd2aD8qhXXzStF/eFBIbiIAvcyTTSXYBciPv1CWdJrbvKVp7EyFiGzB85nLXnt3AluVFSBYad0jXome67x4OEpa7b6HGaENNyOmaaQe9TTBnUXyJT2m6VM2Lk8E+ylVO2oJQ8Bc+ozEvu+gAQ2u/y8Z7aDycQdqFSCZH4HbbYYXIwmqB5xLFBrhpNNhh9htppKxH+fHpVnV3+vpGy5ikyq4PNL9Lh5TOaaeKFZ3n5u+ICoROZNQZ5798QwdqItKehDf+mdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UatvUdnAHKDm3NQ3MVcDdoeY7zuTYCcF2McOkq3aFNQ=;
 b=QRwcroT9IMFWNxEIcUcX6UT5m3WtExObUtsbYVllsFV5NMY9lkM4muWK62pcagqUpbUMyg3n0IqgPwhPp6AVRqnXTOkRwNd2x7fjKuTv1zXAZnoRTF28XtqlA4ztbCUgPfD5HCfj9JsLF4sgQdZCcx2lQ5q7cC3F3lMl2DSErnHHxjL70NdXIRb+v1tAOCs2leaTjpECVdv0x2TrFAKGATrMyf1OJokHu+mtBGmta4uuVEcUMtxtGFRLTyUD5pbN77HyXB/WlasojjRiBMxQKwQXOLSk6cyGIlpCWX7QCCYlEmyuF4TpC7UGnmckD4BRkSgfVBINqejG6+Odw8avIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UatvUdnAHKDm3NQ3MVcDdoeY7zuTYCcF2McOkq3aFNQ=;
 b=pSSn3YUckvG4Tb99X0V6xppmeeuIltFlybJOUnwGqa54gM5pRVCpluxwlf6mSUP03Ezez1dxpA4U0fx5ft7YZneaMKVi+ITAnoeUtfYeTHOrtFtbnNbtTHXJ6WWuDJZ5AqusV3MMaFewDqGUGzkZ262aw61hC7Ti/FJHFL5jVvo=
Received: from MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::9) by
 CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Tue, 15 Aug 2023 06:17:33 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::a4) by MW4P223CA0004.outlook.office365.com
 (2603:10b6:303:80::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 06:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 06:17:32 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 01:17:22 -0500
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
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>
Subject: [PATCH V2 6/7] Documentation: amd-pstate: introduce AMD Pstate Preferred Core
Date:   Tue, 15 Aug 2023 14:15:45 +0800
Message-ID: <20230815061546.3556083-7-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815061546.3556083-1-li.meng@amd.com>
References: <20230815061546.3556083-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: a918cc8e-b72e-43a6-d2e9-08db9d574fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7oYhXr0457ow6ofVQ5sTjl7cbcQw7n0zgXmKH/1oG74PQWkzEiqptSzx52KXWlJ7EkryHJrrM7rEjslgXLWE6bTyxdWdvM8Jp7g2T6DOUJT61zqocXiVKjHFTRVbuj/wM4GGn3lBudDpKClQ0aXYfnU9UYjWW+EuM3FZyvwIiYFVeuCUDlbnZ9G2Cqi+HkUVcoQo8mhNIVGDQqDqU9VPFOgLeBBCxW7m5j5GguGIJIc5+pLxceI1J0riYFgnWNoIfqqRHiQ5j+XYwF3EdUD/MXVf1g9S/SVjzlvmJ+nRG3vHKp3IBpi7oOb8G2q1wKdUvrgF3P2BSy2MY0e2qDcja1DKmdx7aR8HijeWFV8otTnrAAvyMajfATxA887+UQjIwrLYjnUxWhVnUWeq7kmERpUEBk4u6wh47ZYYQfVZLVp8PBnvEOKgr6xmJ9zw4hxDsCSo0FJpsRnCfqLT5Ljg3bjSqetx2TP6yAkvUQy4MLPxYQ8HCD1CRI4ThLRn5FU9SHgh2qHSt9cj2HItYR1AVp9pDjrRMCflsD7xO294ZFVQQTCg6tq+7WO3ApYhcLRo6I1aIYrVs7xJlZGtlC/8ejv9DwHPDaw2ZBiu7B3wg5g2aHZTZP1Idz5geKEJ8iYvbomRI+EOztw2sqYf+C0fnctNG61JlQ7pabFfhOjZtOvJjYQKnEYS23+nKT2lsAfDTHv9zsRo3Hi00RlE+N210NZzwL/yr317eypmoNmNeH7WyiT1hdPjXX8mqF7KvaZELwPMiRyCK/JY8wTVuZz5Nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(1800799006)(186006)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(356005)(478600001)(81166007)(82740400003)(8676002)(6666004)(8936002)(4326008)(110136005)(70206006)(41300700001)(316002)(6636002)(54906003)(70586007)(36860700001)(83380400001)(47076005)(7696005)(2616005)(1076003)(26005)(426003)(336012)(16526019)(86362001)(2906002)(5660300002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:17:32.7378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a918cc8e-b72e-43a6-d2e9-08db9d574fc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce AMD Pstate Preferred Core.

check preferred core state:
$ cat /sys/devices/system/cpu/amd-pstate/prefcore_state

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 54 +++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1cf40f69278c..ef2b69935311 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -353,6 +353,48 @@ is activated.  In this mode, driver requests minimum and maximum performance
 level and the platform autonomously selects a performance level in this range
 and appropriate to the current workload.
 
+AMD Pstate Preferred Core
+=================================
+
+The core frequency is subjected to the process variation in semiconductors.
+Not all cores are able to reach the maximum frequency respecting the
+infrastructure limits. Consequently, AMD has redefined the concept of
+maximum frequency of a part. This means that a fraction of cores can reach
+maximum frequency. To find the best process scheduling policy for a given
+scenario, OS needs to know the core ordering informed by the platform through
+highest performance capability register of the CPPC interface.
+
+``AMD Pstate Preferred Core`` enable the scheduler to favor scheduling on cores
+can be get a higher frequency with lower voltage under preferred core.
+And it has the ability to dynamically change the preferred core based on the
+workload and platform conditions and accounting for thermals and aging.
+
+The priority metric will be initialized by the AMD Pstate driver. The AMD Pstate
+driver will also determine whether or not ``AMD Pstate Preferred Core`` is
+supported by the platform.
+
+AMD Pstate driver will provide an initial core ordering when the system boots.
+The platform uses the CPPC interfaces to communicate the core ranking to the
+operating system and scheduler to make sure that OS is choosing the cores
+with highest performance firstly for scheduling the process. When AMD Pstate
+driver receives a message with the highest performance change, it will
+update the core ranking and set the cpu's priority.
+
+AMD Preferred Core Switch
+=================================
+Kernel Parameters
+-----------------
+
+``AMD Pstate Preferred Core`` has two states: enable and disable.
+Enable/disable states can be chosen by different kernel parameters.
+Default enable ``AMD Pstate Preferred Core``.
+
+``amd_prefcore=disable``
+
+If ``amd_prefcore=disable`` is passed to kernel command line option
+then disable ``AMD Pstate Preferred Core`` if platform can support
+the Preferred Core feature.
+
 User Space Interface in ``sysfs`` - General
 ===========================================
 
@@ -385,6 +427,18 @@ control its functionality at the system level.  They are located in the
         to the operation mode represented by that string - or to be
         unregistered in the "disable" case.
 
+``prefcore``
+	Preferred Core state of the driver: "enabled" or "disabled".
+
+	"enabled"
+		Enable the AMD Preferred Core.
+
+	"disabled"
+		Disable the AMD Preferred Core
+
+
+        This attribute is read-only to check the state of Preferred Core.
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1

