Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCBE7B1711
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 11:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjI1JU0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 05:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjI1JUY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 05:20:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A081A6;
        Thu, 28 Sep 2023 02:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7OvOXJ6A2AvNncuVS6UPvbqHWlQX22+BSf59fDgkchKiPsW1uHsxCmoxXtUcuOhLZVxTVOVEnnAWuK+uj7uZZM8JopQiKrgNc8nOZGukjPexNPTj7sz2p4QPjaMD6s8hwPuYWoL4QU+I5u9/TCK+rcfyucfUSP3ZKWe+EXOV+OsEX+xdrcw/SmrkdFM+kwBs/vDi2tEOHVU3BczU2lg0CkZuww1IwRwpWCzhR28pfR3BuNqINZi1MdPZMXgmIvRbQDnQb+QbHYTZYD37KaYaHQl/KgLvkUR9vyrnMDE8NUrT1ZvJkhnT1JWkV7w4h5EpSHLm4xCU33l3F+s8fO2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KUDgkNoWNLz6olOGCBWxS3YtdEF8jsbVo2evGPxWy4=;
 b=VddDyzw6cEXwqb8Y+CpjOuALEzD9LjNvsIaPhEslOZm+1CYM1KsEu/5+m0gXCJCbwOcAqq3lQOVSCgtNeER4S3GQc3iFjARN7bzZBEamk+b04K4EKxEX1RzgQjdn3hGFuUgvTZ5q0T8/Hawcz7c2ROS8yJXQeZ26zDz1X6fCetpGcwDrykxwHY4HuNhPBzjG7cg5kP0W13fc4aRK4vfht4SBpI1mgAiOMr8BDDEI/FkfW/ObX7DyiJ5daFFX6BJ4TR8QYvRMN6uYTi05jdblIDhPqD8o9dRolZ80meHCCKwODI+xdJs/+SMeKKuhe/50L25+ABquBu0qqbwl4O3ezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KUDgkNoWNLz6olOGCBWxS3YtdEF8jsbVo2evGPxWy4=;
 b=09MA+MazQyrBais5QxuTnM+m4wrk8YTq17OGoTirH9YPcq+FpZGVg5bXKoV3vhqoXTFTAaTRua+8aShQ5XY2VyMMWchh+Da24ax6AkNjzdC4KZnjQGUai9FBFa4P0B5P+InVHcxQYjZspBYJbZ2bHr1WnJhSCbVYMC3vQlajtlg8SpyYYLYEzI4ZhpniJ7iwl7KZ40hUDzdlzSofO1TI68401AKDrx+RD8BFae7U3DWr2ma59ujWbK7SvvgvtZ+lxHDw9MxpbWuQSBHT5CwxuRmrdvtJ3MI4wjBLuAGdF/oqO/8srTdevuq69QHnF5aoz+9ZmH/P4YorfdLjmVfmOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 09:20:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 09:20:18 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add pair_redir_to_connected helper
