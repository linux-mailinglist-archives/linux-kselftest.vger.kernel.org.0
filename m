Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597FE720D2C
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 04:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbjFCCQT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 22:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbjFCCQR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 22:16:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6CDE51;
        Fri,  2 Jun 2023 19:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpS51/F1YLuFu1bnkvawE+aJpHkKh4Map7kb8Ihkhfd+gC613hjINne6Oc45NCXZmjMDovtrOhtgeyyPfDyYSlBYgn/Wi40ffk9Mto5uO58gpr+ULqd+pxEzIMgQzWOA2PHKHwY6bLlBGFwjNtSN86ijlMpeNjTwyICYIxv6vBFk2+vL374EtGmFHMVphkK9tHo4kLQ2qxyPTy7EXu5Ha3k/Ap3vcK6iN22K7CYkXJl/VVvQZRfwtUNxl0FXfN1lvTxDr4TAt/wbxUX7Z0I5CVdqkqbK1+UgC/loukuCmUI0jedxrouyglFxXsTWwsnq3SfJwBB8PcRIwYgKSJi2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNITXhlW7/50q8EibhFIrDa2v1XwHbp1VFAUfpMqVhA=;
 b=OFZ9ODze72b/F0BN+vC+j6zPplgkW/Kce9tZ9wnqsNTyOC0aQNLJMuH3fEDblZJJr04qmn4yKKC2++WdmKVzyra/9EGpEgQDWQ9VYRPkWqESIH3VhaE/zXrrzLavS6H0lgnBzJNUMK7J5A7eyw5hOGOu2fHLAOQ3qXxCayGSkSTX19DBarcO5SrfCuRtbfdjJL6Yr13W//vVX48dB91q/G50CB9P9w8vRM7VoduR2ZrJIYKEKAAyJmTDMZSZdEhlCW3TYyrr6xCjCmzhnqXDV+2AhqVeLTjSFtmVY8Yrh3gv+XexTdd9heUPF73p7/jCJmtIfFhkQ2m8Lplef9xreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNITXhlW7/50q8EibhFIrDa2v1XwHbp1VFAUfpMqVhA=;
 b=KYm8H5ffBg0Bhiu0x6Z4VhT8DN1SIG6e7cFPCbBjkp2ZFbbtLD1SF+3fH4cEJl+d9wguQl3Dd7BbyDhsGoIFu8SxcTIYZ2lx4eYrRsk02dH1YmWrlW7rLto8tGl/5h7U8zWAzZY7apGxd+TeCzN6fzIxCjM4TZcfX6k8sUH+4I9R5wgXn+yPZnpC1a0Fkr5SWo8Rw7AeUyTsEf/zXkaiZDlTJtRmNPEdpU1kdpi7t6iyG7nnk1EfsSn1sCBKzbAMaan6bML9yDujFeNuvcIW8KTTxJICffq+raiAx7xg6A1QJFSpVGqQpD3UeIDtD+oA9xg8KRa+8oRO5TX/cGfElA==
