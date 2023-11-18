Return-Path: <linux-kselftest+bounces-268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3557F0212
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Nov 2023 19:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5E21C20492
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Nov 2023 18:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D324210A3B;
	Sat, 18 Nov 2023 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="KvS8EVlG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2010.outbound.protection.outlook.com [40.92.91.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1F6E5;
	Sat, 18 Nov 2023 10:46:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwXnPKYgkt7WNpVtBwHCvWJDgPClBnVS9cY7TYEE6LEihIlKRVqjoKefHCI7qg/xP6jqNGA2alZoPPZHaSXAJc1sy1Hs6IclqYuG7lvgXWMqz8eBs2FkrAsxrJ47v5QQct3PeQ9TCvbZTbwoF9QICx7gaz5elWqznGxgPIUUhStdT5PUriQllsOcjM6p/kgIeTVgKOrhuk/jJaOOz8ndx6VgCCyG832jqeQgQN05pqhdMs1XNSdbYjP6aNFT+r1RU9gsIQ9z5rWM3GEi0DpebOBEXTShnU4D3C4CTLEcnfIbV8nGygVdLxOE5GORKwfUKJR8aGZkqwZ8DqRZ8rmjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piQaToojm3qbR2rRzMqggkfCTjcB4RS+/8/vAQe8Fwo=;
 b=O/jMsZZ+YxOPEVKGj3jAm8lC3ksuXG2cfhdy7qy3i/NQloeiaDfmPIfmAIu9ju7mQctNRFU0/o2fR+zpeSGtqXKLFd1g+I1gB+gZpZmykTx28l8eJlUFnWgZTmvoLNdOJbwBksgT6yG49CQ1vX854RQYAOcDg2FhHL/hiHJlqUe8Hvi3kZ1crfSPndLj4ZkQSomzwEhHzQDjwN2SEozGLHMgK0HND2vOuLp/sywXXNsXKKCxjMP0qWcUp9Kp0wKoJBq3XqAyrfMIUGRpUXRMxhtUCjHa6tmWD+NEfFcXgjbK79ptDhgCn7RQLZItXB39WzY7EwiGFcwsPDrLMuEMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piQaToojm3qbR2rRzMqggkfCTjcB4RS+/8/vAQe8Fwo=;
 b=KvS8EVlGKk4GgxJlk+Jlfx5dT4Lk5K3CXN3NlHSoo/KIB+kXxIVP/gLg93twAhDGH8ML/7cJeELCxjtaqhwVdeYtdzdYtgdvcy5UlGubllpZiIVor2oRmqk3oVn1pnwBjGjoXi4Dtaz13K2Ee7cATpaiSd+KGS75yTOOweOnkzn18jo1lY1p/TOAFvOuy8fXqqYcxchwr846XttbIbj0Kbahlye+r4861NOSMjJyw6dYDLr7H4UuEQ9Vu0Z1wtqehHsvKFYO0O5aH3M2DyKRHdf7GJIik3LpuFZ+o/nXIoAv99OuM4hM5hMpo8dK5WU/2v0Om0D48GNXHZ7QTdUYkg==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS1PR10MB7936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 18:46:13 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.025; Sat, 18 Nov 2023
 18:46:13 +0000
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
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bpf_obj_id
Date: Sun, 19 Nov 2023 00:15:49 +0530
Message-ID:
 <GV1PR10MB65637AF2A72DAC44AA5642F6E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [SEXYXbvlyvvCt0iU8Bq7JhmHSergPit2]
