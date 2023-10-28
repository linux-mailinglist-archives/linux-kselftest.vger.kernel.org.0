Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116287DA52F
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Oct 2023 07:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjJ1FZH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Oct 2023 01:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJ1FZE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Oct 2023 01:25:04 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2081.outbound.protection.outlook.com [40.92.64.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6DE10A;
        Fri, 27 Oct 2023 22:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zk5tVOCnZ9Kvf2CX5Ss9Cn1X1EuI8gjiHv38JoWbq1Aba87P1u7vaZ8S4bXc2I7No71XWbl9YuO3Xb8ub9niaQ5n6mWdnBA1d9uOW9Y5ZNnsksQvYNfPeH3rvOLR/q0fnVFtydjzEF//SRR1ta8Pb72ghcjeEnxf9LauTZdRBzxSSljvYCPmqiGdRPdArSedvzUjAqWmZyW59NGxyyIbSkyXZNfKdBjL+k2LpzLDq337CisPxHV2kzQaV6yMXY5i5BmI9uHO44hmAhHiH2mydN9zsW2FnqFrFWBE7HZsalmOdCWtJAQNXO8Mqn6AvxCM2ExLbHfWZcLvnnCgpElRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkMMJIKLLa9scNNNpEqFq8LsXi/MEpLqvzyrhZptJ/I=;
 b=j+peqdTzcfe2sfrFeUewAyh5YRpJmKOR7kb1a2gT9OPpou2BETLlGOYV/m5I31V3r3V0ZOrzSIHG171SupYMUsNKvtureABcjWKgtJyxkxmYtti2IyvjXRi49GjiwhVTCuv+WsyGZ1GkwmD9tk0PUoe8yHWmFrtXlm9+f5K2I5+D6BfubMv8gtkgLunB0M7fC7C6NNx52Ui4PRY80MUNZNGDTDD1ncb3fXCODVRmuNoNa6lPoOxYAISvRGr0k0vGW/wt44hI8ULtCEWk/feahg17WrkyUmsREKibUkGgWpeZcB0m38dZP5k9tYQi+dyI8+P8meSxMLWcGfjYom6mEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkMMJIKLLa9scNNNpEqFq8LsXi/MEpLqvzyrhZptJ/I=;
 b=nXMYgTFXYHosUoQTqEkUndiOdqCcLcUwVuaZAvgrx/g6X5cpPUg4KMlrpOe/BhW12Cn0s/gFlklw7WuMxz4/5FCUS2993Uz4ASk1cMQSgshMngRg4hWfD2ovUFxAZBMmDtgNrfl697ZWk+NIhePyivGtlHYCbGqu/1lJELf/s3gxNNs0+BZvpN3nQtZH7WIJwhJnWSclFut+tREpI5GrRMRcBhyJ3BPRQdiso9fgQVMwf2XfKdvHx5rpKdoxCxpxYCWZNcUUj5ZYPrO7HhBSJYd4DBgX3sTOo3FdWfFx7b0v6OWr8VwoBMe/13MLnKzsmyW0poUSBksv23bGdZJFFQ==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by DU0PR10MB6367.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Sat, 28 Oct
 2023 05:24:58 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6933.024; Sat, 28 Oct 2023
 05:24:58 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     bpf@vger.kernel.org, yonghong.song@linux.dev
Cc:     sinquersw@gmail.com, ast@kernel.org, brauner@kernel.org,
        daniel@iogearbox.net, haoluo@google.com, iii@linux.ibm.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        kuifeng@meta.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mykolal@fb.com, sdf@google.com,
        shuah@kernel.org, song@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Yuran Pereira <yuran.pereira@hotmail.com>
Subject: [PATCH bpf-next v3 1/2] selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter
Date:   Sat, 28 Oct 2023 10:54:13 +0530
Message-ID: <DB3PR10MB6835E9C8DFCA226DD6FEF914E8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1698461732.git.yuran.pereira@hotmail.com>
References: <cover.1698461732.git.yuran.pereira@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [c8mzXXAkR16MnI/vr+kLqDt/5BpbCkl+]
X-ClientProxiedBy: JN3P275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::6)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <602a18b1ff49bb8cc32f0d8de6e4bcaf5d404eed.1698461732.git.yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|DU0PR10MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: e78cc38e-20af-4fd1-9147-08dbd7763a23
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQeBAWUp0JqcYPOoLufCSWKsxkAVX8lGnmAxiLbzYxn/IF5ASdTECN1gxJWGq5EnGEH8Zqmq2vnHVxt+bJlvGaH3aIdkTALnHgonN1BXhENNjkv3nOnIf+bYNGfE7em+h4TbuL+qfs/SAM1bcP8IlpBCN3w/nwunM5D0A9J6X23xUssdA7hSO1EO+WJvC2vrenZizN7dWrqn+29302+/BX3jQ13XBTZ+CZ2CNbPdyC0k1zbuOZn/ob+Zmh+n2ja94w//4s4GimF7Yw03OMOUttLLnjZhglsmv0IEstA+10UQwPUhjJr/DmsmK2qa3/+2xa9+O9aSwqactJWU7wVsn3IL3E5QhU+LD1AvkT3gx41cWyHxoBViugqppQ5YzUBIgjnZLmoTVtWGLAoNThDikFz4fP8FStqlBgXprloF0SlDbCM9Rx31OLu8KqUpTqKJExb8TM6b/eKdsgOJHLHo9yVtC5Mvdnjihog7hCMPUX4oA6u+bMuEicfkL9GP8JAdcJbFztIkwdYj8lNDi7Eqik2gCKpf2SBIXZJVvEz0VOnp7VDbXFt1htIt+uPLpLjFbuT2hyS3V5Bmj4bsLmO6LDwMccALhrfFs6BKFp4lcXSy7nuic7JG/ETcSasfQacp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qSSZSs8EN2DJk27fG0J4ZaLUICdrRYf/e/x/roSrlJiD/OvOXU2mBBLwFI5B?=
 =?us-ascii?Q?i3R01ni6bQJQhyosu1Xe7cprYVZRQRO2AFoPiZqugia8QK4pz0Uz/4l8AfXx?=
 =?us-ascii?Q?e1m3zyTy4AyvH+lSkgr2Q0YhC4ABKvq84vMy+UKxTT+6kJKobYhfZueNdWbI?=
 =?us-ascii?Q?iFumYQmQUF92i/b9UPEniD3mqP5ZAVcBbUnTpzev811WM4zmqrgZUDDkh+4t?=
 =?us-ascii?Q?mtymi96KZa8Rs+m7PXGiPWEuu9l45w/H5qUC+x3LeLshiA0Kvmr7DtoYQh9V?=
 =?us-ascii?Q?7RWCNYJrMBMNnsCvTEeWDM3KaFuCEUyLej87GYsl250v/qfRdR+Y//h5f764?=
 =?us-ascii?Q?fSkSauWouOT+xKwU0+Pn7ZeF5YzdkeePc6BLOOmGTA9A04MozzEwgmMAG+Tu?=
 =?us-ascii?Q?iu4jZVqghKqkQtWgSKb1yxiVeRJE5bCuVClEjSM4dAsruEiTLhITxdXOKPTC?=
 =?us-ascii?Q?F13s41TqcH1IUPVzZt4r3wlk8Yp3/XRo1F7+xMkot4ukapFiQTtZR35QSyoL?=
 =?us-ascii?Q?uMD0DvYZT2FGtEMGc6WtlEVOIKNCwhdPjEI1iBQHjzGN0MTQx+ITsNPZk9WO?=
 =?us-ascii?Q?vRh2v9cNT4PKjZwK4ArXkaQwyW/XvgrundSieOQfafRv+I4jQNihDwMM85qx?=
 =?us-ascii?Q?ACwJywU9wjrid05sftWpcCXNgQF41RtHV9KAeFFbdVrkl9PRKb19ExuQQyfQ?=
 =?us-ascii?Q?ULA+43FdtjRGM4CzoxbjSLaSZW1mOcustleLwQgRO6HCz/iBUKXd2rHMKjRs?=
 =?us-ascii?Q?Gmzq7jYg2FyqZiF6MKBFy/mnuoNst/B7YSD0v4F5eWWnIkVAQtTHiZjUvXWJ?=
 =?us-ascii?Q?YNEqVsnPKmObbDSg5o43RxeQPlOtcW8xK7vs2dmRNIkEEuvameBIuAzRNQ7u?=
 =?us-ascii?Q?NN+aczNfDfkACwzR7h51tbO99T1rAsz/WGxevBqVWeHkDjfvylj1n3gLYZYN?=
 =?us-ascii?Q?J5GrT1xmZXJGReS6Zi1gjB445QKYzKHSwrfmCFdBNcu8yhvsOo7IxYIeNf1Q?=
 =?us-ascii?Q?zriACsZSTj6WnuwPy3Pce4H3rBFjoGUK5BAw7+3KSYDBE7e0CI3mGNbPduvU?=
 =?us-ascii?Q?bvPdeQDMeisQSbNAzboEB6tpq4fIX+54XYVQKYjHJ+GIF68v44liOjinwP47?=
 =?us-ascii?Q?lfr8z4AWv/xB0mg0q+Qc8jJo6NRR6y/p4isSMKhF0kU0q24kSFGUuJn+mzde?=
 =?us-ascii?Q?OO5kPWkgGaEnStlMnH4JzIjYrAtDaixWTonNNvYEiCW13tOHp39FGTY/O7Y?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e78cc38e-20af-4fd1-9147-08dbd7763a23
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 05:24:58.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6367
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
 .../selftests/bpf/prog_tests/bpf_iter.c       | 79 ++++++++-----------
 1 file changed, 35 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 1f02168103dd..123a3502b8f0 100644
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
 
