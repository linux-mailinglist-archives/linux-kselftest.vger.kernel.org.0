Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5F84FA055
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Apr 2022 01:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiDIAAk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 20:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiDIAAj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 20:00:39 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3262C105
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649462312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqM2OvyuADdY6McndBW+ZsooHSmnM9esxu/OrxiyYFc=;
        b=ONt5eWjMQksjV+yS/8b4o8mZbOtqe6t3GlccHfvZH+W4t1MKsI5ihkj7CYiHea2W86EMyl
        9LJKrBQeJzE8/l9bJzNSjuTazmLyGloL9wZDETcHqyKvo9Hmf3bVDGd94cBa+QZyyLFhms
        tQqHijBkieO4jak4j+alc+st2GKS0HI=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-RtOkO6wxOsG1iWJDGzPaNw-2; Sat, 09 Apr 2022 01:58:29 +0200
X-MC-Unique: RtOkO6wxOsG1iWJDGzPaNw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAcIIIzbM3hWvJNgsEefl1pcImiW3cxSnMefIh1/LKwKieAT1fvqQTsXF7LXU/tgDbUPLol26Uw1WsQrrrVWb2W2JPGxjaiWe+fyNuvoExY7XyYZ/IiGgZx8oA2Shgxgj9jCFlaPKYUrVv2lbq3NDZkDE/9E4IIyYmMqE0DV7xEgR9aOQke/KQkq8X4bjKq3jh0SP2VoMmiIqM0wDV+KqynD7wOKp88cTOZMnqLiMmCkXS9vo/OY0H0XleV/FeS/ha2a9+kuDjRVEMz2KJVZx1RxmrrkJnZ6PCZFJoJoUo+empoRS6taAwXOE6DUBXxCvvglxyeHRoEWxDINMDzKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyOP5smgO9uVD+ZjgNN+xB0ewJASClkyLYGmjNwtjZs=;
 b=ah22EtRGhb4WiqjCjWab1f69OwBTQTJN04KJxJaHe0pA6cW2/iw0AbC8KB5/pHkHHHaX/2xCf324jwVUCwq/8eZu/S2Nr4fYI8mYtvUHRaMTmJLiUIH9ZyIwXv2ZtPkqwXu1XIFFc9DkTG4vbWAGzxffJUjwuMy7tHk2o/+w44M7jd8zgCozSMK53gXbCeHUYrb284+jkwYgGC4Ymya57j401D95GByDLOvmtRO0u+MYsg/jj89CYUalaewBGawnlMxZLQj27Rzin5+Mbc+4JIG7zpCSha5EDDBF6ALEC/YNGxgrb+VgSrUZL9gazvpNHaQrz3Sxrd+tI/6/VeT6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4430.eurprd04.prod.outlook.com (2603:10a6:803:65::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 23:58:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 23:58:27 +0000
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
Subject: [PATCH v3 1/2] selftests: bpf: drop duplicate max/min definitions
Date:   Sat,  9 Apr 2022 07:58:17 +0800
Message-ID: <1ae276da9925c2de59b5bdc93b693b4c243e692e.1649462033.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649462033.git.geliang.tang@suse.com>
References: <cover.1649462033.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:404:14::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3dfeba1-54f8-48eb-1282-08da19bbac60
X-MS-TrafficTypeDiagnostic: VI1PR04MB4430:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB44306724CC6BEA3EC33F768BF8E99@VI1PR04MB4430.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2FMU6DVqsw7GbJrRRS47p/jsFFklSZpkfj1q1r0S19IUvrYWqwwyvSCLZk0RgxNhvyXnWZGcSYFSsIYq6oC2HFGmou74t5j2pjiNyW8D925KzSLvoXvoA7OLsPkVsA+dmyEu4slOV3ydcO4eHUI9RaOPCqEhf7CHAN4U5vi1spnHgv381729cChwA0a8y/1xlFV/6E8JTsJSY9Y11VDBvDw4ogSlpK+OqoWnEhgDznGwoRCblXoHD0gJlJgjZna7KpfKpgr7d7UoLsc9q03+QkQpG3rk09iIjyt2tDcpVbHOth9ntR+U5R9S3elrYfRa9NcgvvNdDxUqVjmY72D3ykbrCAX7ruyoTL0yQ5GhpfhaXnEzAy/gaCc0YNcJTUa7ykhm62PZEygpHCGHXkUJoCvrNn3wUov4/fx/xgnsuJ/+rDnsxfMjOfGTSFKrW1iNp5QQzrAYrsNrPx+mY+StydAzu5h8vkYJt1rRPpt7vYwz/+fmPU9QddedtnbNIuyVi0jsIyKdikY1BQcGY6ySQDGPzpaUVaK8DyO1pBWTWQhA+l0HdLCc2FEq++tKY5WB1Cq+TUDQpItzlR2PelaLerCUzae1HIBu3QSFZ375QT6SvzBJRSn6TIkC7JB3qmWxrQ7+y/3Qj9pPT2DJ22Db9QPaRrQZ3nIh7uZHQJM1HWwZ1QWEc/PbLq1kKxW5KZ0/Qknfc1D9BcxcPmW+Y5HMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(83380400001)(36756003)(6512007)(2906002)(2616005)(7416002)(4326008)(6506007)(6666004)(110136005)(66946007)(316002)(44832011)(8676002)(38100700002)(5660300002)(86362001)(66476007)(66556008)(508600001)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zc/CgtBJfBqFb4vlYlNIuKdNAYYnnWqaiRK6ipxjlYZ1IapkGMdKbOnxsKY6?=
 =?us-ascii?Q?ut+8dBgfGIVOUl2gJBhXdrir2nHel9ug6Ls8tihD8QTAqSdTd2c0qoz0yQe6?=
 =?us-ascii?Q?CzVJXdTpDq9MxgAIyL/LhSoyCPtf9cP17lqPYX6guqpgFEI6uUhxVnhL/42K?=
 =?us-ascii?Q?WOXvBxNnTsNl8L2r2Ks83E38ptAWY1MI8/uNEN2i6v3WC1dKGFeige5U0437?=
 =?us-ascii?Q?u+3AnoacusrAU8GPA+Qs+/G8hcytWmXHaHe7jssG4Pyhdw6S2KBeGXlS0j2N?=
 =?us-ascii?Q?D0+OmJNtlmsBZ6nNPwse+BMzoBNamhKLmBV1Dy8Ny8lMPDd7qkn2iYmwIyai?=
 =?us-ascii?Q?D9eKhgsVhTcXQD+vO3qTSPPr6dCvg3vo3n46C7xYOW21Ue4iJq8OwN3+hTWN?=
 =?us-ascii?Q?G3sJrDvTTcx3AJ5xQSPVXTH5EKZQOO4ms1YabQucdJ6B9YlHm+l5uHQOczBY?=
 =?us-ascii?Q?42C9z75Bku4uHt9b29ayloAul3r11qDFPYonUibhMLG1m2TK2EHMq4bjeEnt?=
 =?us-ascii?Q?+hwSPT+bMdSgAe1wQTNdDDfG2np7oYshmMrW0cYL2ERChmbCOyuhPAdViJYV?=
 =?us-ascii?Q?mCZL/2oS8zuCM0FcTCdPw7aIrYBy/+WpgTPKnL4NRmV8lXv4HethQ1yptvsP?=
 =?us-ascii?Q?YNYz2U1OLyDGkSr0Y6IimqLf1CWz+QF0kMLX/+/8dlkb6Sk9gmvB9rwoyC5L?=
 =?us-ascii?Q?p58wtzZK6XLnKgT6S8hB5ChOBBFyBtw6MOH/xUktHA2atSr8V8nEsEJ2sGoA?=
 =?us-ascii?Q?jNgsABL4cbJDxHzIKWHZ96yTsLuXVPFoNhZ7PW8eQCiTH+MKUBS+zaHHLDoh?=
 =?us-ascii?Q?KI1Ome7hPi9jI87zPGsCteWzA0yEsrBeOnhqMDS8Uk7qGCFYDNOje0GFgplZ?=
 =?us-ascii?Q?sZqAB2jLyVOpDecjZ6qFegI876pRU/dKUwVLbftLcvmtrWnjy1rjGlzaqbhv?=
 =?us-ascii?Q?EUpO5K0ebhM9x7NkthT44GV5jVz2mr++83/rMu3tA2STPsFPt6q5/F131ob+?=
 =?us-ascii?Q?99nTsKGOlpa0f5FqDTcWTMpSvuvjv740FzpNCCBNH2t5SL/p/vg7kr09SPxU?=
 =?us-ascii?Q?ook/DN6+D7Xj8Q5Zq+shdPzN+pDhLSQrrxlwgSBNLT8ailhn+c0izTyj6Djz?=
 =?us-ascii?Q?bjLp6A/JebOL5tE1UBjVuIgCMHNmxKGiz7lsqbgCy+rGkHlKeJzrsPxaz1J6?=
 =?us-ascii?Q?UwDWLsKa5O0CsKT3w5ISJrnkUqypyFXvL9ztWad4nP3xTS61xoUP6onVwBp5?=
 =?us-ascii?Q?u+iPWxJQ0tAwVzSKSWoqsNb7CyalqgAFxxzUlTK/j6B8vhN7mGAo3U3RFfO+?=
 =?us-ascii?Q?neXnk5BzXDNjaaM+YsTNGd0fa643yi8aQddYIF2SPTIfyqUqsRsj9o4MDJL6?=
 =?us-ascii?Q?1NplLZurTSPKsiBxw/EijerZEVAjeDNvJp7HgVUloBgvN+QBYGmbOWEJD/rN?=
 =?us-ascii?Q?rzmNEAfcHXgLxeIVRSxEc3I62GIxsKYHVs0TeyzvccfOExOuslX7f1DWq0Z8?=
 =?us-ascii?Q?ZaDAbdVrtnPBrYUln4u2w0SHLMLpPLVg0GUtElbegRwauzWfiPLPyUFqZER3?=
 =?us-ascii?Q?9XmswYZFmPt3oldrJdxJhlcCP5ap2XLjga7fo/qHB2sRZkSeDEA6gf0qTkfa?=
 =?us-ascii?Q?ITxOpzP72dbGvaKcyxauAqCoudCDDQStFzHgAV4z1Sv++epmlmLIizECmtcI?=
 =?us-ascii?Q?PjbCfqw7sgeUclwnuGNlkE+Q4tBR+x4YfQJCAvJ1ifQk045CpZ32kowjdU+O?=
 =?us-ascii?Q?k8XcxqUYxH5x6TqiwcI6ji+eVkRdWGs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3dfeba1-54f8-48eb-1282-08da19bbac60
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 23:58:27.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nT+eNX8ud/HlEuzOxbfNA3S42PLiLl4Kf4mvrx7y8mneHAIiY5315h+SmiXx/RcwsBKAF/g4wpziWga3wd3qyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4430
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Drop duplicate macros min() and MAX() definitions in prog_tests, use MIN()
or MAX() in sys/param.h instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c    | 4 +---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  | 6 ++----
 tools/testing/selftests/bpf/prog_tests/snprintf.c    | 4 +---
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 1 -
 tools/testing/selftests/bpf/test_progs.h             | 1 +
 5 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/test=
ing/selftests/bpf/prog_tests/bpf_iter.c
index 5142a7d130b2..2c403ddc8076 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1192,8 +1192,6 @@ static void str_strip_first_line(char *str)
 	*dst =3D '\0';
 }
