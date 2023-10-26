Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEE97D7AA4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 04:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjJZCF1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 22:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZCF0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 22:05:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2106.outbound.protection.outlook.com [40.92.90.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39586128;
        Wed, 25 Oct 2023 19:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g47lRNmp1Z5d6MKcpeDEtlTJ92ax3YKUrgMBdRHkWkW4aXmd8xnlx7MEOi9x2v9sdxYRjm2wsPbKWTAbJXE6tW1fSME2mWFuPEinYCCgAX7/bO2dly2ew+rDAJP9hnEPucWrhbfzpEaGcyPXiBtLbgzpHBr/cRq8ESJIh29R35N++IbYnfq/oI7IUaarghP925ZntiUG4zrDBTDSX0XQ9syXSFgv/jF9K8kwdpjAyjU/pOcL4J6IG9c299xK9b8gP9DMcSCm6O85aFraw/IoXqdLtN49+qEM5Sqxbv6TiuggwWgTrUqGvY8sY2DjvRV/ZNG+dosTqkDKl7mSfEiUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SsSTypahLirAE+kKQYUj4EDriScEW0oGKZ8Q8fMz/I=;
 b=F+rwSwYV/quAQmNO7N2Hz5e/DcAk3RLt1qepgrr1lqGU0W1Y3GJ+giDGPP2zaxsWAbTC5uIV+h9JKkbEstG0R1cA2LXKGQNveUoPE87YWubbxAqoXHq0eDd9gpsKg21kx2BpBHPEHZC5aooQ1xy81iVNOt6zfgEcPxLDE7JzjUTqMNlTzqyxvQrWJe/2xqK/EWNG5SDg458AVvt6hTPW8v+AOlLlkW+JgvEZJSqAq/d0fFI124Yni1Ld39NTenbu0UzvcijdVjE8RanhOfcatgpOHy7Jc3h/gcs8V+gmwfyisSYWXCbRG+GSmO+vCR22hRlV2RM5lMzMF454rIFS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SsSTypahLirAE+kKQYUj4EDriScEW0oGKZ8Q8fMz/I=;
 b=j7qfZXv7gQn01lHaPwBc3v+xMWCB3kf7nyRmxGGwghGX+i/lys0VPaTRPCwJd7licJIp0YwYn9dghz9d1uhJZhum6CYMcXC8B1XA8GnD94F96ZV8lREuhc+bR6hrKIM2w7L4/kjgPRjV0rsUvM7UwE71eJhEVNfEQ2HLblZQbS8Df+26QZqvke7Pg1usy3pz4dEtkNxj5Ikke8naWumNBkRtexZTXBfNKR+xeSDfrMvGfWcWxIKicUGscE0WzfR2iPWW1eFZeZddj2EskTFGJP7gHwkg1McAUGnMyZPaSHHb4HtALmu6f9iS0WCjcpyFq1hbnNT/caHRQ4ETopP5Xw==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by AS2PR10MB7048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:594::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 02:05:20 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 02:05:20 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     bpf@vger.kernel.org, yonghong.song@linux.dev
Cc:     sinquersw@gmail.com, shuah@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, brauner@kernel.org,
        iii@linux.ibm.com, kuifeng@meta.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuran Pereira <yuran.pereira@hotmail.com>
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter
Date:   Thu, 26 Oct 2023 07:33:18 +0530
Message-ID: <DB3PR10MB68352B683F26EE9C342B71A9E8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026020319.1203600-1-yuran.pereira@hotmail.com>
References: <20231026020319.1203600-1-yuran.pereira@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [RltpM2lkkKupvCzJiIeQW51cumD0Kkdc]
X-ClientProxiedBy: JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231026020319.1203600-2-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|AS2PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0bf7c2-78eb-4111-feb2-08dbd5c80199
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0+CTgwo8Uxd4IOQzDdHRy/7RVfQEjx0Bc19W4SzLSlSOqyA3XnEzUmLaUYHgGcEhuSQ5htaYuCbN0UcXrriDR0iySKtCsYCXErUeCK0hnBAlkvcSBJIv7j3Ama5dt7S4IYiJ35VIi/0v/qHal6ovU8+sOjsCt2t890/eNfT5jPy0jpDqGAmmqT9xLf7sB3YVBcoAv2KcritA4DEWyns0T1Hul3z3Ov7hCyP0FbNyg/F/pO2ori0fha1rCAF/rZ693VQ/jDUk7H2Kqc4q1S/i3h4Gb7agQYPYTBe3xW6qtYHZtzcnQh3VbXzAPYr511mXDsq+V9IMWRzQKrszk9vTmrQPw+1HAf2nlXzHri21Vb2jW1ehQo1GeK0KZozddjatPotxx4PDncUXArm0ZmFMOGz5Ry7ghdmgzGCF2DJWRH/SyaGp+m5m35W1PxvKMb/boP/RG9Z1UAXYxIYxu/QfYBqvGyAwO5/37bglIWa+hrlVkbP87BMyryhxg4mwlpnir6ikqCN2B3JbH14BPcd75UqCfeEEvjshf6IQ+8GV5Veh/0lARdXyFvlCk8NUZ1PnQMjrqVZTnRSyMO8v432fmY95NCUDHMtV3Tl9KyKUSci25h8uUnZVRD2twXYA1i1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ptv1SJ+21qkC/fJUPBnzCaOsNqegaIRL5JFa/Uyl1VSmgUOkNy4CH20XfiTc?=
 =?us-ascii?Q?XZ/Qj+CrjB8N/z+HT2lOaNvim01XU6Zn7KQnkvuQLdvjjhOs0FuzAbE8h1Gh?=
 =?us-ascii?Q?wbYMLy8/TJwvP+LgcptLLy87osPiXBTOMiP/e0rTKGLrMKqqnyDNAPkr9BgU?=
 =?us-ascii?Q?/7YBu9FSoA3+rwXD2Fkhfrz/R2UWzBhFoExgzLtUWoGgRKnO3VAjaj3uPMqJ?=
 =?us-ascii?Q?Qoqv1DrCp5+xKikqHAFXZAVhfSc57UFkFxBNNp4P0Gjzcpb1MqYhJ1Q8c1Yx?=
 =?us-ascii?Q?9V84LwGQyCbKOMNzl+Vx7nyQUkpYhtkBzPU40Gw4oISCMTisLXXDOHekHcC8?=
 =?us-ascii?Q?LmMtzEeUIAjFKJLf1Q3Hy4gSw3TWLX3rDQONHCebjb+qEkVQYFYz8FL/eaAm?=
 =?us-ascii?Q?d/wc4wdeXSMWMrOVVmyMKkf2djEOR9bA3XlgG+5nBoHJKNQ9Ih0lQiBHkv2L?=
 =?us-ascii?Q?IZB/iiU8S60YAbu9x77JXOj5Nz/hPjM45N2YXe1oGTSPwAe6bJn4KnKWbpjq?=
 =?us-ascii?Q?NOf0dKLnjqLhXSOSg8yfeqK7DZHPlp8e3k+hSAqmrdimSbEDbnT656070M1g?=
 =?us-ascii?Q?G7RhKKryRx84qoLP3qV/zaPcSl2/cPpVPWl2XwNinU9wRia2Cg+2XOWydiv2?=
 =?us-ascii?Q?tpNQvA0exTux11FYTCJGvW7SfNuefYf/o+n0M4+ZDuMZKHaZbvkTdgcgcnxL?=
 =?us-ascii?Q?9o4CF8xiud7tYJi9O5W4FG52dLZnVedNpO5DwqW4nXHvDUVp8BIq5iJC/VqW?=
 =?us-ascii?Q?QHu3uS/uV2dbvw67x9xBXXlrUmyFiU2nwYqGslibnMSxhGe7WljT1F7VyH5g?=
 =?us-ascii?Q?P9Xg5JqDG19dyywHAbnYFTLUWF5bBdr1j/6aGzX+p1IGuPNagxAQiGeMtPlY?=
 =?us-ascii?Q?UbAUeQN2szx9HCjn4cNGyWRBf99H/Pr+Wt4PUPcQIfAeIrrTlposQDA7UQlv?=
 =?us-ascii?Q?AomkoUxkpx9lqZIYu8yQqZlmZJsjCyQaOmNdL+A7lAyUOI6LNMIvnPk0zanY?=
 =?us-ascii?Q?YFcBsWdxVco5P7xpkeZTfRmAYNYf7SNdL/VIDied6bZvmV5mZJVroPf5xSUy?=
 =?us-ascii?Q?ZFEtGrNpLTyvsMC6Gik7ZsvvHunDba/svu+nCHueN+UwGMW7f+Tl9FAOXjYm?=
 =?us-ascii?Q?ishDPQ9bVnwnYXUGqbfksBICh2ckpU0cHptBVPBXY1vKkMhIKNwIO3b10hzq?=
 =?us-ascii?Q?owxxi4KgCEBFkB/e/7FsgMSj9V/2kjvgNhc8UXBgSlozQk2m2M36ZuL7+CI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0bf7c2-78eb-4111-feb2-08dbd5c80199
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 02:05:20.3410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7048
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
 .../selftests/bpf/prog_tests/bpf_iter.c       | 82 +++++++++----------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 1f02168103dd..7db6972ed952 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -34,8 +34,6 @@
 #include "bpf_iter_ksym.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
-static int duration;
-
 static void test_btf_id_or_null(void)
 {
 	struct bpf_iter_test_kern3 *skel;
@@ -64,7 +62,7 @@ static void do_dummy_read_opts(struct bpf_program *prog, struct bpf_iter_attach_
 	/* not check contents, but ensure read() ends without error */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));
+	ASSERT_GE(len, 0, "read");
 
 	close(iter_fd);
 
@@ -413,7 +411,7 @@ static int do_btf_read(struct bpf_iter_task_btf *skel)
 		goto free_link;
 	}
 
