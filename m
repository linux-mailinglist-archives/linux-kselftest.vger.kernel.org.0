Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430C778DBBB
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbjH3Shd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242666AbjH3JOD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 05:14:03 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2107.outbound.protection.outlook.com [40.107.241.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841C1CCB;
        Wed, 30 Aug 2023 02:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8NOQRWlKfiZ8I/JZfmQg/tWGpcResoeUcvUiA3Xlywra/K3JLjB4iaWxJURYT7b7eb1Es4qeK3a5UUDVV9UmdXCcNJPMFwYjPMPqIEHOgDk86T0SGvieVjKr4Dk+sCoHwlDV6t3aFeOdTOXvXEXet6nSV8n2HCqgqoFVpfRMrVBMrZwUHaXJHtqMnWPl4CfUyc6qngySybNC5R5FvgD2y3qIITPfNgArzgsQZDGmJqZXVmAkMBQR6uXzkTUAhOjQtuoFdayA37aeaj7soi8H1MCUvVPSYWcN6HBoSI52gJ0jH7VAZ2drD7PUq7QRVVWM4Rwph/6x+5/4BwzrEDH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fL4EOwO86H1EP4PmvHyNW6IT3Che41u35CFBg7cURI=;
 b=k9FdkeenSrJQEcTV7KeQDoot1m0kLN8BxQX07uotgELG13p7114/0mc+nlK9CNYJWhm1Y5WnsQYl7zOgCj2pJrz+DcjbUkboce6WPs4fWgdXwuP5hVMBlfYosWU+DEfXhJBU2479oEzljuaRcahIB97syFPYAywkIzFwu1Yc64mGtpYybfVxDdFlwzFVqvxMoWZvwiGHYfURti8lyWqfu4nT7Reb17Amh4KGam5CQRcpT0btvzIiwPMXWAfaKZVZWatPsjA/c0iQZr9ncGJL3R2qWlZWw6yJu4awewq0aqf1xjRqgHG+3f1OpEQ6i4cRCOR75RTnQfPSSzvaKfav4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fL4EOwO86H1EP4PmvHyNW6IT3Che41u35CFBg7cURI=;
 b=awuXy1hCLxULs+0vAh0D6KEl2C5hFEXXQup+PRMav+Iot6bIMk6ymtIDTHiEVYyayUdYtT2c6VeflSKDjiy0mK/OdCROSmMjR8X/7qTNAQGjZ9s3wgrSU9vkoKLilmTW8MJ6ou6mutOdCUK9DIQiQhaoLBx4NaWImVRiBzjJtTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS8P189MB2096.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:52d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Wed, 30 Aug
 2023 09:13:58 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 09:13:57 +0000
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
Subject: [PATCH net v4 2/3] ipv6: ignore dst hint for multipath routes
Date:   Wed, 30 Aug 2023 11:13:40 +0200
Message-Id: <20230830091341.17273-3-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830091341.17273-1-sriram.yagnaraman@est.tech>
References: <20230830091341.17273-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF000013E4.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1::24) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS8P189MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: d62f3f34-7ed5-4b72-e114-08dba9397107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bd4eQHHy2ttlAp8ElzgoPQARFRidZuSs3nAG2iUKwS1dXs4IEUXEoS7DeDBSdhoJE3bwe9NxDzrhbLeNXjfWzYlUdY1H2PPVqxdS6CV6hRzWkS3HRdYqE0lnsM4ZFJRbJPwkliMOwA0Y7gw3Q0dmgQp0DjqjVTYY4IABJUNT5Vxarvpv20kM4hUyEenomtMCniwQlrAbJXuURUlcYvNsWF+aM7DrARjht6hOz1i/JieqXERbr6uTT3AnywoOkT9xFv8o92BWTKFhdCetZV6CND11BXSZJPbBgYFAwxaewOiM9M5dx6zSeiNGTsIcld0eAKuzgFmwXWE0u3hOlleEjYUJISZUxGDoQqwkIjTfdJY5ECyAM/AgBjZDG+xKUVdvoOJpvwgMXmpKHkcj2mjMnrNkhXc39Nb5H/ZhRMerIuUVaz5Uxr4PYn7Kffx2Y30uvB69CyeucacAQv1y0OxsbVAxcKgSP0fXCCoY1gC6f9sG2m5ue9RXXHkOApRf4QqLod5NkUa2jnr0qDFNyYO7XVOlewlvW5o1SSKeXl/kMleCYOMELahMkVE8PWhKntVPZ44NvBP4qXirzIKEc+ov/WZl3TrnGVChrXzG6miVcS2V9UQXqJF9SSyfHlXN/3FFfQ6qKQ5UXaGeXJziSDMPbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39840400004)(1800799009)(109986022)(186009)(451199024)(8936002)(6666004)(478600001)(70586007)(66556008)(6506007)(66946007)(66476007)(54906003)(6486002)(316002)(38100700002)(41300700001)(6512007)(26005)(44832011)(5660300002)(8676002)(36756003)(1076003)(83380400001)(2906002)(2616005)(86362001)(7416002)(4326008)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T+RiLultxA/SYVX3cIG1wvER8pH2QxM4knGhEvJrmUjpFh7/jtg5Rk7uwg5F?=
 =?us-ascii?Q?ciYt3mHo5oXv02D/EaDH2Jg1yCvqe6GxkUW9EZxZLhh5eAtiLR1ZUYKd4jpp?=
 =?us-ascii?Q?KAlHn4sKX/bBUWn4eqwjP1LaUbTnl1bO0syKG2tYsZUk+lD/5OeV/5aiXOLy?=
 =?us-ascii?Q?1hT2siDc6qfVNlwLbOig8+27I24Q26rsdiGE21boR13tme5zh+WA47A61DqK?=
 =?us-ascii?Q?uFVAH2c61Q2u1m5TLlprFdxuwDTvosxxeRXeVDSskUe8POUeg52leiVPyO7F?=
 =?us-ascii?Q?ngMlExZ0/JElDHKC8UzqbObdA2dpT1f3I0LdWqT+thnVmC5Kji4h4yMEjawK?=
 =?us-ascii?Q?TgAqxPGw1x9vHnHNGLb6pwYjmkddXxBxh1MwFQXG8B09C4Oa+ibDHBu+4jvc?=
 =?us-ascii?Q?H247H0IrN4byQFXahIxItvxwuBFyFcj9oCwBHfvswOkp6x55KpY2WH/z7kpJ?=
 =?us-ascii?Q?zvPCTJ4Q+xa/CqU8bgvP8JtS/cBWYwQ+3ovynX46qTfpGKS1uFyYW+RlL/x4?=
 =?us-ascii?Q?xwyBnpkh94ZVV0nUhkE5VQIhn2Vfhx3PIkjgHGm3U1YYADVLprU93BOmV0nq?=
 =?us-ascii?Q?G8Lli+1pOj9NJi4b5jhDAMVf82/yP5uho9Mu3zV9t2eNeL1NwD5+geffUvmV?=
 =?us-ascii?Q?j06+Jf9JjrDQ4N5ZzcrFWJUhhLjDmXYoNkKZbVCoxPgfZkeYVLwiLISAFczz?=
 =?us-ascii?Q?JLhUDFXHa8Z3pFs4F8V/kSWgj0vhHRPUsiGFDsQ1WruqTsu8JR2dTmHHUAPp?=
 =?us-ascii?Q?QIhvJbnxPxUqRMAgnYvqjE3mXhiSnAfLP8LYj+QbbuKqFTTU/JBPr3WSikla?=
 =?us-ascii?Q?7W+8sl9oPUJDWBsjkKH7Ndl6muRtMvK7f+vsTHhojyJEoU/oHa9cIV+/RwFl?=
 =?us-ascii?Q?AC+Eswef70rg3ysuVUi165V3jdF4GyoXMZJ9k71DD54XrDwXKI0tZAjvXbWj?=
 =?us-ascii?Q?xW3mqjyaYcKK5HlcIbGQ4kQmgX/MNiEuHvrMB3uQ3glqPDQy5XkXSJB6DnqK?=
 =?us-ascii?Q?ABV9mqPSUgdnE1u/e6XSXjGoK47HqEkPKQ82yQCmRPIUBYX4/dOzZuLQoJo8?=
 =?us-ascii?Q?j+ZE9eq5x9CVA10ReMifywJp4DKD9e906putg1UdiNTUT9/W/tP95VU0H4mH?=
 =?us-ascii?Q?c2VnQ/SxiVJZ6NmJRovHiKQGL2HghPHj5EFQmSAnZIyo97suy+Gq5SjMMav5?=
 =?us-ascii?Q?broWKFktFYcCnljy3/F0ieqkE2JvcbYOsrHNwZvRQ+HQwequU/ldcvx7nkuw?=
 =?us-ascii?Q?tFWQXWYlbwF4p3gkwO3H41tI7NHY1Z54RpajlYMBISYXOFQo+3+K289L89L4?=
 =?us-ascii?Q?O41k4OC8H0pKgxjpzauJiQUtkHdSHdhsgvS43nn/d6YFdLzX1a8jWlvemkIo?=
 =?us-ascii?Q?vamKIRl4FDEKv/Dg9vIrmmhIn2wuMwFi/qprno/O7tRI3wNGa+onub3DBrZd?=
 =?us-ascii?Q?h4q4hh4Ktmbm5PxVPKaZu8SEgnRfX/Y+JTotFktjfj21vFdIY/ORrT+tNeQw?=
 =?us-ascii?Q?ro1NW1A8SWqpIBu6r2pDXWo3SwbMVozLoOVf7esWgt0Lb0ODNK1se69LVFcI?=
 =?us-ascii?Q?D8/akUqJxXUwFatgn8O971YCzLE2wwspMAEZBZsOq4vy9mjSyflQV7mJTEf3?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: d62f3f34-7ed5-4b72-e114-08dba9397107
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 09:13:57.8781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEePKVyK8d66Za/KN+kM89UX5LrfZ4zngyOKhH+nGgf3E7bsBQ61I9y1FTYEzxEKMAE1sGmfLwhjWhg3cQFi35nYP2fgqy7EzpRO57NTwVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2096
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

