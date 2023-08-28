Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3AB78B038
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 14:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjH1M3P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 08:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjH1M2s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 08:28:48 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2104.outbound.protection.outlook.com [40.107.20.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A148EA;
        Mon, 28 Aug 2023 05:28:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaYDLZcJRTaeZXZEhVfslL2sbBRrRQIF1+z+PuxfVO9yFfPHj5WZ7+nAdvhZSixRfsOA6cq8sn3kdPSZ+PZf7N3N+wIwFnjf83fyeqJ8jBwpP4AFStujGeDVXoefNtRorzdy1u+CLcdTjK0X6TxI2jSNpJoi6JCglUi1L6CqjtRAS4W90pMe3VUzM0PgYOvMsOuXg73FnT6aANcBAK75I+8qn8J29LoXJybChESjBHjdNzJBoXb3qNHxUbMShd9irSYf1NR8TiD3DtJFz+BBilRv5q3oB60iSyeEG2BVmx2Acmd26yWSTF6NFBdIVpPVGZKJI35GtvFHyK2YjXXfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXbfVhRPAesFIcWKKmwcTSK6z+aXryL1GkJTtN5Ngyw=;
 b=Kfr+nbP/im5eeK8s31m6PE16JGbJlf8sd1G6D+B71myytN00kPRuEu4AGDFUXr0RDr3a5h4+qjwwbi9N4KaiguTJJTyAyau3wnxsOHu0mZtUUQqSxd7d/33RejH0KXNIbscItsc+CagNbygWgwpxy093ImaBHxFfZVZmCCxY670Gn7Ytzfx1l6Qq+y/OSjxX5UkRtLABGoWnvArb8txfWowk2CJhmyoPE+yQHZR2/4CVlo6IS8LZvBDFyu3z1PPDZhtvOHZA48XkZEefIuNEsw8UmZO85xpb8njcOABBmcy9KCScOaAOinPV/gjKjnVC2fXn30hbpgcrJOxqgA/IHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXbfVhRPAesFIcWKKmwcTSK6z+aXryL1GkJTtN5Ngyw=;
 b=LoKS5c2ZhCnaeXTdNvA/a2y0fDhsfwAC3DaM5JtvssT1x+XJoSQdpzl02UROc+5n4Sx/+0QVqXvzc6RvPzZUcYQcfSPPPnXJwgp6aDx5w7aWNAitZzAlqEIL2ufm011mGXgbllLRk9wkSY5iRjGVORMfs1/8/2ILhaBAQKzaR+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AM0P189MB0817.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:195::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Mon, 28 Aug
 2023 12:28:30 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:28:30 +0000
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
Subject: [PATCH net v3 0/3] Avoid TCP resets when using ECMP for load-balancing between multiple servers.
Date:   Mon, 28 Aug 2023 13:32:18 +0200
Message-Id: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::35) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AM0P189MB0817:EE_
X-MS-Office365-Filtering-Correlation-Id: 30498915-d0ca-413f-55ac-08dba7c2498b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awS7gssFZYLq0J7WqXCYLOYzaAd+SV0QFKdFKpfrJXzP8I0l+17Ckw40t0w6Fw8jGTxEf30cESQqJjI2Rz4xIs2+YpM2msRpNDel1/xYaHiJqU4hoBrpVwFZAfn2wVajRMaFylCHQixxEgZPpbSKZagfCPD+axDPfJ08e5jc+Iq3YE6qdbasr+ep89sbZVZmrnkdlWMOzonW/rGdjB8o2fF10bLbyY5XJeP1ieNKYGEnPBN7gDf7u+p7zykVbCMQ19Od+HK4eIDWQf6HG6lwGAyhXYtV0YOWIFQUSTwMzpoz+dKmi38rgAUnYZQ7kyKX/xZf7qw7J0aOR8WssSTRSQa4vVzq07PsRFYWNu+nSC4s/0vWVfOOTE4/ruLarZvIHB+RZ2KTESn1LAGQw/p3yoR6YPLePYH8Pu/mNC4KcUfZrhjwS/CeUVHlDJyovYk9IzB2g8UdBVKz5Q8EbnV4xAS6JzWTOd+T69XwFvQorKDp6aTiLK2+pRROmnC7h8oK4IZsPTaxhZrv9svM2NexWSyDHQcJw8zRSNFwnCgIPYMUSNWWpkJAUK51hUIq7F9DEGDp1PepBdUKGbHgw3XBDHLPnFdaExIth+E+Sd5vYSGDp1NxHDeZlV3EEIkty/EL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39830400003)(376002)(136003)(1800799009)(451199024)(186009)(109986022)(1076003)(44832011)(83380400001)(6512007)(478600001)(26005)(7416002)(2616005)(5660300002)(2906002)(8676002)(8936002)(4326008)(70586007)(6486002)(38100700002)(66946007)(66476007)(86362001)(66556008)(54906003)(41300700001)(36756003)(316002)(6666004)(6506007)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TsbHgd6jDAwHp4j7DTspMXMrjxTwJTbzMXII29C9gaiJJMGQDJ0TmhqPtRO3?=
 =?us-ascii?Q?vWy6FqcFDuDI/Uuts7szqt4e66cQ6YzcI/I2G5NX/4zw3WHYXMU3krBNlxYV?=
 =?us-ascii?Q?/1VRFuYv0d6lNRqK5FVFlhKvWyBWuCDvttHDnGrRChO0a7WTvkicOh++S/BG?=
 =?us-ascii?Q?FvrVrGs/OQ3mDijbf8AsGCv/nnCeBQLN6V8eKVfqUVWuRbfqUSzi0SKdpLHA?=
 =?us-ascii?Q?1+C8kac73QX2OOtW4vPapBX/BPvjR+kORFnJbjvOBYrMCinoKqOUX36qK9SJ?=
 =?us-ascii?Q?KYBqc2OG0rshwiPCHZa/HyMAwx42DU2Uyrj657zh1d9GijGnnqV7VOyQuCeo?=
 =?us-ascii?Q?3RaYl35XpR2brkayjw9oNA2sJmQIS+y+Mj39o2f8l+t2xlOwFZGzDE106wS5?=
 =?us-ascii?Q?0IHIF5ScJRISkwuZ1DnDhDYTIvWtLub5NQwHXh+8hZpQrl/dR0R2wpuvaC/G?=
 =?us-ascii?Q?IY/6733Vjy67CethYoW6F4yPKQAeWbPDv3dNyp2Ab8Xbpf3XTE6WMVpZjCt1?=
 =?us-ascii?Q?tS45iCi8Vvd1faaDaQYnT/n9DuDUEWSr7P+JdXTUc3F2wB6UQGGUmYVkeLcI?=
 =?us-ascii?Q?76GTbzCJioqtSSfmfjtdi/A1xQywCwSivaFDdDWrIM9WKmTelF0sA9m0UbPw?=
 =?us-ascii?Q?aBN5BKPy186PgZ4c6FKCW2USWORt1AlnZBMpFh9ASvuZCZIaWmuGaQwdkJqX?=
 =?us-ascii?Q?SXcf/DLF+SiTFUbIQxI5XrBf9jJRM72ydWN3LUCDiNugx7APzmiNvaNDKfmp?=
 =?us-ascii?Q?y/h4vauntUiBbEqI7PCvvnEwYOd6xMRV5eMjFpEujDvQSFhPr+Au9jU7oMUY?=
 =?us-ascii?Q?bk8jtOfK3O2PlQbWPSkHX9u7qpdZODlZcHNp8urW39FcKW8T1QvcwYSqp0sW?=
 =?us-ascii?Q?Ie/v+lEndtNm9dOTvl1L4OhQwvn/mTABeoWi7WKnWrM2S4+cAw9P8+hmdGJw?=
 =?us-ascii?Q?eIhKQLnHIG5b1Wxm8t1+bCigqufo+xlwrj16CVgY6ZDf2USKDowQ5qcWPcRc?=
 =?us-ascii?Q?EuVBFJgimiqeYNxFo7XX/9gNwMxywZyT+o2IHYXlq55UeMwjPeqwVwiTpj42?=
 =?us-ascii?Q?wFr5qmeSSeeQnEgWaEAVKGRyUA0RqszAIeaSjTDSmSwQDxVpqLDIP3/ypLhE?=
 =?us-ascii?Q?yW+XdqbrEZJQIaFcwxYV2y+arcmv6kn4HhGkmiUTUs/wQWwPFSxHHgY9H9hZ?=
 =?us-ascii?Q?32I9sWFdaz0V5TWANixoBVNLR5MGCzyCUrPDIjcrHWHdZB9xbx7nGs9eGNZ2?=
 =?us-ascii?Q?FIr3U6IAwPdvdbSUjCOZaXNIl9Tmyyc1qqYTfZ84xeDoFnp3rLZplPs6GxsJ?=
 =?us-ascii?Q?rYR4AbQgPtW2/iiuvskiSr68ZpBSpjKdeS/ZCjX41HNmZ0di7/fvVEo5n+cF?=
 =?us-ascii?Q?XJBtIifu8ccuDRDQbYmnU5Y8xYde/sPjfk8H87XL7D5pMPG2YtFkBw7IsBBd?=
 =?us-ascii?Q?XpB08LZ67LxFvvSP5eVCay0XQWBxLjkfm3tOR3ut/5cbtTZDIRkr8wyQ3z8v?=
 =?us-ascii?Q?DhTcHAlEbVdlRWjqPTLEjJ7IbbF1k3jDY94gcH3qJcDFaxOCmY/v6IVwYzwc?=
 =?us-ascii?Q?VsV4rdB7cC1WwXLMKzVNkZWnMLrI618fKsKFfFiMib4AuTIQJSiJW4eEdySg?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 30498915-d0ca-413f-55ac-08dba7c2498b
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 12:28:30.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpZX706jI+eaxILhqhU5uYoaFtxTES+7IPkZHJZNn+SfKAZF1PVcy/YWE9JiqHF0VntfH9H0pUyUcGC32qAyvNgvhIIh2I2Vb6G/fV+simA=
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

v2->v3:
- Add NULL check for skb in fib6_select_path (Ido Schimmel)
- Use fib_tests.sh for selftest instead of the forwarding suite (Ido
  Schimmel)
v1->v2:
- Update to commit messages describing the solution (Ido Schimmel)
- Use perf stat to count fib table lookups in selftest (Ido Schimmel)


Sriram Yagnaraman (3):
  ipv4: ignore dst hint for multipath routes
  ipv6: ignore dst hint for multipath routes
  selftests: fib_tests: Add multipath list receive tests

 include/linux/ipv6.h                     |   1 +
 include/net/ip.h                         |   1 +
 net/ipv4/ip_input.c                      |   3 +-
 net/ipv4/route.c                         |   1 +
 net/ipv6/ip6_input.c                     |   3 +-
 net/ipv6/route.c                         |   3 +
 tools/testing/selftests/net/fib_tests.sh | 150 ++++++++++++++++++++++-
 7 files changed, 159 insertions(+), 3 deletions(-)

-- 
2.34.1

