Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6992720D38
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 04:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbjFCCQy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 22:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbjFCCQs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 22:16:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9ADE74;
        Fri,  2 Jun 2023 19:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0wvmzMX2+2lgTlGV7+gto7RjltVDuDcJ4EUgBPfOqWKHBi349MiK3mAuRAQA0LkcgjMzzMXnhvy8liOr50rBTlrUSYtZgiMz7w8EYS72+fLiZzr48HjXI5A8c64x98QZZm6JewQrriNl1kc3hgYrJvdMqNARjWbHKEyeiCzbYNdbTb24zAW2qgtHEDi0w4+f2zR7CGLCguLO8GBEdpgNu+nUItTOZcEXxe1NVU4o/9BKpZumEpcqBBSYtIWE+KGPUep9S2uaf2oTh+tHwJGFPWx/angdN+YN3zYaFhxJaWnkKsLoZoOMD0LeEKD83wCkvb328zz01fQ77dJPoHOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DWMqFfWmcM0S74ipR90Z5t8Em5oNzomwf7Su2Dj4R4=;
 b=kNzp/bAEy19hfRkRKK6QPpeiYkzY+cUNeFDmfUWE+62TBp3ZMvsqqlxtJViVReODiuf7JU1NoaBO0aqboxHr2Ui1Duoj97gSMM/19GNuqQX94Vbj3rpSNckd9XpWlJn23ioFQf+xgetrC5L24HRVCqQ5BQnwUt9YAGlsNCQBAYxXsUcZTIQeTuWajrv0Xlc98btnnTTcRr7aM4c82sbeNNCDeZrT65zEybX8iM53k0fWI6BzaQwNWjlOscJoyy+GRAOlP73N9BYo565YLn54NaiDD5/yDs2bNrEC9n6zrUhwGCr3Vcnnsafj1tX/kADqY0QM/qsm2yGeBervdO7Ilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DWMqFfWmcM0S74ipR90Z5t8Em5oNzomwf7Su2Dj4R4=;
 b=UyepBzWfehO7MgNo3y09cOBnplR2kwSIug7lDAlrS0810ErTRvFZJc2690uqVH0t5dYlGuMeO4QfsqhzPs7ji69zfqXG8qOZFs76PqfJTg2FjlKsMNgnErtvfuMqO0VjPRxcd3cfbA/VQTckhazivCPTOxYJ3qXxbyi3SbX/y9WIbtAl3aimDV5iwjRE/eJ57y26pKC1h8R411jUmVDL07m75XwfEDSJQCXQvD3to8/p22vHrxc4oWoi9Y+bP68a3bAHgBmLdkh3RZ7dcBhBJFBWfBVnnchDHOnlcIgcN4kMOcgneSN2aV7peakqhrtTwHE5X3n623pLreRvMBlErg==
