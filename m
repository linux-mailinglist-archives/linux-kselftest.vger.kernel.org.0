Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBDF7B6040
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Oct 2023 07:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbjJCFKd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 01:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjJCFKc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 01:10:32 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73291D3;
        Mon,  2 Oct 2023 22:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT9LuT9J5DuYX+dzLLUdVJqW0ceKNpTWTTJyJXfBG1R+raYg4zV3f/paD0hvPArXqYv877FAkAeECvt946TxxUrfj5ovMIE65+CfSGPMsexcRcfJwWrDYKQtOokdYbxiyiluSY0yFG+aQ4e8/BYQEdoNinGjdlJ2JpZaczMkQOhpjoRLFM3ZD3YWU64SK1yqGwy08tjrPGZYfolQ1Y0lTO6KzlIqLlHZ2cxkbZhqAvPgFKMz2FgtJaIj7c+OFjj7zW/NPJX9bmOeuHDdmpHP5ZEi65pqGt8FDe/TQ8QdYeguI7lZTSev6EuBi0CXWC242VG3euOFT/vtWGPEwjK4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K5ofjXkc5TeRt0rSxcMGdt3AGeDWXRqbZ0RgwZzUiM=;
 b=aklaRSEG51xPO2WzDKiPF3jgE8E+Ekss1rxk6VZBPiOvPrh6QPa9+TMB5VPt31J1VPpP6Bg4B2Bh0gL3oCH/cXXvt/Ofsu9enm0+3CXXLAQGMDubg8laL/1q79dq1TAUzroBpTnM/Jf1froHcBGZLPJm8s8yqcnF5hqRF3QOMO1EzFMw7qkBZifjOixnicn7QiIn5kHGGtHiNCPtsjAv2wKb1j333L5O+dlQXs6vjZXYbVhKXwU/oXN1mQSgfkPArCyX8ufzyb1RspdozS698v1otuca+xW3l1WWHNaujxIgXSB0DWdNVwrpjLO5sxCw+wOYJDEvW0XdFV8x3uBpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K5ofjXkc5TeRt0rSxcMGdt3AGeDWXRqbZ0RgwZzUiM=;
 b=1D1C1zLPzHcIMAn1XIKYNQFwGvtk718ptXSfI/sORUEsCGN0NFb5vtT+u508Fud3NwEu+tSqUq+Upl+4qZLKCheuOSp/Ap6o0IAqjAAe+BebXdT8GzSNBKc/FS4214wtYuujnraQdOA4dpvv/v9pBOMmCahW5OJZWo3X3+ZMOOA=
Received: from BYAPR08CA0016.namprd08.prod.outlook.com (2603:10b6:a03:100::29)
 by CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 05:10:25 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::93) by BYAPR08CA0016.outlook.office365.com
 (2603:10b6:a03:100::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 05:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 05:10:24 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 00:10:23 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <ray.huang@amd.com>, <shuah@kernel.org>
CC:     <sukrut.bellary@gmail.com>, <li.meng@amd.com>,
        <gautham.shenoy@amd.com>, <wyes.karny@amd.com>,
        <Perry.Yuan@amd.com>, <Mario.Limonciello@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH v3 0/2] Fix issues observed in selftests/amd-pstate
Date:   Tue, 3 Oct 2023 05:10:04 +0000
Message-ID: <20231003051006.6343-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|CH0PR12MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bd720c-1b62-4e42-1566-08dbc3cf0d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6VNHrFAWdz+Eb0GInQXZOki9AmO+4R0t0a733nORnQxsyW1rMOYqYIRXThZ8hfXpBZ5LTAxpcjMJJV4S6iPFLNNXCFu9TiAngON1BiFgzdlItNzAU24zjc8JCVCu0TZlaagTJ1RIq1dioaoWP0UlKcGBRHLYhN6icdmhNdJwh5YYgFA/LRcSZ5kSsMabvEQfcwBLKEQPlFDZBC77muLWrOjwCoJIDi/thhCsdsPmGLFJSSkXiHfFgLkM6330qGq+z1Jwmt3NTbePbarw+eoLd69tR5HJoFRHt8ikwO2bZ3SWgkY+8tgUl6A9u0XA92I4BwBPX1k45nUaybjGDq3OSB7QI0xvUfWeexzizigJ5pO+Q5XFw1LcemLNRhPQ6sbDsapV8lIg+epZpK5SsZjwXgPHAUVkqEsJ2XhbFz8be2pr6jRIPJwhcOY3VFO18CGtmyNrKKrkySB75xFcMS+0YoqPoatwBnlE4idY314E2zcNJnC8452fp3aNp3VeRlqbi/H1fj2VDwW1nwzyXfg/XoFzW00eFZ0o3K3SL/EhMU/ZxC3NzSQeuL4DK1lqA6yDgarHn1erWkaiq4SrJ2gBiC1krtNaQa8duEKNqtoNToCOuZ3jde1BM7WHQxRw1U5c297JEh59sMnMjUJM/xcG+e4z2XumtJu/YV39YWu+rm6tPq83st2JHuayD9AAIETbRjmKLlbf38nmdqRCOp2/K4OJZxD576MANItMADfptGGpn5raZMa1WjMJc9o8PwS/rHGd2dMT6qCAyDafl8iaxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(336012)(426003)(2616005)(40460700003)(1076003)(26005)(16526019)(36860700001)(81166007)(82740400003)(356005)(36756003)(86362001)(40480700001)(47076005)(83380400001)(316002)(4326008)(54906003)(5660300002)(8676002)(44832011)(8936002)(41300700001)(4744005)(70586007)(110136005)(70206006)(2906002)(7696005)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 05:10:24.7282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bd720c-1b62-4e42-1566-08dbc3cf0d1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5025
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series fixes issues observed with selftests/amd-pstate while
running performance comparison tests with different governors. First
patch changes relative paths with absolute path and also change it
with correct path wherever it is broken.
The second patch adds an option to provide perf binary path to
handle the case where distro perf does not work.

Changelog v2->v3:
	* Split the patch into two patches

Swapnil Sapkal (2):
  selftests/amd-pstate: Fix broken paths to run workloads in amd-pstate-ut
  selftests/amd-pstate: Added option to provide perf binary path

 .../x86/amd_pstate_tracer/amd_pstate_trace.py |  2 +-
 .../testing/selftests/amd-pstate/gitsource.sh | 14 +++++++----
 tools/testing/selftests/amd-pstate/run.sh     | 23 +++++++++++++------
 tools/testing/selftests/amd-pstate/tbench.sh  |  4 ++--
 4 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.34.1

