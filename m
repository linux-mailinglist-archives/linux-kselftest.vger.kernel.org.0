Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22C276F95F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 07:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjHDFKM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 01:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjHDFIB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 01:08:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAF74234;
        Thu,  3 Aug 2023 22:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFEO51NbpC68S9mkqAomZx7zylOvrYJz7Fc5BcVud0ciQ0tkggIN1E2TKuMSoL7cz3Wuj6ln69HiCk4AL8XdttCrRts8E/TaZlzXCdq//q+OddYkcep2eJNyS16g/LCD/7hWiMegqByQbfaAibGcYOnmO3yuLVd/hqJ06nWu4L9lGQQruu98AOpCyT9ga63rti9SfEwnVXkt/I3fUz+g17bG9igyEVZGOKXd8yYlc3oiqWHdfs+MPS0yMqgCvE1+uTNROggSPD/waID3y1pqvWWtVX10/gcqvH2PStqdju4jPTAJHh+ucw7yzEIqTKs/hlK5VhqgNPTXq7mbkIT43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67IJNZXR8xHZysLARhWEOYDwJ5zgZ1zmECZ/EfEhyXk=;
 b=a5zOxnr7LCS1oLbIJsMXafHgRBe2BbeFGu+h12I00HKOk8oLRu2R0FdOHkEHzUfVUYee2dXzbsEW1jQVonF1Ek1k3Ub9VgHEFXW9Ga07As4g0AXL0DOzxfYHfNEAvNuA0xDKtOp+7AnD4/ubiH9O17EGP1C75iB7duPQHqTmLZEeAVxnDHzU0i+51k2g1KZJ3PMHvmz7fGSMh8nnM4Toj3tmqy7BQvhL4qlb+oMKo6kuPeIzmyAfo/7ALAGxbxPVyswQvBeDAOrqXYwRJKXDonmiZ4YJFghhOgjM3kqKZnv/Uf6lkztgH8MjPSYo6cvsFssJziKQkxs7+Nf/yn2Gjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67IJNZXR8xHZysLARhWEOYDwJ5zgZ1zmECZ/EfEhyXk=;
 b=DqiehJikZz/gkcTtiSgu9EqpOScQ0rUWcvPHnxn0c4wSt6HKYooCy5ql4qIOwWRkkspJZePwJzQStAsHKJCRpyUuXTMmNKy962JFAXI0I3+5jhEpoWSa0plWiPAO9rAGhsBEif7xzoFiFJ+TU7Jfwi+4H4z74yTJTw3E9+lz2mh9Y6LbbO0pH4SPpT1+Q7X3yAm74KrNNDmo5K0ADrzdBZ1uPgrKuycvV2fu5rtt56vxRVaG+agDVPxNPxdmPDKzPLavTSymU3ZFYscJyVd3EYB7XS1ufONWV8oPXg0QwHR8G6eI8agRG9/BbOP2vAM7T+moyJJ5GuRmxaMltZwNXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10061.eurprd04.prod.outlook.com (2603:10a6:10:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 05:07:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 05:07:52 +0000
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
Subject: [PATCH bpf-next v11 3/5] selftests/bpf: Add two mptcp netns helpers
Date:   Fri,  4 Aug 2023 13:07:41 +0800
Message-Id: <b744542609bee46d4e0f28a0a9f0c551db245f69.1691125344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691125344.git.geliang.tang@suse.com>
References: <cover.1691125344.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce2885a-0c94-4661-c79c-08db94a8c11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/G0frIpQkTV0g0BVLzv3//UtigOMEhieng4P1b2OvrIj+qteM3tExICEOR8gc6lbQ/GySFfSnPVETSvb2b51mqq5qfz2OYB8JNUlSf+6Z1yaYg7YP/ZDEaOb7bKJcFR4ralLK2CKJIo8AC8O06XFOPQ0tKjlfdkd9Vol6onz1c2zDJcKG8BP+fDR4+xIvDkUDo6Xd4Xn6FDlaBFv3VIQ2GN7vygSVopEJoHw35UEGZJidhtpn+eIehjOGaSt4ClSk4BfrCErTfN8X/YJEbVK36NwjydL9U+GTCJb+ViFsaIRf3OvDKGnH6ChzF2UfvQgOxGXTLg5gkcI8RF7xEfMJsaRSeYUEnzsBYUZKbxv5RVzDMweylpvmcCUVwMB2IZAjBZ35HLKMlT7bUaj3jupHFt9WVLxeoOJCC5YfWlWpNDj6RpUB9u81VlbLhmsOcDSS3UMGIC3ZfiQpMTgBg0twUaI8HGPD3/epojT3xOp1iP7H+sLoZ9X4bqigTkdN+z/Dfdlr3Q4rZnap7LEIApmYI4TJOlbdLGE2VhWvQhdrXZqyMo67psEUOjCiqheV5cmdZOCwJs11uczW4ZxnQNhlD3PkorCIBqKPIAf75K1YVmVYknAQgFAoIV8JpamD8W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(346002)(376002)(1800799003)(186006)(451199021)(86362001)(36756003)(54906003)(478600001)(110136005)(38100700002)(921005)(2616005)(83380400001)(6506007)(26005)(6666004)(6486002)(41300700001)(8936002)(8676002)(6512007)(4326008)(66476007)(7406005)(66556008)(44832011)(316002)(7416002)(5660300002)(66946007)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4yOlmeqdDzXjx3iJH/TN9wd9bbnfyVCzVvURINyGnM60GXPC5HP/AzuL5XGA?=
 =?us-ascii?Q?HV/3yOHRiCO4hRmFCNDQ1QUbNTSxIZ3D/w6TR8EaaTHv92uR67u6Xkie2fHg?=
 =?us-ascii?Q?SQ7nvPQcrgGfBpP17jdu5ZYi9sXQTJyxpd74XTdAOCKORo4FX4Orgrfox2gC?=
 =?us-ascii?Q?dSR3XQxrlHihnQQdMH0LOpvAIg9uyWFq/6udKKEv1QRNcMD0m6yu15NHSNmh?=
 =?us-ascii?Q?QhjZp0fitvaeAe+A7kFSUOwqm9F0QlbIdKt/oCz9tEcK3ZQT2Jb3gfMUv2Ii?=
 =?us-ascii?Q?kDFOiG1VdqMd5or0Gl5CZDBpAYHZSkiRROdufu8mS45bRhX+t4G+ilx6DVQK?=
 =?us-ascii?Q?crBWRuM2ulvXqFJ7VqyueFTNBDYAAJ4r7dIGr/8ueHqF/nptBm3GgYq70B/Y?=
 =?us-ascii?Q?HxgZSbn5ed2ZpGo/Ku7/GPK3PB7P7uZc9sT4O2XcmsKRhOwHNdlDQjR362iJ?=
 =?us-ascii?Q?wQIQkLX1Y74YEfq1OUrRxaF26JgkjXetCPbE8Up+LYClAY53gHQzfGiJ1IG3?=
 =?us-ascii?Q?SZ7eWvvTDlxAGRkdKhr4XjI8u+HvVgbw1YoKph45JaZM/8k4OmhU6FlQMnfn?=
 =?us-ascii?Q?aPnOmSc0m/W5+Ma5xb75GUsRJrA0d4eFYJF6IyiduJ4fK5N/rRzZW9jqMsjP?=
 =?us-ascii?Q?ucyIGonj8+MIEKkg9l9XMDouOnjsVJsZg0Ti1sIG1G5pg4H0h5aiCAq1Sw0q?=
 =?us-ascii?Q?AQffPbPptXw5Xu4z7vqAVEgZr8hvnVgqDiQCo3xRdn4P+r+dk6S9KVPbMeas?=
 =?us-ascii?Q?vnELkeMVACJRhLvrb+tyn/YMY7kqrZvDn4ta5BMYzPeuWHPpw/2LkaHl6tGj?=
 =?us-ascii?Q?IcxEUKzEXHsAqYuTzFBIbJBfsaK0/KHz7gGMpLTketx7Qne7LoPYEfTFVFYH?=
 =?us-ascii?Q?k2kYHwOKBtwIaoKWQ1Yp4+6LE6y+688RPgGxk30UF7d4LN8JXc4faaPyuGEj?=
 =?us-ascii?Q?ZZfsEhi4r5h9Kiib7tQK7VzpE7ekROX6tO5gsV6IfgDHQ68cgjXYi7woLvIj?=
 =?us-ascii?Q?E0N9NCZrCVrfejWBKB+fxHu9hEkkEr4Rok9eXD7grDjLThIqSSsEHpewyNTW?=
 =?us-ascii?Q?UIP5RQhcwvIS/9BqMxZQyx/28/EiwJxaA42NkOAOlZ68FgnXeoLkG2HKeezG?=
 =?us-ascii?Q?zBMUOLuTLfNCcpWKM6pw1dNKPBZxp6uGeWph1oY41rDeF+wtVXmnJ8QwLWqR?=
 =?us-ascii?Q?IeanZhWHJh/O7qUxK6mnBbQ+EKIiR7nx2Pm7ZEwnNsPufMbiMa/X4lzN9Yde?=
 =?us-ascii?Q?ffOjs6zCpqG1a6xfFHhzhAOlwOaeu6Knljohd3ofMAjmvD8pZ37DLNCcZ2bJ?=
 =?us-ascii?Q?ivYPgWBjWHVWDfQwjwUJsj5FA1MUeKo1kgW5yPYidhyKC0nd38+m1lsqjlas?=
 =?us-ascii?Q?nh6AXl/KcejdTVC8plI+Lok31ODPmLN5OsW5HDZGaPR+9Rsu/wwWp9NUafpD?=
 =?us-ascii?Q?gOz7/35THvw1YN8r/kWBTfaXXa26IOJOdn7yeNmFUvE+nBd1d+teSeX/WCgI?=
 =?us-ascii?Q?I93NO0C7hUNMDiYVP9ZBSTNnnqnHXkSG2zWIwkA7AeYG0AqamJR3OoKP4eXf?=
 =?us-ascii?Q?Cv+WlydiSeXKkwSoEJg+ns2Wib3mtTZT54wrqm07?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce2885a-0c94-4661-c79c-08db94a8c11f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 05:07:52.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7197Wu9YeuH0a/gEp89jIhXcQHL2brTr40DlvWtIV51Q2hfqghOBfsA1rRiQ906Bh24tlt/16D4HBysp9mqoCw==
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

Add two netns helpers for mptcp tests: create_netns() and
cleanup_netns(). Use them in test_base().

These new helpers will be re-used in the following commits introducing
new tests.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
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

