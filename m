Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6049D28740F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 14:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgJHM1H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 08:27:07 -0400
Received: from mail-eopbgr30102.outbound.protection.outlook.com ([40.107.3.102]:26784
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729915AbgJHM1C (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 08:27:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzayCMfRSUDqCIR/xEKSWwDqmSDQ3kx0XumRnIB9YB/9qbxoBGF7E7XhKgMP/ldQle5rcUgrhcFESibyIG035z9IqmWOtUw6+hpj2ODOC60dHw9RJcZVMmsij1tDm5qkoeOJXIwoG7A7BB0f+gsw9z51M+2b/QF1K+BKv2ciGs7Fgc65OV+lNmL0eQqICRTdDMdy2yTWGebjIr9kBpXopM9Bj1WtY5xa+T2nO/1CRcRvoWeb0NGaMC7UULeWT3y7k9iiJLdtgEGf/hSls2l2v0dbKFsvK/RcPQksO2Favb4XfM/OtwIlnI9cCLXMlECbJ1u1Gs5nfH+z1UdwwReHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzohc8NPpE8vXXtTFCLX7KK4vCZK4MkRRoOj+6DpMkc=;
 b=dhzufNv4xnOi+K8t1b1o2g9ZQan5y9SQ1cKFeaZA5KmiUN8VDj6BnC4CKzAw+2QJRi8fSBoYxP+XQxkG8Wzy6ET7sUMKp+/cJkq0c4fy6DuqhwA9BcYITlgfdCMjvdvOgpOAkALXgcsWPzk5DwtAuH2yKp5/lsHVWGsTnBNCuOVSstxBAV9u8yCrlxB/6r5fCU2Zmx0l+Z2zrAKU8z8d3pIkGR8cmUeYQqjqBnqCKgC6eIGI1Lf7wa0IFZSyRLBMrsuvCIqKbyKHXfmH+3A/iufAnz92bxs2Z1s3EqZ1Cn20BgPcnHAcHbY9oC7FsPWMjzX0M7dkN7xcpMcdLOL3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzohc8NPpE8vXXtTFCLX7KK4vCZK4MkRRoOj+6DpMkc=;
 b=wyQXnHiOPKcYsYelG2zDfWBaiS2Z3Pt1jBeAhLCUTUxkC3VM5xrgl2AEmGZQpIok7SpuWgDYD+cn6ZkWgA7ECmc5VVSSDps0/p1Ftrydx0wq9H4GtIuCnpcUSLfF5shlLbltOnT8Q608L7prlkOOGYYYiyiA4igAoUfHB/BRUB0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2347.eurprd07.prod.outlook.com (2603:10a6:3:6f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Thu, 8 Oct 2020 12:26:51 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 12:26:51 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 05/13] selftests: pidfd: use ksft_test_result_skip() when skipping test
Date:   Thu,  8 Oct 2020 15:26:25 +0300
Message-Id: <20201008122633.687877-6-tommi.t.rantala@nokia.com>
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
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:26:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da02f38d-990c-4180-0d63-08d86b856ed0
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB23475765EDC4BA9538FC2116B40B0@HE1PR0701MB2347.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:264;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ww7f9mSti76AeXgryYlJUmrvTbN7lTiZvpfEYYn7FOJAefYSZRzZiQFF+OUyl009RN4VC7OvL1WOaJcWedBn8ru6GVXkrNq7kmjVoYw67hmek+H0Z0Hz9Hu/Q8Ds2wmivGsxytk8x0TG1kwaLc2jdo8RbopYkCRviNFKfxUGEjRg0jWs+sPTB6+ngjKoB0NIIC8rMbXXdCC36YyDjVoCci1w3dOsv3Pg0JyPmqFZQHFH3CUCK5kPzyQFTSdunQu0h9KEULeb8ugzCVORsCljgAzkwSkPF75w7fGp8wOPat6wb06GYkAOkf4dRpQCRJbyc7/dF1mX5WlbRJOHgP/8yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(66556008)(66476007)(103116003)(36756003)(5660300002)(6666004)(86362001)(66946007)(2906002)(54906003)(6486002)(4326008)(1076003)(316002)(6512007)(6916009)(26005)(52116002)(8936002)(83380400001)(186003)(478600001)(16526019)(6506007)(8676002)(956004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: krcGlC1dPNJK+28GbykaELSFShmfV6rUVcaFoxP/vfCyYU1BYDnIPyeFBEv3JTpWzmO2L6RHqVf36c2wS56xU08qHL5RdLM/fXImSRWNETCNT6VnqEABJYN+aNg9MWzkncsVB5Elgo2KN3mX7U4syZMxX0PveCeT1YOwt+4RBBaYofWERJuabURH9lRT3J0ndbqMkTdfH/buMzMG7zNIoeIFBv/271gH+EyE+pVCzZ+B7CFZdVMOjTWJQb0ZAMvtWulj8ZaBmMfBn/2+ISLQTyE6BVgaYoWaGLDR2r4wIvVZAwRgL/Xm8T/vU/yEug804diF2izzLJsRuEMSPUrfwFXxzx3zcWD9iRxFrI56p6NKRp6wU5NYl9sB8vUa4bZvM95eqXLmZtcfpwpm29Mqzhe0wSJg6+sFWcenlOJ/wybw3ABIFnS1Cy/BpO0NDePIvPUjizTCFZ1z26TrFiUuqgyQqxW52fdqJvmkm5NkugV/o5/tPZn0fVXgelFqEB/5ONVObUCig0u/xcd82e2t4k9LZis3u2J3dAf37PHoHuH8lUZbp40NdNgbLGzEyz3ph+cyQEEcbhuCUi9EjQOqhTyjWlf/FUy3f/OeI04hRFpnE3w47BGTRCmPXVsoJwFcP13p0pxFLXRuVIvo4TrI/w==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da02f38d-990c-4180-0d63-08d86b856ed0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:26:51.0664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3F7maxnw2brzZem9il7e6cBM9W3IINckgg1wROrkC+cySBl/UnExF7enEdzXhcview+WpBXWRvaDHqGFsWMWB6oG5IuqxHxhDlV2+iCuA+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2347
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There's planned tests != run tests in pidfd_test when some test is
skipped:

  $ ./pidfd_test
  TAP version 13
  1..8
  [...]
  # pidfd_send_signal signal recycled pid test: Skipping test
  # Planned tests != run tests (8 != 7)
  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

Fix by using ksft_test_result_skip():

  $ ./pidfd_test
  TAP version 13
  1..8
  [...]
  ok 8 # SKIP pidfd_send_signal signal recycled pid test: Unsharing pid namespace not permitted
  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:1 error:0

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/testing/selftests/pidfd/pidfd_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index c585aaa2acd8..529eb700ac26 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -330,7 +330,7 @@ static int test_pidfd_send_signal_recycled_pid_fail(void)
 		ksft_exit_fail_msg("%s test: Failed to recycle pid %d\n",
 				   test_name, PID_RECYCLE);
 	case PIDFD_SKIP:
-		ksft_print_msg("%s test: Skipping test\n", test_name);
+		ksft_test_result_skip("%s test: Skipping test\n", test_name);
 		ret = 0;
 		break;
 	case PIDFD_XFAIL:
-- 
2.26.2

