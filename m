Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3B377D76F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 03:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbjHPBMS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 21:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240972AbjHPBMD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 21:12:03 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B0B1FFC;
        Tue, 15 Aug 2023 18:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaRFiw0+7fIeCxPPwp8VBHhL+Pe+OcaSOH0JKcjzrBVQvuVOybw3AUykxkErzjXYOJrtEktyQD0R328eWUs+IDYFrkf61ASlVRCfnNuzJdbbHPPcxaJJDOXRyihIT5QPUC9i4WHCaqvJBO6dITvc12Yv3hWwmKIwi47M+szychSrruZDOsH2mg+Yc80tGqibWBFSPyxgRE+wX2+mNQqPD89KxjlvjENUnFwQci0FWNbXQ3Gf+ngylvmnPmpFBkXJDMAiNt9ZWhkQjkwV79Et/tbTlshe1+aDpUzVDlk6ar/vv25KCSlToyqSGK99WFl+WTEGyiCS278IlWni5ZyVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd/8kfPIc8VH4juBd//fMuAR8mCKogVt2f5lxjDZThw=;
 b=mQ6/VdBzMvbHFAI0uvz1KkfVt82kAUQpsATc0S8rdKbq5UVysc89LgvjctabJqBbjeOGQFqfbSiORbmvd9//v7EpYOcZwe6iHbzAJgF5M8IIcFtbDadd8N+fGjXUccaoVD2i+RTgd9iscPAvINNenXTjCTJA7E1H6SIkOu5TX2noLaIPh88nDwgvz25RJahOZCGR9t2GT2IYJBM7v+cYTupNRUZEsGhpyCEo8141DKvaP88eSC187EFfymHtDh+wMHhERZOAD6AQE/dW3foB0A+CTaCToZuWyjdjjdqW8KkbI60hrQPhLfAe89nTHA3xzJH9Cxn01o6DnAHmzim/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd/8kfPIc8VH4juBd//fMuAR8mCKogVt2f5lxjDZThw=;
 b=U0CKiJDJi8IUCb30s4gCdx0t98dGzPp4NT/UMYGZYb+mBMMxeYxH2iZ+57Y6AIQZiJdLRHUhljWmmJICee4egOUQb9nP7PKhoXQxqCsVB36nuLKhAnhwVYzK42GQ6EqlQGVIdBiXpsWx0pVyPfXuB5QxEExtt1HtjT3tgfb8v1rEFc2PFP4i8tsBQSEsgehuQP65G8Wa36G6bY/IVZW2T7uTC213dM37cBwtqlIhOw15hDzhW0pCRynkcgMt20dwpkbpadtc5PjUVOR8GaXKanXIeb0sAKrJi5fSPIdTX6O4MhH1rd7zCRb93pmQCROAAX4ku6t4PirL/gpr0NdT3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9915.eurprd04.prod.outlook.com (2603:10a6:10:4ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 01:11:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 01:11:59 +0000
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
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v14 2/4] selftests/bpf: Add two mptcp netns helpers
Date:   Wed, 16 Aug 2023 09:11:57 +0800
Message-Id: <7506371fb6c417b401cc9d7365fe455754f4ba3f.1692147782.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692147782.git.geliang.tang@suse.com>
References: <cover.1692147782.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9915:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fce2d63-8188-424e-0a43-08db9df5ca42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ukqh0EsrO1oXRvz47m3jObHQ4HatP3bWi9R7WBM2wJHs7yIp+0dmFhmzls79xylhi9sMRof5QXPn48pHRiUhv7xCmBbgPF9gS7Nc+0FyYbiyRe3fwdC/WjZHwjA6TKgfbn7NQSInKufkbaj7n7gzgy9486tdVFf6M+o4PJLGvKzsbpN0P3kEX3A10Alf/YazEZ8AxWV7i2L29VBj30M3L9lxkJhAO7A7A3PHBkLD5EOqmO/FIeGy/mmSHq0rgAK2Ss4wAs2ypzIYfglgjEGN+JI8i/5O0L9h5VAdpfIAYBM8BUqP5hEsvh0ssjjYZzdcJS5peL7+bIJx9VovOvw5+ae9zKZVJ+YLUOGcj6+Vftyschp+x2K9juP10LEzy9BlVP7alDhoOk3pJBvorIz5YEx1lkL6Zjgva1JmfR/zVPiROBQNBXuwBQ1w+7F6pF2bsHXLcCwK3y+Zz81OhAN0S3ER3rip0qHTy5vxy6so0xcyCGutpUv6TkoFdsn3pFD14w1Dfqb4agcvl4UhQOdAh8gT01KCESdsoVd9Ewfo0751THXBYqbHb8h6bxFec5yIk6kYOjesPfB5iRuWhQC1LmktHhPippWkQaQagDm+ilxQtd9EoPi2AjcLV9s/ykaM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(186009)(1800799009)(38100700002)(36756003)(86362001)(921005)(6506007)(66476007)(41300700001)(44832011)(26005)(316002)(4326008)(8676002)(66556008)(83380400001)(2616005)(6512007)(6486002)(2906002)(478600001)(110136005)(5660300002)(7406005)(66946007)(8936002)(54906003)(7416002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F+fic9LDECCub3swJ+HSR5nncVIhON3QTG5EgO3AGAKdc7l1t5JEgi4E5AbI?=
 =?us-ascii?Q?lJBXNUSSnrp5/0JJTcSXGKA/KHRqy9ibETSWB8ztY5XeMyPGZ/dGEcbplMhM?=
 =?us-ascii?Q?jyM9YRS8YVWBFkgMKKnDYm0fAgNvwOAycOcE6VaC6U5za9aK+F00uNfgnpTv?=
 =?us-ascii?Q?Pu1ILilqAtcmyIzdjzFKAx+lXGZkU+rrkAw59GO/Vw/i6ZCKoMcKyGmlcmBP?=
 =?us-ascii?Q?ypx0Q1VM1zsFRLgqT+PY5WL7uhwnx+4rW3Tl7B38VRxpO2m1wapZE8g/ZAhO?=
 =?us-ascii?Q?DCvQg9f1oAOYNWL+LYP7M30wcIWJxFBFmwNVfvUaKanv6gQnU9jQGP/h0FfJ?=
 =?us-ascii?Q?ZDMD5MV4Tj0Px90fPzPWDPTyvDUo/aM8OVAnk2dck/KWCsgy6DMLiarymUCT?=
 =?us-ascii?Q?dWmqb2xUDxVgiEAiLgkAgArsG0WcT36BM7jim03BuuKVtNqvuex84BIEn30v?=
 =?us-ascii?Q?n+AEwTpPmNzC0ymn64yDL20vSU7hR2rxEe9zwxFCGRqTg1Y/lQtYkDZbg7Hb?=
 =?us-ascii?Q?eFmeiWq3eE3iSpm6QiOz7Bb/llmikiJtUZWk6uV07MhvSoFk663TqND2R3Tw?=
 =?us-ascii?Q?QUAZMTtL+Bvvxw7Xe0p4mmwUT47aoJBRCNp9NmsLXwe9xPhmtQer96SCGbXc?=
 =?us-ascii?Q?twtJwbFDV1d0nltdPTx83I+ZHcCPCPDtyGi/T8RMHKODXnXXvcRHNNRwod/b?=
 =?us-ascii?Q?k8gc9N5d3z6Q/fPTirbwJ0KfohFCFKVK8VUB2gSZn1jMtBezJ01ymaL70CIZ?=
 =?us-ascii?Q?ajJOso0E1vGW6q+VZFThNn6aOFW3ILu1ICfoh26s8NmfoR4g0p9HtT7GILaG?=
 =?us-ascii?Q?Cdp+xD9wXJSOb5hIXPtOOHlqTEk/S7WukOCQOxAlDLN9cC/FeUzcoawEfXMq?=
 =?us-ascii?Q?lW3PNZTlPyduz3mOvt+ZmKL2kr5FDMvn+TzXPLt867vENbSieXdX5gbHO6fZ?=
 =?us-ascii?Q?5bfBFRTihy9uhS//V1qtL6QgJYnbIZWcHmIjkn6WDBFJ5zUzTOzFwdwyfotI?=
 =?us-ascii?Q?1R43HXnek/Pc6BG0KNjbOI/Tlol04hNYwst/hwe++//3HL9vaYTDpKtscZOK?=
 =?us-ascii?Q?up2yH46MzlmHyE6ooZbqw4cGRH+uo8xNmcGBhzXQvBlZFpPidlPrVdiZC9UA?=
 =?us-ascii?Q?HwZy7oExCYehhomMP6h4yb6C1Gwv4OZsHeEgvnKASNAzmIEDyyUBTwJscRlo?=
 =?us-ascii?Q?GWW4no5BRUep0SJx4o6Uc9DLZZC5McqlGyxUyE3cGvsAOIc357j/wmATan6o?=
 =?us-ascii?Q?pV6n7dD2NfX43C1ZuGex6wAqPWqyD3IMrxyk26gVHW6DODY12O52KV+u0sh6?=
 =?us-ascii?Q?0nMQ4bY6IT+34nl9Rg3hI/tXVRMF9TLVITKoSQqUZZKJG4rl6Mr3GWdARuaB?=
 =?us-ascii?Q?8V+BOF5xijA7MnwqMGVd4Zi79G45rLZ8EuhNSoUbwhsdwjDrZvVxwgwlzEVt?=
 =?us-ascii?Q?3WFsdB1hZxNiIiHT0s3x/EpnLYWR9X1zAixY2uAUD7ykEwiLXdci+F4jnAnx?=
 =?us-ascii?Q?PKetQ4U8bpko78Yu303y02C6sqDcMErJCTK8Kfg6G185zGSrL2fikn0sjGpE?=
 =?us-ascii?Q?FtOJs8AaKpkwQ0/SnH+eGBZGfdzy6r7ZydXVYykg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fce2d63-8188-424e-0a43-08db9df5ca42
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 01:11:59.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaup3K1y4gv50yDvdmg07aDCH6RZQRuDRyAo5hoNMacwQAdQ5CuiLA6FwXRHiH1KgQ8UKMKllMFnADxcSJzv7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add two netns helpers for mptcp tests: create_netns() and
cleanup_netns(). Use them in test_base().

These new helpers will be re-used in the following commits
introducing new tests.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 31 +++++++++++++------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cd0c42fff7c0..76afb5191772 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -22,6 +22,24 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static struct nstoken *create_netns(void)
+{
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
@@ -147,11 +165,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	nstoken = open_netns(NS_TEST);
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
 	/* without MPTCP */
@@ -174,11 +189,7 @@ static void test_base(void)
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

