Return-Path: <linux-kselftest+bounces-266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB767F020A
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Nov 2023 19:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2355E280E76
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Nov 2023 18:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F47A17DB;
	Sat, 18 Nov 2023 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Zh5ZnvND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2068.outbound.protection.outlook.com [40.92.74.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CB4F2;
	Sat, 18 Nov 2023 10:43:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jI/jcdACzTjkQtltq661NmWCu8MNaitrDEeO0Asa1cO5y1wrl7BIY6nz2hOJkc1g00xJNRQRBWJtu4yyBWUy6hYho4ryjsXnOb7NVb4XWXTG7qNpeDtuH+ctOYKAUcxen/LSF5sz0Ll+679YOsllHkzSHvzT520d0X4B9+xNRd439Fcat2Ill2fhFZsfWjNWpRT472xsH+PKi7RNx4dkKwybO/MFhmGf1/1VLGY+dCtZFlWUUwINLWn+/dU1D8Plhh9bR8KX9cTHXnKcyODdaAcfKtkAolkd6BGy5YTnnfllXEruScYw78qQ4SjVo0HdU1COVKGMT0j13xiom+pk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tu9nlo/CAK/qj9SXaN5q97RBCgbUgYNs+wCjj5orNOs=;
 b=g3nrVV7jaw4Y372BAFe+5vlKqkv+da7w2CiKX7M7U4v0W6hekLKuDl9UyhzibiMAompf2AsGzK+KRX7IwwnLQfXuzHySbbcWj5ANm2JPAi36Ig20E24vlAlONDnkzJwNSrFzak7izRRaNH7hn/cBDapFPjYgmbJPOb7+sDNfKaX2NHjcFgGhJRopUJZYkArLrrO9CciCkeF8gQ7ZzZnx6y3q+tGnRoSHlG4lCj1M6kOD8ybut8kly+Bxa6XY8I6BUDwYi5tCdKRoQWeQzLOEkyzgEdUR0UWCak/LdfoCK3pV6PwUsvaJA8bIUrp5SH8y3l/fXJEa33RD8zc46Htkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu9nlo/CAK/qj9SXaN5q97RBCgbUgYNs+wCjj5orNOs=;
 b=Zh5ZnvND8DkNsUWsRmx9S//nShuO+mIhd5VjWRYn/hKDhM50r8x6MInR2X7Gfu9pQ74SIFfztUWy95T3Fd0zK/zPs2Ce+Tt+khFRurB6b1dR9o9YvvxVtgCVUXR4Rx99uTmvAC1xNRQnGnJ4rs8cH6ITqwFz8rHSYLOFeTkIEH06Zl84ZBRHrqCSN4bqZYcGdm8c+oSo4BANHPRoYFd9JfoorCGJ92cvHcu6z/Qqj5wg7dg6FtKDopythucF49nlregXXfRj7KL/+WlkKcOz/LAI0o03tE5O2X0ZX2LuMEZwuC3TprBg945xRbAdIYgIFfow35hkElI1VHgFjMl57g==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AM0PR10MB3713.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 18:43:19 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.025; Sat, 18 Nov 2023
 18:43:19 +0000
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: bpf@vger.kernel.org
Cc: Yuran Pereira <yuran.pereira@hotmail.com>,
	andrii@kernel.org,
	andrii.nakryiko@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca
Date: Sun, 19 Nov 2023 00:12:54 +0530
Message-ID:
 <GV1PR10MB6563A7938B9B403861CA88F3E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [vHV8bWmR9XMpg0MEYeI00aZAKc8gQx8a]
X-ClientProxiedBy: JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231118184254.231352-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AM0PR10MB3713:EE_
X-MS-Office365-Filtering-Correlation-Id: e4bff77f-cca0-443c-7c61-08dbe8663bb5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ndlgn65m29HHe9ahiKKBLsm1fLWpFgqTCfqg5MSQdI5FjlFiFfkXnf+Yu0IweVoPdeX2c/7/iGTNrUTyB7vKpYrfvMtxZdZzfhCT+qlT9eRgI9ko5FOFoY7CcBLiJLqDRrQ29J4FSNQe4kLZYKxb6cufb+t/+KeBKoGT9qDYixXlNHSrS83N1U7FAjgNSUiLMCqW1Lckl7kIlozYpgIgN5PkjxD3vCvXUGjgSn15XyYyYIaeeelclMV3qc10ZJk3rlVNC3I1CeCcPiQqlTqQPb09jLqYW9wDmqiIkjfdIacRap58qiZP+gVwBjhF8SolRnKZCmxZqHOv/X+jjyJYlmKAqwicxC9ZOH7WnxSLphwr2tNTXjeyeOeEaj0JZVPvS3Uf3Nt1C7HH/q11E/eGdCQDVeUa3UR9uJOY6lZP8YPz+R1A39STEWZqoeKl3jxwwEWWHykc8P1RukInguDTVFyh2J0Xo/QmkpNvk+90z8aSb4rgFpsLbMINiz1DfMZgHZh2NqZ37MP7sChx+hpJ2fkY8pmD8PZkRJ71I0+k7D8EZd77IXDPnNnM7IKIb9B9ZZiIihnXAKhyd2myv5bvT+psHAAbGy4Q/2xsL3TQ++w=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ec0eJkj4wFfuN+0Q6SEVbkVj7TY4fRmki+IKoXNvrvMVNDLoSG3BtjOekaXu?=
 =?us-ascii?Q?EY1wFq3Fj53nDA8yOKPC3Ai2gUY3Rcdvzut1fWM13q7bxUueQQkzCYi9VkEw?=
 =?us-ascii?Q?9fAT5eEpWzkQEtxe8R5muUcA+QLGZgUonX9831p4eBV0YZ25wj0zOWEBvStu?=
 =?us-ascii?Q?uO+1ICIIiwq1rrcO7YCvMNEe9gZ11IXgmCvl6F/uMJ3EqrCFvd7NEc6Te6uw?=
 =?us-ascii?Q?4mlrqRcfminSGiB/9MCav4e9MAzWnQvjnBhOyeP/CoYU5CCqOIb6b+9fxjwV?=
 =?us-ascii?Q?U4/GlSgNoYR+IHmhg5qyfqpEPjJjq5m1RQyc6ZJKe8Ig4Jvoga5UrxfTUYZO?=
 =?us-ascii?Q?deObZiIWUERLXfH3lahsM8obFKQks1hka4Lox0WYnMcPnE7rDw1QqTJy009X?=
 =?us-ascii?Q?sH8EFmy24eyoHhNBjlQr0aCym74MXfQL1/9JhpzT9jbeuD73kZCBcC3xZFPH?=
 =?us-ascii?Q?dOCwvb6e6gfVnh/UmkWSZT7guVdFxECWcAlrSvnUIl+ze9seqGBusg/R3thI?=
 =?us-ascii?Q?j20qdflheFvpXA6taxtCTOJUMxbNGfqEVGnoM2e9+1wrZqueiKHgYLQX5qeX?=
 =?us-ascii?Q?llbhxrGDPH+8VgswjQFS6C6zKxksS2qfPKTPD9dmIz/+jx6pw3CVIMYORcv8?=
 =?us-ascii?Q?ydu6qsn5P6H43leJPb9b49zJfGlP2APMOVqGAtsPYpX/l3qonGQt4DRX1obX?=
 =?us-ascii?Q?hfrYS1oklHmQFASFHSHCQJxOdkP6aNiUAA4WagY+VF/cRiE+7tP3i9WsWfhd?=
 =?us-ascii?Q?oMxFol/OVbyC0EwoIMongHM7rLFHO3UZ3M55qUbUQZNWdCjvc1FbYk4YwaAn?=
 =?us-ascii?Q?E8Zy4llbOwYO+Hs8wp/zNHDUZRtrAOALUca/Ex/SNC3rDBs+ZJc/8kWDQJkK?=
 =?us-ascii?Q?R3G+9tuNG1IkGq5HxPyFJbxeEFuKlzVEsIlKjgEGPfG9ta8c8+mOEfWr3kcX?=
 =?us-ascii?Q?R5G3mxCfgmsBD1GAE6FeWhzQcL0PGFf0tnvDlGtOmrqvxkadvbb49W/RaAXv?=
 =?us-ascii?Q?HR3oLPlvK26BNxCM6kMhBWZXMxka7FYjbERki0GH2VylmaXfRuuLzz0Rp+St?=
 =?us-ascii?Q?FssE/mLSWslu6ZCQY2HOEqYCCiQmDRMtBYwy4mj5kXObpj9AxsLGFwtiB7je?=
 =?us-ascii?Q?YzOQFWkEE5OlMRFjR5Ti5kP0CsiyulwcXIa57wW3rVndNMW1vh5k2opzenGb?=
 =?us-ascii?Q?QBotKTPx9ebZ6ytRK5eglRXlL0iPyoABhAOcI+zXM8iAuLu3ZkPeojj8noQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bff77f-cca0-443c-7c61-08dbe8663bb5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 18:43:19.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3713

bpf_tcp_ca uses the `CHECK` calls even though the use of
ASSERT_ series of macros is preferred in the bpf selftests.

This patch replaces all `CHECK` calls for equivalent `ASSERT_`
macro calls.

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 50 +++++++++----------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 4aabeaa525d4..6d610b66ec38 100644
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
+		if (!ASSERT_NEQ(err, 0, "bpf_map_lookup_elem(sk_stg_map)") ||
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
-	pthread_join(srv_thread, &thread_ret);
-	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
-	      PTR_ERR(thread_ret));
+	err = pthread_join(srv_thread, &thread_ret);
+	ASSERT_OK(err, "pthread_join");
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


