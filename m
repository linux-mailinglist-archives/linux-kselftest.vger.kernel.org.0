Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6A07ADFA2
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 21:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjIYTkP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 15:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYTkO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 15:40:14 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2046.outbound.protection.outlook.com [40.92.64.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B9101;
        Mon, 25 Sep 2023 12:40:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlz6ugNUKeTCgUyepL2qJgkraoGSPfXK9vIIkQzgAViYv1OG0MAnwcGQbFCl5huJ2lZEZfAquN29cpLIXiangpCnJ16PiGoLu6OQ6ZZINM5g8+n+RNBzfzHzmbBL+7CIe5tsKLbaXv6ihfOwYxV0ei7biTs52HmjB2TTRcYFMVzWB1qYqHNVhnnhY0T19L1B38Oc3ZSNQHHQbbHjrRDkorTWy6S4AQ59wgChnTJUl3pLpvBkAMKSx6TL/szOXRSJ1xBBCeKAN/PcXp2XG7VMOWaEk5F1ys/8xRooOQqKE5ob20v+CsxYzi9A16grg6sNrxmwkX18C8/dUV2cpedABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CVD3Q27nJ01Fi3J203j4E6t6HvjGWGCK3DuwnLbYCo=;
 b=UZbJA0kxBn6ecM1RAMYB1lrQkyh0x7A4aL6XLqF7UNaFATBurVr6aMfkE5/xueCel6Oy+tm44TkDc9XqD6oOafG96wTNrOblMWhtL6dSS/24HdV/5jgOBzKySDXZ5K2Dj0a1JOhzMo8y7S1shDW5yN8YtTjwB/auMG0I18UkaUNJWMmbyk6bUfQtzlAi2/MFBI5unWgXu3PDnPYiDq3Q+BrAmWzz9p4tVu/vSV7mvs9Jcg14hbGZdXE1lFQ+xsLcn+oX43bnTxQjxnKA+ifpmQR/4UWrwyrAW3ZRvrl7ZCKprkWI8HmZ71muD4lsKq1XDqyisAF6usPfoCtq1V9kgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CVD3Q27nJ01Fi3J203j4E6t6HvjGWGCK3DuwnLbYCo=;
 b=D8EQyz4jg/6CC4JQm/FP5pf4VTLA59h3U2ePZ6fJdQvanEzYQMDI4fDgrYAbqYNTBBaGzd7QPPmoMFc176wHOXK2hiXswA3WEwVd9kDRKcmkUEo2Y7VlEKo6t7cBR0nuTDxZx/5dBEPixwdvX/F6P9ap9CNkcJRKvolB4EI8yk53NtIW4KTWstKaArEParXravT0wu0Q/F05+Zkl5P4Mmokpc2YYYfICVtQAl00cqyjeZXPc3Pf3lcu0ztiKSKubM140/fEObSFz+LyJ9bt/RfqYKaGoe8CuNBQ81yrSsa9H6mWHzKS/z3z9q7IVyv9vDeqw5EoOSU/cVnuHZv/mIw==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by AS8P193MB1207.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:33b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 19:40:04 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad%4]) with mapi id 15.20.6813.024; Mon, 25 Sep 2023
 19:40:04 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     longman@redhat.com, lizefan.x@bytedance.com, tj@kernel.org,
        hannes@cmpxchg.org, shuah@kernel.org