X-ClientProxiedBy: JNAP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::13)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231118184549.231582-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS1PR10MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c671b29-9d99-4b27-2c24-08dbe866a360
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cyn4TngyQe8IomysJhafr6JYfpibBjh59YRz7JyC22HUtxF2Kvr5xU6sDCtD7joqy1qOMcN1B0YxUvczNKD8IUKZpxm5FqZN8E00gWRL0m+M6Yp/bz0Xmkh2lHonxxJdvw5AXGSkCk14VnEwbrs1Z6ipx8otvNrZCRFNdIDlpP7kkdxHZ370h3WA2qzlRUJvA9KMpbhlE53lljym8Gh6bn+6V2lPa6xPPhHjEFFwBToNXJLwWBb+HoUYJcN+jUVlmxH8KF3N5/5ZQfQ+sJO3+rp/dJuO/RFWr+BnU05rr+JWW5lfLYqtP6AjOrhNkyZh1uM/36vzd9xinWJoSy3lwX2pzQ4gS0tL70IdpPWwn8GhXz/JQFP0R77b+6EomugwdsxX/qTa/Kk2Y/j/QVW6EtlznIbHfVEaOMKNIm9BtCMZq9bEGCoR8dGSLgv33yOQTqPDEkBej2cYHFEcRMMdAoi6S2NtUACFfkbF96NTzBmOzOXxuRgIYlLGkMzpVzpik+pExjzEst9wPF98/Re74S1RGrPAy++jYwW+kxjl36+9x8uaeLl1KEALkRyxiFv52dTbkT7OaHtGJ8tb5hbhzJGzxA4SShgsly3NyyYgkp+MXbiTMVwM6/+4onArV+Rq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4h53PhiFTlaPhE23tfqg/ud1NglSkljCCiEv+BYTtuROY/QJyzJig2dCka3T?=
 =?us-ascii?Q?aliTEd8j6fAl+muCpyLy3IZE8AxnvSs26M/jkdZvTmA4QhwiaebbOfDk78bZ?=
 =?us-ascii?Q?xAv5/8rBe45dTrPxxftjoBWkP3HtpjhXCeNfq7uRP/+74Rje8J4yl+YZImyT?=
 =?us-ascii?Q?4v7jqp00X1m3840qOe1WPcyBLhpsVs3zkDwYVZy2UF/umA8VJfZrM+6IzAal?=
 =?us-ascii?Q?yV93/Em/vY6pkBamTRyQtExD60OjgD8Am05FxCEnnUe5h+oXBDQlh2YlKI1n?=
 =?us-ascii?Q?kvWvEVLy3Pj4AJ9t2her3jZePUQRcrjGXd2j2guAQFEigtFEFzKvoVbAaNNN?=
 =?us-ascii?Q?XcxsOMp83udte75Oq7y77MYNNURqJ4oKqmmIHzqv/0d/n09iTXekg+yQfd/z?=
 =?us-ascii?Q?aTmJEHZcsiKbXFBuP3mp5wReTkI3FhHJ2ou6rR0TdHbkD10/cFQxKH+ZDu6a?=
 =?us-ascii?Q?gWp/do/0TEE9QpEv0qgLYRDdk4i/UK9tZhS+B+l4SFD50NhZbBUeHpTLTVql?=
 =?us-ascii?Q?WRr6lA6kwjiQ4gbhbArtgC0I4ilX9LvlH0ckCWQsUjq6zkJ3J+y3HiptduYx?=
 =?us-ascii?Q?nbLflzD+hK1GoBh1wLnVwq+t0PYSEccDmGbGuOekrupjvxpx8c2LJQF9lu19?=
 =?us-ascii?Q?1cGIIVBlfgktyTv5j6Tutje3EyWs08j5ZoOp8RT1IuLIutEQhbrn4oSiZtH9?=
 =?us-ascii?Q?RgzF5b/BWDqqRrNV83SiMe0LPMtTd6WEfazNRwcbhxlP8rLfmSxkxSfeIdaj?=
 =?us-ascii?Q?7Lty/aUePWtyxV/MKXAsny+mf9dGnoMtSNjF/+EiwSBZ/LOx+0Yw53a/QrGJ?=
 =?us-ascii?Q?VLjc1TaNKdi84bOgpZ9ODFl9zhAIl4arZCnJht/SI2yiS2x7cBQ1Qvw37z8p?=
 =?us-ascii?Q?eYLyBN11kdFkz/AqZ6i0kfmQtLmZSKaK/r/JHmUM2YCRB/k74js22zg3ULyu?=
 =?us-ascii?Q?LIraQibSakGJ26F7HIgU4j9UQLbBYyf1pKSjspo4WVRKeK9bbqWz4NYIe3iL?=
 =?us-ascii?Q?d5dwvkT/NTQ0/yVqrPibki8MAY7jrZSmJ62gtcvLz2oMM9+Xb+7NaCxZ3fsC?=
 =?us-ascii?Q?ERk7B6Px+ajnRT/tVX7yIgM9Wmqmz8xM3cM9HBUh3rW5FEc5NmSvDmVyBQ48?=
 =?us-ascii?Q?Osv3In6LcF//LvFNBTRWu/3x8CcW+N2nd8zh1AMe21TGpy75QtxqIawTcjJ4?=
 =?us-ascii?Q?bI9yRogOE9sD1G9baYO4tzaGdXGY1MU7hkM9BbkuQyto98YPV9A3C/nYzPA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c671b29-9d99-4b27-2c24-08dbe866a360
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 18:46:13.3365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7936

