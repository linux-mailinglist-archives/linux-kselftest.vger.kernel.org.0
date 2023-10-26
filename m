Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB06B7D7AA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 04:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjJZCFj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 22:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjJZCFh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 22:05:37 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2029.outbound.protection.outlook.com [40.92.90.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78470128;
        Wed, 25 Oct 2023 19:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB3ICKE3n2PYZ5vD5Vu0F/r7sgLXP1a+oSdzm+usWnxy7ownEXNxIVybYacpsTEGcydXntBMF+W0p2kXxojQJkRU1O1/hhCmWyFz5fHu664Qr+ANjwOlOTLKQPDiATZDDjXWAiu0GcXIUYhaI8nHwKA0xx08MIGrw+USIl+hHLqQVVPqXuwZGar/F43z/bb2Bk21dLkoETvtchTlJnTW5AfThEvhKb9yeVLtivj0nWt2NLZp+Ep7RHm6mWhNh0wv5dhVe/7Fe5C2URogaBZWt5iby3lrbtUrkBUUx20+C8aTrFWeeIQ3wepufPmPA4VvubJe1wKMg75YwIUuriKeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuOC9d47EIUROiSqH9ZUb+gvxWoQoawXTbtATfZaxSM=;
 b=mE1hJjOL10NElZxgRSLS2OLnP3rXJ1643JVEQX3U+uBaa8k91DCTdzJgso+ooizTiYiINb78C2/ZfeQVFcBNTscclNr1EYJ2y2uIq0rGAEqC6DTzFgR7UxicISotdUnoAWgYgYuRVlhPSdmrcGK4zHkP3Emx+NV/vbxNyIyezqKPI/QjYEJzbISNSa38+het+QNzz8xrSdBdgrefWWcM8SycDhpffhY/E8z22I+V9AaCe18F4TTBMMKEP6JbevHaG/g8UKrSeWbgjV+p5E3pUQrxMbQ0EWPJcTzhXhz2OOJh2e4jDyn025puDOWh7e9YwO/5AhY2jW4FWxT6KsgSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuOC9d47EIUROiSqH9ZUb+gvxWoQoawXTbtATfZaxSM=;
 b=hvrCpZweczTmKY3QowQtcd3eeKGxe3ta/fTHQNuFWONKWCZOmAX7jjF+CJIcVFV34Qrwj63coChgMBnNtwvFvAWE2DfrTsAlfo6pNQ4eY+Q0KYoe0uecr3bwsuTdpdM880eTX/gKhLm35VI56D05PSMnz6f9ELz5wwgJTeI8olX3TQ6qw6iqLCyn2juBCMf2rj3zwgzBCRI9PM4ssAJvLM0sN+bG+jU0Jk3kd6RYHBAQIGeKDO0t03rqHNZUTqH/+OBQvXqaIxSq/bLVeR7Tij2eR0bTgVaTF1MjCcAI8btM08Ss0C0TnFMFoPCKEvv97OkzqKmt0OPbZ+gkUhdQrA==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by AS2PR10MB7048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:594::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 02:05:33 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 02:05:33 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     bpf@vger.kernel.org, yonghong.song@linux.dev
Cc:     sinquersw@gmail.com, shuah@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, brauner@kernel.org,
        iii@linux.ibm.com, kuifeng@meta.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuran Pereira <yuran.pereira@hotmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add malloc failure checks in bpf_iter
Date:   Thu, 26 Oct 2023 07:33:19 +0530
Message-ID: <DB3PR10MB6835A2CBEE0EBE31D07FABFAE8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026020319.1203600-1-yuran.pereira@hotmail.com>
References: <20231026020319.1203600-1-yuran.pereira@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [nZq1co6/wJDLv1LDM6kdGBNx/B4YXE1x]
X-ClientProxiedBy: JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231026020319.1203600-3-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|AS2PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 162a7a00-ad4b-4418-d38f-08dbd5c80941
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZGrevnPyfl5N+f4z5+KfN7ruPEltQYUL79xpX0rJpAB8TGQ76AWrK4ZBoX5wuiXy9vqQ7UHar722yN61+IMwxOKbbRNdOSC2UqnFZmow8lj/FmbmPZfSko4VJljTfumo+ZtGUFdhXIgF/7L2+Ji8f7zYQRcdJjRocAFaylKg39C7l0V6nca8jq6ML7C18zFS7mJFh+6pBDI4FTz+HUxyXZerNmlTzW4JByTEeQz+f60vBRBkip76UReE+WSvFJsgc6AU2cgYLdY1ZaUkKoKBOARxIrmiVx2flRPQAvILZCwJ32W3gSJiBoJyiBYCVBMm0Qlb9Abftv5w7KczuVhqU3XC3VSGGPDORc1DwpfFGW89QOHyAAO5pHr0fqIVilrkrLxPeqDe+myWyrC7cP6GQdFXKmdIwUS7asx+PojQCy0SMtlkLxIk14gTCLs9r5LgUmw3iUHetCQUH+7pEtx9gscBGgZ3WqnUSDhyaY8SE59RacGkEEGHDziPJuNSOtwPZe3FEXD0zO3LA+DU2CLQIfYmJkV6iEco2GdYPDJmaQgYjGZTPVcCFIxeaJvEoKch6uOFHbxeC8Ze/I0ERmQpbSrqd6cdJyG3diWkxAzcK8DYDwxzh0uwkFyBoTLTD6k
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ng1RoVViVSSIGz9v9rxWeddrqQZTd074SxDJwqAlI02wnutFr9A6wo9Do+Al?=
 =?us-ascii?Q?aipZvF0od9Lsna4oWDoWyuR3xPS2h0cAxvu31uyl766poLqLXiwFNaLl2eNq?=
 =?us-ascii?Q?dCXLJb7oMCcBQhlFIlLtUhXiU+H8UdMqhyuFX6x4QMla6yV+OXpi02KmeJrr?=
 =?us-ascii?Q?VGGe4+UmayOY4G7iHcpuDj2yQ/FEchRoXsz8nFUy5JQXGzbixUZpuyCTenXH?=
 =?us-ascii?Q?Nwnw4Wkp5YKU3HpF+GGhbA4etXRmOmrWEEg6ycR69Ci+XLUJjyv2Knwv9amS?=
 =?us-ascii?Q?6S1//Ff1KV9/BJBkKcpEyKJekd9VHS3yeuu3mherQgXaWcXlMYzp3X0GvDs/?=
 =?us-ascii?Q?HjALR6eRMyf5nz2kIZz4xB9rnLMFoZ61Qk6htyDKABsLth3Q+X8o27/20PrU?=
 =?us-ascii?Q?iAV/wLLEkE11lbjn7yY1HhRPjMahA0Q7eiudIok1cN+nU6nnul3niFti2ERY?=
 =?us-ascii?Q?9bzZmxeXR4FXTMMNR1Mz053EH4FdTCO2AOMFlun5Lz/r+tILx7ZzeglKdIbR?=
 =?us-ascii?Q?7Lgd8ZXqZLewryK1qRuhmm7+Ta9GEQkoCWAuXld6Hszk5638Dph9yCO7/9hS?=
 =?us-ascii?Q?JI6XJNnVw1VR7zEnfyzQOvNCSI2mPOdicSa5euxyOAbYsBUZK+jyaJt2w+bQ?=
 =?us-ascii?Q?6dwT0e+td4NcIkTRWJdrHUX2b367/0/8J4O9MkyEtq+EwRM5a4HduT2GdMW5?=
 =?us-ascii?Q?TPmwGILyeWhRphJOWOF55DNKF4UztAklqgfHmqWxTjhgn9DgTqJwxd5AwEzu?=
 =?us-ascii?Q?CCxBJPQuq3m9Htyy6FVhBwpZDzNQftNBpw4y2SHqVkc+BhsPlMo+eFpFXM/l?=
 =?us-ascii?Q?VYzUVWy3y4a2YtvEe1+5VA9fUZ+J8dorrJgglQEvUNZ67yayZBgrk8XktXpC?=
 =?us-ascii?Q?hhzL2katSlbDMxn57roxohD9JGhqikLjfM0M/DP6dxNppPZoZxKuefQOTb54?=
 =?us-ascii?Q?1GeJgqiclfWCF3QwPyr4uOOFudUewJ84TB386NSrA0qKnwd4u34C4mzLmakA?=
 =?us-ascii?Q?mHgKzcv18FCJ7K87hxjRQbo7rwLlOcj1TiLvvE5lXvYXEn2+C6Kz4mqw2yvj?=
 =?us-ascii?Q?hzNo66TzpbD94nvlQOW7fzzkfNPJEmNM7SN4/Hy17PBXAdNJh/z4QiEDpGGB?=
 =?us-ascii?Q?IRicfxYW8FLlv7hxE3wsrZkIMATQrGBvCh6uH2daRN0k8k2oZlTzD4JDi67o?=
 =?us-ascii?Q?Av0XyEDbFuOMFqJewmDXZGGf/2Qf810jvUFkYbSmTGJUT5EqGuxtTKQA1Lo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 162a7a00-ad4b-4418-d38f-08dbd5c80941
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 02:05:33.1714
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

Since some malloc calls in bpf_iter may at times fail,
this patch adds the appropriate fail checks, and ensures that
any previously allocated resource is appropriately destroyed
before returning the function.

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 7db6972ed952..955d374ba656 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -698,7 +698,7 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 		goto free_link;
 
 	buf = malloc(expected_read_len);
-	if (!buf)
+	if (!ASSERT_OK_PTR(buf, "malloc"))
 		goto close_iter;
 
 	/* do read */
@@ -869,6 +869,8 @@ static void test_bpf_percpu_hash_map(void)
 
 	skel->rodata->num_cpus = bpf_num_possible_cpus();
 	val = malloc(8 * bpf_num_possible_cpus());
+	if (!ASSERT_OK_PTR(val, "malloc"))
+		goto out;
 
 	err = bpf_iter_bpf_percpu_hash_map__load(skel);
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_hash_map__load"))
@@ -1046,6 +1048,8 @@ static void test_bpf_percpu_array_map(void)
 
 	skel->rodata->num_cpus = bpf_num_possible_cpus();
 	val = malloc(8 * bpf_num_possible_cpus());
+	if (!ASSERT_OK_PTR(val, "malloc"))
+		goto out;
 
 	err = bpf_iter_bpf_percpu_array_map__load(skel);
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_array_map__load"))
-- 
2.25.1

