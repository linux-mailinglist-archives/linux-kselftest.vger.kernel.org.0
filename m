Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7AD4AF526
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiBIPXR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 10:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbiBIPXQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 10:23:16 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454ACC05CB8F
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 07:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rFtWJxLVhYuLjiP61fT9Jzk8/FSoAfCPlO+An3ySwc=;
 b=vnujyJ6NJQ5Qi3moFlGJhZ84M4+kihDSDQW9zihgGWEj3EJr6E8c+246KGKg7mhAEmYdFycDANHlcwhbTh9whdWRJe6RnvUIdzB6cqB+9wOfO+eY51JKl+X8zIHADqqcWHtLMjus04h6nGCyGrhZYgJdUSMyTjZHH13rGewz8Wg=
Received: from AM6P193CA0053.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::30)
 by AM6PR08MB4103.eurprd08.prod.outlook.com (2603:10a6:20b:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 15:22:59 +0000
Received: from AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8e:cafe::9b) by AM6P193CA0053.outlook.office365.com
 (2603:10a6:209:8e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 15:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT046.mail.protection.outlook.com (10.152.16.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:22:59 +0000
Received: ("Tessian outbound 63bb5eb69ee8:v113"); Wed, 09 Feb 2022 15:22:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7e58cded069838b5
X-CR-MTA-TID: 64aa7808
Received: from 7e25753eca15.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5769496F-6A58-4D61-87E7-9BDDC57C399A.1;
        Wed, 09 Feb 2022 15:22:53 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7e25753eca15.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 09 Feb 2022 15:22:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJhX0R608cIjVEXRGVgRQfciptyOmVAtvffvu5Ls5qc7/+KmCFFqqyG3IZIp0Dp+F6YAWZLeXLTRraO5FaryDFNjZpj6ZN2fGcqzlZxe5Yn3FXBzn9yFTQ9JUqsYRFfw50qHoHl4bd9Z9+Tdqr4RYN5zogvOufqMXaf7kudgo0Jys3ysPupktv7E6QGPBxwCOiEwq987hvl/GY3onfhZByiqaOXnM7lHtK9Y7uN5N4WONW9f/8dM7TF5BEetLW4AtxqeGFhe9OMRMhJi5+pRyLdRgcAPCQwQVQnXrdZSJ4vjwwPl5MXsUwDxTHuinE2xj20i2I6G1BT4C/Fycwkw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rFtWJxLVhYuLjiP61fT9Jzk8/FSoAfCPlO+An3ySwc=;
 b=bfEisWYGFCGIMeqBiXlUKIBUj+D28smsy3Cbb2bf68QYGzKLNwpwdpJ+Cc+spiRrqbwfnqATCi35TTolG3qPb5pSqczqbIvg1UOFjKXLUGrp8XA33aa858X/0AbSM9LE09dkDlOj7B1bEoI9jLTbk/0cqSJxmrdUB3Ha2ysQ/whWlzG/pCWTIRWeb7BeynWtuxKoKvpVbchK4v8ffc3vvk1SomLa7sz4hMvb1o8/HytELQ5jg3KJbNSyg9/RGUh8d+tfRC705D0pL/I9+9EnAg35kBzBuLVr5xpoyzoWl5LkSygJR38fYGK9EkEoQXr1EB61qr1Oe+f3+Yn0JwPUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rFtWJxLVhYuLjiP61fT9Jzk8/FSoAfCPlO+An3ySwc=;
 b=vnujyJ6NJQ5Qi3moFlGJhZ84M4+kihDSDQW9zihgGWEj3EJr6E8c+246KGKg7mhAEmYdFycDANHlcwhbTh9whdWRJe6RnvUIdzB6cqB+9wOfO+eY51JKl+X8zIHADqqcWHtLMjus04h6nGCyGrhZYgJdUSMyTjZHH13rGewz8Wg=
Received: from AS9PR05CA0045.eurprd05.prod.outlook.com (2603:10a6:20b:489::11)
 by PR3PR08MB5609.eurprd08.prod.outlook.com (2603:10a6:102:81::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 15:22:51 +0000
Received: from AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:489:cafe::65) by AS9PR05CA0045.outlook.office365.com
 (2603:10a6:20b:489::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 15:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com;
Received: from nebula.arm.com (40.67.248.234) by
 AM5EUR03FT014.mail.protection.outlook.com (10.152.16.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:22:50 +0000
Received: from AZ-NEU-EX01.Emea.Arm.com (10.251.26.4) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 9 Feb
 2022 15:22:51 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX01.Emea.Arm.com
 (10.251.26.4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Wed, 9
 Feb 2022 15:22:46 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2308.20 via Frontend
 Transport; Wed, 9 Feb 2022 15:22:51 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kselftest@vger.kernel.org>, <nd@arm.com>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <joey.gouly@arm.com>, <shuah@kernel.org>,
        <skhan@linuxfoundation.org>, <will@kernel.org>
Subject: [PATCH v3 6/6] kselftest/arm64: mte: user_mem: test a wider range of values
Date:   Wed, 9 Feb 2022 15:22:40 +0000
Message-ID: <20220209152240.52788-7-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209152240.52788-1-joey.gouly@arm.com>
References: <20220209152240.52788-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: b1bc5bbe-b623-43b0-7b43-08d9ebe00e30
X-MS-TrafficTypeDiagnostic: PR3PR08MB5609:EE_|AM5EUR03FT046:EE_|AM6PR08MB4103:EE_
X-Microsoft-Antispam-PRVS: <AM6PR08MB4103E28994FEBBF17A8FDD0C942E9@AM6PR08MB4103.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:989;OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: FKd1cpuMxDz4udbUMdzQYeZYFfpAun7ycxLdWXBUSiHLDw62nJ1eGuPZNB4i2Zb/xRXoCeRs5ayNmywMtRcrDQpZmQ9EcWcR+u6B2NXJ5IyFDvKeoy5PxSDLBJ+qVdDdzx6SK4OedJawzp/AshHERq2aNSaqN5Ml4nu2KHIiSm/1aNl/tuz9bahwzqjVPtYhrYchU4ZxRIt5L+wxEBXkBLUu6NS0UmVojtwfzODF6n4MVyPyPJWT6eYyBGpdhYXfi7WPjZhGMMEouvC2QGHc0uEP/G8/fxf2rQCBn0DxWv5O9b/rvc+VybJgTqoF0ia0pSBLmiWv1eW/BcAVWfrL9R/hMLDUptjxcOzjRQL1OKZMNskyUUedBLRfFaU18TVfIAmgMxceNyiYxjPJsR2Y2mKXjsXhzca/zNlretP9cWxnQz7AvkanzJ/cjQ90Oc0R1WcRIhvC7eqXRiFw3Ybu7W860aAgx6/Bn3tY4yK4IpNHIbvwt+1HGLZKe33xC9Jw0LFxGlkYeXwZaAi4JZZW1WtgmQnecZslCXqIm7HL0k4AtgkEUncYhU+TE4Soh2wC0VkB7oDItN6kiUX+fx/v0CNozv5wxA7eVwHfEgHLHoTOepyhmIXNdNUMYJRAd6rffu9AEyfFOHUjN+DBQj+q6RBVbHFBbAv0EC3vFvwfy0H9xklcD1Rly28EQLWm1dRgfwj5wDOOtP1NCNFEbiyD7Q==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(5660300002)(4326008)(44832011)(508600001)(2616005)(356005)(81166007)(1076003)(26005)(8676002)(8936002)(54906003)(40460700003)(70206006)(70586007)(36756003)(2906002)(7696005)(6666004)(36860700001)(82310400004)(6916009)(316002)(186003)(83380400001)(86362001)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5609
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f3b3c1a2-c09d-49ae-2df6-08d9ebe00913
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzEfOXtDSxwLEGSS6C2IAvANBvA5UzkQToSj0ZTGum9fdQO7SqHca/pRi6k6FkRQpwiyLAUrRtBayKwOUuxQCuE/4PQvcN9/qEuNPZTdM9gYR39ptR9Y8eEWxynU3d4KSfDFPkeYwEok7Xu9l3jnezts/ZKgmkMD//YpT0IJs77u/TdBrU0DucB2N97D/vVpgeLGM3gddzlUyKK0zMhGbOeotcUZx50SFP839mlSA2Y86arGkLxJ+NSIF7nah3r1L0+sZFPeI28Lned+eTsSgqVB7LiGFk9kVs5X4XrUMGiwKyQ31NQmbyrwf4P+7zqbV/ra0US1Nr/LJcQjYKygyXzwWRS5WHITMwRTeCA6QRbthOXo5Clm1XFMCkXCPDUgVLFPXCpSWa5N8Un2qwTouX/8aRvzuvc24BtUs7h5SbPsekY6E921bedqDebHJOvRDVl7IbWCatCjFUwWzrHKLmGoY8Cf/W8etGzquG2K0/RaTADIROpjJwJKvaSHHNzSU1CWQbn1ty9aTqiySFVLuvD+cMGs8zXb7Wzp/PVPxuk/Duo+3E2JydILvqIArccbqcRC1ZnduKPH0dnqS8672VfzOi2oJdsSR785J8/dQ0mnkwcrUOzZQYLzSzsgrs24TQrPHXHt+wIdlxP2kiqcmHvnIRmMWLhYmxT7/smLIRQMe3jpAgNalcymrka/ROso
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(70586007)(426003)(1076003)(6862004)(26005)(44832011)(336012)(4326008)(83380400001)(186003)(8676002)(5660300002)(86362001)(81166007)(47076005)(54906003)(40460700003)(36756003)(8936002)(2906002)(2616005)(316002)(7696005)(6666004)(508600001)(82310400004)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 15:22:59.2114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bc5bbe-b623-43b0-7b43-08d9ebe00e30
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4103
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Instead of hard coding a small amount of tests, generate a wider
range of tests to try catch any corner cases that could show up.

These new tests test different MTE tag lengths and offsets, which
previously would have caused infinite loops in the kernel. This was
fixed by 295cf156231c ("arm64: Avoid premature usercopy failure"),
so these are regressions tests for that corner case.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../selftests/arm64/mte/check_user_mem.c      | 94 ++++++++++++++++---
 1 file changed, 83 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_user_mem.c b/tools/testing/selftests/arm64/mte/check_user_mem.c
index bb4974c437f8..f4ae5f87a3b7 100644
--- a/tools/testing/selftests/arm64/mte/check_user_mem.c
+++ b/tools/testing/selftests/arm64/mte/check_user_mem.c
@@ -3,6 +3,7 @@
 
 #define _GNU_SOURCE
 
+#include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
@@ -20,6 +21,8 @@
 
 static size_t page_sz;
 
+#define TEST_NAME_MAX 100
+
 enum test_type {
 	READ_TEST,
 	WRITE_TEST,
@@ -136,9 +139,67 @@ static int check_usermem_access_fault(int mem_type, int mode, int mapping,
 	return err;
 }
 
+void format_test_name(char* name, int name_len, int type, int sync, int map, int len, int offset) {
+	const char* test_type;
+	const char* mte_type;
+	const char* map_type;
+
+	switch (type) {
+	case READ_TEST:
+		test_type = "read";
+		break;
+	case WRITE_TEST:
+		test_type = "write";
+		break;
+	case READV_TEST:
+		test_type = "readv";
+		break;
+	case WRITEV_TEST:
+		test_type = "writev";
+		break;
+	default:
+		assert(0);
+		break;
+	}
+
+	switch (sync) {
+	case MTE_SYNC_ERR:
+		mte_type = "MTE_SYNC_ERR";
+		break;
+	case MTE_ASYNC_ERR:
+		mte_type = "MTE_ASYNC_ERR";
+		break;
+	default:
+		assert(0);
+		break;
+	}
+
+	switch (map) {
+	case MAP_SHARED:
+		map_type = "MAP_SHARED";
+		break;
+	case MAP_PRIVATE:
+		map_type = "MAP_PRIVATE";
+		break;
+	default:
+		assert(0);
+		break;
+	}
+
+	snprintf(name, name_len,
+	         "test type: %s, %s, %s, tag len: %d, tag offset: %d\n",
+	         test_type, mte_type, map_type, len, offset);
+}
+
 int main(int argc, char *argv[])
 {
 	int err;
+	int t, s, m, l, o;
+	int mte_sync[] = {MTE_SYNC_ERR, MTE_ASYNC_ERR};
+	int maps[] = {MAP_SHARED, MAP_PRIVATE};
+	int tag_lens[] = {0, MT_GRANULE_SIZE};
+	int tag_offsets[] = {page_sz, MT_GRANULE_SIZE};
+	char test_name[TEST_NAME_MAX];
 
 	page_sz = getpagesize();
 	if (!page_sz) {
@@ -153,17 +214,28 @@ int main(int argc, char *argv[])
 	mte_register_signal(SIGSEGV, mte_default_handler);
 
 	/* Set test plan */
-	ksft_set_plan(4);
-
-	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE, page_sz, 0, READ_TEST),
-		"Check memory access from kernel in sync mode, private mapping and mmap memory\n");
-	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_SYNC_ERR, MAP_SHARED, page_sz, 0, READ_TEST),
-		"Check memory access from kernel in sync mode, shared mapping and mmap memory\n");
-
-	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE, page_sz, 0, READ_TEST),
-		"Check memory access from kernel in async mode, private mapping and mmap memory\n");
-	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_ASYNC_ERR, MAP_SHARED, page_sz, 0, READ_TEST),
-		"Check memory access from kernel in async mode, shared mapping and mmap memory\n");
+	ksft_set_plan(64);
+
+	for (t = 0; t < LAST_TEST; t++) {
+		for (s = 0; s < ARRAY_SIZE(mte_sync); s++) {
+			for (m = 0; m < ARRAY_SIZE(maps); m++) {
+				for (l = 0; l < ARRAY_SIZE(tag_lens); l++) {
+					for (o = 0; o < ARRAY_SIZE(tag_offsets); o++) {
+						int sync = mte_sync[s];
+						int map = maps[m];
+						int offset = tag_offsets[o];
+						int tag_len = tag_lens[l];
+						int res = check_usermem_access_fault(USE_MMAP, sync,
+						                                     map, offset,
+						                                     tag_len, t);
+						format_test_name(test_name, TEST_NAME_MAX,
+						                 t, sync, map, tag_len, offset);
+						evaluate_test(res, test_name);
+					}
+				}
+			}
+		}
+	}
 
 	mte_restore_setup();
 	ksft_print_cnts();
-- 
2.17.1