Date:   Thu, 28 Sep 2023 17:20:56 +0800
Message-Id: <1bc897b2603ebccabfa2a870977bde236714ded5.1695892503.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695892503.git.geliang.tang@suse.com>
References: <cover.1695892503.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: c1aa6043-8bd1-4c0c-f5bd-08dbc0042185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68LS2GE5JZa2zNg0OU9SKTdM3Gmy2r5dYGOZplgkxhSldlWtMW2+9ruavlSsGIsZL9fc5K8pO7yLt6mz6tjoiH7YaWbT1sTMCQ6wnZLRLY+cbdEqE361LNDU3R2UG3mrus4/aTVsTenx11uAMXSEURHVqmfh8Uk8/Ge2gYbRC/G486eKHapMwFXFA59H/Wewx/UHBUbDs2PNUO9FChTFZ3BVyZWF0DWoeMaC1jFYx0UV2LCf9pQE6hBJZ6JFRFeIlgIoBm26fZrsiELlYc0sBjf8lxh7/ZWx6HxD2pmmC/GdAvf9ds98uIQZIcx2kuAF/7wK/hMRCxo4n656wjj/nKTpOeqtVRi78/48+Iti7YsT5zPJi781bTO69Z5Dce9AwmgopXus+JnlSAgI9DOuO8pp4mI2EeABto2AR1logSVnB5214J5n8IUGECLYyV6floszijVMvQiZlhFS98aHYnnf3zutGXqFTZKquMobhJ//Puh2urr391uiIEjY54r8qXX7NDf9ZdguD6z0D+21tcrkDxgx1IGJGB3hMLq3hoaL/8KJNe4DWN6EJY3qCFIU8+um+P76eCPzd8XsZ5/H0OYwCsshnhy3s7o2iXU/MaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66946007)(8936002)(4326008)(83380400001)(921005)(26005)(8676002)(110136005)(316002)(66556008)(41300700001)(6486002)(2906002)(2616005)(44832011)(66476007)(6512007)(5660300002)(478600001)(6506007)(6666004)(7416002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J4UKD4eCh8HawNpz7b6kHtV4eBxA+XgxqJxpyQWAdnT9o8M2g1VuEMdrX+RK?=
 =?us-ascii?Q?1cQe62QkQPXQnKBxJW4S4ZKL2cj6Atqi/rThv2aMZzIDTOZgX7yW4VpX1t3y?=
 =?us-ascii?Q?iIxGQJUAHlD8biWiHKPTKHLnTEwcuqC5ttmOsL/HkdVWOBhtUTYU8D1mzg5F?=
 =?us-ascii?Q?unYc7QBSSxb5CClz38/iESlxxCs9LKCHO1Y2NZ2pJQsXQ8IkgLTVRNcKeFZb?=
 =?us-ascii?Q?+yXEO7dIo+vdMuFjkMluih2xHmqZU4oRGtVMeSUhRXIyu/oLc84F4o58XW2k?=
 =?us-ascii?Q?iPrtaLz/7fmTCL4Tc8q6Jl93VbiJ5xmdy3LVm7fgzMyJVk9QRM5vFhOcN6aN?=
 =?us-ascii?Q?5npcjnjDNkzUSlSRFmuNCSTpFs13eY1YINGSnOEriX72RO6p75v+s9t5mmno?=
 =?us-ascii?Q?nJuLHm3vzFhILpJMLs1G+YkF34oip5BOJOVgYEXMd2z2IWboUdB/dloyAo+T?=
 =?us-ascii?Q?y+mWIhsdCNjef277Cq78qj/8g1RlSgRkMU15issewSK+5PZjLrW8x1JCM5Xk?=
 =?us-ascii?Q?JsgEaHR/JyLcjtuz6l2r5JfwWGyp3Zpv2VA/Hv9M7AT7w1KOUodCj50uPy6R?=
 =?us-ascii?Q?8ABL+60TR7LXkhA7WwY2FVfgwlZYyexKAMH+DEXSYntLqU/wFj2QBRrC00GC?=
 =?us-ascii?Q?j7u5oI72AqXv1VftqBVHfjKA9iJ7G3O7mOFSUnRHHgRn5pA200aHMysqFv4O?=
 =?us-ascii?Q?1Q+9Rb1T6sVHJkIPMTX57u8D3OKuGAvC6Aeeo1gyFd4/GPgdxgD7wKSq6ROn?=
 =?us-ascii?Q?rqaNI6YRj2I6FcjRLip3la8onWBMpiEOVM4wkL8WqaskrLIl4KG3HCmk8PlT?=
 =?us-ascii?Q?3SpXmAneU7+ZSa7aFhtUmOEOXd34AM7No6wp3sMyZvUq0gvTbnH8P+w5giKX?=
 =?us-ascii?Q?IMxrVsVGFLA/pbTUycdj6VTRlK+iJsG5aq/TBUxzNx22NNY8EcgiVOHm5sed?=
 =?us-ascii?Q?S4aZ7Qh0+aTT+EFu7FCKLnrYZ5gg3t8UJMpxdj9tgvj0/P/WIHP2bEIqQYtM?=
 =?us-ascii?Q?VrijroSP8y6A/Y2NpH6dD5NZQs75S8B3TZZ/FpbnOTTlFLGBrUj+HEZP6C9w?=
 =?us-ascii?Q?GuBEoHle7o/mAO9najhIwBazXwQqicwekyxhDDvuG2OKTeHKb6dbvRWDtPe2?=
 =?us-ascii?Q?/vCpA2zuKvE026hStt0yD3gzFwZoEXlwYrR/Y5evjr5Zz22jg+RCTizlwfzS?=
 =?us-ascii?Q?7Lmxh8NRcmHqyA3L7YJLO4PBGhTrEQsvIyO19idlmM44xe0zZMtq3zZWUzDe?=
 =?us-ascii?Q?WHK9bHTAlVuH8Wk+AdfD40WuvnlYGon7EEZiNwCLxJ8OGVQiEe8sYyma2DTX?=
 =?us-ascii?Q?Qyi757Cv+tAvUs0+cl/MBKjyt5tD1LK8VN/ajSHeh3OduCzYWeDAC587ON6I?=
 =?us-ascii?Q?U3lSX0zk4IjLBK/CMEM9TeWvFrD+6ENjIg0wQioG5ETKwHU1cgKDzLOV86Hd?=
 =?us-ascii?Q?4PwfZWC3pbV9jNnlsAMwPdYen5VZ+Y5DT0BYgr+AYzhJVbhrK2wpWht/xzSi?=
 =?us-ascii?Q?VxAny+Mn9gmeLKGl8/mLikrim0TJc8vdAhBHfB2/34DTfzC5AIZ9XUBn2ef5?=
 =?us-ascii?Q?beTgDjXEkGNBdsZFXzk5K31n+UZKfZtfKTUq0IJt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1aa6043-8bd1-4c0c-f5bd-08dbc0042185
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 09:20:18.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zu2QBX0qKG6ztWVshnhAXXXylW+s+R37n0EqAUb8OygXi8VXJkc/XaKQY5FNu1dBUNANJQc4i9wUCPELz52iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extract duplicate code from these four functions

 unix_redir_to_connected()
 udp_redir_to_connected()
 inet_unix_redir_to_connected()
 unix_inet_redir_to_connected()

