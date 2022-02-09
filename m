Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967834AF527
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiBIPXg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 10:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbiBIPXf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 10:23:35 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30055.outbound.protection.outlook.com [40.107.3.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4814FC061355
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 07:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBWkP3xTDqEI9nZFAGoaqV6fBxjZyDpGtlpDd0o4wHg=;
 b=rJuu4RIa7MnnraHG6gJzRLPMmNfl2Ad3QTXW8cZiikWbousyWghwHRAcXjK7e4GprlBcH1oA4Z6nYWEm69D4QM8XuqqpzP8Vnqar+G7wZtOXReGh1ofRsan2tcIOHGSSEMSgH8xHt0F56pnWETyjjaRGQZ/nK29tSJ602iJZJ14=
Received: from AS9PR06CA0217.eurprd06.prod.outlook.com (2603:10a6:20b:45e::17)
 by DB7PR08MB3900.eurprd08.prod.outlook.com (2603:10a6:10:33::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 15:23:23 +0000
Received: from VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:45e:cafe::24) by AS9PR06CA0217.outlook.office365.com
 (2603:10a6:20b:45e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Wed, 9 Feb 2022 15:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT007.mail.protection.outlook.com (10.152.18.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:23:22 +0000
Received: ("Tessian outbound 63bb5eb69ee8:v113"); Wed, 09 Feb 2022 15:23:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 797637f393daa84b
X-CR-MTA-TID: 64aa7808
Received: from 75e4919ea095.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A75D58E6-37C5-4AEC-ADFA-5EF4F6699137.1;
        Wed, 09 Feb 2022 15:23:15 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 75e4919ea095.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 09 Feb 2022 15:23:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9NQ6gm+yEc0d7UI8fdaiothQiRlvwanVPtl5vDHcvdOE/XAiCf/r1KbwCwH+jSBVmbLpJ1l75TWHfHq8dt0ovahqt3CCGlWcQKx7hEpF4z99I2xsoyKEufwS3p7Ffrlaqb3Rso7Ri/2aVZpggVN0ln3URMgyApAhSxUWnzT0gXiYQvIp8ST9h7fk9RIOBtDp9oLSFi+Dg6yqw3pOhJEiW2yug63DRLGM9+GEnNGSRgBQIwhQAgOVJwYb9Dy4EYbPkrypI0w7oMhja5mZtbQHxW1xyEcnyiBgdEs9i1/DqkNjjoe/wFAYMI7uHfQc0awUBGYiaE+rdWXl4UfudkISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBWkP3xTDqEI9nZFAGoaqV6fBxjZyDpGtlpDd0o4wHg=;
 b=KH/5VEqNn+O1TV/fVK1wH87LfUO++JmueX588e5pTcndEAvhrP2Nzad7C/dc6FRPrGd7GoMdOBV7oJ+XPhGpzIgGqMxb6WABhaXftC1GjbMDrwfA1E8FRRGHnKO1vEl9/bgQfqn196kTZ/YQZls0tJitDOtHcxl6Ey1OYG0/xUmscNudfTcAj94wR35TV9nqxC4PEU3R1lUq7H5GCFfOE7ZdqIIERQ9ARfTggtLAX5lX0WturguRqs/NGYTtSw5BnTaYzzkLEO0anQtsXga0hT+UkuAmUe/omkXPnnP3lXBWTzl0MHDCB8SSpwzTk3rE6taXAPnIjvr4Rp0+hlVopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBWkP3xTDqEI9nZFAGoaqV6fBxjZyDpGtlpDd0o4wHg=;
 b=rJuu4RIa7MnnraHG6gJzRLPMmNfl2Ad3QTXW8cZiikWbousyWghwHRAcXjK7e4GprlBcH1oA4Z6nYWEm69D4QM8XuqqpzP8Vnqar+G7wZtOXReGh1ofRsan2tcIOHGSSEMSgH8xHt0F56pnWETyjjaRGQZ/nK29tSJ602iJZJ14=
Received: from AM6P194CA0038.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::15)
 by DB9PR08MB7219.eurprd08.prod.outlook.com (2603:10a6:10:2be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 15:23:13 +0000
Received: from AM5EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:84:cafe::bd) by AM6P194CA0038.outlook.office365.com
 (2603:10a6:209:84::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 15:23:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com;
Received: from nebula.arm.com (40.67.248.234) by
 AM5EUR03FT022.mail.protection.outlook.com (10.152.16.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 9 Feb 2022 15:23:13 +0000
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
Subject: [PATCH v3 5/6] kselftest/arm64: mte: user_mem: add more test types
Date:   Wed, 9 Feb 2022 15:22:39 +0000
Message-ID: <20220209152240.52788-6-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209152240.52788-1-joey.gouly@arm.com>
References: <20220209152240.52788-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: 009f7dc9-85bb-4396-9f6d-08d9ebe01c3f
X-MS-TrafficTypeDiagnostic: DB9PR08MB7219:EE_|VE1EUR03FT007:EE_|DB7PR08MB3900:EE_
X-Microsoft-Antispam-PRVS: <DB7PR08MB3900C4BCA0FFD43D8016CEB7942E9@DB7PR08MB3900.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: mEJayZ/8YA66+sLfsjUZOCL649PGRprNRJ8fMzYIYkonVSqiyGu9yzFUqtwwMXCsVETqljsZ1Q0SZqMdC+YRoMOFJA4EDo02incDFjNT0jZlhjYTa9QKeCoD6rR0/pWcPx/T0+f8u3uv6dccd9ut0QrXkIF1jmd4HAyrZrKddBOXQ6hSfyPs+M5VXvPr6NmTPoLf7zNVZR0K0yaOlQRno2xNhvIpHaQxbmKc9gJ5XMUvDuvcdTxetwm09VUHhsfWlqS+oRRFIO6U4mslixTPLYU4KnulSb8WHv5cYD5IME/MG/G93wIOTNAfM4R6sFxQzXRBmG/zX7jtxeq7Rm8iGKS3NiQLrcyAHUxLMckE6nzHFj5SAIU9nGsKSdZxxTfpOpw4to+YodSF+sDe37cRi26VOiuwO/cqb/XIYWfcBwugTqpDdXvTcnqDyWenD81JP8XvbppIvIfjbVtL8BMg2lhL+6HFrZ4qv+8EgS9NMqwWjoC57C/HXLs6zhIG2vFYOCP2x0JhF//f/kwnI4VsJvVaGksOTipiNdv8dcI2VPUp4fQ4N8b9LsXCnh7tInTJzHWhk2X7JiPN3ISugVVYrQNPIDs3pRMpklcdCoKlx7BGKVxgvWV5MBe9KDmP9dASKfmpjBIhowauhDP7IpLaO9FOINwMKHPWvms9ki7U18LixdAa3GUXz11DaTQDhhCTWO+O6TFNPrNLwKYKoE9pjA==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(356005)(36756003)(40460700003)(508600001)(8936002)(4326008)(70586007)(5660300002)(83380400001)(1076003)(47076005)(26005)(8676002)(81166007)(36860700001)(6916009)(44832011)(70206006)(186003)(82310400004)(426003)(336012)(7696005)(86362001)(316002)(54906003)(2906002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7219
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a838568f-9ebb-4d85-aaa4-08d9ebe016d5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eugQsCy4WfWWU0rVCW3WmG7snQFAnVGEinTOjZ9UC5vpF6EvfG7k4KGygzTXAkcfj0CXzpBGUzxIP9kfYAne8NoDRnb+XieFS2HltrCqPV1ZkzJ75mU6rHt7rNl8KpCWZc0nOACwn0YdHa2lQ2+eEhB543JV2OuBhbb9L6+EeX0iO5cIlMqXldXzMEx6dXuaFNzJoVlJI5QOWXp/VIzsBeGs4ogOVo7fZDQsinG7feGwrsbC2EtkuyaiVvYReGTcg6Aes8zl4wmY77Uvu1DHJPTjnCxWGokjwFfMStXE8yM5LKs6uPN+9Y03tBxZynRwb2Y7MNXa+DLmB/NKn5tUn1Rm/1wI18mVym/azsCEjRUcuxYJAnpkDi2QUiLtbLwe7hjSw9QGWRSXCQ/b0S69CO5d6vFtf0cYT0xXrJ9FPtHNihkBq/W2jJ50ewfCMgyeFlk4WdcjgJbZj002d1mXVIKf8ZnzRk9H+3Zs+m7zeKp584m9JxS2qv16TYAsB3SJCgeMWEe72wVhmbRXKxn84p2+7H53y78yfx3L8oVaggyPiH7YLhWV4tDkAnqW+HtEfqDDNelWLumkxcwJzj4ytdMHikytE/INMAEm4RiixIKrjsqSepF/wWZSwBN71b0LIermUCUIae1pl46cTCI3xId5WaWTrmPPl1JTq46t53E=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(1076003)(47076005)(81166007)(6666004)(70206006)(7696005)(83380400001)(70586007)(44832011)(5660300002)(2906002)(86362001)(316002)(4326008)(6862004)(8936002)(336012)(508600001)(40460700003)(426003)(54906003)(26005)(186003)(82310400004)(36860700001)(8676002)(2616005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 15:23:22.7641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 009f7dc9-85bb-4396-9f6d-08d9ebe01c3f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3900
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To expand the test coverage for MTE tags in userspace memory,
also perform the test with `write`, `readv` and `writev` syscalls.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../selftests/arm64/mte/check_user_mem.c      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/arm64/mte/check_user_mem.c b/tools/testing/selftests/arm64/mte/check_user_mem.c
index 58b1b272ca80..bb4974c437f8 100644
--- a/tools/testing/selftests/arm64/mte/check_user_mem.c
+++ b/tools/testing/selftests/arm64/mte/check_user_mem.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <ucontext.h>
 #include <unistd.h>
+#include <sys/uio.h>
 #include <sys/mman.h>
 
 #include "kselftest.h"
@@ -21,6 +22,9 @@ static size_t page_sz;
 
 enum test_type {
 	READ_TEST,
+	WRITE_TEST,
+	READV_TEST,
+	WRITEV_TEST,
 	LAST_TEST,
 };
 
@@ -81,6 +85,23 @@ static int check_usermem_access_fault(int mem_type, int mode, int mapping,
 				case READ_TEST:
 					syscall_len = read(fd, ptr + ptroff, size);
 					break;
+				case WRITE_TEST:
+					syscall_len = write(fd, ptr + ptroff, size);
+					break;
+				case READV_TEST: {
+					struct iovec iov[1];
+					iov[0].iov_base = ptr + ptroff;
+					iov[0].iov_len = size;
+					syscall_len = readv(fd, iov, 1);
+					break;
+				}
+				case WRITEV_TEST: {
+					struct iovec iov[1];
+					iov[0].iov_base = ptr + ptroff;
+					iov[0].iov_len = size;
+					syscall_len = writev(fd, iov, 1);
+					break;
+				}
 				case LAST_TEST:
 					goto usermem_acc_err;
 				}
-- 
2.17.1