@@ -714,16 +707,14 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 		while ((len = read(iter_fd, buf, expected_read_len)) > 0)
 			total_read_len += len;
 
-		CHECK(len != -1 || errno != E2BIG, "read",
-		      "expected ret -1, errno E2BIG, but get ret %d, error %s\n",
-			  len, strerror(errno));
+		ASSERT_EQ(len, -1, "read");
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
@@ -732,8 +723,7 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 				total_read_len += len;
 		} while (len > 0 || len == -EAGAIN);
 
-		if (CHECK(len < 0, "read", "read failed: %s\n",
-			  strerror(errno)))
+		if (!ASSERT_GE(len, 0, "read"))
 			goto free_buf;
 	}
 
@@ -836,7 +826,7 @@ static void test_bpf_hash_map(void)
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
@@ -917,7 +907,7 @@ static void test_bpf_percpu_hash_map(void)
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
@@ -983,17 +973,14 @@ static void test_bpf_array_map(void)
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
+	if (!ASSERT_EQ(res_first_key, 0, "bpf_seq_write") ||
+			!ASSERT_EQ(res_first_val, first_val, "bpf_seq_write"))
 		goto close_iter;
 
 	if (!ASSERT_EQ(skel->bss->key_sum, expected_key, "key_sum"))
@@ -1092,7 +1079,7 @@ static void test_bpf_percpu_array_map(void)
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
@@ -1131,6 +1118,7 @@ static void test_bpf_sk_storage_delete(void)
 	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (!ASSERT_GE(sock_fd, 0, "socket"))
 		goto out;
