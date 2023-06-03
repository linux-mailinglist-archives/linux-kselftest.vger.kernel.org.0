Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B41720D30
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 04:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjFCCQX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 22:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbjFCCQU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 22:16:20 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA495E4D;
        Fri,  2 Jun 2023 19:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgvSi9dSbKVMcY+CgQwG2SKhOukNJgmgwMICDh82nbVonRjZja3P1mg1izMhzxCO2AFxBwNX2zSBtkcXR2lvpUTgxY3NvNWbm8CZMNXNPCeROGwQcpWEO3dIIFd4E9eXoPUjUjQ/vM1fN1voWw1mweRcT6e5DUgOSHW7L1dumc851GZjaXPYlBnHCiEIg7VCZC01s2VdRAA0jf3P5cw2L1E7qGR/+BNYSc4v55Nr/tlXdiNvek+OrA8JVQ8oUeo+h4klMioPW2CmYCyHxBC6E/nUfplnpbyMuCKHtO0bCqF2AXWFuhwdy7nTL0e0aKtqQ46DStqXFuGmgyKw4a22RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7qWJ0iKcBH5AScsmOvvAEPpASsgJNPE7K/FjHHYXLU=;
 b=YKhQUjW1ovBgO+ZNgp+ye7ws9uBtrORudLnIQHelZQphhRgGauN5HNrVyscPhGF4Z7BGZ+dG1DCD6yA+ZwXS3RywKY0PnkCDRkT8R3syvqdr9MhX3UXd9scGarEs6E9q/Sw4AOQznF+qt2bJnT5O8TZV5AKkdAvNpsEm8HZD6tP5nsCIayohsDzu7/PD6UZvCKk8AJqzt7D9EL7VpSnHUhigTZIss/eRqKnxbcfQ+k7PsueF802HaekFEOnDuefCRAI7yNmontEke4RCWW9jqRwzSyFo1FBpxKTsUapf189kG7XTYq7Fsdm/Wzw4cZbLWnixFsNL6/NuuVXvcEzJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7qWJ0iKcBH5AScsmOvvAEPpASsgJNPE7K/FjHHYXLU=;
 b=T+kwaTEri7b1E2Fiz+lE/Cx+qu4HUGHgz5z8Ry34UH0YNjx/cg+ayUy846jpQ8iUc0FzqCUwiftnWztDVsSIwK+1UXDD5++4V7m0+aNbTjhLSp7U1dhhkvXAfG8m/IMm3T+nwgKVld9cW3g21hILxefGnkfnIntw1inXTL1HOYbOThiG8wVuaNaxkdjusy14BcYVGOhEEa9dNDm3S1J+VS/+gff6W3l9sZtN4ZMpsFQrMbcLAGnuCNVQNGsOlg7YeSv/i0kRSOc2w+ZysICLQsSBr49kSYg3Xs3acT4OCHhu74xljguL6GNnpjHh1/U3ViBq6yG7u0aXbNbru8eFdg==
