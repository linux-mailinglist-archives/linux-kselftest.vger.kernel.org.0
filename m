Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CC54AF52A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 16:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiBIPXQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 10:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbiBIPXF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 10:23:05 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCACC0612BE
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 07:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZanT3lyN1gc3fQ/1uYZewHTiTDHs37oT+i2jKj450Ro=;
 b=DTgseelI/togpL+Po2OVRYC+eN/M9Biv7q9WeAQV+2ctVn9cyrpf2mL/wfutsVWIVX+zf+7w6nnd4LyGfORfkiGRCfrjK26sqfjadqMvNBWb0vVCwe53MzzGt5Rhuq9/kzkic9WCeFMXGlaGITaZmYicErpC/eBfuq1Lzfykhbs=
Received: from DB6PR07CA0021.eurprd07.prod.outlook.com (2603:10a6:6:2d::31) by
 DB6PR0801MB2120.eurprd08.prod.outlook.com (2603:10a6:4:3c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Wed, 9 Feb 2022 15:23:05 +0000
Received: from DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2d:cafe::cb) by DB6PR07CA0021.outlook.office365.com
 (2603:10a6:6:2d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 15:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT019.mail.protection.outlook.com (10.152.20.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:23:05 +0000
Received: ("Tessian outbound 741ca6c82739:v113"); Wed, 09 Feb 2022 15:23:05 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3c0223871a9261da
X-CR-MTA-TID: 64aa7808
Received: from ece15a54c64a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 52E19A3B-1094-46AB-9DE6-B5E2A04C8133.1;
        Wed, 09 Feb 2022 15:22:55 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ece15a54c64a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 09 Feb 2022 15:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgwu0xORQQ9ZikGSX/fhxzQfsAJhJP4IJBCEIbpjGDYYysHhxupU+JUiHLzg56QVNi2K3mTgbVn8WEEZIBiSdUAEVoXtgPKlJ/tUfcAewOYp02QT4klrzkox2DA3xFV4yr1ZyJ1o0MqLxC9kkE5BWmZ0C0R/nCSsvDjugK5wgNMzqjTwUJBU7pliD2/sefuuHpvMg6SwRfH0nJfa56SpYGBT4pcttwlpdpp1qR/4u/lyE2fM3cmArpfbgz8+StuWrqQJajUTMRl8XkbgC03QSvj8p3/2qppeMRpg7S/fDntBfmqTNSZ+vsE1GNh2uCbbMREwx9rIjsBwSHmGxZ7oYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZanT3lyN1gc3fQ/1uYZewHTiTDHs37oT+i2jKj450Ro=;
 b=N0pdEJwiUMAeg/JH6uP1hFHVKxT/irkIoOf+YAw+JXHgv8EdV2zddhXcCoglaR3unMB39A7jROzPO/dC563pSrSCku0EtMndXfeu7pDKXh6OCuw5C0AbENayO09GVpnfSeXHUzljaye9sVdifDtzJlnIwTkoWHtBeF7JW6sGFmQPBl/IGT2kS+YO/FIUkoBFi4t7hrx/m1XGe7BHPGDcuuOtkfly6K+U9iDZDsDi6fiSZejw9yfwlSogSxKeAl5G5sRnBq7Owkq79PrROxL3N5NH32jch7ClAM4oODiW2ZhEoTAluLW8C0gqdnrsTLMxlKRu0niXGwHkB4Gn/RowMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZanT3lyN1gc3fQ/1uYZewHTiTDHs37oT+i2jKj450Ro=;
 b=DTgseelI/togpL+Po2OVRYC+eN/M9Biv7q9WeAQV+2ctVn9cyrpf2mL/wfutsVWIVX+zf+7w6nnd4LyGfORfkiGRCfrjK26sqfjadqMvNBWb0vVCwe53MzzGt5Rhuq9/kzkic9WCeFMXGlaGITaZmYicErpC/eBfuq1Lzfykhbs=
Received: from AM6PR02CA0023.eurprd02.prod.outlook.com (2603:10a6:20b:6e::36)
 by GV1PR08MB7329.eurprd08.prod.outlook.com (2603:10a6:150:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 15:22:53 +0000
Received: from AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:6e:cafe::29) by AM6PR02CA0023.outlook.office365.com
 (2603:10a6:20b:6e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 9 Feb 2022 15:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com;
Received: from nebula.arm.com (40.67.248.234) by
 AM5EUR03FT015.mail.protection.outlook.com (10.152.16.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:22:52 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 9 Feb
 2022 15:22:49 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2308.20 via Frontend
 Transport; Wed, 9 Feb 2022 15:22:49 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kselftest@vger.kernel.org>, <nd@arm.com>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <joey.gouly@arm.com>, <shuah@kernel.org>,
        <skhan@linuxfoundation.org>, <will@kernel.org>
Subject: [PATCH v3 1/6] kselftest/arm64: mte: user_mem: introduce tag_offset and tag_len
Date:   Wed, 9 Feb 2022 15:22:35 +0000
Message-ID: <20220209152240.52788-2-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209152240.52788-1-joey.gouly@arm.com>
References: <20220209152240.52788-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: 8de4a09d-902f-4a1f-12d3-08d9ebe011d1
X-MS-TrafficTypeDiagnostic: GV1PR08MB7329:EE_|DB5EUR03FT019:EE_|DB6PR0801MB2120:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2120F8C8EB10038132D46700942E9@DB6PR0801MB2120.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0nt3vRsz0pCNNLFi2D9egZVgy2iFyCAJpHWBrbIk8HQ5pDJzrnb9dHjefNJ11M7yJw2obddMF+Af1aO8UXJZIVTPq9b4j1qL3yxpYQpl2i2OzGzlWDqLR0enmvh0T+m8ByCQoobIx5/zRrDRwL8nvXOkt4s/IXXEYEuDFOaULBnRkHaNw36z2zU2foCclimp4bO0pg43CB9/jKuDOqaHOEPxJkSIU1CSyFB9+ctTc1m+p3aXHBnwSyi8AN979NfObT84nTwg+z1lqbtlD7vBFpiV2Fm4D5kI+cTD2xv+iIZucMllKrE1hOyjX1kcPln/hYwCWt8B6cZP8JH0BA8wvY2zebIGAOpNi/WCPaPt8JYTfgKcHm0Qai5p9KZ5C7tKCNYiIOxDjOvoLof8IpC4gSCmeDyVsSV49/MBduvF+zJoalaLjUmPhvT1Bx5wO03/o4t4uPg1Yx7Pe8ENmuoOfjG+UpI71kXPuQCQMfgrJlxxOOM97axcsS14EAJWzwDsShkSthhzI5yhTGvLUZsurUaxQSPY46Qh5WMaq08fcilQUDgf3Fi8627h66Ydtkj7MooxiZrbqTcAH2/ukxPIevWKPcwMAtTsScSwGhatRXm5Jk/iTGQ28VPpCN5Iz/HWt3NofSPX2vcm1FLFJ6jhtx5rkwepyZwn2rbr0GK+VSbbbXTevGAeeez0MpZ0tOA/W+lCt769e4hHGMWLecEVlw==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(86362001)(6916009)(2616005)(70586007)(7696005)(82310400004)(40460700003)(508600001)(36860700001)(5660300002)(54906003)(8676002)(47076005)(70206006)(8936002)(316002)(1076003)(44832011)(83380400001)(36756003)(26005)(426003)(356005)(4326008)(81166007)(336012)(186003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7329
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 64f74e5b-62cc-4639-a0af-08d9ebe00a6b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WOiw/IXLoRWNXd2jmX2fcrkJSPYZsCYee73sr3Hime/oQkHP+29BKFYygT10QGx534wWJzHdxJk9mMiux4ZowOqzMjtG2gFau1ClszqvxmvOsQa52TxqFzgRMyPXdrZtQl5lWtstVH9vqbWOXYSIgj8pLmeTO5xLzx4AkbVSVvNGp/xkmoReeBT++UxgvgrQde1Ay88JI35lw+7s2qPqKOJcTrVwdBbiMm8wYNSqB4rhJLIz3pCXtvPoWCoMK/QURlg4FbSVK60CB18nurUOEAf8ikB4F9CTRzQ8ZYZOc0aHmvUC0xuxpk8Hw7H/DXk7ab3aS+80YqwSvv6pWqZY55H28hTvYQd08/Ex5Q/sc6rO/WceYnU8/XgYC0IbOZQdl+Af3OVh+NWoRMiG4ByInoAT2OTKlKxJZZMqe7MMChckN6L8ZX8szFdKXHaW7rnKaYJmT2kw/msLal6JQn+a8xx+Jd1aMcWnxE5jhhGTUChAEZK9SZbglEohsCcf1DTZlG80/ycNipszWCtPeiYutYQNNcbj1jZzTB2Tk4G0KKu0VvKC/B/OSO132qmgphJGQEiZWo21QOJVNSRQQzIPuSrQLVNICHvANr7+ANIHxjMzRw/32w+CYF+evSTAmOopMVgrj18fikbcjge7Ty4JEea+C/uR3Kn2uVBXNoiAohPZrD2ZU75Mangs7UFtvHx
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(36756003)(2616005)(1076003)(186003)(6862004)(426003)(5660300002)(316002)(54906003)(336012)(4326008)(86362001)(47076005)(2906002)(70206006)(7696005)(6666004)(8936002)(44832011)(81166007)(8676002)(83380400001)(36860700001)(70586007)(508600001)(26005)(82310400004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 15:23:05.3595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de4a09d-902f-4a1f-12d3-08d9ebe011d1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2120
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These can be used to place an MTE tag at an address that is not at a
page size boundary.

The kernel prior to 295cf156231c ("arm64: Avoid premature usercopy failure"),
would infinite loop if an MTE tag was placed not at a PAGE_SIZE boundary.
This is because the kernel checked if the pages were readable by checking the
first byte of each page, but would then fault in the middle of the page due
to the MTE tag.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../selftests/arm64/mte/check_user_mem.c      | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_user_mem.c b/tools/testing/selftests/arm64/mte/check_user_mem.c
index 1de7a0abd0ae..5a5a7e1f5789 100644
--- a/tools/testing/selftests/arm64/mte/check_user_mem.c
+++ b/tools/testing/selftests/arm64/mte/check_user_mem.c
@@ -19,7 +19,8 @@
 
 static size_t page_sz;
 
-static int check_usermem_access_fault(int mem_type, int mode, int mapping)
+static int check_usermem_access_fault(int mem_type, int mode, int mapping,
+                                      int tag_offset, int tag_len)
 {
 	int fd, i, err;
 	char val = 'A';
@@ -54,10 +55,12 @@ static int check_usermem_access_fault(int mem_type, int mode, int mapping)
 	if (i < len)
 		goto usermem_acc_err;
 
-	/* Tag the next half of memory with different value */
-	ptr_next = (void *)((unsigned long)ptr + page_sz);
+	if (!tag_len)
+		tag_len = len - tag_offset;
+	/* Tag a part of memory with different value */
+	ptr_next = (void *)((unsigned long)ptr + tag_offset);
 	ptr_next = mte_insert_new_tag(ptr_next);
-	mte_set_tag_address_range(ptr_next, page_sz);
+	mte_set_tag_address_range(ptr_next, tag_len);
 
 	lseek(fd, 0, 0);
 	/* Copy from file into buffer with invalid tag */
@@ -100,14 +103,14 @@ int main(int argc, char *argv[])
 	/* Set test plan */
 	ksft_set_plan(4);
 
-	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE),
+	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE, page_sz, 0),
 		"Check memory access from kernel in sync mode, private mapping and mmap memory\n");
-	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_SYNC_ERR, MAP_SHARED),
+	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_SYNC_ERR, MAP_SHARED, page_sz, 0),
 		"Check memory access from kernel in sync mode, shared mapping and mmap memory\n");
 
-	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE),
+	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE, page_sz, 0),
 		"Check memory access from kernel in async mode, private mapping and mmap memory\n");
-	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_ASYNC_ERR, MAP_SHARED),
+	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_ASYNC_ERR, MAP_SHARED, page_sz, 0),
 		"Check memory access from kernel in async mode, shared mapping and mmap memory\n");
 
 	mte_restore_setup();
-- 
2.17.1

