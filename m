Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1306538EC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 May 2022 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242830AbiEaK0a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 May 2022 06:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiEaK03 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 May 2022 06:26:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BE1985AA;
        Tue, 31 May 2022 03:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Invd+Q8CenjwotI7tXIqJBuTQ2Nhd89c/zu5VG2WAgT9Tcsy60eSupHQJDpjWgQslSM/keh/1oH92e/cV7DNp8db888WjhEmwsMIbenVJZbT0GujMkLg1Neucv59pGGhwfhmsSgkEbQlIxgwMjXouiY9eoQhmC6Yl7raF5f2JnOfaWD+KUBqyPie9PYMBhaLMaYA8u6oQZRnOp+mtBp51sIq3AM+cr9BVTn55YGypSVm8WDC7gchkG8q8VJlae67J2ho+bQ4kGXhCMolm/+AJnh0nRiCxMdlQRdm8J7ajBxhzrRwSqDoUjhyXA2NUnYYK6xO8sf5tqAfPTu0ZOf/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJX1uA7oETMcV1ZH3z2h/YGaS3CjDIJPzGTba67rdl0=;
 b=eNu78ntq8lzzZWJYS67f8/2VYCOOKEOmqbjFIaZqyhgHSamwJAk4NNK+hRkNFf1F9pQC9ocDX4mLV2ErPMSZvyo02U/ETRzM6l2hIyKpNoQu6PxMZLhUgAr5fQSfXZ0jTawg/mAyUxrYpeYWcMGjQchqtabseMZxKdMBmYwBa7Cn8o/ieuRq30yJstF3r9ipmXi/yz1q2/LABaf/GgT1Fz41a2RMyOkJqvEtc5V33b5f7e0bmV4Zff6gFgfnhHFKTFkmlISjYEbcoe7twj/DGjF2W6Z9xHKZkgbNxMgDcw+8LmRdeVY9UuXIIypaAxKM1V9d+7Pcb2pIxNdeY0xXnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJX1uA7oETMcV1ZH3z2h/YGaS3CjDIJPzGTba67rdl0=;
 b=sLvwR3GwHBOjYGNgMcGXdlrg+tJBsR5YByG1pCEEXgtQxM19fW2dB8kXT2SIsoRJNYM/1/OM/c9WlDMCEyix/y2ANjedeuTMg0yML5KoWHG8xBco/7E43UDukADZjX3z9CoEC7CgePW7CzdqyZYQAcGFPTD+/9ioQ3CmAQP86IQ=
Received: from DS7PR03CA0161.namprd03.prod.outlook.com (2603:10b6:5:3b2::16)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 10:26:25 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::f6) by DS7PR03CA0161.outlook.office365.com
 (2603:10b6:5:3b2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 31 May 2022 10:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Tue, 31 May 2022 10:26:24 +0000
Received: from BLR-5CG1345Z9Y.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 05:26:22 -0500
From:   Kalpana Shetty <kalpana.shetty@amd.com>
To:     <akpm@linux-foundation.org>, <shuah@kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kalpana Shetty <kalpana.shetty@amd.com>
Subject: [PATCH] selftests/vm: Add protection_keys tests to run_vmtests
Date:   Tue, 31 May 2022 15:55:56 +0530
Message-ID: <20220531102556.388-1-kalpana.shetty@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce5024c2-1266-4834-014c-08da42f003cb
X-MS-TrafficTypeDiagnostic: MN0PR12MB6079:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6079BA0EFD5C289657A1FB7F8CDC9@MN0PR12MB6079.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SE3Kru0XvSCk2/N/3i/9bLJXTncGZ/4sUMkbrBVRnrg8JoAK4Ada94nJkcj3Sp4ZuNnlecFfjD1FoPfs35dgkTTKfCb8+zzNV9TlcpyksFCdO8Jpl4bQsbnKeC5Io1MXOb9PHyy+jqbKvtp0F8iUipcAMw2jtyrqgJCWUAQ3vUx0K6qX9K8TVGxy/L50TAOSacXSD+qv1RwKXtEdiiNg83Ow43LP6peBQXpnRH8Vuwar5+/LD2M1gJxivjVpcMG6kSe+AkFcXeb3wc7DISyaKWxVT8LjJmvn67kIxjBi6DcePQGdyqTI4/1DPfckMX2WB8xzPY/2brLeWt1/faskknUb992YJ1cL4crpEZoF4Wo554MfMuY1Q7Z7slwBlrivzTh8tBvwBA/2qlp59hJ48AztW5ioWmRjfy89Ug4zpJg3/MDnI8mF6Xz+CR4BWLLi0vbkmAdX7jdZTzEul7LTXKLVFUhGgp4cpMGorkIIVka23DSbNRcUz1YOPHQohFalKYuRoa0bKRfjZau7z25s+NMmi4IOagOf5nst+SYRk7MzwHCy7l7wLZvKj4aJ2DBkJIQs5V6vvOtRxbssfE7eGmIlbVt5dFD+0Gp6o01g1PRifpM3lQHJBmbAtqiyOH73nFBdTajB4tKToDTWyi99l0mvRK0U288OeNVOlWmh+nI/l+gdGfM689s3jep4CPzLAiuNc1DAwOFC5T5ow6GKzvoQmK8McrqDOQp8XAGJvSg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(36756003)(4744005)(86362001)(40460700003)(70206006)(110136005)(316002)(5660300002)(8936002)(1076003)(4326008)(8676002)(186003)(426003)(336012)(16526019)(7696005)(2616005)(2906002)(81166007)(508600001)(36860700001)(6666004)(26005)(356005)(47076005)(82310400005)(44832011)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 10:26:24.8629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5024c2-1266-4834-014c-08da42f003cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Kalpana Shetty <kalpana.shetty@amd.com>
---
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

