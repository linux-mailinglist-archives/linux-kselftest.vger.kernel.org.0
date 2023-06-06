Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1E97238AC
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjFFHR1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjFFHRZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:17:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C59B109;
        Tue,  6 Jun 2023 00:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKCZpwPZn23qi/s//HrklUidi1cZTg+OFkOTTb6LLuNjErtxW09Q8rwbsLq6opHL7SDr266v+BpzJeTRp5iX4/lo6441Nc38GPSRS0FKYWIR0B6JXSnxhcL6FtfSepErTzWbOkf3RfawIllKqXRTNJULh23HJqR6pAMkrkHVONJrkJ8Ome9RHu1VG6NOggFgUTVHuGQpwOWhNSAvgnVw5fHQaRgDJRZgEDuJhIjlGip+NuERnINk+siIDs7VT/Pt0v3sjBKAMDGj/NRzmBr1T6gPhu5QI9M1DU15RUCyIcgRshZM9n18lubdZvL1HJdIIZv5xK6DzcdwPqfv6pp/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvdHBj5yApv+3mwcH6LWSMXJlHljQnJdtS4CV2ZOt8I=;
 b=cZjPNHv3lFsL80EkUAoVmgtV9Y1ajms0ffTe/M7tRc3CqusyPIAWgfMR/YN9nYu5eFqXZzuPk5zEyHpT5gX5AuxgZpI05Wp/Qf/RDa2GVXm5TUmKMdpplKVynpWKgp4zEx6Thub6Yc6EqFwXUCG1t/o0HARpupRpTIpBjDJUoQB3B/73F+v0qlhHxl/S4mVhlfsvAiMObufKlIYh6NSbGTJ/n1EYZFkhk4lFwbZEOx+lN5HrVtYmCogoSPU4TfYst0+FPOQXtpzHsJV/84jF7zli/DTS3IKZE9ofmm1A+EpPcm1NocLc0GxxD6a5yMRFhNYqmlsIAvL7LR7UwY8bTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvdHBj5yApv+3mwcH6LWSMXJlHljQnJdtS4CV2ZOt8I=;
 b=hnOtLnQIeaBIonQjlIzuBxnpVe/Mj5harWLyrSeykRmLLQcA+b8fyuvpBU30IW7k7b4huCaOFjndaDY0+HUEpt3rHVBNSN4ikjAIz14AfQEXZCKL4xVzuHb5BtyGTHLZTRTDKs3ymrMEWApL8LrpJ0UKsyIyAxdoPE5DlgNcAsHDiGOoQe1yC/AYcvBAA6ayZBU+15Wdt/Zu0l8TeGfCvmxNx5C8eufdeNdXpZe5sgWy1gGhly6I8PrMDuNE0yOEtNdxTnTx+7fykL/hr0+hBGO6weSX0VipNfOSqlv2ng2HcvpdNmaSw1+Y2MSJMS1bfQLXUGEn6B8s+fSzms2MaA==
Received: from BL1PR13CA0400.namprd13.prod.outlook.com (2603:10b6:208:2c2::15)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 07:17:21 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::fd) by BL1PR13CA0400.outlook.office365.com
 (2603:10b6:208:2c2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 07:17:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 07:17:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 00:17:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 00:17:09 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 00:17:09 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 04/11] selftests/mm: fix invocation of tests that are run via shell scripts
Date:   Tue, 6 Jun 2023 00:16:30 -0700
Message-ID: <20230606071637.267103-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071637.267103-1-jhubbard@nvidia.com>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 555001b6-8227-4b16-534e-08db665e11d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOxXSSCYbKiZAW8KhYwA//tOeeLektX4TyG4wkJRRv63fRRRNez/Kr0IWnUKT7BNwCP+PZ+bRfJyJ5wdEmQLS4YnhG6zJuhLLlK0rLdGZx5IAuI2jxuuO7g78qmPc5ZwaX4b3xxVHzeiarI77YScpsfP5ytdg8h7GfK01k9IbYS1d2SnRk3bAPhaowpHCa/Mj7tpC7YSN2g8eIFVb4E8srzEMd0wTSGXqLMpylHuoPVjXa/9Hcra8P90Pz9yziWdmkF5AQ/vUHmUNUtYsWP/qTpfoQRhP/CpsHOcYFog8X8APG7Lo9tBhkx2ER475JvcAywq7PTY399PIHMiEBRHrMV1ORij7KKYKfdi7CKF+Oc5n6PAGN37Vc7PSsmhtEcd+kfMwO67XrpTS2l00SR/H8T9wWx8dhpSRIcA/3z6B3pQc6X6QxPpoXoOXDyFLJvaW/5dh6inaK6ploMWuG6DAY7uQglcT+3XmoLGfBj4a2n1RBD726FfyJRguRYNlCUk0BVm5q8gvu5VHBbLc5z1sJYUJNa87mxkMF8YtEETATIKgbqsb/iEaRF39unYwe8RWiSN6BNDZsIPcb4zdeT8j27tIODkT3ahWoA3Z6KcUbIfcmBRfZv47T7eBpLdxECg7wcaKi03nhDi8NlzBUcbjh/QM+/AYMDxSIFAYLtQ9AMo/v9OwHpiw7bftd/wA8zC382vn5bIyYtTYnVXMQ8QVMM1JGMeub/ogvtC2213ICFIOdtQAmaiLVrw5y63gaNl
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(26005)(82740400003)(70206006)(70586007)(356005)(7636003)(6916009)(4326008)(7696005)(336012)(47076005)(36860700001)(83380400001)(82310400005)(478600001)(426003)(2616005)(6666004)(36756003)(2906002)(40460700003)(1076003)(41300700001)(40480700001)(8676002)(316002)(54906003)(8936002)(86362001)(5660300002)(186003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:17:21.3046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 555001b6-8227-4b16-534e-08db665e11d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We cannot depend upon git to reliably retain the executable bit on shell
scripts, or so I was told several years ago while working on this same
run_vmtests.sh script. And sure enough, things such as test_hmm.sh are
lately failing to run, due to lacking execute permissions.

Fix this by explicitly adding "bash" to each of the shell script
invocations. Leave fixing the overall approach to another day.

Acked-by: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 4893eb60d96d..8f81432e4bac 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -242,18 +242,18 @@ if [ $VADDR64 -ne 0 ]; then
 	if [ "$ARCH" == "$ARCH_ARM64" ]; then
 		echo 6 > /proc/sys/vm/nr_hugepages
 	fi
-	CATEGORY="hugevm" run_test ./va_high_addr_switch.sh
+	CATEGORY="hugevm" run_test bash ./va_high_addr_switch.sh
 	if [ "$ARCH" == "$ARCH_ARM64" ]; then
 		echo $prev_nr_hugepages > /proc/sys/vm/nr_hugepages
 	fi
 fi # VADDR64
 
 # vmalloc stability smoke test
-CATEGORY="vmalloc" run_test ./test_vmalloc.sh smoke
+CATEGORY="vmalloc" run_test bash ./test_vmalloc.sh smoke
 
 CATEGORY="mremap" run_test ./mremap_dontunmap
 
-CATEGORY="hmm" run_test ./test_hmm.sh smoke
+CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
 
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate
-- 
2.40.1

