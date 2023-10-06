Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989B07BB542
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 12:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjJFKbV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 06:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjJFKbL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 06:31:11 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E1FC;
        Fri,  6 Oct 2023 03:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZ8lgAMea0YlJ8afVTsM5cDfCTvkaLTL0JUp223ZKDmqzL3PsJ5678BQ6XUNii5V6gvfZxJjxlQouSQWLehHKcCUcWapQMottIWZYSZv1RYc9gMD8ZbWB8E+Drc7HhWNpyoqXg9tjd/0jDV4YmQoxtLSZvcwNgZclhxH/x7DzdRCBsYU8VvN9nrolAljUXP7O1V4gXHViPIFgaS4BEuu6nw4TUKZ7U9M5zf72kN3xyIHY9sNxZZkh/n6uFP+NJHAPr5I09L4on4ffSWCvFLtZ/yGS6WGeLclunVZz4g6th/Ayw6Pt11nB16g+jqF1kZBsLqCLBDlXP/15g6eE0ubTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYTAALXat5Yuil7FifOlAdx+XWTXfwuHRVSQo9PzU/I=;
 b=mJTzNqzAetfEC/FI1iXMW8xJwrWWYwmi+H5YkP4hlyRXENduo0IYoQi7DXptkmBIAET/vGe7x6PWE1k9r3meYYI4c9cJgs0rPCN4fwJ5RNzNO3+w7Yhz3RQWNsnQpe47CyA0EVcK/3Oiyp97N3BBAtqcBMVvhQ692x06LOtztJeHaFbGyydTt0h5+UcibSHj3+GdXJYvc4SeUcwZWXu5y8MHu926PSkfnfiHJa8CYUS4hjZXyAoHquYZ2k9CUqakQ0aB6vjCwL+dqsNJSTaPTYiFFiVueZUbYX9vOaF+5SYCv0IIqsiqOzUS54zNB9lQPPcH68wThctT6fn6xDIbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYTAALXat5Yuil7FifOlAdx+XWTXfwuHRVSQo9PzU/I=;
 b=Hc6QqXwWtJZivRZKI1qWO/CEMHTX6f9YNDEFmRZtKXdWl3sKOVXIw3woS6jXdP8W9oG1NSyyVZy1pP254wj/eqocydOBS6ZLgdWX1VJ7n+oPPGjvU/ldksQ0Hjvf6wz4mkufyZFai5pmK35TlrXYPVtvIRv9EN1nO8znJXbM9Gv+NEph/Ex+VPZ17uKEIvi7CRtOnpyTxGBX3KjVOAME0UQbnHX9IDt5bPKOAEplQMK8qA2rtJ/Z5ZqLz3Omzso4soicBSm5mUXlF7JdbFXJ9mx1RnIL/viAIEC/cJrazbDbl2BCJq/rcealhW/4dEvA/ahTv1i9WWzliSYMHCtw4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9703.eurprd04.prod.outlook.com (2603:10a6:10:302::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 10:31:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Fri, 6 Oct 2023
 10:31:03 +0000
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
Subject: [PATCH bpf-next v3] selftests/bpf: Add pairs_redir_to_connected helper
Date:   Fri,  6 Oct 2023 18:32:16 +0800
Message-Id: <54bb28dcf764e7d4227ab160883931d2173f4f3d.1696588133.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: d4efa0ad-06bc-4f9e-0d78-08dbc65756fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwXTfrUwokqeiblF9ykGvBWUwa6OK6V9ljaecCgu9P4FFrXAWE+Ma+MTT5BlAt19NMDrbCXimiHJcGdmsUyyjRzf5k1Q/Mc3F+MLWCwtip8nlTDK6YQHMzdO7+8nwLYUmFBOZHGpODotIq5w5yospqcSt5i7lB+gvqX3MtH74YhM1pCSG3IpGOMQXcHlxAsvjHSE3XfcS+fo4+4uxRuHRSxyvJ6e5pg8xQTumGTSAt9YyhTqqawI1AprVkjxZq4a3FmywH6vA21sEoZs1qWT6um52raqNTLeZa9CmIZSlb9P1iVZsEw/E6zr0UzlntnIAbxMY4nmK5GJDJLAoAUQ2Q2MQXsVt27Cio+4Vxl0qRzD2b/7AeW0S3rjS2mfodoPmBmvT+jhLz6BLmqtZT7X676dQFOhix+WqMNc19vVuaqf0Z6AP+86eexJZeuJ+cCqW1M0kARTRBI5JtYLY3OfZl8Z2ozbmLkl92iFXMp7thh1+fMPHNsTkSfvh+8jIAIYvDZFNORcpQJSjJbKjq71mNqdORSGoJF+M3UtLU7UtXJ9Z6/lcEJ0xkuPr24/mwTX5BAQSln3oUP62McVZtgybznt9Mr9lFUnj6l7vI7N7sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(83380400001)(6506007)(6666004)(6512007)(6486002)(478600001)(86362001)(38100700002)(921005)(316002)(7416002)(41300700001)(2906002)(2616005)(26005)(36756003)(44832011)(66946007)(66556008)(66476007)(5660300002)(110136005)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W1jZejdf+SYiUNEuB+bJqbWs5GfANB+jxjwTvODzuV2Dgi9wG0vWTua1c6r/?=
 =?us-ascii?Q?vnBxc+HqNJSLsuQWonG5YhPkpg8IOLw0MG6cXNSwWEJwF4eWhdSrvnT5hA/A?=
 =?us-ascii?Q?w1pspGUlM0vQq4e0AJTAk+GNH9oOIJMDMo7LMH7t7KO+nl7uK5j7Y0i2ihWg?=
 =?us-ascii?Q?UY6M30fCRurXufRd021kPEO/87FZExwzHmuhqdAkcOQmiP0cxWKgV977RBTR?=
 =?us-ascii?Q?BmMr2/A9I8nF4TJxd4s8RlDlLQ+PW+1MLx3PXnoLrwxuIF24UjAo4zxH/B7C?=
 =?us-ascii?Q?E6thKUy9aviQeCp9pO91CQyjAGXi6fcaWS7W5TB1QRKXr8FL/rTFTZ33Sppb?=
 =?us-ascii?Q?XV2XsYZhikMdJ9cKToH2GUV8uRURsEcBga/HDLMf/aeEj3lOZVdO9SHD5uQH?=
 =?us-ascii?Q?cZu0ldiOia2lNXOKhEMhkDERul53qKhCEzBycP/UPH25kprZNVBSrbydUowr?=
 =?us-ascii?Q?3Z0rJnRsfcrNTbmaBOB5T/9DP23OKd7b/M+Vyrtnm041tZ/dM4z7bDnb2/pY?=
 =?us-ascii?Q?eJrnDo8AvY/q4Vk0gngcgVZhHq+6aLOA5blpi3AZGKyCNPaFRyd7LA9GgdGM?=
 =?us-ascii?Q?QLvCAy0Rx5fRcWsn1K53xl62nxgcpcbfAxQO4BKpV5lJD/VonkK8pHVnI3UF?=
 =?us-ascii?Q?jOAZLkmhKieXbpIGcViwAZWlfc/wtIXQmEuvDCDaAMELD0wWBK6TQGKVxHgi?=
 =?us-ascii?Q?oMaJLn0K+bJAa4IBdy1CiagX4WnqXRv2CqiSZpGH73fcS9SR3BGvczLCG1aC?=
 =?us-ascii?Q?+5ONSJKIba0rIlBYLbNjGFl3uH6STdx9pTZV8op0RKjAuVWVQ78pB7qtYnf7?=
 =?us-ascii?Q?uDAotHQYPTbJbJQS5WQWzHW0ZMso4AZGV2WL8IcynCGUSpIKmPOKfmbMAM4B?=
 =?us-ascii?Q?9DwZe3sj2avnRl+nU3nzRU6bNC8cTmNXtpOHSbEq24JRlRbC2tA3s5ZGGgrw?=
 =?us-ascii?Q?rnWfLDNkW7xpB86EnTIwQO0MV4MwrYa8HbDPD2wXBB9cirDA1WEuyd0iZlYF?=
 =?us-ascii?Q?y8YWiFgjmywLPoJ/k4CAewh2VEpwzgfuB+yprh0m8bQy7NCl2q4GutPv6kny?=
 =?us-ascii?Q?l9dgNNl64m9lLdS5uwQ9ep2zILWXDfF4rRF5vah+WzKa7SVFU/KSGUSYa7WY?=
 =?us-ascii?Q?OOc6rIS6082swHW9MQjTsLrOZszplBrdt0n2LikzKDoJl3qiz1bs0rPO7ep+?=
 =?us-ascii?Q?wQIqNGqdaOhv/kKo0hYkSGPJK1nvKfXKTy9AXQ3Msp9dk9PHtYbYQznxrg2W?=
 =?us-ascii?Q?zs7vItlsZqjV/7zbXJ2ZgcXY4WQqaftDVKXQ/9r3R/iREaaadtM2IQiPaZND?=
 =?us-ascii?Q?k90Y0Bo7qgn343hAD6r94qgEoQOpR/NQ0EDR/wcFDTZ977neAZKwC3QkiSrj?=
 =?us-ascii?Q?c1bJwmaIVpBjYgv8odVj48sp4brvP2onkplwQgZsIQVZgrJ9bhyaJVdw2zEm?=
 =?us-ascii?Q?ZFYrXSE0nw5OTxA9qlsnTQ3Zvs4zEpTCJiTlxnPtJ5eIJQr6WjTqeVX/zvZi?=
 =?us-ascii?Q?eWWaoVxhGR0tXRAw8XqerNWZTHii0iw6mGl7qcbeeDIjStOMHGJPN9msF1ps?=
 =?us-ascii?Q?DPigfuTYVX1usQENsu4l19rfjGJ5hCq25NqIYbxo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4efa0ad-06bc-4f9e-0d78-08dbc65756fd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:31:03.0248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0M3utixOAMVkVtbANCGD2l+9nyzEQrY77Evsn/gd8gK5ulayXt8CAZjzDL22kordEgUOXvQPLZx1tj+Ewlk/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9703
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

to generate a new helper pairs_redir_to_connected(). Create the
different socketpairs in these four functions, then pass the
socketpairs info to the new common helper to do the connections.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v3:
 - move xclose() out of pairs_redir_to_connected.

 v2:
 - rename c0/c1 to cli0/cli1, p0/p1 to peer0/perr1 as Daniel suggested.
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 146 ++++--------------
 1 file changed, 31 insertions(+), 115 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 8df8cbb447f1..259caffda97a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1336,53 +1336,59 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
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
-		goto close;
+		return;
 
-	n = write(c1, "a", 1);
+	n = write(cli1, "a", 1);
 	if (n < 0)
 		FAIL_ERRNO("%s: write", log_prefix);
 	if (n == 0)
 		FAIL("%s: incomplete write", log_prefix);
 	if (n < 1)
-		goto close;
+		return;
 
 	key = SK_PASS;
 	err = xbpf_map_lookup_elem(verd_mapfd, &key, &pass);
 	if (err)
-		goto close;
+		return;
 	if (pass != 1)
 		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
 
-	n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0, IO_TIMEOUT_SEC);
+	n = recv_timeout(mode == REDIR_INGRESS ? peer0 : cli0, &b, 1, 0, IO_TIMEOUT_SEC);
 	if (n < 0)
 		FAIL_ERRNO("%s: recv_timeout", log_prefix);
 	if (n == 0)
 		FAIL("%s: incomplete recv", log_prefix);
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
+		goto close0;
+	c1 = sfd[0], p1 = sfd[1];
+
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
 
-close:
 	xclose(c1);
 	xclose(p1);
 close0:
@@ -1661,14 +1667,8 @@ static int inet_socketpair(int family, int type, int *s, int *c)
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
@@ -1677,32 +1677,8 @@ static void udp_redir_to_connected(int family, int sock_mapfd, int verd_mapfd,
 	if (err)
 		goto close_cli0;
 
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
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
 
-	n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0, IO_TIMEOUT_SEC);
-	if (n < 0)
-		FAIL_ERRNO("%s: recv_timeout", log_prefix);
-	if (n == 0)
-		FAIL("%s: incomplete recv", log_prefix);
-
-close_cli1:
 	xclose(c1);
 	xclose(p1);
 close_cli0:
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
@@ -1765,32 +1735,8 @@ static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
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
-
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
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
 
-close_cli1:
 	xclose(c1);
 	xclose(p1);
 close:
@@ -1827,15 +1773,9 @@ static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
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
@@ -1845,32 +1785,8 @@ static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
 		goto close_cli0;
 	c1 = sfd[0], p1 = sfd[1];
 
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
-		goto close;
-
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
 
-close:
 	xclose(c1);
 	xclose(p1);
 close_cli0:
-- 
2.35.3

