Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E8A61E826
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 02:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiKGBLw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Nov 2022 20:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiKGBLv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Nov 2022 20:11:51 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7671AD79;
        Sun,  6 Nov 2022 17:11:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeW6usDGKSHtlHroCYzTmpediUZakn4dFLzDipAaZv2hyUJyCHtq8RoNw3h8wLV/JsryuXIz0yDHqnLdLa+msWR5LccjFhxPSLChmMNTt/BeAet8e8Rd6D7sHYOmTe7wmq+Hry5e6G+r6CjaZs+TCzwhE5Uf43Pjncn+9ZvIDHjisLLoSaq79h+dhzW7omDY6Avpqt6ywnnqNxzrg9vuID+jLf/ggCg4qiAX0212WoHxK/VCSjNM7zZaUAG2IHV7I8HKOiQHMuZGtbg08YJ5VhYSTtYAt2oJNurL46W/Du5zvJgRy4Ca6QnlrmkU3fR7g6kVbVNlbsOiWSZs6nkF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVyQHy8rhLu/zUxyrTuMGhUuZ1kQFIR4xyDfRzzWtJQ=;
 b=euDPVcph8lETLDT/xqsHqk6yftziZIkodSp0YuUVhBef3qb1o1IXl70/5Ghm0AwBQwCA1Cn2Htwg3O9Hb0+EKeQLNnk/1OPLbDCS4kqwhnjf3aQFmKZGU9TCU3cI7zLXWKCp+lJ7DT8FigXHDyvGAkbNtL30dTUAPVcT1OTWKyexUNbi4Uw+7ARmcyzzqkrrsymucXDq3m4NlLcBSEquVhDAb4pBnAOelnPQuMITF9+mBNkoV7FrVzlel1C6DtCl9imNv4EG5X88coYsgCTfO6fxkXAdDvUXDTBEBE89i9gv3j8Cm06KZd8eVGffuliTtEGTqPGZgthefaPcAph3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVyQHy8rhLu/zUxyrTuMGhUuZ1kQFIR4xyDfRzzWtJQ=;
 b=159ovfJUp5tFg4759o+Z9rvwkGqlmAGpM3KFg9e69qAIBYedQC8d/A5E+FyEJrbkNmgvakNj57DxIqb1yDeJJxwvCDhYxrVkNgz9kotOxb3AAjFrLZFhKNS/SgPZ+foYyLNaQxFtKqjyRREY5HKEMu3nk8NXPMGBOWFPsiJRqJs=
Received: from BN9PR03CA0303.namprd03.prod.outlook.com (2603:10b6:408:112::8)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 01:11:48 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::2f) by BN9PR03CA0303.outlook.office365.com
 (2603:10b6:408:112::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 01:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Mon, 7 Nov 2022 01:11:46 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 6 Nov
 2022 19:11:42 -0600
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>,
        <linux-kselftest@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [RESEND PATCH V2 0/2] Add speedometer new test cases for amd-pstate-ut
Date:   Mon, 7 Nov 2022 09:11:25 +0800
Message-ID: <20221107011127.1818705-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: a946238e-42e6-4bec-fc97-08dac05d0a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DtvP4ShSJNH9b/ZW05weOmMfhG22niIrDZ6Pf5EMcBek2Br+vJLxJWOpEy+1dylPccLgcJmQWWfBsPnY4MW8ACWKsPj9ONmfTMkDstnwHxM7zPF3CkMqKCfI9FLWI+p+RThQizo9MBMhAgkmEDPbdbP8247t6RcWsGc3Engcf1c4HkgFAzP/Ax8Z0+dYjbgMw71obgRQynM9lAJoeSnJLJBWsyuXAgRuQSLg4Pmubz3C1r44/I9FIkOEWr1Bujv6ZNyPrAwp9/NMgf1790q3ddUtV06AnX2e+Dal23BkLtcMmfrMirk3dbv/0S3ImuRlCB3MGbIvtuwbnROIOuRCvyuGGx/nXDJ7Mhxlk1E18NYF/gWI/O9W80334nyxs3WbFB+3nyQwLkq0TsjbYeGNivqzn5Uz3ZCWC4TQvxF5sFbxfzWnUVY+VzxS0eMWNfjDiv8HDw3QSFFs3FSdfYh5bkhmOzu73MnomO/tBGBy98HdBuAvOpsW2VX7K7yiAtOr8um34r4XXWJdhTtuUUD6L+ZAj10KfeSW8ILassVqQ/tYRzMWGYEjqJY76LI9Fmerg0F+Ed2pC4UC23trAv1QulDAC+1/bOgxCiez6FsUMUHJFoLVZp5HYauecYnhU/dEXHDFbtf3Xue9T1RTREgzy7bhsmkfEpL4+Vk9/6gZKxOR85jOmhJSx2r212IcVcjvLNkc09HebF6jObJlyYjWXAX0QeY6RTEE8W3wPlcSH5iHkvPQ4ESeHWjClReYJkmaSUy76UtxK8RGumqW1dsZOjCQAp4AtW9pxL5m1lHot7sixuwmRiykJDSZra2P94p
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(40480700001)(36756003)(40460700003)(81166007)(478600001)(26005)(8936002)(82740400003)(86362001)(36860700001)(82310400005)(41300700001)(4744005)(1076003)(47076005)(426003)(186003)(356005)(7696005)(336012)(2616005)(16526019)(316002)(70206006)(70586007)(4326008)(2906002)(5660300002)(54906003)(8676002)(83380400001)(110136005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 01:11:46.0892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a946238e-42e6-4bec-fc97-08dac05d0a29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all:

Update the patches base on the latest kselftest/next.

Add speedometer.sh trigger the speedometer testing and monitor the cpu
information.

Modify rst document to introduce test steps and results etc.

Thanks, 
Jasmine 

Meng Li (2):
  selftests: amd-pstate: Trigger speedometer benchmark and test cpus
  Documentation: amd-pstate: Add speedometer test introduction

 Documentation/admin-guide/pm/amd-pstate.rst   |  75 +++-
 tools/testing/selftests/amd-pstate/Makefile   |   2 +-
 tools/testing/selftests/amd-pstate/run.sh     |  32 +-
 .../selftests/amd-pstate/selenium_server.sh   |  15 +
 .../selftests/amd-pstate/speedometer.sh       | 349 ++++++++++++++++++
 .../selftests/amd-pstate/speedometer_web.py   | 106 ++++++
 6 files changed, 571 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/amd-pstate/selenium_server.sh
 create mode 100755 tools/testing/selftests/amd-pstate/speedometer.sh
 create mode 100755 tools/testing/selftests/amd-pstate/speedometer_web.py

-- 
2.34.1