+
 	err = bpf_map_update_elem(map_fd, &sock_fd, &val, BPF_NOEXIST);
 	if (!ASSERT_OK(err, "map_update"))
 		goto out;
@@ -1151,14 +1139,19 @@ static void test_bpf_sk_storage_delete(void)
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
-		goto close_iter;
+
+	 /* Note: The following assertions serve to ensure
+	  * the value was deleted. It does so by asserting
+	  * that bpf_map_lookup_elem has failed. This might
+	  * seem counterintuitive at first.
+	  */
+	ASSERT_ERR(err, "bpf_map_lookup_elem");
+	ASSERT_EQ(errno, ENOENT, "bpf_map_lookup_elem");
 
 close_iter:
 	close(iter_fd);
@@ -1203,17 +1196,15 @@ static void test_bpf_sk_storage_get(void)
 	do_dummy_read(skel->progs.fill_socket_owner);
 
 	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
-	if (CHECK(err || val != getpid(), "bpf_map_lookup_elem",
-	    "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
-	    getpid(), val, err))
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem") ||
+			!ASSERT_EQ(val, getpid(), "bpf_map_lookup_elem"))
 		goto close_socket;
 
 	do_dummy_read(skel->progs.negate_socket_local_storage);
 
 	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
-	CHECK(err || val != -getpid(), "bpf_map_lookup_elem",
-	      "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
-	      -getpid(), val, err);
+	ASSERT_OK(err, "bpf_map_lookup_elem");
+	ASSERT_EQ(val, -getpid(), "bpf_map_lookup_elem");
 
 close_socket:
 	close(sock_fd);
@@ -1290,7 +1281,7 @@ static void test_bpf_sk_storage_map(void)
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
-- 
2.25.1

