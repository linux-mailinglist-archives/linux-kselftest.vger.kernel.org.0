Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA22A287412
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 14:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgJHM1M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 08:27:12 -0400
Received: from mail-eopbgr70138.outbound.protection.outlook.com ([40.107.7.138]:59779
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729938AbgJHM1J (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 08:27:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0mZO51bQ2Irwvqls0+TAWNK9RDTuzgzTeK8AiKDmxG8sZ95qpisLSa9rURrY9ZDC9WiMKaDlnPa5jcFNIjFyunh49pOSHeyfbtPlkoKxRofRzNt4tldCJDdbV0weujF+1dbJ6z+1o678t+c9IaEbTuNxCOgcRiprM43pNilnq6wCZEG3NO2Lq8f5MtoUsBqJPjl4bPeZGnA80+5N6H/Tcj7MQ2Azm+rGVI3it8zYJuwE2Ed+7Q/wA91A1mHPHynLnnkhXMtRYzZ0KVLD0EKZiLal2rdaVsr9rsJW7HWgcZqW2RI3l08t5SFDYJCihpFGNC/PXnZ8wt/qvxPFlChpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT7nEoiyYjMtFlxGGO+J00XVQ78gzb3oUaa9uKjC7qc=;
 b=LSEm1jNolfbAEU2Esfd8iNokr4ihYmBGWSVNOa+m0XqajgRbVOumFW74yJFI8u8Y3L24eZzRpIWzFBME4pjDGUpXWA/ccaKi+HDhZIYtAa4MqORHiQweusCjbUiajFSI+jO3Eaw2oArcEWS4hrANsbtScwExdJ1i6FUNbQ44swKyyG3X5iVm1FjcZF5y2PCiXYpdrfp87Ww4vqMq2tRP7ORw8+ZVCC47LHofm9PA+VbIqM6kveVN0FyUADdnCzd/waSqbTNeT00nD05tRphBQpGFA96aEmPK9HvuM/FPnO6eOrqBnMtIcReePP5odXQnjQ0ubQ+GnbYW2DxG5f16VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT7nEoiyYjMtFlxGGO+J00XVQ78gzb3oUaa9uKjC7qc=;
 b=iDuEhWk5dyHiUg4e5A5V3UB/VA+ZfNNZvtpTTBFOPreJbhzvp5hsYT9fBczsFHlxfIbIjld70urELi+y5wg7i9WXR6Xmo6d9LPyFOWl1Xx9GL9Iivep5OEuSi/foAKEYjV49pb70nSmPTixtyehX7wMiBse7uiqbFz3liD/lZtI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2890.eurprd07.prod.outlook.com (2603:10a6:3:4c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Thu, 8 Oct 2020 12:27:04 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 12:27:03 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 11/13] selftests: core: use SKIP instead of XFAIL in close_range_test.c
Date:   Thu,  8 Oct 2020 15:26:31 +0300
Message-Id: <20201008122633.687877-12-tommi.t.rantala@nokia.com>
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
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:27:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df47c03c-8588-40e1-c1e1-08d86b85767f
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2890:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2890F61A641C5447539428D8B40B0@HE1PR0701MB2890.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tp2SwpdwIOjhpRlCUFc3aPITFKybmGMI7YhHBV3UHVvHdXZawhzY1ni49bGO0WLqIs5APDaodcuWU28B7qT0rbM63/ZC2p4yl24Ek9g4Jzih+DP2s5BFiYYN2JBRFqveNsTcjdHYW6i3SSfLyTKQq8q9MnKMWbsk1gVvKuStrZg3qqiarWxUeMT1NDn1xX/40qITFSqw36PF18TA9JCpEz6E/X3I5B4PuVbQ4JYvo/wtRUDWC3AHkSj9+Bpw4Nidy6OidioO3BCgxqIEM3YRD0fG46fxjvQ1jJSJTnAScvwaXZBFEOqfgK9fjQoaCVJRU9JUTZ/w625sAoYDu+d+lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(4326008)(5660300002)(83380400001)(8676002)(478600001)(16526019)(186003)(26005)(6506007)(86362001)(52116002)(1076003)(103116003)(6512007)(6916009)(2906002)(66946007)(66476007)(66556008)(8936002)(6486002)(36756003)(316002)(2616005)(956004)(54906003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: CAu4mcA7p4AGaLvpjJNCgsY5Yd5SYv9XR1aS9e5TAnkdQgNN7FT65oGG1ufISBWFcDuvM9otuFbc+wsHKr9l9pw/CuYGnBGSs/ODysQsAOG1zsg12qj/KxPa364N0TcnstbR76Yba5HwqBNM6WF+Ryfj6QMAWls6QNJkBs7A/YvceLPiPH//dyJJJGPEm82OzMfoGhh57daM8gfiAOgYr1L8vYvD/BbMcVX63G1uZJHnynFLMlPZPmE+rEEuUA9y9YZb+ctUq7jh7OmEi0OkOE/1qJoE4NCVpFBx1DWHTfvCj767n4iLw8Dkq9jpC68pBv1TuoidvU2v8qNscKYYCM2mi9eYBcXYvc80LvIhVm/qxCsHp2E9e166mhGxnADgYTT+CBtUkgOHRc93am+zImw7vukTBOp9mXQd1fdk+7R2hZJ6sI6lanuFQkvgwgJCWV/1IM0n216+7WFDthnraJph3KXPr/hKLd/w+epRT18sN4H2586L3wVO0Uv4zSK0cNRDxhmyKYMJF/R3zikoD6AZP51T1D2FFzAE3g1vsC7vWt5C2YzWhtPKDHu6TQLZqZFDSO8UXGWp+6Bk74qQJCk8XOqzLhEUiYFGdwGwie9xgis2hI1nVftQtDFM7OQEa/ksjuTg5tVAm25OCBc8zQ==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df47c03c-8588-40e1-c1e1-08d86b85767f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:27:03.7580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOyMgQhGjg4lWWnzS8OskKj8Go9gcqT7m2RTuOG6R+Q2bVrGkUCoeM0z/5GIBxfekra8uaVW8HFXjJjuefgSRRYseF134PommExQNa7uuIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2890
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

XFAIL is gone since 9847d24af95c ("selftests/harness: Refactor XFAIL
into SKIP"), use SKIP instead.

Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/testing/selftests/core/close_range_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index c99b98b0d461..575b391ddc78 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -44,7 +44,7 @@ TEST(close_range)
 		fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
 		ASSERT_GE(fd, 0) {
 			if (errno == ENOENT)
-				XFAIL(return, "Skipping test since /dev/null does not exist");
+				SKIP(return, "Skipping test since /dev/null does not exist");
 		}
 
 		open_fds[i] = fd;
@@ -52,7 +52,7 @@ TEST(close_range)
 
 	EXPECT_EQ(-1, sys_close_range(open_fds[0], open_fds[100], -1)) {
 		if (errno == ENOSYS)
-			XFAIL(return, "close_range() syscall not supported");
+			SKIP(return, "close_range() syscall not supported");
 	}
 
 	EXPECT_EQ(0, sys_close_range(open_fds[0], open_fds[50], 0));
@@ -108,7 +108,7 @@ TEST(close_range_unshare)
 		fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
 		ASSERT_GE(fd, 0) {
 			if (errno == ENOENT)
-				XFAIL(return, "Skipping test since /dev/null does not exist");
+				SKIP(return, "Skipping test since /dev/null does not exist");
 		}
 
 		open_fds[i] = fd;
@@ -197,7 +197,7 @@ TEST(close_range_unshare_capped)
 		fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
 		ASSERT_GE(fd, 0) {
 			if (errno == ENOENT)
-				XFAIL(return, "Skipping test since /dev/null does not exist");
+				SKIP(return, "Skipping test since /dev/null does not exist");
 		}
 
 		open_fds[i] = fd;
-- 
2.26.2

