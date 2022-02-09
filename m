Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122904AF51C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 16:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbiBIPXB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 10:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiBIPXA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 10:23:00 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140049.outbound.protection.outlook.com [40.107.14.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7A3C05CB89
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 07:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnQ2a7+r9tAcGqJnhjaZ6Xuq0tSBsq/+9bztvJcnbak=;
 b=eofYRzQ8pZPRoLcovHKuWmM43dwWP/YPRK3RigWkAq3Wk16ZnUwY0eK4/D85IVb+hrN6EnaMohmMY0908M8lYoadjK1n+O/VGuN2GIDMKvF3yrGnCRb4KFUKBPrDlqZSYwiTNlu9mgCkJ4BGETWb9WT7TSmhP6+e9tJRMgHO3CQ=
Received: from AS9PR06CA0288.eurprd06.prod.outlook.com (2603:10a6:20b:45a::19)
 by VI1PR08MB5309.eurprd08.prod.outlook.com (2603:10a6:803:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 15:22:57 +0000
Received: from AM5EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:45a:cafe::c7) by AS9PR06CA0288.outlook.office365.com
 (2603:10a6:20b:45a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Wed, 9 Feb 2022 15:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT041.mail.protection.outlook.com (10.152.17.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:22:57 +0000
Received: ("Tessian outbound 2877e54fe176:v113"); Wed, 09 Feb 2022 15:22:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 75ed4d2460b9115f
X-CR-MTA-TID: 64aa7808
Received: from e8c803774e21.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2CF22B2F-50B4-4D32-9119-613B9F1D3A2B.1;
        Wed, 09 Feb 2022 15:22:50 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e8c803774e21.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 09 Feb 2022 15:22:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3nbLnrTuFifHqkNQp+8qMLhd67RK0C88qnvhvesaLDxaX4LD3TvmBm3rn8jCcFtfpu8FaUoXKaquvk0J7vtwH77dc8PAPIXp4H3aRExHXLUyNyMMKPNnSV4HnLaiM4gLJOu+YvfqDKwYvoxAp3K5pT0t4WERidiCZbaoyDWEAvUGBw+O54FzopBg+j6HeWBxWlqURx+lWXR8PmDmf3wKzKSMgE67jxtQxCpsAjGvtbJpANhmhvcAkUMSmnJ6pnbD4Da6AEzJJmV+l1F1q7nZFqFx8LZTIvXtQtJ+tIt3Hq0fuxBg06vwb8YBS7MO5/h2mU4bB5wZ8aAJIztchCv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnQ2a7+r9tAcGqJnhjaZ6Xuq0tSBsq/+9bztvJcnbak=;
 b=RWcryQWprqEXhYYkdVja/S4RV7+5JxPgMQs2VjR/Gf1r2hYdrckCrE12Rb0ZzUF9RoBcqkQxJD4O6RAE9odlQWMepHwcau2wtsnN5kVjth5P/ShVbVZqamrs89/iHg2tyccm+OxTLfhwZ87Uuj6nRJ9ls6WxtHMAubEaAzaexJaCghf5qr9SfV8fs01uvYt8fOEqmcAxifmQuaI5mm2MAOsWHQznlFoLWjdN2whVnUMxcUUIauB0WfgJM/vuTU7/31JHF09Q6xvnk/xZN51/1PYwiv483Yh14xQPdyEk6VrCRs8VGjuFbV0PqYlNz3gmr1AAIzo/ewfERjnN/CgsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnQ2a7+r9tAcGqJnhjaZ6Xuq0tSBsq/+9bztvJcnbak=;
 b=eofYRzQ8pZPRoLcovHKuWmM43dwWP/YPRK3RigWkAq3Wk16ZnUwY0eK4/D85IVb+hrN6EnaMohmMY0908M8lYoadjK1n+O/VGuN2GIDMKvF3yrGnCRb4KFUKBPrDlqZSYwiTNlu9mgCkJ4BGETWb9WT7TSmhP6+e9tJRMgHO3CQ=
Received: from AS9PR05CA0032.eurprd05.prod.outlook.com (2603:10a6:20b:489::30)
 by VE1PR08MB5055.eurprd08.prod.outlook.com (2603:10a6:803:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 15:22:48 +0000
Received: from AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:489:cafe::25) by AS9PR05CA0032.outlook.office365.com
 (2603:10a6:20b:489::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 9 Feb 2022 15:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com;
Received: from nebula.arm.com (40.67.248.234) by
 AM5EUR03FT014.mail.protection.outlook.com (10.152.16.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:22:47 +0000
Received: from AZ-NEU-EX01.Emea.Arm.com (10.251.26.4) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 9 Feb
 2022 15:22:50 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX01.Emea.Arm.com
 (10.251.26.4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Wed, 9
 Feb 2022 15:22:45 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2308.20 via Frontend
 Transport; Wed, 9 Feb 2022 15:22:49 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kselftest@vger.kernel.org>, <nd@arm.com>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <joey.gouly@arm.com>, <shuah@kernel.org>,
        <skhan@linuxfoundation.org>, <will@kernel.org>
Subject: [PATCH v3 2/6] kselftest/arm64: mte: user_mem: rework error handling
Date:   Wed, 9 Feb 2022 15:22:36 +0000
Message-ID: <20220209152240.52788-3-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209152240.52788-1-joey.gouly@arm.com>
References: <20220209152240.52788-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: cbf42059-4bd7-46fd-5670-08d9ebe00d09
X-MS-TrafficTypeDiagnostic: VE1PR08MB5055:EE_|AM5EUR03FT041:EE_|VI1PR08MB5309:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB53092093E62832DA5E633D82942E9@VI1PR08MB5309.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: r7GR9BleRN2DP3GHnld5guZfhnmjnyUx33yq7ljHD2pMc8MKKFCiHx8bdQzPs/6+xmeWwVE/FfAfN0nAK3iF2wgDM82/APa3d3nzlnt5sOQeZP8WJHW/+Ip1RIS3kGtFU6D8xyGfzXylZFCWToOHvFfjMdMrLyReKrwSv52uZ2H5SjXWC2EDNXt8B5Jf9IrmT6WunIB5DcRs0iTvbu1wCIhdxkzN6x1pa+V1ht9c7VO8hCan8SwaeJEsq2J8Hy2VZrSAVO0E0EZsKIPdgurMSUo4ujxDAMWNWlBy5LnWfIqZIowdXEFsQvt1sRMWYj352GbsrKO7lhQj9wqVKhGEMFurSCWPcKHIkyGqojWLsbI3zYzMsCQ/by1eHz3KSG2MG+BPq+fmPtF6aiabwj8KkRMx92edUoJh5aAikvxWuun21sv4sdXVjdUmdND/O/r6MTjOkrzVrYWFbkriH+rH8aPDJjh8FYmQ5azBQpBY9D/ngvp3MxqhARAouB2Xkzr0Cn8FtHP4olmY/VWtPQeedlwLxQCc+unlYnBQkVyS7HNUSVXLJN19lumhAW8nc5ZrymY8zxScn8lPLLWlyOYcN147nIl7P0NtOi4ZxBxqZSw8TJY4GL5x3bJlohHv0We/S/mP0iL5UPhljFeJGOz88cu5ExiguhMIdShHpGaOkbha5vhHPuJhwBzc9zLCHdAHfmvwuQRg9qRg/xPYvy5ibA==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(1076003)(47076005)(356005)(81166007)(6666004)(70206006)(7696005)(83380400001)(70586007)(44832011)(5660300002)(2906002)(86362001)(316002)(4326008)(8936002)(336012)(508600001)(40460700003)(426003)(54906003)(26005)(186003)(82310400004)(36860700001)(6916009)(8676002)(2616005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5055
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 33631bb3-2ebc-485b-9d7f-08d9ebe00731
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfsldFbK0EM8+WLoqZF4Hjz7PjSn6ajgTzSb9xX4NmAfFauqpAbtQ7UxiG7+raXtKpbff0OkqnJx/B3NdF65SPxRrdib7oZeyVCmrXwupW7Mk0Ouh0nt6Qz1eVf50rUFOqMggRt6S9ykbkRc0Bm4LnRaKgYYabWBvKcrTAAcC2OVKseJdp9HwKjmYPjx0TVtfcKd9ZNbvAsN4v51Oc2ra8StpuCJylH9iZN6rlJpKYrMDEpFre70CTPDgqs7JbA4VnmouveQyHsZxW2/Yd1HtmP+iBkIWMRjGBhG5f1svHGvebFtt+HJHl9oEdqckTI2of662xppNSNImV48eqhNsxB4nJ9l5cgYmBDPFS6P9w1Q/M/jmyvM/EaK+Le9KwmI6EkLmkTVup93Oeqkj88gSjXDMqJap2zv9ZRfHDUkwpkKMB0+LJmHtgtUMZJO1TU2fVJepGID8qhLf09fdE3rqhaeJ848OrEzXn5eNT5WCYgNisXKLuT9t3U2nzPZqErM8boeAEgXSxyjSccaCDNxfD31gUgBorBrHSAr7ycz8LOHw724Ug0uY7P941vIRo3xCHesOXPTTlkXlabhHGUhEBneuffYZfhKkzZfv7tORhm72Kmera9TuxCn6IQLXnKGVDf73p3jKAZ//xopfUjSF1YIhlsMt+hGZf7Gj7CfedoK5T2Y2B4dOKfm8OLhnu2y
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(1076003)(83380400001)(4326008)(44832011)(54906003)(36860700001)(336012)(70586007)(81166007)(316002)(426003)(26005)(86362001)(40460700003)(186003)(47076005)(2906002)(7696005)(6666004)(6862004)(8676002)(2616005)(8936002)(508600001)(36756003)(82310400004)(5660300002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 15:22:57.1365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf42059-4bd7-46fd-5670-08d9ebe00d09
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5309
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Future commits will have multiple iterations of tests in this function,
so make the error handling assume it will pass and then bail out if there
is an error.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../selftests/arm64/mte/check_user_mem.c      | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_user_mem.c b/tools/testing/selftests/arm64/mte/check_user_mem.c
index 5a5a7e1f5789..2afcc9fb9ae8 100644
--- a/tools/testing/selftests/arm64/mte/check_user_mem.c
+++ b/tools/testing/selftests/arm64/mte/check_user_mem.c
@@ -27,7 +27,7 @@ static int check_usermem_access_fault(int mem_type, int mode, int mapping,
 	size_t len, read_len;
 	void *ptr, *ptr_next;
 
-	err = KSFT_FAIL;
+	err = KSFT_PASS;
 	len = 2 * page_sz;
 	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
 	fd = create_temp_file();
@@ -71,14 +71,22 @@ static int check_usermem_access_fault(int mem_type, int mode, int mapping,
 	 * mode without fault but may not fail in async mode as per the
 	 * implemented MTE userspace support in Arm64 kernel.
 	 */
-	if (mode == MTE_SYNC_ERR &&
-	    !cur_mte_cxt.fault_valid && read_len < len) {
-		err = KSFT_PASS;
-	} else if (mode == MTE_ASYNC_ERR &&
-		   !cur_mte_cxt.fault_valid && read_len == len) {
-		err = KSFT_PASS;
+	if (cur_mte_cxt.fault_valid)
+		goto usermem_acc_err;
+
+	if (mode == MTE_SYNC_ERR && read_len < len) {
+		/* test passed */
+	} else if (mode == MTE_ASYNC_ERR && read_len == len) {
+		/* test passed */
+	} else {
+		goto usermem_acc_err;
 	}
+
+	goto exit;
+
 usermem_acc_err:
+	err = KSFT_FAIL;
+exit:
 	mte_free_memory((void *)ptr, len, mem_type, true);
 	close(fd);
 	return err;
-- 
2.17.1

