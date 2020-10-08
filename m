Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72722287421
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 14:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgJHM1l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 08:27:41 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:33432
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729939AbgJHM1I (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 08:27:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh3OogAj6xWazGKNQyrCNMk6Bcik2Y47ogVlfVJOmicc1heTtSc68AX84ei0U9cSsslNNYnIWMys5bJJMm4rrp6+y5WwlkP8MSAkHAih3dQQVjSWd7t/XzjxS4x3ChYqxblkAPvaNpGJMEJaRTaWyP4DMUiMVNY4tH7BehHhlwgTbDoNJz4uqkpk5oaW5xqm0vxiUGuNFSaqP0I0n0r1n2NPCkHOyVA8kazI8mdk3i9cKhLRk+mUA8eHVm2nLW2RrMUHhOg4EW3hfIk+kYliZ4VXtzSgaoNl0+iv8IB43kkWCTbXw+CdtMCExHVPnlqVrVKLxNDbAO6aoD16DqX6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V8V7hvPdD87KEwNoxinB3bcOm2zpVNQYvV1P5UpCCE=;
 b=lG28dHjbbp6pv79NnYxwYgfXxq0T5KUj8J0Z1XvPuDlEA1FcGVpPKbMl5IkHc0AN4a4W2ygVR4nPFj1XRTP5OJQ7wrPtIB39XKX1Jan61BHuaSMsWqHOwPYOPK013xUpozGbQeUqmZlBgVY4N34jdYc6CFKMGXit87OkgPFxeHR24mYK49dGTcPvYlJS5TzAb45n3wu6TtoESac/PI9M8KNK4/7Xeakm9GUtL2wWrALdEtaVrcDsNvaH0B/9Vwd9EMbWusCP7he88bePBn/R9NN5y2q0+34VJ9/FXMe/+OETex0r8Jq2def5Z2uy116qQO34AYXhSvQgZ29Pj0D5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V8V7hvPdD87KEwNoxinB3bcOm2zpVNQYvV1P5UpCCE=;
 b=t0ZvnKRf1De7bobWtxZHbyciILxdOtDLlZ7+fOeO6R5WfBX2ZekFxLd9t0OO6pWFEIM2ttim5IHNyFYQw6NWS5nAKOQkLpulCRZYtLlBb1XxiQnue76P4WiIU7NvqMZWirAlQiBTztK//JA1+sfblKm1JzGmrPwvldsRZVlrxAU=
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
Subject: [PATCH 06/13] selftests: pidfd: skip test on kcmp() ENOSYS
Date:   Thu,  8 Oct 2020 15:26:26 +0300
Message-Id: <20201008122633.687877-7-tommi.t.rantala@nokia.com>
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
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:26:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5da0ec03-8547-42dd-85aa-08d86b856f5a
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB234732368B38EBFF38F2D984B40B0@HE1PR0701MB2347.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljCjYhPApl8/r6TYrZmyhSw6rcjZpH0jUGi13/q+Aql9SynKhM88D/TS12i5GSGHS+exCNabsoSB1IhWox6X4wuliKLUvZzf8jrCa/lBNn8DaETzwM785pUmO9DBJMHCtM2Jqa6Lqdt8iA7W7ZHVijEGr9uqbYWhmWqdLEp5930cwSSD4bovguHd9g0uwpaWO4Kyf1w6+R4sjSh2Gq0hLHVYKstNRz8UCSVXVnPoRVcodQl/kOWiaosPbdf8Y4FYyL/SPOdM+JvReNMue9XFgbPFUMCGXVUTDBL0ptE/JmLu/Zpe95d1Vr96K1aotuU30Ykt9qbU/p3gXO213cFynQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(66556008)(66476007)(4744005)(103116003)(36756003)(5660300002)(6666004)(86362001)(66946007)(2906002)(54906003)(6486002)(4326008)(1076003)(316002)(6512007)(6916009)(26005)(52116002)(8936002)(83380400001)(186003)(478600001)(16526019)(6506007)(8676002)(956004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ShsUJzLAQYFD/WZiCKqyblbR5/qKidNn+NOjofmn4csCAmAjYYAMVTuFZBMBHJXEnBUFHVaZUcR+bKc3kIKbOrK506gxLT72TrW3eDsvIikRvEho65nD9XvBiEPyLX+0H6bfAA/ctJqGXS92Wc44VU/RC03/XKJYaMYl0oBHuS1031WNpbT7VbjG6jGaElFb0iWfv0LdA+g9TVQr2GZo3nA8ORms8fL9/5ZekVpfCHEGw9s+sqEe46MmcQ0IuK/l8tx9xEHXVJFIFwsIYMUSdsEuyBROnMrw7TZMoQ5/tv097rOWpsGDM9FphrlsILqamCCvBo9xAmi/CXUh2lEJYAEtQZqK8qk/IT066ztIZduZ9bXaOnF/BrKlr3CPP4Szu8CdjqvxqMm4JAPAoAPYYpD4IGA/6qh/0SQgzRxgk5e7K/wux6DzeVV8Y0BTtKjF22CYyitE6q6c5cVBShxmD09N5fKYKR3JuNgpRX1VvYinhHc8QflAhXxAdPNT8i7htkRZf23nqh0YoyKZjmKbToP9QBM30fL6466K2xEQB4UY/ivIRZx+3a35RgMKntXR2i/iOecRDihtEfymnurAatDbN4pAklXbw5QRUf08Ybwq9/NZGlHUAYbYwfOsKYrIA1MApKEiinH7g7PewNvv8A==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da0ec03-8547-42dd-85aa-08d86b856f5a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:26:51.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5f35oM0C3HWvwydmjgOV3xzWckw6esw/hwflSnF1OVddsrJsapVKUPtY8/O46BBogJwCOkdIiq1f6T4e80TNcGKqyYwo7nK6jtWRVAbuZcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2347
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Skip test if kcmp() is not available, for example if kernel is compiled
without CONFIG_CHECKPOINT_RESTORE=y.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/testing/selftests/pidfd/pidfd_getfd_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index 7758c98be015..0930e2411dfb 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -204,7 +204,10 @@ TEST_F(child, fetch_fd)
 	fd = sys_pidfd_getfd(self->pidfd, self->remote_fd, 0);
 	ASSERT_GE(fd, 0);
 
-	EXPECT_EQ(0, sys_kcmp(getpid(), self->pid, KCMP_FILE, fd, self->remote_fd));
+	ret = sys_kcmp(getpid(), self->pid, KCMP_FILE, fd, self->remote_fd);
+	if (ret < 0 && errno == ENOSYS)
+		SKIP(return, "kcmp() syscall not supported");
+	EXPECT_EQ(ret, 0);
 
 	ret = fcntl(fd, F_GETFD);
 	ASSERT_GE(ret, 0);
-- 
2.26.2

