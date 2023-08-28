Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF8178B037
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 14:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjH1M3R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjH1M25 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 08:28:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2104.outbound.protection.outlook.com [40.107.20.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B818F;
        Mon, 28 Aug 2023 05:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vt3w2SiJ0TLcQs65e1Dk3DAfIYhxaZdJ8mtGHHA4aX0CuzbGGK6CL14CsqE7ZWbOdBBVvz6kR1HSo+TYqVPcZm5wbvsk2wHjZ2KXXua1dir5rBhBuxWDLU6gFJ74UXlsiaIpvIRDVKikDOyZJg3BMgf7PyBW0p8MrXcKoxDvOKODibt2PVXsabBzkQd2z0ZWVQTd4r8pMx99w2tDyMRj7PeAdJ/ylRj0dQpDnfn9pgzhfi9+E04aaHjzhM738/CJ7lwvC20XD/QYd/KNVnOGnrJjg5Adzax+qBj6qksMhmfib2sfKAEYJNIDebGHnFrjGs1bJsHmznYXRGV9trbQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK1SaxBau9ezB/599xhQ+OmyNo0RpfRZjw0urTfez3U=;
 b=Pwq5eFrVMy/ICwuibPz4BmWUY5OTTzGr8TkdUIukD1U49xjfIz/EsG/N+2V0p2r8W/+u/MU94BEhFscNHUYYI1Hl5sY/wZub8JAYFaczEi/A6bwgf42d8KjLUDoaR1/3kmxI1z2S2oqrxucio9svtlUCb5xGB0nhPp3qBeLfoCk8kWCrngzB8ibSpQyaCnsP0baHU86gSu0mP/in5q1CUgHoIa0dsUVj2rEWJ/BsaRHJhZTzsHtX+j8+M55fdw8PzZoMb0uc22T5AZ/ev1ppNKvOO4aasjEDNAQSi0jbM3bqkIXKAadOyzwXypouzb3wkLeadn5T/edGxDklVkZlqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK1SaxBau9ezB/599xhQ+OmyNo0RpfRZjw0urTfez3U=;
 b=RuF1lD4tP8IOLqELW4kjpILzDxabUewBnl6XjNBbWidFwPokF7//EE9lWMC3Dg0jCjYOKeeacho5/fV5pa4F+ichGMtlrYrKVry6sf3StLWLxJcCHBhW1mnhq63AF5x0R29r0787qnci6u78GaYbgQFrqJPYiigTTQP1tUs9K7o=
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
Subject: [PATCH net v3 1/3] ipv4: ignore dst hint for multipath routes
Date:   Mon, 28 Aug 2023 13:32:19 +0200
Message-Id: <20230828113221.20123-2-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::34) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AM0P189MB0817:EE_
X-MS-Office365-Filtering-Correlation-Id: 979aeabd-d43b-4f4e-b7e8-08dba7c2498d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ej8cWE8y1YbVuAqj6x7av3u5HgJteevVpdiKL+1D3jH66m87VC0w2cQ4b8kr3Zs7mqLAoBcRkdI5zmfr2Aqn+YbX6DZ2gmDk6lt8QTzPHytUOI3dPlK31YFGP48cjmc3TNBpPkxWpgXMSA4wLZRSLvVFx2wBYm+cxSRuaC5mKlV5JyRlloGt+tt+4Lo2yMD9fy3dTcEwI/dSzD+81SwX/7KL/9OOaY1xiFcsDOxFOkA6samA+/qaXgqZ8q2ex+kD3O7HohVnLo3Bv7Xfyf/rCsrS+ib/Ey5iRvy8BU/LQ8D6YRcTC4irFNKd4b6lppPgJhUqvXdcgAYIHT9NumTNkoSWwU7/Z6+iEMdMqSJtsMYnGAYG8B7gyTB27xQO0lHDnwfSIs2ClvAFpcfupRWkKcuF+QOrR1Qz5X7oYscaA0ZACwSsUJ4FEX0LNH3VJrDds9Q0rGMCFkcEfhxI67oyLg8kHe4fcWz3r7lCz2ZKoCmtjz7v6XzSEojXEGF9/qAU6XL2rQGt14KQDlhnhwuDvt+aFl/A0k8Rx+JoFBRBzX/GjXTXdO4bdLN6JOvNhdJF8ZNUN97M/qrGJke/Zbn++UOpcAGFk9sb+Czi2UV7zyNkRoZ+KinBOqtC9mI3jfzpfAt3mntcCub0nTjGdjZnJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39830400003)(376002)(136003)(1800799009)(451199024)(186009)(109986022)(1076003)(44832011)(83380400001)(6512007)(478600001)(26005)(7416002)(2616005)(5660300002)(2906002)(8676002)(8936002)(4326008)(70586007)(6486002)(38100700002)(66946007)(66476007)(86362001)(66556008)(54906003)(41300700001)(36756003)(316002)(6666004)(6506007)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3tD+CaR0cv6EHBU0KbzpCmwCgBARIBDFz2+VGErD0gZ5MS27lCKE31vssR/E?=
 =?us-ascii?Q?/VRpg7Rdhq/mbNYyNWLZhMk6HKRofC2LpeGtkypFBTO/ulkhuKoDqozsn0Ve?=
 =?us-ascii?Q?0E0N0DP6H8gyO34pivs3FCB+Qf8A0b9uv2H7D9uxOSVrTyRIow8oECULe/R9?=
 =?us-ascii?Q?0QJKBCfzr0JeJBljIaX7d6u9RNYqjFtSF3DrWqwmyiukteEer3UaamYl4eAx?=
 =?us-ascii?Q?aNiSKtlV7+ZbqWKGUPZ0Gu1w7zEaHjXX4PAThiav12g7nB2lem9V75sFAfwN?=
 =?us-ascii?Q?Gulk6nU9tOLkep48+MGOI08QG6cNxdaj78ukOBFUCYrFYc9CTG4K91OYdXV4?=
 =?us-ascii?Q?wdJOQDEOnHf3nNwFORyW4Yq6JVWHCVNBA8JDcJKZxGahzCMSoJSYVI0tY5fD?=
 =?us-ascii?Q?w8Z4JRmaDfpD3pYh+ULQ93dSXmGg1NAzDGJPb4keu6O0bH8ZuKfbT6SAaeJ6?=
 =?us-ascii?Q?XNK/NukGDLw1EvUmj5U5rMO+pajRawrrS5rbeAJA6VyyAT+f9b7Y/IZrUKzl?=
 =?us-ascii?Q?RIVauvBWvYaNziZ3RLHUYc2ZKocWbLFc/aBl+bovISY2niPav06bn50kFbE6?=
 =?us-ascii?Q?qzF85hA//G4XjQI1GdbtU9JPn1oxwAb6cfIJFpNgMQ5JzhunS7rplLNxFcaJ?=
 =?us-ascii?Q?hieZfRig0joPfoJT8fPZhoKqv8pMZ3H0EfAfvR7CCn9HlF5C+B9He2+/xJmT?=
 =?us-ascii?Q?TeEELTQH2QgHZnI2ceq9RFYwvxF7+eHbROJSf1OCgyu2uY1OgCbdjju2As3J?=
 =?us-ascii?Q?6s8XxBInFrRsKyHwifJ1vAHsMu+yzi02+VN5FGtWGz+b+F0IkNpEtVtj4r7L?=
 =?us-ascii?Q?rlLwR1Id+/GPToDxLVqhfKFl0qN1BTXnsH43q4jwB9/sjEn9CYZIyqI7GX87?=
 =?us-ascii?Q?hlzGGXB4UKOyaM5s2egqfZewvGHUS8bcsORgX+yQzgPPM3pllHNUfbhBdUo+?=
 =?us-ascii?Q?c4paYXI4Q91IJ758ykB5tAtlRW0Lb0pg2IzKfQaMFwvJ0gqqZSccXtN41oXr?=
 =?us-ascii?Q?JyhBtPO4DmWwwHT60WoNIQYe2x8uD0rR+Xzd5SG/qNpYD+wTnnYu+nuwdbBC?=
 =?us-ascii?Q?UQwQXUPFLIpnl405nFIv0e9NdbiE5KfguIqymkIJIkZphO0C1detGHqpVQkk?=
 =?us-ascii?Q?+6ifqsVzAOIbUNty3QRqUq+PPlFsjmSk4lVVProcL1IWw/6pSEnDCimr2Hi6?=
 =?us-ascii?Q?C63RTC5GxxqI82HC3mSBUxF0zU0N/w5Ukuu3c5s0aLeEZy8mfrz1ufDHahIb?=
 =?us-ascii?Q?CeC6cL2mjL2kaQcUuefybjmk7DqH7C6Wj+Xm6YpXxSaGX8omXdXt7JMMp1a4?=
 =?us-ascii?Q?Bqmpf4lFgz0v7L5LrK+c3kn8Dmfou99B+8UCc9LcuLRfzZqOxDZLBoCHGg1c?=
 =?us-ascii?Q?lWfT5AlCr8jM7+icKOwlleO+aibrCJNeH4CL36Laa6Qzj91G++JC8z86XOvA?=
 =?us-ascii?Q?lhzfUtcajRLdaTjO6av5jsCfVFYMGQb46ja1TE+I/k+eMu47jhTqFK/U73JE?=
 =?us-ascii?Q?0aaZCvgFe4G18J4oksAyIka/hK6F67XctxzwsvEkX0p2ymvSXt5/tuYzIN+6?=
 =?us-ascii?Q?sCnv0H68YX86XO5unf7j5wqglTdP/IanvrsCX/lRbnW+xNiHPRTyu9AqH62z?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 979aeabd-d43b-4f4e-b7e8-08dba7c2498d
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 12:28:30.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhyELbPz2dYKw4RbZbARTQ273AcM18BRKQfQHhJONS3iSkuUjN/xs7lV8Xgy2vzyupog0lHhx45TEd/6zyB9ZoKxV2hy3HNwt3WYgNgGnxY=
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

