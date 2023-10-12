Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C6B7C69B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjJLJdT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 05:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJLJdT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 05:33:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B1D91;
        Thu, 12 Oct 2023 02:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmEjkscYA2TF4XlbFVD1VWZ/6dlrnjWr5o3Bm+9jMRm8m2ne/9HPbuUluv9Twl+U6D+j+apLMxq/diyXYU1Z9QCMi70MGIQAcbw5B1TMptdNkgnyS5y16AdGdG2e8mttkwjAnPGqAEJhdonhjDeoev5ITp19U5VlTnJwq+JNXyZZxPO2C8oeAzDLd0yAC9yo3jtUL7oc5Db2UYBNdSXCoLhnYM8gfXTnFvmaO5zRGeIj02LsNI1EkyL2Yuxz9S6d4AaxixANiStSzPon+MdIY44ZhYgGn61qbRpBKxUE6hmq8wKvUYXiWE6aa1Qcf7MllXwZdMWjYV/2ubHU+VabSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71wYQxW11owXULxexRO6B+BxjzWJiN9fObkRCeUW2Tg=;
 b=RRryoeKa4DpRij0Us6qNkvRXFnQAPNYVtox+T6X8wx4WZ8JTEoJX8M9k/n+xGSrx41fEztIz5EpI14BFwuEm3m+LhOJnPwZ5bz8CrWQHFTc26xMoaN81KCYZ2GReVZEmFqPMD0uhbzYP0HruzlJKnhhDKELp+jGza+TJSM7nsq45xoIDj6pUniiqD/H9sxIyPSIYBCF7UTrjgbfWApqwsXfkdGODvtrCYGtzwOiNE6j0VueUqYBsukHeDuKm1+oD1itnNZ+HTCALWf1zq00/KvN0A9/32C4c8GW/i2b7Zau9i5GvL446gzBhNvT7COpzxDmILAhfTajWoLNFTQ2RRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71wYQxW11owXULxexRO6B+BxjzWJiN9fObkRCeUW2Tg=;
 b=SS+atR7o6yYl3xfrePRibqMiVs7g2bMLYpuB4nbDL0Rtwi0/4iDI4E6pkCUg46rxYfziRrg/zlXzm9SQrj/eQiIKV2UB+d+VgI0qxBTJuUPvBMnRqhuPZL1Geirb516lF5ZTdF8QiSRB0XMpmLcT2LHzOWVDNOiXAoIx7xairHo=
Received: from PR3P195CA0016.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::21)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Thu, 12 Oct
 2023 09:33:14 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10a6:102:b6:cafe::32) by PR3P195CA0016.outlook.office365.com
 (2603:10a6:102:b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44 via Frontend
 Transport; Thu, 12 Oct 2023 09:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 09:33:12 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 04:33:03 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <ray.huang@amd.com>, <shuah@kernel.org>
CC:     <sukrut.bellary@gmail.com>, <li.meng@amd.com>,
        <gautham.shenoy@amd.com>, <wyes.karny@amd.com>,
        <Perry.Yuan@amd.com>, <Mario.Limonciello@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH v4 0/2] Fix issues observed in selftests/amd-pstate
Date:   Thu, 12 Oct 2023 09:32:23 +0000
Message-ID: <20231012093225.2045109-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 1083bfbc-d913-4766-b015-08dbcb06413d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ocprIFr7mLDYHUHqANIbXdo6ZJlsA2TXgpyKZorCk9PhVKyGeBlS5ra3MQzuSwk3rSFagV1O8xODWIX1TDIWuPSGsiiYHF31B1QhJmztCxLJDrv5DJub+CQof4RW13Dmu42ma0yczCSe1SN9OxZS5m2veJTiDYVqMeERgBdgXS6owyi5iMP5YG3czsf9ifNu3lJuiJOFJiswFJZJHGatt+mci0CdCAZGxLbCh3ntfR7wACauawVBO7RowJuj8+GeT6u2qRwjzk7c/UD4ztEM6Qhm2rFzrFZhkkI9YqUOWUdo0Q8pOxXgi5hZQpmHCBFAI/gcUqvpeRstZ1jDDpmlRVF18zeAS3qM/WaI08U+larfNZptM4izPwKEH53Q4p2fkjdUCvpr4bBH4b3F5ymuBfSIDEIZWF+ADkN0ziiV1CnKTIuIQaRkuYUzUfURl7z6HuTbNNnqQwnk9NW7eG//MdXQjYJmCQ60AucCUEn+JIDpGIARWMuEaLIoJjIfRUrtcSaR9mwj59h0mrpu6H3Rf4i6fKg+NkatRLRMyO0ap0DPyXMK+veA5sQzXrkF0hHIIQEEVb6sdAU06l87oHWe4BCPzsgYpyOETABgfa1zIHohcX83Y0tEwaNhI/DLdbkw3zZ6x2K73ckcRiN5JBhQgwOXM1+V3Yq8QgNbchrK2vu1DDdrT+fGyGdfDbeG6UejueShN9nhnQAiPry1YGRDD20xxK1/9bGICoY6kbEBQ+mYtqfwETKn1qONvf89Lpy8c1sUtRW+TLjZHwKPzEzaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(47076005)(6666004)(478600001)(4326008)(110136005)(8936002)(8676002)(44832011)(41300700001)(70586007)(5660300002)(426003)(54906003)(2616005)(1076003)(7696005)(16526019)(36860700001)(336012)(26005)(83380400001)(316002)(82740400003)(70206006)(81166007)(86362001)(2906002)(4744005)(356005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 09:33:12.7392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1083bfbc-d913-4766-b015-08dbcb06413d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
patch changes relative paths with absolute paths and also change it
with correct paths wherever it is broken.
The second patch adds an option to provide perf binary path to
handle the case where distro perf does not work.

Changelog v3->v4:
	* Addressed review comments from v3

Swapnil Sapkal (2):
  selftests/amd-pstate: Fix broken paths to run workloads in
    amd-pstate-ut
  selftests/amd-pstate: Added option to provide perf binary path

 .../x86/amd_pstate_tracer/amd_pstate_trace.py |  3 +--
 .../testing/selftests/amd-pstate/gitsource.sh | 17 +++++++++------
 tools/testing/selftests/amd-pstate/run.sh     | 21 +++++++++++++------
 tools/testing/selftests/amd-pstate/tbench.sh  |  4 ++--
 4 files changed, 29 insertions(+), 16 deletions(-)

-- 
2.34.1

