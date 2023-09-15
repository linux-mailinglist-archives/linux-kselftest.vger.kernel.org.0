Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7FD7A1C7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjIOKlp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 06:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjIOKlo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 06:41:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48779C1;
        Fri, 15 Sep 2023 03:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wm1zOsBp9+Xfi8dxlwx17g+7h2AwdYLO5jFhwY+j07JtCx6xc8WO3GM5aY9YOrk0R929mnDB/UmAzphIIxTXRPXSGlZ2ROHtzW/HbuxP6HmjsR76mtApbfL57R4J1NQUrOnB8e7XYJzgDrAR++hW3wViIG8qvndYyIg4w5pRigf1RukiiIZzj0M3xUMtjFAVVtvbkUYrJr66YUadNhkohBCA+DryocgCcjC1D9PhijLAxdBrZL7bg+UlfCo1nSjlXe1i170lynUqul/D9qQok/AsC9lPE29Qw2GJJ+1NJnHujMh/DEpW6QwtsT3Xsh8wk0poah+L2uY33muN/HQNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVGOYC0AG3mvj6i+NeaJGc4eIE+uhrTlrNL/G/z9aUw=;
 b=KLd/CN87dZZE9IkIvx+AcTgnLPbO5xiW/Z0MKkTeyXcomvQ35SxW6jH165dpOmWe5qlvqDuiSG4/SiUGtFDtTD5lSE5RJ0qiw0Ym9Uuol/6ARrdsYIwM8Fdx0WhHC0UNyh0hoSX0icya9cPsc6NDLoHDiiDCUP66j+t7tCyoRZD6jrgq8MAkdmpWMlaGgNqKbsjLnNu8oErHW7fp+wUhzXfSZA7UBtuNcy873LS/hAdLkjWrroJgPkdG3zViRy0uzm7rXUWhH74V/ld4mO1OeFzjy9uN1yIzBKf4htJ6D/0T7tYFlMPDEztHAW3QpQ2d3F0CwnlRksRNggOCou+wBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVGOYC0AG3mvj6i+NeaJGc4eIE+uhrTlrNL/G/z9aUw=;
 b=KKpOpugWw9df/mGVVJNL+frMaHLpYMVLE5JI+KdowGdmYr9k3dkrBOWiw7//2zgYHMRX+RhE9xHic/e4iIkdCExqErU+zDGJPqmNuSx/m4zqOVfRZfRTT8CCqu7Bh6bF2yhCmISUuZMSHbCoDwdDMIpl+ieF9n+p9r5+H+l8PgE=
Received: from CH0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:610:e5::10)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 10:41:35 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::90) by CH0PR03CA0245.outlook.office365.com
 (2603:10b6:610:e5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 10:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 10:41:35 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 05:41:13 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Ray.Huang@amd.com>,
        <li.meng@amd.com>, <shuah@kernel.org>
CC:     <sukrut.bellary@gmail.com>, <gautham.shenoy@amd.com>,
        <wyes.karny@amd.com>, <Perry.Yuan@amd.com>,
        <Mario.Limonciello@amd.com>, <zwisler@chromium.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        "Swapnil Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH 0/2] Fix issues observed with selftests/amd-pstate
Date:   Fri, 15 Sep 2023 10:40:55 +0000
Message-ID: <20230915104057.132210-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8c5157-2e79-4bfa-33df-08dbb5d85551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 472I0qFLbEHelSvOAk6kckBuxAGlBH5Pru0EzIJ2Gumf2WR3YLHcCTMjU3dRYJHJkXRiZ4s0xHL4FlpMeEUDDYvFDifjvkYm9ADeH8Z9t1+wXZZABjz+H9MxDePX5AYoIdM3HQTjhY7Yu96Pt6+2yGKjJfJb+e5iCJKx7wHRUzkOlNcOXQhtVHr0Xg9Vy+wejmP1iuubYxWfern5z9BC1DgR/ZWEiMkVD+fsLZ3hIgcklCnJmxkqsmLLr39f21gOV8nnc3Xy/lu7bisgcf7DcKpLyUTG71ZZzLbT3tIRx1/34gh2ToX+ONPcog9ey1rnWOQ1YA32nznvQDsF37AUlvS5ZDmetJiPZhy8s8Cz4I5aZVX/8h74/dCrfJHrd/zCXzEiB/kz11ZvtCIDY3TjmGMyz0ziusLdV7LOwZzbadyeZxlOu5xMCPT9oH7i4RtMkCrqSIDUD4xVuDXS6IgqTcFRxjOWU6nVMuNL/rYjayu/8FX7Bw2bSmpyPP0NafaF0f4x1ViKQLEnt35PvhRz41KSyXzH/w6KF+QZ5e2UW3w7uLIkd0Cf4TkqD7F0BHDBjhmHkIoz6urmmIfG5aguvurBwyqownWW3GH87wdoxSJIxrLraepJNNqRRiDMBQ9CvWkE9+j4I6ByYJIKqGl50VynAZiwnJ6/9Mvmf/GbfDX5/yv7nnJbosaR1j7L/fpebREgSx5GIs5p2i9PvA1wZHeN0pdhd02zpr4F8LVs6B8OCvZVCh/PKty5xR104N7Y6BgBWxV5ONOBTlk61g1xxzYyS2jHlYF+lw7QaEXGv3U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(70206006)(81166007)(356005)(36860700001)(7696005)(6666004)(36756003)(4744005)(82740400003)(40480700001)(47076005)(336012)(8936002)(426003)(478600001)(26005)(40460700003)(16526019)(86362001)(41300700001)(2906002)(2616005)(70586007)(110136005)(54906003)(4326008)(8676002)(316002)(44832011)(83380400001)(1076003)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 10:41:35.1224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8c5157-2e79-4bfa-33df-08dbb5d85551
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series fixes the issues observed with selftests/amd-pstate while
running performance comparison tests with different governors. First
patch changes relative paths with absolute path and also change it with
correct path wherever it is broken.
The second patch fixes error observed while importing the Gnuplot in
intel_pstate_tracer.py.

Swapnil Sapkal (2):
  selftests/amd-pstate: Fix broken paths to run workloads in
    amd-pstate-ut
  tools/power/x86/intel_pstate_tracer: Use pygnuplot package for Gnuplot

 .../x86/amd_pstate_tracer/amd_pstate_trace.py |  3 +--
 .../intel_pstate_tracer.py                    |  4 ++--
 .../testing/selftests/amd-pstate/gitsource.sh | 14 +++++++-----
 tools/testing/selftests/amd-pstate/run.sh     | 22 +++++++++++++------
 tools/testing/selftests/amd-pstate/tbench.sh  |  4 ++--
 5 files changed, 29 insertions(+), 18 deletions(-)

-- 
2.34.1

