Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C124F747E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Apr 2022 06:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiDGEVZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 00:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiDGEVX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 00:21:23 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CC81DDFDD
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Apr 2022 21:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649305163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CuW4ykShVyOXqQXqO2AsPQhWRpdOSrWOfipjx+vPuVg=;
        b=Fq5WnGREyneint+u2OAHgwBwl8kNFHziJBqklFG5D3T/ipOzRA2m/xkYIpCoR4Cn7l7cd5
        F0yZ0YKuWfjaLt2BrilRgiqjO2EYoxWmw9lu/HOWCHXshCPkT2p9QUAlxatQf0k9Wdj/kg
        RpVAh/T7d1Xu35eVMsRgYmHDNbrBpBw=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-WFJfoaC4NPGQzPDr-svz-g-2; Thu, 07 Apr 2022 06:19:22 +0200
X-MC-Unique: WFJfoaC4NPGQzPDr-svz-g-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrdaTZNsSRox3fFEhdHkDBmuyZ7sa/+1pZY04Eis8d+LmDIJLVn14R3lu1xwe4TYnI5bUdQBKpqEhBgw4OUFA6nH5cTLozhQl7AodPoJQ8vxfsHNPlBHLIipu8ZnRvA0kDqP5ugLWDYZqD6IEzBuZLAay0Lk5rH3rISqDLJu9P8/7fj2eJ2JgDUKtN5r7+/UmpwY8bmEQW3Qn7YblemrUN33KRRCX48ncunhngWT4M8CvPxhXzVrjx5LH9Tu7RdtaAMEKOf/Lk5n5oYixmzcc4LT++pDRc8S5ovKC050VtcyByQgIUSIWc0gsUMNPa0ingt9TgL2V6ZaQgZKgXYXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+GPc50rMzWCV07s8bqd/KUtIUHfdXXtLrr8gAJmzWQ=;
 b=PbCbofGM/tN6TsZiYXuvr4JqwvJcOe6BLDoWaCdoNks1UsD+REYrzk8zRmEacpKJJJPiB8SbGuMnyzhw8fSuxx3DH5Mif3iraWxoU99pmAlaZSP1BQzp33DaJHIdG7U9TwujZys2S/gkiG37t4FSJr1GivW/luHZZRgDLi8pXZ0JwTiaIR2EoKf/73henJBmyjQYV6u1Q+HkaZzAwiQBQhxbrwmmTOKCy/HilzuB1g/LlQo8niC/ugx7y0oOsN1kb3M+q+d4lu1mGnfI0SjoESQCNcDmyIq7BCSeA1DPb3bR9B7GTzaaRCa5khzX88AxpG2uruHAPFBw2xd0A2D5Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4418.eurprd04.prod.outlook.com (2603:10a6:208:6d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 04:19:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:19:19 +0000
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
Subject: [PATCH bpf-next] selftests: bpf: use MIN for TCP CC tests
Date:   Thu,  7 Apr 2022 12:19:26 +0800
Message-ID: <4da5ff038c442d4421b95580558fc981bb674e61.1649304888.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad72bfe0-1fca-4ce5-b863-08da184dc903
X-MS-TrafficTypeDiagnostic: AM0PR04MB4418:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4418CBAA9D8B2D5B947C1C10F8E69@AM0PR04MB4418.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAqHKFcB6cKoUs0krkGGb7vrXLMORothH0Xr8s4vWO/dxUzvG9iCdDlyG+nsRSSKYxTjCJWkI+Zyx1ChhmV+biqJ7tPzvtRriomeD6A2+XZl0bjFtc1xU0e6KJYcgVUI8g6sSuA9kzZgC7FoU4kmmXPFb1JdKu66RdPBkHw3QTCUcpcIQ9uMeAyDgb8CwIjwV7+DovhJ+Q7jCN/e2yUPTqIDBXQIHn5MSRw2LFdNI1CFQqQWClRzsxBjwI7Cg205TyxLZnCLlQKdblhZObgIAqdXJFoP+9vXAzqkeKla2sg8cCAErWj/dUNu04fwA+QIRMTXZOiF6qLaqQHHWljkxjG5gZ84arX9lGATfY9yE6G6ggn0FDQDJt5ym9IGPwB+w8bJ3UpK/TVFZvOrnPpXfBDT+2TtQfNOpSgW7TbwGxBn+fa4Gqy1/QnaBYUc1cqzagTSi9ZXhbvf/mHjYo7LAJnrQG5cXkG/eol3YFSiT4wYlXumS7j1+chq0oiHLV/xcVcavsuj+m8RauMchYoV9pDLPKtjs+Crmv+0LDui81STb0pQ6nd6v+ToVmDGCVHOU7kpxHK1ydIf0oBhKUR6jiOEPCZhFK8t1X1MEfYVkfLOhLTP9r8ZHRbY/bTlp6OY7aqpdCdfZvKhGptnzaG3B1P01k0ZpEV1OfeiBgLHL+wUX0jXYpsABQPTNWxPVEYs+/P/WRTScABXrB548h4odA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(86362001)(7416002)(44832011)(26005)(316002)(5660300002)(186003)(2906002)(83380400001)(110136005)(36756003)(4326008)(508600001)(8676002)(66556008)(66476007)(38100700002)(66946007)(8936002)(2616005)(6666004)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QgtXP//xIA69rQWjxlU6nQfgH0RFOuyay8mhed1+UHYgIVZmTVctvQpfZozO?=
 =?us-ascii?Q?vrjA//F3NIKu9MaiU2GVw4NJEgr20sL43cOorihl1pNCC76H4qQGuEKL69h5?=
 =?us-ascii?Q?uKkRWlXoTJuKjmSXjdqObHk2eju4OLoos/HeAt/odCQz6GXDYWv2JbRJYVZ8?=
 =?us-ascii?Q?F+JII4pP2RwhkSJ0+YVJRcJxAF6fSbPc2EI8GMMpoZrsAtxYEu4ASXL33vTk?=
 =?us-ascii?Q?g8VP0uAyfXM6P3Mm/e3TNqdRDrhfUxIbFwLusqCfJ/T5puTmqo+hrit65Gk7?=
 =?us-ascii?Q?Inkr9QWcI+knwz18GP5mu2FAcoOgtveKkVhuto6U1wYajtFUWnGW0VGQKiS0?=
 =?us-ascii?Q?5rgwC5iBBlwQQY0+7Xw9p28sANchmhSKdkXSGADDkhdLQpxdH7pfrgMFvapz?=
 =?us-ascii?Q?TfOHYvEzz3BsyQ/RH0gN0CkBJhYPusFrQ0hobPeShNJL3dKsIYhJtC9v/QNB?=
 =?us-ascii?Q?8ssxzmykVPeQTOjxhJ4BfrtItztD8WekNsEVUqWJBupJYpNVHxr8SlEUXD9r?=
 =?us-ascii?Q?4tYDiibLOXV1cXY0FlC6v91tgOiBUWQfijezAnRy4OJ3uUvxEHu7g0UYyGAI?=
 =?us-ascii?Q?AnxhC/i8QWM7GjTc3BEunE5/H4Iow9tF2gAYOp6F03Q1WriPXboiXtyKOjoj?=
 =?us-ascii?Q?UhPonPCGTZlwUJtNta+LgGfRBrmS6ZKm9nPJ6/oh9nE65b95awCDnRZtKNa2?=
 =?us-ascii?Q?NYsdqev4i+hXXnEQkXWzRUAklFoQ4WMukPpPigcoyD53dD3roW2du7CYlf/B?=
 =?us-ascii?Q?C+py4DdERN/jkG0vMiW/O+IhyrdoSOrbmXc2wQkrQzNLGPwYvTDKuzYEQWA9?=
 =?us-ascii?Q?nfrEol2YzQhbHqZ5TgrL8Ea+PdOCIeFfkh2+zmWTUdAwrNPr40AhAL4O4Z5Z?=
 =?us-ascii?Q?iF7FKZjfUyfvB0bAxhxvtwpsjaeq9MLKvAw9GEtSB9Wq03uDJc8hsDJq0Iy0?=
 =?us-ascii?Q?tNoW+7kPDsKTAiVnuXh6LF8aEngMy6xQaCvqdfpVKAs0AnRvSMVVQzWMNs6t?=
 =?us-ascii?Q?glOYFqrtLCgocOoW4z+xOWouzWns9NXWVeWPO1OKtU/Jb1rYO0e3YaArx1iS?=
 =?us-ascii?Q?KcOHrtVUNiT/jBs553fIaK3SDXE2NvnoPtmlzjfafaLc+vqX+ITj0gxvQStH?=
 =?us-ascii?Q?DcfJSu9Tpc40TgU8hRRRtOemAf5xFYn6pyxINDcpgfd2h1WsEI9oVSjsGQZi?=
 =?us-ascii?Q?RUN/ChDz2GMX0uCLzc3WAsXbBGWe9XqKtVkligOFZmWS80afEQcyxPCKq69C?=
 =?us-ascii?Q?ch71sK6srRk7OZPeX5swrhd6AJwMw7KSU8kGdQWZYRwF1O5JaHMAXXIcjFIV?=
 =?us-ascii?Q?1bVvMtoBjuHEbBDzSoF7nchAVY9BacGj8QYuxg9/vLY4muuAy3ucm3QUPJNq?=
 =?us-ascii?Q?T/g9FMkWDUOtKbIr8F0qayACQ71tBq5wNINMIQVXQDnN1BHEzKnogNwUW5PK?=
 =?us-ascii?Q?scDwuOMDAIAINwR03lPZD/IqF1SEyT/dCFOqWifgSp6mlfn6/5qB3TWPSut2?=
 =?us-ascii?Q?oes0pAVsdUSvdUzBSLIg+aLI54ScCKLiHPGRIF3Y9LVDlS3TuMK3MX6V4p5/?=
 =?us-ascii?Q?z+lK4MbIXc9lQZTIUjOJbBkCjeVWAvGBgYldiKw+c5Vfzi0MDC93GlZ2Rrzd?=
 =?us-ascii?Q?uEbIEEh1WOb57S0sWv+lkwrRWw/6UwbGiPlRsEfgPB8rdl1J/UjeRwOSJhWc?=
 =?us-ascii?Q?oK9jiD7emYG31dcJdWqcW2PBWOrH2wgT8F7tHaPzoUS6Oa/JfKjd+6lRB8D8?=
 =?us-ascii?Q?0ygNqt9eHrH4mjyi7NBVJVItnfL/ra0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad72bfe0-1fca-4ce5-b863-08da184dc903
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:19:19.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6ceSYfNJTDGUAhSvCjJghLhGpISeBwzhXOfoWnkDVGiP/a/t1u0RQLI1n9ohw7YxFUNd/jytdNCvHXKKB6LPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4418
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

Use macro MIN() in sys/param.h for TCP CC tests, instead of defining a
new one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

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
--=20
2.34.1