bpf_obj_id uses the `CHECK` calls even though the use of
ASSERT_ series of macros is preferred in the bpf selftests.

This patch replaces all `CHECK` calls for equivalent `ASSERT_`
macro calls.

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 .../selftests/bpf/prog_tests/bpf_obj_id.c     | 204 +++++++-----------
 1 file changed, 73 insertions(+), 131 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
index 675b90b15280..986fb8429b22 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
@@ -25,7 +25,7 @@ void serial_test_bpf_obj_id(void)
 	 */
 	__u32 map_ids[nr_iters + 1];
 	char jited_insns[128], xlated_insns[128], zeros[128], tp_name[128];
-	__u32 i, next_id, info_len, nr_id_found, duration = 0;
+	__u32 i, next_id, info_len, nr_id_found;
 	struct timespec real_time_ts, boot_time_ts;
 	int err = 0;
 	__u64 array_value;
@@ -33,16 +33,16 @@ void serial_test_bpf_obj_id(void)
 	time_t now, load_time;
 
 	err = bpf_prog_get_fd_by_id(0);
-	CHECK(err >= 0 || errno != ENOENT,
-	      "get-fd-by-notexist-prog-id", "err %d errno %d\n", err, errno);
+	ASSERT_LT(err, 0, "bpf_prog_get_fd_by_id");
+	ASSERT_EQ(errno, ENOENT, "bpf_prog_get_fd_by_id");
 
 	err = bpf_map_get_fd_by_id(0);
-	CHECK(err >= 0 || errno != ENOENT,
-	      "get-fd-by-notexist-map-id", "err %d errno %d\n", err, errno);
+	ASSERT_LT(err, 0, "bpf_map_get_fd_by_id");
+	ASSERT_EQ(errno, ENOENT, "bpf_map_get_fd_by_id");
 
 	err = bpf_link_get_fd_by_id(0);
-	CHECK(err >= 0 || errno != ENOENT,
-	      "get-fd-by-notexist-link-id", "err %d errno %d\n", err, errno);
+	ASSERT_LT(err, 0, "bpf_map_get_fd_by_id");
+	ASSERT_EQ(errno, ENOENT, "bpf_map_get_fd_by_id");
 
 	/* Check bpf_map_get_info_by_fd() */
 	bzero(zeros, sizeof(zeros));
@@ -53,25 +53,26 @@ void serial_test_bpf_obj_id(void)
 		/* test_obj_id.o is a dumb prog. It should never fail
 		 * to load.
 		 */
-		if (CHECK_FAIL(err))
+		if (!ASSERT_OK(err, "bpf_prog_test_load"))
 			continue;
 
 		/* Insert a magic value to the map */
 		map_fds[i] = bpf_find_map(__func__, objs[i], "test_map_id");
-		if (CHECK_FAIL(map_fds[i] < 0))
+		if (!ASSERT_GE(map_fds[i], 0, "bpf_find_map"))
 			goto done;
+
 		err = bpf_map_update_elem(map_fds[i], &array_key,
 					  &array_magic_value, 0);
-		if (CHECK_FAIL(err))
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
 			goto done;
 
-		prog = bpf_object__find_program_by_name(objs[i],
-							"test_obj_id");
-		if (CHECK_FAIL(!prog))
+		prog = bpf_object__find_program_by_name(objs[i], "test_obj_id");
+		if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
 			goto done;
+
 		links[i] = bpf_program__attach(prog);
 		err = libbpf_get_error(links[i]);
