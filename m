Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7C37238B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjFFHRc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbjFFHR1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:17:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECEE109;
        Tue,  6 Jun 2023 00:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLzHpO/KXQOAkH4m0DUEyVWY884g1hehCucOwsW4gQLKd1TrKX1TzwQMkIU5Rcwbk3fmjVo1n8PWsbg5mT8vyxSJ0HjFDxfhs2iG7LOS0/ukDlZfP1soyOeVk9vJ43if+KBo7zWxuej/V/lUMjKNvlfCLhzJKdbPhUKP8CJzobN6uUvsZpYV6bjtLZbZz5Aull/hedpLQNGoWwPGCb5kPNFjoatbk8FGylHw/mNVss9jsj51qdDF7ubqtWlVnvpb3zlG8llD7gpRJOwEYtqlriR/f4xPFcD8mrJSUJ/Gwtsefb2Sp0dzZEmkNAx8wZYHNdHitvRK6koj98b3he4Ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOpTW35hPW9iKOEt96WhLvNwMqiGhAYImrqLsr3Vsz0=;
 b=GIFcumYKROG5l85+lZaLd1PeTULqcs5ZstCyHrNlw/13MOCxEwH3kxKMuJvNYspuNEwuWIpfIo7fAu7G+zPJCVw1iIzCRSHKsfchtYzs6EpJ+S7uaK6JjYAqBeECN5d7REcLniJosvBFVb4lvkVWPS/CYnV4i/70nPo7G6NPGdzBfw+F4mST3HSBtDaDBsvMzwqTyeVBY77Fy57Ty7rdkN3NUqS4T4vJOQ6Q/Az7me4MzS9puxHHio7+KoyK6KTQGCPx6ultGWGIgVS4MbvGoczX9X87uOGgoM8fQ65VpO4p444yWm7l2EjdgGbvHSKnrI7vBRU8nO30XpkSdV7Lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOpTW35hPW9iKOEt96WhLvNwMqiGhAYImrqLsr3Vsz0=;
 b=Cs3xjVBjMmPXKiGLvPsh82s1bxhDN7I+k1gUClbRmrPKFtiLSTgv+/Hn+vEF+hgOKubmKrJp8ss5sR/B73C8X1qXOrLpnv3FM+U2LfXiLbWsscKRjBm20WpEMG/Ag/JoHVgel3HfBAqRsxZ9k3y1CXKz1H9HwO8z1L9WhO+rCFz4pRR4OUfr0QPuMpk5swbYH/BAri98zXConkg8Be8dSYAfzwr2bTeMopJ8aFJIk+ex9fqFe3bqFhDa9tptkviz7pmkKIiMVyztGJsnGNbdyDxfki8e+CRuHfMTT0PZ6VDJcTiEkqRRqGzoPvU1KOQZ9JSij75OepNMLlIt1zqgdw==
Received: from BN9PR03CA0685.namprd03.prod.outlook.com (2603:10b6:408:10e::30)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 07:17:23 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::a8) by BN9PR03CA0685.outlook.office365.com
 (2603:10b6:408:10e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 07:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 07:17:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 00:17:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 00:17:10 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 00:17:10 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 06/11] selftests/mm: fix two -Wformat-security warnings in uffd builds
Date:   Tue, 6 Jun 2023 00:16:32 -0700
Message-ID: <20230606071637.267103-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071637.267103-1-jhubbard@nvidia.com>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 08de86af-7f0e-47fa-dd20-08db665e12c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QvkjZ2c9IwzdJR78K2sjoTyO6arPk17BGxnWAkDm4+oEKD9TigllXXB/EIULxdNFm4RncZV5vH2TPVRlDzLGfAOb1dmzBMhVt3j2f2qzKY6PVnBW8tHqN93DyBcqaQVLz7wNRfHD7tJ0HU2Cts1exe6+DO8dPhj614BUTS+e49ERhXpvMgNxWFb5YFKrPHE/ZaqSUtTcCVw2UuteGYofliUAPD6ko+orjjiXzenHmEG0IP+u6aWA2OvbarLCFglFQ5nhi71Oe3IAXG7maRKDik/84K+PcHiPuq2U4/h4sX48oTWZJ7RWLunwbtyByxlLy6qimvyGSnUWa4UxzZ0ERHsSYcrg4ymuQ5gLbb8tQP98vygTpMGNuCyT4OfkOogW1e/z498wKGac1tEdf3hiPQMeBJ2i4F/4AVJok9j/u2h7MKZ8fHYZirkrmgq2UJYs3WeVmQKN7m4Hx8IBntoGXU/P+2v82YfdYb3tb1lx9WoK5DeoeO90k5XVz3Ba2538uWG39Twm3drLdJO1YEYa1mcVhOsdGmaHDN6IuGHXtzCUrVdecULDXdl9QYNCF3V4+J0FDOP5T4DZcN6+1MwDNncXfONyIvIQDqt1BB81omK4HC7VPh9Ca3qSfqxJjY/Nu/nbYZ9SpwjAN4JRPyWY0glVNxV2oWuj+HnprkOLri8tN8kKOxZjt9iUz4akXbsB+xBPpINXhIqBp4iCtdf1bf76aqmiupk7z2MC6EdDUZX0y6nVPc3DkTXYr87WgKcP
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(426003)(336012)(2906002)(47076005)(83380400001)(2616005)(36756003)(82310400005)(86362001)(356005)(82740400003)(7636003)(36860700001)(40480700001)(7696005)(41300700001)(316002)(6666004)(5660300002)(107886003)(8936002)(8676002)(54906003)(478600001)(70206006)(4326008)(70586007)(26005)(1076003)(15650500001)(6916009)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:17:22.9007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08de86af-7f0e-47fa-dd20-08db665e12c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
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

