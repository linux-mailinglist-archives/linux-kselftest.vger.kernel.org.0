Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E1076F967
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 07:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjHDFKU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 01:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjHDFIC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 01:08:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C694236;
        Thu,  3 Aug 2023 22:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1zBpnFxUIfDDMpQDDyGDdizSqQ6fS2zg4puTaXkvka5z/fZ57mqQfNy6Ao0rnTeMY5JYH5St50L8PR9mb8v6QUUBresWTMr/JsR8YxcXDlL+LpTFnT7gbKeQvR9rF2qU7GyJx4tmsAHACPDqrMz5JTj2LHGVJEiPM2FVbGPtBh+8tsSq1UB4oexfLrasVirRifcjXMlaevzEcE8g7BmNTjTGQibop8VyRPPHBk2MZYsunv/M9Ml63Qc/U8vq6EAvIlh5IpoGKkgMn1UY4SCRRSA25VWHT1hFhTqSDnduOm7HPOLNtAAYFpte4nXZfRAcW1oqkL0iXE1NU4dhVHn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3hcBDUWz28H0tCgLnSThh4rsFQW8jpBW7vkhQIC+F8=;
 b=cGscQ4NnU0zIZbLHok/b92VWtbh9OvymBR94yVn6rzDVe0X9PcIJRCs7Y4fP+A7KGhNWSFuUh5IpNMmOf4s/nBCgdEdJm+LCpYPHLKsOKLfv9oQoeF4r7zdGAdA3Guu1H362XNCI+atnHaNIjy+hOL3oQPoXycHsBwaEQFZRFDd6AQ6W4aStZCcQ++mj159nDYB21SqLdmZTaFNKexDblRq6f4we6XqU99toFTgxWBbo+pEJdKYyEsXNUNIQl5jmMGz0aJoL6n+WxuGGbK6uktP+O2REO/4NEvXa0uVGvENNY/8REo9rkLAe3cHI0Osw9yHXhV9h4Vex+Lk5+v0dwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3hcBDUWz28H0tCgLnSThh4rsFQW8jpBW7vkhQIC+F8=;
 b=HqhsryO9jWLNVvNcDNWPxg6f83yoKxE8NLE+MT5MfYPmlcubRsU3+RbZJDyQVA5M1jkhgD5toR/dCCQyjcvWjv7Ty8bOXP/OkyVuFORQt16fT/LNy1KZODSw0FFD/RvTS1xgs+pJcxN5USxLPXjAk1EnqmIvt3+d430Z2JMlAYgSQYBsYUITan1p8d1WZ8kXSS/5G7BMb0Nk9IVgQrbUphc72s+Kz9ox+diQu18Gx+MGzIdH60cylQwPrUtyMjJSuClY1bXfFLtOsTuVbsKqAgJ6Omrkra5Prd/7Rim/DIGh0NjtAKBBbieVJhbzn1O/qBOk6cosDb4bXbjm0SoB6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10061.eurprd04.prod.outlook.com (2603:10a6:10:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 05:07:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 05:07:58 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Simon Horman <horms@kernel.org>
Cc:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v11 4/5] selftests/bpf: Drop unneeded checks for mptcp
Date:   Fri,  4 Aug 2023 13:07:42 +0800
Message-Id: <69c9cb050deeca1bbc54d97070ff5c0d5dda16e4.1691125344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691125344.git.geliang.tang@suse.com>
References: <cover.1691125344.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: e3bbac02-b12b-4391-ebf2-08db94a8c4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHbZnINj4KjNJBw42dlLpNqbbO4GVCZ6Syf92K3hHhgpHKSmMhfN3PdTSR1TaXkwG7Yldm4vRlkJ2TMiAs6FXYdM6FcE+32Kb1Gjyqabi9wi1C5BX+jLpzInYJ4skzACl3YsO7VQYBbja3iJ+/dV8WEJ2cOMu0Efh0k8R3/bAGZGYSQsVVuqAQboDxzWJid2FleE4SUsRKoCdh6sudW3QZFNxjuFS+8cjUWNZGrjPA5A3QXy+XUij5Ry/qqQhYcVc0C1owThrcNhZMNnqORRgGg3jrMAqodP29feamVDigWfqvUt8yB62EFdeylvYYxLjbJsf3F/VaBtGpiLKWLwdQLmf5wXIo46Za4KhVx+TtQv7zXdjtnvhm+Ou+TEBX5/ujuM6k2X0unqjZRQa0lV/MHFwpzh29CKVZo0/pAopBDJq5Ln3brrOtnhDHrNSLSJDN30OogJoNOgJqQXqM6Nai479y2TRpMPCVxMzpG0i+Er3SV0Q0ryB0M6yeI6aZKgv8FcojJX7hFnxX8ffmhnlyXR+TU6NO+K/iIocpuzkPk8TiR5H+4c8wIzt2T7vD+zUfKPCVPPNNTI/9wTmgCMmGZPCS249JfzN5dGsjoirUUlRblwYmha0diJd3mfSeYwyb8TPuye2DRO3mrl5j2yVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(346002)(376002)(1800799003)(186006)(451199021)(86362001)(36756003)(54906003)(478600001)(110136005)(38100700002)(921005)(2616005)(83380400001)(6506007)(26005)(6666004)(6486002)(41300700001)(8936002)(8676002)(6512007)(4326008)(66476007)(7406005)(66556008)(44832011)(316002)(7416002)(5660300002)(66946007)(2906002)(13296009)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e8o6yP7qnrFTeXdS7mJwpW/ksP4pHBFjHlB8zmMcKpQKhfxgWoa2O58QDJ/q?=
 =?us-ascii?Q?b7VTtOAsTJnVDB80Hj5988mC9o1KYLYrGCdLeIwfAo/5iv1+X9cfPgNL9iFt?=
 =?us-ascii?Q?+rCwyRdpLfKDxkBl3ikeVXSsLixf2hoypahlS6zQthW9y7CAsgc345M5vftm?=
 =?us-ascii?Q?wbbILKmTCEnzZMtaPHrjMTsCPT0JRepAjLA1n698ajBhHPW7TMW4ouGw26K7?=
 =?us-ascii?Q?S0CL2pf11W4uJG1a1NU7CqUUqUGlQyA6IUXsoxX9HRZdYkFSvGiOLNATuWve?=
 =?us-ascii?Q?95awqbJ4+MeQHG5no0f5OIT1Rsuvub9jmATKhj1qcDmNoOQOVhxLHvoA7+eh?=
 =?us-ascii?Q?eNllpAFeA5OIbCEXRS5ObVYbYAVp3424+N5Cg8ZvI68xJEEwwij8gM8h0SvH?=
 =?us-ascii?Q?6Rg3aHQGwfpAMHjX0hBypYHTuW6TbakObsJCd2OCL9NqMOGqewSI9kD4zvIN?=
 =?us-ascii?Q?NTL/YEehcVXucEPSwA1MyowgmomWlQxsQLQaRxJa1XCDMqXVpfRvj29gZRIp?=
 =?us-ascii?Q?IQi0HKPNhe8q9fOD0syj2PecC0H5xxcf4Nhsn0FqSkQiXWjnbREzSUlsZFvF?=
 =?us-ascii?Q?cjZNQqoZ+Q6bkZpQ3oZtzClUCrD3ErFU3JNyWGsDM5iR0HFUGwJfnuss4IC4?=
 =?us-ascii?Q?yNGsPtq4JoG3EQIKsFFSHDbFKZvV81ZSeB2kXRZsUKgyU0q2WRc2PacSfNlc?=
 =?us-ascii?Q?hpXejm3LUpuenGLNWthTbQNt9SeB6YBr0Np9fGeF5a+VUXGWoKANWcT+AON3?=
 =?us-ascii?Q?I2VZ15ojg4yK81NM3Lv09iq/qocowAUYjgHkpR+IpT4IxahRiv/nGOPaJ67M?=
 =?us-ascii?Q?KeC4msfxVLHj3WSZB6pElvOVSx1CxFGZd250i5ZWY6tjJl5fuDiY/bxEqLGq?=
 =?us-ascii?Q?o42OHFW9A+64OT8PQwEkS6DuAJoLTwZLtLU32uZsXAdJ1J2fT4C028KBzAMe?=
 =?us-ascii?Q?lw1K+5n77XeL+m5eiQEYRKvI3EJtFNu+HX2gBFmsUGmvrPZ3tUvMgtN7l32i?=
 =?us-ascii?Q?MKZezr1vp5ptSECHPLcykaNJW+7F3d8DSV9i8wg79UHUgpQyXlTuw8txOjnv?=
 =?us-ascii?Q?SvVxuEvC9N8chHdulUqJ3Xu65niItsIg4tKXKVfenIL71HnK9U393EGBgqeh?=
 =?us-ascii?Q?sXbjr/sed9RYxyyN4nDjEjR9WFVCcv3QdJ4rLTnZlAMAeTlLFfBUKTOAS2Z9?=
 =?us-ascii?Q?XQgyf2iQCt2YaeUhco6qaVbeEl4digLDcKpl5wpujVjHIHx45RcqxWcmPxfr?=
 =?us-ascii?Q?EykXRjEXGnhVpqP9ReDpuhIJ612eG4W4irankVMmLFJnlpXJ7c1bNGEUiycc?=
 =?us-ascii?Q?WYve1NgKv8/dkXeN6ILURwuCJN+2Abaj0w1b6NlLoYAufAi0poafm9FBmCK8?=
 =?us-ascii?Q?rKQZVFQDvQ48F+Ml+8VjloNSvuUnxvyDN8jIOT7I3V4lUrmpUSUczhdXHJMJ?=
 =?us-ascii?Q?/jqMX9v4kSFZoVeAv4GE9Al8DFDox3g9YY2eV0ceupbJE1aD05heZBoEBaL7?=
 =?us-ascii?Q?ZG4lH7Ob5keV7YobK5mJ8mYJUMj2OGQutTfOne1Kb6xsHsvEECyrs73pAJLt?=
 =?us-ascii?Q?ieHouFBmWDH2A0vDcoK1JcSsDfZ41cc4YwLjI1Re?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bbac02-b12b-4391-ebf2-08db94a8c4c3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 05:07:58.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whoTZNN7Njm9RDN2w1ToFdX8FOa+pb8yvLGtKbYZfEJhwP/4V0sx++TbOIje2wGo+G12e9BlQR2AaPW/4Q+p+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Load success means prog_fd and map_fd are always valid. So drop these
unneeded ASSERT_GE checks for them in mptcp run_test().

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 4407bd5c9e9a..3dc0ba2e7590 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -127,17 +127,7 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 		goto out;
 
 	prog_fd = bpf_program__fd(sock_skel->progs._sockops);
-	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd")) {
-		err = -EIO;
-		goto out;
-	}
-
 	map_fd = bpf_map__fd(sock_skel->maps.socket_storage_map);
-	if (!ASSERT_GE(map_fd, 0, "bpf_map__fd")) {
-		err = -EIO;
-		goto out;
-	}
-
 	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
 	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		goto out;
-- 
2.35.3