to create a new helper pair_redir_to_connected(). Create the different
socketpair in these four functions, then pass the socketpair infos to
the new common helper to do the connections.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 149 ++++--------------
 1 file changed, 30 insertions(+), 119 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 8df8cbb447f1..fbdf7eb23c1b 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1336,27 +1336,17 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
 	}
 }
 
-static void unix_redir_to_connected(int sotype, int sock_mapfd,
-			       int verd_mapfd, enum redir_mode mode)
+static void pair_redir_to_connected(int c0, int p0, int c1, int p1,
+		int sock_mapfd, int verd_mapfd, enum redir_mode mode)
 {
 	const char *log_prefix = redir_mode_str(mode);
-	int c0, c1, p0, p1;
 	unsigned int pass;
 	int err, n;
-	int sfd[2];
 	u32 key;
 	char b;
 
 	zero_verdict_count(verd_mapfd);
 
-	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
-		return;
-	c0 = sfd[0], p0 = sfd[1];
-
-	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
-		goto close0;
-	c1 = sfd[0], p1 = sfd[1];
-
 	err = add_to_sockmap(sock_mapfd, p0, p1);
 	if (err)
 		goto close;
@@ -1385,7 +1375,25 @@ static void unix_redir_to_connected(int sotype, int sock_mapfd,
 close:
 	xclose(c1);
 	xclose(p1);
-close0:
+}
+
+static void unix_redir_to_connected(int sotype, int sock_mapfd,
+			       int verd_mapfd, enum redir_mode mode)
+{
+	int c0, c1, p0, p1;
+	int sfd[2];
+
+	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
+		return;
+	c0 = sfd[0], p0 = sfd[1];
+
+	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
+		goto close;
+	c1 = sfd[0], p1 = sfd[1];
+
+	pair_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
+
+close:
 	xclose(c0);
 	xclose(p0);
 }
@@ -1661,51 +1669,19 @@ static int inet_socketpair(int family, int type, int *s, int *c)
 static void udp_redir_to_connected(int family, int sock_mapfd, int verd_mapfd,
 				   enum redir_mode mode)
 {
-	const char *log_prefix = redir_mode_str(mode);
 	int c0, c1, p0, p1;
-	unsigned int pass;
-	int err, n;
-	u32 key;
-	char b;
-
-	zero_verdict_count(verd_mapfd);
+	int err;
 
 	err = inet_socketpair(family, SOCK_DGRAM, &p0, &c0);
 	if (err)
 		return;
 	err = inet_socketpair(family, SOCK_DGRAM, &p1, &c1);
 	if (err)
-		goto close_cli0;
-
-	err = add_to_sockmap(sock_mapfd, p0, p1);
-	if (err)
-		goto close_cli1;
-
-	n = write(c1, "a", 1);
-	if (n < 0)
-		FAIL_ERRNO("%s: write", log_prefix);
-	if (n == 0)
-		FAIL("%s: incomplete write", log_prefix);
-	if (n < 1)
-		goto close_cli1;
-
-	key = SK_PASS;
-	err = xbpf_map_lookup_elem(verd_mapfd, &key, &pass);
-	if (err)
-		goto close_cli1;
-	if (pass != 1)
-		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
+		goto close;
 
-	n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0, IO_TIMEOUT_SEC);
-	if (n < 0)
-		FAIL_ERRNO("%s: recv_timeout", log_prefix);
-	if (n == 0)
-		FAIL("%s: incomplete recv", log_prefix);
+	pair_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
 
-close_cli1:
-	xclose(c1);
-	xclose(p1);
-close_cli0:
+close:
 	xclose(c0);
 	xclose(p0);
 }
