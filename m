Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA3678E783
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbjHaIDv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 04:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjHaIDu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 04:03:50 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2133.outbound.protection.outlook.com [40.107.22.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF41A4;
        Thu, 31 Aug 2023 01:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/FLDdmv4e04cNKkaNH+WgusoscvzXgI8wqGbc4Jj9TGwmwQB09Fb2dII1lXfLnNiej2ktFXdHmlWMl7EMi5Q+bcL09K1OnmFfvYtWpDrU6/IP2bioQjkiDWvsr63NALJDUPAIxFbnIEPEF3Y0cxEpa7L8KCgzSReF1oCJdP3YaWlhyfRBabUjJN9VfkP8lK3otTYmr9UY+I7E+gGL4SsusgdT54ipCOg02jjWXgrkpEeE6YCkZN+UCg+HakKJv9y3cTn+6R02TSYq0KeMNe3GgLDhSDd0cD14NeW+U1FA3eExgNUpEqEOGlritR/MV9L/WSan+SaFx+7mZUWPbn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkY11kfDOcqVDFHUtAFoI3MIPNDYp3mD2y+AgzXssrc=;
 b=i2cxc/nbQ83Gcxfq1byNr24DoM3vsD1KU4L7CDesHzN5sJjErxCf7lkg0SULnDT225JptS9axx+XXz9qPdXZiiTLvR4jCWazqBfo2vYVleA+rnozbC4Yo3R+7k4Cb2/gQzUmJLKZQ9I0/gPT6kDwZas4l2jXLa098O0kwujQTtWt+Fb7l/8LvuC6gWinJ8qV8ypEW5peSWiXU/RpAXlQyQow4Gr3Et2WjL/Roq/E0zmVhdxlQH/6RZxWqtIUNqdu/BXDdVkz8yxeri/buhaHEgUmLQjORNGUzrJYfBOmNN0snmUl0YCCt3p2PtXgYzSgMQMVoFIFj+m/+/z1IGn9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkY11kfDOcqVDFHUtAFoI3MIPNDYp3mD2y+AgzXssrc=;
 b=T9jHnz42gkCjIEi+xElbTW9GCjvxY2h+kl8/1QhtwS7DgAihx56HjjTArP9Ge2ecTXiUbDn1990lZtA/7MsRBZW9NODG8N3LBQiYiQcGnd7SKIVsQc5pY5F9xCrYUFvWUdPyrBJ0FeTb2YaSxvF1+4EwQ5SLyNDzPATWQEpcGeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by DB9P189MB1929.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:33a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 08:03:39 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 08:03:39 +0000
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
Subject: [PATCH net v5 1/3] ipv4: ignore dst hint for multipath routes
Date:   Thu, 31 Aug 2023 10:03:30 +0200
Message-Id: <20230831080332.2495-2-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831080332.2495-1-sriram.yagnaraman@est.tech>
References: <20230831080332.2495-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::8) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|DB9P189MB1929:EE_
X-MS-Office365-Filtering-Correlation-Id: e9fe18b2-4016-4422-6c83-08dba9f8c875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxj+29QIYZSTw2L8ToP68fWOq2oAhc2YMUf8PFO+sCK9FVtpAXsvnFvNN0X3Z3ySD3RpOH/5KZ5smLtf4hj8VEwyDK+iVgyIpY1SJ9IaVV9CJ8A+aSluk44997GMtG2LHR2nRAYPPteyYohbk9d/dfajz4sLDaR5vrLiPO+M/+YVlFI0QOZVbXYZ3rZPmSxS+54u38zxYI/ZxbQH6h10AZYaATbjN1JntqbuAATvuSeLRuSQ4RdSUFPmhITKq4VRi4lt5LtnLwpFRQR6SfWU+TvxX3M5IsK5ZlK84avREEuS/yNY8oJI6K1UQ4gcGqzX+j2RT9d1rS5lH+m5X1zDxoyblcMDYQPJvB/Q/FBFIs1WB9XH7e1HGmUhs3XM/UtWe7XXCo4+7sLdMBwfF75DhgQ6TBJbH1sqHrWCbGXulBeA/TIQrwPz3L0NLT196Xt5VuWuPIMjjLQnjRpMqi3iQIOVeAmFC5ItOlJcs+PnIZiFD2eoGdkTL3oswXWwKCis7FdvmezyYlSedrhdZ1IqmbcJIyBKQd59JLZRC/MgEQRBTDLVC3YOA2ZZM5KFRUjWC+ijI19QGNzpiTwtlJsnd8H7L7jN3U0aSL3AoX3eb9+i2ouSoHll2vyOW/t4o/5wAceS/bVlLR1lqkTWLAfAjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39840400004)(376002)(396003)(109986022)(1800799009)(451199024)(186009)(36756003)(7416002)(83380400001)(8676002)(86362001)(44832011)(41300700001)(8936002)(4326008)(5660300002)(6666004)(1076003)(26005)(2616005)(6486002)(6506007)(6512007)(478600001)(2906002)(38100700002)(54906003)(66556008)(66476007)(70586007)(66946007)(316002)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OZA78qA9mKd39TC4lhBRgDj0LEY0utQwKrzrXXpnA2fPPMLyDfgN0bPjlytc?=
 =?us-ascii?Q?CdCXE8PXSY+LtseKbO9BDVVgqcQo+TTPkdvJJUALBWdgWk6d9Mj/A6B/5ktk?=
 =?us-ascii?Q?E+f2eCoZ5eWeCalj2Z4Xkz06UTDv0x3/g1CdDiQqGpgkADi1QBS+d44a34r2?=
 =?us-ascii?Q?JjMSIc4h5sPUKkw5lAM9oOQUdDm78EZVRsjBEKkeabKp22EJDPdrtj4fybGW?=
 =?us-ascii?Q?b7mLEgsOlkOL1clqfWyqi6o6CEblgfH4Gykk5jNsatg9XOWHciGEE7Gz2BZw?=
 =?us-ascii?Q?0YeWeYq8l8ZZZNWWg+YJOF9v8uHmarJbew79GmrBpAlyp4lYyNzdoxBK2ysR?=
 =?us-ascii?Q?wE0Xztv+xV9hJ7DqDbVe9h2wQps41J4IN4RwCzvsAoYX+rsySR0z1HvUEcJ4?=
 =?us-ascii?Q?SsRB/YGX3pVTU+ELf4uu8RijERigTTjxxmDQQdDEJh8UCMLUax7sUR3bNWkj?=
 =?us-ascii?Q?PtZoYGF8YxeTBVHYvW8Pa/YByONn8eUxn9Slr406xwg7diK0ewIiOyArM8kR?=
 =?us-ascii?Q?WVpSWVofVinPTxsBjS61cebjt5zQNYqfX6Uywpn2oDdEMBMoeSVS+AOEv7LZ?=
 =?us-ascii?Q?3RISByA3zABra00f2A3fOaCI/D8rSmd4KlNmhdeZFVGENKE98n/NVoqVw3rN?=
 =?us-ascii?Q?149rwQZ1Gqg+Stfshw1fjBFfsSzdBj4vdUCoig6U4GYkeEPyHQqmxgFMcei3?=
 =?us-ascii?Q?cx+xAaf2ILpSh1IZRuWwIx3DDU1lnJxtaMgUD6iuoCo+SedF6M4k6gSzDAMn?=
 =?us-ascii?Q?CY/jyPKXM4YnDXX3Vn23I8IkAUE7naFq63YixcYv+gtg4mNa7S9HbQgi/OOp?=
 =?us-ascii?Q?FZUwd84+hv8aLy1V+kh50kzRRCAuKIDhL0vI0tiAKGwJzqDaf72HZOgt+DIa?=
 =?us-ascii?Q?UrCYiZZ0jgIjuHlnxCf+Exp2967OGoPoTgcpO6j/WYCSu4QbtmzhPp48aJl9?=
 =?us-ascii?Q?K1J9UYg9ST/wN0h3dMb8hCoWnmsFwZpOe5dGK7Yp8yp8FXuI9610n1EabBOr?=
 =?us-ascii?Q?1+X74FE5hQICKkDd4AZOWvXRfQX5PeNIVPi3iKNXlBNip/oyd/orOsVGLH+m?=
 =?us-ascii?Q?aU4RM0Dml9cYWcm3OZ/PYN6VMdmwpSJg1KlDAucnbIzRxM41gm5ltHOBh0nZ?=
 =?us-ascii?Q?w+SV+BE6C/1i2CX9cG3wQLYdvEXE+FnMAfEtbBIGZfVGhXEKf+UA0owEP+xt?=
 =?us-ascii?Q?KJh6EmYhEJlqQXzDG/344azy5yWw6jnf50BWwEIW0hofERcpmDfJps+SIpDg?=
 =?us-ascii?Q?9MZTIigwwjBv9DFaBykFinI6wB3xbv+Unasg2H84LWXLbILTXqul4Gq68YZB?=
 =?us-ascii?Q?WqOf/sIESl1uvtMy8f3A88GDYU0RWsyjbvFaebyEOkgSLqse0PXQF/U7asVM?=
 =?us-ascii?Q?Z70DdhbQd5yOa82uxi/C7YnLNtgNlyccHLQ9/W03A2nymeKeUEIY/bk/8Mdt?=
 =?us-ascii?Q?WebO9NkZvTE+Zie22nOKvrzLdWEvM/h5Ptkh3dsApN08F6iOTdvKJtiQZAd6?=
 =?us-ascii?Q?43cVUY5lBcJil+aHiZvHV0xbyRmKoJFUZ+WoEVP6MEVw2ed2vLI888cXVJq/?=
 =?us-ascii?Q?RXCcnNP0D1yd9DcjlnjI8HaOGcDcy2+5hmK5EMw6vsM9AEdZxOf1gkKeR/+h?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fe18b2-4016-4422-6c83-08dba9f8c875
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 08:03:38.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZb55cv5ow87wibR0XtdRdYoehK5+b095jyZ14LNOt4XYy7flqa9KurxSBBJCOz+YZalLJXYcDxM5h8F1ZHFAfZTPHVnbVexpRE+8R3dJvk=
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