-		if (CHECK(err, "prog_attach", "prog #%d, err %d\n", i, err)) {
+		if (!ASSERT_OK(err, "bpf_program__attach")) {
 			links[i] = NULL;
 			goto done;
 		}
@@ -81,24 +82,14 @@ void serial_test_bpf_obj_id(void)
 		bzero(&map_infos[i], info_len);
 		err = bpf_map_get_info_by_fd(map_fds[i], &map_infos[i],
 					     &info_len);
-		if (CHECK(err ||
-			  map_infos[i].type != BPF_MAP_TYPE_ARRAY ||
-			  map_infos[i].key_size != sizeof(__u32) ||
-			  map_infos[i].value_size != sizeof(__u64) ||
-			  map_infos[i].max_entries != 1 ||
-			  map_infos[i].map_flags != 0 ||
-			  info_len != sizeof(struct bpf_map_info) ||
-			  strcmp((char *)map_infos[i].name, expected_map_name),
-			  "get-map-info(fd)",
-			  "err %d errno %d type %d(%d) info_len %u(%zu) key_size %u value_size %u max_entries %u map_flags %X name %s(%s)\n",
-			  err, errno,
-			  map_infos[i].type, BPF_MAP_TYPE_ARRAY,
-			  info_len, sizeof(struct bpf_map_info),
-			  map_infos[i].key_size,
-			  map_infos[i].value_size,
-			  map_infos[i].max_entries,
-			  map_infos[i].map_flags,
-			  map_infos[i].name, expected_map_name))
+		if (!ASSERT_OK(err, "bpf_map_get_info_by_fd") ||
+				!ASSERT_EQ(map_infos[i].type, BPF_MAP_TYPE_ARRAY, "map_type") ||
+				!ASSERT_EQ(map_infos[i].key_size, sizeof(__u32), "key_size") ||
+				!ASSERT_EQ(map_infos[i].value_size, sizeof(__u64), "value_size") ||
+				!ASSERT_EQ(map_infos[i].max_entries, 1, "max_entries") ||
+				!ASSERT_EQ(map_infos[i].map_flags, 0, "map_flags") ||
+				!ASSERT_EQ(info_len, sizeof(struct bpf_map_info), "map_info_len") ||
+				!ASSERT_STREQ((char *)map_infos[i].name, expected_map_name, "map_name"))
 			goto done;
 
 		/* Check getting prog info */
@@ -112,48 +103,34 @@ void serial_test_bpf_obj_id(void)
 		prog_infos[i].xlated_prog_len = sizeof(xlated_insns);
 		prog_infos[i].map_ids = ptr_to_u64(map_ids + i);
 		prog_infos[i].nr_map_ids = 2;
+
 		err = clock_gettime(CLOCK_REALTIME, &real_time_ts);
-		if (CHECK_FAIL(err))
+		if (!ASSERT_OK(err, "clock_gettime"))
 			goto done;
+
 		err = clock_gettime(CLOCK_BOOTTIME, &boot_time_ts);
-		if (CHECK_FAIL(err))
+		if (!ASSERT_OK(err, "clock_gettime"))
 			goto done;
+
 		err = bpf_prog_get_info_by_fd(prog_fds[i], &prog_infos[i],
 					      &info_len);
 		load_time = (real_time_ts.tv_sec - boot_time_ts.tv_sec)
 			+ (prog_infos[i].load_time / nsec_per_sec);
-		if (CHECK(err ||
-			  prog_infos[i].type != BPF_PROG_TYPE_RAW_TRACEPOINT ||
-			  info_len != sizeof(struct bpf_prog_info) ||
-			  (env.jit_enabled && !prog_infos[i].jited_prog_len) ||
-			  (env.jit_enabled &&
-			   !memcmp(jited_insns, zeros, sizeof(zeros))) ||
-			  !prog_infos[i].xlated_prog_len ||
-			  !memcmp(xlated_insns, zeros, sizeof(zeros)) ||
-			  load_time < now - 60 || load_time > now + 60 ||
-			  prog_infos[i].created_by_uid != my_uid ||
-			  prog_infos[i].nr_map_ids != 1 ||
-			  *(int *)(long)prog_infos[i].map_ids != map_infos[i].id ||
-			  strcmp((char *)prog_infos[i].name, expected_prog_name),
-			  "get-prog-info(fd)",
-			  "err %d errno %d i %d type %d(%d) info_len %u(%zu) "
-			  "jit_enabled %d jited_prog_len %u xlated_prog_len %u "
-			  "jited_prog %d xlated_prog %d load_time %lu(%lu) "
-			  "uid %u(%u) nr_map_ids %u(%u) map_id %u(%u) "
-			  "name %s(%s)\n",
-			  err, errno, i,
-			  prog_infos[i].type, BPF_PROG_TYPE_SOCKET_FILTER,
-			  info_len, sizeof(struct bpf_prog_info),
-			  env.jit_enabled,
-			  prog_infos[i].jited_prog_len,
-			  prog_infos[i].xlated_prog_len,
-			  !!memcmp(jited_insns, zeros, sizeof(zeros)),
-			  !!memcmp(xlated_insns, zeros, sizeof(zeros)),
-			  load_time, now,
-			  prog_infos[i].created_by_uid, my_uid,
-			  prog_infos[i].nr_map_ids, 1,
-			  *(int *)(long)prog_infos[i].map_ids, map_infos[i].id,
-			  prog_infos[i].name, expected_prog_name))
+
+		if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd") ||
+				!ASSERT_EQ(prog_infos[i].type, BPF_PROG_TYPE_RAW_TRACEPOINT, "prog_type") ||
+				!ASSERT_EQ(info_len, sizeof(struct bpf_prog_info), "prog_info_len") ||
+				!ASSERT_FALSE((env.jit_enabled && !prog_infos[i].jited_prog_len), "jited_prog_len") ||
+				!ASSERT_FALSE((env.jit_enabled && !memcmp(jited_insns, zeros, sizeof(zeros))),
+					"jited_insns") ||
+				!ASSERT_NEQ(prog_infos[i].xlated_prog_len, 0, "xlated_prog_len") ||
+				!ASSERT_NEQ(memcmp(xlated_insns, zeros, sizeof(zeros)), 0, "xlated_insns") ||
+				!ASSERT_GE(load_time, (now - 60), "load_time") ||
+				!ASSERT_LE(load_time, (now + 60), "load_time") ||
+				!ASSERT_EQ(prog_infos[i].created_by_uid, my_uid, "created_by_uid") ||
+				!ASSERT_EQ(prog_infos[i].nr_map_ids, 1, "nr_map_ids") ||
+				!ASSERT_EQ(*(int *)(long)prog_infos[i].map_ids, map_infos[i].id, "map_ids") ||
+				!ASSERT_STREQ((char *)prog_infos[i].name, expected_prog_name, "prog_name"))
 			goto done;
 
 		/* Check getting link info */
