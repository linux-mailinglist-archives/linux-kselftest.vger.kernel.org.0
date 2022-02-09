Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09BE4AF528
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiBIPXe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 10:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiBIPX1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 10:23:27 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70059.outbound.protection.outlook.com [40.107.7.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8FEC05CB90
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 07:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk8UCdrCbfHrikHsK0eP/ECI2A9aeI8O1MImQnAZT2c=;
 b=sgaam0UTxXxWfEGrukZGN2qYudMkdhvbpPagnHIDx1h3KQLI6A848sLoZilDe5HES96TeOUzbPPnF8mi6OQlK8qtbwqpSfrwBRfSXi4yvrYB8eL5AJVSwpVHb2+AeQx+JSRillBwvIle7OHzFXg7oF2uF9OVsPdv9qH8a49Gfhc=
Received: from AM5PR0601CA0076.eurprd06.prod.outlook.com (2603:10a6:206::41)
 by VI1PR08MB4336.eurprd08.prod.outlook.com (2603:10a6:803:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Wed, 9 Feb
 2022 15:23:23 +0000
Received: from VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:0:cafe::cf) by AM5PR0601CA0076.outlook.office365.com
 (2603:10a6:206::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 15:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT062.mail.protection.outlook.com (10.152.18.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:23:22 +0000
Received: ("Tessian outbound 741ca6c82739:v113"); Wed, 09 Feb 2022 15:23:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 12beb7a43d10e576
X-CR-MTA-TID: 64aa7808
Received: from f12f5f16e401.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9F163494-A6BE-442E-97BD-2562E1D2019B.1;
        Wed, 09 Feb 2022 15:23:16 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f12f5f16e401.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 09 Feb 2022 15:23:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkNtA6agkJM4K0obZHZchmiRIowMFGKh8sYQSxSHmhLCHi058Wvl6CpAHFvszuIWt82BpAOyVQ0r9F9PnXLE9Jf0k1BYlSmuJLU6fXhzs9EwlKxeqHWuGlFiJ1YVx2psSKVrBpg/efKg47D9730ctYnizuJPtSGrh2CoI9TxO4cfUsM+ssgVheIwUM341C/cHe6QODMxcz3O3NEvN6nJlAKbW2p6pT8JvyhoZ0hMrvfXK1UwYodJHavVJDC6/aJ6/wklk79aPrYpVVblpSAj3WvndHs8vZIYLi8pkVc57oNhqP2xtnM/8j8XdgFY2kwZlYqYdKHEZ6rIU4hbFgKxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mk8UCdrCbfHrikHsK0eP/ECI2A9aeI8O1MImQnAZT2c=;
 b=bPASvwMi58DGrnVPlJJlZVmg8QDrRhjDKwVtEpPaKK7/w1ihoadvsgF/irsdicEX5wRitFjTgI2M5WUsY15XpKMxIauadenK/JNppSBbsiLYB3/egR0Ek3ULceX6rhxAMxfDIrsSWulqdzk/ySOnQF9OKd9XtPR6+3K1b8DknjuPjWtLPLBV408ypoqDpdC6FgudpNSrROvaEYFLu3DUrypkGta5eZ6PIRL3XmNgLlEHkGowLybdewuJdHTP0vTLM24HiwoqCUzxsnYF5sCLM6fxXQ7YzA5TfmRH7fFm7ytrPFNZ0McSupQWYVEb0tkvhUAWgt5rtyT6xtq+Z6kz3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk8UCdrCbfHrikHsK0eP/ECI2A9aeI8O1MImQnAZT2c=;
 b=sgaam0UTxXxWfEGrukZGN2qYudMkdhvbpPagnHIDx1h3KQLI6A848sLoZilDe5HES96TeOUzbPPnF8mi6OQlK8qtbwqpSfrwBRfSXi4yvrYB8eL5AJVSwpVHb2+AeQx+JSRillBwvIle7OHzFXg7oF2uF9OVsPdv9qH8a49Gfhc=
Received: from AM6P194CA0040.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::17)
 by AS8PR08MB6679.eurprd08.prod.outlook.com (2603:10a6:20b:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 15:23:14 +0000
Received: from AM5EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:84:cafe::a) by AM6P194CA0040.outlook.office365.com
 (2603:10a6:209:84::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 15:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com;
Received: from nebula.arm.com (40.67.248.234) by
 AM5EUR03FT022.mail.protection.outlook.com (10.152.16.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:23:14 +0000
Received: from AZ-NEU-EX01.Emea.Arm.com (10.251.26.4) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 9 Feb
 2022 15:22:50 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX01.Emea.Arm.com
 (10.251.26.4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Wed, 9
 Feb 2022 15:22:46 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2308.20 via Frontend
 Transport; Wed, 9 Feb 2022 15:22:50 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kselftest@vger.kernel.org>, <nd@arm.com>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <joey.gouly@arm.com>, <shuah@kernel.org>,
        <skhan@linuxfoundation.org>, <will@kernel.org>
Subject: [PATCH v3 4/6] kselftest/arm64: mte: user_mem: add test type enum
Date:   Wed, 9 Feb 2022 15:22:38 +0000
Message-ID: <20220209152240.52788-5-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209152240.52788-1-joey.gouly@arm.com>
References: <20220209152240.52788-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: a2b2c379-afc3-4b7c-37c1-08d9ebe01c4c
X-MS-TrafficTypeDiagnostic: AS8PR08MB6679:EE_|VE1EUR03FT062:EE_|VI1PR08MB4336:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB43368841E95B2BE618E8FEA0942E9@VI1PR08MB4336.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: XByxhaBfo3gIfeLXZ/Zf74jNW1t/y+ITSY4yb6Y49DqypKxdd3i1ZtPYYglKalsXMhEiYXHcx0us7n4KY1M1rLIyofS071nqyYcaEt5/6Bbj3tMVcRcwvU0itgHEkHWdwEtDPK6YpLU9Xwo1T5GofIbaUXJNa0bmsHs7VFi8oO8N10ELb7IuCv4jJd1w1llTBWHrGWM05jASQA4VN+/0NHp7HE6Q0xzEP1XU4O4ckl5DXyRrq4qWODBEjp+IOTXCmW0oBgLCxjqihsJzTir884VRgMFV4rPENebRgLA4W4kJ73cQxwfcR/YPGkFPSgSl1VPgqrB77AUXyKjpP74HnEUdYq9z0jZ7LSRP6E7kmiFhhdsFUPFrT4mcNDiIuRaItmyQxDqjBL5jRuXRbgV+VoeHNiI/5oGEgx2YMyU6O6xEhYjokmzvr3mZ6ofL/uMz7HmAzyYQliV9tjvmaebB3xyVE2W8JgrWtW+DGNsN0Ra8Ujx8nA4hpoxc6Zj0W0+tFuffvOYKP+sPcWZDSf1jEspPSmvy7ClIb/wkzzQ7u3q1Q4QZIbbu3/hP+pCmA03AL12bJcidzxEQ+DBwSxJvBIpGBBLHJRFROA2YBiT8sxmW8tYgCvi+5drnNRsFWni8hno/v50CzkDGJ13ze1z/2GdQhiqJtT6sYqjOxdLkew0Ij4uxOe+FiM2/Css9+WKWBAu+JtFzZqrWPHhhYbXVxA==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(36756003)(336012)(36860700001)(5660300002)(82310400004)(426003)(316002)(7696005)(508600001)(6666004)(83380400001)(86362001)(47076005)(186003)(26005)(40460700003)(8676002)(2616005)(8936002)(70206006)(44832011)(2906002)(70586007)(81166007)(54906003)(6916009)(4326008)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6679
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c1c813a8-800a-4036-bb4d-08d9ebe01707
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xmf3gTGjuH3zgkLrfO65nKVAUcVNNS2a5p6LhrgzUHIV3xcLCCYS/Dn+gdZ0YWII9HzT6F3LNb4ScOUBx4SRfeQ9OQpNYo39D4J7xlc6JIzW0UgqyXxMtJLL4C7K4b9RMuDhLq06aqQbuc7W/KkIjJyvr7DV7G75hDnYy4wLaLOc2pQt+xIoPc9I2SsWlMK8eSKRMPslfw550v7dzFAWMhbQYXeSY6jk4ARFurcRFh8tnR0gImIDJDrVETXUg9l/xTYeZHfBpupoDeZu772SO3+DUgTofn2uMptF2UGu3iqLV8vq/oPPkwTInXcaHre6tZD6vmkZzoJUZVqYCtlEEU22dNNneyTS1zh5UqRih8Yhbv1uk/Y6A52v0vAJ3AWC6X8VKL5jkf8Edii3fYtdBXSGNtzSV2NvZWyLvO74ZRqxpIX5cGzGmZmanyrnqal8Ni0rFtnmd93XBSw+KyqF6ZS9cObbEzAcoBv+E65XjaG9TI16YZJJBeeILkqEMxoOsrhn2SnMa+YDi92xAg2PMGrTlB1G34cbMBemPKkVDqnHdt53qX0h6oa4SNNIIv5Zl1qmTe/7tTT7+wRm59NgeGNJ/FUS4ZsXpjkZLQYfv17kASJo4GcxvXPTEYbaKN3KKMXpN0M1WEZbd/+01BkzfnW0KakgW0yTQYPDGxDhqs=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(86362001)(2616005)(70586007)(7696005)(82310400004)(40460700003)(508600001)(36860700001)(5660300002)(54906003)(8676002)(47076005)(70206006)(6862004)(8936002)(316002)(1076003)(44832011)(83380400001)(36756003)(26005)(426003)(4326008)(81166007)(336012)(186003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 15:23:22.8526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b2c379-afc3-4b7c-37c1-08d9ebe01c4c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4336
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test is currently hardcoded to use the `read` syscall, this commit adds
a test_type enum to support expanding the test coverage to other syscalls.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../selftests/arm64/mte/check_user_mem.c      | 38 +++++++++++++------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_user_mem.c b/tools/testing/selftests/arm64/mte/check_user_mem.c
index 89c861ee68fa..58b1b272ca80 100644
--- a/tools/testing/selftests/arm64/mte/check_user_mem.c
+++ b/tools/testing/selftests/arm64/mte/check_user_mem.c
@@ -19,12 +19,18 @@
 
 static size_t page_sz;
 
+enum test_type {
+	READ_TEST,
+	LAST_TEST,
+};
+
 static int check_usermem_access_fault(int mem_type, int mode, int mapping,
-                                      int tag_offset, int tag_len)
+                                      int tag_offset, int tag_len,
+                                      enum test_type test_type)
 {
 	int fd, i, err;
 	char val = 'A';
-	size_t len, read_len;
+	ssize_t len, syscall_len;
 	void *ptr, *ptr_next;
 	int fileoff, ptroff, size;
 	int sizes[] = {1, 2, 3, 8, 16, 32, 4096, page_sz};
@@ -46,9 +52,9 @@ static int check_usermem_access_fault(int mem_type, int mode, int mapping,
 	}
 	mte_initialize_current_context(mode, (uintptr_t)ptr, len);
 	/* Copy from file into buffer with valid tag */
-	read_len = read(fd, ptr, len);
+	syscall_len = read(fd, ptr, len);
 	mte_wait_after_trig();
-	if (cur_mte_cxt.fault_valid || read_len < len)
+	if (cur_mte_cxt.fault_valid || syscall_len < len)
 		goto usermem_acc_err;
 	/* Verify same pattern is read */
 	for (i = 0; i < len; i++)
@@ -69,8 +75,16 @@ static int check_usermem_access_fault(int mem_type, int mode, int mapping,
 			for (i = 0; i < ARRAY_SIZE(sizes); i++) {
 				size = sizes[i];
 				lseek(fd, 0, 0);
-				/* Copy from file into buffer with invalid tag */
-				read_len = read(fd, ptr + ptroff, size);
+
+				/* perform file operation on buffer with invalid tag */
+				switch (test_type) {
+				case READ_TEST:
+					syscall_len = read(fd, ptr + ptroff, size);
+					break;
+				case LAST_TEST:
+					goto usermem_acc_err;
+				}
+
 				mte_wait_after_trig();
 				/*
 				 * Accessing user memory in kernel with invalid tag should fail in sync
@@ -80,9 +94,9 @@ static int check_usermem_access_fault(int mem_type, int mode, int mapping,
 				if (cur_mte_cxt.fault_valid) {
 					goto usermem_acc_err;
 				}
-				if (mode == MTE_SYNC_ERR && read_len < len) {
+				if (mode == MTE_SYNC_ERR && syscall_len < len) {
 					/* test passed */
-				} else if (mode == MTE_ASYNC_ERR && read_len == size) {
+				} else if (mode == MTE_ASYNC_ERR && syscall_len == size) {
 					/* test passed */
 				} else {
 					goto usermem_acc_err;
@@ -120,14 +134,14 @@ int main(int argc, char *argv[])
 	/* Set test plan */
 	ksft_set_plan(4);
 
-	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE, page_sz, 0),
+	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE, page_sz, 0, READ_TEST),
 		"Check memory access from kernel in sync mode, private mapping and mmap memory\n");
-	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_SYNC_ERR, MAP_SHARED, page_sz, 0),
+	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_SYNC_ERR, MAP_SHARED, page_sz, 0, READ_TEST),
 		"Check memory access from kernel in sync mode, shared mapping and mmap memory\n");
 
-	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE, page_sz, 0),
+	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE, page_sz, 0, READ_TEST),
 		"Check memory access from kernel in async mode, private mapping and mmap memory\n");
-	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_ASYNC_ERR, MAP_SHARED, page_sz, 0),
+	evaluate_test(check_usermem_access_fault(USE_MMAP, MTE_ASYNC_ERR, MAP_SHARED, page_sz, 0, READ_TEST),
 		"Check memory access from kernel in async mode, shared mapping and mmap memory\n");
 
 	mte_restore_setup();
-- 
2.17.1

