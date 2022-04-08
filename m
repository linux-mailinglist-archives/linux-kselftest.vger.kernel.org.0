Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953A34F96D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 15:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiDHNif (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 09:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiDHNie (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 09:38:34 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B211D760E
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649424988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mv9ZtsyTL4eTyuTVOi/hHDsyHVs2Fc09mfLmUojK/LU=;
        b=nQI+fSJF8+LfcjFqmJnSBSIwSNU85+azgXLYyJu4zBfysKjWd158nMb88wr1/sv00oJl28
        vwbypL8Iohjb4FBo2JT/MBryQ1ZvcB/mZyWjVYL5AW+3JzceLoRQN7ouZ7EOPqU8wze7/i
        iTyllXONZgZQaj79jr3T/TmxOJMjPDg=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-2iN7Dl57NOyBcc1clDg5Yw-1; Fri, 08 Apr 2022 15:36:23 +0200
X-MC-Unique: 2iN7Dl57NOyBcc1clDg5Yw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcxJUGKcmEVaTuyxYIBB3cn1jriaj+phBjrdMwpkHLiDddi+/hDOI+gky8y2lX7L0AnhH9aF7XuqJJ7XQUkSueor7qKupQwRVM9CJXmzg04z6FU6qbsF1Owno1aliV1tNPIZ+4mB3OuOgZjNfxCUX8kzFdgL2TGftSZSeHYizZn7kjUfnVq935zw1EAsXVJKFaIK7AZM9FUxeJikZZWYNh2IprPV71Q+6BfNKW6rSUGy9hX76tCAzIGXH+YVaxE5nx+nd4mSBNew0AFmZjEEB3NhnfhFTEooj5VJi8jELputYwq8WiuPehk56IKFtZ3jZH8Nigc+fOuXeICPEosJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE3wGDfK9cEpoGNGy9nW5e859E7jqC6Y5KVKakYH5pg=;
 b=KI6Iz5GVfwPG7vAqFmB0HmnyxvTKyCFEkAic27aeQeedt+y2XDtZflAFqbqwak/lUVLhqpxBj/i8SX6pNcN1ay0Os/Jlg6CTh4mkme+aexXNVgmV7audyOguEtRX3mp3NLm5Oc9kGPGCyO39i9rI8j6OGManw9Rjkob6ILzlmLDzpkz6petUY6DYgOLP1x0uX9xM++Z/g4iUts+pkh9fFQgJ6TqWJGMDsAeh8smcEEzxpa9l+tC0/tFY6ngutwdvr/3FYkEvA964sm7wnTZ/ng00Jz3uK1LlUpU+xpCOaYoRG8LAV87V1vsaImEC+VYCCo3jb48Ke/pFuTxo0/BDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 13:36:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 13:36:22 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
CC:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/2] selftests: bpf: drop duplicate max/min definitions
Date:   Fri,  8 Apr 2022 21:36:23 +0800
Message-ID: <0efb81dab7a8de23044302c5c7fa9af308766236.1649424565.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649424565.git.geliang.tang@suse.com>
References: <cover.1649424565.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8a13b46-4fe1-42a7-0f7a-08da1964c55f
X-MS-TrafficTypeDiagnostic: AS8PR04MB7766:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB7766C35CA5F7E66B1FE712CEF8E99@AS8PR04MB7766.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wT80ZpHEsE71MhcO4UnTwHS26ZD3m7FZu+vGt3U/MamH3lkTybTbGEVb6HwMrkkJ4tyb3q5Fk5BXb0TiAPMyg1RGlGvxmDvXWzHISFRhuT6ausjwGyQNLDRcJknnpZp1lWQLhx+AadzNBSmew8l0E+bCBH0vSjLVUd3ur3itcmzdch1sjUrcM4cCcM52+hXDYNS3lXyIf9W2rABUOg42F/At7kI6JlKOOXhYwLDJucP/axQmhfk6vUsiB3+3TZirdYyDGPm8wA049LcEKtmJHiQgK07170VHWDQjs4mR+ePQ343nYWfVtr9z4U3VNc2GikXLBpiM46k5EbEHoN1hrjBpFolk6jzrBAdxpRJo3bd1kK/FD++IhG+nyLlvRf4iVmg12yIlYMgMbgMcrdG2DaO+Hy59PlT9Oqj4GVNpFt4CHzlA+7Dx9p1X7hwhYrhXQ/G5ARxgyF5p3zPbe/62bDOkXRumz1h2wOIHhecu4K8jqY4/szd4vtlwfslMWj5a6xvNvg45zAgdw1B7u/86Uk9BLgsejsNjT8Dx1KmVrVNMynuWTooz7+EJ6GqSJRzkiH6ubz26ON2VD/80BirrnPS9Ra/V/tgB5r2IYmaM7p7gQTLpW1ywUaj7upM8RN+vFcndfdASO7xG03mcJUzYaD94UVD9wqXESYoteEuf6kfbk4lqJdsh/gqM0WMoqhHl165vLle25awcAvrijOIJQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(4326008)(8676002)(66946007)(66556008)(66476007)(5660300002)(7416002)(26005)(316002)(110136005)(36756003)(508600001)(186003)(6486002)(2616005)(6512007)(6506007)(2906002)(8936002)(86362001)(44832011)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m8ce/JnKDsR/c8U7OS01VkbK/l79qjjRruIymajYQ40mMnnhNGTcM0yMYZoL?=
 =?us-ascii?Q?sT+f2U4ROG43KEqhiqRdrM4FwQLNP8raGB2/0Abh1i0JmhNDUbBObMSGfZ4V?=
 =?us-ascii?Q?71eB3ll6CLkWAPLirdwrA0eh6WuiDsZQBYj2el/BwohACoxYja5oSL/+ERQl?=
 =?us-ascii?Q?1q26R3EyGhxlCuXI9TbfwRuLGVKALX/qBSeXxHuE7+5856wluqWHVMBFGC82?=
 =?us-ascii?Q?sJGdwUuY6lvTUm6liqQFljO9SLDsR4VJkiHAQFS2+fhLevsw4pFCaVrSpeAR?=
 =?us-ascii?Q?KWEQgXQnVKPxp11plN/+ozBvzFl9rq9sRO5D9tjexWOWJHtSC3QbgY7ogwyb?=
 =?us-ascii?Q?eNM+enB+R+Bny/3tBIZ7yZ96dmN2hUiiGEiVmkpbKJobMQA+I+gVHtz6lmrk?=
 =?us-ascii?Q?Md7h1bcaY8CpaIZoqR/+nf4/kU/4t8nvMvUM/yPwLhD5ofnLHn8e82SOT4HG?=
 =?us-ascii?Q?5zlN1/nM/Ei2qzzxX+v69sZoRlk2xYNyB0RgR8hIKX2J3tAFv4ZVdjiX6vEj?=
 =?us-ascii?Q?keOs9Ua1dYegoA03R2B6jczV3geWowkV+a0C//G4mkJNhrpgtW03cvQHv4XN?=
 =?us-ascii?Q?WUCNMLI/I541SmGXxJdzlvcUJDMjGxcRkTdCfaZ30qpo9DEwpHH3Ql7YIwvs?=
 =?us-ascii?Q?ibS26AfcmYbSNaxXOgWVoo+82Gj/Y2ti9q5DQFNhJ721wDzDATUGVRYGO8PW?=
 =?us-ascii?Q?op5cW9yQjkk9Rd6dK4X653FV8XofMiOm8V8NZVQqKjulv7rGKwiZVn2GtE+k?=
 =?us-ascii?Q?3oHEVImOHs+XjNxdJJLMnSZZ3M6RZ9oPFziLttK4OqnWnSJ3fKUY+NdKLrmk?=
 =?us-ascii?Q?CYGvEY+6zcw/hJq8IG9jMSvin+NoqLFcZb9bo6iL3QWXBR1w3fjig+MBCBVt?=
 =?us-ascii?Q?auwpTXae1ujaw5S4yF9ddZGpW/d1zYgTiNFBkpC3l5y+wCKT4mk/4SgQnFoQ?=
 =?us-ascii?Q?V95pqIraGZtSS22+TMJHSAzBwl43A+2zabhqbvoJt6ZgSNjbgHAGWDP9MCIM?=
 =?us-ascii?Q?U/PEVOUhnxmHESFADP13rKQNinDbGeFhVkdretAKNeqAp0YsZ/jCZvzq7WOA?=
 =?us-ascii?Q?nI8mQMvdKzcrnUitm7D3odSk3i4f64fyRi3+cK9lj3bI+vn5xTfzmcHqYztj?=
 =?us-ascii?Q?OY3Z33g7ScQt9ejIZuUFBSEv6pjxhLodoTyAim88Nw2S0miyQ8gYcBE8WQmv?=
 =?us-ascii?Q?nxezv3T+twPSJTCCVTkF5OtoO2fQh+SMcmth2BXH32wwJfB4uKq918vRqx9k?=
 =?us-ascii?Q?J8Ii1Kvu9H4k7JFqsR0bP09fV6mzBfn/R9fcQNVY1U3ylOu+wkKjIZ+84rJE?=
 =?us-ascii?Q?xGvfVFogxLHF2wttlMn9QPCTrgS0yEunSmoh4Vkt1sxnGqwSyHWEbUsdH9uV?=
 =?us-ascii?Q?s93YB38AoLVW3RUAir634xxRJ6VhS9egelyg27FpaHvgFTLYywmtyMm8T7RU?=
 =?us-ascii?Q?ttv6/Vj8YpNF3Zjat5CThl9CbgSxuxWCpVQu1hla9IpX5Ak0gSXJbQnylR+B?=
 =?us-ascii?Q?9nJyk5eHwS9QF9pQOQJQFEpQYSSvnXWjBw/yRnrNSyarjkyzZjwYRmvS801G?=
 =?us-ascii?Q?QDyI1SwJWQ53W2sS2QAxslSzSIyDR0C8Ultl0S2+/8guDaVFr7aG2Y0rp0tx?=
 =?us-ascii?Q?I1z6wIaspgieNcDrTrLOnIA+j7m+7bLI5yNKXYbcIz4+KP+eZKJbrF/b2QqQ?=
 =?us-ascii?Q?bCbxBBFfd6YeFlKXhxXhsplqTrwJfFAI+72sMe+0orbtub94v1Qgyhi60vZb?=
 =?us-ascii?Q?Njn07QwJhmYiILf2arHW/XUIkbwYH14=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a13b46-4fe1-42a7-0f7a-08da1964c55f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 13:36:22.8392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIAy2xWT/zhPnKQmHNgOwGFl07G5XvCs0Vb73vFA3uawbDoixEqbqr5pIW0wzaHaazc1RHLPVPUuQMmOsWIt6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Drop duplicate macros min() and MAX() definitions in prog_tests, use MIN()
or MAX() in sys/param.h instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c    | 5 ++---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  | 7 +++----
 tools/testing/selftests/bpf/prog_tests/snprintf.c    | 5 ++---
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 2 +-
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/test=
ing/selftests/bpf/prog_tests/bpf_iter.c
index 5142a7d130b2..86561c0b0dea 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
+#include <sys/param.h>
 #include <test_progs.h>
 #include "bpf_iter_ipv6_route.skel.h"
 #include "bpf_iter_netlink.skel.h"
@@ -1192,8 +1193,6 @@ static void str_strip_first_line(char *str)
 	*dst =3D '\0';
 }
