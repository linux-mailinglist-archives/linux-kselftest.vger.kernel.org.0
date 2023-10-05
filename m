Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174D67B9EC4
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjJEOME (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 10:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjJEOKD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 10:10:03 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A217A99;
        Thu,  5 Oct 2023 00:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KomtQwP09lqvn773I1ccdxOyI3YjboPtOFK0qjfRBjOpmZMDuQvW4ppRHklWZU6hwFsYscui6FHNclWuT3pCneG368KXb90ShEpYmKzgbDH3F9+rbpyqlyZpI5eGqlfalsx8HdmlVporecuzknys/j6R28xJvgUnHgvO0dgUI0wXQSwWTcc/XxxBFnTCUWhdLFKeOWDOzMIN81CFRJN2lFbm7teIkNGdyTY/ZV5RqPsqhIcZGDZLJR0x3pTJro5HcvmRCSuPJmoAgpgFGMlo0KnZXGr5xmWMke2eOarUVH5zHh/oYDuPMQHgGtNcILPZKr/Tf4FjcHcxdhn4E2wRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC/ykFCS881o3zURptxnd9lelpRrII1MeWykA1KuiHE=;
 b=kR6zd9MVyBiIqvtcij9sQCtREnwgui6VmRqGZ113FKrg/EWNQeSjOR0MteZpaZmD4X29uylKxFsIQWa/o0OLvYgHdJFYIDMD4QLnviS/8+5SMLl6GBGr8QkSm6AA0H4hjVWSKNhVoiGoR5xwL5ApfgkrFa5PpKUPlAYBa9LvaxsDwYMQIQ7e/Stj+JHG2eaCbZuY+dOEAudYyctVAGXt9/NPl4IaFqfvkhUCdpaGBj6yyxS62SmWTG6De6WRSZKEe/e8s048m6ih0mkAK+3UUXFo6T0godxyVjFWR6M7ogTgwYSR4q9Uyku6V1to0iwKsT5tMQYIhIE6ZnT1KwKZuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC/ykFCS881o3zURptxnd9lelpRrII1MeWykA1KuiHE=;
 b=5LOOBFFwP3MDIQzK5Wm8YDupGMNVOg8zPFd61A9eWjvdx93XGXc2Bws9bCE22J3OE7ymVI0rZpBGzjLFZHsLmmqOSRQZ7UJKzCYkuWk8FaNaacOGBeIlX7yuzr+28G/HWqqUYi9tZ522jFF6PbCU1baWboPoNN9Q3I2MBbx29aXWWldIIw4y5/8KCW/aGmJRe2ZDOXiPz/yo5YrlJ70E2llR9eO3TfDejE8mlteq+NBWqaVfims+HeejBi0PTH0BvDyGFBUiExJGVI3uM9j+iWhqSJ+mDl41LcuoI2wuLIY/sOvx0jUN13hYqQC8Aln5e6k9qnj4bcjvdtIC6LTioQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8999.eurprd04.prod.outlook.com (2603:10a6:10:2e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 07:21:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 07:21:03 +0000
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add pairs_redir_to_connected helper
Date:   Thu,  5 Oct 2023 15:21:52 +0800
Message-Id: <10920edc470974553e66e2391400dfa81ec03d47.1696490003.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1696490003.git.geliang.tang@suse.com>
References: <cover.1696490003.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ff3839-f8f0-401d-dea5-08dbc573a1f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Wl/SZYpA4Xz3Bp5qyjZE+nObBGOPhPoJ2adQxlZtusyD9pO1Cow1T9bR9MS1Z3+PZDXNOoU0nRsq8cwU+dSr/4IBQSGt4fUFCuKxJFkSMX5hPloIawW3d0nOeFuFojDZ6W6+OAk4igj038G72qorjkb70/ITkKuWLo/HphZmZtxLpTKRCA15MHhvJee2SLy7YTCpF6jL4A4N00upAn09oAPnr2b1bP54gm6Lb/IfzMdw8BXum/o/wOX5cXQlGofvO93d5jw++35NNq5tYIUQeyY3fqt0IMIYdPhULbKkyazBHXrNprwp/VDXNsAReGA9zws8klZ4XM+/EWMTwKrENRoPSxZA3K8c/AvCjYZacsLgO87GydP60uWADaB8+RcqvW7fYxOLcXYkPM7E8XPxE5Ef18441wkDM5AkWRVRV9GbbxbYIlvFUUCwXO447fKiry4Yic/5FlDkT8PBma4mal+2IA+9fXAtRnJ4J9TSC77TbbfBeSC8srWLnk8BPU8Bo6ogi7gmLIxoVmexlPGYOJb3vPYHMgoCnXVJTzlu4tXwSEYzlIXzNw9swTBZrCijSVxp77xkX07I40D/02yBC8RUFWqBlYdrfWfIAi2T0uga5Xr+9HbTSij/SieIzK/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(44832011)(83380400001)(5660300002)(2906002)(7416002)(6666004)(38100700002)(6506007)(6512007)(921005)(478600001)(86362001)(6486002)(36756003)(26005)(8676002)(8936002)(4326008)(66476007)(41300700001)(110136005)(66946007)(66556008)(316002)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xWEN02iXPciCQ3mliZ564GsV8DlkVxjibFpyeZRoAY9gAtRVfAH6fU6/Jcg4?=
 =?us-ascii?Q?UixGWHr79tDGFCHrRjuhRg1UAaYyAhe0Zn9d7QOZjj/74WxilyesEOg7DmdZ?=
 =?us-ascii?Q?l2dOzwbCuXkGYaShei6SK2hQ5YxG+MXg21LNo5dtJ1PeflaB3jfyWqeNqRUn?=
 =?us-ascii?Q?BTLeyAuN9bZ6gW8d/Ohn/o5kUgIc32tQ0GkrOwgjehQ172yWPH8mql1xPXau?=
 =?us-ascii?Q?fXtnvMESM8MeFvkYVJDDkfSTmpSSuTBovMeTxNcwlY/GGn7KNPPRWdtEhA6Z?=
 =?us-ascii?Q?H0aNJE05aYzlGl/Z4+BqbS/UUqAkNAf5WKeKi0hI/0BoZJUVh+qfh6azMbiM?=
 =?us-ascii?Q?YK7+DMi+oGAYWa4nNKuSGs4T4l2oYfApMUE4SRqQiB6fVnPr2mUSa4BYuGsq?=
 =?us-ascii?Q?fM4vNP9zXzcrLZCAz7uL2XdCAudnl/vwhcHLNOcvxdy4RXra0fy4i4pq5FhK?=
 =?us-ascii?Q?2Y8M971inmi0iVCpfo3Fw3kpUlvZo/rgRfZsDg90C7p7GsysOZ4PN314TMZK?=
 =?us-ascii?Q?tQKCbs7zsx7u338POqOXNN7gIb00UI0oFb74tme+ZqkvkF+ickor+D8Okvkx?=
 =?us-ascii?Q?ThsIwjbAO80MlPnZkZLTo3tUNElyD9Qxb9KPuXM3hJ79P2tHmlsV1XtXHC20?=
 =?us-ascii?Q?knkwr+WgYLyF3l8g3ygHCaPkkT8HtEKaMU/ivQEp4BRBmr1XLMQb4dFBrZs9?=
 =?us-ascii?Q?VVTCChx6dVZN1Plzz6P3zgWgqwjXyK8Z3kz1GSNzzGfVj07jwD9iFUOUg7rj?=
 =?us-ascii?Q?5e3aGEwviRV+qjOdZLx1oj3Z+Ri0+FSsCQFo31jqAUgL5Qjrq0XrJPTmW8Bf?=
 =?us-ascii?Q?b7p2B76Ny6PPu3Tuczcletm1d0bmI0LauAtfMQXYmZxzGND/a5s/sfDYeZY1?=
 =?us-ascii?Q?zN8Jcaq0xN3eaNucD0XAU8/IA9cG8za5IbklyoAffnkN1CfEeE0ySoUFMVW7?=
 =?us-ascii?Q?k5AuEeVxZvVaBQF8DJ1J9C0gyZO0WDBXSSJPnFjKzrTUT0PQ+PxxmVvraYRZ?=
 =?us-ascii?Q?sD7+bm7SlohiUI1SlcvSqUifHP+rxpFb7sTb7S3VE/R3zJsGDMsDgKt5twqR?=
 =?us-ascii?Q?zeLjm8N03bOUtPjMxrCoCF8c0kMzkfrm053F9fgN4o7AgVoNrVfTPpCs5buW?=
 =?us-ascii?Q?2TGhFkne7EX/PFVZhtpJo4i3S9UND+QwRRehCsYSTMhEy30iQNBfJpeE8Oem?=
 =?us-ascii?Q?3zJ2YebME3yUaNJig+QAl9yO6KHLfptGgfS3nZCmIgGEQYYhU/Vt/2l+w6zz?=
 =?us-ascii?Q?f81zG84w/x6VmSPzQ6zRYpEIexdXJxRQIUtJh+ZUFbjbxxIzV9sX4KOOZSOz?=
 =?us-ascii?Q?fOSl/aZddGMFUDu4EP1tdejYxxvZCwPD5QJsF5t0j68LxTP3JjLb8wEavdhV?=
 =?us-ascii?Q?1qWbJTRjBuuV6PlpX9E3aHs5/WZ165PKmTFYpowLheU2/qhmYMEmcBC3wZzq?=
 =?us-ascii?Q?7e2otcIFwHwjh0kaJ0jhqNAEiIWCmrEl+khw9tF68SZIJ4tF4vW1i4JSUJFW?=
 =?us-ascii?Q?kMWL+7HEAg1Yl49ox0Q6z8QcG4fxl/BxeEI1bA0cExFnAO7TePGcSbpaXDLB?=
 =?us-ascii?Q?fzFufRzMi10TYntXlk9p+aZcQNUjx0hHioyCKRz3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ff3839-f8f0-401d-dea5-08dbc573a1f9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 07:21:03.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjqX7GXh0wMkTek3uHVFjm8Q4M3X6caG6tspNk4N9Lu/9I/5cDkeNWekw+NY2H4/4HXP7ipCtD7APQah8f/5Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8999
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

to create a new helper pairs_redir_to_connected(). Create the different
socketpairs in these four functions, then pass the socketpairs info to
the new common helper to do the connections.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 159 ++++--------------
 1 file changed, 35 insertions(+), 124 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 8df8cbb447f1..74cbce11e22a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1336,32 +1336,22 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
 	}
 }
 
