Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA0A7D5E6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 00:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344484AbjJXWoi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 18:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbjJXWoi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 18:44:38 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2035.outbound.protection.outlook.com [40.92.90.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F0010CC;
        Tue, 24 Oct 2023 15:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g12CXKSLhnqPEik0+rGDz1h+VcG+kRCE9I8thmHoNAHfDBT8/0f+h8jrEqQ/gyIKcjXWhM6USiv84dHSP8OsQK/KzRTjvN6+H/hbs1FRM8Thhh7pSC8aBLLdworpQTo2+MtbAcrTqbSVUQR/+UJaTo1gOHh7Qrhj762O8LGt8GO3A2gkvYRidCin1L1sWTAzN8eQn4oJkL2IWlVJxAh/1e0oPZr9H4jfm5ZeNuNUQFL7UKySHZl+p1Ywq1o6W+Mg668JE58GKFi9vPIjR4R6D8RRg+t6aaCbe++oqh6xtvQwJoopEyJEy3XshsPm/iggECsC7isOp+qQn4QrejR0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4CGHoK/U8pNm/aSNzIvvseE3n3Cos4JFnIkgRy/hYY=;
 b=ZhdK0pqmiFrut0lbWiB8BjpBb65dCTcdvtb1l8d0OsiD7bv0nhDVi22O5KIgwO40se2F2/C9Cii1qLIUdRpOBT72noEAIdB3GAQ71kZM+PMOIpzkSOQY2zaw6OYC4+lM89g07aP/aUTuujBtBC8R5wDuyOv2mD4aEefZDQyTa9iG2k5uXWqrVnuXJt6t8N3iFBiC/mK0DjuyRRshRESXwnVkpUDWlf9OGFYbF20nW13Z0RghN+eJoOZrbHYd2vIqot9o+QetL0XaZ4y+2HpLTiOWvPq6IomduV81hFJmSRg40OkLxhwt5VOWAxNIdWIYmQ1FUwocgRvk7av6pGP2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4CGHoK/U8pNm/aSNzIvvseE3n3Cos4JFnIkgRy/hYY=;
 b=k3MZ1hqdId2T5ubMUo/nFelzMV1+eB4SI6SZFDak9YsZYxW65Y+83u77IotnB4QgLCChDel3o35DwwN7KRlQcR0l6Pp1kWl8epDx1AW2mneqB4Y6Ey21SuPM2CXmv0VcVAvPvL99ME6C2wMTr+6RHdaax9yjW6SuGIoFVnUq0m6qc1Mcyv4cjHEoG1SpOxy+iB/fFfY5mA9FTxc9Y5xm3bHkjBFz+f8G7MQ0qcD2BrNq2ZvrrOOJMs8Xztyrd6VPw4rcxZwEmzeRvzexBPM8lL68lcroJZgcj9EFOgFdz+oOJD4dEOH/R8a2xMFfzccj4v90k9IDe9O80k3JxDIc0A==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by AS2PR10MB7477.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:593::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 22:44:31 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 22:44:31 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     yonghong.song@linux.dev
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, shuah@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, brauner@kernel.org,
        iii@linux.ibm.com, kuifeng@meta.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter
Date:   Wed, 25 Oct 2023 04:13:20 +0530
Message-ID: <DB3PR10MB683589A5F705C6CA5BE0D325E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [7lHMraXneiI0S4kqlweSKyiTwx8FGMau]
X-ClientProxiedBy: JN3P275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::12)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231024224320.1053343-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|AS2PR10MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1b2614-83b8-4463-cb0d-08dbd4e2c93e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYTNssAkQ75cFkkJ7PtFtuOh+Tg3sg1wdGjA9XrR+wFKC6+fvhfLybaArcrgk9fZ3hMBI12ZNpi53mdtrfZ+GbTYjt4IL0Ylv933qjpkH264cv259eVPESU3HZPZmhVMN7MBbnZlavOYkMOjmRVJf7YTCc5jHk7Ig7/UJ/L3IVIPKDYXvgY5tHVHmAxlirFyAbAVvDk3FnavSZnm4BY6eXjObxrW1cYW8zxq7A0pA1PMQ1RtfZxeGRo933ujH3i/uYpeTkmNZP2vsd9qbaUADU72CQNtOE6PkpuZel5ONB6fKyyGftgkcQuvXV8D+ypYzvCo1rOW9PgeviVkXhmFXOIsdhixgxL+Sems52mqROEeUwKAhz2nuLF+Ow9FDXj/JVrYlPpJy+iPLa8451R52y6tExDR853Sy55SWv9vCswa3u4SQFWD6uQrrwbfFzca0HZ3H/e2tffWVoYDcP/9XC4FImC71L/+RkXPInvHf7gqEmqhpNKuupp0Uy2dAWwi4eKhgcDV+nuX7wgczLWJhyWIGFitxdACE37yxZ2ePGDDT2m7zFvz6/2/mMGmYfUdMZWeqHYgAjAG/YXGPCFXXGDbz8aVEbsqnAdA3hoK+u25kyjBpyaKElUSMZrWooG3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7BW0md1gKnK5Isazinq9PzMRrS3MHd3+POlgTHwUJAt+pPIoITsjg+bZqQW1?=
 =?us-ascii?Q?bx//a3VYhxFx3LMh+HzO31+5FTi/eVkk1Smg5wDVVPA+1x/veqtotvGxkqmU?=
 =?us-ascii?Q?Q1LOLPh2JayXXtcFsGC1jNjddzfAkruG7QAkaZU+KuU3WYFp1j5JEZWghCa6?=
 =?us-ascii?Q?g/es72YXSCbUQ9ntYtm3xAnCIgxIB8Z1MKxNfIHMOKYkRQ++OMQnRVJYztIj?=
 =?us-ascii?Q?xKAZxd4pvdDMxnBClWkceRtUTkDkzBh7AL3sxr4W0yIaiObPrcYbtjSN5chz?=
 =?us-ascii?Q?jEmJAbHvjHyx0CIPH7pn0PDZ7V+WVP1lmsi95F9K2ARh2Ma35RQXZ3MHiIhz?=
 =?us-ascii?Q?2qHV4lvmGG2halBCoa68WmWJ7UUDZBNy6fFdbdvuyv7PgipWXNG5iZvZEjS/?=
 =?us-ascii?Q?D9OQwyDbVOqsBkMNDX5YC5cYSLRtmIUjzom4CcQr6wltQtVDzl+AtzYaOxMh?=
 =?us-ascii?Q?58k8B0FH9AKgLPq+srS0qugwX/edEhZwCkg2Sa/XLzfOeRkL/CaZbZu/e9eJ?=
 =?us-ascii?Q?iwfh7094gYR79L2TqFpOk5VhJbb/Rbl8QLBuLazkaQQ3LZLwrQpXPcchsson?=
 =?us-ascii?Q?KrGdQsShclUydXG/nm3iK1w4NQwXG3mz78xmKKO6PGPDQK3ZUKAsddUQqWw8?=
 =?us-ascii?Q?HQJXVWKHlL6tuVkyUDW6zBZeTdxZypCRRWCloqzJ6xcsIz1rRgPmlGrdqL9W?=
 =?us-ascii?Q?WH7tSbgW5oRAbZxBIDHfrIdHOKoEVNmctd/M96lANJ+18WWjNA5q8Xl2FC3Q?=
 =?us-ascii?Q?B1b1qmd1yvoReFeRzXEatVWMMNTaDm1Ykr+TZH9NNXvTI1GqMHO6Vc37+fj4?=
 =?us-ascii?Q?c43B4whLpovMY2bcR3CJqBWWp8p0E0x5kl9Je3u8C7Mw8tZQnVnFIAlbosTh?=
 =?us-ascii?Q?KZ6oc01nfN1J3Y528DbrFkwobQj8yHSA8DSXmIKEFN838RTw8AEmnC4slG4W?=
 =?us-ascii?Q?eQMo+Wt5KQclqdIv8AD8lGSp3EX2VCdYPoppEywSU0jTMZjV4LdzD3j1mpRt?=
 =?us-ascii?Q?KaIquse57qoI2G4O+zJBVc4yYPeT4/tbnkx+SPowK+HIFYpeGyoQ5sPCEo+n?=
 =?us-ascii?Q?sEg8Pk1kCgBnXf6UFTAyUpOiG5IiAqZaR8AGiGvi/c/fOukJdsgdBhYrBD1L?=
 =?us-ascii?Q?syV+GkVxCSskfIbdRnsCZId8h5kbs3crXF08xH4pWajLtEiw1qpPPHQ49e+X?=
 =?us-ascii?Q?vpkO5c7g3WrN1yyHJxU4D1FXN9hQYAaOUQKnTwK8ezVYdQywQrLU5SAxN/o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1b2614-83b8-4463-cb0d-08dbd4e2c93e
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 22:44:31.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As it was pointed out by Yonghong Song [1], in the bpf selftests the use
of the ASSERT_* series of macros is preferred over the CHECK macro.
This patch replaces all CHECK calls in bpf_iter with the appropriate
ASSERT_* macros.

