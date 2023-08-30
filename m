Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2D78DBB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbjH3Sh1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242664AbjH3JN5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 05:13:57 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2101.outbound.protection.outlook.com [40.107.105.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B7DD2;
        Wed, 30 Aug 2023 02:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYfXVE9nicRSiOaUwkwYBP3XQU2khEchC4OSn17NeuBS1xdcEF6QM7G3NAWq+0BmyZpwAzXXqvgHxtPl4xH56HgIb6ZCg73C9Y/IcK5p5u+oRJYU9RZUbkZ11g5f7Ls+lT3UugYRiq1BMjkVzMxSc0+EFquWRAs1eI2lr8VL5kDqjHF3Ti3q4y0EtQ2X9zHhFFxHYJb0nAxi4KI7aczRdrn17hYrGPPuTHS+jh0pv7dZiCLYDLcVNmGN2rN7Lw5VvQ7xAFSMQYHyTaXucJkbUudnqrXyj3PU3otf1ZVWKEU6S/e/xxKX5hS8IAZbEogiQyA6vmJNHpeYquHNf66BsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xB6tXRGqQfrmeXMsUNp8Bfs601jng6QZ0BwuHveSNk=;
 b=dJKE/xPpZEHx0UTyOHPbrP0rRRRgTT6HLRBkPvwbs7p2+PbiZKzj38JFYsasaqlEooW90+w3GspW+I3gRMqUoihxb8+q72rHney/pExqwRfirkoDLH2sWOHT4ZYoZLtn36CRi+ZGhlwCmItFCbhcDgrdV5pZ8/FQB+DRRKplgf8Kgh4Lzk0w7iLfWVCx0bWPCCSEh4H9EpArtuzTj/qV2raYxKcbrYarZznS5vcIQSd2WT0MgmQvfe41jvy2aacs6tpSox8Wd3/I8c9xM/rBAYKaqJD0jU/btEad7u7PWt6a4ITZF/19J9pYNf/uNG8hS+m+gmoKH69JeVQ81HP+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xB6tXRGqQfrmeXMsUNp8Bfs601jng6QZ0BwuHveSNk=;
 b=NFXiC7OVdvTT825+b5tXTdYNyXOBuN4UsfbJ2cx3vc9y2KjPviHKpKjnMjZKEVuwD5JPIDiIkchXeWzECMbljaZPfr7CHYYEgeSWGccCXs+Mjl9OAv7UldgAh6iI9EcqVG4mKsYHsmV4qMU1LFJUCCqkOjV8gmPPcx4DLZMHupI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS8P189MB2096.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:52d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Wed, 30 Aug
 2023 09:13:50 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 09:13:49 +0000
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
Subject: [PATCH net v4 0/3] Avoid TCP resets when using ECMP for load-balancing between multiple servers.
Date:   Wed, 30 Aug 2023 11:13:38 +0200
Message-Id: <20230830091341.17273-1-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0011.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::7)
 To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS8P189MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: b345031a-3319-4790-e1f6-08dba9396c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xClwkanpo0wisuoZ26d2buVibOU1WbWX+4BzBau3I8M6bAFZEISm8oMzYge7iL/swQ8sFSddkuErbTxS4x6dLTvhIkik9eYuOysXcg2r5+B/X3E1KcIDmI/O398knfPZyY31cqxkMMVUB595Jez5Pv3eES/TbHYhCd1bRHJT1rBqY5YvHMkN7Cyqzpzs8AcjCp8/3ViO4ITEFDRLrNb3QAQzbsTgrUQWLbytjCwTlAtaZbFnQnF+WLfXYAwGi14pNIj1nBZRYap+CEQlODpnxZjsyj99Nl/hbn0DM3chjfdlXsN0RR02Dh0giapHYxef61sjtnol6MHRpbMFsu8bQjYx4hRQ1sIOU/Z0LWs1tygexY/2D3N/s6eARMKj4pqsFO9ZvndkYVujPybBG8j3uCP5rHmNW0XkuPLu5fARTm9yJlUPlcU6xMVXtihj52VjVZPBRwBQkAVyOgD5Hxs+woaN0Z7phvWMOnNti7lgtQBxv6EDSX+M9IRdiJX7f5dFtcSHsMJ+0Khkt3v7sY5wSUC77IuOZ2zuXM5RcHSFy/gJuojI3kZsGEzOJvp4Gr3vWkxu2r8gvLHOvShDjNrJx1SeYGQTBDrqkH2Y74CELL5V6JQ8ydeHnB3oHDSII3ST
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39840400004)(1800799009)(109986022)(186009)(451199024)(8936002)(6666004)(478600001)(70586007)(66556008)(6506007)(66946007)(66476007)(54906003)(6486002)(316002)(38100700002)(41300700001)(6512007)(26005)(44832011)(5660300002)(8676002)(36756003)(1076003)(83380400001)(2906002)(2616005)(86362001)(7416002)(4326008)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2d+uSA9WCtMGJBKx/cF0+hVh/gC+Vc2zez22mD64uy8tcWuqKXz4LxfuLIqU?=
 =?us-ascii?Q?rnvHjYwD7ta2vlwSdXLpj2YvzCqJ4NDgQC/D1OgZkv+y/MoAf3UuO/PiSTVr?=
 =?us-ascii?Q?drAAU0Is1hfo5Pf047up0+/bJt00+lID2dnm1UpBAwFlA9vXjsKginnrRV29?=
 =?us-ascii?Q?cVL1kNIxwZ6XTiF1MOvOmuJXcfOtY4JnoJuQzjhulRuwfU7GlNv1T0nKWOIU?=
 =?us-ascii?Q?5/sszyp/a/DhV2B5VQzDjvt2rUwhesGfwD24dfi1bS0yIq16Y175qlPhoYqg?=
 =?us-ascii?Q?cier9x4DCBgGS1rXOxDJuY/W9xE1HhLl0rQdQuxCdxsbUjnUg69pEE0+JY/U?=
 =?us-ascii?Q?MCPzA+BUnLoa1M7BCe/kUBk4d3XTBmW4IEwb41ZCTyCr1kKFlI6mqp4lmXod?=
 =?us-ascii?Q?6tbbZEidIzT0tH2njTF9AiBqFwf0IkLI9ESNc349TXlZKUrvP/GLrJ6HQAKJ?=
 =?us-ascii?Q?h/9+CMXI4etgupSpVDC760Ac9DxFVmNr2QGgDpirEeel59Q3YAGNBcTwEOQm?=
 =?us-ascii?Q?k/VQc2JiwA4yglxH9VFSeoAqdrutLLghOPUVBZ9Qxqja67uMgsoFRLY8Me/E?=
 =?us-ascii?Q?3QGtorh3wtYkrHutq8LjZXRns+rQtulM3tkIs55rlo3NEj4q/2EvEJojdj4E?=
 =?us-ascii?Q?6NqwmkEpW/rMuIC6sxYXzU27fF+ddqnBAMxhM3DR8Zj4oD6xn9Q+2nWxsoSx?=
 =?us-ascii?Q?BW/VsZP4vxdEAmbWZDGLJ9myQhI8X4njX2kFlKE7cucaXGBeNM8VVWW7lTsz?=
 =?us-ascii?Q?uiGC2irGus+jY6ZHVsMmZvMu9HjoqoXpxqBnN+I+HrqdmvOrQwsO/v5oNJWe?=
 =?us-ascii?Q?qHyAOHtwWcKv7+yJNioxJ/Sjvx8uyj2dfACQBDWra1gnPWpsJFTfHnX3a5DS?=
 =?us-ascii?Q?nXpvqcrOIMJMdEgWsQJru5qpc6TtYgkmmPW5OHRT2PE5g6QlGr0a8wUOCKE6?=
 =?us-ascii?Q?oMnQgPEUpvhfUvmXznATCqZCBE+kJ4wSLulIV+qDOmxuG9lr5bpMVuMipLwT?=
 =?us-ascii?Q?y8i7fczg1vc+QZcr2VLavzQiT0GBW7FPslUTp1RAb6xEDgEqzsgnOxopbvnK?=
 =?us-ascii?Q?4QNk97XTk88/5oz5qRFdKLF1mY7q8wFBFr6KC8Xc9Lvztjg3pJ8CVV4ETAtc?=
 =?us-ascii?Q?b1EFizOwLsbBTlhhPXI2eNuADgNbRMK1acIj8pIb61RPS+JycEIqx1c83MLz?=
 =?us-ascii?Q?kN+YNU3h4w5Sbre4rxDzOhw8edwwyiBA1RqTLEN7QK0hxxtGiUTivf7A1Qis?=
 =?us-ascii?Q?OiO7o91h5a1hPeG2nNOjbT3F40meDNhwzcKMOBAk9N/a2K25EnpG+tbSViPl?=
 =?us-ascii?Q?cyXExXx79A+oo+GqHCMHzSDu2t+nnLSP0XYeVt7aHsQbU596PBxUGSDslmjX?=
 =?us-ascii?Q?B4YUupi6dG6X1z/sjJ6WecnSHBpbtl6uvvwcua2UzOSa1f8vtRI94tGilxz3?=
 =?us-ascii?Q?fIt7zLFcqG0BBbcEMlS8HQuwnbZIvp5RI/pCwkfrwQsl1XWmiudXepS90Ypn?=
 =?us-ascii?Q?wjT+0I2cLpVtsX9DVo9HQJW02YCmwE8rLt446tNqM5/sl9AY+yTNBcIcYZXI?=
 =?us-ascii?Q?mhqtCBw/rXKzEDy/5w5pJhZ1uRxg0lSr+mU9+SxMnnW0T0jaoLh35tsIw6NQ?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: b345031a-3319-4790-e1f6-08dba9396c39
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 09:13:49.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+7xwS0hJVH7FHbRiIiGMawueNzwAoqRg9/kdDn5W+T9uJNND8mjhEvxVizUYqc2z8yhvAqVv08HtrpzpCeHtMffKvq0SyfoTY20VmmCrag=
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

v3->v4:
- Remove single path test
- Rebase to latest
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
 tools/testing/selftests/net/fib_tests.sh | 158 ++++++++++++++++++++++-
 7 files changed, 167 insertions(+), 3 deletions(-)

-- 
2.34.1

