Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04F1788310
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 11:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbjHYJJP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 05:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244116AbjHYJIu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 05:08:50 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2103.outbound.protection.outlook.com [40.107.6.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF291FC3;
        Fri, 25 Aug 2023 02:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrGDFS0CPogVWsWXE0b1PW+2nD0SA5VsNFGAtAPjHOmf4RBbr6aaPK6QYb9DEjb+DmPBWzejxIVPR4bcp4TfylDMqtXDytfq+buaYgJBFH1pnIih5S0v4obVbNLJ869SBls/KeLm2MUAhJuxwnpNY+IdG5uUsV2FPRoQulyA5iKvo92bJGsWohXyYBRbW4IkMYRqrA6N7qaUkp37CNyJUqpYhxXtRTBkf5y37agzYGjWrS9kes7SB4R/MQAQYvr4ZOsTeoB0mPTYOsmCr3zFutwO01oyt5URLnSQGPCYm8hqn5sp5xcEzOcMDs4I8ilSSpzcvwxfhfYyMOo3djmQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZkt1Pc9P/uVZQoVCZk6jRO17Kv6cGwcBiY4UWYxN34=;
 b=VCzh6YTjCufBJ01fOlDrNuWHJZxcjXPKI31pyv+EeuiHy0DhuDY8cAWfzjSv60V+TwMB8KqM7STBMc2Vymt6oWb6UIAROZZ8j6v5ABiOvI5y9vEpE0OXhW5639j8s+LWWadg+ZtGLB1T5XmWqD0MFaDepJ4V4y4kd16+4j4Q0FzfdypHaq1WxHWDnyhvJjI4h2l49yAswIt6UQ1cDKZKFF9ZdvUZU8K3VIz1mQJKgV6krbShhOuugXZ7dY8LtRE5rDfKJ2d35utimOIQ3fkYYsGPmFdOiVZXdJGLct3Scvs2SF7rjHxRt33ceiQ9gqL6do7ALcCIJEeWX2NBrsbtKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZkt1Pc9P/uVZQoVCZk6jRO17Kv6cGwcBiY4UWYxN34=;
 b=h8/dO1Zydrr8PxDo3rvs+xRoNijEtg7nzLpDni2zCIUM5LJ2ze58Xb5T/ny769dXnkJ10vP2HbDTTYJVOG47HEddprc6B7nLK75VHHN4vnvl4lBj4zoeUgLqEo+0iOu3ZuA53+1Kj5UOMwsz44voo13nK/bJC/HRr/R1WgLz+sE=
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
Subject: [PATCH net v2 0/3] Avoid TCP resets when using ECMP for load-balancing between multiple servers.
Date:   Fri, 25 Aug 2023 11:08:27 +0200
Message-Id: <20230825090830.18635-1-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0025.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::21) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|DB9P189MB1499:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4ecf74-513b-439c-1489-08dba54ade43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+YDapQVD9+H3g7l08eMuTQSTO8ZfCeHLmADpvcwwBdF4L8OBl6+VsItqpnXADcKrTE3cTowsx5Qduqd0cLBFKHAGwFX7tCPLpb811xQRKvaH9o0GnCySd1I6qXOq3KcK3rmPpqK8B5xixpDC0PvhTbKbRbry5LcHmiH7B6mhNFWjx3Y4SwV/0gDrLMm8VtupKaSn4g2Ymk93C5CLOCPgY9T1Msk99Azwsc7/psYoGbEWjopm1uHHsBzm6Rq7gonbnGSIYaoQnZOYMTDTAvC8qror07kEuQAY0b2fPW5aTXWWHMaPPaIWXM/Ck6CyWNQKzKxyqQAjqU5pZYAjD8lqmbfOIJ+ZdkxprOjU1skfmHOlifdXOcFlc+zjkdibFMmlGQ2rvDL8Yd1oNPI9Ix87fAfJorAMWDB9PwhEpBfBU/gl7yETRCT5ltESV/yc57YJEI1C8TsZz+FayMV6PbJ0etB8knqXVO7qWHV73HPeb1h7MVtHdtIDuUq2MoNP1ls7s3dOPFUL/T3qCgdLhMJDtrcTC2O99nBPWw9vH7tGusKMRxz53q8b7NSyLIJYn+7+3MsI2UfHBDjpfd7RrQmVcvxVgPp3/korxe99Nx0sfJ0fU34o2sEeVuB+yroyub6oG8UvG7uc9kGT/5j5mVsvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39840400004)(186009)(1800799009)(109986022)(451199024)(66476007)(54906003)(66556008)(70586007)(66946007)(316002)(478600001)(26005)(38100700002)(6666004)(41300700001)(6506007)(86362001)(6486002)(6512007)(2906002)(4326008)(8676002)(66574015)(8936002)(83380400001)(2616005)(5660300002)(7416002)(44832011)(1076003)(36756003)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4V5er7cbaTzj9N2w6VuKwx4Q4GPje91m2KivA6mDmVHy+JYAxV7NoAcCSfMN?=
 =?us-ascii?Q?kZHXGnIfMO6B8wLOLVikNF7j0WK1cRzpXdc7DQXUpRc9SKShvj+tTRhoC28H?=
 =?us-ascii?Q?yAc4Oj93AO6ro780i0mkVccbZmJN4MJtem3sSPSMnQY5vR/Q0fQr2kbD4NbP?=
 =?us-ascii?Q?GdV2byafmZpXAqJyKxRb+Al3274XON0mUCSRacdXbNMf2l6gpEvx9y/26INA?=
 =?us-ascii?Q?V4VyvQJNdQRLAqbbP+4YRNUsa9U9+r24cXWBoG0Ads+07l77hFe6UQJKBXMe?=
 =?us-ascii?Q?a+IgIUUyAK1oEqNASl315nQAzbhPmiThZu4PXHyLytWiqfkqrtkTwVKTxxm3?=
 =?us-ascii?Q?DblnEKgIF205KOUhUfGpFzg+LITvWK0rUvrQIyGHqGEwPtUstgvbH/fyXkpX?=
 =?us-ascii?Q?OvyGyvq16TSNf5GuY+fiDGQw1qu/YgOKgbFJJw9XGF4jZ2LkiC7TRUJTS/x4?=
 =?us-ascii?Q?hfMFi6sVMWWHZn8Rz2YW1jacwLuSArdoUOKL9eDwNU1x9zggWAFgHeEam2q3?=
 =?us-ascii?Q?D2Mx88Wwdmi4YoVGlZYjJUzv4Wc65QkAZ3IhyEF9KTwK5RLAnVrY5malZUd4?=
 =?us-ascii?Q?M0qxS8wZ2ZNOHKfc29E8C9BfgUIhPukto7f0gs7+zBPS+qATVH4rGdANcKyY?=
 =?us-ascii?Q?9c8I7W24WcWD9JcaE+3pqMG7srEMiv8hPyft09FU1RkdkBSSSipoxnbe+r2T?=
 =?us-ascii?Q?juagZtQK9q0hop3IzZlYMo6wp3WCRc+hqZzlKDmeZhz8McZcrTLjMonJB4IP?=
 =?us-ascii?Q?Z623ucxAsvtYKOsTC01k6+yTHtLgPTdDFc+VpqdQRZz5Y29gWO/583lA3BbM?=
 =?us-ascii?Q?8oh0mjyRostD5T2+B3jtqny5lhnlY2Vl5gLOTMpDWxuaBlKeukDtr8hbCj7Q?=
 =?us-ascii?Q?1BdivTmznn6f5UITSLqxO6+2DlM738lx49sFL+h9SzQ/k7sIrFIh/4ScHNgH?=
 =?us-ascii?Q?YNXkAQZzCbYYoavceAUMhymJSvowHOkknvshDazdQRybd/x2bO2ey88syc/8?=
 =?us-ascii?Q?wfTQRdAIu09w90jQlf7olD1BsH6SSZu8hguiKbzyjpT9uD2oayg0UvDWDZI7?=
 =?us-ascii?Q?ZBgZGVPtIlAtTWNVAe5HvcX4mvxkzz28L5sjZVmVjAboQVvhYbjsJWyBfMxx?=
 =?us-ascii?Q?vp3w/3MPK4e2fgvaPJe/RsXjzDTrf3EmJnDG82ZZ6WQjTi/cUK/Ex5WVLaIg?=
 =?us-ascii?Q?GRhTW035XYuilmw4aL7V6LWsCAHerqkeRsWYp9CUbfXcxfvkDhifvyPqRYDQ?=
 =?us-ascii?Q?own1+H4QSHZBmfGc+c2LN+2x1ORthMCCBMcF4oE+DldJwWmWkPSRSYv2KXpK?=
 =?us-ascii?Q?9D7+0KN2pBT+aQ9805Ztmqbdl44wuZbZFedR7r0kwuDqRRJtBxt8ojUIrnK0?=
 =?us-ascii?Q?zLrUr0wvmtc4rvTFlyIenA7jRKGJSPf8bkd2BgUfHKetKTCt6sWuXuGgZ+N1?=
 =?us-ascii?Q?B3677Hx+Pv9IHExQARHxDuNV5s8RyN2e9BJGb6A0Ci7DTdOWxINquphcOLlU?=
 =?us-ascii?Q?NgawV5qMV87+h+HOAuFREjpGOWIQIBAleexj6atjmklti+akTNpz54VNeITR?=
 =?us-ascii?Q?Q7A3Cxm4BjHzzSKupM6HLJd9jnaEdG9TvX7/qw6Tns66NtvmpRwrVdvvY04e?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4ecf74-513b-439c-1489-08dba54ade43
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 09:08:37.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rztC2ItlOlkKaUld1ovuVn9Nzh54WMTpdlx/7XN2gC/WHugP5Yd9Blcq8kgl4FGrXeJAvSaEnuUYLwUu7635VwWK0wc7pExdCTTXSI6uiK8=
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

