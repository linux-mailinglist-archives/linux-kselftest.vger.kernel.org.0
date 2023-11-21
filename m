Return-Path: <linux-kselftest+bounces-350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 680287F21F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 01:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03EDD1F22B3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 00:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152F8387;
	Tue, 21 Nov 2023 00:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="qxupbq0B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2024.outbound.protection.outlook.com [40.92.65.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643CE95;
	Mon, 20 Nov 2023 16:06:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzgozHlAs3dTrqHoiVKCE/aoQANlwC9CLIjsxpajxyiSZ3q2ZMJ9NcQeeIzo+YKGIqDTQOKyJmyBMmsPDAQVujysE6kZT0fWvPOMwzD4ORZKL2sAJE+MWB4nlLDfgnvhERCAN1rhQsXOCDMkC6A0/TXlN7aS9PysP/HvJ7yJw8wZrM8oFZ0T0othh2vmG0LOE/MxhiISLjx243Vasr5pEAajuwknv8kSaqhDGjUO047Di/sVNqikjj6Hx/yqru5PsaHFbX6COzonlEn/fvrEFxdC0v2GEA3w985kgdTdsEj+ChZJaWVgND35yncGFxJo3by18bDWnOaC4jjkiQmglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaWv7+gGNvT8/2OemPY/yw072DI8us4yFD0NbweDiDE=;
 b=Gyz+jIrKDYVwfocx9++870gn3eqk6mRlbCa+VW+JQW+El8cNpTUiPaxnLEWox2kMH0FNfFiEwSgs9b38i3/isvYtQSf8qa6Si9F6gXwduFsgniVVZvXlPWx5jZbwHXhdbiYh137Vpl5dhPCD9fc7ghVZJcrQM6sbfFpqAZJdWXZ+pw/HqHdmujl1BP14znD63DZBF/c41fB6G2OWXF3cjvvezDg5zhUryMkYa0naLraL4eNuP/q6PbNI4nhCqTUYDNLVTJzbJpoNfQGahYjOb94VWXkTX9Br2WliarWWb6krA5qcfgXQchAs9etcd7uxpiDtQk1nWli534FH7HKKVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaWv7+gGNvT8/2OemPY/yw072DI8us4yFD0NbweDiDE=;
 b=qxupbq0BXyVpmu6RgF/IVq6pJNO4a4ZVKwbD+yP2l36R+RRPqfiXcsghcgZO3yws9/zGP79QOI6uvynsIIDjkWS8QutUZYoDx9DjxWVTnqj7oNK6qq1dWp+wbFmlmG15ndAkRWuCSwKQu4JTryS8wGNgDm9TIf5c4JycyGW9eqMcUwUXKH1VDdqrQ1XBomttS/uyB12zSYWpnpsFwBQ14wCdFC+Yt3Qf6ZCQ1yEkO6tX0s8mv77tzbKrd6aCJ/x6IZ29nPqD7YOLhGk45RGdu+hG8vJxwGiDmx7s/F+jwQfOn/yPV/E2i8k0mJKIZuIMw/0S6WLBqGbd573+k03aCQ==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS2PR10MB7477.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:593::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 00:06:16 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 00:06:16 +0000
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: bpf@vger.kernel.org
Cc: Yuran Pereira <yuran.pereira@hotmail.com>,
	andrii@kernel.org,
	ast@kernel.org,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mykolal@fb.com,
	sdf@google.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next v3 1/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca
Date: Tue, 21 Nov 2023 05:35:39 +0530
Message-ID:
 <GV1PR10MB6563F180C0F2BB4F6CFA5130E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [fHMVdpxwz9OQbya4iq+gaB9tclLMjrvM]
