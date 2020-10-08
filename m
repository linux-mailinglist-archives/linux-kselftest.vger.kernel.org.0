Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EB728741C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgJHM13 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 08:27:29 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:33432
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729954AbgJHM1K (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 08:27:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/k6ylvMna/XgbQtdQ34YuYxoc3J66+okcp8/jRBji84C61ccSdw/6yVugv+qg6Ky4TPgNik/xdkjNy7sW/hylC25aze0S9wOVsyAMTbWLBkmDm37BfoDY9qvpn9nqz5fMRCeapzqkSkO7Ce+oopDZJzpXha3+y68MGbEHA0vHJyyWTZoKcxAqK1uJ+KpWT1aHYx4r/9cm41Pwcbr3o+Lhh08TYpCy/fiHlQtA7eyRoflIhQWmsmCy+1v7fMHyT4r2a/9qHgmnRkunSZwpMPRLSAQmyJ+lSZNJx0Ss6LIm1jblFcrBJAcrqHq8zwA7Xw16yycDID13k5TnqmlX0qEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9hh3WniNakl1lQtEyWqXDpxiIdLiGeO69bekWoXlKQ=;
 b=hQThrHHkUvRjgAy4MT3oZfJnzb5MzFoEEmoQqH+qf/jQg8woJYovF7S+r/lXWPnPVkFqvd2F2ngWsGnbAWeJzEetruM5qtSlEXhVyWgdvlMZklYHImIn0Cgad7ksyhajPx8+w2vZKgVwnZu3Qqba4sLtQ9zCURC1D1tHETQWCDZ+wLm/eYg2qf0tydZ31Xpz+Za1c3jhWMs6qAjnfKdfTZv3GGtAN2ajV/cIy5aGIpKb2DNUB4WcA0kPOxoTJsKnQnpmMuQOwfjpJM/ODxc9vR9ygDd43ZB7gGnxxV8CISu4HruTYXzmftlaTwUmvphnuUcSL/N4FWogpmFMJ1HTVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9hh3WniNakl1lQtEyWqXDpxiIdLiGeO69bekWoXlKQ=;
 b=M0ig2dNjvNnAmMncojm34QJfyKs6DwU+TlxPDwcZp3o+2jEpQay2GNOw3QDsCTq8gxkj7e587D4vA+fGXyuiTQeNUFE6d7W7sifk6PyEhzOi1z6IGHy5Zan6CGAypoF8OpLNg97rrJ0atDzT6VnX6BhSfDP4md0o+QrqU48mw5A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2347.eurprd07.prod.outlook.com (2603:10a6:3:6f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Thu, 8 Oct 2020 12:26:54 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 12:26:53 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 08/13] selftests: pidfd: drop needless linux/kcmp.h inclusion in pidfd_setns_test.c
Date:   Thu,  8 Oct 2020 15:26:28 +0300
Message-Id: <20201008122633.687877-9-tommi.t.rantala@nokia.com>
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
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:26:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95570936-2d18-4ca9-a8cb-08d86b857047
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2347E40851566B1BEE4395DDB40B0@HE1PR0701MB2347.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhP51P5FKaGZQjXNMDGo6hUpj2MBiIHy3CfX6PMRri/U8zh6+/FcolK9429QyZq203UEYT21CSoVKyrjmfvbgjkDbk3mOPgiRYi9xdBbfrEX9vGVRk4yiSHfuQFmCohLERf1DTYthX4Q8rtIgEbR1wWgI7Ek+rUPGUKjPi6WJOtukPvjlm0KBD9W+eUymQ49FunbQn6w1EMNQA31U3feBwHOPlRXf3UOhNqNfdB1acvE50y/SRWBYrV0VeV+DLXimUoWOwFGLTuQ1TWXLhb0wCtGAifvuRCrLwS22zFNG/5H1NsDd6NBDimzpxheyPe8v4hRs+du5HThGoSR5xtryw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(66556008)(66476007)(4744005)(103116003)(36756003)(5660300002)(6666004)(86362001)(66946007)(2906002)(54906003)(6486002)(4326008)(1076003)(316002)(6512007)(6916009)(26005)(52116002)(8936002)(83380400001)(186003)(478600001)(16526019)(6506007)(8676002)(956004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: K4N0iK3BDmoclnxSJzThHJ+1N1bqIwEWV05fI9OH3G16kI9F5IW7O8SijerAtRmtEljsMS8BTwVyfuagqfH7/Ad+ulZJJDQxjkO1+enu6+htvXPggVDloiWmkk4TA5c+k1bgmQitK+vlYP0y4g8ytP6Vb9anV6UR3SP3bstqRgd42KVQEHOa/7XL3OMRKo8iJ8bsc0GNio4bi0cNAbCo4wOgOFXTP9AU0qAyLR4XD+7zWK//G21OTu8Ox94jFz4Is18XZBzwsaIJWOIZF6X8zEDx96sUzPf7Lv59Hq/2knMT2nb++oK1UXMI0pIHIq8vdm4fZylG1Fx560NcBXjhdLhyiSsinNK4LCUDZaOSEA3eEhrEkDEJswelONsB2VdEXTuSpZw98TpV0IdHt+0snUvtwPbsQnJ1mNKhenQ9LZwIXw6iXvr8jULZI88+Q5hgli+cJYAj1B5663boqY1wJa4drx/SNg3yAhJsbzWe26sYbZvj+OxOviIDm/zEIhRDhGSBJf4tuUra99UcJiixwdwsQuhaymaV3vy2QIJZ2DQU1G/WZSxhue9tmhbfcDVZEZb6xEamhKr8a5m53SfniG4y912Tbs6mEN21kvgcAhlFyXjGlXwr5kwxHV2U+Nxp0S7LThZExhCxHu3VlGBPIg==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95570936-2d18-4ca9-a8cb-08d86b857047
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:26:53.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dA9lvpefdxrIw8YrzARy+v5yCvzQkadFQ9Cq8FJGzzbCwKRLftf1p3E2teqsGFiNPTpz2a8mZU0b5RHdTRdkSbvdtb4eLJ4RCpuy8lbgDMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2347
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kcmp is not used in pidfd_setns_test.c, so do not include <linux/kcmp.h>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 7dca1aa4672d..3f3dc7a02a01 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -16,7 +16,6 @@
 #include <unistd.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
-#include <linux/kcmp.h>
 
 #include "pidfd.h"
 #include "../clone3/clone3_selftests.h"
-- 
2.26.2