Received: from DM6PR13CA0008.namprd13.prod.outlook.com (2603:10b6:5:bc::21) by
 MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28; Sat, 3 Jun 2023 02:16:15 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::54) by DM6PR13CA0008.outlook.office365.com
 (2603:10b6:5:bc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Sat, 3 Jun 2023 02:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24 via Frontend Transport; Sat, 3 Jun 2023 02:16:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 19:16:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 19:16:08 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 19:16:08 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Muhammad Usama Anjum" <usama.anjum@collabora.com>
Subject: [PATCH v2 08/11] selftests/mm: fix uffd-unit-tests.c build failure due to missing MADV_COLLAPSE
Date:   Fri, 2 Jun 2023 19:15:55 -0700
Message-ID: <20230603021558.95299-9-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603021558.95299-1-jhubbard@nvidia.com>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 7413a83a-9fe6-4415-5259-08db63d8823d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nr0aRGhqo8cpXsOta8vimurzvq1Cu8pWwPJNbdshFg390LbktTr7mjClIX1+L88vdPvs2x/EQYxnZ/DmMiXOOPZGqwBmSH+dnmhnIw6qKD8DE8lbyZ1Xvg1W5dyDzwDD3h6XN4Sr8MmwHAZA+qQZFUepUCVoQY6TSZCoyyWtXO90jB06BGM7Znb1CzayQZ2hMiuqKUfl/jOVP1fhKELa6154GvqpIku3zOuly//Io/0pgnwn4m8RktJWsJsOguZIkcsYP9AFOFkT0bYhIcy/vp4WUuyVfQvz30CfHwghT5YN2OjbX1jfOcA+PNMJLhKJ3jQgy513ZcEA798hrQNZSnp1+P/BNqxHM0yZirP59bZmW3vLjiGxzI+iIKRe9fqZQ8qiqSssjSAIQpo2WxxBm9sVlWp91DbR39Xem2Ujvzf+XB1yQOOPMQlW7xIXJ9aGh9Hi8ZK+0E+a1oSzik4HQWPVsmCmEy+cR5SW2RWDaqALJ0DmlLLPvdh6z7PH2RnZvbwIVoyEUle7ocH0zCq1sKDdzqbiEBkp0CkX2hkU1lnkpRP0FFbkSO1G2SYdPqBIxfLEBn9xqSpOJpbO7AHJqZfMOcw9utgpcm6bMXPluvI4BFOJcIFGrW3Mac0Ctzrh+k8E/dPXv5IW63lpdNJFi2EWVk/aB8Yc8xggB8aHdFXUCtRDpraLOEcls2bxTlUA7HcwOZtClCxlfA8lx/cFDdbOxYHvM7cWCqYZMl1gvRr2dSLxKop2Ce+/C2MkDn5E
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(47076005)(83380400001)(40480700001)(86362001)(40460700003)(82310400005)(82740400003)(356005)(7636003)(478600001)(6666004)(7696005)(54906003)(8676002)(8936002)(5660300002)(70586007)(4326008)(70206006)(6916009)(41300700001)(2906002)(316002)(2616005)(426003)(336012)(26005)(1076003)(36756003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:16:15.0793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7413a83a-9fe6-4415-5259-08db63d8823d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

MADV_PAGEOUT, MADV_POPULATE_READ, MADV_COLLAPSE are conditionally
defined as necessary. However, that was being done in .c files, and a
new build failure came up that would have been automatically avoided had
these been in a common header file.

So consolidate and move them all to vm_util.h, which fixes the build
failure.

An alternative approach from Muhammad Usama Anjum was: rely on "make
headers" being required, and include asm-generic/mman-common.h. This
works in the sense that it builds, but it still generates warnings about
duplicate MADV_* symbols, and the goal here is to get a fully clean (no
warnings) build here.

Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/cow.c        |  7 -------
 tools/testing/selftests/mm/khugepaged.c | 10 ----------
 tools/testing/selftests/mm/vm_util.h    | 10 ++++++++++
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index dc9d6fe86028..8882b05ec9c8 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -30,13 +30,6 @@
 #include "../kselftest.h"
 #include "vm_util.h"
 
-#ifndef MADV_PAGEOUT
-#define MADV_PAGEOUT 21
-#endif
-#ifndef MADV_COLLAPSE
-#define MADV_COLLAPSE 25
-#endif
-
 static size_t pagesize;
 static int pagemap_fd;
 static size_t thpsize;
diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 97adc0f34f9c..e88ee039d0eb 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -22,16 +22,6 @@
 
 #include "vm_util.h"
 
-#ifndef MADV_PAGEOUT
-#define MADV_PAGEOUT 21
-#endif
-#ifndef MADV_POPULATE_READ
-#define MADV_POPULATE_READ 22
-#endif
-#ifndef MADV_COLLAPSE
-#define MADV_COLLAPSE 25
-#endif
-
 #define BASE_ADDR ((void *)(1UL << 30))
 static unsigned long hpage_pmd_size;
 static unsigned long page_size;
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index b950bd16083a..07f39ed2efba 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -63,3 +63,13 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 
 #define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
 #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
+
+#ifndef MADV_PAGEOUT
+#define MADV_PAGEOUT 21
+#endif
+#ifndef MADV_POPULATE_READ
+#define MADV_POPULATE_READ 22
+#endif
+#ifndef MADV_COLLAPSE
+#define MADV_COLLAPSE 25
+#endif
-- 
2.40.1

