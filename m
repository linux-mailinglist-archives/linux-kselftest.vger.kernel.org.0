Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D162781957
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Aug 2023 13:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjHSLuu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Aug 2023 07:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHSLut (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Aug 2023 07:50:49 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2138.outbound.protection.outlook.com [40.107.14.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04428E40;
        Sat, 19 Aug 2023 04:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFIU6O+emtVKgNF89ZxfB1ELeUCRmnzyO94TMzS6oHJwixmI9ilEPbXSjL7+wgAbES7sgFjFTAyEhe1v6VpmwTDlBluJBOhrBHzwYxFKHxXyVCx9j89fRB/w/UXavEzRXK8m8A9JG/49NFzzgZQcltptDQcfsI9Z3itlWlW9zMtugcNkDB8bNv9hi/AVa4j2PflJY9DyEi8M4TCo0CTkmV+RtaBlOa0Fs4Cm5h0OW3h3zeo0Zl/epokcFfdHFUpmUaPCYIo9LveTv68PIesNY8MFpNlZBdS70K7UGm4IejohTOL2eC6ZTh5m4EUG0CMhirRhCXIztLQ1YS+b0V3M0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o0rhJlqav+t4qyW/MoMaNO6Zvbg4RccRp9L+S10wY0=;
 b=lz10ptwt8yvfP0TNlbdRnu11C41uYI/OyxbxsR8ik1PRKhaO/P0jr3ewkklaVlMiMPBEycz1ZrmXh/2d1Zsx9l3/k1XGPHLgLwI9oivXxEhupXQmIsKcvhGF72IHxnAPOODJxN2aSoLVn2SPgXIHSMZASjMokuZ2XAzSCWYBvu2jnsQeWNg1nDjZn3A4mzglnNB+0/mudxIHablv/6A/TlmcVRcEu4Dv2LEU4LbkhFl5+jvhhTezjohDNFgedt55k5IOUuy346VDi0oIGQBybnfQHoQWwepwVCvlkUkNWyQ9TPqmMXD8WPpZ2Dgo984QFIhGiYrsZmL9dQ1DhYs1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o0rhJlqav+t4qyW/MoMaNO6Zvbg4RccRp9L+S10wY0=;
 b=UoGha7CxEp5w7IHOmXlDEEutBLxbhluoGKtlm4qbZdRlENer48xOJQsQvVHgZPCCWDbj/ugZM0RlQlBiTn3qADiUU5BjH4iD3iCqpjQYxvQP/MYNFZDhOz1AdRErUS9iKjcuQAis5GUtBw7iexwgQ5P7xRwU6//YSljY7HfHGSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by VE1P189MB1133.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 11:48:32 +0000
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
Subject: [PATCH 1/3] ipv4: ignore dst hint for multipath routes
Date:   Sat, 19 Aug 2023 13:48:23 +0200
Message-Id: <20230819114825.30867-2-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819114825.30867-1-sriram.yagnaraman@est.tech>
References: <20230819114825.30867-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::32) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|VE1P189MB1133:EE_
X-MS-Office365-Filtering-Correlation-Id: c2430af3-a665-4bca-4f88-08dba0aa3605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gMhI+08ZNBM3FkaZAq29eow+VZk3aBWFbFeR1EbJSwEmOXxvUwuLQ8ghBLOtbPwt4bLaVPR+lBh0M4KosbDGalvrgMji56GuBCgSdsk/SsmmUB18SNuiNlfJgiz3N3Zy4GKLBPHmHnLtGsTlxd3FQCFN4IaO2Apl3bakTuenV5mnm2lYLZitWxkP52/DUuyYQFaL+FpQvG0KenhND6r4+yrX5EBsm4K/djCsTZTK7jmXgRBmTqTmb2nOAgG9bWFbeFd90Bp4naAdOiQhAJPHouGZRL+mSEK4L4prGAXLu0uNaVbrIe9lh0V14dwYSpVhQ/86WXRMOah8n0vBba8tRDj2q4r9USKpIAKYFdsOStXyR39NTryDx7nJ1lAZ+AF6Cxd7HPxPeSTCWj2RHjCvq8xAx0RMi8GZOtch/YzBcixnmjkc3RHKHJmTp7Oc5Sge9YhjXHySedO+RSI1TcjENyBU029Ut1J/437YL/nqZLL/qd9FIdRvVVBO0Ic41yIu1cgzU1Jv00lFm9spodJw496quPTS9KQAWaVurE5Gj2zMuAG3qDM/sc4W3883MG0ed7whgrMT7+RhY969dlEiY+Ufmk3YILs0qOzUjpJahaUqiX3vCQIubRG14v6OZBY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39830400003)(136003)(346002)(451199024)(1800799009)(109986022)(186009)(66556008)(66946007)(54906003)(66476007)(2906002)(4326008)(8676002)(8936002)(41300700001)(316002)(70586007)(6666004)(6486002)(5660300002)(44832011)(6506007)(478600001)(6512007)(2616005)(1076003)(26005)(83380400001)(38100700002)(86362001)(36756003)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6JpoubQOcbYFPo/O9BAZ2M4lTvkR2g4UufNEUc9LHZgNlJ77Ue1cd75abu1M?=
 =?us-ascii?Q?rmBm09pG4zKdkr5NcaFoEw/5ftBQhbV5wgbaiVbh073J+5STxeOO2YiJ8xoP?=
 =?us-ascii?Q?HYNJzTvS+5JDLVDLJWktKchBIkS4+6rZmuGrjXnvK+G63pZx/ttln8/bD61/?=
 =?us-ascii?Q?0ixPbifyOJrOSV+QmGeEoldgcVgLF6PuGCASBreY7YnP5DK7uj05iefq+A9q?=
 =?us-ascii?Q?qQ94DjMe1i/938+X4GBBBb/2tTU0Idmk9zDesTG56lLn9GTBgLwOPIIfiewv?=
 =?us-ascii?Q?cqW69hHGDw6V50JhHAQ9L/oU2ymNdJOAKztF13jP4G6KrtFs/mzo5AIpYY93?=
 =?us-ascii?Q?0uAVmdLkph0dXAuhlr0ZGGNNeH7wolhJ3UoZMifo1zv3qYJwzr1vY0kslALf?=
 =?us-ascii?Q?b/uEYmXwWDL6Ll8eSZ7vRcB/4ctOfSme3cgKOalUFCTSX7mIxqy+XDq5VqkK?=
 =?us-ascii?Q?HYSoHtvJtjZjU/YU1lM7as2z1tDocXrSd0M7Qq+zfbfyVQsopkmVDhw8ZsMY?=
 =?us-ascii?Q?2+quEm+7oFAz2Gq9ajbyNgMn5dBzRSkMRwiOyoD2mmNxgZdut4xj0aRyF3M2?=
 =?us-ascii?Q?mB0k6qJA+CTz4UKGw2UdOmLajvuVQXfG1Pk/HSebVMZCJBeXCR/ATJ6Yh1gF?=
 =?us-ascii?Q?y+gDkYbGlpOlql4EjHBGHY8jGeEV5389EDC6+8oZE3C8fSekMuAGkqaCt80X?=
 =?us-ascii?Q?I1brZ4i0Ch2NwhnEo817+VMUsZWMIau9gcvRNxWXogOVJc5oFlcP5MydtyHn?=
 =?us-ascii?Q?uSWQmh33bGdczN4wugMB2kp7TSZKo4/DFXhG68d+fLwygHxbK3TE4/uVXgKp?=
 =?us-ascii?Q?C8tvWC9uOMn4eznI+/qgtB+oOKdyKUIgQHrS3n0NCYRDmgzt4GcFajeheYHH?=
 =?us-ascii?Q?p6m3MDJy697/7wyzkEvhBrbM5ferK0iVHPqFyKK0lFZ+cIQ5tuHBljp9pbup?=
 =?us-ascii?Q?ahJXa6wyRzBkMLile6wYdtTeiM9+JP1syTvWqQ7wsK33A8yU9BjCtEGokOE2?=
 =?us-ascii?Q?BxTWOOAn04JqGjeUYW4HlWMtj7Q6XIuwjd+5KppioFGhPQJtOsKGR/RQ9ypN?=
 =?us-ascii?Q?nLDe25gAK1Y1PsoXet1ubB7U5Epxy6G3+7lcffy7DXvhOoC/gSukGMEaU557?=
 =?us-ascii?Q?UCStYTO6YtU+/ogGtzcrHxmCmnCCSDmAoGX4anQviQdZMB555U0MeQLD8dkA?=
 =?us-ascii?Q?u2jUQfbA6+3PggaIhxL52gnueUJN4tw6oOt0txlPGfAN4NnuOawcWpheNwCU?=
 =?us-ascii?Q?mnxFFXjv3u37cUsPOKulfby2u2IOyMMMaOQDwhBSoc9wDId/nn+5zDYWcYKx?=
 =?us-ascii?Q?R4sekRGWSapooi3+2N1LsGlWhuh7QzmcEO54vfdGLJnuzyZTMT5OmhKMRQZW?=
 =?us-ascii?Q?QGW9pz83wFgfqM6tyHrYPiOOcEHf+jA+4EJLtKx6zW5mwmjofHKlYF/Xmk7p?=
 =?us-ascii?Q?I0DVi01IjdTbEGPtOQQli5N+h8l++8XWgucJC8suvTdrZ2AUi7peAUQ/MT44?=
 =?us-ascii?Q?wUy2gP521YJy6Jfr8OeJz35uPYZ9mXt5WCH4lKhgditIFhqIcrl/4BMv8SJ/?=
 =?us-ascii?Q?lyvkU3OAYgqj7YMQOK1wj6p6L8MnXXTqwrbXdDpBdAsV2ARVL4yyOkWE/YC4?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: c2430af3-a665-4bca-4f88-08dba0aa3605
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 11:48:31.5248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mURj3FkXPq1gqQVZoFc2XFgnAs0OBkUayr9joIfxp6d8Kk7+91esC+SRVpxFm5fzfJ8fgQEm/gPRbzaW8rrQK9TVoMsXHZGw2dz2qTne1BI=
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

Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 include/net/ip.h    | 1 +
 net/ipv4/ip_input.c | 3 ++-
 net/ipv4/route.c    | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 332521170d9b..bdce572fa422 100644
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

