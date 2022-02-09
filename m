Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6BF4AF525
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 16:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiBIPXR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 10:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbiBIPXG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 10:23:06 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60086.outbound.protection.outlook.com [40.107.6.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1315FC05CB82
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 07:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zrFR/5yfryMYPJxbnasHVRAHNFbLp4MPEyNkzpxB0U=;
 b=3lyo/kg5MdO5OvqXUYJYOueq3dPsLYDmvEdrvllLkCFf84THD8Idc86djq78w3ql9L1LjvW5urrba82HeP4nyNmRWtZuMiq+sEpTUuEzi22etWS0q1tTSv1w7j1di1hlccZKPMZZpRMqp3FkgQ0IFZ/w4TmsTvFcPw4XF4h/CO4=
Received: from DB6PR0301CA0044.eurprd03.prod.outlook.com (2603:10a6:4:54::12)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 15:23:06 +0000
Received: from DB5EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:54:cafe::e) by DB6PR0301CA0044.outlook.office365.com
 (2603:10a6:4:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 15:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT050.mail.protection.outlook.com (10.152.21.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:23:06 +0000
Received: ("Tessian outbound 741ca6c82739:v113"); Wed, 09 Feb 2022 15:23:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3e56b5aebf36f51a
X-CR-MTA-TID: 64aa7808
Received: from f8e88ca1b39e.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4A2C5390-15E0-4B9E-8DA4-E09E9902D79D.1;
        Wed, 09 Feb 2022 15:22:59 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f8e88ca1b39e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 09 Feb 2022 15:22:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kULLDDWYzFWET/+u64l+1EF6wq/s6gF9bYPVrC7QeEjoXsryiUyo50ei/QEHgQXnlYRrUzcw1+7pRYqlezFWgDNa0hiizQxPwUkuCFJM7BTyrAqCMxZmUxhkK/DYXtq8FyR4zGUN4T/M7Wnd4E+grXVP2QDPF/5EXtoX4krlpDX7kaE5JQ/eI3o+oNZOXCisZb01CKdm75Z9STRcOVIuaG4TIOPrF4HObZEWvozXCk0vLXA3E6otPmpABVCPC7ALr79rTEAuhUH4I5ej7vMBewYf2gcvx6yA78+JQAO99BZuPzjpK+Sx4D9RyrukftLn69XE+v4e3+YyvW94i4g+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zrFR/5yfryMYPJxbnasHVRAHNFbLp4MPEyNkzpxB0U=;
 b=lXedgpTgZ2WI7fok7vb/8pv9JsJbMa453ifpsOXE1VAYbhzfh+A08kC/CplaVlFUxzizD76ITj/Smu5teEdrCXptNVwV6tHZOBYntwARoDzmR/7D5iKyi9STH1uv/CyD9ixpqN4bvc4Q6qQU1V2HIHGJNShQHlhCCa0uAp8bv/wfDKrXGRDbvUR3/l0Q5seh/6Vuv/JiwkUR2UC3+wT3wcREwelYhqlCIeqgxFLbs3o5O8PZO59vsDP35y2FjJfPFdPIE8jHNfUZF0YcAtGzEvyV+J+QRwsrZotknBuzRgA3nNU02JvPqqtITMqUdFAD3v4HRCG6VJOBGgsYv7vODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zrFR/5yfryMYPJxbnasHVRAHNFbLp4MPEyNkzpxB0U=;
 b=3lyo/kg5MdO5OvqXUYJYOueq3dPsLYDmvEdrvllLkCFf84THD8Idc86djq78w3ql9L1LjvW5urrba82HeP4nyNmRWtZuMiq+sEpTUuEzi22etWS0q1tTSv1w7j1di1hlccZKPMZZpRMqp3FkgQ0IFZ/w4TmsTvFcPw4XF4h/CO4=
Received: from AM6PR02CA0019.eurprd02.prod.outlook.com (2603:10a6:20b:6e::32)
 by HE1PR08MB2923.eurprd08.prod.outlook.com (2603:10a6:7:2b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 15:22:56 +0000
Received: from AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:6e:cafe::9b) by AM6PR02CA0019.outlook.office365.com
 (2603:10a6:20b:6e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 9 Feb 2022 15:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com;
Received: from nebula.arm.com (40.67.248.234) by
 AM5EUR03FT015.mail.protection.outlook.com (10.152.16.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:22:56 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 9 Feb
 2022 15:22:50 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2308.20 via Frontend
 Transport; Wed, 9 Feb 2022 15:22:50 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kselftest@vger.kernel.org>, <nd@arm.com>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <joey.gouly@arm.com>, <shuah@kernel.org>,
        <skhan@linuxfoundation.org>, <will@kernel.org>
Subject: [PATCH v3 3/6] kselftest/arm64: mte: user_mem: check different offsets and sizes
Date:   Wed, 9 Feb 2022 15:22:37 +0000
Message-ID: <20220209152240.52788-4-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209152240.52788-1-joey.gouly@arm.com>
References: <20220209152240.52788-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: fba8ddbc-37ee-4501-c37b-08d9ebe01277
X-MS-TrafficTypeDiagnostic: HE1PR08MB2923:EE_|DB5EUR03FT050:EE_|AM7PR08MB5336:EE_
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336AE919D77FB94FBC928B7942E9@AM7PR08MB5336.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: npbCxEm940+s0nO0Yy20R2gIFzzkgkmDWxhKvmeulZeADWS52IgTpYgSFFxfAo8zuoQFmyl0H1lbwPXY+YRMjjERkmDFpOYtgoUWHEjDcm8HqfdTx7clALB1OnaBEpG+77CaXWrGUiF55udpPNEwkfZDpTj++52LPEwLzHpmHVYIKrFqiyJLlZWtN1MooWXkerMg1CNvAEaLcF+F1GacgXbF8rZTDOfEwEMNXnQKPfgzDuDnMq4LMrxQCb2DmDy6c0I42bTRYzByi2ozrMM+MvyNsWPoQ+fySt/S5JoPf45BJ/Xds9gJ+pf0Eoq0u0hdnCWpSmHNiWNQz8gCjJMkHLFsAW4XLaptqKQAt8AIutzeNnwujFpc1u+2QK9URdODQjdWFLXYjjHCTsiva8TjgpY2+Ku1QlU7okAl0KVP9yLMs0fdZiub1ECDZ4qOSJIhhwutfEfqT2wDBYjV97cdnI2+ruUGNXZk2nR2ImLdKt+dwf/diEJ3m2k47o6dc2eSl9BXxoYE7m9WICDi0dPm0DEZdgFrX5jHxqgQz3Ti+sG7DkyygsD729AmytjGjTcvT9rhIS/4swGPqgn2SfrI1hnG9W4ZZPJYbO0zB4+njq6ZlsSrcALqI7fuGVKJTef6GDbG8mWkMVWoUBHLKU3+KYWAUXPqbYKGXc/fYmiRgpY0zPIj4wKKpvGdsLqwxU5zaTkubqB13Uk0L+dCLgJZNg==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(26005)(4326008)(8936002)(8676002)(86362001)(1076003)(336012)(426003)(70206006)(70586007)(6916009)(82310400004)(54906003)(186003)(316002)(81166007)(7696005)(2906002)(6666004)(47076005)(356005)(2616005)(36756003)(40460700003)(83380400001)(44832011)(508600001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2923
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7d558006-94ad-406a-bc63-08d9ebe00c56
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h20I9oZADYxINUNI/6c7tabyptat5CNGR+RtdNi+wvTL1VsMI4KdFVD8xvodxeLzLefHMUgPyA0hmntzrZJBbketA5avIssOPz/RdrHxXZlWwAXs9UIrJr7YyB5IxcUPqRJZc+Io7FHRaXNCgx/wUte4ffZW/K6nbKzRXZuO8lMV02Bhml4C3sFWOB4ZQaRPfYmgtB91qw5g2yok4yn88AFW1ns0jTeG060R7mW0vROrEA271GBD2eCxwA0P3GxB5PEzSEgh17IEA0yXGuh0r++aUMLObl2UvdGieme7MYiAyxxiD1Uq5V9rf1HhdpPSsu3TRY84PM/yiW0qzmrAV32M4zdT2CBGgI0eztbNG26qtfzeEaHmf6qINyyy1s2nIgc/Xc2mPRDkfcDWcvl6qC18Fy5Eh3HyPiXFmyXOAWkck5K24nBQ7/KR9cbvyPum4YBZkZ43KoSFjA7a1PIcZ1z2lHfdTff3+c7KYD35WqdS6sCmL2jGsYP0hR7KGVH5lrzMJq/Deqet+V6xEQ7F7eTwIqy8er7tKK4hAG3kZgWa/Px84hUiYPFlh12VQW80moHZ+gULB8KlRk0sOBEVdakrjSAov34O1KaAHkx0F+q+UuPZzLp534NLnvtektcJ/tT3N6tQVnzr/BhkdTWmXniRMoeez0lcgx2xRbgsTVV6dd/caZPqhSQm3AgwxKda
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(8936002)(2616005)(36756003)(7696005)(36860700001)(47076005)(316002)(40460700003)(6666004)(508600001)(1076003)(8676002)(83380400001)(86362001)(426003)(336012)(82310400004)(70206006)(4326008)(6862004)(186003)(70586007)(26005)(44832011)(2906002)(81166007)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 15:23:06.4596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba8ddbc-37ee-4501-c37b-08d9ebe01277
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To check there are no assumptions in the kernel about buffer sizes or alignments of
user space pointers, expand the test to cover different sizes and offsets.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../selftests/arm64/mte/check_user_mem.c      | 45 +++++++++++--------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_user_mem.c b/tools/testing/selftests/arm64/mte/check_user_mem.c
index 2afcc9fb9ae8..89c861ee68fa 100644
--- a/tools/testing/selftests/arm64/mte/check_user_mem.c
+++ b/tools/testing/selftests/arm64/mte/check_user_mem.c
@@ -26,6 +26,8 @@ static int check_usermem_access_fault(int mem_type, int mode, int mapping,
 	char val = 'A';
 	size_t len, read_len;
 	void *ptr, *ptr_next;
+	int fileoff, ptroff, size;
+	int sizes[] = {1, 2, 3, 8, 16, 32, 4096, page_sz};
 
 	err = KSFT_PASS;
 	len = 2 * page_sz;
@@ -62,24 +64,31 @@ static int check_usermem_access_fault(int mem_type, int mode, int mapping,
 	ptr_next = mte_insert_new_tag(ptr_next);
 	mte_set_tag_address_range(ptr_next, tag_len);
 
-	lseek(fd, 0, 0);
-	/* Copy from file into buffer with invalid tag */
-	read_len = read(fd, ptr, len);
-	mte_wait_after_trig();
-	/*
-	 * Accessing user memory in kernel with invalid tag should fail in sync
-	 * mode without fault but may not fail in async mode as per the
-	 * implemented MTE userspace support in Arm64 kernel.
-	 */
-	if (cur_mte_cxt.fault_valid)
-		goto usermem_acc_err;
-
-	if (mode == MTE_SYNC_ERR && read_len < len) {
-		/* test passed */
-	} else if (mode == MTE_ASYNC_ERR && read_len == len) {
-		/* test passed */
-	} else {
-		goto usermem_acc_err;
+	for (fileoff = 0; fileoff < 16; fileoff++) {
+		for (ptroff = 0; ptroff < 16; ptroff++) {
+			for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+				size = sizes[i];
+				lseek(fd, 0, 0);
+				/* Copy from file into buffer with invalid tag */
+				read_len = read(fd, ptr + ptroff, size);
+				mte_wait_after_trig();
+				/*
+				 * Accessing user memory in kernel with invalid tag should fail in sync
+				 * mode without fault but may not fail in async mode as per the
+				 * implemented MTE userspace support in Arm64 kernel.
+				 */
+				if (cur_mte_cxt.fault_valid) {
+					goto usermem_acc_err;
+				}
+				if (mode == MTE_SYNC_ERR && read_len < len) {
+					/* test passed */
+				} else if (mode == MTE_ASYNC_ERR && read_len == size) {
+					/* test passed */
+				} else {
+					goto usermem_acc_err;
+				}
+			}
+		}
 	}
 
 	goto exit;
-- 
2.17.1