=20
-#define min(a, b) ((a) < (b) ? (a) : (b))
-
 static void test_task_vma(void)
 {
 	int err, iter_fd =3D -1, proc_maps_fd =3D -1;
@@ -1229,7 +1228,7 @@ static void test_task_vma(void)
 	len =3D 0;
 	while (len < CMP_BUFFER_SIZE) {
 		err =3D read_fd_into_buffer(iter_fd, task_vma_output + len,
-					  min(read_size, CMP_BUFFER_SIZE - len));
+					  MIN(read_size, CMP_BUFFER_SIZE - len));
 		if (!err)
 			break;
 		if (CHECK(err < 0, "read_iter_fd", "read_iter_fd failed\n"))
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 8f7a1cef7d87..ceed369361fc 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -3,6 +3,7 @@
=20
 #include <linux/err.h>
 #include <netinet/tcp.h>
+#include <sys/param.h>
 #include <test_progs.h>
 #include "network_helpers.h"
 #include "bpf_dctcp.skel.h"
@@ -10,8 +11,6 @@
 #include "bpf_tcp_nogpl.skel.h"
 #include "bpf_dctcp_release.skel.h"
=20
-#define min(a, b) ((a) < (b) ? (a) : (b))
-
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
 #endif
@@ -53,7 +52,7 @@ static void *server(void *arg)
=20
 	while (bytes < total_bytes && !READ_ONCE(stop)) {
 		nr_sent =3D send(fd, &batch,
-			       min(total_bytes - bytes, sizeof(batch)), 0);
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
 		if (nr_sent =3D=3D -1 && errno =3D=3D EINTR)
 			continue;
 		if (nr_sent =3D=3D -1) {
@@ -146,7 +145,7 @@ static void do_test(const char *tcp_ca, const struct bp=
f_map *sk_stg_map)
 	/* recv total_bytes */
 	while (bytes < total_bytes && !READ_ONCE(stop)) {
 		nr_recv =3D recv(fd, &batch,
-			       min(total_bytes - bytes, sizeof(batch)), 0);
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
 		if (nr_recv =3D=3D -1 && errno =3D=3D EINTR)
 			continue;
 		if (nr_recv =3D=3D -1)
diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/test=
ing/selftests/bpf/prog_tests/snprintf.c
index 394ebfc3bbf3..5ca70aa15c4a 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Google LLC. */
=20
+#include <sys/param.h>
 #include <test_progs.h>
 #include "test_snprintf.skel.h"
 #include "test_snprintf_single.skel.h"
@@ -83,8 +84,6 @@ static void test_snprintf_positive(void)
 	test_snprintf__destroy(skel);
 }
=20
-#define min(a, b) ((a) < (b) ? (a) : (b))
-
 /* Loads an eBPF object calling bpf_snprintf with up to 10 characters of f=
mt */
 static int load_single_snprintf(char *fmt)
 {
@@ -95,7 +94,7 @@ static int load_single_snprintf(char *fmt)
 	if (!skel)
 		return -EINVAL;
=20
-	memcpy(skel->rodata->fmt, fmt, min(strlen(fmt) + 1, 10));
+	memcpy(skel->rodata->fmt, fmt, MIN(strlen(fmt) + 1, 10));
=20
 	ret =3D test_snprintf_single__load(skel);
 	test_snprintf_single__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/t=
esting/selftests/bpf/prog_tests/tc_redirect.c
index 7ad66a247c02..52f1b9139145 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -20,6 +20,7 @@
 #include <stdbool.h>
 #include <stdio.h>
 #include <sys/stat.h>
+#include <sys/param.h>
 #include <unistd.h>
=20
 #include "test_progs.h"
@@ -949,7 +950,6 @@ static int tun_open(char *name)
 	return -1;
 }
=20
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
 enum {
 	SRC_TO_TARGET =3D 0,
 	TARGET_TO_SRC =3D 1,
--=20
2.34.1

