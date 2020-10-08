Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4913228741B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgJHM12 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 08:27:28 -0400
Received: from mail-eopbgr70138.outbound.protection.outlook.com ([40.107.7.138]:59779
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729957AbgJHM1L (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 08:27:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxjPcUUao7ZI3e65g/ONO6VZwrfLNmgGT+nxdhdTeQK+MhouGvSPUsf9KmaMsNFVsNnQdoZb3YMxYeSIMuuQ6xvcsSAAxixGA5luTHxhAHITdT/ExIfAahqE1I5N2nFtRRI0WyGtkX1FC0I2duW+oJGOusm2pNhzARlOYW9zN183P94vZ3tr9wzZL9x5bBxFWr+MFQdwaiIq0zDkVLUeUhC9WqkjcM2kjNbhrJKymoO2fDeKuoO3DpKQs1tQYOPybzCLjfpvd3AqJZInx5UszF5fO4JwbI3mtu6vzJ4/g5z7kGz8n00Qbowx+/utsk2znrrNjFHBAphzK8xCmmZKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n07utvrJ19W8WLyry3ZhXnj0KWoaqCYvJusE5lDKou0=;
 b=KHPqd1RnUPiv9GUaU+nH+eq6A7IdzvHyeuK0TSZKD9Jd3V4q1v8v1B30JK5NSaSSrrQwwf/Ds17H4PIi+dwXLSoI6qS92is2efvcBolfAF4eDKaST9VC0R2u3F5dBdhPgQR3hn95y7jQ8hX9iEtSYtyn/EmIxQxqzSRmxeizPmYYk+otjdPOrpRiQsqcX49UliOTLESKNLUAwHBvSeBs+qPxoBH0qhcwYkhHed5sPP5ltux3J8jrLs9GEp2dCdQuShxh3nuiJILcXhXR4ZokwTgJt+vX/J/Tp/qem1o7t/brVYz7fWlUeI44f3IhCEzGAESzjc55PUvDDIFm/64jfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n07utvrJ19W8WLyry3ZhXnj0KWoaqCYvJusE5lDKou0=;
 b=hhfFJZKSOV6B2o4PoJMTHc91M4LWR6b/76lfcwHTQihJbB48jvTvpW1HjVokyLwOXFef2KHF+HKFQNf076tIoYuSl7DqtdUd6OsjzYHuqHOXU312eTJc4arYhVjIhVma6ICAGIavqxUqtI+hATc1Mlv7axwKT4vDh+oIUbNnCM4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2890.eurprd07.prod.outlook.com (2603:10a6:3:4c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Thu, 8 Oct 2020 12:27:04 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 12:27:04 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 12/13] selftests: clone3: use SKIP instead of XFAIL
Date:   Thu,  8 Oct 2020 15:26:32 +0300
Message-Id: <20201008122633.687877-13-tommi.t.rantala@nokia.com>
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
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:27:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3d5c4f5-6c8d-452e-0798-08d86b8576f5
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2890:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2890E64681CFE2E50C88F524B40B0@HE1PR0701MB2890.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AeBl2UWh/gKCVbqehH/ohEbheUsyUIYdWmpWx7afvxDEdBO8iCM1crz1JFkJKvDBYupMlHTP3kmKmjxgYpeAizoAxdD+wgv9LB2neNHB8uH0i3cofgP79GaxT/E8VE311/IowrRMDUn1JGPd0xFtlzq82KBGmjEgwJxh3vTCz2s3G/zkYVUkse7hmFTHfPkJih153MsPf605qwH4+NiN/Zg9dVu6VwAQeQ73KfsaDpbZhtbHiD1UXSguT2ON8FJnkalspzG7T0rQG/sE3zmtK+KvHrvjDRgW0rOOXFE8ywPhivr4dNu5l202Tc4uGi0Let+Rvk04ctk6SjwXRx73VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(4326008)(5660300002)(83380400001)(8676002)(478600001)(16526019)(186003)(26005)(6506007)(86362001)(52116002)(1076003)(103116003)(6512007)(6916009)(2906002)(66946007)(66476007)(66556008)(8936002)(4744005)(6486002)(36756003)(316002)(2616005)(956004)(54906003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0e+s09x7VlrEDZIbE4QsfzhWVJqSr/joJGTTcQ+ncR3osTy5LR7tuZV+BVdKVLbgR/4xqwXblKGX1PbY4hmlVEIeX0gYQNXFmNDfWG8eVuKJ0I0LqM3KXckGVUnWHqsb5tU/XNj3DUZE2hsF0feQtmXgetMpCbmL2IrMSGUYu9Ct9ToJpz3xVjaxGHKjkaqPB3naOMLCBdhbs4CEC9IXc/3oNjGCCNtTmX9+XvyAhogfKFHjEPB8z8Ivd6obXsPD3VfbjLr6yr52nxjpGDJwvlhPbRngNa550iZann+PetxcQOYwJlgbr9UAOQfPKKcXr9D4uX7i7rA3D4dhuQf7PML8EGVBtNjjAGtKqi0YbMCBzTaZIMcqVIPVWhHb6tyzHibt7U8OuSNd3MvGolDzCJnmc2vTkkyDdXB47rkqgHfevVuewmA9yhP1i6tGs5rTT8TftB/rRydWkFynvHs2pzxQPDvVgVl1N+JCh6vBdSjnIUSWM4cRo3rNdSdsXVYJyPpXbNviTmHBpUxLmUybVDNElwRv67X5VGMumfczIamA5Izcp8nda5htOP72L4Gok7G7mpu/tRvCzPK++kt6pa+gUxBriStfrSUii6Z33ThNZ+4SogzinmLlPvMYjLG7Vpqa09QWClYERGWdUY7CQQ==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d5c4f5-6c8d-452e-0798-08d86b8576f5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:27:04.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E97XHAl5T4nYWkwT1qWvjti4Sk8D5BbB7rr8MS/NRMfM6NrUAicNbOdv17X9xgKvH5M/8vUSxUJhXFbaJR9Gs3bbvodF2129HpNDtFV435Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2890
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

XFAIL is gone since 9847d24af95c ("selftests/harness: Refactor XFAIL
into SKIP"), use SKIP instead.

Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 9562425aa0a9..614091de4c54 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -145,7 +145,7 @@ TEST(clone3_cap_checkpoint_restore)
 	test_clone3_supported();
 
 	EXPECT_EQ(getuid(), 0)
-		XFAIL(return, "Skipping all tests as non-root\n");
+		SKIP(return, "Skipping all tests as non-root");
 
 	memset(&set_tid, 0, sizeof(set_tid));
 
-- 
2.26.2

