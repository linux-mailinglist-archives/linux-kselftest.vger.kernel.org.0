Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CAC78830D
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 11:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbjHYJJO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 05:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244119AbjHYJIv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 05:08:51 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2103.outbound.protection.outlook.com [40.107.6.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6CF1FC4;
        Fri, 25 Aug 2023 02:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBpYAdC0uc98N35CUyKKJkhOOyEj+ye7zh+cuon6RVHr2kD9Jrr8mvBA3g9RPsamRSvBzWlGHejByQB3APUUe2PkOGAPR3VAcXweznLotxXj3zPe9xVR7Pp5Yb2yVMwUuYUGn9d/5uXW06GwMy3lUfcqBaCqSzjzF83NxQZNeHrYTNvCcigxwStrI7RfteVKJEFnpiNnvlQigCGN0H75rq59BWnBJHtPPIORbgZUT2Q6Qk8QVZQNSD7UbxbqzVGUxQNJoUXD4m8GOYShg5FHowJgQ1gWIiOYVpE5lHhdTWYwDdJ/tZmWNqsQXnfwhPb4ssB0HxlF9S3+F5RilQhJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q89TH4qzI6EqD61X7pPKSlzcGLJ6xTonkvVtjY+AOJ8=;
 b=hHKAYfdfqXdDEzWBoqrvpeTZ0qaE/siGOT8qCKZpqULsyh5uNqkyB8Y0sNShJXCl75ioeBbbETL/ifJwrx4SSuuExyntAtup6mdB16BTQ/FbmMBN0LeluqzvCD+kZSK8Gc8Ip5zAamklqQ6Sj9ej+V+j87SoZ/sJmUT0Riw2yaLkdgMVk414Bz/p5CfXIiBlWdnFD7yU0cSFVJUuChwbwA+QVpx1KTtv6g9sXnT4WafbaVblBTJLvMKnj4A5tviFxOeaRY+EOdAYP4hBwbwHe8q2vMezfD9N9SdbQRoC5oBzYzvREmmkwOqE1nvy3Z9amsvgeyVaknBLTicWRERNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q89TH4qzI6EqD61X7pPKSlzcGLJ6xTonkvVtjY+AOJ8=;
 b=dQv4ctICcxuN9ECab3XI2zfROZjUAJf09wPrssF+alugdHgYdzqJ3mztreAtOsDaPL4/lcIDkQ4HxVhErgaP9f20Ml2XaPxgmqqKw14cQWz9CSVcPGJfMgKVgjIgD8M17v/TMKZt/1Ma09DTzFqJxrSrCcrLPp2jlb6UGKlaVNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by DB9P189MB1499.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 09:08:38 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 09:08:38 +0000
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
Subject: [PATCH net v2 2/3] ipv6: ignore dst hint for multipath routes
Date:   Fri, 25 Aug 2023 11:08:29 +0200
Message-Id: <20230825090830.18635-3-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825090830.18635-1-sriram.yagnaraman@est.tech>
References: <20230825090830.18635-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0022.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::12) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|DB9P189MB1499:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ec5660-4e70-467c-206f-08dba54ade94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFjXR2jiUigyXBINFZMeWrSuHHqoxrgBBVgNQztcMeZrzoKpKa7RlZnhZ2VRqdQvR7e9bmQyqoej4uQsZAhQNPWDXDDulLy1xHMQIGBM2TRA8zNrrOsIOs2QkqeemR7ijm5hvN3DFVnjD8nO2kJ/009S+xZ/7G0u4kHsyMFpt2w9tNz3L6niWGR9LfZmXC4ukpPyOFI9O0hDxNVB1At7nbQZFx1O0GlLpBYdPf8pLWtQID0l5KglKXl/FDGK1g7A3Jz59xn7gauNrO2+5Zbn0OVrQuA2bKNWz/IefLmVDCMd7+YENxdD5DkEqa5Wb7AV6EbAi8suOqEDJEDVD2irTkZy81WwdtaO0YwNUfStmBo7Sd40nVytWHrMhXdRnmUIc0MIYyDkye9XJhCsKXwpMM/aK2AunXm0nPCtxkXNkpBQL/BDIzUDbFqjCcgPVryXH/WFDgApGth+rIafeJmtVhCb8VLtisqC8xnm2L9/Ju7jjFnVMQ2ZRIFRRE+8jRJ3d9Shr2MHFPXZUJ0MDdHSfplwVgrMDX0LPVyJFl7+dLZ3gLw2oPrtO8Nn4cfnxYix7bz8/vTxXp3cAK1g3Yt/+pv7jjUgkgPXVFSmG6UYGqHOckLroKchLaaIlu2RaPqymglrkKW+QZjmGcEsk2ZUMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39840400004)(186009)(1800799009)(109986022)(451199024)(66476007)(54906003)(66556008)(70586007)(66946007)(316002)(478600001)(26005)(38100700002)(6666004)(41300700001)(6506007)(86362001)(6486002)(6512007)(2906002)(4326008)(8676002)(8936002)(83380400001)(2616005)(5660300002)(7416002)(44832011)(1076003)(36756003)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vR9a0i9SlbQ7D1ZOFxURxvPcSFJK1+Atmu0dKtkNKIUAIBvFowIF1Z+8ixuT?=
 =?us-ascii?Q?uzXzuNUw7ygX6nDgqmY0hn4KlAinH9zPDJmd6CUZEg/0UcoMjtbxnVYQ/dyR?=
 =?us-ascii?Q?jAHG1eOf7lTR+7WjcUYrDYfaup1rebsDP0UmesV1cMICIsEl7fgneWHcoaR6?=
 =?us-ascii?Q?JHPRh9rOj41kGiAb4RquuIdYwZDp4C7TRAhdaekNp3LMo9Zishb7MpXPAfkA?=
 =?us-ascii?Q?SeN4omiPDwQVauSwzj+84Xvm0OJ2pYi3O/lLKV+hjFf7y1S7xzSG3HQNTH0M?=
 =?us-ascii?Q?2lmDyKXPyPDHtkzJOMPhHmOeJoM855mJ18PpamH3yIg+7daFMCP7U9omm/GM?=
 =?us-ascii?Q?QyhX7brM/gtd2cucAC4my4RxIlofG6K3e/CG/QnGB38rRQXQ1kL0E0No91AH?=
 =?us-ascii?Q?lEdiKGXsrY4ZHR7GXbooKPYCFL7Hq91+dQytJ0IHNRL/tW4+TYcrEoirnWNq?=
 =?us-ascii?Q?AqdFhY14m1iPYAfjcpcQs3KjjmvEtWImLfJ0DCoSK/odJlXXXoAo6zKPcCKj?=
 =?us-ascii?Q?cOKtzFWqyyF4DHPLod/VyjCPbBVOaGbFgf3XAsQpyXXRVfzhqHqhq8ifcH1d?=
 =?us-ascii?Q?bpegFMTLbFka3Sz01Jhj3m/vJ0LJrP2VVVOAX3TXQAJsTWeG9HV/kXEXVK2i?=
 =?us-ascii?Q?oYUP67wl6NLUHpKxiv9xv1KWTkXanmnlx7LU+Hwmerb+XtdHcnB5yUc3B+3t?=
 =?us-ascii?Q?1NegSvQ1LDTJzMYNwC4MNRrQ1vyrFpd+MHZjNO6yJGDgiqzh0vPdhhXH8Xov?=
 =?us-ascii?Q?r1elqCGKCKM65oTnF23X0nJ+qIaVlYVVxo6WF84bQFDCxbRNh2vZx/L5aiUE?=
 =?us-ascii?Q?eSbX65xDZUJcZR1Kk+uN4HUtN9vWd+qNcHt4sWbGnuin23FbiYGdkw6RU/y0?=
 =?us-ascii?Q?soAGIJyZQYvr+o+JwwpIgq/eHBmGu8/dRXDriVwzm3w1+XdUnFBR6Wloe3b5?=
 =?us-ascii?Q?eHubWXSVbYNzxEPVNHdP9lVXLvLC8b3eqHUVE4xq7l3znoPgwTD2ekCZ5yAf?=
 =?us-ascii?Q?3r6NJq9uh2eOxtwsn2ffRbod2jsiLv6uiEZQs9kSkdt6OEtBUaqGgi3nk+iO?=
 =?us-ascii?Q?QPGyfrRf3j4o8uG+NddebplumvsGcZRb1uSPCncgPI/AIsByBPDxc7QR0Zt5?=
 =?us-ascii?Q?tY1awKgZaL6818CY3rEs1ANkkfdyLeOAwTSiz2mzmhqGn6Gcel8SnvuTZx1B?=
 =?us-ascii?Q?2znKNeZsyjj1mKe+DjKkksI9nB3O5zpbv8Lc9344Nyz6XyOGLCvDQ37QN8Pz?=
 =?us-ascii?Q?HulxcFm6Y3HbeTR1LMJsdZfa1WZy4hx3UNsvnxjqJFgW4XCtoF0jJxLeXkOl?=
 =?us-ascii?Q?/xEpyXyNyUkfafy1NKDpAobsEONB5gd8D+Ujj2SzXwT7MJiOCgVarlk8unkj?=
 =?us-ascii?Q?HAmiU57GeYCzMgmrkjhR33z9K/UCIa4FPYik0CX7tNPe6hlz/7Sn1ojGr05Y?=
 =?us-ascii?Q?iib+fUNdIpGFQPScMASpMAeZE/OVpVbkQ+E9Vqb4ic5x8LREPvwFHgf9YgMv?=
 =?us-ascii?Q?jlkxHT44y0+KuyUueZsWPLVUPd/0ZZClcIFCjb/L9n3rC4r4w2LF8zm11hEq?=
 =?us-ascii?Q?S12t3W3yXqRFY5Vk58cluxgONpPYGlvGpQOM5w+I943RlVs6qIwGWVwpNJ5Y?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ec5660-4e70-467c-206f-08dba54ade94
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 09:08:38.5120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVxtZxgzCb0XQrE4bRCDx+qJZO/U4bs7rRKIS2niXl7s+WNl1rni6vePkOkqj24mlXyRPGOjDoB3HrtUSaE9dOyPaoxjYuTUmWcCSP3jeaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB1499
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 net/ipv6/route.c     | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

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
index 56a55585eb79..4631e03c84b4 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -424,6 +424,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 	if (match->nh && have_oif_match && res->nh)
 		return;
 
+	IP6CB(skb)->flags |= IP6SKB_MULTIPATH;
+
 	/* We might have already computed the hash for ICMPv6 errors. In such
 	 * case it will always be non-zero. Otherwise now is the time to do it.
 	 */
-- 
2.34.1

