Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2730C78E785
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 10:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbjHaIDz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 04:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjHaIDy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 04:03:54 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2133.outbound.protection.outlook.com [40.107.22.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4482ACE6;
        Thu, 31 Aug 2023 01:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/vRYzreOboird5zVKbKD5MRK6SCL5S9RFGb7E32a8PaMjaDG816TGHZ+3U80WBPvVvJFQXGRK5PTJo60X8hTpvc1sqFTYC8fIXo0goKeMflQosK21m+be/QWIhYOa6CixYOlSayGGaYe1koyia41iC7TGEGZSfTbQXKPU94f4SbagGiN6QwK8G3fk6nJQuFIDLqoZY4alKF3Na+NJhxs4V5xxKxVf7AU0QXuug9M3FjiDsc5Tpul2s4unTsRkOtyBIHpf09yNl8QYSiX+9ygxxQ33QfSzAyNKhYHklBzFUD2UxEDm7RB0xXttJihQUsd/2PZ923u8OaNcBeeJDp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZapA3Ydxlp8tWV8g17C7HEtMpzYArWg5EJ06wUMgNdg=;
 b=blJMqqEt3VBrVDRkp8Lag8m1kBxRXVJmHT+axF4hj8e4tVnlCnWXSFRbEz4GASk7Fj0ZosUQwitJtdi8LmKIvhm4zOm7jCwlwtKO8/RDUIxHZysg/YmMCj1NkrfFr9oJW9kUp6Y5YYSnj2GkaYCSxEcfCzvvz+0mLrN1umK/ebpebDzTYqfxvbuP/3PCUP0tAJD4jo1ojcSN1Fxqz+2cvManZAquwzUD+0AYJhNN2luX642MS3zkRCVuaR1nGGwFRmYhu1MsAoCA1tgx3VMy7soDWIv/w6jWkNU+AE3vn0aGZCoC1IUTjvkFAmVZQO4Hc57+Qqxb0TsSKIe5av40GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZapA3Ydxlp8tWV8g17C7HEtMpzYArWg5EJ06wUMgNdg=;
 b=XV68uS648Wk70yKCWYtXaYPa6fvGu5esl0zzatBxui/W1JO3m/YVe5eHmVWvcyNXTaB7QupoeANZ+Et0XDxSo0EZDYaFVjJVsVKm+B18nK6LKjHJ/FG/THdGibAMy5StfTBNk+w3yh3Gc3Nr/sfEYSl96cJ+O7lmjzY2WYT6yMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by DB9P189MB1929.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:33a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 08:03:38 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 08:03:38 +0000
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
Subject: [PATCH net v5 0/3] Avoid TCP resets when using ECMP for load-balancing between multiple servers.
Date:   Thu, 31 Aug 2023 10:03:29 +0200
Message-Id: <20230831080332.2495-1-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0015.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::13) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|DB9P189MB1929:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6f7e34-84e3-439a-e376-08dba9f8c86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHA4hddzlKb2b2jSUWlQKNapKEl9pbpKmZbmM6WZFoweO1sW4XtSIiOTfwJfetftR4QPoha0PbiFVR9nVGWlRfHuvZhoICCkWkdBMU5XE7jlE9EgXG+4O8dSh35QtgT5olkjb6MRQjMQGL0JHmIsjTEkA3vRvRcRD8o2/3RJrZGr/B6HVCQGlwdKSuND4mIk2hSfqoLjZD5bA2m8poUkHRFNfKmhyK4eZuXWkmKlinWv+sU8ZoQoCJGkxsiixcbbdoNAPfr9SEuTfFQatdEHw9/lfZJkA0GTq7GSIHPwqULR3LTnyAvWPEIw/23kq7pbtPFFnMdTWhCbzzG1ksJPNORoTXUsfRqMyBsIvo/ie4LH70mHrQ2MHEOoJ8wdlqNiPEhXQZG2bzFDeWwvm8v9Cnqw9u7UAQH6qzN9McALj7uDMrrI91Zax5j9MQLv7gO6Me5UWD/F5JKO3R9XRFSp4YmIjIIb7rnqftGkVqlgqYMI2VnqjlH7T8qMi2LQG9cAXUbufHU+k2Xww+zYkDXIU8yzqlAiM3+kmqNzAEK7tfuMeHW7oTzJErIqjF90joXjgzWwQxGk1kJwqDpzpKmhd6WiK54VBbDuUVDdOOtmgPFrbLcou2NgcOTbQPTPTMlY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39840400004)(376002)(396003)(109986022)(1800799009)(451199024)(186009)(36756003)(7416002)(83380400001)(8676002)(86362001)(44832011)(41300700001)(8936002)(4326008)(5660300002)(6666004)(1076003)(26005)(2616005)(6486002)(6506007)(6512007)(478600001)(2906002)(38100700002)(54906003)(66556008)(66476007)(70586007)(66946007)(316002)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vxZN/Ni3Z+qUqnW/I1bdkgfDtMPlrGHBz1WyhO//6W98+n4LGobrHZudc5kc?=
 =?us-ascii?Q?fqtAjFJ9lmWu6hP5hheuAXmHPrs5wB6m2pWm/SQF04vDX5nf88O3VuFLRoCG?=
 =?us-ascii?Q?h6mZCpb5dMBKd+YdOc1A5Or+gRbyja7yTPahUSQKstTfUDaSKTw3GhIC7DCu?=
 =?us-ascii?Q?JastJcs3DiqJxw1t9kf/8nSong5SLGz9hlgNebPN1TXFF4VacmW6PUdHFN4b?=
 =?us-ascii?Q?o2QOWxq/zym48ndJmq0s8xOjLvx8M246SuBWCeYPlT4i35S1MljHyH0XJeSe?=
 =?us-ascii?Q?CklVIhfS1xv4e/Chk163HuyApFI7t8KPi2J6Rl2SuYUxnINBPAqSLbNyUp9F?=
 =?us-ascii?Q?Ilv5CErKNWfzu/D4O3HsRP/cLDIKC4NDcRNUOoP+W0Zwve2W4WIWhC/NkuSH?=
 =?us-ascii?Q?lqW4BJAHRwwTZHGt5eoWC4RTSbkT+/y+oFDBz0z7W1VxeJdT4IqjkLUM9Qwu?=
 =?us-ascii?Q?j/sPkrFc+7PLwCO8Qhwbbel/T2HKTOnxalPVPKaQfKW+HfCpKa6tiI/59IyE?=
 =?us-ascii?Q?8ebxfIhk87UDNyWSMaBb+lrI9GifjSqCYCfMxzopVsCv3tOHdCW6ylfI33CV?=
 =?us-ascii?Q?qxmgPQEP40PYIoGgcUkX9VwgvZeDVPH93JtAtcyckduBzM24cgAB19VDDLCC?=
 =?us-ascii?Q?1zpyM/CusysTJzubPUeHN23qS9wBugXZv26iv4wcX6oYvQ/A0Y+ZUUeyxkIB?=
 =?us-ascii?Q?k+UB2vI/m9VYUvezH9Gwksg62QtRrhfxM5SetAR9EpJOtE7xD5A1ERh2i7/D?=
 =?us-ascii?Q?5+uFB82KUo1LuXdfoFTlv4gV5nD0BHGA9SGXNdOJrVIKdrVQ48PelAkIz7yF?=
 =?us-ascii?Q?d7YNGibhlaHcy5SQruP3f5jw7ZQFR2G9PY0k6yi+ExMiyPP9ai8leFbAcLiJ?=
 =?us-ascii?Q?hb1CeiJhpT3c2hU7b9k8KIX4IT7p5WGDONaGj+3iI+cJzZjJEICQeYOw/+lx?=
 =?us-ascii?Q?xIxbmeOwhVuNsVowd5bhCh0vy7Ic/LpnWmOJFQpSA2BtTcA5oJ2muWbetuTv?=
 =?us-ascii?Q?/MLSefvYhR1Rr9aNZ5Eybj5fpUnTcMUX0CzJxbQv5FfDAFwkMNuVURyJfwXh?=
 =?us-ascii?Q?69tmYqFmytlzv/QDWpdHSb5xCjCChfjKY5DPFfbnRTtbToWgkxJ+ZpiXL0V1?=
 =?us-ascii?Q?zJXS4/Vj0nzcKGbFHj0Wyg3l1kapirAQQYAgSMFQVzl9vgVmj2t3dzUZxf9O?=
 =?us-ascii?Q?KI3EgirBF8jiMJmW44U/Odj9md21MPr558wgE/EdREerVhiQnK1FhvDEVnPX?=
 =?us-ascii?Q?qukUdrt5cAkYLs/eZkevr8I3c7QMOmEXL+CPm6p+MHrtYNPXQyyb1tnlYrpF?=
 =?us-ascii?Q?sPqmewQ5h34+QaJ9yU44Zd3uA9EobNqNq9AUsh6dMzRPoR7pR0Y5xmSYTHNy?=
 =?us-ascii?Q?jxTv6GaqiyK+5qIM7U3NdhnGGbfdd16n3S7u/C8Ol4bm+ILw8WyZfDSfwjKT?=
 =?us-ascii?Q?ypungFOuF5kNgvQxJKHIt2pxrBDtdEp8Vbh3zCko6ioRv0bSV5KcQVJfoVcM?=
 =?us-ascii?Q?7O/Dwf1QXPFo+7bY8Buw6SXVZzzDAmNW4CrcTZq9fNa7JzmzhDJcKZGCQhPF?=
 =?us-ascii?Q?yUGWOyg5IUHeZNLuXJ3YpZuN128J69Imf27kv/2KUsROe0SIj8SEBZb0r+QQ?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6f7e34-84e3-439a-e376-08dba9f8c86b
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 08:03:38.4116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXeosjLuK0psjVasFDB1ogpINiYOZSwsk5itH+phEoo8yp4oyB0A7qvOZraDfInsNvLYrohIwHQespkjM2lXj7XbMsmHDj/QlVit3ZYaUaY=
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

v4->v5:
- Fixed review comments from Ido
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
 tools/testing/selftests/net/fib_tests.sh | 155 ++++++++++++++++++++++-
 7 files changed, 164 insertions(+), 3 deletions(-)

-- 
2.34.1