@@ -163,25 +140,12 @@ void serial_test_bpf_obj_id(void)
 		link_infos[i].raw_tracepoint.tp_name_len = sizeof(tp_name);
 		err = bpf_link_get_info_by_fd(bpf_link__fd(links[i]),
 					      &link_infos[i], &info_len);
-		if (CHECK(err ||
-			  link_infos[i].type != BPF_LINK_TYPE_RAW_TRACEPOINT ||
-			  link_infos[i].prog_id != prog_infos[i].id ||
-			  link_infos[i].raw_tracepoint.tp_name != ptr_to_u64(&tp_name) ||
-			  strcmp(u64_to_ptr(link_infos[i].raw_tracepoint.tp_name),
-				 "sys_enter") ||
-			  info_len != sizeof(struct bpf_link_info),
-			  "get-link-info(fd)",
-			  "err %d errno %d info_len %u(%zu) type %d(%d) id %d "
-			  "prog_id %d (%d) tp_name %s(%s)\n",
-			  err, errno,
-			  info_len, sizeof(struct bpf_link_info),
-			  link_infos[i].type, BPF_LINK_TYPE_RAW_TRACEPOINT,
-			  link_infos[i].id,
-			  link_infos[i].prog_id, prog_infos[i].id,
-			  (const char *)u64_to_ptr(link_infos[i].raw_tracepoint.tp_name),
-			  "sys_enter"))
+		if (!ASSERT_OK(err, "bpf_link_get_info_by_fd") ||
+				!ASSERT_EQ(link_infos[i].type, BPF_LINK_TYPE_RAW_TRACEPOINT, "link_type") ||
+				!ASSERT_EQ(link_infos[i].prog_id, prog_infos[i].id, "prog_id") ||
+				!ASSERT_EQ(link_infos[i].raw_tracepoint.tp_name, ptr_to_u64(&tp_name), "&tp_name") ||
+				!ASSERT_STREQ(u64_to_ptr(link_infos[i].raw_tracepoint.tp_name), "sys_enter", "tp_name"))
 			goto done;
