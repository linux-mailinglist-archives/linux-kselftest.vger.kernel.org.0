Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303FA76F740
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 03:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjHDB4T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 21:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjHDB4S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 21:56:18 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC181FF3;
        Thu,  3 Aug 2023 18:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBn63rl8qbrDNqMdcAKF3wmjJp5ABr+oOlG1KM/5/BPbY+gEvLChZyKDyifHyE8sDVx4c2UY4R0u+AZCY3Mog0PeEcR3z6oCLLCGFkcwjQmNLNIyLMg2+48dYAEh4shulbS3rL4rFa0q2GV5Y/xT8B/B49S13mjac41KMk46Js+fTxHoStCRqD9S6BwZG9Z6SHMl3APu7hAX2+V3Jt2Jh8K0zbWUQnw5v8KOKBEm/nl7pSHXdBbFQ+LsS693uhglB3aLjUG4HdQ47fcvLk05CoTrlZwYwy9JIUUBJiEw9yB1jHFdtnihER4o5sNyexGGpOerxf+8l7OyiyQ4solEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHTJIrxZIXZNpiE/inZgiAPSfO6oiyUOLxGFu7G85oQ=;
 b=ZWodkb4FuwRhOnF31hv2NOc4m+zCFZxn2iBzAr+aYusqsAnYAUVV6zSn3tvv8tjyMjcHdEw4BubOg03+H0Cb9BMVDYygFc5bFw2JKJwrja8rYD7gNY1SSkvdj16QWO5pPDJIL3sL++1FL7SH+JroEC4I/zYVbaKq48G8achkWlJNMX2XJzmx5hJFZX3OI6wzVGCyK2nL2oVcECN52nk2kDf/QYr7R6FZugsDyCa5cA8W/GRrr22zR2W+xEY929Z7T+naOqcYctCKW29Xzo7HkcH5ffDFsSt0jkcg+JhMCusK35XDNSZS5UXKrxYizgPwZSFPbLOEiA5icm0etJCFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHTJIrxZIXZNpiE/inZgiAPSfO6oiyUOLxGFu7G85oQ=;
 b=hEV0QYne2FT61I3yzveRuogZPSIwcpOQgrvwSPRYkOENkIqj96WqCJ4O0CG8GcY9jJHA2yWLuBVFpPkIdT6RB3fBWsDRt4rdl26bLbmP0nrjw2M1I5aQHYdrfrzjPw7rp7vSeaxYwEF7vL8kzmjxMTGx+QE39i7G/QIMDe4WgK2GbDK+Ya2942SKPm5rg4lNFf/I+PsXm2QikN/ofjEPRyZvNbPH/p/YrYIMo3BLBWAVBzSR/yT1ZYXEI+wvKOLQvZ6pMaXfYBngwjiVvGImoBfqCXMFWLwsGR4UJ2l/+20ukjnffxWHYZHqkRIuhIiAVVqoSTf20ocJ2sbuv08FoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 01:56:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 01:56:15 +0000
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
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v10 4/5] selftests/bpf: Drop unneeded checks for mptcp
Date:   Fri,  4 Aug 2023 09:55:46 +0800
Message-Id: <5eecd03fc0eaecc19da6a40bb118690971a8a7a7.1691113640.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691113640.git.geliang.tang@suse.com>
References: <cover.1691113640.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc8b78c-ef32-4e48-e850-08db948dfc59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GmS4b3A6bzs2cwwL01omiq+e6fzJiodT3jtezTRP/r28zrnbnUtCnrjgM5WbinZAHmok+sPn2rvUmbx3XoioDBsx1kuqRf3Yt114uvlCdmPjkzp5BB8svKvxmA1DB4RF+C+mSfiAfTwXB6YNsQh93uErY/ns2KgfYuxgFqLVzimIGjMzgVaX/VXu0ByfVvra7Lh0rxOZFlONWgzX4ByQz6936gNOBuE5Xlv+3ACKis1MvsHqaSRus930P2HcWZGvdeKY+KoHRotCfOo67aKBJYgo1B92FZ3GSjtD+R63Kt45v+mK9InpL+29Ny/mRvuawkqenfFNecxVsW5sBlm2D935+7M/DxDOmIPZHEMAIf7FWDsjnpwPt4nmGF6XmIqRi21w4CvVPKA9jP2AtG0+G9jLbdXEMWk7/BIY6LJNvkaXDwhP9IL7K9gzNiAwJW4HBiPP8xeKhhCsEF6IRLpzWiU5/jlhfclp0/NqfwHvMROYDPmEotpAg334ByemKK+A4CnffoUFthYZ6WmBCx5j/7fpewyXwG3xxOV2fTfDvPlbb2QJW14YEHi0eqaQgd+JvOEfQ/S96sDxgSmxvSd9KCnEo5JyKe/MDV2FKANP3Eyg/+Zty5OCNmNmsUB3/K9PceoBoKAGMJidruIJ/9kRUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(346002)(39860400002)(186006)(451199021)(1800799003)(6506007)(38100700002)(921005)(26005)(478600001)(8676002)(8936002)(5660300002)(7416002)(110136005)(44832011)(7406005)(41300700001)(66556008)(4326008)(66946007)(66476007)(6512007)(6666004)(86362001)(316002)(6486002)(2616005)(36756003)(2906002)(83380400001)(13296009)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TeSwqpsY3PJ86nAjAoQiVrzV+wBjeQi1i32FV6073HZkTsujPRC+AM0B8xCg?=
 =?us-ascii?Q?gF6kaWoI04QpWHpTLjSD0TmIFwFxiICwa5k3SS2qi+jxw1MA/ZPhJd9Yok+e?=
 =?us-ascii?Q?zOC0bRqa9yqXoCoeP/nYtqS+grd6JH9dQ3ceJfAmBBnx/uowR9QMQ7kL3SBh?=
 =?us-ascii?Q?4uKe/PB9hUCMdlJfcbPhu68VXvlSYjQK5Qu00wrvwyOrDfFMjOQuTCDtDA88?=
 =?us-ascii?Q?S8apj7DZa1n/UKVthC8DgZQb3rxw2fUOo8KtVegbEugpH92lscqYydKEiZG4?=
 =?us-ascii?Q?UU4OiJdFjJCzcZFpaJB57geOwuzKJg4H/8Zs+C+mkxkUE6RlNM8ZZrmtBF/L?=
 =?us-ascii?Q?keSXmzc7ixKj9IEbWypJbBfN7D4uCWK5FdpWRLqVV7m0F47mQEQxgREej+vL?=
 =?us-ascii?Q?hMbaPfShBs+OEQVtIfxnBqzU4byJD5hd2rB34rgzQWIcG4z8tIY9FOPShAmG?=
 =?us-ascii?Q?9XCQIqQs3bZ+RUNU4MRu2yA3yVJZbkF30v5O5YczWg/+b5Zuk3T5SQgKXcCi?=
 =?us-ascii?Q?dwANefQvIhVkauIVZIar1oGI3HOYeu4ifXodN9vKKbOgshiTde/tPJJYvR6L?=
 =?us-ascii?Q?pede1CwINvWncASIYPWI+E9HBzcGE5RSu0ySANrhzjcQTMi9zbU1pafYByp2?=
 =?us-ascii?Q?/a38OmoPfBjnCnkDWE+KNMHFWJdjmeF2Z+cER+C3f/7wiYUSmxJb/FqQZq+2?=
 =?us-ascii?Q?tpVJs008ijRZZUU613EVrzqRzucTnElvD5NLbTvY1++epNbOp4P/q+5TaYqS?=
 =?us-ascii?Q?/y7jdaZf3RsMwxGx0tks5JiZpV3kXY3K2QD+eCqdomv6/uKJBjQF8PRT8+5i?=
 =?us-ascii?Q?n1jkcz/Huz/+OpblL/dXGlHwUblfdyidoFKy1HS/ZM0u17Xd2Qrr+5cJranB?=
 =?us-ascii?Q?57PuQmn7sk+WCIBFl3zXL3nMp1GGk7s2i51W1eCOJWutyYWGtpKROzmd+sPa?=
 =?us-ascii?Q?rdVHHttRWi9fL4RSX6WZNqsX+vJEt1XXn4ZloACSGUEKzP4Ti+DUKY39sq/d?=
 =?us-ascii?Q?igkHa3xzzH/HlhtTOE9YeugctFwc8CbM6uQLwgjtg9OhvrSCWJwD5ivaOSUf?=
 =?us-ascii?Q?5Gt2RD36jpPEK9ocnBImI8gkQWNSZUOpW7PEAd+gEpKo1xHZi/xGpgfMFPZ8?=
 =?us-ascii?Q?VDzb9BbvB1J3oSgvSXXvrRk949epY5gRnhpvaryKpRZfI5tbeXU3Shfplz4d?=
 =?us-ascii?Q?ZT5yCk+XAVRdt1SZvDIWOy905jhE4VYD2UTqZOSuDfEwJsfRHgqg2bALhiqo?=
 =?us-ascii?Q?9RppSmlfN/WUJIHJpF6/oT1dD+3qpJs2sL4x52CJk0OvQxwm9AiTt7n6/w/J?=
 =?us-ascii?Q?gjlcWeIyKNOVx3ndZ31ACeHO49/WIue9jEicJ360JrU7SAvh8S13QdO5GrUz?=
 =?us-ascii?Q?O2VjnP3nabTp0csLLUxzNXjmRhWKbfAQ/QvT0RMrY75Frirk8mvt7jN0zr7u?=
 =?us-ascii?Q?Ipb4i9oTMbOAooVnUkje/khk/U1HaJ9h3HfFL4vVWjqWrfcmJ+8/RHimeJMX?=
 =?us-ascii?Q?7vP2qPhMahAQsj0zo68e/SU8jtOBCuccUfK4uwTO07tU+zv7vxHUMbZMb9O7?=
 =?us-ascii?Q?VQHxPrBOBDcklLW+HuSBwrRcL4vg2NaNbpMBDDeR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc8b78c-ef32-4e48-e850-08db948dfc59
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 01:56:14.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUwXXrHJqekSBus3MGUd3IaN+e9MIEQyZR2hhvDXV6S7bTuwukE1yMoNdS1PpdlmN8DQMdB7uh/TgJ6G01k0Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9085
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

