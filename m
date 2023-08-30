Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0408378DBB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbjH3Sh3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242665AbjH3JN6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 05:13:58 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2137.outbound.protection.outlook.com [40.107.105.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0D5D2;
        Wed, 30 Aug 2023 02:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDkyRpu1UnOv82mXhrH1Ks+bbZlu2sFGfMSd3qTmCnrICAnguv9ir5IzKa3yT+k5qNtOrbJPf69PXNlYU8Jbf5L6J7GvfDIDi/qTTgvRg8kOIS5PE3vq6Brs8ob3m6raNdv6vLv+BQ6gQcl0JXyWGnpVb/9MyzalgX4+dIyjxap64af+TeTO6mNOSqJ2YiAuzbiqQdDTAnX4TGsYoRxyRxZ/7zKF1zLIUXxXGNwPSwe28Bajqrk2xaebGWAueXEqilUkiyOppDYqYE9rmy66nL4VIM+PVaSalcLBI9BxJXQC9tkyzv/cqwewbmrWE4oXH1HhXMtw0q/ch76aQSSDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkY11kfDOcqVDFHUtAFoI3MIPNDYp3mD2y+AgzXssrc=;
 b=X7UmUM+Kr5wa1eWcSZxGoI4W2i2lwZHkeaiUVXvoFkfS3pzR9J8Z3a8WGyKWpz0k0ZOvDtCm6UlSovlhpOlZfTQSVVkys8ZAihKVkjuhYnXXcc1tAmEFywe8IjlC8RFODZNmoDxKWVtfOjwuAs4tMKmAY4yQGYFZ3P3VeMIH4YjtuKh8VgbO1rZFERgIgCSBeUxg9gCYKcWkzH/7vQXgjDKT/FJU7o2w9CrVZFj1zqXv24OEF504gx8imN5IfhR7btQ9rQwQxStWK6hPKGRninP89Kb5rhl4Q9VN3sNGfRY2cxDFP/DA8Hf1SQJrEcUZoEwNlP7J5dsCSuHGtn3P1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkY11kfDOcqVDFHUtAFoI3MIPNDYp3mD2y+AgzXssrc=;
 b=HVuHe2/86oebDhi613RT4jsqP9F8SG9g9LPFes+J22m3b8XBvV8/YjmKswOkY6cyN4SCM7s6mIwodW+Hmf5ei8jP7YJgMsWaHzgUGoRenUFr416qMyILKPG1UW0YelRRGgVXZY+FzkC/W5k/a0hJGDqZ8TgYLwjYPE6M7FXdbh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS8P189MB2096.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:52d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Wed, 30 Aug
 2023 09:13:54 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 09:13:53 +0000
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
Subject: [PATCH net v4 1/3] ipv4: ignore dst hint for multipath routes
Date:   Wed, 30 Aug 2023 11:13:39 +0200
Message-Id: <20230830091341.17273-2-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830091341.17273-1-sriram.yagnaraman@est.tech>
References: <20230830091341.17273-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF000013DB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1::14) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS8P189MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: 69af8b93-d493-43a7-ccbe-08dba9396eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VBnGtyS7If7If/I89ySS2E+WfdOqIzcc79SNg8ovQoKiqQ8APcEFiWqSgZx9O7s0eunAWLXHw/5/NRSAUQdnMk84nJj1Zf0hql3HhNbnSIYF06oeLH9zAzXBBrniEASUcgtHWyXhzW90lISADGFxMMXSW6TA09D+8nbCYJxN53AmTCQXP8fkht3bcro7TGB39rLA6SEZwGQ3Rm+A3TRgUB6318f+OsN4CIw7nzYD4yv+4VkFPnuGqgZVaW/q9JJD4nXk4RlkmiSozSeb0brfA4SHSdqcWsJ3JmSoKCCkUg90TOArXJng/nKmmumPcH3WWIUalZb6g0H8Rm8VqX4knE79kaGB/j63+Fl8cNb6M4QDtRIefQ6vGRIeelJsLlPgZ2D4dG7voIy/R02XN3sYTQ2ZNS338vqgrsAh7aT2ZbiLSUdVO1vWcYQJxeskPyuN28/YZiqn0kzOHgWGD53JIxpZ6E9WEFOQHFkrNQIzON1ZGyqjqBpSRr/556SGwiYQLx69YsrEMiFdS43JwUIUkFbelMt0kzwWG7TiIxPHt5GvDpsUrCPUiJfTaJ6e8qDZCB/eW33YWbs017Wf+eCxxWo6qDdb/fcRCR74hTH/Q9tIAALEdNVceUUigsfh3y16wEIYpfKBq5yg+Hv/HifVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39840400004)(1800799009)(109986022)(186009)(451199024)(8936002)(6666004)(478600001)(70586007)(66556008)(6506007)(66946007)(66476007)(54906003)(6486002)(316002)(38100700002)(41300700001)(6512007)(26005)(44832011)(5660300002)(8676002)(36756003)(1076003)(83380400001)(2906002)(2616005)(86362001)(7416002)(4326008)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ncZVowc7Prr2xyCl3PJ+CyXJpkytzIhLeQgAFy8qghs+WM9M1V20H8CHdciM?=
 =?us-ascii?Q?rKJd2XlsWJokBDhQmR8h8E3AyATsPp1fC21bgHHX5Ae8sr8UzKZEImtUFsaq?=
 =?us-ascii?Q?uvBZQsGQaV3e572Hjm/mncZJMBOG96MnRMH3qoSbTE7OID35reDQ1jxWaLUf?=
 =?us-ascii?Q?BIoLFJ0K7MdbjvtWYnUbz/5PTiFvwIW2jtKEQfYxpYdTKjx//uHHGdjgueGq?=
 =?us-ascii?Q?nLZ7YKiuHi+aOmZ/zpL4zQ/KvAtTXdkH0eM8SYVMKMv1aQb7CWniMZhWpoQe?=
 =?us-ascii?Q?hlg/0Dv6rN6bZDZS8K/A5lXpGHIhHXOQwjWXvFz9vMGEkUSe6xoTP/EoDkAO?=
 =?us-ascii?Q?kFx3p6yeT8ZVbjbE+outgmIz0sknpTSRcc2tNOKJhcTkJVNKlpDqHStQTccP?=
 =?us-ascii?Q?Pkkv2VZZYdcb6D2czRoNu08+E5NemkdGyJ0DyIhNNJJS70Xj0ONE/Xu7nt3o?=
 =?us-ascii?Q?WGNmIvywXO0t4OKqmIPMBGhLMy7WfsSqBi6Pp3cIM1KRtsvHJsQJU2jxEZSp?=
 =?us-ascii?Q?JRLT7Zn3ybF5eml8P7xU853Ec4zEYG32CiT1jSpRqhz0kK3Nb7a+PiZMy7Ls?=
 =?us-ascii?Q?X0p0G4ZavsF0jYZJTEoM699doxH0C6Ri5SRufL7rhbfGQ0NRX2wtuFNHoWim?=
 =?us-ascii?Q?8UlCpf4huXJtumuyIHE6ZCm8TEhb3zdb2IzaZiE09xsfzFIOdOVN4sg5QNeH?=
 =?us-ascii?Q?2ytcxJDzL7Ls5tz3sjIv/3ow19/XoExmYoNQM22H73I6iwXd/wXi8gKzab7d?=
 =?us-ascii?Q?ecAkxtRiDB/YdOqVcCTtDG4VxhoWAfXcl7wpKDONCHtXfsUvsnQXh/JB243N?=
 =?us-ascii?Q?lflk0ilR/Qe2m+f6smh3fPT3Sp/KPkTzHBWtqfz8d5tLa1GCj+eveoP/fWeT?=
 =?us-ascii?Q?ZEfGiK2mrSMhs0VqoAV8r8riTwKer093bmXdvvFZp19r1TgCU6j/NSmW8C8A?=
 =?us-ascii?Q?sc5JohRJM6k52ZQaXW/RKfWABI880zBMyy9nWcRVn+9pdOFTVQnYkVjDyYPo?=
 =?us-ascii?Q?XlA8hZqHDZayT2vmjlFgDgHu4nNTuJeO6+7X2RALoNm3uF1O49Yewoy8voc0?=
 =?us-ascii?Q?+st5em29kmA++93DlgvObJ8xdoMB69eULS95kRnJ9KHH/OQKAHnMZ/hghZy7?=
 =?us-ascii?Q?aovCZ0iqgVSeJ3ryEFPJco96U71VmdfhsOAR6l5vyjKAl/X4Hn9GXp+izU10?=
 =?us-ascii?Q?LWsbjh4KkcZ+1Ge5XBtlwn8jEYfx0+pL3Sc3Q1Wizj3quRwi/zV21QCcIOmd?=
 =?us-ascii?Q?9N1D2iE9ynBGr2x793oZeDRSZIculyVHS3xRWPsmX9I8B3l2TcnVWPk+dI/i?=
 =?us-ascii?Q?1LaCpHF+CCzEWf8RrmpwJbi1BjBPpZp9OBBPzmvrqBkNc8yDEJckwEYT/LxO?=
 =?us-ascii?Q?NgLXkpgrS+7DqUwqn60oQHrXcleUstGlfVTAJpzWM/olzdJU065THilth/8R?=
 =?us-ascii?Q?dRVvCJPP25JYTfmv93YEJwpUGOKRVd1fpOavuAwz2VNIe80NQyQPhn6rHdq6?=
 =?us-ascii?Q?UmXNxS0uuhIM0wETsDzaTntPesPQtFJ6SlD53WIaFtln5f85O4YDiBHN9o0X?=
 =?us-ascii?Q?mUROrv0mtQhQOyH8QIjaGtDBjjvWfUBQWq2NnyGoJIGmeKStLNVE4AVT5D/w?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 69af8b93-d493-43a7-ccbe-08dba9396eac
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 09:13:53.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPmIpsAmOilzKnJwgaJ+/t4mykdhLhAEn8c9eOiEwjxXN0DtcrsIN+a8PGuA3I+1CYxn7l52zhBEGXd4KMd/16k4lDriw4y+P8vrP1m8jXM=
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

A new SKB flag IPSKB_MULTIPATH is introduced for this purpose, set the
flag when route is looked up in ip_mkroute_input() and use it in
ip_extract_route_hint() to check for the existence of the flag.

Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
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
index a4e153dd615b..6a3f57a3fa41 100644
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

