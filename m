Return-Path: <linux-kselftest+bounces-352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F787F21F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 01:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20D3282787
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 00:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872F6636;
	Tue, 21 Nov 2023 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="R52DQcZa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2072.outbound.protection.outlook.com [40.92.65.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFD597;
	Mon, 20 Nov 2023 16:09:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHFA8h3tQIqOXD/Jg0NN8XSoLX1R34y0sXftg7PPrnxg9b+PlSOwH9L0m0IRK+3FrWFCPMJ3RrYzrKDvcLb7W+qLDaGDe1IGMuIWr7bmk1rA3Zaox14gdjMdoGHzlv91m4TJhZV+h85uXPCSEEgewV45T2B4kpwFIWSVNFem9tmPHbwrPhP1CZ7zVsot5e7RoFoTA9VMaTbYL696RJMIJsJIuZkFGMMMOAK7K89ADkC+ncvrdIRI/i/piqn9nAEnslbY0rJDyd58zJFv1rMm1YKbJ+eOtmnrYe7AmR1yYqVgEpOFqVXyjNIP+oChpMjUQdLoUEef16/XGu4/haiG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piQaToojm3qbR2rRzMqggkfCTjcB4RS+/8/vAQe8Fwo=;
 b=ZMosWzYzBUab5ldb8mHB6tOdCrngtHVUVq0tK3d++xScpOmSomQSeet0XR4oT5GQ92x0BK7eSKWLEVpD5bPCXHxG9O11tkpTdFbifPBdSWVpTE7TFZAazsO4oogeYHsIwTDe9mKealvow3cxvxGWKG5MRAKIiVosSKVQnkKclG2KursqvIgZ9nFPJI6YXl19MbyjpCoppXoHqZFA5P2XbinHSQCxKqQzRzGWl5qwuaZ0/i6C9Uo4QDJk8z6nc08fopNcJ7s/O/ODPwr0W+xvthLi9fQENXQuKG489rfgTUbfZUVa6mH9vq3BAbsxhq7IkYGbAJaLkYXxgEvJFXIKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piQaToojm3qbR2rRzMqggkfCTjcB4RS+/8/vAQe8Fwo=;
 b=R52DQcZaYgsZPh6hy9sRQpzlFQlAzh7rgaAd7OMKtNwYK3mSxx39hhXSq0aRV3lr+9u5CIiTRkutZRmGd4lUCOBNwr6w1af4gS+IWhBU8mPzo58mpPEaJqqyiLAVEVZ+OQMiKKu1RSf5Iqab4e1LyRE+9X4X9ZbliwZbwydG2orSb1kWhwDjNRMx3a8MCOuKxrfuXMU78v3xNYpgaCQ+fhF66wPZMSlp2ZZ6UaYjNmVp+dWwbYlOi72/D7qOYEUfOhx8QR1KcJesljMq1Z2H7O2F7kGFwTkXYZabg/PdFkWSE9FSl28KuQDvDuyVq7qr0REsTIGGrpCHAzKCCxHELg==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS2PR10MB7477.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:593::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 00:09:46 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 00:09:46 +0000
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
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bpf_obj_id
Date: Tue, 21 Nov 2023 05:39:25 +0530
Message-ID:
 <GV1PR10MB65639AA3A10B4BBAA79952C7E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [NajEpF/15VQGibqeRjjpOpWyx+Xkwigd]