A new SKB flag IPSKB_MULTIPATH is introduced for this purpose, set the
flag when route is looked up in ip_mkroute_input() and use it in
ip_extract_route_hint() to check for the existence of the flag.

Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 include/net/ip.h    | 1 +
 net/ipv4/ip_input.c | 3 ++-
 net/ipv4/route.c    | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 19adacd5ece0..464176a88f86 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -57,6 +57,7 @@ struct inet_skb_parm {
 #define IPSKB_FRAG_PMTU		BIT(6)
 #define IPSKB_L3SLAVE		BIT(7)
 #define IPSKB_NOPOLICY		BIT(8)
+#define IPSKB_MULTIPATH		BIT(9)
 
 	u16			frag_max_size;
 };
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index fe9ead9ee863..5e9c8156656a 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -584,7 +584,8 @@ static void ip_sublist_rcv_finish(struct list_head *head)
 static struct sk_buff *ip_extract_route_hint(const struct net *net,
 					     struct sk_buff *skb, int rt_type)
 {
-	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST)
+	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
+	    IPCB(skb)->flags & IPSKB_MULTIPATH)
 		return NULL;
 
 	return skb;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 92fede388d52..33626619aee7 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2144,6 +2144,7 @@ static int ip_mkroute_input(struct sk_buff *skb,
 		int h = fib_multipath_hash(res->fi->fib_net, NULL, skb, hkeys);
 
 		fib_select_multipath(res, h);
+		IPCB(skb)->flags |= IPSKB_MULTIPATH;
 	}
 #endif
 
-- 
2.34.1

