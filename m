Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695417DA530
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Oct 2023 07:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjJ1FZK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Oct 2023 01:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjJ1FZI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Oct 2023 01:25:08 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2077.outbound.protection.outlook.com [40.92.64.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BDA10A;
        Fri, 27 Oct 2023 22:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cb66q/VcmBHwC5yjQtggg5XnHBL5MSMJUhVMH5aT+C+MHb3GKCCiB4wzchUwzOn0G7JXFLax8xn5NcXXY8xVe02GTNwcc5gZyl0eS9ggaOKRAIf68pcxxlYRL7gdWoHxexHKpHINSedmQ2ew5LsfOsY47qirAgC8bsmQlJiEHoUvWejtWaapwMrmntcCQOmA/c8H9VY/slMWbsYDJq1bo/359y42fYZhDkPN6IyyoNlnYyCWzbuGL4XQzyx54tnvQnqQafqURMNXV2ca2mgCbN41c4yw4Jfhs5C57v6z+wMPojgqOlxYBMEsWLpiBfxL9PeIvowiHe2wRUs9kAotVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0vU6QzwY0KgWTyrQQqWM9stWEifz+KR6QYp41Wr3/w=;
 b=WE2Z0feQkqxi6+kOdFT7TcagHRiQrRdxFWxjciCCi4rkPEtgUuL/fDKGBs6d4mwXSW61yVRWqoDs1khOxArctMpv2D2D+HPAGeA7BV7TSTPFiHa+02BBsoeTzuAobEJ7XBLFDfYmt8WIJ+zQBpCZtkdJciwenVbkuQvDWJKnzEaZMGddw++DzPTCPEbC25loE5LdU0y/KgoUInYzsAa31Cjqbga4l/5ugdomONQz0L/jkgXlbnC2ET4W54iZL5IlZk/5QeEivSHMde7y3nHqCTLPvjODIkZ4mB/y+02pzBoRzPp3VQ2mDaoP9S89QZj9a5Hf1P7ZMnmTxWqUX2EiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0vU6QzwY0KgWTyrQQqWM9stWEifz+KR6QYp41Wr3/w=;
 b=hjPae80bnwFnSF5Roo4ym/Z9+S0O9J0aFtcVMyoSmsaAi+0oLZqRhiTO5s/UjDEf7Juosp3wogtOSPrwuEeB/4BBAIDrNAx1/2ANX4jlml9gfLl9dR746Q1lRPynhpYzZcy7LUhhUhD0pfGSMgJJFP0t8/60fs/aWsJioDaz1ELm7pBGdlVdW+sifh9BFBzssQ5vqJu+yS+Ok9grr3wCjn+f5IfVmCvnN6H9iUu0I/lHsZEzWQbnj3MZ5n4jgJAyHIYHLYfJFCHSjcPKTvWAMGrJaD5Uz80xKt6qzI2X3tTH0TsI54SpC2Z6lGdtvdEV5aoKt5Q9rFrCgx0fSmMd5w==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by DU0PR10MB6367.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Sat, 28 Oct
 2023 05:25:04 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6933.024; Sat, 28 Oct 2023
 05:25:04 +0000
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add malloc failure checks in bpf_iter
Date:   Sat, 28 Oct 2023 10:54:14 +0530
Message-ID: <DB3PR10MB6835F0ECA792265FA41FC39BE8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1698461732.git.yuran.pereira@hotmail.com>
References: <cover.1698461732.git.yuran.pereira@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [bEIWiwKQSCkoEmLKktPbRwGxn5+fMSHi]
X-ClientProxiedBy: JN3P275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::6)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <5f3b9bdf9b22e0b3bfd5e73a0ef15b68db3a381e.1698461732.git.yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|DU0PR10MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb9c629-068e-4bad-937f-08dbd7763d50
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1NgmA2FUg5Tr4C2YXh42Qef/ei7y8PCWjdvVnKgtrbOc13N1p6ZwSn9Rgxzqi4N12/Nk2GUinZu2qtnOXZB3ZK6hNCFbRCt+I4NSBp8EwZ8i/nagu1kDvqRwVRs66/5pRsvN942KEOQH7H4ygMi2BwtVYDXrZrO1H1OOu4h9TsnF14j2j0H2nzQHo/w/pgusUnucESqgzlciydWjZ5QB8/IOnObnoIE6Z4m97Mqhis3MT/ELeSj9oB6ZpsSDAOAHu3soY3NH9TqVWWPjyBFNSMNofb1MfFAt6Vw0Fhum4lJ37yPgmjrhJ2jkOU3yNq6yB+oYtBd7RqoEKw1CX2aZTBHzqRklKW09QiHibkA3BBb1Uf4ilZrzsorxsCxW6P57J2I18ZQ9/+6BdsFxS8yUAz8c8HfPZlzJwviB0w5NzTgjhJgOie3qa0CF6HAddc0hOmC7MCzW+0evJiLbBAv41DsnqAaeGUxmYLE5Is0LMrL5ew3Y1lvc8chmD5oVmEW8+lxLCv1GzabIZdCWVntcCfIEKcBMvyB26FxzBpPzra2TJZGtXnkk2LeeZa30MDMqZfvf+CMmNPwK1fmb2q0q+6BHaIX8EjH8DcBNmqUrX4DnqAG8kN7wDPqjYRRGfGB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GX+9YO9hYVqgbPNybZEr4+PlJnAVmBHWMLr1AKk+lERQiQgIzZMMK77EeTPT?=
 =?us-ascii?Q?pvucvkpdZRosjkKSpOQ3YgELYr01tD0qfJGYdExYGjkcx71Z8I4A86fWO2bh?=
 =?us-ascii?Q?lKoZfuDAXG0PXZh5zo+eS+O6MA5QqAu+Ypkvh64oLaiYTDuC03H5ig4IJmsP?=
 =?us-ascii?Q?BtBKc35dTZ1QIdqd7rnWvPqD+oiCweRmGS9rXJviVl4HCS1cfp9iZzYxkVbs?=
 =?us-ascii?Q?kE8ACoWguWLG/NrkLCdYSp4Bsk2POhOQBuhDQ3vIf8wvMOsbdT6nbxqKPvQw?=
 =?us-ascii?Q?zM846zvaDhzxrJM3p7RAEwtx3d7kKh1eZi36SyTuEgQvL2LTnn8zuv2ke+3+?=
 =?us-ascii?Q?YT1GhtNrIeTghgx7DHkAZmXLBYX5aGItNcSTY4gMX6/rG1B8vB+MyjhKfZiw?=
 =?us-ascii?Q?nl5HPugsjmmwOJMcJz3G10oXoxcVwtfn0mGrQtYm9hDsHY6iKVM/I22Gmdko?=
 =?us-ascii?Q?1RN8zXsUnic3XtgBvhJ2vJEF91J2QD/HuIYx3X+PboeEbJPoj7Ds2M/eDWIr?=
 =?us-ascii?Q?CnQZdOdiT7hIlG9lvVJ7GIAn+Ea2bfVdWt7q+H4OMx7tDFX5pyIAUTjGn2T8?=
 =?us-ascii?Q?L7kMSJ6cUE634KoaZEA4WkCKXhxLQxTXz93qEDQuDGWIIB2tWBhndohrpPgi?=
 =?us-ascii?Q?KqANdT2kRnlIFXu6ndVsPxn0PIcpEytxjdJpkdoFHcU39PPZgyrkMlyXOOoy?=
 =?us-ascii?Q?D1q7xzmsABZbp+jEZkiqYaIU5HTlF11fRU3fX9XJN+oYGfRi8ZwZ4HNX4oOz?=
 =?us-ascii?Q?hb49RZnVU4tuMe2b2N1er1dz4sDPI3gQ7mTuaRjgVpBp3yOENeVZdlLx9BEN?=
 =?us-ascii?Q?PzAFFl91gPFTWHRhMZk6FdiOM2rdtR9TjZH4Y/LnpYdYlaSr2a2EscEFbdHA?=
 =?us-ascii?Q?Wom6dzCPnj1olagFZ+tH3r6rr/S1maLuDVGu7Id8uCP74Q+DqoEVQiy4U6uI?=
 =?us-ascii?Q?/TTS7/5uJhB6OFoIKxF4atvi/YQ4rt8Q5y+tKl/tbJ6uojKW9UjHtuLI8XHc?=
 =?us-ascii?Q?tOQVBsR6EeNJd9QuICwRlSD/xuPl+9ec7+R9t+TuVFFIvSDvjcwF5M29n6+I?=
 =?us-ascii?Q?Zg5Kqgebbcq2k5Irkkq1XQYBHBbSG6tp71KmllGb2Oko6LE6x5Sn8HPPCAfh?=
 =?us-ascii?Q?FITBJkJSz3QfT0GhhGESktpxGMsgOiJB+wCb3j5G/cXJJ/qPMvW/KPS8PJAV?=
 =?us-ascii?Q?rMvdfrAgV3F7vZaIG8ePw0kuETHyWlnBc6a5QZx3JY2IXl8lULEc/mLRIeU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb9c629-068e-4bad-937f-08dbd7763d50
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 05:25:04.0864
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

