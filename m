Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC65D720D2B
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 04:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbjFCCQS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 22:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFCCQQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 22:16:16 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDE4E4D;
        Fri,  2 Jun 2023 19:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UijT4dEha26jLc/VP7RZfgOaYO8EccJbvXrvATFy2MhP7+MliTyms29v5FdhpQftM0az8BwO9x7VpuemvcChFxqoTu/nYsSILTb5QWteIJ1COhuiSjiQAvTlP8inGQtHaJ3tU6l56is06uPL4++uTVNZiRQMZke1hgG/Zxj0OuJAM9nzLc6AKmzP+wNxtrn121LRjbEBkItvGxe8VjBSVCAKMatMDDQsiFLmxmKCvkF0fan9fmMkOhEkK8fqwPg5iJ8HFYAKblu/Slr3Yf2AEIu8mw4PiiZ9kiaNauOfBrt4PjLth49bUGeaNsoPX6XKQ7SYpAyZfPdATHvwRBS9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvdHBj5yApv+3mwcH6LWSMXJlHljQnJdtS4CV2ZOt8I=;
 b=jYI9yCc5KNutAAMzuMNIhtgZn9Z0uMQhOF7mfqUsyiVcGPQiS8n1NIfSqHDlhZYsXh7cKsme5ifsJ8GgdJjdp+c/DSUA42cmMI+rH38xDqQjYBCPRXUr5kFrLrzCbxT6SMqVlyocdeM/2l2v9zoEGe1vJkv6MOBN3nfMrQlEPvZsQS4jNNoYZcFLZqsG6EC1Rg4VHfGmxLA7yRdAGo4WzJPvw2eJ5/bywzxdkXL9OCOnrfdUsDxKVcbpCnIdvcKAK8cekunFKmDAECWfKhPPYZANn5AmETLWUciApC+sd4hjRbHi81aXNVLBkXlrxPbJ/rsxFPdmNORjQyGILOzzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvdHBj5yApv+3mwcH6LWSMXJlHljQnJdtS4CV2ZOt8I=;
 b=qXJGc/dZ74K9YC/RLWY0ud/u1B0theGdJdf+IZMnGg+XEVZeh2LbPMW44wpkYHnts97eY6pp+2c+6kadXLd40A1flWWhiK7cAJIKjx5+h5SyGY170b9c+fv84gh6Kq73A4EJsh3ZH0MSdTXXT2F/4FrMr9rBNgwVMxG36zdBp4LHVWd2bm42Oo7lLxTLS2mAJBmcHTfCY9DHxvxdhyW6e69vwOwRU9iB/Na5deU7ebOwFGXTWvEr1CsAaJIt+Oppth7KWPyb+3DvY3uwYP5frRDs43sIIcaLMsc9XgS51uoDvUpQfvwcZO2SfGl6mL3hjLA41NgJz9ekBmCu3Ub+GA==
Received: from DM6PR08CA0022.namprd08.prod.outlook.com (2603:10b6:5:80::35) by
 BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 02:16:13 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::9d) by DM6PR08CA0022.outlook.office365.com
 (2603:10b6:5:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Sat, 3 Jun 2023 02:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28 via Frontend Transport; Sat, 3 Jun 2023 02:16:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 19:16:07 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 19:16:07 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 19:16:07 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 04/11] selftests/mm: fix invocation of tests that are run via shell scripts
Date:   Fri, 2 Jun 2023 19:15:51 -0700
Message-ID: <20230603021558.95299-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603021558.95299-1-jhubbard@nvidia.com>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: cae54a2b-1ecb-43c0-b36d-08db63d8813b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHXVVICQjNzu0XwqQK6e08dj0iBJLsdeYeF/yGV0SqzGQXoIf/6S6qZ8UY+NVSiUS5nqV6Hhwgk8zlbh2kTiGN2EDhQurU+pIcB4rB2KCInnGhcFxC0wMoCKgorDcZPsZwCq+wN3/BiF0sehfku7yNc/wV3nt/6Rx3LlT2JO8qh6G4Pclb3QkbFRXa1+GNPghcmvzmtTdgjzaZ6jbxwuKWt4gr5bIzWbeTBah/vj8dEsqnAHZ70QzyxR3/ManWfqFeFUNpYVw0yFmSMk37ChcnbQ9J1p+6p2ZcTDr4k5N03P2tHH8EvdMf9NGFWpIUWRuvuqJaNMcWI3QIXrQG1S8kiToBct4IssKzoArzDlZox+t30JN8GNqanguRTPYv6+DiFrXgFuN1I+4N7TzcdOBhVGf4rnYR1wuK7SV16W3tsmG//bXF0cd0C6A3u4OoGQrHrz4Jw5PNT/NK9rnTtX6aXJRwHwdgZgziNMZUs1KOi07QBrOT5+he2xKs7BeS17SOHQwVGNYOLBQB7g7OmNUMajZDDeEaihXu/BasjzItQXodbTs64sH5R9WMdaoq1k8NmwkPkeSZhxWzZgHAFhcR+WXPh+Tc2HR+wSPAmnWfjQMfM+Hio8D82Yu6gdtFkeW9yXPbr9Z0bTbCWXAKNhboKyvUtZl8FECt4WJtCeZWFbiLpjymTK9SjCqUjaS6rHxcBl4VMBJzgiFvQTVVqtMibemfLaKxAj+Eu5DGSbGqkIfKh64q2rmNcHtTI7egpu
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(316002)(356005)(2906002)(47076005)(186003)(82740400003)(5660300002)(36860700001)(8936002)(8676002)(426003)(336012)(70586007)(70206006)(6916009)(54906003)(4326008)(83380400001)(7636003)(41300700001)(2616005)(40460700003)(478600001)(86362001)(6666004)(26005)(7696005)(40480700001)(107886003)(1076003)(36756003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:16:13.3910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cae54a2b-1ecb-43c0-b36d-08db63d8813b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
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

