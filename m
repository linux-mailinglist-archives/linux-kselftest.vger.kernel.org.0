Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6EC767207
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 18:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjG1QkZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 12:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG1QkY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 12:40:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94299E;
        Fri, 28 Jul 2023 09:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQK1e4ej3rSo1w4parAFOeIRMOsg9/DXxU0A2EVPc6R6pXRlywGou6bRruC1Ec0PQSj8cAczKTVU2G3esjwsoNk6CpmgNkTSr2tUfGAUQeNCiB1u+3xq7+qetPzDj7LZ5XqZghOIu9t2p5xJM1gDQM9cs1p7vyXISCMf1Web23285dJrNksLuqJC9oD3/BOrnS2b9AGs9IYqpiZ6RODIPMITD+l08C0lt5UyWl3bEs5ARZSIVscJymGuTvhuw7pIy7X3ukctUTrCcSv3yMWHEnc0NVTQtlKRYLjk/o0mSpElHx6q8/sGPMiFnfTDzSvHTzjFrx8m/JVGBudJl9pkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfagcM595CBddVOpZ8s2WHITdqCWuHqZNcCEFdTwj50=;
 b=MR412B+AS5yOxjeoIIuIWV9SyzLPFN+eN0kOh9q92BXoBXLqxlAcrUpbcQoDfMpmgYCiRrLZq8KqZy7Ka3cHif753Wdm5vpVbgIecjWdRif28KexwsSuqC8/Bbfomk9JGZeq4FUipucGdtpqr9xKyVD9h5Fb8Hsdsf8dteqlacx70nIYO0tg0cGlQana0uNAYb1LMysvYiFSoviusZnEfwIzetQpXNcTEsor9+Ur+IhZOEvz38OHJW21oIUFDEioNMkTqA3uoTERdiZWugC5PFX8Bdk9fP18pgHqDuREnZGWLvRXoY32i29RChmWg4eXshU/l8jHM5BCKmNLxFx/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfagcM595CBddVOpZ8s2WHITdqCWuHqZNcCEFdTwj50=;
 b=GNfC/rMs0HiZhy1Vg6v2KGbYncyVIZWLvYe2ImxrL+G1RDPnB34lTnLGZeFuKNlOBaHPrruJsDU/D/V76SkDY0QPeuF2AOrazqfsKHWdzrVw8LyXaoktndrwuGxTL4fHPaO5XFLw/CbV4r9r2OM3lJdlUCFyY5DOVemw63l04X4=
Received: from DM6PR02CA0050.namprd02.prod.outlook.com (2603:10b6:5:177::27)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:40:14 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::ec) by DM6PR02CA0050.outlook.office365.com
 (2603:10b6:5:177::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 16:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 16:40:13 +0000
Received: from BLR-PF38F8CF.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 11:40:08 -0500
From:   Ayush Jain <ayush.jain3@amd.com>
To:     <akpm@linux-foundation.org>, <shuah@kernel.org>,
        <pasha.tatashin@soleen.com>, <zhansayabagdaulet@gmail.com>,
        <tyhicks@linux.microsoft.com>, <shr@devkernel.io>,
        <raghavendra.kt@amd.com>
CC:     <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Narasimhan.V@amd.com>,
        <Santosh.Shukla@amd.com>, Ayush Jain <ayush.jain3@amd.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 1/2] selftests: mm: ksm: Fix incorrect evaluation of parameter
Date:   Fri, 28 Jul 2023 22:09:51 +0530
Message-ID: <20230728163952.4634-1-ayush.jain3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2184fb-2c21-462b-374c-08db8f895152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7CkK629iEgji1PAgg3dop7x2E16PJA6R0vXzZu37IxxHAKtYFo710IcNWHX22gxk89pbjmQMJfK9x/llscITu/lexs8nd0Oa8xO72XeuywPjW1FegLYy84x57LU0bJUBb1hJYcOyOFB1zSBe5QT2JBI/RngZgO4+C6/kRF4k269uyeB4/obMmwkV8m3cNIs2ey5I9xHK+GTY2x/gTpkX1pDsQAqN93ehV1Lj0eVFabnaiyWKF4wK8XkFAC1PfHEKllnXphEDs49/33BNzxONSn1HBR0ZpO4+Xl9Hv3M0vZHvrfLYW+eMllCrnLN5Ycprd6db4iAsR6iD+mxCWIzq+xAKrkNA0rOMz6tRdweBNqD5kj5M/NmBcF6VeqIRGTQ5k3vBaHS9oeYxfr0iMQI8J1vP5AyzXusx5XwxXJj7VkWrTNzOtk3uPSLajaVIFpVPzQMVZrDti2XP03WOcLUDj2YpBrytrfXD6gKF2VOCflD219beIagwzoSCLIQAGHYhcxai7olWHttG8Gnq9SxjvmgjGvFu4VAM6sS+8YqC5wBggx/jMgubdgP6xRrzGHha5MW2YCsS4wD7VRgwE/pDTKVUNkS78hStPg7azAbTiyUPkgyOcUOgYR7IOIJzejTZdaToZkqCZNm4tiS9omUM3XiKFEyXwqDc7cIUG7cy7dEmnIVu+l7kUE7xItn+vCisTtyZR0OH+m8r9MjUWjrAiTws8PaRXBYbxV91Hrsu4zM26g2o5RYdUC2WAa+rKrfFH5h6cy0jORPuXtO9Z9H/4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6636002)(4326008)(70206006)(6666004)(70586007)(40480700001)(5660300002)(478600001)(82740400003)(7696005)(316002)(356005)(110136005)(54906003)(81166007)(40460700003)(86362001)(41300700001)(8936002)(8676002)(26005)(1076003)(186003)(7416002)(16526019)(336012)(83380400001)(426003)(47076005)(2616005)(36860700001)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:40:13.9910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2184fb-2c21-462b-374c-08db8f895152
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A missing break in kms_tests leads to kselftest hang when the
parameter -s is used.
In current code flow because of missing break in -s, -t parses
args spilled from -s and as -t accepts only valid values as 0,1
so any arg in -s >1 or <0, gets in ksm_test failure

This went undetected since, before the addition of option -t,
the next case -M would immediately break out of the switch
statement but that is no longer the case

Add the missing break statement.

----Before----
./ksm_tests -H -s 100
Invalid merge type

----After----
./ksm_tests -H -s 100
Number of normal pages:    0
Number of huge pages:    50
Total size:    100 MiB
Total time:    0.401732682 s
Average speed:  248.922 MiB/s

Fixes: 07115fcc15b4 ("selftests/mm: add new selftests for KSM")

Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
v1 -> v2
collect Reviewed-by from David
Updated Fixes tag from commit 9e7cb94ca218 to 07115fcc15b4

 tools/testing/selftests/mm/ksm_tests.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index 435acebdc325..380b691d3eb9 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -831,6 +831,7 @@ int main(int argc, char *argv[])
 				printf("Size must be greater than 0\n");
 				return KSFT_FAIL;
 			}
+			break;
 		case 't':
 			{
 				int tmp = atoi(optarg);
-- 
2.34.1