-static void unix_redir_to_connected(int sotype, int sock_mapfd,
-			       int verd_mapfd, enum redir_mode mode)
+static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
+				     int sock_mapfd, int verd_mapfd, enum redir_mode mode)
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
-	err = add_to_sockmap(sock_mapfd, p0, p1);
+	err = add_to_sockmap(sock_mapfd, peer0, peer1);
 	if (err)
 		goto close;
 
-	n = write(c1, "a", 1);
+	n = write(cli1, "a", 1);
 	if (n < 0)
 		FAIL_ERRNO("%s: write", log_prefix);
 	if (n == 0)
@@ -1376,16 +1366,34 @@ static void unix_redir_to_connected(int sotype, int sock_mapfd,
 	if (pass != 1)
 		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
 
-	n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0, IO_TIMEOUT_SEC);
+	n = recv_timeout(mode == REDIR_INGRESS ? peer0 : cli0, &b, 1, 0, IO_TIMEOUT_SEC);
 	if (n < 0)
 		FAIL_ERRNO("%s: recv_timeout", log_prefix);
 	if (n == 0)
 		FAIL("%s: incomplete recv", log_prefix);
 
 close:
-	xclose(c1);
-	xclose(p1);
-close0:
+	xclose(cli1);
+	xclose(peer1);
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
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
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
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
 
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
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
 
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
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
 
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