X-ClientProxiedBy: JNXP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::24)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231121000539.421270-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS2PR10MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d6a93e-04b8-4a47-968e-08dbea25adda
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2bPTRemX/EeOyugDR2WqaarU5qbuNPJBg2q82L5fx713soOye1VZOVgVGDp7H3Ay3Zk7AaJVmSzayMbI6zBg0AaINBG0GHtpYZogyAP1HcM1VjNO8lU0rpD3Wt5HmIAh8VeBLMjW2Rxs9vzwwAdStkGnXB5EpidnhZAHsgdemvoT2BhEGU9d0QxB6476yAFUOi2/btE4eGC3OCaTgDDJTcEhQkc8cmFlxVL3vmlCxeG++luCi7eIaS3EpILvam664ceRpxdR4P3xng/V5HID/meHIJchrqeA4h771j75FRRhL5EHup2hziIDa2lHh+iWcZHoqZIt0NMnXBHzzd6SE11cIjKKNeY7o07Lupqer6w2GpIawJDsdeCDK4XWH6SYh+T7Pn2anJ89UbAhadsd/3WUoexvLTx++sKoLutY1Ai15TX50ebKEt04fHsCH3nGrkD5vIivb0XUHq5cuc4upb/PI5y2wsp46tCZmiBy8gVuPig1otLcrUAPbJucWempPkSaQjA36x7fkG/7Zma42W8wrdNCk1sEw8xG3Lrqxa7pbzmVbka0RMjnxFJwzshGS1nSxSCfQhu0oKQ6S9KuEhgLzfks0LNmJPINkhPvAhU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0U+WjHph7B6OUQ8HENfwGYaqHVnoNTlaXpJdR6CCTxvA+OtlvGvyGubdaKrc?=
 =?us-ascii?Q?UvogW+P1mXJIhc7R7Lpf7HI8+Y496PbXlAUBSPbgCP82n1J9QuCXBXzhnA31?=
 =?us-ascii?Q?gmbg0DC4XqX/2raKjEGhLwUqwPOrMkC1ljs9kQMQZof/CSGuIU2LMLVWzJJg?=
 =?us-ascii?Q?4XX+O6briG/6qbkg6VW1HgvdtKporJiIwsXUTq3+rYzAWEHirFO+zmkl5x0r?=
 =?us-ascii?Q?HZJaJ19stU0vt6Z2M2LyrDuoMLQzXl5hh/76mOaXQDanjWrOqN4HOoHTvpyk?=
 =?us-ascii?Q?QL/s9PiFqVp7EmbNsBcqSUjZhSj21+bTVcj4FUTq4WW3YDHJPloT0tzy6KcG?=
 =?us-ascii?Q?yMN+jLC16Yl1bkS5u9gPT9p31fAhWoiWDr53qAaSutArpxwK66t9sj6CyAJi?=
 =?us-ascii?Q?8ULJAbvHr5cEJkbSMfRCzkqjh/5Omwh+WvIcwPuxakfzlencSCpGFkx8fCQv?=
 =?us-ascii?Q?qJoOFwrcZxQLmq7Xiqav2/7G3UJY5dYXOJhZteAKodyqmzf6p4QeLeizk3qM?=
 =?us-ascii?Q?KiPSWcMrYpeOMiGtnRJONfKIyQad0lQjWidt8RKk4SaoQbCeacAfKRPzd2L4?=
 =?us-ascii?Q?95J/vjIj9GmOKYtiXV/pwDNsBi9Hl6cIQymt1pZj1OOsgpMwu7yoRDEFfw0c?=
 =?us-ascii?Q?95WRFMh9aTmr2coUYZ5BLq+opRfRTOVIjaZA+WCJhgkJUDfkUoD8rdD5+CUc?=
 =?us-ascii?Q?MOiGU6b0qL0kRoGz52opcnSKZjTDd9x40Q5Ih8za/XsCW7wpxzUWc6b7i1Jr?=
 =?us-ascii?Q?2G5j5I8W5YoDiW4QMQ7JhuOTiXxe6YpLDzJVpANa5VK8Ey269akcEz1ptyBo?=
 =?us-ascii?Q?6NeLlb6dZvq5cjigKaA5QefV/x5RnY0Xj533s7BRugFLpILTIzMNxJHkD7qt?=
 =?us-ascii?Q?T5m9iovTYSig/wHsnLD5IbBPB/udt840By2MWlQL2Q2p5V+XwUWWnqzC1mqG?=
 =?us-ascii?Q?bAMVUUwpt+aMN2IBk8dRj2Dzh1W4A68uHKkLIavl6dWXBty2QdLFR48oPjxd?=
 =?us-ascii?Q?7nAkZdK6w3Ql3oxl8DoC4WSfDzuzDP0RKfOvdYnwCsgBcH7EI1ll/whOxABA?=
 =?us-ascii?Q?UCc5iNX+cawz4zpJg9NVEd+CSb2yWEH7qx6tjqrfLtOzezYyNMu9GhcBxqbd?=
 =?us-ascii?Q?wigrPmtTCKWes/9gV/C2pYSiJWI7iRLPmhnZFQzPH6vcMzb3HX3ck6gBWxww?=
 =?us-ascii?Q?4dyT5hYCl9a2Da6W+OZ1mDbTSIoutmmWYmfrv1/P0ETsspsKDXT8pKMLEIg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d6a93e-04b8-4a47-968e-08dbea25adda
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 00:06:16.0149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7477

bpf_tcp_ca uses the `CHECK` calls even though the use of
ASSERT_ series of macros is preferred in the bpf selftests.

This patch replaces all `CHECK` calls for equivalent `ASSERT_`
macro calls.

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 48 +++++++++----------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 4aabeaa525d4..a88e6e07e4f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -20,15 +20,14 @@
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int expected_stg = 0xeB9F;
-static int stop, duration;
+static int stop;
 
 static int settcpca(int fd, const char *tcp_ca)
 {
 	int err;
 
 	err = setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, tcp_ca, strlen(tcp_ca));
-	if (CHECK(err == -1, "setsockopt(fd, TCP_CONGESTION)", "errno:%d\n",
-		  errno))
+	if (!ASSERT_NEQ(err, -1, "setsockopt"))
 		return -1;
 
 	return 0;
@@ -65,8 +64,7 @@ static void *server(void *arg)
 		bytes += nr_sent;
 	}
 