-
 	}
 
 	/* Check bpf_prog_get_next_id() */
@@ -190,7 +154,7 @@ void serial_test_bpf_obj_id(void)
 	while (!bpf_prog_get_next_id(next_id, &next_id)) {
 		struct bpf_prog_info prog_info = {};
 		__u32 saved_map_id;
-		int prog_fd;
+		int prog_fd, cmp_res;
 
 		info_len = sizeof(prog_info);
 
@@ -198,9 +162,7 @@ void serial_test_bpf_obj_id(void)
 		if (prog_fd < 0 && errno == ENOENT)
 			/* The bpf_prog is in the dead row */
 			continue;
-		if (CHECK(prog_fd < 0, "get-prog-fd(next_id)",
-			  "prog_fd %d next_id %d errno %d\n",
-			  prog_fd, next_id, errno))
+		if (!ASSERT_GE(prog_fd, 0, "bpf_prog_get_fd_by_id"))
 			break;
 
 		for (i = 0; i < nr_iters; i++)
@@ -218,9 +180,8 @@ void serial_test_bpf_obj_id(void)
 		 */
 		prog_info.nr_map_ids = 1;
 		err = bpf_prog_get_info_by_fd(prog_fd, &prog_info, &info_len);
-		if (CHECK(!err || errno != EFAULT,
-			  "get-prog-fd-bad-nr-map-ids", "err %d errno %d(%d)",
-			  err, errno, EFAULT))
+		if (!ASSERT_ERR(err, "bpf_prog_get_info_by_fd") || 
+				!ASSERT_EQ(errno, EFAULT, "bpf_prog_get_info_by_fd"))
 			break;
 		bzero(&prog_info, sizeof(prog_info));
 		info_len = sizeof(prog_info);
@@ -231,27 +192,22 @@ void serial_test_bpf_obj_id(void)
 		err = bpf_prog_get_info_by_fd(prog_fd, &prog_info, &info_len);
 		prog_infos[i].jited_prog_insns = 0;
 		prog_infos[i].xlated_prog_insns = 0;
-		CHECK(err || info_len != sizeof(struct bpf_prog_info) ||
-		      memcmp(&prog_info, &prog_infos[i], info_len) ||
-		      *(int *)(long)prog_info.map_ids != saved_map_id,
-		      "get-prog-info(next_id->fd)",
-		      "err %d errno %d info_len %u(%zu) memcmp %d map_id %u(%u)\n",
-		      err, errno, info_len, sizeof(struct bpf_prog_info),
-		      memcmp(&prog_info, &prog_infos[i], info_len),
-		      *(int *)(long)prog_info.map_ids, saved_map_id);
+		cmp_res = memcmp(&prog_info, &prog_infos[i], info_len);
+
+		ASSERT_OK(err, "bpf_prog_get_info_by_fd");
+		ASSERT_EQ(info_len, sizeof(struct bpf_prog_info), "prog_info_len");
+		ASSERT_OK(cmp_res, "memcmp");
+		ASSERT_EQ(*(int *)(long)prog_info.map_ids, saved_map_id, "map_id");
 		close(prog_fd);
 	}
