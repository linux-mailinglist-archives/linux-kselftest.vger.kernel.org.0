Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DAD78B036
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 14:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjH1M3S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 08:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjH1M3B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 08:29:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2104.outbound.protection.outlook.com [40.107.20.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851BC198;
        Mon, 28 Aug 2023 05:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUy5bQ/iDd8p00KyQWKVAnSI5VcoKMROGuLmLaMQZ5eBzicwhMY/84JBripQoU6BMi9O+i8TgLzt4THcRcVoL+FZY3+/ei3mSzZG/JYbr7tk5v9Rdlp29bYDchSJsND6+vzyp5fj/D8Ll5ys9iw9X+LkI4tVlRC8LcSFlb9gGbT+yl77uzqnbMF1zgyxLfYtMVUknCFTJCFAeyzvjeP8E21K/VpDuzf0d80q/A7FJpzoWeNeXw7wHpj4XxtigaO6ogGgEwvhsDN34DUEb3EeY3qlYUC/gD0YAHc3b1DSjgLu+LcxiXjm/fpyV20dARfMuJiLKTWuqqio6HuTnCEEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCE4pKlxfpEHlaaymtwqhceY03ZRJGtavqbhBRwkLUk=;
 b=O9AbBEmbWmoDvHOAN1eQtjwly0CJuChrl/x/rvr7PI/dkhDzV3bM9yhOyir2bq0PIvoRZen/vm6oikgYsJKlFwCtyv4mR6pwItoPHAkn1SIwz4brDHeAzBCrCHmmtX7Z5rb4hYEZ+FZdOOkesHsk7x1AUrBR29BGk0kBmw0NRYcfwbypUPmj5woso4aEoeYIfWAmvvFyjUAVO2xqTYID8B2RAzJlNEaKmkKQSYAekljULl9bo+POG2gZhGvPajrr4MsPMP6Fdv3Piv+jmEyXh5GVKZMpvBvuAKkNcma4rq4+1cyibcke1Uq1byvfl81CKs3yvOf21EmxYg2Pfch6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCE4pKlxfpEHlaaymtwqhceY03ZRJGtavqbhBRwkLUk=;
 b=EygHwJ1qk3B4vOKlTNuwxHgDhx9nPW/60V6D8KGIezgyYlTwH77uJ/eljL/gKy/whS+ApHnk0Yi+PeKYMWt4TjiP0fnGLOe9N0Cyp3qmuy+CtuTEnF86dW0v0foxlfI9W1aAFGKPNGBH1bUnMOJtMrqTkS1hiAPDoky/yqsnS8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AM0P189MB0817.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:195::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Mon, 28 Aug
 2023 12:28:31 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:28:31 +0000
From:   Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH net v3 2/3] ipv6: ignore dst hint for multipath routes
Date:   Mon, 28 Aug 2023 13:32:20 +0200
Message-Id: <20230828113221.20123-3-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0015.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::13) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AM0P189MB0817:EE_
X-MS-Office365-Filtering-Correlation-Id: 54189382-a968-4e20-6769-08dba7c24a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: on+fdWGmaGkveMkE+6dhNIi7ACdjkhnb/vLdGjRtgmiUD9OpuunmJPWZy8Ew55q7p+pHBzzdT0rcLiTxBXM6cZueNklQ5MY/zGCZ3lPNzHT/5yR7Yd+3pYM+JJaq3oCE0RQ67saRBFEZFcd3TLonIYn9Nwzvbz+RF2aMZhi+5qv4gJ7JN9S5Io1uLDSsph+yk/DgI9LMy8ID5hx8GFsE95l1wGZuW7OFFYSPmWU0Ytfjq1Uq8roDuRNQwTAASwxRw5iny7/rWGoyjVdLiOYNPK8CdnAYvIcvmv0kS4Cdfr397Ci5fbTWnmwhJT6ZtRmGxJXglYCoBa35q8bJgz5EZbrjOtPEQtq7wOrYVL6mWaiC4NnG2hN74RLOdStoSd1avi3Zm3QFA3GzXxOyhhw3/uOD6ib0apmIiuXdq7OktKsGYd9+Za/P98YwRV1kWpIUiexXcI/UnmiXZpe3M5Wy79+zJYC29iLF8Nh6YHoBotTHPcOtuBiK1FBGa726gJdYoEnoxNX0+SCgmq66g3CmogUa7fFI/eZpG9oMY9B01r8xFJodqUKOoz3eoYUxYNjq8z3uIkIuHE0BIM3Uy9cc/5kjVZqDaADqqsiTn3lpK3+4BKHscw4sllM9VJOkY3d3SCOEbEYmh/bSPss3eCo2AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39830400003)(376002)(136003)(1800799009)(451199024)(186009)(109986022)(1076003)(44832011)(83380400001)(6512007)(478600001)(26005)(7416002)(2616005)(5660300002)(2906002)(8676002)(8936002)(4326008)(70586007)(6486002)(38100700002)(66946007)(66476007)(86362001)(66556008)(54906003)(41300700001)(36756003)(316002)(6666004)(6506007)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A0r2WbnPsslOehp9jNThfrdlUbfIH+oXVxFBKguVYfP5H3O9MsFenVLHG3EE?=
 =?us-ascii?Q?qdwDrI1pONWYIJvQyXFwRt33qZH3tgmhJiy+sXeXTYfOLbmiQIGicFFVyebA?=
 =?us-ascii?Q?zWnDuKxniqIwT/Q3TgR/ZBsyPUixWPCd05N74fOEPklWzt8sDTQH89P+pBpr?=
 =?us-ascii?Q?Ms3JAjUKfTUzjkvfMM01kj+wu4jDwCggl5tKBuTxLu8QPEyXLdMM+ly28yL6?=
 =?us-ascii?Q?R9ThuBtGw4DAn7mNw44JE0StxHNa6dTs6YKKTb8ONprh8ZSEncrKkoopPxEk?=
 =?us-ascii?Q?tfOTCZsNem2DghOdg/KEhP/FefkGT+nlgBd9Pwy15O6phBjzeF8w5T72BjS1?=
 =?us-ascii?Q?wIgS3FP97ISvuuSEL7z6yk/Br04GLBXMJud31p0w0YA2iruGQnY/iqGR7Tud?=
 =?us-ascii?Q?F0LP/espgbcip+qHrznJjNPlWuy+zMBQCcWWgT3uz9jFI1ztQmZR/4Xh6xwJ?=
 =?us-ascii?Q?PtF31QPw3X/FtqA1uiYC7yZgxUWv+6ALuMOyumEdWYCQ7gpinznzokuGiShj?=
 =?us-ascii?Q?vUiC6VPxy86ko0IS607yPXg2g2AnMY3Q3wIBWSFBKZnlJmwUoky8LGhE1RNO?=
 =?us-ascii?Q?WwRz/7nnC6S0JeEEzFo8eu2tQusQwzwoD/g3yrCkOGl6cZP7HlLaX8BqGaRb?=
 =?us-ascii?Q?cHFL2QCQzaOfc9DDXSYiP2Veh00NvGu/AxPHhoR9oRS+tkXG6tXlNw2+hP6o?=
 =?us-ascii?Q?S/ecx5XGRKuaNFUnBjvzDLynDFkR4/o/nfLwGjVpzfo7sAexWZjd5bYWf1JM?=
 =?us-ascii?Q?Ej5tDelbdNEXG0Ng6EFTou+0IEjt6wxqouYU0nqp/EIJob4jJ0CyQcdpv1w7?=
 =?us-ascii?Q?X+yG2klE2lGH9c/o0Qj6yfEde9rvKBsGBFLc0wxG+rFDmYeYR1jn6lbgIYNe?=
 =?us-ascii?Q?4/nEy75omp7WSkQZJv0WbLhhU7p1aOjgk5eRawXA6X2oKtzbLSFGMqo1jfUv?=
 =?us-ascii?Q?pXcUZOwmT/oh0n3wz6IOLzZHsyrDmSESB4jflGa9GihvGivWLk4HBEIiv9/R?=
 =?us-ascii?Q?qAGVxBP9V4LT9rmMJTPAygleHnoLETzcZMX4sbdRN9CnpH5aga6O0XZBDR24?=
 =?us-ascii?Q?asD7+bwt9ZK0X0kewl2u6vSFYXxzffo7cBdxC+akS0OdxUspjFXGotyX/eNZ?=
 =?us-ascii?Q?d7wF4RsKHQ0+nD8kho4UwH8XsWy1tsf8aMM68cXltLF1r7U0LMCOf2kolrj7?=
 =?us-ascii?Q?WZEEWM+ADGylCL4XrNgFLDWOFOe9CcmksBm7/dHaETw61XiBZ2vCQWqtUiHx?=
 =?us-ascii?Q?dl6FPa7/ZlnEwNLT9Eyut6kHhm7N2c81s7dDs3lKFylMzHeXksY13vjCapw8?=
 =?us-ascii?Q?C/WhwfqBClBNqKf+/FIDXvBAvD4/vJcBNJ9gy652Ym6WDfMdKdMYGWzAvwP+?=
 =?us-ascii?Q?Cwagnu6SG1Kzb6wmq+QZtEUrDM90IaLkMyTKalSZltPJAX4DqYHcfuqX8Ez1?=
 =?us-ascii?Q?fZgGeczRl4AYvlekb9mDrNiB6XIXc5c9XIenmIFQljJFWnRjfJLaF3jWyXXo?=
 =?us-ascii?Q?Pjl0sggeLss87wcmtozswYvjqsCvh0ThD7AgAL8uYe1deM4ZEMgadVQlLBAW?=
 =?us-ascii?Q?Oas2vWd9Zt+l+gZag+V/ECm8wp5AwRvc6NeSQG4InIHbS3MnjrCD37ZWn646?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 54189382-a968-4e20-6769-08dba7c24a6b
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 12:28:31.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mApcCxbGhFC4P+DwHemdRKtgxSQ4E65PZS8uUWWNLVZcWQvYye5bZVFFqlbOHmhyYO7cYfnM50sa2jvEXq23RM/rkybxUS8ODn35FV5C5/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB0817
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Route hints when the nexthop is part of a multipath group causes packets
in the same receive batch to be sent to the same nexthop irrespective of
the multipath hash of the packet. So, do not extract route hint for
packets whose destination is part of a multipath group.