[1] https://lore.kernel.org/lkml/0a142924-633c-44e6-9a92-2dc019656bf2@linux.dev

Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 80 +++++++++----------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 1f02168103dd..526ac4e741ee 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -64,7 +64,7 @@ static void do_dummy_read_opts(struct bpf_program *prog, struct bpf_iter_attach_
 	/* not check contents, but ensure read() ends without error */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));
+	ASSERT_GE(len, 0, "read");
 
 	close(iter_fd);
 
@@ -413,7 +413,7 @@ static int do_btf_read(struct bpf_iter_task_btf *skel)
 		goto free_link;
 	}
 
-	if (CHECK(err < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(err, 0, "read"))
 		goto free_link;
 
 	ASSERT_HAS_SUBSTR(taskbuf, "(struct task_struct)",
@@ -526,11 +526,11 @@ static int do_read_with_fd(int iter_fd, const char *expected,
 	start = 0;
 	while ((len = read(iter_fd, buf + start, read_buf_len)) > 0) {
 		start += len;
-		if (CHECK(start >= 16, "read", "read len %d\n", len))
+		if (!ASSERT_LT(start, 16, "read"))
 			return -1;
 		read_buf_len = read_one_char ? 1 : 16 - start;
 	}
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		return -1;
 
 	if (!ASSERT_STREQ(buf, expected, "read"))
@@ -571,8 +571,7 @@ static int do_read(const char *path, const char *expected)
 	int err, iter_fd;
 
 	iter_fd = open(path, O_RDONLY);
-	if (CHECK(iter_fd < 0, "open", "open %s failed: %s\n",
-		  path, strerror(errno)))
+	if (!ASSERT_GE(iter_fd, 0, "open"))
 		return -1;
 
 	err = do_read_with_fd(iter_fd, expected, false);
@@ -600,7 +599,7 @@ static void test_file_iter(void)
 	unlink(path);
 
 	err = bpf_link__pin(link, path);
-	if (CHECK(err, "pin_iter", "pin_iter to %s failed: %d\n", path, err))
+	if (!ASSERT_OK(err, "pin_iter"))
 		goto free_link;
 
 	err = do_read(path, "abcd");
@@ -651,12 +650,10 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 	 * overflow and needs restart.
 	 */
 	map1_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 8, 1, NULL);
-	if (CHECK(map1_fd < 0, "bpf_map_create",
-		  "map_creation failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(map1_fd, 0, "bpf_map_create"))
 		goto out;
 	map2_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 8, 1, NULL);
-	if (CHECK(map2_fd < 0, "bpf_map_create",
-		  "map_creation failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(map2_fd, 0, "bpf_map_create"))
 		goto free_map1;
 
 	/* bpf_seq_printf kernel buffer is 8 pages, so one map
@@ -685,14 +682,12 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 	/* setup filtering map_id in bpf program */
 	map_info_len = sizeof(map_info);
 	err = bpf_map_get_info_by_fd(map1_fd, &map_info, &map_info_len);
-	if (CHECK(err, "get_map_info", "get map info failed: %s\n",
-		  strerror(errno)))
+	if (!ASSERT_OK(err, "get_map_info"))
 		goto free_map2;
 	skel->bss->map1_id = map_info.id;
 
 	err = bpf_map_get_info_by_fd(map2_fd, &map_info, &map_info_len);
-	if (CHECK(err, "get_map_info", "get map info failed: %s\n",
-		  strerror(errno)))
+	if (!ASSERT_OK(err, "get_map_info"))
 		goto free_map2;
 	skel->bss->map2_id = map_info.id;
 
@@ -714,16 +709,15 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 		while ((len = read(iter_fd, buf, expected_read_len)) > 0)
 			total_read_len += len;
 
-		CHECK(len != -1 || errno != E2BIG, "read",
-		      "expected ret -1, errno E2BIG, but get ret %d, error %s\n",
-			  len, strerror(errno));
+		if (!ASSERT_EQ(len, -1, "read"))
+			goto free_buf;
+		ASSERT_EQ(errno, E2BIG, "read");
 		goto free_buf;
 	} else if (!ret1) {
 		while ((len = read(iter_fd, buf, expected_read_len)) > 0)
 			total_read_len += len;
 
-		if (CHECK(len < 0, "read", "read failed: %s\n",
-			  strerror(errno)))
+		if (!ASSERT_GE(len, 0, "read"))
 			goto free_buf;
 	} else {
 		do {
@@ -732,8 +726,7 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 				total_read_len += len;
 		} while (len > 0 || len == -EAGAIN);
 
-		if (CHECK(len < 0, "read", "read failed: %s\n",
-			  strerror(errno)))
+		if (!ASSERT_GE(len, 0, "read"))
 			goto free_buf;
 	}
 
@@ -836,7 +829,7 @@ static void test_bpf_hash_map(void)
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
@@ -917,7 +910,7 @@ static void test_bpf_percpu_hash_map(void)
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
@@ -983,17 +976,15 @@ static void test_bpf_array_map(void)
 	start = 0;
 	while ((len = read(iter_fd, buf + start, sizeof(buf) - start)) > 0)
 		start += len;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
 	res_first_key = *(__u32 *)buf;
 	res_first_val = *(__u64 *)(buf + sizeof(__u32));
-	if (CHECK(res_first_key != 0 || res_first_val != first_val,
-		  "bpf_seq_write",
-		  "seq_write failure: first key %u vs expected 0, "
-		  " first value %llu vs expected %llu\n",
-		  res_first_key, res_first_val, first_val))
+	if (!ASSERT_EQ(res_first_key, 0, "bpf_seq_write"))
+		goto close_iter;
+	else if (!ASSERT_EQ(res_first_val, first_val, "bpf_seq_write"))
 		goto close_iter;
 
 	if (!ASSERT_EQ(skel->bss->key_sum, expected_key, "key_sum"))
@@ -1092,7 +1083,7 @@ static void test_bpf_percpu_array_map(void)
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
@@ -1131,6 +1122,7 @@ static void test_bpf_sk_storage_delete(void)
 	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (!ASSERT_GE(sock_fd, 0, "socket"))
 		goto out;
+
 	err = bpf_map_update_elem(map_fd, &sock_fd, &val, BPF_NOEXIST);
 	if (!ASSERT_OK(err, "map_update"))
 		goto out;
@@ -1151,14 +1143,20 @@ static void test_bpf_sk_storage_delete(void)
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
 	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
-	if (CHECK(!err || errno != ENOENT, "bpf_map_lookup_elem",
-		  "map value wasn't deleted (err=%d, errno=%d)\n", err, errno))
+
+	 /* Note: The following assertions serve to ensure
+	  * the value was deleted. It does so by asserting
+	  * that bpf_map_lookup_elem has failed. This might
+	  * seem counterintuitivei at first.
+	  */
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
 		goto close_iter;
+	ASSERT_EQ(errno, ENOENT, "bpf_map_lookup_elem");
 
 close_iter:
 	close(iter_fd);
@@ -1203,17 +1201,17 @@ static void test_bpf_sk_storage_get(void)
 	do_dummy_read(skel->progs.fill_socket_owner);
 
 	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
-	if (CHECK(err || val != getpid(), "bpf_map_lookup_elem",
-	    "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
-	    getpid(), val, err))
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		goto close_socket;
+	else if (!ASSERT_EQ(val, getpid(), "bpf_map_lookup_elem"))
 		goto close_socket;
 
 	do_dummy_read(skel->progs.negate_socket_local_storage);
 
 	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
-	CHECK(err || val != -getpid(), "bpf_map_lookup_elem",
-	      "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
-	      -getpid(), val, err);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		goto close_socket;
+	ASSERT_EQ(val, -getpid(), "bpf_map_lookup_elem");
 
 close_socket:
 	close(sock_fd);
@@ -1290,7 +1288,7 @@ static void test_bpf_sk_storage_map(void)
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
-- 
2.25.1

