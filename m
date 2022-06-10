Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B4B546114
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jun 2022 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346040AbiFJJJ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jun 2022 05:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344416AbiFJJJi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jun 2022 05:09:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2964027B9A1;
        Fri, 10 Jun 2022 02:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXxz99A/1bROjeBADKcboeYWcTMomw1+irrsnCiiwtFmZ0bvfOh8eUXvRdnQRg8Yf523L2atzHxKPuBk09DtqJ81v50oiIm46PMXQ/5bLnZSs5sUVBtKIIa+8HDd+Rp37xJjNp8lOvnKL80QP9iJhWc5/hqGZND0qQMtzUWT51ROSmJO78H/6ZvP34bZaogIO9XT2zVQfH6s5mjLin5B7UzJN6e+1cC9lXOnV6aa3Ei4FUi+aphAlcXLDKiikp97gAQsaVzQlV7RKTmhFetR8L1ju7vVPwkt79rI8703EyKHU3ScuCi7zh/9FCbCINj3Nh1N2iAblVhEBBt128D5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HygiLJT23LuhSK8uQsZiowr7RwLPGl/xF0b9GGJSCLE=;
 b=T8LtKx35w7faIwg9/1i1VifufdXZwPtC1d0386MfbJfBKM+akn0Oj7XyU4YAGLjH3R7opYLrxgbbnDxq82GeVS9ufnYKL7Wrtyrj5trUjcIddPmMO0JqGuKUKqDOFaaHslVBMmoizT6KEACpddi7xvOw5m2Rr6Fx6F/8tAPFmuYW3RCDkK67o+OsIcrOoQUsG3EKNsuGbh7EJLzIrATGKoT4rxs94mVprc9JEQ4SzzlktVbgfTO5we6oQS6Y+BMDBIjtDuQAH1We7nSU7ybBhaBMgMbsFqINudlXty0sYZf4p9UAJVd+nrgtpt0ZKTaJsgy/lRlWFp4PiC21iJFV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HygiLJT23LuhSK8uQsZiowr7RwLPGl/xF0b9GGJSCLE=;
 b=VQTbqhcC0frxzPxK65NJMHNLfJw2kFk0MDKCWtyJLGIh9/qzaL0g51pxFdBJ2VqjSdp/tUB1yewxoiRxz6654GLltsTjDrDGSgRglo141+fSRS3izxf2WVjxpvad/bk6/rtkZo3pRMeE+zq4qJKMlkasVEWAdNJ/gBtbAM4HfWQ=
Received: from DM6PR13CA0022.namprd13.prod.outlook.com (2603:10b6:5:bc::35) by
 MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 09:07:24 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::bf) by DM6PR13CA0022.outlook.office365.com
 (2603:10b6:5:bc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.7 via Frontend
 Transport; Fri, 10 Jun 2022 09:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 09:07:24 +0000
Received: from BLR-5CG1345Z9Y.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 04:07:21 -0500
From:   Kalpana Shetty <kalpana.shetty@amd.com>
To:     <akpm@linux-foundation.org>, <shuah@kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kalpana Shetty <kalpana.shetty@amd.com>
Subject: [PATCH V2] selftests/vm: Add protection_keys tests to run_vmtests
Date:   Fri, 10 Jun 2022 14:37:04 +0530
Message-ID: <20220610090704.296-1-kalpana.shetty@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57214a24-82fd-4e00-4747-08da4ac0a23e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4285:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4285E3A6437F3145E529AD1C8CA69@MN2PR12MB4285.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsLkSzFVLhZPFyGQ8rZ6evxZ8jBGToTpNxqTDF5+VJ3WLt3DvWH3GsbBfdeVTyEd543Y/2LqOen8vkDSGlWHM4YEcMGk3bbDp42+8UMoQOJQHWSImC5XsEgWKOJw7fTrCaZLq//1OnjIZ/RgjHAlRK5O+4puBbbU1ob1MqEJDWJ9Lo+oeH9SbKoxeAgf8rEL97E/hjCi0eKL5jURs6JOvcv51Ufg5ZrLhR8xlhAGM6KhdkXcKQ8CqsFoXl4EZ1hY7IrURdHSux+eHgm2aq+p+NsQjyJ57UsIUPrNtWy8AHGIaM6EAEngK4caAFGeMd6nr7WFM54id3+8/+3XAt/lbKkmLQEP+0Y88ijlszgnFYOipnMKs+pPhuhjBQwAolHEjMK8+KhilEwk4dLoJ7KclM41t+9kOJpKCIatigXT2v1J1rR3otarVcmHVfxJWOREC9HxGxAHwhbJtKqH3pAeqwdRFSv/Q0P/qkSodWAu5NVg0EETJ2Sou1oDinKYXGPFPoYXW/nPnWRf+FvEYqq4W4ip0bQVAfD8XV1C2Z/8ad+6FkzsT2xaSX7MCZLQq+wRN5DA7MCiP6fp9diKhD70KcKJtpeWxd6+4ODyYUTOUI4qt4qmIuI70Lb6pAzrhrFp0VLyIwnqLRpBNV2qDG3YzqOar4CBCJvGnzrRkfTLslDe8kssBSslmsWwIfZ7wFYUe4jhJtec0Wax2V2X6JOlM3Ik3vxKckPOeqQHT2KT6DA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(7696005)(86362001)(6666004)(1076003)(2906002)(8676002)(36756003)(110136005)(82310400005)(4326008)(316002)(70586007)(70206006)(36860700001)(508600001)(4744005)(81166007)(44832011)(40460700003)(186003)(336012)(47076005)(426003)(16526019)(8936002)(5660300002)(2616005)(356005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 09:07:24.1575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57214a24-82fd-4e00-4747-08da4ac0a23e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adding "protected_keys" tests to "run_vmtests.sh" would help out to run all VM related tests
from a single shell script.

Signed-off-by: Kalpana Shetty <kalpana.shetty@amd.com>
---
 Changes in V2:
  * Added patch description.

 tools/testing/selftests/vm/run_vmtests.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 41fce8bea929..54a0c28f810c 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -179,4 +179,11 @@ run_test ./ksm_tests -N -m 1
 # KSM test with 2 NUMA nodes and merge_across_nodes = 0
 run_test ./ksm_tests -N -m 0
 
+# protection_keys tests
+if [ $VADDR64 -eq 0 ]; then
+	run_test ./protection_keys_32
+else
+	run_test ./protection_keys_64
+fi
+
 exit $exitcode
-- 
2.25.1

