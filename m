Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACD878E787
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 10:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbjHaIEA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 04:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbjHaID7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 04:03:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2133.outbound.protection.outlook.com [40.107.22.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB69BE42;
        Thu, 31 Aug 2023 01:03:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGdhP7Wpv5oa9f+mfgkr4k8cCmopjyIiy8Hk0EMzivo15eM/IYkyYinH7Luqs/Z+GiTcapGgqndSW3rGNQIAL9/mEHnPMwssFhd0aK4+CIRbo3PK0N5sk/4fSfVEwGEFc+vC3ionp+67aUFeTNSgfay1TrN1yRQBPhQuIqtb3ZTlc1JRSTn60YhjwUGBi2sknPAgLUkRWYGxMaOvl79Uk6DsO+rRvZPtCeD/DyyQLQVi4f8SGI0khTsCxb0dL3Rh1/dhqI1lYOvT4rG5uDnVTGX3ab1TOl/8PGT6FS5lAzrQPS/lQ9X1iRHpF2Pq+UpmVmIb10Za/Tpq130zcChwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fL4EOwO86H1EP4PmvHyNW6IT3Che41u35CFBg7cURI=;
 b=m9izACG+834J2iGkgtDJ7Xspl5Z2CNuLLTN4rJ9eIoIveuKSMF4SCygfYr1IDs3AuHwy+tJT19IOVK/djq40+MADPVssFxtfFKjnWx8F4GS8qJIDgWJJLw83iXpvRbCg7WNc+WlekaYEVIOhupexNkxGcHc3CseKyImuK5U5v523gnCEVTFvfnLiL5CY7zBrXb9x9iYUYLgoGe5Ish25dWbKECAxJPFww1fUPdAIjvYKeEf0lBhhXz9if4mkg0oEKm+upwSjX2KfjcsSC/b2a5z2bRRJDYMCG0b22g1bv6gvzosg/ADTGIh2AjNW7id6x3Va5Y2/Wrr+hpCypPCvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fL4EOwO86H1EP4PmvHyNW6IT3Che41u35CFBg7cURI=;
 b=QMErEGSJsk7t+b8RuT4KPK+trXD9drA4nb+MwtamV7itxslnyaL3H4hxWED46QZWuP8yA0xA030BrwrtkPL3Y5AqGLums9w2ORxVf5Okmur7UPELUdbEjplLiziKH9nyseL8iilViy9qSYDRGDfy0qRgjSh+2UtXP3Fc297JyFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by DB9P189MB1929.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:33a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 08:03:41 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 08:03:41 +0000
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
Subject: [PATCH net v5 2/3] ipv6: ignore dst hint for multipath routes
Date:   Thu, 31 Aug 2023 10:03:31 +0200
Message-Id: <20230831080332.2495-3-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831080332.2495-1-sriram.yagnaraman@est.tech>
References: <20230831080332.2495-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0024.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::12) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|DB9P189MB1929:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e85f0c4-fdac-4a4e-5a2f-08dba9f8c9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dAsNHq9wOpZjJbhNjBUB4RvQazRtNkpD7mU6XWdVJTadtbYfPIJE3n+EUdBWdtdo4BcOiJb3/8NtJP1tc9fKPYBJwS+r6diMcGcSzj2KJgV2d4fU9LBUAf0+JhyGPCN3y60eU7FqYMzeBZ9TBWnOHNvNrstTM0weWOrUI1IM3Fe6y06YESevUMbXjKWdiH+TZwIxWKAdnVoH1sdG0R1aZ0DKrFhBkNNqoc3zZImwSpXP1FTvs8usFbYC4ZbP7/r/iiLJ0o3yTkRdIT/4B7yJeAQ/Rtjcg4yNOD0Uc9Jgxjv0pKKdaaUoREPOkmtu4oiPdYKyGJ/igg0jzbIxIrxGcHbFWS+nJfamvxIwdHWSHIG+VmOuq5KfpzJW5OwKdTcWuUNj9o9rzZYkVuDjGoKYU+TbsXR0YgZP4U8r39GjsEvzUEgfO0yjA1sCKLRabXXLUiEgSvAECqZ5CSiYum4N0lRmme5C3qgB/8/ehvhtI5FOU5J0XD9YqkcqUw4c7AsJfKZq010ccMmp0vkNVhP1x53aKpvOW8Fh04pUrWrWC2VB23dIk2fTqJWLufUtSJRnu3z/OCUd9hc3HEYtwnKhIlKS3Y8qR5VW0/XcDs26id7/5CuolqnEa20PDC4+xIT7fH8UU4ylcuif1RlKShYOow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39840400004)(376002)(396003)(109986022)(1800799009)(451199024)(186009)(36756003)(7416002)(83380400001)(8676002)(86362001)(44832011)(41300700001)(8936002)(4326008)(5660300002)(6666004)(1076003)(26005)(2616005)(6486002)(6506007)(6512007)(478600001)(2906002)(38100700002)(54906003)(66556008)(66476007)(70586007)(66946007)(316002)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MA15rMU2iRixoq8gjSxkNsr0UBqLpf6i4uJT+Zd8htXwOJ14c/BAmceqXTYK?=
 =?us-ascii?Q?WRU9guNsVG510cBZTbhWE+zGxzbUfAaYlQb7Rro1UEOgNtAPrmqE4roRQJPD?=
 =?us-ascii?Q?d4bv9IcG7eCGvFKhtmHkm7tvX6Hg0ivYlzFfAkTl/+9gDZdy8EIebjbY8cqE?=
 =?us-ascii?Q?Our0Znn/QSzRmgV3N1MzT7j+reX1h2dY8OTPEPQr/d6bxbf2bM5ch2sdGUAm?=
 =?us-ascii?Q?c3EAsB8j8QHFMSdxALQM1BYWL04oIT1ilQswZAUqjEX2LXJ3PpLd0CmEU3Ol?=
 =?us-ascii?Q?MHfUzjClP3vO8rqgCR+bucYTnirBxBPemL+eHtFU9cCSKi6SsVlrPCxo8jy8?=
 =?us-ascii?Q?9pnsQAQ8n62R+OKqnfXoYTj5G8BkbMbtrcYlZvC4I6fbkeJ9IGohIHprJXfM?=
 =?us-ascii?Q?jtS2YBkIbX5pAdJFY9MtH9TbuMtGr8QJLelGblETJT3vmJYwzxt1kul9sJIY?=
 =?us-ascii?Q?n/oz08u/5qxiVEdZf6GOeHL8R8CFacvvM8B4gM8ItW2sY4lwmp1JMVbBKCCP?=
 =?us-ascii?Q?6JyeU+ZljzFEB1Nd6kxLKp3e0N6Rai/iJIiaivjr6yi2DI5kzSltaDc+RKtd?=
 =?us-ascii?Q?ASogFdvs3D2jbP/+XmT86zjvrJQ2HBxL+VzmJSleTFpl2mVREQ5XD4KDXwqO?=
 =?us-ascii?Q?5ahYqIEWd9+6zz2ZwmONhjXhaWZ/5L65dq+Ii6k7ROolnzbDim5zPr6lbQFm?=
 =?us-ascii?Q?Kci0DT4qRK7JsjuVyqnr7S/oNzgpDCpnVuYMqnv+7nwIZ++yh1Xjd4RzTCVD?=
 =?us-ascii?Q?Ri+RNmX7mRuGsUeZ34etOG+r+fUGaV7hMyd+E7hOik+hnzVIwmKuUhGcQacL?=
 =?us-ascii?Q?ArPRriRoiPU9JLaDAV2HjYEA/Volag8HUay38XF+ezQ08rGiYiDwyGi3VmJo?=
 =?us-ascii?Q?vc9m8BOqZalBWPhqLeuqgAO42DfzfW9XQokVU8EYkqkbTr6sBNsSSWCZtLCJ?=
 =?us-ascii?Q?1zmFGzf3kv+//VuYtRoFu72raKRmZn4/DBzJUaAl38U3hFqCRQXY5yUDjXXF?=
 =?us-ascii?Q?BwodYw/kKHN/LhsUESSumWiJdWvgcngbxhrgXHIDrZQ4//wQS9QY7kePFIpB?=
 =?us-ascii?Q?6KyAdb2VyYnp7OzabRX2pqeyQXUt4Dv7KKNtuSQp2hkGTGOgcEGsu8iR1g2E?=
 =?us-ascii?Q?TqfubWOXFwnw0W5MYoxLyBwoXeWnkOG0bqajFxtCP7TaACoxoVEivowUqczK?=
 =?us-ascii?Q?JDja/M+XlYj7HXEQ5UFmcK8F1prJVRJDRJaJBR31LYzz9vFXg3ztEvvGf5TB?=
 =?us-ascii?Q?LJoVUgwALmeVgDRRnFBz4qFbEhetUWzRBIRkkqtLNQUq30sZ0ytznQW4xBeL?=
 =?us-ascii?Q?+HlOc8EUfsObyrDSJV3bInKLTpF+UUAV1I/pSftdqEX3QKAfXjd60Eq7Yg2v?=
 =?us-ascii?Q?xpX/prCMm49826dp0p+Nrq2APiWlkdHDlZro610Wdz2Slkb++IVySzupPRLu?=
 =?us-ascii?Q?1zJrrdfky0o5rn4rPL8YO1vvq/mtAlj1rpslulo2W8SCYfiNG+V7DNnLnPE3?=
 =?us-ascii?Q?yXTw8shy1oxef8/+I7VW1x9ngd3HhvYw4UnUgFBGtLJ0vH5xyn0KGc3BHDFe?=
 =?us-ascii?Q?rulANGmjhOPLXrG0MEz7WUG2Fdi9ECIV9uh62WDMSdMSinnYNcJvHYoqSQ53?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e85f0c4-fdac-4a4e-5a2f-08dba9f8c9fc
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 08:03:41.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biCXmuUdRc9tVoQYThAiDigDny64MdY6zLJFy5lQDP6C4xsMEcDWi5EvoNalO8eMTmlYdogv+mLUG5KoLGYt7Ju5Qrblbyt2p1MtvuKgQcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB1929
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
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/linux/ipv6.h | 1 +
 net/ipv6/ip6_input.c | 3 ++-
 net/ipv6/route.c     | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 5883551b1ee8..af8a771a053c 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -147,6 +147,7 @@ struct inet6_skb_parm {
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
index 846aec8e0093..01d6d352850a 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -423,6 +423,9 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
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

