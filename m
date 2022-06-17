Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689BC54F66C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 13:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381038AbiFQLKn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jun 2022 07:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380571AbiFQLKn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jun 2022 07:10:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2926D6CA88;
        Fri, 17 Jun 2022 04:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD3x/IO9JvSbkujROkJy+jNEqH5vtm56J1HE5Bnkekt8/PdKlSiegFbxBFBdyAWtpnay7s5DPxMCjZ88RPn8tXp2lWEK3I+246p7czWT5XCzZEmJ5rUfq4itK0SBqZODChHDHNG5B3tgEhWm/Kunibw3isgKyq0tx1bJrQCrt+8VIzVz+8/u2WCIP5835dYpqOUKzXRHen2Nql71LXBoAuhdps2XXVX0DFoBh/Zc0dYrdQwim3Tk0U9vZgwIizkct+cFkrELJYDy2pKnZ3yZnxoonh7a2N5PLdXmW4lI0aEXv6jJ9Y9XcIBqDjS/5JRP3cIOvoXCUEgarCz8JOy9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEnVOIN8LNX8Drtt7cifwAPClIlZ+qHGNP/QkgPP7RA=;
 b=ENxUmCgTBBzZ48Sjyyp5VBXTS/2R4AdIMAvhG1iGJ6v6co8WLNMxQR29oqmtcj172qCe2ycTbozLYzfyEH/vRRGh1Ot/0FOINHObgrxRjqVCz4OSXuduz+BVTgr5fJdy2Py43t6MmQ78iomvSMRRZZ3H/f9uVH9gTeQYDyIAxAPsKnJyf0Er5LARnPJPLXmc9IvHRPnoRePFdLmCoCoW7ka/qESNkeNskEE1Jg95zFVrPpOV+IMej19FYJ0ni+AXNk5vnm9hYnwbtSCPqTUpL7CyjcQRjd0GCt/3iahj4Y0r9dk00IZYL+pbsGQaWjpxvK+ED3SLQcRqHumq+S2cpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEnVOIN8LNX8Drtt7cifwAPClIlZ+qHGNP/QkgPP7RA=;
 b=Yn8RSAk25nrfjpbf1eJLd3OG0ijJvb7yr0JTcHrIFC0KhGdKunz6IXEW1rPRs0kwCj/XGL5Vg1JDSe1MHh0MFd3COcU9L9mRJv6TvbzGzu/2T8aXpwGRF/7zql36QzJ57UQzhJXknpQ/5kDpTqPJ+i75aXwa5q5sqgAtqL5ajgo=
Received: from BN6PR11CA0052.namprd11.prod.outlook.com (2603:10b6:404:f7::14)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 17 Jun
 2022 11:10:40 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::3b) by BN6PR11CA0052.outlook.office365.com
 (2603:10b6:404:f7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 11:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 11:10:39 +0000
Received: from BLR-5CG1345Z9Y.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 06:10:37 -0500
From:   Kalpana Shetty <kalpana.shetty@amd.com>
To:     <akpm@linux-foundation.org>, <shuah@kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kalpana Shetty <kalpana.shetty@amd.com>
Subject: [PATCH V3] selftests/vm: Add protection_keys tests to run_vmtests
Date:   Fri, 17 Jun 2022 16:40:19 +0530
Message-ID: <20220617111019.476-1-kalpana.shetty@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1cff1a2-1b8e-403e-970e-08da5052032c
X-MS-TrafficTypeDiagnostic: MW4PR12MB5603:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB560324FFFE0A314833347C5E8CAF9@MW4PR12MB5603.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUpniem+OVjCCmuOkyXttXEBn9EVKP0vfti7lky1uQ/Dn7oReC0o7z5bbdnNu4hfU5o14kro3RtCdiXULMYIjEP1hXQK2QnZmrJxlOEbA53k42dQRr9rpt1eDqFVUQppJsxVj/ujeC9nJXCB4RzTGfFEAPQq5P5bdDa7POcIn4hVrM2ioUxXuqIWG0txFeJtVs7bd4b41PZxHxWclOe5KCM/DgIhS2/y/6CgS3s4Hu6m6jnChxHGjWUAJ7NRv3EE2hTTKvVrXry+U82SM6BDRh5azuIHCiqTIXils7WNhQSRWw0anckZk//fSRCPQXfzM8c2osXc67Q0O6Ra78JrMtMQpTJcQYCYlTiIItwKSrs9I5fgDr8bW8dN+i0angTg766rCacjDEqmpEmH81WATFQy5ZsCei/tG430x2Kc0baiiKMY3j2XuFgdm56rDU9fYPtxHsM99vMePR/RasLnXs5pWcoIQzncusZW+Pg8W2RPBSb0byNe/SFNf+d34XEX5FoMAkiuASVF2cyPjS/Bjj+tvc8WWQFcpBrXjDO6JrVxlUyqriKQXAEZvxo64aZ0NxAvIKkzhNhUw/2HX9aV+Jc2LUE1+ZwHU6Ei1zyE0TQxAXVqfI8tDyjmrb+JYpRc0ynLkmj11XkC0FlskDWfBS//55fpQ3SnJTNA6oLT18O/lpGhpg+2mU5u/WvwwWs84rgnfVO6D+qsw9N7txpHHfbfmE1XBELdmAGANuySfks=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(8676002)(36756003)(82310400005)(8936002)(44832011)(4744005)(4326008)(70586007)(498600001)(316002)(70206006)(110136005)(40460700003)(2906002)(5660300002)(6666004)(2616005)(26005)(336012)(186003)(1076003)(7696005)(426003)(47076005)(16526019)(81166007)(356005)(36860700001)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 11:10:39.6515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cff1a2-1b8e-403e-970e-08da5052032c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adding "protected_keys" tests to "run_vmtests.sh" would help out to run all VM related tests
from a single shell script.

Signed-off-by: Kalpana Shetty <kalpana.shetty@amd.com>
---
Changes in V3:
 Shuah Khan's review comments incorporated, added protection_keys binary check.

 tools/testing/selftests/vm/run_vmtests.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 41fce8bea929..b19c6b1b84c4 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -179,4 +179,15 @@ run_test ./ksm_tests -N -m 1
 # KSM test with 2 NUMA nodes and merge_across_nodes = 0
 run_test ./ksm_tests -N -m 0
 
+# protection_keys tests
+if ./protection_keys_32 &> /dev/null
+then
+	run_test ./protection_keys_32
+fi
+
+if ./protection_keys_64 &> /dev/null
+then
+	run_test ./protection_keys_64
+fi
+
 exit $exitcode
-- 
2.25.1