Received: from BN9PR03CA0603.namprd03.prod.outlook.com (2603:10b6:408:106::8)
 by PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Sat, 3 Jun
 2023 02:16:23 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::8f) by BN9PR03CA0603.outlook.office365.com
 (2603:10b6:408:106::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31 via Frontend
 Transport; Sat, 3 Jun 2023 02:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28 via Frontend Transport; Sat, 3 Jun 2023 02:16:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 19:16:09 -0700
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
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 09/11] selftests/mm: move psize(), pshift() into vm_utils.c
Date:   Fri, 2 Jun 2023 19:15:56 -0700
Message-ID: <20230603021558.95299-10-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603021558.95299-1-jhubbard@nvidia.com>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 407d3725-fac4-4239-cc21-08db63d886ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMGmq3uSy47cK0QCBP8nvRopexopyt98f8rAjhRSt6kcCMjIJln+Jd124MEdJKEnM7wzPgKenr2OH859KMAqAuRAJ6/HJ2d/D/zc2dL4RwWOqOZTVo9m9DWhJQ89CMcifgjNb21Ei/B1hUffraT2q+6wpbMePAjGQiWDtKoKiwS/mtGW8+mTS4/lZAJm6nCoRaZ/Z7puKdQQdQTULDFu6LZiUdbr8Xa2uWb4gtD65aHOsWj9HA6oVhqIamfQIQpDB81KZbGaFc7RoOrQZqlCl3kiQVTWjNarfvqo8fyEzRgkB/1cz2LL7M2l6nI0ZbzQqTmZ6oHVwrlUT7f9s7RE1h5uEBVAcqceyPcho+J5R/mEywh6sLmhTIAmyTtZlXY8io8pdBWnW4kuYpI+edf7NmC17E7PDFSKfkzluWOzHomLK8CxtPRhLi07525ZwLc7KQdDLNR00jNPZHeLT/YEjwcM/WAUEsXGWSwWXef5D3zJuCO1yUl1IgBAOQMEbbKIU9ruGNsL50q9xsrw9Ks1BsvDutIecehzMtXqR8yZ7rsLzBsc/Hj2ngG2lRRFgLUqIpYf5Lh7+rkSIG/zbbrHyM53A/FnGwfwk+amTvKmCr0vdULof0namXujL6DBkF30x2C3YYPkd62pbgK/G48EVFiqLiUNnML2ywdbB+UbRig7unqumOasib+NqHombP6bwttuZmJa+1ic19pGSzA0+oEc/GfPrUCXFL43RiOE5boQ+QwnZfqNVe4f3tKs7Mvc
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(36860700001)(83380400001)(40480700001)(426003)(336012)(47076005)(7636003)(82740400003)(4326008)(356005)(36756003)(41300700001)(316002)(6666004)(1076003)(7696005)(26005)(6916009)(107886003)(70586007)(70206006)(8936002)(2906002)(40460700003)(5660300002)(8676002)(2616005)(54906003)(478600001)(86362001)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:16:22.8646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 407d3725-fac4-4239-cc21-08db63d886ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6764
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

This is in preparation for linking test programs with both vm_utils.c
and uffd-common.c. The static inline routines, while normally not a
problem, in this case complicate an already fragile header file
situation: the header files including other header files leads to
compilation failures in a subsequent patch that moves code around.

Anyway, there is no particular need for inlining here, so turn these
into normal functions, as a workaround to avoid refactoring the header
file includes for now.

Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/vm_util.c | 14 ++++++++++++++
 tools/testing/selftests/mm/vm_util.h | 16 ++--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 9b06a5034808..01296c17df02 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -301,3 +301,17 @@ int uffd_get_features(uint64_t *features)
 
 	return 0;
 }
+
+unsigned int psize(void)
+{
+	if (!__page_size)
+		__page_size = sysconf(_SC_PAGESIZE);
+	return __page_size;
+}
+
+unsigned int pshift(void)
+{
+	if (!__page_shift)
+		__page_shift = (ffsl(psize()) - 1);
+	return __page_shift;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 07f39ed2efba..8aa543a3678b 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -3,7 +3,6 @@
 #include <stdbool.h>
 #include <sys/mman.h>
 #include <err.h>
-#include <string.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
 
 #define BIT_ULL(nr)                   (1ULL << (nr))
@@ -17,19 +16,8 @@
 extern unsigned int __page_size;
 extern unsigned int __page_shift;
 
-static inline unsigned int psize(void)
-{
-	if (!__page_size)
-		__page_size = sysconf(_SC_PAGESIZE);
-	return __page_size;
-}
-
-static inline unsigned int pshift(void)
-{
-	if (!__page_shift)
-		__page_shift = (ffsl(psize()) - 1);
-	return __page_shift;
-}
+unsigned int psize(void);
+unsigned int pshift(void);
 
 uint64_t pagemap_get_entry(int fd, char *start);
 bool pagemap_is_softdirty(int fd, char *start);
-- 
2.40.1