-	CHECK(bytes != total_bytes, "send", "%zd != %u nr_sent:%zd errno:%d\n",
-	      bytes, total_bytes, nr_sent, errno);
+	ASSERT_EQ(bytes, total_bytes, "send");
 
 done:
 	if (fd >= 0)
@@ -92,10 +90,11 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	WRITE_ONCE(stop, 0);
 
 	lfd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (CHECK(lfd == -1, "socket", "errno:%d\n", errno))
+	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
+
 	fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (CHECK(fd == -1, "socket", "errno:%d\n", errno)) {
+	if (!ASSERT_NEQ(fd, -1, "socket")) {
 		close(lfd);
 		return;
 	}
@@ -108,26 +107,27 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	sa6.sin6_family = AF_INET6;
 	sa6.sin6_addr = in6addr_loopback;
 	err = bind(lfd, (struct sockaddr *)&sa6, addrlen);
-	if (CHECK(err == -1, "bind", "errno:%d\n", errno))
+	if (!ASSERT_NEQ(err, -1, "bind"))
 		goto done;
+
 	err = getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
-	if (CHECK(err == -1, "getsockname", "errno:%d\n", errno))
+	if (!ASSERT_NEQ(err, -1, "getsockname"))
 		goto done;
+
 	err = listen(lfd, 1);
-	if (CHECK(err == -1, "listen", "errno:%d\n", errno))
+	if (!ASSERT_NEQ(err, -1, "listen"))
 		goto done;
 
 	if (sk_stg_map) {
 		err = bpf_map_update_elem(bpf_map__fd(sk_stg_map), &fd,
 					  &expected_stg, BPF_NOEXIST);
-		if (CHECK(err, "bpf_map_update_elem(sk_stg_map)",
-			  "err:%d errno:%d\n", err, errno))
+		if (!ASSERT_OK(err, "bpf_map_update_elem(sk_stg_map)"))
 			goto done;
 	}
 
 	/* connect to server */
 	err = connect(fd, (struct sockaddr *)&sa6, addrlen);
-	if (CHECK(err == -1, "connect", "errno:%d\n", errno))
+	if (!ASSERT_NEQ(err, -1, "connect"))
 		goto done;
 
 	if (sk_stg_map) {
@@ -135,14 +135,13 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 
 		err = bpf_map_lookup_elem(bpf_map__fd(sk_stg_map), &fd,
 					  &tmp_stg);
-		if (CHECK(!err || errno != ENOENT,
-			  "bpf_map_lookup_elem(sk_stg_map)",
-			  "err:%d errno:%d\n", err, errno))
+		if (!ASSERT_ERR(err, "bpf_map_lookup_elem(sk_stg_map)") ||
+				!ASSERT_EQ(errno, ENOENT, "bpf_map_lookup_elem(sk_stg_map)"))
 			goto done;
 	}
 
 	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
-	if (CHECK(err != 0, "pthread_create", "err:%d errno:%d\n", err, errno))
+	if (!ASSERT_OK(err, "pthread_create"))
 		goto done;
 
 	/* recv total_bytes */
@@ -156,13 +155,12 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 		bytes += nr_recv;
 	}
 
-	CHECK(bytes != total_bytes, "recv", "%zd != %u nr_recv:%zd errno:%d\n",
-	      bytes, total_bytes, nr_recv, errno);
+	ASSERT_EQ(bytes, total_bytes, "recv");
 
 	WRITE_ONCE(stop, 1);
 	pthread_join(srv_thread, &thread_ret);
-	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
-	      PTR_ERR(thread_ret));
+	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
+
 done:
 	close(lfd);
 	close(fd);
@@ -174,7 +172,7 @@ static void test_cubic(void)
 	struct bpf_link *link;
 
 	cubic_skel = bpf_cubic__open_and_load();
-	if (CHECK(!cubic_skel, "bpf_cubic__open_and_load", "failed\n"))
+	if (!ASSERT_OK_PTR(cubic_skel, "bpf_cubic__open_and_load"))
 		return;
 
 	link = bpf_map__attach_struct_ops(cubic_skel->maps.cubic);
@@ -197,7 +195,7 @@ static void test_dctcp(void)
 	struct bpf_link *link;
 
 	dctcp_skel = bpf_dctcp__open_and_load();
-	if (CHECK(!dctcp_skel, "bpf_dctcp__open_and_load", "failed\n"))
+	if (!ASSERT_OK_PTR(dctcp_skel, "bpf_dctcp__open_and_load"))
 		return;
 
 	link = bpf_map__attach_struct_ops(dctcp_skel->maps.dctcp);
@@ -207,9 +205,7 @@ static void test_dctcp(void)
 	}
 
 	do_test("bpf_dctcp", dctcp_skel->maps.sk_stg_map);
-	CHECK(dctcp_skel->bss->stg_result != expected_stg,
-	      "Unexpected stg_result", "stg_result (%x) != expected_stg (%x)\n",
-	      dctcp_skel->bss->stg_result, expected_stg);
+	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
 	bpf_link__destroy(link);
 	bpf_dctcp__destroy(dctcp_skel);
-- 
2.25.1


