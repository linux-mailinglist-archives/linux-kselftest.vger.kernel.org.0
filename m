Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5859C781955
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Aug 2023 13:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjHSLur (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Aug 2023 07:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHSLuq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Aug 2023 07:50:46 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2138.outbound.protection.outlook.com [40.107.14.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC0E1BB;
        Sat, 19 Aug 2023 04:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKrusq/slLMp0IryObhtMxQxa7UGN0+Lhl7r1+flItVnHE+oOxh8CB+BY+LEZLQJ3EMqfAP2CnauqkTjw76itQbG5Fh3sZ0Oe0I8cyxN5qfzHtgbsDCD/i2T8i5AsE6/w1qQT11A4RFVKKQz4qWhE2Sk9XwdUGZiH0Hsg7qlRc6yHBojYFCYZ9TW/zZr7HI0KuW7pquOmiK2aSKeP9FiVm0n1rpwN24T2ehaUCM4rz2A9q4Ygc7lQbOl+pjXXst6QZ3nolj0pz+RiZz4HB4p2WQukjlbeG88cuVhLTqagCa0L1bHTuZxSTSv6Q6hJumxIB7qCCZdTeIEZMXv0YmMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SL8nOcAO/BtKhkv7QDpKtzLve5uNk53bKxzsPAbm8E=;
 b=iWuPt1ecmKQbg3NiIMqfY/JCsDkzhJPuJp+l1IUhvgxmNgOeWyQp5sKfWj2SpWisMwtq6ClXyuMDAEsAXMqvnqHIdOGEwofFsWOSKPVO6nN8NtIEpCakMEFzSnyqLsIjUjMMrM3U6Jxz32f4vOwm4zoncCB3nXNMSQPIKK9SqOm++PrQFsqDRhB/VDC4jrAShbxkhADWXynrIdFRIABDDSXj20v4BJu9u8TXPXY0qbwimV/p0yCicrKCMqELmkpnSPPrEc5vaxPiH5UiGUrsTUAj5xm2kxFe8qf7S6SPE/IdEGs3ClGGy+m85mW3vcszYFcOREZPtplKUb0pswpkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SL8nOcAO/BtKhkv7QDpKtzLve5uNk53bKxzsPAbm8E=;
 b=UYDtJjjC+6Wz2j6+Xw4mmam9kCCRw7G7EuHijE3AL7pt8HSlpt84cBtYh3NyS0cR24Gxq/9oV2231oPBYnwl9rM/Re52kcceYJSzOjVb7I4rCjnTnskgK3OU2YHDCWXB08jAWE/KXpGA/tysDs+2RimLE8h67jo9jogZ3luIBm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by VE1P189MB1133.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 11:48:31 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 11:48:31 +0000
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
Subject: [PATCH 0/3] Avoid TCP resets when using ECMP for load-balancing between multiple servers.
Date:   Sat, 19 Aug 2023 13:48:22 +0200
Message-Id: <20230819114825.30867-1-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0096.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::35) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|VE1P189MB1133:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6c5367-d9b5-4b36-e18b-08dba0aa35b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sex9Nrhw2XfQhWQxHUt0Jc5R4buQear+NUpXs61rohzciK6LK90QhRhWVfDUTTvUV9OBW40iKn1s0ynH3Hx+fhr5CYGogLsDZwJe1DyWhyuhp2aZZyJBUJyR9QFIUTQgDuaXZoioKA7iBhelUpDxEBIEweezEt+wLLp7r4sriI8vAiJiy4coLZs5XYHEJqyV+szuKvS4D1dm+LPBPsw3jGlS/BecT3YTFzLIvi+N0EJQPu+uQ5C1YtSg/z7vDqAAOuSJuVzWCqrwFK43XLb4DJ4tuGCyJSCzHOMJwO9gioWyprAJcNQlxQzr6GcawktlpCSikFt1+DiriFCMtowXPtCo6hCdPSCo+w8yutMI6p2v+leSosTtK8wni7Lzvb/jqdMz1mo2x2SqhdpjbLcOWTtlcmbpH7SAnuX1EthouwMdYuCnXN8UBHDTmBQw8QhN1BdGjvmRH4eAPQ8DuJxhxUq5VMIMUmG0yth3lJa9fCC2Gpzo4ZBUBARsUpkmu7SQuKqO7EeFm7qIpdJWWGxmpP495yWPnWz0zutqco2yOTuS+co7/QN6nrxchiFoRH0Z2/nKPqzU4kYYZJ/c2c7VFIkdonNbSElRpD8EiH5hC9zoeUtcdv1rH+wK5Ch9pZTg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39830400003)(136003)(346002)(451199024)(1800799009)(109986022)(186009)(66556008)(66946007)(54906003)(66476007)(2906002)(4326008)(8676002)(8936002)(41300700001)(316002)(70586007)(966005)(6666004)(6486002)(5660300002)(44832011)(6506007)(478600001)(6512007)(2616005)(1076003)(26005)(83380400001)(38100700002)(66574015)(86362001)(36756003)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kolXSpP8jT9FtOgqLHX2XIfvcJL2JfnlrTAr65jk+Rmi3gN44q5rZCwqY4Fx?=
 =?us-ascii?Q?rir7eMoq37a/JY1Psu9Fz0uksyVsIG8hlDo6dAnI9fZoqKVzU/JGw006cN+7?=
 =?us-ascii?Q?jwvPhZ4SeQGoXFZpFoKL8iyD/TBdYuwQnoM8yGFaF5EGIoKuX3ZQYI62dkvV?=
 =?us-ascii?Q?rxXaa/bzhapLiqbSLHlGWEiQr5EUwNYYsym400VEt7DyMsyYwnkXo2Fb5O0/?=
 =?us-ascii?Q?TAO/TMBHhoOHkw01iFkUAGFN1Z+GffQujdIZLbI8+p0QVOPSMsi2XE3fkvQN?=
 =?us-ascii?Q?MmObzXB7ZbihU/ajJoN1r3OMOylQEvkKy361Ia5gO8Q9/phXUjFUz0oiCCJq?=
 =?us-ascii?Q?VTwvULDRYFqpON8YrBAHrkCayiPqC2J2W181If6GGg1B5dXrJzNP1/KfSlM4?=
 =?us-ascii?Q?koG/OVafOhAPA5O6t8+M+PVyf/5+FjqY5lOu4rZKWftCExDGgrjVekmWAcVg?=
 =?us-ascii?Q?3R2MfDIPIq033+foLIMA4yaQyu1Y8KrYmatR+xEVDpLkn2O1fa0AB+p0lnm5?=
 =?us-ascii?Q?3oRcMjw36GJHjqhg11h6dtf6ZCy/7VOlgm//hGNBaJIkcxx/ZDJGwyxFtSkf?=
 =?us-ascii?Q?iMzGXRTa529KHom7ibSmGojVZGmNFr68s8Vp+709M5UldQBvXu8PsaCxOvwD?=
 =?us-ascii?Q?CZNH4zxtKWy4EEAl/lqcz0pla6NUsmqDfIfjXUW9wbLUT6Zi5QEBK9WkFf2/?=
 =?us-ascii?Q?B6ipGKOsjm+3S0pSQYqdUag2XjA+hV82QyrojxjfXDDs3GrqfTTDOIU67ifQ?=
 =?us-ascii?Q?qxmP9C52qhPDcj8CNDF9+69AuUCh+QiDNxoz1+nkKZK3EcwZPZSnPJZtEMaM?=
 =?us-ascii?Q?ingla+cG9auFCSrduXxK2HdiDp++JWG0zpkkUpp1OrikotjvLFjliNTywztp?=
 =?us-ascii?Q?prS04nVnvEWQdS2GJx3/u1IoJhrMou/hWi+Q/p6OSeyQn9uxMt7gYk4tFOu4?=
 =?us-ascii?Q?PHvYQkNrNYtcFWmky3v1ebLCtGkKdX5FRmO00lnhCGi/Cd7TdxlmalJdx0+L?=
 =?us-ascii?Q?ayvb//+kQY5C+naaEHJO/q7RRtmX2YkrFhZ1ru1rGknHOJlM/LXn3IqwVBTA?=
 =?us-ascii?Q?zjChX0d19lGX4PglS6zc8FB+cpHdhjiI84CwTm3eztxwfJ6f/FJLznR43Om+?=
 =?us-ascii?Q?EMw38v3STYH0cBQpySqfOhhnlm+6TInlE6T5QKOSTfuRYNaJND8ie1wZMa0J?=
 =?us-ascii?Q?Mo4kPCuGMJqO2c30YOYfllCmfeA1Z3h1tfvKnU1Kcfg8ngzgn1LXCZnFnc09?=
 =?us-ascii?Q?0auHK72eJWJih8c4p0IqCTeviJdaQyrbektc2hO98t7BhzmcHFGuNFYXeW7h?=
 =?us-ascii?Q?8iOx8NlGyNd7nebKM5zaorfmxLocN2ylHqyMcig6FejdJQTr48LSKLgjydpS?=
 =?us-ascii?Q?/6OJFOfdK/UuRZYdm4dWEzHd87qeTc8NbubEgFINM6YxPkHMl11eelDq8NXB?=
 =?us-ascii?Q?iR2JggsJo0xVX8j4RVsxACKJf77Sfl7QNTyeii0D2Ujktamq6zip6Wi3y5xC?=
 =?us-ascii?Q?p998OY2zdjpJd2J5mar5PJFJxpsMUrk0gxhJ42YtYFEBQcEERgone8Yd0jh5?=
 =?us-ascii?Q?ZTI61AJg9+EisFlIMJ47vyd/Tg51BWinW7mtzGxA4CQm419cuxHjrM3mNyfe?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6c5367-d9b5-4b36-e18b-08dba0aa35b1
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 11:48:30.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U491Vl94Ympbqj0w9mHuMithEpz+2jo2oqT94exZzgzLqtxaA97obRvfg1hyHyL2KppWnY/KK1C+PabZVA34r/3PtWgIItzLwDxOjfrxNPE=
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

All packets in the same flow (L3/L4 depending on multipath hash policy)
should be directed to the same target, but after [0]/[1] we see stray
packets directed towards other targets. This, for instance, causes RST
to be sent on TCP connections.

The first two patches solve the problem by ignoring route hints for
destinations that are part of multipath group, by using new SKB flags
for IPv4 and IPv6. The third patch is a selftest that tests the
scenario.

Thanks to Ido, for reviewing and suggesting a way forward in [2].

[0]: commit 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
[1]: commit 197dbf24e360 
        ("ipv6: introduce and uses route look hints for list input.")
[2]: https://lore.kernel.org/netdev/20230815201048.1796-1-sriram.yagnaraman@est.tech/

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
 .../net/forwarding/router_multipath_vip.sh    | 403 ++++++++++++++++++
 8 files changed, 413 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/router_multipath_vip.sh

-- 
2.34.1

