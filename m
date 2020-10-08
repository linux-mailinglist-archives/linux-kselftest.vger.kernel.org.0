Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91D0287414
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgJHM1Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 08:27:16 -0400
Received: from mail-eopbgr70138.outbound.protection.outlook.com ([40.107.7.138]:59779
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729962AbgJHM1O (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 08:27:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEClyS21qHYvr+WiTjSKtELnJFD7solx2dpBN5Q0MY2tN0qd59Hvy/ptGxFdMvlhuaudubOeZlinZn1WVN24BXmL1m5Ncobf7ntG6Q4YPcbZLNUkZNMDfYORi0ZeJ/QuCufY5rp4rZMl4gJsXXM+UP/Gm3AeOfgCK5JJhly6vmK3+/pGBME0X7se2I/9G0cwPihlyxLlx9lVNpm9fe1RDVbrr1OsPBBhpHGGKIAAPYSnCdd3BbD0DJkIgDiDXHADl0bTE9swaqyZKFJTGFtuBi2xXE1IAdDma3D4Xj0n360/GIB4OvtpoKf21q/i9fLEsqAeOGzz/Uwwd8EjiqKuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeuCNWQN9zksOYRDjokWNtTDANbB0ABqJMbNXINb4b8=;
 b=n0H4aEJ237xKYH48Cf3c4EpcsZoIe/U6s1+xtHpI0bZTtMjWarjvn39hRcZP/XqOdIE6gDZMqHhxtvZ+uFTDOZdDYa9Wp+kcfqmLyRmwT4Wd62JfhqePdh5JfaztYedkJ/C9B9aJO2dki9+bnhTNUSCQvpDNNJk1BdiwqvDmL0WutpecYs8xkyKDh6GrJo0g4Vnx7JBN6NF6tZRoBcn/Upcym8ZRpiBDkvAPU5tmAHabYY6v2zdjnOgaOinYHR43VRu0cJbcqPloWKfiUQ9y8uVc69pzXB7ybC6VJAtAK7SE/+vBcMdLbRFEJdml1DIv2lVS8ikJQEVWIywZLlDGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeuCNWQN9zksOYRDjokWNtTDANbB0ABqJMbNXINb4b8=;
 b=EpjWpUPD0BYT7plnQ7ZGlv0/ElD8/Lnreu7mxhSeHWOCJKRPJYmE9rA17XalcWn8SRq/cjYXe0ofx6Xc/9JMv82ILGB+CEfEI1xgAKH7jKp3JmxD8ZYwcTNzFXPhLdmuiypME4L/iZHZ8BW/YMYQ8uJWmVd9RLAOjcV9DOE8/rE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2890.eurprd07.prod.outlook.com (2603:10a6:3:4c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Thu, 8 Oct 2020 12:27:07 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 12:27:07 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 13/13] selftests: binderfs: use SKIP instead of XFAIL
Date:   Thu,  8 Oct 2020 15:26:33 +0300
Message-Id: <20201008122633.687877-14-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [131.228.2.17]
X-ClientProxiedBy: HE1PR08CA0076.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::47) To HE1PR07MB3450.eurprd07.prod.outlook.com
 (2603:10a6:7:2c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:27:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b90c13dc-fc07-4eab-258b-08d86b85782a
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2890:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2890CE0CC0D2E96C14E1E061B40B0@HE1PR0701MB2890.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GXaRemM/R4aTqW46R6H225rmUmQcV1Js1nGjQJh3Q5m4p51Y+OCrN7dIoctzSLnaMN9+7sCpxlthkF7DNoZ1qJMOPzmRUrJCAhJe6LwR+ie0uIKhUxQaHZ3XnbDvUNvbwEzl8eAPYSgQT8u/O/hYKhf98XNLjL7gcKUMPmTOmeqVu0fJpCWTP877UtOAxwtDqiRYXCeTWGCSrpAX5vO3Hc5fM8f9PWzvM0Rto7o11vyqLr24dx58JP/g6pt6rsQwLYfdWNkLw/So4ZlIUopa+uj2Yr6EelsdnOfSm5U26/08C91eTRCXFSjoSHWdrM6a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(4326008)(5660300002)(83380400001)(8676002)(478600001)(16526019)(186003)(26005)(6506007)(86362001)(52116002)(1076003)(103116003)(6512007)(6916009)(2906002)(66946007)(66476007)(66556008)(8936002)(6486002)(36756003)(316002)(2616005)(956004)(54906003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: pJR6CCu3bXEBaPOLgIHNglil0qVumvtd4OxxCZWBppNf5SOy4uEfvQi2huAJnOmh/S2TuetEpmJWwFEyZoGlCL6kEGC6/Rh60j3+D+LsTQhz5NujHTdBHuU9PFdwVXbi0V60HFzqtaC63yW6pq7f5PnKZ7JqP5P45mj6WVOphYPYjd5BPa1P+QkrQqZwXyNi0/GQwNCRpqAOa0oZ/hLenJL0r7gJ8Gj5ZuuLmVH2sge8a5Ogz+aqQVo6nRKM4cLPySnUwkijkI2f3di4pTmKOf/Nj5M7Z/Cxt+iCelwU2vjkf4y92TNbqD+DbfhG1iv95IpsfcxtzbD4VPldOPQ/uy3qMZsg40PZPWvyyyXiJXUhgRDWfkCGn9T6VEXH34SaT9pq7prCkPF/+/yK8yT4R5uvfmlIcET52JY1133+KEQSXOQfaAFIgsa7W7tEKbsx2OBBVjAdgxd2Yo5xELX7hgIpyxPMRqgceY5fKbgYR6doQK00a2q1rXldaXMx97G47BRlmqOkfdgHt+xvv3gxFyc8QrzToE6e0QGlVURCPX1M+5qLQ7Q8/7pBuz9zQApayW5wzseTZJjcoNFbd/T0oUE4sQIJQh+C5SMiutEgELiGZPxkY2/MgGEkHZg0dsmEagRbiJ5g67JjRu1+tq7iMg==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90c13dc-fc07-4eab-258b-08d86b85782a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:27:06.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ATaAHrAw4PxS8Y87Fvfkya6cxB7pxAnPvuxk5HbdecClvBmklG8UHc0r6YtTmAsJqdaevw63RRDNSyOI6ep5YtAVnl4Hbn+x7iSYzOu1aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2890
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

XFAIL is gone since 9847d24af95c ("selftests/harness: Refactor XFAIL
into SKIP"), use SKIP instead.

Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 .../selftests/filesystems/binderfs/binderfs_test.c        | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 1d27f52c61e6..477cbb042f5b 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -74,7 +74,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 	ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
 	EXPECT_EQ(ret, 0) {
 		if (errno == ENODEV)
-			XFAIL(goto out, "binderfs missing");
+			SKIP(goto out, "binderfs missing");
 		TH_LOG("%s - Failed to mount binderfs", strerror(errno));
 		goto rmdir;
 	}
@@ -475,10 +475,10 @@ TEST(binderfs_stress)
 TEST(binderfs_test_privileged)
 {
 	if (geteuid() != 0)
-		XFAIL(return, "Tests are not run as root. Skipping privileged tests");
+		SKIP(return, "Tests are not run as root. Skipping privileged tests");
 
 	if (__do_binderfs_test(_metadata))
-		XFAIL(return, "The Android binderfs filesystem is not available");
+		SKIP(return, "The Android binderfs filesystem is not available");
 }
 
 TEST(binderfs_test_unprivileged)
@@ -511,7 +511,7 @@ TEST(binderfs_test_unprivileged)
 	ret = wait_for_pid(pid);
 	if (ret) {
 		if (ret == 2)
-			XFAIL(return, "The Android binderfs filesystem is not available");
+			SKIP(return, "The Android binderfs filesystem is not available");
 		ASSERT_EQ(ret, 0) {
 			TH_LOG("wait_for_pid() failed");
 		}
-- 
2.26.2