All packets in the same flow (L3/L4 depending on multipath hash policy)
should be directed to the same target, but after [0]/[1] we see stray
packets directed towards other targets. This, for instance, causes RST
to be sent on TCP connections.

The first two patches solve the problem by ignoring route hints for
destinations that are part of multipath group, by using new SKB flags
for IPv4 and IPv6. The third patch is a selftest that tests the
scenario.

Thanks to Ido, for reviewing and suggesting a way forward in [2] and
also suggesting how to write a selftest for this.

v1->v2:
- Update to commit messages describing the solution (Ido Schimmel)
- Use perf stat to count fib table lookups in selftest (Ido Schimmel)


Sriram Yagnaraman (3):
  ipv4: ignore dst hint for multipath routes
  ipv6: ignore dst hint for multipath routes
  selftests: forwarding: Add test for load-balancing between multiple
    servers

 include/linux/ipv6.h                          |   1 +
 include/net/ip.h                              |   1 +
 net/ipv4/ip_input.c                           |   3 +-
 net/ipv4/route.c                              |   1 +
 net/ipv6/ip6_input.c                          |   3 +-
 net/ipv6/route.c                              |   2 +
 .../testing/selftests/net/forwarding/Makefile |   1 +
 tools/testing/selftests/net/forwarding/lib.sh |   5 +
 .../net/forwarding/router_multipath_vip.sh    | 255 ++++++++++++++++++
 9 files changed, 270 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/router_multipath_vip.sh

-- 
2.34.1