A new SKB flag IP6SKB_MULTIPATH is introduced for this purpose, set the
flag when route is looked up in fib6_select_path() and use it in
ip6_can_use_hint() to check for the existence of the flag.

Fixes: 197dbf24e360 ("ipv6: introduce and uses route look hints for list input.")
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 include/linux/ipv6.h | 1 +
 net/ipv6/ip6_input.c | 3 ++-
 net/ipv6/route.c     | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 839247a4f48e..fe3492a67b35 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -146,6 +146,7 @@ struct inet6_skb_parm {
 #define IP6SKB_JUMBOGRAM      128
 #define IP6SKB_SEG6	      256
 #define IP6SKB_FAKEJUMBO      512
+#define IP6SKB_MULTIPATH      1024
 };
 
 #if defined(CONFIG_NET_L3_MASTER_DEV)
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index d94041bb4287..b8378814532c 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -99,7 +99,8 @@ static bool ip6_can_use_hint(const struct sk_buff *skb,
 static struct sk_buff *ip6_extract_route_hint(const struct net *net,
 					      struct sk_buff *skb)
 {
-	if (fib6_routes_require_src(net) || fib6_has_custom_rules(net))
+	if (fib6_routes_require_src(net) || fib6_has_custom_rules(net) ||
+	    IP6CB(skb)->flags & IP6SKB_MULTIPATH)
 		return NULL;
 
 	return skb;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 56a55585eb79..a02328c93a53 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -424,6 +424,9 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 	if (match->nh && have_oif_match && res->nh)
 		return;
 
+	if (skb)
+		IP6CB(skb)->flags |= IP6SKB_MULTIPATH;
+
 	/* We might have already computed the hash for ICMPv6 errors. In such
 	 * case it will always be non-zero. Otherwise now is the time to do it.
 	 */
-- 
2.34.1