=20
-#define min(a, b) ((a) < (b) ? (a) : (b))
-
 static void test_task_vma(void)
 {
 	int err, iter_fd =3D -1, proc_maps_fd =3D -1;
@@ -1229,7 +1227,7 @@ static void test_task_vma(void)
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
index 8f7a1cef7d87..e9a9a31b2ffe 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -10,8 +10,6 @@
 #include "bpf_tcp_nogpl.skel.h"
 #include "bpf_dctcp_release.skel.h"
=20
-#define min(a, b) ((a) < (b) ? (a) : (b))
-
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
 #endif
@@ -53,7 +51,7 @@ static void *server(void *arg)
=20
 	while (bytes < total_bytes && !READ_ONCE(stop)) {
 		nr_sent =3D send(fd, &batch,
-			       min(total_bytes - bytes, sizeof(batch)), 0);
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
 		if (nr_sent =3D=3D -1 && errno =3D=3D EINTR)
 			continue;
 		if (nr_sent =3D=3D -1) {
@@ -146,7 +144,7 @@ static void do_test(const char *tcp_ca, const struct bp=
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
index 394ebfc3bbf3..4be6fdb78c6a 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -83,8 +83,6 @@ static void test_snprintf_positive(void)
 	test_snprintf__destroy(skel);
 }
=20
-#define min(a, b) ((a) < (b) ? (a) : (b))
-
 /* Loads an eBPF object calling bpf_snprintf with up to 10 characters of f=
mt */
 static int load_single_snprintf(char *fmt)
 {
@@ -95,7 +93,7 @@ static int load_single_snprintf(char *fmt)
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
index 7ad66a247c02..958dae769c52 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -949,7 +949,6 @@ static int tun_open(char *name)
 	return -1;
 }
=20
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
 enum {
 	SRC_TO_TARGET =3D 0,
 	TARGET_TO_SRC =3D 1,
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selft=
ests/bpf/test_progs.h
index eec4c7385b14..e6ae2e52a668 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -25,6 +25,7 @@ typedef __u16 __sum16;
 #include <sys/wait.h>
 #include <sys/types.h>
 #include <sys/time.h>
+#include <sys/param.h>
 #include <fcntl.h>
 #include <pthread.h>
 #include <linux/bpf.h>
--=20
2.34.1

