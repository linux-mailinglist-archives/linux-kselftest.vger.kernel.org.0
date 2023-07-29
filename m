Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42973767DDD
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 11:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjG2J6D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 05:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjG2J6C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 05:58:02 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE22D7B;
        Sat, 29 Jul 2023 02:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFYqBo1bDzNYGrjuUF84XVboTchzNyovQMeotJVFBa8JEOhGlJfJIGRHv+CV+AFDYuaB1nnJUDmH8zR2PJpZOHIpW64cIRicGlEi0L0pn0GfmfGsVjArvdcNaMProjyepprJY/Viv6HL8tU5DUtLfflrnkruuNaw+fcd2WdkwdMU8yqu3JEbnHvrMXD2uq5SNwLyd2sRG5+i1kffEn+4mxTZDXKps0o4WSu0UreEh/mJjYshUqxJCHPfww6MaIw/+DkNPS8pIFsWs+6HoAt8lDA5Bmtfb3d/noBu1qjwGNrkPqFucdYhJbx77ykWqkPJUNkQrhjFXuHU2g3sdu0KrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWqMc9UT7yWdDRGAA1JFdqK94iY4Pu9Cr1Kw+TYOXMg=;
 b=QiYosVczsBfL0aOug+dfCqCidflNBYNIBLd0DrpWevV65kHxKc+SO0LIG8rApspTB+z7FyXSJfLH9bdNpjJlxvm+/GeOPrCOsy0i/puK5nKxogmxgx0XSEK5CRhSbAvUjmkedGvEgK9RJBcbPKo1i8poMVv0os4YDPrrcUWogZRJp7l70SdIyVdm0Rb6D9X/Yv1kPuc4WL27wtEcEIQnMBgQ4UuwWvjp51w1XXOfeus8M/BKqNDCfeskuueWyT48IjRGcOl7tKRTH+O/oSpDG9M4slalfC4tU6lFrIDdR/emVRSl2uyvXSAljow6FtkxSGuNc2iNyd1euPIbur0lbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWqMc9UT7yWdDRGAA1JFdqK94iY4Pu9Cr1Kw+TYOXMg=;
 b=3SUSk6bg+QZpGzUapyPgsJ9BrK5az93661JfbUQRFSshDBpoJuvowc75zzVg/QZwLepoUxBwHpobuMu9G8o99JnvCEMLb81OQDhnDIjHLR0xfXKkaodPpLFQQtfy7fbtyJ8miEK4UfbWnM6EUEbzpozgzRHjDjivtTDnqKH7AJVrfbjrekIsG1cVeiAAiMlLv+gHkiStJ/OVIzN52uoS4zwTaZYLlaJGzH6xr5lDRaZ8O1BVrMNEoBkgg3wsTlgLYF7R7vmTb8X/tZCT7Egeacu8FuieC7HM4dPbpHer5mMH2orKOEvZfvEs/nRXS6GXMqYF/8IA9xhSZsPJaJWCbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9733.eurprd04.prod.outlook.com (2603:10a6:150:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 09:57:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 09:57:58 +0000
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
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC bpf-next v7 5/6] selftests/bpf: add two mptcp netns helpers
Date:   Sat, 29 Jul 2023 17:57:26 +0800
Message-Id: <49e5ee337d2943a7fda9f1cf61e47c24ef78c5bb.1690624340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690624340.git.geliang.tang@suse.com>
References: <cover.1690624340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fddaa7b-1e1c-47ad-c00b-08db901a49cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T32DD3baHEf9uYiXkaBsW1rYlhKekO8MQIeV9wTZd14k5bc1v9AvK8tM3kp90TSDx7LXfWi1XncVJxwI88gJD76YUUZYVHhipQtkxnpCbc2tjlsILlwVrwsBT/Fpv4wV4hf3spUR6ElmaQLg5AtlbeXQohVNXxXETWSmYEkyYrFTzw26VvHV0Zw5xHEIGqPPhIKP6mVy1EGTNUGGiBaHnq74jyJ6g/G8UrD8EE2UJwgYdtlR18lM2iPgfrKaM3Jf6IpYqGkAnD+l+OTVahIyouCAtRnuYiFA0tzemQwxsyDUmT68nAxSZLQdahyohkO8dR11mh2yB+W7Ht6jcM/4a1YSQkjC+GSX5UJXuEvmwvLrxNKEn7rQ7oc8VlABvyzaPP3jJ4Utl/NSrXX614dkYdLdCpzOKO/+9xUeAFsYsanN8fzU5b2zogJj0n1/rQTn/lEKfqsFgH4Hbp9Jl2/IYtWKUtYRdzY8Nh+SsxWMzeafaycTCrPDAa/JnIUdvYXUBGLG4FaLGl2iW6+fYc9JqCN49j7mHFZi0g9v2615wCvKBp6fEDNlmU4EiZmlE7GXWaGTFHY74eocHL4Na8A1psyGNgU1PGy2GC3LSAGq87I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(316002)(8676002)(110136005)(478600001)(38100700002)(66556008)(921005)(86362001)(5660300002)(4326008)(66946007)(66476007)(6486002)(6512007)(6666004)(186003)(6506007)(26005)(7416002)(7406005)(8936002)(2906002)(41300700001)(44832011)(2616005)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?abeUrEJrUncTovy4Xzk0bJAkaHR4Xa5Iax3hUvDwP/yVJZTj0cb/MuAFO++6?=
 =?us-ascii?Q?LJWCXWmpWBvUurqPBXp7I06w07xzdiwzeiPb8EB3ldNIdOVVT/kvHOm85QWn?=
 =?us-ascii?Q?5SckpKwdrQfh1OBvoNN5jg7+xgKvuiuqXthUyKZORSYik6Fn6fnxGxAS1ME2?=
 =?us-ascii?Q?DZMVzeRioIMw+giM/ZWrd46tOkg2hu2FFruE+SCq4jAK1tWOVz+CCkuenr/C?=
 =?us-ascii?Q?CA9pbiYgS8isrBBqoYLtjN3mofDxRTQb/IZMhZUl7uTgmJlOPqF5ClzMi1g/?=
 =?us-ascii?Q?wLSikpHKJwrnvr17/Ht28cDAQ9Ivve8im1VQBczCe2H/2PNMzgbLgNxVZ32X?=
 =?us-ascii?Q?5ApKhNoQ9pnRe26Le1PDZQi6WrZDYxfsFJ0B1DlRvA0dr65Jyv6Xx5XdGsDe?=
 =?us-ascii?Q?wnCWKtWJwyTDV3iyUg9F5SZ/sXf1wtH9LRD24lCUxa1zi/o4l/A+4k5jC0oe?=
 =?us-ascii?Q?wqJczMpzq4sdEt6SFFYnlnn79kRvoXlLDRjYWJ/szSqUr/9SexkjJNljyHh0?=
 =?us-ascii?Q?mgbaTtCl7X4kNYOeCspE+VXiIUW2IFCvCXCfc7YTW+xcG3hioiEXzyzc04gs?=
 =?us-ascii?Q?lQhs60vESPrZw2AzycuUr7xCeC6Y2ZweqcsnhnoynaObLrxaNKznFp3ZRx2p?=
 =?us-ascii?Q?KVn1ksBTqFgTaMZEWEZBmumfSxDOourVlXhiuaqCnrC3RAjCqB6ThM2O8dhk?=
 =?us-ascii?Q?+exXeOl0qGAVBd9ISVkvK7finLn5GHUiu9opJJNk/Lzg7TYvSw9jWoNTFXkD?=
 =?us-ascii?Q?BHPX0Xk0vHGopP/Cd64R+XekBT32D/QXAzK/WdiW+8+b/mh5wjfDxATJMT41?=
 =?us-ascii?Q?J6nkIc84BRL0JeDTay4i4uPLdP9nqz5LwVCNtookriOK8O8Dxn1oF/CsD753?=
 =?us-ascii?Q?6MzkQJDWLwN+98A3BR+qC9PQ4EuHeBqSfuhxMkFkgMesErHBP1avIFaNpCie?=
 =?us-ascii?Q?6jwG9EORVkt2hb5+nF7nuBxknXgtllz6oL1t9ZE5TR8mErApYLmD2C6m+RVy?=
 =?us-ascii?Q?xDpl7vOE4JdkbBYtht5lZhrPVqDaJBJHkXC4R/xupn7t3V2OejDbkaPCsEp1?=
 =?us-ascii?Q?lbR5xzzIn5XYvN2BF3Y4jpHL035nTOVhz1mAX63anFdPHm7BPzD0MwEUZo56?=
 =?us-ascii?Q?43b1l5F6jaSpNAYX7FQ09ZOBF+YbAMPTVYv8AT0gB/+I83g0rOgxgGYiGe1t?=
 =?us-ascii?Q?Ks8t0QzBE/p5E6Z1MlYJzMxFEk1949epsifzApmZ8e2cZHvvMmLrvs5+k+IN?=
 =?us-ascii?Q?DAV64SAYW/lOcNgQK2YQIgUd7OoaEAzVsxJJtGdIsr8jCKHxEM8/kY/9vrvz?=
 =?us-ascii?Q?mqXiCwZy/fsJpB2SkFylg7YwWTueRCx9ohaOvA8y9iB1w4GG0EGk0cOsFh6l?=
 =?us-ascii?Q?Mqkg3JeB45mO52YNWulPDf572OFTBi9lmJjhn0yz7/fuPikJVQFTlqVm7jio?=
 =?us-ascii?Q?kGkzNpt5pEcLzmKwSnLqL8O6oHpzJ4XoCRH3Zy0cznrsM2r8jwyvCluh2Dk4?=
 =?us-ascii?Q?vb26E/+w/SPIjbPoxu+pBHjUZjpvHo3RiHek1iRmFr0paH7acgVwszoNk8sR?=
 =?us-ascii?Q?tajelbB9+vw00eihojXM7ol88AEHTCG/y9p/Ktoh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fddaa7b-1e1c-47ad-c00b-08db901a49cd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 09:57:58.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYVdwR8QqJKgh9zzSmNvlZfw41FnCjzy0d8CLFx9Ed5BZTGMsO9j0MuTkxICpS2gZkVtdVPQmty8KR/8U/nh3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add two netns helpers for mptcp tests: create_netns() and
cleanup_netns(). Use them in test_base().

These new helpers will be re-used in the following commits introducing
new tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 35 ++++++++++++-------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 4ccca3d39a8f..4407bd5c9e9a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -22,6 +22,26 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static struct nstoken *create_netns(void)
+{
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	return open_netns(NS_TEST);
+fail:
+	return NULL;
+}
+
+static void cleanup_netns(struct nstoken *nstoken)
+{
+	if (nstoken)
+		close_netns(nstoken);
+
+	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
+}
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
@@ -147,13 +167,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	srand(time(NULL));
-	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	nstoken = open_netns(NS_TEST);
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
 	/* without MPTCP */
@@ -176,11 +191,7 @@ static void test_base(void)
 	close(server_fd);
 
 fail:
-	if (nstoken)
-		close_netns(nstoken);
-
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
-
+	cleanup_netns(nstoken);
 	close(cgroup_fd);
 }
 
-- 
2.35.3

