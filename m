Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096EA28740A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgJHM06 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 08:26:58 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:33432
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729756AbgJHM04 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 08:26:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqsqC9vgkxPiT0n1/inBpcGmPOkqyEyLHlEjSpbQrNldTy5wtoLxz5ZzPLIbRCtLbGz0WTI3osJi20JZ9bY895Xk64HRJLwWYcpoUVcH5zSE1BPQXDXaIiCdxndWp4IPiCLsILSnrx0n1u6kYjbmaTZTeIzrtGUg/wUmm8MWBzH0KkryHCcDS4RGcDWJjPNIjWmrE5RFnguLo0We9aVLcu/5arhv1jS/EtOSmNyi9s6h0apZUwl0sNHuuvDgdqVkb205un+jEJaahNbxcu08s8FM23BtduRyxEZSvEZ5Z+dFPoo4yGute2cwFJZOlYN/vF+gnaMCtvcTAp08EF72LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRdY3DwayFuLPPCxU6TH+fsE0G+lfYyn9pDIcM2iX68=;
 b=XPdzKSusuAOs5uqcW75+Bpj+ChyMS6ggBKgs9PsKZ2IpPxiDCXBWqUpvjy1cSQbyj1Rqlouva0Ypp56EQ4esom+Q04PCPa0CaZTTo75NnzupLjdiSXKvZGVQkksCVTLDwm7IG2iiwwKY4/GASyvUIxcSKYzzhf0os0lzBVhZ7xLhvZhK85qD12+tve6VcuCnzWetsqmBP70dyXd+xSf7wpJfW3q76T2aPu2Id4ULemSqw6xoDElePDtbZtrxj1QE1Hnoc/Zir8buZvqwuw6wpPvkcqQI47yYGRMJPvNoB10rAP/KhQ2kxwYmt/wELjS/Fu3+P0Xubg56B61aNXwYoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRdY3DwayFuLPPCxU6TH+fsE0G+lfYyn9pDIcM2iX68=;
 b=rcpsF9z0D1H7ni0ApenFbc9pOherLOo5qtvXUsEZWt1Reqjubp9GyTN7Osulkk63U8Ai6FOhtTkLPj8GfAJTdfxxrMTOJyYaq1hHmUYh58FlasAAuHhPPwEm+IuCMEkT97il3XZKaITeYB6Ci9p6hmpvkpm30fGMEMNoRcM46Bw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2347.eurprd07.prod.outlook.com (2603:10a6:3:6f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Thu, 8 Oct 2020 12:26:47 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 12:26:47 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 02/13] selftests: pidfd: fix compilation errors due to wait.h
Date:   Thu,  8 Oct 2020 15:26:22 +0300
Message-Id: <20201008122633.687877-3-tommi.t.rantala@nokia.com>
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
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:26:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d049d344-2db8-4649-5edc-08d86b856cbb
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2347E1699A5D8928503A266BB40B0@HE1PR0701MB2347.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5k4c5JC8kkiWRmTlk2prVIktwxuYGx0R83Ft2n4jObn1I6EsrIxjoyuiwFJCLKQeqEKSlj0AQckNuT7vCSVLmsdu+sRr3Kw3bXxXoFsj+Fd56YOx4uUcd6jJKggwyQp+QxUHWOyvZnYV8bsRPvip7FPlDH/dJ1n6qJY12X/EB96EQuBOx8nlWyH/Rv0dz6FGKj8cecHLQQ9dALyU04MIIcK612HNEZI3CT/Iye4vQH/DsGxCR94E2FfAwJDxJuim0mWnWcFp72y679Lw+Qs9vkQhrUxGoipm4IatHFvydQ8D5/S12cmrrUFdmCwXbOJfz3VblcGh0rXIoUFNPI+KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(66556008)(66476007)(103116003)(36756003)(5660300002)(6666004)(86362001)(66946007)(2906002)(54906003)(6486002)(4326008)(1076003)(316002)(6512007)(6916009)(26005)(52116002)(8936002)(83380400001)(186003)(478600001)(16526019)(6506007)(8676002)(956004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 595T0uhcEjWDCfcqejurgSHipcqY8ZPu3XVm/G/mFZCJ/JgBA0PBt3kiVtP3tCMn1zo2+JoayyaMjeQmxvrQuxEDoVqTll/mGnKuwcxiT94BolDtD7mmYGx2JjWGlFSES3AcmjZAW5VvrEUm26E2Q6IlTvhz6cDbxLkujnMQEijbW5UJkkUr+pSMNW7YwE1CdS5YE/thoymzCNCR1XN9VhEeehXDFAcpwXaeESxmbEFB5ZcP2IKchNvjINhAgpmKXrY43JC3UbpupiPFPbmYBqTcitJpl6kbpIT1T+MtdhUZDruUnKYinyMe3ToAf/u3OjIKPoQpvqLUMiVRezurhnEK8cYBore34oDncmKfBjoiBQQkgPTb4A3YvNkp7xyxJXmENE6Ld6FGIOpydBcNfD5woBaMmeGiLwUnIl8HjBp+JuZM0oTb3jBq3XzdEQ4D+1t3BfFEz+4CqGVgJpA8+lRwLF/L5y91Bu1iNovZtF01GcGBWZ8WQw29cjdaLLKU2QfuL61cdTT/8m9fwF4F74uu9JzcpsTvNNSsKdLDMywNBsbWWj9N0UixB9M4YkSiRzxZJvuP0RbKZmRxg4ETpMwEgKD5K/RPDyiNzH8IFF7VX/DGcXssg4llZ2TTBjamKtx7YWTpz/8DUvnAWURZlg==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d049d344-2db8-4649-5edc-08d86b856cbb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:26:47.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8pY3AsiUodorwiZOe9zXWsZQ727BDAMCJr1FZlv8L9GVqNxgb7Pk/6e2RoFdhW56DRK7MPRew7TNDIM0ltegmeN3nk2ihicfAg70nH0UEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2347
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Drop unneeded <linux/wait.h> header inclusion to fix pidfd compilation
errors seen in Fedora 32:

In file included from pidfd_open_test.c:9:
../../../../usr/include/linux/wait.h:17:16: error: expected identifier before numeric constant
   17 | #define P_ALL  0
      |                ^

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/testing/selftests/pidfd/pidfd_open_test.c | 1 -
 tools/testing/selftests/pidfd/pidfd_poll_test.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index b9fe75fc3e51..8a59438ccc78 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -6,7 +6,6 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
index 4b115444dfe9..610811275357 100644
--- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -3,7 +3,6 @@
 #define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 #include <poll.h>
 #include <signal.h>
 #include <stdbool.h>
-- 
2.26.2

