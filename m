Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DF6786523
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 04:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbjHXCOt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 22:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239332AbjHXCOp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 22:14:45 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659D810C7;
        Wed, 23 Aug 2023 19:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/FiMct444vsyBl3A9lB4hdxevzC4d0Q5Hq/eA8V0RffOxDM0sEnLjv3Sb6Gr3dypbCpySv3clLGpBSwMvVZ1f5mSMWsJ3sLgy8W+HJZNLmWrdrDjhy0gv8uCQ/ZtBPpPyW2ik4iN8dy+0GWxP/cZKWJl/RO8BBOmPhKsfI+w3HJ3A7KMtsIZ/ZyBFAc2wqiyqAPmcJUekOdeNzIC90y6R2JIwf/HY8QSIZJ1dnJ/WTrBJy+4UVuDHRrlGnG8/paqBRdcz3Y+T3YLPfdhsOFgNVBYhh9erYwkleMGRM0Z/IibeoXMbpIz/f2ka2WnMhur9/HWDJIyNlQ56cyzxEf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/CkHh/XcfhK0dNgI9Hlr7RAo8wQP5DuG9zY4ElzxDw=;
 b=LJWSARFhr2UBHlLgX2L7SDHdxmjENUA3xNPL+3JgwB7SML4Pn/ryjdVNL6J9VyBGh/iABGkJ63CIXUBtTCXPhjlUEsjgxJlNqOKe0k53eRkuV7pi2JWht0TbVgAxHkUC6aV0udKb1Y9cMdM9skB65ptS7WXSZsXmgcUFBY+sreLIP0N20ww1yPdTszeG65A0O22LHxHJnzApT5RvUqhQ9FL9ml2kgveWGRKN4cqVrVigJDPMQn8qk1gMgSrsL6t2+RFEiRFsq1Wk5huxUCQSrrJh+iYJ8YzRcRwM9BhFtru9sBDwSoqhxbtkOKopRBRfu8fP+T5PX03lK77lcNsl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/CkHh/XcfhK0dNgI9Hlr7RAo8wQP5DuG9zY4ElzxDw=;
 b=Y2DnfM26rVXnXsSZcBGAMJSUSggeuCKVzWj0uPOTupvH6CCd/5j5OOGUNzYCjHYlXNzgn6pEdSsziP0M2/Qm2G9F/HfnaLAcpgqI7JEp2iO6O/azXUYggEEHNWBmoHKVRpuo7LtpwDhOAVXdqAVExqBv8rxCcQfaOeBjBypwt0g=
Received: from CH0PR03CA0423.namprd03.prod.outlook.com (2603:10b6:610:10e::6)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 02:14:40 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:610:10e:cafe::5c) by CH0PR03CA0423.outlook.office365.com
 (2603:10b6:610:10e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Thu, 24 Aug 2023 02:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 02:14:40 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 21:14:35 -0500
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
Subject: [PATCH V3 7/7] Documentation: introduce AMD Pstate Preferrd Core mode kernel command line options
Date:   Thu, 24 Aug 2023 10:12:49 +0800
Message-ID: <20230824021249.271946-8-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824021249.271946-1-li.meng@amd.com>
References: <20230824021249.271946-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: c99c7a61-37c9-4e16-b9df-08dba447df8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vdMQNOvwAMizMj6y8fms38UbY2Y+aQ1d+Ahofecj9RCFsEFPHU6Phtt9TLuCapqczl1NGDg+/Jzppc0HZOKyjfBbOnjxg1ie3Rr5Vs5yzoIcBjOoG9F7cknEpUSLM38G+WMMuAea6uym2PzCcs18taHgxHGmeyiJ7KgYtZVmqiu7CE1wL3yUh1XOLgqgJbGclknCITCobyCvMjKmhaaLjgSxCjCp1Du9msNc2ROasSFFWMCdQsEOZA2BFc7SoenJANTyEkQrIYC35ImSthVVnGadgsWjyzlRffMMBQ1E0FJaQHfNnQgig5j8YuFgipd+FDFHM20/LL3CvEdhlMPfpEUquS5pU3C2aDUJOXMDol08Q+ZnH7efGi98eTg1GCqqgGjfpyB9Qz/SHx6hnmmoskDM9gWlMLYu44ZAbqKJnwJDl9rG4XvOY/mirwZaz0Vo08/mSzmjNDyrV40ElhYHzt8X4gQFspOV12Flm+rbze2a5+kIy+E6exLlTpNwsWf/m1MTj5vxM846QqvwkF8eC8xeeFQdLXCZzuG4xulu1kGmdFdtBAaaMaV8BklgGJav8yqSYVzAglld8LdVjrLaO/TgwX4HkdcdXPT1FPZuSvfyNUFjL5lXBUQghuKi2Y6+o2ZXt9O4FzZijI1jAY4Sq1u461koAaXogqsFW4cPvtW5pLESt6GJzYkV7KlVpJMsR2/9dNTdlrW6N4TBLa2Hy9NmynM4k89tM6pDcN8Bf1NRhpA0I3tKNSeucYyIV8zyaUn0Gc3nukgvEDHmMpHigbRq4GaH3JV/m1SZB65xtRKFtNKTLnnc54Ejc09DM0n
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(70586007)(316002)(70206006)(110136005)(6636002)(8676002)(8936002)(2616005)(4326008)(41300700001)(36756003)(40460700003)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(4744005)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(16526019)(26005)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 02:14:40.2007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99c7a61-37c9-4e16-b9df-08dba447df8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975
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

