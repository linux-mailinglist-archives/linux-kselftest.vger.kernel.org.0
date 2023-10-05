Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8721E7BA2D8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 17:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjJEPso (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 11:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjJEPsD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 11:48:03 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C467A97;
        Thu,  5 Oct 2023 00:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fekz4rfvdjDE5w3f28kP5ng2Yf+2XVTItCEbITWF0Mfe2JW/9n9pFu/ethT0VxHxC2NFWwUT7BoPWjYO7G0LWptmjSQ7Gg9nNqpADBb4KkPoBu1cXOVZ6S2qJKAkDilkjqc85rxCZc/5AeQ3mMtStoHDXNdzUdKVZPbArtETmoe6Q3ri+hjICCs+QNqGCSYiBdApX8GVe/wojEN8cR9Tt9t24UHkGN8u6wUVVUROkw7pj5FhBPEJoW0xB97bQ8A45SMk+mVndjnlNgGpkhQsLstIBXlmdbSYin9nd1yZ+1zv92BauJUlqIy6CSPjSEMD9Wl+yQ/3xT4G3WEw8Ecrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVMQuwoQO5/3D87+dmoupZKTye3tTF6lYcDqr6ZiP3Y=;
 b=IuIH3gmk/nK7Nz1SK743gZM6lVCo56CXCZ9FQhRzG60iUht0sTXK1CDBv6t9zHlke7pOuGqiOfiBivf8nP4YdBUtHZLZsLBu1v+tVqvC0xNcQIhs4JJVpKVi3kxfNcm3B+czDmasaWYSYed57Gr8aNymQ+jizJmUkog+uvjCuXaFcS/5yvgDMRv6uqaJJKMJxcjSGHA8+fDF0wXvHIwNBntXv7mAX55ja77cxgaIgrVUW9gRug9GQUOjt3YVgIWKxWAWnefKDywxRalIfdbmK2gBPQAMiZKFDzORczu8785kbO5w3GdtpcnweeF6yhuFc7gybptFnBPu63Snv7QDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVMQuwoQO5/3D87+dmoupZKTye3tTF6lYcDqr6ZiP3Y=;
 b=HdEEZr1so1glWio8mYRNKtb+uwbdy9fSzt6mxjos+HQMwgF0kNttAUdKrL+wUWcItOjDdLY1VbCTSmqYt5Hv70tGPcFPo/BXTa/cHx0YuvlSUJn+ZYlu0S65tcJm8uc51+D2jX1bBxgKmCqAm0gqd09wYC/fx/i4ZPSyE44x8m7qR4UimMUPKX9TXJTAMTwSX7IC8oO1If/ChkkaXeHFJpqkmB2t23zc/IbA3sNbyAJoSXXkx92MMAIMERwt0QiBo1NXPijPQTKX4DFvBjlwHvi34Q28yyr8143l8QHZ8vCRmEXU0bzhJVBRbcZ1PSm3A7J6IJG+qESUK3Ww3Qu/Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8999.eurprd04.prod.outlook.com (2603:10a6:10:2e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 07:20:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 07:20:56 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Enable CONFIG_VSOCKETS in config
Date:   Thu,  5 Oct 2023 15:21:51 +0800
Message-Id: <472e73d285db2ea59aca9bbb95eb5d4048327588.1696490003.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1696490003.git.geliang.tang@suse.com>
References: <cover.1696490003.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c967514-082f-44e8-63f5-08dbc5739d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ug+pWSZAvqLfeHbSGLXqsc+sNZEOCXzRCkH+Wo6IWpS9/ARkM5v0YuQQ8l+Hm8e/iDtQdxWgmxhjg/PCZBi5A4vkepNythMd0xVXZp/s+U7PcGDjP7Yv4gXW7AI0mQwFiHqbpdpfH9tS53YCkuMt/NNF5SERn7Gc17VILsAzFyroEJFdBUMWg8r9Y+OtrEeAvJmzpOBucS4aiuSTkM+xa2gAj7F4WCZWtxP5wmFFJtX6ZU2HTLnrK3y5P1CmTYGIkvO66vISIc/cBu9Zicj+oZs3u3r8Ntie0WQ4SrgfXpEjs86VWDdtMGP3szZuUwCSSErhHr5uVQvvw3/Tp3FlY0+ZlxOVTQhwP5y8MVtkif/Y/nsqkXuxNl6Qo+CQsLRx2cM0CcMJLkvZC0PjezPhzmIy7vn3Y03d1H0PPdu4xDuWmR2LrvVedGtqKTGWCVuAHA4BcnqBFrXrhF6fuE1xuIz+sb/RZlLSHEWJc4WCSSKLRM1BAH4IxliLUSFZsvxKB3e8WUv7hvGfvZijDLBQ5x7PcDJReF+MZB8vGMZXFinXpjE16WvxLq+7RFD3pUHo07tH8i7r5nOkwjPYyO6nzp58WsHGG8ggY7rJfoYEiP1IBMe3NWukGYOkpOViJUdE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(44832011)(5660300002)(2906002)(7416002)(4744005)(6666004)(38100700002)(6506007)(6512007)(921005)(478600001)(86362001)(6486002)(36756003)(26005)(8676002)(8936002)(4326008)(66476007)(41300700001)(110136005)(66946007)(66556008)(316002)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jCq1n8fMhECiPnuU04tlBz/DFCli93L0EMM1RINcvaeUMgWoubaXbXxg3Okp?=
 =?us-ascii?Q?4DJ230YSuox0GXl+ncMQCJDHWUg1vDmRKJMPF6lP6uS+EkwdlxCsTA6geOn4?=
 =?us-ascii?Q?sxB1rMusxhK8zcHz1aY4uo3jHOa1mOzyK2IhJWBr9Z71fKSzxDW1mvsEGiSW?=
 =?us-ascii?Q?M/aEljwhc0lEbIoUa3zuRQgGrPc86h5XyfmTvd9oYBSwBtfbQ8r5Rk5Oo3xY?=
 =?us-ascii?Q?e6RctV+jeNBdbD5QW1apmX0FFwc6k/lvrmn9EjeEIs5yNlQ4VQfRKaT5GbjV?=
 =?us-ascii?Q?0+T97PXoedrEI/WLnslIYcJMScDNp/MdnGVsupphzTxSDYX6XEzQ/dKfDhG2?=
 =?us-ascii?Q?jUEnofWypNaz5tbte/t4/8fZiUVqnYIa84mq/yh4tQxUfmtmdDKnluhmQ+Qy?=
 =?us-ascii?Q?pIjhzzuXdJTg7hVHAiekocmH038ptuRIwz5O1zWM4OQRrfv05j8RIJxXIZ4I?=
 =?us-ascii?Q?xRcR3ZnGAGzIc8aI/47zI/dubTsbdZtktsQzM+tQVPNLEy9l3U/uCRGjosyK?=
 =?us-ascii?Q?bRsZxVxbiMkZOu2z9CsPIUFDVceU0paOThLmenIsohYQbzMHquRW6VNyGwZ8?=
 =?us-ascii?Q?KMeOBITBlIa/AyMbNHanXnpOjAsjTZ0o+XQObM6Av56TZehUr2aIhysjoRMc?=
 =?us-ascii?Q?MWTJ0Fvo+jJE7IBVWy+W+1TJBgNqHwgIg8KO4EmDnDh5+LrKSf2DK0EL9yVY?=
 =?us-ascii?Q?cQzcQQ6OLm/gwVPinUTXkTJY0p2s2eDd0k3sMLJCE0yLM44ocxjhs+NX9TLT?=
 =?us-ascii?Q?N62xuL9HZ1QnR/YMRSydzfhkygLVjDhD9EeqWhVfoiIy1lpbDSxA+pA/BZyi?=
 =?us-ascii?Q?Gqc8RNQ8kze/pGW6LkqQyfyoYxLl6Mb4+V+y9qaVqXJl2L5AyAy4p8ktsPbK?=
 =?us-ascii?Q?c+ppzerTxG+bUkW7V+IVBvCdoBeey6HjuK0Oxu+GdzfFXcSZqdj69BXY/9tu?=
 =?us-ascii?Q?t071khFGaLLAGKtpmBMlTHs+1A4Bk355swEk4h1obOHwo6YF+QOUrCE52V9D?=
 =?us-ascii?Q?AHcPylu/Ttquai1GO8HNZQhr+iFoDTBces2z3G6ws8glpxRtPn4pgoJ+r9nr?=
 =?us-ascii?Q?3MP4jPl+dLsg3ESE/KPXgLBy6kldIG3yniX+fK5ZCNaKJOWBHLfWZf46WPfZ?=
 =?us-ascii?Q?JO35WfrS8rUQgEktsisIos6ymJ7qFI+7ZeBHUEonrkFSHmxNBFgRuTv8x9Ks?=
 =?us-ascii?Q?/aq/Uwp+YSTwjyENLLqsN2q8lWWrA2lFBE7X0FGIIcDFCw3mCNBj04OizZqM?=
 =?us-ascii?Q?xSg+r1ikP1Z6OekZ7BZqRUkYqd9Degq/nXG0/wkrL+nU4KWJTAEI+UJcQ7J5?=
 =?us-ascii?Q?idS8Eh8nxIdnn1eLDMdhRrAtBjEIRIcZfxn4azuLrR12SY08fs1ks3bG2CUX?=
 =?us-ascii?Q?cGxyLwhN/r7VUWcuZHPRHPHdM9XEjNO1rFbYxGtavwR0mfFgpYmUl/laBu1O?=
 =?us-ascii?Q?hDZFxQ8+dQqkgnfxsGomfM4P1eJ10f4o8+dQzcxpie1lEnXtD0FWRdjiGIm0?=
 =?us-ascii?Q?kVYTpqcoyjvHHqeO3zjajQYewNDLcs/mcWTg447msJ0C3w/0vPT4uFuyaWuC?=
 =?us-ascii?Q?XtXah0bjWCGurRm5S9K00aocsEg0edk99btCMCAl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c967514-082f-44e8-63f5-08dbc5739d99
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 07:20:56.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tt3SaHrCC/z+lY68r/RgCE/7t7ihi/PCZ6uDf7a/zAsSpX5ci+XunO14+AyFy7wdLXiEvuQC3kp1aZcWH+LK7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8999
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CONFIG_VSOCKETS is required by BPF selftests, otherwise we get errors
like this:

    ./test_progs:socket_loopback_reuseport:386: socket:
		Address family not supported by protocol
    socket_loopback_reuseport:FAIL:386
    ./test_progs:vsock_unix_redir_connectible:1496:
		vsock_socketpair_connectible() failed
    vsock_unix_redir_connectible:FAIL:1496

So this patch enables it in tools/testing/selftests/bpf/config.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index e41eb33b2704..02dd4409200e 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -84,3 +84,4 @@ CONFIG_USERFAULTFD=y
 CONFIG_VXLAN=y
 CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
+CONFIG_VSOCKETS=y
-- 
2.35.3