-	if (CHECK(err < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(err, 0, "read"))
 		goto free_link;
 
 	ASSERT_HAS_SUBSTR(taskbuf, "(struct task_struct)",
@@ -526,11 +524,11 @@ static int do_read_with_fd(int iter_fd, const char *expected,
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
@@ -571,8 +569,7 @@ static int do_read(const char *path, const char *expected)
 	int err, iter_fd;
 
 	iter_fd = open(path, O_RDONLY);
-	if (CHECK(iter_fd < 0, "open", "open %s failed: %s\n",
-		  path, strerror(errno)))
+	if (!ASSERT_GE(iter_fd, 0, "open"))
 		return -1;
 
 	err = do_read_with_fd(iter_fd, expected, false);
@@ -600,7 +597,7 @@ static void test_file_iter(void)
 	unlink(path);
 
 	err = bpf_link__pin(link, path);
-	if (CHECK(err, "pin_iter", "pin_iter to %s failed: %d\n", path, err))
+	if (!ASSERT_OK(err, "pin_iter"))
 		goto free_link;
 
 	err = do_read(path, "abcd");
@@ -651,12 +648,10 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
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
@@ -685,14 +680,12 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
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
 
@@ -714,16 +707,15 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
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
@@ -732,8 +724,7 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 				total_read_len += len;
 		} while (len > 0 || len == -EAGAIN);
 
-		if (CHECK(len < 0, "read", "read failed: %s\n",
-			  strerror(errno)))
+		if (!ASSERT_GE(len, 0, "read"))
 			goto free_buf;
 	}
 
@@ -836,7 +827,7 @@ static void test_bpf_hash_map(void)
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
@@ -917,7 +908,7 @@ static void test_bpf_percpu_hash_map(void)
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
@@ -983,17 +974,15 @@ static void test_bpf_array_map(void)
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
@@ -1092,7 +1081,7 @@ static void test_bpf_percpu_array_map(void)
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
@@ -1131,6 +1120,7 @@ static void test_bpf_sk_storage_delete(void)
 	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (!ASSERT_GE(sock_fd, 0, "socket"))
 		goto out;
+
 	err = bpf_map_update_elem(map_fd, &sock_fd, &val, BPF_NOEXIST);
 	if (!ASSERT_OK(err, "map_update"))
 		goto out;
@@ -1151,14 +1141,20 @@ static void test_bpf_sk_storage_delete(void)
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
@@ -1203,17 +1199,17 @@ static void test_bpf_sk_storage_get(void)
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
@@ -1290,7 +1286,7 @@ static void test_bpf_sk_storage_map(void)
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
-- 
2.25.1