Since some malloc calls in bpf_iter may at times fail,
this patch adds the appropriate fail checks, and ensures that
any previously allocated resource is appropriately destroyed
before returning the function.

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 123a3502b8f0..1e02d1ba1c18 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -698,7 +698,7 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 		goto free_link;
 
 	buf = malloc(expected_read_len);
-	if (!buf)
+	if (!ASSERT_OK_PTR(buf, "malloc"))
 		goto close_iter;
 
 	/* do read */
@@ -868,6 +868,8 @@ static void test_bpf_percpu_hash_map(void)
 
 	skel->rodata->num_cpus = bpf_num_possible_cpus();
 	val = malloc(8 * bpf_num_possible_cpus());
+	if (!ASSERT_OK_PTR(val, "malloc"))
+		goto out;
 
 	err = bpf_iter_bpf_percpu_hash_map__load(skel);
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_hash_map__load"))
@@ -1044,6 +1046,8 @@ static void test_bpf_percpu_array_map(void)
 
 	skel->rodata->num_cpus = bpf_num_possible_cpus();
 	val = malloc(8 * bpf_num_possible_cpus());
+	if (!ASSERT_OK_PTR(val, "malloc"))
+		goto out;
 
 	err = bpf_iter_bpf_percpu_array_map__load(skel);
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_array_map__load"))
-- 
2.25.1

