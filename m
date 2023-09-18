Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E1A7A4474
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 10:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbjIRITc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 04:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbjIRIS0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 04:18:26 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ED619AE;
        Mon, 18 Sep 2023 01:15:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3mf1nprw0km17DfmnWwr/9/ktQerxn+iF7zmWOpn7/J+h/1bu7tSj9eQdG7ArWi3JLnB8gwjvIakSTfjXnyzvEKqgC+sx71VjAB0EydlmhDCLlD8Bj+XEMrV750VYC6o5r2oOXNzRd7kIgcgBq1uEtYans4Ie4LXnFF4L32TxEnMHsOblP/pJiwm7/aXoe922adaJNBiygaY/rH9+CZ0PLf1xZl2Thks4SLFAh1HaUsIgnoeztJcMYwSM0bHR7LZVCTaOC3OuIXolmlNlriDUVzXOVWlreLgvKRUpPSB1cu34i7qSb/dm3fshVf06ODrohw03zx3FglLmUjZkaHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g494rm/WucGNct/HgYJq9c6LXzNLWaO7uYjU96lfJiI=;
 b=dCZx8X0IzWJpUqeixlIMt6ujoC/m2mwTMNbdc1u8aoaVPvQW+ky9YK9BHARa/dEA0Fi+2dE7EWu8rpKNLRtXo0sSBTZ9DhXj6waoZPGlsynGJPzX/tGU5FzwL8yyZqfSuLvI2rrqzLBeo/d3cDJUD+t5PmPkbp+5EXRlR9yCC+Odl4vdwvThW3JIpXn5sL2lGfucA03eJ9QXIih7PugZ1jsDC9h3sCYrZjUO7pFsBFNSzLdrmm3ksuvh4592metslgbCUKsFEUvYHzS7Kk10mKU23a7L97jCLZ8PrLKyPdws4+pg6QzJg2EzBVu9/t5AkP0BRIa8xUanTsUGQqgedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g494rm/WucGNct/HgYJq9c6LXzNLWaO7uYjU96lfJiI=;
 b=x2Y8K9ehOO+pfIW/uq+HiRg5qS0sBrgHDWHF+g0JwXVB/SuoAZ5/+kwn64hwqDgH2W/eoXu7jH5eg9pix3cbavhoytj9Wdb4h09YZK+yS3pEtnSbr29MVWnwuW2eNH5oXEKVsjAan4eC80coOgALmfDRgihtyYm5zIXOO6jMrco=
Received: from SA9P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::22)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:15:39 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::e6) by SA9P223CA0017.outlook.office365.com
 (2603:10b6:806:26::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 08:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Mon, 18 Sep 2023 08:15:39 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 03:15:33 -0500
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
Subject: [PATCH V7 7/7] Documentation: introduce amd-pstate preferrd core mode kernel command line options
Date:   Mon, 18 Sep 2023 16:14:07 +0800
Message-ID: <20230918081407.756858-8-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918081407.756858-1-li.meng@amd.com>
References: <20230918081407.756858-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd745aa-53ee-463c-1750-08dbb81f71c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrH9EughjPkaI6PUgGmq+StlOvMMG1qqTnTq0ngYV7DNwN7UAgHoRziWj791pIQ7v8U+539tG7YIfgNwKq/7LZ7WxxBJ/sQZ3qX7p/172K9yU1B3ZxyDHGhkL7Cm0icNr6Dv3rQzG1N8dei+4Uwx5Ms9OvtqOFRYgXkgpvkIgVAmt+qBWHkysG2A1dMSzDGZaBW1NERdndYniFmdGDBU+ejQi5IApJyL9yYFExJCQ6EgJ0ARLTDEAPHtx6yoUquytsZfrtDdNkiY1fyUO9mRJuGxKshC6RUQGrMXdtSpwEVukd7FsW8ra/koZ2MsdVtodYDImMI7ikrHTUKE3aiB3akNd7MOi4PIVEQTdWv5jGZQp8RVVHFK9HBxs6sUqUmn5EZ5FEWP/BBVMsFFduxRuzBgfNtzpBtSRlzHmp/bdYNkDdYZ0omAFaMzJWyjytiXbReC5p1U0ppxquHJQ+S/yjYYmxjtokydF3pHJwVp2OwghYaa+2dFGWrNecschh4g48WhTyF0Mefpyq8R6u/yGxI7c1FWooWLEFYbtiLvqc4CtDxBLFfOG+7rh1cGG76/13d2mP//CbEZuB27csIs3shL+r75d8kHcZh2Z9RPuR/MX5goBr4JlJGaO9sKuxC0/m+oosKQ+XtFEbbC/j5VXNQypz/hP23JzfBeMMsfqAlSaJtREFSzMIbVC8Ecfe5N0O7OV9SbsP/fCEIi4u3zOPTJmOB8RbKd3g+7PDwmeId98dpqlqqPUK0GRt+UMJY0sSjbxu89h2Lxq70xAENK8mwTACnFCNTiX9gbclJLCLz6OC3OMaYlKDFjjTOEmUDa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(86362001)(81166007)(40480700001)(36756003)(82740400003)(356005)(36860700001)(26005)(2616005)(1076003)(47076005)(336012)(2906002)(426003)(16526019)(83380400001)(478600001)(8676002)(5660300002)(4326008)(6636002)(110136005)(8936002)(41300700001)(316002)(54906003)(70206006)(70586007)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:15:39.4605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd745aa-53ee-463c-1750-08dbb81f71c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

amd-pstate driver support enable/disable preferred core.
Default enabled on platforms supporting amd-pstate preferred core.
Disable amd-pstate preferred core with
"amd_prefcore=disable" added to the kernel command line.

Signed-off-by: Meng Li <li.meng@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..e35b795aa8aa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -363,6 +363,11 @@
 			  selects a performance level in this range and appropriate
 			  to the current workload.
 
+	amd_prefcore=
+			[X86]
+			disable
+			  Disable amd-pstate preferred core.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
-- 
2.34.1