-	CHECK(nr_id_found != nr_iters,
-	      "check total prog id found by get_next_id",
-	      "nr_id_found %u(%u)\n",
-	      nr_id_found, nr_iters);
+	ASSERT_EQ(nr_id_found, nr_iters, "prog_nr_id_found");
 
 	/* Check bpf_map_get_next_id() */
 	nr_id_found = 0;
 	next_id = 0;
 	while (!bpf_map_get_next_id(next_id, &next_id)) {
 		struct bpf_map_info map_info = {};
-		int map_fd;
+		int map_fd, cmp_res;
 
 		info_len = sizeof(map_info);
 
@@ -259,9 +215,7 @@ void serial_test_bpf_obj_id(void)
 		if (map_fd < 0 && errno == ENOENT)
 			/* The bpf_map is in the dead row */
 			continue;
-		if (CHECK(map_fd < 0, "get-map-fd(next_id)",
-			  "map_fd %d next_id %u errno %d\n",
-			  map_fd, next_id, errno))
+		if (!ASSERT_GE(map_fd, 0, "bpf_map_get_fd_by_id"))
 			break;
 
 		for (i = 0; i < nr_iters; i++)
@@ -274,25 +228,19 @@ void serial_test_bpf_obj_id(void)
 		nr_id_found++;
 
 		err = bpf_map_lookup_elem(map_fd, &array_key, &array_value);
-		if (CHECK_FAIL(err))
+		if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
 			goto done;
 
 		err = bpf_map_get_info_by_fd(map_fd, &map_info, &info_len);
-		CHECK(err || info_len != sizeof(struct bpf_map_info) ||
-		      memcmp(&map_info, &map_infos[i], info_len) ||
-		      array_value != array_magic_value,
-		      "check get-map-info(next_id->fd)",
-		      "err %d errno %d info_len %u(%zu) memcmp %d array_value %llu(%llu)\n",
-		      err, errno, info_len, sizeof(struct bpf_map_info),
-		      memcmp(&map_info, &map_infos[i], info_len),
-		      array_value, array_magic_value);
+		cmp_res = memcmp(&map_info, &map_infos[i], info_len);
+		ASSERT_OK(err, "bpf_map_get_info_by_fd");
+		ASSERT_EQ(info_len, sizeof(struct bpf_map_info), "info_len");
+		ASSERT_OK(cmp_res, "memcmp");
+		ASSERT_EQ(array_value, array_magic_value, "array_value");
 
 		close(map_fd);
 	}
-	CHECK(nr_id_found != nr_iters,
-	      "check total map id found by get_next_id",
-	      "nr_id_found %u(%u)\n",
-	      nr_id_found, nr_iters);
+	ASSERT_EQ(nr_id_found, nr_iters, "map_nr_id_found");
 
 	/* Check bpf_link_get_next_id() */
 	nr_id_found = 0;
@@ -308,9 +256,7 @@ void serial_test_bpf_obj_id(void)
 		if (link_fd < 0 && errno == ENOENT)
 			/* The bpf_link is in the dead row */
 			continue;
-		if (CHECK(link_fd < 0, "get-link-fd(next_id)",
-			  "link_fd %d next_id %u errno %d\n",
-			  link_fd, next_id, errno))
+		if (!ASSERT_GE(link_fd, 0, "bpf_link_get_fd_by_id"))
 			break;
 
 		for (i = 0; i < nr_iters; i++)
@@ -325,17 +271,13 @@ void serial_test_bpf_obj_id(void)
 		err = bpf_link_get_info_by_fd(link_fd, &link_info, &info_len);
 		cmp_res = memcmp(&link_info, &link_infos[i],
 				offsetof(struct bpf_link_info, raw_tracepoint));
-		CHECK(err || info_len != sizeof(link_info) || cmp_res,
-		      "check get-link-info(next_id->fd)",
-		      "err %d errno %d info_len %u(%zu) memcmp %d\n",
-		      err, errno, info_len, sizeof(struct bpf_link_info),
-		      cmp_res);
+		ASSERT_OK(err, "bpf_link_get_info_by_fd");
+		ASSERT_EQ(info_len, sizeof(link_info), "info_len");
+		ASSERT_OK(cmp_res, "memcmp");
 
 		close(link_fd);
 	}
-	CHECK(nr_id_found != nr_iters,
-	      "check total link id found by get_next_id",
-	      "nr_id_found %u(%u)\n", nr_id_found, nr_iters);
+	ASSERT_EQ(nr_id_found, nr_iters, "link_nr_id_found");
 
 done:
 	for (i = 0; i < nr_iters; i++) {
-- 
2.25.1


