Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0739B781958
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Aug 2023 13:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjHSLu7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Aug 2023 07:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHSLu6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Aug 2023 07:50:58 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2138.outbound.protection.outlook.com [40.107.14.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6333C10;
        Sat, 19 Aug 2023 04:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNhjzywRzUrJjkB2RFLHx5GIyV/JyzcxsyCRpGAqqkNaoUS/uJU5dPOjNZhigUPgvTSthDZSk4mq50fkXPx+u8bFS39Wi6NC+VrjgCSbr7zrUrDEk6J5vNU38Wq0h09XqzIZ3Vf3HkwKyM3uzmEu1x8YCyYIB0E9INuiJK1Ur5lJFFe1A2syMi66t4WtXn3ns9YX+NcKy4mDt7Wzom50E9doChrMJ1l8ssSs5BBxG7Z8ikhtPpMr056udlMdcG7aMsJyzrZD1QEt/vcVLBUkWfniFxiUkb5HebwQf53CVBAR2PPvR9UEn1+/DKzw80ovDHfrCjG9NTNfl6gQSVGtjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ2YzlcVi6EnBaE6c23fRg75/fbGRMCYIYYVhtNnaco=;
 b=ZfIv3OvvMFTJbwH2H6Bb1ooagaom6ewL3EHP4PxaWv1QmgAItdWKlw2/6stH/kz8OjVZ1qat3w2ICOABq+tNR/NwUWv8YjdJv4CA2E0ugjpZc+3FxjZ/DC87DtoMhb4nQBkeBxRKxop79yaQ9Jjl7eMyRZYfrzg5zScgMdVgtubcCibgcJA+0uBg6Fd4fUOVUYNrWEB2Xqi+OtHuikO7ucQgB84DLiJ9cRy9EYV12t2v5QuC7XQYBvGqtL8DJ5FWqfEVfieMxtoA+IdtBTcyixRne3vw52iZ77AqV9xNm+pUdqmylghAZ4uZs4HRM9C5xtqvBp8okBg7wbhT7ICOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ2YzlcVi6EnBaE6c23fRg75/fbGRMCYIYYVhtNnaco=;
 b=Jr22gqDyNVeUSOa+PTtzC/XFhMtl3mespX+kJIJLndW9ZK/m8jpgm3v17o3A0Mbp7/zs0Dr4tyewe+V/ZcSm/I4mQGFs+9fulcPwjpXKgg9c1VcAtmly7pQmkHlZhXiA1uVs3oX9N4lLWSvx7xdOoXuiA3GPEvjICXLKG3LPog0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by VE1P189MB1133.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 11:48:33 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 11:48:32 +0000
From:   Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH 2/3] ipv6: ignore dst hint for multipath routes
Date:   Sat, 19 Aug 2023 13:48:24 +0200
Message-Id: <20230819114825.30867-3-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819114825.30867-1-sriram.yagnaraman@est.tech>
References: <20230819114825.30867-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0115.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::18) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|VE1P189MB1133:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0b92e7-a5d7-4714-3a51-08dba0aa36de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etYlnPnB6iPX1cgm/+2548vHUxK2Khod6PL+Ew2dHuDNo9UKNQWFvkIWPs16nvIi7zwRVdR0JkUEu5PJPR+j1Ot5nrcNb7TOIpzx6pIIRlNfnOG20nx6IU4b9rCU5jPLT3cKW+bBCETTx1/NRZuqz7qwZfiRREV5yVfZBZIXaxFIjsun3TptDCdJfNA9BYL9xVokYxXK+LqATQdl2/+tbf9kGWKCPrrpT8SUjL+IpygD5jBB93WIu7yAg7Mj9iw1NZcn9ngHQc9yXImsbkOwHdN/oD+UEXp10BGAgNPWWHJMg6tbCAS7tPBPR6XdODIj5LjT/oWVFARZrigXydNAyPFMYZsduE8CdTLqlRVTkA1d8Ki1sr7Zvjw4Q5wyd72Xv2CZynsYNE7UFyYjM1amAsjBm9eWHKPeUXszntyWstVFEq0j4GVdqt6GQaa0xnIkkULQuGHAuqk3iFajdNVDSVx2eHAQjfigH6P8OmwBZf/rJVkEKQUBxAAB//mkdgmkXaTl/nrFzgFD5Hv+h16vHHr6FleDtCfBPUoseLUuaqyZScHNmpHxtomcQNVV5WP4IJZGQjpiiX4dCNSVAnOgws6gL/gmKw+mrbp7AQ2vAVQX2FZTopZcljZG6XR0tvoLiEuf7zXAJnh3E/X6TV5FNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39830400003)(136003)(346002)(451199024)(1800799009)(109986022)(186009)(66556008)(66946007)(54906003)(66476007)(2906002)(4326008)(8676002)(8936002)(41300700001)(316002)(70586007)(6666004)(6486002)(5660300002)(44832011)(6506007)(478600001)(6512007)(2616005)(1076003)(26005)(83380400001)(38100700002)(86362001)(36756003)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Q6teInSD3WMHwxqGvErw/DIvIUYjVJGCsgZBru6V9Wn4t54/e3lv5L8HrdY?=
 =?us-ascii?Q?lWQO/Wax719kxXqhDa3dbwUEzHYuhuDtkZed61NjmGji/scJEgEEgIsCk9fx?=
 =?us-ascii?Q?1pHT4Hln9iu6uZr0oLmCh8rhxxtPzU72at8ajYnV1KUntMCjqv8BLKD8VrnQ?=
 =?us-ascii?Q?0M2znIxLgm0R1xoB325kBnZMrs46zc1bIZesMe//4t0XDBi10bnL28iYjSrJ?=
 =?us-ascii?Q?29E2mZ9zS+ai15z20siZ8pvk939wSw4Wqawp7Ts18FMVt6nso7G0PC2CODMs?=
 =?us-ascii?Q?zHlPPm8BvzDK+tIcG/1Trx7pxrMbGtrY+/AHRhJjspyTPJDGCBjea9YMc0Jh?=
 =?us-ascii?Q?hACMXXYCn+ywJOjA306Nl7fmZfEXG5QGlKp67uYg5LUX8MrUJ+Hlt647ruxY?=
 =?us-ascii?Q?/Ya/6oKOrtpuBxmJcX0xvFWCOIC1lJ+OSwHXenFycGT9mWn2MPkUnhGOhZhh?=
 =?us-ascii?Q?sSZRGGeh5ZNkHOzAOu8JevA1C2EUK+9/bySxm8VZV9Dloq6Mauy7058YeR/b?=
 =?us-ascii?Q?ix45EYA+xOJM4NlJRulyAwhZojYTceyCSuHuh/WLi5SPqK8Pgnh7fzP9ygUH?=
 =?us-ascii?Q?F+9AcmEEv3XQd4I1xziaPr6nderiReOeL3ENIHF4Jfqe4fShzj+1nCbkO9Lc?=
 =?us-ascii?Q?OSS3b6OmbFLgk1VASuo8RoxOUbV6CCA9rmKLbt5TWcvAME0x8qpyE3mNOS5R?=
 =?us-ascii?Q?P1sS1RPTLu5LeXkg4+uoCZuLvM/GGNaenldRNrcR7lgY4KB0kgj5ErB1rANT?=
 =?us-ascii?Q?6TYdBcKrNKtww+AqAvnOZOjMy+4fdu5RvB22YCnEzrH+lSJbMcWPAHYMkFrW?=
 =?us-ascii?Q?RmGTZnVAf/8QtsoMhKiWt4sjgg2zkN5D6TUNk2TlLEJ4aQFUIluWRWcxWDYm?=
 =?us-ascii?Q?RnORv4qkVOcOnhVUg3t03Q26sjU8urBG1sng6dOvrBfSl9pzYjmo9QigtTkj?=
 =?us-ascii?Q?Cn69bx74nWDU9VRmK4i7iTbCIpJYA/W+vcj+qHhLIRags+pcfz8ARDOYbqTQ?=
 =?us-ascii?Q?T2OD4SpbngbmUaidj4uj2Uhbs7qF5uVB9OgXrtZsSqCSb8/mY2HiUgb5vO2r?=
 =?us-ascii?Q?5GIk3VeWAAHO/T6jWbHO6+zRXSVnz4hQWWdXQpvKYFUfZ9lGpj49ZlpJQkPL?=
 =?us-ascii?Q?cUGU3v6LHaY+lGIVInYdix7IGKpsoCXQV1j48h8/KfvtY1N8/Bp8zffSGklJ?=
 =?us-ascii?Q?UUb4Ktz+/gdO3mk12ZOrunEL+WmOOGHFc2jgoM/b3aFr2kK0QkfrRq+MAsG/?=
 =?us-ascii?Q?8GpBY35FBPOyn3uNhPgqy7uPP2EGgT+hPgXaRpBoc0fgdcolLTEgqTep9Fnj?=
 =?us-ascii?Q?mnkCcLxy+ZevvjIsVZcBOcsrcvRBheKjxUc8TjHl6AzPeqy89/EbxxkyWb8W?=
 =?us-ascii?Q?TQgAZQxtJ/xlDGjfB4AyaS0BfCTuc3/OP4+1W7Mtc7jqhfEsk5atbqSXTptS?=
 =?us-ascii?Q?uZDSxqAsEs6M/ZoOYmXjTb9upmO4nuVR0NXVy4DYagYOvXXY4WwVF/iYTWPo?=
 =?us-ascii?Q?Vz5Vp4PUG2BUCb/bwauPfDc66DDS5y44qssav5432xlGpm3vUXrDrtScvXNE?=
 =?us-ascii?Q?XuRUydj5Bs6/c2CN6osNWC7hE7/3wTYI6UVxilQ01mEMaYYpRTHWHUPwJesQ?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0b92e7-a5d7-4714-3a51-08dba0aa36de
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 11:48:32.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLsl/AFIb9L8a280ezP0H0I5U99IVaGNuggKbT8SlyI+OT6JeyqIll8g8AapYz5LUUGwcnAyslML9eP7ooSYI1HCrqcEkGxmE0xodRWRWEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P189MB1133
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Route hints when the next hop is part of a multipath group causes
packets in the same receive batch to the same next hop irrespective of
multipath hash of the packet. So, do not extract route hint for packets
whose destination is part of multipath group.

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