X-ClientProxiedBy: JN2P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::32)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231121000925.421563-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS2PR10MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f54da95-3361-4401-9020-08dbea262b4b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QyexJDEA6BA6k+s0jNs/7nMN9DGJw/l7oyk+t8JFvQYUbfqNvQ0KTJNlPn5HyCN2UGnJT4SPG+zHEA0GZhDPjVIv+qdoSAMQkHN3FM+rIR4veGFskMWLK8U++2Ez1WJFB46JO8lFOFeBxqST8lmMaJd37m1iJZ+hJ+prM0yl4/qDE6BjV2kRN+et5c8qp6mF2fFY8iBK2qtOUd0obG1YG6V/4gogQ6Jzm93RbnWbi9CqyOYzCqvIWr6XnB+Om39JZgYriA/ulITyT+JGISo50y0J2w5nhlERlEeK4qVtYLbxPpfvo0FQC0WBol3NUonlQfp2bLqCaxE/vm2/H5wn1JF00q6JV6hY4Tszf9JZo3SmDM4NU8t36umWKw5hmmvTnMkR9W92YBMo6CDLVR0a+Dw0bew53AIYJD3K3xfgwoYOMJf7qJbv2B7/FD/AD5edOyYe80HpImVCkZCdxxaFbrr3QuHr5Gr2Nd59AhZhLqONvcS4z3dCH7uom5msR0hEKwHGGkDzUqGjBLHveVdDSQi9Lp0jTuU7f1m6DmkSsvDnL94sB0eTZu3+EnPw/M+XTTUiX68Vfl73WekxNtEc7N2W2dhR+nTkdbLOOT/OrcxsnTx/bzHtD4uJ7HC0UoZ6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?okkMx7hKCFFMcW9vv8jitpBWJlwFhsQT/iA9olDZErc7zcMJvPOQOpNoLb1r?=
 =?us-ascii?Q?JPfWS5iTbiToHdc3ay1JnQn791Do/dLbGCBB/MvZ4zU8FYhqlaOA9TVmMeIG?=
 =?us-ascii?Q?vSeLBySXkS2hvgAWcAtZiVXEXzARV1JWnt3giiivaBobFtiafmchWoOnl8f4?=
 =?us-ascii?Q?Z9xtuT/MN+of+/Q4bcuT7klHBm21lNRw6Sp4rnnoEB/cRUas3bDH3Yrd4OSv?=
 =?us-ascii?Q?jTZXa2+wuTX5MwX+YYaIFxT0LfB7XxQyhCTuAFmcECA5MPauobrON48Y8zAf?=
 =?us-ascii?Q?KZx5T8+TIyhSUCrj3uY8PK8QbSgUnTEaFPqz6DrFo20Bb2HazluGsi2UGsla?=
 =?us-ascii?Q?zQTzF8JK4IJoBiw19A7LuAov4AM9v2AZG1HJvLAlMeIFDC+Lc6MxVRlP86Zz?=
 =?us-ascii?Q?nY/XhC7GB1mGcp67pxA6sId2aZTYMJzn92IWTT7JC6XO+0DGXtRlSgYHGZdI?=
 =?us-ascii?Q?PtvAyJ4tfOzwdzAj98nB1uv+EVy3gZbhwe9crhNabY++Y57fqllfVil8EwLX?=
 =?us-ascii?Q?52uh4ErdAfMbA/s7JGN7AVO/+8fbWKt1iK7o2QrxkHKfrBg50OsHoeQ9l9KO?=
 =?us-ascii?Q?CiqlaEmDW7kZrqqBa1dMGXLmXolSgZIhfa4vw1KhlpUaXkP2/26SXpdg82wf?=
 =?us-ascii?Q?axbBwhhy1nZCfp+KnmC6TEOVWPUyPdMNR23eBEtWabX55OW2buwu3SlY4BTJ?=
 =?us-ascii?Q?q1Yf96n0sm78S2zNELAS1/MYpXkXKF38UlHoOAmBAk9as8Sjl25ScGjIBFIb?=
 =?us-ascii?Q?yshSAvcVTSRk9exwY+23x6xW1MipsOjJYecuuNXR9A/B2T+ukwfOFuF3UGzj?=
 =?us-ascii?Q?slS1vB0WdZv7H+knQaoX2gahRtlZD1Y9To11dtcXtrLxh8Q2pP4oQJU684hp?=
 =?us-ascii?Q?KpMlrstWrh4UOz7OdVkOejfjWy53BQ6snLyMyAxcc8729BQzsv3zEhK/hI7/?=
 =?us-ascii?Q?Xc54vrbdSC3qOx0ATFKZjCuPPhC7Umo0rHYEjwh+sKcEErh3pUl0/kQGEXTr?=
 =?us-ascii?Q?aATaTAtcOlT1ULfz4do2GCUohF7/FsDWZvbPRz2a6Jx/Rw4899COMp9Jxn8u?=
 =?us-ascii?Q?DRNI26ulpXgKVHvznJyjTeIJT5XUeqahitHKRwJZ3i+47DuJhuAxr0RYAFxQ?=
 =?us-ascii?Q?a+EhvSAeOqTGAZoxNMlSsuW+Gv937HDbQKbNvPuR0lZbiL/6nVwUcSK49ysd?=
 =?us-ascii?Q?Y+pbhNcUKrD65GuOorzEbKf0d8KYa3S6hTCPwWbaMpS61v0EFhGm7Y4iUuo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f54da95-3361-4401-9020-08dbea262b4b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 00:09:46.4252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7477

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