Cc:     cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests/cgroup: Fix awk usage in test_cpuset_prs.sh that may cause error
Date:   Tue, 26 Sep 2023 03:38:19 +0800
Message-ID: <VI1P193MB07522BFC89B6B6DC5A89153999FCA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Q1FYZPJYQuqtuAZ0vMiCQViRc0oaC9I1]
X-ClientProxiedBy: AS4PR09CA0001.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::7) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20230925193819.6603-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|AS8P193MB1207:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3ef119-0c17-40ad-8e14-08dbbdff3734
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rh6O9R7gcPbGz2f0EnL3urW8Um8l7GqeWqbVkLguPjfnMvebqm4/ORzyJ1bYNs59ZXzG9bECHvMECy83R7QPXZ0zOPeyM+WNT6mRPRSKqtYHqPdynZM9VEZKPZ1ewG4q2h7npHUvrXeC4UbVfmdF4vocmuTzMe5qAGMqQaMa+kXd9xllqOzLsZyU+2emsr8hUNb9CYUS96TLjGwgRoKQSKDeFkFgL+EJEkOpEwDJpmjYzIZ2ros78Bo+9enoGt9qX40bUu5Jl6XRgQjF41PNWGkSaNpGk3VbVO51tec4CmTTeqJ/Spa3tdddAUK0109eDUDUORljrIJfXV01yLoZnK1CA2UXbDqhslR2LbUD7PlhrIJz89S7lRdKeSU7cOzAL+qMRZkBAQ59xIOX1Rj5xpYX/sdgTczCkMUqOlXxdz6K/M1WYIMQhBZQM8afw1G1Bk53PDCwpPJk/RcLZMM5P6cL5TYiUY9OMqtBVUARXeH4DjofjIobMQvylE2Q1/5qrnSY/HOs7pPmTzvw3IWfNBm8cQWKO52tP7lznbVgej8mgYP/w/bENvfZP75cHAtB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RMbnDoI0ZvOB9E6cLBGpBS7bT8PnpuMfRLvL2JAzElvBpwJlprOQiEz2B9ux?=
 =?us-ascii?Q?AHkPKgi4qkUCTVf+19iCkPBlTWFOsiUjCTIdtYC4D5ANkZWaw/NaBxEwi6R5?=
 =?us-ascii?Q?zUpqgnoxLDsrlWa+/D8359HeOPtgyUBETwJTZL2gwjKcfI+ZB9DzklrwmV4f?=
 =?us-ascii?Q?slVlv1qmbAq1mZ0veyFwW1JKZ4X8ErlLd67q3q7Z+BgW+MriuoPEyHdiVRXi?=
 =?us-ascii?Q?EYXMahFNVtlhlW5x30hoIJlfbNdeg71QvqcqNi8wYMwKHNRIKeaUBh5unIuK?=
 =?us-ascii?Q?vj7tnLw3HhaBJE4V8HtW0EoYe/CKl3Ll1Uhw1wvf3/FBAMn7rvN91SMF8qEY?=
 =?us-ascii?Q?LlvlgI+TtqrdBpWBF3HKFOM5YPsmsv7048PfgApAMUoRbV+tLdoc+VRJvVEJ?=
 =?us-ascii?Q?rmdH9GEcOLcVtdwumOoFqOkfYfMg7MNPi6icpJHjf5ZFZkoTEOHuSDx4en9P?=
 =?us-ascii?Q?1y7G+DMoIF78MJD7Q6IKKf2FKZPv4e2ZukC9E9qp6MryyA5RANmPdSOnv/iF?=
 =?us-ascii?Q?601aSmZI/KDWHYbPogpBuhZItCXx4TFV9O5H9UyWRSdOli7DDC2ZdGP5kmUE?=
 =?us-ascii?Q?/PcE0qRJHVBBKlyCocVtmykA+A9OaS/gGWTP3ujlmbNow7dax0SkvW7XAFZz?=
 =?us-ascii?Q?M3ae3EwYvhv3z5OalNcawtjfV1EiGRjfdViqxKek4KqTPlH+Wg+9QdiK1tll?=
 =?us-ascii?Q?nHquVQKoQmABlVo1trZPtvs59r4xIqti9U4BvmPcN+WCaPHDB/qZjWuf+Vta?=
 =?us-ascii?Q?XtUzPyGo1fyQhQif+Qz3QTUZf/cVVOwOPSqYGVlzQAbShn34Brfl3v71uH+8?=
 =?us-ascii?Q?+aivyW6y8h+InSOl4xCzWYaKZp+xPMy86bxrk2KljZ8pJb/iYot+bS4mBHui?=
 =?us-ascii?Q?cUNRLOHkyLDQ2XnedeAFsdxKNPjLw66ZHqUz83Zcu0nBjfBx/BW+xRYQHJ1P?=
 =?us-ascii?Q?AShT5eisDAkhqAPcMkGuHlfKNmDqFX31ItjY31fdCxg+aWoyXqu8UPgG6+Oq?=
 =?us-ascii?Q?kBYL4NYrLPjDOVUtyCIjdiis6yfm3G5YRLvv8U6/w5xtS6hbhbQK0mHq4H3h?=
 =?us-ascii?Q?Nqy2csAtYLjbrD8FQ/vntuh5/mr/rGdgzKHGEZ9Msvp6MWc0+VpnPJjFQ9Fj?=
 =?us-ascii?Q?0yUt6u1PX9PrvIGNWH2I9N/x9Ce4iy87xb+3ydzC94S0cVEUDp1rYjnDPMCC?=
 =?us-ascii?Q?WsNvUTfMfnGct2mQi4HVJPupP8+0f8Cs14smmZ39427IeoPCMGaubu+uxQM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3ef119-0c17-40ad-8e14-08dbbdff3734
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 19:40:04.6035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1207
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

According to the awk manual, the -e option does not need to be specified
in front of 'program' (unless you need to mix program-file).

The redundant -e option can cause error when users use awk tools other
than gawk (for example, mawk does not support the -e option).

Error Example:
awk: not an option: -e
Cgroup v2 mount point not found!

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 4afb132e4e4f..6820653e8432 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -20,7 +20,7 @@ skip_test() {
 WAIT_INOTIFY=$(cd $(dirname $0); pwd)/wait_inotify
 
 # Find cgroup v2 mount point
-CGROUP2=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
+CGROUP2=$(mount -t cgroup2 | head -1 | awk '{print $3}')
 [[ -n "$CGROUP2" ]] || skip_test "Cgroup v2 mount point not found!"
 
 CPUS=$(lscpu | grep "^CPU(s):" | sed -e "s/.*:[[:space:]]*//")
-- 
2.39.2