Received: from DM6PR08CA0036.namprd08.prod.outlook.com (2603:10b6:5:80::49) by
 CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28; Sat, 3 Jun 2023 02:16:14 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::89) by DM6PR08CA0036.outlook.office365.com
 (2603:10b6:5:80::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Sat, 3 Jun 2023 02:16:14 +0000
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
 19:16:08 -0700
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
Subject: [PATCH v2 06/11] selftests/mm: fix two -Wformat-security warnings in uffd builds
Date:   Fri, 2 Jun 2023 19:15:53 -0700
Message-ID: <20230603021558.95299-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603021558.95299-1-jhubbard@nvidia.com>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a1ac45-7e00-4acd-4aff-08db63d88196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6GrvjepMgXX4Yp7sGZ8SZ58SCeNQVZ/Uj7hhVXkNSGOh5E9k6pSesgEE+DZ6Vd+qAg8JXIxzGStWRftgR/KUQ8/dBB+GRaVZZ5JO72Sa9mkezQ2Di3l0EVssgyX2/Z7tsNy2JtUvhLMGRH3tQy7jWcnjoAPJz3ffkU4FkMhxNeSRTTg8abM97H1mZEcRgJZU7Wy7cBREehyJgzKyeo+NNMbb6znoMsMHkGXCsfUnKdsa01mUDU2IqfHLKO+k8ds89VCtEgetKcBEeHHwprkA5moEtH4Mj8NG9XQdKrFnx725FrCtkuw5ISAolv2CuiK5wKzngBomsFpLzkM4taoR8hP/YAql+Txk4tq3l3FG23wz9NXReTYWNA4yRne5i1KzxicnKEDv4MGhVfvMJ83oh6sp4nni+fttvqx3M7yX4ALwzK5qvgkPgym46bEbj8SeeMJnWJBJNID0Y9wgJfQljLw3NZ/JqlPdBeq5FkHyNMBTxw2PLC88ve7Eq3UgJtq6CoYO9FLsxpB7+y2lBhr3XQktoMdF30voGq1ANDVToglB7WAgT8U1EwzaVimps00vTjnY8MIyvW+s5mgOPY1FQ0hyZDOZudAACbeEsm3Qh+kmhlNVZJloiNgwxQWBv0nt15YUzvk/98xcNd6KdTa/DWmre5JCR2YVixcgjwo01ytuOacFmIJb/9iTZgGJ9XCR8WvRWmNYJvTyIHDD1/HJ0NpCxF7pVzWr1osMMpG1lY/4ezEYFlmcpX3fVlc0gHl
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(316002)(7636003)(356005)(15650500001)(2906002)(47076005)(186003)(82740400003)(5660300002)(36860700001)(336012)(8936002)(426003)(8676002)(54906003)(70206006)(70586007)(4326008)(6916009)(83380400001)(41300700001)(2616005)(86362001)(478600001)(40460700003)(6666004)(26005)(7696005)(40480700001)(107886003)(36756003)(1076003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:16:13.9847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a1ac45-7e00-4acd-4aff-08db63d88196
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298
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

The uffd tests generate two compile time warnings from clang's
-Wformat-security setting. These trigger at the call sites for
uffd_test_start() and uffd_test_skip().

1) Fix the uffd_test_start() issue by removing the intermediate
test_name variable (thanks to David Hildenbrand for showing how to do
this).

2) Fix the uffd_test_skip() issue by observing that there is no need for
a macro and a variable args approach, because all callers of
uffd_test_skip() pass in a simple char* string, without any format
specifiers. So just change uffd_test_skip() into a regular C function.

Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 269c86768a02..04d91f144d1c 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -109,12 +109,11 @@ static void uffd_test_pass(void)
 		ksft_inc_fail_cnt();		\
 	} while (0)
 
-#define  uffd_test_skip(...)  do {		\
-		printf("skipped [reason: ");	\
-		printf(__VA_ARGS__);		\
-		printf("]\n");			\
-		ksft_inc_xskip_cnt();		\
-	} while (0)
+static void uffd_test_skip(const char *message)
+{
+	printf("skipped [reason: %s]\n", message);
+	ksft_inc_xskip_cnt();
+}
 
 /*
  * Returns 1 if specific userfaultfd supported, 0 otherwise.  Note, we'll
@@ -1149,7 +1148,6 @@ int main(int argc, char *argv[])
 	uffd_test_case_t *test;
 	mem_type_t *mem_type;
 	uffd_test_args_t args;
-	char test_name[128];
 	const char *errmsg;
 	int has_uffd, opt;
 	int i, j;
@@ -1192,10 +1190,8 @@ int main(int argc, char *argv[])
 			mem_type = &mem_types[j];
 			if (!(test->mem_targets & mem_type->mem_flag))
 				continue;
-			snprintf(test_name, sizeof(test_name),
-				 "%s on %s", test->name, mem_type->name);
 
-			uffd_test_start(test_name);
+			uffd_test_start("%s on %s", test->name, mem_type->name);
 			if (!uffd_feature_supported(test)) {
 				uffd_test_skip("feature missing");
 				continue;
-- 
2.40.1

