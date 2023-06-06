Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776BF7238AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjFFHR2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjFFHRZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:17:25 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A01F7;
        Tue,  6 Jun 2023 00:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j61+e5z8XhSvb86Pb6/ZS/u+i72hc/l4keiNP1wo+j7D4ttiBIYibMYdfChf0KgYSGsIV6F+6ZcmQF6wldWpfwYfa1t7Cv7chvUxYN966yxm4PteKGR5uHGc3/oHhQcPO+WxNITnSOvc2mPXXZHL7U6JTnXjXIH4m0dd9pXR3zPKnbbz0YozVM4qzl/+k7xRLDtVmfq6zT7NyMeEZswWgnVLRQJqy8rSsl27FNLEwKCeILdtlrgalhkA5A5spUQaoyrYLC+gNhE5289ZlK0PqKaMc3Cn86lxrIB7KRU6v3Ip7emnyqXRDcDymnPnYgDftXJiHlHFXY7S5wBkt3rHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oomk2fy3Qd8IWmlp1U9Cr+uW/RGziNlTD8zYdFVYMMA=;
 b=aGqs2kVLge+C7sTZ6ErEWATw6v62ag7K644y/NnzGwj1tEI/TUWabJeZX4EfAkzQNuRXT2SBjJWXVDmzQ8F1RQDUmj1hrJxZ6siEGY53iEyBa5IT2zyBVaiDY36c1Ea4RQl+heoU+B5n5AI3XfuRmLwDuWyFBisuIhHTIwKaxAR0CaPY1oWU4LXylfnNfgIq5Rim7R7t781B18z5dyfPgkdqO+CFUu42oNamcimEnbrHwnSvMEped0+HetsowwzOD6V7bNADwjpfYMC0au18rvWfrTXSfLXUSpoP3CvZlr9q//sWcGUgAUl7UkvRwsGI01V3YFx7wRbmAw7A852iOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oomk2fy3Qd8IWmlp1U9Cr+uW/RGziNlTD8zYdFVYMMA=;
 b=Ze04XqAwyyefbOQdLS2a/cErELDu0dyXO/JDMG3PY5ONuz3OafovhpM1Vm1MHizELnzQs6lZEDvrRMUTwas281IZi3c+pzLI/s7EcVj4UO4imJR8ASc+TbiFjZcrgTj0s9v/9zKfdSsKMxydAHYdokyhDx5ax4MPnT7eW31G6OP8VBDDVO6dQgiXHTeMhJlhanQTJCLfuFGbrxrmB4xKE2sLPSnXYURWdAMxdpQue9GdFN/dcYNY0jx63JsRluHdWyhoiiCbYJLz9Ha/xj/A/VnFwXOCnUDcjwefYd34y41gGy6RaYzS7wWpbnp3+vv1ofYP9we/0g9F+qA6YAmdRw==
Received: from BL1PR13CA0402.namprd13.prod.outlook.com (2603:10b6:208:2c2::17)
 by DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 07:17:21 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::b6) by BL1PR13CA0402.outlook.office365.com
 (2603:10b6:208:2c2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 07:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 07:17:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 00:17:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 00:17:08 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 00:17:08 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 02/11] selftests/mm: fix unused variable warnings in hugetlb-madvise.c, migration.c
Date:   Tue, 6 Jun 2023 00:16:28 -0700
Message-ID: <20230606071637.267103-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071637.267103-1-jhubbard@nvidia.com>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|DM6PR12MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ddaaa03-832e-4960-58b1-08db665e1157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmsKfaV+Y9szZUbOLZz/nYJQ5ryVYu3989jC4EVu3MAXqDRqSRoZeotMfNffL2FceTjsGRiZj3rOt1cdxALUiE7XfVc3kIMalNK+z2anDlGJfG20eRAGJM50QMmoxNYomAhfLdiMqc9u5gnKwrNcqr/rFx1uMAyd1nY/yMKr8soUG2S6FZamAZhJNJLN4Vma91pbW89kwUvfItk52W0lVCMHcwmgGkoAneVqIi9a2IHEi8ezr6Vmsf+1Qg/hk+NUbaJ2R1Kx1NHbgutUfXdRP3TD2oPnaMpNY+NzHtykwfM2W5xjerS+e38ZkhNPzK+vc/abCVAZf3QLrvH1Yo57LBkuDGcQOawlrvkxaSn0qhJbXWz/CbPUTVvmuE2wU0P6B3mrNT2pdosQ71kb+I92H7ysmgx2/eUzjCywbKtXDLnD9dYPAhJl75xT5UfTEDW0CevAoXQv9C/jaBkKye3JaZFL88sqrahCZnCp6SXv5vLLmuOOkasW3XG5JQj7hjJv8Tqv11wwBVpIhFoFjkPiaT9qTOOy0l0V1oWuet8iUcXHIe7XjvigldV33GVDEGykwqNhRAgTIgLz2qI7zYTFzv4dunniqQs21zwLFbz9Nt6tBlGASkgy/vE+4MF18yUu1y+kcmOdSiOMHcmSmjupEIAnmNKjQL7404448TgKjZR6OwfLrEMrN+yVceP4i4t9US79AW0Hdl2Tw75sl6uT04uE5tXfMmHLGiK2mjlp9OhQNAR+bAZWX3osPTcjIORV
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(107886003)(1076003)(186003)(26005)(2616005)(426003)(336012)(83380400001)(47076005)(36756003)(6666004)(36860700001)(54906003)(82310400005)(7696005)(2906002)(8676002)(8936002)(82740400003)(40480700001)(478600001)(40460700003)(6916009)(5660300002)(86362001)(4326008)(7636003)(41300700001)(316002)(356005)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:17:20.4921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddaaa03-832e-4960-58b1-08db665e1157
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4877
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

Dummy variables are required in order to make these two (similar)
routines work, so in both cases, declare the variables as volatile in
order to avoid the clang compiler warning.

Furthermore, in order to ensure that each test actually does what is
intended, add an asm volatile invocation (thanks to David Hildenbrand
for the suggestion), with a clarifying comment so that it survives
future maintenance.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/hugetlb-madvise.c | 8 ++++++--
 tools/testing/selftests/mm/migration.c       | 5 ++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index 28426e30d9bc..d55322df4b73 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -65,11 +65,15 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
 
 void read_fault_pages(void *addr, unsigned long nr_pages)
 {
-	unsigned long dummy = 0;
+	volatile unsigned long dummy = 0;
 	unsigned long i;
 
-	for (i = 0; i < nr_pages; i++)
+	for (i = 0; i < nr_pages; i++) {
 		dummy += *((unsigned long *)(addr + (i * huge_page_size)));
+
+		/* Prevent the compiler from optimizing out the entire loop: */
+		asm volatile("" : "+r" (dummy));
+	}
 }
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index 1cec8425e3ca..379581567f27 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -95,12 +95,15 @@ int migrate(uint64_t *ptr, int n1, int n2)
 
 void *access_mem(void *ptr)
 {
-	uint64_t y = 0;
+	volatile uint64_t y = 0;
 	volatile uint64_t *x = ptr;
 
 	while (1) {
 		pthread_testcancel();
 		y += *x;
+
+		/* Prevent the compiler from optimizing out the writes to y: */
+		asm volatile("" : "+r" (y));
 	}
 
 	return NULL;
-- 
2.40.1

