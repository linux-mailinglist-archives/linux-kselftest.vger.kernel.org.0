Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06F578830C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 11:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjHYJJO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 05:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244124AbjHYJIv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 05:08:51 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2103.outbound.protection.outlook.com [40.107.6.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5A81FCA;
        Fri, 25 Aug 2023 02:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=El3AtzeBh7FzA8YEVFXQpBt4T2xmBLYUkfn3IDGGpETbaeC+r3W8kdoXAr0tO4grj1cXnGyKEvuVv/jt3i9hIRZdV3gIA2a+BUyfS5sCQT3GUQoCUm9MXfUVMizdsl0ZR9+63oZHg8/Vnbjcld2mtP2kKc+jcQDMruZtQ/n3fQAMqDYLtV5bNPfwxuM0/m3UeVJ6Fw9oQPT7xsyqbckqRZdqGqAef0azdnTO1UDfm20WnBodxgju4x4gpSv+eyANO4ePYj/4BjZOl5cimX64r1C1SpR0g0nEo5dvsI7k0Fw4EmUxWm8eUr/Ga9HCaCFYx6t+5C2whaValx1I20EPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK1SaxBau9ezB/599xhQ+OmyNo0RpfRZjw0urTfez3U=;
 b=cRbgczttlbB1BD+QK8XvBKT4q2Z4XeKbq9KQ7p8Cr6HG1pj0PZPktUSpSbJFzmascH48eMBKGkeXUORfi9Gz+glfAaqVCAn3AS0wj5/M+Vcf/8qX3SXIOgPFjX1R2FE3gSnkuquDVa9WOLMCjcjQTqD3vFFn2SN0yf9Nf/E7kuBj8aWlP4x/ceClP/WefUev22iE4OETXziNe+WxYzwt9+1sgqTC5yXoy8E7JDRDqvS2bT5pbB8DcrLzOv9oJ10nySWP0OJcZZs8RBAWBch0zSOtG1x60jtyOqUiraqL27ttryVhBq1sImc7cKoPeChRG89HWX2jvWVWwrHirI9Ssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK1SaxBau9ezB/599xhQ+OmyNo0RpfRZjw0urTfez3U=;
 b=AjNNNKHjArVftDSbrpOT4lQkyDaiWqNi3ykDOXc7PFmdqDMAIHBHfsby8jkGI65IHwRRoT82HExKo0eODpYm3k3KkUmyopwkvx2seeUCw2+irYHp7rs0eGB75RSjWlnHC1lJWSNOLMz4x3YERKIwdZRf6rQSNtFv/CBnHM3o2YQ=
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
Subject: [PATCH net v2 1/3] ipv4: ignore dst hint for multipath routes
Date:   Fri, 25 Aug 2023 11:08:28 +0200
Message-Id: <20230825090830.18635-2-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825090830.18635-1-sriram.yagnaraman@est.tech>
References: <20230825090830.18635-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::35) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|DB9P189MB1499:EE_
X-MS-Office365-Filtering-Correlation-Id: 29af3bc3-6b4d-4d3d-76bc-08dba54ade45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lU6onDRLpINo/qQoHIDvptisIYC7Rt9QAAdeRQbRU1T3vMzkyOshCkkteLCJRJpNpNIbN7+1QFQ4lCKHkufnjLy8PyOuAkf3beemEBfEyR3Nk84JdtiwdxzORRzfjDekrZ6RHDN63KEoyKcyFLuADXYzBXx/HKuMoOl0SNuYQDm28B4nQaFvQhuLbFpdj/riC6lDRgZcObd6qPnPcVu2FCx7q+b8mbEd8FsFRtdLd6Ub+iHAYFp3UygftOM1PCZu2CRWnGwYnJWKTSKFzvjohvcF+5fjLjq0NsIaXElwSNlI3jTbDd7b8RJfAjkyqefnYVRaHMo2w+4glz6BpVMJgaBDN8XJ9Qlsy7m+5R5gUolXexYVhEoA/0Lt9rPmw4fVdi2s9jjC69tXBPLRTSwH0/zruKBC+BFqr6txIVsOoKdiTy/kcCkzsdCljX5yohSxtdQ8dzA3rjL3I9Lbgkef0cGXhcNCsne90kh6D+q2uH2xoAytQfVCnSWvNxkz0tqWIoK1L4/0W7Z/+GWy+EiqyJdHR63csn0+ct9JDdgBsqxOmAgR3sJ6+ItkBtci+GQm289lPGYZlzyQox9F3OqdwDsbsBCQhauc3W2coD6iuFnaM+bUbniEFqTcysF98BkICS52IIKzUBNEClj8B8npSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39840400004)(186009)(1800799009)(109986022)(451199024)(66476007)(54906003)(66556008)(70586007)(66946007)(316002)(478600001)(26005)(38100700002)(6666004)(41300700001)(6506007)(86362001)(6486002)(6512007)(2906002)(4326008)(8676002)(8936002)(83380400001)(2616005)(5660300002)(7416002)(44832011)(1076003)(36756003)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nFgAekcRvK7Pd1ucSOf0EOS3fwtVgV6W7iXmpYLHKlILZs2ULK9E4vf3X1vj?=
 =?us-ascii?Q?ueaEkBryerMCrOuAF67HeBpJ73XTTLmrkt16mgnQfcigvgK7q3eu53joMDJ6?=
 =?us-ascii?Q?o2IxYB1aPdiMxO19sJWDGfpwgyP5XokZBpfn3J32YxFhKEjzSk6gsUzNnMmL?=
 =?us-ascii?Q?ABdoR0/X6WuYOmE3Yy4UIT+95lX6paCAlhivICrvHyrtD5I3+xi8k2SY2MRR?=
 =?us-ascii?Q?GANltXSglJpxwxXBjwc0FBwuncUZZeGYn9wc9eNfLTx+pBySRItR1Ry+Fp9f?=
 =?us-ascii?Q?BJei6Q6p2RDP6aXYOh8mftW3yssJCK5PORfn/G8xWc9jPsMIR7jn7x38JodK?=
 =?us-ascii?Q?drZ6v6E+MLy2w7suoXPkFLHgR+sSfKOe5Wt3n1Oj85ih8aCcSZ6yL5UCJrvk?=
 =?us-ascii?Q?k+GFiug9UR7YQjptXugFoV3slElK+7y2bugh6i2V8yef8+xf1sqjGlpp904Y?=
 =?us-ascii?Q?m2pNK1PCGVpHWBRZWym/viyY59DI3g+qG2AMHDOLT+ZlhDBJnjnpXsVOnwBG?=
 =?us-ascii?Q?tnFfTnCy5Ix2bg0Os2UXjTNzmiHzesqVTa0YKlG2IeRb086/k9k7l4ufYcRb?=
 =?us-ascii?Q?tkim4z40gMJr2+N7GXb7bw0Ituy5fi4xffIL7BnL9rQe0MtJUPNucgQRTIaL?=
 =?us-ascii?Q?GJjGNumn9ZIUQq1Cg8JksxLcB4/zYoHgWZj5tOqjWABVPlpOJJQe0H1+v0mG?=
 =?us-ascii?Q?u51+n6LsHbScqUkvlVilrqt4zMjARf3rUV8DJpouelPJC+/z0vUKbiQz9NeL?=
 =?us-ascii?Q?S50+WyFJBdDeT/DLL1sgZU1dEFQpk7uP+kNtnatUC6kHwkaJyzoB5i9ELmuK?=
 =?us-ascii?Q?1TK3mtmS3kLILjxFBS9zx2xW684UdRjHTrKHQWhNUmwdk/qelwEJwYOBHjyz?=
 =?us-ascii?Q?uS6c8mwnFe4QAWk42lXjBKcckdMIHRRtBLhoNgvo4kiNu3fg5F761YKAPdPr?=
 =?us-ascii?Q?ScPOpaaLeiUDI+SDAC/NZxPL8rCq+nmMCHvUIFX6hdZyEHRZAakndp2l+j8U?=
 =?us-ascii?Q?FXpWOvxpXLr0PyGIVTP3Btn5M4PtTu22IVpbNDDFuYRhLFVpjECHDFn8vic0?=
 =?us-ascii?Q?fqcZmtSg2Ko6aw7SYVpGsb+aV5KSqQJiCriNxksC0GBb3gOZGLVwSc0VcJqh?=
 =?us-ascii?Q?wABYna08abeIQxGaueX6/cRdj8S+HNc0W7xXfE1JMOMYn1mDUd6+tbXoyw3O?=
 =?us-ascii?Q?IqAyuHYklEJrcgnkrCEGUTcKyrOC+ALLGsrEDW80I/qTRvXfGYQqbDu3T2lq?=
 =?us-ascii?Q?gpO87foLyuH61lP+pmuQSEeUIMm870I8nnDi6PogQ8aR6H9FCLiiMB8QdDdI?=
 =?us-ascii?Q?czLw2C51s7l4MWcGKXUyXUuwr2w4hxN9I52H6HVz+YqpDsTAcKDBd2wpU2wW?=
 =?us-ascii?Q?glbiPQI2QkF+mE/lP+qwTYEdvr4SNsEvUP/J/QGpw5w1XFYdzR8uDKVLT5ng?=
 =?us-ascii?Q?4rlpgZLUpRlw0eGzZgcVolEEDnFF4mBAkNj5rtcyjzY0wiGrHZG5dkNiOGnw?=
 =?us-ascii?Q?DX8aX8+oCtHPPwrFcr9QxFm1hcIiKs8u53uPl9fBNc8jRM2NcWYny2S0f09I?=
 =?us-ascii?Q?JspqMOQuq6rP4v86pQ4uDdw7qeAJNBgsZXfgo1w+w6slNUYUq/60X28d3l8n?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 29af3bc3-6b4d-4d3d-76bc-08dba54ade45
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 09:08:37.9351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqgMQH2UVQ1m6tIP/yC9ekDoiKjnCiBkrdlGs1qMIk4uP8CtCxp//ORrjj1mPteO/OV8JPsxolEgxEj68eqUWajbpyYUM0yaka2mhSY8s3c=
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