@@ -1747,15 +1723,9 @@ static void test_udp_redir(struct test_sockmap_listen *skel, struct bpf_map *map
 static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
 					int verd_mapfd, enum redir_mode mode)
 {
-	const char *log_prefix = redir_mode_str(mode);
 	int c0, c1, p0, p1;
-	unsigned int pass;
-	int err, n;
 	int sfd[2];
-	u32 key;
-	char b;
-
-	zero_verdict_count(verd_mapfd);
+	int err;
 
 	if (socketpair(AF_UNIX, SOCK_DGRAM | SOCK_NONBLOCK, 0, sfd))
 		return;
@@ -1765,34 +1735,8 @@ static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
 	if (err)
 		goto close;
 
-	err = add_to_sockmap(sock_mapfd, p0, p1);
-	if (err)
-		goto close_cli1;
-
-	n = write(c1, "a", 1);
-	if (n < 0)
-		FAIL_ERRNO("%s: write", log_prefix);
-	if (n == 0)
-		FAIL("%s: incomplete write", log_prefix);
-	if (n < 1)
-		goto close_cli1;
+	pair_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
 
-	key = SK_PASS;
-	err = xbpf_map_lookup_elem(verd_mapfd, &key, &pass);
-	if (err)
-		goto close_cli1;
-	if (pass != 1)
-		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
-
-	n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0, IO_TIMEOUT_SEC);
-	if (n < 0)
-		FAIL_ERRNO("%s: recv_timeout", log_prefix);
-	if (n == 0)
-		FAIL("%s: incomplete recv", log_prefix);
-
-close_cli1:
-	xclose(c1);
-	xclose(p1);
 close:
 	xclose(c0);
 	xclose(p0);
@@ -1827,56 +1771,23 @@ static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
 					int verd_mapfd, enum redir_mode mode)
 {
-	const char *log_prefix = redir_mode_str(mode);
 	int c0, c1, p0, p1;
-	unsigned int pass;
-	int err, n;
 	int sfd[2];
-	u32 key;
-	char b;
-
-	zero_verdict_count(verd_mapfd);
+	int err;
 
 	err = inet_socketpair(family, SOCK_DGRAM, &p0, &c0);
 	if (err)
 		return;
 
 	if (socketpair(AF_UNIX, SOCK_DGRAM | SOCK_NONBLOCK, 0, sfd))
-		goto close_cli0;
-	c1 = sfd[0], p1 = sfd[1];
-
-	err = add_to_sockmap(sock_mapfd, p0, p1);
-	if (err)
-		goto close;
-
-	n = write(c1, "a", 1);
-	if (n < 0)
-		FAIL_ERRNO("%s: write", log_prefix);
-	if (n == 0)
-		FAIL("%s: incomplete write", log_prefix);
-	if (n < 1)
 		goto close;
+	c1 = sfd[0], p1 = sfd[1];
 
-	key = SK_PASS;
-	err = xbpf_map_lookup_elem(verd_mapfd, &key, &pass);
-	if (err)
-		goto close;
-	if (pass != 1)
-		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
-
-	n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0, IO_TIMEOUT_SEC);
-	if (n < 0)
-		FAIL_ERRNO("%s: recv_timeout", log_prefix);
-	if (n == 0)
-		FAIL("%s: incomplete recv", log_prefix);
+	pair_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
 
 close:
-	xclose(c1);
-	xclose(p1);
-close_cli0:
 	xclose(c0);
 	xclose(p0);
-
 }
 
 static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
-- 
2.35.3

