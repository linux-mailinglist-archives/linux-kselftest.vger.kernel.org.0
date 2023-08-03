Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1076E19D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjHCHgJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjHCHf3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:35:29 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AF446A4;
        Thu,  3 Aug 2023 00:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnRMk1GYPmY7F0oTYnODCjuHXThHKnb1EoMurBOQLrnjKmTglaR/6koqAdOdX+STMqEECxX90922LSupgZl88ISzJ36ltZyUQ8kCx2LmClXuc4xo570IROOGKJhdu6+ZcbWRwyJTmslD/4npAgd8q+TpfgFRwvfIdltWERkQLaf1NTmFtGPWgj1upEMye3Ph/E7PaYuCNYUHkWAgr8NmlKbq6wcLWWmzEqNInKuIpV8iFTpJzN99FxsQ+o5x1IHMdWNZL7ZLS4NrqAxzGSWwWtZxw/9bn9teL7tmoXmXUAApNI+Qwetle2iINC3p127gLqfhhYrjJnXqZ3CBb9XhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWqMc9UT7yWdDRGAA1JFdqK94iY4Pu9Cr1Kw+TYOXMg=;
 b=ne9w+SASlk/Lv95MbMWhAhkQTdsdNtw+2FU2WFehqL/H2PkVTqdFZ+sJlHKQbYdDc218G7AD7Urtujlht0sKh89tjz4TC0jBdN2+aNHeO3GO1wdghplI+rPM/tNYvr9jFXvxXBXZ349lVpyf1pVtgQb0RFgy2t3m0PrAK6hDg+eCH0kBP4Hx1pgpBV+XcGJhh7XdV52oRmH/NjvcvkKz6G3J5bM46vxgISRmu+UG3mBRAoMjT8x17lSZkgzYn6zhq/+66QuhJgCrbvYYHYog/h+SfQ08zE5f4G0Elqe5tIHFNjXC5FhUdU9YpRXhFNQbOrXnHhfpOWPiKcz7cCusgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWqMc9UT7yWdDRGAA1JFdqK94iY4Pu9Cr1Kw+TYOXMg=;
 b=JPj0Irxqq1r9Z4qcZJMIEjW97dKK1EB9SHMvK0HSm1oWGMXkTH9IeFBGvmUeH4b03r2WoWZSYAbBjXJbmHZJr0h3K2otKGjWJaejLrAon/5jT/7cZd9mRDL96HHkVkrJfzOjN7JZ+DrqfyJkVrPy7ZX1VruFvafFrPhCXti5ZmJ6spt8uRMjJ4lND+Oel9qhX9WqC6e6EDk5nJqMYKdQRMIDRUTC2RsHM7eUjx49pGLm4Ur2y6QUhdOScFX3bG2CrKgvrb1dZlzxjv9cElButnqetmHG67MXmCos3ZeNr0v+ZyqePui9chuDE/+jqG/dU4lYbWmaq6aJi9e/5eHJ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8571.eurprd04.prod.outlook.com (2603:10a6:20b:436::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 07:31:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 07:31:10 +0000
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
Subject: [PATCH bpf-next v8 3/4] selftests/bpf: Add two mptcp netns helpers
Date:   Thu,  3 Aug 2023 15:30:41 +0800
Message-Id: <72b924b35bdad2a598534e32869cf3a19516bace.1691047403.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691047403.git.geliang.tang@suse.com>
References: <cover.1691047403.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:404:28::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddaec91-cb1e-4855-9409-08db93f39bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0cIk9khNadvbKoMJRK2f2q66fY2HhXaEtUzaKCuZukaVuwrVmOxpM5dyV1pOk5gMWgyVlF629wzODfezF0SImwPwJmN708RYzVZrcMktv+PtZ92uY9O71/biE/fckEd4elCJnEI7f/9C5Go3hjLrOIqBXMcI4d7+DqQuf5zNg8fGz+gOD4TARufI15Hllr0ghZ3vRAUFyFCf+E58L2qx+sjXmOP2NksMUm0o2lnsSVGJWjPK1m6XmSXQlRlus/KeDw1Gq6pJBFxjRjOLCVKYiECuGqH/vi4AU6ZJCh1FDRyg+imjRE1N56XfP5uhv6FQtim9uzBbyitin5WMzT/pumzPBe9Cthabhl3x+19DtqHt2LAbovIoiEcBaReA/RQ8A4K8IAhp1xvJL5zTLb9W1HywCt2wbfJD3iU/Jd1JoIXBUxC3/SnV0nOXn1xl9NKbTzRS6QxmKvkMw6f8UooRCnyab3eElJCL/6Lb0P1dPqrLEZMpLro/89nk3XQ3djukWn4Bxkibj2ZAGC1QVfMukXaQYawDwGiHkoc7TnM0841YHNfwl0dHyP8Hqlrddl8sWUmhn7ArRS1JQisD5A67grCoW9QZH0bZ/za87rxzIPD6Z+40baY/Nix0xi6Yj6LQBZLHQuLbjLJquVR8CZ5+mHyxtQ/EVwNrcshfCzaymA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(6666004)(110136005)(6486002)(41300700001)(478600001)(7416002)(5660300002)(8936002)(8676002)(7406005)(186003)(4326008)(6512007)(316002)(66476007)(26005)(6506007)(66556008)(66946007)(2616005)(2906002)(83380400001)(44832011)(36756003)(38100700002)(921005)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ke5w8LaLcVypwN/7PZcZa0AVvIYi4dXbOUneqMMuTYjRJbEkCwzj/tF9ctV/?=
 =?us-ascii?Q?W3MPQjEUsKSO7WuwwfSnKeXYcqKDFnrHdhWwMtNkv+ll0XjjSaPa8atXICy7?=
 =?us-ascii?Q?Gb6V7d1VT5SsV9KtOekXhS5erIO29MzGf3dO+D2B3N47FZLFPVii7AHQx0Lv?=
 =?us-ascii?Q?TrYfWxvikcGjpzqDYHLZGgAJ7a4IdeMAtasabrjyMsGwncGJ7VEvkxpVC4IU?=
 =?us-ascii?Q?RKwDE9Ds7GoX9W6Wgk+MAdGqqCclY1J6fiVJ9qd0Veh93WGWTDeXJBa57k6z?=
 =?us-ascii?Q?ZUyQwm5aIi2Nay1Xxf2wRnJi7LkxDnj6gUd99XX86t5RzCZRu8Hj0zP40naG?=
 =?us-ascii?Q?gpftLnS/ofDjAZB0E0iXn8KjJuE+nv8ngD3w6UQvsbnTOGV8y8onTcF3YWZF?=
 =?us-ascii?Q?oZ14sEWiNp0i+HwwogV3jsihi5TDTZMDFu5UQYXusoG10r1PFlXtF+N9anyg?=
 =?us-ascii?Q?YUFOWtCxOzMuam8LNAR02Nxv1ECzIZbcG9g3D8TnbZKifR9OVKEDNi/zbL/u?=
 =?us-ascii?Q?Lv6cHgFNCJSvp8urUAt264kQ8BEGNvdXEoEDyQVkA0y1MLJWVuPK0mAJt/b9?=
 =?us-ascii?Q?oyq1fdCb6vvGRDx/ha5FLvcxIiDPpNrd3IPN8D+1XhHhW0aR1I32V1AC0xIs?=
 =?us-ascii?Q?Pi/wJeDJdWXWK6lAHcmakCFzCh5ZeQ1UhDALczp+9S+o4erpMLv+2PFh7uAb?=
 =?us-ascii?Q?f1Ao/rMAhHmZ+YR/DRV1dO/H+u7UV8312UGeiQgq2s89YSX+nvmnutJG8Z2K?=
 =?us-ascii?Q?qqHwydu1842ON3qBhKzDvF6KOqla7J0QkDwmE2lIiQsbfV/enWSiHITQhICU?=
 =?us-ascii?Q?Zz2Hm46jHtYos/BOQQZs4xWVNQ99GfBtzXDDKLa/qjMC8Fc0SQn2z8OEj463?=
 =?us-ascii?Q?bP15xxCbJLppdO6luV4ghFFgY6vQ6hdvpRgiLBEHn3RgXqEpB/w+gNjq1MZ9?=
 =?us-ascii?Q?RW3prvgdCH+NPLnZam+/gkBgsZZyRHXJC/vBTSs3lx894oSdW1v+uMi0ysLW?=
 =?us-ascii?Q?2Cp9O23FBaFSoD0yRTTdNs5U9XPmQJG50tP6ngSD63K2f/OKEYz2QymPg+qZ?=
 =?us-ascii?Q?mnCaNVOQsIzqzS3WE9tWDDkCzJhqmJVZbyOq0TO+bUzv+eTEvmkg5Recla36?=
 =?us-ascii?Q?cmRbnKicA7oZIHz5x11S5YNU77OnS1+Os4/0ITayUZzm35f2c1gPaPV/lnXm?=
 =?us-ascii?Q?mctUzw5OD+rbiRs6dNgripQzpObvTFVUxq1+1+RWsqHLf1P9AQv5VNOX52D3?=
 =?us-ascii?Q?ZhT8H/ggk3nJn9aRbVCaQkt4F45zH7sM13VejnnhUr1OLRoOX8gFZh9s9nzm?=
 =?us-ascii?Q?MZVpRBfHLXUAUJkztXbqZ9u4IBfRbVBCIHpY5hbiwn+C6C9Bs/4E569dELJO?=
 =?us-ascii?Q?SNqD5N0h2SAYw6rVZh7GEGygYjBfWU/gSBKaze73jMtyrS93yoKl98JU5QCn?=
 =?us-ascii?Q?F1lGlRVG3q/1GeR8ak/ZcoHJe6AsL+UzEhOg1BPS0806ir/nznRVlgSGwnK2?=
 =?us-ascii?Q?W7KyZyJ0xbw+XHucpQ9xDbRK2V4ELc0Y1BA5e8s2RicJ4KU7ZG637ewpGDvN?=
 =?us-ascii?Q?BsURDFwnvDNQV3TuX4k3PyYLAVTpELnVVttPYa4o?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddaec91-cb1e-4855-9409-08db93f39bee
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:31:10.7469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/QxLbbnPi8s1WSrUEKD2rJbm8uimYnGGtUsGWQ3IwL9I598JD6uZSJ7iD33sWIdUQO6ioFLLe+zHVyiBKwVYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

